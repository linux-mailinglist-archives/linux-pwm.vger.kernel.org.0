Return-Path: <linux-pwm+bounces-4004-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A49B9832
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 20:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC2C1C211DE
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 19:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CE21CEEAC;
	Fri,  1 Nov 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z7/MlNtI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4101CEE8C
	for <linux-pwm@vger.kernel.org>; Fri,  1 Nov 2024 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488452; cv=none; b=A4AimBnjj2aIgAVTG++WL6TWXCn8S5PaIGHwqEzr2Gy9hK8A3j3lLI+a7le6shZdptmjjO8zLUTpPhdZj81RrXzv7b5NLJbMm/cOfu/drGtGclh6X5Md6HGvt9pX6TcFGG/NPaphzHB4D+Wvh+MiMjWUkmF+mWGVTPwA9ADEkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488452; c=relaxed/simple;
	bh=pDjNsj/uR7KWktZ/8xtR6Ld0FW5X4bVw0siPw90LdWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a6nhX3MSrD/uCeNm/f/7X8vAjVdsM+ojsGZGGG5iht/uSI59RKkQpvfgbl2Q0RmLKxjerkjNvMX8AwDTvF9FZtnVljkj98W+4Ps6+wYqrW2OGIHhvEqwRZ99Bw7CvLMRV3YJXmrqKznvRYYVTVsPplvTrWpi8Q2d1mwQfmYMJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z7/MlNtI; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7187e0041d5so1356284a34.2
        for <linux-pwm@vger.kernel.org>; Fri, 01 Nov 2024 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730488447; x=1731093247; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8sAyjZ/oJIDMWwj3k2UpnrT9F8051F+7CYH0edY0xX0=;
        b=z7/MlNtIrKKNWKnZ1cTFWBCesBW3JWjs6FWIb15cHHaC9dYFV8AUxhKL+lvS/vEe/B
         1HBfgiHOcdaAKXtXJUdiAGw2cLhpAl3V7PtTv2ctftD1p9oAKsZj6elDM8wJDeKvnoiS
         SVPDVNt5TYsMgUA7cZ5olyZs11BE6y+oL6UWtC5qbNsDCsjWB1wkHCWycqpLWoFQc2uO
         5PYiMIqRC2TbrjchTF4gym05pw6CTMmZSQeOy73uvy0+HNx7TJ3qNfvhsr0TsXgIC+Iq
         NvCgb8tqOEvPddwtyX9xrV2Cd48xX0gjciQPYZocDbJZ0xLMClhsbexPkbvco023VMwX
         V8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488447; x=1731093247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sAyjZ/oJIDMWwj3k2UpnrT9F8051F+7CYH0edY0xX0=;
        b=L08XZTn3O5KWy2Ar/BW5lqafCle62fEXo7vvV7GCJ0l+uQX8oTbv5rp5MXbSW/cnyh
         EwerqUg0y0+zaliH1CJ/Cq2U1H9HJylzsnBd1GhMt38+ywJlNjccEzXZwxOmzV/HbEss
         0nQqFfwPCWULvjEm+qKhvoWLsjsj1aiEFbRHTe6Bj/xOJ16tNvqrSElDeYL646h0btvS
         LlyhzjMDonxYaL/SEt1hoCK+ODMPL7lDKFwudj3DzAKnM8FPj6NYanvP+3NELXb5/mmh
         JB1fawZpzA257fUUyBbfzMZBVOsEL5aX4N7yLE85Odsdk/FdsPiErqtzvW3a31WRaCRE
         Vo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiYM0zlQuhuX0zHT6yXzSk9eJyvjM62VjjFGziE4Y0nLPIAFUADviYKmUG0vgaIbTnBI4ncON87TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrR+maj7/k/Hqx6rfFsIH6inIfI0SrH8Z8ltkapKW8hVp1zbX
	mIi+wfkyYugudP7rA+KnRD+fGukE/+eSDh/LirzZAmDrd+9Co7NTzjdSxvBkiWcYZWi5Z+wS3Jh
	T
X-Google-Smtp-Source: AGHT+IFqwvnqX16z+k2sof4ZL0KXV5SgaqEWhYWjrhVJarMDTAY2reH7+pgp1cHJhT2FxuAUA2qkQA==
X-Received: by 2002:a05:6830:2b08:b0:718:1cb6:e593 with SMTP id 46e09a7af769-7189b5584damr8041731a34.27.1730488446967;
        Fri, 01 Nov 2024 12:14:06 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc59c92sm838098a34.10.2024.11.01.12.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 12:14:06 -0700 (PDT)
