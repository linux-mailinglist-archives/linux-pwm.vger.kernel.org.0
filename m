Return-Path: <linux-pwm+bounces-4175-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE369DF21D
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Nov 2024 18:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AA92810E8
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Nov 2024 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B951A2632;
	Sat, 30 Nov 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULCr3D5Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D38468;
	Sat, 30 Nov 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732986370; cv=none; b=lG/Ik/iBCfq/9ygxwoYSzO2IDvuftyrZoXHPPFIrwye+W0ZO1Mn7AXpI/JwPovEO1P9QJxPU2FMsUfvXyWEQOdyXfNYYM4svpyMI9wdf3POh6xhkpx7ap/HbwIDVmo/x965kunLVNuFH0ZWA2NBJG77kKw4ZQc302JZ+OCLxjlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732986370; c=relaxed/simple;
	bh=YT8u8PQhT/FcidDay9cA3ZIOy2+NbSTHOTNHdq56/UU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZX95ItA6ChzENk3lOg/l3piHZcrtmsuvFwg2Ntut54MnXEorQAfAPYR9mNVO6D1XY8ngx/zBcHlyMaHZT/J5oilt/2bf5uMg6ffWr1Psknv3W2WSGxL7mhG2YkWmRtGGRK6zCdg1VY6w7IhVF3/7IgkzkOmiFudK5bhsFHyao+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULCr3D5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A11EC4CECC;
	Sat, 30 Nov 2024 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732986370;
	bh=YT8u8PQhT/FcidDay9cA3ZIOy2+NbSTHOTNHdq56/UU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ULCr3D5QUsHcLQwWF13h2ojBRICMvtooxfBiIKainVGXOTn1wHDtsuXdD45Iyh4t4
	 q1A7aiLOk0Z/UEhgJ6TSPaMQunHCHR7IfGGOIAUH8JHLamTvV4eQGYboxcBzKq6xH1
	 MucEk2B6Eu5z+PsHi7+7ebhaW/jTLjG/ZI8WN4Xolx4XhzRXMmRg6NvPl1++/QEEmA
	 oV5hf+0WQyUBgDkZi29sBT6jhsAfCK7qlUxkKK4padVU3u2wFI3UE0OMF2Z/ODr5RM
	 H4wUfdujaxVFeVs+X09RFJQWK67Zl7SRTkuRQsi7wGPdVT/a+fvzYfYl4NP+kPlnNO
	 MHNngmbKiS32A==
Date: Sat, 30 Nov 2024 17:06:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v7 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <20241130170600.3488f987@jic23-huawei>
In-Reply-To: <20241129153546.63584-9-antoniu.miclaus@analog.com>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
	<20241129153546.63584-9-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 17:35:46 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v7:
>  - use new iio backend os enable/disable functions
>  - implement separate scan_type for both signed and unsigned.
>  - drop ext_scan_type for 16-bit chips
>  - rework scan_index ordering.
>  - add separate scales for diff/single-ended channels
>  - parse iio channels via dts properties.
Hi Antoniu

The bot clearly found a few places where data got added but not used
that need fixing up.  Some other comments below.

> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..e8e5c0def29e
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c
> @@ -0,0 +1,1346 @@

> +struct ad4851_chip_info {
> +	const char *name;
> +	unsigned int product_id;
> +	int num_scales;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
Some of these appear to be optional. If so, I think this structure should
have some docs to explain why.

> +	unsigned long max_sample_rate_hz;
> +	unsigned int resolution;
> +	int (*parse_channels)(struct iio_dev *indio_dev);
> +};


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
> +	.scan_index = index,							\
Why the final line continuation?

> +
> +#define AD4858_IIO_CHANNEL(index, ch, diff, bits)				\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.ext_scan_type = ad4851_scan_type_##bits##_##diff,			\
> +	.num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_##bits##_##diff),	\

Seems you set this again below.

