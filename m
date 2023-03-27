Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960376CA493
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Mar 2023 14:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjC0Muz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Mar 2023 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0Muy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Mar 2023 08:50:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A640FC
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2023 05:50:51 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so8673452wrh.6
        for <linux-pwm@vger.kernel.org>; Mon, 27 Mar 2023 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679921450;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=T37WvrK7gDgqaEqWmPcTVPmlzV4CvonsfwxEYNlwENk=;
        b=viBEClOZI5g4+bZRdZVYllM5wFrQ8mY8u1EPpWeY79F+3B61vjsMM6ZzJnkEJOBEMi
         2RbqS9lYDcyP+OdcXC4NqwlSi3wtD4bHgS5hrL4Dryq3HFsMYptmD3fUSJtChoLiYGF8
         rmyNPVAU7fVfaXptIPxPM2Pu2wY5MN7hecQ4+aPw4DeWIcbIfYtfd4uf6C3Wrr3WyKPN
         1o6xBvKWS1VmPDMuouC6Gci+vx0UUclULiTCnfrAHWEEN0zlnntGnGau/KnQXfR+ki+o
         knOc/UcXrANjHPmS6S71upOgy+utTN7KOaHPNp1UPjm0KG5M+HqT+Wd/fYxA+g3yK/FZ
         IbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921450;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T37WvrK7gDgqaEqWmPcTVPmlzV4CvonsfwxEYNlwENk=;
        b=oe5q+eawFCUeCMvjtaz6jKoNnp7L4aK7LzG3ezVxoRd1pZrwFerYQw0eKbF2x+3d4l
         6Ccyn7vWrPyQzx36sodee25t6vtt53s/aBEtbnOoFgXYejhjcxKxxHLrgMrLcG0+DJMd
         o4e50Rz5YuVmDoBKgVtPvuZEvgQPpHdLANPNIIQ3MrMBIcdI8vDHiCNX9VcTo5LPw4Pg
         7x/h9q2PIte9/zG3iH2EmAsbm0x/8m0t9IGJBSuOvJShDi06TBtw53XwT9qXouj7sfVz
         3QzOp+LMLANslWVBhqkGXtRaIxY9Q7H096tCvvHuY+QiQ//rjfv5/cxzPQz8w47Kc8Eg
         08FA==
X-Gm-Message-State: AAQBX9fKQyyW7hSEf5JHEjvW96rGg8mu5Ekm/yd3ycejJYkbyDTBeOnp
        fMDFRzeNt5fTh3i90wJJvdyZAA==
X-Google-Smtp-Source: AKy350brhUDJrcLAM1cHvnz/Xsrzr06tXoFTSsQXVigOh12vuehFkA1Ljkls0ww0F1JXKEWQeZMH1Q==
X-Received: by 2002:adf:e9d1:0:b0:2d6:6af:4891 with SMTP id l17-20020adfe9d1000000b002d606af4891mr8305953wrn.3.1679921450158;
        Mon, 27 Mar 2023 05:50:50 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002cfe685bfd6sm25060991wrw.108.2023.03.27.05.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:50:49 -0700 (PDT)
References: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
 <1j5yapot4j.fsf@starbuckisacylon.baylibre.com>
 <dc311f8c-a394-40fe-a4ca-6ef331d2b56b@gmail.com>
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
Date:   Mon, 27 Mar 2023 14:13:50 +0200
In-reply-to: <dc311f8c-a394-40fe-a4ca-6ef331d2b56b@gmail.com>
Message-ID: <1jedpanys6.fsf@starbuckisacylon.baylibre.com>
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


On Sat 25 Mar 2023 at 23:58, Heiner Kallweit <hkallweit1@gmail.com> wrote:

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

That the clock driver concern, not the PWM one.

The fact is the whole PWM clock block is still there.
It still has 4 inputs, which may be improperly documented AFAICT.

As previously stated, the doc says: xtal, vid_pll, fdiv3 and fdiv4

Since Amlogic does not bother to intialize the "SEL" value anymore, you
may assume the PWM clock is connected to the input number maching the
register field value. (most likely 0 - so replacing the XTAL)

Since you have been able to test this - change this SEL field, you'll see
what it does and should be able to determine which clock is behind each
of the mux inputs.

>
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