Message-ID: <de120709-b60b-4e85-912e-b60ca18a8001@baylibre.com>
Date: Fri, 1 Nov 2024 14:14:04 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
 <20241101112358.22996-7-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241101112358.22996-7-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 6:23 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

This is looking better. But I think what we really need is a
through test plan to test all of the combinations of different
states since so many attributes interact with each other.

> changes in v5:
>  - use linux/unaligned.h
>  - drop redundant masks for reg_val
>  - use regmap_clear_bits/regmap_set_bits where applicable.
>  - add hard reset sequence via pd_gpio
>  - use scan_type_ext and implement resolution normal/boost.
>  - drop offset, implement differential channels and handle scale based on the
>    channel type.
>  drivers/iio/adc/Kconfig  |   13 +
>  drivers/iio/adc/Makefile |    1 +
>  drivers/iio/adc/ad4851.c | 1179 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1193 insertions(+)
>  create mode 100644 drivers/iio/adc/ad4851.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6c4e74420fd2..0d97cd760d90 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -61,6 +61,19 @@ config AD4695
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4695.
>  
> +config AD4851
> +	tristate "Analog Device AD4851 DAS Driver"
> +	depends on SPI
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD4851, AD4852,
> +	  AD4853, AD4854, AD4855, AD4856, AD4857, AD4858, AD4858I high speed
> +	  data acquisition system (DAS).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad4851.
> +
>  config AD7091R
>  	tristate
>  
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 7b91cd98c0e0..d83df8b5925d 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD4000) += ad4000.o
>  obj-$(CONFIG_AD4130) += ad4130.o
>  obj-$(CONFIG_AD4695) += ad4695.o
> +obj-$(CONFIG_AD4851) += ad4851.o
>  obj-$(CONFIG_AD7091R) += ad7091r-base.o
>  obj-$(CONFIG_AD7091R5) += ad7091r5.o
>  obj-$(CONFIG_AD7091R8) += ad7091r8.o
> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..0ef8ea0d2fc2
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c
> @@ -0,0 +1,1179 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4851 DAS driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +
> +#define AD4851_REG_INTERFACE_CONFIG_A	0x00
> +#define AD4851_REG_INTERFACE_CONFIG_B	0x01
> +#define AD4851_REG_PRODUCT_ID_L		0x04
> +#define AD4851_REG_PRODUCT_ID_H		0x05
> +#define AD4851_REG_DEVICE_CTRL		0x25
> +#define AD4851_REG_PACKET		0x26
> +#define AD4851_REG_OVERSAMPLE		0x27
> +
> +#define AD4851_REG_CH_CONFIG_BASE	0x2A
> +#define AD4851_REG_CHX_SOFTSPAN(ch)	((0x12 * (ch)) + AD4851_REG_CH_CONFIG_BASE)
> +#define AD4851_REG_CHX_OFFSET(ch)	(AD4851_REG_CHX_SOFTSPAN(ch) + 0x01)
> +#define AD4851_REG_CHX_OFFSET_LSB(ch)	AD4851_REG_CHX_OFFSET(ch)
> +#define AD4851_REG_CHX_OFFSET_MID(ch)	(AD4851_REG_CHX_OFFSET_LSB(ch) + 0x01)
> +#define AD4851_REG_CHX_OFFSET_MSB(ch)	(AD4851_REG_CHX_OFFSET_MID(ch) + 0x01)
> +#define AD4851_REG_CHX_GAIN(ch)		(AD4851_REG_CHX_OFFSET(ch) + 0x03)
> +#define AD4851_REG_CHX_GAIN_LSB(ch)	AD4851_REG_CHX_GAIN(ch)
> +#define AD4851_REG_CHX_GAIN_MSB(ch)	(AD4851_REG_CHX_GAIN(ch) + 0x01)
> +#define AD4851_REG_CHX_PHASE(ch)	(AD4851_REG_CHX_GAIN(ch) + 0x02)
> +#define AD4851_REG_CHX_PHASE_LSB(ch)	AD4851_REG_CHX_PHASE(ch)
> +#define AD4851_REG_CHX_PHASE_MSB(ch)	(AD4851_REG_CHX_PHASE_LSB(ch) + 0x01)
> +
> +#define AD4851_REG_TESTPAT_0(c)		(0x38 + (c) * 0x12)
> +#define AD4851_REG_TESTPAT_1(c)		(0x39 + (c) * 0x12)
> +#define AD4851_REG_TESTPAT_2(c)		(0x3A + (c) * 0x12)
> +#define AD4851_REG_TESTPAT_3(c)		(0x3B + (c) * 0x12)
> +
> +#define AD4851_SW_RESET			(BIT(7) | BIT(0))
> +#define AD4851_SDO_ENABLE		BIT(4)
> +#define AD4851_SINGLE_INSTRUCTION	BIT(7)
> +#define AD4851_REFBUF_PD		BIT(2)
> +#define AD4851_REFSEL_PD		BIT(1)
> +#define AD4851_ECHO_CLOCK_MODE		BIT(0)
> +
> +#define AD4851_PACKET_FORMAT_0		0
> +#define AD4851_PACKET_FORMAT_1		1
> +#define AD4851_PACKET_FORMAT_MASK	GENMASK(1, 0)
> +
> +#define AD4851_OS_EN_MSK		BIT(7)
> +#define AD4851_OS_RATIO_MSK		GENMASK(3, 0)
> +
> +#define AD4851_TEST_PAT			BIT(2)
> +
> +#define AD4858_PACKET_SIZE_20		0
> +#define AD4858_PACKET_SIZE_24		1
> +#define AD4858_PACKET_SIZE_32		2
> +
> +#define AD4857_PACKET_SIZE_16		0
> +#define AD4857_PACKET_SIZE_24		1
> +
> +#define AD4851_TESTPAT_0_DEFAULT	0x2A
> +#define AD4851_TESTPAT_1_DEFAULT	0x3C
> +#define AD4851_TESTPAT_2_DEFAULT	0xCE
> +#define AD4851_TESTPAT_3_DEFAULT(c)	(0x0A + (0x10 * (c)))
> +
> +#define AD4851_SOFTSPAN_0V_2V5		0
> +#define AD4851_SOFTSPAN_N2V5_2V5	1
> +#define AD4851_SOFTSPAN_0V_5V		2
> +#define AD4851_SOFTSPAN_N5V_5V		3
> +#define AD4851_SOFTSPAN_0V_6V25		4
> +#define AD4851_SOFTSPAN_N6V25_6V25	5
> +#define AD4851_SOFTSPAN_0V_10V		6
> +#define AD4851_SOFTSPAN_N10V_10V	7
> +#define AD4851_SOFTSPAN_0V_12V5		8
> +#define AD4851_SOFTSPAN_N12V5_12V5	9
> +#define AD4851_SOFTSPAN_0V_20V		10
> +#define AD4851_SOFTSPAN_N20V_20V	11
> +#define AD4851_SOFTSPAN_0V_25V		12
> +#define AD4851_SOFTSPAN_N25V_25V	13
> +#define AD4851_SOFTSPAN_0V_40V		14
> +#define AD4851_SOFTSPAN_N40V_40V	15
> +
> +#define AD4851_MAX_LANES		8
> +#define AD4851_MAX_IODELAY		32
> +
> +#define AD4851_T_CNVH_NS		40
> +
> +struct ad4851_chip_info {
> +	const char *name;
> +	unsigned int product_id;
> +	const unsigned int (*scale_table)[2];
> +	int num_scales;
> +	const int *offset_table;
> +	int num_offset;

Looks like some leftover offset members here that are no longer used.

> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;

Also looks like these two are unused.

> +	unsigned long throughput;
> +	unsigned int resolution;
> +};
> +
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
> +	int *offsets;

