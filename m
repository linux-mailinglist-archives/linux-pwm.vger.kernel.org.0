Return-Path: <linux-pwm+bounces-3288-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343BF97BA0C
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2024 11:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CE31C218BB
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Sep 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D480139D09;
	Wed, 18 Sep 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ek0/3U+A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B222868B
	for <linux-pwm@vger.kernel.org>; Wed, 18 Sep 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651282; cv=none; b=C4dDMbZGkQyPTbvre4yaJukdFPZKo5or7E/as+n4/+5QlZzKCDqiT38/Wo2HrXgOtb/KScwS7HTDoOGp916bwhvk2wOHM1uy5URrBXI/6/7F+bqTWjwKhDj9SUEZKobgEci/R9RM4DbZzOQr4MR55iXT7qANoOIOVg14YOCt+iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651282; c=relaxed/simple;
	bh=ZfhcJdrcgjXRccH2r+DSP2QYPUIUkdPxTUHxNFCvFNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+Wm1g0ev2KMAfiL6Jy3tVCRxtwb7+BpMU3MgZjdUwCGkr3UeDYFg763GC0vguglrhoJ4PuJ1w2WArfjEii392KYoBWpdEQ5wcyESm99bbvmFK3QYsEAO9YGmryqzDDHWYehbVce5SCCloKdsZWNiool0ufLjBfBNwKLeLEwH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ek0/3U+A; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1094602a12.0
        for <linux-pwm@vger.kernel.org>; Wed, 18 Sep 2024 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726651277; x=1727256077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2rvcaWE0cA+av2GmJYqvneONDg6yGGjZm+pg87fVPWQ=;
        b=ek0/3U+AMRGGYtN6qj6EpABMof5uX1iW7QOHap9wuzxpg4InxxT/U1AdcQtNEFG22y
         yX2iQ9p9e9EUr0M2zDqLMJY6+qirVRHTvgIMEl7FT9q3V8CL5W6Z3SyaRz5FEI4Kv1rh
         pHRlDfXYLWdtqsGdtGXQ9Tysk3UYJcMYMtiU1DY1YwScrO195MCYY5IEtc4QHJgZGrSs
         noUbYP4s1tZ6+EVVXe9S0UwQ1Dq3ydKcuQoqwByJWuHvBzot8NAMc81JlUYXMIvBaqzZ
         iDVxd1jKYYjO8nyPF0ahhroNP53HDa/ZG2zuXorkTXbkGV6hhdIXw7frnW4vMYO3O/Wl
         LHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726651277; x=1727256077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rvcaWE0cA+av2GmJYqvneONDg6yGGjZm+pg87fVPWQ=;
        b=GSG4+ihLygJxfPmpr1GScGC55/nX1J0gx+dsxyqD55PTS9Iia4SQKAqCF5K8mGEqjd
         I2YEhAeY9kAjoSRlPNvUByvtN/JyYEZCsdgaGraY1+Hs7dUoCUeKTlRb+AI5MHurIABK
         g2ECbKuamGEbBDmEZdNO0vh5YeNAieREZTskyHPqImRhDiIBi3Xj3p0BewtmfLcZkLWV
         2QpMBEURB89CplnK5eY6fuBT8x7/mTGK+hmKte1YPQJCB7uEF+zljP/yBsUR7UIEzi9T
         WByhguNodotlgJ5J/CY9tSvup8rHvcQJRPEzoRv+sUPt+KLwxh/gDFIUDgEQFvNbUx3q
         7tKg==
X-Gm-Message-State: AOJu0YwHyRZVJnA3peZRUh+epvDGyCPA8XahfLjpyHRmXGnmF3AMWNcc
	ICGiF5mw/AMzo5rMLZL+zuHn48AGTlOAb/Swnu/wTnGHnEdkN4WfH7EnASGD7Go=
