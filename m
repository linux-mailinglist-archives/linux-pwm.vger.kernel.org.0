Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCADF70ED46
	for <lists+linux-pwm@lfdr.de>; Wed, 24 May 2023 07:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjEXFqN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 24 May 2023 01:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbjEXFqM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 May 2023 01:46:12 -0400
X-Greylist: delayed 896 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 22:46:11 PDT
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de [80.67.31.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD8418B
        for <linux-pwm@vger.kernel.org>; Tue, 23 May 2023 22:46:11 -0700 (PDT)
Received: from [89.1.81.74] (helo=karo-electronics.de)
        by smtprelay01.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <LW@KARO-electronics.de>)
        id 1q1hK5-0003fA-OK; Wed, 24 May 2023 07:46:09 +0200
Date:   Wed, 24 May 2023 07:46:07 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2] pwm: imx-tpm: fix kernel crash upon resume due to
 register access with clocks disabled
Message-ID: <20230524074607.41ffc31b@karo-electronics.de>
In-Reply-To: <20230524052714.3077-1-LW@KARO-electronics.de>
References: <20230524052714.3077-1-LW@KARO-electronics.de>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If the pwm-imx-tpm driver is being used e.g. for backlight, the
pwm_imx_tpm_apply() function is being called before the device is
resumed and the clocks are enabled, resulting in a data abort:
echo +5 > /sys/class/rtc/rtc0/wakealarm;echo mem > /sys/power/state
PM: suspend entry (deep)
Filesystems sync: 0.006 seconds
Freezing user space processes ... (elapsed 0.015 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Disabling non-boot CPUs ...
psci: CPU1 killed (polled 0 ms)
Enabling non-boot CPUs ...
Detected VIPT I-cache on CPU1
cacheinfo: Unable to detect cache hierarchy for CPU 1
GICv3: CPU1: found redistributor 100 region 0:0x0000000048060000
CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
CPU1 is up
Internal error: synchronous external abort: 0000000096000010 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 245 Comm: bash Not tainted 6.1.1-karo+g29549c7073bf #1
Hardware name: Ka-Ro electronics GmbH TX93-5210 (NXP i.MX93) module (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : pwm_imx_tpm_apply+0x12c/0x3f0
lr : pwm_imx_tpm_apply+0x104/0x3f0
sp : ffff80000a11b710
x29: ffff80000a11b710 x28: 0000000000000001 x27: 0000000000000000
x26: 0000000000000000 x25: 000000000007a12a x24: 0000000000008236
x23: 0000000000000000 x22: ffff00000309b5d0 x21: 0000000000000000
x20: ffff0000022b0a00 x19: ffff00000309b580 x18: 3030387830383231
x17: 0048008800d90326 x16: 0324032303260320 x15: ffff80000a11b780
x14: ffff80000a11b830 x13: ffff80000a11b834 x12: ffff00003fd90740
x11: ffff00000391da00 x10: 00000000000007d0 x9 : ffff80000a11b6b0
x8 : ffff00000391e230 x7 : 0000000000000000 x6 : ffff00000391da00
x5 : 000000001dcd6500 x4 : 0000000000000000 x3 : ffff00000309b5d0
x2 : ffff00000391da00 x1 : 0000000000000000 x0 : ffff800008fdd010
Call trace:
 pwm_imx_tpm_apply+0x12c/0x3f0
 pwm_apply_state+0x5c/0xbc
 pwm_backlight_update_status+0xc4/0x1ac
 drm_panel_enable+0x70/0xe0
[...]

Fix this by remembering the suspend state and returning -EAGAIN in HW
related functions (pwm_imx_tpm_apply() and pwm_imx_tpm_get_state()) as
long as pwm_imx_tpm_resume() has not been called.

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
---
V2: one hunk was missing in the first mail
---
 drivers/pwm/pwm-imx-tpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index e5e7b7c339a8..537c7182f988 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -64,6 +64,7 @@ struct imx_tpm_pwm_chip {
 	u32 user_count;
 	u32 enable_count;
 	u32 real_period;
+	int suspended;
 };
 
 struct imx_tpm_pwm_param {
@@ -140,6 +141,9 @@ static void pwm_imx_tpm_get_state(struct pwm_chip *chip,
 	u32 rate, val, prescale;
 	u64 tmp;
 
+	if (tpm->suspended)
+		return -EAGAIN;
+
 	/* get period */
 	state->period = tpm->real_period;
 
@@ -294,6 +298,9 @@ static int pwm_imx_tpm_apply(struct pwm_chip *chip,
 	struct pwm_state real_state;
 	int ret;
 
+	if (tpm->suspended)
+		return -EAGAIN;
+
 	ret = pwm_imx_tpm_round_state(chip, &param, &real_state, state);
 	if (ret)
 		return ret;
@@ -397,6 +404,7 @@ static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
 	if (tpm->enable_count > 0)
 		return -EBUSY;
 
+	tpm->suspended = 1;
 	clk_disable_unprepare(tpm->clk);
 
 	return 0;
@@ -411,6 +419,7 @@ static int __maybe_unused pwm_imx_tpm_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "failed to prepare or enable clock: %d\n", ret);
 
+	tpm->suspended = 0;
 	return ret;
 }
 
-- 
2.30.2


