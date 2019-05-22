Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6BD26860
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2019 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfEVQef (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 22 May 2019 12:34:35 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:41790 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbfEVQef (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 22 May 2019 12:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1558542873; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=iWtE607ygyephngrXoZlswDjPShkvMXmajkumWA4ytc=;
        b=I40kohTauhNL2B30AT1P9Ug4a/NaE5wADnGZ60YisnxmkGkNfC+9Dx6xCIvOCU1ZyozbLF
        X3SDY2ErWA4fFl/5/KgUrVVm2XaC1zKRDE5cjfqqod4x0QozBCD4QVE4BO/JnoIjOEY+/f
        cQ41nk0uQnrt9OnVFl/KdMtCERRL7zc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered down
Date:   Wed, 22 May 2019 18:34:28 +0200
Message-Id: <20190522163428.7078-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When the driver probes, the PWM pin is automatically configured to its
default state, which should be the "pwm" function. However, at this
point we don't know the actual level of the pin, which may be active or
inactive. As a result, if the driver probes without enabling the
backlight, the PWM pin might be active, and the backlight would be
lit way before being officially enabled.

To work around this, if the probe function doesn't enable the backlight,
the pin is set to its sleep state instead of the default one, until the
backlight is enabled. When the backlight is disabled, the pin is reset
to its sleep state.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/video/backlight/pwm_bl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index fb45f866b923..422f7903b382 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/fb.h>
 #include <linux/backlight.h>
@@ -50,6 +51,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 	struct pwm_state state;
 	int err;
 
+	pinctrl_pm_select_default_state(pb->dev);
+
 	pwm_get_state(pb->pwm, &state);
 	if (pb->enabled)
 		return;
@@ -90,6 +93,8 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
+
+	pinctrl_pm_select_sleep_state(pb->dev);
 }
 
 static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
@@ -626,6 +631,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	backlight_update_status(bl);
 
 	platform_set_drvdata(pdev, bl);
+
+	if (bl->props.power == FB_BLANK_POWERDOWN)
+		pinctrl_pm_select_sleep_state(&pdev->dev);
+
 	return 0;
 
 err_alloc:
-- 
2.21.0.593.g511ec345e18

