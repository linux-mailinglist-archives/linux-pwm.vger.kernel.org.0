Return-Path: <linux-pwm+bounces-2956-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D184E944DFA
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 16:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E32B20C90
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D971A3BB0;
	Thu,  1 Aug 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdGuIYK6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDEE16DECD;
	Thu,  1 Aug 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522489; cv=none; b=RWosu1o96349u2t0qadHCYJ0r/AJhsjgNZz6Np+ymXbQI2DAsXEbTNuQfkFNjYrhhypGG3EU5VxXrp1iwYTDjqs42o+zFljxzn3L0apgRoRQAAG9dKc3aB/JJxuxyVvWoZBTMmazRThn6AZWqMUlFgvEIo8d7fDA6qPXxgrSY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522489; c=relaxed/simple;
	bh=nXweTf1N/Qrtc92k2Hk2plyPYVbHK4S52KdhUzL4GTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0Gwtz/03syP/bQYcigbulPVVbR4FX8QGqGYjHKegRIL54noJ9GI+66LLK+/s596tcaFPbVsf2T14wP0sDLRvbT/ynPxZupGczNyvX/NFvMoXNdXXIfKKyEuqKBP9akguUOkz2BHgEpdorwjtH0gJ8SGRz9BYYhmSKSBMB1aGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdGuIYK6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so952304966b.2;
        Thu, 01 Aug 2024 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722522485; x=1723127285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8hkL8OO2ZxeFgam3kNnsXVfMD29C3IsiuBvZny7yAE8=;
        b=FdGuIYK6OuxWeiZo/NpbmdsoZKL2kxwLB3ed2/1VqBttR7RTCPWpZJ1hudD1f66ROs
         YG0xj9BEf6GVRP1v3wJdOvri+Y1imt78/mS7rwc/iypeJO+mPaylrYO4n9jZEjt8dTbU
         LlI3VkeQ8XO4xj64q7cBhsb5yfjq0u+FJLLwUP1R6zMuBqnOADD5MkZRki7cXLa+ryJB
         5IfdvGLeN+Z08AVtXIaflHkI/36Z7BlhQopOk436XmuVmdc+0DwfancDm0dnXt2AFU4a
         RP1p9PlP4TuPbMY5hSHR6buJ1En8rZ0oE2VCmWwlMCPIA5zXMKFB6sjdbzofmY7UZ6In
         XGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522485; x=1723127285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hkL8OO2ZxeFgam3kNnsXVfMD29C3IsiuBvZny7yAE8=;
        b=tG94QfbALyVb/Cr+UOcFKbK3X3C2vfhgziWXuaIgCqUvOMj9D9b9do5Pd3YLAU4i6z
         V50i91DwLm3IlHc2E6/78aTFYaj33tvjqnbGJOeIWc3GQRPDiQZpJ/ArE3tvnHacElJn
         qIy39bdkozeDcng8qmWypQJIx+H9EbwJOcoimT8QMtxn6foPpsgOv6JjbxH+Y9f4NOw6
         QGL5MfRWwwVIh3JrXsfGTEUCt/CO2F7joyodTCBnBbZJEPloxUza3IpiPLd+cqRFLyJ8
         GAndLePc1OUF6Hw/di7QZD4h84BnnPQlj1NNZY+Z1xSXbpzs4ucLYyvWL655OiP60jb0
         mzUA==
X-Forwarded-Encrypted: i=1; AJvYcCXsO00nv9C7g3ha2c8DbrsJq1G4XA0ID5/CRzE43wGw1ukYDbPk3oAMKoJzCGA6RKSAMhqaJZIz0NryXCJWMN2hLSB9Bg3uaYkcVp+xeXV4UNvLiozG3sEevlx0l9Vtzb6w1PltSuCsdtHh02PzekMmCCYFTQ8hsKeJQCsPG9ZrVSWt4g==
X-Gm-Message-State: AOJu0YwYCNQQuPm7LoiZe6Iib0+arpMPbiRqGjabQTlMC41B65+O+7KE
	WZfjMvPQO0pLI6NY+9DXciH9+mEdYZz028YLYIKDfTOK44REyiK4rt7QmQ==
X-Google-Smtp-Source: AGHT+IGFi4C4ODRsJyjv1TBoIj5UnVy1EOO44jMxcUUZsgY26wAnMlldo6NAF00nmgE5bCFQbiW3Bw==
X-Received: by 2002:a17:907:868a:b0:a7a:b781:60ee with SMTP id a640c23a62f3a-a7dc506e7c4mr23118366b.48.1722522485001;
        Thu, 01 Aug 2024 07:28:05 -0700 (PDT)
