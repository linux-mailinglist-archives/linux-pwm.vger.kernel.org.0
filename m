Return-Path: <linux-pwm+bounces-4242-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8CF9E4B77
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 01:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ED8167409
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 00:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D171F5FA;
	Thu,  5 Dec 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l8yVadJV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F31A260
	for <linux-pwm@vger.kernel.org>; Thu,  5 Dec 2024 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359625; cv=none; b=A0kmzB6/gdlC4rj5oFxrUBlRJPeDhMOubZg3YCKTYvor2OSfEGJ6m35i4ac/3XXgz5XCkYx5ZpmTlUhlPn/zanOmLgrJT1TSQRWBATdrguC3oqAc8OU8C3oVVoqcxJt+/mpUp6lgafe4SjzpW55oJYmgHiOK7s6xDn3JhhFMsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359625; c=relaxed/simple;
	bh=QysfSxgEVRwQ5xJCXIhvZS3Xsi0lfEQ9bwSeoIrxkDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tU8q2V/gbBNQz4JIJvzMeI29hYQWoAde7ce7lE2ZT6IvL4VROxOgvTAy35WuAaqdQtZtkRwzfwCI2TPZR8hnZDqLMEgg/QHUkWz53EfkDlom75m1U0w4B+ABHyeOSKcz6Gg4wSC7yVJjFDnDV42QGNRMn/y8tQdzCeBs5cf4Mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l8yVadJV; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f1f81e51b1so228610eaf.3
        for <linux-pwm@vger.kernel.org>; Wed, 04 Dec 2024 16:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733359622; x=1733964422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8p4q15WVKblfBi6Kn4uPAclVcX2kybZAq0VzH31+WU=;
        b=l8yVadJVnb+I1JzpaNVPd5ntfH6e3KkdWSqRuCQc/mYBdeu+jcuJu199i0dKClgwZ3
         YH1E2hXtGAn3qoBbTVMdtDCV1VI65Ou4gobfyhpxfZ6YRaXOeDYeNga0G1/GmN55ynwO
         EwMnQUQuTHvPXCDGPdbPHgnMRCnf0bggf6+ud/ktuMOBOA3PXGwPipgqCUv8/ylg1z23
         hHAJQwnBcStA004LWb/a4zynrcrw80AwNypjObwET4QwSR8wzfE4leih5VKBS+Q+O+sP
         PRAkFlwlWQkwDar8bOpCKKspl0hvJwZ7YD1zyh1vteuT08adoHgObBUvU6jYxMqkC7O3
         LmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359622; x=1733964422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8p4q15WVKblfBi6Kn4uPAclVcX2kybZAq0VzH31+WU=;
        b=V/d/dV6WMr4Kk32RYJ3qMYhdlS9KypyZ0oTFzLX3n7Ey8OU0Uug6UgQ1qmFEXTX5xS
         Gho+gB5F1jOgXbhebPTeKP6W+VadmaDuYRz6l4Bk/Rdwsi4dLkc8o7FYY3Kw2Luo25Kp
         Qv+8bKBXqvnMo0o/fiSCiRIW7PlZCf2r1TdvtZhzslVXtTvZsJaLlRK265lRUnsXr5zF
         mzAjn2hLJFsarAXVORNM6iTv0KidciqpGynXiaqE77KOM4eajjU/02n1eQPl5d6CorpC
         vn627h5G9s62kUkZZShr8b03aedzf1kb3m6tvhzxzGSflQWrDelF/4ekcLkY69JVYQ1j
         kgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHupIkfIL/LDrwPvQi2f9/a6/G5nmCJEwoLPAPRsxsRqEAcoMJflGzDDaTpsZCfPPVQk470+GRGI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyieVabvDVqxMTEP0NY1HDrHx0+Y/wGl+SEeX7L48Dg3ZXLGyrs
	ezSuYUNAVl0zjzmQ16srF8dAB8bY/TLgRszus7l+nOu3i6JzpzGKK+413ujXakA0xiP6IznN3P/
	2
X-Gm-Gg: ASbGnctQBWgvJNH+f9Sk1p6eyCSlhbybDyUEUtY5EUKXWT7ZZElYBUC1IE5deyOtobQ
	uRwXlwY4FYULfRw/Pn5gEMBxV8je59rDQlfBtYd03xgsR8fksiWVvAWR0A/5HCFSUdoBToXe8LU
	COrTKPnN/8Qw3k4UAGf4wyv5LGqKbtT4mlluUwhmkcEG5+dou4W8FM99KFvdU2vzWF3jQvUNlLB
	MWvi+Srdo/7/mQ1k5vvkgjOc65XX92kennreqTM/C/3FAMjleOjbgR/jUkLTCxE9wcsUfBl7s7K
	CvIsLxaDo3Y=
X-Google-Smtp-Source: AGHT+IHwJcUqp71G1F8+1pNoNqOv9fmmPQcWJXqYYlz1QYEPeYCZNukY2WiIQJTY++R6odipVCp4PA==
X-Received: by 2002:a05:6820:1b09:b0:5ee:d89f:1d35 with SMTP id 006d021491bc7-5f25ae29232mr8492295eaf.6.1733359622304;
        Wed, 04 Dec 2024 16:47:02 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f279304212sm107672eaf.34.2024.12.04.16.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 16:47:01 -0800 (PST)
