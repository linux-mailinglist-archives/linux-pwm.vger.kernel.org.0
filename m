Return-Path: <linux-pwm+bounces-3034-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B99558C3
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 17:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7669A1C20D3E
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDDA14F9E9;
	Sat, 17 Aug 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEiw8Enw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F5EEA9;
	Sat, 17 Aug 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723909680; cv=none; b=Z62YbQ00Lo4wgYlsWX55TZZkUD54DzFXWlyZb/keynMVmgZrRyzFr9qyIpLtRkWXL0adJm+cbypZaFBR0/eJUQo5x+FREDka1cE1/b5JllmBwePCoWaTKXorZnmQPF13Pcfe7XHTYAXoB5or0mNPcKePDNXJfygox5fbhHqUiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723909680; c=relaxed/simple;
	bh=CBftMxGU3ns6CW4XyKm4mkBXMYbO6o4ir42xFnqmmJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiZxxZBlV1TFf3POzTLI+UM/zEk/HrS4GTnXnwhero6vekcjZ+a3M9Gry3xy4bP/f9vWcSPEQYPux3Yw6DLARkBsyLgpURal4eKWPq5C3zA1CSVdQbTzjvRHlK3l89Lh4mbQEczPT47OPfgNNHj+fWUXS9oxcac9l5Y313xT2ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEiw8Enw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AEBC116B1;
	Sat, 17 Aug 2024 15:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723909680;
	bh=CBftMxGU3ns6CW4XyKm4mkBXMYbO6o4ir42xFnqmmJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YEiw8Enw3DF16pYJ/rCvdNOKL+Wu5xsgLQEzRq1sAQRlpY4FiYB0UaoDlXMz3mC8O
	 uK67ZKQ2StOx/+xkstFs2835y9W9OyM88mpWH6TlSif4+9P4240mtW7G64Wi6i35nV
	 DXP4WOPzcqpJnlCx/6kbTNAZ4D+rjUI4I3IXP5bnKy0ldLezTO8EiXr2QliW3Mlnx7
	 fCD+S1lU51cxlJkjPR0UefuxqQ7hyais0hq71VJRRv6K/1P5XLiLeCu9zdtep8hDxo
	 kZ6jEb0zODeavtC5RS/Q3c8xeunj9c3+d51dNRC3B+VInej1TrIZbckXlR4Q3No9ok
	 HFonS/PhsDnCA==
Date: Sat, 17 Aug 2024 16:47:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, aardelean@baylibre.com
Subject: Re: [PATCH 8/8] iio:adc:ad7606: Add iio-backend support
Message-ID: <20240817164748.30091016@jic23-huawei>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-8-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-8-cea3e11b1aa4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:12:02 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> - Basic support for iio backend.
> - Supports IIO_CHAN_INFO_SAMP_FREQ R/W.
> - Only hardware mode is available, and that IIO_CHAN_INFO_RAW is not
>   supported if iio-backend mode is selected.
> 
> A small correction was added to the driver's file name in the Kconfig
> file's description.
>
I'm going to want Nuno's input on this.  Given it's the summer that may
take a little while, so in meantime a few comments inline.

Jonathan

 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/Kconfig      |   3 +-
>  drivers/iio/adc/ad7606.c     | 103 +++++++++++++++++++++++++++++++++++--------
>  drivers/iio/adc/ad7606.h     |  16 +++++++
>  drivers/iio/adc/ad7606_par.c |  98 +++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 200 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 88e8ce2e78b3..01248b6df868 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -227,9 +227,10 @@ config AD7606_IFACE_PARALLEL
>  	help
>  	  Say yes here to build parallel interface support for Analog Devices:
>  	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
> +	  It also support iio_backended devices for AD7606B.
>  
>  	  To compile this driver as a module, choose M here: the
> -	  module will be called ad7606_parallel.
> +	  module will be called ad7606_par.
If we can avoid a rename that would be good.  Or was this always wrong?
If so spin a fix patch before this one.

