Return-Path: <linux-pwm+bounces-86-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E3C7F2FAC
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8561F24126
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0E537F6;
	Tue, 21 Nov 2023 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4612B10FE
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-00069P-0f; Tue, 21 Nov 2023 14:52:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAW-00Ab1C-Ll; Tue, 21 Nov 2023 14:52:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAW-004xfy-CW; Tue, 21 Nov 2023 14:52:00 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 077/108] pwm: raspberrypi-poe: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:19 +0100
Message-ID: <20231121134901.208535-78-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sfEL3M03e6p0Lt3K6pYjza6DR53uTwrg9PFe5yYmqwo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWhPKlh/kr7Be6TUdXp8D1nou/vBMWNRyA7Y 99TKIlAJ1+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1oQAKCRCPgPtYfRL+ TvK9CACtEU257/giVns5lZRmnElaI+NH6J3rYZKCTbTlALc3OTu0TC6g87TiqV7KJrVnBSNwdDN DibFSNTjdsFPybvDgbk7y3JDrAtV6gGPd2fzDrQJ/bEEa/tqzuK6Ov3yV5apcvEkzfJpQUKXknp nj+P8IMKN+CIa8YWnswfX7aHIakJdRD/+wNQXY7ilLg20GhTiNrh/j28RaFnX+dJHczjoVnyUhS IGZUQPMAVT9GzkRmyRJylo3kF4zlTOZ03JCYmFbrqunkLGwpMx3TjqGFlBbrH1TpcRXOdfQUZDT YDhKVPhE7JgS8cjY5rzxvwMsj0nvd1KcpJQqltPcYx6jNQ2P
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
index f10e8a624c51..5e5dd8d65e42 100644
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
+	return pwmchip_priv(chip);
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
2.42.0


