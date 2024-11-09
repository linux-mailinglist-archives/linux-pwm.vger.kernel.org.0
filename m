Return-Path: <linux-pwm+bounces-4050-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 166699C2E49
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8A6B20DB7
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Nov 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A97A19C562;
	Sat,  9 Nov 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOdrh8UI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1C19B3D8;
	Sat,  9 Nov 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731166795; cv=none; b=LPuj+w3iIcKmPEiGZGLrUscwoHhQEFqyjT6RSEfr05+oFyj4XiZFIZ+/zWoWUMdVNeOOIdnn3MRNvCqveBkg5CzDQNcfSdBxgb3GLSkW53z9+oa7xS39edftRV01nUp+w1a9oHmEk/DaEaEnimm1lMPlX1Ub1AM0Os1n4N8QjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731166795; c=relaxed/simple;
	bh=tXfocABwPBFTxx/MOXWvovhlbtkWeZ2PINylPXQqA3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJWuMZwOUbQnOHbkldma6FKCKXO2fg1QqdSvfTHAiwzcJ5fmkPa4KcVCMq5dZjPC8IPJzD81+gJOPVNaGNIKW7oSMfYjOfQRWLxTtpHSleLuUx7hPiHJaOKO2iIzqfRkgzUMfv6GdAQQpBRo5sx7lQf+PaFIUm8WJquiVAdmAeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOdrh8UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30028C4CECE;
	Sat,  9 Nov 2024 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731166794;
	bh=tXfocABwPBFTxx/MOXWvovhlbtkWeZ2PINylPXQqA3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bOdrh8UIoov3JPWAru6BaEk9TPiON1p456mTnNf6HMXan0tm2FSSP389HzEgkg5Qr
	 +SdFKQu0gze9veDUGcar2LggftfuEb1jnO0KnWRrt36/SwoEua9A1m8Mhts84rtK/2
	 SJ5Y4u/rds2CUqw4pCArxqVqv4JlUxoIL5zU1Aucuedhr/wnK9sVNdo9rt8m7KGWZ/
	 L8U3HFHG0LdKrv+dKZd68MndMrE+ewSx8mrDIf0Oi4w+W3r+kXt4RyiwQEFjWXB/Ti
	 LS2hDRxKLJlowNEi7DGdYmDbSEgmGCpV0ROHMBEGoZ9TGqzs05EkD4z2RZAWHGQC/t
	 SaKsbYE+AxEDA==
Date: Sat, 9 Nov 2024 15:39:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] iio: adc: ad4851: add ad485x driver
Message-ID: <20241109153946.4f4df9d2@jic23-huawei>
In-Reply-To: <146a24a7-d7a1-4969-98c0-f621a1709dd7@baylibre.com>
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
	<20241101112358.22996-7-antoniu.miclaus@analog.com>
	<de120709-b60b-4e85-912e-b60ca18a8001@baylibre.com>
	<CY4PR03MB339993CDE9BA8DD3976CF2F29B5C2@CY4PR03MB3399.namprd03.prod.outlook.com>
	<1f2b8d91-19be-46b7-9202-824aa177dff6@baylibre.com>
	<146a24a7-d7a1-4969-98c0-f621a1709dd7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 10:47:52 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 11/7/24 10:13 AM, David Lechner wrote:
> > On 11/7/24 4:51 AM, Miclaus, Antoniu wrote:  
> 
> 
> >>> I'm pretty sure that calibscale and calibbias also need to take into
> >>> account if resolution boost is enabled or not.  
> >>
> >> Can you please detail a bit on this topic? I am not sure what I should do.
> >>  
> > 
> > We haven't implemented oversampling yet in ad4695 yet, so I don't know
> > exactly what we need to do either. ;-)
> > 
> > But this is how I would test it to see if it is working correctly or
> > not. We will need to test this with a 20-bit chip since that is the
> > only one that will change the _scale attribute when oversampling is
> > enabled.
> > 
> > First, with oversampling disabled (_oversampling_ratio = 1), generate
> > a constant voltage of 1V for the input. Read the _raw attribute. Let's
> > call this value raw0. Read the _scale attribute, call it scale0 and
> > the _offset attribute, call it offset0.
> > 
> > Then we should have (raw0 + offset0) * scale0 = 1000 mV (+/- some
> > noise).
> > 
> > Then change the offset calibrate to 100 mV. To do this, we reverse
> > the calculation 100 mV / scale0 = calibbias (raw units). Write the
> > raw value to the _calibbias attribute. Then read the _raw
> > attribute again, call it raw0_with_calibbias.
> > 
> > This time, we should have (raw0_with_calibbias + offset0) * scale0
> > = 1100 mV (+/- some noise).
> > 
> > Then set _calibbias back to 0 and repeat the above by setting the
> > _calibscale attribute to 0.90909 (this is 1 / 1.1, which should  
> 
> Now that I have written this, this has me second-guessing if I
> implemented calibscale correctly on ad4695. It would seem more
> logical that if we have an actual input voltage of 1 V and a
> calibscale of 1.1, then the resulting processed value we read
> should be 1100 mV.
> 
> Jonathan, can you set me straight? The sysfs ABI docs aren't
> clear on this point.

Deliberately vague in this case.  calibbias is kind of the wild west
of ABI. Often we have no meaningful information on what the tweak
register settings actually do beyond 'up vs down'.  In some cases
the datasheets even refer to them as taps up or taps down.

I don't think we've ever said if it should be consistent as you
change other parameters.  If you care about calibration you probably
need to redo it for your new settings anyway and tweak the calibbias
/calibscale till it gives the right values.

Obviously that is easier to do if you have a consistent scheme for
a given device and if possible allow calibrating at just one setting
but I don't think we can apply general rules.

Jonathan

> 
> > add 10% to the measured raw value). Read, the _raw attribute again,
> > call it raw0_with_caliscale.
> > 
> > This time, we should have (raw0_with_caliscale + offset0) * scale0
> > = 1100 mV (+/- some noise).
> > 
> > Set _calibscale back to 0. Then set _oversampling_ratio to 2. Read
> > _scale and _offset again, call these scale1 and offset1.
> > 
> > Then repeat the steps above using scale1 and offset1 in the
> > calculations. The raw values will be different but the resulting
> > processed values (mV) should all be the same if the attributes
> > are implemented correctly.
> >   


