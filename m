Return-Path: <linux-pwm+bounces-2223-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C58CC79F
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 22:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1231C20CE7
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27356145B33;
	Wed, 22 May 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HkZa7hGc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05282F4E7
	for <linux-pwm@vger.kernel.org>; Wed, 22 May 2024 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716408368; cv=none; b=tXWzMSvTBfwPNUjOjWjvGBInBCacxu8gjKW3o+LQ41vlyu/XcDR/9Wy5u55NafpikU5tMLIS+Jc0go/sHELu+iiJh6thCItrtgZMqr6RvPH+QJJazI5cMGFOp4uJ8taZq8h04b4daMfBtF48bIu4pxSP2kl1i9s/NWrHXJxuFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716408368; c=relaxed/simple;
	bh=zkCJWYYFlcj5D3tT+xTyw8Pg3kAf4fTMTuu0pKc9aJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mU1iJQOq4EiYFcnHKwPz4r4iv77LOMZ5EbGL069d3C1g/4OdF8uH1Fnj1OA4fUtqmqKxiZ4gIXCt+M0ks6BQsF7ljQs9MKK+4rL7ewQ9pX7iAXPiSS20Im3lZOmfEH0qxk6w0D49pzifkWCgZwdk32JZtRgG+lUUkZpVoL2//Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HkZa7hGc; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-794977cbcc3so77192885a.0
        for <linux-pwm@vger.kernel.org>; Wed, 22 May 2024 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716408363; x=1717013163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dd7GrKK6qrVpweRGgoT/fw8t7w7OjlAlF8Ebyefp99A=;
        b=HkZa7hGc7qW3wUC3MJ5LHI8JbKnnBNPZWfpqPPWlXrRSMRteOK/e2iFFSuW0eaPaj7
         9pkMOy37mKY3F1GdyyQz3W85TwMv+X7SjC235fw9J9f6WIPeHGRe7oSUUxg9HJ3ZAq8M
         ppgI8BsQRVSmDkfMwYj6Ij2IBYK8AYQCytmxIGdN1FPAT9syBc57wv5AgFE3Si+ePINg
         hR5PQxy6FWXG7RHPqFPwLu12l4UsiUVc+pD1UZqgDtSpXrlcnxP7H3HpvM5g1k8hCAzK
         EPBr5DJB+ZNIjGUGAIi9EuFqg6AF4KUAshv7DfwP1v+7Iv5RWgR6EMydVHcLbrOQfSev
         xDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716408363; x=1717013163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd7GrKK6qrVpweRGgoT/fw8t7w7OjlAlF8Ebyefp99A=;
        b=gNgWP7yWC92+2UvSVRECCIz6pxVnnjJOqDubnEVALT8c/60NQLtF1SEt5HqvjMrhc5
         2756nIJJQPs8tT5217jOpETzOyiiw88wGefUFIiBrjGcy36IL9P6YCrX4DgtRm7CSWeX
         hK0wPfdm2O2R914FDcza2g0BrP6626smA07u7fdR8dnrjWy9EwGfiWYZHPNVB7s5Thoz
         cRdVcaKrgZS5aMs/pPcHTDmSoMLK0GKwDRDEeCvGcAqyLmYmfoGn7ar/9CNuOKBLppOz
         h/T8xyXIJjVJPvXWe1+87tzi1/8xDRPdSukiiupkwI5EEf5KmPZ4ZKBvGYLOr3rXzBq4
         0gyw==
X-Gm-Message-State: AOJu0YxFg3Kd8kOvsbkcMDwhaNcPkYwLZ0VP+DqBg1OV+acs6C+63m/+
	oB1yWlP5ITbSXlelswUxYKP/KRMmbR/V5/y9NcT1uzxIvlUjZAs7lZL8BTrMico=
X-Google-Smtp-Source: AGHT+IGGldJXhqigbx8J7LMJWdYC3ut5BDoxC+SGxjvsaI+ZsTWHQpthKxu5elgY1i6ljiF++PxgQw==
X-Received: by 2002:a05:620a:20cb:b0:794:7969:5d66 with SMTP id af79cd13be357-794994b20d4mr274602485a.55.1716408362773;
        Wed, 22 May 2024 13:06:02 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf275229sm1428443185a.18.2024.05.22.13.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 13:06:02 -0700 (PDT)
