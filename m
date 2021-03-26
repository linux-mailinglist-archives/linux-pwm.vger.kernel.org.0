Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1010634A317
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Mar 2021 09:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCZISw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Mar 2021 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhCZIST (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Mar 2021 04:18:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51972C0613AA
        for <linux-pwm@vger.kernel.org>; Fri, 26 Mar 2021 01:18:18 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPhfb-0006t3-97; Fri, 26 Mar 2021 09:18:15 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPhfY-0000fr-TF; Fri, 26 Mar 2021 09:18:12 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: bcm-kona: Don't modify HW state in .remove callback
Date:   Fri, 26 Mar 2021 09:18:04 +0100
Message-Id: <20210326081804.117843-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

A consumer is expected to disable a PWM before calling pwm_put(). And if
they didn't there is hopefully a good reason (or the consumer needs
fixing.) Also if disabling an enabled PWM was the right thing to do, this
should better be done in the framework instead of in each low level driver.

So drop the hardware modification from the .remove() callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index f09a31042859..800b9edf2e71 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -310,11 +310,6 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 static int kona_pwmc_remove(struct platform_device *pdev)
 {
 	struct kona_pwmc *kp = platform_get_drvdata(pdev);
-	unsigned int chan;
-
-	for (chan = 0; chan < kp->chip.npwm; chan++)
-		if (pwm_is_enabled(&kp->chip.pwms[chan]))
-			clk_disable_unprepare(kp->clk);
 
 	return pwmchip_remove(&kp->chip);
 }
-- 
2.30.2

