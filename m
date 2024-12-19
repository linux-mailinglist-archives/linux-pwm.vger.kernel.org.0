Return-Path: <linux-pwm+bounces-4411-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7218B9F846E
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 20:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC87C1678AB
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 19:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F3B1AAA0D;
	Thu, 19 Dec 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHgWkWaB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B66198A08;
	Thu, 19 Dec 2024 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636949; cv=none; b=B21mtjemLsbjgPEpDZPzfHc+luqF5fhSkc9Hp7UhiZJ3MMMJ0EfS+8+KUt8ae5gHBlmKWXvmWazRi5iiXlOQYffM2av2t0gh8WLHJoDBvlIIRQW3r67W+oYw/AiX9FXS6NTVIDoAzZAPGkUvITAxWpSCx+f3r64AN3sSGgzO3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636949; c=relaxed/simple;
	bh=SA+1oC08uDFMTRoO6PwsNpUy2AKRs8ZKCbyPsQA+Uik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+2qOQj7iRNNZK2wfTuk09HQFCRmJQj5O/gVOb6+gCJKeQr1KRnF15o3H7OE8GZw90yYxKJ3IeBP9XhPqoITX3fiRX+F3slk+UxXv0DHu6fsrbaLwmnPYDQRiZdr9IDYQUFLkhWXa9/ug8TLD32TfeIYRDQr6kG0S+/IyMs5i98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHgWkWaB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so1011066b3a.2;
        Thu, 19 Dec 2024 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734636946; x=1735241746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6l1l8xW+tGely/slpff3ASJPbegyBGo6X7WgDUE5Tbg=;
        b=CHgWkWaB6i5u8FLePhhAoTrpOqYNi0Z2uE1qKwMV86y5LlvutJaBM6fuf7tjTBND4d
         KwPNVJGCgpZf8NnG6N3mX3QH5uuCIABpY8vPB+hQIFhH0VHE/Ipi2jwJLihpCR/NQq6n
         fG6wjFC4/n3hXZVTv0QKyvLVP/AcGteqmpAk/JeAqfroRiZeCGxnyEq2H/SNPhhrcgZX
         ixJxsBVFAvqpSO62lZoZDnJqulRHHIeEZo0h63VzDc8T7niQo2uouB6vcL0LbGr5YoIZ
         /8FrsyRcI/9ASKViXRCV7tqLF9rUO9NKRa8MNsoydUcd+ZPNG25dZOlkFHhY/r5CkXOS
         BPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734636946; x=1735241746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l1l8xW+tGely/slpff3ASJPbegyBGo6X7WgDUE5Tbg=;
        b=L04JSkHouE31L5rOxM5AyucQvnTW/ON5rMID/0hNu7otGjcHz72Voc6WZzNgDDxYM5
         EjCs1WbWFdwqLbmpbv1NSUh127C7CI4ErVESbYFV9MNGPFNdd3rzn5qwwEWMC8pba/Li
         g8cKQv1rCTawkHyORGHSBHxLiyBHn4YUAO/r5FoIHv1HCqzJxIZF9Fl14rGr/8JJxgXh
         FvEs8t3KMOoW+IQR/haRYZ01ohvWZaKvxLUabyW7iyifSFV5r3WhUyg/BsGalwUkFg6e
         QBwhfcTraN2eMFtkLNA4RFzOxf5MgNwzul8mnkvVPRmjDdYT2hliMeXm+7OFogGnRpGI
         HHNw==
X-Forwarded-Encrypted: i=1; AJvYcCUFL7RWR6vHemE8SAHqTltQOEYTafkLcSuYUCHHFLcQ76gMibcn5uLtME1SljHGP5XdsgfJ0EmqpjnCJdUh@vger.kernel.org, AJvYcCUrRx9xgz9/wuIhMoWZ53lA4pS/ivn7QbVh66pirnXSUGcJI/vhdnqkQyo/FVL6AXBwMP3vEnnzkMRP@vger.kernel.org, AJvYcCUwoMHJRQyVUnOZnr/eZeFfeXwQGpbBJ8fT6BOOajfYWel5rqTS/zTeAY6p39JWyQx72opvS2/abN1E@vger.kernel.org, AJvYcCXa3ZUv2rFLtDZnSWK5jhiY9ebQch7qlLbH+hsuvCoC1NOJlxk2AhhWNmlCbpj3DjFEF0+/kG/geO3ErBU=@vger.kernel.org, AJvYcCXiviDD+fdKWUYwBXdOB6PpYgMrq0WQLdECxmjhwdLeHcfa76m5Cb31ucOJ0ucuqvcMC2KNW1xWAOwV4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YygGyQfyLB2rV3m+RwxmvqIXOSyX0PLeXp31Pe2BXLsFhZziX8Z
	BVUU3T6NFVMb7EqVOvQrj47qZ0gz2yPLMAtqWPFRXzCUBxWjUWjQ
