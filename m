Return-Path: <linux-pwm+bounces-5602-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F12A94E95
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583DC7A68D9
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237C0214204;
	Mon, 21 Apr 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XpNn9QEt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F944C63;
	Mon, 21 Apr 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745227437; cv=none; b=j7lK3TfNhkfea+ZgcZ96HUf3pCpnsZ3a8jTmW/KB2U8/t6kfCMvIFNOeCmeTlQk18g+9UyUdHX8zurucqp0MoIltxJtZnRXx1OyOh2kMc3cZmt2UK+/J1Q3XHEc8H8ARbxlaJ7bGEwDFvhVfOGHQ0UBtqe5oRFR0egF90lT8IGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745227437; c=relaxed/simple;
	bh=coAJc/t3Vl7gQOGmsuPOEdmHo3d9ZrtsWRF0cNuobzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvpGZdZnXBHiZJeLoisnSyCAGiPsAp4fn1c/pzcbwZinanSrEuNe1cJ+e68hLYdHBcIxpqe0UGT4Hzc0UtVqd/Y05rKoiOQIyGtmBI3uyUckbmUcof8fsl65RBMAs93weQsWHFORM1y4JBlz6K5FbBtRzZ1JKr5xoZOggwgZS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XpNn9QEt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id F26AB6D5;
	Mon, 21 Apr 2025 11:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745227307;
	bh=coAJc/t3Vl7gQOGmsuPOEdmHo3d9ZrtsWRF0cNuobzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XpNn9QEttVJQz0liVn3dgPcPtUOdFz2gS9eQY5YPre+JU5+POBfOQsVyGULIRKewe
	 oCMRKohXrnuM8aeiNl6Qx1eEF2KN200FG2apSv4hQyNk30e+kCBjdQgRikzsKoTVOQ
	 HUDcf8T0gSiLpgf9J8wN7Yo3jjEVKD8yNahdYO8A=
Date: Mon, 21 Apr 2025 12:23:51 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 07/17] gpio: adp5585: add support for the ad5589
 expander
Message-ID: <20250421092351.GF29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-7-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-7-3a799c3ed812@analog.com>

Hi Nuno,

Thank you for the patch.

On Tue, Apr 15, 2025 at 03:49:23PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Support the adp5589 I/O expander which supports up to 19 pins. We need
> to add a chip_info based struct since accessing register "banks"
> and "bits" differs between devices.
> 
> Also some register addresses are different.

