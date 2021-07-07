Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357133BECE9
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 19:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhGGRUh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhGGRUg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 13:20:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30572C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 10:17:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1BBK-0002N7-5w; Wed, 07 Jul 2021 19:17:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1AkP-0002f6-TS; Wed, 07 Jul 2021 18:50:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APi-0006II-VM; Wed, 07 Jul 2021 18:28:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 15/47] pwm: fsl-ftm: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:03 +0200
Message-Id: <20210707162835.1772882-16-u.kleine-koenig@pengutronix.de>
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

This allows to drop the platform_driver's remove function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 96ccd772280c..0247757f9a72 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -453,7 +453,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->chip.ops = &fsl_pwm_ops;
 	fpc->chip.npwm = 8;
 
-	ret = pwmchip_add(&fpc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &fpc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 		return ret;
@@ -464,13 +464,6 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	return fsl_pwm_init(fpc);
 }
 
-static int fsl_pwm_remove(struct platform_device *pdev)
-{
-	struct fsl_pwm_chip *fpc = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&fpc->chip);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int fsl_pwm_suspend(struct device *dev)
 {
@@ -552,7 +545,6 @@ static struct platform_driver fsl_pwm_driver = {
 		.pm = &fsl_pwm_pm_ops,
 	},
 	.probe = fsl_pwm_probe,
-	.remove = fsl_pwm_remove,
 };
 module_platform_driver(fsl_pwm_driver);
 
-- 
2.30.2