Received: from debian ([2a00:79c0:66e:2400:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4148fsm912381466b.121.2024.08.01.07.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:28:04 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:28:02 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20240801142802.GA212266@debian>
References: <20240515112034.298116-1-dima.fedrau@gmail.com>
 <20240515112034.298116-3-dima.fedrau@gmail.com>
 <aczpsiqyh4qsbvnqhqdnvkj2j3fihkltafop5ajkxm57sehbx5@mn4vp7avpeac>
 <20240731084648.GA18584@debian>
 <bokad5wa2vw5qwdrrqpkkyrxgmxco2ix76wdaxlqv6usi5rdck@46bp6ywqteo2>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bokad5wa2vw5qwdrrqpkkyrxgmxco2ix76wdaxlqv6usi5rdck@46bp6ywqteo2>

Am Thu, Aug 01, 2024 at 12:24:28AM +0200 schrieb Uwe Kleine-König:
Hi Uwe,

[...]

> > > > +static int mc33xs2410_pwm_get_relative_duty_cycle(u64 period, u64 duty_cycle)
> > > > +{
> > > > +	if (!period)
> > > > +		return 0;
> > > > +
> > > > +	duty_cycle *= 256;
> > > 
> > > This might overflow.
> > > 
> > 
> > How ? Max period and duty_cycle is checked by the caller and can be
> > maximum 2000000000, 2000000000 * 256 = 512000000000, fits in u64. Did I
> > miss anything ?
> 
> I didn't notice the check in the caller. Please add a respective comment
> for the next reader who might miss that.
> 
Ok.

> > > > +	duty_cycle = DIV_ROUND_CLOSEST_ULL(duty_cycle, period);
> > > 
> > > round-closest is most probably wrong. Please test your driver with
> > > PWM_DEBUG enabled and increasing and decreasing series of duty_cycle and
> > > period.
> > 
> > Yes, I should probably round it down. But I tested with PWM_DEBUG enabled
> > and it gave me the best results so far. There are still few cases where
> > there are complaints. I try to fix it.
> 
> I don't have the hardware so I cannot test myself. Please make sure that
> there are no more complaints, at least none you are aware of. PWM_DEBUG
> should be happy if you pick a hardware setting where period is maximal
> but not bigger than requested and then for that given period duty_cycle
> is maximal but not bigger than requested. So typically use round-down
> division in .apply(). In .get_state() you should return a pwm_state that
> makes .apply() write the exact same state as found when .get_state() was
> called. So typically you have to use round-up there.
>

Thanks, this fixed the remaining complaints. Did it exactly as you
suggested.

> > > > +	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
> > > > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > > > +
> > > > +	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > [...]
> > > > +static int mc33xs2410_probe(struct spi_device *spi)
> > > > +{
> > > > [...]
> > > > +	/* Disable watchdog */
> > > > +	ret = mc33xs2410_write_reg(spi, MC33XS2410_WDT, 0x0);
> > > > +	if (ret < 0)
> > > > +		return dev_err_probe(dev, ret, "Failed to disable watchdog\n");
> > > 
> > > Wouldn't the watchdog functionality better be handled by a dedicated
> > > watchdog driver? Disabling it here unconditionally looks wrong.
> > 
> > Yes, would be better. I planned this after this patchset is accepted.
> > Without disabling the watchdog, the device is not able to operate. So I
> > would stick to it for now and come up with a patch later on.
> 
> How long is the default timeout? Don't you need to disable the watchdog
> in the bootloader anyhow?
> 

Default and also maximum timeout is 256ms. My hardware is configured to
let the device stay in reset until the driver puts it out of reset by
setting the associated GPIO. Datasheet refers to it as "Disable mode".
Outputs are turned off.
Without having such reset logic, the device would need to have the
watchdog disabled in the bootloader and continue in "Normal mode" or it
would go into "Safe mode" while booting the kernel almost sure violating
the timeout. Outputs are then controlled by the INx input logic signals.
I think there is no single solution but rather depends on the use case.
There are three modes which the device can be in when the driver is probed:
"Disable", "Safe" and "Normal". All three are handled by this driver,
assuming the watchdog should be disabled.

> If you still think the watchdog should be disabled here, please add a
> comment that it's conceptually wrong to do here, but needed until there
> is a proper watchdog driver.
> 

I will leave a comment, but I'm not sure if I can come up with a good
solution since the maximum timeout is very low with 256ms. For interaction
with userspace it must be at least 1s.
Why is the handling of the watchdog conceptually wrong here, I could use
devm_watchdog_register_device to register it, why can't I just disable it
here ?

> Should this better be a mfd driver then?
> 

I don't thinks so, the watchdog and the outputs belong somehow together.
When the device runs into an timeout it switches into "Safe" mode and the
outputs are controlled by the INx input logic signals.
I thought of a mfd device as a device which provides multiple functions
not really belonging together. Didn't find a clear definition. What do you
think of it ?

Best regards
Dimitri

