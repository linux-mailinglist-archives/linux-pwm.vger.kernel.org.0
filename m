Return-Path: <linux-pwm+bounces-3397-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A1989590
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 14:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9202829D0
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Sep 2024 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645017AE1D;
	Sun, 29 Sep 2024 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW96i+yJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2387166F3D;
	Sun, 29 Sep 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727614575; cv=none; b=GDc83ugMl/d0OSyMMed6qx8P9jaKrdvg2S9rAqRIz0A+V9pmg7t+JCh7S0PVdq/z4CVuJbKDNTCANr4Tf3s1TlnS+ufBJeLkjsdIf1vXcbk1Nt+c5IvEU+FRP5XGuxEegp+UN5g+hULBCvsJj1vRZgWzeN1D/9M3u7NqfkwHdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727614575; c=relaxed/simple;
	bh=OfJqlFNVcOO6gyMyiuZtizh6vUe7XaDZBBLuSJQG+II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJDjyYTjQPnJtQUAX+wfIB6memwQyu/1+5p8JwEndd+/P+9x7+g/X9vMP7PRwhX8KF0vvArD5wThnyGX9U6Z97cxnxlZM6x11lG/ng3ayVy/V2lv4LyMslpMpU/7/Cpb2AJPnW0iegrFsINCHzcozm9JTbEVtcvfuLxqJotXxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW96i+yJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E7BC4CEC5;
	Sun, 29 Sep 2024 12:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727614575;
	bh=OfJqlFNVcOO6gyMyiuZtizh6vUe7XaDZBBLuSJQG+II=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BW96i+yJ7/gJrIhP2a6zLCQyS1oGaZH7JMGSnLoMdqBqRriseT4Ipxv6KWwbnmx3a
	 91+JerPM9z4ZjPQCGHjfE8DD1X5UA/PlRKeyAS775KeQ+LM/t7zukeugXot0gGUS/P
	 GV8s5Bd1HSxjCERvZx6Y+UZzkECyp6KvMKvgsPH1G75LjLTPV/w7vC4nFtH3KozVVo
	 oQBOBVhD7fOAXO2jAt58fuIOVliTtZ52KretLnwCDsTykeDJTGxc23c18zdUV+NVzy
	 A79DZ7iuvs0yTbNX6SnwG6Vu56hJNUAjYO0FDbuBz30QiHcUfhIfskmWzmzgZfePDi
	 +tsWxA3VAzrlg==
Date: Sun, 29 Sep 2024 13:56:03 +0100
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
Subject: Re: [PATCH v2 10/10] iio: adc: ad7606: Disable PWM usage for non
 backend version
Message-ID: <20240929135603.0ceb6cfc@jic23-huawei>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-10-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
	<20240920-ad7606_add_iio_backend_support-v2-10-0e78782ae7d0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 17:33:30 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Since the pwm was introduced before backend, there was an example use
> whit triggered buffers. However, using it may be dangerous, because if
> the PWM goes too fast, a new conversion can be triggered before the
> transmission is over, whit the associated mess in the buffers.
> Until a solution is found to mitigate this risk, for instante CRC
> support, the PWM will be disabled.
> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

Whilst I can see the logic introducing it in two steps, maybe
shout a bit more about that in the original patch as otherwise
some foolish unnamed maintainer might pick up part of this series
leaving things in a bad state for a kernel release.

The earlier patch 'recommends' it isn't used which is a bit week.
Say support is going to be removed later.
> ---
>  drivers/iio/adc/ad7606.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index f710445bdc22..0c12ca237ee9 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -599,7 +599,6 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
>  	gpiod_set_value(st->gpio_convst, 1);
> -	ad7606_pwm_set_swing(st);
>  
>  	return 0;
>  }
> @@ -609,7 +608,6 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
>  	gpiod_set_value(st->gpio_convst, 0);
> -	ad7606_pwm_set_low(st);
>  
>  	return 0;
>  }
> @@ -838,6 +836,12 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		indio_dev->setup_ops = &ad7606_pwm_buffer_ops;
>  	} else {
>  		init_completion(&st->completion);
> +
> +		/* Reserve the PWM use only for backend (force gpio_convst definition) */
> +		if (!st->gpio_convst)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "No backend, connect convst to a GPIO");
> +
>  		ret = devm_request_threaded_irq(dev, irq,
>  						NULL,
>  						&ad7606_interrupt,
> 


