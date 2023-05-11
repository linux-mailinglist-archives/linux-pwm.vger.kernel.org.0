Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C916FF968
	for <lists+linux-pwm@lfdr.de>; Thu, 11 May 2023 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjEKSTG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 May 2023 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbjEKSTF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 May 2023 14:19:05 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FED30FB
        for <linux-pwm@vger.kernel.org>; Thu, 11 May 2023 11:19:04 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D8C2E8619B;
        Thu, 11 May 2023 20:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1683829142;
        bh=5c87M5Mlyt4IPwxZPGG6d+KSyENTxxKXvZ/14g99J2U=;
        h=From:To:Cc:Subject:Date:From;
        b=MUxbAN0RW2wtIp+R1atD+l+52gp1fO9Eag3z/vzg5XZRaFtfFNQJQtp9ZNOkf8HdA
         mxywf2ytfceCs9uoNyY1hB50F19Vj2Yr27meeMwBMYFC2ZKVJEhYtbp9GIu77E1E1P
         ITeviZMM9TdhO4DGgDKIHmYTFj2/g/n2zMTB36YOx6xjIYBJvRNGQnb8TURT7jicZ5
         DQ3G4AIG5uUrgAWP0Z9C31tHmhSDIVh0SS6YV6+0y8f4BjfKnqxmFOUdKW9vs+bF60
         o1zPbvyzZTlOe9+Uew5xz3tjvdQza5SFhtWIvUPHSGbdx6XHjco/AjbAw/I7ivG1FH
         iT7lLP4NnbukA==
From:   Marek Vasut <marex@denx.de>
To:     linux-pwm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Brian Norris <briannorris@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] pwm: core: Permit unset period when applying configuration of disabled PWMs
Date:   Thu, 11 May 2023 20:18:53 +0200
Message-Id: <20230511181853.185685-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In case the PWM is not enabled, the period can still be left unconfigured,
i.e. zero . Currently the pwm_class_apply_state() errors out in such a case.
This e.g. makes suspend fail on systems where pwmchip has been exported via
sysfs interface, but left unconfigured before suspend occurred.

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

Permit unset period in pwm_class_apply_state() in case the PWM is disabled
to fix this issue.

Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Brian Norris <briannorris@chromium.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pwm@vger.kernel.org
---
 drivers/pwm/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3dacceaef4a9b..87252b70f1c81 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -510,8 +510,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	 */
 	might_sleep();
 
-	if (!pwm || !state || !state->period ||
-	    state->duty_cycle > state->period)
+	if (!pwm || !state || (state->enabled &&
+	    (!state->period || state->duty_cycle > state->period)))
 		return -EINVAL;
 
 	chip = pwm->chip;
-- 
2.39.2

