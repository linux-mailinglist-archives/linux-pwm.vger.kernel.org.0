Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B79F6C8CF9
	for <lists+linux-pwm@lfdr.de>; Sat, 25 Mar 2023 10:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCYJn2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Mar 2023 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjCYJn1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Mar 2023 05:43:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F212D46A6
        for <linux-pwm@vger.kernel.org>; Sat, 25 Mar 2023 02:43:25 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t10so16791837edd.12
        for <linux-pwm@vger.kernel.org>; Sat, 25 Mar 2023 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679737404;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irY3kauuEAWHlPP7SIvURQ+4Z1X6TILKILmsrBeQtRc=;
        b=JubLcFHunBB9x9eRX9pAJjgb7sokIxKieUa++sesvjeX6NBav5M/UGU0LNrhzRvUMs
         WKXnnU8nAnIGWAjiQUZbdeH6RUBkt4R1pmaD4KKRzPABDQOLII1gw1V/wS1PGMKXh9DT
         t2o3nUaG1gBPW0wd+/tDw7Thx9xZNu42URMwbPvVjY0Dl4/B0W9P4feTrKXLNaff4Roo
         8Q1CtprroVK44pxSlg51O21OR/N0vZwxPrmSblKTRfrkQjRvHavm4m6QwgbpxlIJeUFe
         9+PlJ9FewNj7yFOaXojJSGpCJvAgp2Ib1ZVfo6jA34hExFNIiisDZ1XJZ01oZTg9N/Qe
         n7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679737404;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irY3kauuEAWHlPP7SIvURQ+4Z1X6TILKILmsrBeQtRc=;
        b=Dbo4T9SFbYIINdA3amCNUXThmKGWo1qlYU3g5UrsunRwsGpclIaoHxgMcHeaWFqsm8
         CO35eHLk6/xjnswoMT1QAzpX41IXKSaCYVWip/IE8NDM+HvNE921nz2dJRe6XiWNIJJ3
         tCQBBbOrAJPfahQhM4IqCkg8cCDU4C5Y1y67LMmMGq9ZOXsNYaSL3H72sEI8h/qxR5a0
         dqm4OaD3r8Ki7Zbhv5+lXeT9v0cWZM2yYaOA36CoxS0+yvTPSlNSgz5YrVwFbXl1Sc4S
         WAbjQ79xrikYqELlEVu4rmr57lyH8ihMfR5MNsz6j9PQNfCz60XqVt8/FdI5RuFcqS82
         Vfzg==
X-Gm-Message-State: AAQBX9fi77RsKdqb0Fnx2CJcf/gCtffNh5yFPznrD9dsg8afOnBppumR
        h6lEmn7TFRgMqvlLFg9RGcY=
X-Google-Smtp-Source: AKy350a2XB9kr+MdUkofF+MNfzTczpHuYrOsjmLaI+LACAhF58Qz4bGuhm2/FGETRSAEMlkm/d8VAw==
X-Received: by 2002:a17:906:9b89:b0:8b2:b711:5e62 with SMTP id dd9-20020a1709069b8900b008b2b7115e62mr7131516ejc.52.1679737403997;
        Sat, 25 Mar 2023 02:43:23 -0700 (PDT)
Received: from ?IPV6:2a01:c22:73a5:2800:e59a:ffcb:c722:70cf? (dynamic-2a01-0c22-73a5-2800-e59a-ffcb-c722-70cf.c22.pool.telefonica.de. [2a01:c22:73a5:2800:e59a:ffcb:c722:70cf])
        by smtp.googlemail.com with ESMTPSA id d13-20020a170906344d00b009318ad4a583sm11565655ejb.210.2023.03.25.02.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 02:43:23 -0700 (PDT)
Message-ID: <654c8fff-9ea7-8f6e-e2ea-5525b175cc1b@gmail.com>
Date:   Sat, 25 Mar 2023 10:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <fad131e9-265f-6c4d-3223-932f69c9a927@gmail.com>
 <20230325082004.q7suqrt2udzgq4mb@pengutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] pwm: meson: add support for S4 chip family
In-Reply-To: <20230325082004.q7suqrt2udzgq4mb@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 25.03.2023 09:20, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Mar 24, 2023 at 11:23:09PM +0100, Heiner Kallweit wrote:
>> This adds pwm support for (at least) the s4 chip family. The extension
>> is based on the vendor driver that can be found at [0]. There the
>> version with the new clock handling is called meson-v2-pwm.
>> Central change is that the clock is now fully provided by the SoC clock
>> core. The multiplexer isn't any longer part of the pwm block.
>>
>> This was tested on a sc2-based system that uses the same pwm block.
>>
>> [0] https://github.com/khadas/linux/blob/khadas-vims-5.4.y/drivers/pwm/pwm-meson.c
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> Adding the amlogic,meson-s4-pwm compatible to the documentation was part
>> of the yaml conversion already.
> 
> This refers to
> https://lore.kernel.org/linux-pwm/3edc5ba6-bf3d-e45b-377a-9e7ece7642a7@gmail.com
> 
Right

> Does the external mux clk behave in the same way as the internal ones
> before? (I.e. it can select one of a few parents and has a single
> divider?)
> 
Yes, it's a standard clock with few parents, a mux, and a divider.

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
> 
> err could be local to this block.
> 
OK

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
> 
> This requires a binding change, right? Would it make sense to drop the
> ext_clk flag and determine that by trying to get the clk and if it's
> there, assume ext_clk would have been set?
> 
Clocks clkin0 and clkin1 are used already, therefore the binding doesn't change.
Just the type of clock usage is different. So far the clocks are the parents
for the internal mux/div, now it's the "final" clocks.

> Also I wonder if it would make sense to use the same name as used when
> the mux clk is internal, i.e. reuse name from the line below.
> 
IMO this name is ok when used internally, but wouldn't be nice if used in
the binding, e.g. because part of it is dev_name(dev). Therefore I'd prefer
to stick with the clkin0/clkin1 names.

>>  		snprintf(name, sizeof(name), "%s#mux%u", dev_name(dev), i);
> 
> Best regards
> Uwe
> 
Heiner