Same comment as for 06/17, splitting the patch in two will make it
easier to review.

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/gpio/gpio-adp5585.c | 121 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 88 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
> index d5c0f1b267c82a5002b50cbb7a108166439e4785..d8f8d5513d7f6a9acf5bdecccacc89c4615ce237 100644
> --- a/drivers/gpio/gpio-adp5585.c
> +++ b/drivers/gpio/gpio-adp5585.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright 2022 NXP
>   * Copyright 2024 Ideas on Board Oy
> + * Copyright 2025 Analog Devices, Inc.
>   */
>  
>  #include <linux/device.h>
> @@ -14,21 +15,49 @@
>  #include <linux/regmap.h>
>  #include <linux/types.h>
>  
> -#define ADP5585_GPIO_MAX	11
> +struct adp5585_gpio_chip {
> +	unsigned int max_gpio;
> +	int (*bank)(unsigned int off);
> +	int (*bit)(unsigned int off);
> +	bool has_bias_hole;
> +};
>  
>  struct adp5585_gpio_dev {
>  	struct gpio_chip gpio_chip;
> +	const struct adp5585_gpio_chip *info;
>  	struct regmap *regmap;
> +	const struct adp5585_regs *regs;
>  };
>  
> +static int adp5585_gpio_bank(unsigned int off)
> +{
> +	return ADP5585_BANK(off);

While at it, let's move the ADP558[59]_{BANK,BIT} macros to this file,
and name them ADP558[59]_GPIO_{BANK_BIT}.

> +}
> +
> +static int adp5585_gpio_bit(unsigned int off)
> +{
> +	return ADP5585_BIT(off);
> +}
> +
> +static int adp5589_gpio_bank(unsigned int off)
> +{
> +	return ADP5589_BANK(off);
> +}
> +
> +static int adp5589_gpio_bit(unsigned int off)
> +{
> +	return ADP5589_BIT(off);
> +}
> +
>  static int adp5585_gpio_get_direction(struct gpio_chip *chip, unsigned int off)
>  {
>  	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> -	unsigned int bank = ADP5585_BANK(off);
> -	unsigned int bit = ADP5585_BIT(off);
> +	const struct adp5585_regs *regs = adp5585_gpio->regs;
> +	unsigned int bank = adp5585_gpio->info->bank(off);
> +	unsigned int bit = adp5585_gpio->info->bit(off);
>  	unsigned int val;
>  
> -	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank, &val);
> +	regmap_read(adp5585_gpio->regmap, regs->gpio_dir_a + bank, &val);
>  
>  	return val & bit ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
>  }
> @@ -36,35 +65,37 @@ static int adp5585_gpio_get_direction(struct gpio_chip *chip, unsigned int off)
>  static int adp5585_gpio_direction_input(struct gpio_chip *chip, unsigned int off)
>  {
>  	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> -	unsigned int bank = ADP5585_BANK(off);
> -	unsigned int bit = ADP5585_BIT(off);
> +	const struct adp5585_regs *regs = adp5585_gpio->regs;
> +	unsigned int bank = adp5585_gpio->info->bank(off);
> +	unsigned int bit = adp5585_gpio->info->bit(off);
>  
> -	return regmap_clear_bits(adp5585_gpio->regmap,
> -				 ADP5585_GPIO_DIRECTION_A + bank, bit);
> +	return regmap_clear_bits(adp5585_gpio->regmap, regs->gpio_dir_a + bank,
> +				 bit);
>  }
>  
>  static int adp5585_gpio_direction_output(struct gpio_chip *chip, unsigned int off, int val)
>  {
>  	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> -	unsigned int bank = ADP5585_BANK(off);
> -	unsigned int bit = ADP5585_BIT(off);
> +	const struct adp5585_regs *regs = adp5585_gpio->regs;
> +	unsigned int bank = adp5585_gpio->info->bank(off);
> +	unsigned int bit = adp5585_gpio->info->bit(off);
>  	int ret;
>  
> -	ret = regmap_update_bits(adp5585_gpio->regmap,
> -				 ADP5585_GPO_DATA_OUT_A + bank, bit,
> -				 val ? bit : 0);
> +	ret = regmap_update_bits(adp5585_gpio->regmap, regs->gpo_data_a + bank,
> +				 bit, val ? bit : 0);
>  	if (ret)
>  		return ret;
>  
> -	return regmap_set_bits(adp5585_gpio->regmap,
> -			       ADP5585_GPIO_DIRECTION_A + bank, bit);
> +	return regmap_set_bits(adp5585_gpio->regmap, regs->gpio_dir_a + bank,
> +			       bit);
>  }
>  
>  static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
>  {
>  	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> -	unsigned int bank = ADP5585_BANK(off);
> -	unsigned int bit = ADP5585_BIT(off);
> +	const struct adp5585_regs *regs = adp5585_gpio->regs;
> +	unsigned int bank = adp5585_gpio->info->bank(off);
> +	unsigned int bit = adp5585_gpio->info->bit(off);
>  	unsigned int reg;
>  	unsigned int val;
>  
> @@ -79,8 +110,8 @@ static int adp5585_gpio_get_value(struct gpio_chip *chip, unsigned int off)
>  	 * .direction_input(), .direction_output() or .set() operations racing
>  	 * with this.
>  	 */
> -	regmap_read(adp5585_gpio->regmap, ADP5585_GPIO_DIRECTION_A + bank, &val);
> -	reg = val & bit ? ADP5585_GPO_DATA_OUT_A : ADP5585_GPI_STATUS_A;
> +	regmap_read(adp5585_gpio->regmap, regs->gpio_dir_a + bank, &val);
> +	reg = val & bit ? regs->gpo_data_a : regs->gpi_stat_a;
>  	regmap_read(adp5585_gpio->regmap, reg + bank, &val);
>  
>  	return !!(val & bit);
> @@ -90,17 +121,19 @@ static int adp5585_gpio_set_value(struct gpio_chip *chip, unsigned int off,
>  				  int val)
>  {
>  	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
> -	unsigned int bank = ADP5585_BANK(off);
> -	unsigned int bit = ADP5585_BIT(off);
> +	const struct adp5585_regs *regs = adp5585_gpio->regs;
> +	unsigned int bank = adp5585_gpio->info->bank(off);
> +	unsigned int bit = adp5585_gpio->info->bit(off);
>  
> -	return regmap_update_bits(adp5585_gpio->regmap,
> -				  ADP5585_GPO_DATA_OUT_A + bank,
> +	return regmap_update_bits(adp5585_gpio->regmap, regs->gpo_data_a + bank,
>  				  bit, val ? bit : 0);
>  }
>  
>  static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
>  				 unsigned int off, unsigned int bias)
>  {
> +	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
> +	const struct adp5585_regs *regs = adp5585_gpio->regs;
>  	unsigned int bit, reg, mask, val;
>  
>  	/*
> @@ -108,8 +141,10 @@ static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
>  	 * consecutive registers ADP5585_RPULL_CONFIG_*, with a hole of 4 bits
>  	 * after R5.
>  	 */
> -	bit = off * 2 + (off > 5 ? 4 : 0);
> -	reg = ADP5585_RPULL_CONFIG_A + bit / 8;
> +	bit = off * 2;
> +	if (info->has_bias_hole)
> +		bit += (off > 5 ? 4 : 0);
> +	reg = regs->rpull_cfg_a + bit / 8;
>  	mask = ADP5585_Rx_PULL_CFG_MASK << (bit % 8);
>  	val = bias << (bit % 8);
>  
> @@ -119,22 +154,24 @@ static int adp5585_gpio_set_bias(struct adp5585_gpio_dev *adp5585_gpio,
>  static int adp5585_gpio_set_drive(struct adp5585_gpio_dev *adp5585_gpio,
>  				  unsigned int off, enum pin_config_param drive)
>  {
> -	unsigned int bank = ADP5585_BANK(off);
> -	unsigned int bit = ADP5585_BIT(off);
> +	const struct adp5585_regs *regs = adp5585_gpio->regs;
> +	unsigned int bank = adp5585_gpio->info->bank(off);
> +	unsigned int bit = adp5585_gpio->info->bit(off);
>  
>  	return regmap_update_bits(adp5585_gpio->regmap,
> -				  ADP5585_GPO_OUT_MODE_A + bank, bit,
> +				  regs->gpo_out_a + bank, bit,
>  				  drive == PIN_CONFIG_DRIVE_OPEN_DRAIN ? bit : 0);
>  }
>  
>  static int adp5585_gpio_set_debounce(struct adp5585_gpio_dev *adp5585_gpio,
>  				     unsigned int off, unsigned int debounce)
>  {
> -	unsigned int bank = ADP5585_BANK(off);
> -	unsigned int bit = ADP5585_BIT(off);
> +	const struct adp5585_regs *regs = adp5585_gpio->regs;
> +	unsigned int bank = adp5585_gpio->info->bank(off);
> +	unsigned int bit = adp5585_gpio->info->bit(off);
>  
>  	return regmap_update_bits(adp5585_gpio->regmap,
> -				  ADP5585_DEBOUNCE_DIS_A + bank, bit,
> +				  regs->debounce_dis_a + bank, bit,
>  				  debounce ? 0 : bit);
>  }
>  
> @@ -175,6 +212,7 @@ static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
>  static int adp5585_gpio_probe(struct platform_device *pdev)
>  {
>  	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
>  	struct adp5585_gpio_dev *adp5585_gpio;
>  	struct device *dev = &pdev->dev;
>  	struct gpio_chip *gc;
> @@ -185,6 +223,11 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	adp5585_gpio->regmap = adp5585->regmap;
> +	adp5585_gpio->regs = adp5585->info->regs;
> +
> +	adp5585_gpio->info = (const struct adp5585_gpio_chip *)id->driver_data;
> +	if (!adp5585_gpio->info)
> +		return -ENODEV;
>  
>  	device_set_of_node_from_dev(dev, dev->parent);
>  
> @@ -199,7 +242,7 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
>  	gc->can_sleep = true;
>  
>  	gc->base = -1;
> -	gc->ngpio = ADP5585_GPIO_MAX;
> +	gc->ngpio = adp5585->info->max_cols + adp5585->info->max_rows;
>  	gc->label = pdev->name;
>  	gc->owner = THIS_MODULE;
>  
> @@ -211,8 +254,20 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct adp5585_gpio_chip adp5585_gpio_chip_info = {
> +	.bank = adp5585_gpio_bank,
> +	.bit = adp5585_gpio_bit,
> +	.has_bias_hole = true,
> +};
> +
> +static const struct adp5585_gpio_chip adp5589_gpio_chip_info = {
> +	.bank = adp5589_gpio_bank,
> +	.bit = adp5589_gpio_bit,
> +};
> +
>  static const struct platform_device_id adp5585_gpio_id_table[] = {
> -	{ "adp5585-gpio" },
> +	{ "adp5585-gpio", (kernel_ulong_t)&adp5585_gpio_chip_info },
> +	{ "adp5589-gpio", (kernel_ulong_t)&adp5589_gpio_chip_info },
>  	{ /* Sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, adp5585_gpio_id_table);

-- 
Regards,

Laurent Pinchart

