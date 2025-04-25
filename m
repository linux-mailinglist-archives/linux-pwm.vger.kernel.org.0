Return-Path: <linux-pwm+bounces-5720-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A02A9D612
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Apr 2025 01:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D69171D05
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Apr 2025 23:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2332973A0;
	Fri, 25 Apr 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PUk2Anzp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA6296D31
	for <linux-pwm@vger.kernel.org>; Fri, 25 Apr 2025 23:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745622834; cv=none; b=XMiEHHXlaxmc7MQsWNplUSkPrazguk4AqLE5V1arwaAslTse37l5bCH6GKrobBAuMCnliUC64dtRCKTkm2o5I07y/AVBXCLL3tJY+XupVBdniACLiP2rBZCpKRrI5W4a78bJ1NIzZTF12ycRTU1HTr7zMLiODXSWQz8r8+6BZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745622834; c=relaxed/simple;
	bh=PngBN4fnbURLzAySAY30tx1qdDko/K5iW4qjRDdHsFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADOcbQ/C5LY3GQDVTZCQvOgCWu8zclDk9LGNUPBsHncYDOKyY+PrsnqXPSH2mCYcZHTy323rJ60vi2apY4e0TUZcHfd6WYvnnUI1hrECMckQbEwrjIWfJRZpS3DB6yTkmuWRY3N318Xcds52d9Vno113tYcXGnNEHYDDU9CIMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PUk2Anzp; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72c1425fbfcso2278673a34.3
        for <linux-pwm@vger.kernel.org>; Fri, 25 Apr 2025 16:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745622830; x=1746227630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+3rb/tLAGnvLIt9IgNGUN65XhsnftVTZknFpZtsVlw=;
        b=PUk2AnzpMmsL9x4bI3BiNLMqjY+ETaT1qygv3AzghvWuoHExRhHuqUhxgiN59teVcV
         g5P5CeARl53jAfoWr53r6LAoxFnGChMXWPVAPUGunXfhWMtJlTQdvGHwqIn+qPzs/nYi
         VK444HhDkFMs56CqvyUnFHs6fzNODG2Z3Kfu/Xje/i7CVHi6NZoO5IOuf6ishTP2BYVJ
         8xTG9Q3UIn01GKDmRswJbbGce/e4kHL2ttPjVpN4klPJ0G7wOZ10dCiiqG65VluD4Wce
         bTHiFDfAR5U0XNRK914l0npeBo8reM4kIbj25PMyFOxGIkqs5hhLYuYu74BvaEXs/h7i
         bc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745622830; x=1746227630;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+3rb/tLAGnvLIt9IgNGUN65XhsnftVTZknFpZtsVlw=;
        b=lkOiJ5B18k/r8Th+ZOMXQ2t3ILIUA5NdPqtB7IGqTJavw8+XsHkJlfnyU1UFKnywml
         LcvHZUKPdjthpabHAyAxAbSn3DD4W/aUGY56+XOAppqiKT6p7Fb+Q94Z4CcOMVyuz0F9
         OOSl4XknDbpAq+XXalUtVp4ruCJ0ZVfvJ/wnxsyrwfZM9Te3idc1qgNnA1OSz+uvbQaX
         r09A5p93EPIaGgnLaSIA50/zGGuAr08xIb0xf3V2ZTX8Xla7TS7pOzIFnjhAWHSsz4NG
         qkQM+ek/7T8oJVtRvUCNfC5WpshxOqWiPqIHXdxqI+YZcBG0QOB2TXQ2g2iGphr7hBi5
         bHxw==
X-Forwarded-Encrypted: i=1; AJvYcCUNBxkR54SrgkxgfRYvIaNeqjYUKYtFPOuLVUAdVX7vzl2QvzzgM2OJ7jnIJfyz4yl2TXwPGOy+NSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97MitrUGqDBtli8HLGYr7BDdm6gVlmJPQ7v0OEzthBibCfgoV
	UgfC0p1yfd5sOSMYeuNnTfPkni4xeIRPRhQ0Y/l9yYR91EEkrqVieBiDW5w1xVI=
X-Gm-Gg: ASbGncuV38DbbhQ2o7yMaFDR95cKmYY5yAwQrJYmPoi3kMvCQ/HAUKvw3NTL7rCjwGu
	BGLzS5/qRKxDYkH0rT+BQmX2DiBKSbZBusLKjoG3gty7G0JVlMx1oVNcWzxdba7hcln/rLLQ/F5
	4b9r38sntDPtxBxg6+Yj75ozLG3cL2Fk8AXXRBxB8uuVmjyJv3cacn420IW809sXwRCNsSJV77Y
	ZwAs6f+ywoirq+MSiWJcIgUNF2WhjN7lfrD8KVRE/h5V3/yw1THQeVrjwwgb6kEzk61+BJE/5hI
	Z3nkYM5LqybK+eVRdXHhaHrSxQYZWMdCmB3d9OQL0ZKQVt/4tnfX+eihEwXaslo5SS2ciOLLrqk
	URbm8IBT2EP9C
