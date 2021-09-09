Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F440483D
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhIIKL6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 06:11:58 -0400
Received: from smtp2.axis.com ([195.60.68.18]:54458 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhIIKL6 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Sep 2021 06:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1631182249;
  x=1662718249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8WA791u9a+qKUngkNVzY5nIzKD8RRpENC0AG6NpLung=;
  b=N7dXfY2CxoMInJmyiYFVAsSftNCrVD8UfRAiWuKcWJZdzrG8OTNnFsIR
   +RIKAse6ctCouCBl4smzWSeEu7fvIJoMR59G2qsehkUZ5Qe3H/SyycvMN
   bEta1dSzckDyPodZ5UqFaX5H9de1gOCK1cR99dNq+6H4MGCUPaDiyIHAD
   ikfawhROqqu3D9+arFzXN8MCgY0beDf2ngIpBoxw2fBXtbm+13R051IDk
   jVzL477KtBAX/w0zi7i/czZlzfYOFUZUl9hJofHg1Xo2yD8m05eAd5BK1
   drmIfqzhYplwCThHDLXegFWnVPH6tULoVVzckESDHG2Tka/WdS3Jlj2Zr
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3] pwm: pwm-samsung: Trigger manual update when disabling PWM
Date:   Thu, 9 Sep 2021 12:10:42 +0200
Message-ID: <20210909101042.17431-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When duty-cycle is at full level (100%), the TCNTn and TCMPn registers
needs to be flushed in order to disable the signal. The PWM manual does
not say anything about this, but states that only clearing the TCON
auto-reload bit should be needed, and this seems to be true when the PWM
duty-cycle is not at full level. This can be observed on an Axis
ARTPEC-8, by running:

  echo <period> > pwm/period
  echo <period> > pwm/duty_cycle
  echo 1 > pwm/enable
  echo 0 > pwm/enable

Since the TCNTn and TCMPn registers are activated when enabling the PWM
(setting TCON auto-reload bit), and are not touched when disabling the
PWM, the double buffered auto-reload function seems to be still active.
Lowering duty-cycle, and restoring it again in between the enabling and
disabling, makes the disable work since it triggers a reload of the
TCNTn and TCMPn registers.

Fix this by securing a reload of the TCNTn and TCMPn registers when
disabling the PWM and having a full duty-cycle.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---

v2:
 - Move fix above setting of disabled_mask

v3:
 - Move up definition of __pwm_samsung_manual_update to avoid
   declaration of the same

 drivers/pwm/pwm-samsung.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index f6c528f02d43..f660ec2501fd 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -117,6 +117,20 @@ static inline unsigned int to_tcon_channel(unsigned int channel)
 	return (channel == 0) ? 0 : (channel + 1);
 }
 
+static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
+				      struct pwm_device *pwm)
+{
+	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
+	u32 tcon;
+
+	tcon = readl(chip->base + REG_TCON);
+	tcon |= TCON_MANUALUPDATE(tcon_chan);
+	writel(tcon, chip->base + REG_TCON);
+
+	tcon &= ~TCON_MANUALUPDATE(tcon_chan);
+	writel(tcon, chip->base + REG_TCON);
+}
+
 static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
 				    unsigned int channel, u8 divisor)
 {
@@ -276,6 +290,13 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	tcon &= ~TCON_AUTORELOAD(tcon_chan);
 	writel(tcon, our_chip->base + REG_TCON);
 
+	/*
+	 * In case the PWM is at 100% duty cycle, force a manual
+	 * update to prevent the signal from staying high.
+	 */
+	if (readl(our_chip->base + REG_TCMPB(pwm->hwpwm)) == (u32)-1U)
+		__pwm_samsung_manual_update(our_chip, pwm);
+
 	our_chip->disabled_mask |= BIT(pwm->hwpwm);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
@@ -284,18 +305,11 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
 				      struct pwm_device *pwm)
 {
-	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
-	u32 tcon;
 	unsigned long flags;
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	tcon = readl(chip->base + REG_TCON);
-	tcon |= TCON_MANUALUPDATE(tcon_chan);
-	writel(tcon, chip->base + REG_TCON);
-
-	tcon &= ~TCON_MANUALUPDATE(tcon_chan);
-	writel(tcon, chip->base + REG_TCON);
+	__pwm_samsung_manual_update(chip, pwm);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
-- 
2.20.1

