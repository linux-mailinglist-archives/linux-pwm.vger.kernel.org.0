Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C528E6C8E85
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Mar 2023 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjCYNa6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Mar 2023 09:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCYNa5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Mar 2023 09:30:57 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD48AF31
        for <linux-pwm@vger.kernel.org>; Sat, 25 Mar 2023 06:30:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so2494936wms.1
        for <linux-pwm@vger.kernel.org>; Sat, 25 Mar 2023 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679751053;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx6IA/cmvYhhy0iahaNyV7Iyadx9sMo1vUgqiMwnkCM=;
        b=L8pjIGb3uR/EQhuCArVEYqyTUL+7t4rDeMCkuZKmnglqDztVOeuYQDuVM4yh33thgb
         itHK12MU3jrglIXaMYBx2O5kosrrYXv2Zjh3i+OoS7IfkI9Uyl7H0X/TtNmkIyEJ0emk
         rboBtR5Lr03ORSE7i7NypTlGXHRLT0slvJX8CZql9fyLfw+euoQgh94uvnEdvTmBmJaT
         aIg3FDmp3NEI7P2DTr2SDb4+gK3g0eNxdpbf1GYjcsF68cV6It2f6c6n79ZiXe/afobo
         vuIorKO1hUpOskWh/tWn+CABtSfhqm4vvzbpOrRLNdoqE4yiMVKiITyJsbPzjWgf1JQJ
         m4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679751053;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx6IA/cmvYhhy0iahaNyV7Iyadx9sMo1vUgqiMwnkCM=;
        b=g63o39kMyAYbvQ2DHu9U3uYSfchuwImUCUNT2ZOMKbPatczHC/y7jkdTANVsBO7+5z
         KJDpx13DSRFzCJOKaOyI6ua32s1ZT7yX61mVrUgz0X7sLdtTI3YfzDuvEPv0CjO07OrF
         soU513v3ShSTaUo0gh0Wq3aGvTN+hjs715khuWX+xAMpTDmbMSnzNwxyL8Q3DmsMqugp
         kqQ7kCuCNPqft8HNlAnCgxUArvhXemXYKq4Q34LGMGFzy9HZcp58wudPLlZDJeNB/IsB
         U35nltlVX0cqCQKo0JbaxcJD6cW6Ox9hZgQVZeIIFMWO+0D4f5RHfHufxbOpskMuRIPe
         175w==
X-Gm-Message-State: AO0yUKWNsjBts0OwcPbpGjRy+ydcSAygMWm1TL9uA/tmeZnYb2yV5Jxy
        JHquDPoicqzHyI9o48a3gyS4/A==
X-Google-Smtp-Source: AK7set/YjWDzwJZpZKsP8OfuUmUh0g3kz11oM8Uia+ycgl/OXq9wDaH9k4+VTfHWlDX2MJDoC8jzyg==
X-Received: by 2002:a05:600c:224c:b0:3df:eecc:de2b with SMTP id a12-20020a05600c224c00b003dfeeccde2bmr5152550wmm.11.1679751053077;
        Sat, 25 Mar 2023 06:30:53 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id x4-20020a1c7c04000000b003ee0d191539sm7914108wmc.10.2023.03.25.06.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 06:30:52 -0700 (PDT)
References: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] pwm: meson: add support for S4 chip family
Date:   Sat, 25 Mar 2023 14:24:01 +0100
In-reply-to: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
Message-ID: <1j5yapot4j.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Fri 24 Mar 2023 at 23:23, Heiner Kallweit <hkallweit1@gmail.com> wrote:

> This adds pwm support for (at least) the s4 chip family. The extension
> is based on the vendor driver that can be found at [0]. There the
> version with the new clock handling is called meson-v2-pwm.
> Central change is that the clock is now fully provided by the SoC clock
> core. The multiplexer isn't any longer part of the pwm block.

As far as the documentation is concerned this is not true.
There is a input multiplexer with the xtal, vid_pll, fdiv3 and fdiv4

I'm not sure the differences mentionned here actually exists.

>
> This was tested on a sc2-based system that uses the same pwm block.
>
> [0] https://github.com/khadas/linux/blob/khadas-vims-5.4.y/drivers/pwm/pwm-meson.c

AFAICT, this looks more like a choice in vendor SDK to not use the input
mux. IOW, just SW decision.

I don't think such change makes sense in mainline if the HW has not
actually changed.

>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> Adding the amlogic,meson-s4-pwm compatible to the documentation was part
> of the yaml conversion already.
> ---
>  drivers/pwm/pwm-meson.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 16d79ca5d..7a93fdada 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -98,6 +98,7 @@ struct meson_pwm_channel {
>  struct meson_pwm_data {
>  	const char * const *parent_names;
>  	unsigned int num_parents;
> +	unsigned int ext_clk:1;
>  };
>  
>  struct meson_pwm {
> @@ -158,6 +159,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>  	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
>  	unsigned int duty, period, pre_div, cnt, duty_cnt;
>  	unsigned long fin_freq;
> +	int err;
>  
>  	duty = state->duty_cycle;
>  	period = state->period;
> @@ -165,6 +167,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>  	if (state->polarity == PWM_POLARITY_INVERSED)
>  		duty = period - duty;
>  
> +	if (meson->data->ext_clk) {
> +		err = clk_set_rate(channel->clk, 0xffffUL * NSEC_PER_SEC / period);
> +		if (err) {
> +			dev_err(meson->chip.dev, "failed to set pwm clock rate\n");
> +			return err;
> +		}
> +	}
> +
>  	fin_freq = clk_get_rate(channel->clk);
>  	if (fin_freq == 0) {
>  		dev_err(meson->chip.dev, "invalid source clock frequency\n");
> @@ -173,10 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>  
>  	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
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
>  	}
>  
>  	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
> @@ -445,6 +459,10 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
>  	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
>  };
>  
> +static const struct meson_pwm_data pwm_s4_data = {
> +	.ext_clk = 1,
> +};
> +
>  static const struct of_device_id meson_pwm_matches[] = {
>  	{
>  		.compatible = "amlogic,meson8b-pwm",
> @@ -478,6 +496,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>  		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>  		.data = &pwm_g12a_ao_cd_data
>  	},
> +	{
> +		.compatible = "amlogic,meson-s4-pwm",
> +		.data = &pwm_s4_data
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);
> @@ -493,6 +515,14 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>  	for (i = 0; i < meson->chip.npwm; i++) {
>  		struct meson_pwm_channel *channel = &meson->channels[i];
>  
> +		if (meson->data->ext_clk) {
> +			snprintf(name, sizeof(name), "clkin%u", i);
> +			channel->clk = devm_clk_get(dev, name);
> +			if (IS_ERR(channel->clk))
> +				return PTR_ERR(channel->clk);
> +			continue;
> +		}
> +
>  		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>  
>  		init.name = name;

