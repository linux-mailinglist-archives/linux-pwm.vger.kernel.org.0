Return-Path: <linux-pwm+bounces-6468-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932D7AE3065
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Jun 2025 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235781892630
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Jun 2025 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E249F1E7C2E;
	Sun, 22 Jun 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D10j0628"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2908F7D;
	Sun, 22 Jun 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750602511; cv=none; b=j1KxvtTx6XQERDbPKYg0SS19lhlEQzsVT1559e/MXqzcazjeIQuneAHESXFl8vy5v36nLSQDFkvjlFTO5n3bvh171YlEXI05YCNKfmE+zbzSffrZf1VUk0zkG67HFKCKgfkDYXDGj4qIOk1lW41bK7KvqLZUt1GD8a5qynG82pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750602511; c=relaxed/simple;
	bh=SaJ+23WO+7OYLKZg2pBhG5ynSdOJOwyYxgfo0mfMTAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnQhU1/mJNhZGPL4RnGnx+e8zmyJYmGVry9yBjv2R7GnmGJwf1rarmilb3Tr1BJ0m0dFwwASe1x3jMuUxJEUldmhryUoawg6jJP7rR6qsoL1WYPNygPr+rxEIxlwP12aj2ghVWCx01YIbrYf8psn9/7y6H4v3nogJMyxaM/uVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D10j0628; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1274BC4CEE3;
	Sun, 22 Jun 2025 14:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750602511;
	bh=SaJ+23WO+7OYLKZg2pBhG5ynSdOJOwyYxgfo0mfMTAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D10j0628NEW6t1Yz28rXWveZauB0RAPAaYdmBWO16drJYElLVgXh/dwbAYTk+Eh+a
	 SUCmKfuvh4hPvKHw5TOXs5BX+W9nGHuCguz+8dOnEk6JHCKkWj36PdV8Blx4Inr6dm
	 4vVuXkyh2IG7blnaUj+bQ5grtdhiDgKomD7BfHuOPNX+Rr6Uwpdtprjk95X2EaIi23
	 rCRhMmu2UnWT6pOVcpNH/TUIKHdIbyBsZkPM0yMnc2ydczdlFrOziMMak212iIzGvg
	 uGbjC9KXvHmbl9TeCAjifUoGl38x+RXdmedo9HQyE+RmTvSJlmviYBLQ1rBILhPziv
	 iW+rtFFvJ7lBw==
Date: Sun, 22 Jun 2025 15:28:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/8] iio: adc: Add support for ad4052
Message-ID: <20250622152820.7333c88e@jic23-huawei>
In-Reply-To: <0e8bd9ff-ae2e-486b-8beb-c14d7909cb7c@baylibre.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-4-cf1e44c516d4@analog.com>
	<20250614110812.39af2c41@jic23-huawei>
	<c89f4b2f-0892-4f63-b9b4-5ae55b477c01@baylibre.com>
	<20250621170824.249c6b0c@jic23-huawei>
	<0e8bd9ff-ae2e-486b-8beb-c14d7909cb7c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Jun 2025 11:13:58 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/21/25 11:08 AM, Jonathan Cameron wrote:
