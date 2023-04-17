Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1304D6E40BF
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Apr 2023 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjDQHXl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Apr 2023 03:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDQHXk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Apr 2023 03:23:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C939BBA
        for <linux-pwm@vger.kernel.org>; Mon, 17 Apr 2023 00:23:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f1763ee8f8so339915e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 17 Apr 2023 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716216; x=1684308216;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U4bj2H9qmeVSso11SML7BIrdtQZppfzayCc2jlV8HSA=;
        b=Q2DSizZMUn8VJnRy7rHbmzMtasXXXxVoZBGXJC4yGiV9tabUw8E7dDSenuk+PTFlnR
         N26pwNntWAk7KVsDzsjmiITsplldcOklQ6iXqvOyHkPSudVIID0N8y3McU8b/Whki/w1
         xQx468MKmsjpbEihR5MHQbCPdpiSTS56QmvdZZ8VhdGZUcruUbiYh+f+KmB7PRinETvg
         Cxcg4b1i84uFPUZLPVJkRnl5qZPGyO/mY45CUXwMIVUgBsTupznFbytbIF2JAyZ4cVhy
         wYIVnX00ilhaW2zoIhwD/SgMCknRdkYzvlZx/wraTaash0nNeWerauK58FpghdDiB466
         U9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716216; x=1684308216;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4bj2H9qmeVSso11SML7BIrdtQZppfzayCc2jlV8HSA=;
        b=bSdkJm6ZXvH2HSXZg8iOXysdEq4r4+wwluHupElX3hz6nKAkc8Y6GrViMhH2lyHvga
         ZB5rNJWxrtON7lqOmFBWooqsI2NJj4JOBIOswAtjj95yXZEWtQSG32hFxbQU3bRkNCZh
         2JK5lH6yyiUBwM70XtkI8iQHFdd5eWWVJ+AoAnGeIHr/NgGWGMuidWp/AowhqSVzwiEA
         qxLeDQhS+8KeAxTjW+b/nZphno+qZO/mRdOduUHCttaKrNuQE8USScqS9F2Qw6h0WyBI
         bHRoKFI+4KEBGAepGLMyl51YtxFAlJUO/uSR59JKzVUusMEB6kMz7AY7Yage47CiiHIW
         ocPw==
X-Gm-Message-State: AAQBX9c4hRePdH9domMUkm1m1jgwNvU3T8pnMsZprGPaHe42Bf/vqVKP
        OVjcXPs48nea0YsZTJ+XULvhwQ==
X-Google-Smtp-Source: AKy350aA9XNG4LmNRdZi0YP7UNqmvXbzNkiIAU7N6IRbZEuVy28KvvZKl/jTW71vAjv6ZX3wJuaDBw==
X-Received: by 2002:a5d:6e86:0:b0:2e5:56f8:61fc with SMTP id k6-20020a5d6e86000000b002e556f861fcmr4118050wrz.15.1681716215886;
        Mon, 17 Apr 2023 00:23:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a1e1:81a8:1acc:2b91? ([2a01:e0a:982:cbb0:a1e1:81a8:1acc:2b91])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d6b4f000000b002c8476dde7asm9775536wrw.114.2023.04.17.00.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:23:35 -0700 (PDT)
