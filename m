Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128E03A106
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFHSGr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:06:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39624 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfFHSGr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so4679513wma.4;
        Sat, 08 Jun 2019 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brzPVQYJGO5+8pQRVV1qIooN3xRwnjhrtAnJ9r3iNOY=;
        b=D/4RsKmz0dAGeE7le8UugYLcUi/q/08AKyLYw034gyyUTG2UnreTOfwxzk/KJu/+eJ
         si2x16KSj0Dug6WijoeyeTf9UP+m5GEk4oaWLq2VduPcp8SKK4L15IkTC+clRcdFiVlb
         w/5d9rSLIiIG0FvG/g10eSe9bKQrWMdH+UGfe6ixk9mUF8hCl3JoZmiASyGgGtM1/YQL
         vyKlFJ86kuShoUqStQheLbR8rMYhuMoVzR862F7gfEMirLwtlbqUmz3U29pnfS1R3U4U
         OyfUzDG0StsSejZNrAc7V4spjYy76C+DlffoHZ0Do7MBtKs8dnk4RKmy3K1z7E6pWs8X
         B+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brzPVQYJGO5+8pQRVV1qIooN3xRwnjhrtAnJ9r3iNOY=;
        b=WDeVf5VoVPdKj6eJtSzufYDvB5yKzDRGJiQ7CT/dCuiGYGPA5tKJdz5b5hdFg+cbTP
         EwQsSLhzFpdiE7S0CdnEQmD6frM7SobLG1Mz8QEBHGecmVpBx6ER0ZAR/rL8wARAbfYc
         k0TSpSJ1pdM9C7EYigRu6/xh9QWjv2BLDw13ZEvRexYaiblfwrGJUaDqGNBF1wF2Q3q+
         gH7Gk/ki3Srnbf+DNlMrOZ0zspqsicfLpxmwubq3MFt0NIupRziyk0ynnQFARgkopv3H
         QGNn/UeYJfcFkCCOrrcu+cEIgY+QsXl34mzNG/RjOnFJLjWmJfH8vdbCXOzPg8G0QGff
         QH/w==
X-Gm-Message-State: APjAAAWFfuoOBZMNpONWbmftAEnJIzzo89WDRAdMXEcj9M9ih/H0vpZA
        fJSjHFxNnSm0nxlTT0XBBSU=
X-Google-Smtp-Source: APXvYqx37P1AY7EEr7qrvDbgENYYECOqQftclIqpO+G5gI//TwwFkpfqgIcpB8LgchQYDvPTDT+A/A==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr7763216wmg.112.1560017205383;
        Sat, 08 Jun 2019 11:06:45 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:44 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 11/14] pwm: meson: read the full hardware state in meson_pwm_get_state()
Date:   Sat,  8 Jun 2019 20:06:23 +0200
Message-Id: <20190608180626.30589-12-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update the meson_pwm_get_state() implementation to take care of all
information in the registers instead of only reading the "enabled"
state.

The PWM output is only enabled if two conditions are met:
1. the per-channel clock is enabled
2. the PWM output is enabled

Calculate the PWM period and duty cycle using the reverse formula which
we already have in meson_pwm_calc() and update struct pwm_state with the
results.

As result of this /sys/kernel/debug/pwm now shows the PWM state set by
the bootloader (or firmware) after booting Linux.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 52 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 9afa1e5aaebf..010212166d5d 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -287,19 +287,65 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static unsigned int meson_pwm_cnt_to_ns(struct pwm_chip *chip,
+					struct pwm_device *pwm, u32 cnt)
+{
+	struct meson_pwm *meson = to_meson_pwm(chip);
+	struct meson_pwm_channel *channel;
+	unsigned long fin_freq;
+	u32 fin_ns;
+
+	/* to_meson_pwm() can only be used after .get_state() is called */
+	channel = &meson->channels[pwm->hwpwm];
+
+	fin_freq = clk_get_rate(channel->clk);
+	if (fin_freq == 0)
+		return 0;
+
+	fin_ns = div_u64(NSEC_PER_SEC, fin_freq);
+
+	return cnt * fin_ns * (channel->pre_div + 1);
+}
+
 static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
-	u32 value, mask;
+	struct meson_pwm_channel_data *channel_data;
+	struct meson_pwm_channel *channel;
+	u32 value, tmp;
 
 	if (!state)
 		return;
 
-	mask = meson_pwm_per_channel_data[pwm->hwpwm].pwm_en_mask;
+	channel = &meson->channels[pwm->hwpwm];
+	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
 
 	value = readl(meson->base + REG_MISC_AB);
-	state->enabled = (value & mask) != 0;
+
+	tmp = channel_data->pwm_en_mask | channel_data->clk_en_mask;
+	state->enabled = (value & tmp) == tmp;
+
+	tmp = value >> channel_data->clk_div_shift;
+	channel->pre_div = FIELD_GET(MISC_CLK_DIV_MASK, tmp);
+
+	value = readl(meson->base + channel_data->reg_offset);
+
+	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
+	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
+
+	if (channel->lo == 0) {
+		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
+		state->duty_cycle = state->period;
+	} else if (channel->lo >= channel->hi) {
+		state->period = meson_pwm_cnt_to_ns(chip, pwm,
+						    channel->lo + channel->hi);
+		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
+							channel->hi);
+	} else {
+		state->period = 0;
+		state->duty_cycle = 0;
+	}
 }
 
 static const struct pwm_ops meson_pwm_ops = {
-- 
2.21.0