X-Google-Smtp-Source: AGHT+IEO4Pse/iE98lP/RmL3b9CYzy/ElHi2nx++y75EJiMNdcDLS3mbZin0e83SYrFwmBdiw2zwXA==
X-Received: by 2002:a05:6402:d06:b0:5c3:d8fb:df6a with SMTP id 4fb4d7f45d1cf-5c414383763mr24840635a12.14.1726651277291;
        Wed, 18 Sep 2024 02:21:17 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc8906fsm4885138a12.86.2024.09.18.02.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 02:21:16 -0700 (PDT)
Date: Wed, 18 Sep 2024 11:21:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v4 4/7] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <pjr5yscxjmmohvn3rddj4ycvs6inefj6ovffic2c6ci63ugyso@r43kd6sxt2kn>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com>
 <7acc85f6-69e9-4e44-ab04-88eaf2ffa291@baylibre.com>
 <5qrct3wt2e544vfoxaaacdifxcc7k243hnlrs7rki5nkbki4os@vfss2f2g4hvu>
 <37e84d8f-f7bf-47e6-811f-50a6e71f8810@baylibre.com>
 <i22iwa6rwscdbnrrfk5vvyjy6bgwblb53ovpjbpozn7237u33p@hcvoyf5lnvwr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <i22iwa6rwscdbnrrfk5vvyjy6bgwblb53ovpjbpozn7237u33p@hcvoyf5lnvwr>

On Tue, Sep 17, 2024 at 07:10:54PM +0200, Uwe Kleine-König wrote:
> Hello David,
> 
> On Mon, Sep 09, 2024 at 03:53:11PM -0500, David Lechner wrote:
> > On 9/8/24 9:59 AM, Uwe Kleine-König wrote:
> > > On Fri, Sep 06, 2024 at 05:26:46PM -0500, David Lechner wrote:
> > > > Or maybe we just don't need the REQUEST and FREE ioctls?
> > > 
> > > The idea of the REQUEST ioctl is that an application can make sure it
> > > can access all PWMs it needs before starting to change the
> > > configuration.
> >
> > Ah, I had not considered that case.
> > 
> > But if it is required in some cases, I feel like it would be better
> > to just make it required in all cases. Otherwise, it feels like there
> > are too many ways to do the same thing if all of the other GET/SET
> > ioctls implicitly call the equivalent of REQUEST if it was not
> > explicitly called. It is one less decision to make for me as a user
> > if there is only one "right" way to use this interface.
> 
> I'd hope you as a user would use libpwm or at least use it as a template
> for your code. :-)
> 
> And to argue honestly: I see an advantage in keeping usage simple and so
> I think it's nice that if an application doesn't care about requesting a
> PWM line, it doesn't need to and the kernel just cares enough about
> these details automatically to still make the operation safe.
> 
> But again, this is subjective and somewhat expected that tastes differ.

While working on v5 of this series (and still having your concern in
mind) I found a good argument to make the REQUEST ioctl explicitly
necessary: In v4, if a call to say SETEXACTWF fails after the pwm_device
was auto-requested the error of pwm_set_waveform_might_sleep() was just
forwarded to userspace without releasing the pwm_device. That semantic
is ugly: While the ioctl failed, still something was changed (i.e. the
pwm_device was requested). The obvious fix is to auto-free the
pwm_device again if pwm_set_waveform_might_sleep() failed. But the
semantic then is still not so nice IMHO. Then SETEXACTWF can fail for
two different sets of reasons: a) requesting failed, and b) programming
the hardware failed. A userspace program has to act differently on these
two error classes, so it cannot be unaware of the whole request
complication. This defeats the idea to make the API simple. From the
userspace program's point of view it then is sensible to explicitly
request the pwm_device to have a simple means to distinguish the two
error classes.

That together with your reasoning that TMTOWTDI isn't usually good for
kernel interfaces convinces me that making the REQUEST ioctl obligatory
is the right way to move forward. So that's what I will do in v5.

Thanks for your input
Uwe

PS: I forgot my crypto token at home, so this mail is unsigned.

