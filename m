Return-Path: <linux-pwm+bounces-3643-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C7A99DA8D
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 02:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8024D1C21325
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 00:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8191F191;
	Tue, 15 Oct 2024 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0X0NFE24"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489CBEC5
	for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951149; cv=none; b=ElLJRw8ws8ZihXdxP0AvI3mm/UN386TvtrJ6PYPsB7YBVq3txoAqmHmJJ8UixNtDTTplOvrdewuJIOy00DsVbYLtxaXrrA5CYYflv9HVEUR8uCl9JsLt7lGo9YcVYKzYAMyCQkleeG9tDGBi1Q+1KXXwC+mcsjtWPRrCNAspols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951149; c=relaxed/simple;
	bh=q+OgFmqhk/HJD3GVdmya2ZCFmSEpTmfeM4Ui3XhpTVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JvYQ9YzhmvHiCAR1ZUPNAGtiUNL294+0UmYUEqs+7r74QbhsRunR7QVg4v24HLs+eXynmwuzQ7WWq5BpoO6xEDqFK5qI5KIPIWBpbTtJT+epEj6LHF/dEjt3oY8GhBwH3dlo8ED664wBPA1D9tOoclLVRg5BSEXYN0+aIOYiumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0X0NFE24; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7157c329d93so2327357a34.3
        for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728951145; x=1729555945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2nJK5ypxzPre+b3iZgUs3/o2UAwXiSSl8CirXUM73cg=;
        b=0X0NFE24xO13NwRWEWVkZUBgCjXcSbRTof86LqpGCOL1/oPisu56ditiUGgHwEdXVn
         GKx4pZOjVnZHVXC2hKFy12tiUQk+Ku90AFn9jL6MjgLR7536/uAiROzVs4wngoUGOIUl
         d0A8IYYACn0xyuhyuJC6160bPMxvsxHAGM9oCw2mH9YtWVqTT/EU7HtR7HY/4hyZux95
         pj9hxS4Hihf0BInePdpXZo4vgAPOeSr3cr0+bw7EpzSlu09sLo1t+2OFrdyXppWeh7QG
         g/TLwePIfV58ed4kH6ZnP9fpIHC/1DDimUn2ePNnb6mkmI76G2ukIr4hJe4O1lhl0Y6d
         nkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728951145; x=1729555945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nJK5ypxzPre+b3iZgUs3/o2UAwXiSSl8CirXUM73cg=;
        b=kbUiIsbEf/yL03OS6V4lIPyx3dHlsodFpbqdHzJUfszhLh+wiHXM/XA3fTfCa5OtU6
         m5V6GAQYLjKmUj2YEOnoxtdtbgNbV3ocqz3lQBY8MqVsAWw3GyH4xD5KbNrr6tQb5w9K
         Pb5FlzE18HsMmkkSlPDDMGqX2oqscv7+xiP9BHEc+Fb3z55kA+K6fxYq83rDE3lEZICt
         VgBK9EIVqT5FLNQ9MutrxQoZznwd1orjX4bMqhKCqvWKZekxR3GN+DQz4OOtYiYaGlDk
         gb6UgO333PG4vfMVk0HGpUg5622UQm2fPHoeh3d/EaOQqmveJy5hw87NN+S8BvlQNsqz
         Ic7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO2+ltad4lY1+fc1BFrfPKF2B1ImvY0fHP5lMh0k+j7+GRTwGV5VNpiI2dPHybsotXGj66To3VRw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypnOsKJaja8NpDv79NnjGKjZYKEeEYuLMU4Z960nIZ5jdxe4Ly
	Cp5MonNKr/blB73rlT58DIXalGHzi2QRY5wiGzUUp7Kw5EcIVvG+if+8Mf4XGls=
X-Google-Smtp-Source: AGHT+IFUmS4kVr2Pv7oFj7W8MKvd6iijlrriku8hfRtZ9uKSfBSxmXMv7Q8VVGLYVLbT+xWg7qohAQ==
X-Received: by 2002:a05:6830:2b0f:b0:716:a7fc:20b1 with SMTP id 46e09a7af769-717d63eb003mr8735657a34.6.1728951145153;
        Mon, 14 Oct 2024 17:12:25 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717fba4196csm82237a34.77.2024.10.14.17.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 17:12:23 -0700 (PDT)
