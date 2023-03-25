Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CFD6C914D
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Mar 2023 23:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCYW6c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Mar 2023 18:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYW6b (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Mar 2023 18:58:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909444200
        for <linux-pwm@vger.kernel.org>; Sat, 25 Mar 2023 15:58:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er18so10463389edb.9
        for <linux-pwm@vger.kernel.org>; Sat, 25 Mar 2023 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679785108;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/kjrlpAFJlByb5r4kcgziG7xUQqgKCB9T/lzl/oWEY=;
        b=dvB66wq+RSjpshlc7rAytYTeerA1twetqLiFKSMlVlHA7A4uBQmzhrZeNfztNh8mUA
         MeOK/ipu2wd3VVp8pRnEPyJBpE2e4pbW401AwPpKH0MM308+AImF+mAxFzgWokECr+3X
         ELerERCGwXWCfUoqT8b2Bdfb2iWOiTYD8rqkmMPozhfZyU4jYgMllDN/WcYpIGXPVqc5
         SkIUMvcA4YYByUpjNcpZ8S/V+ZuZaClaNmU9zXdOi1/TiUlCDQ2W0JGjRgbVvQQbtTsG
         Bc/kcTf30JddOB+MwSrHGOIgfoZcxwoMnc44a7Q2mLYfQyv2E7kvNTFlTctyLNrLOD3K
         tlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679785108;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/kjrlpAFJlByb5r4kcgziG7xUQqgKCB9T/lzl/oWEY=;
        b=52SW4Af/jKVGpzMqMYt3Vi2DM6+vEk6N0/PYicjExeAJFcPbNaR9Yzu1OsDnGvWizt
         soiiJ6yDCcMfk4+CJQ/TbOa3vrrkd24CFOF4l9z8QPd2i30d3RNrjD1vciDpO2uKCVIv
         wPFkN95Q6aQUNsMotAfxy+FQeWsk4HC3douNMfppr+EmjyG24Koa7d9uh+DkOP9Zif2L
         DFyHIsBBcqzyyzQ0ONA3Y2m2zkW0OWPpSnSH4RG4FUPAwNd3heUgw4fps78oIIIRo5nq
         mYjSFRbZgL40gaqk1ItF1v7dvDt3bykEWNL8EyHUR6wavDIThhs66Q03sjgVLDtA5+G6
         /YPg==
X-Gm-Message-State: AAQBX9dEplofB9SIlSt7Ul1Mj8efP/sdl1/oVEEtqqbEObGd9Z93wcdk
        goWyANrYYLbSqfo/x4xsAzE=
X-Google-Smtp-Source: AKy350YRk1oS2DCigEsdS8fgzquum+EH0fXpn1asQ408Ll1dgOm2M4sGAEPwSoszRlrKFcFQ25Ix5Q==
X-Received: by 2002:a17:906:d283:b0:925:b187:ce5f with SMTP id ay3-20020a170906d28300b00925b187ce5fmr7060526ejb.35.1679785107706;
        Sat, 25 Mar 2023 15:58:27 -0700 (PDT)
Received: from ?IPV6:2a01:c22:73a5:2800:f0d1:6ea:6291:6c19? (dynamic-2a01-0c22-73a5-2800-f0d1-06ea-6291-6c19.c22.pool.telefonica.de. [2a01:c22:73a5:2800:f0d1:6ea:6291:6c19])
        by smtp.googlemail.com with ESMTPSA id v15-20020a170906858f00b0093229e527cdsm11805300ejx.42.2023.03.25.15.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 15:58:27 -0700 (PDT)
Message-ID: <dc311f8c-a394-40fe-a4ca-6ef331d2b56b@gmail.com>
Date:   Sat, 25 Mar 2023 23:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] pwm: meson: add support for S4 chip family
In-Reply-To: <1j5yapot4j.fsf@starbuckisacylon.baylibre.com>
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

On 25.03.2023 14:24, Jerome Brunet wrote:
> 
> On Fri 24 Mar 2023 at 23:23, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> This adds pwm support for (at least) the s4 chip family. The extension
>> is based on the vendor driver that can be found at [0]. There the
>> version with the new clock handling is called meson-v2-pwm.
>> Central change is that the clock is now fully provided by the SoC clock
>> core. The multiplexer isn't any longer part of the pwm block.
> 
> As far as the documentation is concerned this is not true.
> There is a input multiplexer with the xtal, vid_pll, fdiv3 and fdiv4
> 
> I'm not sure the differences mentionned here actually exists.
> 

