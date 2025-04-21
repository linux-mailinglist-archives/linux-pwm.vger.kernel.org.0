Return-Path: <linux-pwm+bounces-5605-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5A4A94EB8
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E502A16B4FB
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2B20E708;
	Mon, 21 Apr 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Zszvlj7o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CEFC08;
	Mon, 21 Apr 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228121; cv=none; b=rcDeqquDqeC1aNRenb01uMA4SVMvgELew+AcPz+RPrALqpEL5kglc2vShTP8OAdVnhbyyUZb12tKQP5hMvrQLwzEJgRmmpnMy14vs1XnNwje1u2WdDK8Uk5sSEMGKCk7TVEClpmw4iXDdcYpjMY339ZEd5u+mIUpi6lneMfb14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228121; c=relaxed/simple;
	bh=5pnpoWO/gQfa70KFC8FylA9SFNbW6vX0cXcOlDWarXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb8aq3pnKHRhRWy9IiCe187CQGtjDPCwA7+TLJeQzBUTcPh8081ThnICG/BHInubKHtWvDkimC/d1H+zDNx+m+NczMkTzjvzGROUoZC9j8EKPALd1eHAj3Y3djUnHdHd/U89Bj5o+5wMPrQzlSwRYTup6FelAasbhknyxcpDzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Zszvlj7o; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D17426D5;
	Mon, 21 Apr 2025 11:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745227991;
	bh=5pnpoWO/gQfa70KFC8FylA9SFNbW6vX0cXcOlDWarXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zszvlj7oGtG9vzpkaIYko0M6+vJa2dd9NVndJHwWwFppeY+epu1DvauNv+t/2tty5
	 EaEAZE9Qfu5UqiEoe+rOoqpZzDtGPbTpzUepUDbmbRlAbO5poQDChvErffceSSbruF
	 6TPa+ZIgmkPFwDrka+oIxNqzmkbpqMmVZR+wTCg8=
Date: Mon, 21 Apr 2025 12:35:15 +0300
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
Subject: Re: [PATCH v2 12/17] Input: adp5585: Add Analog Devices ADP5585/89
 support
Message-ID: <20250421093515.GI29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-12-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-12-3a799c3ed812@analog.com>

Hi Nuno,

Thank you for the patch.

