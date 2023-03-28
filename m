Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C826CCBBB
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Mar 2023 22:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjC1U7z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Mar 2023 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC1U7v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Mar 2023 16:59:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90B1BFF
        for <linux-pwm@vger.kernel.org>; Tue, 28 Mar 2023 13:59:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i9so13563115wrp.3
        for <linux-pwm@vger.kernel.org>; Tue, 28 Mar 2023 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680037188;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0LkwcHKxJlPAZYVPEvwzvc5AODwtMll4Ug2i1zf+8Y=;
        b=DwVTOfezB1bsliQxPVoLYdQTqU+vXHR2FHoN6Z48+E1MMwlaISDtlaxFokg8M9Hmh8
         ERfTuabYWtmGnlgwOAFjA8nEoEDMb5FphWa9MTZOMjkihIiKuiL6GwvtUM5nPU5gkfNK
         qmi+XrALiTyr+Ps+BbOsF8eM4FJpYtGFBlGETQkruo+C773o5Fc1JP35jHq65kZW3ii+
         YbnLj5GwhaCHIoACZITaMIMVv4rLn+2MX9BJZ/+hDysBZpOWVTbi7+FYkQX+VytukteH
         wVb+FXTmx5tmEnn3qM2zRFmC3ELDZJviKGAoNpBXJckd5+jy3dG2xE8KaxzYuPr8cceJ
         C0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680037188;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x0LkwcHKxJlPAZYVPEvwzvc5AODwtMll4Ug2i1zf+8Y=;
        b=ObD6TpG2pQSBeZJbOOivCWZot935J3iEIbz0kIRHhVxh6qpcQlCxNHXDkZjJ02kzfZ
         rJPwIaKRRPxMQ8X1jWZgIbcQ54zkhzovhVM7Sj3ZSVE3ssyiZE+g2fC/FNfsy+F3PBAi
         vExNTYNR0MgvLwliR0pOpgoYbI+J85TC7jFd4IUl2/oLfHSWg/xSHOgSAbXI5JhOijfe
         iy3RoCVewNons/kweorrgaPdmnaT/jJBopwqSrpl8EMadCqIrr//hC7rM7ePKZEpt1zH
         n/geRiGBHlbJEP7e6PcGl2ek5wXnKqzX6KmPrA+dCEghNWadE5bqynBfNlvfwYP7Jmnz
         CPRg==
X-Gm-Message-State: AAQBX9diYXiv7ehdNaoLen1cqw5zIvs59fEJpCv40Xlek7Ep9faGOpb4
        QXlFYxhL8viwGk3X/BcwBZs=
X-Google-Smtp-Source: AKy350Y6Z5gaDeLQ/HZwhHPCPPBwM4gCu8vo6U3YjC1IFS7WKA14ueKUebqkZ6sR/V/6Zq3Vll4cJQ==
X-Received: by 2002:adf:e98d:0:b0:2cf:f0c3:79c1 with SMTP id h13-20020adfe98d000000b002cff0c379c1mr13174203wrm.67.1680037188389;
        Tue, 28 Mar 2023 13:59:48 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c121:f800:1c72:2511:8eab:ad9d? (dynamic-2a01-0c23-c121-f800-1c72-2511-8eab-ad9d.c23.pool.telefonica.de. [2a01:c23:c121:f800:1c72:2511:8eab:ad9d])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d510d000000b002c794495f6fsm25403955wrt.117.2023.03.28.13.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 13:59:47 -0700 (PDT)
Message-ID: <abf03223-5745-0c79-7840-176c551134c5@gmail.com>
Date:   Tue, 28 Mar 2023 22:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC/RFT] pwm: meson: make full use of common clock framework
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Newer versions of the PWM block use a core clock with external mux,
divider, and gate. These components either don't exist any longer in
the PWM block, or they are bypassed.
To minimize needed changes for supporting the new version, the internal
divider and gate should be handled by CCF too.

I didn't see a good way to split the patch, therefore it's somewhat
bigger. What it does:

- The internal mux is handled by CCF already. Register also internal
  divider and gate with CCF, so that we have one representation of the
  input clock: [mux] parent of [divider] parent of [gate]
  
- Now that CCF selects an appropriate mux parent, we don't need the
  DT-provided default parent any longer. Accordingly we can also omit
  setting the mux parent directly in the driver.
  
- Instead of manually handling the pre-div divider value, let CCF
  set the input clock. Targeted input clock frequency is
  0xffff * 1/period for best precision.
  
- For the "inverted pwm disabled" scenario target an input clock
  frequency of 1GHz. This ensures that the remaining low pulses
  have minimum length.