Also unused.

> +};
> +
> +static int ad4851_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);

	guard(mutex)(&st->lock);

> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int ad4851_set_sampling_freq(struct ad4851_state *st, unsigned int freq)
> +{
> +	struct pwm_state cnv_state = {
> +		.duty_cycle = AD4851_T_CNVH_NS,
> +		.enabled = true,
> +	};
> +	int ret;
> +
> +	freq = clamp(freq, 1, st->info->throughput);
> +
> +	cnv_state.period = DIV_ROUND_DOWN_ULL(NSEC_PER_SEC, freq);

DIV_ROUND_UP_ULL

> +
> +	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
> +	if (ret)
> +		return ret;
> +
> +	st->sampling_freq = freq;
> +
> +	return 0;
> +}
> +
> +static const int ad4851_oversampling_ratios[] = {
> +	1, 2, 4, 8, 16,	32, 64, 128,
> +	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> +	65536,
> +};
> +
> +static int ad4851_osr_to_regval(int ratio)
> +{
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(ad4851_oversampling_ratios); i++)
> +		if (ratio == ad4851_oversampling_ratios[i])
> +			return i - 1;
> +
> +	return -EINVAL;
> +}
> +
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
> +		ret = regmap_clear_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +				      AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		val = ad4851_osr_to_regval(osr);
> +		if (val < 0)
> +			return -EINVAL;

