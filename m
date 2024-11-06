Return-Path: <linux-pwm+bounces-4040-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E05F89BEF86
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 14:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2A8B2479C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2024 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD481DF747;
	Wed,  6 Nov 2024 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ftP6I8KI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65140201011;
	Wed,  6 Nov 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901299; cv=none; b=By3nHm3TZbVLKSYf21j4R4tGTt3+a4QFj0/uj2TEHk5C+RBvLX/0z1SL1CdjDeLRNMkejH7Hb6s4UaQG3zTV0yhPgjCGZu4OuvmIODpJQOs3WZGHACDFKKRDg4zfntFUmNMMJowbUlBlHioIjPjyJA+y8gbwHaPni2kCmHcwY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901299; c=relaxed/simple;
	bh=Sfw1gAiy1cCy8QCHZMOzCQQMC8sWPK+f7SqnefWeOUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cmp8LJTsDKSDPlABkq76DBLeRNhUU3JaNJd+KxyyBl3Ct65fJPQHKNofcnDv7N2IdD5NGjq+J2LM4fO9oqRxxhmONDheoXHTgDrixdjJrBJADL63ntV3AKnFrItDfYf7Y2btp8F1lOsavq9pcHMQIGOOxjhOFxXSlN11eIep0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ftP6I8KI; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CC512100027;
	Wed,  6 Nov 2024 16:54:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CC512100027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1730901282;
	bh=TamoRQHVz3CLLV4TriCaXhJ6JFCj9iwTzd2ELzYslvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=ftP6I8KI+D0QkunWuobJM9R6/TLFnROf1F1QNLBw6FPYpuIo6tY4d3yl3W9LMy4L1
	 pe+Z6mmHZGG9cDWB+GaWLZsp8W708Cv+E4Nxq5TjF8SrudxCEbW9ikIAnTWEMrbOJf
	 2VUhYXX/AIUGMe2zxIJnKxohEqC5Yjw2jmewuVDMx9NgMT30ACU3zLm+LXueCVLeFa
	 Q8MSFaAJt4t3WPtpvZDVP07WJucipz1r+ImTxYCOSxkCuCJk7tOiGv0gDdqnhFlP8k
	 R8mkR8NcSwfxW9HcKtebB7e/FyukW3kWRvm2CR6yF2J9DZidXV1iuSslXStARAM96t
	 iAG3vPqk8zEEg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  6 Nov 2024 16:54:42 +0300 (MSK)
Message-ID: <f08513c8-56d6-4551-8ac6-84641c134552@salutedevices.com>
Date: Wed, 6 Nov 2024 16:54:41 +0300
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
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <w3igi2jmva6mfa7anlieyp3iiwfzhsvi3t37wwcqqtzdy42fqn@btmdsfsmpw7r>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188995 [Nov 06 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/06 12:26:00 #26826484
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Uwe

Thanks for the review.

On 11/4/24 12:32, Uwe Kleine-König wrote:
> Hello George,
> 
> there are two minor things I dislike in this patch/driver. But I'm not
> sure the alternatives are objectively considerably better. See below and
> judge yourself.

...

>> @@ -68,6 +72,8 @@ static struct meson_pwm_channel_data {
>>   	u8		clk_div_shift;
>>   	u8		clk_en_shift;
>>   	u32		pwm_en_mask;
>> +	u32		const_en_mask;
>> +	u32		inv_en_mask;
>>   } meson_pwm_per_channel_data[MESON_NUM_PWMS] = {
>>   	{
>>   		.reg_offset	= REG_PWM_A,
>> @@ -75,6 +81,8 @@ static struct meson_pwm_channel_data {
>>   		.clk_div_shift	= MISC_A_CLK_DIV_SHIFT,
>>   		.clk_en_shift	= MISC_A_CLK_EN_SHIFT,
>>   		.pwm_en_mask	= MISC_A_EN,
>> +		.const_en_mask	= MISC_A_CONSTANT_EN,
>> +		.inv_en_mask	= MISC_A_INVERT_EN,
>>   	},
>>   	{
>>   		.reg_offset	= REG_PWM_B,
>> @@ -82,6 +90,8 @@ static struct meson_pwm_channel_data {
>>   		.clk_div_shift	= MISC_B_CLK_DIV_SHIFT,
>>   		.clk_en_shift	= MISC_B_CLK_EN_SHIFT,
>>   		.pwm_en_mask	= MISC_B_EN,
>> +		.const_en_mask	= MISC_B_CONSTANT_EN,
>> +		.inv_en_mask	= MISC_B_INVERT_EN,
>>   	}
>>   };
> 
> So the generic register description describes the const and invert bits,
> but it doesn't apply to all IPs. Thinking about that, I wonder why this
> struct exists at all. I would have done this as follows:
> 
> 	#define MESON_PWM_REG_PWM(chan)		(0 + 4 * (chan))
> 
> 	#define MESON_PWM_REG_MISC		(8)
> 	#define MESON_PWM_REG_MISC_EN(chan)		BIT(chan)
> 	#define MESON_PWM_REG_MISC_CLK_SEL(chan)	GENMASK(5 + 2 * (chan), 4 + 2 * (chan))
> 	....
> 
> and then use these constants directly (with pwm->hwpwm as parameter if
> needed) in the code. I would expect this to result in more efficient and
> smaller code.

I've been looking into this driver for more than a year and got used to
it so much so never thought about changing the foundations :) Although 
it's an interesting thought.

1. I took meson_pwm_enable() without
const patches and reimplemented it using only defines (e.g. w/o local
var channel_data) and objdumped current and new versions. New version
turned out to be one instruction longer (arm64, gcc, default -O2). So 
total difference in executable code may be not that significant although
we can win in C-code line count.

2. Things like
#define MISC_B_EN		BIT(1)
#define MISC_A_EN		BIT(0)
is more straightforward and can be matched to the datasheet easier
comparing to (a + b * (chan)) things.

So I'm not sure either.

>> @@ -227,6 +252,15 @@ static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>>   
>>   	value = readl(meson->base + REG_MISC_AB);
>>   	value |= channel_data->pwm_en_mask;
>> +
>> +	if (meson->data->has_constant)
>> +		meson_pwm_assign_bit(&value, channel_data->const_en_mask,
>> +				     channel->constant);
> 
> Personally I'd prefer:
> 
> 	value &= ~MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);
> 	if (meson->data->has_constant && channel->constant)
> 		value |= MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);
> 
> even though your variant only mentions the mask once. While it has this
> repetition, it's clear what happens without having to know what
> meson_pwm_assign_bit() does. Maybe that's subjective?
> 

Actually I also don't like meson_pwm_assign_bit() too match and I'm
surprised there's no something like this in the kernel already.
I again objdumped versions meson_pwm_assign_bit() vs double mask 
repetition. Unconditional bit clearing takes only a single instruction:

// value &= ~channel_data->const_en_mask;
9ac:	0a250040 	bic	w0, w2, w5

So in the current series I could drop meson_pwm_assign_bit() and use:

value &= ~channel_data->const_en_mask;
if (meson->data->has_constant && channel->constant)
	value |= channel_data->const_en_mask;

If it's decided now or later to drop meson_pwm_channel_data then
w\o meson_pwm_assign_bit() future patch will be line-to-line change.

What you think?

> Best regards
> Uwe

-- 
Best regards
George

