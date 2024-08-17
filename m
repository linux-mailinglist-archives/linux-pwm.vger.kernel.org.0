Return-Path: <linux-pwm+bounces-3032-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6F49558A9
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 17:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EB5282A21
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Aug 2024 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F13144315;
	Sat, 17 Aug 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsMie/Gn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE678C0B;
	Sat, 17 Aug 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723908593; cv=none; b=BteVMzwlLWd7TUgO3yEFEzyx8EEgocXfUaj/n7PJd8Tous6svoaFTG9OxtZUmnoLEMVY+RlohVVTqjOgRQRle/gw28RzxPUpra6b6O2t0YKlyF2umaWRGyIN8rzHa+JX40etoNuQ8rKvKLKl6e9ErPocs5dgEvZEi8cv9E55Wvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723908593; c=relaxed/simple;
	bh=1RKDCpzCGu84I/lej7Efkj6WIVoEwnzYEjR9k/aXkoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEKQijXHkF8gLoMN6P024It1rqyr9NoLsRXGrEHrpS1vKWMGzvzvC5UqsnvHy7WO15SbyUzoet/Ol4Cdsc0sNp3KEGwlErVqc8ZYLP09q5ogdclU6P7qsSMJlBPGjXxRGlCJZQ8TKlV+eXLApCYGNnBYkefJl/T+JslkoIfu3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsMie/Gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6E6C116B1;
	Sat, 17 Aug 2024 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723908592;
	bh=1RKDCpzCGu84I/lej7Efkj6WIVoEwnzYEjR9k/aXkoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OsMie/GnkEA7sssNwcOhMEZvKpN2+OeGZCSaB136uIqYHXrQzG1YPYYV38K37l3S2
	 xz0x//PrDBf1Cll/XH38rXLq3lykxiOfYN2j3N09F0rRZzLlVb0DmUM0il4OPOgsni
	 mojHW03otFbuXy8g3N1KxOmUSkDpK1PdVM9ZQkxVbRbJ/okS2M9qHRlZfb+3pC6Hfl
	 mbKxd4rkZd4CTDlSlXKbbNPK7whcAvftQtS8dYDXrvueKSwS6e+axB6dqZPyG87H8S
	 TuCJxlj74uXR7119p9uGeVY6h/XwjVPkkhNra88haU3P6mnTA+FADd/atficJ7LkB1
	 ItU2gsfwmVYEg==
Date: Sat, 17 Aug 2024 16:29:42 +0100
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
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com
Subject: Re: [PATCH 6/8] iio: adc: ad7606: Add PWM support for conversion
 trigger
Message-ID: <20240817162942.7fb95484@jic23-huawei>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-6-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
	<20240815-ad7606_add_iio_backend_support-v1-6-cea3e11b1aa4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:12:00 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Until now, the conversion were triggered by setting high the GPIO
> connected to the convst pin. This commit gives the possibility to
> connect the convst pin to a PWM.
> Connecting a PWM allows to have a better control on the samplerate,
> but it must be handled with care, as it is completely decorrelated of
> the driver's busy pin handling.
> Hence it is not recommended to be used "as is" but must be exploited
> in conjonction with IIO backend, and for now only a sampling frequency
> of 2 kHz is available.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Hi,

A few comments inline. I'm not particularly familiar with PWM
controls though so that bit could do with more eyes.

Jonathan

> ---

> +
> +static int ad7606_pwm_set_swing(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +
> +	if (!st->cnvst_pwm)
> +		return -EINVAL;
Blank line here and in similar cases where we have unrelated blocks
of code otherwise with no line between them.


> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	cnvst_pwm_state.enabled = true;
> +	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
> +	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
> +}
> +
> +static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +
> +	if (!st->cnvst_pwm)
> +		return false;

Blank line here.

> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	return cnvst_pwm_state.duty_cycle != cnvst_pwm_state.period &&
> +	       cnvst_pwm_state.duty_cycle != 0;
> +}
> +
> +static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned long freq)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +	bool is_swinging = ad7606_pwm_is_swinging(st);
> +	bool is_high;
> +
> +	if (freq == 0)
> +		return -EINVAL;
> +
> +	/*Retrieve the previous state */
/* Ret

> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	is_high = cnvst_pwm_state.duty_cycle == cnvst_pwm_state.period;
> +
> +	cnvst_pwm_state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> +	cnvst_pwm_state.polarity = PWM_POLARITY_NORMAL;
> +	if (is_high)
> +		cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
> +	else if (is_swinging)
> +		cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
> +
> +	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
> +}
> +
>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
>  	unsigned int num = st->chip_info->num_channels - 1;
> @@ -141,9 +213,21 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>  static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> +	struct pwm_state cnvst_pwm_state;
>  	int ret;
> +	bool pwm_swings = false;
>  
> -	gpiod_set_value(st->gpio_convst, 1);
> +	if (st->gpio_convst) {
> +		gpiod_set_value(st->gpio_convst, 1);
> +	} else {
> +		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +		/* Keep the current PWM state to switch it back off if needed*/
needed */

