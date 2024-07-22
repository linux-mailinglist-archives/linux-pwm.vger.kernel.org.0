Return-Path: <linux-pwm+bounces-2892-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29799938BD0
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2031C21289
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C816A940;
	Mon, 22 Jul 2024 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MYFq9t39"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB79168C20;
	Mon, 22 Jul 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639703; cv=none; b=sTbqzpy4x2VwNGgMM+Cv7jSTLbXx2OkGZUHT7tRC1APle98OPTzw1Fi2FqUG0GC9KVhp2Fsvg+g8xPPdEKWFSBG4J6+Bbs3LzJy388xPga9UNDqwPbuXKw4JOiu//kR5aDbh9nsi+zy4hpHVbkJst9Hrb0pR0jzkcSeeZmzAjOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639703; c=relaxed/simple;
	bh=d7xHslyF97tJsVZUBlUYphB1JXCq3oyEqSrlI2iYOVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZKegW5uL/f1IX7pYJMSwyfRwnp2jb0ND7eHxj6pShrvfRgBJ03geiJz6ql1FvbXsbKg5zar3ck7QRtZ4RYsP+Y4sHCxcmUrYXOX0i4GNIcvu8Lyh7BlPdJLBxKPPJPfkfrw5OR12wp5jSjHk7wxmS+WYszu2qnADtgG2H5LWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MYFq9t39; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C174645B;
	Mon, 22 Jul 2024 11:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721639658;
	bh=d7xHslyF97tJsVZUBlUYphB1JXCq3oyEqSrlI2iYOVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYFq9t39ZWqF4PIP1g1B53NOlzleaLjzeI3h+JYt0RYO5vli3OfXrKQrEO5LWzHjf
	 JFs1IQwZqE1haSzcIBmo50wyCufYLsFgzO5jDuPtVc9lB2+M9wd2QfDeUyjVpo9L/d
	 +FHVUcRkqE+kCSpEIDKYQr6OF8ZOSA7wQNU+HnfM=
Date: Mon, 22 Jul 2024 12:14:41 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH v6 2/4] mfd: adp5585: Add Analog Devices ADP5585 core
 support
Message-ID: <20240722091441.GA13497@pendragon.ideasonboard.com>
References: <20240721160049.20470-1-laurent.pinchart@ideasonboard.com>
 <20240721160049.20470-3-laurent.pinchart@ideasonboard.com>
 <20240722085629.GX501857@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722085629.GX501857@google.com>

Hi Lee,

Thank you for the review.