On Tue, Apr 15, 2025 at 03:49:28PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the keyboard function using the platform device
> registered by the core MFD driver.
> 
> The ADP5589 has 19 pins and also features an unlock function.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  MAINTAINERS                           |   1 +
>  drivers/input/keyboard/Kconfig        |  11 ++
>  drivers/input/keyboard/Makefile       |   1 +
>  drivers/input/keyboard/adp5585-keys.c | 221 ++++++++++++++++++++++++++++++++++
>  4 files changed, 234 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5acf50fc6af4322dec0dad2169b46c6a1903e3c..48bd39a1a96d9c57145cf2560eec54248427fc89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -549,6 +549,7 @@ L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/*/adi,adp5585*.yaml
>  F:	drivers/gpio/gpio-adp5585.c
> +F:	drivers/input/adp5585-keys.c
>  F:	drivers/mfd/adp5585.c
>  F:	drivers/pwm/pwm-adp5585.c
>  F:	include/linux/mfd/adp5585.h
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 721ab69e84ac6586f4f19102890a15ca3fcf1910..322da0957067db77c7f66ab26a181d39c2c1d513 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -37,6 +37,17 @@ config KEYBOARD_ADP5520
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called adp5520-keys.
>  
> +config KEYBOARD_ADP5585
> +	tristate "ADP5585 and similar  I2C QWERTY Keypad and IO Expanders"
> +	depends on MFD_ADP5585
> +	select INPUT_MATRIXKMAP
> +	help
> +	  This option enables support for the KEYMAP function found in the Analog
> +	  Devices ADP5585 and similar devices.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adp5585-keys.
> +
>  config KEYBOARD_ADP5588
>  	tristate "ADP5588/87 I2C QWERTY Keypad and IO Expander"
>  	depends on I2C
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 1e0721c3070968a6339a42f65a95af48364f6897..f00ec003a59aa28577ae164c0539cc5aff9579fc 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -7,6 +7,7 @@
>  
>  obj-$(CONFIG_KEYBOARD_ADC)		+= adc-keys.o
>  obj-$(CONFIG_KEYBOARD_ADP5520)		+= adp5520-keys.o
> +obj-$(CONFIG_KEYBOARD_ADP5585)		+= adp5585-keys.o
>  obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
>  obj-$(CONFIG_KEYBOARD_ADP5589)		+= adp5589-keys.o
>  obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
> diff --git a/drivers/input/keyboard/adp5585-keys.c b/drivers/input/keyboard/adp5585-keys.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..93961a9e822f8b10b1bca526b9486eed4ad7f8f7
> --- /dev/null
> +++ b/drivers/input/keyboard/adp5585-keys.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices ADP5585 Keys driver
> + *
> + * Copyright (C) 2025 Analog Devices, Inc.
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/device.h>
> +#include <linux/find.h>
> +#include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/mfd/adp5585.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +/* As needed for the matrix parsing code */
> +#define ADP5589_MAX_KEYMAPSIZE		123
> +
> +struct adp5585_kpad {
> +	struct input_dev *input;
> +	unsigned short keycode[ADP5589_MAX_KEYMAPSIZE];
> +	struct device *dev;
> +	int row_shift;
> +	u8 max_rows;
> +	u8 max_cols;
> +};
> +
> +static int adp5585_keys_parse_fw(const struct adp5585_dev *adp5585,
> +				 struct adp5585_kpad *kpad)
> +{
> +	unsigned long row_map, col_map;
> +	struct device *dev = kpad->dev;
> +	u32 cols = 0, rows = 0;
> +	int ret;
> +
> +	row_map = bitmap_read(adp5585->keypad, 0, kpad->max_rows);
> +	col_map = bitmap_read(adp5585->keypad, kpad->max_rows, kpad->max_cols);
> +	/*
> +	 * Note that given that we get a mask (and the HW allows it), we
> +	 * can have holes in our keypad (eg: row0, row1 and row7 enabled).
> +	 * However, for the matrix parsing functions we need to pass the
> +	 * number of rows/cols as the maximum row/col used plus 1. This
> +	 * pretty much means we will also have holes in our SW keypad.
> +	 */
> +	if (!bitmap_empty(&row_map, kpad->max_rows))
> +		rows = find_last_bit(&row_map, kpad->max_rows) + 1;
> +	if (!bitmap_empty(&col_map, kpad->max_cols))
> +		cols = find_last_bit(&col_map, kpad->max_cols) + 1;
> +
> +	if (!rows && !cols)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "No rows or columns defined for the keypad\n");
> +
> +	if (cols && !rows)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Cannot have columns with no rows!\n");
> +
> +	if (rows && !cols)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Cannot have rows with no columns!\n");
> +
> +	ret = matrix_keypad_build_keymap(NULL, NULL, rows, cols,
> +					 kpad->keycode, kpad->input);
> +	if (ret)
> +		return ret;
> +
> +	kpad->row_shift = get_count_order(cols);
> +
> +	if (device_property_present(kpad->dev, "autorepeat"))
> +		__set_bit(EV_REP, kpad->input->evbit);
> +
> +	return 0;
> +}
> +
> +static int adp5585_keys_setup(const struct adp5585_dev *adp5585,
> +			      struct adp5585_kpad *kpad)
> +{
> +	unsigned long keys_bits, start = 0, nbits = kpad->max_rows;
> +	const struct adp5585_regs *regs = adp5585->info->regs;
> +	unsigned int i = 0, max_cols = kpad->max_cols;
> +	int ret;
> +
> +	/*
> +	 * Take care as the below assumes max_rows is always less or equal than
> +	 * 8 which is true for the supported devices. If we happen to add
> +	 * another device we need to make sure this still holds true. Although
> +	 * adding a new device is very unlikely.
> +	 */
> +	do {
> +		keys_bits = bitmap_read(adp5585->keypad, start, nbits);
> +		if (keys_bits) {
> +			ret = regmap_write(adp5585->regmap, regs->pin_cfg_a + i,
> +					   keys_bits);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		start += nbits;
> +		if (max_cols > 8) {
> +			nbits = 8;
> +			max_cols -= nbits;
> +		} else {
> +			nbits = max_cols;
> +		}
> +
> +		i++;
> +	} while (start < kpad->max_rows + kpad->max_cols);
> +
> +	return 0;
> +}
> +
> +static void adp5585_keys_ev_handle(struct device *dev, unsigned int key,
> +				   bool key_press)
> +{
> +	struct adp5585_kpad *kpad = dev_get_drvdata(dev);
> +	unsigned int row, col, code;
> +
> +	row = (key - 1) / (kpad->max_cols);
> +	col = (key - 1) % (kpad->max_cols);
> +	code = MATRIX_SCAN_CODE(row, col, kpad->row_shift);
> +
> +	dev_dbg_ratelimited(kpad->dev, "report key(%d) r(%d) c(%d) code(%d)\n",
> +			    key, row, col, kpad->keycode[code]);
> +
> +	input_report_key(kpad->input, kpad->keycode[code], key_press);
> +	input_sync(kpad->input);
> +}
> +
> +static void adp5585_keys_ev_handle_clean(void *adp5585)
> +{
> +	adp5585_keys_ev_handle_set(adp5585, NULL, NULL);
> +}
> +
> +static int adp5585_keys_probe(struct platform_device *pdev)
> +{
> +	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct adp5585_kpad *kpad;
> +	unsigned int revid;
> +	const char *phys;
> +	int ret;
> +
> +	kpad = devm_kzalloc(dev, sizeof(*kpad), GFP_KERNEL);
> +	if (!kpad)
> +		return -ENOMEM;
> +
> +	if (!adp5585->irq)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "IRQ is mandatory for the keypad\n");

This causes the following messages to be printed in the kernel log on a
platform where the keypad feature is not declared in DT:

[   11.625591] adp5585-keys adp5585-keys.1.auto: error -EINVAL: IRQ is mandatory for the keypad
[   11.625637] adp5585-keys adp5585-keys.1.auto: probe with driver adp5585-keys failed with error -22

The MFD driver should detect which features are declared, and only
register the corresponding MFD cells.

> +
> +	kpad->dev = dev;
> +	kpad->max_cols = adp5585->info->max_cols;
> +	kpad->max_rows = adp5585->info->max_rows;
> +
> +	kpad->input = devm_input_allocate_device(dev);
> +	if (!kpad->input)
> +		return -ENOMEM;
> +
> +	ret = regmap_read(adp5585->regmap, ADP5585_ID, &revid);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read device ID\n");
> +
> +	phys = devm_kasprintf(dev, GFP_KERNEL, "%s/input0", pdev->name);
> +	if (!phys)
> +		return -ENOMEM;
> +
> +	kpad->input->name = pdev->name;
> +	kpad->input->phys = phys;
> +	kpad->input->dev.parent = dev;
> +
> +	input_set_drvdata(kpad->input, kpad);
> +
> +	kpad->input->id.bustype = BUS_I2C;
> +	kpad->input->id.vendor = 0x0001;
> +	kpad->input->id.product = 0x0001;
> +	kpad->input->id.version = revid & ADP5585_REV_ID_MASK;
> +
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	ret = adp5585_keys_parse_fw(adp5585, kpad);
> +	if (ret)
> +		return ret;
> +
> +	ret = adp5585_keys_setup(adp5585, kpad);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, kpad);
> +	adp5585_keys_ev_handle_set(adp5585, adp5585_keys_ev_handle, dev);
> +	ret = devm_add_action_or_reset(dev, adp5585_keys_ev_handle_clean,
> +				       adp5585);
> +	if (ret)
> +		return ret;
> +
> +	return input_register_device(kpad->input);
> +}
> +
> +static const struct platform_device_id adp5585_keys_id_table[] = {
> +	{ "adp5585-keys" },
> +	{ "adp5589-keys" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, adp5585_keys_id_table);
> +
> +static struct platform_driver adp5585_keys_driver = {
> +	.driver	= {
> +		.name = "adp5585-keys",
> +	},
> +	.probe = adp5585_keys_probe,
> +	.id_table = adp5585_keys_id_table,
> +};
> +module_platform_driver(adp5585_keys_driver);
> +
> +MODULE_AUTHOR("Nuno Sá <nuno.sa@analog.com>");
> +MODULE_DESCRIPTION("ADP5585 Keys Driver");
> +MODULE_LICENSE("GPL");

-- 
Regards,

Laurent Pinchart

