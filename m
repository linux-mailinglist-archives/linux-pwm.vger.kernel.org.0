Return-Path: <linux-pwm+bounces-4013-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA859BA0E9
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Nov 2024 15:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202981C20DB3
	for <lists+linux-pwm@lfdr.de>; Sat,  2 Nov 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265019CC27;
	Sat,  2 Nov 2024 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0x0jfiO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC982890;
	Sat,  2 Nov 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730559534; cv=none; b=R3Tq2GF8PjFvFdghVump81L6XAM2CJoWYcZ+jqN1Ff42fpkRyjivSCYvWD7VLvchqiB/OcbZhYzu3sPNpz4dG7AaudfeWe9ni5ECb/Geqe8Uk+CKDBa8NfsPzpJe3ZuOIW0d/bLDUfRLpi63ccbUjcT3GsxQ2BZ6k96ePU0hN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730559534; c=relaxed/simple;
	bh=hA5mig55eMiPG+mSvid5SDtNAli6m8IprtfZYjNaRRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2X8HWAKXizDfRncuKr188Y+OiiPhk3TctHi9HkGn+5/vYnByIFVqopSdc16M1sBUYFSANDuf56UiENYMb7Q69gHpYjPVNnBTt1QrawGgC7YrUwGRPIbQfNfdZqzzigM9ARqVd75L8NW3sf+GH8WWo52u0yjNFrLn/UtmdgeMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0x0jfiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64891C4CEC3;
	Sat,  2 Nov 2024 14:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730559534;
	bh=hA5mig55eMiPG+mSvid5SDtNAli6m8IprtfZYjNaRRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p0x0jfiOVJzwlcSmKaBvmUeHbqe/qzlkiZhAcUs/D1hZYxAQF4D8gnK332OSriG3Z
	 pu7u1f+E54BV2UUbfeib8XO54kYhoGHO5wsuBV0Gtbbh5kNfjCVrgU3BxlwDwaLnvJ
	 un11o8+sfcoFHRrTNVv84KbwU+CjX7bOM3Beo1GH+bPHPwg+3xZOdJ0u/Jf6keZVfb
	 O9IOWguuPxc1wgxGEgOaaY8NCI+aqWAmeFSSQ7pljnLqzL6Ua8vrLpXSfBSLflSIw/
	 j3HhqZw9/ITOjx6cAK0RvDxuz7JJNiWQvac1l+igdjJqnD6ARoPfPLVj4mAeuvahQt
	 zONnSk+Jb3ZyQ==
Date: Sat, 2 Nov 2024 14:58:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <conor+dt@kernel.org>, <dlechner@baylibre.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] iio: adc: ad4851: add ad485x driver
Message-ID: <20241102145847.6e615d42@jic23-huawei>
In-Reply-To: <20241101112358.22996-7-antoniu.miclaus@analog.com>
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
	<20241101112358.22996-7-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 13:23:58 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu.

Various things inline to add to David's much more thorough review.

Jonathan

> +enum {
> +	AD4851_SCAN_TYPE_NORMAL,
> +	AD4851_SCAN_TYPE_RESOLUTION_BOOST,
> +};
> +
> +struct ad4851_state {
> +	struct spi_device *spi;
> +	struct pwm_device *cnv;
> +	struct iio_backend *back;
> +	/*
> +	 * Synchronize access to members the of driver state, and ensure
> +	 * atomicity of consecutive regmap operations.
> +	 */
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	struct regulator *vrefbuf;
> +	struct regulator *vrefio;
> +	const struct ad4851_chip_info *info;
> +	struct gpio_desc *pd_gpio;
> +	bool resolution_boost_enabled;
> +	unsigned long sampling_freq;
> +	unsigned int (*scales)[2];

As described below consider clearer type definition by using
a structure.

> +	int *offsets;
> +};
>
> +static int ad4851_setup(struct ad4851_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +
> +	if (st->pd_gpio) {

Not obvious why you are pulsing twice. Add a comment.

> +		gpiod_set_value(st->pd_gpio, GPIOD_OUT_HIGH);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, GPIOD_OUT_LOW);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, GPIOD_OUT_HIGH);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, GPIOD_OUT_LOW);
> +		fsleep(1000);
> +	}
...