Message-ID: <51482499-76c6-4cdc-a3a9-9077ea09787c@baylibre.com>
Date: Wed, 4 Dec 2024 18:47:00 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-9-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241129153546.63584-9-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 9:35 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static const struct ad4851_scale ad4851_scale_table_se[] = {
> +	{ 2500, 0x0 },
> +	{ 5000, 0x2 },
> +	{ 6250, 0x4 },
> +	{ 10000, 0x6 },
> +	{ 12500, 0x8 },
> +	{ 20000, 0xA },
> +	{ 25000, 0xC },
> +	{ 40000, 0xE },
> +};
> +
> +static const struct ad4851_scale ad4851_scale_table_diff[] = {
> +	{ 5000, 0x1 },
> +	{ 10000, 0x3 },
> +	{ 12500, 0x5 },
> +	{ 20000, 0x7 },
> +	{ 25000, 0x9 },
> +	{ 40000, 0xB },
> +	{ 50000, 0xD },
> +	{ 80000, 0xF },
> +};

The logic circuits in my brain thank you for separating these. :-)

Much easier for me to understand how the code works now.

> +
> +static const unsigned int ad4851_scale_avail_se[] = {
> +	2500,
> +	5000,
> +	6250,
> +	10000,
> +	12500,
> +	20000,
> +	25000,
> +	40000,
> +};
> +
> +static const unsigned int ad4851_scale_avail_diff[] = {
> +	5000,
> +	10000,
> +	12500,
> +	20000,
> +	25000,
> +	40000,
> +	50000,
> +	80000,
> +};
> +
> +struct ad4851_chip_info {
> +	const char *name;
> +	unsigned int product_id;
> +	int num_scales;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +	unsigned long max_sample_rate_hz;
> +	unsigned int resolution;
> +	int (*parse_channels)(struct iio_dev *indio_dev);
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
> +	unsigned int scales_se[AD4841_MAX_SCALE_AVAIL][2];
> +	unsigned int scales_diff[AD4841_MAX_SCALE_AVAIL][2];
> +};
> +
> +static int ad4851_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
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

This still doesn't seem safe due to possible rounding of this minium
time. See previous reviews.

> +		.enabled = true,
> +	};
> +	int ret;
> +
> +	freq = clamp(freq, 1, st->info->max_sample_rate_hz);
> +
> +	cnv_state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> +
> +	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
> +	if (ret)
> +		return ret;
> +

There is now a pwm_get_state_hw() function we can use to get the actual
PWM period the hardware actually selected. We can use that here to more
accuratly set st->sampling_freq instead of using the requested value.

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
> +
> +		ret = iio_backend_oversampling_disable(st->back);
> +		if (ret)
> +			return ret;
> +	} else {
> +		val = ad4851_osr_to_regval(osr);
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +				      AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_RATIO_MSK, val);

Wouldn't hurt to use FIELD_PREP() on val here.

> +		if (ret)
> +			return ret;
> +
> +		ret = iio_backend_oversampling_enable(st->back);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	switch (chan->scan_type.realbits) {

When using ext_scan_type, we have to use iio_get_current_scan_type()
to get the scan type instead of chan->scan_type. Otherwise we will
be accessing a member of a union that is currently being used for
something else and will get some unknown value.

We also have to be extra careful here since changing the oversampling
ratio will change the scan type. So here, it would probably be best to
use the resolution from the chip info instead of scan_type to get the
16 or 20. Otherwise, realbits could be 24 if oversampling is already
enabled on a 20-bit chip.

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
> +	if (osr == 1 || chan->scan_type.realbits == 16) {

Again here, consider chip info resolution instead of scan_type.

> +		ret = regmap_clear_bits(st->regmap, AD4851_REG_PACKET,
> +					AD4851_PACKET_FORMAT_MASK);
> +		if (ret)
> +			return ret;
> +
> +		st->resolution_boost_enabled = false;
> +	} else {
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> +					 AD4851_PACKET_FORMAT_MASK,
> +					 FIELD_PREP(AD4851_PACKET_FORMAT_MASK, 1));
> +		if (ret)
> +			return ret;
> +
> +		st->resolution_boost_enabled = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4851_get_oversampling_ratio(struct ad4851_state *st, unsigned int *val)
> +{
> +	unsigned int osr;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
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
> +static void ad4851_pwm_disable(void *data)
> +{
> +	pwm_disable(data);
> +}
> +
> +static int ad4851_setup(struct ad4851_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +
> +	if (!IS_ERR(st->vrefbuf)) {
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +				      AD4851_REFBUF_PD);
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
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +				      AD4851_REFSEL_PD);
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
> +	if (st->pd_gpio) {
> +		/* To initiate a global reset, bring the PD pin high twice */
> +		gpiod_set_value(st->pd_gpio, 1);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 0);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 1);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 0);
> +		fsleep(1000);
> +	} else {
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +				      AD4851_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}