also back on or off I guess?

> +		if (ad7606_pwm_is_swinging(st))
> +			pwm_swings = true;
> +		ret = ad7606_pwm_set_high(st);
> +		if (!ret)
> +			return ret;
> +	}
>  	ret = wait_for_completion_timeout(&st->completion,
>  					  msecs_to_jiffies(1000));
>  	if (!ret) {
> @@ -154,7 +238,12 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  	ret = ad7606_read_samples(st);
>  	if (ret == 0)
>  		ret = st->data[ch];
> -
> +	if (!st->gpio_convst) {
> +		if (!pwm_swings)
> +			ret = ad7606_pwm_set_low(st);
> +		else
> +			ret = ad7606_pwm_set_swing(st);
> +	}
>  error_ret:
>  	gpiod_set_value(st->gpio_convst, 0);



> +static void ad7606_pwm_disable(void *data)
> +{
> +	pwm_disable(data);
> +}
> +
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops)
> @@ -635,20 +733,42 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  			return ret;
>  	}
>  
> -	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> -					  indio_dev->name,
> -					  iio_device_id(indio_dev));
> -	if (!st->trig)
> -		return -ENOMEM;
> -
> -	st->trig->ops = &ad7606_trigger_ops;
> -	iio_trigger_set_drvdata(st->trig, indio_dev);
> -	ret = devm_iio_trigger_register(dev, st->trig);
> -	if (ret)
> -		return ret;
> -
> -	indio_dev->trig = iio_trigger_get(st->trig);
> +	/* If convst pin is not defined, setup PWM*/
PWM */

> +	if (!st->gpio_convst) {
> +		st->cnvst_pwm = devm_pwm_get(dev, NULL);
> +		if (IS_ERR(st->cnvst_pwm))
> +			return PTR_ERR(st->cnvst_pwm);
> +		ret = devm_add_action_or_reset(dev, ad7606_pwm_disable,

Add a comment on why we are registering devm based disabling here.
I'm not sure where matching enable is.

> +					       st->cnvst_pwm);
> +		if (ret)
> +			return ret;
>  
> +		/*
> +		 * Set the sampling rate to 2 kHz so to be sure that the interruption can be
> +		 * handled between within a single pulse.
> +		 */
> +		ret = ad7606_set_sampling_freq(st, 2 * KILO);
> +		if (ret)
> +			return ret;
> +	} else {
> +		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						  indio_dev->name,
> +						  iio_device_id(indio_dev));
> +		if (!st->trig)
> +			return -ENOMEM;
> +		st->trig->ops = &ad7606_trigger_ops;
> +		iio_trigger_set_drvdata(st->trig, indio_dev);
> +		ret = devm_iio_trigger_register(dev, st->trig);
> +		if (ret)
> +			return ret;
> +		indio_dev->trig = iio_trigger_get(st->trig);
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						      &iio_pollfunc_store_time,
> +						      &ad7606_trigger_handler,
> +						      &ad7606_buffer_ops);
> +		if (ret)
> +			return ret;
> +	}
>  	ret = devm_request_threaded_irq(dev, irq,
>  					NULL,
>  					&ad7606_interrupt,
> @@ -657,13 +777,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      &iio_pollfunc_store_time,
> -					      &ad7606_trigger_handler,
> -					      &ad7606_buffer_ops);
> -	if (ret)
> -		return ret;
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(ad7606_probe, IIO_AD7606);
> @@ -693,7 +806,6 @@ static int ad7606_resume(struct device *dev)
>  		gpiod_set_value(st->gpio_standby, 1);
>  		ad7606_reset(st);
>  	}
> -
Check for spurious noisy whitespace cleanup in patches.
it doesn't belong in a patch doing anything other that whitespace
changes.

>  	return 0;
>  }
>  
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 0c6a88cc4695..60bac1894a91 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -38,6 +38,8 @@
>  	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
>  		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
>  
> +struct pwm_device		*cnvst_pwm;

I'm going to guess that this started global then some internal review
or you guessed that wasn't going anywhere and added it to the state
structure below.  Then forgot to clean this up.
Anyhow this is correctly unused, get rid of it.

> +
>  /**
>   * struct ad7606_chip_info - chip specific information
>   * @channels:		channel specification
> @@ -94,6 +96,7 @@ struct ad7606_state {
>  	const struct ad7606_bus_ops	*bops;
>  	unsigned int			range[16];
>  	unsigned int			oversampling;
> +	struct pwm_device		*cnvst_pwm;
This structure had docs that need updating.

>  	void __iomem			*base_address;
>  	bool				sw_mode_en;
>  	const unsigned int		*scale_avail;
> 


