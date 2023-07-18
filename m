Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47340758475
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGRSTQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGRSTO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5472910F3
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHp-0001tZ-KJ; Tue, 18 Jul 2023 20:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHn-000Qnc-4v; Tue, 18 Jul 2023 20:18:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHm-005uoR-D0; Tue, 18 Jul 2023 20:18:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 17/18] pwm: stm32: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:48 +0200
Message-Id: <20230718181849.3947851-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4591; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=u86XsNNP9xPpUQDfeiRdXDHtFE5LnIzzsU2bX8BET9M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttb6wJ6iKJHFw/ycL+HtyGUhOiNsh0wE5GvcH ndusH46/tWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW+gAKCRCPgPtYfRL+ Tv3ACAClcE/e/zFcuDNcTFUyF0vn6w5fYbBmtsGFftYI+INrtyvaytCvxDs6cFVkwX/HmOJRtLw nRIr2t7LDuaGeXChRZiQAw81I+3EBSEWJa4ov07S17PhfbQrj1SV+0D5fZbsXx8jAzau499LTpJ M6R/JRyrzakesBA7Ssy+ymxfI90TPs6h+e1uMJZO5utRNFf0EqSkTEiK3XFUa5Mu5pieviKpPs8 gmR3+nTIK4C0ByNMhiaO55mk9gZmV6nrNreRboGyybcQYgJu9krFXhMy1daxFgrS9GzuqTPOYqG 6MFwXBBtsrhO/Sy3+QSI25oiwMXgO67mTOre8B+8/QHk3+sn
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pwm/pwm-stm32.c | 42 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3d6be7749e23..ade89b169bd1 100644
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
@@ -109,7 +108,7 @@ static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
 				 unsigned long tmo_ms, u32 *raw_prd,
 				 u32 *raw_dty)
 {
-	struct device *parent = priv->chip.dev->parent;
+	struct device *parent = pwm->chip->dev->parent;
 	enum stm32_timers_dmas dma_id;
 	u32 ccen, ccr;
 	int ret;
@@ -185,7 +184,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = clk_enable(priv->clk);
 	if (ret) {
-		dev_err(priv->chip.dev, "failed to enable counter clock\n");
+		dev_err(chip->dev, "failed to enable counter clock\n");
 		goto unlock;
 	}
 
@@ -451,6 +450,7 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	int ret;
 
+	dev_info(chip->dev, "%s:%d, priv=%px\n", __func__, __LINE__, priv);
 	enabled = pwm->state.enabled;
 
 	if (enabled && !state->enabled) {
@@ -613,11 +613,14 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_pwm *priv;
+	struct pwm_chip *chip;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	chip = devm_pwmchip_alloc(dev, sizeof(*priv));
+	if (!chip)
 		return -ENOMEM;
+	priv = to_stm32_pwm_dev(chip);
+	dev_info(chip->dev, "%s:%d, priv=%px\n", __func__, __LINE__, priv);
 
 	mutex_init(&priv->lock);
 	priv->regmap = ddata->regmap;
@@ -633,33 +636,40 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	stm32_pwm_detect_complementary(priv);
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &stm32pwm_ops;
-	priv->chip.npwm = stm32_pwm_detect_channels(priv);
+	chip->ops = &stm32pwm_ops;
+	chip->npwm = stm32_pwm_detect_channels(priv);
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, priv);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
+static void stm32_pwm_remove(struct platform_device *pdev)
+{
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	dev_info(&pdev->dev, "%s:%d: chip=%px\n", __func__, __LINE__, chip);
+	chip->ops = 0;
+}
+
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
@@ -669,7 +679,8 @@ static int __maybe_unused stm32_pwm_suspend(struct device *dev)
 
 static int __maybe_unused stm32_pwm_resume(struct device *dev)
 {
-	struct stm32_pwm *priv = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
 	int ret;
 
 	ret = pinctrl_pm_select_default_state(dev);
@@ -690,6 +701,7 @@ MODULE_DEVICE_TABLE(of, stm32_pwm_of_match);
 
 static struct platform_driver stm32_pwm_driver = {
 	.probe	= stm32_pwm_probe,
+	.remove_new = stm32_pwm_remove,
 	.driver	= {
 		.name = "stm32-pwm",
 		.of_match_table = stm32_pwm_of_match,
-- 
2.39.2

