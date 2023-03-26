Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDE6C93AA
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Mar 2023 12:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCZKCR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Mar 2023 06:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZKCP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Mar 2023 06:02:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80D7D90
        for <linux-pwm@vger.kernel.org>; Sun, 26 Mar 2023 03:02:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so24453010edd.5
        for <linux-pwm@vger.kernel.org>; Sun, 26 Mar 2023 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679824933;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7O4PE9uvBuP4z4Lc9KAAusmsJ0q1ATLYzf9/kFXaHa8=;
        b=FUjIjPCT0q2IzxkSV2VV+I+OxsZNnygLC+AJke0F74kYh56a72/hkp4NVS2LJOjkLj
         jIAXptCA7z4tKXJpe/Co9HOOjGSM7itFzo68oT287KiBdwaCOmEjbE2p0Vnc72MeNUcM
         LadgCx5CWRRCnKOGZAFQEzlhuSGHkN8YWnej6XEDA2Vy6dzByTJgxsJrry+sGPgJ1w9P
         e3iTAcy6ktyZ96RTdvwVBNjcEH49s1Ous15DNn8HZ3IvVADjDixR1+pCKRfhF6qXCQSa
         ktmY22J7X1APzPtTZa7nXVlk9zZrIEned2KCaHVIq0SXQDfZv6XgK8Bb9Q6rqBqzl2Ng
         AqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679824933;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7O4PE9uvBuP4z4Lc9KAAusmsJ0q1ATLYzf9/kFXaHa8=;
        b=zoHfp09uCOfD+KkUKKww5jjSTb3yVBVGsyL/wuGSFoCEzL8vhl+Ua0z8TRkY4zJbC5
         zVSH2bca2Y6M2qxb+hJVq44Ffs3J3XMFafDMIx84aar1o5tZJOy4V0xYdkrQ/My8BYtu
         w/G1oJKgz2a/HvAXDFaWKjL2D5zGBK3p1O3fSsa1/wre1tW9+1w8tPszSO8D+q6oFQ20
         rYisf6EcAkgEou6XaIuU/rHbGfCtEuw3zlEJhb1+3uM6LnFEh+2m6L05iuK7uyc3VHzm
         bk61BHfw0ujGv4oTjKVK0jgZ8//NolCZkE45G2bS/d2MbxTaJxoEkU08Uf+BMNnyik9P
         xRVA==
X-Gm-Message-State: AO0yUKXaeZ+fqOcGsOk4bmo02uw+GROqjsCs/pMwE2JWCSIiNVrTlNO6
        R07f6geuAhZqWuTWkGVP7XCLmrtd1IY=
X-Google-Smtp-Source: AK7set97awHv0vPnpX2b4zBdaMOKC8pie5aoYFH0lfxZ7YCRKZrSTEQ4fN7d2MJ4a3TsnbpdCCe/OA==
X-Received: by 2002:a05:6402:22d3:b0:4fd:21a6:832d with SMTP id dm19-20020a05640222d300b004fd21a6832dmr14847681edb.11.1679824932901;
        Sun, 26 Mar 2023 03:02:12 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bcbe:8b00:30df:510c:6021:dbbf? (dynamic-2a01-0c23-bcbe-8b00-30df-510c-6021-dbbf.c23.pool.telefonica.de. [2a01:c23:bcbe:8b00:30df:510c:6021:dbbf])
        by smtp.googlemail.com with ESMTPSA id a18-20020a50c312000000b004c06f786602sm13280600edb.85.2023.03.26.03.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 03:02:10 -0700 (PDT)
Message-ID: <e5bbed2f-361c-8a6d-cc09-ea60163069e0@gmail.com>
Date:   Sun, 26 Mar 2023 12:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] pwm: meson: add support for S4 chip family
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
 <1j5yapot4j.fsf@starbuckisacylon.baylibre.com>
 <dc311f8c-a394-40fe-a4ca-6ef331d2b56b@gmail.com>
Content-Language: en-US
In-Reply-To: <dc311f8c-a394-40fe-a4ca-6ef331d2b56b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 25.03.2023 23:58, Heiner Kallweit wrote:
> On 25.03.2023 14:24, Jerome Brunet wrote:
>>
>> On Fri 24 Mar 2023 at 23:23, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>>> This adds pwm support for (at least) the s4 chip family. The extension
>>> is based on the vendor driver that can be found at [0]. There the
>>> version with the new clock handling is called meson-v2-pwm.
>>> Central change is that the clock is now fully provided by the SoC clock
>>> core. The multiplexer isn't any longer part of the pwm block.
>>
>> As far as the documentation is concerned this is not true.
>> There is a input multiplexer with the xtal, vid_pll, fdiv3 and fdiv4
>>
>> I'm not sure the differences mentionned here actually exists.
>>
> 
> I don't have access to a S905X4 datasheet, just to the one for S905X3.
> What makes me think that the hw is different:
> 
> - In the clock drivers for families before s4 I see no hint that
>   dedicated pwm clocks exist. From s4 there are CLKID_PWM_... clocks.
> 