> +static int ad4851_calibrate(struct ad4851_state *st)
> +{
> +	unsigned int opt_delay, lane_num, delay, i, s, c;
> +	enum iio_backend_interface_type interface_type;
> +	DECLARE_BITMAP(pn_status, AD4851_MAX_LANES * AD4851_MAX_IODELAY);
> +	bool status;
> +	int ret;
> +
> +	ret = iio_backend_interface_type_get(st->back, &interface_type);
> +	if (ret)
> +		return ret;
> +
> +	switch (interface_type) {
> +	case IIO_BACKEND_INTERFACE_SERIAL_CMOS:
> +		lane_num = st->info->num_channels;

num_lanes is probably a better name as lane_num sounds like the number
of a particular lane rather than now many there are.

> +		break;
> +	case IIO_BACKEND_INTERFACE_SERIAL_LVDS:
> +		lane_num = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (st->info->resolution == 16) {
> +		ret = iio_backend_data_size_set(st->back, 24);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_PACKET,
> +				   AD4851_TEST_PAT | AD4857_PACKET_SIZE_24);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = iio_backend_data_size_set(st->back, 32);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_PACKET,
> +				   AD4851_TEST_PAT | AD4858_PACKET_SIZE_32);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < st->info->num_channels; i++) {
> +		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_0(i),
> +				   AD4851_TESTPAT_0_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_1(i),
> +				   AD4851_TESTPAT_1_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_2(i),
> +				   AD4851_TESTPAT_2_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_3(i),
> +				   AD4851_TESTPAT_3_DEFAULT(i));
> +		if (ret)
> +			return ret;
> +
> +		ret = iio_backend_chan_enable(st->back, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < lane_num; i++) {
> +		for (delay = 0; delay < AD4851_MAX_IODELAY; delay++) {
> +			ret = iio_backend_iodelay_set(st->back, i, delay);
> +			if (ret)
> +				return ret;

Blank line here is more consistent with surounding code (which looks better
than this block does).

> +			ret = iio_backend_chan_status(st->back, i, &status);
> +			if (ret)
> +				return ret;
> +
> +			if (status)
> +				set_bit(i * AD4851_MAX_IODELAY + delay, pn_status);
> +			else
> +				clear_bit(i * AD4851_MAX_IODELAY + delay, pn_status);
> +		}
> +	}
> +
> +	for (i = 0; i < lane_num; i++) {
> +		status = test_bit(i * AD4851_MAX_IODELAY, pn_status);
> +		c = ad4851_find_opt(&status, AD4851_MAX_IODELAY, &s);
> +		if (c < 0)
> +			return c;
> +
> +		opt_delay = s + c / 2;
> +		ret = iio_backend_iodelay_set(st->back, i, opt_delay);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < st->info->num_channels; i++) {
> +		ret = iio_backend_chan_disable(st->back, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = iio_backend_data_size_set(st->back, 20);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
> +}

> +
> +static int ad4851_set_calibscale(struct ad4851_state *st, int ch, int val,
> +				 int val2)
> +{
> +	u64 gain;
> +	u8 buf[0];

As per my very brief review the other day, 0 length is a problem.

> +	int ret;
> +
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	gain = val * MICRO + val2;
> +	gain = DIV_U64_ROUND_CLOSEST(gain * 32768, MICRO);
> +
> +	put_unaligned_be16(gain, buf);
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch),
> +			   buf[0]);

Don't wrap so early. It fits under 80 chars on oneline.

> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch),
> +			    buf[1]);
> +}

