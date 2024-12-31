Return-Path: <linux-pwm+bounces-4530-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749809FF116
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2024 18:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCD418829A1
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2024 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF81AB6DD;
	Tue, 31 Dec 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pn7nUkri"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9729415;
	Tue, 31 Dec 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735667194; cv=none; b=V2bImgAMk6KrNOk/MwV3MtI0+hvxSlBMOnktV5SYnvNvU2Qu9nMpivfppAvuEHYaZy8N+IDEE19Gu/QQMipAYwtwFocobmOgwPSSS4o9Lf8JZQAcTlPAjS3wd/kg3oA3xSn1euARbEWBXmJsfbjXeOLyiwyI6uUrWWWwuOSomu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735667194; c=relaxed/simple;
	bh=b3kJQSRlOuwmiP9FvyvwKX2+5UtaH5W+Q6wQ0S4lZUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hr8WTTyBbmv8SJe4fZr/qUyp/Ov+ofvH0ioOwPcrAmQYpH1GBWAQHswupBAXU2lupx26x8QRvfboZDU8tpz6ttfKMBjyT4a4H5fIb6sKtxC239scUVJRMTx+TssNSMKp0v/junh9k3tJAgUjgILY9niJwrkuOpD31Ta6fAyc7p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pn7nUkri; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id SgIutFpsjolrGSgIxtmvwD; Tue, 31 Dec 2024 18:45:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735667120;
	bh=tAnaZKrfMtUTk+GrqVDfErJjKr6kecOcPoeVpxfvUvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=pn7nUkriIGV5cF4/Yrt13Fc3HvKFby+Nwuz7K9tCw+acwxp3cKAWULAVNM3/3v5nl
	 QKhiSV1oAXoyK1BdMBs19+oBpLja3eCaR9Qb5xcsOFDtRWDeeiTO8us5aiJk7DYG24
	 E+8+NpVoz0x2XB1elD4QtvMGff8dFqG9snoMr/GaZzVoGI64WqdYic0SCPX5CSScJX
	 A6QdUzQFYj34cxbi0KPKZDLL3gO+zDWOyX8Dc4VhamopjZuqPifihIZnvQB2gZdyTB
	 e0mm03D+WXXq/mZI8WN1jqjA1zlx4vrpTIUmqGZAtjv5xgXaIYFoJFrnkgl7A9WHOD
	 l64YNB6ORAQDA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 31 Dec 2024 18:45:20 +0100
X-ME-IP: 90.11.132.44
Message-ID: <b11abf7f-a25f-493b-a714-463a7dab8117@wanadoo.fr>
Date: Tue, 31 Dec 2024 18:45:15 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] input: keyboard: Add support for MAX7360 keypad
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-pwm@vger.kernel.org, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-5-37a8d22c36ed@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241223-mdb-max7360-support-v2-5-37a8d22c36ed@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/12/2024 à 17:42, Mathieu Dubois-Briand a écrit :
> Add driver for Maxim Integrated MAX7360 keypad controller, providing
> support for up to 64 keys, with a matrix of 8 columns and 8 rows.
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

...

> +static int max7360_keypad_open(struct input_dev *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
> +	int error;
> +
> +	/*
> +	 * Somebody is using the device: get out of sleep.
> +	 */
> +	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
> +				  MAX7360_CFG_SLEEP, MAX7360_CFG_SLEEP);
> +	if (error) {
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 configuration");

Missing \n.

> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static void max7360_keypad_close(struct input_dev *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
> +	int error;
> +
> +	/*
> +	 * Nobody is using the device anymore: go to sleep.
> +	 */
> +	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
> +				  MAX7360_CFG_SLEEP, ~MAX7360_CFG_SLEEP);
> +	if (error)
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 configuration");

Missing \n.

> +}
> +
> +static int max7360_keypad_hw_init(struct max7360_keypad *max7360_keypad)
> +{
> +	unsigned int val;
> +	int error;
> +
> +	val = max7360_keypad->debounce_ms - MAX7360_DEBOUNCE_MIN;
> +	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_DEBOUNCE,
> +				  MAX7360_DEBOUNCE,
> +				  FIELD_PREP(MAX7360_DEBOUNCE, val));
> +	if (error) {
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 debounce configuration");

Missing \n.
This is called from probe. Use dev_err_rpobe()?

> +		return error;
> +	}
> +
> +	error = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_INTERRUPT,
> +				  MAX7360_INTERRUPT_TIME_MASK,
> +				  FIELD_PREP(MAX7360_INTERRUPT_TIME_MASK, 1));
> +	if (error) {
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 keypad interrupt configuration");

Missing \n.
This is called from probe. Use dev_err_rpobe()?

> +		return error;
> +	}
> +
> +	return 0;
> +}

...

> +static int max7360_keypad_probe(struct platform_device *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad;
> +	struct input_dev *input;
> +	bool autorepeat;
> +	int error;
> +	int irq;
> +
> +	if (!pdev->dev.parent)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "No parent device\n");
> +
> +	irq = platform_get_irq_byname(to_platform_device(pdev->dev.parent),
> +				      "intk");
> +	if (irq < 0)
> +		return irq;
> +
> +	max7360_keypad = devm_kzalloc(&pdev->dev, sizeof(*max7360_keypad),
> +				      GFP_KERNEL);
> +	if (!max7360_keypad)
> +		return -ENOMEM;
> +
> +	max7360_keypad->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_keypad->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Could not get parent regmap\n");
> +
> +	error = max7360_keypad_parse_dt(pdev, max7360_keypad, &autorepeat);
> +	if (error)
> +		return error;
> +
> +	input = devm_input_allocate_device(pdev->dev.parent);
> +	if (!input)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "Failed to allocate input device\n");

Not sure an error message is needed.

> +
> +	max7360_keypad->input = input;
> +
> +	input->id.bustype = BUS_I2C;
> +	input->name = pdev->name;
> +	input->open = max7360_keypad_open;
> +	input->close = max7360_keypad_close;
> +
> +	error = matrix_keypad_build_keymap(NULL, NULL,
> +					   MAX7360_MAX_KEY_ROWS,
> +					   MAX7360_MAX_KEY_COLS,
> +					   max7360_keypad->keycodes, input);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "Failed to build keymap\n");
> +
> +	input_set_capability(input, EV_MSC, MSC_SCAN);
> +	if (autorepeat)
> +		__set_bit(EV_REP, input->evbit);
> +
> +	input_set_drvdata(input, max7360_keypad);
> +
> +	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					  max7360_keypad_irq,
> +					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					  "max7360-keypad", max7360_keypad);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "Failed to register interrupt: %d\n",
> +				     error);

No need to duplicate error.

> +
> +	error = input_register_device(input);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "Could not register input device: %d\n",
> +				     error);

No need to duplicate error.

> +
> +	platform_set_drvdata(pdev, max7360_keypad);
> +
> +	error = max7360_keypad_hw_init(max7360_keypad);
> +	if (error)
> +		return dev_err_probe(&pdev->dev, error,
> +				     "Failed to initialize max7360 keypad\n");
> +
> +	device_init_wakeup(&pdev->dev, true);
> +	error = dev_pm_set_wake_irq(&pdev->dev, irq);
> +	if (error)
> +		dev_warn(&pdev->dev, "Failed to set up wakeup irq: %d\n",
> +			 error);
> +
> +	return 0;
> +}

CJ

