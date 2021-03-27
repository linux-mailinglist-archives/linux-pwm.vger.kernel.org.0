Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F84234B97D
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Mar 2021 22:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhC0VYv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Mar 2021 17:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhC0VYf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Mar 2021 17:24:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5AC0613B1
        for <linux-pwm@vger.kernel.org>; Sat, 27 Mar 2021 14:24:35 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQGQ5-0002Qo-BX; Sat, 27 Mar 2021 22:24:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQGQ3-0005m8-CA; Sat, 27 Mar 2021 22:24:31 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: lpc18xx-sct: Free resources only after pwmchip_remove()
Date:   Sat, 27 Mar 2021 22:24:28 +0100
Message-Id: <20210327212428.136684-1-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-lpc18xx-sct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 3f8e54ec28c6..b643ac61a2e7 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -441,13 +441,15 @@ static int lpc18xx_pwm_remove(struct platform_device *pdev)
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = platform_get_drvdata(pdev);
 	u32 val;
 
+	pwmchip_remove(&lpc18xx_pwm->chip);
+
 	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL,
 			   val | LPC18XX_PWM_CTRL_HALT);
 
 	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
 
-	return pwmchip_remove(&lpc18xx_pwm->chip);
+	return 0;
 }
 
 static struct platform_driver lpc18xx_pwm_driver = {
-- 
2.30.2

