Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EB3BEC2D
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhGGQbg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGGQbf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AE8C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APt-0004NH-Cp; Wed, 07 Jul 2021 18:28:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APs-0002cr-SC; Wed, 07 Jul 2021 18:28:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APl-0006JH-JV; Wed, 07 Jul 2021 18:28:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 32/47] pwm: twl: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:20 +0200
Message-Id: <20210707162835.1772882-33-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-twl.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index e83a826bf621..203194f2c92e 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -298,7 +298,6 @@ static const struct pwm_ops twl6030_pwm_ops = {
 static int twl_pwm_probe(struct platform_device *pdev)
 {
 	struct twl_pwm_chip *twl;
-	int ret;
 
 	twl = devm_kzalloc(&pdev->dev, sizeof(*twl), GFP_KERNEL);
 	if (!twl)
@@ -314,20 +313,7 @@ static int twl_pwm_probe(struct platform_device *pdev)
 
 	mutex_init(&twl->mutex);
 
-	ret = pwmchip_add(&twl->chip);
-	if (ret < 0)
-		return ret;
-
-	platform_set_drvdata(pdev, twl);
-
-	return 0;
-}
-
-static int twl_pwm_remove(struct platform_device *pdev)
-{
-	struct twl_pwm_chip *twl = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&twl->chip);
+	return devm_pwmchip_add(&pdev->dev, &twl->chip);
 }
 
 #ifdef CONFIG_OF
@@ -345,7 +331,6 @@ static struct platform_driver twl_pwm_driver = {
 		.of_match_table = of_match_ptr(twl_pwm_of_match),
 	},
 	.probe = twl_pwm_probe,
-	.remove = twl_pwm_remove,
 };
 module_platform_driver(twl_pwm_driver);
 
-- 
2.30.2