X-Gm-Gg: ASbGnctVKJhRC7yNEfU4XP/0mIfJT0h8PglA0fLzCxH2kbxZIXd94tNw2O0exftGGyw
	Ia0jgA/HFiSWNnxDtVg+/FOgYE+nsTiUipGJipKOpyZ5o4xAK1TiMFstG+BrDVPEqxCouckzUYs
	KFSVipm6RnRkqc16q/2J9N477DokmnzxdloEZtzk7LUI5dGd+ZKAVYXhGb/sT87VO+IxoBo09i0
	I/JA8Pq2TdWldU6WHq4y24Q9d0B/Ubo9mIzlfeMklN3wsrfPRhTh6Rd/w==
X-Google-Smtp-Source: AGHT+IEthmscUgqJEOLOt2xMPjqaZIlxdzUR17rpPWL7yK7dU738VobiVtTylmL/q0CvGYza7553mg==
X-Received: by 2002:a05:6a00:2407:b0:725:b201:2362 with SMTP id d2e1a72fcca58-72aa8d5164emr6253626b3a.11.1734636946446;
        Thu, 19 Dec 2024 11:35:46 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:afa0:e44c:aa7e:5cd4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90c1bcsm1730660b3a.187.2024.12.19.11.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:35:45 -0800 (PST)
Date: Thu, 19 Dec 2024 11:35:42 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 6/8] input: keyboard: Add support for MAX7360 keypad
Message-ID: <Z2R1ju7pNd-BBLJ4@google.com>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
 <20241219-mdb-max7360-support-v1-6-8e8317584121@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-mdb-max7360-support-v1-6-8e8317584121@bootlin.com>

Hi Mathieu,

On Thu, Dec 19, 2024 at 05:21:23PM +0100, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 keypad controller, providing
> support for up to 64 keys, with a matrix of 8 columns and 8 rows.
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  drivers/input/keyboard/Kconfig          |  12 ++
>  drivers/input/keyboard/Makefile         |   1 +
>  drivers/input/keyboard/max7360-keypad.c | 297 ++++++++++++++++++++++++++++++++
>  3 files changed, 310 insertions(+)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 721ab69e84ac..bba029f65cfa 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -421,6 +421,18 @@ config KEYBOARD_MAX7359
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called max7359_keypad.
>  
> +config KEYBOARD_MAX7360
> +	tristate "Maxim MAX7360 Key Switch Controller"
> +	select INPUT_MATRIXKMAP
> +	depends on I2C
> +	depends on MFD_MAX7360
> +	help
> +	  If you say yes here you get support for the keypad controller on the
> +	  Maxim MAX7360 I/O Expander.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called max7360_keypad.
> +
>  config KEYBOARD_MPR121
>  	tristate "Freescale MPR121 Touchkey"
>  	depends on I2C
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index 1e0721c30709..b49d32d4003d 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_KEYBOARD_LPC32XX)		+= lpc32xx-keys.o
>  obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
>  obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
>  obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
> +obj-$(CONFIG_KEYBOARD_MAX7360)		+= max7360-keypad.o
>  obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
>  obj-$(CONFIG_KEYBOARD_MT6779)		+= mt6779-keypad.o
>  obj-$(CONFIG_KEYBOARD_MTK_PMIC) 	+= mtk-pmic-keys.o
> diff --git a/drivers/input/keyboard/max7360-keypad.c b/drivers/input/keyboard/max7360-keypad.c
> new file mode 100644
> index 000000000000..fbc51c89dba1
> --- /dev/null
> +++ b/drivers/input/keyboard/max7360-keypad.c
> @@ -0,0 +1,297 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Bootlin
> + *
> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> + */
> +
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/input/matrix_keypad.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +struct max7360_keypad {
> +	struct input_dev *input;
> +	unsigned int rows;
> +	unsigned int cols;
> +	unsigned int debounce_ms;
> +	int irq;
> +	bool no_autorepeat;
> +	struct regmap *regmap;
> +	unsigned short keycodes[MAX7360_MAX_KEY_ROWS * MAX7360_MAX_KEY_COLS];
> +};
> +
> +static irqreturn_t max7360_keypad_irq(int irq, void *data)
> +{
> +	struct max7360_keypad *max7360_keypad = data;
> +	unsigned int val;
> +	unsigned int row, col;
> +	unsigned int release;
> +	unsigned int code;
> +	int ret;
> +
> +	ret = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
> +	if (!ret && val == MAX7360_FIFO_OVERFLOW) {
> +		/* FIFO overflow: ignore it and get next event. */
> +		dev_err(&max7360_keypad->input->dev, "max7360 FIFO overflow");
> +		ret = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO,
> +				  &val);
> +	}