We should check this before setting AD4851_REG_OVERSAMPLE, otherwise
we could end up in an invalid state if we return error here. And
we could combine the two register writes into a single call since
it is the same register.

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
> +		case 0:
> +			return -EINVAL;
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
> +	if (osr == 1) {
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> +					 AD4851_PACKET_FORMAT_MASK, 0);

regmap_clear_bits()

> +		if (ret)
> +			return ret;
> +
> +		st->resolution_boost_enabled = false;
> +	} else {
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> +					 AD4851_PACKET_FORMAT_MASK, 1);

regmap_set_bits()

> +		if (ret)
> +			return ret;
> +
> +		st->resolution_boost_enabled = true;

Technically speaking, 16-bit chips don't have resolution boost. And
selecting PACKET_FORMAT = 1 here would enable extra status bits that
we aren't using. I don't think that is what we want.

> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4851_get_oversampling_ratio(struct ad4851_state *st, unsigned int *val)
> +{
> +	unsigned int osr;
> +	int ret;

	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_OVERSAMPLE, &osr);
> +	if (ret)
> +		return ret;
> +
> +	if (!FIELD_GET(AD4851_OS_EN_MSK, osr))
> +		*val = 1;
> +	else
> +		*val = ad4851_oversampling_ratios[FIELD_GET(AD4851_OS_RATIO_MSK, osr)];
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static void ad4851_reg_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static int ad4851_setup(struct ad4851_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +
> +	if (st->pd_gpio) {
> +		gpiod_set_value(st->pd_gpio, GPIOD_OUT_HIGH);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, GPIOD_OUT_LOW);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, GPIOD_OUT_HIGH);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, GPIOD_OUT_LOW);

The GPIOD_OUT_* macros are not valid here. Just use 0 and 1.
Also, we can use gpiod_set_value_cansleep() here.

> +		fsleep(1000);
> +	}
> +
> +	if (!IS_ERR(st->vrefbuf)) {
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +					 AD4851_REFBUF_PD, AD4851_REFBUF_PD);

Can be simplified to regmap_set_bits().

> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_enable(st->vrefbuf);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&st->spi->dev, ad4851_reg_disable,
> +					       st->vrefbuf);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (!IS_ERR(st->vrefio)) {
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +					 AD4851_REFSEL_PD, AD4851_REFSEL_PD);

Can be simplified to regmap_set_bits().


> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_enable(st->vrefio);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&st->spi->dev, ad4851_reg_disable,
> +					       st->vrefio);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ad4851_set_sampling_freq(st, HZ_PER_MHZ);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +			   AD4851_SW_RESET);
> +	if (ret)
> +		return ret;

Probably need a time delay after reset. Also we should not need to
call this if we were able to reset using the PD gpio since the chip
was already reset.

Also, also, this needs to be moved before other register writes
above, otherwise it will reset those registers.

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

This one also needs to be done before any regmap reads (including
update_bits, set_bits, clear_bits that implicitly read).

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

Doing regmap_write here will set all other bits to 0, which will
clear previous config done above. Should be regmap_set_bits().

Other regmap_write() calls seem OK, but it's always nice to have a
comment explaining why it is OK, otherwise it looks suspicios, like
it could be hiding a bug like we have here.

> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
> +}
> +
> +static int ad4851_find_opt(bool *field, u32 size, u32 *ret_start)
> +{
> +	unsigned int i, cnt = 0, max_cnt = 0, max_start = 0;
> +	int start;
> +
> +	for (i = 0, start = -1; i < size; i++) {
> +		if (field[i] == 0) {
> +			if (start == -1)
> +				start = i;
> +			cnt++;
> +		} else {
> +			if (cnt > max_cnt) {
> +				max_cnt = cnt;
> +				max_start = start;
> +			}
> +			start = -1;
> +			cnt = 0;
> +		}
> +	}
> +	/*
> +	 * Find the longest consecutive sequence of false values from field
> +	 * and return starting index.
> +	 */
> +	if (cnt > max_cnt) {
> +		max_cnt = cnt;
> +		max_start = start;
> +	}
> +
> +	if (!max_cnt)
> +		return -ENOENT;
> +
> +	*ret_start = max_start;
> +
> +	return max_cnt;
> +}
> +
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
> +		break;
> +	case IIO_BACKEND_INTERFACE_SERIAL_LVDS:
> +		lane_num = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}> +
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
> +static int ad4851_get_calibscale(struct ad4851_state *st, int ch, int *val, int *val2)
> +{
> +	unsigned int reg_val;
> +	int gain;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch),
> +			  &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain = reg_val << 8;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch),
> +			  &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain |= reg_val;
> +
> +	*val = gain;
> +	*val2 = 32768;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int ad4851_set_calibscale(struct ad4851_state *st, int ch, int val,
> +				 int val2)
> +{
> +	u64 gain;
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

I'm pretty sure that calibscale and calibbias also need to take into
account if resolution boost is enabled or not.

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
> +}
> +

nit: a comment mentioning this is mapping voltage ranges to register
values would be helpful

> +static const unsigned int ad4851_scale_table[][2] = {
> +	{ 2500, 0x0 },
> +	{ 5000, 0x1 },
> +	{ 5000, 0x2 },
> +	{ 10000, 0x3 },
> +	{ 6250, 0x04 },

nit: drop the extra 0

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

I'm not sure how this table is supposed to work since there are
multiple entries with the same voltage value. Probably better
would be to just have the entries for the unipolar/unsigned ranges.
Then if applying this to a differential/signed channel, just add
1 to resulting register value before writing it to the register.
Or make two different tables, one for unsigned and one for signed
channels.

> +
> +static const int ad4857_offset_table[] = {
> +	0, -32768,
> +};
> +
> +static const int ad4858_offset_table[] = {
> +	0, -524288,
> +};

These are no longer used.

> +
> +static const unsigned int ad4851_scale_avail[] = {
> +	2500, 5000,
> +	10000, 6250,
> +	12500, 20000,
> +	25000, 40000,
> +	50000, 80000,
> +};

This should only go up to 40000. Or we need two different tables, one
for signed channels and one for unsigned channels. Although it would
probably be simpler to just multiply values from this table by 2 if
.differential = 1 rather than having a second table.

> +
> +static void __ad4851_get_scale(struct ad4851_state *st, int scale_tbl,
> +			       unsigned int *val, unsigned int *val2)
> +{
> +	const struct ad4851_chip_info *info = st->info;
> +	const struct iio_chan_spec *chan = &info->channels[0];
> +	unsigned int tmp;
> +
> +	tmp = ((unsigned long long)scale_tbl * MICRO) >> chan->scan_type.realbits;
> +	*val = tmp / MICRO;
> +	*val2 = tmp % MICRO;
> +}
> +
> +static int ad4851_set_scale(struct ad4851_state *st,
> +			    const struct iio_chan_spec *chan, int val, int val2)
> +{
> +	unsigned int scale_val[2];
> +	unsigned int i;
> +	bool single_ended = false;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_table); i++) {
> +		__ad4851_get_scale(st, ad4851_scale_table[i][0],
> +				   &scale_val[0], &scale_val[1]);
> +		if (scale_val[0] != val || scale_val[1] != val2)
> +			continue;
> +
> +		/*
> +		 * Adjust the softspan value (differential or single ended)
> +		 * based on the scale value selected channel type.
> +		 *
> +		 * If the channel is not differential then continue iterations
> +		 * until the next matching scale value which always corresponds
> +		 * to the single ended mode.
> +		 */
> +		if (!chan->differential && !single_ended) {
> +			single_ended = true;
> +			continue;
> +		}
> +
> +		return regmap_write(st->regmap,
> +				    AD4851_REG_CHX_SOFTSPAN(chan->channel),
> +				    ad4851_scale_table[i][1]);

Since we don't know if we are using single-ended or differential
until we actually read data, we should not be setting the softspan
register here. Instead, we should just save the selected scale
to st->scale. Then when we do a buffered read, we can set the
softspan correctly for each channel depending on which one is
enabled.

> +	}
> +
> +	return -EINVAL;
> +}
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

