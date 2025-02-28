Return-Path: <linux-pwm+bounces-5020-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93393A496B5
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 11:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75FA3AEDE2
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2025 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72632268FCD;
	Fri, 28 Feb 2025 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="YeCNdxiR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4021325D523
	for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2025 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737376; cv=none; b=J6vFq7460zpwnH1LVrQL6v89WV0ap30ajbHxbNrlvy3EWSr3OQ/4odhSZfrZ1EvfEd0L9tPBgseNjTnDib8fD7z5wzfh45t4Hqb3/zoxmA7seU6QVMLCVpMHOb8l+AUr7Qu9kQFMxKFPF8fjrqgew5XEt8/Js9bU70b5XwN1MI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737376; c=relaxed/simple;
	bh=2Vh6s5d9G9Yevb9V+NyS1g0ALh2v4cCTWYZX6WaWto4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+fosxqurHToAcci+47fmgLqTiUP8SfPMdgtCQ8f4Qz/WOKkzi/PG7o//TxxRGy7iMlMWrxlMWqQAQFtxj8F0/viGtNp0psB5D0s+GCa63tgHrVyOiLqynohWqyFTpg489wEjpmjt8V+bZ9vWySdDCGY0rhlHm7rKerMPI/BJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=YeCNdxiR; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=2UCCLlAhi2XVYL+PR3aixzJ9O8fv6heHVP14A0uBTPA=;
	b=YeCNdxiRy5kf91+7ZAevXRHsmE0G1s7W/8WQIXQ0tXmv9gQPDM0KdqXt708s323lS7IHoyvGmlPFN
	 btMeXt/xpgy/enPD1Zc/hj9XGH7tzMeQqPeGQpvn7YcUEG8EaS5p1ST0GGnyHUCR+WLHncO0Q3ksuP
	 C5GVJ5etu082SCbKmYVBdIDH0FrQU2GFwT09o5wsu3cX1ynGbGJ42i8bEV4opHZdn0hZmqU10JWRZd
	 U0l1TchgqICKjuvNaZekVtWN7Jx1iyA6tL4KGVdN1FHSIJ47a+PNaQro5d2XKzDtAhkcQErCmRf0H6
	 9FrjyNyzGqk1XvOrgFpP/ynUvR3o6Rg==
X-MSG-ID: 1a633c63-f5bc-11ef-a39b-00505681446f
Date: Fri, 28 Feb 2025 11:09:31 +0100
From: David Jander <david@protonic.nl>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, linux-pwm@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] dt-bindings: motion: Add motion-simple-pwm
 bindings
Message-ID: <20250228110931.7bdae7fd@erd003.prtnl>
In-Reply-To: <9a1d75a2-66c0-46b6-91a1-4922b892dfb1@kernel.org>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-8-david@protonic.nl>
	<20250228-wonderful-python-of-resistance-d5b662@krzk-bin>
	<20250228102201.590b4be6@erd003.prtnl>
	<9a1d75a2-66c0-46b6-91a1-4922b892dfb1@kernel.org>
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

On Fri, 28 Feb 2025 10:37:48 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 28/02/2025 10:22, David Jander wrote:
> >   
> >>> +
> >>> +  motion,pwm-inverted:
> >>> +    $ref: /schemas/types.yaml#/definitions/flag    
> >>
> >> And PWM flag does not work?  
> > 
> > I have seen PWM controllers that don't seem to support the
> > PWM_POLARITY_INVERTED flag and those where it just doesn't work. Should all  
> 
> 
> Shouldn't the controllers be fixed? Or let's rephrase the question: why
> only this PWM consumer needs this property and none of others need it?

CCing Uwe Kleine-Koenig and linux-pwm mailing list.

I know that at least in kernel 6.11 the pwm-stm32.c PWM driver doesn't
properly invert the PWM signal when specifying PWM_POLARITY_INVERTED. I agree
this is a probably bug that needs fixing if still present in 6.14-rc. Besides
that, if linux-pwm agrees that every single PWM driver _must_ properly support
this flag, I will drop this consumer flag an start fixing broken PWM drivers
that I encounter. I agree that it makes more sense this way, but I wanted to
be sure.

Best regards,

-- 
David Jander

