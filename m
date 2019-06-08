Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 864FE3A107
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfFHSGv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:06:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40950 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfFHSGs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so4681580wmj.5;
        Sat, 08 Jun 2019 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2ToPp43IDqJY9ruWYlbIAIk8rREDtHiEg0Zr2a3p3U=;
        b=eywnowT3FV8czlQzFI8M3KB61zx8ksV40JxyuUI2r0EVZJvHfST15EcsA3sliMrZqt
         MftDg+tCTBg1Ttq9RgZaQLBOYrdZC+h7/KpBFeHy+i4NpfluFC4NW7p2e7SaJ4aRcFw2
         CoOuaBKztBKR+/tFZdOsg1+V6AejWVG40dLV5QUvJiAad/ZL/jUauFyabADWZzPeSA6I
         Z1/oZCilwF9bkCEl4k2ywVy1KGL2x3IAUET8gmZDKZ0Eh8w8NT/JHQBnF+Rp7AkAcm5r
         Sd1BnAwBQQJW+pDMvHxGOASFKKBJDhzJPSYIkTx9kdVYKq0D162b64xeaih0ssDBJqoX
         kGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2ToPp43IDqJY9ruWYlbIAIk8rREDtHiEg0Zr2a3p3U=;
        b=i44c16qMHyW2HfQtZvM9j9IEGE21o6oIyIypMWxMg4WualkJDql+mSz5mUbQPOV+5M
         EiSZVIUC4f1KW3/auXFZmST8EbE9dD6PpjLLaz86U04/ucHMhjcGjEm9+CYBfCItw9Y1
         7s50u+hKDRji8H+XHWLUUHrYEZ+6Ekq0tpylpbXHunpOKw2Ohg9wPFIlLpqLgpJmHEA8
         x7mcxr459+0c1SrRMDwNax3NkAA3Fe4RY7gkZgVwQeK2T+4TSVzvr06x40YihDWb2kmm
         jyYUdJ2xbNztzy7+ugwFWr1gfw8vLhhbJTBDK2yqVrZfQrDwvDlCEgNmV8Z9L4KBNl81
         DHOA==
X-Gm-Message-State: APjAAAVnnW+vWqo5oQl3RlJXn3G6hlrhiS4opVzIaEhqDNAzG0W8LSzu
        9FpCgSsrw0BMxhU4XOBwbRY=
X-Google-Smtp-Source: APXvYqzKbhVwCuFbTgMQsfzH5DhqyH4Vq7yYLlluv4xdq4kBEVhrp4ppQhvp/iNKP8GbfnN5So4iEQ==
X-Received: by 2002:a1c:8049:: with SMTP id b70mr7436969wmd.33.1560017206430;
        Sat, 08 Jun 2019 11:06:46 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 12/14] pwm: meson: don't cache struct pwm_state internally
Date:   Sat,  8 Jun 2019 20:06:24 +0200
Message-Id: <20190608180626.30589-13-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
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
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

