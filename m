Return-Path: <linux-pwm+bounces-4455-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423749FAE0C
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 13:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAD4162F27
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E48F1A3A95;
	Mon, 23 Dec 2024 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AauwYI7r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340719A2B0;
	Mon, 23 Dec 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734955214; cv=none; b=CX8bbCbuIx17p1OeK14/T8bb2U3TfAQr2ODJS3LkLaU8pjzTP2NQvJTerJ4ISB3YEeLHgAk8+lDGcoFurylCvXVRk7y9Mw+f/6xAjSS1ERjdQnB1vIKzEW+D54Dgi49pjQYSPT0MW96afW6j8M5dHtGrJ/JuK5ckplAnubTC0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734955214; c=relaxed/simple;
	bh=eMBtvlonX6DFqouKQusWoFxDUDng4gku7MeD9UIBZ8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLDB+8YS60pFWOTnDqpQZKHIHa37SV82QLcbxPXhoNfNoV+TvhP9rAXw+A8OcxFgFgn5YTW3U2aMAW9qna9qj6FytSL2x3/nHRYaPNXVLT8sKmn0rE6p4e0jTnyU5SBLWyCVjOd8S6U2uOEyqAL3EfIZDEPkXXxozxQzeQ2bl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AauwYI7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD743C4CED3;
	Mon, 23 Dec 2024 12:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734955213;
	bh=eMBtvlonX6DFqouKQusWoFxDUDng4gku7MeD9UIBZ8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AauwYI7rgHHJI3jf+lci6S7Wu+tcW6TJE5YM1FOIq4Ic/KmaoRseGUm+NZ9Lw3iWe
	 uUgVa/SQyn/VwhOKc0Ng9+zUnMIICb/qDlKHca4iLra7XBFtvyRHnMBh97f4DbH4Zf
	 5m+NDTJU1BXlfeV+PWSF/iYCcL4+S5/EQit/d4nTrjPJOYbXtHcflbMY8eIwn8qcY+
	 s8wzttZk0RbCROaFe5OI9HupeZfzUjEukKTDyu17WsvexEgifAQ8ZIayU2r2RNxqkr
	 AYXa8ah0ICKCYuKGi/Ip4reY09+bG1yK4FNp8hiLJLyeeQaoaVNXx5rsbLS0LDoPUo
	 pWvHs2FdN4MSw==
Date: Mon, 23 Dec 2024 12:00:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v9 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <20241223120005.1bc9a208@jic23-huawei>
In-Reply-To: <20241220120134.42760-8-antoniu.miclaus@analog.com>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
	<20241220120134.42760-8-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 14:01:34 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v9:
>  - add back diff-channels property parsing.
>  - shrink code in one line where possible.
>  - use struct device *dev = &st->spi->dev
>  - split elements that are assigned from those which aren't in the places
>    mentioned by the review.
>  - avoid code duplication on num_channels
>  - parse bipolar and diff-channels properties separately.
>  - update comment on parse_channels
>  - use devm_regulator_get_enable_optional for vrefbuf and vrefio
>  - add devm_add_action_or_reset(&st->spi->dev, ad4851_pwm_disable, st->cnv)
>    after the pwm is turned on.

A few comments inline.  The one about checking for existence of voltage
regulators is (I think) a bug. The rest more superficial stuff given
you are going to be doing a v10.  I might otherwise have just tweaked
some of these whilst applying.

Thanks,

Jonathan


> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..c5525433990c
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c
> @@ -0,0 +1,1290 @@

...


> +static void __ad4851_get_scale(struct iio_dev *indio_dev, int scale_tbl,
> +			       unsigned int *val, unsigned int *val2)
> +{
> +	const struct iio_scan_type *scan_type;
> +	unsigned int tmp;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
> +
> +	tmp = ((unsigned long long)scale_tbl * MICRO) >> scan_type->realbits;

u64 for the cast so we know how big it is.


> +	*val = tmp / MICRO;
> +	*val2 = tmp % MICRO;
> +}
> +
> +static int ad4851_scale_fill(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	unsigned int i, val1, val2;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_avail_se); i++) {
> +		__ad4851_get_scale(indio_dev, ad4851_scale_avail_se[i], &val1, &val2);
> +		st->scales_se[i][0] = val1;
> +		st->scales_se[i][1] = val2;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_avail_diff); i++) {
> +		__ad4851_get_scale(indio_dev, ad4851_scale_avail_diff[i], &val1, &val2);
> +		st->scales_diff[i][0] = val1;
> +		st->scales_diff[i][1] = val2;
> +	}
> +
> +	return 0;
> +}


...

> +static int ad4851_get_calibscale(struct ad4851_state *st, int ch, int *val, int *val2)
> +{
> +	unsigned int reg_val;
> +	int gain;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain = reg_val << 8;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain |= reg_val;
> +
> +	*val = gain;
> +	*val2 = 32768;
Why not use IIO_VAL_FRACTIONAL_LOG2;  Then you can make the power of 2 explicit.

> +
> +	return IIO_VAL_FRACTIONAL;
> +}

...

