Return-Path: <linux-pwm+bounces-6459-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0A0AE2A1F
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 18:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CCC1899F64
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA022126E;
	Sat, 21 Jun 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWPoLFlG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5121FF48;
	Sat, 21 Jun 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750522113; cv=none; b=n7FFNZYcq3p9NmUaHj43weJBW+J8UHVW+fNxm5CVRg6EPVU9EjsVq3wdVQh/LZjNejA+FYDPdB/DKsam4T4KWRj4oeLnT8Jok3a5cMkf7OiMU9X172p/K5/Vmft8xVKOR6wOo8khhD/oOZzJCX/5objoGDnTM+xnmES3i3hGZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750522113; c=relaxed/simple;
	bh=yJGijM+8o40JqzQz5C3sIfRbs/BciilUWorAgqKr8rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAgidoRQzC72AAxTpySjT3a0XhadujnrXbAi56xlxWybFx7Vhf4dhnBwEz5uVwFXg4LNCNbMb2FWXv3fkTF/5Dvg2yNjCxKIVUO1HLIwBTEN9I30fNM47PZiDDsXyVcnyHQj8dnD++ELxx1oYhZqnC3+ZybFSaGA2qbM9g8NTro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWPoLFlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0D3C4CEE7;
	Sat, 21 Jun 2025 16:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750522113;
	bh=yJGijM+8o40JqzQz5C3sIfRbs/BciilUWorAgqKr8rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lWPoLFlG0bPYkIdt7QVAo8TlRCOuhvvQxGWSM+wr9D0qpXYqpscgP0fhp+8sW6bHa
	 jhdWLUX/d0CjAeYfr5WjjUYH/0l4/WD+/aFKBvorIqndW5sroh+dd4Om61NqU3PYpp
	 IXoqav7dPipC/6zRG77/5K5OESrUb6Utseoh234t+gtdUW7/Bz837B4MWCmJ7M0eMx
	 +y61IGNptt+QtHPAdZThcYhIqyPn76HcLjwgJihQWvtT3N7w7jkWTPDeei1SsKf1fl
	 gb8k+eC/GDvt7Ihb1HBJKMu5G6zdm02bLPcW9DvqBCLd02CYh31EjyC3JomEcLGwMn
	 YtmqHA0K/iC4A==
Date: Sat, 21 Jun 2025 17:08:24 +0100
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
Message-ID: <20250621170824.249c6b0c@jic23-huawei>
In-Reply-To: <c89f4b2f-0892-4f63-b9b4-5ae55b477c01@baylibre.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-4-cf1e44c516d4@analog.com>
	<20250614110812.39af2c41@jic23-huawei>
	<c89f4b2f-0892-4f63-b9b4-5ae55b477c01@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 09:54:52 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/14/25 5:08 AM, Jonathan Cameron wrote:
