Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E16D7C7304
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379616AbjJLQbu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbjJLQbT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EEAE8
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyad-0005o3-J4; Thu, 12 Oct 2023 18:31:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyab-001CAu-It; Thu, 12 Oct 2023 18:31:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyab-00F5S9-9v; Thu, 12 Oct 2023 18:31:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 090/109] pwm: stm32: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:58 +0200
Message-ID: <20231012162827.1002444-201-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5683; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=spP0XjE/Zs62UwUDn+Gi8pEWdm3A7LuFbTjpaFYEf4Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8Wga3s91I2WoyRnV+OOVPlZvWvsTnQPDTKm SGz5I/e6+KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfFgAKCRCPgPtYfRL+ TlOUCAC1fYqp0j9wI53Oy5qXxnn80IM8h6DqlnsEKuqZOPysYFA+qcyMhoKxBqUFYfLmTkY6fp1 TCBbY4mwq2/81icXkdF2DGJKSV7wPRfmwJ9Tun/boccThWqv+6ZDsdxP5zFrL67GKvehzQ/4BWh rMcw7rIWNwo0D/1ntsZVabJfAUSiscrp1Pr1UsIdAWxMtvKD4Sty6WMn9P6gLqlnj9lcngwOt4V yoJ+3bi3varwV7U44HRuiEw+6QbVknB9kbYQzdaH9AjRm0UH60sfmpRinEI9IqZGjZLwVJdt98i 5wLheUe9JvWVxCx7JO5M4ZSZooTnO6fWW8oR0okopeUQgFss
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

This prepares the pwm-stm32 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 51 ++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index bb8592291bd0..bec6784870ec 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -27,7 +27,6 @@ struct stm32_breakinput {
 };
 
 struct stm32_pwm {
-	struct pwm_chip chip;
 	struct mutex lock; /* protect pwm config/enable */
 	struct clk *clk;
 	struct regmap *regmap;
@@ -40,7 +39,7 @@ struct stm32_pwm {
 
 static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stm32_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static u32 active_channels(struct stm32_pwm *dev)
@@ -105,11 +104,12 @@ static int write_ccrx(struct stm32_pwm *dev, int ch, u32 value)
  * - Period     = t2 - t0
  * - Duty cycle = t1 - t0
  */
-static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
+static int stm32_pwm_raw_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 				 unsigned long tmo_ms, u32 *raw_prd,
 				 u32 *raw_dty)
 {
-	struct device *parent = pwmchip_parent(&priv->chip);
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	struct device *parent = pwmchip_parent(chip);
 	enum stm32_timers_dmas dma_id;
 	u32 ccen, ccr;
 	int ret;
@@ -223,7 +223,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			   TIM_CCER_CC12P : TIM_CCER_CC34P, pwm->hwpwm < 2 ?
 			   TIM_CCER_CC2P : TIM_CCER_CC4P);
 
-	ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd, &raw_dty);
+	ret = stm32_pwm_raw_capture(chip, pwm, tmo_ms, &raw_prd, &raw_dty);
 	if (ret)
 		goto stop;
 
@@ -244,7 +244,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 		/* 2nd measure with new scale */
 		psc /= scale;
 		regmap_write(priv->regmap, TIM_PSC, psc);
-		ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd,
+		ret = stm32_pwm_raw_capture(chip, pwm, tmo_ms, &raw_prd,
 					    &raw_dty);
 		if (ret)
 			goto stop;
@@ -272,7 +272,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			   FIELD_PREP(TIM_CCMR_IC1PSC, icpsc) |
 			   FIELD_PREP(TIM_CCMR_IC2PSC, icpsc));
 
-	ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd, &raw_dty);
+	ret = stm32_pwm_raw_capture(chip, pwm, tmo_ms, &raw_prd, &raw_dty);
 	if (ret)
 		goto stop;
 
@@ -578,18 +578,18 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
 	priv->have_complementary_output = (ccer != 0);
 }
 
-static int stm32_pwm_detect_channels(struct stm32_pwm *priv)
+static unsigned int stm32_pwm_detect_channels(struct stm32_timers *ddata)
 {
 	u32 ccer;
-	int npwm = 0;
+	unsigned int npwm = 0;
 
 	/*
 	 * If channels enable bits don't exist writing 1 will have no
 	 * effect so we can detect and count them.
 	 */
-	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
-	regmap_read(priv->regmap, TIM_CCER, &ccer);
-	regmap_clear_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
+	regmap_set_bits(ddata->regmap, TIM_CCER, TIM_CCER_CCXE);
+	regmap_read(ddata->regmap, TIM_CCER, &ccer);
+	regmap_clear_bits(ddata->regmap, TIM_CCER, TIM_CCER_CCXE);
 
 	if (ccer & TIM_CCER_CC1E)
 		npwm++;
@@ -612,11 +612,14 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_pwm *priv;
+	struct pwm_chip *chip;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, stm32_pwm_detect_channels(ddata),
+				  sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_stm32_pwm_dev(chip);
 
 	mutex_init(&priv->lock);
 	priv->regmap = ddata->regmap;
@@ -632,33 +635,32 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	stm32_pwm_detect_complementary(priv);
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &stm32pwm_ops;
-	priv->chip.npwm = stm32_pwm_detect_channels(priv);
+	chip->ops = &stm32pwm_ops;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, priv);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static int __maybe_unused stm32_pwm_suspend(struct device *dev)
 {
-	struct stm32_pwm *priv = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	unsigned int i;
 	u32 ccer, mask;
 
 	/* Look for active channels */
 	ccer = active_channels(priv);
 
-	for (i = 0; i < priv->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		mask = TIM_CCER_CC1E << (i * 4);
 		if (ccer & mask) {
 			dev_err(dev, "PWM %u still in use by consumer %s\n",
-				i, priv->chip.pwms[i].label);
+				i, chip->pwms[i].label);
 			return -EBUSY;
 		}
 	}
@@ -668,7 +670,8 @@ static int __maybe_unused stm32_pwm_suspend(struct device *dev)
 
 static int __maybe_unused stm32_pwm_resume(struct device *dev)
 {
-	struct stm32_pwm *priv = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	int ret;
 
 	ret = pinctrl_pm_select_default_state(dev);
-- 
2.42.0

