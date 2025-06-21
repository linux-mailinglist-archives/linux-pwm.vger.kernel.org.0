Return-Path: <linux-pwm+bounces-6463-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FDEAE2A44
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEE6177659
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2123114A62B;
	Sat, 21 Jun 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/d/N0HL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5CB19BBC;
	Sat, 21 Jun 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750522867; cv=none; b=jOd9/GUCkcHhTbSVuGB/aYjemQcvI1a4kyqQsPzUYRcMf3UC+bk3D3AUiiy10elIBcDiDze2uWOMppa63A9SehJ397UISyT2l+nyr31ImKqbFgjl0jtCGDJ/39+EsZ05zfyUds4e0eBSMsEGLPHyuWs0StNcsvOHoQkPVHnx2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750522867; c=relaxed/simple;
	bh=LB/sUlImxWZJV0axEKn9tfOzZFIfxAbqgGkgEQtBZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AvLuAC7YxUroj3JaMgxXes2usSPBm6lhlxZVGF+cZxqJ6d3aEwk69Zx72JPO7jpYpFNTPdPioX/xwepoFtEzXcffso5ywvNfxFKN/tU8nxEl6ZHcW+dEKByyW74eaNCqzliJWzE37KIW4qW6PRhRa9bF4UyJT/Z4O7vQzRYyycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/d/N0HL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41B3C4CEE7;
	Sat, 21 Jun 2025 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750522866;
	bh=LB/sUlImxWZJV0axEKn9tfOzZFIfxAbqgGkgEQtBZ0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/d/N0HLO8IFfTdRJMTxTwOkneCdUwP4t3AQn83qfjTgPQO3APcqH4LMOoLjK2K1T
	 sa3CeeUbyK90l4uX4GRdYkSa49x0PryTnGqiwaT0xJm5qyxKATcw6P6J5UHnBVTmTD
	 kAjgCbF2EFt1Wjau1mvOQMmAH44ZWBIU1AxBU8xAO5/6EBhSvtl+SBSHlRYZpVfHSx
	 6URQ42efVcH0z1j+DWyV7k8JUgoxSGmkJRaWogr2or4k9bs62SoJKNfOmDYn9bKuaf
	 mAROyXgGnXfyKhUSqi424U3buI/n4HOvMMK01HrrCJKuDpckWdVCVhbuQlGBbcBSoN
	 c1JJU77lAQcIQ==
Date: Sat, 21 Jun 2025 17:20:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 8/8] iio: adc: Add events support to ad4052
Message-ID: <20250621172054.3698f3ff@jic23-huawei>
In-Reply-To: <2uknsmgz57wie4cv2tll3ttfyiw7lyjyaryc74nd3o5fteoazk@vbgdt5ofkn5r>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-8-cf1e44c516d4@analog.com>
	<20250614113616.4663269f@jic23-huawei>
	<2uknsmgz57wie4cv2tll3ttfyiw7lyjyaryc74nd3o5fteoazk@vbgdt5ofkn5r>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > +
> > > +static int ad4052_read_event_value(struct iio_dev *indio_dev,
> > > +				   const struct iio_chan_spec *chan,
> > > +				   enum iio_event_type type,
> > > +				   enum iio_event_direction dir,
> > > +				   enum iio_event_info info, int *val,
> > > +				   int *val2)
> > > +{
> > > +	struct ad4052_state *st = iio_priv(indio_dev);
> > > +	int ret;
> > > +
> > > +	if (!iio_device_claim_direct(indio_dev))
> > > +		return -EBUSY;
> > > +
> > > +	if (st->wait_event) {
> > > +		ret = -EBUSY;
> > > +		goto out_release;  
> >   
> 
> Below are two distinct options with different implications.
> > Not being able to read event parameters whilst monitoring them seems
> > very restrictive.  Can't we cache the values?  Either play games to ensure
> > we get them from the regmap cache or just cache these few values in st.
> > 
> > Checking what you are monitoring for feels like the sort of thing
> > userspace might well do.  
> 
> (1)
> I agree, I can investigate regcache_cache_only and the other cache
> options to achieve this. If I come to the conclusion it is not possible,
> storing into st will achieve the same.
> 
> > 
> > Even blocking changing the monitoring parameters is unusually strict.
> > Why not just drop out of monitor mode, update them and go back in?
> >   
> (2)
> The core point of the blocking behaviour is to not have hidden downtimes
> in the monitoring for the user. An early driver used to do what you
> describe and it was a design decision.
> 
> Since a custom regmap_bus was necessary to restrict the regmap access
> speed (ADC access is faster), bringing back this by behavior embedding
> it in the custom regmap now seems plausible, with proper explanation in
> the rst page. This should fully dismiss the st->wait_event -> -EBUSY.
> 
> Considering (1) and (2), what is the preferred approach?

Key here is that the user made the choice to change the parameters.
Most of the time they won't choose to do that, but if they do then
that's what they want to do. Why make them turn the monitoring off,
change value and turn it on again if we can support it reasonably
cleanly.  In many devices there is no interruption to monitoring so
we may well have userspace code written against assumption it
can just update this stuff without that dance.  So prefer (2)
but (1) is better than nothing if (2) proves too complex.

J
> 
> Regards,
> Jorge
> > > +	}
> > > +
> > > +	switch (info) {
> > > +	case IIO_EV_INFO_VALUE:
> > > +		ret = __ad4052_read_event_info_value(st, dir, val);
> > > +		break;
> > > +	case IIO_EV_INFO_HYSTERESIS:
> > > +		ret = __ad4052_read_event_info_hysteresis(st, dir, val);
> > > +		break;
> > > +	default:
> > > +		ret = -EINVAL;
> > > +		break;
> > > +	}
> > > +
> > > +out_release:
> > > +	iio_device_release_direct(indio_dev);
> > > +	return ret ? ret : IIO_VAL_INT;
> > > +}  


