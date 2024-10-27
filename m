Return-Path: <linux-pwm+bounces-3920-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D79B1B6C
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2AA282237
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 00:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E88F6B;
	Sun, 27 Oct 2024 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a1o/Jdsw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F09801
	for <linux-pwm@vger.kernel.org>; Sun, 27 Oct 2024 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729987322; cv=none; b=KGb6bBBtaFIiC2vi7Z9KVq/m2fH+SU6XFpPUIGRtQfpQ08Blvhe/r3Lkb0YRJC7fmeZjsCqkkfucI7JS3JetVxAbmRZtc6ZkAtXrx+mKmReOavbc29jCeLFO+CL24Nor5Es8p0iVv9ea5CWTZQ7PEPdU+WPGUO6Y/MEmNXNMVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729987322; c=relaxed/simple;
	bh=XtHzNcCTescXvZ9bmJ21cJwyQyCROOdHRf81dam67xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uym6NbfdojZt7P8ZIrqLh5xJzXdqMlKPqTlv/wqHnZ3UvXd1TSRuCEdFTmLL+zeIZslICydWWSnhnsGvZi5fS7xdRYnKTia4IU/hsEhYBkG3d7Fc5rHY+9xt0TY6r/eI1RwYi6CSclXWbNqTbivYunIzWVqk2Ew36UazKEdp3K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a1o/Jdsw; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e5fef69f2eso1961396b6e.3
        for <linux-pwm@vger.kernel.org>; Sat, 26 Oct 2024 17:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729987317; x=1730592117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pB662/UrG0gsr42jN3Byh38T4paHRcUICgBizIXwO94=;
        b=a1o/JdswcuUg3tMsrcphbiZ496cUAplZUhttZYQ/QStrW1mHA5c9LwQGZfRS2UeIdU
         H+oYjd1qJuAgxAG+oVmfAtwe9TDFcKk3GU6KzBrv3/ZMGnQaqe8fe6200cbO8W8p4oKL
         /NeEGJ1aWgE/C/ggG1AqJf03nhzxyZpc/Fk8wUyP3ocWbbidICbEulZ8URyPO/zkt607
         sfmlIsV/FPVJaBu2QlSSn68MCkIN5QtwcIHgnHNVVNN7Cnw7r2BnZsZvQ7rlcQ3hvrEP
         HwCeTkDDpDo/juBtBW8LUT8SyGHzTDtOXFE/A3moycLF3OFXwnzEBkmql6kMA/tDLS4v
         eH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729987317; x=1730592117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pB662/UrG0gsr42jN3Byh38T4paHRcUICgBizIXwO94=;
        b=Md5OY4OGJq9cQPQyWx3nPmjVrOLT+65o2QJap7cgeosveXRkUTrLaESG5cebNp37Sh
         6Px0Oo6RgExRrtYmgr1wyMtRv9uZK3jcy3dH1ENzXrrJa9Tom4Up5P2qF9U7wPvP5k/h
         uKDD1v8OGiowftUTMU09q9NqrJJ/FFsBvBHyZ+YgGUHE6f69r5O2qSEcEbIBuA/NEpfm
         SxgEQV/YwZ5ilhQesqh+J+RWewr3UkoFsplwTTDsDKfbYHo+pKHh6AaS7r6OgKm2QSDF
         +xJuov+Fy2tJoAfOis8nay5dSF0JF5k0ByNjKhhSdiDiYcT6yIKQuY3V0/I+nruSXbJQ
         dm6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsJEV99vjMiAUCzHbxmnRJJ8JONs7V3kAG2OyfjLbnCzfrbasXZhZcFLHNgRhJyN9giiX5biu7CgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1cd0YfvooIWABSomP9nlZVmDE4Cb7gdivZhLSXPJYrlJ3/LY
	PxJYm1FlO73RyMQbVxc4mojemegknGGhPyyggdHqINT4kCdWxmF6TQqJc2E0+cA=
X-Google-Smtp-Source: AGHT+IH2z0sp0u1GTEj5o+cvNnbB6imPt8Lme4yRFhIieZGB3/RPpO4DgbjBPb7ujfBjNHRtdhMihQ==
X-Received: by 2002:a05:6830:2707:b0:718:4063:4c71 with SMTP id 46e09a7af769-7186827359fmr2739914a34.15.1729987317363;
        Sat, 26 Oct 2024 17:01:57 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-718616104a5sm942278a34.22.2024.10.26.17.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 17:01:55 -0700 (PDT)
