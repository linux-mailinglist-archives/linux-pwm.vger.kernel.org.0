Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481A543092
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbfFLT7k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35587 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388292AbfFLT7j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so18265077wrv.2;
        Wed, 12 Jun 2019 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwDAaDmWDruDWFqHwKhJ34WL6+B33C4drQYm+h+tPEA=;
        b=RZYiqh+GbVSPxundT8VUdR0zNFJSvJT/M2ArtDuVPSzRF0cxtCfjtRf2FKON/uGJZ1
         zrBA6HsLwHfYopWt7vlmuUMC+f8YJuaqcpQPrKYJrypTNFoEhgjzHvEWXSqwz+wMa5Hn
         8tOxuwh1HHR8qhtLCt5BjFul0w+ZDIGREbxbn3oP6gcpaahP24QHtJCwyfjR8F0+ToVV
         dpSS8mPqZarkQKjyTNnCBRigcEo5aD83vvFKY3OSnBtmlly4tq8Q/cUOqwleT4QpVh+q
         kj2mES5D978Z/LJezWyr4F+2PNz5IHiYLyNODDEn8RMfoES4nQKq4LG+mypLCw53vZR8
         xJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwDAaDmWDruDWFqHwKhJ34WL6+B33C4drQYm+h+tPEA=;
        b=nLAE7iEi9R4+bugZstHR1SyupsHDbBKqfkevToX73BM+u0kaAYIlid6Iq7dvT8ZqGv
         TuwIwuJxAghhr+Ip/743BWeIILauFUR6CtaeRv3rNA/uIBs6t2vlofKKp9Zp2bCpnWRl
         dCuDO/1ZI6OKFgIK6L2PsrSRq5eRRDWCWGhG344n1+pfp4oXXZuEYsAYKjgz0GzMLIQQ
         3zXnpq9B1tghHxLdenjM3Js6QXtBMxWT8xBf5Ab+nSYv62fRQ3pfLeBgo7UL4XHxIGtb
         FQoUz6Q58GwuyGXynBg4fg0h1GE6ZPJhcjgXQoWzp3bJK7FvHIYL4HX7T9Fq9kmZIimG
         FALw==
X-Gm-Message-State: APjAAAUPAvutdSJbvWJLNPXxV2rGtvpFEEQSZDU/LztChllZJmBeOnKl
        iLX4oBxI3rQXV+uJ0fIwZEI=
X-Google-Smtp-Source: APXvYqyRd9iRBgrT+ppvjw2zSNFBzwCbz5lZMd8Rs46/h3SHdhCglQoaHGh97NTkcGKWTFWLWStV/w==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr4218144wrt.227.1560369577258;
        Wed, 12 Jun 2019 12:59:37 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:36 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 06/14] pwm: meson: pass struct pwm_device to meson_pwm_calc()
Date:   Wed, 12 Jun 2019 21:59:03 +0200
Message-Id: <20190612195911.4442-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

meson_pwm_calc() is the last function that accepts a struct
meson_pwm_channel. meson_pwm_enable(), meson_pwm_disable() and
meson_pwm_apply() for example are all taking a struct pwm_device as
parameter. When they need the struct meson_pwm_channel these functions
simply call pwm_get_chip_data() internally.

Make meson_pwm_calc() consistent with the other functions in the
meson-pwm driver by passing struct pwm_device to it as well. The value
of the "id" parameter is actually pwm->hwpwm, but the driver never read
the "id" parameter, which is why there's no replacement for it in the
new code.

No functional changes.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 39ea119add7b..d6eb4d04d5c9 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -114,10 +114,10 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 		clk_disable_unprepare(channel->clk);
 }
 
-static int meson_pwm_calc(struct meson_pwm *meson,
-			  struct meson_pwm_channel *channel,
+static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  struct pwm_state *state)
 {
+	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	unsigned int duty, period, pre_div, cnt, duty_cnt;
 	unsigned long fin_freq = -1;
 	u64 fin_ps;
@@ -280,7 +280,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period != channel->state.period ||
 	    state->duty_cycle != channel->state.duty_cycle ||
 	    state->polarity != channel->state.polarity) {
-		err = meson_pwm_calc(meson, channel, state);
+		err = meson_pwm_calc(meson, pwm, state);
 		if (err < 0)
 			return err;
 
-- 
2.22.0

