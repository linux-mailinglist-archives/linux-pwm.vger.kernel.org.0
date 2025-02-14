Return-Path: <linux-pwm+bounces-4896-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DDAA35D31
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 12:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72025188E209
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA5F263C7F;
	Fri, 14 Feb 2025 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kWmxyq49"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC73221541;
	Fri, 14 Feb 2025 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534075; cv=none; b=jDcL5QVBE33c9zp3xW8nIqLCXliI6uDmsmNUYAmul6ZLGTOn+LS222iHOqFiHye+sB/rxlitql6fzIlN5O8swv3i/UYKfz5QvXsIQKun4f+CDwEJvI41MC882KWKAOwliw0VJ8HhyNLpN4O0C6FqXs8wBjWuGgAnQjeos8YG5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534075; c=relaxed/simple;
	bh=HI8EwoC0v/mnJcoRwvIyzMEB3LbRz6V2OsbB0TGXVsk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=sCnJmOKTOi6uKNptMTR4DkBFQDgiumNkV4tE5LQ+VbVWnC0CwaYOE7XLjYNx0ajy1c8qabliFHZKhJQ8Z5zDyPlRrLsY0k+8ymZBR2W1preOLc9z7T0v406fzZ6ZOA97mTUWQElhzUKEBj9F24aVlQljgSL7d2VFPtx5zgEb6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kWmxyq49; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CE7D43297;
	Fri, 14 Feb 2025 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739534070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvZmD9qQBpCHdGYAx46m4LzLnVpR1HzltuJ00ZwvJPs=;
	b=kWmxyq49z3w8rvPqklSR4cZKhIzTAZrdVYqsPH/3vxHdX1CDu1xRFLUXxoVZBbXMr3R6Kc
	L8SMWnLd0QK/xls1QVTNObfCDNHXo0dM6x925LGxhmIkUMak57Z7E9iMK7Smy/hUbEOow2
	9iZ6/51rYMOGUFy+fy2USGSVuKYI41BWuzABzpazWfwhWBIod9Pw1cUtbVuEYW1w8If3i1
	f7yEczLbvYGdztdETdwf4vKQvL7gl3Sg1Sa83cWWSRTiCaflLE4jNe7VX6JfckqXgqcFhj
	et2jjbDPEwfs6OMvJlHAZ68ICr0q3Ocgd9GpnWuetsTMZciR/cga4CmI0+B24g==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 12:54:29 +0100
Message-Id: <D7S5D37XT80H.2WLFX1D18TZ6P@bootlin.com>
Subject: Re: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
In-Reply-To: <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeehhffhlefhkeejueegtdduleeuteffjeffhfekieevvdevlefgteefleevtedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrt
 ghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Feb 14, 2025 at 12:49 PM CET, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
>
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.
>
> Co-developed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
...
> +static int max7360_gpio_probe(struct platform_device *pdev)
...
> +	} else {
> +		u32 ngpios;
> +
> +		ret =3D device_property_read_u32(dev, "ngpios", &ngpios);
> +		if (ret < 0) {
> +			dev_err(dev, "Missing ngpios OF property\n");
> +			return ret;
> +		}
> +
> +		gpio_config.reg_set_base =3D GPIO_REGMAP_ADDR(MAX7360_REG_PORTS);
> +		gpio_config.reg_mask_xlate =3D max7360_gpo_reg_mask_xlate;
> +		gpio_config.ngpio =3D ngpios;

The device_property_read_u32() and setting of gpio_config.ngpio here
will be removed, once the "gpio: regmap: Make use of 'ngpios' property"
series gets merged.

https://lore.kernel.org/linux-gpio/20250213195621.3133406-1-andriy.shevchen=
ko@linux.intel.com/

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


