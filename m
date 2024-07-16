Return-Path: <linux-pwm+bounces-2827-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B5B9328FA
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 16:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771CB1C22F03
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 14:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C76A1A98E8;
	Tue, 16 Jul 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eX2bXI+o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650D1A08CB
	for <linux-pwm@vger.kernel.org>; Tue, 16 Jul 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140118; cv=none; b=oNqz22tVfwu4owWGWSzTfZXhh18j8XKmwUfMWpfusIOGQ7snRp/rSZ/Bj847+pBB3gOJhp5BC88yEZAWqNBw8kZnKddFCaXAQbFsZ242A4ZeieUWAdudHofV+X4yfNx2/gmdUcH7RccnaFI1Y1pT5nOGbcp5uCUldE76sg3lq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140118; c=relaxed/simple;
	bh=+SqsDGbmCRKMaJBpHdLFBLmpBYssobPbBFkFeCWg+B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQXH6gvFQOhcv6axoGK586VM/faJjDdaZAJE15kaF5YvhoS4zB8Tpe63pajgzteiF/KO+8iU96QRLucF3lJlwpAzzziE4zk8QHJpmjlOthnVUh6Y9WNtW6IAluj7DO6r3qaGH21Ol54as5F66YgP0m2IH3QQ9cl3ys4ShVQai58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eX2bXI+o; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c6924f2383so2700372eaf.2
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jul 2024 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721140114; x=1721744914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yl0R0GrWfxUHkOIos4obcPgixfGNOqUJyJIVXXpvRs=;
        b=eX2bXI+o7d77VKH57KSoqNsOODryyt27ScIKA228KKJUdAfVKlmYNN7xArqZt5nR8z
         nu9HAQxxcz3JFDlcgnozZvdqAJVhfTboSlIvLTxt0Mlh2Al1ujabvFk2p/PVeqrek2qq
         Vn0EGn0H7eDd8Ix/UxM26bip24TfabBO/18jgcWsQXszmLQXkg1dYV6U1NWEgM6q1T0E
         sr6RiZFtotmgAlN08vn64H2AiVAZhArp+AEnIKJL4mFQuK9UYxxBbpYhBNSt3OakJ0e6
         bmnebeUg2m5I3yUxaucPtVKO5d1JNjJAsc8UcwaQrM+yh6sBZ839v+qWgXduNU53KqrS
         4BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721140114; x=1721744914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yl0R0GrWfxUHkOIos4obcPgixfGNOqUJyJIVXXpvRs=;
        b=k5PcdsWuFy3doS3Cc3DBuJJpVyxqsd+hVn/gtvLZRPEQyw1pdMw1oML7OKrfOA6XYu
         Y3okT5tEPSNOQQjCkyuUUDYkb/ydswLHs24p8vmPHXNgawwmMs7xjSBvl0UkKghvl79f
         sdiRZTyGYLNofj2VdwgrV+2NJP5Q14y/H1YzqsF0xsB502sP+b+SZRkykg5OfGctTOkY
         4U7+K9Xqcd5E6umL1nu0jRnb9mBQs8F6uYynzXcqVzHXJXB+BgTDiHA7henRkVkX/juU
         FGTO0nY/IpHKpwj6wZECeVm9MmijB8EVqQU0DEj4/TXaYKE/AgTf3nrBT1MFal9BpSWU
         2F4g==
X-Gm-Message-State: AOJu0Yy6g7MSnVyrXXgcvgQu/gB8Vtk6XRbxaRwAuq+VPIu8av5LmZAy
	1SyEXpQUIowKX7aVxq35UwBMyu7SWqRlEYsh8+vs0bL3jJeuGD7yGHkOwuHgX5k=
X-Google-Smtp-Source: AGHT+IHbxQd+i7MGH0hgaf6ZleBKXHuj2xaZiX9uCAz57dkgNOiyIMsxTNt9nQWPfTe5r/4Oil3HLg==
X-Received: by 2002:a4a:ee8b:0:b0:5b9:e7db:1cf8 with SMTP id 006d021491bc7-5d288b520e1mr2787312eaf.4.1721140113864;
        Tue, 16 Jul 2024 07:28:33 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce753d1bdbsm1209711eaf.16.2024.07.16.07.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 07:28:33 -0700 (PDT)
