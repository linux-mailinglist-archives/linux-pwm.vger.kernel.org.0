Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17C5322EF
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2019 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFBKXx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Jun 2019 06:23:53 -0400
Received: from gofer.mess.org ([88.97.38.141]:37827 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfFBKXx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 2 Jun 2019 06:23:53 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id A747D60474; Sun,  2 Jun 2019 11:23:50 +0100 (BST)
Date:   Sun, 2 Jun 2019 11:23:50 +0100
From:   Sean Young <sean@mess.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andreas Christ <andreas@christ-faesch.ch>
Subject: [PATCH] pwm: bcm2835: increase precision of pwm
Message-ID: <20190602102350.zzwmfvlky3mnlqln@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
carrier ends up being 476kHz.

A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
this to 2.1ns rather than 2.2ns. So, use DIV_ROUND_CLOSEST() to reduce
rounding errors, and we have a much more accurate carrier of 454.5kHz.

Reported-by: Andreas Christ <andreas@christ-faesch.ch>
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/pwm-bcm2835.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 5652f461d994..edb2387c49a2 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -63,14 +63,14 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
 	unsigned long rate = clk_get_rate(pc->clk);
-	unsigned long scaler;
+	unsigned int scaler;
 
 	if (!rate) {
 		dev_err(pc->dev, "failed to get clock rate\n");
 		return -EINVAL;
 	}
 
-	scaler = NSEC_PER_SEC / rate;
+	scaler = DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
 
 	if (period_ns <= MIN_PERIOD) {
 		dev_err(pc->dev, "period %d not supported, minimum %d\n",
@@ -78,8 +78,10 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
-	writel(duty_ns / scaler, pc->base + DUTY(pwm->hwpwm));
-	writel(period_ns / scaler, pc->base + PERIOD(pwm->hwpwm));
+	writel(DIV_ROUND_CLOSEST(duty_ns, scaler),
+	       pc->base + DUTY(pwm->hwpwm));
+	writel(DIV_ROUND_CLOSEST(period_ns, scaler),
+	       pc->base + PERIOD(pwm->hwpwm));
 
 	return 0;
 }
-- 
2.20.1

