Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54434341A08
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Mar 2021 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCSK33 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Mar 2021 06:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCSK3G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Mar 2021 06:29:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CFC061763
        for <linux-pwm@vger.kernel.org>; Fri, 19 Mar 2021 03:29:05 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNL-0003l4-Bi; Fri, 19 Mar 2021 11:29:03 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNK-0001h3-7t; Fri, 19 Mar 2021 11:29:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/14] pwm: atmel-tcb: Only free resources after pwm_chip_remove() returned
Date:   Fri, 19 Mar 2021 11:28:49 +0100
Message-Id: <20210319102852.101209-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
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

Link: https://lore.kernel.org/r/20210308095150.26774-1-u.kleine-koenig@pengutronix.de
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

