Return-Path: <linux-pwm+bounces-5206-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15BA6527E
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCDB1680E5
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F723FC68;
	Mon, 17 Mar 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ETmbRDB/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A92080F4;
	Mon, 17 Mar 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220794; cv=none; b=KjHpqBObUIGdZBklX+AESjyhIQbkYhtjv0ItJ9F43eg++FZZgWy1DMgOi3CysYyVKN2uuKgkyXtsPucujz+AWy42xXci+kNjKM4PzsKooBj2NrxYvCrvXyxe9Aj0+IbHL4mL4NCxfXpkn4yaaG0XmIP45QlfyJb07ihYi5TEiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220794; c=relaxed/simple;
	bh=Feg/Ppuea9RJgn7Wz78KNv7y0CPovHULrq/N29FKn9k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=FKXmh+Tma03F1cG3euTVKCERU63jpXGuFG1q9MyyE+os1kwNlozWU2SICRdm3IfDKvPl/zt9zjU2rL7KLX1JebRfDh6VC0TntwWs2X5vDgKcRpMrngsITu+Ng7BTohgKtn+r3n6+SfJGDQ5bWzuh0IfSxbxSX/S9AuxbjH+Mifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ETmbRDB/; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6CD62058C;
	Mon, 17 Mar 2025 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742220788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHcPeYxJQkDePf7dlku43JoIeqPciwMneqAALFAfqMU=;
	b=ETmbRDB/JwVZbHwvek3CLpa8+4HAg3pVC2Dj+EZX3BnSMPzuqWwo6kQdWAmCQmgP7YgRPm
	PnslxQ3iDB2JVmP9rWcf55p8c/zATn/CPWUEtfwWEq0GMIogBHuyiZkOTMQQGhEBDzUemF
	y5GG1ppMWo6qlJTf7fHDvue2OaKmy2U0vwGTHES7mgE+wifQsdIYCJX6SiNM9E/XsiTyjp
	Ttl4kGcDNnWBskaaQgPLzarNnn0ijWlXWUdJRPEI5EuK5kLOFiKuXYw4ipqxAz7Iw5SR2I
	xRUdpFjNWjR2jCIZhTr4Li0Xf3BKVFqyFDUbUPKs+QxJ599ByNVu0hmU+caW0A==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 15:13:07 +0100
Message-Id: <D8ILQ4NT6977.50SD8DM8FIBF@bootlin.com>
Subject: Re: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
 <Z69oa8_LKFxUacbj@smile.fi.intel.com>
 <D8FAX4E29LZK.3VUK90WB04MV2@bootlin.com>
 <Z9PlYSZDviGOCV7X@surfacebook.localdomain>
In-Reply-To: <Z9PlYSZDviGOCV7X@surfacebook.localdomain>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeeljedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegrnhguhidrshhhvghvtghhvghnkhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgth
 hgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Mar 14, 2025 at 9:14 AM CET, Andy Shevchenko wrote:
> Thu, Mar 13, 2025 at 06:07:03PM +0100, Mathieu Dubois-Briand kirjoitti:
> > On Fri Feb 14, 2025 at 4:59 PM CET, Andy Shevchenko wrote:
> > > On Fri, Feb 14, 2025 at 12:49:57PM +0100, Mathieu Dubois-Briand wrote=
:
> > > > Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
>
> ...
>
> > > > +	/*
> > > > +	 * MAX7360_REG_DEBOUNCE contains configuration both for keypad de=
bounce
> > > > +	 * timings and gpos/keypad columns repartition. Only the later is
> > > > +	 * modified here.
> > > > +	 */
> > > > +	val =3D FIELD_PREP(MAX7360_PORTS, ngpios);
> > > > +	ret =3D regmap_write_bits(regmap, MAX7360_REG_DEBOUNCE, MAX7360_P=
ORTS, val);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to write max7360 columns/gpos configuration=
");
> > > > +		return ret;
> > > > +	}
> > >
> > > Shouldn't this be configured via ->set_config() callback?
> >=20
> > I believe this comment has been a bit outdated by our discussion on
> > using GPIO valid mask, but I believe we could not use the ->set_config(=
)
> > callback here: this callback is made to configure a single pin while th=
e
> > gpos/keypad columns repartition is global.
>
> Yeah, we have similar desing in Intel Bay Trail (see pinctrl-baytrail.c) =
and it
> requires some software driven heuristics on how individual setting may af=
fect
> the global one. But the Q here is is the debounce affects only keypad? Th=
en it
> should be configured via keypad matrix driver. Btw, have you checked
> drivers/input/keyboard/matrix_keypad.c? Is there anything that can be use=
ful
> here?
>

Hum, maybe the comment is not clear enough? Not sure, but please tell
me.