Message-ID: <60452f83-28a1-4a80-8e90-1f1ed32a594e@baylibre.com>
Date: Mon, 14 Oct 2024 19:12:22 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-6-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241014094154.9439-6-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 4:40 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static int ad4851_set_sampling_freq(struct ad4851_state *st, unsigned int freq)
> +{
> +	struct pwm_state cnv_state = {
> +		.duty_cycle = AD4851_T_CNVH_NS,

PWM drivers typically round down, so this mimimum required
high time may not be met if pwm_apply cannot make an exact
match.

> +		.enabled = true,
> +	};
> +	int ret;
> +
> +	freq = clamp(freq, 1, st->info->throughput);
> +
> +	cnv_state.period = DIV_ROUND_CLOSEST_ULL(GIGA, freq);

As Uwe mentioned in v2, ROUND_CLOSEST doesn't seem like the
best choice here.

And usually we use NSEC_PER_SEC for this instead of GIGA.

> +
> +	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
> +	if (ret)
> +		return ret;

pwm_get_state_hw() is currently not public. But it would be nice
to make it public and use it here to assign st->sampling_freq to
the actual frequency the hardware is capable of instead of the
requested frequency. This way users can read back the sampling
frequency attribute to know what the real sample rate is in case
the exact requested rate was not possible.

> +
> +	st->sampling_freq = freq;
> +
> +	return 0;
> +}
> +

...

> +static int ad4851_set_oversampling_ratio(struct ad4851_state *st,
> +					 const struct iio_chan_spec *chan,
> +					 unsigned int osr)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (osr == 1) {
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_EN_MSK, 0);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_EN_MSK, AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;

regmap_clear_bits() and regmap_set_bits() would make this a bit
less verbose and consistent with the effort started in [1].

[1]: https://lore.kernel.org/linux-iio/20240617-review-v3-0-88d1338c4cca@baylibre.com/


> +
> +		val = ad4851_osr_to_regval(osr);
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_RATIO_MSK, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	switch (chan->scan_type.realbits) {
> +	case 20:
> +		switch (osr) {
> +		case 1:
> +			val = 20;
> +			break;
> +		default:
> +			val = 24;
> +			break;
> +		}
> +		break;
> +	case 16:
> +		val = 16;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = iio_backend_data_size_set(st->back, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> +				  AD4851_PACKET_FORMAT_MASK, (osr == 1) ? 0 : 1);
> +}
> +
> +static int ad4851_get_oversampling_ratio(struct ad4851_state *st, unsigned int *val)
> +{
> +	unsigned int osr;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_OVERSAMPLE, &osr);
> +	if (ret)
> +		return ret;
> +
> +	if (!FIELD_GET(AD4851_OS_EN_MSK, osr))
> +		*val = 1;
> +	else
> +		*val = ad4851_oversampling_ratios[FIELD_GET(AD4851_OS_RATIO_MSK, osr)];

Why is 1 not in the table?

> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4851_setup(struct ad4851_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +

Would be nice to do a hard reset here if possible using st->pd_gpio
(datasheet says to cycle this twice and then wait 1 ms).

> +	ret = ad4851_set_sampling_freq(st, HZ_PER_MHZ);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +			   AD4851_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_B,
> +			   AD4851_SINGLE_INSTRUCTION);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +			   AD4851_SDO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_PRODUCT_ID_L, &product_id);
> +	if (ret)
> +		return ret;
> +
> +	if (product_id != st->info->product_id)
> +		dev_info(&st->spi->dev, "Unknown product ID: 0x%02X\n",
> +			 product_id);
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_DEVICE_CTRL,
> +			   AD4851_ECHO_CLOCK_MODE);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
> +}
> +

...

> +
> +static int ad4851_set_calibscale(struct ad4851_state *st, int ch, int val,
> +				 int val2)
> +{
> +	unsigned long long gain;

	u64

> +	u8 buf[0];
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
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch),
> +			    buf[1]);
> +}
> +

...

