Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4EB3A113
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfFHSHQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:07:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38297 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfFHSGp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so2232896wmj.3;
        Sat, 08 Jun 2019 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kOkFbu7Keyup8NSOgjduYXjsH/7xYfvaup38HVdoTI8=;
        b=t8KaWkhwgi43KZmS0c+ekfNGTUipDxJRBGfizchn4hnyD2OJ1PHMCmPPlZVvHqq1BA
         epuDC8ersvwklntb3JmERtfZCIFWJVDDcTKa2jlsi9Y2F8PeSWiNbproVIUqvPPZ0j4z
         XnDU+QUZYEoN4HJKkThGB5ztCA3INuN8bn3MylF/0mNHn5mK3si0uM3Knt0NrJcZedsA
         JuSPOLAMdoYmlYnp1enR9Awk2ycWofVoPYP6cM1hmZkRk2qaP7HWDanZNXdgc0Ws+T6t
         qtbUZnLk5J5L9qeOWn/ZsGJ2Dw/JelNbe4RBoDcQHZZbRFF2y9/zj8W/uDcTE+jBdDyJ
         C7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOkFbu7Keyup8NSOgjduYXjsH/7xYfvaup38HVdoTI8=;
        b=JjCEuNesdaJbXRx0/lIRtFz0ZOftTrGXLq2EofUJzUtfhhE+JKZimoYhtG5DcEggpS
         D18pSYCVKzqmRhuI1O83E66Ku6RivJMeIrRq9axUleXTjkRbPte+4XIpPh4Q5jd3++iO
         5WT5TqDoCwHPiA8oKJQ/FyiveseWGeSqQoRca1NyF5eDDtCI87r1RtNwiGKSxZPSc5I/
         bbr1FwybPZ1i4M4cpRiooxWZEnuLeSyu3/ne7RB/5GZWJus2lIzUcGRsggE98sKFbIWM
         H30gkX2hxMII0on3eAaOANhHOjCy829/B/Jh1svu4OmIwfTaOIldTbS7hyTRQeAEuRUH
         sfhw==
X-Gm-Message-State: APjAAAVPjLjsRiZQ+gq+Wu11vJaW/+PbpTLTtpeRmM14Rw8EUA1diKHF
        RIH5r9c/1jEItrmAc+CH+CN2shgF
X-Google-Smtp-Source: APXvYqy/omBZ6sRYBAoPHP6FTJXnGXl4Kq2DSI3n1+vPxlevi/KhkeeRZcvOHtq/ny8G5WkhnfgsnA==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr7153695wmj.99.1560017202312;
        Sat, 08 Jun 2019 11:06:42 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 08/14] pwm: meson: add the per-channel register offsets and bits in a struct
Date:   Sat,  8 Jun 2019 20:06:20 +0200
Message-Id: <20190608180626.30589-9-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Introduce struct meson_pwm_channel_data which contains the per-channel
offsets for the PWM register and REG_MISC_AB bits. Replace the existing
switch (pwm->hwpwm) statements with an access to the new struct.

This simplifies the code and will make it easier to implement
pwm_ops.get_state() because the switch-case which all per-channel
registers and offsets (as previously implemented in meson_pwm_enable())
doesn't have to be duplicated.

No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pwm/pwm-meson.c | 90 ++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 56 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index a4ae3587a3ce..ac7e188155fd 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -39,9 +39,27 @@
 
 #define MESON_NUM_PWMS		2
 