Message-ID: <ca531c1a-3c62-5fb1-6765-68ec1e541483@linaro.org>
Date:   Mon, 17 Apr 2023 09:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock
 framework
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 13/04/2023 07:54, Heiner Kallweit wrote:
> Newer versions of the PWM block use a core clock with external mux,
> divider, and gate. These components either don't exist any longer in
> the PWM block, or they are bypassed.
> To minimize needed changes for supporting the new version, the internal
> divider and gate should be handled by CCF too.
> 
> I didn't see a good way to split the patch, therefore it's somewhat
> bigger. What it does:
> 
> - The internal mux is handled by CCF already. Register also internal
>    divider and gate with CCF, so that we have one representation of the
>    input clock: [mux] parent of [divider] parent of [gate]
>    
> - Now that CCF selects an appropriate mux parent, we don't need the
>    DT-provided default parent any longer. Accordingly we can also omit
>    setting the mux parent directly in the driver.
>    
> - Instead of manually handling the pre-div divider value, let CCF
>    set the input clock. Targeted input clock frequency is
>    0xffff * 1/period for best precision.
>    
> - For the "inverted pwm disabled" scenario target an input clock
>    frequency of 1GHz. This ensures that the remaining low pulses
>    have minimum length.
> 
> I don't have hw with the old PWM block, therefore I couldn't test this
> patch. With the not yet included extension for the new PWM block
> (channel->clk coming directly from get_clk(external_clk)) I didn't
> notice any problem. My system uses PWM for the CPU voltage regulator
> and for the SDIO 32kHz clock.
> 
> Note: The clock gate in the old PWM block is permanently disabled.
> This seems to indicate that it's not used by the new PWM block.
> 
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> Changes to RFT/RFC version:
> - use parent_hws instead of parent_names for div/gate clock
> - use devm_clk_hw_register where the struct clk * returned by
>    devm_clk_register isn't needed
> 
> v2:
> - add patch 1
> - add patch 3
> - switch to using clk_parent_data in all relevant places
> v3:
> - add flag CLK_IGNORE_UNUSED
> v4:
> - remove variable tmp in meson_pwm_get_state
> - don't use deprecated function devm_clk_register
> ---
>   drivers/pwm/pwm-meson.c | 142 +++++++++++++++++++++++-----------------
>   1 file changed, 83 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 40a8709ff..80ac71cbc 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -51,7 +51,7 @@
>   #define REG_MISC_AB		0x8
>   #define MISC_B_CLK_EN		23
>   #define MISC_A_CLK_EN		15
> -#define MISC_CLK_DIV_MASK	0x7f
> +#define MISC_CLK_DIV_WIDTH	7
>   #define MISC_B_CLK_DIV_SHIFT	16
>   #define MISC_A_CLK_DIV_SHIFT	8
>   #define MISC_B_CLK_SEL_SHIFT	6
> @@ -87,12 +87,13 @@ static struct meson_pwm_channel_data {
>   };
>   
>   struct meson_pwm_channel {
> +	unsigned long rate;
>   	unsigned int hi;
>   	unsigned int lo;
> -	u8 pre_div;
>   
> -	struct clk *clk_parent;
>   	struct clk_mux mux;
> +	struct clk_divider div;
> +	struct clk_gate gate;
>   	struct clk *clk;
>   };
>   
> @@ -125,16 +126,6 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>   	struct device *dev = chip->dev;
>   	int err;
>   
> -	if (channel->clk_parent) {
> -		err = clk_set_parent(channel->clk, channel->clk_parent);
> -		if (err < 0) {
> -			dev_err(dev, "failed to set parent %s for %s: %d\n",
> -				__clk_get_name(channel->clk_parent),
> -				__clk_get_name(channel->clk), err);
> -			return err;
> -		}
> -	}
> -
>   	err = clk_prepare_enable(channel->clk);
>   	if (err < 0) {
>   		dev_err(dev, "failed to enable clock %s: %d\n",
> @@ -157,8 +148,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>   			  const struct pwm_state *state)
>   {
>   	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
> -	unsigned int duty, period, pre_div, cnt, duty_cnt;
> +	unsigned int duty, period, cnt, duty_cnt;
>   	unsigned long fin_freq;
> +	u64 freq;
>   
>   	duty = state->duty_cycle;
>   	period = state->period;
> @@ -166,7 +158,11 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>   	if (state->polarity == PWM_POLARITY_INVERSED)
>   		duty = period - duty;
>   
> -	fin_freq = clk_get_rate(channel->clk);
> +	freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
> +	if (freq > ULONG_MAX)
> +		freq = ULONG_MAX;
> +
> +	fin_freq = clk_round_rate(channel->clk, freq);
>   	if (fin_freq == 0) {
>   		dev_err(meson->chip.dev, "invalid source clock frequency\n");
>   		return -EINVAL;
> @@ -174,46 +170,35 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>   
>   	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
>   
> -	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
> -	if (pre_div > MISC_CLK_DIV_MASK) {
> -		dev_err(meson->chip.dev, "unable to get period pre_div\n");
> -		return -EINVAL;
> -	}
> -
> -	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
> +	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC);
>   	if (cnt > 0xffff) {
>   		dev_err(meson->chip.dev, "unable to get period cnt\n");
>   		return -EINVAL;
>   	}
>   
> -	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
> -		pre_div, cnt);
> +	dev_dbg(meson->chip.dev, "period=%u cnt=%u\n", period, cnt);
>   
>   	if (duty == period) {
> -		channel->pre_div = pre_div;
>   		channel->hi = cnt;
>   		channel->lo = 0;
>   	} else if (duty == 0) {
> -		channel->pre_div = pre_div;
>   		channel->hi = 0;
>   		channel->lo = cnt;
>   	} else {
> -		/* Then check is we can have the duty with the same pre_div */
> -		duty_cnt = div64_u64(fin_freq * (u64)duty,
> -				     NSEC_PER_SEC * (pre_div + 1));
> +		duty_cnt = div64_u64(fin_freq * (u64)duty, NSEC_PER_SEC);
>   		if (duty_cnt > 0xffff) {
>   			dev_err(meson->chip.dev, "unable to get duty cycle\n");
>   			return -EINVAL;
>   		}
>   
> -		dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
> -			duty, pre_div, duty_cnt);
> +		dev_dbg(meson->chip.dev, "duty=%u duty_cnt=%u\n", duty, duty_cnt);
>   
> -		channel->pre_div = pre_div;
>   		channel->hi = duty_cnt;
>   		channel->lo = cnt - duty_cnt;
>   	}
>   
> +	channel->rate = fin_freq;
> +
>   	return 0;
>   }
>   
> @@ -223,16 +208,15 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
>   	struct meson_pwm_channel_data *channel_data;
>   	unsigned long flags;
>   	u32 value;
> +	int err;
>   
>   	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
>   
> -	spin_lock_irqsave(&meson->lock, flags);
> +	err = clk_set_rate(channel->clk, channel->rate);
> +	if (err)
> +		dev_err(meson->chip.dev, "setting clock rate failed\n");
>   
> -	value = readl(meson->base + REG_MISC_AB);
> -	value &= ~(MISC_CLK_DIV_MASK << channel_data->clk_div_shift);
> -	value |= channel->pre_div << channel_data->clk_div_shift;
> -	value |= BIT(channel_data->clk_en_bit);
> -	writel(value, meson->base + REG_MISC_AB);
> +	spin_lock_irqsave(&meson->lock, flags);
>   
>   	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
>   		FIELD_PREP(PWM_LOW_MASK, channel->lo);
> @@ -271,16 +255,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   			/*
>   			 * This IP block revision doesn't have an "always high"
>   			 * setting which we can use for "inverted disabled".
> -			 * Instead we achieve this using the same settings
> -			 * that we use a pre_div of 0 (to get the shortest
> -			 * possible duration for one "count") and
> +			 * Instead we achieve this by setting an arbitrary,
> +			 * very high frequency, resulting in the shortest
> +			 * possible duration for one "count" and
>   			 * "period == duty_cycle". This results in a signal
>   			 * which is LOW for one "count", while being HIGH for
>   			 * the rest of the (so the signal is HIGH for slightly
>   			 * less than 100% of the period, but this is the best
>   			 * we can achieve).
>   			 */
> -			channel->pre_div = 0;
> +			channel->rate = 1000000000;
>   			channel->hi = ~0;
>   			channel->lo = 0;

