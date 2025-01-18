Return-Path: <linux-pwm+bounces-4675-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4831CA15E29
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 17:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E002166236
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 16:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCD19E975;
	Sat, 18 Jan 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po/hY2lt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3219CC24;
	Sat, 18 Jan 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737219481; cv=none; b=tkRIJmdxTZwZ8Tx6NJPr0yjbjbdt+RPAYSV1u8QNYmeS2RxvH0DRkFdy7xGbBBYrkgxluey5rBmYZfjfM7QlBOQ2umN/oQhSstnJDuxN7e4g7qwgWlFOtPG0cMmIDiQLqebKvKirmAQ4z5F7n2Dk0n9KcNUeQaEJql2mR0mwqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737219481; c=relaxed/simple;
	bh=meheUtbs98xJgPkjAJIveNeOLQ7f9R49Q1KB7cAL5Og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnBHX6I1N3KDh/GetLO95dgng+q0I6+77juq5jccZP3sKcPn8RMKm0PofY7zWsduTxCmcT1rZ5MyEtF1WX0VuqLXhXmrepaRjsjLauvpSYJt6fSychmdoFOfoljb2TZNugpAIoVWR0DPnRnBAFRPbqvSeYV913KuZHSQDLe0lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po/hY2lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4503C4CED1;
	Sat, 18 Jan 2025 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737219481;
	bh=meheUtbs98xJgPkjAJIveNeOLQ7f9R49Q1KB7cAL5Og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Po/hY2ltyrGHWD3uLdVHSxWrsriZtsGxR6cIsrARysI4mLsCIs+4OzkvziQ7TQqfr
	 WswB2ZOeDIgZwWWUDQpXUdOuAlTn7OuFFyjgmsB0/9dPxQEosiWgG/+l9E6++qnED5
	 TINPjQ4ULGQr8m0EFT9HcH6ZR9oRRpEJmQoB+8qX+OvkM4McyvmiQOwjNOmZt077M8
	 bf39x2e2x34npHlTtu8iiJl/nBgN2OOrZYmRv/ox2Sg/Uam8fufrWv58ucz3kkL8rZ
	 NC5a7n2dwlFuvGsnD2dnXXYhfYhkIYAEoi/e68ud694neTXoHtbZyShGX2mfpruJK8
	 mmDGjeh3O1xZA==
Date: Sat, 18 Jan 2025 16:57:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <20250118165751.334fe37b@jic23-huawei>
In-Reply-To: <d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	<20250117130702.22588-9-antoniu.miclaus@analog.com>
	<d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 15:45:35 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/17/25 7:07 AM, Antoniu Miclaus wrote:
