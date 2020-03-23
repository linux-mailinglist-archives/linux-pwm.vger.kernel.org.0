Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B483C18F6C2
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 15:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgCWOYu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 10:24:50 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44366 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgCWOYt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 10:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1584973469; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSjRM581ZcgPbIMlyi94/j1T7nFhoAAHB4Hnw4QUeSw=;
        b=rhg8F5w++b6ZV5AFahBoGNS+bYUYzz1qtxPksBCujueVCbgSyjf9ALMV8R7oO+dphbufzD
        5ecjaNr4CuB34AljJomhJ7LYFDk4CeDmxyFjaOUubjF3k/09sIu0qgbwJDXCiIQMGdDhYu
        5JaoZozAeEBYo+msrX/LWQiHhpiwoU0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v4 4/4] pwm: jz4740: Allow selection of PWM channels 0 and 1
Date:   Mon, 23 Mar 2020 15:24:21 +0100
Message-Id: <20200323142421.42817-4-paul@crapouillou.net>
In-Reply-To: <20200323142421.42817-1-paul@crapouillou.net>
References: <20200323142421.42817-1-paul@crapouillou.net>
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
    v2-v4: No change

 drivers/pwm/pwm-jz4740.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index df6906c51b8d..c12c43eb2506 100644
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
2.25.1

