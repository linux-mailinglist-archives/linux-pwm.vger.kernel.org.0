Return-Path: <linux-pwm+bounces-4531-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100569FF11F
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2024 18:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1A81882DBA
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2024 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D41ADFE4;
	Tue, 31 Dec 2024 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pzlolBp9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133C944E;
	Tue, 31 Dec 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735667449; cv=none; b=S0qCqzKqlrVOP10PD6I7R3E/Fg4CVU19Vk1qyjFMbjhipIkxup89KmreEf4F+bZgRxet8DMJDnwEEem+N8cQYmrPiTFMjafK39BVTDu+CPBIMZncffv8bY+cuQXjXuV2JsmmtJxw+uAlndITY2v5RftVD1gzuAmPy2noJniCl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735667449; c=relaxed/simple;
	bh=RQepdvOPDG+3D7qUdrDRwsy0idXcItm90wVfxTTtryY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qS5KvT35K/TBx1Mmr+axAodte0rbszl+QIhxBm62nWykcuezc0kHJKkJyeFd4NFDxVJCiMY0ampfoUDRNhFLpKwLxKnGG6D1TYelcAwJejq5rLdPUQA1HLttm1qKTDMrQCMSXyPKUtdF9j5u0bALfEbYfnjewgF8YgbPzD9ovSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pzlolBp9; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id SgMztjlG8ifTFSgN2tAfq6; Tue, 31 Dec 2024 18:49:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735667374;
	bh=SP0P11G0pmoaZcFdk5Wu/VpgVSI6Y81XCZzsiqaYWlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=pzlolBp9nhyJbQTIlteBaxxGEZ+0O48G1PwAOnn8ivpWC+s2Ar+Dbbgn12y3EA7w9
	 q8E34TldrGCyy/rY91kL5+aEYRg9fnYZquBd4eOLT73BaQcJhzne3/HFeLXGfllnKY
	 AK98kzMp6OooZE6nkTvF6qjKL1fEX8vXdAR942pq+OMniciseQEI9B0yFhLZ+Iwuyl
	 V0bEXM+bd3fpY2/ebvTrX4z5RDbGVVCLapBbxefZ1T0m27jdAMx7iWfbxnOFhGNrMW
	 pjuw+WpaFvkMR1dJdgC9UOHsK8jb7HRjYg5b/UHJmD2nHg9Qk3l+ZFdHCfvD1FDyAf
	 k9BUiWw7PR3BA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 31 Dec 2024 18:49:34 +0100
X-ME-IP: 90.11.132.44
Message-ID: <d3174dce-868c-4a42-9a5c-2b947ae88d18@wanadoo.fr>
Date: Tue, 31 Dec 2024 18:49:29 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] input: misc: Add support for MAX7360 rotary
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
 <20241223-mdb-max7360-support-v2-6-37a8d22c36ed@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241223-mdb-max7360-support-v2-6-37a8d22c36ed@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/12/2024 à 17:42, Mathieu Dubois-Briand a écrit :
> Add driver for Maxim Integrated MAX7360 rotary encoder controller,
> supporting a single rotary switch.
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

...