X-Google-Smtp-Source: AGHT+IFMv0vnj0gyPnnBDlAAtjQ4qLxNurqnITAkClibY+ZJfAW3Guzqu2qpn/vLBJV0bNHfsRHU4w==
X-Received: by 2002:a05:6830:3816:b0:72b:9f83:1155 with SMTP id 46e09a7af769-7305c9f62bamr2552310a34.17.1745622830303;
        Fri, 25 Apr 2025 16:13:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:96a3:e28:3f6:dbac? ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f19fb76sm873571a34.16.2025.04.25.16.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 16:13:49 -0700 (PDT)
Message-ID: <c82b8c53-e653-4cd3-80ef-37c5daf9314c@baylibre.com>
Date: Fri, 25 Apr 2025 18:13:48 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
To: Jorge Marques <jorge.marques@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 6:34 AM, Jorge Marques wrote:
> The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
> successive approximation register (SAR) analog-to-digital converter (ADC)
> that enables low-power, high-density data acquisition solutions without
> sacrificing precision.
> This ADC offers a unique balance of performance and power efficiency,
> plus innovative features for seamlessly switching between high-resolution
> and low-power modes tailored to the immediate needs of the system.
> The AD4052/AD4058/AD4050/AD4056 are ideal for battery-powered,
> compact data acquisition and edge sensing applications.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> ---
>  MAINTAINERS              |    1 +
>  drivers/iio/adc/Kconfig  |   14 +
>  drivers/iio/adc/Makefile |    1 +
>  drivers/iio/adc/ad4052.c | 1425 ++++++++++++++++++++++++++++++++++++++++++++++

This patch is way too big, so I didn't review most of it yet. But time to call
it quits for today. In the future, it would be a lot easier for reviewers if
you can split things into multiple patches instead of implementing all of the
features at once. E.g. start with just a basic driver, then a patch to add
oversampling support, then another patch to add SPI offload support. 500 lines
is a more manageable size for review.

...

> +static int ad4052_update_xfer_offload(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	struct spi_transfer *xfer = &st->xfer;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> +
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	xfer = &st->offload_xfer;
> +	xfer->bits_per_word = scan_type->realbits;
> +	xfer->len = BITS_TO_BYTES(scan_type->storagebits);

This doesn't work for oversampling. realbits may be 16 while storagebits is 32.
But the SPI controller needs to know how many realbits-sized words to read.

So this should be 

	xfer->len = BITS_TO_BYTES(scan_type->realbits);



> +
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +	st->offload_msg.offload = st->offload;
> +
> +	return spi_optimize_message(st->spi, &st->offload_msg);

I know it is like this in a few other drivers already, but I don't like having
spi_optimize_message() in this funtion because it makes it really easy to
forget to do have balanced calls to spi_unoptimize_message().

> +}
> +

...

> +static const struct iio_buffer_setup_ops ad4052_buffer_setup_ops = {
> +	.postenable = &ad4052_buffer_postenable,
> +	.predisable = &ad4052_buffer_predisable,
> +};

Would be nice to add "offload" to the name of this struct and the callbacks
to make it clear that these are only for the SPI offload use case.

...

> +
> +static bool ad4052_offload_trigger_match(struct spi_offload_trigger *trigger,
> +					 enum spi_offload_trigger_type type,
> +					 u64 *args, u32 nargs)
> +{

We should be checking the args here according to what I suggested in my reply
to the devicetree bindings patch. Right now it is assuming that we are only
using this for SPI offload and that the pin used is GP1 and the event is data
read. We should at least verify that the args match those assumptions.

For bonus points, we could implement allowing GPO as well.

> +	return type == SPI_OFFLOAD_TRIGGER_DATA_READY;
> +}
> +
> +static const struct spi_offload_trigger_ops ad4052_offload_trigger_ops = {
> +	.match = ad4052_offload_trigger_match,
> +};
> +
> +static int ad4052_request_offload(struct iio_dev *indio_dev)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct dma_chan *rx_dma;
> +	struct spi_offload_trigger_info trigger_info = {
> +		.fwnode = dev_fwnode(dev),
> +		.ops = &ad4052_offload_trigger_ops,
> +		.priv = st,
> +	};
> +	struct pwm_state pwm_st;
> +	int ret;
> +
> +	indio_dev->setup_ops = &ad4052_buffer_setup_ops;
> +
> +	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register offload trigger\n");

