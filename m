Return-Path: <linux-pwm+bounces-5108-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A530BA50284
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 15:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167511885B9B
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2324E008;
	Wed,  5 Mar 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hs1AY+IA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E224BC1A
	for <linux-pwm@vger.kernel.org>; Wed,  5 Mar 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185781; cv=none; b=eON+iLD3nfBGzATA06ax4R51dUGElDbiZcNz7T+pu+5JZPC84MtT1qintICfHhBP/3UEQ+Q022GIf5DvTVeLYXNtZpxdKhaPf9byLCFiu5PYTEAKV//MiN8u8v9jzsjSrd/yA8S1l6I7lDAHsFYbGC507NrgAdQdMgBNW7uV4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185781; c=relaxed/simple;
	bh=W/cFTtjUPjloF/TEE1KZm3u7DpwmHS8nwZr4v423BxE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FboQ9PElrKvfEtgIgVZ24gRSn+cnbGnZq+kACUw6VJfUP0S/GSwjhtEAplIBrfU2f8okFdnKE2/6lhA/5eecu9lE9vnBdIWjumLRGPaDxTQJ1rr+xyOsxdxGhqhDWOIMI//m609gBNIwFJ5odGBYXlLZWi2ttplBoC7qGz5Hmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hs1AY+IA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso629001f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 05 Mar 2025 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741185778; x=1741790578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRLdSry5OGKnrSFvS+LP96NBp0+rBD/EpukWTUX58+k=;
        b=Hs1AY+IA6SS+nB9EnL97q9Hs0RU1ENouP1YrjQ5xi7TCwsM5r3b5bVu1Ubl6k4TIA2
         sssFz//TjQq/jdgOueUgXLUChM5mIPxyWRLkoCZmQRqwS5Up8KxSXnhhpC32aeQv5mpS
         GGfXjtcOmnk+1JTFQmcKJTdUhVvSvbjeOspm08BJ3Zm/pXaKnXE+wLxxDEF/Mi9FXFs0
         dWnxT2Pp/w4FpCwdtDBPyEUCtbLmL28hQWUVXigqZCNQZtKtI+a3cAj2ownIwGLyeylJ
         aUO8C23Zef8OgXyahWrr8xWXrUPsuIqqq/YSLKRn+43i2VaukQWeSVKH4vyGBhn1IaQg
         Y5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185778; x=1741790578;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRLdSry5OGKnrSFvS+LP96NBp0+rBD/EpukWTUX58+k=;
        b=g+Y2/I/coAF9i0B5INbRcVh7AjnwKi9W1rKxRIWB0eBpiabv6WPZD32eTPGMfKD/wW
         Udk+Yb6VdpIkYGnnn9u7PXUlem0j9JdnUkhdNFim7VB9yCCAi/ipgeHpYGfNdgfMHE0G
         LG7PgUskWLYuOdM5JOceWPwOZQw6+LfqUfqvyEiORY+G5vbcWCw0I7QQFVBfmGHUplXn
         UWdV5GSW/6GofTK3E4XrQPF+6PvrZZ7rKwcDJaTb3S9LV/ZOA9l3trCSDWsoTHoY2p6Z
         lhQjhhCBlqTO59kFTBZJ0Pr1ie1fDZtfWq5dd5Xm8OKwKHOUkdfkXCXovTv93p1F/DLX
         tCAA==
X-Forwarded-Encrypted: i=1; AJvYcCUO904FVNN12lcfSeNC+NsQib8wI03947LTlUUCKCesXBAdvhJQJ8c7SvVqdpQRmztJ9lkxDZPXxbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgj7E/AdJFTgSULUXU896aV1Ju+nEtIzjowi/a3yAdjv8m5EU
	UB9oNAJw4xsBR7Nt8dELRo8DmU5AtDaiKQTVoXnQGMiEFUX1BjcDFbnZJCV7pOQ=
X-Gm-Gg: ASbGncvZTpGW9Myu+ymFI9aV9e80OrNnbcItSQDACs4B/AwoZhax4JRYBm43MSrCgq+
	LNMy0XNug8FcRzFucJhVQUWCdHPC4O8vtWk95QAVJIrs2qvOzJygjeBnbL5tT7b6AZWYRxhgaUN
	EmQs9HqJMIOMDn/ut2UBGFXCxAT8EAJwDR4juNB2ZMkim/E8uzhqOTcU8Za4Oe/D4CSdNf42u+Y
	PSg4QTfEyAiAcjVX2ZtNfm0+EjerJercKOK4PNlUAR8fjzgRHa+DYcRH/+/Hehv5Yw/x5aD8jZZ
	NvJE3zlfGUZs7t0y2kO6AURxIK9Mg9psqPyX77dB1UhAtJ/IzXNaG3Bdris5DEuvWNmrunoNzWa
	x/u7a3aVGyoGOCA34I8yXYA==
