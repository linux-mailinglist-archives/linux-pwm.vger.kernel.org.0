Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E5E46F67B
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Dec 2021 23:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhLIWMg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Dec 2021 17:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhLIWMg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Dec 2021 17:12:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0EC061746
        for <linux-pwm@vger.kernel.org>; Thu,  9 Dec 2021 14:09:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mvRb2-0002ev-28; Thu, 09 Dec 2021 23:09:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mvRb0-003f88-Po; Thu, 09 Dec 2021 23:08:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mvRaz-0005CT-NI; Thu, 09 Dec 2021 23:08:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: raspberrypi-poe: Drop assignment to struct pwmchip::base
Date:   Thu,  9 Dec 2021 23:08:51 +0100
Message-Id: <20211209220851.1319460-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=T6kNvz5eExhYsWyZ+Z1FZLp+VmOdQ/kJOKSnDO9lI7Q=; m=p4UjSZ2BZ3vnnbCAULKYsjtkeGl4spepTinBmMRWoqQ=; p=Q1bGOrxQqbiOYP55ReaeSGDcje+gITXBoZJIN3OHasw=; g=691c13966d1150672ccd0442b126d115ea5b4cf6
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGyfmoACgkQwfwUeK3K7AnqHAf7BgW nMKJhDrS5VElz73m6f/c/2U35RGFcyshUpBFyF96tGrWRPKKTQtI+AOPZuJMJGBHn6K3mbbCfJRdn /G81JryHuBe/XKZFyhmDV/cYwhM2L8ruCs6RtyhNb8c8C69qkancUcHWLPoEBblpAxuBV3nsE/yIF VstkM8BlxcRIzk+X+gHtSk2H8zcnp2gXrv592Sb6/Pkibwhog/80dE3XlrOZ4ashZRz+pTFmdu4Rh 7iJSLuugLegVgCAVAxDq5eOuR7hHLome/ROsI+ZdICnmbyjoyYDERfRoQ2exq9MUOHQAd1NQLcqjO VVX+QnEyqWj/wv1g20lasmETujHEuzQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit f9a8ee8c8bcd ("pwm: Always allocate PWM chip base ID
dynamically") there is no effect any more for assigning this variable.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-raspberrypi-poe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
index 579a15240e0a..e52e29fc8231 100644
--- a/drivers/pwm/pwm-raspberrypi-poe.c
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -163,7 +163,6 @@ static int raspberrypi_pwm_probe(struct platform_device *pdev)
 	rpipwm->firmware = firmware;
 	rpipwm->chip.dev = dev;
 	rpipwm->chip.ops = &raspberrypi_pwm_ops;
-	rpipwm->chip.base = -1;
 	rpipwm->chip.npwm = RASPBERRYPI_FIRMWARE_PWM_NUM;
 
 	ret = raspberrypi_pwm_get_property(rpipwm->firmware, RPI_PWM_CUR_DUTY_REG,
-- 
2.30.2

