Return-Path: <linux-pwm+bounces-345-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0A806E8E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE9DB20DFC
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9C634CDA;
	Wed,  6 Dec 2023 11:48:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC8D40
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-0006Td-Dv; Wed, 06 Dec 2023 12:48:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-00DwuH-9O; Wed, 06 Dec 2023 12:48:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-00FQzV-0J; Wed, 06 Dec 2023 12:48:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 046/115] pwm: atmel-hlcdc: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:00 +0100
Message-ID:  <626279339e6088d5209b0b3d6638250402f6834c.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4042; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=dxp5TA/yVV1M8T9FFnYASKubVzjSfcC/GawcAJ6CWAQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6WwIqdyEeRyh0Re54/TlxRuemeRYSdX0jdB epBvWFwEE+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBelgAKCRCPgPtYfRL+ Tj9lCACqewljbKVAs9TnLIvv6iwh4tpDHhUzSg2+IVYLq6H2Mqd6BjdB+78a1rXcrNEeFa8vfwc mgLdvv3Rzk6hONAutfM3sARIJUO/v9IrXt8X7Zsijr+vMJwyYrGN1zH3raRlHcaii+by0ESrXEm RWhVO7Gs8971pLZkxsJadObyM+CId3jiGcdFHtFDAJQ7CySQdtfCUi7EIZQMlSgcVzrl8vqseah Rf+0CpN3rBw6RFUTDMfod/uNgVXXtbt5yxC1yBI58BDoYZQqRjh0eQJDquGweyparbP3xIHfuru l/OhBlqBF+HkRJpWgsOmizF87p8IynymDmMkOp5HJy5m8w20
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-atme-hlcdc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 3f2c5031a3ba..aa1b67b6f2ea 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -28,7 +28,6 @@ struct atmel_hlcdc_pwm_errata {
 };
 
 struct atmel_hlcdc_pwm {
-	struct pwm_chip chip;
 	struct atmel_hlcdc *hlcdc;
 	struct clk *cur_clk;
 	const struct atmel_hlcdc_pwm_errata *errata;
@@ -36,7 +35,7 @@ struct atmel_hlcdc_pwm {
 
 static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct atmel_hlcdc_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int atmel_hlcdc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -182,10 +181,11 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 
 static int atmel_hlcdc_pwm_suspend(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (pwm_is_enabled(&atmel->chip.pwms[0]))
+	if (pwm_is_enabled(&chip->pwms[0]))
 		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
@@ -193,11 +193,12 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
 
 static int atmel_hlcdc_pwm_resume(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
 	struct pwm_state state;
 	int ret;
 
-	pwm_get_state(&atmel->chip.pwms[0], &state);
+	pwm_get_state(&chip->pwms[0], &state);
 
 	/* Re-enable the periph clock it was stopped during suspend. */
 	if (!state.enabled) {
@@ -206,8 +207,7 @@ static int atmel_hlcdc_pwm_resume(struct device *dev)
 			return ret;
 	}
 
-	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
-				     &state);
+	return atmel_hlcdc_pwm_apply(chip, &chip->pwms[0], &state);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_pwm_pm_ops,
@@ -243,15 +243,17 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct atmel_hlcdc_pwm *atmel;
 	struct atmel_hlcdc *hlcdc;
 	int ret;
 
 	hlcdc = dev_get_drvdata(dev->parent);
 
-	atmel = devm_kzalloc(dev, sizeof(*atmel), GFP_KERNEL);
-	if (!atmel)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*atmel));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	atmel = to_atmel_hlcdc_pwm(chip);
 
 	ret = clk_prepare_enable(hlcdc->periph_clk);
 	if (ret)
@@ -262,11 +264,9 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 		atmel->errata = match->data;
 
 	atmel->hlcdc = hlcdc;
-	atmel->chip.ops = &atmel_hlcdc_pwm_ops;
-	atmel->chip.dev = dev;
-	atmel->chip.npwm = 1;
+	chip->ops = &atmel_hlcdc_pwm_ops;
 
-	ret = pwmchip_add(&atmel->chip);
+	ret = pwmchip_add(chip);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
@@ -279,9 +279,10 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 
 static void atmel_hlcdc_pwm_remove(struct platform_device *pdev)
 {
-	struct atmel_hlcdc_pwm *atmel = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
 
-	pwmchip_remove(&atmel->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(atmel->hlcdc->periph_clk);
 }
-- 
2.42.0


