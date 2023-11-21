Return-Path: <linux-pwm+bounces-84-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF01C7F2FAB
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F58281DBC
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A953812;
	Tue, 21 Nov 2023 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E23DD7C
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAY-000616-Ff; Tue, 21 Nov 2023 14:52:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAV-00Ab0i-An; Tue, 21 Nov 2023 14:51:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAV-004xfX-1t; Tue, 21 Nov 2023 14:51:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 070/108] pwm: microchip-core: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:12 +0100
Message-ID: <20231121134901.208535-71-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=m4GyQiFXFJaqNI6WOpp3CmU9hg+F8DEVlbs8fT7JIU0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWZSTYln9e9/w1RE6dBuatGQK2RNYSXM6EYF CszlHEPUGeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1mQAKCRCPgPtYfRL+ Tso6CACWEICz+Jh2/S6FDrY1o+5J7hFt6zyH2dcAUsmNBuWJ4ZqL4miE/SUO657rMaSUg9Wtkhy wrFk8QVsIS04DXx4wHU1gic30T/u/3U7GisM5aBAwGKZ4S+xZy1TMkLOM9rOZxTJ21uecn8GM8G CEe+cLYLMAGgAJg/bfJYd5VkX9zCifzLtblcuAghcXnJSLVuutfJ8b7BHD9Xw59lRGWMFmz6jV0 nasGBbYyqmfwI8i8evkJ/BZo5i0cK4cCbXUyUbqnVSoI8LpAPwoZDKwgwLxn3LrWfQ2jNWr4e5y MqOLZ/CXnwJhoh0PzYy7JvOglfnnUh/Bk8uFWxLds8X3iQ4Q
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-microchip-core driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-microchip-core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
index c0c53968f3e9..6e0c2cbfc120 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -54,7 +54,6 @@
 #define MCHPCOREPWM_TIMEOUT_MS	100u
 
 struct mchp_core_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct mutex lock; /* protects the shared period */
@@ -65,7 +64,7 @@ struct mchp_core_pwm_chip {
 
 static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mchp_core_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -447,13 +446,15 @@ MODULE_DEVICE_TABLE(of, mchp_core_of_match);
 
 static int mchp_core_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct mchp_core_pwm_chip *mchp_core_pwm;
 	struct resource *regs;
 	int ret;
 
-	mchp_core_pwm = devm_kzalloc(&pdev->dev, sizeof(*mchp_core_pwm), GFP_KERNEL);
-	if (!mchp_core_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 16, sizeof(*mchp_core_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mchp_core_pwm = to_mchp_core_pwm(chip);
 
 	mchp_core_pwm->base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
 	if (IS_ERR(mchp_core_pwm->base))
@@ -470,9 +471,7 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 
 	mutex_init(&mchp_core_pwm->lock);
 
-	mchp_core_pwm->chip.dev = &pdev->dev;
-	mchp_core_pwm->chip.ops = &mchp_core_pwm_ops;
-	mchp_core_pwm->chip.npwm = 16;
+	chip->ops = &mchp_core_pwm_ops;
 
 	mchp_core_pwm->channel_enabled = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0));
 	mchp_core_pwm->channel_enabled |=
@@ -485,7 +484,7 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
 	mchp_core_pwm->update_timestamp = ktime_get();
 
-	ret = devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add pwmchip\n");
 
-- 
2.42.0


