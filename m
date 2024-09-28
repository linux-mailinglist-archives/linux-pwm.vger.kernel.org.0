Return-Path: <linux-pwm+bounces-3389-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D09890E5
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 19:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718FB281EC7
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8A1448E3;
	Sat, 28 Sep 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3o8AfQd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7F1DDC9;
	Sat, 28 Sep 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727545653; cv=none; b=qUUfXmpFRdPRXz0+7e7vIMFSq8IHJUBrO4a6Z4qgOcVD9ojUDKSvJN9cDdMsxjG8gFYShf0xaIk3R3Wl1hKx6TFuFBQlFj23sBmYjpbPnCEJUWxn+M7QFVTZWUsHxAHGDl27nbrF0/6h2r9Gf4LlWqwZeCmIUNUzgF6HdZu/kKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727545653; c=relaxed/simple;
	bh=JVWMZ2uryw2i0TZEETV/srEzMJ/lmNarVJCMpotwcaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApP+yXkkCuAr9lU+dei4LDYhxfKcbHaViitFSZf/DElefugTBlii606/c3TRI3VIw9bdzyRjAfvs0sVmBFPbi/GSpj5MlQWHOKvKif6jXBpuOqyPbgXCgPbTMp8coKxb2k3Yvtql2U7GUyeIAyUb135/6Wbj9ezosNIJYvLaCt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3o8AfQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF1DC4CEC3;
	Sat, 28 Sep 2024 17:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727545653;
	bh=JVWMZ2uryw2i0TZEETV/srEzMJ/lmNarVJCMpotwcaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M3o8AfQdIkW/PHzyM9vZ9wb04F2SFJZi3L3wF63oB0fH6QSVKt2dBqicfdzoj3VFq
	 Aw013BCWTik+VYjC5hH1/lnsRTdeAKxmOzs+3mxaQc6scTw31krT/44rSCsI1PcgS3
	 sFbD2VqjzqHL+0a1RKOKUmfIlujhOPBWxVugzd8nVUiDkEqXTcSHZ+G6RWaoE16yt0
	 NruHuaHRm3ghoCeT2D/VrzOvkzhBCGqIwdRDL8A2UXFdyBDDhHeu+E78drzpIXiw2K
	 sSFGq9H3C0Yzv2BmDhY5k83Iyj6FUkEoUy4x3MOgyQQl2ABVN9+J8Yj40SJPKsaoOB
	 94XL5wERyYcdQ==
Date: Sat, 28 Sep 2024 18:47:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Mike Looijmans
 <mike.looijmans@topic.nl>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <20240928184722.314b329b@jic23-huawei>
In-Reply-To: <20240923101206.3753-7-antoniu.miclaus@analog.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	<20240923101206.3753-7-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 13:10:23 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X DAS familiy.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

A few additional comments from me.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad485x.c b/drivers/iio/adc/ad485x.c
> new file mode 100644
> index 000000000000..3333cad9ed8f
> --- /dev/null
> +++ b/drivers/iio/adc/ad485x.c
> @@ -0,0 +1,1061 @@

> +static int ad485x_setup(struct ad485x_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +
> +	ret = ad485x_set_sampling_freq(st, 1000000);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_INTERFACE_CONFIG_A,
> +			   AD485X_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_INTERFACE_CONFIG_B,
> +			   AD485X_SINGLE_INSTRUCTION);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_INTERFACE_CONFIG_A,
> +			   AD485X_SDO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_PRODUCT_ID_L, &product_id);
> +	if (ret)
> +		return ret;
> +
> +	if (product_id != st->info->product_id)
> +		dev_warn(&st->spi->dev, "Unknown product ID: 0x%02X\n",
> +			 product_id);

dev_info() for this is probably better.  Might be fine afterall if
the new part is fully backwards compatible with this one.

> +
> +	ret = regmap_write(st->regmap, AD485X_REG_DEVICE_CTRL,
> +			   AD485X_ECHO_CLOCK_MODE);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD485X_REG_PACKET, 0);
> +}


> +
> +static int ad485x_get_packet_format(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan)
> +{
> +	struct ad485x_state *st = iio_priv(indio_dev);
> +	unsigned int format;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_PACKET, &format);
> +	if (ret)
> +		return ret;
> +
> +	format = FIELD_GET(AD485X_PACKET_FORMAT_MASK, format);
> +
> +	return format;
	return FIELD_GET()
> +}

> +
> +static int ad485x_get_calibscale(struct ad485x_state *st, int ch, int *val,
> +				 int *val2)
> +{
> +	unsigned int reg_val;
> +	int gain;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_GAIN_MSB(ch),
> +			  &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain = (reg_val & 0xFF) << 8;
Use a byte array into which you write the regval then a get_unalignedb_be16
or similar to get the value.
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_GAIN_LSB(ch),
> +			  &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain |= reg_val & 0xFF;
> +
> +	*val = gain;
> +	*val2 = 32768;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}

