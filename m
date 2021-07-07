Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67EB3BECE7
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhGGRUf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 13:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhGGRUe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 13:20:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E5C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 10:17:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1BBI-0002Jx-Az; Wed, 07 Jul 2021 19:17:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1AkP-0002f6-Q9; Wed, 07 Jul 2021 18:50:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APk-0006Il-4U; Wed, 07 Jul 2021 18:28:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 23/47] pwm: mediatek: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:11 +0200
Message-Id: <20210707162835.1772882-24-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-mediatek.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index b4a31060bcd7..0d4dd80e9f07 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -253,13 +253,11 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		}
 	}
 
-	platform_set_drvdata(pdev, pc);
-
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &pwm_mediatek_ops;
 	pc->chip.npwm = pc->soc->num_pwms;
 
-	ret = pwmchip_add(&pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		return ret;
@@ -268,13 +266,6 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pwm_mediatek_remove(struct platform_device *pdev)
-{
-	struct pwm_mediatek_chip *pc = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&pc->chip);
-}
-
 static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
@@ -335,7 +326,6 @@ static struct platform_driver pwm_mediatek_driver = {
 		.of_match_table = pwm_mediatek_of_match,
 	},
 	.probe = pwm_mediatek_probe,
-	.remove = pwm_mediatek_remove,
 };
 module_platform_driver(pwm_mediatek_driver);
 
-- 
2.30.2

