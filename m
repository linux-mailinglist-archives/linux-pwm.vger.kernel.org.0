Return-Path: <linux-pwm+bounces-4756-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C17A24A3E
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Feb 2025 17:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830BF3A73EB
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Feb 2025 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF771C3BFC;
	Sat,  1 Feb 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmmPA2jQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38E2F56;
	Sat,  1 Feb 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738426782; cv=none; b=Wr4sAE4RiZg8iYvthyDaEa1j0ilKe8Hj2nRVYRQyOZ4mLP8CRJgVmHq4TpzZXJi4TrODJ3oc8cdQaQjDDYnzFNuhGvAn774YNRaJ2+zGLIhOJ33fYI84JSzcyxA+QmzICEk/us2TA2dtZfqbmz9TfO0+KfserPd1bzmxkoG7JJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738426782; c=relaxed/simple;
	bh=DY5NDVYk7SPwl1aCk3edxfLAY7ludyGB6iGKYhQhItQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFlfq61QSEFUz5tcMH/78x5j8u8SF/REnqS+yvdguiN3ajddQhzUQtLSOakJcYs81H5hO6Fk2VWna/HQZuL7689V1Rcf1BTYDQKuoUpnrhwaT5v+bXXH9/LFGUEsc8Pbc8QAIjZV5irHaWRG2Ffx4Z6ZIkx6yz3b5K1+o3KrEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmmPA2jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4853DC4CED3;
	Sat,  1 Feb 2025 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738426781;
	bh=DY5NDVYk7SPwl1aCk3edxfLAY7ludyGB6iGKYhQhItQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XmmPA2jQ1bhbxy+69mwiq+c4FixlOTgEGnjM9fSl1VQri3TGr5Qv5yNXYB/nxKD05
	 /BqimMYImS6hU1koEPntpW+JqNCJxqlPioB28+ANwWtr8xxmIxq3+2GwsFLGXC7tDK
	 CeeSfxZkqTdYhEiI0gd/nP4Sf6ktZcJnDEHyexYde5pE+R4rO8Ld0TmkyxS3wf+r6d
	 wk861r77taUqGt/aIOQ3MUK7/51DWIH0MyJOZN0hGBTGUILxVX1cNjYML6EnlffbTH
	 gCXtVmTmKO3lI0D0oSS1aD4DGbbc2WW5/wIHyWaY72D8/hE6ewclq5BjmkPwvcnN55
	 ekeHthQGtoW7g==
Date: Sat, 1 Feb 2025 16:19:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v11 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <20250201161932.08417b99@jic23-huawei>
In-Reply-To: <20250127105726.6314-9-antoniu.miclaus@analog.com>
References: <20250127105726.6314-1-antoniu.miclaus@analog.com>
	<20250127105726.6314-9-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 12:57:26 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Nearly there, but I think an issue with the allocation of the iio_chan_spec
array has gotten through.  In general, pass the non const data for that
around until you are ready to commit to not changing it any more and only
then set the pointer and number of channels in the struct iio_dev.

Jonathan

> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..a49959679e75
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c
> @@ -0,0 +1,1302 @@