> +
> +static int ad4851_set_offset(struct ad4851_state *st,
> +			     const struct iio_chan_spec *chan, int val)
> +{
> +	guard(mutex)(&st->lock);
> +
> +	if (val != st->offsets[chan->channel])
> +		return 0;
> +
> +	st->offsets[chan->channel] = val;
> +	/* Restore to the default range if offset changes */
> +	if (st->offsets[chan->channel])
> +		return regmap_write(st->regmap,
> +					AD4851_REG_CHX_SOFTSPAN(chan->channel),
> +					AD4851_SOFTSPAN_N40V_40V);
> +	return regmap_write(st->regmap,
> +				AD4851_REG_CHX_SOFTSPAN(chan->channel),
> +				AD4851_SOFTSPAN_0V_40V);

Pretty sure I mentioned this in a previous review...

I don't see how changing the softspan affects the offset. A raw value
of 0 is still 0V either way.

It should only affect the scale and signed vs. unsigned data.

> +}
> +

...

> +
> +#define AD4851_IIO_CHANNEL(index, real, storage)			\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
> +		BIT(IIO_CHAN_INFO_SCALE) |				\
> +		BIT(IIO_CHAN_INFO_OFFSET),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	.info_mask_shared_by_type_available =				\
> +		BIT(IIO_CHAN_INFO_SCALE) |				\
> +		BIT(IIO_CHAN_INFO_OFFSET) |				\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	.indexed = 1,							\
> +	.channel = index,						\

These chips are fully differential, so I would expect:

	.differential = 1,
	.channel = 2 * index,
	.channel2 = 2 * index + 1,

Or alternatly, if we use the devicetree to specify the type of input
attached, (differential or signle-ended) then this would be dynamically
configured.

> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = real,					\
> +		.storagebits = storage,					\

Since enabling oversampling can change realbits, this driver will likely
need to implement scan_type_ext so that userspace is aware of the
difference when oversampling is enabled. (Adding support for oversampling
could always be a followup patch instead of trying to do everything
all at once.)

See the ad7380 driver as an example of how to impelemt this. [2]

[2]: https://lore.kernel.org/linux-iio/20240530-iio-add-support-for-multiple-scan-types-v3-5-cbc4acea2cfa@baylibre.com/

Also, I would expect the .sign value to depend on how the
input is being used. If it is differential or single-ended
bipolar, then it is signed, but if it is signle-ended unipoloar
then it is unsiged.

Typically, this is coming from the devicetree because it
depends on what is wired up to the input.

> +	},								\
> +}

...

> +static int ad4851_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
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
> +
> +	ret = devm_regulator_get_enable_optional(&spi->dev, "vddl");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(&spi->dev, ret, "failed to get vddl voltage\n");
> +
> +	ret = devm_regulator_get_enable_optional(&spi->dev, "vrefbuf");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(&spi->dev, ret, "failed to get vrefbuf voltage\n");

According to the datasheet, if there is a supply cconnected to the
REFBUF pin, then "Disable the internal band-gap reference and the
internal reference buffer through the DEVICE_CTRL register in this
configuration and connect the REFIO pin to the GND pins."

So we probably shoudn't be enabling this supply until after
configuring the registers.

> +
> +	ret = devm_regulator_get_enable_optional(&spi->dev, "vddl");

Should be "vrefio", not vddl".

> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(&spi->dev, ret, "failed to get vrefio voltage\n");

We need to keep track if this supply is present or not and set
REF_SEL in the DEVICE_CTRL register accordingly.

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
> +	ret = ad4851_scale_offset_fill(st);
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
> +
> +static const struct of_device_id ad4851_of_match[] = {
> +	{ .compatible = "adi,ad4858", .data = &ad4851_info, },
> +	{ .compatible = "adi,ad4857", .data = &ad4852_info, },
> +	{ .compatible = "adi,ad4856", .data = &ad4853_info, },
> +	{ .compatible = "adi,ad4855", .data = &ad4854_info, },
> +	{ .compatible = "adi,ad4854", .data = &ad4855_info, },
> +	{ .compatible = "adi,ad4853", .data = &ad4856_info, },
> +	{ .compatible = "adi,ad4852", .data = &ad4857_info, },
> +	{ .compatible = "adi,ad4851", .data = &ad4858_info, },
> +	{ .compatible = "adi,ad4858i", .data = &ad4858i_info, },
> +	{}

As requested in previous reviews, { } is preferred to be consistent.

And more importantly, it looks like compatible strings are in
reverse order compared to info structs.

> +};
> +