> > Add support for the AD485X a fully buffered, 8-channel simultaneous
> > sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> > differential, wide common-mode range inputs.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---  
> 
> ...
> 
> > +static void __ad4851_get_scale(struct iio_dev *indio_dev, int scale_tbl,
> > +			       unsigned int *val, unsigned int *val2)
> > +{
> > +	const struct iio_scan_type *scan_type;
> > +	unsigned int tmp;
> > +
> > +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);  
> 
> This is ignoring possible error return.
> 
> > +
> > +	tmp = ((u64)scale_tbl * MICRO) >> scan_type->realbits;
> > +	*val = tmp / MICRO;
> > +	*val2 = tmp % MICRO;
> > +}
> > +...  
> 
> > +static int ad4851_read_raw(struct iio_dev *indio_dev,
> > +			   const struct iio_chan_spec *chan,
> > +			   int *val, int *val2, long info)
> > +{
> > +	struct ad4851_state *st = iio_priv(indio_dev);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*val = st->cnv_trigger_rate_hz / st->osr;  
> 
> Needs to be:
> 
> 		*val = st->cnv_trigger_rate_hz;
> 		*val2 = st->osr;
> 
> for IIO_VAL_FRACTIONAL.
> 
> > +		return IIO_VAL_FRACTIONAL;
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		return ad4851_get_calibscale(st, chan->channel, val, val2);
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return ad4851_get_scale(indio_dev, chan, val, val2);
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		return ad4851_get_calibbias(st, chan->channel, val);
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		return ad4851_get_oversampling_ratio(st, val);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ad4851_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long info)
> > +{
> > +	struct ad4851_state *st = iio_priv(indio_dev);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		return ad4851_set_sampling_freq(st, val * st->osr);  
> 
> Since we are using IIO_VAL_FRACTIONAL on read, we should handle val2 here to
> allow for a decimal component.
> 
> 	val * st->osr + val2 * st->osr / MICRO
> 
> 
> Also, should return -EINVAL if (val < 0 || val2 < 0) to avoid negative values
> being turned into large numbers when casting to unsigned.
> 
> 
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return ad4851_set_scale(indio_dev, chan, val, val2);
> > +	case IIO_CHAN_INFO_CALIBSCALE:
> > +		return ad4851_set_calibscale(st, chan->channel, val, val2);
> > +	case IIO_CHAN_INFO_CALIBBIAS:
> > +		return ad4851_set_calibbias(st, chan->channel, val);
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		return ad4851_set_oversampling_ratio(indio_dev, chan, val);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +  
> 
> ...
> 
> > +
> > +#define AD4851_IIO_CHANNEL(index, ch, diff)					\
> > +	.type = IIO_VOLTAGE,							\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
> > +		BIT(IIO_CHAN_INFO_CALIBBIAS) |					\
> > +		BIT(IIO_CHAN_INFO_SCALE),					\
> > +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),		\
> > +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> > +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> > +	.info_mask_shared_by_all_available =					\
> > +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> > +	.indexed = 1,								\
> > +	.differential = diff,							\
> > +	.channel = ch,								\
> > +	.channel2 = ch,								\
> > +	.scan_index = index,  
> 
> channel, channel2 and scan_index get written over in ad4851_parse_channels()
> so can be omitted here.
> 
> > +
> > +/*
> > + * In case of AD4858_IIO_CHANNEL the scan_type is handled dynamically during the
> > + * parse_channels function.
> > + */
> > +#define AD4858_IIO_CHANNEL(index, ch, diff)					\
> > +{										\
> > +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> > +}
> > +
> > +#define AD4857_IIO_CHANNEL(index, ch, diff)					\
> > +{										\
> > +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> > +	.scan_type = {								\
> > +		.sign = 'u',							\
> > +		.realbits = 16,							\
> > +		.storagebits = 16,						\
> > +	},									\
> > +}
> > +
> > +static int ad4851_parse_channels(struct iio_dev *indio_dev,
> > +				 struct iio_chan_spec **ad4851_channels,
> > +				 const struct iio_chan_spec ad4851_chan,
> > +				 const struct iio_chan_spec ad4851_chan_diff)
> > +{
> > +	struct ad4851_state *st = iio_priv(indio_dev);
> > +	struct device *dev = &st->spi->dev;
> > +	struct iio_chan_spec *channels;
> > +	unsigned int num_channels, reg;
> > +	unsigned int index = 0;
> > +	int ret;
> > +
> > +	num_channels = device_get_child_node_count(dev);
> > +	if (num_channels > AD4851_MAX_CH_NR)
> > +		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
> > +				     num_channels);
> > +
> > +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> > +	if (!channels)
> > +		return -ENOMEM;
> > +
> > +	indio_dev->channels = channels;
> > +	indio_dev->num_channels = num_channels;
> > +
> > +	device_for_each_child_node_scoped(dev, child) {
> > +		ret = fwnode_property_read_u32(child, "reg", &reg);
> > +		if (ret || reg >= AD4851_MAX_CH_NR)
> > +			return dev_err_probe(dev, ret,
> > +					     "Missing/Invalid channel number\n");  
> 
> This allows returning 0 on error which will lead to an invalid state. Probably
> best to split this into two messages/returns.
> 
> > +		if (fwnode_property_present(child, "diff-channels")) {
> > +			*channels = ad4851_chan_diff;
> > +			channels->scan_index = index++;
> > +			channels->channel = reg;
> > +			channels->channel2 = reg;  
> 
> Typically we don't set channel == channel2 for differential channels.
So i guess this is tripping up on these being dedicated pairs labelled
+IN1,-IN1 on the datasheet.  The binding documents those as matching
the diff-channels - hence both channels and reg are the same.
So maybe best bet is to enforce that in the driver by checking it is
true.

It is a slightly weird description but only alternative would be to
invent some more channel numbers for the negative sides which is
less than ideal.  We could go that way though.

Some comments alongside a sanity check is probably the best way to
handle this and no surprise us in the future.

> 
> > +
> > +		} else {
> > +			*channels = ad4851_chan;
> > +			channels->scan_index = index++;
> > +			channels->channel = reg;  
> 
> These two lines are the same in each branch, so can be pulled out of the if
> statement to avoid duplicating them.
> 
> > +		}
> > +		channels++;
> > +
> > +		st->bipolar_ch[reg] = fwnode_property_read_bool(child, "bipolar");
> > +
> > +		if (st->bipolar_ch[reg]) {
> > +			channels->scan_type.sign = 's';
> > +		} else {
> > +			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
> > +					   AD4851_SOFTSPAN_0V_40V);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +	}
> > +
> > +	*ad4851_channels = channels;  
> 
> At this point, channels is pointing to memory we didn't allocate (because of
> channels++). As in the previous review, I suggest we just get rid of the output
> parameter since indio_dev->channels already has the correct pointer.
> 
> It's less chance for mistakes like this and avoids needing to provide an unused
> arg in ad4857_parse_channels().
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad4857_parse_channels(struct iio_dev *indio_dev)
> > +{
> > +	struct iio_chan_spec *ad4851_channels;
> > +	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL(0, 0, 0);
> > +	const struct iio_chan_spec ad4851_chan_diff = AD4857_IIO_CHANNEL(0, 0, 1);  
> 
> The only difference between these is the diff bit, so seems simpler to just
> have one template and dynamically set the bit instead.
> 
> > +
> > +	return ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan,
> > +				     ad4851_chan_diff);
> > +}
> > +...  
> 
> > +static const struct iio_info ad4851_iio_info = {
> > +	.debugfs_reg_access = ad4851_reg_access,
> > +	.read_raw = ad4851_read_raw,
> > +	.write_raw = ad4851_write_raw,
> > +	.update_scan_mode = ad4851_update_scan_mode,
> > +	.get_current_scan_type = &ad4851_get_current_scan_type,  
> 
> Inconsistent use of & on function pointer.
> 
> > +	.read_avail = ad4851_read_avail,
> > +};
> > +  


