Return-Path: <linux-pwm+bounces-4935-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8702CA38182
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 12:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DF73A3F68
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1C3217670;
	Mon, 17 Feb 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RrI/MANu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B651A3A80;
	Mon, 17 Feb 2025 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791225; cv=none; b=oMXXieNlOKirK5aWptrZIY4NGkHbthFwtbL7TfUFXol9Km6lR9vL6K4BymAYEFMWCFrit0SwmqfoYgekLh2G6fJTzztZvslL3WDhV2ru/0bL4ZwF5lCakulZOlKglAXjJ2hAYJ6utIu5zBH/r/vwFC13pmFKcsuj5/d3UZZRNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791225; c=relaxed/simple;
	bh=qAPIZ4GUzWGR27RHXoSxQ1XbGWnYegkvF3qD0RJrWVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=JFB1ZpeplysIlRRZHJvCFzVFrZYuYs7GmThhKg7zQX6dqX6LyY1tyTHnw+6MbiCtJ4jsQLjWSf8+PnMXHPtmLLR9mZYql1v6ccKneNO1u89Re/7Ed32yC0wJFmMH31pUTHfrCvt4QfNodDr6IlwEd9bv4g4CqN0OEyokOrVo54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RrI/MANu; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A14BF44292;
	Mon, 17 Feb 2025 11:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739791214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTifytKq0afNIcuvxFzi/XOwR9oYhiX3X9pY3vR0uQ0=;
	b=RrI/MANuxnGOBG0g3fyNvrBoTmfydyqihAiFrlPsBvEmLWKRB24QsGTijXCrIo/DQoKLGw
	jUkOVkb5kV9SMT4JWI7yY6Kw9aWxq+YICf2ZxwPdls2NVN5PTjFooyosgYuIVXBRCRAqAR
	mUBX3aSWXPcBJR11m0eufjF6w34mUyrzJkhXAjJcgJuTDnL7lfVx4ElNKIot2AJp9lB+85
	tafABTqz5Qt8vJ44qcZFiPg2hmeM3Ziz5j7ZrotEkc/4VgNjImvQOwPkd8Bo1UZGZtXI81
	l6yk77Zf7rHr/bBDqJFD9dZB9lbblz49KVKxGX3tF8B3gjyrdA+FIgmkYrwCqA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Feb 2025 12:20:13 +0100
Message-Id: <D7UOIHL2WOZP.LLGRKMILNJFU@bootlin.com>
Subject: Re: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
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
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
 <Z69oa8_LKFxUacbj@smile.fi.intel.com>
In-Reply-To: <Z69oa8_LKFxUacbj@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkedviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheplefhhfetleegfeegfedviedtvedvvddtfedvfeegheeitdeiiefgvdeiteetlefgnecuffhomhgrihhnpegrnhgrlhhoghdrtghomhdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtohepl
 hgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Feb 14, 2025 at 4:59 PM CET, Andy Shevchenko wrote:
> On Fri, Feb 14, 2025 at 12:49:57PM +0100, Mathieu Dubois-Briand wrote:
> > Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
>
> ...
>
> > +static int max7360_gpo_reg_mask_xlate(struct gpio_regmap *gpio,
> > +				      unsigned int base, unsigned int offset,
> > +				      unsigned int *reg, unsigned int *mask)
> > +{
> > +	u16 ngpios =3D gpio_regmap_get_ngpio(gpio);
> > +
> > +	*reg =3D base;
> > +	*mask =3D BIT(MAX7360_MAX_KEY_COLS - (ngpios - offset));
> > +
> > +	return 0;
>
> Does this GPIO controller only capable of servicing keypads?
> I think no, hence I'm not sure why this split is needed to be
> here and not in the input driver.
>

I would say it's more a keypad controller able to support some GPIOs.
Some of the keypad columns, if unused, can be used as output-only gpios.
So I believe the split has its place here, because in the default
configuration, the split is set to have 8 keypad columns and no gpio. As
a consequence, the keypad driver can work without having to worry about
the split; the gpio driver needs to know about it.

To provide a bit more details, there is basically two set of pins usable
as GPIOs.

On one side we have what I refer to as GPIOs:
  - PORT0 to PORT7 pins of the chip.
  - Shared with PWM and rotary encoder functionalities. Functionality
    selection can be made independently for each pin. We have to ensure
    the same pin is not used by two drivers at the same time. E.g. we
    cannot have at the same time GPIO4 and PWM4.
  - Supports input and interrupts.
  - Outputs may be configured as constant current.
  - 8 GPIOS supported, so ngpios is fixed to MAX7360_MAX_GPIO.
  - maxim,max7360-gpio compatible, gpio_function =3D=3D MAX7360_GPIO_PORT.

On the other side, we have what I refer to as GPOs:
  - COL2 to COL7 pins of the chip.
  - Shared with the keypad functionality. Selections is made by
    partitioning the pins: first pins for keypad columns, last pins for
    GPOs. Partition is described by the ngpios property.
  - Only support outputs.
  - maxim,max7360-gpo compatible, gpio_function =3D=3D MAX7360_GPIO_COL.

> Or you mean that there output only GPIO lines in HW after all?
> Is there a link to the datasheet?

A datasheet is available on https://www.analog.com/en/products/max7360.html

>
> > +}
> > +
> > +static int max7360_gpio_request(struct gpio_chip *gc, unsigned int pin=
)
> > +{
> > +	/*
> > +	 * GPIOs on PORT pins are shared with the PWM and rotary encoder
> > +	 * drivers: they have to be requested from the MFD driver.
> > +	 */
>
> So, this sounds to me like a pin control approach is needed here.
> This looks like an attempt to hack it in an "easy" way.
>

Linus Walleij had a similar comment on v3, but said he thought it was
fine here. Still, I'm open to discussion.

> > +	return max7360_port_pin_request(gc->parent->parent, pin, true);
> > +}
> > +
> > +static void max7360_gpio_free(struct gpio_chip *gc, unsigned int pin)
> > +{
> > +	max7360_port_pin_request(gc->parent->parent, pin, false);
> > +}
> > +
> > +static int max7360_set_gpos_count(struct device *dev, struct regmap *r=
egmap)
> > +{
> > +	/*
> > +	 * MAX7360 COL0 to COL7 pins can be used either as keypad columns,
> > +	 * general purpose output or a mix of both.
> > +	 */
> > +	unsigned int val;
> > +	u32 columns;
> > +	u32 ngpios;
> > +	int ret;
> > +
> > +	ret =3D device_property_read_u32(dev, "ngpios", &ngpios);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Missing ngpios OF property\n");
>
> Clean messages from OF, "device property" is established term.
>

Yes

> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * Get the number of pins requested by the keypad and ensure our own =
pin
> > +	 * count is compatible with it.
> > +	 */
> > +	ret =3D device_property_read_u32(dev->parent, "keypad,num-columns", &=
columns);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to read columns count\n");
> > +		return ret;
> > +	}
> > +
> > +	if (ngpios > MAX7360_MAX_GPO ||
> > +	    (ngpios + columns > MAX7360_MAX_KEY_COLS)) {
> > +		dev_err(dev, "Incompatible gpos and columns count (%u, %u)\n",
> > +			ngpios, columns);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/*
> > +	 * MAX7360_REG_DEBOUNCE contains configuration both for keypad deboun=
ce
> > +	 * timings and gpos/keypad columns repartition. Only the later is
> > +	 * modified here.
> > +	 */
> > +	val =3D FIELD_PREP(MAX7360_PORTS, ngpios);
> > +	ret =3D regmap_write_bits(regmap, MAX7360_REG_DEBOUNCE, MAX7360_PORTS=
, val);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to write max7360 columns/gpos configuration");
> > +		return ret;
> > +	}
>
> Shouldn't this be configured via ->set_config() callback?
>