X-Google-Smtp-Source: AGHT+IFiP6nXyFE7qfLHUsJAhYeWZSHp1CwIttpP4iE2kEDTy//u5ccfQX8sVcUhQe610fRL8SqZzw==
X-Received: by 2002:a5d:64ab:0:b0:391:952:c74a with SMTP id ffacd0b85a97d-391155ffd95mr5535609f8f.8.1741185777755;
        Wed, 05 Mar 2025 06:42:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d001:4ab2:d11a:658b? ([2a01:e0a:982:cbb0:d001:4ab2:d11a:658b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4795d30sm21510078f8f.10.2025.03.05.06.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:42:57 -0800 (PST)
Message-ID: <997d4cf8-5256-4413-8059-569451962a83@linaro.org>
Date: Wed, 5 Mar 2025 15:42:56 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
To: Abel Vesa <abel.vesa@linaro.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
 Kamal Wadhwa <quic_kamalw@quicinc.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
 <ylnkjxnukss7askv7ip5htrb4tyjzhpw7jim2se6rloleq5h6w@ngk7lbk26hxj>
 <Z8bGHV4PIkY4te6V@linaro.org>
 <5uk75v3cpy2hymdgjyvqdwyda34t2pn7jqyupyvhmqgo3wlxkl@uim4lth7lipa>
 <Z8hgj11p+TY1546x@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <Z8hgj11p+TY1546x@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/03/2025 15:32, Abel Vesa wrote:
> On 25-03-04 16:38:57, Uwe Kleine-König wrote:
>> On Tue, Mar 04, 2025 at 11:21:33AM +0200, Abel Vesa wrote:
>>> On 25-03-04 07:24:32, Uwe Kleine-König wrote:
>>>> Hello Abel,
>>>>
>>>> On Mon, Mar 03, 2025 at 06:14:36PM +0200, Abel Vesa wrote:
>>>>> Currently, the implementation computes the best matched period based
>>>>> on the requested one, by looping through all possible register
>>>>> configurations. The best matched period is below the requested period.
>>>>
>>>> The best matched period *isn't above* the requested one. An exact match
>>>> is fine.
>>>>
>>>
>>> Yep, that's better. Will re-word.
>>>
>>>>> This means the PWM consumer could request duty cycle values between
>>>>> the best matched period and the requested period, which with the current
>>>>> implementation for computing the PWM value, it will result in values out
>>>>> of range with respect to the selected resolution.
>>>>
>>>> I still don't understand what you mean with resolution here.
>>>
>>> Resolution in this context means the number of bits the PWM value
>>> (register value) is represented in. Currently, the driver supporst two PWM
>>> HW subtypes: normal and Hi-Res. Normal ones recently got support for changing
>>> the resolution between 6 bits or 9 bits. The high resolution ones support
>>> anything between 8 bits and 15 bits.
>>>
>>>>
>>>> I guess you spend some time understanding the workings of the driver and
>>>> you also have an example request that results in a hardware
>>>> configuration you don't like. Please share the latter to a) support your
>>>> case and b) make it easier for your reviewers to judge if your change is
>>>> indeed an improvement.
>>>
>>> Sure, will bring up the 5ms period scenario again.
>>>
>>> When the consumer requests a period of 5ms, the closest the HW can do in
>>> this case is actually 4.26ms. Since the PWM API will continue to ask for
>>> duty cycle values based on the 5ms period, for any duty cycle value
>>> between 4.26ms and 5ms, the resulting PWM value will be above 255, which
>>> has been selected as best resolution for the 4.26ms best matched period.
>>>
>>> For example, when 5ms duty cycle value is requested, it will result in a
>>> PWM value of 300, which overflows the 255 selected resolution.
>>
>> this is the bug you have to fix then. The PWM value (that defines the
>> duty cycle) has to be calculated based on .period = 4.26 ms and capped
>> at 255. So assuming that 0 yields a duty cycle of 0 ms and 255 yields
>> 4.26 ms, a request for .duty_cycle = 4; + .period = 5 should result in an
>> actual .duty_cycle = 239 / 255 * 4.26 ms = 3.992705882352941 ms;
>> + .period = 4.26 ms.
> 
> OK then. The patchset that fixes this according to your suggestion is
> already on the list (re-spun):
> 
> https://lore.kernel.org/all/20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org/
> 
>>
>>>>> So change the way the PWM value is determined as a ratio between the
>>>>> requested period and duty cycle, mapped on the resolution interval.
>>>>
>>>> Is the intention here that (for the picked period) a duty_cycle is
>>>> selected that approximates the requested relative duty_cycle (i.e.
>>>> .duty_cycle / .period)?
>>>
>>> Yes, that exactly what the intention is.
>>>
>>>> If it's that: Nack. This might be the right thing for your use case, but
>>>> it's wrong for others, it complicates the driver because you have spend
>>>> more effort in the calculation and (from my POV even worse) the driver's
>>>> behaviour deviates from the usual one for pwm drivers. I admit there are
>>>> some other lowlevel pwm drivers that are not aligned to the procedure I
>>>> described that should be used to determine the register settings for a
>>>> given request. But I target a common behaviour of all pwm drivers
>>>> because that is the only way the pwm API functions can make a promise to
>>>> its consumers about the resulting behaviour. Reaching this is difficult,
>>>> because some consumers might depend on the "broken" behaviour of a given
>>>> lowlevel driver (and also because analysing a driver to check and fix
>>>> its behaviour is an effort). But "fixing" a driver to deviate from the
>>>> declared right behaviour is wrong and includes all downsides that make
>>>> me hesitate to align the old drivers to the common policy.
>>>
>>> OK, fair enough. But I still don't get what you expect from the provider
>>> that can't give the exact requested period. Do you expect the consumer
>>> to request a period, then provider compute a best matched one, which in
>>> our case is pretty far, and then still give exact duty cycle values ?
>>>
>>> Like: request 5ms period, get 4.26ms instead, then request 4ms duty
>>> cycle and get exact 4ms duty cycle when measured, instead of a
>>> proportional value to the best matched period?
>>
>> Yes.
>>   
>>> If so, then what happens when consumer asks for 5ms duty cycle?
>>> Everything above the 4.26ms will just represent 100% duty cycle.
>>
>> Yes.
> 
> I still think this is wrong.

I also think this is very wrong, duty_cycle is a factor of the period,
so if the HW gives a lower period, the term Pulse Width Modulation implies
the ratio between the "duty_cycle" and the period is important,
not the exact duration of the components of the modulation.

So is this a defect of the PWM API ? why would the API insist on
having an exact duty_cycle and a random period ?

I mean if you look at the basis of PWM :
https://en.wikipedia.org/wiki/Pulse-width_modulation

The duty_cycle is expressed as a percentage of the period, because
this is the key feature of PWM here, can you explain more in detail
why we can't make an extra effort to keep the duty_cycle/period ratio ?

Neil

> 
> I do agree with the exact value. I advocated for it on the other
> thread.
> 
> But the fact that the API allows requests with values above what the
> provider can do is wrong.
> 
> In this specific case, we are talking about top 15% that it just
> thrown away. But it becomes even worse for others.
> 
>>
>>>> The policy to pick a hardware setting is a compromise between consumer
>>>> needs and what is straight forward to implement for (most) hardware
>>>> drivers. Please stick to that. If you want more flexibility and
>>>> precision in your consumer, please consider converting the pwm driver to
>>>> the waveform API.
>>>
>>> That means the pwm_bl driver will have to switch to waveform API, IIUC.
>>
>> Yes, if the pwm_bl driver cares about that precision it has to switch.
>>
>> While the waveform API isn't expressive enough, just use 4260000 as
>> period in the pwm_bl device, or ignore the missing precision.
>>
>>> That might break other providers for the pwm_bl consumer, wouldn't it?
>>
>> Given that the consumer side of the waveform API only works with drivers
>> that are converted: maybe. You could fall-back to the legacy API.
> 
> Based on the provider's best matched period? Hm.
> 
>>   
>>>>> [...]
>>>>> ---
>>>>> base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3
>>>>
>>>> My git repo doesn't know that commit. Given that you said your patch
>>>> bases on that other series, this isn't surprising. Please use a publicly
>>>> available commit as base parameter, otherwise you (and I) don't benefit
>>>> from the armada of build bots because they just silently fail to test in
>>>> this case.
>>>
>>> Well, this is a pretty common practice. When the patch relies on other
>>> patches that haven't been merged yet, but are still on the list, you
>>> can't really base it on a publicly available commit.
>>>
>>> And the fixes patchset that this is based on is needed for this to work.
>>>
>>> So I really don't get how this can be done differently.
>>
>> You can still use --base=$newestpubliccommit and git-format-patch will
>> at least give a chance to the build bots by emitting patch-ids for all
>> the commits between the public base and the start of your patch series.
> 
> Got it. I use b4 for most patches nowadays. I'll try to make use of it's
> --edit-deps and see where that lands.
> 
>>
>> Best regards
>> Uwe
> 
> Thanks,
> Abel
> 


