Return-Path: <linux-pwm+bounces-382-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB73C806EB2
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6281C20CF6
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAE934561;
	Wed,  6 Dec 2023 11:48:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB4CD67
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOL-0007Dy-EI; Wed, 06 Dec 2023 12:48:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-00DwwT-A4; Wed, 06 Dec 2023 12:48:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-00FR1y-0i; Wed, 06 Dec 2023 12:48:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 083/115] pwm: raspberrypi-poe: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:37 +0100
Message-ID:  <11b3a9ab42ae302071dcab5eb0bba70174c8efc6.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1b5jylgXzzbhPkT3S3eOltYdW6gKQYJ2VGue01OM6e4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8HtBHNG2G1BJCEFiaGtOXyYMq/UBZ/IVgqx gARsAR6KjCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfBwAKCRCPgPtYfRL+ TvvLB/9aQvcl0oW4cd7cwUdM71Scjg4tIhcm1+tWOKCIlU/7Ennd/kWWzml6Q3wxvDl5QCmBZVq H13xxXfYFvDYA0OGX0e9uiYr6gbMoVb0oxhfbGxZ1R/rz7Niy4cGIyBjbGzUxFnJV/KAPYdqTAx gqBfAJu20FzBmB0P3gvVYI634yryXuiMJuk+YjIri9EFrGcjULUVFkQTVi6YFUiZPNqMrroZfAa gOZHtSMyVFDmM+BtTTu2aw6w/N3bO0fF3PE1jZ0ech4rcWZ5uBKA7UVpauUotYnk+8+H6vJ0oOk T2pCw9PfBQWuwKDxMcm7VXH8yDmimP1u2iavSZfNL4wGSx5S
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
2.42.0