I don't have hw with the old PWM block, therefore I couldn't test this
patch. With the not yet included extension for the new PWM block
(channel->clock directly coming from get_clk(external_clk)) I didn't
notice any problem. My system uses PWM for the CPU voltage regulator
and for the SDIO 32kHz clock.

Note: The clock gate in the old PWM block is permanently disabled.
This seems to indicate that it's not used by the new PWM block.

I'd appreciate testing on the different platforms using the old
PWM block.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 133 +++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 57 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 16d79ca5d..2b1debda4 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -86,12 +86,13 @@ static struct meson_pwm_channel_data {
 };
 
 struct meson_pwm_channel {
+	unsigned long rate;
 	unsigned int hi;
 	unsigned int lo;
-	u8 pre_div;
 
-	struct clk *clk_parent;
 	struct clk_mux mux;
+	struct clk_divider div;
+	struct clk_gate gate;
 	struct clk *clk;
 };
 
@@ -124,16 +125,6 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct device *dev = chip->dev;
 	int err;
 
-	if (channel->clk_parent) {
-		err = clk_set_parent(channel->clk, channel->clk_parent);
-		if (err < 0) {
-			dev_err(dev, "failed to set parent %s for %s: %d\n",
-				__clk_get_name(channel->clk_parent),
-				__clk_get_name(channel->clk), err);
-			return err;
-		}
-	}
-
 	err = clk_prepare_enable(channel->clk);
 	if (err < 0) {
 		dev_err(dev, "failed to enable clock %s: %d\n",
@@ -156,8 +147,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	unsigned int duty, period, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 freq;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -165,7 +157,11 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	if (state->polarity == PWM_POLARITY_INVERSED)
 		duty = period - duty;
 
-	fin_freq = clk_get_rate(channel->clk);
+	freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
+	if (freq > ULONG_MAX)
+		freq = ULONG_MAX;
+
+	fin_freq = clk_round_rate(channel->clk, freq);
 	if (fin_freq == 0) {
 		dev_err(meson->chip.dev, "invalid source clock frequency\n");
 		return -EINVAL;
@@ -173,46 +169,35 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
 
-	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
-	if (pre_div > MISC_CLK_DIV_MASK) {
-		dev_err(meson->chip.dev, "unable to get period pre_div\n");
-		return -EINVAL;
-	}
-
-	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC);
 	if (cnt > 0xffff) {
 		dev_err(meson->chip.dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
-		pre_div, cnt);
+	dev_dbg(meson->chip.dev, "period=%u cnt=%u\n", period, cnt);
 
 	if (duty == period) {
-		channel->pre_div = pre_div;
 		channel->hi = cnt;
 		channel->lo = 0;
 	} else if (duty == 0) {
-		channel->pre_div = pre_div;
 		channel->hi = 0;
 		channel->lo = cnt;
 	} else {
-		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = div64_u64(fin_freq * (u64)duty,
-				     NSEC_PER_SEC * (pre_div + 1));
+		duty_cnt = div64_u64(fin_freq * (u64)duty, NSEC_PER_SEC);
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
 		}
 
-		dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
-			duty, pre_div, duty_cnt);
+		dev_dbg(meson->chip.dev, "duty=%u duty_cnt=%u\n", duty, duty_cnt);
 
-		channel->pre_div = pre_div;
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
 	}
 
+	channel->rate = fin_freq;
+
 	return 0;
 }
 
@@ -222,16 +207,15 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
 	u32 value;
+	int err;
 
 	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
 
-	spin_lock_irqsave(&meson->lock, flags);
+	err = clk_set_rate(channel->clk, channel->rate);
+	if (err)
+		dev_err(meson->chip.dev, "setting clock rate failed\n");
 
-	value = readl(meson->base + REG_MISC_AB);
-	value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
-	value |= channel->pre_div << channel_data->clk_div_shift;
-	value |= channel_data->clk_en_mask;
-	writel(value, meson->base + REG_MISC_AB);
+	spin_lock_irqsave(&meson->lock, flags);
 
 	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
 		FIELD_PREP(PWM_LOW_MASK, channel->lo);
@@ -270,16 +254,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			/*
 			 * This IP block revision doesn't have an "always high"
 			 * setting which we can use for "inverted disabled".
-			 * Instead we achieve this using the same settings
-			 * that we use a pre_div of 0 (to get the shortest
-			 * possible duration for one "count") and
+			 * Instead we achieve this by setting an arbitrary,
+			 * very high frequency, resulting in the shortest
+			 * possible duration for one "count" and
 			 * "period == duty_cycle". This results in a signal
 			 * which is LOW for one "count", while being HIGH for
 			 * the rest of the (so the signal is HIGH for slightly
 			 * less than 100% of the period, but this is the best
 			 * we can achieve).
 			 */