-static const unsigned int mux_reg_shifts[] = {
-	MISC_A_CLK_SEL_SHIFT,
-	MISC_B_CLK_SEL_SHIFT
+static struct meson_pwm_channel_data {
+	u8		reg_offset;
+	u8		clk_sel_shift;
+	u8		clk_div_shift;
+	u32		clk_en_mask;
+	u32		pwm_en_mask;
+} meson_pwm_per_channel_data[MESON_NUM_PWMS] = {
+	{
+		.reg_offset	= REG_PWM_A,
+		.clk_sel_shift	= MISC_A_CLK_SEL_SHIFT,
+		.clk_div_shift	= MISC_A_CLK_DIV_SHIFT,
+		.clk_en_mask	= MISC_A_CLK_EN,
+		.pwm_en_mask	= MISC_A_EN,
+	},
+	{
+		.reg_offset	= REG_PWM_B,
+		.clk_sel_shift	= MISC_B_CLK_SEL_SHIFT,
+		.clk_div_shift	= MISC_B_CLK_DIV_SHIFT,
+		.clk_en_mask	= MISC_B_CLK_EN,
+		.pwm_en_mask	= MISC_B_EN,
+	}
 };
 
 struct meson_pwm_channel {
@@ -194,43 +212,26 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
 	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
-	u32 value, clk_shift, clk_enable, enable;
-	unsigned int offset;
+	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
+	u32 value;
 
-	switch (pwm->hwpwm) {
-	case 0:
-		clk_shift = MISC_A_CLK_DIV_SHIFT;
-		clk_enable = MISC_A_CLK_EN;
-		enable = MISC_A_EN;
-		offset = REG_PWM_A;
-		break;
-
-	case 1:
-		clk_shift = MISC_B_CLK_DIV_SHIFT;
-		clk_enable = MISC_B_CLK_EN;
-		enable = MISC_B_EN;
-		offset = REG_PWM_B;
-		break;
-
-	default:
-		return;
-	}
+	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
 
 	spin_lock_irqsave(&meson->lock, flags);
 
 	value = readl(meson->base + REG_MISC_AB);
-	value &= ~(MISC_CLK_DIV_MASK << clk_shift);
-	value |= channel->pre_div << clk_shift;
-	value |= clk_enable;
+	value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
+	value |= channel->pre_div << channel_data->clk_div_shift;
+	value |= channel_data->clk_en_mask;
 	writel(value, meson->base + REG_MISC_AB);
 
 	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
 		FIELD_PREP(PWM_LOW_MASK, channel->lo);
-	writel(value, meson->base + offset);
+	writel(value, meson->base + channel_data->reg_offset);
 
 	value = readl(meson->base + REG_MISC_AB);
-	value |= enable;
+	value |= channel_data->pwm_en_mask;
 	writel(value, meson->base + REG_MISC_AB);
 
 	spin_unlock_irqrestore(&meson->lock, flags);
@@ -238,26 +239,13 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 
 static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 {
-	u32 value, enable;
 	unsigned long flags;
-
-	switch (pwm->hwpwm) {
-	case 0:
-		enable = MISC_A_EN;
-		break;
-
-	case 1:
-		enable = MISC_B_EN;
-		break;
-
-	default:
-		return;
-	}
+	u32 value;
 
 	spin_lock_irqsave(&meson->lock, flags);
 
 	value = readl(meson->base + REG_MISC_AB);
-	value &= ~enable;
+	value &= ~meson_pwm_per_channel_data[pwm->hwpwm].pwm_en_mask;
 	writel(value, meson->base + REG_MISC_AB);
 
 	spin_unlock_irqrestore(&meson->lock, flags);
@@ -309,18 +297,7 @@ static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!state)
 		return;
 
-	switch (pwm->hwpwm) {
-	case 0:
-		mask = MISC_A_EN;
-		break;
-
-	case 1:
-		mask = MISC_B_EN;
-		break;
-
-	default:
-		return;
-	}
+	mask = meson_pwm_per_channel_data[pwm->hwpwm].pwm_en_mask;
 
 	value = readl(meson->base + REG_MISC_AB);
 	state->enabled = (value & mask) != 0;
@@ -458,7 +435,8 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		init.num_parents = meson->data->num_parents;
 
 		channel->mux.reg = meson->base + REG_MISC_AB;
-		channel->mux.shift = mux_reg_shifts[i];
+		channel->mux.shift =
+				meson_pwm_per_channel_data[i].clk_sel_shift;
 		channel->mux.mask = MISC_CLK_SEL_MASK;
 		channel->mux.flags = 0;
 		channel->mux.lock = &meson->lock;
-- 
2.21.0