> +static int ad485x_get_calibbias(struct ad485x_state *st, int ch, int *val,
> +				int *val2)
> +{
> +	unsigned int lsb, mid, msb;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_MSB(ch),
> +			  &msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_MID(ch),
> +			  &mid);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_LSB(ch),
> +			  &lsb);
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
As below I'd use a byte array then you can do get_unaligned_be24 to
+ a right shift by 4 of the whole thing.

> +		*val = sign_extend32(*val, 19);
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad485x_set_calibbias(struct ad485x_state *st, int ch, int val,
> +				int val2)
> +{
> +	unsigned int lsb, mid, msb;
> +	int ret;
> +
> +	if (st->info->resolution == 16) {
> +		lsb = 0;
> +		mid = val & 0xFF;
> +		msb = (val >> 8) & 0xFF;
> +	} else {
> +		lsb = (val << 4) & 0xFF;

Might as well mask by 0xF0 to make it really clear
nothing in bottom few bits.


> +		mid = (val >> 4) & 0xFF;
> +		msb = (val >> 12) & 0xFF;

I'd be tempted to shift the whole thing left 4 bits and
then use a put_unaligned_be24 on it into a byte array then pick
out the bytes from that array.  Will be easier to read.
Above 16 bit case would be a put_unaligned_be16

> +	}
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_LSB(ch), lsb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_MID(ch), mid);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_MSB(ch), msb);

I think you already got this question, but consider bulk writes.

> +}
> +
> +static const unsigned int ad485x_scale_table[][2] = {
> +	{2500, 0x0}, {5000, 0x1}, {5000, 0x2}, {10000, 0x3}, {6250, 0x04},
> +	{12500, 0x5}, {10000, 0x6}, {20000, 0x7}, {12500, 0x8}, {25000, 0x9},
> +	{20000, 0xA}, {40000, 0xB}, {25000, 0xC}, {50000, 0xD}, {40000, 0xE},
> +	{80000, 0xF}

Spaces after { and before } preferred.
Maybe just have this as one item per line. I think that is more readable.

> +};

> +
> +static int ad485x_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad485x_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->sampling_freq;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad485x_get_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad485x_get_scale(st, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad485x_get_calibbias(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_OFFSET:
> +		scoped_guard(mutex, &st->lock)
> +			* val = st->offsets[chan->channel];

			*val = ...

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +#define AD485X_IIO_CHANNEL(index, real, storage, info)			\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.ext_info = info,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
> +		BIT(IIO_CHAN_INFO_SCALE) |				\
> +		BIT(IIO_CHAN_INFO_OFFSET),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.info_mask_shared_by_type_available =				\
> +		BIT(IIO_CHAN_INFO_SCALE) |				\
> +		BIT(IIO_CHAN_INFO_OFFSET),				\

Maybe add avail for calibscale and calibbias as well.


> +
> +static struct iio_chan_spec_ext_info ad4858_ext_info[] = {
> +	IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> +	IIO_ENUM_AVAILABLE("packet_format",
> +			   IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> +	{},
> +};
> +
> +static struct iio_chan_spec_ext_info ad4857_ext_info[] = {
> +	IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> +	IIO_ENUM_AVAILABLE("packet_format",
> +			   IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> +	{},
I think Andy pointed these out. No trailing comma on terminators.

However, I'm not sure this ABI is practical currently.
Basically I have no idea what it is or how to use it!
> +};

> +
> +static const struct ad485x_chip_info ad4858i_info = {
> +	.name = "ad4858i",
> +	.product_id = AD4858I_PROD_ID,
> +	.scale_table = ad485x_scale_table,
> +	.num_scales = ARRAY_SIZE(ad485x_scale_table),
> +	.offset_table = ad4858_offset_table,
> +	.num_offset = ARRAY_SIZE(ad4858_offset_table),
> +	.channels = ad4858_channels,
> +	.num_channels = ARRAY_SIZE(ad4858_channels),
> +	.throughput = 1000000,

Odd you use MEGA above, but not here.

> +	.resolution = 20,
> +};

> +static int ad485x_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad485x_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	mutex_init(&st->lock);

Ever so slight preference for the new option of.
	ret = devm_mutex_init(dev, &st->lock);
	if (ret)
		return ret;

...

> +}
> +
> +static const struct of_device_id ad485x_of_match[] = {
> +	{ .compatible = "adi,ad4858", .data = &ad4858_info, },
> +	{ .compatible = "adi,ad4857", .data = &ad4857_info, },
> +	{ .compatible = "adi,ad4856", .data = &ad4856_info, },
> +	{ .compatible = "adi,ad4855", .data = &ad4855_info, },
> +	{ .compatible = "adi,ad4854", .data = &ad4854_info, },
> +	{ .compatible = "adi,ad4853", .data = &ad4853_info, },
> +	{ .compatible = "adi,ad4852", .data = &ad4852_info, },
> +	{ .compatible = "adi,ad4851", .data = &ad4851_info, },
> +	{ .compatible = "adi,ad4858i", .data = &ad4858i_info, },
> +	{}
	{ }
> +};
> +



