Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E639348B91
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Mar 2021 09:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCYIaL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 25 Mar 2021 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCYI3k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 25 Mar 2021 04:29:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BF3C06174A
        for <linux-pwm@vger.kernel.org>; Thu, 25 Mar 2021 01:29:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPLN0-0001Eh-6y; Thu, 25 Mar 2021 09:29:34 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPLMz-0007BD-3i; Thu, 25 Mar 2021 09:29:33 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH] pwm: bcm2835: Free resources only after pwmchip_remove()
Date:   Thu, 25 Mar 2021 09:29:31 +0100
Message-Id: <20210325082931.81774-1-u.kleine-koenig@pengutronix.de>
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

Before pwmchip_remove() returns the PWM is expected to be functional. So
remove the pwmchip before disabling the clock.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index e4b54675b356..fc240d5b8121 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -179,9 +179,11 @@ static int bcm2835_pwm_remove(struct platform_device *pdev)
 {
 	struct bcm2835_pwm *pc = platform_get_drvdata(pdev);
 
+	pwmchip_remove(&pc->chip);
+
 	clk_disable_unprepare(pc->clk);
 
-	return pwmchip_remove(&pc->chip);
+	return 0;
 }
 
 static const struct of_device_id bcm2835_pwm_of_match[] = {
-- 
2.30.2