> +}
> +
> +#define AD4857_IIO_CHANNEL(index, ch, diff, bits)				\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.scan_type = {								\
> +		.sign = 's',							\
> +		.realbits = bits,						\
> +		.storagebits = bits,						\
> +	},									\
> +}
> +
> +static const struct iio_chan_spec ad4858_channels[] = {
> +	AD4858_IIO_CHANNEL(0, 0, 0, 20),
> +	AD4858_IIO_CHANNEL(1, 0, 1, 20),
> +	AD4858_IIO_CHANNEL(2, 1, 0, 20),
> +	AD4858_IIO_CHANNEL(3, 1, 1, 20),
> +	AD4858_IIO_CHANNEL(4, 2, 0, 20),
> +	AD4858_IIO_CHANNEL(5, 2, 1, 20),
> +	AD4858_IIO_CHANNEL(6, 3, 0, 20),
> +	AD4858_IIO_CHANNEL(7, 3, 1, 20),
> +	AD4858_IIO_CHANNEL(8, 4, 0, 20),
> +	AD4858_IIO_CHANNEL(9, 4, 1, 20),
> +	AD4858_IIO_CHANNEL(10, 5, 0, 20),
> +	AD4858_IIO_CHANNEL(11, 5, 1, 20),
> +	AD4858_IIO_CHANNEL(12, 6, 0, 20),
> +	AD4858_IIO_CHANNEL(13, 6, 1, 20),
> +	AD4858_IIO_CHANNEL(14, 7, 0, 20),
> +	AD4858_IIO_CHANNEL(15, 7, 1, 20),
> +};
> +
> +static const struct iio_chan_spec ad4857_channels[] = {
> +	AD4857_IIO_CHANNEL(0, 0, 0, 16),
> +	AD4857_IIO_CHANNEL(1, 0, 1, 16),
> +	AD4857_IIO_CHANNEL(2, 1, 0, 16),
> +	AD4857_IIO_CHANNEL(3, 1, 1, 16),
> +	AD4857_IIO_CHANNEL(4, 2, 0, 16),
> +	AD4857_IIO_CHANNEL(5, 2, 1, 16),
> +	AD4857_IIO_CHANNEL(6, 3, 0, 16),
> +	AD4857_IIO_CHANNEL(7, 3, 1, 16),
> +	AD4857_IIO_CHANNEL(8, 4, 0, 16),
> +	AD4857_IIO_CHANNEL(9, 4, 1, 16),
> +	AD4857_IIO_CHANNEL(10, 5, 0, 16),
> +	AD4857_IIO_CHANNEL(11, 5, 1, 16),
> +	AD4857_IIO_CHANNEL(12, 6, 0, 16),
> +	AD4857_IIO_CHANNEL(13, 6, 1, 16),
> +	AD4857_IIO_CHANNEL(14, 7, 0, 16),
> +	AD4857_IIO_CHANNEL(15, 7, 1, 16),
> +};
> +
> +static int ad4857_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL(0, 0, 0, 16);
> +	const struct iio_chan_spec ad4851_chan_diff = AD4857_IIO_CHANNEL(0, 0, 1, 16);
> +	unsigned int num_channels, index = 0, reg;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > AD4851_MAX_CH_NR)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
> +				     num_channels);
> +
> +	ad4851_channels = devm_kcalloc(dev, num_channels,
> +				       sizeof(*ad4851_channels), GFP_KERNEL);
> +	if (!ad4851_channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = ad4851_channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");
> +		if (fwnode_property_present(child, "diff-channels")) {
> +			*ad4851_channels = ad4851_chan_diff;
> +			ad4851_channels->scan_index = index++;
> +			ad4851_channels->channel = reg;
> +			ad4851_channels->channel2 = reg + AD4851_MAX_CH_NR;
> +		} else {
> +			*ad4851_channels = ad4851_chan;
> +			ad4851_channels->scan_index = index++;
> +			ad4851_channels->channel = reg;
> +			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
> +					   AD4851_SOFTSPAN_0V_40V);
> +			if (ret)
> +				return ret;
> +		}
> +		ad4851_channels++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4858_parse_channels(struct iio_dev *indio_dev)

