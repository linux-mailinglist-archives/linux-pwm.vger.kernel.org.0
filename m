Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956BE3A110
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfFHSHI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:07:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38296 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfFHSGp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so2232920wmj.3;
        Sat, 08 Jun 2019 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZO7qivBo434TSsVVa4YbzWhWwMZ6z2njZ7atSZyZUE=;
        b=HYY27Tka+Zve8oOw3M3LuURDsY4EXX8qUIvDs9nN77A6hMV7RdCJiqmMLzVYd24D9J
         NZ8KEuhugImjFpMm7IKgsJss/+2YogqQ42dMk1K5h+cxpN+5BjKguyQjRRdTnj1ywhnj
         x7wWEg0obaSdlV2gdVABueOS6ybEMlzo0clHpc+g7ePBVyE6/1Z3b67B7pHgvH8+EM3Y
         EzmvgWJuyTW02VMwmV19skNhqBH+K6mAW17IGIK0PuCQZVH8UobD84u5oEt2ypzgUoE/
         g0i+CfD3HBjY9u0FgqOJDWHlfS2GqDIWKD/m/IpXYxEApSvMYhGUekx+G6x7rb+jNK6/
         7/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZO7qivBo434TSsVVa4YbzWhWwMZ6z2njZ7atSZyZUE=;
        b=bWDA2QiaEm3YCuAovLwh9GZ7Jhgo88f+m5RmM7rbawJzhxe9rY5VDEK4KiOwHGGJwO
         qIynxk8+sc1/mw3tWAOw5eT2Fr8y+1ET4RuoqhdpcG9v4WRJyP1dbAftOtNC/Mq5macz
         Z76rzx7CfsGiklj3ZzEPnu+/p1/7/rdD8Z7Mv+zx8Mu5zUPm7clpz8fEpH052f2YwiVG
         8OBzsnBoOTNKBjQBaWEK4R7epOFdBb53jdBRT5EAx3ZP41v89E3kIjnZWB8eBx/yzR0T
         mNYt0LgEZ3K4Zra2mC1SZnuU2zTNKK7GvcWwymqP1W7AxL8okZmEJ0cJNVPRltBWS1IZ
         waOg==
X-Gm-Message-State: APjAAAWbFV4w6Mt8JQB+BZyQUBfwwq544vx7ia4D9+HRTf8Pcmclg83J
        gmtBcjK+1+9yHBKkFpb+CiQ=
X-Google-Smtp-Source: APXvYqy5gBo0+pcOVgy3Rvl4MUPwN7blfDUL7OIOL3mmZBtcEZnBu9vQTKJGfmXPerM5g/iu3ZkI5Q==
X-Received: by 2002:a1c:3b45:: with SMTP id i66mr6173542wma.48.1560017203368;
        Sat, 08 Jun 2019 11:06:43 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 09/14] pwm: meson: move pwm_set_chip_data() to meson_pwm_request()
Date:   Sat,  8 Jun 2019 20:06:21 +0200
Message-Id: <20190608180626.30589-10-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

All existing PWM drivers (except pwm-meson and two other ones) call
pwm_set_chip_data() from their pwm_ops.request() callback. Now that we
can access the struct meson_pwm_channel from struct meson_pwm we can do
the same.

Move the call to pwm_set_chip_data() to meson_pwm_request() and drop the
custom meson_pwm_add_channels(). This makes the implementation
consistent with other drivers and makes it slightly more obvious
thatpwm_get_chip_data() cannot be used from pwm_ops.get_state() (because
that's called by the PWM core before pwm_ops.request()).

No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index ac7e188155fd..27915d6475e3 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -98,12 +98,16 @@ static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
 
 static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel;
 	struct device *dev = chip->dev;
 	int err;
 
-	if (!channel)
-		return -ENODEV;
+	channel = pwm_get_chip_data(pwm);
+	if (channel)
+		return 0;
+
+	channel = &meson->channels[pwm->hwpwm];
 
 	if (channel->clk_parent) {
 		err = clk_set_parent(channel->clk, channel->clk_parent);
@@ -124,7 +128,7 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	chip->ops->get_state(chip, pwm, &channel->state);
 
-	return 0;
+	return pwm_set_chip_data(pwm, channel);
 }
 
 static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -460,14 +464,6 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 	return 0;
 }
 
-static void meson_pwm_add_channels(struct meson_pwm *meson)
-{
-	unsigned int i;
-
-	for (i = 0; i < meson->chip.npwm; i++)
-		pwm_set_chip_data(&meson->chip.pwms[i], &meson->channels[i]);
-}
-
 static int meson_pwm_probe(struct platform_device *pdev)
 {
 	struct meson_pwm *meson;
@@ -503,8 +499,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	meson_pwm_add_channels(meson);
-
 	platform_set_drvdata(pdev, meson);
 
 	return 0;
-- 
2.21.0

