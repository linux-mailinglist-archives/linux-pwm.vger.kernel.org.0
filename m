Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18FC430A0
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbfFLT77 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52868 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389772AbfFLT7o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so7807645wms.2;
        Wed, 12 Jun 2019 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RV+OLObvzmYIBVmEezNfCuTw9H3cY6vNxRlWZtxojAU=;
        b=DlhpIRTJ4MdcQchNiyAt/oB5rLRGKiZHbqyN3SwrK0qIm+7uLb9uVPkOuxnyX7dN/a
         2fuu2FenVNwgYZbkbojWBw8tPpuwDjyvMHzbw6CTOF7fYep6VxeZWmtqWtehYuUtG0Rq
         ruFbBS4CmXLY4hKpwu7HH28kfrqGz21IaQUXV4DkVXCp6P87jgHfAJ1gyU+6AnPuIs8g
         fW/YwIulCT9AX3Ph4OEqbe9oC3xrTba6UViLwePqmBBOIMnKXa5rj9SHFgWtLJQoTMZ5
         Scpm3w3GveBKhLsc9fnSs2s2EAUWRBYXhP4VQjPnSInl+BiZCiuqX7lGa9C9WskJsg7I
         WYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RV+OLObvzmYIBVmEezNfCuTw9H3cY6vNxRlWZtxojAU=;
        b=tNXHmY19t1kG/p/VJ1hdHSsA7KysdjOfVEqvfnbU6W8xoO08sUsF51Ue/81/BQqouN
         wErfb5zoON9EoXoHBeVTct1H+yDGnuP0tHNnTPrKgXlUwK3OHEJ1XRCfZHkv/7aDsOaA
         rE4cppVuuyLj5D6pjbo9MuAlHNneN+pOSe11VNIdcZwgfXQTOUig7jnaeejqAqdH3mfj
         5XFeRTJgcl35Bce8uDw0PWZedApu1Y3W1ssBQzdWQtZV9Xg7ujPs9f9yek7MbphfYaYX
         jNXgMzpnF7b6dEdXGWIRu9orTrcdp1s9nXVuXUYLIwmeAkhTaFi5Trln36A6U+U+cwKG
         7foQ==
X-Gm-Message-State: APjAAAUvF7WJwgX3A8JuwOOjfYXIYur4ORXBX66pwNAKz86ZVgbUnDjd
        5X5LTFYF90DtyFsNan0BMWU=
X-Google-Smtp-Source: APXvYqw0FeAFhC+xg04qzQEZj95492ycLUOllcqQJRybPLbEwc0eA1L6Lx+qvhOOeKWQk3rpbn7+aQ==
X-Received: by 2002:a1c:808b:: with SMTP id b133mr581640wmd.160.1560369582613;
        Wed, 12 Jun 2019 12:59:42 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:42 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 11/14] pwm: meson: read the full hardware state in meson_pwm_get_state()
Date:   Wed, 12 Jun 2019 21:59:08 +0200
Message-Id: <20190612195911.4442-12-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
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

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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
2.22.0