> > On Mon, 16 Jun 2025 09:54:52 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 6/14/25 5:08 AM, Jonathan Cameron wrote:  
> >>> On Tue, 10 Jun 2025 09:34:37 +0200
> >>> Jorge Marques <jorge.marques@analog.com> wrote:
> >>>     
> >>>> The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit, successive
> >>>> approximation register (SAR) analog-to-digital converter (ADC) that
> >>>> enables low-power, high-density data acquisition solutions without
> >>>> sacrificing precision. This ADC offers a unique balance of performance
> >>>> and power efficiency, plus innovative features for seamlessly switching
> >>>> between high-resolution and low-power modes tailored to the immediate
> >>>> needs of the system. The AD4052/AD4058/AD4050/AD4056 are ideal for
> >>>> battery-powered, compact data acquisition and edge sensing applications.
> >>>>    
> >>
> >> ...
> >>  
> >>>> +static int ad4052_update_xfer_raw(struct iio_dev *indio_dev,
> >>>> +				   struct iio_chan_spec const *chan)
> >>>> +{
> >>>> +	struct ad4052_state *st = iio_priv(indio_dev);
> >>>> +	const struct iio_scan_type *scan_type;
> >>>> +	struct spi_transfer *xfer = &st->xfer;
> >>>> +
> >>>> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> >>>> +	if (IS_ERR(scan_type))
> >>>> +		return PTR_ERR(scan_type);
> >>>> +
> >>>> +	xfer->rx_buf = st->raw;
> >>>> +	xfer->bits_per_word = scan_type->realbits;
> >>>> +	xfer->len = scan_type->realbits == 24 ? 4 : 2;    
> >>>
> >>> This is a little odd. I'm not sure what happens with len not dividing
> >>> into a whole number of bits per word chunks.
> >>> Maybe a comment?    
> >>
> >> Even better, there is now spi_bpw_to_bytes() for this.
> >>  
> >>>     
> >>>> +	xfer->speed_hz = AD4052_SPI_MAX_ADC_XFER_SPEED(st->vio_uv);
> >>>> +
> >>>> +	return 0;
> >>>> +}    
> >>>
> >>>     
> >>
> >> ...
> >>  
> >>>     
> >>>> +static int __ad4052_read_chan_raw(struct ad4052_state *st, int *val)
> >>>> +{
> >>>> +	struct spi_device *spi = st->spi;
> >>>> +	struct spi_transfer t_cnv = {};
> >>>> +	int ret;
> >>>> +
> >>>> +	reinit_completion(&st->completion);
> >>>> +
> >>>> +	if (st->cnv_gp) {
> >>>> +		gpiod_set_value_cansleep(st->cnv_gp, 1);
> >>>> +		gpiod_set_value_cansleep(st->cnv_gp, 0);
> >>>> +	} else {
> >>>> +		ret = spi_sync_transfer(spi, &t_cnv, 1);    
> >>>
> >>> Add a comment for this.   I can't immediately spot documentation on what
> >>> a content free transfer actually does.  I assume pulses the chip select?
> >>> is that true for all SPI controllers?    
> >>
> >> Should be. Setting .delay in the xfer would also make it more
> >> clear that this is doing.
> >>  
> >>>     
> >>>> +		if (ret)
> >>>> +			return ret;
> >>>> +	}
> >>>> +	/*
> >>>> +	 * Single sample read should be used only for oversampling and
> >>>> +	 * sampling frequency pairs that take less than 1 sec.
> >>>> +	 */
> >>>> +	if (st->gp1_irq) {
> >>>> +		ret = wait_for_completion_timeout(&st->completion,
> >>>> +						  msecs_to_jiffies(1000));
> >>>> +		if (!ret)
> >>>> +			return -ETIMEDOUT;
> >>>> +	}
> >>>> +
> >>>> +	ret = spi_sync_transfer(spi, &st->xfer, 1);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	if (st->xfer.len == 2)
> >>>> +		*val = sign_extend32(*(u16 *)(st->raw), 15);
> >>>> +	else
> >>>> +		*val = sign_extend32(*(u32 *)(st->raw), 23);
> >>>> +
> >>>> +	return ret;
> >>>> +}    
> >>>     
> >>
> >> ...
> >>  
> >>>> +
> >>>> +static int ad4052_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> >>>> +				     unsigned int writeval, unsigned int *readval)
> >>>> +{
> >>>> +	struct ad4052_state *st = iio_priv(indio_dev);
> >>>> +	int ret;
> >>>> +
> >>>> +	if (!iio_device_claim_direct(indio_dev))    
> >>>
> >>> For these guards in the debugfs callback, please add a comment on why they
> >>> are needed.   We've had a lot of questions about these recently and I'd
> >>> like it to be clear to people when they should cut and paste these and when
> >>> not.    
> >>
> >> The reason I started doing this is that running the iio_info command attemps
> >> to read register 0x00 via the debug attribute of every single iio device. So
> >> if you run iio_info during a buffered read, and 0x00 is a valid register, it
> >> would break things without this check.
> >>
> >> Ideally, general purpose commands wouldn't be poking debug registers, but
> >> that isn't the case. But I suppose we could "fix" iio_info instead.
> >>  
> > 
> > Please do fix iio_info.  It absolutely should not be poking the debug interfaces
> > except on specific debug calls.  The user has to know they may be shooting themselves
> > in the foot.
> > 
> > I'm not sure why a read of that register would break buffered capture though.
> > Is it a volatile register or is there a sequencing problem with multiple
> > accesses in this driver?  If it is multiple accesses then that should be
> > prevented via a local lock, not whether we are in buffer mode or not.  
> 
> IIRC, this was particularly a problem on chips that have a separate data
> capture mode and reading a register exits data capture mode.

Those ones I'm fine with just having a comment that hopefully means it
doesn't get cut and paste somewhere inappropriate!

Jonathan

> 
> > 
> > So I'm fine with this defense where it is necessary for all register
> > accesses, but I would like to see comments on why it is necessary.
> > 
> > Jonathan
> >   
> >>>     
> >>>> +		return -EBUSY;
> >>>> +
> >>>> +	if (readval)
> >>>> +		ret = regmap_read(st->regmap, reg, readval);
> >>>> +	else
> >>>> +		ret = regmap_write(st->regmap, reg, writeval);
> >>>> +	iio_device_release_direct(indio_dev);
> >>>> +	return ret;
> >>>> +}    
> >>>     
> >   
> 


