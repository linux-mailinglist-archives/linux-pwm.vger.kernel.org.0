Return-Path: <linux-pwm+bounces-4347-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F08E9F1F0F
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 14:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6297C7A057E
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5133C1925B9;
	Sat, 14 Dec 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKRdAR8o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B7D268;
	Sat, 14 Dec 2024 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734183815; cv=none; b=F/+jd4L19zHjStg2DM2Lz4sGAW1YSGeI3Razwr5cq54j36vxgKXS1AMqQu7khdc795K6aS+35Lq4/MKMh6fDoOT9Y6Sf/MRHZbeJ2xK+TUplxfDrUzAS0D13T5K0Zn68VeoKiBORFarSURLznHGr+DNotEmRWMgeHcB1x7Y+oII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734183815; c=relaxed/simple;
	bh=E2ylePdLN1j0rhZKi6IRDL0ej5OB44kvves6gas3Rhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gItazMjvZw4yQAWkJQ/vcgdsScwxfuj28dhWIslD9tEfZA8zOfHdVAsmtxVj0+vDBwKVeXs4Wjci4cyVg+iPu9pHtdHE8PBvEHjkumeblnwq/qBVmevTj4tXuQJ2NeDL8O4ELEnfxisNkMtCpfEhP64AHQH7nBwurCTfrtIL740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKRdAR8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9908AC4CED1;
	Sat, 14 Dec 2024 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734183813;
	bh=E2ylePdLN1j0rhZKi6IRDL0ej5OB44kvves6gas3Rhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VKRdAR8o+xn1zPaEINfaXIMhzus6/UBjvuzwr8sYTL/S15GnPGCWNU97TzQtP+AeH
	 Lm9Uq5Vsygl8YHGanbT/DrNoQmQyRorUTJu55xlCrSLd5WfKB/xrN4Wyt7uPTC7RSs
	 PBwDGgbugWzBXkDXoSTQU+mB4VDrkkr1Kp/Ku0lnDCpvOpQVsXp/1d4G+tuem53HYs
	 yAxjrFtU/RkLpLFS1QX0C91ZZGFP5yvm71MZ3f/uCR/PXfogJafrbU2ONA8xqkNX9C
	 1Eupr0lLJwn+HdbLMmwUsZo8Xy25D7ydbdtUGRqJVbxz22jKya0bweBr0vOiaMnUjp
	 hMFlk8PQQK7lw==
Date: Sat, 14 Dec 2024 13:43:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v8 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <20241214134325.5aa7c99b@jic23-huawei>
In-Reply-To: <20241213164445.23195-8-antoniu.miclaus@analog.com>
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
	<20241213164445.23195-8-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 18:44:45 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

Whilst David's question needs a clear answer I took a look at this
version and noticed a few more minor things.

One is a left over from a previous review that got missed.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..a5dbf464a4b0
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c
> @@ -0,0 +1,1300 @@


...


> +static int ad4851_get_calibbias(struct ad4851_state *st, int ch, int *val)
> +{
> +	unsigned int lsb, mid, msb;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_OFFSET_MSB(ch),
> +			  &msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_OFFSET_MID(ch),
> +			  &mid);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_OFFSET_LSB(ch),
> +			  &lsb);

Fits under 80 chars so should be on oneline.
Check the whole driver for similar cases.  As code evolves and indents
change it's common to have a few of these but a final check by the author
before posting should tidy them up.

> +	if (ret)
> +		return ret;
> +
> +	if (st->info->resolution == 16) {
> +		*val = msb << 8;
> +		*val |= mid;
> +		*val = sign_extend32(*val, 15);
> +	} else {
> +		*val = msb << 12;
> +		*val |= mid << 4;
> +		*val |= lsb >> 4;
> +		*val = sign_extend32(*val, 19);
> +	}
> +
> +	return IIO_VAL_INT;
> +}




...


> +
> +static int ad4851_parse_channels(struct iio_dev *indio_dev, struct iio_chan_spec **ad4851_channels,
> +				 const struct iio_chan_spec ad4851_chan,
> +				 const struct iio_chan_spec ad4851_chan_diff)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct ad4851_state *st = iio_priv(indio_dev);

See below. I'd get the device via st->spi.dev

> +	struct iio_chan_spec *channels;
> +	unsigned int num_channels, index = 0, reg;
Trivial but I'd prefer splitting the elements that are assigned from those that aren't.
	unsigned int num_channels, reg;
	unsigned int index = 0;

It can sometimes be a little hard to spot which are assigned and which not if
they are all in one long line.

> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > AD4851_MAX_CH_NR)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
> +				     num_channels);
> +
> +	channels = devm_kcalloc(dev, num_channels,
> +				sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;
> +	st->num_channels = num_channels;

Trivial.  Maybe worth avoiding that duplication.

> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");
> +		if (fwnode_property_present(child, "bipolar")) {

Bipolar and differential aren't necessarily linked.  You can have
a differential channel that is not bipolar. Maybe in this case this
connection is there. Anyhow this really comes back to David's question
on why these aren't differential channels in DT.

> +			*channels = ad4851_chan_diff;
> +			channels->scan_index = index++;
> +			channels->channel = reg;
> +			channels->channel2 = reg + AD4851_MAX_CH_NR;
> +
> +		} else {
> +			*channels = ad4851_chan;
> +			channels->scan_index = index++;
> +			channels->channel = reg;
> +			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
> +					   AD4851_SOFTSPAN_0V_40V);
> +			if (ret)
> +				return ret;
> +		}
> +		channels++;
> +	}
> +
> +	*ad4851_channels = channels;
> +
> +	return 0;
> +}
> +
> +static int ad4857_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL(0, 0, 0);
> +	const struct iio_chan_spec ad4851_chan_diff = AD4857_IIO_CHANNEL(0, 0, 1);
> +
> +	return ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan, ad4851_chan_diff);
> +}
> +
> +static int ad4858_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct device *dev = indio_dev->dev.parent;

Whilst true that it's that device, that is kind of an internal detail of IIO.
	struct ad4851_state *state = iio_priv(indio_dev);
	struct device *dev = &state->spi.dev;
is contained entirely in this driver code so perhaps a more resilient path to
that device.

Same for other places where you need to get to that device.

> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL(0, 0, 0);
> +	const struct iio_chan_spec ad4851_chan_diff = AD4858_IIO_CHANNEL(0, 0, 1);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan, ad4851_chan_diff);
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
> +
> +/* parse_channel() function populates of the rest of the chip_info fields */

This comment is confusing. Whilst there are other fields that are filled
by parsing the channels, they aren't in anything called chip_info.


> +static const struct ad4851_chip_info ad4851_info = {
> +	.name = "ad4851",
> +	.product_id = 0x67,
> +	.max_sample_rate_hz = 250 * KILO,
> +	.resolution = 16,
> +	.parse_channels = ad4857_parse_channels,
> +};

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
> +	st->vrefbuf = devm_regulator_get_optional(dev, "vrefbuf");

Please add a comment here and for vrefio below to say why you don't enable
these yet.  I assume that's to do with setting device state before enabling
the regulator. If that ordering isn't actually required, then enabling them
here probably makes more sense.  Then just store a flag/bool to say if they were
enodev or not rather than keeping the regulator pointer around. 

In many cases I'd expect these to be provided precision references that are always
on so I hope the device doesn't need them to be off until it is configured.

> +	if (IS_ERR(st->vrefbuf)) {
> +		if (PTR_ERR(st->vrefbuf) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(st->vrefbuf),
> +					     "Failed to get vrefbuf regulator\n");
> +	}
> +
> +	st->vrefio = devm_regulator_get_optional(dev, "vrefio");
> +	if (IS_ERR(st->vrefio)) {
> +		if (PTR_ERR(st->vrefio) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(st->vrefio),
> +					     "Failed to get vrefio regulator\n");
> +	}
> +
> +	st->pd_gpio = devm_gpiod_get_optional(dev, "pd", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->pd_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->pd_gpio),
> +				     "Error on requesting pd GPIO\n");
> +
> +	st->cnv = devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->cnv))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv),
> +				     "Error on requesting pwm\n");
> +
> +	ret = devm_add_action_or_reset(&st->spi->dev, ad4851_pwm_disable,
> +				       st->cnv);

At this point it's not turned on.  So not appropriate to turn it off automatically
just yet.

> +	if (ret)
> +		return ret;
> +
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	st->regmap = devm_regmap_init_spi(spi, &regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ad4851_set_sampling_freq(st, HZ_PER_MHZ);
> +	if (ret)
> +		return ret;

The call above is what enables the PWM I think. So should have
the devm_add_action_or_reset() to turn it off down here.

Note I gave this feedback on an earlier version.  Please make sure to
either address all comments in next posting or reply to the review to
given a reason they are not appropriate / correct etc.

> +
> +	ret = ad4851_setup(st);
> +	if (ret)
> +		return ret;

> +}

