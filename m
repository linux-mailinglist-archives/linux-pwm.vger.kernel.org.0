Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93563330A95
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Mar 2021 10:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCHJwe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Mar 2021 04:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhCHJwF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Mar 2021 04:52:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13689C06174A
        for <linux-pwm@vger.kernel.org>; Mon,  8 Mar 2021 01:52:05 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJCYS-0001zw-4C; Mon, 08 Mar 2021 10:52:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJCYR-0002GX-FE; Mon, 08 Mar 2021 10:51:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: atmel-tcb: Only free resources after pwm_chip_remove() returned
Date:   Mon,  8 Mar 2021 10:51:50 +0100
Message-Id: <20210308095150.26774-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
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

Otherwise the PWM stops working before the PWM core and its consumers
are aware the device is going away.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 4d2253f3048c..8451d3e846be 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -507,14 +507,14 @@ static int atmel_tcb_pwm_remove(struct platform_device *pdev)
 	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
 	int err;
 
-	clk_disable_unprepare(tcbpwm->slow_clk);
-	clk_put(tcbpwm->slow_clk);
-	clk_put(tcbpwm->clk);
-
 	err = pwmchip_remove(&tcbpwm->chip);
 	if (err < 0)
 		return err;
 
+	clk_disable_unprepare(tcbpwm->slow_clk);
+	clk_put(tcbpwm->slow_clk);
+	clk_put(tcbpwm->clk);
+
 	return 0;
 }
 
-- 
2.30.1