> +
> +static const unsigned int ad4851_scale_table[][2] = {
I'd suggest a structure for each entry. Then you can do
ad4851_scale_table[i].reg_val etc
rather than opaque indexing to 0 or 1.

> +	{ 2500, 0x0 },
> +	{ 5000, 0x1 },
> +	{ 5000, 0x2 },
> +	{ 10000, 0x3 },
> +	{ 6250, 0x04 },
> +	{ 12500, 0x5 },
> +	{ 10000, 0x6 },
> +	{ 20000, 0x7 },
> +	{ 12500, 0x8 },
> +	{ 25000, 0x9 },
> +	{ 20000, 0xA },
> +	{ 40000, 0xB },
> +	{ 25000, 0xC },
> +	{ 50000, 0xD },
> +	{ 40000, 0xE },
> +	{ 80000, 0xF },
> +};
...

> +
> +static int ad4851_get_scale(struct ad4851_state *st,
> +			    const struct iio_chan_spec *chan, int *val,
> +			    int *val2)
> +{
> +	int i, softspan_val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_SOFTSPAN(chan->channel),
> +			  &softspan_val);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_table); i++) {
> +		if (softspan_val == ad4851_scale_table[i][1])

See above - I'd use a structure for the scale_table entries
so this and the [0] below can be named structure elements.

> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(ad4851_scale_table))
> +		return -EIO;
> +
> +	__ad4851_get_scale(st, ad4851_scale_table[i][0], val, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}


> +
> +static int ad4851_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;

struct device *dev = *spi->dev;
will shorten a lot of code in here so probably worth doing.

> +	struct ad4851_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	ret = devm_mutex_init(&spi->dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_bulk_get_enable(&spi->dev,
> +					     ARRAY_SIZE(ad4851_power_supplies),
> +					     ad4851_power_supplies);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to get and enable supplies\n");
> +
> +	ret = devm_regulator_get_enable_optional(&spi->dev, "vddh");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(&spi->dev, ret, "failed to get vddh voltage\n");
You aren't trying to get the voltage, just turn it on.  So update the commit
message to "failed to enable vddh\n"

> +
> +	ret = devm_regulator_get_enable_optional(&spi->dev, "vddl");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(&spi->dev, ret, "failed to get vddl voltage\n");
Same here.
> +
> +	st->vrefbuf = devm_regulator_get_optional(&spi->dev, "vrefbuf");
> +	if (IS_ERR(st->vrefbuf)) {
> +		if (PTR_ERR(st->vrefbuf) != -ENODEV)
> +			return dev_err_probe(&spi->dev, PTR_ERR(st->vrefbuf),
> +					     "Failed to get vrefbuf regulator\n");
> +	}
> +
> +	st->vrefio = devm_regulator_get_optional(&spi->dev, "vrefio");
> +	if (IS_ERR(st->vrefio)) {
> +		if (PTR_ERR(st->vrefio) != -ENODEV)
> +			return dev_err_probe(&spi->dev, PTR_ERR(st->vrefio),
> +					     "Failed to get vrefbuf regulator\n");

wrong regulator in the message.

> +	}
> +
> +	st->pd_gpio = devm_gpiod_get_optional(&spi->dev, "pd", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->pd_gpio))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->pd_gpio),
> +				     "Error on requesting pd GPIO\n");
> +
> +	st->cnv = devm_pwm_get(&spi->dev, NULL);
> +	if (IS_ERR(st->cnv))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->cnv),
> +				     "Error on requesting pwm\n");
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
> +	ret = ad4851_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->channels = st->info->channels;
> +	indio_dev->num_channels = st->info->num_channels;
> +	indio_dev->info = &ad4851_iio_info;

Whilst it's not actively used, current best practice is to set
indio_dev->modes = INDIO_DIRECT_MODE;

> +
> +	st->back = devm_iio_backend_get(&spi->dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(&spi->dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4851_calibrate(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

