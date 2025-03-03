Return-Path: <linux-pwm+bounces-5053-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E7A4C69D
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 17:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E9C189AE8F
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEC223A563;
	Mon,  3 Mar 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="ULec7LBt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A5B239560
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018194; cv=none; b=QoPJ2EzqLX4NGtiIq1oybGIc7GvNTksCQu41siye3LKFCxYk4mtjGyk1grAwAiYGLdDEWq0iQu+BraCHgzKITtxFMlpI3DOsV/tepkeHkD8P6C6kHpDMhIJgiLE4Z060fO+uTs/waXdAto76NleI3I9/qZCX7qshRWtC3qwkc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018194; c=relaxed/simple;
	bh=TxY4xRAgsFg8SCvRdIn7kFXkzwJn1C/ATI2TnrYjEho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSF6s7UWVpQ7HWtnmNcixovUn0PDAKLT2zC+ecBooUn7ScaMZb+px9uIm5jcM1gUxJQef2AMPjXT/gZBCaqQnQPPKYcwXCqdeknUD87Vz5DeYVdlzHSTZzX5LtowdANr0FjMQoP6A/ML99tg+WqvE/zyQSI6tor3sXcodWS3CS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=ULec7LBt; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=9N+PZWKrNc7CNPllkkZ9CiFN5GeZj3OH4/6pJkaEiPk=;
	b=ULec7LBt+1ywkVp7LEAdBPySKNVIU5SorGo7jPzNu8Kz+YF4nGq417bjgrB8/sunMaSy+N0K4tvWL
	 jX961cyJVHT0RITHWbsv55CrwA0H32fh2v+6tsFa8btGA29aU0yVJqj1wGYMnRiPSeaMqvvxoACmpj
	 UARRpac09Dg0KH4w6zZEpGNsGy9ZCeKpPFClutUhhtjFNHJrZBkJ0bYuM2snAE8nZQIFOgHgi7ewq+
	 NpOcBRh8cp1uYaFq13c4YoEpgE/ZB0HzCCAlUkpwgW2YP9uosDI4RQc39zk7ZRAoX/dqzrAavk0lRp
	 J4F0zBbnAyyceIdOQf46DMxv8sNYE2g==
X-MSG-ID: ef999062-f849-11ef-8b46-005056817704
Date: Mon, 3 Mar 2025 17:09:50 +0100
From: David Jander <david@protonic.nl>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
Message-ID: <20250303170950.426c2f13@erd003.prtnl>
In-Reply-To: <c9dc351b-0b81-44c6-a89d-4644f600a41c@kernel.org>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-8-david@protonic.nl>
	<20250228-wonderful-python-of-resistance-d5b662@krzk-bin>
	<20250228102201.590b4be6@erd003.prtnl>
	<9a1d75a2-66c0-46b6-91a1-4922b892dfb1@kernel.org>
	<20250228110931.7bdae7fd@erd003.prtnl>
	<tm57fsmijq4t4y4dpmtss63ekzpm5oefir5tz4aioxq5dx4or6@lgoqjpxc3axh>
	<20250303124034.726ba698@erd003.prtnl>
	<c9dc351b-0b81-44c6-a89d-4644f600a41c@kernel.org>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 15:18:40 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 03/03/2025 12:40, David Jander wrote:
> >>
> >> Some hardwares cannot support PWM_POLARITY_INVERTED. Affected drivers
> >> include:
> >>
> >> 	pwm-adp5585
> >> 	pwm-ntxec
> >> 	pwm-raspberrypi-poe
> >> 	pwm-rz-mtu3 (software limitation only)
> >> 	pwm-sunplus
> >> 	pwm-twl-led (not completely sure, that one is strange)
> >>
> >> . ISTR that there is a driver that does only support inverted polarity,
> >> but I don't find it. For an overview I recommend reading through the
> >> output of:
> >>
> >> 	for f in drivers/pwm/pwm-*; do
> >> 		echo $f;
> >> 		sed -rn '/Limitations:/,/\*\/?$/p' $f;
> >> 		echo;
> >> 	done | less
> >>
> >> . (Note not all drivers have commentary in the right format to unveil
> >> their limitations.)
> >>
> >> For most use-cases you can just do
> >>
> >> 	.duty_cycle = .period - .duty_cycle  
> > 
> > Yes, that is exactly what the relevant code in motion/simple-pwm.c does when
> > the "pwm-inverted" flag is present in the DT node.
> >   
> >> instead of inverting polarity, but there is no abstraction in the PWM
> >> bindings for that and also no helpers in the PWM framework. The problem
> >> is more or less ignored, so if you have a device with
> >>
> >> 	pwms = <&pwm0 0 PWM_POLARITY_INVERTED>;
> >>
> >> and the PWM chip in question doesn't support that, the pwm API functions
> >> will fail. So the system designer better makes sure that the PWM
> >> hardware can cope with the needed polarity.  
> > 
> > Thanks for clarifying this!
> > 
> > @Krzysztof, do you think that given this situation it is acceptable to include
> > the "pwm-inverted" flag in the dt-schema of the simple PWM motor driver?  
> 
> No, because that flag is already supported via PWM_POLARITY_INVERTED.
> 
> Do not tie bindings to specific implementation. If PWM core is changed
> to always handle PWM_POLARITY_INVERTED even if controller does not
> support it, would the binding became outdated?

Understood. I guess I will have to start fixing PWM drivers then... @uwe, do
you have objections to trying to add a (very trivial) helper for PWM
controllers that can't do inversion in hardware and start to patch some of
them if needed?

> > The need for an inverted PWM signal is something very common in the case of
> > H-bridge motor drivers, where the PWM signal represents the actual logical
> > output level of each of the two halves of the bridge. Often the high-side
> > switches are used as the free-wheel position, so that 100% duty-cycle on both
> > channels is actually standstill, while 0% duty-cycle on one channel is full
> > speed in either direction. This isn't always the case though, hence the
> > importance for this to be able to be selected.  
> 
> Sure and use existing bindings for that. If implementation has problems,
> fix implementation.

Sounds reasonable.

Best regards,

-- 
David Jander

