Return-Path: <linux-pwm+bounces-5052-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAABA4C33C
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 15:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8110A173C4E
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD7212FB8;
	Mon,  3 Mar 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuEyftF6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57D13BAF1;
	Mon,  3 Mar 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011528; cv=none; b=gzE0vgoaH0oF/NOeUs88XzGQFq1UNLk6BrGIgNQkvM9X28qs8qivFcun9jsfFIXFy/COLgpHW+KJxXr/NVVgZ1P0vr93FfXOajmuT3SjSEgS+lYVHlbNo81kJHCrZp/gBErgg6i83jkIudSKIRkLg/hYQJKFYWqtxuGFuXXHKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011528; c=relaxed/simple;
	bh=lqjp7LIjDhQxWqewy5mV5ckok6buZoX+dvARhvXCRko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obnB6j1bvY6MEIvdpRKKo5EPnz2LYIkl5EPy6EVSLncLTLmrYcjkPZdwzqlcd6VGQIkksz6jn/rpA4fetO1RkToGZ03s7E1Mljo6sdPtKsA+42pOgKHA3Jg58wzWeNtYbaIQ2Du7sHCsTarbQ72885YhltqqvLeYCp5+EYqIbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuEyftF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCA2C4CED6;
	Mon,  3 Mar 2025 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011528;
	bh=lqjp7LIjDhQxWqewy5mV5ckok6buZoX+dvARhvXCRko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PuEyftF6/98P2YSoT/4dx5CwnIWkCdDWHwsSHGPpVCQdI7A/Qz4YSX+WX/Kc/luQU
	 rCpXhhOGWAizvCQE+iTUEyI/y1ZTX00Oyj2kGjCxNawQwjg2Cr5Eq+BMG9JV29dwsn
	 N4EvxuaxfaVRYdC5lQUFhX4TAs/cVp1tXbWpRrkSw+SJUb9IftzGhb4jgtP/XKoX4Y
	 acPXTU8ONuYyS6hUZBbqxcXtj26VxkXj+rUttuRoPG5mzo4JWh8/hhEhUzQaDAq9oM
	 i46OI85zxt/voI71Jw6MiSdGgiFvM0Ad4BhfJVkQNf0hPimHMme+Q3kbvisBOLMsz/
	 2L8vFxvrgC9Tw==
Message-ID: <c9dc351b-0b81-44c6-a89d-4644f600a41c@kernel.org>
Date: Mon, 3 Mar 2025 15:18:40 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
To: David Jander <david@protonic.nl>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, linux-pwm@vger.kernel.org
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-8-david@protonic.nl>
 <20250228-wonderful-python-of-resistance-d5b662@krzk-bin>
 <20250228102201.590b4be6@erd003.prtnl>
 <9a1d75a2-66c0-46b6-91a1-4922b892dfb1@kernel.org>
 <20250228110931.7bdae7fd@erd003.prtnl>
 <tm57fsmijq4t4y4dpmtss63ekzpm5oefir5tz4aioxq5dx4or6@lgoqjpxc3axh>
 <20250303124034.726ba698@erd003.prtnl>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20250303124034.726ba698@erd003.prtnl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2025 12:40, David Jander wrote:
>>
>> Some hardwares cannot support PWM_POLARITY_INVERTED. Affected drivers
>> include:
>>
>> 	pwm-adp5585
>> 	pwm-ntxec
>> 	pwm-raspberrypi-poe
>> 	pwm-rz-mtu3 (software limitation only)
>> 	pwm-sunplus
>> 	pwm-twl-led (not completely sure, that one is strange)
>>
>> . ISTR that there is a driver that does only support inverted polarity,
>> but I don't find it. For an overview I recommend reading through the
>> output of:
>>
>> 	for f in drivers/pwm/pwm-*; do
>> 		echo $f;
>> 		sed -rn '/Limitations:/,/\*\/?$/p' $f;
>> 		echo;
>> 	done | less
>>
>> . (Note not all drivers have commentary in the right format to unveil
>> their limitations.)
>>
>> For most use-cases you can just do
>>
>> 	.duty_cycle = .period - .duty_cycle
> 
> Yes, that is exactly what the relevant code in motion/simple-pwm.c does when
> the "pwm-inverted" flag is present in the DT node.
> 
>> instead of inverting polarity, but there is no abstraction in the PWM
>> bindings for that and also no helpers in the PWM framework. The problem
>> is more or less ignored, so if you have a device with
>>
>> 	pwms = <&pwm0 0 PWM_POLARITY_INVERTED>;
>>
>> and the PWM chip in question doesn't support that, the pwm API functions
>> will fail. So the system designer better makes sure that the PWM
>> hardware can cope with the needed polarity.
> 
> Thanks for clarifying this!
> 
> @Krzysztof, do you think that given this situation it is acceptable to include
> the "pwm-inverted" flag in the dt-schema of the simple PWM motor driver?

No, because that flag is already supported via PWM_POLARITY_INVERTED.

Do not tie bindings to specific implementation. If PWM core is changed
to always handle PWM_POLARITY_INVERTED even if controller does not
support it, would the binding became outdated?

> 
> The need for an inverted PWM signal is something very common in the case of
> H-bridge motor drivers, where the PWM signal represents the actual logical
> output level of each of the two halves of the bridge. Often the high-side
> switches are used as the free-wheel position, so that 100% duty-cycle on both
> channels is actually standstill, while 0% duty-cycle on one channel is full
> speed in either direction. This isn't always the case though, hence the
> importance for this to be able to be selected.

Sure and use existing bindings for that. If implementation has problems,
fix implementation.

Best regards,
Krzysztof

