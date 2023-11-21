Return-Path: <linux-pwm+bounces-73-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B62757F2FA3
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4681DB210F9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921B953808;
	Tue, 21 Nov 2023 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5255310EB
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-0006H6-3t; Tue, 21 Nov 2023 14:52:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAY-00Ab1c-66; Tue, 21 Nov 2023 14:52:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAX-004xgb-TQ; Tue, 21 Nov 2023 14:52:01 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Walle <michael@walle.cc>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 084/108] pwm: sl28cpld: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:26 +0100
Message-ID: <20231121134901.208535-85-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SP6HObl80sKwkBdnebMV0NaVHrkgjH2XzfH7ob63+Ig=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWpwWhMGtDGaaPSLdY7QUxl+KNrnFVHd6FOT AAi9Ii1Hz+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1qQAKCRCPgPtYfRL+ Tv15B/9eYSNY5ScFcI7BkppO6h7sWw4mWSP5RvRqlWveBuVPWa1IpJ+VV9/IGayvYYfq8x/8Ff1 B/bNnixyRBtJnFCMDFOmIvxCMcnP6HDJW0Po9ddTZu1EhNYEekq4wzZCueYf9bHJkPJ8EeHgvmt rd3pAare8tGXn3sLPJPRWwnQMEjw0VFVvheC3y5uYHIkwhwD0UVlGKPv83PJOkWA9DXTgeljWZE jAj5YIQqc7tiSxiQ5+OuSpKVcNOn21JRnxS4o6kXkgukp8zN/ZP91Sfd+F46b6bKTSSdwKX1mbv CRJKBeC7cxd99pKezVvYx1eCadN52oHbHieafGgsy6Zt7c4o
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sl28cpld driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sl28cpld.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 88b01ff9e460..30f96d10a3b8 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -81,14 +81,13 @@
 	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
 
 struct sl28cpld_pwm {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 offset;
 };
 
 static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sl28cpld_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int sl28cpld_pwm_get_state(struct pwm_chip *chip,
@@ -213,9 +212,10 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = sl28cpld_pwm_from_chip(chip);
 
 	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!priv->regmap) {
@@ -231,10 +231,7 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize the pwm_chip structure */
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &sl28cpld_pwm_ops;
-	chip->npwm = 1;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret) {
-- 
2.42.0


