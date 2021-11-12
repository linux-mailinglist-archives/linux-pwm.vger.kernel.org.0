Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2EE44ECFE
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Nov 2021 20:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhKLTDS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Nov 2021 14:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhKLTDR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Nov 2021 14:03:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF57C061766
        for <linux-pwm@vger.kernel.org>; Fri, 12 Nov 2021 11:00:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlbmi-0002v1-7c; Fri, 12 Nov 2021 20:00:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlbmf-0009wC-8x; Fri, 12 Nov 2021 20:00:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mlbme-0002OY-6e; Fri, 12 Nov 2021 20:00:20 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Zou Wei <zou_wei@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] pwm: img: Use only a single idiom to get a pm_runtime reference
Date:   Fri, 12 Nov 2021 20:00:15 +0100
Message-Id: <20211112190015.1141825-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=rxU++YmI7oCBQVebUN1oxgyCVTezraG+Yo6pb/kEAx8=; m=YKjbo0Z8fLd16srxNE1eJhVLIRY793VrxgDUsqKYgh0=; p=RyYxEV/3fcM+sbgByMhnYlJXDJnXwL62VsrF8CFt2KM=; g=2e54acdee79653376afa4227836f9704b51089fb
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGOubsACgkQwfwUeK3K7AlVfgf9Erm vbnpcfaouVBMjxUUlukAEXFBOddqYt4wljwMuiqCkJF3olEVDbs7ngmnkj11oTnUjVRZ3BoHaVFog aXIDzHlQLTI/YMNrKZI1WQ4ycbc6VzDGT8k46r9f9o1gsdtQeJD6Bg89gw7ijZBRA2SoOiwtozM0s zbj78OQoCB8mLCnqksfea9yLjaI3yeWoryMtor6ch3sKZw+0MFsStcdHFtUpnZF4VPyvdRialb5UR Yh5zI6lhz/ln4CbNf89i/fE3Ga62c7EJNS+muMO3A32zp4RkxSKdL6jmUymgvjtdqTRQ0c1PrNWja EuaGbi4MTCu6SMRixvTam5CBnjlYUdA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Currently there are two very similar approaches in use by this driver:
img_pwm_config() uses pm_runtime_get_sync() and calls
pm_runtime_put_autosuspend() in the error path; img_pwm_enable() calls
pm_runtime_resume_and_get() which already puts the reference in its own
error path.

Align pm_runtime usage and use the same idiom in both locations.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I asked to use the same idiom in both locations in a review feedback for
the patch that became fde25294dfd8 ("pwm: img: Fix PM reference leak in
img_pwm_enable()"). The patch was however picked up without addressing
this. See
https://lore.kernel.org/linux-pwm/20210512045222.2yjm6yxikznohlmn@pengutronix.de
for the details.

So here is a follow-up that aligns the two functions.

Best regards
Uwe

 drivers/pwm/pwm-img.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index f97f82548293..51fc6016f833 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -128,11 +128,9 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
-	ret = pm_runtime_get_sync(chip->dev);
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(chip->dev);
+	ret = pm_runtime_resume_and_get(chip->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
 	val &= ~(PWM_CTRL_CFG_DIV_MASK << PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));

base-commit: 5833291ab6de9c3e2374336b51c814e515e8f3a5
-- 
2.30.2

