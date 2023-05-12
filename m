Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE00700D4D
	for <lists+linux-pwm@lfdr.de>; Fri, 12 May 2023 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjELQr7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 May 2023 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjELQr6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 May 2023 12:47:58 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C7A24C
        for <linux-pwm@vger.kernel.org>; Fri, 12 May 2023 09:47:53 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F4016846A3;
        Fri, 12 May 2023 18:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683910070;
        bh=ATsqck42pYmke4Qkc3IcURR2e8W9A32K/RB+7MQ5pFw=;
        h=From:To:Cc:Subject:Date:From;
        b=xJoPwHMNgr+i2PYOgVOm++tSNsrplT/z98JjhaQd3E5cXTr0J6R07Ma2iuBxVFcCR
         ja998rj4rtt2Dz2VTHtGAzVOuuOX/GpmkUluo+9ivfUSuCUQLTsChipblpupaT62p0
         gyfnFHHHwQhb6Y9NZitilWoahhgHq8ufTiod/ll/MSg1fjaUitFavl3yykeciQK/2T
         JgXEsGH4sC80T4SxcBXDZK5sNyI449zrO0+0//78XVMeqdTiA/g3n4IqQ8MnkMVCVr
         fUF3SeW/n1qG0y8ldn5VwRFhKw8qizvp0SsubCyplF2YMUCtlrUKXAocg0hN0QOWvK
         IJFraSZDqnrmQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-pwm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Brian Norris <briannorris@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] pwm: sysfs: Do not apply state to already disabled PWMs
Date:   Fri, 12 May 2023 18:47:36 +0200
Message-Id: <20230512164736.53615-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If the PWM is exported but not enabled, do not call pwm_class_apply_state().
First of all, in this case, period may still be unconfigured and this would
make pwm_class_apply_state() return -EINVAL, and then suspend would fail.
Second, it makes little sense to apply state onto PWM that is not enabled
before suspend.

Failing case:
"
$ echo 1 > /sys/class/pwm/pwmchip4/export
$ echo mem > /sys/power/state
...
pwm pwmchip4: PM: dpm_run_callback(): pwm_class_suspend+0x1/0xa8 returns -22
pwm pwmchip4: PM: failed to suspend: error -22
PM: Some devices failed to suspend, or early wake event detected
"

Working case:
"
$ echo 1 > /sys/class/pwm/pwmchip4/export
$ echo 100 > /sys/class/pwm/pwmchip4/pwm1/period
$ echo 10 > /sys/class/pwm/pwmchip4/pwm1/duty_cycle
$ echo mem > /sys/power/state
...
"

Do not call pwm_class_apply_state() in case the PWM is disabled
to fix this issue.

Fixes: 7fd4edc57bbae ("pwm: sysfs: Add suspend/resume support")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Brian Norris <briannorris@chromium.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org
---
 drivers/pwm/sysfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 1a106ec329392..8d1254761e4dd 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -424,6 +424,13 @@ static int pwm_class_resume_npwm(struct device *parent, unsigned int npwm)
 		if (!export)
 			continue;
 
+		/* If pwmchip was not enabled before suspend, do nothing. */
+		if (!export->suspend.enabled) {
+			/* release lock taken in pwm_class_get_state */
+			mutex_unlock(&export->lock);
+			continue;
+		}
+
 		state.enabled = export->suspend.enabled;
 		ret = pwm_class_apply_state(export, pwm, &state);
 		if (ret < 0)
@@ -448,7 +455,17 @@ static int pwm_class_suspend(struct device *parent)
 		if (!export)
 			continue;
 
+		/*
+		 * If pwmchip was not enabled before suspend, save
+		 * state for resume time and do nothing else.
+		 */
 		export->suspend = state;
+		if (!state.enabled) {
+			/* release lock taken in pwm_class_get_state */
+			mutex_unlock(&export->lock);
+			continue;
+		}
+
 		state.enabled = false;
 		ret = pwm_class_apply_state(export, pwm, &state);
 		if (ret < 0) {
-- 
2.39.2

