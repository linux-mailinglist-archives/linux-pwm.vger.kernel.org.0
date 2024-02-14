Return-Path: <linux-pwm+bounces-1421-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708FD8545EE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C821C262B4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F171B26E;
	Wed, 14 Feb 2024 09:34:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0613199A7
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903286; cv=none; b=lDobQ39wr2H03jlHe88vbh9bkLIT7MoCvnwG8Gvat4QmoZLrq2vpow8K6tSZoGIx1FHouFQ4u7krvPI9N0r8DERqJB1yQs5j/7LVRN1ewMHbA5Zmj71AX8STnWFPXeVJVnRtY9rsV/ZTfirF1xVB5G/V55reZk2F6WLumLdnwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903286; c=relaxed/simple;
	bh=L2fP/40Abfd2uvbzxxaCl1aJUDUo3oBsL6xZcwUm+2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/f9plTYc89aSgiJMZY0i38Fjmb8r4SnsxD/eNc0hqmhIepqmtJQCf2ynl8qtXzyVv67F90XKaNv0xFcOb3LTciZH/S6zExInGofLwiPikxloASzh0szhcl2dbmo21G+c78J2JpQQH+A3IhbJbDFM4DjakNbp6FttXroa4igN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-0005X3-Ha; Wed, 14 Feb 2024 10:34:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-000fF1-DI; Wed, 14 Feb 2024 10:34:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-004Y6f-14;
	Wed, 14 Feb 2024 10:34:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pwm@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 101/164] pwm: samsung: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:28 +0100
Message-ID:  <f188e68bdea8d5a24277a10c8c9a6350a9c246ac.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=L2fP/40Abfd2uvbzxxaCl1aJUDUo3oBsL6xZcwUm+2w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIi/e7UAi6YnGdZM63g1kB7xY5zzYA/9MCiLs qcEG9PGLFWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIvwAKCRCPgPtYfRL+ Tt6uCACPyWp3rurpxUbYuN/g8JHDaC1Vl08KyFrb62bjxltlTf/39f706K/2jtSvH9JJmOWQY9s d/JbO2xwE/+kQgdAzHRq7cKgd35llxalGb9EnnjjF5uCVisi8lvyxDCoEh2u0gZLDZN1MyAC9mZ tdPWltTiSjjusA9CTvaqlifwLrbMYLFHYDY9r6fxa2EfuuYMKHEe5B3cSL6KJrxtyC4d1+YKg37 bJtZikaRpPZlgoOX9T1gL6SZ1sWJDgCMFwH0FJbn8zEADmgfyI1VpRnSRP8h+z6HBIhgW5tFKt5 OmKJ6Z+n8ySR2wSqYp0mElum6sud+xIHBMQE6/fqrog4XPo4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-samsung driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index d3dc9b5b80d6..efb60c9f0cb3 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -69,7 +69,6 @@ struct samsung_pwm_channel {
 
 /**
  * struct samsung_pwm_chip - private data of PWM chip
- * @chip:		generic PWM chip
  * @variant:		local copy of hardware variant data
  * @inverter_mask:	inverter status for all channels - one bit per channel
  * @disabled_mask:	disabled status for all channels - one bit per channel
@@ -80,7 +79,6 @@ struct samsung_pwm_channel {
  * @channel:		per channel driver data
  */
 struct samsung_pwm_chip {
-	struct pwm_chip chip;
 	struct samsung_pwm_variant variant;
 	u8 inverter_mask;
 	u8 disabled_mask;
@@ -110,7 +108,7 @@ static DEFINE_SPINLOCK(samsung_pwm_lock);
 static inline
 struct samsung_pwm_chip *to_samsung_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct samsung_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline unsigned int to_tcon_channel(unsigned int channel)
@@ -549,14 +547,12 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 	unsigned int chan;
 	int ret;
 
-	our_chip = devm_kzalloc(&pdev->dev, sizeof(*our_chip), GFP_KERNEL);
-	if (our_chip == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, SAMSUNG_PWM_NUM, sizeof(*our_chip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	our_chip = to_samsung_pwm_chip(chip);
 
-	chip = &our_chip->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &pwm_samsung_ops;
-	chip->npwm = SAMSUNG_PWM_NUM;
 	our_chip->inverter_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
-- 
2.43.0


