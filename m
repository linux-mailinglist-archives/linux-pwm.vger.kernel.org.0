Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E333BEC25
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhGGQb1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhGGQb1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A5C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APl-00041H-Ci; Wed, 07 Jul 2021 18:28:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APk-0002bp-Rx; Wed, 07 Jul 2021 18:28:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APk-0006Ix-RC; Wed, 07 Jul 2021 18:28:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 27/47] pwm: raspberrypi-poe: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:15 +0200
Message-Id: <20210707162835.1772882-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
References: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This allows to drop the platform_driver's remove function. This is the
only user of driver data so this can go away, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-raspberrypi-poe.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index 043fc32e8be8..579a15240e0a 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -166,8 +166,6 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 	rpipwm->chip.base = -1;
 	rpipwm->chip.npwm = RASPBERRYPI_FIRMWARE_PWM_NUM;
 
-	platform_set_drvdata(pdev, rpipwm);
-
 	ret = raspberrypi_pwm_get_property(rpipwm->firmware, RPI_PWM_CUR_DUTY_REG,
 					   &rpipwm->duty_cycle);
 	if (ret) {
@@ -175,14 +173,7 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return pwmchip_add(&rpipwm->chip);
-}
-
-static int raspberrypi_pwm_remove(struct platform_device *pdev)
-{
-	struct raspberrypi_pwm *rpipwm = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&rpipwm->chip);
+	return devm_pwmchip_add(dev, &rpipwm->chip);
 }
 
 static const struct of_device_id raspberrypi_pwm_of_match[] = {
@@ -197,7 +188,6 @@ static struct platform_driver raspberrypi_pwm_driver = {
 		.of_match_table = raspberrypi_pwm_of_match,
 	},
 	.probe = raspberrypi_pwm_probe,
-	.remove = raspberrypi_pwm_remove,
 };
 module_platform_driver(raspberrypi_pwm_driver);
 
-- 
2.30.2

