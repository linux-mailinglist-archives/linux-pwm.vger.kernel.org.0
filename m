Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DCF756858
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jul 2023 17:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGQPxM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Jul 2023 11:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjGQPxL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Jul 2023 11:53:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1950713D
        for <linux-pwm@vger.kernel.org>; Mon, 17 Jul 2023 08:53:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLQX5-0006fv-Uc; Mon, 17 Jul 2023 17:53:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLQX5-000AcV-48; Mon, 17 Jul 2023 17:53:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLQX4-005dR2-Eo; Mon, 17 Jul 2023 17:53:06 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: lpc32xx: remove handling of PWM channels
Date:   Mon, 17 Jul 2023 17:52:57 +0200
Message-Id: <20230717155257.2568627-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3022; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zatuQth9EAY08kesXmS74oQHMHnj/bDngN3aPGB3Oog=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBktWPYRg0BCaK6FgzEhjrhgGUZueH7EfcEssZ9g eMgnRXRPCmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLVj2AAKCRCPgPtYfRL+ TuMOB/9ptm3p2NQj4YiS2VxQREWCaLbFxmMhdCUet51Oa+HIY4NS7IPKpik9oLbj5npe8n5FyAJ Gdwu1AR6LlpTKKxWvCidrtOSiO1WeTVTaWb3oOIkJEaIsFZ7PuVnP9T/hsjRDZN5N5c8ecZe9II 9szA9wXL2d9G5ZQ8uyp8ICOWR3p/8sE2GEN9Z+yeAAc7YuekL6R/mMa1LCsaMY/jgY77B74ju1T BD5JfB2z1gwqWEKLlIhCdY656am2rx3QvU9+z/qwcfGIQqTwTXYRYbQaNokRtuDGyXn8nAPS6Fb mSAWWd7XMcTtNCDK8P0iranUnXv49Ceh5bcI/m1y8NbRiK5O
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Vladimir Zapolskiy <vz@mleia.com>

Because LPC32xx PWM controllers have only a single output which is
registered as the only PWM device/channel per controller, it is known in
advance that pwm->hwpwm value is always 0. On basis of this fact
simplify the code by removing operations with pwm->hwpwm, there is no
controls which require channel number as input.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is a patch that was submitted before by Vladimir in 2016[1]. I
stumbled over hwpwm always being 0 while doing some restructuring of all
pwm drivers. I thought this wasn't the first time I diagnosed this and
while searching for such a patch by me, I found Vladimir's :-)

I added "only a" to the commit log and rebased to v6.5-rc1. I considered
adding
[ukl: improved wording of commit log and rebase to v6.5-rc1]
to the commit log, but the adaptions seemed too trivial to me.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20161205014308.1741-2-vz@mleia.com

 drivers/pwm/pwm-lpc32xx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 86a0ea0f6955..806f0bb3ad6d 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -51,10 +51,10 @@ static int lpc32xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty_cycles > 255)
 		duty_cycles = 255;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~0xFFFF;
 	val |= (period_cycles << 8) | duty_cycles;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	return 0;
 }
@@ -69,9 +69,9 @@ static int lpc32xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (ret)
 		return ret;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val |= PWM_ENABLE;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	return 0;
 }
@@ -81,9 +81,9 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct lpc32xx_pwm_chip *lpc32xx = to_lpc32xx_pwm_chip(chip);
 	u32 val;
 
-	val = readl(lpc32xx->base + (pwm->hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~PWM_ENABLE;
-	writel(val, lpc32xx->base + (pwm->hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	clk_disable_unprepare(lpc32xx->clk);
 }
@@ -141,9 +141,9 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	lpc32xx->chip.npwm = 1;
 
 	/* If PWM is disabled, configure the output to the default value */
-	val = readl(lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	val = readl(lpc32xx->base);
 	val &= ~PWM_PIN_LEVEL;
-	writel(val, lpc32xx->base + (lpc32xx->chip.pwms[0].hwpwm << 2));
+	writel(val, lpc32xx->base);
 
 	ret = devm_pwmchip_add(&pdev->dev, &lpc32xx->chip);
 	if (ret < 0) {

base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.39.2

