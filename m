Return-Path: <linux-pwm+bounces-3490-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299C991688
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 13:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764BA1C218BB
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Oct 2024 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105714AD0E;
	Sat,  5 Oct 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+/MGrsN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EC3F9C5;
	Sat,  5 Oct 2024 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728128449; cv=none; b=WCvORY0yuzuxpvfGSHkoORGnIwJ63vobNMIB3Je3vdkUKZuy2BMMpgcbDAga8rZqCjy6PA0ovd1n1Kplhdy1aeMUng6M/jRZXj2wYNr/2WNteB2aFfvPzPASpb0hcn9+GAuSPQuQ8GOwTrsZz/iRFEo1o9/+7MoBLs4m16/PpIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728128449; c=relaxed/simple;
	bh=KoXZp5Z1MRtJTgzX5BAlyJxAJSikVi2jOrXgPjYZtoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q24DOLsKudZo328DB9+vipf9T3HHIPJxRyCgwKIRLP6G9t4c7s6b6JJPVLC8Pk0ylC9SYgj+Loc64GmB5Cai8ea7fFid7gSl7vehVbJV/9yFlTEZjq5geEh1yPcFXRZOKzzwTLORNl7GkPwNzYhRffW+gLi9hqLDoEXr6R4LGdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+/MGrsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43348C4CEC2;
	Sat,  5 Oct 2024 11:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728128448;
	bh=KoXZp5Z1MRtJTgzX5BAlyJxAJSikVi2jOrXgPjYZtoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f+/MGrsNUSZYpUA0ju9htUARS4HjVUipXjKMsuwo3B+PL4QGGFBJZexNeFLyN8Ph3
	 j6F6TxeJ/ANaDOba9gG6rAt3C5pv8SZSSXOrioPRNmUFh94H8feVJGuq1ZvtSNLrbu
	 BMjxTm+Pw2QODbDSyXg8kbI/VLNIzaC5stPcZsrd+GhQOHswu36CKHfabbyAfb2+4i
	 bhP40EsGWkZiUisnTJdpie+Hm+TBXZ1hC0fTNpopNQA3ADKn2bg9047BXNR6JN5OFy
	 22Go26r1dMWX10PGS6wwqGgoyR8DH/oThAQRHFRisPTs7y1xnf9pVGW/6lBFIYvvSY
	 Y+5rT8x3626yw==
Date: Sat, 5 Oct 2024 12:40:36 +0100
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
 aardelean@baylibre.com, dlechner@baylibre.com, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 06/10] iio: adc: ad7606: Add PWM support for
 conversion trigger
Message-ID: <20241005124036.5a09367a@jic23-huawei>
In-Reply-To: <20241004-ad7606_add_iio_backend_support-v3-6-38757012ce82@baylibre.com>
References: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
	<20241004-ad7606_add_iio_backend_support-v3-6-38757012ce82@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Oct 2024 21:48:40 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Until now, the conversion were triggered by setting high the GPIO
> connected to the convst pin. This commit gives the possibility to
> connect the convst pin to a PWM.
> Connecting a PWM allows to have a better control on the samplerate,
> but it must be handled with care, as it is completely decorrelated of
> the driver's busy pin handling.
> Hence it is not recommended to be used "as is" but must be exploited
> in conjunction with IIO backend, and for now only a mock functionality
> is enabled, i.e PWM never swings, but is used as a GPIO, i.e duty_cycle
> == period equals high state, duty_cycle == 0 equals low state.
> 
> This mock functionality will be disabled after the IIO backend usecase
> is introduced.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
If you reroll for other reasons a few trivial comments inline

J
> ---
>  drivers/iio/adc/ad7606.c | 164 ++++++++++++++++++++++++++++++++++++++++-------
>  drivers/iio/adc/ad7606.h |   2 +
>  2 files changed, 144 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index d1aec53e0bcf..224ffaf3dbff 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -13,10 +13,12 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
> +#include <linux/pwm.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> +#include <linux/units.h>
>  #include <linux/util_macros.h>
>  
>  #include <linux/iio/buffer.h>
> @@ -299,6 +301,82 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
>  	}
>  }
>  


>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops)
> @@ -951,20 +1050,48 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	if (ret)
>  		return ret;
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
> +	/* If convst pin is not defined, setup PWM. */
> +	if (!st->gpio_convst) {
> +		st->cnvst_pwm = devm_pwm_get(dev, NULL);
> +		if (IS_ERR(st->cnvst_pwm))
> +			return PTR_ERR(st->cnvst_pwm);

As below. Blank line preferred here.

> +		/* The PWM is initialized at 1MHz to have a fast enough GPIO emulation. */
> +		ret = ad7606_set_sampling_freq(st, 1 * MEGA);
> +		if (ret)
> +			return ret;
>  
> -	indio_dev->trig = iio_trigger_get(st->trig);
> +		ret = ad7606_pwm_set_low(st);
> +		if (ret)
> +			return ret;
>  
> +		/*
> +		 * PWM is not disabled when sampling stops, but instead its duty cycle is set
> +		 * to 0% to be sure we have a "low" state. After we unload the driver, let's
> +		 * disable the PWM.
> +		 */
> +		ret = devm_add_action_or_reset(dev, ad7606_pwm_disable,
> +					       st->cnvst_pwm);
> +		if (ret)
> +			return ret;
> +	} else {
> +		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						  indio_dev->name,
> +						  iio_device_id(indio_dev));
> +		if (!st->trig)
> +			return -ENOMEM;

Blank line preferred here.  Generally it helps readability a little to
have one after any 'do something and check for errors block'.


> +		st->trig->ops = &ad7606_trigger_ops;
> +		iio_trigger_set_drvdata(st->trig, indio_dev);
> +		ret = devm_iio_trigger_register(dev, st->trig);
> +		if (ret)
> +			return ret;

It we are rerolling for any other reason add a blank line here too.
If not I might tweak whilst applying or might not bother..

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
> @@ -973,13 +1100,6 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
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