Message-ID: <8cd080ef-e1f3-4752-8f92-d61c5fd321b5@baylibre.com>
Date: Wed, 22 May 2024 16:06:00 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v3] pwm: add duty offset support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com
References: <20240521194916.1897909-1-tgamblin@baylibre.com>
 <20240521194916.1897909-2-tgamblin@baylibre.com>
 <73y7ovftjv35gw3sjeu3jisg7feplhyebmcnldqvszuofqnn7q@eh4lyicuhfmq>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <73y7ovftjv35gw3sjeu3jisg7feplhyebmcnldqvszuofqnn7q@eh4lyicuhfmq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-05-22 11:53 a.m., Uwe Kleine-König wrote:
> Hello Trevor,
>
> On Tue, May 21, 2024 at 03:49:15PM -0400, Trevor Gamblin wrote:
>> Some PWM chips support a "phase" or "duty_offset" feature. This patch
>> continues adding support for configuring this property in the PWM
>> subsystem.
>>
>> Functions duty_offset_show(), duty_offset_store(), and
>> pwm_get_duty_offset() are added to match what exists for duty_cycle.
>>
>> Add a check to disallow applying a state with both inversed polarity and
>> a nonzero duty_offset.
>>
>> Also add duty_offset to TP_printk in include/trace/events/pwm.h so that
>> it is reported with other properties when using the event tracing pipe
>> for debug.
>>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
>> v3 changes:
>> * rebased on top of latest pwm/for-next
>> * removed changes related to cdev to match current pwm tree
>> * fixed minor whitespace issue caught by checkpatch
>>
>> v2 changes:
>> * Address feedback for driver in v1:
>>    * Remove line setting supports_offset flag in pwm_chip, since that has
>>      been removed from the struct in core.c.
>>
>> ---
>>   drivers/pwm/core.c         | 79 +++++++++++++++++++++++++++++++++++---
>>   include/linux/pwm.h        | 15 ++++++++
>>   include/trace/events/pwm.h |  6 ++-
>>   3 files changed, 93 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 18574857641e..2ebfc7f3de8a 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -62,6 +62,7 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>>   	 */
>>   	if (s1.enabled && s1.polarity != state->polarity) {
>>   		s2.polarity = state->polarity;
>> +		s2.duty_offset = s1.duty_cycle;
> s/duty_cycle/duty_offset/
Thanks for the catch.
>
>>   		s2.duty_cycle = s1.period - s1.duty_cycle;
>>   		s2.period = s1.period;
>>   		s2.enabled = s1.enabled;
>> @@ -103,6 +104,23 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>>   			 state->duty_cycle, state->period,
>>   			 s2.duty_cycle, s2.period);
>>   
>> +	if (state->enabled &&
>> +	    last->polarity == state->polarity &&
>> +	    last->period == s2.period &&
>> +	    last->duty_offset > s2.duty_offset &&
>> +	    last->duty_offset <= state->duty_offset)
>> +		dev_warn(pwmchip_parent(chip),
>> +			 ".apply didn't pick the best available duty offset (requested: %llu/%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
>> +			 state->duty_offset, state->period,
> Does it make sense to emit $duty_offset/$period here? Establishing a
> consistent way to write this would be nice. Something like:
>
> 	$duty_cycle/$period [+$duty_offset]
>
> maybe?
I like that. I'll clean it up.
>
>> +			 s2.duty_offset, s2.period,
>> +			 last->duty_offset, last->period);
>> +
>> +	if (state->enabled && state->duty_offset < s2.duty_offset)
>> +		dev_warn(pwmchip_parent(chip),
>> +			 ".apply is supposed to round down duty_offset (requested: %llu/%llu, applied: %llu/%llu)\n",
>> +			 state->duty_offset, state->period,
>> +			 s2.duty_offset, s2.period);
>> +
>>   	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
>>   		dev_warn(pwmchip_parent(chip),
>>   			 "requested disabled, but yielded enabled with duty > 0\n");
>> @@ -126,12 +144,13 @@ static void pwm_apply_debug(struct pwm_device *pwm,
>>   	if (s1.enabled != last->enabled ||
>>   	    s1.polarity != last->polarity ||
>>   	    (s1.enabled && s1.period != last->period) ||
>> +	    (s1.enabled && s1.duty_offset != last->duty_offset) ||
>>   	    (s1.enabled && s1.duty_cycle != last->duty_cycle)) {
>>   		dev_err(pwmchip_parent(chip),
>> -			".apply is not idempotent (ena=%d pol=%d %llu/%llu) -> (ena=%d pol=%d %llu/%llu)\n",
>> +			".apply is not idempotent (ena=%d pol=%d %llu/%llu/%llu) -> (ena=%d pol=%d %llu/%llu/%llu)\n",
>>   			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
>> -			last->enabled, last->polarity, last->duty_cycle,
>> -			last->period);
>> +			s1.duty_offset, last->enabled, last->polarity,
>> +			last->duty_cycle, last->period, last->duty_offset);
>>   	}
>>   }
>>   
>> @@ -146,13 +165,24 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>>   	int err;
>>   
>>   	if (!pwm || !state || !state->period ||
>> -	    state->duty_cycle > state->period)
>> +	    state->duty_cycle > state->period ||
>> +	    state->duty_offset > state->period)
>>   		return -EINVAL;
>>   
>>   	chip = pwm->chip;
>>   
>> +	/*
>> +	 * There is no need to set duty_offset with inverse polarity,
>> +	 * since signals with duty_offset values greater than 0.5 *
>> +	 * period can equivalently be represented by an inverted signal
>> +	 * without offset.
> This isn't exact. The equation is:
>
> 	state_with_offset.period = inverted_state.period
> 	state_with_offset.duty_cycle = inverted_state.period - inverted_state.duty_cycle
> 	state_with_offset.duty_offset = inverted_state.duty_cycle
>
> And with duty_offset you can express more wave-forms than with
> inversion.
Thanks for the clarification, I'll change this too.
>
>> +	 */
>> +	if (state->polarity == PWM_POLARITY_INVERSED && state->duty_offset)
>> +		return -EINVAL;
>> +
>>   	if (state->period == pwm->state.period &&
>>   	    state->duty_cycle == pwm->state.duty_cycle &&
>> +	    state->duty_offset == pwm->state.duty_offset &&
>>   	    state->polarity == pwm->state.polarity &&
>>   	    state->enabled == pwm->state.enabled &&
>>   	    state->usage_power == pwm->state.usage_power)
> While I like the added expressiveness of having .duty_offset, I think we
> shouldn't let the low-level drivers face both .duty_offset and
> .polarity.
>
> I suggest to add a new callback similar to .apply that gets passed a
> variant of pwm_state that only has
>
> 	u64 period
> 	u64 duty_cycle
> 	u64 duty_offset
>
> period = 0 then signals disable. Implementers are then supposed to first
> round down period to a possible period (> 0), then duty_cycle to a
> possible duty_cycle for the picked period and then duty_offset to a
> possible duty_offset with the picked period and duty_cycle.
>
> Then there is a single code location that handles the translation
> between state with polarity and state with duty_offset in the core,
> instead of case switching in each lowlevel driver. And I wouldn't
> add .duty_offset to the sysfs interface, to lure people into using the
> character device support which has several advantages over the sysfs
> API. (One reasonable justification is that we cannot remove polarity
> there, and we also cannot report polarity = normal + some duty_offset
> without possibly breaking assumptions in sysfs users.)
Makes sense. On a related note, will your pwm/chardev branch be merged soon?
>
> What is missing in my plan is a nice name for the new struct pwm_state
> and the .apply() (and matching .get_state()) callback. Maybe pwm_nstate,
> .apply_nstate() and .get_nstate()? n for "new", which however won't age
> nicely. Maybe it also makes sense to add a .round_nstate() in the same
> go. We'd have to touch all drivers anyhow and implementing a rounding
> callback (that has similar semantics to clk_round_rate() for clocks,
> i.e. it reports what would be configured for a given (n)state) isn't
> much more work. With rounding in place we could also request that
> .apply_nstate() only succeeds if rounding down decrements the values by
> less than 1, which gives still more control. (The more lax variant can
> then be implemented by first passing an nstate to .round_nstate and then
> .apply_nstate that one.)

Instead of "new", what about something like "raw", "base", "signal", or 
"waveform"? I think those (even abbreviated) might make it more clear 
what the purpose of the new struct is. "wstate" seems to be fairly 
unique to me - a quick grep caught other uses of the string only in:

- tools/testing/selftests/net/mptcp/mptcp_connect.c

- arch/sparc/include/asm/hibernate.h

- arch/sparc/kernel/asm-offsets.c

Thanks again for the feedback. I'll spend some time thinking about this 
and aim to come back with a v4 soon.

Trevor

>
> Best regards
> Uwe
>

