Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE33A10C
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFHSHC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:07:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39626 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfFHSGt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so4679559wma.4;
        Sat, 08 Jun 2019 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gus9EVUSXiif9myhzplFWmWxo5iVjcg4L/R7PzfQr/4=;
        b=aC3QJv4yV2M2NgE+T6iUkKFAXQ4b82UbBPPWeG20gvtlZaDZHm3hTWpaeGbwCRPmnh
         tCrc1f60ZSqkOlQ7wiEvVW5FMKplDfQM6TJRDMM7fMvvbIBfRyf+Vq/Z0jQLJubciKMt
         kqTMk5ZpTVpEDBPQnRlznSLsUQ6wHGBe8LfcF6sWel+B/tfcmJlrXabelYHCkfjqpJmq
         sPFobFtjwwPwPpbw7ss0q3uaMjBfUFuGxp9gN33lDkGl+oJ7QRB0S+51GZQl4clO46vF
         EOtSTUEgT089LkWHdq5C0jFy1quBzOWByO2XO/EU0FcYpXn3kLcdyQlWRx8IiBIKs22z
         CLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gus9EVUSXiif9myhzplFWmWxo5iVjcg4L/R7PzfQr/4=;
        b=B44vVnbXPQH5KjFRJTk0T0cR+IEQyGK4tNL3h1yzEoSMEQ0SB/7ReJnlB0kp/89vVC
         ivRgiX/IJix58RsBurp/+igiDGdPaCNqK5+p9EihaRMezI8O2m/MbvIHRQqRbnkT7hCC
         qD2gVDFFKXHFU0keN+Q6dJp5M+sU9keA10+M518VAlQWfCGjTJjW3y2jO59GUOFXCuGR
         XdYnL4n4EfZ+tPu7EpaWBD0aGpfck/dJc+hMvMbaEE/L0J0u+Ten1oHp+EGRqiXbJDAj
         4uudUcHW6opsfDDfFJ/JeZFDj93kZ/yxlGekcNDkvYLXljGCIC4Tsnfk5gedX9WEBr94
         /xwA==
X-Gm-Message-State: APjAAAVCi1cITNQab+wTJfvzfq/h7+2FUwpIdELvo+F3uewqhU/wiVAH
        R+AwBiXVKuV5lSoigz3O8kw=
X-Google-Smtp-Source: APXvYqzRGcVvHTQ7ACECA1v/MRk4nF9YNeywKueh0QL3/1P6th9zfIq6Kc07vu6eLxFOilV6x/wiNw==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr7924649wme.95.1560017207452;
        Sat, 08 Jun 2019 11:06:47 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:46 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 13/14] pwm: meson: add support PWM_POLARITY_INVERSED when disabling
Date:   Sat,  8 Jun 2019 20:06:25 +0200
Message-Id: <20190608180626.30589-14-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

meson_pwm_apply() has to consider the PWM polarity when disabling the
output.
With enabled=false and polarity=PWM_POLARITY_NORMAL the output needs to
be LOW. The driver already supports this.
With enabled=false and polarity=PWM_POLARITY_INVERSED the output needs
to be HIGH. Implement this in the driver by internally enabling the
output with the same settings that we already use for "period == duty".

This fixes a PWM API violation which expects that the driver honors the
polarity also for enabled=false. Due to the IP block not supporting this
natively we only get "an as close as possible" to 100% HIGH signal (in
my test setup with input clock of 24MHz and measuring the output with a
logic analyzer at 24MHz sampling rate I got a duty cycle of 99.998475%
on a Khadas VIM).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 900d362ec3c9..bb48ba85f756 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -245,6 +245,7 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   struct pwm_state *state)
 {
+	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	int err = 0;
 
@@ -252,7 +253,27 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		meson_pwm_disable(meson, pwm);
+		if (state->polarity == PWM_POLARITY_INVERSED) {
+			/*
+			 * This IP block revision doesn't have an "always high"
+			 * setting which we can use for "inverted disabled".
+			 * Instead we achieve this using the same settings
+			 * that we use a pre_div of 0 (to get the shortest
+			 * possible duration for one "count") and
+			 * "period == duty_cycle". This results in a signal
+			 * which is LOW for one "count", while being HIGH for
+			 * the rest of the (so the signal is HIGH for slightly
+			 * less than 100% of the period, but this is the best
+			 * we can achieve).
+			 */
+			channel->pre_div = 0;
+			channel->hi = ~0;
+			channel->lo = 0;
+
+			meson_pwm_enable(meson, pwm);
+		} else {
+			meson_pwm_disable(meson, pwm);
+		}
 	} else {
 		err = meson_pwm_calc(meson, pwm, state);
 		if (err < 0)
-- 
2.21.0