I don't have access to a S905X4 datasheet, just to the one for S905X3.
What makes me think that the hw is different:

- In the clock drivers for families before s4 I see no hint that
  dedicated pwm clocks exist. From s4 there are CLKID_PWM_... clocks.

- In the S905X3 datasheet I see no hint that the pwm block can be fed
  from an external clock (except the standard 4 mux parents).

>>
>> This was tested on a sc2-based system that uses the same pwm block.
>>
>> [0] https://github.com/khadas/linux/blob/khadas-vims-5.4.y/drivers/pwm/pwm-meson.c
> 
> AFAICT, this looks more like a choice in vendor SDK to not use the input
> mux. IOW, just SW decision.
> 

- If it would be a sw decision to use internal mux/div or an external
  clock, then there should be a way to configure whether to use option a or b.
  I see no such switch in the vendor driver code. Maybe you can check in the
  datasheet whether there's such a switch.

> I don't think such change makes sense in mainline if the HW has not
> actually changed.
> 
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> Adding the amlogic,meson-s4-pwm compatible to the documentation was part
>> of the yaml conversion already.
>> ---
>>  drivers/pwm/pwm-meson.c | 38 ++++++++++++++++++++++++++++++++++----
>>  1 file changed, 34 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 16d79ca5d..7a93fdada 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -98,6 +98,7 @@ struct meson_pwm_channel {
>>  struct meson_pwm_data {
>>  	const char * const *parent_names;
>>  	unsigned int num_parents;
>> +	unsigned int ext_clk:1;
>>  };
>>  
>>  struct meson_pwm {
>> @@ -158,6 +159,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>  	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
>>  	unsigned int duty, period, pre_div, cnt, duty_cnt;
>>  	unsigned long fin_freq;
>> +	int err;
>>  
>>  	duty = state->duty_cycle;
>>  	period = state->period;
>> @@ -165,6 +167,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>  	if (state->polarity == PWM_POLARITY_INVERSED)
>>  		duty = period - duty;
>>  
>> +	if (meson->data->ext_clk) {
>> +		err = clk_set_rate(channel->clk, 0xffffUL * NSEC_PER_SEC / period);
>> +		if (err) {
>> +			dev_err(meson->chip.dev, "failed to set pwm clock rate\n");
>> +			return err;
>> +		}
>> +	}
>> +
>>  	fin_freq = clk_get_rate(channel->clk);
>>  	if (fin_freq == 0) {
>>  		dev_err(meson->chip.dev, "invalid source clock frequency\n");
>> @@ -173,10 +183,14 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
>>  
>>  	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
>>  
>> -	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
>> -	if (pre_div > MISC_CLK_DIV_MASK) {
>> -		dev_err(meson->chip.dev, "unable to get period pre_div\n");
>> -		return -EINVAL;
>> +	if (meson->data->ext_clk) {
>> +		pre_div = 0;
>> +	} else {
>> +		pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
>> +		if (pre_div > MISC_CLK_DIV_MASK) {
>> +			dev_err(meson->chip.dev, "unable to get period pre_div\n");
>> +			return -EINVAL;
>> +		}
>>  	}
>>  
>>  	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
>> @@ -445,6 +459,10 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
>>  	.num_parents = ARRAY_SIZE(pwm_g12a_ee_parent_names),
>>  };
>>  
>> +static const struct meson_pwm_data pwm_s4_data = {
>> +	.ext_clk = 1,
>> +};
>> +
>>  static const struct of_device_id meson_pwm_matches[] = {
>>  	{
>>  		.compatible = "amlogic,meson8b-pwm",
>> @@ -478,6 +496,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>>  		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>  		.data = &pwm_g12a_ao_cd_data
>>  	},
>> +	{
>> +		.compatible = "amlogic,meson-s4-pwm",
>> +		.data = &pwm_s4_data
>> +	},
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>> @@ -493,6 +515,14 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
>>  	for (i = 0; i < meson->chip.npwm; i++) {
>>  		struct meson_pwm_channel *channel = &meson->channels[i];
>>  
>> +		if (meson->data->ext_clk) {
>> +			snprintf(name, sizeof(name), "clkin%u", i);
>> +			channel->clk = devm_clk_get(dev, name);
>> +			if (IS_ERR(channel->clk))
>> +				return PTR_ERR(channel->clk);
>> +			continue;
>> +		}
>> +
>>  		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
>>  
>>  		init.name = name;
> 

