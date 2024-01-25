Return-Path: <linux-pwm+bounces-986-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F6F83C1D8
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14DD290E3A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA084502D;
	Thu, 25 Jan 2024 12:10:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6854501B
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184654; cv=none; b=iHwSsXYDUy/xPKV0Tjp/1vUlWbhHFl6mW3rcnRj4dEVYs1KbdUdcnhlIhppCH1lG2vWHPVzT36CbNARmUcJ6ArY7YG8ZieQlCrrS2Ucz0i4kjVNgZMX7cEnnvlnYx/XPd2OsjbtsgVOdgYvXGA8CF4OKRqwomZTcj2H24Hh4dHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184654; c=relaxed/simple;
	bh=Qrt9vaeR4KUuMfztIWBoWRb0aAUfBcwyeUrVK67lMM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obKMcm88zADnt9ySrES6kC1yxzD6i2ZdZUdm6+FrKuzzbl7QLn0WueIGU2CCCKm24pDGEe3r/kQD21oYFjGOEyKhAioIsxKssAJDhAgoPKzWPMYC83UT/NgsZvroCHsMq15Z2wDfWpjkcpVHkdQaWTj1Pjb1sMrtNcwvYpnl1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-0004DE-Rp; Thu, 25 Jan 2024 13:10:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZE-002HRZ-Vj; Thu, 25 Jan 2024 13:10:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZE-007n19-2u;
	Thu, 25 Jan 2024 13:10:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 045/111] pwm: atmel-tcb: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:07 +0100
Message-ID:  <929bfbd2695535c73260647e16f44de17ec892af.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Qrt9vaeR4KUuMfztIWBoWRb0aAUfBcwyeUrVK67lMM4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9uVoZxZ932+hxCc1MLX7pX118ipIVmyxMd7 QEJ8McityaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPbgAKCRCPgPtYfRL+ TiGrB/9ietXPsxs0oMkY3xy79/6GRlF8x68TjvUWo6tC7zsKbLXZ53MwqX5oBPo7J+iuB6mRJZ/ uH9Sfi80JKlq0LaAc7SoFKRgkN9LrRlXv98D4Mes1pIRpQJ/bierH/KprkGEei5EBVXVlMESWa0 z/13bIk3NpzCGZSHUkhjBI74HIhwaxeH9m1mdCIilmE+yY6q1E9KPe0at0CSC0Sh3srV4R1aUoM kZc3i5S4C80ye/akqyniiltBU1cxNmGugVMF1RNiO3p9J0tsaiI4rYWf5RGNuqrPEepzBk9gPWX qHofFlXGd8ChFgWMoE8DbB+Cp4SYOYblw989mVo3JK0Gkho+
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-atmel-tcb driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 80121ab81a01..0663685532ec 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -47,7 +47,6 @@ struct atmel_tcb_channel {
 };
 
 struct atmel_tcb_pwm_chip {
-	struct pwm_chip chip;
 	spinlock_t lock;
 	u8 channel;
 	u8 width;
@@ -63,7 +62,7 @@ static const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128, 0, };
 
 static inline struct atmel_tcb_pwm_chip *to_tcb_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct atmel_tcb_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int atmel_tcb_pwm_request(struct pwm_chip *chip,
@@ -389,6 +388,7 @@ static const struct of_device_id atmel_tcb_of_match[] = {
 static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
+	struct pwm_chip *chip;
 	struct atmel_tcb_pwm_chip *tcbpwm;
 	const struct atmel_tcb_config *config;
 	struct device_node *np = pdev->dev.of_node;
@@ -396,9 +396,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	int err;
 	int channel;
 
-	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
-	if (tcbpwm == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, NPWM, sizeof(*tcbpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	tcbpwm = to_tcb_chip(chip);
 
 	err = of_property_read_u32(np, "reg", &channel);
 	if (err < 0) {
@@ -436,9 +437,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	tcbpwm->chip.dev = &pdev->dev;
-	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
-	tcbpwm->chip.npwm = NPWM;
+	chip->ops = &atmel_tcb_pwm_ops;
 	tcbpwm->channel = channel;
 	tcbpwm->width = config->counter_width;
 
@@ -448,11 +447,11 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tcbpwm->lock);
 
-	err = pwmchip_add(&tcbpwm->chip);
+	err = pwmchip_add(chip);
 	if (err < 0)
 		goto err_disable_clk;
 
-	platform_set_drvdata(pdev, tcbpwm);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
@@ -473,9 +472,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 static void atmel_tcb_pwm_remove(struct platform_device *pdev)
 {
-	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct atmel_tcb_pwm_chip *tcbpwm = to_tcb_chip(chip);
 
-	pwmchip_remove(&tcbpwm->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(tcbpwm->slow_clk);
 	clk_put(tcbpwm->gclk);
-- 
2.43.0