Message-ID: <23a181c4-80b1-4545-ad48-54e89e4bf690@baylibre.com>
Date: Tue, 16 Jul 2024 09:28:32 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] pwm: Provide new consumer API functions for
 waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <8db2c6f239b9e101f85d556d9e203935c2da2570.1721040875.git.u.kleine-koenig@baylibre.com>
 <ff628d7e-bd87-48e7-b80c-aff2d4e61f2c@baylibre.com>
 <cwgrbvzc73hnsmkfigq2t5t43y73oyz54tugad6ayxwzrlawlw@qd3bylzfqvns>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cwgrbvzc73hnsmkfigq2t5t43y73oyz54tugad6ayxwzrlawlw@qd3bylzfqvns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/16/24 2:06 AM, Uwe Kleine-König wrote:
> Hello David,
> 
> On Mon, Jul 15, 2024 at 05:23:45PM -0500, David Lechner wrote:
>> On 7/15/24 6:16 AM, Uwe Kleine-König wrote:
>>> Provide API functions for consumers to work with waveforms.
>>>
>>> Note that one relevant difference between pwm_get_state() and
>>> pwm_get_waveform*() is that the latter yields the actually configured
>>> hardware state, while the former yields the last state passed to
>>> pwm_apply*() and so doesn't account for hardware specific rounding.
>>>
>>
>> ...
>>
>>> +
>>> +/* PWM consumer APIs */
>>> +int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
>>> +int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
>>> +int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struct pwm_waveform *wf, bool exact);
>>>  int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
>>>  int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
>>>  int pwm_adjust_config(struct pwm_device *pwm);
>>
>>
>> It seems like there could be a potential race condition between rounding
>> and setting a PWM.
>>
>> Consider two PWM devices that share the same clock and the driver can
>> set the clock rate to accommodate a wider range of periods or get a
>> more accurate duty length.
>>
>> Thread 1				Thread 2
>> --------				--------
>> PWM consumer A calls round_waveform()
>> a few times, e.g. to round up or round
>> closest. Clock is not exclusive so
>> rounding assumes the rate can be
>> changed to get the best rate.
>> 					PWM consumer B call set_waveform().
>> 					clk_set_rate_exclusive() is called
>> 					on the clock so the rate can no
>> 					longer be changed and the rate is
>> 					not the one PWM consumer A selected
>> 					in the rounding operation.
>> PWM consumer A calls set_waveform().
>> This will either fail or will
>> not get the same results that
>> was returned by round_waveform().
> 
> The "exact" parameter has the purpose to make this fail. While
> implementing the idea I wondered if I should drop the parameter and
> make .set_waveform() imply exact=true.

Would consumers then be expected to implement a retry loop to
handle the error when an exact=true call failed because the same
rounding was no longer possible?

> 
> Two more thoughts about this: First, I think the most usual use cases
> are rounding up or maybe rounding closest (instead of rounding down as
> done by default). It's easy to implement a helper function in the pwm
> core that holds the chip lock and does the necessary function calls to
> determine the rounded setting needed.

Would these same functions also get ioctls for the cdev interface?

> 
> The second thought is: Even when holding the chip lock, another clk
> consumer can theoretically change the flexibility of a participating clk
> while the right settings are determined for a given pwm consumer. Also
> if I use clk_round_rate() to determine the resulting rate of a parent
> clock, it's not sure that I can set this rate because again the
> situation might have changed since I called clk_round_rate() or because
> another consumer refuses my request to change the rate.
> 
> So as soon as you consider changing an upstream clock to reach a certain
> PWM setting, this all degrades to a racy best effort quest.
> 
>> If it wasn't for the userspace cdev interface, I would suggest
>> to drop pwm_round_waveform_might_sleep() and pass an optional
>> function pointer to pwm_set_waveform_might_sleep() instead of
>> the `bool exact` argument so that the full operation of rounding
>> and setting could be performed with the pwmchip lock held without
>> consumer drivers having to worry about getting it right. Consumer
>> drivers would then just have to implement functions to suit their
>> needs, or there could even be standard ones like round_closest().
>>
>> But that still might not fix it in all cases e.g. if two pwmchips
>> share the same clock as opposed to one pwmchip with two outputs.
>> If this is possible, then then "pwm: Add more locking" patch
>> might already cause some problems with race conditions in the
>> existing PWM apply() ops. Although, I suppose this kind of
>> clock coordination between pwm chips (and potentially other
>> devices) should be handled outside of the PWM subsystem.
> 
> I would expect that the "Add more locking" patch doesn't enable more
> races than are possible without it? I don't understand the problems you
> think of here.
> 

When we consider other non-PWM clock consumers you are right, it
is not any different that before. I think you understood me fully.
I agree that there aren't any serious issues here any more than
the current state of things.


