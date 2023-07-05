Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04219747EFE
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jul 2023 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGEIHJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Jul 2023 04:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGEIHI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jul 2023 04:07:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6ED135
        for <linux-pwm@vger.kernel.org>; Wed,  5 Jul 2023 01:07:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXM-0003pC-Lm; Wed, 05 Jul 2023 10:06:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXL-00CDN6-NC; Wed, 05 Jul 2023 10:06:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXK-002Oau-U0; Wed, 05 Jul 2023 10:06:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 1/8] pwm: berlin: Put per-channel config into driver data
Date:   Wed,  5 Jul 2023 10:06:43 +0200
Message-Id: <20230705080650.2353391-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
References: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3363; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sMWSgIk60cPeGRd1zx37s8tb4EIGg5ANZBZAmstlcBE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkpSSO+DMG5B/9FTDB0nw1BKKL5pPmzchdmx3Di oamoaQPWDWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKUkjgAKCRCPgPtYfRL+ TtIuCACizYUm0GtR20Af8UTxtNZKgXiQ5XSTgP4cGcEgs82KdZpgKRxXntyruV/g2gtIMb/o/3S +8+lAu8nmjIsxjO4Bqft4IQr/EoLhpFRQBFZfW75zvd3/4t420Hm1wgwJOhJsevcMZB3d8Lmu7r KLCDrPvMdlkj5+H9RFBo/EsKW6cZBO2dp+ICF16+17e+/96i8lNTjd4p2VzifzKkHxnFcyemc50 4GAISxoQCZGjeaGzJWPFb6W9gRfZ9beHvneSjZUndKzkpUO99TTvrasYdNVMUBiv5dywY0M3VDA NaAIy4hVYJOnTHoZKc4JafXx1gnlhBDJunK0a18DSHiWTJf7
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Instead of allocating extra data in .request() provide the needed memory
in struct berlin_pwm_chip. This reduces the number of allocations. A
side effect is that on suspend and resume the state for all four
channels is always saved and restored. This is easier (and probably
quicker) than looking up the matching pwm_device and checking its
PWMF_REQUESTED bit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 0c5992a046b2..38dcd0c99efd 100644
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
 			     u64 duty_ns, u64 period_ns)
 {
@@ -201,8 +186,6 @@ static int berlin_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 }
 
 static const struct pwm_ops berlin_pwm_ops = {
-	.request = berlin_pwm_request,
-	.free = berlin_pwm_free,
 	.apply = berlin_pwm_apply,
 	.owner = THIS_MODULE,
 };
@@ -236,7 +219,7 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 
 	bpc->chip.dev = &pdev->dev;
 	bpc->chip.ops = &berlin_pwm_ops;
-	bpc->chip.npwm = 4;
+	bpc->chip.npwm = BERLIN_PWM_NUMPWMS;
 
 	ret = pwmchip_add(&bpc->chip);
 	if (ret < 0) {
@@ -266,11 +249,7 @@ static int berlin_pwm_suspend(struct device *dev)
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
@@ -294,11 +273,7 @@ static int berlin_pwm_resume(struct device *dev)
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
2.39.2