> +{
> +	struct device *dev = indio_dev->dev.parent;
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL(0, 0, 0, 20);
> +	const struct iio_chan_spec ad4851_chan_diff = AD4858_IIO_CHANNEL(0, 0, 1, 20);
> +	unsigned int num_channels, index = 0, reg;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > AD4851_MAX_CH_NR)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
> +				     num_channels);
> +
> +	ad4851_channels = devm_kcalloc(dev, num_channels,
> +				       sizeof(*ad4851_channels), GFP_KERNEL);
> +	if (!ad4851_channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = ad4851_channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");
> +		if (fwnode_property_present(child, "diff-channels")) {
> +			*ad4851_channels = ad4851_chan_diff;
> +			ad4851_channels->scan_index = index++;
> +			ad4851_channels->channel = reg;
> +			ad4851_channels->channel2 = reg + AD4851_MAX_CH_NR;
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_1;
i think this is already set appropriately in the AD4858_IIO_CHANNEL() macro.
 
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_1);
> +
> +		} else {
> +			*ad4851_channels = ad4851_chan;
> +			ad4851_channels->scan_index = index++;
> +			ad4851_channels->channel = reg;
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_0;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_0);
as above.

With those dealt with there is a huge amount of duplication between this and
 ad4857_parse_channels.  Perhaps factor out a helper function into which
the two iio_chan_spec are passed.

> +			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
> +					   AD4851_SOFTSPAN_0V_40V);
> +			if (ret)
> +				return ret;
> +		}
> +		ad4851_channels++;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct ad4851_chip_info ad4851_info = {
> +	.name = "ad4851",
> +	.product_id = 0x67,
> +	.max_sample_rate_hz = 250 * KILO,
> +	.resolution = 16,
> +	.parse_channels = ad4857_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4852_info = {
> +	.name = "ad4852",
> +	.product_id = 0x66,
> +	.max_sample_rate_hz = 250 * KILO,
> +	.resolution = 20,
> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4853_info = {
> +	.name = "ad4853",
> +	.product_id = 0x65,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 16,
> +	.parse_channels = ad4857_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4854_info = {
> +	.name = "ad4854",
> +	.product_id = 0x64,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 20,
> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4855_info = {
> +	.name = "ad4855",
> +	.product_id = 0x63,
> +	.max_sample_rate_hz = 250 * KILO,
> +	.resolution = 16,
> +	.parse_channels = ad4857_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4856_info = {
> +	.name = "ad4856",
> +	.product_id = 0x62,
> +	.max_sample_rate_hz = 250 * KILO,
> +	.resolution = 20,
> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4857_info = {
> +	.name = "ad4857",
> +	.product_id = 0x61,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 16,
> +	.channels = ad4857_channels,
> +	.num_channels = ARRAY_SIZE(ad4857_channels),
> +	.parse_channels = ad4857_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4858_info = {
> +	.name = "ad4858",
> +	.product_id = 0x60,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 20,

A lot of these are not setting all the fields.
If intentional I'd like some comments in here to remind us
why.

> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4858i_info = {
> +	.name = "ad4858i",
> +	.product_id = 0x6F,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 20,
> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct iio_info ad4851_iio_info = {
> +	.debugfs_reg_access = ad4851_reg_access,
> +	.read_raw = ad4851_read_raw,
> +	.write_raw = ad4851_write_raw,
> +	.update_scan_mode = ad4851_update_scan_mode,
> +	.get_current_scan_type = &ad4851_get_current_scan_type,
> +	.read_avail = ad4851_read_avail,
> +};

> +
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
> +	if (ret < 0 && ret != -ENODEV)> +		return dev_err_probe(dev, ret, "failed to enable vddh voltage\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vddl");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vddl voltage\n");
> +
> +	st->vrefbuf = devm_regulator_get_optional(dev, "vrefbuf");
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

I think this belongs after ad4841_set_sampling_freq as that includes
enabling the pwm.  A devm cleanup action should be registered immediately
after whatever it is undoing.


> +				       st->cnv);
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
> +	ret = ad4851_scale_fill(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4851_set_sampling_freq(st, HZ_PER_MHZ);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4851_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->info = &ad4851_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = st->info->parse_channels(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4851_calibrate(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