Resetting here will reset the REFBUF/REFSEL that were already configured
in the DEVICE_CTRL register. The reset should be done before any other config.

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
> +	ret = regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +			      AD4851_ECHO_CLOCK_MODE);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
> +}
> +

...

> +
> +static void __ad4851_get_scale(struct ad4851_state *st, int scale_tbl,
> +			       unsigned int *val, unsigned int *val2)
> +{
> +	const struct ad4851_chip_info *info = st->info;
> +	const struct iio_chan_spec *chan = &info->channels[0];
> +	unsigned int tmp;
> +
> +	tmp = ((unsigned long long)scale_tbl * MICRO) >> chan->scan_type.realbits;

As above, we need to use iio_get_current_scan_type() to safely get the
current scan_type struct.

Can also abbrivate unsigned long long as u64.

> +	*val = tmp / MICRO;
> +	*val2 = tmp % MICRO;
> +}
> +

...

> +
> +static int ad4851_scale_fill(struct ad4851_state *st)
> +{
> +	unsigned int i, val1, val2;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_avail_se); i++) {
> +		__ad4851_get_scale(st, ad4851_scale_avail_se[i], &val1, &val2);
> +		st->scales_se[i][0] = val1;
> +		st->scales_se[i][1] = val2;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_avail_diff); i++) {
> +		__ad4851_get_scale(st, ad4851_scale_avail_diff[i], &val1, &val2);
> +		st->scales_diff[i][0] = val1;
> +		st->scales_diff[i][1] = val2;
> +	}

Isn't this just copying the static structs directly? If that is the case,
why not just use the static structs directly in the code instead of making
a copy?

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

I didn't think about this before, but oversampling ratio will affect the
sampling freqency. Userspace tools like iio-oscilloscope expect the rate
reported by the sampling_frequency attribute to mean how often we read one
sample from the chip or one batch of samples from a simeltaneous sampling
chip like this one. But st->sampling_freq is the rate at which we are
toggling the CNV pin. When oversampling is enabled, we toggle CNV N times
before doing a read where N is the oversamping ratio. So to get the correct
value to userspace, we need to divide st->st->sampling_freq by the
oversampling ratio.

Could also be a good idea to rename st->sampling_freq to something like
st->cnv_trigger_rate_hz or something like that to avoid confusion.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_get_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_get_scale(st, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4851_get_calibbias(st, chan->channel, val);
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

Similar to above, we need to take into account oversampling ratio here.

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
> +	for (c = 0; c < st->info->num_channels / 2; c++) {

This doesn't look quite right. This means only the first half of the
channels could ever be enabled. Also scan_index doesn't correspond to
channel number any more.

Since each physical input has 2 IIO channels with consecutive scan_index,
we could read 2 bits at a time from the scan_mask.

If that value == 0x3, then return -EINVAL because we tried to enable
both the differential and single-ended input on the same physical
input pin.

If the value is 0x0, disable the channel in the backend. Otherwise,
enable the channel in the backend (value is 0x1 or 0x2).

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
> +		if (chan->differential) {
> +			*vals = (const int *)st->scales_diff;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			/* Values are stored in a 2D matrix */
> +			*length = ARRAY_SIZE(ad4851_scale_avail_diff) * 2;
> +		} else {
> +			*vals = (const int *)st->scales_se;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			/* Values are stored in a 2D matrix */
> +			*length = ARRAY_SIZE(ad4851_scale_avail_se) * 2;
> +		}

This one gets a bit tricky since on 20-bit chips, enabling oversampling
also changes the number of realbits. So we need different list of scales
available in that case.

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
> +static const struct iio_scan_type ad4851_scan_type_16 = {
> +	.sign = 's',
> +	.realbits = 16,
> +	.storagebits = 16,
> +};

Don't we need an unsigned version of this one too? Or is this struct
unused and can be removed?

> +
> +static const struct iio_scan_type ad4851_scan_type_20_0[] = {
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

Did you mean diff * (ch + 8)?

> +	.scan_index = index,							\
> +
> +#define AD4858_IIO_CHANNEL(index, ch, diff, bits)				\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.ext_scan_type = ad4851_scan_type_##bits##_##diff,			\
> +	.num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_##bits##_##diff),	\
> +}
> +
> +#define AD4857_IIO_CHANNEL(index, ch, diff, bits)				\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.scan_type = {								\
> +		.sign = 's',							\

sign should be 's' for diff and 'u' for !diff

> +		.realbits = bits,						\
> +		.storagebits = bits,						\

Could just hard code 16 here and avoid passing it as a parameter.

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
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_1);
> +
> +		} else {
> +			*ad4851_channels = ad4851_chan;
> +			ad4851_channels->scan_index = index++;
> +			ad4851_channels->channel = reg;
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_0;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_0);
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

Do we actually need these 2 channel parsing functions? I thought the goal
here was to provide both a differential and single-ended version of each
channel always so we wouldn't be limited to one or the other by the
devicetree.

static const struct iio_chan_spec ad4858_channels and ad4857_channels seem
like they should be sufficint to me without dynamically creating channels
during probe.


