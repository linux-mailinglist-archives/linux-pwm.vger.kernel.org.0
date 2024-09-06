Return-Path: <linux-pwm+bounces-3144-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5DE96FD41
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 23:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615FAB21B19
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 21:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58F112EBDB;
	Fri,  6 Sep 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3HJE+3H/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9B47F46
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657768; cv=none; b=VkNM0GkfluP9jolilQSPGjm5nf//h+bIfJ90x3xyxbfE1F2SMTpNZ5mrPbM+4zHz7A8bvGgkjbK381EiRC/JW7jCJGD3rb1bSWL2JonXGs5jV563rlnW4QMwHuhsXC+IZeiSihK6BGlt2XlI/w4ITaV6Dp5olkp2LsOCOVRqDDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657768; c=relaxed/simple;
	bh=Bci53St+24vzYAiZCjUjWD3xJZuKHYem9JX/d6sXNO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNkDZ9TmteLlnYqo6Mt7mwpwO8xb8KEuVj4YneQscImegQc3lrYxQ6PX98hWbhp4jooruRe/KruSXYRDH2P5DnZQ/c4MY8liNJSIiecbSbSMmWt6oNllbqoZI5zKLha0pTtfiSDYCaQGRaaUpsVcbSKx4AtGUw9m/eZr9MDRTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3HJE+3H/; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70f645a30dcso1835505a34.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725657764; x=1726262564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXm5oT7BLRzSMlryshMKZH8vG6Xkz5gMTWH9Kz5tyRU=;
        b=3HJE+3H/TIRfqt61+qxkjs3MxeY7Q2SkGnmAxcyycdMp3xNYX6rzKQvEGFSbrXIk/P
         /k6s07s7Pzc1y+x7nGToWmuEmYW71bLbYMYyietS1cnkAs81u4PDb0Fo1dKokILbXlTa
         g4Gtte1M7dj+vuqO3URQhLZmZgpOTS0cauTrSQGoaiexgvxznxJbAyxfIMp1Q+OJlPph
         CXGxvtPuX7blhG4V4keEA499I5/cEW1ogwEVNErTe+zAZ/OOo1MG/pMQAwbBgCGsrQ3u
         oC4j6ff+58jRoUe6FMBt9l9kurGmy2oyJTqaKAQl4HCKJT/ZBungAbKBPzwjzk01jefJ
         Q3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725657764; x=1726262564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXm5oT7BLRzSMlryshMKZH8vG6Xkz5gMTWH9Kz5tyRU=;
        b=h4aQgPnieyRjoBKjgjYtcMkVhZL8DEU0zKxW98KzzisL7iL3dibdu/bW7BZim0M8T/
         IRecI0toxwivrbYancyCzfMOHSncCS4TFT0LgkRHCX06AzB+yMQz6S6GoQ6foR7tc7v4
         6gwWffFvuS/SbFdVPARTDJrLkmH0PR+hhl1l/D0g5Qk2QoHCWy4fF7hRJo5yN5IEOMl3
         znbFsvW8BZ9ohtfv51CddEX1iP/WhnrN0cgozE/MMJVBXGxBF/7J9Jvux6A1HMtXiwh4
         SFYr16YBuE/VGvYGxNvipWoubRsO9AYMgNuqYkxLZv/Mxrm83KMEqJMURd5c0gGnRqkp
         KAvw==
X-Forwarded-Encrypted: i=1; AJvYcCWcwkZj3/dCHJkYYiP2vBq0ZajzZkVzQjJAtgN+hgAJnijrvCYGR8gFXRwL5qWciY2D1Yuma8p7Oc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVwr/l/125IhH0fX8RwE8Wze1Oh2rgnqQavGxeRv8qWA0jwZ8
	/dJXrdMydnLz/UDKt5Hk46SD/jp7fpmLj9PAUE2HWDhKITihOmVV05l1Ajl5Ll+QzcNx6/oWw+D
	r
X-Google-Smtp-Source: AGHT+IFWxQQ10SgyNnJQtVlhZYVuVnNId9VVEEAuAsbTuiFYYpcrUv/T2B0rH7m0A0OlKzPrSnA5jQ==
X-Received: by 2002:a05:6808:11cb:b0:3df:54d:7b62 with SMTP id 5614622812f47-3e02a045e87mr4514871b6e.42.1725657763889;
        Fri, 06 Sep 2024 14:22:43 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df11866831sm3982673b6e.37.2024.09.06.14.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 14:22:43 -0700 (PDT)
