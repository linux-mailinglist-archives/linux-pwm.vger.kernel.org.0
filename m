Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E563BEC24
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhGGQb1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhGGQb0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B218C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APk-0003wU-FQ; Wed, 07 Jul 2021 18:28:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APj-0002bh-SI; Wed, 07 Jul 2021 18:28:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APj-0006Ia-RY; Wed, 07 Jul 2021 18:28:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 21/47] pwm: lp3943: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:09 +0200
Message-Id: <20210707162835.1772882-22-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-lp3943.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 7551253ada32..ea17d446a627 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -276,16 +276,7 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 	lp3943_pwm->chip.ops = &lp3943_pwm_ops;
 	lp3943_pwm->chip.npwm = LP3943_NUM_PWMS;
 
-	platform_set_drvdata(pdev, lp3943_pwm);
-
-	return pwmchip_add(&lp3943_pwm->chip);
-}
-
-static int lp3943_pwm_remove(struct platform_device *pdev)
-{
-	struct lp3943_pwm *lp3943_pwm = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&lp3943_pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, &lp3943_pwm->chip);
 }
 
 #ifdef CONFIG_OF
@@ -298,7 +289,6 @@ MODULE_DEVICE_TABLE(of, lp3943_pwm_of_match);
 
 static struct platform_driver lp3943_pwm_driver = {
 	.probe = lp3943_pwm_probe,
-	.remove = lp3943_pwm_remove,
 	.driver = {
 		.name = "lp3943-pwm",
 		.of_match_table = of_match_ptr(lp3943_pwm_of_match),
-- 
2.30.2