> > On Tue, 10 Jun 2025 09:34:37 +0200
> > Jorge Marques <jorge.marques@analog.com> wrote:
> >   
> >> The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit, successive
> >> approximation register (SAR) analog-to-digital converter (ADC) that
> >> enables low-power, high-density data acquisition solutions without
> >> sacrificing precision. This ADC offers a unique balance of performance
> >> and power efficiency, plus innovative features for seamlessly switching
> >> between high-resolution and low-power modes tailored to the immediate
> >> needs of the system. The AD4052/AD4058/AD4050/AD4056 are ideal for
> >> battery-powered, compact data acquisition and edge sensing applications.
> >>  
> 
> ...
> 
> >> +static int ad4052_update_xfer_raw(struct iio_dev *indio_dev,
> >> +				   struct iio_chan_spec const *chan)
> >> +{
> >> +	struct ad4052_state *st = iio_priv(indio_dev);
> >> +	const struct iio_scan_type *scan_type;
> >> +	struct spi_transfer *xfer = &st->xfer;
> >> +
> >> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> >> +	if (IS_ERR(scan_type))
> >> +		return PTR_ERR(scan_type);
> >> +
> >> +	xfer->rx_buf = st->raw;
> >> +	xfer->bits_per_word = scan_type->realbits;
> >> +	xfer->len = scan_type->realbits == 24 ? 4 : 2;  
> > 
> > This is a little odd. I'm not sure what happens with len not dividing
> > into a whole number of bits per word chunks.
> > Maybe a comment?  
> 
> Even better, there is now spi_bpw_to_bytes() for this.
> 
> >   
> >> +	xfer->speed_hz = AD4052_SPI_MAX_ADC_XFER_SPEED(st->vio_uv);
> >> +
> >> +	return 0;
> >> +}  
> > 
> >   
> 
> ...
> 
> >   
> >> +static int __ad4052_read_chan_raw(struct ad4052_state *st, int *val)
> >> +{
> >> +	struct spi_device *spi = st->spi;
> >> +	struct spi_transfer t_cnv = {};
> >> +	int ret;
> >> +
> >> +	reinit_completion(&st->completion);
> >> +
> >> +	if (st->cnv_gp) {
> >> +		gpiod_set_value_cansleep(st->cnv_gp, 1);
> >> +		gpiod_set_value_cansleep(st->cnv_gp, 0);
> >> +	} else {
> >> +		ret = spi_sync_transfer(spi, &t_cnv, 1);  
> > 
> > Add a comment for this.   I can't immediately spot documentation on what
> > a content free transfer actually does.  I assume pulses the chip select?
> > is that true for all SPI controllers?  
> 
> Should be. Setting .delay in the xfer would also make it more
> clear that this is doing.
> 
> >   
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +	/*
> >> +	 * Single sample read should be used only for oversampling and
> >> +	 * sampling frequency pairs that take less than 1 sec.
> >> +	 */
> >> +	if (st->gp1_irq) {
> >> +		ret = wait_for_completion_timeout(&st->completion,
> >> +						  msecs_to_jiffies(1000));
> >> +		if (!ret)
> >> +			return -ETIMEDOUT;
> >> +	}
> >> +
> >> +	ret = spi_sync_transfer(spi, &st->xfer, 1);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (st->xfer.len == 2)
> >> +		*val = sign_extend32(*(u16 *)(st->raw), 15);
> >> +	else
> >> +		*val = sign_extend32(*(u32 *)(st->raw), 23);
> >> +
> >> +	return ret;
> >> +}  
> >   
> 
> ...
> 
> >> +
> >> +static int ad4052_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> >> +				     unsigned int writeval, unsigned int *readval)
> >> +{
> >> +	struct ad4052_state *st = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	if (!iio_device_claim_direct(indio_dev))  
> > 
> > For these guards in the debugfs callback, please add a comment on why they
> > are needed.   We've had a lot of questions about these recently and I'd
> > like it to be clear to people when they should cut and paste these and when
> > not.  
> 
> The reason I started doing this is that running the iio_info command attemps
> to read register 0x00 via the debug attribute of every single iio device. So
> if you run iio_info during a buffered read, and 0x00 is a valid register, it
> would break things without this check.
> 
> Ideally, general purpose commands wouldn't be poking debug registers, but
> that isn't the case. But I suppose we could "fix" iio_info instead.
> 

Please do fix iio_info.  It absolutely should not be poking the debug interfaces
except on specific debug calls.  The user has to know they may be shooting themselves
in the foot.

I'm not sure why a read of that register would break buffered capture though.
Is it a volatile register or is there a sequencing problem with multiple
accesses in this driver?  If it is multiple accesses then that should be
prevented via a local lock, not whether we are in buffer mode or not.

So I'm fine with this defense where it is necessary for all register
accesses, but I would like to see comments on why it is necessary.

Jonathan

> >   
> >> +		return -EBUSY;
> >> +
> >> +	if (readval)
> >> +		ret = regmap_read(st->regmap, reg, readval);
> >> +	else
> >> +		ret = regmap_write(st->regmap, reg, writeval);
> >> +	iio_device_release_direct(indio_dev);
> >> +	return ret;
> >> +}  
> >   


