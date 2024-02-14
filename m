Return-Path: <linux-pwm+bounces-1459-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D99485461D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2307E1F2E108
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB4818E10;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292F19475
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=q7tSlF3/8gfkVXQXgIQZpiiq9kEYSHXeknf1cajp3lgsJPmFl6SYHzW/vraArd6d5dUEZk330ns46BSQol7234yREyye6eAKECSV6gsLBfrJ9SEBIRrVcX+FHv3EE7ilAI0ZBhpY3zmUwCvQPoaGcTUqeIncsgts7/TIyYCMCIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=Bb8YBorqx+bVzwUkLBbdXoJMd39BE0M+Jl5c4roRp5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLO9MWv1pGqWds7BFQNbKg8bVAlfL7JojTRDOZ1eo2tVLprzPqsJl80fsuKfLqZNgU2/tK+JcA9ERoGpIEfAs46cgwHU4AMR5rjCc9P+77qwmODl5mNK+W/UkmZbDhXkaqv9Ikm2PpCZsqlYyoE9s6aJEXdQ5+8Y8Ti9B7gEP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-0005rI-Mh; Wed, 14 Feb 2024 10:34:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-000fGK-QI; Wed, 14 Feb 2024 10:34:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-004Y85-2N;
	Wed, 14 Feb 2024 10:34:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 123/164] pwm: stmpe: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:50 +0100
Message-ID:  <7e3dbf3b70126038c0ba16331ca8c07cab575bd3.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2455; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Bb8YBorqx+bVzwUkLBbdXoJMd39BE0M+Jl5c4roRp5w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjYOMQ8tTWUOYAVYGSFAA+Yj0Hz+F/f4oxBl Rnfs+qAKOGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI2AAKCRCPgPtYfRL+ Th1jB/0fMrZDxTfd7Yt+yAj4BDFhl1L44RtBqZZzcd1IUYVMTqIwcgf76dzxY1D879k4DWMYWnH 4Qm4c4MoBoAhwFS7b9es8RzCCxmNZqwHGYASw8WyyaWHsexjOTvI3n436eZzN6KOk5HVrUNfLU4 7CU4WRiFuAUiT8h4DMuJsdqAkFC7Eju+QqYLX4BDITHtibkh58JrxaYobxYvAADm3Q9oNs1V4gc Fb4TFuw69uGkZ4Pv43Z0BBebpEdEi++I9Vr92rIvhxG9UWPDoZ4la0/jkcJOpMA5dkdmE/djM9v xBq2hV0PAPuPFd06QXzl6mQeCCU8+n+7m6mvMjR3bozH6tlO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-stmpe driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stmpe.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index 05f3f38031ee..bb91062d5f1d 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -27,13 +27,12 @@
 
 struct stmpe_pwm {
 	struct stmpe *stmpe;
-	struct pwm_chip chip;
 	u8 last_duty;
 };
 
 static inline struct stmpe_pwm *to_stmpe_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stmpe_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -292,33 +291,36 @@ static const struct pwm_ops stmpe_24xx_pwm_ops = {
 static int __init stmpe_pwm_probe(struct platform_device *pdev)
 {
 	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct stmpe_pwm *stmpe_pwm;
 	int ret;
 
-	stmpe_pwm = devm_kzalloc(&pdev->dev, sizeof(*stmpe_pwm), GFP_KERNEL);
-	if (!stmpe_pwm)
-		return -ENOMEM;
+	switch (stmpe->partnum) {
+	case STMPE2401:
+	case STMPE2403:
+		break;
+	case STMPE1601:
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "STMPE1601 not yet supported\n");
+	default:
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "Unknown STMPE PWM\n");
+	}
+
+	chip = devm_pwmchip_alloc(&pdev->dev, 3, sizeof(*stmpe_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	stmpe_pwm = to_stmpe_pwm(chip);
 
 	stmpe_pwm->stmpe = stmpe;
-	stmpe_pwm->chip.dev = &pdev->dev;
 
-	if (stmpe->partnum == STMPE2401 || stmpe->partnum == STMPE2403) {
-		stmpe_pwm->chip.ops = &stmpe_24xx_pwm_ops;
-		stmpe_pwm->chip.npwm = 3;
-	} else {
-		if (stmpe->partnum == STMPE1601)
-			dev_err(&pdev->dev, "STMPE1601 not yet supported\n");
-		else
-			dev_err(&pdev->dev, "Unknown STMPE PWM\n");
-
-		return -ENODEV;
-	}
+	chip->ops = &stmpe_24xx_pwm_ops;
 
 	ret = stmpe_enable(stmpe, STMPE_BLOCK_PWM);
 	if (ret)
 		return ret;
 
-	ret = pwmchip_add(&stmpe_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret) {
 		stmpe_disable(stmpe, STMPE_BLOCK_PWM);
 		return ret;
-- 
2.43.0