In addition, that's what the relevant commit in the vendor driver says:

https://github.com/khadas/linux/commit/4f35972692b52a7f7b96f86b06c01feb7f3b3862

-> sc2 pwm controller moves clk to clktree


> - In the S905X3 datasheet I see no hint that the pwm block can be fed
>   from an external clock (except the standard 4 mux parents).
> 
>>>
>>> This was tested on a sc2-based system that uses the same pwm block.
>>>
>>> [0] https://github.com/khadas/linux/blob/khadas-vims-5.4.y/drivers/pwm/pwm-meson.c
>>
>> AFAICT, this looks more like a choice in vendor SDK to not use the input
>> mux. IOW, just SW decision.
>>
> 
> - If it would be a sw decision to use internal mux/div or an external
>   clock, then there should be a way to configure whether to use option a or b.
>   I see no such switch in the vendor driver code. Maybe you can check in the
>   datasheet whether there's such a switch.
> 
>> I don't think such change makes sense in mainline if the HW has not
>> actually changed.
>>
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>> Adding the amlogic,meson-s4-pwm compatible to the documentation was part
>>> of the yaml conversion already.
>>> ---
>>>  drivers/pwm/pwm-meson.c | 38 ++++++++++++++++++++++++++++++++++----
>>>  1 file changed, 34 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>>> index 16d79ca5d..7a93fdada 100644
>>> --- a/drivers/pwm/pwm-meson.c
>>> +++ b/drivers/pwm/pwm-meson.c
>>> @@ -98,6 +98,7 @@ struct meson_pwm_channel {
>>>  struct meson_pwm_data {
>>>  	const char * const *parent_names;
>>>  	unsigned int num_parents;
>>> +	unsigned int ext_clk:1;
>>>  };
>>>  
>>>  struct meson_pwm {
>>> @@ -158,6 +159,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>>  	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
>>>  	unsigned int duty, period, pre_div, cnt, duty_cnt;
>>>  	unsigned long fin_freq;
>>> +	int err;
>>>  
>>>  	duty = state->duty_cycle;
>>>  	period = state->period;
>>> @@ -165,6 +167,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>>  	if (state->polarity == PWM_POLARITY_INVERSED)
>>>  		duty = period - duty;
>>>  
>>> +	if (meson->data->ext_clk) {
>>> +		err = clk_set_rate(channel->clk, 0xffffUL * NSEC_PER_SEC / period);
>>> +		if (err) {
>>> +			dev_err(meson->chip.dev, "failed to set pwm clock rate\n");
>>> +			return err;
>>> +		}
>>> +	}
>>> +
>>>  	fin_freq = clk_get_rate(channel->clk);
>>>  	if (fin_freq == 0) {
>>>  		dev_err(meson->chip.dev, "invalid source clock frequency\n");
>>> @@ -173,10 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>>  
>>>  	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
>>>  
>>> -	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
>>> -	if (pre_div > MISC_CLK_DIV_MASK) {
>>> -		dev_err(meson->chip.dev, "unable to get period pre_div\n");
>>> -		return -EINVAL;
>>> +	if (meson->data->ext_clk) {
>>> +		pre_div = 0;
>>> +	} else {
>>> +		pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
>>> +		if (pre_div > MISC_CLK_DIV_MASK) {
>>> +			dev_err(meson->chip.dev, "unable to get period pre_div\n");
>>> +			return -EINVAL;
>>> +		}
>>>  	}
>>>  
>>>  	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
>>> @@ -445,6 +459,10 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
>>>  	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
>>>  };
>>>  
>>> +static const struct meson_pwm_data pwm_s4_data = {
>>> +	.ext_clk = 1,
>>> +};
>>> +
>>>  static const struct of_device_id meson_pwm_matches[] = {
>>>  	{
>>>  		.compatible = "amlogic,meson8b-pwm",
>>> @@ -478,6 +496,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>>>  		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>>  		.data = &pwm_g12a_ao_cd_data
>>>  	},
>>> +	{
>>> +		.compatible = "amlogic,meson-s4-pwm",
>>> +		.data = &pwm_s4_data
>>> +	},
>>>  	{},
>>>  };
>>>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>>> @@ -493,6 +515,14 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>>>  	for (i = 0; i < meson->chip.npwm; i++) {
>>>  		struct meson_pwm_channel *channel = &meson->channels[i];
>>>  
>>> +		if (meson->data->ext_clk) {
>>> +			snprintf(name, sizeof(name), "clkin%u", i);
>>> +			channel->clk = devm_clk_get(dev, name);
>>> +			if (IS_ERR(channel->clk))
>>> +				return PTR_ERR(channel->clk);
>>> +			continue;
>>> +		}
>>> +
>>>  		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>>>  
>>>  		init.name = name;
>>
> 

