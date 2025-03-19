Return-Path: <linux-pwm+bounces-5237-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C7A6859C
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 08:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAF217893E
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 07:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C0212FB5;
	Wed, 19 Mar 2025 07:16:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC06158DD4;
	Wed, 19 Mar 2025 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742368563; cv=none; b=DPUGQuIAanzo4JM+eL3EDoXYUV3KLuLXP3INcUSOsMCLfTovsvOwZXRfmeBwhs5ovSSiKqKKqm0Czj4hHWjNkgYZvpOB1HMcSKA/8aJOVHMr3Ns8Xuaxvhlb5acBZacZVEtlCnXYELEyh8n1/Fx0FQ2DKEiaQoVMmuh9DFiRORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742368563; c=relaxed/simple;
	bh=twxEXN+zS1pPm3HtYqQyQXyi8XjLzXje+sYlHiLVYa8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=WW2WjArDMx0y/IeDtBFnj2t5Xr6E2mspv6qfwR5s6tG171M0cVbn5X7pUkF3poRaOiLGE3JSkDZQNum0zdUby4MOhQH0oSHfUtnvfl9WEJX3hYGfTZ4oNq/HQPVxWxXb8A3eBsB1KCvmOg/CqeVzieoFzMS/KckCW3M0LIV96T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 12ADE3B8;
	Wed, 19 Mar 2025 08:15:58 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 08:15:57 +0100
Message-Id: <D8K23TCWC5TO.3T1YPKL3G0OY5@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.16.0
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
In-Reply-To: <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>

Hi,

> GPIO controller often have support for IRQ: allow to easily allocate
> both gpio-regmap and regmap-irq in one operation.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  drivers/gpio/gpio-regmap.c  | 23 +++++++++++++++++++++--
>  include/linux/gpio/regmap.h | 15 +++++++++++++++
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index 05f8781b5204..61d5f48b445d 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -203,6 +203,7 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
>   */
>  struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config=
 *config)
>  {
> +	struct irq_domain *irq_domain;
>  	struct gpio_regmap *gpio;
>  	struct gpio_chip *chip;
>  	int ret;
> @@ -280,8 +281,26 @@ struct gpio_regmap *gpio_regmap_register(const struc=
t gpio_regmap_config *config
>  	if (ret < 0)
>  		goto err_free_gpio;
> =20
> -	if (config->irq_domain) {
> -		ret =3D gpiochip_irqchip_add_domain(chip, config->irq_domain);
> +	irq_domain =3D config->irq_domain;
> +#ifdef CONFIG_GPIOLIB_IRQCHIP

Why do we need this ifdef?

> +	if (config->regmap_irq_chip) {
> +		struct regmap_irq_chip_data *irq_chip_data;
> +
> +		ret =3D devm_regmap_add_irq_chip_fwnode(config->parent, dev_fwnode(con=
fig->parent),
> +						      config->regmap, config->regmap_irq_irqno,
> +						      config->regmap_irq_flags, 0,
> +						      config->regmap_irq_chip, &irq_chip_data);
> +		if (ret)
> +			goto err_free_gpio;
> +
> +		irq_domain =3D regmap_irq_get_domain(irq_chip_data);
> +		if (config->regmap_irq_chip_data)
> +			*config->regmap_irq_chip_data =3D irq_chip_data;

I'm not a fan of misusing the config to return any data. Can we have
a normal gpio_regmap_get_...()? Usually, the config is on the stack
of the caller, what if you need to get irq_chip_data afterwards?
Then your caller has to save it somewhere.

Also, what is the advantage of this? Your caller doesn't have to
call devm_regmap_add_irq_chip_fwnode(), but on the flip side you
have to cram all its parameters in the gpio_regmap config. I'd like
to keep that small and simple (but still extensible!). IMHO just
setting the irq_domain is enough to achieve that.

-michael

> +	}
> +#endif
> +
> +	if (irq_domain) {
> +		ret =3D gpiochip_irqchip_add_domain(chip, irq_domain);
>  		if (ret)
>  			goto err_remove_gpiochip;
>  	}
> diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
> index a9f7b7faf57b..55df2527b982 100644
> --- a/include/linux/gpio/regmap.h
> +++ b/include/linux/gpio/regmap.h
> @@ -40,6 +40,14 @@ struct regmap;
>   * @drvdata:		(Optional) Pointer to driver specific data which is
>   *			not used by gpio-remap but is provided "as is" to the
>   *			driver callback(s).
> + * @regmap_irq_chip:	(Optional) Pointer on an regmap_irq_chip structure.=
 If
> + *			set, a regmap-irq device will be created and the IRQ
> + *			domain will be set accordingly.
> + * @regmap_irq_chip_data: (Optional) Pointer on an regmap_irq_chip_data
> + *                      structure pointer. If set, it will be populated =
with a
> + *                      pointer on allocated regmap_irq data.
> + * @regmap_irq_irqno	(Optional) The IRQ the device uses to signal interr=
upts.
> + * @regmap_irq_flags	(Optional) The IRQF_ flags to use for the interrupt=
.
>   *
>   * The ->reg_mask_xlate translates a given base address and GPIO offset =
to
>   * register and mask pair. The base address is one of the given register
> @@ -78,6 +86,13 @@ struct gpio_regmap_config {
>  	int ngpio_per_reg;
>  	struct irq_domain *irq_domain;
> =20
> +#ifdef CONFIG_GPIOLIB_IRQCHIP
> +	struct regmap_irq_chip *regmap_irq_chip;
> +	struct regmap_irq_chip_data **regmap_irq_chip_data;
> +	int regmap_irq_irqno;
> +	unsigned long regmap_irq_flags;
> +#endif
> +
>  	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
>  			      unsigned int offset, unsigned int *reg,
>  			      unsigned int *mask);