> +
> +#define AD4851_IIO_CHANNEL							\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |					\
> +		BIT(IIO_CHAN_INFO_SCALE),					\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.info_mask_shared_by_all_available =					\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.indexed = 1,
Typically don't have a trailling comma here...
> +
> +/*
> + * In case of AD4858_IIO_CHANNEL the scan_type is handled dynamically during the
> + * parse_channels function.
> + */
> +#define AD4858_IIO_CHANNEL							\
> +{										\
> +	AD4851_IIO_CHANNEL							\
> +}
> +
> +#define AD4857_IIO_CHANNEL							\
> +{										\
> +	AD4851_IIO_CHANNEL							\

.. so you can have one here and it looks more like normal assignment.
of just set this in the other channel parsing functions so that the template
is the same for all devices.


> +	.scan_type = {								\
> +		.sign = 'u',							\
> +		.realbits = 16,							\
> +		.storagebits = 16,						\
> +	},									\
> +}
> +
> +static int ad4851_parse_channels(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec ad4851_chan)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *channels;
> +	unsigned int num_channels, reg;
> +	unsigned int index = 0;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > AD4851_MAX_CH_NR)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
> +				     num_channels);
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (reg >= AD4851_MAX_CH_NR)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid channel number\n");
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");
> +		*channels = ad4851_chan;
> +		channels->scan_index = index++;
> +		channels->channel = reg;
> +
> +		if (fwnode_property_present(child, "diff-channels")) {
> +			channels->channel2 = reg + st->info->max_channels;
> +			channels->differential = 1;
> +		}
> +
> +		channels++;
> +
> +		st->bipolar_ch[reg] = fwnode_property_read_bool(child, "bipolar");
> +
> +		if (st->bipolar_ch[reg]) {
> +			channels->scan_type.sign = 's';
> +		} else {
> +			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
> +					   AD4851_SOFTSPAN_0V_40V);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4857_parse_channels(struct iio_dev *indio_dev)
> +{
> +	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL;
> +
> +	return ad4851_parse_channels(indio_dev, ad4851_chan);
> +}
> +
> +static int ad4858_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL;
> +	int ret;
> +
> +	ad4851_channels = (struct iio_chan_spec *)indio_dev->channels;

Casting away a const is normally a 'bad smell' but there is more
going on here than just that.
Who allocated this?  At this point I'm fairly sure no one did yet
> +
> +	ret = ad4851_parse_channels(indio_dev, ad4851_chan);

It's allocated in here.

Create a function with the 'functionality' of ad4851_parse_channels along
lines of this (returns num channels if positive)

static int ad4851_parse_channels_common(struct iio_dev *indio_dev,
					const struct iio_chan_spec ad4851_chan,
				        struct iio_chan_spec **chans)
{
	struct ad4851_state *st = iio_priv(indio_dev);
	struct device *dev = &st->spi->dev;
	struct iio_chan_spec *channels;
	unsigned int num_channels, reg;
	unsigned int index = 0;
	int ret;

	num_channels = device_get_child_node_count(dev);
	if (num_channels > AD4851_MAX_CH_NR)
		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
				     num_channels);

	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
	if (!channels)
		return -ENOMEM;

//	indio_dev->channels = channels;
//	indio_dev->num_channels = num_channels;

	device_for_each_child_node_scoped(dev, child) {
		ret = fwnode_property_read_u32(child, "reg", &reg);
		if (reg >= AD4851_MAX_CH_NR)
			return dev_err_probe(dev, ret,
					     "Invalid channel number\n");
		if (ret)
			return dev_err_probe(dev, ret,
					     "Missing channel number\n");
		*channels = ad4851_chan;
		channels->scan_index = index++;
		channels->channel = reg;

		if (fwnode_property_present(child, "diff-channels")) {
			channels->channel2 = reg + st->info->max_channels;
			channels->differential = 1;
		}

		channels++;

		st->bipolar_ch[reg] = fwnode_property_read_bool(child, "bipolar");

		if (st->bipolar_ch[reg]) {
			channels->scan_type.sign = 's';
		} else {
			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
					   AD4851_SOFTSPAN_0V_40V);
			if (ret)
				return ret;
		}
	}
//and get back the channels + how many
	*chans = channels;

	return num_channels;
}

Then in the callers, do other stuff to chanels as necessary before finally
assigning iio_dev->channels and iio_dev->num_channels when they are actually
constant as we've finished filling them in.

> +	if (ret)
> +		return ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ad4851_channels->has_ext_scan_type = 1;
> +		if (fwnode_property_present(child, "bipolar")) {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_b;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_b);
> +
> +		} else {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_u;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_u);
> +		}
> +		ad4851_channels++;
> +	}
> +
> +	return 0;
> +}


