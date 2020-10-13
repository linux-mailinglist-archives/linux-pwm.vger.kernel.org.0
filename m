Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7462728CA23
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 10:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403771AbgJMIVt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391412AbgJMIVt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2020 04:21:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012AFC0613D2
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 01:21:49 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFZ3-0002lC-Hw; Tue, 13 Oct 2020 10:21:45 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFZ3-00053Q-04; Tue, 13 Oct 2020 10:21:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] clk: provide new devm helpers for prepared and enabled clocks
Date:   Tue, 13 Oct 2020 10:21:31 +0200
Message-Id: <20201013082132.661993-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013082132.661993-1-u.kleine-koenig@pengutronix.de>
References: <20201013082132.661993-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When a driver keeps a clock prepared (or enabled) during the whole
lifetime of the driver, these helpers allow to simplify the drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/clk-devres.c | 85 ++++++++++++++++++++++++++++++++-------
 include/linux/clk.h      | 87 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index be160764911b..a56289c04921 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -4,42 +4,99 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 
+struct devm_clk_state {
+	struct clk *clk;
+	void (*exit)(struct clk *clk);
+};
+
 static void devm_clk_release(struct device *dev, void *res)
 {
-	clk_put(*(struct clk **)res);
+	struct devm_clk_state *state = *(struct devm_clk_state **)res;
+
+	if (state->exit)
+		state->exit(state->clk);
+	clk_put(state->clk);
 }
 
-struct clk *devm_clk_get(struct device *dev, const char *id)
+static struct clk *__devm_clk_get(struct device *dev, const char *id,
+				  struct clk *(*get)(struct device *dev, const char *id),
+				  int (*init)(struct clk *clk),
+				  void (*exit)(struct clk *clk))
 {
-	struct clk **ptr, *clk;
+	struct devm_clk_state **ptr, *state;
+	struct clk *clk;
+	int ret;
 
 	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	clk = clk_get(dev, id);
-	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
+	clk = get(dev, id);
+	if (IS_ERR(clk))
+		goto err_clk_get;
+
+	state->clk = clk;
+
+	ret = init ? init(clk) : 0;
+	if (ret) {
+		clk = ERR_PTR(ret);
+		goto err_init;
 	}
 
+	state->exit = exit;
+	*ptr = state;
+	devres_add(dev, ptr);
+
+	return clk;
+
+err_init:
+
+	clk_put(state->clk);
+err_clk_get:
+
 	return clk;
 }
+
+struct clk *devm_clk_get(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get, NULL, NULL);
+}
 EXPORT_SYMBOL(devm_clk_get);
 
-struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+struct clk *devm_clk_get_prepared(struct device *dev, const char *id)
 {
-	struct clk *clk = devm_clk_get(dev, id);
+	return __devm_clk_get(dev, id, clk_get,
+			      clk_prepare, clk_disable);
+}
+EXPORT_SYMBOL(devm_clk_get_prepared);
 
-	if (clk == ERR_PTR(-ENOENT))
-		return NULL;
+struct clk *devm_clk_get_enabled(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get,
+			      clk_prepare_enable, clk_disable_unprepare);
+}
+EXPORT_SYMBOL(devm_clk_get_enabled);
 
-	return clk;
+struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get_optional, NULL, NULL);
 }
 EXPORT_SYMBOL(devm_clk_get_optional);
 
+struct clk *devm_clk_get_optional_prepared(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get_optional,
+			      clk_prepare, clk_unprepare);
+}
+EXPORT_SYMBOL(devm_clk_get_optional_prepared);
+
+struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get_optional,
+			      clk_prepare_enable, clk_disable_unprepare);
+}
+EXPORT_SYMBOL(devm_clk_get_optional_enabled);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 7fd6a1febcf4..14050d9b5b38 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -409,7 +409,7 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
  * the clock producer.  (IOW, @id may be identical strings, but
  * clk_get may return different clock producers depending on @dev.)
  *
- * Drivers must assume that the clock source is not enabled.
+ * Drivers must assume that the clock source is neither prepared nor enabled.
  *
  * devm_clk_get should not be called from within interrupt context.
  *
@@ -418,6 +418,47 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
  */
 struct clk *devm_clk_get(struct device *dev, const char *id);
 
+/**
+ * devm_clk_get_prepared - devm_clk_get() + clk_prepare()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Returns a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev and @id to determine the clock consumer, and thereby
+ * the clock producer.  (IOW, @id may be identical strings, but
+ * clk_get may return different clock producers depending on @dev.)
+ *
+ * The returned clk (if valid) is prepared. Drivers must however assume that the
+ * clock is not enabled.
+ *
+ * devm_clk_get_prepared should not be called from within interrupt context.
+ *
+ * The clock will automatically be unprepared and freed when the
+ * device is unbound from the bus.
+ */
+struct clk *devm_clk_get_prepared(struct device *dev, const char *id);
+
+/**
+ * devm_clk_get_enabled - devm_clk_get() + clk_prepare_enable()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Returns a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev and @id to determine the clock consumer, and thereby
+ * the clock producer.  (IOW, @id may be identical strings, but
+ * clk_get may return different clock producers depending on @dev.)
+ *
+ * The returned clk (if valid) is prepared and enabled.
+ *
+ * devm_clk_get_prepared should not be called from within interrupt context.
+ *
+ * The clock will automatically be disabled, unprepared and freed when the
+ * device is unbound from the bus.
+ */
+struct clk *devm_clk_get_enabled(struct device *dev, const char *id);
+
 /**
  * devm_clk_get_optional - lookup and obtain a managed reference to an optional
  *			   clock producer.
@@ -429,6 +470,26 @@ struct clk *devm_clk_get(struct device *dev, const char *id);
  */
 struct clk *devm_clk_get_optional(struct device *dev, const char *id);
 
+/**
+ * devm_clk_get_optional_prepared - devm_clk_get_optional() + clk_prepare()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as devm_clk_get_prepared() except where there is no clock producer.
+ * In this case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *devm_clk_get_optional_prepared(struct device *dev, const char *id);
+
+/**
+ * devm_clk_get_optional_enabled - devm_clk_get_optional() + clk_prepare_enable()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as devm_clk_get_enabled() except where there is no clock producer.
+ * In this case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id);
+
 /**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
@@ -773,12 +834,36 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline struct clk *devm_clk_get_prepared(struct device *dev,
+						const char *id)
+{
+	return NULL;
+}
+
+static inline struct clk *devm_clk_get_enabled(struct device *dev,
+					       const char *id)
+{
+	return NULL;
+}
+
 static inline struct clk *devm_clk_get_optional(struct device *dev,
 						const char *id)
 {
 	return NULL;
 }
 
+static inline struct clk *devm_clk_get_optional_prepared(struct device *dev,
+							 const char *id)
+{
+	return NULL;
+}
+
+static inline struct clk *devm_clk_get_optional_enabled(struct device *dev,
+							const char *id)
+{
+	return NULL;
+}
+
 static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 						 struct clk_bulk_data *clks)
 {
-- 
2.28.0

