Return-Path: <linux-pwm+bounces-3393-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393EB989567
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3F21C2196D
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA7817839C;
	Sun, 29 Sep 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHVI68TM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075D224F0;
	Sun, 29 Sep 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613564; cv=none; b=gybd++GCHQua6KJrllsDcHlVkeAxGc7x3I/ssuaIRceHCq3fREJZ5mZ6aiAypob0zsgD4y9dFoF594fhkHqDQG0UDUMLqhmpsbBrij5VTTSc+XZZPDzh5GGsY5JdU8qjmWaGK9FIvMMvChc485dvQJlIxgc6Cw1fXgxTqy8jp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613564; c=relaxed/simple;
	bh=jNv5z8QqxRQzjIYAb5hFYYoRIN8oLgkaAvCViwwZ5f4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oT2xOM+AynxEr09l6Xp484Q9yOiT2TVbumZTmPyWuJq65b1CuXWoxSKq5FvgD3oeXLl5XbFcBWS9EVQ3+jJhDq0zozSEgrRcp0pvLKKd8LZkPvoK8CERD9tWwH/y6s5IwYOfa1VmJZAfyyxvijK0BO8YKgJnfAOCkyPRwsHUnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHVI68TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BABFC4CEC5;
	Sun, 29 Sep 2024 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727613563;
	bh=jNv5z8QqxRQzjIYAb5hFYYoRIN8oLgkaAvCViwwZ5f4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHVI68TM/lsVgtNf7DBfnqXnfAVt5l85+ktK/plHvWkxD66jv39g/tRADWW0DvSqZ
	 6RtIN6+gt+as3NAiL5kfF9GZMhmI7Au/qvUzebAgq1o/kxfEr2vovJSFmU3JhyWQWI
	 VdhhuWJycM5JoJyPaJSIvSp8gM9saMJJbKchxoqkD3sL1WKW2obFgJ/gScWqh43/OZ
	 ASc1JebGQGPUbb4uh2OFBvRNBfSW6g4hWrCNJPxPhT7MEGH8Dz7SytiKsVar0GNJXW
	 0C34X4TCOoGXyoBUqjLW3LEqqfILh7RYUE3AHosTuqbfIfaUtAeVmZFGK23JTh45Qo
	 cYJVF4OBzAWrg==
Date: Sun, 29 Sep 2024 13:39:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michal Marek
 <mmarek@suse.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com
Subject: Re: [PATCH v2 06/10] iio: adc: ad7606: Add PWM support for
 conversion trigger
Message-ID: <20240929133913.43ba8572@jic23-huawei>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-6-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
	<20240920-ad7606_add_iio_backend_support-v2-6-0e78782ae7d0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 17:33:26 +0000
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
Spell check patch descriptions.  conjunction

Note this is a do as I say, not as I do because my spelling is terrible and
I frequently forget to check them.

A few trivial things inline.

Jonathan

> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 170 ++++++++++++++++++++++++++++++++++++++++-------
>  drivers/iio/adc/ad7606.h |   2 +
>  2 files changed, 148 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 9b457472d49c..b98057138295 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -13,11 +13,13 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
> +#include <linux/pwm.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/util_macros.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -83,6 +85,80 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ad7606_pwm_set_high(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +
> +	if (!st->cnvst_pwm)
> +		return -EINVAL;

Trivial but add a blank line here to separate the sanity check from the
guts of the function.

> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	cnvst_pwm_state.enabled = true;
> +	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
> +
> +	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
> +}
> +
> +static int ad7606_pwm_set_low(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +
> +	if (!st->cnvst_pwm)
> +		return -EINVAL;

Likewise blank line here.

> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	cnvst_pwm_state.enabled = true;
> +	cnvst_pwm_state.duty_cycle = 0;
> +
> +	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
> +}
> +
> +static int ad7606_pwm_set_swing(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +
> +	if (!st->cnvst_pwm)
> +		return -EINVAL;
> +
> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	cnvst_pwm_state.enabled = true;
> +	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
> +
> +	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
> +}
> +
> +static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
> +{
> +	struct pwm_state cnvst_pwm_state;
> +
> +	if (!st->cnvst_pwm)
> +		return false;
And here.

> +	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +	return cnvst_pwm_state.duty_cycle != cnvst_pwm_state.period &&
> +	       cnvst_pwm_state.duty_cycle != 0;
> +}
> @@ -130,7 +219,12 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
>  	ret = ad7606_read_samples(st);
>  	if (ret == 0)
>  		ret = st->data[ch];
> -

I'd keep a blank line here as this code unconnected to previous block.

> +	if (!st->gpio_convst) {
> +		if (!pwm_swings)
> +			ret = ad7606_pwm_set_low(st);
> +		else
> +			ret = ad7606_pwm_set_swing(st);
> +	}
>  error_ret:
>  	gpiod_set_value(st->gpio_convst, 0);