On Mon, Jul 22, 2024 at 09:56:29AM +0100, Lee Jones wrote:
> On Sun, 21 Jul 2024, Laurent Pinchart wrote:
> 
> > From: Haibo Chen <haibo.chen@nxp.com>
> > 
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > This driver supports the chip by modelling it as an MFD device, with two
> > child devices for the GPIO and PWM functions.
> > 
> > The driver is derived from an initial implementation from NXP, available
> > in commit 8059835bee19 ("MLK-25917-1 mfd: adp5585: add ADI adp5585 core
> > support") in their BSP kernel tree. It has been extensively rewritten.
> > 
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Changes since v4:
> > 
> > - One more GENMASK() usage
> > - Include err.h
> > 
> > Changes since v2:
> > 
> > - Add missing and remove extraneous headers
> > - Use i2c_get_match_data()
> > - Drop unneeded parentheses
> > - Use GENMASK()
> > - Drop of_match_ptr()
> > - Allow compilation on !OF with COMPILE_TEST
> > - Replace ADP5585_MAN_ID() macro with ADP5585_MAN_ID_MASK
> > - Drop unneeded macro
> > 
> > Changes since v1:
> > 
> > - Add comment to explain BANK and BIT macros
> > - Drop compatible strings from cells
> > - White space fixes
> > - Fix comparison to NULL
> > 
> > Changes compared to the NXP original version:
> > 
> > - Add MAINTAINERS entry
> > - Fix compatible strings for child devices
> > - Fix header guards
> > - Use lowercase hex constants
> > - White space fixes
> > - Use module_i2c_driver()
> > - Switch to regmap
> > - Drop I2C device ID table
> > - Drop ADP5585_REG_MASK
> > - Support R5 GPIO pin
> > - Drop dev field from adp5585_dev structure
> > - Check device ID at probe time
> > - Fix register field names
> > - Update copyright
> > - Update license to GPL-2.0-only
> > - Implement suspend/resume
> > ---
> >  MAINTAINERS                 |   2 +
> >  drivers/mfd/Kconfig         |  12 +++
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/adp5585.c       | 200 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/adp5585.h | 126 +++++++++++++++++++++++
> >  5 files changed, 341 insertions(+)
> >  create mode 100644 drivers/mfd/adp5585.c
> >  create mode 100644 include/linux/mfd/adp5585.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4fe8bd8752a5..ebb1a1833bbc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -532,6 +532,8 @@ L:	linux-gpio@vger.kernel.org
> >  L:	linux-pwm@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
> > +F:	drivers/mfd/adp5585.c
> > +F:	include/linux/mfd/adp5585.h
> >  
> >  ADP5588 QWERTY KEYPAD AND IO EXPANDER DRIVER (ADP5588/ADP5587)
> >  M:	Michael Hennerich <michael.hennerich@analog.com>
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 266b4f54af60..05e8e1f0b602 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -20,6 +20,18 @@ config MFD_CS5535
> >  	  This is the core driver for CS5535/CS5536 MFD functions.  This is
> >  	  necessary for using the board's GPIO and MFGPT functionality.
> >  
> > +config MFD_ADP5585
> > +	tristate "Analog Devices ADP5585 MFD driver"
> 
> It's not an MFD driver (whatever one of those is), is a Keypad Decoder
> and I/O Expander.

OK.

> > +	select MFD_CORE
> > +	select REGMAP_I2C
> > +	depends on I2C
> > +	depends on OF || COMPILE_TEST
> > +	help
> > +	  Say yes here to add support for the Analog Devices ADP5585 GPIO
> > +	  expander, PWM and keypad controller. This includes the I2C driver and
> > +	  the core APIs _only_, you have to select individual components like
> > +	  the GPIO and PWM functions under the corresponding menus.
> > +
> >  config MFD_ALTERA_A10SR
> >  	bool "Altera Arria10 DevKit System Resource chip"
> >  	depends on ARCH_INTEL_SOCFPGA && SPI_MASTER=y && OF
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index c66f07edcd0e..37f36a019a68 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -188,6 +188,7 @@ obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
> >  obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
> >  obj-$(CONFIG_MFD_TIMBERDALE)    += timberdale.o
> >  obj-$(CONFIG_PMIC_ADP5520)	+= adp5520.o
> > +obj-$(CONFIG_MFD_ADP5585)	+= adp5585.o
> >  obj-$(CONFIG_MFD_KEMPLD)	+= kempld-core.o
> >  obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
> >  obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
> > diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
> > new file mode 100644
> > index 000000000000..5dc3e47a0533
> > --- /dev/null
> > +++ b/drivers/mfd/adp5585.c
> > @@ -0,0 +1,200 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices ADP5585 I/O expander, PWM controller and keypad controller
> > + *
> > + * Copyright 2022 NXP
> > + * Copyright 2024 Ideas on Board Oy
> > + */
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mfd/adp5585.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/types.h>
> > +
> > +static const struct mfd_cell adp5585_devs[] = {
> > +	{ .name = "adp5585-gpio", },
> > +	{ .name = "adp5585-pwm", },
> > +};
> > +
> > +static const struct regmap_range adp5585_volatile_ranges[] = {
> > +	regmap_reg_range(ADP5585_ID, ADP5585_GPI_STATUS_B),
> > +};
> > +
> > +static const struct regmap_access_table adp5585_volatile_regs = {
> > +	.yes_ranges = adp5585_volatile_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(adp5585_volatile_ranges),
> > +};
> > +
> > +static const u8 adp5585_regmap_defaults_00[ADP5585_MAX_REG + 1] = {
> > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x18 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > +};
> > +
> > +static const u8 adp5585_regmap_defaults_02[ADP5585_MAX_REG + 1] = {
> > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc3,
> > +	/* 0x18 */ 0x03, 0x00, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > +};
> > +
> > +static const u8 adp5585_regmap_defaults_04[ADP5585_MAX_REG + 1] = {
> > +	/* 0x00 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x08 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x10 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55,
> > +	/* 0x18 */ 0x05, 0x55, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x20 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x28 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x30 */ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +	/* 0x38 */ 0x00, 0x00, 0x00, 0x00, 0x00,
> > +};
> 
> This 'patches', 'default's whatever you want to call them are horrid!

As far as I understand, that's what regmap requires to handle default
register values when using the regmap cache. Is there a better way ?

> > +enum adp5585_regmap_type {
> > +	ADP5585_REGMAP_00,
> > +	ADP5585_REGMAP_02,
> > +	ADP5585_REGMAP_04,
> > +};
> 
> What is a type 00, 02 and 04?

Those are devices variants, described in the datasheet. -00 is the
default, -02 doesn't have internal pull-up resistors, and -04 has
pull-down resistors instead. See
https://www.analog.com/media/en/technical-documentation/data-sheets/ADP5585.pdf
if you're curious.

> > +static const struct regmap_config adp5585_regmap_configs[] = {
> > +	[ADP5585_REGMAP_00] = {
> > +		.reg_bits = 8,
> > +		.val_bits = 8,
> > +		.max_register = ADP5585_MAX_REG,
> > +		.volatile_table = &adp5585_volatile_regs,
> > +		.cache_type = REGCACHE_MAPLE,
> > +		.reg_defaults_raw = adp5585_regmap_defaults_00,
> > +		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_00),
> > +	},
> > +	[ADP5585_REGMAP_02] = {
> > +		.reg_bits = 8,
> > +		.val_bits = 8,
> > +		.max_register = ADP5585_MAX_REG,
> > +		.volatile_table = &adp5585_volatile_regs,
> > +		.cache_type = REGCACHE_MAPLE,
> > +		.reg_defaults_raw = adp5585_regmap_defaults_02,
> > +		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_02),
> > +	},
> > +	[ADP5585_REGMAP_04] = {
> > +		.reg_bits = 8,
> > +		.val_bits = 8,
> > +		.max_register = ADP5585_MAX_REG,
> > +		.volatile_table = &adp5585_volatile_regs,
> > +		.cache_type = REGCACHE_MAPLE,
> > +		.reg_defaults_raw = adp5585_regmap_defaults_04,
> > +		.num_reg_defaults_raw = sizeof(adp5585_regmap_defaults_04),
> > +	},
> > +};
> > +
> > +static int adp5585_i2c_probe(struct i2c_client *i2c)
> > +{
> > +	const struct regmap_config *regmap_config;
> > +	struct adp5585_dev *adp5585;
> > +	unsigned int id;
> > +	int ret;
> > +
> > +	adp5585 = devm_kzalloc(&i2c->dev, sizeof(struct adp5585_dev),
> 
> sizeof(*adp5585)

Indeed, not sure how I missed that.

> > +			       GFP_KERNEL);
> 
> No need to line-wrap here - user 100 chars to improve readability.
> 
> > +	if (!adp5585)
> > +		return -ENOMEM;
> > +
> > +	i2c_set_clientdata(i2c, adp5585);
> > +
> > +	regmap_config = i2c_get_match_data(i2c);
> > +	adp5585->regmap = devm_regmap_init_i2c(i2c, regmap_config);
> 
> Is regmap_config guaranteed to be !NULL?

Unless someone modifies the driver without understanding what they're
doing, yes. Please see below.

> How would devm_regmap_init_i2c() handle that if it were?
> 
> > +	if (IS_ERR(adp5585->regmap))
> > +		return dev_err_probe(&i2c->dev, PTR_ERR(adp5585->regmap),
> > +				     "Failed to initialize register map\n");
> > +
> > +	/* Verify the device ID. */
> 
> Probably superfluous.

The comment, or verifying the ID ?

> > +	ret = regmap_read(adp5585->regmap, ADP5585_ID, &id);
> > +	if (ret)
> > +		return dev_err_probe(&i2c->dev, ret,
> > +				     "Failed to read device ID\n");
> > +
> > +	if ((id & ADP5585_MAN_ID_MASK) != ADP5585_MAN_ID_VALUE)
> > +		return dev_err_probe(&i2c->dev, -ENODEV,
> > +				     "Invalid device ID 0x%02x\n", id);
> > +
> > +	dev_dbg(&i2c->dev, "device ID 0x%02x\n", id);
> 
> How often to you think this well be useful post-dev?
> 
> I'd wager, never.

I'll drop that.

> > +
> > +	/* Add MFD devices. */
> 
> Definitely superfluous.

I assume you mean the comment only :-) I can drop it.

