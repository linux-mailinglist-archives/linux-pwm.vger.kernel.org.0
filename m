Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6377C72F8
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379636AbjJLQbo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347163AbjJLQbQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BAAE5
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-0005jv-Lk; Thu, 12 Oct 2023 18:31:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-001CAV-CH; Thu, 12 Oct 2023 18:31:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-00F5Rl-34; Thu, 12 Oct 2023 18:31:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 084/109] pwm: sifive: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:52 +0200
Message-ID: <20231012162827.1002444-195-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3168; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yDxKsZliBQFMVNEOUUZXIwbfArvn+cb6Q/j1nGYWcs8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8PtfdNsMYqDXchKPBLPetdFW+hNCAGAZGM+ tuIOyJ0xwaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfDwAKCRCPgPtYfRL+ TvIKB/9haStlp9qTBPfv4vOD09UoHm8gDe/U1PpELnHW6nUQQ+mDrvvsBddnaGl0M1jA9tPZabb I46czft9qdC2SDxIAL8Sfe1R+2KqJBo81t0dn8LdcL+jbx0Emcgzy6l5VCXfPfONo73NknwLPot QDPVdVTSBaj8DtkrYmCr40YTqSyBl+Zanpn0Xy42YcKUC0uYsAJAvyzi8EMZVlxb1P/EkYqws2i Y5wuDmVb8SsB79MMFZa2n1q+pjyhDmnz+4fz70m43x7DlYD5odS4IhoD/ZYtpwKDA/rLkO9gy/s GyEPweioJNTO7eSWUpVNYfMaIGJ92AxImriZxPwVlXs7Uujq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-sifive driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index c830845e0e52..c4e1dcc5177d 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -41,7 +41,6 @@
 #define PWM_SIFIVE_DEFAULT_PERIOD	10000000
 
 struct pwm_sifive_ddata {
-	struct pwm_chip	chip;
 	struct device *parent;
 	struct mutex lock; /* lock to protect user_count and approx_period */
 	struct notifier_block notifier;
@@ -55,7 +54,7 @@ struct pwm_sifive_ddata {
 static inline
 struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_sifive_ddata, chip);
+	return pwmchip_priv(chip);
 }
 
 static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -103,7 +102,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
 	ddata->real_period = div64_ul(num, rate);
-	dev_dbg(ddata->chip.dev,
+	dev_dbg(ddata->parent,
 		"New real_period = %u ns\n", ddata->real_period);
 }
 
@@ -231,17 +230,16 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	u32 val;
 	unsigned int enabled_pwms = 0, enabled_clks = 1;
 
-	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ddata = pwm_sifive_chip_to_ddata(chip);
+	ddata->parent = dev;
 
 	ddata->parent = dev;
 	mutex_init(&ddata->lock);
 
-	chip = &ddata->chip;
-	chip->dev = dev;
 	chip->ops = &pwm_sifive_ops;
-	chip->npwm = 4;
 
 	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddata->regs))
@@ -299,7 +297,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 		goto unregister_clk;
 	}
 
-	platform_set_drvdata(pdev, ddata);
+	platform_set_drvdata(pdev, chip);
 	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
 
 	return 0;
@@ -317,15 +315,16 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 
 static void pwm_sifive_remove(struct platform_device *dev)
 {
-	struct pwm_sifive_ddata *ddata = platform_get_drvdata(dev);
+	struct pwm_chip *chip = platform_get_drvdata(dev);
+	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
 	struct pwm_device *pwm;
 	int ch;
 
-	pwmchip_remove(&ddata->chip);
+	pwmchip_remove(chip);
 	clk_notifier_unregister(ddata->clk, &ddata->notifier);
 
-	for (ch = 0; ch < ddata->chip.npwm; ch++) {
-		pwm = &ddata->chip.pwms[ch];
+	for (ch = 0; ch < chip->npwm; ch++) {
+		pwm = &chip->pwms[ch];
 		if (pwm->state.enabled)
 			clk_disable(ddata->clk);
 	}
-- 
2.42.0

