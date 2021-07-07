Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE023BECE8
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhGGRUg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 13:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhGGRUg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 13:20:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F88C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 10:17:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1BBJ-0002KP-Hd; Wed, 07 Jul 2021 19:17:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1AkP-0002f6-Rc; Wed, 07 Jul 2021 18:50:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APj-0006IR-D7; Wed, 07 Jul 2021 18:28:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 18/47] pwm: iqs620a: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:06 +0200
Message-Id: <20210707162835.1772882-19-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-iqs620a.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 6c6e26d18329..54bd95a5cab0 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -189,7 +189,6 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 	if (!iqs620_pwm)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, iqs620_pwm);
 	iqs620_pwm->iqs62x = iqs62x;
 
 	ret = regmap_read(iqs62x->regmap, IQS620_PWR_SETTINGS, &val);
@@ -224,31 +223,18 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = pwmchip_add(&iqs620_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &iqs620_pwm->chip);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to add device: %d\n", ret);
 
 	return ret;
 }
 
-static int iqs620_pwm_remove(struct platform_device *pdev)
-{
-	struct iqs620_pwm_private *iqs620_pwm = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = pwmchip_remove(&iqs620_pwm->chip);
-	if (ret)
-		dev_err(&pdev->dev, "Failed to remove device: %d\n", ret);
-
-	return ret;
-}
-
 static struct platform_driver iqs620_pwm_platform_driver = {
 	.driver = {
 		.name = "iqs620a-pwm",
 	},
 	.probe = iqs620_pwm_probe,
-	.remove = iqs620_pwm_remove,
 };
 module_platform_driver(iqs620_pwm_platform_driver);
 
-- 
2.30.2