> > +	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO,
> > +				   adp5585_devs, ARRAY_SIZE(adp5585_devs),
> > +				   NULL, 0, NULL);
> > +	if (ret)
> > +		return dev_err_probe(&i2c->dev, ret,
> > +				     "Failed to add MFD devices\n");
> 
> s/MFD/child/
> 
> Or
> 
> s/MFD /sub-/
> 
> > +	return 0;
> > +}
> > +
> > +static int adp5585_suspend(struct device *dev)
> > +{
> > +	struct adp5585_dev *adp5585 = dev_get_drvdata(dev);
> > +
> > +	regcache_cache_only(adp5585->regmap, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static int adp5585_resume(struct device *dev)
> > +{
> > +	struct adp5585_dev *adp5585 = dev_get_drvdata(dev);
> > +
> > +	regcache_cache_only(adp5585->regmap, false);
> > +	regcache_mark_dirty(adp5585->regmap);
> > +
> > +	return regcache_sync(adp5585->regmap);
> > +}
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
> > +
> > +static const struct of_device_id adp5585_of_match[] = {
> > +	{
> > +		.compatible = "adi,adp5585-00",
> > +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +	}, {
> > +		.compatible = "adi,adp5585-01",
> > +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +	}, {
> > +		.compatible = "adi,adp5585-02",
> > +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_02],
> > +	}, {
> > +		.compatible = "adi,adp5585-03",
> > +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_00],
> > +	}, {
> > +		.compatible = "adi,adp5585-04",
> > +		.data = &adp5585_regmap_configs[ADP5585_REGMAP_04],
> > +	}, {
> 
> 	{	.compatible = "adi,adp5585-05"	},  /* Whoops, did I just dereference a NULL poiner? */

Don't add an entry without .data.

 	{ .compatible = "adi,adp5585-05", .data = (void *)ADP5585_REGMAP_05 },

would also lead to problems. Someone adding support for a new variant is
expected to understand a bit of the driver. Furthemore, the NULL pointer
dereference would be caught immediately at development time, so it won't
make it to mainline. I don't think this calls for a runtime check in
probe().

> > +	{ /* sentinel */ }
> 
> Comment sounds cool, but is it necessary?

That's the common practice, and I think it makes the code clearer..

> > +};
> > +MODULE_DEVICE_TABLE(of, adp5585_of_match);
> > +
> > +static struct i2c_driver adp5585_i2c_driver = {
> > +	.driver = {
> > +		.name = "adp5585",
> > +		.of_match_table = adp5585_of_match,
> > +		.pm = pm_sleep_ptr(&adp5585_pm),
> > +	},
> > +	.probe = adp5585_i2c_probe,
> > +};
> > +module_i2c_driver(adp5585_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("ADP5585 core driver");
> > +MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
> > new file mode 100644
> > index 000000000000..25025b381c63
> > --- /dev/null
> > +++ b/include/linux/mfd/adp5585.h
> > @@ -0,0 +1,126 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Analog Devices ADP5585 I/O expander, PWM controller and keypad controller
> > + *
> > + * Copyright 2022 NXP
> > + * Copyright 2024 Ideas on Board Oy
> > + */
> > +
> > +#ifndef __LINUX_MFD_ADP5585_H_
> 
> You can probably drop the LINUX_ part.

$ git grep 'ifndef.*_H_\?$' include/linux/ | grep LINUX_ | wc -l
1408
$ git grep 'ifndef.*_H_\?$' include/linux/ | grep -v LINUX_ | wc -l
804

Namespacing the header guards seems a good practice to me. I agree that
we will likely not have another mfd/adp5585.h file in any other
directory in include/, so that's more of a theoretical concern, but can
I still go with the majority practice ?

> > +#define __LINUX_MFD_ADP5585_H_
> > +
> > +#include <linux/bits.h>
> > +
> > +#define ADP5585_ID			0x00
> > +#define		ADP5585_MAN_ID_VALUE		0x20
> > +#define		ADP5585_MAN_ID_MASK		GENMASK(7, 4)
> > +#define ADP5585_INT_STATUS		0x01
> > +#define ADP5585_STATUS			0x02
> > +#define ADP5585_FIFO_1			0x03
> > +#define ADP5585_FIFO_2			0x04
> > +#define ADP5585_FIFO_3			0x05
> > +#define ADP5585_FIFO_4			0x06
> > +#define ADP5585_FIFO_5			0x07
> > +#define ADP5585_FIFO_6			0x08
> > +#define ADP5585_FIFO_7			0x09
> > +#define ADP5585_FIFO_8			0x0a
> > +#define ADP5585_FIFO_9			0x0b
> > +#define ADP5585_FIFO_10			0x0c
> > +#define ADP5585_FIFO_11			0x0d
> > +#define ADP5585_FIFO_12			0x0e
> > +#define ADP5585_FIFO_13			0x0f
> > +#define ADP5585_FIFO_14			0x10
> > +#define ADP5585_FIFO_15			0x11
> > +#define ADP5585_FIFO_16			0x12
> > +#define ADP5585_GPI_INT_STAT_A		0x13
> > +#define ADP5585_GPI_INT_STAT_B		0x14
> > +#define ADP5585_GPI_STATUS_A		0x15
> > +#define ADP5585_GPI_STATUS_B		0x16
> > +#define ADP5585_RPULL_CONFIG_A		0x17
> > +#define ADP5585_RPULL_CONFIG_B		0x18
> > +#define ADP5585_RPULL_CONFIG_C		0x19
> > +#define ADP5585_RPULL_CONFIG_D		0x1a
> > +#define		ADP5585_Rx_PULL_CFG_PU_300K	0
> 
> Assuming these are bits - 2 spaces is usually enough.

I find a tab tobe more readable. Is this a showstopper or can I keep the
tab ?

> > +#define		ADP5585_Rx_PULL_CFG_PD_300K	1
> > +#define		ADP5585_Rx_PULL_CFG_PU_100K	2
> > +#define		ADP5585_Rx_PULL_CFG_DISABLE	3
> > +#define		ADP5585_Rx_PULL_CFG_MASK	3
> > +#define ADP5585_GPI_INT_LEVEL_A		0x1b
> > +#define ADP5585_GPI_INT_LEVEL_B		0x1c
> > +#define ADP5585_GPI_EVENT_EN_A		0x1d
> > +#define ADP5585_GPI_EVENT_EN_B		0x1e
> > +#define ADP5585_GPI_INTERRUPT_EN_A	0x1f
> > +#define ADP5585_GPI_INTERRUPT_EN_B	0x20
> > +#define ADP5585_DEBOUNCE_DIS_A		0x21
> > +#define ADP5585_DEBOUNCE_DIS_B		0x22
> > +#define ADP5585_GPO_DATA_OUT_A		0x23
> > +#define ADP5585_GPO_DATA_OUT_B		0x24
> > +#define ADP5585_GPO_OUT_MODE_A		0x25
> > +#define ADP5585_GPO_OUT_MODE_B		0x26
> > +#define ADP5585_GPIO_DIRECTION_A	0x27
> > +#define ADP5585_GPIO_DIRECTION_B	0x28
> > +#define ADP5585_RESET1_EVENT_A		0x29
> > +#define ADP5585_RESET1_EVENT_B		0x2a
> > +#define ADP5585_RESET1_EVENT_C		0x2b
> > +#define ADP5585_RESET2_EVENT_A		0x2c
> > +#define ADP5585_RESET2_EVENT_B		0x2d
> > +#define ADP5585_RESET_CFG		0x2e
> > +#define ADP5585_PWM_OFFT_LOW		0x2f
> > +#define ADP5585_PWM_OFFT_HIGH		0x30
> > +#define ADP5585_PWM_ONT_LOW		0x31
> > +#define ADP5585_PWM_ONT_HIGH		0x32
> > +#define ADP5585_PWM_CFG			0x33
> > +#define		ADP5585_PWM_IN_AND		BIT(2)
> > +#define		ADP5585_PWM_MODE		BIT(1)
> > +#define		ADP5585_PWM_EN			BIT(0)
> > +#define ADP5585_LOGIC_CFG		0x34
> > +#define ADP5585_LOGIC_FF_CFG		0x35
> > +#define ADP5585_LOGIC_INT_EVENT_EN	0x36
> > +#define ADP5585_POLL_PTIME_CFG		0x37
> > +#define ADP5585_PIN_CONFIG_A		0x38
> > +#define ADP5585_PIN_CONFIG_B		0x39
> > +#define ADP5585_PIN_CONFIG_C		0x3a
> > +#define		ADP5585_PULL_SELECT		BIT(7)
> > +#define		ADP5585_C4_EXTEND_CFG_GPIO11	(0U << 6)
> > +#define		ADP5585_C4_EXTEND_CFG_RESET2	(1U << 6)
> > +#define		ADP5585_C4_EXTEND_CFG_MASK	GENMASK(6, 6)
> > +#define		ADP5585_R4_EXTEND_CFG_GPIO5	(0U << 5)
> > +#define		ADP5585_R4_EXTEND_CFG_RESET1	(1U << 5)
> > +#define		ADP5585_R4_EXTEND_CFG_MASK	GENMASK(5, 5)
> > +#define		ADP5585_R3_EXTEND_CFG_GPIO4	(0U << 2)
> > +#define		ADP5585_R3_EXTEND_CFG_LC	(1U << 2)
> > +#define		ADP5585_R3_EXTEND_CFG_PWM_OUT	(2U << 2)
> > +#define		ADP5585_R3_EXTEND_CFG_MASK	GENMASK(3, 2)
> > +#define		ADP5585_R0_EXTEND_CFG_GPIO1	(0U << 0)
> > +#define		ADP5585_R0_EXTEND_CFG_LY	(1U << 0)
> > +#define		ADP5585_R0_EXTEND_CFG_MASK	GENMASK(0, 0)
> > +#define ADP5585_GENERAL_CFG		0x3b
> > +#define		ADP5585_OSC_EN			BIT(7)
> > +#define		ADP5585_OSC_FREQ_50KHZ		(0U << 5)
> > +#define		ADP5585_OSC_FREQ_100KHZ		(1U << 5)
> > +#define		ADP5585_OSC_FREQ_200KHZ		(2U << 5)
> > +#define		ADP5585_OSC_FREQ_500KHZ		(3U << 5)
> > +#define		ADP5585_OSC_FREQ_MASK		GENMASK(6, 5)
> > +#define		ADP5585_INT_CFG			BIT(1)
> > +#define		ADP5585_RST_CFG			BIT(0)
> > +#define ADP5585_INT_EN			0x3c
> > +
> > +#define ADP5585_MAX_REG			ADP5585_INT_EN
> > +
> > +/*
> > + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 6/R5", numbered 0 to 5 by the
> > + * driver, and bank 1 covers pins "GPIO 7/C0" to "GPIO 11/C4", numbered 6 to
> > + * 10. Some variants of the ADP5585 don't support "GPIO 6/R5". As the driver
> > + * uses identical GPIO numbering for all variants to avoid confusion, GPIO 5 is
> > + * marked as reserved in the device tree for variants that don't support it.
> > + */
> > +#define ADP5585_BANK(n)			((n) >= 6 ? 1 : 0)
> > +#define ADP5585_BIT(n)			((n) >= 6 ? BIT((n) - 6) : BIT(n))
> > +
> > +struct regmap;
> > +
> > +struct adp5585_dev {
> > +	struct regmap *regmap;
> > +};
> > +
> > +#endif

-- 
Regards,

Laurent Pinchart