>  
>  config AD7606_IFACE_SPI
>  	tristate "Analog Devices AD7606 ADC driver with spi interface support"
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 99d5ca5c2348..a753d5caa9f8 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -21,6 +21,7 @@
>  #include <linux/util_macros.h>
>  #include <linux/units.h>
>  
> +#include <linux/iio/backend.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
> @@ -148,7 +149,15 @@ static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned long freq)
>  
>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
> -	unsigned int num = st->chip_info->num_channels - 1;
> +	unsigned int num = st->chip_info->num_channels;
> +
> +	/*
> +	 * Timestamp channel does not contain sample, and no timestamp channel if
> +	 * backend is used.
> +	 */
> +	if (!st->back)
> +		num--;
> +
>  	u16 *data = st->data;
>  	int ret;
>  
> @@ -220,11 +229,15 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  		if (!ret)
>  			return ret;
>  	}
> -	ret = wait_for_completion_timeout(&st->completion,
> -					  msecs_to_jiffies(1000));
> -	if (!ret) {
> -		ret = -ETIMEDOUT;
> -		goto error_ret;
> +
> +	/* backend manages interruptions by itself.*/
> +	if (!st->back) {
> +		ret = wait_for_completion_timeout(&st->completion,
> +						  msecs_to_jiffies(1000));
> +		if (!ret) {
> +			ret = -ETIMEDOUT;
> +			goto error_ret;
> +		}
>  	}
>  
>  	ret = ad7606_read_samples(st);
> @@ -271,6 +284,12 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = st->oversampling;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
> +		/* If the PWM is swinging, return the real frequency, otherwise 0 */
So this only exists for the pwm case. In that case can we split the channel definitions
into versions with an without this and register just the right one.

A sampling frequency of 0 usually means no sampling, not that we can tell what it
is.  If we can't tell don't provide the file.


> +		*val = ad7606_pwm_is_swinging(st) ?
> +			DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period) : 0;
> +		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
>  }
> @@ -360,6 +379,8 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad7606_set_sampling_freq(st, val);
>  	default:
>  		return -EINVAL;
>  	}


>  static const struct iio_trigger_ops ad7606_trigger_ops = {
> @@ -602,8 +660,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> -	init_completion(&st->completion);
> -
>  	ret = ad7606_reset(st);
>  	if (ret)
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
> @@ -635,7 +691,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  			return ret;
>  	}
>  
> -	/* If convst pin is not defined, setup PWM*/
> +	/* If convst pin is not defined, setup PWM */
Push into earlier patch.  Check for this sort of fix being in wrong patch
before sending a series. It just adds noise to patch and to reviews.

