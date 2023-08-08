Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9747746AD
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjHHS7E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjHHS6r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5881DD50
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN7-0007KN-VC; Tue, 08 Aug 2023 19:19:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-00226T-7u; Tue, 08 Aug 2023 19:19:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-00BTDD-Gx; Tue, 08 Aug 2023 19:19:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 048/101] pwm: sifive: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:38 +0200
Message-Id: <20230808171931.944154-49-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3458; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sQrwfGAiQqBKsZnlF78YLJAV7nOlKgW1pwzJPdjWmO0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njm06bRSjBKu2go3Ov3/6QH4R8HnmBOAtr0J SkLcnWqxGmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ45gAKCRCPgPtYfRL+ TojkB/97FZMU2TxbMCBELaM5ae7w/cpmnxunLcdMFo+m83wP7ooDvSY/m1Z+QGaceELxBU2/IoY As6lcj3pu/0UpNqsCfEhZqlxPn/N713eAJRbTIFmKxbH3poD+G+EJLKwqeoQmIh8Pp7nkF8chGB mu7j1SV/7kE/ZsB/W2TueLYjn5qNzRlH62AZaQyUAgMgBs7RjLzpzl3HJcY7fsd+Eag6Z+Zo7Eb fzHLwDzUHaWu29Wlum60dvBenLsAuf/4oyYAVIzWIMHwf8LAzjSzg3n1mXLVFK1+SubRnOBs0ty zswST25Ww9gj5B3nsZ4IM/hRCzjOcgZAhrS8GMR/Zd/iRpsl
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

This prepares the pwm-sifive driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 089e50bdbbf0..1f8a50143300 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -41,7 +41,7 @@
 #define PWM_SIFIVE_DEFAULT_PERIOD	10000000
 
 struct pwm_sifive_ddata {
-	struct pwm_chip	chip;
+	struct device *parent;
 	struct mutex lock; /* lock to protect user_count and approx_period */
 	struct notifier_block notifier;
 	struct clk *clk;
@@ -54,7 +54,7 @@ struct pwm_sifive_ddata {
 static inline
 struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_sifive_ddata, chip);
+	return pwmchip_priv(chip);
 }
 
 static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -102,7 +102,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
 	ddata->real_period = div64_ul(num, rate);
-	dev_dbg(ddata->chip.dev,
+	dev_dbg(ddata->parent,
 		"New real_period = %u ns\n", ddata->real_period);
 }
 
@@ -185,7 +185,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!enabled) {
 		ret = clk_enable(ddata->clk);
 		if (ret) {
-			dev_err(ddata->chip.dev, "Enable clk failed\n");
+			dev_err(chip->dev, "Enable clk failed\n");
 			return ret;
 		}
 	}
@@ -230,15 +230,14 @@ static int pwm_sifive_probe(struct platform_device *pdev)
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
 
 	mutex_init(&ddata->lock);
-	chip = &ddata->chip;
-	chip->dev = dev;
 	chip->ops = &pwm_sifive_ops;
-	chip->npwm = 4;
 
 	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddata->regs))
@@ -296,7 +295,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 		goto unregister_clk;
 	}
 
-	platform_set_drvdata(pdev, ddata);
+	platform_set_drvdata(pdev, chip);
 	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
 
 	return 0;
@@ -314,15 +313,16 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 
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
2.40.1

