Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0267D3BECED
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGGRUk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhGGRUj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 13:20:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2456C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 10:17:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1BBM-0002Rw-J1; Wed, 07 Jul 2021 19:17:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1AkP-0002f6-Qw; Wed, 07 Jul 2021 18:50:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APj-0006Ii-WE; Wed, 07 Jul 2021 18:28:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 22/47] pwm: lpc32xx: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:10 +0200
Message-Id: <20210707162835.1772882-23-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-lpc32xx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 719e8e913656..ddeab5687cb8 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -122,24 +122,15 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	val &= ~PWM_PIN_LEVEL;
 	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
 
-	ret = pwmchip_add(&lpc32xx->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &lpc32xx->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip, error %d\n", ret);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, lpc32xx);
-
 	return 0;
 }
 
-static int lpc32xx_pwm_remove(struct platform_device *pdev)
-{
-	struct lpc32xx_pwm_chip *lpc32xx = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&lpc32xx->chip);
-}
-
 static const struct of_device_id lpc32xx_pwm_dt_ids[] = {
 	{ .compatible = "nxp,lpc3220-pwm", },
 	{ /* sentinel */ }
@@ -152,7 +143,6 @@ static struct platform_driver lpc32xx_pwm_driver = {
 		.of_match_table = lpc32xx_pwm_dt_ids,
 	},
 	.probe = lpc32xx_pwm_probe,
-	.remove = lpc32xx_pwm_remove,
 };
 module_platform_driver(lpc32xx_pwm_driver);
 
-- 
2.30.2

