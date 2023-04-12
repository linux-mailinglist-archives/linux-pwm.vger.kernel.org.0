Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A826DFEAD
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDLTXl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 15:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDLTXk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 15:23:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD356188
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 12:23:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504718a2282so3796716a12.0
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681327417; x=1683919417;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vagm+1hWMXNarfXdnE9ifh3xJCO8ArRcquWDC5OsUrQ=;
        b=fXqb+dB9YQ5nh+N+mHBMYMcwHkFAUftNe2Of9/PkAoRAK7CgPrSOMv+gN9VRRGhtOr
         cRplOFgrWa0stdTbtn1oEo8F0IK+ayRPk5dLO3erJlmEnMYMBWsvzmMkLmi09115dwNy
         gpZBmDzwGEDRq85En0wBNpVEgUIiy+0xInNJZVQO7N76TBnIDwIjtrRPCPtLv+acON9Z
         4Y5BYyS3pPxqLpgQLv+91Advi2JvaGqiLD2Mq54uTETaNtCU9nDC5oA7YSsBF3K9mrZO
         cQyO1aNR3tkVHK0LxEXjXsoUWudhPkxwgK2ByQYAQzoCJoY+kL0s2yH5P0IrxVKp5VJG
         /fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681327417; x=1683919417;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vagm+1hWMXNarfXdnE9ifh3xJCO8ArRcquWDC5OsUrQ=;
        b=MlzVUYeqGrraXVq4ho4DruKS67wvOGDWN67/oANiRU4TS8jXx0Z+zeSmtVMwo81SFD
         eYvxZGzEuErP//s3z5J8/7YCKSClwDQVhEad37h9u3YGQWlDLigRgpAw8pFgK9TmPa9i
         b+qqtzI+3AAH9DRVgD5l970IUyk1UUwSMZZbm9+OSuaOm2H2XkDN/7TyxA0inVq3RAoS
         6BF2iymU0CXvinznHjxzJMzj0YpVx/EG3bSkwqVgloL6wbozU829q8gxs9kkHWMXNOwz
         Res5YC9GOvfwDMSk9Va8iGD24ZjeZfS7JraSAvu+BEFQ+UuOk1IPaNBlKqDFGFlAEdJh
         7TjA==
X-Gm-Message-State: AAQBX9fBSvvD1UWUaEhSyzvadLrMOXAwoN9fnNUnVDFxu/CXtweizFbw
        8lcTFPfyat5ouV3czLQZuI8=
X-Google-Smtp-Source: AKy350YS9lzrKfhFtJnuz1nSFnb333p4qSJIw82HP6wwwLTHa8X6DjX/o7AykHwsL4iTLVJUKGHWIw==
X-Received: by 2002:aa7:d445:0:b0:4af:6c5e:225c with SMTP id q5-20020aa7d445000000b004af6c5e225cmr6122760edr.33.1681327417012;
        Wed, 12 Apr 2023 12:23:37 -0700 (PDT)
Received: from ?IPV6:2a02:3100:903d:3d00:b0e7:6bd7:f613:784b? (dynamic-2a02-3100-903d-3d00-b0e7-6bd7-f613-784b.310.pool.telefonica.de. [2a02:3100:903d:3d00:b0e7:6bd7:f613:784b])
        by smtp.googlemail.com with ESMTPSA id u6-20020a50d506000000b004c13fe8fabfsm7147999edi.84.2023.04.12.12.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 12:23:36 -0700 (PDT)
Message-ID: <12d4fbc1-8ed4-637e-32ca-2c09d25d60a6@gmail.com>
Date:   Wed, 12 Apr 2023 21:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: [PATCH v3 4/4] pwm: meson: make full use of common clock framework
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
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
References: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com>
In-Reply-To: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
Changes to RFT/RFC version:
- use parent_hws instead of parent_names for div/gate clock
- use devm_clk_hw_register where the struct clk * returned by
  devm_clk_register isn't needed

v2:
- add patch 1
- add patch 3
- switch to using clk_parent_data in all relevant places
v3:
- add flag CLK_IGNORE_UNUSED
---
 drivers/pwm/pwm-meson.c | 134 +++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 58 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 40a8709ff..6d401fd0d 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -51,7 +51,7 @@
 #define REG_MISC_AB		0x8
 #define MISC_B_CLK_EN		23
 #define MISC_A_CLK_EN		15
