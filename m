Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA17BD714
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Oct 2023 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbjJIJch (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Oct 2023 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345449AbjJIJcg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Oct 2023 05:32:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528CD94
        for <linux-pwm@vger.kernel.org>; Mon,  9 Oct 2023 02:32:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmcq-0008RZ-Jd; Mon, 09 Oct 2023 11:32:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmco-000NZy-UD; Mon, 09 Oct 2023 11:32:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmco-00C59f-Kj; Mon, 09 Oct 2023 11:32:30 +0200
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
Subject: [PATCH v4] backlight: pwm_bl: Disable PWM on shutdown, suspend and remove
Date:   Mon,  9 Oct 2023 11:32:23 +0200
Message-Id: <20231009093223.227286-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ukp03GXhJGGhriRo81oTqb+ZF09mBJI1HDBsdlZDDEw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlI8imhPFLFc7G9DQzsmEVrBtK7ni6oOsoVVU0d du0W4DICtGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSPIpgAKCRCPgPtYfRL+ TpelB/9veiKkWgBLSFdRf8C/mZU536ZliA4SH6xEfVnniFW/RGorUdbDglV1YQkTaUbtOb6EwCT WKwjQ0OCOnwbxoL6cxSDcUKVgLnHh9wOFP4dnnosQ3thzE83HFaiCLJLNLvWWHzsQIQOTisdCIM FGESqKYG9TSdjVfI/Y8mQo2jTmwP1IdFUFfrU1P0GYum55T8xK8peNaSK1fP6T9/lDIlO6CfeOo 1tjTEGqLjX49b1xNgegMOHzAfkeMg0EETle7IAeCSy9E+x5ajTvgbaBASBH4weevYfseX2h7UR8 uEW0PNIhm4irmPEbl9vEaBh8NUQ6nYUD3/+l3mjsy7kedtKc
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

Changes since v3 (available at
https://lore.kernel.org/linux-fbdev/20230926150116.2124384-1-u.kleine-koenig@pengutronix.de):

 - Fix buildfailure identified by the kernel test robot. (*Sigh*, that's
   what you get if you improve a patch without build testing ...)
 - Fix the Subject to also mention "remove".

Best regards
Uwe

 drivers/video/backlight/pwm_bl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index a51fbab96368..289bd9ce4d36 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -626,9 +626,14 @@ static void pwm_backlight_remove(struct platform_device *pdev)
 {
 	struct backlight_device *bl = platform_get_drvdata(pdev);
 	struct pwm_bl_data *pb = bl_get_data(bl);
+	struct pwm_state state;
 
 	backlight_device_unregister(bl);
 	pwm_backlight_power_off(pb);
+	pwm_get_state(pb->pwm, &state);
+	state.duty_cycle = 0;
+	state.enabled = false;
+	pwm_apply_state(pb->pwm, &state);
 
 	if (pb->exit)
 		pb->exit(&pdev->dev);
@@ -638,8 +643,13 @@ static void pwm_backlight_shutdown(struct platform_device *pdev)
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
@@ -647,12 +657,24 @@ static int pwm_backlight_suspend(struct device *dev)
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
 

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

