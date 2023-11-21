Return-Path: <linux-pwm+bounces-95-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E1D7F2FBE
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB94B20EB7
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF6537FB;
	Tue, 21 Nov 2023 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D75F10DC
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-0006MY-5e; Tue, 21 Nov 2023 14:52:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAZ-00Ab1w-BA; Tue, 21 Nov 2023 14:52:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAZ-004xgv-1s; Tue, 21 Nov 2023 14:52:03 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 089/108] pwm: stm32: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:31 +0100
Message-ID: <20231121134901.208535-90-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5958; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Hjoz5pS3o+vQD05j7hvlIBMBoLcpuUHgtSwWzaNV+3M=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSYres8WkNvFhs+jChapSa9tKPnZ0/AckfRxNSZlh9tH rL7Wp7sZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAi2jXs/8w99lmIa8x2W+cs 76+mfviL5ipG9h/Ll+wJVJ4f2fOsvuMSr5eJxvx6MZegvhCfY+p212x93d4Lh1Yznk1NXuPsZHn mu22k2LzDXkyxGiGTxM0mFVlIG/5jX3Dk43qHd4sv3JNfkMjkxrzrXfa7vldalTMNI/x29Cf8c5 1ZMPdV5hGbs6Ja3WdfcNyKvKi24dWZuUssJHWPRB5Luf7lf/fCllmue0TseNalP12ck7j90oy25 /+WtzmI59quYNvgev9a9/OgCb8+Szld9+Gwlve+LKU821eQv7csxJuJ22f/c8H+iZ2aJnMjW08F Mq6UOGy2XWSio7R8YKlV0Guj97+Fn4ZX5SW/SAnZXmYBAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-stm32 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 51 ++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index d1dc9e3ca2a1..248244d03e4d 100644
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
@@ -90,11 +89,12 @@ static u32 active_channels(struct stm32_pwm *dev)
  * - Period     = t2 - t0
  * - Duty cycle = t1 - t0
  */
-static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
+static int stm32_pwm_raw_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 				 unsigned long tmo_ms, u32 *raw_prd,
 				 u32 *raw_dty)
 {
-	struct device *parent = pwmchip_parent(&priv->chip)->parent;
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	struct device *parent = pwmchip_parent(chip)->parent;
 	enum stm32_timers_dmas dma_id;
 	u32 ccen, ccr;
 	int ret;
@@ -208,7 +208,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			   TIM_CCER_CC12P : TIM_CCER_CC34P, pwm->hwpwm < 2 ?
 			   TIM_CCER_CC2P : TIM_CCER_CC4P);
 
-	ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd, &raw_dty);
+	ret = stm32_pwm_raw_capture(chip, pwm, tmo_ms, &raw_prd, &raw_dty);
 	if (ret)
 		goto stop;
 
@@ -229,7 +229,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 		/* 2nd measure with new scale */
 		psc /= scale;
 		regmap_write(priv->regmap, TIM_PSC, psc);
-		ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd,
+		ret = stm32_pwm_raw_capture(chip, pwm, tmo_ms, &raw_prd,
 					    &raw_dty);
 		if (ret)
 			goto stop;
@@ -257,7 +257,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			   FIELD_PREP(TIM_CCMR_IC1PSC, icpsc) |
 			   FIELD_PREP(TIM_CCMR_IC2PSC, icpsc));
 
-	ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd, &raw_dty);
+	ret = stm32_pwm_raw_capture(chip, pwm, tmo_ms, &raw_prd, &raw_dty);
 	if (ret)
 		goto stop;
 
@@ -605,7 +605,7 @@ static void stm32_pwm_detect_complementary(struct stm32_pwm *priv)
 	priv->have_complementary_output = (ccer != 0);
 }
 
-static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv,
+static unsigned int stm32_pwm_detect_channels(struct stm32_timers *ddata,
 					      unsigned int *num_enabled)
 {
 	u32 ccer, ccer_backup;
@@ -614,10 +614,10 @@ static unsigned int stm32_pwm_detect_channels(struct stm32_pwm *priv,
 	 * If channels enable bits don't exist writing 1 will have no
 	 * effect so we can detect and count them.
 	 */
-	regmap_read(priv->regmap, TIM_CCER, &ccer_backup);
-	regmap_set_bits(priv->regmap, TIM_CCER, TIM_CCER_CCXE);
-	regmap_read(priv->regmap, TIM_CCER, &ccer);
-	regmap_write(priv->regmap, TIM_CCER, ccer_backup);
+	regmap_read(ddata->regmap, TIM_CCER, &ccer_backup);
+	regmap_set_bits(ddata->regmap, TIM_CCER, TIM_CCER_CCXE);
+	regmap_read(ddata->regmap, TIM_CCER, &ccer);
+	regmap_write(ddata->regmap, TIM_CCER, ccer_backup);
 
 	*num_enabled = hweight32(ccer_backup & TIM_CCER_CCXE);
 
@@ -632,11 +632,14 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	struct stm32_pwm *priv;
 	unsigned int num_enabled;
 	unsigned int i;
+	struct pwm_chip *chip;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, stm32_pwm_detect_channels(ddata, &num_enabled),
+				  sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_stm32_pwm_dev(chip);
 
 	mutex_init(&priv->lock);
 	priv->regmap = ddata->regmap;
@@ -652,37 +655,36 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	stm32_pwm_detect_complementary(priv);
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &stm32pwm_ops;
-	priv->chip.npwm = stm32_pwm_detect_channels(priv, &num_enabled);
+	chip->ops = &stm32pwm_ops;
 
 	/* Initialize clock refcount to number of enabled PWM channels. */
 	for (i = 0; i < num_enabled; i++)
 		clk_enable(priv->clk);
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, priv);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static int stm32_pwm_suspend(struct device *dev)
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
@@ -692,7 +694,8 @@ static int stm32_pwm_suspend(struct device *dev)
 
 static int stm32_pwm_resume(struct device *dev)
 {
-	struct stm32_pwm *priv = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	int ret;
 
 	ret = pinctrl_pm_select_default_state(dev);
-- 
2.42.0