This looks like a really bad idea... please don't do that and instead introduce
some pinctrl states where we set the PWM pin as GPIO mode high/low state like we
did for SPI:
https://lore.kernel.org/r/20221004-up-aml-fix-spi-v4-2-0342d8e10c49@baylibre.com

>   
> @@ -305,7 +289,6 @@ static unsigned int meson_pwm_cnt_to_ns(struct pwm_chip *chip,
>   	struct meson_pwm *meson = to_meson_pwm(chip);
>   	struct meson_pwm_channel *channel;
>   	unsigned long fin_freq;
> -	u32 fin_ns;
>   
>   	/* to_meson_pwm() can only be used after .get_state() is called */
>   	channel = &meson->channels[pwm->hwpwm];
> @@ -314,9 +297,7 @@ static unsigned int meson_pwm_cnt_to_ns(struct pwm_chip *chip,
>   	if (fin_freq == 0)
>   		return 0;
>   
> -	fin_ns = div_u64(NSEC_PER_SEC, fin_freq);
> -
> -	return cnt * fin_ns * (channel->pre_div + 1);
> +	return div_u64(NSEC_PER_SEC * (u64)cnt, fin_freq);
>   }
>   
>   static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -325,7 +306,7 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   	struct meson_pwm *meson = to_meson_pwm(chip);
>   	struct meson_pwm_channel_data *channel_data;
>   	struct meson_pwm_channel *channel;
> -	u32 value, tmp;
> +	u32 value;
>   
>   	if (!state)
>   		return 0;
> @@ -335,11 +316,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   
>   	value = readl(meson->base + REG_MISC_AB);
>   
> -	tmp = BIT(channel_data->pwm_en_bit) | BIT(channel_data->clk_en_bit);
> -	state->enabled = (value & tmp) == tmp;
> -
> -	tmp = value >> channel_data->clk_div_shift;
> -	channel->pre_div = FIELD_GET(MISC_CLK_DIV_MASK, tmp);
> +	state->enabled = __clk_is_enabled(channel->clk) &&
> +			 value & BIT(channel_data->pwm_en_bit);
>   
>   	value = readl(meson->base + channel_data->reg_offset);
>   
> @@ -480,6 +458,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>   
>   	for (i = 0; i < meson->chip.npwm; i++) {
>   		struct meson_pwm_channel *channel = &meson->channels[i];
> +		struct clk_parent_data div_parent = {}, gate_parent = {};
>   		struct clk_init_data init = {};
>   
>   		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
> @@ -499,18 +478,63 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>   		channel->mux.table = NULL;
>   		channel->mux.hw.init = &init;
>   
> -		channel->clk = devm_clk_register(dev, &channel->mux.hw);
> -		if (IS_ERR(channel->clk)) {
> -			err = PTR_ERR(channel->clk);
> +		err = devm_clk_hw_register(dev, &channel->mux.hw);
> +		if (err) {
>   			dev_err(dev, "failed to register %s: %d\n", name, err);
>   			return err;
>   		}
>   
> -		snprintf(name, sizeof(name), "clkin%u", i);
> +		snprintf(name, sizeof(name), "%s#div%u", dev_name(dev), i);
> +
> +		init.name = name;
> +		init.ops = &clk_divider_ops;
> +		init.flags = CLK_SET_RATE_PARENT;
> +		div_parent.index = -1;
> +		div_parent.hw = &channel->mux.hw;
> +		init.parent_data = &div_parent;
> +		init.num_parents = 1;
> +
> +		channel->div.reg = meson->base + REG_MISC_AB;
> +		channel->div.shift = meson_pwm_per_channel_data[i].clk_div_shift;
> +		channel->div.width = MISC_CLK_DIV_WIDTH;
> +		channel->div.hw.init = &init;
> +		channel->div.flags = 0;
> +		channel->div.lock = &meson->lock;
> +
> +		err = devm_clk_hw_register(dev, &channel->div.hw);
> +		if (err) {
> +			dev_err(dev, "failed to register %s: %d\n", name, err);
> +			return err;
> +		}
> +
> +		snprintf(name, sizeof(name), "%s#gate%u", dev_name(dev), i);
> +
> +		init.name = name;
> +		init.ops = &clk_gate_ops;
> +		init.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED;
> +		gate_parent.index = -1;
> +		gate_parent.hw = &channel->div.hw;
> +		init.parent_data = &gate_parent;
> +		init.num_parents = 1;
> +
> +		channel->gate.reg = meson->base + REG_MISC_AB;
> +		channel->gate.bit_idx = meson_pwm_per_channel_data[i].clk_en_bit;
> +		channel->gate.hw.init = &init;
> +		channel->gate.flags = 0;
> +		channel->gate.lock = &meson->lock;
> +
> +		err = devm_clk_hw_register(dev, &channel->gate.hw);
> +		if (err) {
> +			dev_err(dev, "failed to register %s: %d\n", name, err);
> +			return err;
> +		}
>   
> -		channel->clk_parent = devm_clk_get_optional(dev, name);
> -		if (IS_ERR(channel->clk_parent))
> -			return PTR_ERR(channel->clk_parent);
> +		channel->clk = devm_clk_hw_get_clk(dev, &channel->gate.hw, NULL);
> +		if (IS_ERR(channel->clk)) {
> +			err = PTR_ERR(channel->clk);
> +			dev_err(dev, "failed to register %s: %d\n", name, err);
> +			return err;
> +		}
>   	}
>   
>   	return 0;

