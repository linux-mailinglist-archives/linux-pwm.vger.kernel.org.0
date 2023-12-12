Return-Path: <linux-pwm+bounces-540-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B20D80F541
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 19:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D946E281E20
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226447E771;
	Tue, 12 Dec 2023 18:10:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4FFCA
	for <linux-pwm@vger.kernel.org>; Tue, 12 Dec 2023 10:09:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7CY-00018c-61; Tue, 12 Dec 2023 19:09:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7CX-00FOY3-Kp; Tue, 12 Dec 2023 19:09:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7CX-001opK-BH; Tue, 12 Dec 2023 19:09:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org,
	kernel@pengutronix.de,
	Sean Anderson <sean.anderson@seco.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 1/2] clk: Add a devm variant of clk_rate_exclusive_get()
Date: Tue, 12 Dec 2023 19:09:42 +0100
Message-ID:  <744a6371f94fe96f527eea6e52a600914e6fb6b5.1702403904.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702403904.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702403904.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=83osLBwIYWm/efrAoaEOAgooSgTJvsramEdhJvazV5c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBleKHmnp1ZpKaQnrsMzctCAYGIjclO6xGTQBCtD KaUaHCzGUqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXih5gAKCRCPgPtYfRL+ TpyAB/4u6wkx3TpEBJVzSsWQzviQdOwzYmaP7vC3NCWpCoTuwRhrgzrTMjmRy/2sO/pTwmaXfE+ 2OTuqR6X8bgY0lMymYVkl2euoUnTknNk8hhhjfi/KLJwPcZUXChp9tnnsWLtvMUy3h7K02Z7e1z oko66rrnckYVteYUHN05lg+CygUx/ft79QtJsXdXMjkoDNQwUbnlGrZmMtXXm1QwVYq+kmt+o+X kV7ecKNZfvzlWqSNHWorRqvshwgyZXnbjKo6KHtie/xOdapn7JA5Qs/MQZd8YuvYCNicUBuhZla kaixocs/p2TkrKP//KEyIut1wACozmCQdgfdhHFpjPRiJkFJ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This allows to simplify drivers that use clk_rate_exclusive_get()
in their probe routine as calling clk_rate_exclusive_put() is cared for
automatically.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/clk.c   | 15 +++++++++++++++
 include/linux/clk.h | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af2011c2a93b..78249ca2341c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -937,6 +937,21 @@ void clk_rate_exclusive_get(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
 
+static void devm_clk_rate_exclusive_put(void *data)
+{
+	struct clk *clk = data;
+
+	clk_rate_exclusive_put(clk);
+}
+
+int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk)
+{
+	clk_rate_exclusive_get(clk);
+
+	return devm_add_action_or_reset(dev, devm_clk_rate_exclusive_put, clk);
+}
+EXPORT_SYMBOL_GPL(devm_clk_rate_exclusive_get);
+
 static void clk_core_unprepare(struct clk_core *core)
 {
 	lockdep_assert_held(&prepare_lock);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index f88c407925f8..5a749459c3a3 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -199,6 +199,18 @@ bool clk_is_match(const struct clk *p, const struct clk *q);
  */
 void clk_rate_exclusive_get(struct clk *clk);
 
+/**
+ * devm_clk_rate_exclusive_get - devm variant of clk_rate_exclusive_get
+ * @dev: device the exclusivity is bound to
+ * @clk: clock source
+ *
+ * Calls clk_rate_exclusive_get() on @clk and registers a devm cleanup handler
+ * on @dev to cal clk_rate_exclusive_put().
+ *
+ * Must not be called from within atomic context.
+ */
+int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk);
+
 /**
  * clk_rate_exclusive_put - release exclusivity over the rate control of a
  *                          producer
-- 
2.42.0


