Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F6743093
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbfFLT7k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39308 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389262AbfFLT7i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so15577018wrt.6;
        Wed, 12 Jun 2019 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n89sS2IF6oy/dSMTJYTuwbKIYEQibFNtMkr3Jdh00VI=;
        b=jqdfuaGKGVBJDHLqJloPap7ddlkc++Vw86n/G9Cqyth3C/JiT4bp7/TUYhV8kA3DZW
         9VmJOVKhZyIYoVp1ShT9znjTjRAywfH5dI8FzdwqBfBrdwBSlRHHY+PV5QLuV/gqtiYa
         sw0W4lu3jshnIGbAA1VGd9bbl7/EixEghlG/mC8s+3yj+h7XhEyKKn88/d+FzY7l78e6
         emsXdYiElYRTMxlcvj/KwqOhcAMRIJgldcvPIdsB3zvNGADkAVXx0zJ/DnDQEJcCf/hw
         K39ILIJWYx2B3Mx0tQoWFJzOD5Zt1QLQ9M+wHb6oBL0EV6HX0nBEpFJ8GjC07ZYt88FP
         HcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n89sS2IF6oy/dSMTJYTuwbKIYEQibFNtMkr3Jdh00VI=;
        b=SRKyrM4IoAqlfI/AY5ccppJTmzMwjmSTrNIOm3EhwIUt3pxH5jFfgp0en8Pu/9lnd2
         /Uxx5yr+5aJ/h459v1OzyPvBrQGgNRKwCV+LjV1gwGhskMKDXM7iKEDV3MiU9LB+Hjey
         1KpNe9xzO3RYK3bOV3aI0Kz/UpVHSKvWXNmIvSIEx1UkIPhvbS3l8TEt2yCA9stJ3Ove
         8Jqfoi4ODspDm1Ia7Eo19+8XUVgjd1CBQOeRg+VbJiQPTW88ENUVssu6eb02AXOMcRND
         VNGtfTjnJLMUWCf0+TFf2ksuzqjicn37Y1kBxMPK/oMzNd320LwKTeNYe61WYugBB2CM
         FwCQ==
X-Gm-Message-State: APjAAAUQxQNIqVrBaJYi5X9jhc3pyvlffXPNWfJKmJ7/pLUVg6lPGkeS
        B8k3xPktL8AvIzydNWmpAhg=
X-Google-Smtp-Source: APXvYqyF127E/x6ADQ6vNMivZrB0ELAdxN4kdSdQGkVwcCebnCsQXj6HYABRETo8h+cHEk9hOcFpWw==
X-Received: by 2002:adf:df91:: with SMTP id z17mr50155625wrl.336.1560369575951;
        Wed, 12 Jun 2019 12:59:35 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:35 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 05/14] pwm: meson: don't duplicate the polarity internally
Date:   Wed, 12 Jun 2019 21:59:02 +0200
Message-Id: <20190612195911.4442-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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
2.22.0