Strictly speaking, the trigger-source provider is indendant of using it for
SPI offload. I guess this is fine here for now though.

> +
> +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> +							   SPI_OFFLOAD_TRIGGER_DATA_READY);
> +	if (IS_ERR(st->offload_trigger))
> +		return PTR_ERR(st->offload_trigger);
> +
> +	st->cnv_pwm = devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->cnv_pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
> +				     "failed to get CNV PWM\n");
> +
> +	pwm_init_state(st->cnv_pwm, &pwm_st);
> +
> +	pwm_st.enabled = false;
> +	pwm_st.duty_cycle = AD4052_T_CNVH_NS * 2;
> +	pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> +					 AD4052_MAX_RATE(st->grade));
> +
> +	ret = pwm_apply_might_sleep(st->cnv_pwm, &pwm_st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to apply CNV PWM\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad4052_pwm_disable, st->cnv_pwm);
> +	if (ret)
> +		return ret;
> +
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> +	if (IS_ERR(rx_dma))
> +		return PTR_ERR(rx_dma);
> +
> +	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
> +							   IIO_BUFFER_DIRECTION_IN);
> +}
> +
> +static int ad4052_probe(struct spi_device *spi)
> +{
> +	const struct ad4052_chip_info *chip;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4052_state *st;
> +	int ret = 0;
> +
> +	chip = spi_get_device_match_data(spi);
> +	if (!chip)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Could not find chip info data\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	spi_set_drvdata(spi, st);
> +	init_completion(&st->completion);
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ad4052_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	st->mode = AD4052_SAMPLE_MODE;
> +	st->wait_event = false;
> +	st->chip = chip;
> +	st->grade = chip->prod_id <= 0x75 ? AD4052_2MSPS : AD4052_500KSPS;
> +	st->oversampling_frequency = AD4052_FS_OFFSET(st->grade);
> +	st->events_frequency = AD4052_FS_OFFSET(st->grade);

Somewhere around here, we should be turning on the power supplies. Also, it
looks like we need some special handling to get the reference volage. If there
is a supply connected to REF, use that, if not, use VDD which requires writing
to a register to let the chip know.

> +
> +	st->cnv_gp = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->cnv_gp))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_gp),
> +				     "Failed to get cnv gpio\n");
> +
> +	indio_dev->modes = INDIO_BUFFER_HARDWARE | INDIO_DIRECT_MODE;

INDIO_BUFFER_HARDWARE should not be set here. If using SPI offload,
devm_iio_dmaengine_buffer_setup_with_handle() will add it automatically.
For non-SPI-offload operation, it should not be set.

> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ad4052_info;
> +	indio_dev->name = chip->name;
> +
> +	st->offload = devm_spi_offload_get(dev, spi, &ad4052_offload_config);

This

> +	if (IS_ERR(st->offload))
> +		return PTR_ERR(st->offload);

should be

	ret = PTR_ERR_OR_ZERO(st->offload);

> +
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get offload\n");
> +
> +	if (ret == -ENODEV) {
> +		st->offload_trigger = NULL;
> +		indio_dev->channels = chip->channels;
> +	} else {
> +		indio_dev->channels = chip->offload_channels;
> +		ret = ad4052_request_offload(indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure offload\n");
> +	}
> +
> +	st->xfer.rx_buf = &st->d32;

I don't think we want this set globally. I.e. it doesn't make sense for SPI
offload xfers.

> +
> +	ret = ad4052_soft_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "AD4052 failed to soft reset\n");
> +
> +	ret = ad4052_check_ids(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "AD4052 fields assertions failed\n");
> +
> +	ret = ad4052_setup(indio_dev, indio_dev->channels);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
> +			   AD4052_DEVICE_STATUS_DEVICE_RESET);

Why not include this in ad4052_setup() or even ad4052_soft_reset()?

> +	if (ret)
> +		return ret;
> +
> +	ret = ad4052_request_irq(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ad4052_update_xfer_raw(indio_dev, indio_dev->channels);
> +
> +	pm_runtime_set_active(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable pm_runtime\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int ad4052_runtime_suspend(struct device *dev)
> +{
> +	struct ad4052_state *st = dev_get_drvdata(dev);
> +
> +	return regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
> +			    FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK,
> +				       AD4052_DEVICE_CONFIG_LOW_POWER_MODE));
> +}
> +
> +static int ad4052_runtime_resume(struct device *dev)
> +{
> +	struct ad4052_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
> +			   FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK, 0));

regmap_clear_bits() would be shorter if there isn't going to be a macro to
explain the meaning of 0.

> +	return ret;
> +}
> +

