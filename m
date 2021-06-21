Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7429A3AE9A8
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Jun 2021 15:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFUNH0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Jun 2021 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFUNH0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Jun 2021 09:07:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F1C061756
        for <linux-pwm@vger.kernel.org>; Mon, 21 Jun 2021 06:05:11 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvJbx-0002V3-KM; Mon, 21 Jun 2021 15:05:09 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lvJbr-00086W-FK; Mon, 21 Jun 2021 15:05:03 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Tony Prisk <linux@prisktech.co.nz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: vt8500: Only unprepare the clock after the pwmchip was removed
Date:   Mon, 21 Jun 2021 15:04:58 +0200
Message-Id: <20210621130458.118530-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621130458.118530-1-u.kleine-koenig@pengutronix.de>
References: <20210621130458.118530-1-u.kleine-koenig@pengutronix.de>
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

Until pwmchip_remove() returns the PWM is supposed to work, so
pwmchip_remove() must be called before the clock is stopped.

The return value of pwmchip_remove doesn't need to be checked because
it returns zero anyhow and I plan to make it return void soon.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 7164df2fbacf..ea2aa151080a 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -240,10 +240,11 @@ static int vt8500_pwm_remove(struct platform_device *pdev)
 {
 	struct vt8500_chip *chip = platform_get_drvdata(pdev);
 
+	pwmchip_remove(&chip->chip);
 
 	clk_unprepare(chip->clk);
 
-	return pwmchip_remove(&chip->chip);
+	return 0;
 }
 
 static struct platform_driver vt8500_pwm_driver = {
-- 
2.30.2

