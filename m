Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB77AEF56
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Sep 2023 17:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjIZPBa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Sep 2023 11:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjIZPB3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Sep 2023 11:01:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6496611D
        for <linux-pwm@vger.kernel.org>; Tue, 26 Sep 2023 08:01:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql9Yt-0008Ns-FK; Tue, 26 Sep 2023 17:01:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql9Ys-009883-5s; Tue, 26 Sep 2023 17:01:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql9Yr-004zRC-Sn; Tue, 26 Sep 2023 17:01:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: [PATCH v3] backlight: pwm_bl: Disable PWM on shutdown and suspend
Date:   Tue, 26 Sep 2023 17:01:16 +0200
Message-Id: <20230926150116.2124384-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3373; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=61FP9G4E8M9F1pTU3wuzp0u70AjlycxIrURHR3QM++A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlEvI7fKNBv6WMI58kdVa/QJNJIswdnYz9HDjvW tYOgyJzHGqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRLyOwAKCRCPgPtYfRL+ TsHMCACY/dDub8/nxtStdqOoD5+FVknnQRRC/OVkjMROReL5w0mRNZfZlwSQjiDmaT1M278Bn9E fLCddz5oyxegjFJOhVwF6Yxykfct6HKMG3bUZePVS0z/wlJ0ncuAJ2dc1EK9l5XNpH7SoF5HoSa lLGwS7aUcnaZh+ueKtWVsJrGwtT3ldeddIwnZq+bbHzyQGD3g/DN9JnAaKnpKw2EDtN2tTbtdh4 ZQv4K7DsOKqT4XS55EFrsVvnG+tSU5G9au+kjxDPsvrEFT5xPhqn8B2Y4oqWeRftN0tMoKLwOfl COQj9T89QKgnwHzZb4MdAiE+oISw5CccM+Whma2peneA4QIP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once
per backlight toggle") calling pwm_backlight_power_off() doesn't disable
the PWM any more. However this is necessary to suspend because PWM
drivers usually refuse to suspend if they are still enabled.

Also adapt shutdown and remove callbacks to disable the PWM for similar
reasons.

Fixes: 00e7e698bff1 ("backlight: pwm_bl: Configure pwm only once per backlight toggle")
Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
Tested-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

On Tue, Sep 26, 2023 at 12:11:37PM +0100, Daniel Thompson wrote:
> Changes proposed look good (and the comment about badly designed boards
> going to HiZ state we super helpful).

I didn't mention Hi-Z and note that disabling a PWM can even result in
the hardware driving to the active level. (This can happen for example
for pwm-mxs and pwm-imx27.)

> Only thing from my is why there is no attempt to disable the PWM
> from the .remove_new() callback.

Good catch, good I didn't manage to send out a v3 for the email address
fix yet :-) So here comes a v3 with two improvments:

Changes since v2
(https://lore.kernel.org/dri-devel/20230926084612.2074692-1-u.kleine-koenig@pengutronix.de):

 - Fix Aisheng Dong's email address
 - also disable PWM in .remove and adapt commit log accordingly (Thanks
   to Daniel Thompson for spotting that).

 drivers/video/backlight/pwm_bl.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index a51fbab96368..390398ae07b9 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -629,6 +629,10 @@ static void pwm_backlight_remove(struct platform_device *pdev)
 
 	backlight_device_unregister(bl);
 	pwm_backlight_power_off(pb);
+	pwm_get_state(pb->pwm, &state);
+	state.duty_cycle = 0;
+	state.enabled = false;
+	pwm_apply_state(pb->pwm, &state);
 
 	if (pb->exit)
 		pb->exit(&pdev->dev);
@@ -638,8 +642,13 @@ static void pwm_backlight_shutdown(struct platform_device *pdev)
 {
 	struct backlight_device *bl = platform_get_drvdata(pdev);
 	struct pwm_bl_data *pb = bl_get_data(bl);
+	struct pwm_state state;
 
 	pwm_backlight_power_off(pb);
+	pwm_get_state(pb->pwm, &state);
+	state.duty_cycle = 0;
+	state.enabled = false;
+	pwm_apply_state(pb->pwm, &state);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -647,12 +656,24 @@ static int pwm_backlight_suspend(struct device *dev)
 {
 	struct backlight_device *bl = dev_get_drvdata(dev);
 	struct pwm_bl_data *pb = bl_get_data(bl);
+	struct pwm_state state;
 
 	if (pb->notify)
 		pb->notify(pb->dev, 0);
 
 	pwm_backlight_power_off(pb);
 
+	/*
+	 * Note that disabling the PWM doesn't guarantee that the output stays
+	 * at its inactive state. However without the PWM disabled, the PWM
+	 * driver refuses to suspend. So disable here even though this might
+	 * enable the backlight on poorly designed boards.
+	 */
+	pwm_get_state(pb->pwm, &state);
+	state.duty_cycle = 0;
+	state.enabled = false;
+	pwm_apply_state(pb->pwm, &state);
+
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, 0);
 

base-commit: 8fff9184d1b5810dca5dd1a02726d4f844af88fc
-- 
2.40.1