-#define MISC_CLK_DIV_MASK	0x7f
+#define MISC_CLK_DIV_WIDTH	7
 #define MISC_B_CLK_DIV_SHIFT	16
 #define MISC_A_CLK_DIV_SHIFT	8
 #define MISC_B_CLK_SEL_SHIFT	6
@@ -87,12 +87,13 @@ static struct meson_pwm_channel_data {
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
 
@@ -125,16 +126,6 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
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
@@ -157,8 +148,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	unsigned int duty, period, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 freq;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -166,7 +158,11 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
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
@@ -174,46 +170,35 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
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
 
@@ -223,16 +208,15 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
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
-	value |= BIT(channel_data->clk_en_bit);
-	writel(value, meson->base + REG_MISC_AB);
+	spin_lock_irqsave(&meson->lock, flags);
 
 	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
 		FIELD_PREP(PWM_LOW_MASK, channel->lo);
@@ -271,16 +255,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
 
@@ -305,7 +289,6 @@ static unsigned int meson_pwm_cnt_to_ns(struct pwm_chip *chip,
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel;
 	unsigned long fin_freq;
-	u32 fin_ns;
 
 	/* to_meson_pwm() can only be used after .get_state() is called */
 	channel = &meson->channels[pwm->hwpwm];
@@ -314,9 +297,7 @@ static unsigned int meson_pwm_cnt_to_ns(struct pwm_chip *chip,
 	if (fin_freq == 0)
 		return 0;
 
-	fin_ns = div_u64(NSEC_PER_SEC, fin_freq);
-
-	return cnt * fin_ns * (channel->pre_div + 1);
+	return div_u64(NSEC_PER_SEC * (u64)cnt, fin_freq);
 }
 
 static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -335,11 +316,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	value = readl(meson->base + REG_MISC_AB);
 
-	tmp = BIT(channel_data->pwm_en_bit) | BIT(channel_data->clk_en_bit);
-	state->enabled = (value & tmp) == tmp;
-
-	tmp = value >> channel_data->clk_div_shift;
-	channel->pre_div = FIELD_GET(MISC_CLK_DIV_MASK, tmp);
+	tmp = BIT(channel_data->pwm_en_bit);
+	state->enabled = __clk_is_enabled(channel->clk) && (value & tmp) == tmp;
 
 	value = readl(meson->base + channel_data->reg_offset);
 
@@ -480,6 +458,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
+		struct clk_parent_data div_parent = {}, gate_parent = {};
 		struct clk_init_data init = {};
 
 		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
@@ -499,18 +478,57 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		channel->mux.table = NULL;
 		channel->mux.hw.init = &init;
 
-		channel->clk = devm_clk_register(dev, &channel->mux.hw);
-		if (IS_ERR(channel->clk)) {
-			err = PTR_ERR(channel->clk);
+		err = devm_clk_hw_register(dev, &channel->mux.hw);
+		if (err) {
 			dev_err(dev, "failed to register %s: %d\n", name, err);
 			return err;
 		}
 
-		snprintf(name, sizeof(name), "clkin%u", i);
+		snprintf(name, sizeof(name), "%s#div%u", dev_name(dev), i);
+
+		init.name = name;
+		init.ops = &clk_divider_ops;
+		init.flags = CLK_SET_RATE_PARENT;
+		div_parent.index = -1;
+		div_parent.hw = &channel->mux.hw;
+		init.parent_data = &div_parent;
+		init.num_parents = 1;
+
+		channel->div.reg = meson->base + REG_MISC_AB;
+		channel->div.shift = meson_pwm_per_channel_data[i].clk_div_shift;
+		channel->div.width = MISC_CLK_DIV_WIDTH;
+		channel->div.hw.init = &init;
+		channel->div.flags = 0;
+		channel->div.lock = &meson->lock;
+
+		err = devm_clk_hw_register(dev, &channel->div.hw);
+		if (err) {
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
+		init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
+		gate_parent.index = -1;
+		gate_parent.hw = &channel->div.hw;
+		init.parent_data = &gate_parent;
+		init.num_parents = 1;
+
+		channel->gate.reg = meson->base + REG_MISC_AB;
+		channel->gate.bit_idx = meson_pwm_per_channel_data[i].clk_en_bit;
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


