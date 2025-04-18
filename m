Return-Path: <linux-pwm+bounces-5572-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB10FA93A1E
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 17:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9F31B64878
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 15:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E6F2144C1;
	Fri, 18 Apr 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dPxgNa/t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-76.smtpout.orange.fr [80.12.242.76])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF52AE66;
	Fri, 18 Apr 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991556; cv=none; b=HVhZ+CWMxo5BAataH/lbd9fb/0FymCZFZB4WrV5uXTZ3lv/1DRwjOau8T/s+FIuxzJWFx8ya94DrA1/vgXWrIAR/GbCArdeDBwUV0WvJmkUW1G7vwasS4KVjI/u5FLSLbl5untjVJ/X/LfS4fSTqjCv/IfhSFt3HfPW2Bit7Y5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991556; c=relaxed/simple;
	bh=1Emak3AAkccjDPd7EknzHq8TpQF/zfiGooX0eA5TUn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDJQmjTHoW/3IrAVNpzbamLK2aUivCcVnY9QkfMTB1UPbMZhyvXhjqBOcfscPcBVS+sgGwZTP+hXqxmFSewqXbn3GEZIugljKzAA8NCougpbHyeRIGMxw+1J35XGD4R0JPNAGSWcCqtgAtIcRlTQyvX8lENRIXMfMgFcVmf7JOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dPxgNa/t; arc=none smtp.client-ip=80.12.242.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 5o0puqlbAGpxt5o0tulgtS; Fri, 18 Apr 2025 17:52:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1744991545;
	bh=/3XbO54OHHSOFYDyx+q6qR+5BrYP+5NiGlMKjT7FF+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dPxgNa/tn3heYvaUNc5aUOSVroj/M2lR0GMnG89fbgsiKl2iNJrbT5soqOXtGQLAf
	 FYesmR/IeNn4YmHuqcx26ivCvCzi98gNaXR/EwvLPLfrVBPNdYVlr9rjcOUna1KzPL
	 Pd2uC0N0t08j0xTETgEUHiEM9ut/uCCSDnYo7/LhbMrb06esP0ThGe53OgBb1OVwn9
	 VRsqyw9ZmKfRxZ9x7gyp/9INNQ/fqQjBAhKBwaFodYVmzQRk4nmHZqGtK1ziuuMejo
	 QjR8BNn0LVsG4rfCFqfBFO7TAkjHr8RjZ5WZGODJNrEpRtE0NrxmgqJDHX82Piej+t
	 uADFNiXUGYY9A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 18 Apr 2025 17:52:25 +0200
X-ME-IP: 90.11.132.44
Message-ID: <bb269f81-d33e-4292-89df-4c8cf40b3077@wanadoo.fr>
Date: Fri, 18 Apr 2025 17:52:19 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/12] mfd: Add max7360 support
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
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-2-7a2535876e39@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250409-mdb-max7360-support-v6-2-7a2535876e39@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/04/2025 à 16:55, mathieu.dubois-briand@bootlin.com a écrit :
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add core driver to support MAX7360 i2c chip, multi function device
> with keypad, GPIO, PWM, GPO and rotary encoder submodules.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---

...

> +	ret = max7360_mask_irqs(regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Could not mask interrupts\n");
> +
> +	ret =  devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,

Nitpick: 2 spaces after =

> +				    max7360_cells, ARRAY_SIZE(max7360_cells),
> +				    NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register child devices\n");
> +
> +	return 0;
> +}
> +