> +static irqreturn_t max7360_rotary_irq(int irq, void *data)
> +{
> +	struct max7360_rotary *max7360_rotary = data;
> +	int val;
> +	int ret;
> +
> +	ret = regmap_read(max7360_rotary->regmap, MAX7360_REG_RTR_CNT, &val);
> +	if (ret < 0) {
> +		dev_err(&max7360_rotary->input->dev,
> +			"Failed to read rotary counter");

Missing \n.

> +		return IRQ_NONE;
> +	}
> +
> +	if (val == 0) {
> +		dev_dbg(&max7360_rotary->input->dev,
> +			"Got a spurious interrupt");

Missing \n.

> +
> +		return IRQ_NONE;
> +	}
> +
> +	input_report_rel(max7360_rotary->input, max7360_rotary->axis,
> +			 (int8_t)val);
> +	input_sync(max7360_rotary->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int max7360_rotary_hw_init(struct max7360_rotary *max7360_rotary)
> +{
> +	int val;
> +	int ret;
> +
> +	ret = regmap_write_bits(max7360_rotary->regmap, MAX7360_REG_GPIOCFG,
> +				MAX7360_GPIO_CFG_RTR_EN,
> +				MAX7360_GPIO_CFG_RTR_EN);
> +	if (ret) {
> +		dev_err(&max7360_rotary->input->dev,
> +			"Failed to enable max7360 rotary encoder");

Missing \n.

> +		return ret;
> +	}
> +
> +	val = FIELD_PREP(MAX7360_ROT_DEBOUNCE, max7360_rotary->debounce_ms) |
> +		FIELD_PREP(MAX7360_ROT_INTCNT, 1) | MAX7360_ROT_INTCNT_DLY;
> +	ret = regmap_write(max7360_rotary->regmap, MAX7360_REG_RTRCFG, val);
> +	if (ret) {
> +		dev_err(&max7360_rotary->input->dev,
> +			"Failed to set max7360 rotary encoder configuration");

Missing \n.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max7360_rotary_probe(struct platform_device *pdev)
> +{
> +	struct max7360_rotary *max7360_rotary;
> +	struct input_dev *input;
> +	int irq;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "No parent device\n");
> +
> +	ret = max7360_port_pin_request(pdev->dev.parent, MAX7360_PORT_RTR_PIN,
> +				       true);
> +	if (ret)
> +		dev_err_probe(&pdev->dev, ret,
> +			      "Could not request rotary pin\n");

Missing return or done on purpose?

> +
> +	irq = platform_get_irq_byname(to_platform_device(pdev->dev.parent),
> +				      "inti");
> +	if (irq < 0)
> +		return irq;
> +
> +	max7360_rotary = devm_kzalloc(&pdev->dev, sizeof(*max7360_rotary),
> +				      GFP_KERNEL);
> +	if (!max7360_rotary)
> +		return -ENOMEM;
> +
> +	max7360_rotary->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_rotary->regmap)
> +		dev_err_probe(&pdev->dev, -ENODEV,
> +			      "Could not get parent regmap\n");
> +
> +	device_property_read_u32(pdev->dev.parent, "linux,axis",
> +				 &max7360_rotary->axis);
> +	device_property_read_u32(pdev->dev.parent, "rotary-debounce-delay-ms",
> +				 &max7360_rotary->debounce_ms);
> +	if (max7360_rotary->debounce_ms > MAX7360_ROT_DEBOUNCE_MAX)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "Invalid debounce timing: %u\n",
> +				     max7360_rotary->debounce_ms);
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +				     "Failed to allocate input device\n");

Not sure an error message is needed.

> +
> +	max7360_rotary->input = input;
> +
> +	input->id.bustype = BUS_I2C;
> +	input->name = pdev->name;
> +	input->dev.parent = &pdev->dev;
> +
> +	input_set_capability(input, EV_REL, max7360_rotary->axis);
> +	input_set_drvdata(input, max7360_rotary);
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +					max7360_rotary_irq,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> +					"max7360-rotary", max7360_rotary);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to register interrupt: %d\n", ret);

No need to duplicate ret.

> +
> +	ret = input_register_device(input);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Could not register input device: %d\n",
> +			ret);

No need to duplicate ret.

> +
> +	platform_set_drvdata(pdev, max7360_rotary);
> +
> +	device_init_wakeup(&pdev->dev, true);
> +	ret = dev_pm_set_wake_irq(&pdev->dev, irq);
> +	if (ret)
> +		dev_warn(&pdev->dev, "Failed to set up wakeup irq: %d\n", ret);
> +
> +	ret = max7360_rotary_hw_init(max7360_rotary);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to initialize max7360 rotary\n");
> +
> +	return 0;
> +}

CJ


