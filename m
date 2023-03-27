Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA856C9C16
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Mar 2023 09:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjC0Hd4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Mar 2023 03:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjC0Hdz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2023 03:33:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91F4494
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2023 00:33:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r11so7577744wrr.12
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2023 00:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679902432;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UEEhPH8ocJiYd/9gSr8KPUbLSW9GjlZZJg9wPJ1Qyn0=;
        b=y98+fKbVnOsCQ2P0y7g28X0HTs0El/7woxQqYka+NkB1KpYEZQWzKVScotKUgAm6YI
         tAXxkexbmhXRZhgyyZoItJTeViRyx2u32WDHWUgOEp0xvbUImyl3CuCNazddG4fuKz/c
         /TaSzAfhHcqDlxzeqFtlMLeP8b0D1QXDATH47u3M4YYcXUyur0LhfAfTigBdxfk0Ar8C
         MXOnZmP4FSb4rIRgl811FfxS2hkAjtCqUes3ujcRmXlFE8iiqXkF5RK2EEEa78uXpkx3
         e3+HwAUX9wwD+I2iKBYlndng7YGpJL1tYr3Vl1JpAnXqOqmZtClBCmwmfWnBAyZLQO9x
         hucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679902432;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEEhPH8ocJiYd/9gSr8KPUbLSW9GjlZZJg9wPJ1Qyn0=;
        b=iRP6t5rwQf6hR4TA8qyu9DrBREQ5BHXu4Y3EPG7REfoypiUhCi79TagdJvobVxUQ9G
         BEKo5K6ZOvalf9oqwmFOLugURMp9fBPlepMhlOp/DRKTV+lzpLvybu9Lyoh1WTssFv1R
         dhWAK09k81T+bVCngYRePoGIvFZ5BqeJWGQnuRhMfZ9J/OMren41kZQgH6n+bze2O3uh
         pz4ZKmm5l/JEmPy5magQVTuK68iXugujSuSt0eS0ef+AzFJPXqBqa7TFa4SKGnLaD4hj
         1PQwUH1cUPzUsfzWFTj5QhJVRj8EUcAKc2t+2nPfN2zN46f6U6lz/ewpz3o3PlKmtMqO
         k8KA==
X-Gm-Message-State: AAQBX9eJp65TxZJ2eJbyn5TiU2JDTJv/gaGImmF6plzQv4oUzJpXtSmm
        kyUFUT5PgH2GIFjIV5BL9t3Zjg==
X-Google-Smtp-Source: AKy350Ya1Gn52ZkgK8M8GtMJPZe8lW2E1iv776XstJljlYLc3Z+Vhj96yMGyvK4wPgF5NUth9kUyHw==
X-Received: by 2002:a5d:55c2:0:b0:2d8:7bba:5bb6 with SMTP id i2-20020a5d55c2000000b002d87bba5bb6mr8439397wrw.28.1679902432004;
        Mon, 27 Mar 2023 00:33:52 -0700 (PDT)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id g16-20020a5d4890000000b002de99432fc8sm4767475wrq.49.2023.03.27.00.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:33:51 -0700 (PDT)
Message-ID: <3492657f-6cc2-5828-b153-30c609a92783@linaro.org>
Date:   Mon, 27 Mar 2023 09:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] pwm: meson: add support for S4 chip family
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 24/03/2023 23:23, Heiner Kallweit wrote:
> This adds pwm support for (at least) the s4 chip family. The extension
> is based on the vendor driver that can be found at [0]. There the
> version with the new clock handling is called meson-v2-pwm.
> Central change is that the clock is now fully provided by the SoC clock
> core. The multiplexer isn't any longer part of the pwm block.
> 
> This was tested on a sc2-based system that uses the same pwm block.
> 
> [0] https://github.com/khadas/linux/blob/khadas-vims-5.4.y/drivers/pwm/pwm-meson.c
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> Adding the amlogic,meson-s4-pwm compatible to the documentation was part
> of the yaml conversion already.
> ---
>   drivers/pwm/pwm-meson.c | 38 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 16d79ca5d..7a93fdada 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -98,6 +98,7 @@ struct meson_pwm_channel {
>   struct meson_pwm_data {
>   	const char * const *parent_names;
>   	unsigned int num_parents;
> +	unsigned int ext_clk:1;

Drop the :1, the compiler will align the struct size to the register size, so simply use unsigned int or bool.

I'd use a better name for that, like: no_mux_blk, pwm_clk_input....

>   };
>   
>   struct meson_pwm {
> @@ -158,6 +159,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>   	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
>   	unsigned int duty, period, pre_div, cnt, duty_cnt;
>   	unsigned long fin_freq;
> +	int err;
>   
>   	duty = state->duty_cycle;
>   	period = state->period;
> @@ -165,6 +167,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>   	if (state->polarity == PWM_POLARITY_INVERSED)
>   		duty = period - duty;
>   
> +	if (meson->data->ext_clk) {
> +		err = clk_set_rate(channel->clk, 0xffffUL * NSEC_PER_SEC / period);
> +		if (err) {
> +			dev_err(meson->chip.dev, "failed to set pwm clock rate\n");
> +			return err;
> +		}

If the same MUX architecture has been moved out of the PWM registers, then why would you call
set_rate ? we don't call set_rate today, so why should we ?

Today the MUX selection is static depending on the clk names specified in the bindings (yes it's
really not the good way to do that,....) but now the MUX is outside the PWM registers block
we should stick to the same architecture and mark the MUX as NO_REPARENT and instead of using
a bad bindings specify the MUX parent & rate in dt using assigned-clk-parent/rate.

So please drop this set_rate().

> +	}
> +
>   	fin_freq = clk_get_rate(channel->clk);
>   	if (fin_freq == 0) {
>   		dev_err(meson->chip.dev, "invalid source clock frequency\n");
> @@ -173,10 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>   
>   	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
>   
> -	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
> -	if (pre_div > MISC_CLK_DIV_MASK) {
> -		dev_err(meson->chip.dev, "unable to get period pre_div\n");
> -		return -EINVAL;
> +	if (meson->data->ext_clk) {
> +		pre_div = 0;
> +	} else {
> +		pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
> +		if (pre_div > MISC_CLK_DIV_MASK) {
> +			dev_err(meson->chip.dev, "unable to get period pre_div\n");
> +			return -EINVAL;
> +		}
>   	}
>   
>   	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
> @@ -445,6 +459,10 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
>   	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
>   };
>   
> +static const struct meson_pwm_data pwm_s4_data = {
> +	.ext_clk = 1,
> +};
> +
>   static const struct of_device_id meson_pwm_matches[] = {
>   	{
>   		.compatible = "amlogic,meson8b-pwm",
> @@ -478,6 +496,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>   		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>   		.data = &pwm_g12a_ao_cd_data
>   	},
> +	{
> +		.compatible = "amlogic,meson-s4-pwm",

This deserved a bindings update, and we should perhaps start a new bindings by using
new clock-names (!= clkin0/1) to differentiate from the old buggy bindings.

Neil

> +		.data = &pwm_s4_data
> +	},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> @@ -493,6 +515,14 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>   	for (i = 0; i < meson->chip.npwm; i++) {
>   		struct meson_pwm_channel *channel = &meson->channels[i];
>   
> +		if (meson->data->ext_clk) {
> +			snprintf(name, sizeof(name), "clkin%u", i);
> +			channel->clk = devm_clk_get(dev, name);
> +			if (IS_ERR(channel->clk))
> +				return PTR_ERR(channel->clk);
> +			continue;
> +		}
> +
>   		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>   
>   		init.name = name;

