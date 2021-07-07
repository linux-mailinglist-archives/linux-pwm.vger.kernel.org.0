Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9F3BEC2A
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGGQbc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhGGQbc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB87C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APq-0004DN-AI; Wed, 07 Jul 2021 18:28:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APp-0002cT-Pv; Wed, 07 Jul 2021 18:28:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APi-0006I7-MJ; Wed, 07 Jul 2021 18:28:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 13/47] pwm: bcm-kona: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:01 +0200
Message-Id: <20210707162835.1772882-14-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-bcm-kona.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 8c85c66ea5c9..64148f5f81d0 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -267,8 +267,6 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	if (kp == NULL)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, kp);
-
 	kp->chip.dev = &pdev->dev;
 	kp->chip.ops = &kona_pwm_ops;
 	kp->chip.npwm = 6;
@@ -298,20 +296,13 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 
 	clk_disable_unprepare(kp->clk);
 
-	ret = pwmchip_add(&kp->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &kp->chip);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 
 	return ret;
 }
 
-static int kona_pwmc_remove(struct platform_device *pdev)
-{
-	struct kona_pwmc *kp = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&kp->chip);
-}
-
 static const struct of_device_id bcm_kona_pwmc_dt[] = {
 	{ .compatible = "brcm,kona-pwm" },
 	{ },
@@ -324,7 +315,6 @@ static struct platform_driver kona_pwmc_driver = {
 		.of_match_table = bcm_kona_pwmc_dt,
 	},
 	.probe = kona_pwmc_probe,
-	.remove = kona_pwmc_remove,
 };
 module_platform_driver(kona_pwmc_driver);
 
-- 
2.30.2

