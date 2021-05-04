Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C09F372AEC
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhEDN0j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhEDN0i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 09:26:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7C1C061574
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 06:25:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldv3W-0001tK-Di; Tue, 04 May 2021 15:25:42 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldv3V-0008SI-Gb; Tue, 04 May 2021 15:25:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Thomas Hebb <tommyhebb@gmail.com>,
        Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 2/4] pwm: berlin: Put channel config into driver data
Date:   Tue,  4 May 2021 15:25:35 +0200
Message-Id: <20210504132537.62072-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
References: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Instead of allocating extra data in .request() provide the needed memory
in struct berlin_pwm_chip. This reduces the number of allocations. A side
effect is that on suspend and resume the state for all four channels is
always saved and restored. This is easier (and probably quicker) than
looking up the matching pwm_device and checking its PWMF_REQUESTED bit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 0310d28408ed..894ea5869d42 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -38,6 +38,8 @@
 #define BERLIN_PWM_TCNT			0xc
 #define  BERLIN_PWM_MAX_TCNT		65535
 
+#define BERLIN_PWM_NUMPWMS		4
+
 struct berlin_pwm_channel {
 	u32 enable;
 	u32 ctrl;
@@ -49,6 +51,7 @@ struct berlin_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
+	struct berlin_pwm_channel channel[BERLIN_PWM_NUMPWMS];
 };
 
 static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip *chip)
@@ -69,24 +72,6 @@ static inline void berlin_pwm_writel(struct berlin_pwm_chip *bpc,
 	writel_relaxed(value, bpc->base + channel * 0x10 + offset);
 }
 
-static int berlin_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct berlin_pwm_channel *channel;
-
-	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
-	if (!channel)
-		return -ENOMEM;
-
-	return pwm_set_chip_data(pwm, channel);
-}
-
-static void berlin_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct berlin_pwm_channel *channel = pwm_get_chip_data(pwm);
-
-	kfree(channel);
-}
-
 static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			     int duty_ns, int period_ns)
 {
@@ -168,8 +153,6 @@ static void berlin_pwm_disable(struct pwm_chip *chip,
 }
 
 static const struct pwm_ops berlin_pwm_ops = {
-	.request = berlin_pwm_request,
-	.free = berlin_pwm_free,
 	.config = berlin_pwm_config,
 	.set_polarity = berlin_pwm_set_polarity,
 	.enable = berlin_pwm_enable,
@@ -206,7 +189,7 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 
 	bpc->chip.dev = &pdev->dev;
 	bpc->chip.ops = &berlin_pwm_ops;
-	bpc->chip.npwm = 4;
+	bpc->chip.npwm = BERLIN_PWM_NUMPWMS;
 	bpc->chip.of_xlate = of_pwm_xlate_with_flags;
 	bpc->chip.of_pwm_n_cells = 3;
 
@@ -240,11 +223,7 @@ static int berlin_pwm_suspend(struct device *dev)
 	unsigned int i;
 
 	for (i = 0; i < bpc->chip.npwm; i++) {
-		struct berlin_pwm_channel *channel;
-
-		channel = pwm_get_chip_data(&bpc->chip.pwms[i]);
-		if (!channel)
-			continue;
+		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
 		channel->ctrl = berlin_pwm_readl(bpc, i, BERLIN_PWM_CONTROL);
@@ -268,11 +247,7 @@ static int berlin_pwm_resume(struct device *dev)
 		return ret;
 
 	for (i = 0; i < bpc->chip.npwm; i++) {
-		struct berlin_pwm_channel *channel;
-
-		channel = pwm_get_chip_data(&bpc->chip.pwms[i]);
-		if (!channel)
-			continue;
+		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
 		berlin_pwm_writel(bpc, i, channel->duty, BERLIN_PWM_DUTY);
-- 
2.30.2