Maybe

	do {
		error = regmap_read(...);
		if (error) {
			dev_err(...);
			return IRQ_HANDLED;
		}
	} while (val == MAX7360_FIFO_OVERFLOW);

> +	if (ret) {
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to read max7360 FIFO");
> +		return ret;

Wrong value for irqreturn_t.

> +	}
> +
> +	if (val == MAX7360_FIFO_EMPTY) {
> +		dev_dbg(&max7360_keypad->input->dev,
> +			"Got a spurious interrupt");
> +
> +		return IRQ_NONE;
> +	}
> +
> +	row = FIELD_GET(MAX7360_FIFO_ROW, val);
> +	col = FIELD_GET(MAX7360_FIFO_COL, val);
> +	release = val & MAX7360_FIFO_RELEASE;
> +
> +	code = MATRIX_SCAN_CODE(row, col, MAX7360_ROW_SHIFT);
> +
> +	dev_dbg(&max7360_keypad->input->dev,
> +		"key[%d:%d] %s\n", row, col, release ? "release" : "press");
> +
> +	input_event(max7360_keypad->input, EV_MSC, MSC_SCAN, code);
> +	input_report_key(max7360_keypad->input, max7360_keypad->keycodes[code],
> +			 !release);
> +	input_sync(max7360_keypad->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int max7360_keypad_open(struct input_dev *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
> +	int ret;

	int error;

> +
> +	/*
> +	 * Somebody is using the device: get out of sleep.
> +	 */
> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
> +				MAX7360_CFG_SLEEP, MAX7360_CFG_SLEEP);
> +	if (ret) {
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 configuration");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void max7360_keypad_close(struct input_dev *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
> +	int ret;

	int error;

> +
> +	/*
> +	 * Nobody is using the device anymore: go to sleep.
> +	 */
> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
> +				MAX7360_CFG_SLEEP, ~MAX7360_CFG_SLEEP);
> +	if (ret) {
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 configuration");
> +	}

No need for braces here.

> +}
> +
> +static int max7360_keypad_hw_init(struct max7360_keypad *max7360_keypad)
> +{
> +	unsigned int val;
> +	int ret;

	int error;

> +
> +	val = max7360_keypad->debounce_ms - MAX7360_DEBOUNCE_MIN;
> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_DEBOUNCE,
> +				MAX7360_DEBOUNCE,
> +				FIELD_PREP(MAX7360_DEBOUNCE, val));
> +	if (ret) {
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 debounce configuration");
> +		return ret;
> +	}
> +
> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_INTERRUPT,
> +				MAX7360_INTERRUPT_TIME_MASK,
> +				FIELD_PREP(MAX7360_INTERRUPT_TIME_MASK, 1));
> +	if (ret) {
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 keypad interrupt configuration");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max7360_keypad_parse_dt(struct platform_device *pdev,
> +				   struct max7360_keypad *max7360_keypad)
> +{
> +	bool no_autorepeat;
> +	int ret;
> +
> +	ret = matrix_keypad_parse_properties(&pdev->dev, &max7360_keypad->rows,
> +					     &max7360_keypad->cols);
> +	if (ret)
> +		return ret;
> +
> +	if (!max7360_keypad->rows || !max7360_keypad->cols ||
> +	    max7360_keypad->rows > MAX7360_MAX_KEY_ROWS ||
> +	    max7360_keypad->cols > MAX7360_MAX_KEY_COLS) {
> +		dev_err(&pdev->dev,
> +			"Invalid number of columns or rows (%ux%u)\n",
> +			max7360_keypad->cols, max7360_keypad->rows);
> +		return -EINVAL;
> +	}
> +
> +	max7360_keypad->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_keypad->regmap) {
> +		dev_err(&pdev->dev, "Could not get parent regmap\n");
> +		return -ENODEV;
> +	}

What this has to do with parsing DT? 

> +
> +	no_autorepeat = of_property_read_bool(pdev->dev.of_node,
> +					      "linux,input-no-autorepeat");