-			channel->pre_div = 0;
+			channel->rate = 1000000000;
 			channel->hi = ~0;
 			channel->lo = 0;
 
@@ -304,7 +288,6 @@ static unsigned int meson_pwm_cnt_to_ns(struct pwm_chip *chip,
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel;
 	unsigned long fin_freq;
-	u32 fin_ns;
 
 	/* to_meson_pwm() can only be used after .get_state() is called */
 	channel = &meson->channels[pwm->hwpwm];
@@ -313,9 +296,7 @@ static unsigned int meson_pwm_cnt_to_ns(struct pwm_chip *chip,
 	if (fin_freq == 0)
 		return 0;
 
-	fin_ns = div_u64(NSEC_PER_SEC, fin_freq);
-
-	return cnt * fin_ns * (channel->pre_div + 1);
+	return div_u64(NSEC_PER_SEC * (u64)cnt, fin_freq);
 }
 
 static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -334,11 +315,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	value = readl(meson->base + REG_MISC_AB);
 
-	tmp = channel_data->pwm_en_mask | channel_data->clk_en_mask;
-	state->enabled = (value & tmp) == tmp;
-
-	tmp = value >> channel_data->clk_div_shift;
-	channel->pre_div = FIELD_GET(MISC_CLK_DIV_MASK, tmp);
+	tmp = channel_data->pwm_en_mask;
+	state->enabled = __clk_is_enabled(channel->clk) && (value & tmp) == tmp;
 
 	value = readl(meson->base + channel_data->reg_offset);
 
@@ -492,6 +470,8 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
+		const char *clk_parent[1];
+		struct clk *mux_clk, *div_clk;
 
 		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
 
@@ -510,18 +490,57 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		channel->mux.table = NULL;
 		channel->mux.hw.init = &init;
 
-		channel->clk = devm_clk_register(dev, &channel->mux.hw);
-		if (IS_ERR(channel->clk)) {
-			err = PTR_ERR(channel->clk);
+		mux_clk = devm_clk_register(dev, &channel->mux.hw);
+		if (IS_ERR(mux_clk)) {
+			err = PTR_ERR(mux_clk);
 			dev_err(dev, "failed to register %s: %d\n", name, err);
 			return err;
 		}
 
-		snprintf(name, sizeof(name), "clkin%u", i);
+		snprintf(name, sizeof(name), "%s#div%u", dev_name(dev), i);
+
+		init.name = name;
+		init.ops = &clk_divider_ops;
+		init.flags = CLK_SET_RATE_PARENT;
+		clk_parent[0] = __clk_get_name(mux_clk);
+		init.parent_names = clk_parent;
+		init.num_parents = 1;
+
+		channel->div.reg = meson->base + REG_MISC_AB;
+		channel->div.shift = meson_pwm_per_channel_data[i].clk_div_shift;
+		channel->div.width = __builtin_popcountl(MISC_CLK_DIV_MASK);
+		channel->div.hw.init = &init;
+		channel->div.flags = 0;
+		channel->div.lock = &meson->lock;
+
+		div_clk = devm_clk_register(dev, &channel->div.hw);
+		if (IS_ERR(div_clk)) {
+			err = PTR_ERR(div_clk);
+			dev_err(dev, "failed to register %s: %d\n", name, err);
+			return err;
+		}
 
-		channel->clk_parent = devm_clk_get_optional(dev, name);
-		if (IS_ERR(channel->clk_parent))
-			return PTR_ERR(channel->clk_parent);
+		snprintf(name, sizeof(name), "%s#gate%u", dev_name(dev), i);
+
+		init.name = name;
+		init.ops = &clk_gate_ops;
+		init.flags = CLK_SET_RATE_PARENT;
+		clk_parent[0] = __clk_get_name(div_clk);
+		init.parent_names = clk_parent;
+		init.num_parents = 1;
+
+		channel->gate.reg = meson->base + REG_MISC_AB;
+		channel->gate.bit_idx = __ffs(meson_pwm_per_channel_data[i].clk_en_mask);
+		channel->gate.hw.init = &init;
+		channel->gate.flags = 0;
+		channel->gate.lock = &meson->lock;
+
+		channel->clk = devm_clk_register(dev, &channel->gate.hw);
+		if (IS_ERR(channel->clk)) {
+			err = PTR_ERR(channel->clk);
+			dev_err(dev, "failed to register %s: %d\n", name, err);
+			return err;
+		}
 	}
 
 	return 0;
-- 
2.40.0

