Return-Path: <linux-pwm+bounces-5865-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CEBAB0EFE
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F384C38E8
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3120027F75F;
	Fri,  9 May 2025 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="O8VXS6no"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01627A925;
	Fri,  9 May 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782962; cv=none; b=TkREs4L5q1olPUs/Coxbp6/H9cB1BxUPzMzDJtf5K4LZjYNKit5SkJAXhjpGVn2ENOjhPtStmXqT9smDKu3u4GouA6+mzqZmPJ7luZmlWQfUfLPVStZS5OnCyJGQ43ddriO+Ent9UudiIgJ5FIcFZgewN1d3mq1rDyt7Qob4QIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782962; c=relaxed/simple;
	bh=JyK+fdEHecKizeMVTygzuAz5bKu1jHxKGa1EMszfEYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=risEY+ZXVVHgE25yhJKh+ri17WZscZJfIWlOH7yZLy8ktacDqUtfChrRYTvumhU3VmwJsWxKNfDKEaN2lIVempa3YbiW4d/qMoAhl04J606r3ynkNWjYgAvxKc5bXnroVlWfiiU/J0Bxo8JW3bG6H6KA/Rjvbzadr1CtpeCjddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=O8VXS6no; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id DK2buS2m2CaH2DK2cuYVme; Fri, 09 May 2025 11:29:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746782956;
	bh=9k2mrQAl7Cj0IfvW/DTZv9DLLgVCT9UG9X9Gsz14CR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=O8VXS6no49EtUOlSCetHI/Ib9q5NYZWAyyA2caN5K3Yqu7v7UAUwvWweX1jllzu17
	 R8PfTV9jrdLqxY5lr+hZKGE4O/chsNlbb8jMlVD9BtRPIFb7FZGX/wpQuQDmv0qYlx
	 iS2mGpqfMP1QwOlKRQ/iJVvQSfoTDlh+01uMBm9myo8l8gXgrMcvctmUkLTAZw/z5/
	 cW+iDS/J3SSOH7FWKMRJNi3KeypOXcVARnlotR4biDp7+xLY91bwUQtQCztEZ/5kUF
	 i7HHJswAe1ORvUClwsyH1iskLBRkFROoPKL7lVmFlWkjqMT18FrPTsBPSceOS7jcet
	 gs+f9DWJ5bKrw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 09 May 2025 11:29:16 +0200
X-ME-IP: 90.11.132.44
Message-ID: <69f72478-7102-4cfd-98d7-a93dcfe5a1a0@wanadoo.fr>
Date: Fri, 9 May 2025 11:29:13 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/11] mfd: Add max7360 support
To: mathieu.dubois-briand@bootlin.com, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kamel Bouhara
 <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-2-bbe486f6bcb7@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250509-mdb-max7360-support-v8-2-bbe486f6bcb7@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/05/2025 à 11:14, mathieu.dubois-briand@bootlin.com a écrit :
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add core driver to support MAX7360 i2c chip, multi function device
> with keypad, GPIO, PWM, GPO and rotary encoder submodules.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---

Hi,

...

> +static int max7360_mask_irqs(struct regmap *regmap)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	unsigned int val;
> +	int ret;
> +
> +	/*
> +	 * GPIO/PWM interrupts are not masked on reset: as the MAX7360 "INTI"
> +	 * interrupt line is shared between GPIOs and rotary encoder, this could
> +	 * result in repeated spurious interrupts on the rotary encoder driver
> +	 * if the GPIO driver is not loaded. Mask them now to avoid this
> +	 * situation.
> +	 */
> +	for (unsigned int i = 0; i < MAX7360_PORT_PWM_COUNT; i++) {
> +		ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> +					MAX7360_PORT_CFG_INTERRUPT_MASK,
> +					MAX7360_PORT_CFG_INTERRUPT_MASK);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to write MAX7360 port configuration");

Nitpick: Missing \n

> +	}
> +
> +	/* Read GPIO in register, to ACK any pending IRQ. */
> +	ret = regmap_read(regmap, MAX7360_REG_GPIOIN, &val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read GPIO values: %d\n", ret);

Nitpick: ret is not needed in the error message.

> +
> +	return 0;
> +}

...

CJ

