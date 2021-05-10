Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4AA379633
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhEJRnM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhEJRnH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 13:43:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A787C061761
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 10:42:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9ug-0005HJ-Ez; Mon, 10 May 2021 19:41:50 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9uf-0006aW-D3; Mon, 10 May 2021 19:41:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 2/6] clk: Provide new devm_clk_helpers for prepared and enabled clocks
Date:   Mon, 10 May 2021 19:41:38 +0200
Message-Id: <20210510174142.986250-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When a driver keeps a clock prepared (or enabled) during the whole
lifetime of the driver, these helpers allow to simplify the drivers.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/clk-devres.c | 31 ++++++++++++++
 include/linux/clk.h      | 90 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 91c995815b57..b54f7f0f2a35 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -67,12 +67,43 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(devm_clk_get);
 
+struct clk *devm_clk_get_prepared(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get, clk_prepare, clk_unprepare);
+
+}
+EXPORT_SYMBOL(devm_clk_get_prepared);
+
+struct clk *devm_clk_get_enabled(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get,
+			      clk_prepare_enable, clk_disable_unprepare);
+
+}
+EXPORT_SYMBOL(devm_clk_get_enabled);
+
 struct clk *devm_clk_get_optional(struct device *dev, const char *id)
 {
 	return __devm_clk_get(dev, id, clk_get_optional, NULL, NULL);
 }
 EXPORT_SYMBOL(devm_clk_get_optional);
 
+struct clk *devm_clk_get_optional_prepared(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get_optional,
+			      clk_prepare, clk_unprepare);
+
+}
+EXPORT_SYMBOL(devm_clk_get_optional_prepared);
+
+struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, clk_get_optional,
+			      clk_prepare_enable, clk_disable_unprepare);
+
+}
+EXPORT_SYMBOL(devm_clk_get_optional_enabled);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 266e8de3cb51..b011dbba7109 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -449,7 +449,7 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
  * the clock producer.  (IOW, @id may be identical strings, but
  * clk_get may return different clock producers depending on @dev.)
  *
- * Drivers must assume that the clock source is not enabled.
+ * Drivers must assume that the clock source is neither prepared nor enabled.
  *
  * devm_clk_get should not be called from within interrupt context.
  *
@@ -458,6 +458,47 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
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
+ * Returns a struct clk corresponding to the clock producer, or valid IS_ERR()
+ * condition containing errno.  The implementation uses @dev and @id to
+ * determine the clock consumer, and thereby the clock producer.  (IOW, @id may
+ * be identical strings, but clk_get may return different clock producers
+ * depending on @dev.)
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
@@ -469,6 +510,29 @@ struct clk *devm_clk_get(struct device *dev, const char *id);
  */
 struct clk *devm_clk_get_optional(struct device *dev, const char *id);
 
+/**
+ * devm_clk_get_optional_prepared - devm_clk_get_optional() + clk_prepare()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as devm_clk_get_prepared() except where there is no clock
+ * producer.  In this case, instead of returning -ENOENT, the function returns
+ * NULL.
+ */
+struct clk *devm_clk_get_optional_prepared(struct device *dev, const char *id);
+
+/**
+ * devm_clk_get_optional_enabled - devm_clk_get_optional() +
+ *                                 clk_prepare_enable()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as devm_clk_get_enabled() except where there is no clock
+ * producer.  In this case, instead of returning -ENOENT, the function returns
+ * NULL.
+ */
+struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id);
+
 /**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
@@ -813,12 +877,36 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
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
2.30.2