So yes, this register is named "debounce" but controls two different
things:
- The keypad debounce: we do not touch it here.
- The partition between keypad columns and gpos. This is the value we do
  modify here.

I've been looking at drivers/input/keyboard/matrix_keypad.c, but I
believe the idea is completely different: it allows to use GPIOs to
create a keypad matrix, without the help of any controller. Here we have
a controller dedicated to keypad matrix, allowing to repurpose unused
columns as GPIOs. So except for some device tree similar properties and
input events, I believe there there isn't much we can reuse.

> ...
>
> > > > +		if (irq < 0)
> > > > +			return dev_err_probe(dev, irq, "Failed to get IRQ\n");
> > > > +
> > > > +		irq_chip =3D devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
> > > > +		if (!irq_chip)
> > > > +			return -ENOMEM;
> > > > +
> > > > +		irq_chip->name =3D dev_name(dev);
> > > > +		irq_chip->status_base =3D MAX7360_REG_GPIOIN;
> > > > +		irq_chip->num_regs =3D 1;
> > > > +		irq_chip->num_irqs =3D MAX7360_MAX_GPIO;
> > > > +		irq_chip->irqs =3D max7360_regmap_irqs;
> > > > +		irq_chip->handle_mask_sync =3D max7360_handle_mask_sync;
> > > > +		irq_chip->status_is_level =3D true;
> > > > +		irq_chip->irq_drv_data =3D regmap;
> > > > +
> > > > +		for (unsigned int i =3D 0; i < MAX7360_MAX_GPIO; i++) {
> > > > +			regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
> > > > +					  MAX7360_PORT_CFG_INTERRUPT_EDGES,
> > > > +					  MAX7360_PORT_CFG_INTERRUPT_EDGES);
> > > > +		}
> > > > +
> > > > +		flags =3D IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
> > > > +		ret =3D devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev), re=
gmap, irq, flags, 0,
> > > > +						      irq_chip, &irq_chip_data);
> > >
> > > Right.
> > >
> > > What I mean in previous discussion is to update gpio-regmap to call t=
his from inside.
> > > You need to add irq_chip pointer and irq_chip_data pointer to the reg=
map configuration
> > > and if they are set (or the first one, I dunno if this is supported b=
y IRQ chip core)
> > > call this function and assign domain. This should be called after GPI=
O chip is
> > > added, but before IRQ domain attachment.
> > >
> >=20
> > Ok, this is a bit more clear to me now. So I came up with something, it
> > will be part of the next iteration, probably during the next week.
> >=20
> > This required to add a few additional fields to the gpio_regmap_config
> > structure, specifying the IRQ configuration:
> >=20
> > + * @regmap_irq_chip:   (Optional) Pointer on an regmap_irq_chip struct=
ure. If
> > + *                     set, a regmap-irq device will be created and th=
e IRQ
> > + *                     domain will be set accordingly.
> > + * @regmap_irq_chip_data: (Optional) Pointer on an regmap_irq_chip_dat=
a
> > + *                      structure pointer. If set, it will be populate=
d with a
> > + *                      pointer on allocated regmap_irq data.
> > + * @regmap_irq_irqno   (Optional) The IRQ the device uses to signal in=
terrupts.
> > + * @regmap_irq_flags   (Optional) The IRQF_ flags to use for the inter=
rupt.
>
> Okay, just make sure it's guarded by the same ifdeffery as the similar in=
 the
> GPIO:
>
> #ifdef CONFIG_GPIOLIB_IRQCHIP
>

Thanks!

> ...
>
> > > > +
> > > > +		regmap_write(regmap, MAX7360_REG_GPIOOUTM, outconf);
> > > > +	}
> > > > +
> > > > +	/* Add gpio device. */
> > > > +	gpio_config.parent =3D dev;
> > > > +	gpio_config.regmap =3D regmap;
> > >
> > > > +	if (gpio_function =3D=3D MAX7360_GPIO_PORT) {
> > > > +		gpio_config.ngpio =3D MAX7360_MAX_GPIO;
> > >
> > > Why this case can't be managed also via ngpios property? Maybe at the=
 end of
> > > the day you rather need to have another property to tell where the sp=
lit is?
> > >
> > > This will help a lot and removes unneeded sharing of ngpios here and =
there.
> > >
> > > What I read from this code is like you are trying to put _two_in_one_=
 semantics
> > > on the shoulders of "ngpios".
> >=20
> > So as I reworked the keypad columns GPIOs, PORT GPIOs and the COL GPIOs
> > are a bit more similar on this point. So far I now use a constant value
> > assigned in the driver for both, as I believe there is no way the numbe=
r
> > of GPIOs could be a different. Yet I can easily switch back to a value
> > provided by a device property.
>
> Sounds good as long as ngpios is not overloaded with the additional meani=
ngs.

Thanks again for your review.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