>  	if (!st->gpio_convst) {
>  		st->cnvst_pwm = devm_pwm_get(dev, NULL);
>  		if (IS_ERR(st->cnvst_pwm))

...

> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index aab8fefb84be..9a098cd77812 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -34,6 +34,12 @@
>  		BIT(IIO_CHAN_INFO_SCALE),		\
>  		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
>  
> +#define AD7606_BI_CHANNEL(num)				\
> +	AD760X_CHANNEL(num, 0,				\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> +
>  #define AD7616_CHANNEL(num)	\
>  	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
>  		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> @@ -61,6 +67,7 @@ enum ad7606_supported_device_ids {
>   * @os_req_reset	some devices require a reset to update oversampling
>   * @init_delay_ms	required delay in miliseconds for initialization
>   *			after a restart
> + * @has_backend		defines if a backend is available for the given chip

That seems to me more of a case of does the driver support it.
Linux kernel code has no way of knowing if a backend hardware exists
or not.  Modify the comment to speak about if we know it works.

Or is there something fundamental that stops the backend approach
working with some devices?

Why does the driver need this flag?

>   */
>  struct ad7606_chip_info {
>  	enum ad7606_supported_device_ids id;
> @@ -71,6 +78,7 @@ struct ad7606_chip_info {
>  	unsigned int			oversampling_num;
>  	bool				os_req_reset;
>  	unsigned long			init_delay_ms;
> +	bool				has_backend;
>  };
>  


> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index d83c0edc1e31..5c8a04556e25 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -3,6 +3,8 @@
>   * AD7606 Parallel Interface ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> + * Copyright 2024 Analog Devices Inc.
> + * Copyright 2024 BayLibre SAS.
>   */
>  
>  #include <linux/mod_devicetable.h>
> @@ -11,10 +13,86 @@
>  #include <linux/types.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/pwm.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
Not on any order currently but try to minimize a future series
that might clean this up.  Preference is alphabetical though fine
to have a trailing block of IIO headers, then driver specific
ones after that. You can either fix the current order in a
separate patch, or just put your new headers in approximately the write place.

>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/backend.h>
>  #include "ad7606.h"



> +static int ad7606_bi_setup_iio_backend(struct device *dev, struct iio_dev *indio_dev)
> +{
> +		struct ad7606_state *st = iio_priv(indio_dev);
Why 2 tabs?

> +		unsigned int ret, c;
> +
> +		st->back = devm_iio_backend_get(dev, NULL);
> +		if (IS_ERR(st->back))
> +			return PTR_ERR(st->back);
> +
> +		/* If the device is iio_backend powered the PWM is mandatory */
> +		if (!st->cnvst_pwm)
> +			return -EINVAL;
> +
> +		ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_iio_backend_enable(dev, st->back);
> +		if (ret)
> +			return ret;
> +
> +		struct iio_backend_data_fmt data = {
> +			.sign_extend = true,
> +			.enable = true,
> +		};
> +		for (c = 0; c < indio_dev->num_channels; c++) {
> +			ret = iio_backend_data_format_set(st->back, c, &data);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		indio_dev->channels = ad7606b_bi_channels;
> +		indio_dev->num_channels = 8;
> +
> +		return 0;
> +}
> +
> +static const struct ad7606_bus_ops ad7606_bi_bops = {
> +	.iio_backend_config = ad7606_bi_setup_iio_backend,
> +	.update_scan_mode = ad7606_bi_update_scan_mode,
> +};
> +#endif
> +
>  static int ad7606_par16_read_block(struct device *dev,
>  				   int count, void *buf)
>  {
> @@ -52,7 +130,20 @@ static int ad7606_par_probe(struct platform_device *pdev)
>  	void __iomem *addr;
>  	resource_size_t remap_size;
>  	int irq;
> -
> +#ifdef CONFIG_IIO_BACKEND
> +	struct iio_backend *back;
> +
> +	/*For now, only the AD7606B is backend compatible.*/
/* For ... ble. */

> +	if (chip_info->has_backend) {
> +		back = devm_iio_backend_get(&pdev->dev, NULL);
> +		if (IS_ERR(back))
> +			return PTR_ERR(back);
> +
> +		return ad7606_probe(&pdev->dev, 0, NULL,
> +				    chip_info,
> +				    &ad7606_bi_bops);

Short wrap. Aim for 80 char limit unless it hurts readability a lot.

> +	}
> +#endif
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> @@ -74,6 +165,7 @@ static const struct platform_device_id ad7606_driver_ids[] = {
>  	{ .name	= "ad7606-4", .driver_data = (kernel_ulong_t)&ad7606_4_info, },
>  	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
>  	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
> +	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
> @@ -83,6 +175,7 @@ static const struct of_device_id ad7606_of_match[] = {
>  	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_info },
>  	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
>  	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
> +	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ad7606_of_match);
> @@ -102,3 +195,6 @@ MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(IIO_AD7606);
> +#ifdef CONFIG_IIO_BACKEND
> +MODULE_IMPORT_NS(IIO_BACKEND);

I'd not bother with config guards.  Importing a namespace we don't
use should be harmless.

> +#endif
> 


