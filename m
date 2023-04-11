Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA396DE4EF
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 21:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDKT0j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 15:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDKT0j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 15:26:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684BA135
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:26:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d9so8745168wrb.11
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681241196; x=1683833196;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jjTcv9ISBL6Oz86Z5Q8IZbwq6mT5uF1034ER6v+8wcw=;
        b=m9BGxS/YDtb/FnmThK/9ZqChjjc2a9+h9YYyTZ44iz+tMec+IA+EiIIJlT/QhyDHQ+
         2Ywx6MzCG+o/+y5951RRgMPD69IEC5xx5Wnz9sz39k2w9Zp7kuDbN+fV3HiSAYrNlZ53
         Bn3RggjCEnlt1An/CVi5/uuuunGpSgWsg6PFQs5VEvCaKbNkZBq2bjskADJ4k7tQKLgp
         O3SLFBKwG322xZCThPphSHGIUs+o7jQDA5Q8Y8rTXpSueV2k/sMW/PeIxZmhUCcgAza3
         khZsxPl5wbgHGh8HJXsDqDMW6JsVOW0O7xbgh4DpPTdiSykiIvenwHYcq+DjU0vPZKdv
         cMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681241196; x=1683833196;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjTcv9ISBL6Oz86Z5Q8IZbwq6mT5uF1034ER6v+8wcw=;
        b=7OLdxWKA/ppsrcDZbigri3K3YKd88U/lUGhQ0E1oV4BEoBgWoqDMPmht40GVpC42jJ
         ZjP/4PsQ2sjuJ4CtWOSNDyTg7/BaP1vpE8IH9o1SVGV/wH4R9/eDnuMHKRQ4IOmnJ4WD
         tndlyq+iMgvfuEQso0HFlIFwWyUwWJACssCOsKQ8Ey4IsJvI1jtv2tr2royY3e1ujt0B
         fwLzZthFXBYwWjqWXP6sPxR+tMHFP/U6Rgd78N/jHrUQH7KE+Kfeu6A+ipP3cBnRRuUj
         Die4L2gCcpt8QryRynFu+hL4yyzXWeqX3xKlwAUkycUSEF/b+5qdpkKyZ2IJxGQRnnA+
         zC/A==
X-Gm-Message-State: AAQBX9eDtpG0A22yxO/Ky2nxJhaW7Hgvvoi5nUSEK55/PjbjEpww6Ns5
        umimp2mtI1AX1n9lnqDhoIYx8hfYZ28=
X-Google-Smtp-Source: AKy350YuZ8cLZf4VKnQpd/KyyFO/R+p01/xclXqXeiQ96OgqauxuC30NN55OTjySPKJUigd8eHsL9g==
X-Received: by 2002:a5d:464b:0:b0:2f2:4790:fccc with SMTP id j11-20020a5d464b000000b002f24790fcccmr4236838wrs.46.1681241195862;
        Tue, 11 Apr 2023 12:26:35 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4bb:c200:90e3:4731:63e4:d333? (dynamic-2a01-0c23-c4bb-c200-90e3-4731-63e4-d333.c23.pool.telefonica.de. [2a01:c23:c4bb:c200:90e3:4731:63e4:d333])
        by smtp.googlemail.com with ESMTPSA id r5-20020adfce85000000b002c54c9bd71fsm15236003wrn.93.2023.04.11.12.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 12:26:35 -0700 (PDT)
Message-ID: <05e3b9de-ee38-97b6-7f39-5b6f7de1674f@gmail.com>
Date:   Tue, 11 Apr 2023 21:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: [PATCH v2 4/4] pwm: meson: make full use of common clock framework
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
References: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
In-Reply-To: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
---
 drivers/pwm/pwm-meson.c | 134 +++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 58 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index f7595f81c..ec9c82e48 100644
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
 
@@ -475,6 +453,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
+		struct clk_parent_data div_parent = {}, gate_parent = {};
 		struct clk_init_data init = {};
 		int j;
 
@@ -500,18 +479,57 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
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
+		init.flags = CLK_SET_RATE_PARENT;
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


