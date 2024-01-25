Return-Path: <linux-pwm+bounces-1015-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FBB83C1F9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC571F221E1
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895E45026;
	Thu, 25 Jan 2024 12:11:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5B3FE2B
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184661; cv=none; b=koGaUpWLd4enk4tu4qdeaFWwdFDg+FAlyt0Szfd3Dg6+nZ2LThHVk5SjXG2od/TjnYSgJK5q/7vqOXbrWu/Q/u/RXGAkIAKm1iZnAgOn7Rqxdlx80ftsAGTpCT22vgMU/Sux+RfR8bkjxO0O2rffWnIp50ODbF6dNLqPATP7be0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184661; c=relaxed/simple;
	bh=hZ48ifFT5vmPHvpooGFp+QQXZ/HZi5ytMwRpLJdzaL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPADty3hMyq09gnN+31lvr71kCbIjpiOhS6rVv27y3oJElAZ3c6iYA2k1rJp80zcdJZqx0iu7JkObtvlYOTt6oO9xoPur4Npm7sCPJOLAgKqCtHRTJJhGtLicXpVMGoUfXG3Hlv82ZM53IhEYJpD22f+qqH6bbNF2kQIbTXSKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-0004UE-0f; Thu, 25 Jan 2024 13:10:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-002HTr-QD; Thu, 25 Jan 2024 13:10:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-007n3U-2M;
	Thu, 25 Jan 2024 13:10:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 080/111] pwm: raspberrypi-poe: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:42 +0100
Message-ID:  <7240dd99d9ef8032b51995feb6d7e63b6c45558b.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=hZ48ifFT5vmPHvpooGFp+QQXZ/HZi5ytMwRpLJdzaL4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+Y57iPgeMAeGCjIL4Dzuip7IHsvGZge+Sza VKltxAix+uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPmAAKCRCPgPtYfRL+ Tp3UB/4n0S/zlLIBBC0jmzVZQXhOAT4zj+dOPbCv3R9U4BJWwZzKIw0JxfOYA6c7ecMOuZLsGGc DVlG8U1d5RZNmzxbGCPY0YvQug+qZApwKESMKM6/IchAt3jVGOj/bNf8npO6awSfAvbsen4kk/w oaAUtrK6CW+Tw+c8QckK5IQ1+lLOpOtpS9E11FY2OLCtXSiYV0070wE1itItoaFNnKlOFooNunF DYwYDRByI7FinEFT5F+PYeE+yflyRRAmytp9JjqV6P2UHpDyOLLgoLBDz6RT32v2mFL3xY71jGQ Osd4h5nNLqPQ8IH4IePCdKUdrgl3NPI8nr+P/7pMYTNFKdht
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-raspberrypi-poe driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-raspberrypi-poe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index f10e8a624c51..8921e7ea2cea 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -27,7 +27,6 @@
 
 struct raspberrypi_pwm {
 	struct rpi_firmware *firmware;
-	struct pwm_chip chip;
 	unsigned int duty_cycle;
 };
 
@@ -40,7 +39,7 @@ struct raspberrypi_pwm_prop {
 static inline
 struct raspberrypi_pwm *raspberrypi_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct raspberrypi_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int raspberrypi_pwm_set_property(struct rpi_firmware *firmware,
@@ -142,6 +141,7 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 	struct device_node *firmware_node;
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *firmware;
+	struct pwm_chip *chip;
 	struct raspberrypi_pwm *rpipwm;
 	int ret;
 
@@ -157,14 +157,14 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EPROBE_DEFER,
 				     "Failed to get firmware handle\n");
 
-	rpipwm = devm_kzalloc(&pdev->dev, sizeof(*rpipwm), GFP_KERNEL);
-	if (!rpipwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, RASPBERRYPI_FIRMWARE_PWM_NUM,
+				  sizeof(*rpipwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	rpipwm = raspberrypi_pwm_from_chip(chip);
 
 	rpipwm->firmware = firmware;
-	rpipwm->chip.dev = dev;
-	rpipwm->chip.ops = &raspberrypi_pwm_ops;
-	rpipwm->chip.npwm = RASPBERRYPI_FIRMWARE_PWM_NUM;
+	chip->ops = &raspberrypi_pwm_ops;
 
 	ret = raspberrypi_pwm_get_property(rpipwm->firmware, RPI_PWM_CUR_DUTY_REG,
 					   &rpipwm->duty_cycle);
@@ -173,7 +173,7 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_pwmchip_add(dev, &rpipwm->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct of_device_id raspberrypi_pwm_of_match[] = {
-- 
2.43.0


