Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE625774821
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjHHT0l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjHHT0V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:26:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DC11DD20
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-0007kM-Nv; Tue, 08 Aug 2023 19:20:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-0022AK-10; Tue, 08 Aug 2023 19:20:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-00BTGH-CY; Tue, 08 Aug 2023 19:20:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 095/101] pwm: tiehrpwm: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:25 +0200
Message-Id: <20230808171931.944154-96-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3924; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=puBlJ1DhDms39NjWYPFdNambdVJ5EbjKVI//gkU5u5I=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpRLldIaO10vHdrNXaumx5JZaMSasnTZNlXel5PrxLVKo jfwy8zqZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiawPY/wfqL91xQP+PaP2F NdfcJWVWZjgt13lmdY3RuXWFWa7ki92vcs4JJB/OuqR5ZZqyoeJfxrB5q/bX61a8YhHfl8vVwLs qiP1LxcpT7BoyUXFKD9/OM1I1DxRT+/ZnzhqB5OhWD66Xa/5uErnFGsqg2Xci1KpiWuzTJa99/R ovLDv2ada+LRHXig0UIrYw1L83Mr/z2oRd0OAra6NV2p9TJ5jdZfgez760b/YFw62B4UvC1i+f/ 8mxNS+dO4rv7K97S//q3KhS1Nt8qfD0k3a3COF/EqL5phsF9fxSP7Jecow0K6xgl/7/+CLHieKw pz+T5FNTji0P/ZdqleBvUj/3ulBtJnt9z0vPNok7zJKXAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 5516cca7e3ac..e9ba78308997 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -105,6 +105,7 @@ struct ehrpwm_context {
 };
 
 struct ehrpwm_pwm_chip {
+	struct device *parent;
 	unsigned long clk_rate;
 	void __iomem *mmio_base;
 	unsigned long period_cycles[NUM_PWM_CHANNEL];
@@ -255,7 +256,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			if (i == pwm->hwpwm)
 				continue;
 
-			dev_err(chip->dev,
+			dev_err(pc->parent,
 				"period value conflicts with channel %u\n",
 				i);
 			return -EINVAL;
@@ -267,11 +268,11 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Configure clock prescaler to support Low frequency PWM wave */
 	if (set_prescale_div(period_cycles/PERIOD_MAX, &ps_divval,
 			     &tb_divval)) {
-		dev_err(chip->dev, "Unsupported values\n");
+		dev_err(pc->parent, "Unsupported values\n");
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pc->parent);
 
 	/* Update clock prescaler values */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
@@ -298,7 +299,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
 
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pc->parent);
 
 	return 0;
 }
@@ -321,7 +322,7 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u16 aqcsfrc_val, aqcsfrc_mask;
 
 	/* Leave clock enabled on enabling PWM */
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pc->parent);
 
 	/* Disabling Action Qualifier on PWM output */
 	if (pwm->hwpwm) {
@@ -376,7 +377,7 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable(pc->tbclk);
 
 	/* Disable clock on PWM disable */
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pc->parent);
 }
 
 static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -384,8 +385,8 @@ static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
 	if (pwm_is_enabled(pwm)) {
-		dev_warn(chip->dev, "Removing PWM device without disabling\n");
-		pm_runtime_put_sync(chip->dev);
+		dev_warn(pc->parent, "Removing PWM device without disabling\n");
+		pm_runtime_put_sync(pc->parent);
 	}
 
 	/* set period value to zero on free */
@@ -461,6 +462,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "Failed to get fck\n");
 
+	pc->parent = &pdev->dev;
 	pc->clk_rate = clk_get_rate(clk);
 	if (!pc->clk_rate) {
 		dev_err(&pdev->dev, "failed to get clock rate\n");
@@ -518,7 +520,7 @@ static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pc->parent);
 
 	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TBCTL);
 	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TBPRD);
@@ -529,7 +531,7 @@ static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
 	pc->ctx.aqsfrc = ehrpwm_read(pc->mmio_base, AQSFRC);
 	pc->ctx.aqcsfrc = ehrpwm_read(pc->mmio_base, AQCSFRC);
 
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pc->parent);
 }
 
 static void ehrpwm_pwm_restore_context(struct pwm_chip *chip)
-- 
2.40.1