Message-ID: <e1dfca79-a267-4c91-b504-b3f222dacc24@baylibre.com>
Date: Fri, 6 Sep 2024 16:22:42 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] pwm: Provide new consumer API functions for
 waveforms
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <857ae911c23a474e6de4a1ba0b224bc8d982d624.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <857ae911c23a474e6de4a1ba0b224bc8d982d624.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 10:42 AM, Uwe Kleine-König wrote:
> Provide API functions for consumers to work with waveforms.
> 
> Note that one relevant difference between pwm_get_state() and
> pwm_get_waveform*() is that the latter yields the actually configured
> hardware state, while the former yields the last state passed to
> pwm_apply*() and so doesn't account for hardware specific rounding.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

One thing I am wondering about is how to implement rounding up instead
of down. For example, I we need a >= 10 ns duty cycle.

Here is my attempt...

#define MIN_DUTY_NS 10

int some_func(struct pwm_device *pwm)
{
	struct pwm_waveform wf = {
		.period_length_ns = 400,
	};
	u64 trial_ns = MIN_DUTY_NS;
	int ret;

	do {
		wf.duty_length_ns = trial_ns;

		ret = pwm_round_waveform_might_sleep(pwm, &wf);
		if (ret < 0)
			return ret;

		/*
		 * ret == 1 could be either because duty or period
		 * is not attainable. In any case, we have to wait
		 * until the last trial to rule out earlier trials
		 * failing because of too small duty since we try
		 * again with larger duty. Maybe this check isn't
		 * needed though since pwm_round_waveform_might_sleep()
		 * should fail when trial_ns > wf.period_length_ns?
		 */
		if (ret == 1 && trial_ns == wf.period_length_ns)
			return -ERANGE;

		trial_ns++;
	} while (wf.duty_length_ns < MIN_DUTY_NS);

	return pwm_set_waveform_might_sleep(pwm, &wf, true);
}


1. This seems like it would waste time trying each 1 ns increment
   compared to being able to tell the low level driver which way
   we want to round.
2. Even with this, we could end up with an actual period of 9.5 ns
   which is < 10 ns but have to way to know since the returned value
   will be 10. Probably not likely that 0.5 ns is going to cause
   something to malfunction, but you never know.
3. Handling ret == 1 seems kind of messy since it could be caused
   by multiple different problems.

Maybe we could consider including a rounding direction (up/down/closest)
for each of the waveform parameters and pass that along to low level
driver to avoid much of this? Or at least have these parameters for
the high-level pwm_round_waveform_might_sleep() so each consumer doesn't
have to try to figure out how to do the rounding right?

> @@ -145,6 +192,220 @@ static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, c
>  
>  #define WFHWSIZE 20
>  
> +/**
> + * pwm_round_waveform_might_sleep - Query hardware capabilities
> + * Cannot be used in atomic context.
> + * @pwm: PWM device
> + * @wf: waveform to round and output parameter

It would be helpful to spell out in the description below that @wf will
be modified upon non-error return and what the modified values will
actually be. (Or refer to the other functions where the values are already
documented to avoid duplication.)

> + *
> + * Typically a given waveform cannot be implemented exactly by hardware, e.g.
> + * because hardware only supports coarse period resolution or no duty_offset.
> + * This function returns the actually implemented waveform if you pass wf to
> + * pwm_set_waveform_might_sleep now.
> + *
> + * Note however that the world doesn't stop turning when you call it, so when
> + * doing
> + *
> + * 	pwm_round_waveform_might_sleep(mypwm, &wf);
> + * 	pwm_set_waveform_might_sleep(mypwm, &wf, true);
> + *
> + * the latter might fail, e.g. because an input clock changed its rate between
> + * these two calls and the waveform determined by
> + * pwm_round_waveform_might_sleep() cannot be implemented any more.
> + *
> + * Returns 0 on success, 1 if there is no valid hardware configuration matching
> + * the input waveform under the PWM rounding rules or a negative errno.
> + */
> +int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf)
> +{

