Return-Path: <linux-pwm+bounces-3731-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA09A4ED6
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0831F26DC3
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418B315CD49;
	Sat, 19 Oct 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6xRTEFU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D876C623;
	Sat, 19 Oct 2024 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349426; cv=none; b=S0SvG2suvFwC2ObE2R2CcpKwLOT2FiI868bXbdww9SEux1hjuPFlacbY9FuT5Gsaj4OyEKvAYL2EFqmYI229MnU0CmOn2JFIe0VFsMXMN24vFC8yZBBOARvCTYLqiWs9f2Rs/x57ll8wFjuMQYay71V97UtNfqhOjjogQAsMy58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349426; c=relaxed/simple;
	bh=GazNkts+JzgMhEAJWcSa5fM19KC1ZaNSZ/AO72xlmZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayg9c3KGHSmKPC8wYV90E0QlqfKx+actQE4qJ1I7nyJ3F+RmX0PH4c+aIey7a46oHmgzvXaSyaPsfLBFcgQcKvQDTiwScrz7wf2DvH5A5r+YTbRo/3lADKq0LQ86mk1ifV9/IuGJF3vAjyCGTwtofDYazCReQ/OoaDS9JealuQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6xRTEFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B099C4CEC5;
	Sat, 19 Oct 2024 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729349425;
	bh=GazNkts+JzgMhEAJWcSa5fM19KC1ZaNSZ/AO72xlmZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q6xRTEFUEtdHVCWHVykDfiFSbOR+mFflVM/YaU8g7SoUhcsnCaZqq5JPB/NSSvYh4
	 8+N6iSvNkXVR68wZcm8lTTCjZtGjzfTu8Ar9+G4Ay2nPGXUcP+whxYHShvjZaIBmV4
	 tx3bV8QVhExYLdMhbigo5bsBHrMbxYL4cKI+6DRffGUC0AFWk6Kbsxtyl+H1uT3Yf0
	 Ac2shQhEkOnph3rnYaFZGgAku2e6h7oIoMcIcYX4bY8IZw4EUwQLMe/RhNCLwCmY+5
	 GI9DFXYGJgaQRSJmvS63Ei7vz2CNahlELhPTtM1BRvXnqBuMdhrDByig5tdCKUm0V+
	 dHeINcRlXZayA==
Date: Sat, 19 Oct 2024 15:49:20 +0100
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
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com,
 nuno.sa@analog.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 4/8] iio: adc: ad7606: Add PWM support for conversion
 trigger
Message-ID: <20241019154920.64797b16@jic23-huawei>
In-Reply-To: <20241015-ad7606_add_iio_backend_support-v5-4-654faf1ae08c@baylibre.com>
References: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
	<20241015-ad7606_add_iio_backend_support-v5-4-654faf1ae08c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 13:56:17 +0000
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
Trivial fix needed so this builds.

>  static int ad7606_read_samples(struct ad7606_state *st)
>  {
>  	unsigned int num = st->chip_info->num_channels - 1;
> @@ -324,7 +393,13 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>  error_ret:
>  	iio_trigger_notify_done(indio_dev->trig);
>  	/* The rising edge of the CONVST signal starts a new conversion. */
> -	gpiod_set_value(st->gpio_convst, 1);
> +	if (st->gpio_convst) {
> +		gpiod_set_value(st->gpio_convst, 1);
> +	} else {
> +		ret = ad7606_pwm_set_high(st)
Missing ;

> +		if (ret < 0)
> +			dev_err(st->dev, "Could not set PWM to high.");
> +	}

