Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8899C2A64A
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfEYSMd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:12:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40749 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfEYSL7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:11:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so12046008wmg.5;
        Sat, 25 May 2019 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oGmx4EPee47ZcnAwDDemernEH2nzHCt+ROW/DzQRqH4=;
        b=NLjJV2J0js50+wwDSBN8P3m7XcjsHo8yqeLMaiBAwg5FW+Up2vKGQV0dKoyFT4UXAa
         siH1WlwloOBvqzH32foCJ/epwz61M5yX6TLfRv9o615KmxHQ8Xw5rc2ahEciTImkGFjr
         LGHIieMVbRQiw5h4qWM584X8DuCqJfd/ySn30BOGD1vRgoDN1Ophe9fAzHmhtQNo/nil
         8FD4TUn/ZtIJXhl3gy1GmdxJvD95z2y+n+Y/js4E8+GIETsqZFLnH6ejlAZRiJ8oNYXu
         12t/vknGV4hM0IXIjVnSj0T+Pk9cWjjbxtUILt04A0FLFTD9tR6asqRlaPPHiHr1N2Gj
         iKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGmx4EPee47ZcnAwDDemernEH2nzHCt+ROW/DzQRqH4=;
        b=MfreqUmXlDh5jvPPOVckQgrmg64of4u6Mt3+lONEN+y+qwRET0WbmLrxLOIIl7Y9sI
         +yJMnM1RCCRXxP8lucneKzhpNzQ9gV+rjBok6qtuXo94CxJKrNelgYDrV/k+SUno1U2q
         EN6hdwQlAzWFWl1lLmhuwh3zoPsbaTcsR+a/9HTrny2phAX+1UKFqeDwj6FTD5ADEq2e
         cRIw+rMHJ6llrgldIBLVI5rw9JvaUo2lSyjSa1lyWAhZAAIWI+tadVY5qN6D0/GTad3v
         X/nkaTY374Zr4AtsoV14pruQw8PzqS+cy2c+tzFWtYHTLUw3p1rUm+6Hz3A/e9Y1wRgj
         3BwA==
X-Gm-Message-State: APjAAAX7Y25slNKHj7FK+/LOJxhVt9KWyFwDDxjfrQUpFzs4WZ8faas4
        qtvVnNKtyyZmgAIExeWa4oM=
X-Google-Smtp-Source: APXvYqxQULktAEL5DQ5YwcPwKLm/Q3r7ZI5mvk1sKtDOcewCJUj8+P0/kbO8Gvty/fop1JttdwlRqQ==
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr4034024wml.172.1558807916826;
        Sat, 25 May 2019 11:11:56 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:56 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 11/14] pwm: meson: read the full hardware state in meson_pwm_get_state()
Date:   Sat, 25 May 2019 20:11:30 +0200
Message-Id: <20190525181133.4875-12-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
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

