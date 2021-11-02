Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B58442A65
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Nov 2021 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhKBJat (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Nov 2021 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKBJas (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Nov 2021 05:30:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E00BC061764
        for <linux-pwm@vger.kernel.org>; Tue,  2 Nov 2021 02:28:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhq5T-000351-GW; Tue, 02 Nov 2021 10:28:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhq5O-0008TO-HY; Tue, 02 Nov 2021 10:28:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhq5O-0005Hj-Gf; Tue, 02 Nov 2021 10:28:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH 2/2] pwm: vt8500: Rename pwm_busy_wait() to make it obviously driver-specific
Date:   Tue,  2 Nov 2021 10:28:04 +0100
Message-Id: <20211102092804.296089-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102092804.296089-1-u.kleine-koenig@pengutronix.de>
References: <20211102092804.296089-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=RSm0G5TTKqzOP1s+jhGcVsSt6IapFECC90REsA+WAy8=; m=d6RErcUVDCcRec6zPTV53kL8mx/CF6lAzfW0cgFWiJ8=; p=0yKl+6DiUAx/PLFSZbL97vAoLsERfsHj3ScdmziqJlc=; g=6d9377b080ad10fe932a6d57a1f0d8ed8b949bba
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGBBKAACgkQwfwUeK3K7AlYfgf/eBI dfvYhuQe2WR1lU2V69vae89IUvGnqJ1Eh1Jyf6/hFpu5cTbziopfpWgp36XKHQeWQL71UeTDBFX3y ae9uSw6pn2h+mamDpBi+/OdeD8HaFpE/4qoELASeV2s21s1A2cjikpx0g1sRLqGOd9243CX0W9Ax7 vlph3AzFOQZeta7bMQi6PzZPyjhUK7a3cU3Vb3zmSCIftFEZKyfyCdcbSmB10oCKFUJCgy92cRuwC 4wD1HFbYyLjJLnPDbEI44r6j3Vgf/oO0riZxw8hOLbvsBXvD1PKeJdUZ4G6FENDdA7SRXUCfdHBIB ZYpLsZ1deMTKUbl0nR2KTbYPl7wQrAA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pwm_ prefix suggests that pwm_busy_wait() is a function provided by
the pwm core. Use the otherwise consistently used driver prefix for this
function, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 3203ec1b0d24..7170a315535b 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -56,7 +56,7 @@ struct vt8500_chip {
 #define to_vt8500_chip(chip)	container_of(chip, struct vt8500_chip, chip)
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
-static inline void pwm_busy_wait(struct vt8500_chip *vt8500, int nr, u8 bitmask)
+static inline void vt8500_pwm_busy_wait(struct vt8500_chip *vt8500, int nr, u8 bitmask)
 {
 	int loops = msecs_to_loops(10);
 	u32 mask = bitmask << (nr << 8);
@@ -106,18 +106,18 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	dc = div64_u64(c, period_ns);
 
 	writel(prescale, vt8500->base + REG_SCALAR(pwm->hwpwm));
-	pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_SCALAR_UPDATE);
+	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_SCALAR_UPDATE);
 
 	writel(pv, vt8500->base + REG_PERIOD(pwm->hwpwm));
-	pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_PERIOD_UPDATE);
+	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_PERIOD_UPDATE);
 
 	writel(dc, vt8500->base + REG_DUTY(pwm->hwpwm));
-	pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_DUTY_UPDATE);
+	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_DUTY_UPDATE);
 
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 	val |= CTRL_AUTOLOAD;
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	clk_disable(vt8500->clk);
 	return 0;
@@ -138,7 +138,7 @@ static int vt8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 	val |= CTRL_ENABLE;
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	return 0;
 }
@@ -151,7 +151,7 @@ static void vt8500_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val = readl(vt8500->base + REG_CTRL(pwm->hwpwm));
 	val &= ~CTRL_ENABLE;
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	clk_disable(vt8500->clk);
 }
@@ -171,7 +171,7 @@ static int vt8500_pwm_set_polarity(struct pwm_chip *chip,
 		val &= ~CTRL_INVERT;
 
 	writel(val, vt8500->base + REG_CTRL(pwm->hwpwm));
-	pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
+	vt8500_pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_CTRL_UPDATE);
 
 	return 0;
 }
-- 
2.30.2

