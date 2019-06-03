Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 356D532B44
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2019 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfFCJBA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Jun 2019 05:01:00 -0400
Received: from gofer.mess.org ([88.97.38.141]:36829 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfFCJBA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 3 Jun 2019 05:01:00 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 8805160599; Mon,  3 Jun 2019 10:00:58 +0100 (BST)
Date:   Mon, 3 Jun 2019 10:00:58 +0100
From:   Sean Young <sean@mess.org>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andreas Christ <andreas@christ-faesch.ch>
Subject: [PATCH v2] pwm: bcm2835: improve precision of pwm
Message-ID: <20190603090058.qd3tbiffmdgqm34d@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If sending IR with carrier of 455kHz using the pwm-ir-tx driver, the
carrier ends up being 476kHz. The clock is set to bcm2835-pwm with a
rate of 10MHz.

A carrier of 455kHz has a period of 2198ns, but the arithmetic truncates
this to 2100ns rather than 2200ns. So, use DIV_ROUND_CLOSEST() to reduce
rounding errors, and we have a much more accurate carrier of 454.5kHz.

Reported-by: Andreas Christ <andreas@christ-faesch.ch>
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/pwm-bcm2835.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 5652f461d994..f6fe0b922e1e 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -70,7 +70,7 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
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