This is not a standard property, please using positive "autorepeat".

> +	max7360_keypad->no_autorepeat = no_autorepeat;

I do not think you need to store this in driver data, just check and
immediately set EV_REP bit.

> +
> +	max7360_keypad->debounce_ms = MAX7360_DEBOUNCE_MIN;
> +	ret = of_property_read_u32(pdev->dev.of_node, "debounce-delay-ms",
> +				   &max7360_keypad->debounce_ms);

Please use generic device properties:

	error = device_property_read_u32(...);

> +	if (ret == -EINVAL) {
> +		dev_info(&pdev->dev, "Using default debounce-delay-ms: %u\n",
> +			 max7360_keypad->debounce_ms);
> +	} else if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to read debounce-delay-ms property\n");
> +		return ret;
> +	} else if (max7360_keypad->debounce_ms < MAX7360_DEBOUNCE_MIN ||
> +		   max7360_keypad->debounce_ms > MAX7360_DEBOUNCE_MAX) {
> +		dev_err(&pdev->dev,
> +			"Invalid debounce-delay-ms: %u, should be between %u and %u.\n",
> +			max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN,
> +			MAX7360_DEBOUNCE_MAX);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max7360_keypad_probe(struct platform_device *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad;
> +	struct input_dev *input;
> +	unsigned long flags;
> +	int irq;
> +	int ret;

	int error;

> +
> +	if (!pdev->dev.parent)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "No parent device\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	max7360_keypad = devm_kzalloc(&pdev->dev, sizeof(*max7360_keypad),
> +				      GFP_KERNEL);
> +	if (!max7360_keypad)
> +		return -ENOMEM;
> +
> +	ret = max7360_keypad_parse_dt(pdev, max7360_keypad);
> +	if (ret)
> +		return ret;
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "Failed to allocate input device\n");
> +
> +	max7360_keypad->input = input;
> +
> +	input->id.bustype = BUS_I2C;
> +	input->name = pdev->name;
> +	input->dev.parent = &pdev->dev;

This is done by devm_input_allocate_device(), no need to repeat.

> +
> +	input->open = max7360_keypad_open;
> +	input->close = max7360_keypad_close;
> +
> +	ret = matrix_keypad_build_keymap(NULL, NULL,
> +					 MAX7360_MAX_KEY_ROWS,
> +					 MAX7360_MAX_KEY_COLS,
> +					 max7360_keypad->keycodes, input);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to build keymap\n");
> +
> +	input_set_capability(input, EV_MSC, MSC_SCAN);
> +	if (!max7360_keypad->no_autorepeat)
> +		__set_bit(EV_REP, input->evbit);
> +
> +	input_set_drvdata(input, max7360_keypad);
> +
> +	flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;

Shared? Why? And why do you need a temp variable?

> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					max7360_keypad_irq, flags,
> +					"max7360-keypad", max7360_keypad);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register interrupt: %d\n", ret);
> +
> +	ret = input_register_device(input);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Could not register input device: %d\n",
> +				     ret);
> +
> +	platform_set_drvdata(pdev, max7360_keypad);
> +
> +	device_init_wakeup(&pdev->dev, true);
> +	ret = dev_pm_set_wake_irq(&pdev->dev, irq);
> +	if (ret)
> +		dev_warn(&pdev->dev, "Failed to set up wakeup irq: %d\n", ret);
> +
> +	ret = max7360_keypad_hw_init(max7360_keypad);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to initialize max7360 keypad\n");

You need to clear wake irq here. Or move setting it to after HW init.

> +
> +	return 0;
> +}
> +
> +static void max7360_keypad_remove(struct platform_device *pdev)
> +{
> +	dev_pm_clear_wake_irq(&pdev->dev);
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id max7360_keypad_of_match[] = {
> +	{ .compatible = "maxim,max7360-keypad", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max7360_keypad_of_match);
> +#endif
> +
> +static struct platform_driver max7360_keypad_driver = {
> +	.driver = {
> +		.name	= "max7360-keypad",
> +		.of_match_table = of_match_ptr(max7360_keypad_of_match),
> +	},
> +	.probe		= max7360_keypad_probe,
> +	.remove		= max7360_keypad_remove,
> +};
> +module_platform_driver(max7360_keypad_driver);
> +
> +MODULE_DESCRIPTION("MAX7360 Keypad driver");
> +MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
> +MODULE_ALIAS("platform:max7360-keypad");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.39.5
> 

Thanks.

-- 
Dmitry

