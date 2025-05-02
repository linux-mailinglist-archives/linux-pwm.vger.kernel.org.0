Return-Path: <linux-pwm+bounces-5809-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C006AA71E9
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 14:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E519E4C6987
	for <lists+linux-pwm@lfdr.de>; Fri,  2 May 2025 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F905252284;
	Fri,  2 May 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TlzZp1/0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D722D4C5;
	Fri,  2 May 2025 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189080; cv=none; b=oXnzORw4kvLnxIqx1VBm12fb0P0Wc1DhH1TJ6Myu2TIGZqUav7W6HXYqENlOF1jck1ulNuh4DA/SO/tezIFrroreMXOZTqwqwV0kPssVpP4JnFYnE9Nz9WZ1mAaufCL52fOXGYcYnCa9bVii0B3cEwzmTWAyApJlFYWva1CxMyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189080; c=relaxed/simple;
	bh=3G3CkBJ5xwmbD1aL2pXi9Vq8HxzS0MbLhvQFlo4eHDE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Rc1HVAL6IroCGRLJ9ahgrVnecv2mYBvaTNAdYIA7qlNnN4IIZjfeWDwk69bMBPrqDfnKr3HR8zJKn9UwpnQ23Tan8l20OaR1ftPKBOzZHRTpSxXQiFiwC782jlsFKgIYc0TzGsszlS7PMVm1lvZVpJqyNmDa/XBl49kNzH+QdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TlzZp1/0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF4C843B02;
	Fri,  2 May 2025 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746189075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVc5PbC2k1qdzHpLeknU2G3KgAO+5ptclccnAPwMI+M=;
	b=TlzZp1/0oKau46rbcImJXUoZfqTMdboxJb9zF5I+oT4MBM3UKybI43+7j3nTPbAC5Yp1mY
	29LSG9vQ9szDDM4I0Z6OnEc8/UVUIZu8q7weO0ntfpvOXV9V8+t1W+fI/CvinnTDMPoy5D
	L9LrATS0cs67BQ8+ByFdZD92EyDAX9WHhOr/s4ZPoMqan5z5GSQa/J4aBf3FCwmEKcrxBr
	p8QzSm1wQtK9kbA3OTc7Vk0px3qUla+7M5oZ9RcvWVpvfdnOxZ528ejZjI4wvN2AspDwFq
	fgCnH60HzO9LiKxoVy45e0ihTN6UwwnBzCP01UQGx1biZO9nAXGpdE/UDexZ+w==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 14:31:13 +0200
Message-Id: <D9LOD5X8NXF2.2GWBU2IAZESH7@bootlin.com>
Subject: Re: [PATCH v7 08/11] gpio: max7360: Add MAX7360 gpio support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bartosz Golaszewski"
 <bartosz.golaszewski@linaro.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
 <20250428-mdb-max7360-support-v7-8-4e0608d0a7ff@bootlin.com>
 <aBSg2qwNhPqJJRxK@smile.fi.intel.com>
In-Reply-To: <aBSg2qwNhPqJJRxK@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvgeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri May 2, 2025 at 12:39 PM CEST, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 01:57:26PM +0200, Mathieu Dubois-Briand wrote:
>> +static int max7360_gpio_probe(struct platform_device *pdev)
>> +{
>> +	const struct max7360_gpio_plat_data *plat_data;
>> +	struct gpio_regmap_config gpio_config =3D { };
>> +	struct regmap_irq_chip *irq_chip;
>> +	struct device *dev =3D &pdev->dev;
>> +	struct regmap *regmap;
>> +	unsigned int outconf;
>> +	int ret;
>> +
>> +	regmap =3D dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap)
>> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
>> +
>> +	plat_data =3D device_get_match_data(dev);
>> +	if (plat_data->function =3D=3D MAX7360_GPIO_PORT) {
>> +		if (device_property_read_bool(dev, "interrupt-controller")) {
>> +			/*
>> +			 * Port GPIOs with interrupt-controller property: add IRQ
>> +			 * controller.
>> +			 */
>> +			gpio_config.regmap_irq_flags =3D IRQF_ONESHOT | IRQF_SHARED;
>> +			gpio_config.regmap_irq_line =3D
>> +				fwnode_irq_get_byname(dev_fwnode(dev->parent), "inti");
>> +			if (gpio_config.regmap_irq_line < 0)
>> +				return dev_err_probe(dev, gpio_config.regmap_irq_line,
>> +						     "Failed to get IRQ\n");
>
>> +			irq_chip =3D devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
>
> Can this be made static const instead?
>

Sorry, I don't think we can. We do have a few data that will vary:
->name, but above all ->irq_drv_data, as it will point on the regmap of
the specific device.

> ...

OK with all other comments.

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


