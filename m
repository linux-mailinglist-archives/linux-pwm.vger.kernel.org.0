Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B642A646
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfEYSMU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:12:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52390 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbfEYSMA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:12:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so12354093wmm.2;
        Sat, 25 May 2019 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZBrfkl16mJlGiWrnZRe//jeJtUZhnRCrg3oI0vNyFI=;
        b=MgUAmTL4yQFGoNbP7rExFDhLyToEDMu/d0vkne8q//dsS1wVYTc5RZ943WOgq3Wu3D
         7C0kJswseNQVZJ10l7h2RMOJqFNusWEqF8YRh94m+J4618+oOsjp0NdVDk7u2auMCgtN
         KFxgTNGAFTpmEvvvrrGbdZF2B1dnsdByx48ZB3UeKE/okpT5KHo6Lb+BKTAwjkcXbNlj
         lsXY2Y/aLWsfE0hD0bJ4VdcLwj1GuIvZR+Ap34vgH1GQUXZrWZhQ3pN9RIp4Ad/ziwQQ
         YcJXBItvX19JiDrTBcOyvStOwsIkpVNbj9PYJqyKUE1FcmWvVo7Ffy/rs0zRN+vqkmEi
         t/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZBrfkl16mJlGiWrnZRe//jeJtUZhnRCrg3oI0vNyFI=;
        b=V+iAFbmeCtiONHYVwKDCnjcdn9Wyw+KNha3njYn/kPe3IJvSgUpOlVqgZaj9Xcc0Av
         fduj5iJ5UpiHRaFAuGK8It14n7t2+g6Dkeq43AWCkSr+1rbthQTRdDmYVjYtuNS+MSGS
         ADgTTz+x7OXlWQTaX2xMXRrFGBxp4gPuVci2aMVph1HodGxuovM6ta+hoIK2o9Zu+AgL
         faP3z2E3nSTSQiYAT60ytdm+yqSdYZ7jlQTTgw8TXvReuKsy6pDX+UBylGWsNmaaP36V
         TFg9Q89HhoSmZNup6RRiYILW8a87cXDFBKUGvM3mJs50sicnYuVuk7qwr2QGYST2iEgr
         LFWA==
X-Gm-Message-State: APjAAAVpdqQZ+Zn0kaF7Qf2lF6hRxGfg+rk1+CSEisHgze8/ga7WsdYp
        aLOcW3yAEfn2a+cbDeAd+n1tlIF0
X-Google-Smtp-Source: APXvYqx7WEtmO5tBGD+Qk0uLxms3RRFGsn/SwE+f+++pGxOUKsvbHBDc+QgOZvlVI410mS9pcBvgSA==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr21216802wmk.78.1558807917837;
        Sat, 25 May 2019 11:11:57 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:57 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 12/14] pwm: meson: don't cache struct pwm_state internally
Date:   Sat, 25 May 2019 20:11:31 +0200
Message-Id: <20190525181133.4875-13-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
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
2.21.0