My understanding of the set_config() callback is that it's meant to set
the configuration of a single line. Here the configuration applies to
the whole chip.

> > +	return 0;
> > +}
>
> ...
>
> > +		if (irq < 0)
> > +			return dev_err_probe(dev, irq, "Failed to get IRQ\n");
> > +
> > +		irq_chip =3D devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
> > +		if (!irq_chip)
> > +			return -ENOMEM;
> > +
> > +		irq_chip->name =3D dev_name(dev);
> > +		irq_chip->status_base =3D MAX7360_REG_GPIOIN;
> > +		irq_chip->num_regs =3D 1;
> > +		irq_chip->num_irqs =3D MAX7360_MAX_GPIO;
> > +		irq_chip->irqs =3D max7360_regmap_irqs;
> > +		irq_chip->handle_mask_sync =3D max7360_handle_mask_sync;
> > +		irq_chip->status_is_level =3D true;
> > +		irq_chip->irq_drv_data =3D regmap;
> > +
> > +		for (unsigned int i =3D 0; i < MAX7360_MAX_GPIO; i++) {
> > +			regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> > +					  MAX7360_PORT_CFG_INTERRUPT_EDGES,
> > +					  MAX7360_PORT_CFG_INTERRUPT_EDGES);
> > +		}
> > +
> > +		flags =3D IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
> > +		ret =3D devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev), regmap=
, irq, flags, 0,
> > +						      irq_chip, &irq_chip_data);
>
> Right.
>
> What I mean in previous discussion is to update gpio-regmap to call this =
from inside.
> You need to add irq_chip pointer and irq_chip_data pointer to the regmap =
configuration
> and if they are set (or the first one, I dunno if this is supported by IR=
Q chip core)
> call this function and assign domain. This should be called after GPIO ch=
ip is
> added, but before IRQ domain attachment.
>

OK, I believe I got it now. I will try to work on it in the coming days.

> > +
> > +		regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
> > +	}
> > +
> > +	/* Add gpio device. */
> > +	gpio_config.parent =3D dev;
> > +	gpio_config.regmap =3D regmap;
>
> > +	if (gpio_function =3D=3D MAX7360_GPIO_PORT) {
> > +		gpio_config.ngpio =3D MAX7360_MAX_GPIO;
>
> Why this case can't be managed also via ngpios property? Maybe at the end=
 of
> the day you rather need to have another property to tell where the split =
is?
>
> This will help a lot and removes unneeded sharing of ngpios here and ther=
e.
>
> What I read from this code is like you are trying to put _two_in_one_ sem=
antics
> on the shoulders of "ngpios".
>

It could be managed with ngpios, just there is no specific need as we
will always have 8 gpios here. With (gpio_function =3D=3D
MAX7360_GPIO_PORT), there is no split and starting from this version of
my series, there is no reuse on ngpios property.

The split and reuse of ngpios is only used for GPO on keypad columns
(gpio_function =3D=3D MAX7360_GPIO_COL).

We can introduce a new property to tell where the split is, but the
number of gpio is a direct consequence of the position of the split.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


