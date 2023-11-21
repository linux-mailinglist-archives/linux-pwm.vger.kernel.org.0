Return-Path: <linux-pwm+bounces-53-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E55A7F2F86
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC75D281AD5
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592D53812;
	Tue, 21 Nov 2023 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B35A10E2
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAW-0005rg-7q; Tue, 21 Nov 2023 14:52:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAT-00Ab0K-Qf; Tue, 21 Nov 2023 14:51:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAT-004xf5-Hh; Tue, 21 Nov 2023 14:51:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 063/108] pwm: keembay: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:05 +0100
Message-ID: <20231121134901.208535-64-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+wiZzyRQMv0GyOksGeOGDn2tFrkfYPzBCr3yQcXURs8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWStg1nmm1BTapa/6w7RYOIrPy1k7h3dQxca Hh7vOMZ/3iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1kgAKCRCPgPtYfRL+ TlggB/9nAlQC7TTM4UT5BnkYOfHhuTj+qr95d5h5Shj4gLjRb7SLI/v9DoXn9EurYmdpTMXSCMK HdH+pxl8jVzOaLCSMgKGYab3JaJnUyEyXzIPYtdv8FP6FsRl3tv7uSIdficnErUEp7SlbG7K+s9 rVeZOfWTxaO2Y+bfPN8WsxsBReCdQooagG9WVik+9lEcshCqgC7K+TZSW4gFVjMJiOwP/zifkhP 0+gYQ+tIDUz2Ahn4fO4yH4+FdOlTJf2KhYOrTDFbxX3DvgllNpdXNT//4uSxq6M5/fpiAjCvKHz PM95nabB1ZhgDpTkjHVWI/T4VutAnptPbkLFQZXMiW6rsCa5
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-keembay driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-keembay.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
index ac824ecc3f64..2af5e6565705 100644
--- a/drivers/pwm/pwm-keembay.c
+++ b/drivers/pwm/pwm-keembay.c
@@ -36,7 +36,6 @@
 #define KMB_PWM_HIGHLOW_OFFSET(ch)	(0x20 + 4 * (ch))
 
 struct keembay_pwm {
-	struct pwm_chip chip;
 	struct device *dev;
 	struct clk *clk;
 	void __iomem *base;
@@ -44,7 +43,7 @@ struct keembay_pwm {
 
 static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip *chip)
 {
-	return container_of(chip, struct keembay_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static void keembay_clk_unprepare(void *data)
@@ -185,12 +184,14 @@ static const struct pwm_ops keembay_pwm_ops = {
 static int keembay_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct keembay_pwm *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, KMB_TOTAL_PWM_CHANNELS, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_keembay_pwm_dev(chip);
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk))
@@ -204,11 +205,9 @@ static int keembay_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &keembay_pwm_ops;
-	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
+	chip->ops = &keembay_pwm_ops;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
-- 
2.42.0


