Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E1B2A636
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfEYSLw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:11:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51975 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfEYSLv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:11:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id f10so4900720wmb.1;
        Sat, 25 May 2019 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nn1lq5gWQykJ2fa3C4+FTZu1w/wv0i+nYPKx90V4RFM=;
        b=unEoYEq163JDPHz4GpYBoATDRMh+15QMqfxr+AHKhSvMSgwptHsRNKR8UMzbNUWkdb
         wsMB9PVohIZ05gyBMxH175ByVXPLK/OjYoTxNqwR/LChOSFJ285vN3v+1Wvt657xB39l
         Wjgpaq6C9cO0arrDdmKnWp1hljFYGJ+vpgtx6EB3qPeeFUz0+iccx7ebfYXdkfBqnU+3
         PvInFGbDkBhjdOoQXLxa+Mxu9XMB+tA1YkxYf8pIwUIU/XV0naV8hSP3lMpiUCW29Fhl
         rhUOg3DvFJcIKHv6K2ktuXXOt7I/B5/f2oyx+5SDsa5yFt+946Q5icY0PvzXoQ54vJnc
         8iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nn1lq5gWQykJ2fa3C4+FTZu1w/wv0i+nYPKx90V4RFM=;
        b=TNAkWzedvVq2rzYRc1FmS3JXXEcc+UwSoXhZoadmR6ZR/EEG91lS7kLnfQU+UVOICW
         MCRXaK4s+XTWiEQ8gegAu+oBJFZFEyqQHcSnUmBtZ5V5Mv8C7px0aTLDDEGiDjBBG0jI
         98qpnlCNGLBgY92fOuyHl2Zbj6eU1ijwW0WAAA+83zgAb4qP/hJ/3knCfhKnhxO4YH2D
         giRC4U4uQ+ReVPMTnHUEU2qVUnBEf6r6efTrjNBUvGjAKEHkhKBhNNyZAiXELRGmhDst
         j/2yN2qe/A+qlN9pcSr78tSte6mU7ouMgpM/C6asv0+b3N/ndIFc3uq+9QWTjHkOD9Fg
         cRyA==
X-Gm-Message-State: APjAAAXkKIKRB2bgHe1k9SjYuuCGBIqdM3goFk7CVqeHxq9shfOeNLfQ
        BjMC/YldsddbdxsggExvX4w=
X-Google-Smtp-Source: APXvYqyArwVBOnsm4XmcG01yPAMcVx9BefPdZ5RdtyXTzaWpsVjGIOfb+gC8dfMpIwqaxfR6tXifMg==
X-Received: by 2002:a1c:eb0c:: with SMTP id j12mr19669283wmh.55.1558807909296;
        Sat, 25 May 2019 11:11:49 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:48 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 05/14] pwm: meson: don't duplicate the polarity internally
Date:   Sat, 25 May 2019 20:11:24 +0200
Message-Id: <20190525181133.4875-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let meson_pwm_calc() use the polarity from struct pwm_state directly.
This removes a level of indirection where meson_pwm_apply() first had to
set a driver-internal inverter mask which was then only used by
meson_pwm_calc().

Instead of adding the polarity as parameter to meson_pwm_calc() switch
to struct pwm_state directly to make it easier to see where the
parameters are actually coming from.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 84b28ba0f903..39ea119add7b 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -63,7 +63,6 @@ struct meson_pwm {
 	struct pwm_chip chip;
 	const struct meson_pwm_data *data;
 	void __iomem *base;
-	u8 inverter_mask;
 	/*
 	 * Protects register (write) access to the REG_MISC_AB register
 	 * that is shared between the two PWMs.
@@ -116,14 +115,17 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static int meson_pwm_calc(struct meson_pwm *meson,
-			  struct meson_pwm_channel *channel, unsigned int id,
-			  unsigned int duty, unsigned int period)
+			  struct meson_pwm_channel *channel,
+			  struct pwm_state *state)
 {
-	unsigned int pre_div, cnt, duty_cnt;
+	unsigned int duty, period, pre_div, cnt, duty_cnt;
 	unsigned long fin_freq = -1;
 	u64 fin_ps;
 
-	if (~(meson->inverter_mask >> id) & 0x1)
+	duty = state->duty_cycle;
+	period = state->period;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
 		duty = period - duty;
 
 	if (period == channel->state.period &&
@@ -278,15 +280,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period != channel->state.period ||
 	    state->duty_cycle != channel->state.duty_cycle ||
 	    state->polarity != channel->state.polarity) {
-		if (state->polarity != channel->state.polarity) {
-			if (state->polarity == PWM_POLARITY_NORMAL)
-				meson->inverter_mask |= BIT(pwm->hwpwm);
-			else
-				meson->inverter_mask &= ~BIT(pwm->hwpwm);
-		}
-
-		err = meson_pwm_calc(meson, channel, pwm->hwpwm,
-				     state->duty_cycle, state->period);
+		err = meson_pwm_calc(meson, channel, state);
 		if (err < 0)
 			return err;
 
@@ -520,7 +514,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	meson->chip.of_pwm_n_cells = 3;
 
 	meson->data = of_device_get_match_data(&pdev->dev);
-	meson->inverter_mask = BIT(meson->chip.npwm) - 1;
 
 	channels = devm_kcalloc(&pdev->dev, meson->chip.npwm,
 				sizeof(*channels), GFP_KERNEL);
-- 
2.21.0

