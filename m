Return-Path: <linux-pwm+bounces-5971-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA9AB59D1
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 18:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC73D7B2298
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E0C2BEC3B;
	Tue, 13 May 2025 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftbyYkUd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85212BEC2F;
	Tue, 13 May 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153589; cv=none; b=lMbjigOUUV4gd8OBA7Y3wefWwkXQyY04z3lYFEltBysXrRNq46wMQ2VrFWcr14tSDmbZHXsGM2HJDtZwsUbrclm64jHgMxlbd0XVjBa9GAAuoS737Z5qEqxVCbHKKkJUtojBrnPEnIXy/jI97nO5cwGYJmOvgFJbUlTyN9ff21s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153589; c=relaxed/simple;
	bh=fOF8sy8iZquy2qTBP2SKHak8+By98mcNoTi6gQlT5io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1q+A2gRd2NFI6tOFo6VJSQjIrt2p26xBU8TgEHnEGBT8rxn6rVgxpLOP9Z1o20NU35MAlPq8tWjrUxtaKVaGPQn6RMjrulx83xa/qIH3tRIE8XSPqL8Y76VahELPyCQPBFGjioekfR2UXH5wNaLSOwACur4LIE6Op6dM5SM4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftbyYkUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEB0C4CEE4;
	Tue, 13 May 2025 16:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747153588;
	bh=fOF8sy8iZquy2qTBP2SKHak8+By98mcNoTi6gQlT5io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftbyYkUduy5VmYwoOz29GNR4p//6oLXt5V/jN9fQNAMU5McYyZjWnEwn3s1ViWF+z
	 5OVDIcoIf/a8uBnf4s5pN9rxzMDt4YJodc8gKpCFf9lRU3rCQ3mlQ2HAlBHrY/dDuT
	 u7xI9+PWdXxymEahKHZiii83DSm2PnfqjKr2ToP1ANkXIm03+03N2/tW/i+D/mIAwg
	 TQb9WQ/g70CLbyZJ5G/TvfBeZ8GDtiZnqhEAjOxaLmWjasULoE60mCdGNaIjamA1+3
	 DV67M4279GOA8wgobOlTZ+SyYnMJoeuT/RsItIG6XvcfvZ9WIbilamCXM3I9dlzR6s
	 qlWxJmZkBvH2w==
Date: Tue, 13 May 2025 17:26:22 +0100
From: Lee Jones <lee@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 21/22] mfd: adp5585: add support for a reset pin
Message-ID: <20250513162622.GW2936510@google.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-21-092b14b79a88@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512-dev-adp5589-fw-v3-21-092b14b79a88@analog.com>

On Mon, 12 May 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> Make sure to perform an Hardware reset during probe  if the pin is given
> in FW.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> index 88401668f30e06ac201175470eeaf6216f3121d9..0fbe1f7f2582408b2e1b99f629182ceebce73fd7 100644
> --- a/drivers/mfd/adp5585.c
> +++ b/drivers/mfd/adp5585.c
> @@ -11,6 +11,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mfd/adp5585.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mod_devicetable.h>
> @@ -712,6 +713,7 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct regmap_config regmap_config;
>  	struct adp5585_dev *adp5585;
> +	struct gpio_desc *gpio;
>  	struct mfd_cell *devs;
>  	unsigned int id;
>  	int ret, n_devs;
> @@ -730,6 +732,20 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
>  	if (ret)
>  		return ret;
>  
> +	gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio))
> +		return PTR_ERR(gpio);
> +
> +	/*
> +	 * Note the timings are not documented anywhere in the DS. They are just

It's okay, you can say "datasheet". :)

> +	 * reasonable values that work...

What does "..." mean in this context?

> +	 */
> +	if (gpio) {
> +		fsleep(30);
> +		gpiod_set_value_cansleep(gpio, 0);
> +		fsleep(60);
> +	}
> +
>  	adp5585->regmap = devm_regmap_init_i2c(i2c, &regmap_config);
>  	if (IS_ERR(adp5585->regmap))
>  		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

