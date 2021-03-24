Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B5A348243
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Mar 2021 20:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhCXT5R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Mar 2021 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhCXT4x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Mar 2021 15:56:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C68C061763
        for <linux-pwm@vger.kernel.org>; Wed, 24 Mar 2021 12:56:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP9cM-0007KS-Kz; Wed, 24 Mar 2021 20:56:38 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP9cK-0007Sk-Ky; Wed, 24 Mar 2021 20:56:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: atmel: Free resources only after pwmchip_remove()
Date:   Wed, 24 Mar 2021 20:56:35 +0100
Message-Id: <20210324195635.75037-1-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-atmel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index a4d0be6b265b..d49da708337f 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -450,10 +450,12 @@ static int atmel_pwm_remove(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm = platform_get_drvdata(pdev);
 
+	pwmchip_remove(&atmel_pwm->chip);
+
 	clk_unprepare(atmel_pwm->clk);
 	mutex_destroy(&atmel_pwm->isr_lock);
 
-	return pwmchip_remove(&atmel_pwm->chip);
+	return 0;
 }
 
 static struct platform_driver atmel_pwm_driver = {
-- 
2.30.2