> +
> +static int ad4851_set_calibbias(struct ad4851_state *st, int ch, int val)
> +{
> +	u8 buf[3] = { 0 };
> +	int ret;
> +
> +	if (val < 0)
> +		return -EINVAL;
> +
> +	if (st->info->resolution == 16)
> +		put_unaligned_be16(val, buf);
> +	else
> +		put_unaligned_be24(val << 4, buf);
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_CHX_OFFSET_LSB(ch), buf[2]);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_CHX_OFFSET_MID(ch), buf[1]);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_CHX_OFFSET_MSB(ch), buf[0]);

Add a comment somewhere on why this can't be a bulk read.  Otherwise someone
will change it as it's obvious low hanging fruit for a cleanup.
Perhaps up by the register definitions.  Obviously even better, figure out why
and make it work as it's probably a timing of cs_change thing.

> +}

> +
> +static const struct iio_scan_type ad4851_scan_type_20_0[] = {

the _0 / _1 postfix isn't particularly intuitive. Maybe consider u vs b
for unipolar vs bipolar or something along those lines?

> +	[AD4851_SCAN_TYPE_NORMAL] = {
> +		.sign = 'u',
> +		.realbits = 20,
> +		.storagebits = 32,
> +	},
> +	[AD4851_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 'u',
> +		.realbits = 24,
> +		.storagebits = 32,
> +	},
> +};
> +
> +static const struct iio_scan_type ad4851_scan_type_20_1[] = {
> +	[AD4851_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.realbits = 20,
> +		.storagebits = 32,
> +	},
> +	[AD4851_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 's',
> +		.realbits = 24,
> +		.storagebits = 32,
> +	},
> +};
> +
> +static int ad4851_get_current_scan_type(const struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	return st->resolution_boost_enabled ? AD4851_SCAN_TYPE_RESOLUTION_BOOST
> +					    : AD4851_SCAN_TYPE_NORMAL;
> +}
> +
> +#define AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |					\
> +		BIT(IIO_CHAN_INFO_SCALE),					\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.info_mask_shared_by_all_available =					\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.indexed = 1,								\
> +	.differential = diff,							\
> +	.channel = ch,								\
> +	.channel2 = ch + (diff * 8),						\
> +	.scan_index = index,
> +
> +#define AD4858_IIO_CHANNEL(index, ch, diff)					\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\

Add a comment on why you don't set the scan type stuff up for just this case.

> +}
> +
> +#define AD4857_IIO_CHANNEL(index, ch, diff)					\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.scan_type = {								\
> +		.sign = diff ? 's' : 'u',					\
> +		.realbits = 16,							\
> +		.storagebits = 16,						\
> +	},									\
> +}
> +
> +static int ad4851_parse_channels(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec **ad4851_channels,
> +				 const struct iio_chan_spec ad4851_chan,
> +				 const struct iio_chan_spec ad4851_chan_diff)
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
> +	channels = devm_kcalloc(dev, num_channels,
> +				sizeof(*channels), GFP_KERNEL);

This is an oddly short wrap.  Check the whole driver for places where the wrap
can be neater.  Aim for 80 char limit except when readability is substantially
better if you go up to 100.

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");
> +		if (fwnode_property_present(child, "diff-channels")) {
> +			*channels = ad4851_chan_diff;
> +			channels->scan_index = index++;
> +			channels->channel = reg;
> +			channels->channel2 = reg + AD4851_MAX_CH_NR;
> +
> +		} else {
> +			*channels = ad4851_chan;
> +			channels->scan_index = index++;
> +			channels->channel = reg;
> +		}
> +		channels++;
> +
> +		if (fwnode_property_present(child, "bipolar")) {
> +			st->bipolar_ch[reg] = true;
> +		} else {
> +			st->bipolar_ch[reg] = false;
> +			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
> +					   AD4851_SOFTSPAN_0V_40V);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	*ad4851_channels = channels;
> +
> +	return 0;
> +}

> +static int ad4858_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL(0, 0, 0);
> +	const struct iio_chan_spec ad4851_chan_diff = AD4858_IIO_CHANNEL(0, 0, 1);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan, ad4851_chan_diff);

Wrap this line. It's easy to keep it under 80 chars and that is still the preference
for cases that don't hurt readability in IIO.  Check for similar lines and
wrap them all.

> +	if (ret)
> +		return ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");
> +		if (fwnode_property_present(child, "bipolar")) {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_1;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_1);
> +
> +		} else {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_0;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_0);
> +		}
> +		ad4851_channels++;
> +	}
> +
> +	return 0;
> +}

> +static int ad4851_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &spi->dev;
> +	struct ad4851_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(ad4851_power_supplies),
> +					     ad4851_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get and enable supplies\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vddh");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vddh voltage\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vddl");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vddl voltage\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vrefbuf");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vrefbuf voltage\n");
> +
> +	if (ret > 0)

I'm fairly sure that call never returns a positive.  Will return 0 for success so I think this
should be if (ret == 0)

> +		st->vrefbuf_en = true;
> +	else
> +		st->vrefbuf_en = false;
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vrefio");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vrefio voltage\n");
> +
> +	if (ret > 0)

Same here.

> +		st->vrefio_en = true;
> +	else
> +		st->vrefio_en = false;
> +
...

> +}

