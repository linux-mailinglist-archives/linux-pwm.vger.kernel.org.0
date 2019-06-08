Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5415A3A114
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfFHSHV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:07:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51376 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfFHSGl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so48185wma.1;
        Sat, 08 Jun 2019 11:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8gcZ7g6SZecaItbHxibQT2XcvF7LxO5AUSQLLhQn3s=;
        b=Uzj3vu/OW9/CR/8CE259GRohUZutqH35BBlg2VgqpcuTLlMkRYRgIIhD1+MO+5/iAc
         ioOI2XtVxuqt7hT1Vav9hCm3LR8AEk03uvyDKvitdv+VtQC6mXDBkihPScFN0xiNMAQR
         qSXJf1czVXvHL67Z1CIG7Qi7TH/MGSDmvj8g2lrnf5JKrN03ndOj0/HVhhTSJKwiMQZX
         5uD5ssP9kOj18DO54FdPmlYtL32qKnZfdJI4cWd4hiBy8JvsJDnl+oJQOPmlmhnFvFwX
         dNuRRnTCwNjVYVNGyLyJKBkqOK5S0NPIbezwCzxSbSjrGzR/mzihY8E28mVSDXD0/1TA
         gthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8gcZ7g6SZecaItbHxibQT2XcvF7LxO5AUSQLLhQn3s=;
        b=axg41Oh6nMsgZnlg1BrkPo2cBrIW1BtuqhSJya2Folb54WVghUa2lor4BifAleJ7eK
         VyYT9Biw08QgpCZd7szLoEp1ieym7b5+DkOmaDEQoVikWx1SVIPJ40wFi//f70MhEQ0I
         jOU9xZnoNiJSIQsj0+ZdJgc9x+uHQbe8HI1LFc7cOZ/f+dDOKBrgiiDQaKcJLjIE1s/j
         WOxqs5ry9d4GFxjjhz8vK+QUbg4iNFg8kT7d3OtPxcBdEIp7t6/a/S4GkVphPrjBdmlD
         zksf2dnwBges9cmEc54ndyf2IYWUUZwaRgiCfqq8tQZUY8U+P8JajyBoiZuuN5tZNOC1
         cv4w==
X-Gm-Message-State: APjAAAWzwxbFKeb20o2wYK2c4lD80T9f6mwzCJME1O+WW3nfJY4dcnLz
        /NjE3zQwBcxFYB3GnIthDxw=
X-Google-Smtp-Source: APXvYqxl0lqew1WyedVbrTnaPnS2DMqwoLTa6KuMO3KeqkeWq2hFRkU8aYGCrR+F/9hsRbf3kHKoXw==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74mr8031837wmg.43.1560017199160;
        Sat, 08 Jun 2019 11:06:39 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:38 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 05/14] pwm: meson: don't duplicate the polarity internally
Date:   Sat,  8 Jun 2019 20:06:17 +0200
Message-Id: <20190608180626.30589-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let meson_pwm_calc() use the polarity from struct pwm_state directly.
This removes a level of indirection where meson_pwm_apply() first had to
set a driver-internal inverter mask which was then only used by
meson_pwm_calc().

Instead of adding the polarity as parameter to meson_pwm_calc() switch
to struct pwm_state directly to make it easier to see where the
parameters are actually coming from.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 84b28ba0f903..39ea119add7b 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -63,7 +63,6 @@ struct meson_pwm {
 	struct pwm_chip chip;
 	const struct meson_pwm_data *data;
 	void __iomem *base;
-	u8 inverter_mask;
 	/*
 	 * Protects register (write) access to the REG_MISC_AB register
 	 * that is shared between the two PWMs.
@@ -116,14 +115,17 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static int meson_pwm_calc(struct meson_pwm *meson,
-			  struct meson_pwm_channel *channel, unsigned int id,
-			  unsigned int duty, unsigned int period)
+			  struct meson_pwm_channel *channel,
+			  struct pwm_state *state)
 {
-	unsigned int pre_div, cnt, duty_cnt;
+	unsigned int duty, period, pre_div, cnt, duty_cnt;
 	unsigned long fin_freq = -1;
 	u64 fin_ps;
 
-	if (~(meson->inverter_mask >> id) & 0x1)
+	duty = state->duty_cycle;
+	period = state->period;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
 		duty = period - duty;
 
 	if (period == channel->state.period &&
@@ -278,15 +280,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period != channel->state.period ||
 	    state->duty_cycle != channel->state.duty_cycle ||
 	    state->polarity != channel->state.polarity) {
-		if (state->polarity != channel->state.polarity) {
-			if (state->polarity == PWM_POLARITY_NORMAL)
-				meson->inverter_mask |= BIT(pwm->hwpwm);
-			else
-				meson->inverter_mask &= ~BIT(pwm->hwpwm);
-		}
-
-		err = meson_pwm_calc(meson, channel, pwm->hwpwm,
-				     state->duty_cycle, state->period);
+		err = meson_pwm_calc(meson, channel, state);
 		if (err < 0)
 			return err;
 
@@ -520,7 +514,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	meson->chip.of_pwm_n_cells = 3;
 
 	meson->data = of_device_get_match_data(&pdev->dev);
-	meson->inverter_mask = BIT(meson->chip.npwm) - 1;
 
 	channels = devm_kcalloc(&pdev->dev, meson->chip.npwm,
 				sizeof(*channels), GFP_KERNEL);
-- 
2.21.0

