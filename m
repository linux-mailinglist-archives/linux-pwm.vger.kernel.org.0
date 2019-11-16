Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F20FF46D
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Nov 2019 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfKPRmt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Nov 2019 12:42:49 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40018 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfKPRms (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 16 Nov 2019 12:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1573925781; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2cbYuCgLlNTwc6PuVhvUunFsMN6Y7kI5a1YouN7/v5c=;
        b=GthUwsVMbie+Q2wcqsFqIz642g6QkdIg3iOZ0YQifvcFTAGhXjGtqWpWdi6/xVmfCLsD7S
        iRe+wBVP1NlqomlCGIg5Z5BrutDX0qbJ6wCCjEwUHnDMw1dLiFgYZ9bmp4391c4DhupZZx
        HPxAjga783h+oq3LjDv6cuWFTVzKuQI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 3/3] pwm: jz4740: Allow selection of PWM channels 0 and 1
Date:   Sat, 16 Nov 2019 18:36:13 +0100
Message-Id: <20191116173613.72647-4-paul@crapouillou.net>
In-Reply-To: <20191116173613.72647-1-paul@crapouillou.net>
References: <20191116173613.72647-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The TCU channels 0 and 1 were previously reserved for system tasks, and
thus unavailable for PWM.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: No change

 drivers/pwm/pwm-jz4740.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index a5368b98652d..801dfabfa6f4 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -33,6 +33,19 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 	return container_of(chip, struct jz4740_pwm_chip, chip);
 }
 
+static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
+				   unsigned int channel)
+{
+	/* Enable all TCU channels for PWM use by default except channels 0/1 */
+	u32 pwm_channels_mask = GENMASK(NUM_PWM - 1, 2);
+
+	device_property_read_u32(jz->chip.dev->parent,
+				 "ingenic,pwm-channels-mask",
+				 &pwm_channels_mask);
+
+	return !!(pwm_channels_mask & BIT(channel));
+}
+
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct jz4740_pwm_chip *jz = to_jz4740(chip);
@@ -40,11 +53,7 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char clk_name[16];
 	int ret;
 
-	/*
-	 * Timers 0 and 1 are used for system tasks, so they are unavailable
-	 * for use as PWMs.
-	 */
-	if (pwm->hwpwm < 2)
+	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
 		return -EBUSY;
 
 	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
-- 
2.24.0

