Return-Path: <linux-pwm+bounces-4101-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1F9D2620
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 13:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7B61F24610
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2024 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689841CC8A6;
	Tue, 19 Nov 2024 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="V3a3QIqc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB551CC150;
	Tue, 19 Nov 2024 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020699; cv=none; b=pIObqm6C897AgFxVhNn5f4Ydg05yCuBTkYLwLQsLSHqN3Ikp8IQdNN0gjiqMgPMumfoIVg9RJy/AJLiBuBlqMtlEUw3IOTGswigBGZhLOVfaQZd4HtLvfZxeCml/BoIpw0cW06CPAcANNlKvQYfqBHwAgj4Arz6FWUNQ9Njg9b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020699; c=relaxed/simple;
	bh=GuXTE2rLvrhvhbljrbM9nOqOwVkBoc7a9KbSflU9Nrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IN1FN6V7pHNoO1EeS5pLagOSekDwZ5ojgox3KUQ30RRMvi856F6kTcJGHvqbhzZAkvoRGcwfWjxcqYvn/Pnn9fyv930g8kwtjggtJ8PUj4A4OOzQjhvgrdAx6Y2fxC3lm4I1Jxc+4Yw8DkrQ7YVZhTSU6qpdfmhioieQVyz13AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=V3a3QIqc; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 754AF10000A;
	Tue, 19 Nov 2024 15:51:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 754AF10000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1732020695;
	bh=Ii7nhdIGuTiZ2Cjp6gNaEeAPJj6qad8DWD7J3M9rl2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=V3a3QIqc1iepwiiqH1aWfprboJYKy+tnR6chs74FjkRi9un1lzCESgB2sigYqsgfJ
	 W74e9xhXtC17Po3WC5U7pu2oWMcB3pOftWJxDnFwBh/t/4/5Dwm34DRHuRtIZJjZBl
	 4HChdB9wOoMRWyYOgAmiOD76xPXdtxX5YpTGO0t4eyauoHqkhpsxgZg/sB4i6ElURn
	 i+hOPRKiHjVIpvRq8tQHijglvNu3uzltqa1zfUSiyrv1gSBMBz1xihOSnZDRF3JqBQ
	 dt3YccXGJ+XJrvZOE0E+IxLUt01Z4H34BenH3wd+QuMGSlP6I8hYPCNjxADh1NYGq4
	 XgKUi+NpIqMQQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 19 Nov 2024 15:51:35 +0300 (MSK)
Message-ID: <ed5cdef1-aaa7-4ff3-a427-87eae4c90f18@salutedevices.com>
Date: Tue, 19 Nov 2024 15:51:34 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] pwm: meson: Support constant and polarity bits
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
CC: <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<linux-pwm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <20241016152553.2321992-1-gnstark@salutedevices.com>
 <20241016152553.2321992-3-gnstark@salutedevices.com>
 <w3igi2jmva6mfa7anlieyp3iiwfzhsvi3t37wwcqqtzdy42fqn@btmdsfsmpw7r>
 <f08513c8-56d6-4551-8ac6-84641c134552@salutedevices.com>
 <l5xvdndysdvtil472it6ylthcfam5jp7lh3son45mezq7dh2yk@3yj557k2o5k5>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <l5xvdndysdvtil472it6ylthcfam5jp7lh3son45mezq7dh2yk@3yj557k2o5k5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189267 [Nov 19 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/19 08:41:00 #26886618
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Uwe

On 11/7/24 11:41, Uwe Kleine-König wrote:
> On Wed, Nov 06, 2024 at 04:54:41PM +0300, George Stark wrote:
>> On 11/4/24 12:32, Uwe Kleine-König wrote:
>>>> @@ -68,6 +72,8 @@ static struct meson_pwm_channel_data {
>>>>    	u8		clk_div_shift;
>>>>    	u8		clk_en_shift;
>>>>    	u32		pwm_en_mask;
>>>> +	u32		const_en_mask;
>>>> +	u32		inv_en_mask;
>>>>    } meson_pwm_per_channel_data[MESON_NUM_PWMS] = {
>>>>    	{
>>>>    		.reg_offset	= REG_PWM_A,
>>>> @@ -75,6 +81,8 @@ static struct meson_pwm_channel_data {
>>>>    		.clk_div_shift	= MISC_A_CLK_DIV_SHIFT,
>>>>    		.clk_en_shift	= MISC_A_CLK_EN_SHIFT,
>>>>    		.pwm_en_mask	= MISC_A_EN,
>>>> +		.const_en_mask	= MISC_A_CONSTANT_EN,
>>>> +		.inv_en_mask	= MISC_A_INVERT_EN,
>>>>    	},
>>>>    	{
>>>>    		.reg_offset	= REG_PWM_B,
>>>> @@ -82,6 +90,8 @@ static struct meson_pwm_channel_data {
>>>>    		.clk_div_shift	= MISC_B_CLK_DIV_SHIFT,
>>>>    		.clk_en_shift	= MISC_B_CLK_EN_SHIFT,
>>>>    		.pwm_en_mask	= MISC_B_EN,
>>>> +		.const_en_mask	= MISC_B_CONSTANT_EN,
>>>> +		.inv_en_mask	= MISC_B_INVERT_EN,
>>>>    	}
>>>>    };

...

>>> Personally I'd prefer:
>>>
>>> 	value &= ~MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);
>>> 	if (meson->data->has_constant && channel->constant)
>>> 		value |= MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);
>>>
>>> even though your variant only mentions the mask once. While it has this
>>> repetition, it's clear what happens without having to know what
>>> meson_pwm_assign_bit() does. Maybe that's subjective?
>>
>> Actually I also don't like meson_pwm_assign_bit() too match and I'm
>> surprised there's no something like this in the kernel already.
>> I again objdumped versions meson_pwm_assign_bit() vs double mask repetition.
>> Unconditional bit clearing takes only a single instruction:
>>
>> // value &= ~channel_data->const_en_mask;
>> 9ac:	0a250040 	bic	w0, w2, w5
>>
>> So in the current series I could drop meson_pwm_assign_bit() and use:
>>
>> value &= ~channel_data->const_en_mask;
>> if (meson->data->has_constant && channel->constant)
>> 	value |= channel_data->const_en_mask;
>>
>> If it's decided now or later to drop meson_pwm_channel_data then
>> w\o meson_pwm_assign_bit() future patch will be line-to-line change.
>>
>> What you think?
> 
> Sounds sensible.

While changing the patch to drop meson_pwm_assign_bit() one thing
concerned me on the approach:

value &= ~channel_data->const_en_mask;
if (meson->data->has_constant && channel->constant)
	value |= channel_data->const_en_mask;

that we reset bit in the value var even if that bit is not supported on
the current SoC. I checked several datasheets for old SoCs and those 
bits are marked as unused (not even reserved) and I've never seen those
bits set. Still I'd offer to use precise condition for changing those 
bit. I'll send v3 let's discuss it again if you think I bother too much.

> 
> Best regards
> Uwe

-- 
Best regards
George

