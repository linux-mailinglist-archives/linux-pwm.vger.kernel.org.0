Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEFC43099
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbfFLT7q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40621 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbfFLT7q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so7751570wmj.5;
        Wed, 12 Jun 2019 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLy7MuNNW7ZLGj2GLiOb+ot6OCmiebBg8TF4amKVb/w=;
        b=TGB+JGNDKNqhzbggSZ0+62hx471mt0iNXoEb9V46P1WPYT2PTURINF3pQrUmVHZ0hM
         t4UgW199o7Tdq7FWC2Qkw6s5T2mEmS5SGqr6efsqME9Xa/7HQ33rnVFcPtQmoPr1nAZt
         FHobdnn5yq1EFpmxTLoHoKBT7gXzsP0BXWBwGX7vgftqJgViLCFZUX3VtQXlnQK9pKTO
         jicD8mSNxUsh8LGULZKSHY7iZAmygk9onDkMPvfWm3p80e9mxXmb7kB57bTSAtfpqJR6
         YwM/duwTlk8KsmHvX+3384kgb8tik7oCTyyf8jekjf+2rjc1l+quLzmwEwZRNo0QF9SN
         hIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLy7MuNNW7ZLGj2GLiOb+ot6OCmiebBg8TF4amKVb/w=;
        b=AMmFRANW634NYtQ0VFJmtZFu65nvEpS9FoDeocZnophpNbmgZ2rYTtfpsD6TIjjKIh
         A8HMeTL6SKRRvn2tmoafQ0JQHTCI+qwkJIocVapsktN/WKxdrIMInzzpLI341K7rEsw/
         /XfEvlMCbrRM2hqK9fqrJhCUH4zpMYy1yZIPljHPKpS9UGLfghjtPhi4vMw/y1FjhnAN
         BeI/GCTcCtZk1gYdTWo0UzIUW0uNYxBv2OvOXfSOMOGzjynZQnlMt5nAt6uJGc81Vujd
         YP4TamfK61FXN1/QkWJb7Cl+fSIyq/sgBplsdgT5WzW4fXHMNZO+Y7zTu+BRO2+VVuoS
         fdRg==
X-Gm-Message-State: APjAAAUvGm5nKZLPq0yik8LCq1/itoeVN+JFnAd2He/eELPNj8LM7hDV
        /MtpINDKpY90QbbgQcnAr5I=
X-Google-Smtp-Source: APXvYqw2DhiiYjSAa1cfWXxQ/DMMAcmz5W+waI3fkKgc2wp5Bsn4Qbqb7vj0emhQduFyIQIGuCx/ag==
X-Received: by 2002:a1c:7a15:: with SMTP id v21mr633916wmc.82.1560369583959;
        Wed, 12 Jun 2019 12:59:43 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 12/14] pwm: meson: don't cache struct pwm_state internally
Date:   Wed, 12 Jun 2019 21:59:09 +0200
Message-Id: <20190612195911.4442-13-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM core already caches the "current struct pwm_state" as the
"current state of the hardware registers" inside struct pwm_device.

Drop the struct pwm_state from struct meson_pwm_channel in favour of the
struct pwm_state in struct pwm_device. While here also drop any checks
based on the pwm_state because the PWM core already takes care of this.

No functional changes intended.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 010212166d5d..900d362ec3c9 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -68,8 +68,6 @@ struct meson_pwm_channel {
 	unsigned int lo;
 	u8 pre_div;
 
-	struct pwm_state state;
-
 	struct clk *clk_parent;
 	struct clk_mux mux;
 	struct clk *clk;
@@ -127,8 +125,6 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return err;
 	}
 
-	chip->ops->get_state(chip, pwm, &channel->state);
-
 	return pwm_set_chip_data(pwm, channel);
 }
 
@@ -153,10 +149,6 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	if (state->polarity == PWM_POLARITY_INVERSED)
 		duty = period - duty;
 
-	if (period == channel->state.period &&
-	    duty == channel->state.duty_cycle)
-		return 0;
-
 	fin_freq = clk_get_rate(channel->clk);
 	if (fin_freq == 0) {
 		dev_err(meson->chip.dev, "invalid source clock frequency\n");
@@ -253,7 +245,6 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   struct pwm_state *state)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	int err = 0;
 
@@ -262,26 +253,12 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (!state->enabled) {
 		meson_pwm_disable(meson, pwm);
-		channel->state.enabled = false;
-
-		return 0;
-	}
-
-	if (state->period != channel->state.period ||
-	    state->duty_cycle != channel->state.duty_cycle ||
-	    state->polarity != channel->state.polarity) {
+	} else {
 		err = meson_pwm_calc(meson, pwm, state);
 		if (err < 0)
 			return err;
 
-		channel->state.polarity = state->polarity;
-		channel->state.period = state->period;
-		channel->state.duty_cycle = state->duty_cycle;
-	}
-
-	if (state->enabled && !channel->state.enabled) {
 		meson_pwm_enable(meson, pwm);
-		channel->state.enabled = true;
 	}
 
 	return 0;
-- 
2.22.0