Message-ID: <5a090847-ee53-41be-ad28-b7604cf9020a@baylibre.com>
Date: Sat, 26 Oct 2024 19:01:53 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 15/15] iio: adc: ad4695: Add support for SPI
 offload
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-15-f8125b99f5a1@baylibre.com>
 <20241026170038.4b629cff@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241026170038.4b629cff@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/24 11:00 AM, Jonathan Cameron wrote:
> On Wed, 23 Oct 2024 15:59:22 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add support for SPI offload to the ad4695 driver. SPI offload allows
>> sampling data at the max sample rate (500kSPS or 1MSPS).
>>
>> This is developed and tested against the ADI example FPGA design for
>> this family of ADCs [1].
>>
>> [1]: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> A few questions inline. In general looks ok, but it's complex code and I'm
> too snowed under for a very close look at the whole thing for a least a few weeks.
> 
> Jonathan
> 
>> ---
>>  drivers/iio/adc/Kconfig  |   1 +
>>  drivers/iio/adc/ad4695.c | 470 +++++++++++++++++++++++++++++++++++++++++++----
>>  2 files changed, 440 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 92dfb495a8ce..f76a3f62a9ad 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -53,6 +53,7 @@ config AD4695
>>  	depends on SPI
>>  	select REGMAP_SPI
>>  	select IIO_BUFFER
>> +	select IIO_BUFFER_DMAENGINE
>>  	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  Say yes here to build support for Analog Devices AD4695 and similar
> 
>> +static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
>> +{
>> +	struct ad4695_state *st = iio_priv(indio_dev);
>> +	struct spi_offload_trigger_config config = {
>> +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
>> +	};
>> +	struct spi_transfer *xfer = &st->buf_read_xfer[0];
>> +	struct pwm_state state;
>> +	u8 temp_chan_bit = st->chip_info->num_voltage_inputs;
>> +	u8 num_slots = 0;
>> +	u8 temp_en = 0;
>> +	unsigned int bit;
>> +	int ret;
>> +
>> +	iio_for_each_active_channel(indio_dev, bit) {
>> +		if (bit == temp_chan_bit) {
>> +			temp_en = 1;
>> +			continue;
>> +		}
>> +
>> +		ret = regmap_write(st->regmap, AD4695_REG_AS_SLOT(num_slots),
>> +				   FIELD_PREP(AD4695_REG_AS_SLOT_INX, bit));
>> +		if (ret)
>> +			return ret;
>> +
>> +		num_slots++;
>> +	}
>> +
>> +	/*
>> +	 * For non-offload, we could discard data to work around this
>> +	 * restriction, but with offload, that is not possible.
>> +	 */
>> +	if (num_slots < 2) {
>> +		dev_err(&st->spi->dev,
>> +			"At least two voltage channels must be enabled.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = regmap_update_bits(st->regmap, AD4695_REG_TEMP_CTRL,
>> +				 AD4695_REG_TEMP_CTRL_TEMP_EN,
>> +				 FIELD_PREP(AD4695_REG_TEMP_CTRL_TEMP_EN,
>> +					    temp_en));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Each BUSY event means just one sample for one channel is ready. */
>> +	memset(xfer, 0, sizeof(*xfer));
>> +	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
>> +	xfer->bits_per_word = 16;
>> +	xfer->len = 2;
>> +
>> +	spi_message_init_with_transfers(&st->buf_read_msg, xfer, 1);
>> +	st->buf_read_msg.offload = st->offload;
>> +
>> +	st->spi->max_speed_hz = st->spi_max_speed_hz;
>> +	ret = spi_optimize_message(st->spi, &st->buf_read_msg);
>> +	st->spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * NB: technically, this is part the SPI offload trigger enable, but it
>> +	 * doesn't work to call it from the offload trigger enable callback
>> +	 * due to issues with ordering with respect to entering/exiting
>> +	 * conversion mode.
> Give some detail on the operations order.
> 
>> +	 */
>> +	ret = regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
>> +			      AD4695_REG_GP_MODE_BUSY_GP_EN);
>> +	if (ret)
>> +		goto err_unoptimize_message;
>> +
>> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
>> +					 &config);
>> +	if (ret)
>> +		goto err_disable_busy_output;
>> +
>> +	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
>> +	if (ret)
>> +		goto err_offload_trigger_disable;
>> +
>> +	guard(mutex)(&st->cnv_pwm_lock);
>> +	pwm_get_state(st->cnv_pwm, &state);
>> +	/*
>> +	 * PWM subsystem generally rounds down, so requesting 2x minimum high
>> +	 * time ensures that we meet the minimum high time in any case.
>> +	 */
>> +	state.duty_cycle = AD4695_T_CNVH_NS * 2;
>> +	ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
>> +	if (ret)
>> +		goto err_offload_exit_conversion_mode;
>> +
>> +	return 0;
>> +
>> +err_offload_exit_conversion_mode:
>> +	/* have to unwind in a different order to avoid triggering offload */
> 
> Needs more details here.
> 
>> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
>> +	ad4695_cnv_manual_trigger(st);
>> +	ad4695_exit_conversion_mode(st);
>> +	goto err_disable_busy_output;
>> +
>> +err_offload_trigger_disable:
>> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
>> +
>> +err_disable_busy_output:
>> +	regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
>> +			  AD4695_REG_GP_MODE_BUSY_GP_EN);
>> +
>> +err_unoptimize_message:
>> +	spi_unoptimize_message(&st->buf_read_msg);
>> +
>> +	return ret;
>> +}
> 
>> +
>>  static int ad4695_write_raw(struct iio_dev *indio_dev,
>>  			    struct iio_chan_spec const *chan,
>>  			    int val, int val2, long mask)
>> @@ -779,6 +992,17 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
>>  			default:
>>  				return -EINVAL;
>>  			}
>> +		case IIO_CHAN_INFO_SAMP_FREQ: {
>> +			struct pwm_state state;
>> +
>> +			if (val <= 0)
>> +				return -EINVAL;
>> +
>> +			guard(mutex)(&st->cnv_pwm_lock);
>> +			pwm_get_state(st->cnv_pwm, &state);
> 
> What limits this to rates the ADC can cope with?
> 
>> +			state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, val);
>> +			return pwm_apply_might_sleep(st->cnv_pwm, &state);
>> +		}
>>  		default:
>>  			return -EINVAL;
>>  		}
> 
>>  static int ad4695_probe(struct spi_device *spi)
>>  {
>>  	struct device *dev = &spi->dev;
>>  	struct ad4695_state *st;
>>  	struct iio_dev *indio_dev;
>> -	struct gpio_desc *cnv_gpio;
>>  	bool use_internal_ldo_supply;
>>  	bool use_internal_ref_buffer;
>>  	int ret;
>>  
>> -	cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
>> -	if (IS_ERR(cnv_gpio))
>> -		return dev_err_probe(dev, PTR_ERR(cnv_gpio),
>> -				     "Failed to get CNV GPIO\n");
>> -
>> -	/* Driver currently requires CNV pin to be connected to SPI CS */
>> -	if (cnv_gpio)
>> -		return dev_err_probe(dev, -ENODEV,
>> -				     "CNV GPIO is not supported\n");
>> -
>>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>>  	if (!indio_dev)
>>  		return -ENOMEM;
>> @@ -1002,8 +1374,13 @@ static int ad4695_probe(struct spi_device *spi)
>>  		return -EINVAL;
>>  
>>  	/* Registers cannot be read at the max allowable speed */
>> +	st->spi_max_speed_hz = spi->max_speed_hz;
>>  	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
>>  
>> +	ret = devm_add_action_or_reset(dev, ad4695_restore_spi_max_speed_hz, st);
> 
> Why do you need to put it back in devm? What happens after this but without
> a driver restart that uses that faster rate?
> 
I should have added a comment here as this was a weird bug to trace.

The core SPI framework sets the initial value of spi->max_speed_hz
to the minimum of the controller max rate and the max rate specified
by the devicetree.

The SPI device lives beyond this driver, so if we bind the driver
and set spi->max_speed_hz to something other than what the SPI core
set it, then the next time we bind the driver, we don't get the
the max rate from the SPI core, but rather we changed it to when
the driver unbound.

So on the second bind, the max rate would be the slow register
read rate instead of the actual max allowable rate.

So we need to reset spi->max_speed_hz to what it was originally
on driver unbind so that everything works as expected on the
next bind.

(Or we call this a SPI core bug and fix it there instead).


