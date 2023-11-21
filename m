Return-Path: <linux-pwm+bounces-66-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015817F2F90
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FDA1C21620
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CF353808;
	Tue, 21 Nov 2023 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FD510CA
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAV-0005q2-Km; Tue, 21 Nov 2023 14:51:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAT-00Ab0H-JL; Tue, 21 Nov 2023 14:51:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAT-004xf1-AE; Tue, 21 Nov 2023 14:51:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-mips@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 062/108] pwm: jz4740: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:04 +0100
Message-ID: <20231121134901.208535-63-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bRQ+F+aeB8vQEGLPrJ2M2/SlRwuHDUTUKoEQayEnhZU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWQVHXq2IQFQmVQaZqkQIXfVZ3J3PxxEWEQ6 rIqiqwGIeSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1kAAKCRCPgPtYfRL+ ToUXB/9Cb/apBMPlv6wauaVR+BaP/R5kAvVCcSpXhblSi8/rr1F5FldWQYqgfBrpJxl58VuxvK9 2GMOuT9+sFPkEywEsr0AXBsh+V1tK7w4p5JjOvpLiljujr+DXJkU6AVitdT2dfbA7ujq+zhC8NO bAR3+AsZf63fou6m54tnKnzR7Zh/K88rgehCv+0fNcjgSUt93eL2Dv6CBQnq8ubUi376uJt5Ds2 sTPzqX1FDeB5/r7T7P+Sn6xDN68TBSStstRe+MXDKm51GF8jlgyNOGsdxhHBzW7UTfln8cZN/mh 268TswBMWiNuO0Db8ounJXv2CfAM+iu6QsOUyvHjBpdFyTew
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-jz4740 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 555c2db3968d..84ad5c3eb599 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -25,14 +25,13 @@ struct soc_info {
 };
 
 struct jz4740_pwm_chip {
-	struct pwm_chip chip;
 	struct regmap *map;
 	struct clk *clk[];
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 {
-	return container_of(chip, struct jz4740_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned int channel)
@@ -222,6 +221,7 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct jz4740_pwm_chip *jz;
 	const struct soc_info *info;
 
@@ -229,10 +229,10 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	jz = devm_kzalloc(dev, struct_size(jz, clk, info->num_pwms),
-			      GFP_KERNEL);
-	if (!jz)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, info->num_pwms, struct_size(jz, clk, info->num_pwms));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	jz = to_jz4740(chip);
 
 	jz->map = device_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(jz->map)) {
@@ -240,11 +240,9 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(jz->map);
 	}
 
-	jz->chip.dev = dev;
-	jz->chip.ops = &jz4740_pwm_ops;
-	jz->chip.npwm = info->num_pwms;
+	chip->ops = &jz4740_pwm_ops;
 
-	return devm_pwmchip_add(dev, &jz->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct soc_info jz4740_soc_info = {
-- 
2.42.0