As above, we can just return the value save in st->scale instead of
reading the register.

> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_table); i++) {
> +		if (softspan_val == ad4851_scale_table[i][1])
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(ad4851_scale_table))
> +		return -EIO;
> +
> +	__ad4851_get_scale(st, ad4851_scale_table[i][0], val, val2);

If resolution boost is in effect because of oversampling, we need
to take that into account here as well.

> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int ad4851_scale_fill(struct ad4851_state *st)
> +{
> +	unsigned int i, val1, val2;
> +
> +	st->scales = devm_kmalloc_array(&st->spi->dev, ARRAY_SIZE(ad4851_scale_avail),
> +					sizeof(*st->scales), GFP_KERNEL);
> +	if (!st->scales)
> +		return -ENOMEM;

It looks like this is a fixed size, so we could just include that
size in struct ad4851_state instead of doing a kmalloc here.

> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_avail); i++) {
> +		__ad4851_get_scale(st, ad4851_scale_avail[i], &val1, &val2);
> +		st->scales[i][0] = val1;
> +		st->scales[i][1] = val2;
> +	}

Maybe simpler to make st->scales a 1-dimintional array and just
store the index of the values in ad4851_scale_avail instead of
copying the values? 

> +
> +	return 0;
> +}
> +
> +static int ad4851_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->sampling_freq;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_get_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_get_scale(st, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4851_get_calibbias(st, chan->channel, val);
> +		return IIO_VAL_INT;

Unreachable return.

> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4851_get_oversampling_ratio(st, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4851_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4851_set_sampling_freq(st, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_set_scale(st, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_set_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4851_set_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4851_set_oversampling_ratio(st, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4851_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	unsigned int c;
> +	int ret;
> +

This is where we should also write the SoftSpan register to ensure
the correct unipolar or bipolar range is selected depending on
which channels are enabled.

Also, we will need to check here and return error if both the
single-ended and differential channel for any physical input
is enabled.

> +	for (c = 0; c < st->info->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4851_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (const int *)st->scales;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		/* Values are stored in a 2D matrix */
> +		*length = ARRAY_SIZE(ad4851_scale_avail) * 2;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = ad4851_oversampling_ratios;
> +		*length = ARRAY_SIZE(ad4851_oversampling_ratios);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_scan_type ad4851_scan_type_16[] = {
> +	[AD4851_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.realbits = 16,
> +		.storagebits = 16,

Is storagebits really 16 here? The HDL engineers mentioned that on
other projects, they were trying to standardize on 32-bit storage
size everywhere, even when data is <= 16 bit.

> +	},
> +	[AD4851_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 's',
> +		.realbits = 16,
> +		.storagebits = 16,
> +	},
> +};

NORMAL and RESOLUTION_BOOST are the same on 16-bit chips, so we
don't actually need to implement ext_scan_type for those chips.

> +
> +static const struct iio_scan_type ad4851_scan_type_20[] = {
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

The single-ended channels (differential = 0) have unsigned data, so we
will need different structs to handle that case.

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
> +#define AD4851_IIO_CHANNEL(index, diff, real)				\

nit: "bits" would make more sense to me than "real"

> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
> +		BIT(IIO_CHAN_INFO_SCALE),				\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	.info_mask_shared_by_type_available =				\
> +		BIT(IIO_CHAN_INFO_SCALE) |				\

Scale needs to be info_mask_separate_available to match IIO_CHAN_INFO_SCALE
flag on info_mask_separate.

> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
> +	.indexed = 1,							\
> +	.differential = diff,						\
> +	.channel = index,						\
> +	.channel2 = index + diff * 8,					\
> +	.scan_index = index + diff * 8,					\
> +	.ext_scan_type = ad4851_scan_type_##real,			\
> +	.num_ext_scan_type =						\
> +		ARRAY_SIZE(ad4851_scan_type_##real),		\
> +}
> +
> +static const struct iio_chan_spec ad4858_channels[] = {
> +	AD4851_IIO_CHANNEL(0, 0, 20),
> +	AD4851_IIO_CHANNEL(1, 0, 20),
> +	AD4851_IIO_CHANNEL(2, 0, 20),
> +	AD4851_IIO_CHANNEL(3, 0, 20),
> +	AD4851_IIO_CHANNEL(4, 0, 20),
> +	AD4851_IIO_CHANNEL(5, 0, 20),
> +	AD4851_IIO_CHANNEL(6, 0, 20),
> +	AD4851_IIO_CHANNEL(7, 0, 20),
> +	AD4851_IIO_CHANNEL(0, 1, 20),
> +	AD4851_IIO_CHANNEL(1, 1, 20),
> +	AD4851_IIO_CHANNEL(2, 1, 20),
> +	AD4851_IIO_CHANNEL(3, 1, 20),
> +	AD4851_IIO_CHANNEL(4, 1, 20),
> +	AD4851_IIO_CHANNEL(5, 1, 20),
> +	AD4851_IIO_CHANNEL(6, 1, 20),
> +	AD4851_IIO_CHANNEL(7, 1, 20),
> +};
> +
> +static const struct iio_chan_spec ad4857_channels[] = {
> +	AD4851_IIO_CHANNEL(0, 0, 16),
> +	AD4851_IIO_CHANNEL(1, 0, 16),
> +	AD4851_IIO_CHANNEL(2, 0, 16),
> +	AD4851_IIO_CHANNEL(3, 0, 16),
> +	AD4851_IIO_CHANNEL(4, 0, 16),
> +	AD4851_IIO_CHANNEL(5, 0, 16),
> +	AD4851_IIO_CHANNEL(6, 0, 16),
> +	AD4851_IIO_CHANNEL(7, 0, 16),
> +	AD4851_IIO_CHANNEL(0, 1, 16),
> +	AD4851_IIO_CHANNEL(1, 1, 16),
> +	AD4851_IIO_CHANNEL(2, 1, 16),
> +	AD4851_IIO_CHANNEL(3, 1, 16),
> +	AD4851_IIO_CHANNEL(4, 1, 16),
> +	AD4851_IIO_CHANNEL(5, 1, 16),
> +	AD4851_IIO_CHANNEL(6, 1, 16),
> +	AD4851_IIO_CHANNEL(7, 1, 16),
> +};

I don't think it is valid for two channels to have the same scan_index.
And since this is simultaneous sampling and we don't have control over
the order in which the data is received from the backend, to get the
ordering correct, we will likely have to make this:

#define AD4851_IIO_CHANNEL(scan_index, channel, diff, bits) \
...

	AD4851_IIO_CHANNEL(0, 0, 0, 16),
	AD4851_IIO_CHANNEL(1, 0, 1, 16),
	AD4851_IIO_CHANNEL(2, 1, 0, 16),
	AD4851_IIO_CHANNEL(3, 1, 1, 16),
	AD4851_IIO_CHANNEL(4, 2, 0, 16),
	AD4851_IIO_CHANNEL(5, 2, 1, 16),
	AD4851_IIO_CHANNEL(6, 3, 0, 16),
	AD4851_IIO_CHANNEL(7, 3, 1, 16),
	AD4851_IIO_CHANNEL(8, 4, 0, 16),
	AD4851_IIO_CHANNEL(9, 4, 1, 16),
	AD4851_IIO_CHANNEL(10, 5, 0, 16),
	AD4851_IIO_CHANNEL(11, 5, 1, 16),
	AD4851_IIO_CHANNEL(12, 6, 0, 16),
	AD4851_IIO_CHANNEL(13, 6, 1, 16),
	AD4851_IIO_CHANNEL(14, 7, 0, 16),
	AD4851_IIO_CHANNEL(15, 7, 1, 16),


> +
> +static const struct ad4851_chip_info ad4851_info = {
> +	.name = "ad4851",
> +	.product_id = 0x67,
> +	.channels = ad4857_channels,
> +	.num_channels = ARRAY_SIZE(ad4857_channels),
> +	.throughput = 250 * KILO,

Is throughput the max sample rate? Better name would be max_sample_rate_hz.

> +	.resolution = 16,
> +};
> +
> +static const struct ad4851_chip_info ad4852_info = {
> +	.name = "ad4852",
> +	.product_id = 0x66,
> +	.channels = ad4858_channels,
> +	.num_channels = ARRAY_SIZE(ad4858_channels),
> +	.throughput = 250 * KILO,
> +	.resolution = 20,
> +};
> +
> +static const struct ad4851_chip_info ad4853_info = {
> +	.name = "ad4853",
> +	.product_id = 0x65,
> +	.channels = ad4857_channels,
> +	.num_channels = ARRAY_SIZE(ad4857_channels),
> +	.throughput = 1 * MEGA,
> +	.resolution = 16,
> +};
> +
> +static const struct ad4851_chip_info ad4854_info = {
> +	.name = "ad4854",
> +	.product_id = 0x64,
> +	.channels = ad4858_channels,
> +	.num_channels = ARRAY_SIZE(ad4858_channels),
> +	.throughput = 1 * MEGA,
> +	.resolution = 20,
> +};
> +
> +static const struct ad4851_chip_info ad4855_info = {
> +	.name = "ad4855",
> +	.product_id = 0x63,
> +	.channels = ad4857_channels,
> +	.num_channels = ARRAY_SIZE(ad4857_channels),
> +	.throughput = 250 * KILO,
> +	.resolution = 16,
> +};
> +
> +static const struct ad4851_chip_info ad4856_info = {
> +	.name = "ad4856",
> +	.product_id = 0x62,
> +	.channels = ad4858_channels,
> +	.num_channels = ARRAY_SIZE(ad4858_channels),
> +	.throughput = 250 * KILO,
> +	.resolution = 20,
> +};
> +
> +static const struct ad4851_chip_info ad4857_info = {
> +	.name = "ad4857",
> +	.product_id = 0x61,
> +	.channels = ad4857_channels,
> +	.num_channels = ARRAY_SIZE(ad4857_channels),
> +	.throughput = 1 * MEGA,
> +	.resolution = 16,
> +};
> +
> +static const struct ad4851_chip_info ad4858_info = {
> +	.name = "ad4858",
> +	.product_id = 0x60,
> +	.channels = ad4858_channels,
> +	.num_channels = ARRAY_SIZE(ad4858_channels),
> +	.throughput = 1 * MEGA,
> +	.resolution = 20,
> +};
> +
> +static const struct ad4851_chip_info ad4858i_info = {
> +	.name = "ad4858i",
> +	.product_id = 0x6F,
> +	.channels = ad4858_channels,
> +	.num_channels = ARRAY_SIZE(ad4858_channels),
> +	.throughput = 1 * MEGA,
> +	.resolution = 20,
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
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(7),
> +};
> +
> +static const char * const ad4851_power_supplies[] = {
> +	"vcc",	"vdd", "vee", "vio",
> +};
> +
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

We should also have a devm_add_action_and_reset() to call pwm_disable()
on driver remove. And to make it easier to see the full logic. we should
move ad4851_set_sampling_freq() from the ad4851_setup() here. (It should
come before registering the disable callback.) 

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
> +	{ .compatible = "adi,ad4851", .data = &ad4851_info, },
> +	{ .compatible = "adi,ad4852", .data = &ad4852_info, },
> +	{ .compatible = "adi,ad4853", .data = &ad4853_info, },
> +	{ .compatible = "adi,ad4854", .data = &ad4854_info, },
> +	{ .compatible = "adi,ad4855", .data = &ad4855_info, },
> +	{ .compatible = "adi,ad4856", .data = &ad4856_info, },
> +	{ .compatible = "adi,ad4857", .data = &ad4857_info, },
> +	{ .compatible = "adi,ad4858", .data = &ad4858_info, },
> +	{ .compatible = "adi,ad4858i", .data = &ad4858i_info, },
> +	{ }
> +};
> +
> +static const struct spi_device_id ad4851_spi_id[] = {
> +	{ "ad4851", (kernel_ulong_t)&ad4851_info },
> +	{ "ad4852", (kernel_ulong_t)&ad4852_info },
> +	{ "ad4853", (kernel_ulong_t)&ad4853_info },
> +	{ "ad4854", (kernel_ulong_t)&ad4854_info },
> +	{ "ad4855", (kernel_ulong_t)&ad4855_info },
> +	{ "ad4856", (kernel_ulong_t)&ad4856_info },
> +	{ "ad4857", (kernel_ulong_t)&ad4857_info },
> +	{ "ad4858", (kernel_ulong_t)&ad4858_info },
> +	{ "ad4858i", (kernel_ulong_t)&ad4858i_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4851_spi_id);
> +
> +static struct spi_driver ad4851_driver = {
> +	.probe = ad4851_probe,
> +	.driver = {
> +		.name   = "ad4851",

nit: too many spaces betwee name and =

> +		.of_match_table = ad4851_of_match,
> +	},
> +	.id_table = ad4851_spi_id,
> +};
> +module_spi_driver(ad4851_driver);
> +
> +MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
> +MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4851 DAS driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_BACKEND);


