Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC877C72EF
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379603AbjJLQbk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379609AbjJLQbP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:15 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9DFCC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyab-0005hm-CE; Thu, 12 Oct 2023 18:31:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-001CA7-0y; Thu, 12 Oct 2023 18:31:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaY-00F5RN-O7; Thu, 12 Oct 2023 18:31:06 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 078/109] pwm: raspberrypi-poe: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:46 +0200
Message-ID: <20231012162827.1002444-189-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sfEL3M03e6p0Lt3K6pYjza6DR53uTwrg9PFe5yYmqwo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8IPKlh/kr7Be6TUdXp8D1nou/vBMWNRyA7Y 99TKIlAJ1+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfCAAKCRCPgPtYfRL+ Tmo8B/9XGPO9iU3o4hosA3h12tSRR6Aqei8R+3duNL2B345atpdgH9wfSLVr8Btqydotr3DmQqK reXQ5g5acSLngaFhbI8lZG6ZwmtELkRo/EUzWr/xZQQ/TsV3ah4h1uyOMif+vZ1Fal1aLMis9/h C9qrT5UggsOWyRAXYqX1HsfYvjjqEJRle7uTSw+4dZviHxhQ5jfSs9x9yeTczlfKToyNlIB4pZC lSx7F9TZdRDyRaeSwVip9wWdO70buWif5hZzzKfo288ngEmtBgBN5mOzOCbAyNy7XIIJJmHwD9C Ck0Yn5kh+7ZiWZUKnPfwbQEG7fFSO1iDq4HFV84847Ow2Qy9
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

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

