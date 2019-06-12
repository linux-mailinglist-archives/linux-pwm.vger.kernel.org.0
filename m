Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBD514309C
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390170AbfFLT7r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39325 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390069AbfFLT7q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so15577492wrt.6;
        Wed, 12 Jun 2019 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ozFqFrdOls/tbyfpKPSUD8IXeIqprLYFvxWmhrpcf0=;
        b=hJezs/mhpUzuwKDYnDTkffQSPj1qlqYWTxHyZZCyJGmz9yMf9DCeczOxzmFpD6p02W
         MQ1+rm+WsLeepWr2BiRIvZBMLF4USVKGFSr11rnqEs9XAA6/sdkbic8gz+bSvLuFYkvG
         +eIF+Ta7P+wDId7ny7OtptjJYPXgdVDTzAp7NvYx/o+4id+3a9qlRB09XwADiEWSBmoP
         ZpKVkZumu8yg/mdo5k/swfiCD7e+dMkmGIb51cJAVAVxSJKLnlv65x2rkqVQKFhzEdfF
         Yuyo1AKdxn0C8JFSg31K4H/ZeJn2+6665p5jWIn+3PKlEgzaMLnS0CxLDDuIe4RoRsYp
         HW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ozFqFrdOls/tbyfpKPSUD8IXeIqprLYFvxWmhrpcf0=;
        b=JSBYMwDOmWhCrKJ8BjQrKnn57IqIZEYauSDYbsHPX2EEsxYb5h5cdHPGFNM/3TlAQ0
         TS90sd4ef8j694GKbS8O7bo+P5DTfs84mcXENd6c8WVWr7i3y/aZxWWU6gICtCQQ9p8c
         HZkvrZVwboiKARyMgvylb5+HpqtwNLK1TVwOHgeUyVyuLyQrMXUjrBjGGH32WVvgbEAp
         slR9W2eCg3ClaHw4luzZvjmeJza/1tjNXYGIqq/adSftNOQrcJGHJjoFMD2MreMscCsc
         E3AvklXSa8sEs1394vrPJBjnPE7N2/EP11yqY5wMjU7O4dZHaPxi3mrGaxLTQo06ekrR
         kkaQ==
X-Gm-Message-State: APjAAAWgkm+YZnmtgPdIH60lFhXEqyj/xfeEuH13Tfwzb/lTO68xVf6U
        qKuvpETqy1pbta8RXOk8p2Xj8Ls3
X-Google-Smtp-Source: APXvYqx+I2z01ZACLWNFwKG9uP3GcaI25PwRYsbOfOhifupPiCs73U78vFKZDu77frhlBoTC9raCUg==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr9218749wrn.168.1560369584977;
        Wed, 12 Jun 2019 12:59:44 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 13/14] pwm: meson: add support PWM_POLARITY_INVERSED when disabling
Date:   Wed, 12 Jun 2019 21:59:10 +0200
Message-Id: <20190612195911.4442-14-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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
2.22.0

