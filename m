Return-Path: <linux-pwm+bounces-38-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3987C7F2F70
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6564282690
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F063854F8B;
	Tue, 21 Nov 2023 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35127D6F
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAP-0005QP-5Z; Tue, 21 Nov 2023 14:51:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-00Aayx-Ov; Tue, 21 Nov 2023 14:51:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-004xdR-Fi; Tue, 21 Nov 2023 14:51:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 040/108] pwm: atmel-hlcdc: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:42 +0100
Message-ID: <20231121134901.208535-41-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4035; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CoRiOQmhOjCsmSi/rI1j6UI8Zd+z28Kcs+vg9BGgJZ4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLV4+wOaXDfgBCxjpUGvGwqJ16Zs0+Fu4G0Q/ dNQDh8KlKOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1eAAKCRCPgPtYfRL+ TqjuB/9z8qV7YnoOjpV3yWAxtHibG1okuHw4++oFG7tEEXtqlYva8843eBtKUC0yTq5Ho0Cq95/ 4In7/rSl/ZxBp0l9e6Q1iRwc8jVc01n1CAguhjnIEgSpgbCZJWRX+Bc+DKuf8J7CRI25RWvRmE7 h5zbZaA/nhWu/BC+Ccx4qrIuqXvIFUa9M+IB/zqtYgKV+GEMH3I9bpvNCl6EPMDpLM1gaYAzxyw rpk4tv65p3SNrgsfCDkQXOfJA02DPHSaox2+Dvd9lI+thPSNBLHthImNjLhszwrjbFMm5xsWQtY 9vw9aNJSh8HejpZVs07NhrDmPRDqJ3TcMrI4qSqtZobjj3pm
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
index 3f2c5031a3ba..4133107d3774 100644
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
+	return pwmchip_priv(chip);
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


