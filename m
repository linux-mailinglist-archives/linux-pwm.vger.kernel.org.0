Return-Path: <linux-pwm+bounces-92-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983C7F2FB9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21DB0B2097E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7521353812;
	Tue, 21 Nov 2023 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6231BD7E
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-0006PH-IN; Tue, 21 Nov 2023 14:52:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAZ-00Ab24-SX; Tue, 21 Nov 2023 14:52:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAZ-004xh3-JB; Tue, 21 Nov 2023 14:52:03 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 091/108] pwm: sun4i: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:33 +0100
Message-ID: <20231121134901.208535-92-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NamMhonsmWC/vi5fd8wfhvGOrAdNJTRMzmBa6OpmDa8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWwjaoSvfLlTQRQTIEZx8QXpI4WVF2SrI4t6 3vk84iJ+3KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1sAAKCRCPgPtYfRL+ TtI9B/9E/KxFyGPrr572LA0DDO3PnQll5rgDNEhEpfqOAjPuA4M+KTVCv5dp1XHtHVUkISEn+T3 l1+4OBu3mH8jhMUZsnQgHXiX7FdnQ5HO8eM1y17dZi0BjTn3bQv+KKMPHvUZ985sRCj9/MqTtL1 VEfOlMiSbUOkrBq2nEHyR7N6E3qGPdDQgRz3vG0RYju/Xk38pTXCvxVRW7QPKDOQnIOM/XGIrT+ 3+yHrBSvhzcc7d5gJSIqisHsXiXtSXDMe1DxYQINYaosxqHCyMQL7xQW7vfmjNFgZAE+JysJWKD xFTHlcM8Wn6uAs8LqsEXe2sYzzpbNd3f414QILJuxwfYsS/N
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sun4i driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 44edf1ce5739..65652f510237 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -81,7 +81,6 @@ struct sun4i_pwm_data {
 };
 
 struct sun4i_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
@@ -92,7 +91,7 @@ struct sun4i_pwm_chip {
 
 static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sun4i_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *chip,
@@ -384,17 +383,22 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
 
 static int sun4i_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct sun4i_pwm_chip *sun4ichip;
+	const struct sun4i_pwm_data *data;
 	int ret;
 
-	sun4ichip = devm_kzalloc(&pdev->dev, sizeof(*sun4ichip), GFP_KERNEL);
-	if (!sun4ichip)
-		return -ENOMEM;
-
-	sun4ichip->data = of_device_get_match_data(&pdev->dev);
-	if (!sun4ichip->data)
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
 		return -ENODEV;
 
+	chip = devm_pwmchip_alloc(&pdev->dev, data->npwm, sizeof(*sun4ichip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	sun4ichip = to_sun4i_pwm_chip(chip);
+
+	sun4ichip->data = data;
+
 	sun4ichip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sun4ichip->base))
 		return PTR_ERR(sun4ichip->base);
@@ -451,19 +455,18 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto err_bus;
 	}
 
-	sun4ichip->chip.dev = &pdev->dev;
-	sun4ichip->chip.ops = &sun4i_pwm_ops;
-	sun4ichip->chip.npwm = sun4ichip->data->npwm;
+	chip->ops = &sun4i_pwm_ops;
+	chip->npwm = sun4ichip->data->npwm;
 
 	spin_lock_init(&sun4ichip->ctrl_lock);
 
-	ret = pwmchip_add(&sun4ichip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 		goto err_pwm_add;
 	}
 
-	platform_set_drvdata(pdev, sun4ichip);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
@@ -477,9 +480,10 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 static void sun4i_pwm_remove(struct platform_device *pdev)
 {
-	struct sun4i_pwm_chip *sun4ichip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct sun4i_pwm_chip *sun4ichip = to_sun4i_pwm_chip(chip);
 
-	pwmchip_remove(&sun4ichip->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(sun4ichip->bus_clk);
 	reset_control_assert(sun4ichip->rst);
-- 
2.42.0


