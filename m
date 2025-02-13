Return-Path: <linux-pwm+bounces-4878-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39662A33D2B
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 12:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71DED7A4220
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Feb 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305252139DF;
	Thu, 13 Feb 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d/Mhh3Nd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5C82139D2;
	Thu, 13 Feb 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444384; cv=none; b=C0/0rxFFiEDEyiEtrotz0ajlSzWCRdybZElc0mS8lQUlzyLt50QPMpR3J4KbTVktsVv6aP/LuV/Oi16RX0TcYyFkxcWF1wll3xLEd/uiQE6lHoaDGfrNJpslvNpPqQcKWcoZoNMM3IMVINGAGB5WK2cuU8KnlTupCrgf7eAfR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444384; c=relaxed/simple;
	bh=xDVrlK0GSHvz7tJRAfdNrY4o62bDOvoV3gSyda5z/eY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=rKlnWB/fwxYmjM7c+b1eCeu4XG/TajxFfo6k1k/R5iUuWp5p1WAUS/HlN73vsf0O8za0ZNBIaFpVpnejohoPL8lMNE9USEFbeN6IBmgBoUNco44RNyGDrblcqu/mhIspiguKZ9ZgXq+lAoxTM4FUdlOOMRFX2pECmpOtUyFaIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d/Mhh3Nd; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0E6D432FC;
	Thu, 13 Feb 2025 10:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739444372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZl2hgZn7jehdjIzednng7eJxpp/nrLuv91gbdmRYjc=;
	b=d/Mhh3Ndhg3JWzdTG+RTBCkhAXySiufk0uR/wo4ytLWc73hLlZvo2H8+IZYVuuOlY5b9Ge
	PNN29nwIV+50n1wIo+baZ78rS7VGFoYGz/8Cm0DghC9TnB9dkrWUYRJI8beC68TRRJXh5V
	eijwN0Yuso8xbb2ildJj686MKCaf9ht0P8HGziPcS8c8zjAes5zznOpgpua9OasFWa/Yqx
	4oI1RYoji9hl94+Mp+tqQEQtYM8Efake2lhAacsQOM5AKT0Ob8IUhrrtGDt3jhDz7k7WYl
	uNveQP3olQ8PPZ6X7hag01RNYtSzrOX86vVkNG3N7f02PGdplYge93E3Tr0Dsw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Feb 2025 11:59:31 +0100
Message-Id: <D7R9KGN6EMDM.1DCDL4P5RC23B@bootlin.com>
Subject: Re: [PATCH v3 4/7] gpio: max7360: Add MAX7360 gpio support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <Z5eFGJspoGOINcG6@smile.fi.intel.com>
 <D7QHGB7D0VSG.X255SDU7DFOF@bootlin.com>
 <Z6y65SnrprvnpKEa@smile.fi.intel.com>
 <D7QLITNTXRUJ.3NA44E6PQMAUX@bootlin.com>
 <Z6zJljphfTuEhBTP@smile.fi.intel.com>
In-Reply-To: <Z6zJljphfTuEhBTP@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Feb 12, 2025 at 5:17 PM CET, Andy Shevchenko wrote:
> On Wed, Feb 12, 2025 at 05:08:56PM +0100, Mathieu Dubois-Briand wrote:
> > On Wed Feb 12, 2025 at 4:14 PM CET, Andy Shevchenko wrote:
> > > On Wed, Feb 12, 2025 at 01:57:34PM +0100, Mathieu Dubois-Briand wrote=
:
> > > > On Mon Jan 27, 2025 at 2:07 PM CET, Andy Shevchenko wrote:
> > > > > On Mon, Jan 13, 2025 at 01:42:28PM +0100, Mathieu Dubois-Briand w=
rote:
>
> ...
>
> > > > > > +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios=
)) {
> > > > > > +		dev_err(&pdev->dev, "Missing ngpios OF property\n");
> > > > > > +		return -ENODEV;
> > > > > > +	}
> > > > >
> > > > > This is not needed, it is already done in GPIOLIB core.
> > > >=20
> > > > I believe this is still needed:
> > > > - For gpos, we need the gpio count to correctly set the partition
> > > >   between gpo and keypad columns in max7360_set_gpos_count().
> > >
> > > Shouldn't be that done somewhere in the GPIO valid mask initialisatio=
n?
> > >
> > > > - For gpios, we need the gpio count to setup the IRQs.
> > >
> > > Doesn't GPIOLIB parse the property before initializing the IRQ valid =
mask
> > > and other init callbacks?
> >=20
> > No, I believe I have to register the IRQ before registering the GPIO, s=
o
> > I can get the IRQ domain.
> >=20
> > Right now I have something like:
> >=20
> > irq_chip->num_irqs =3D ngpios;
> > devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev), max7360_gpio->reg=
map,
> > irq, flags, 0, irq_chip, &irq_chip_data);
> > gpio_config.irq_domain =3D regmap_irq_get_domain(irq_chip_data);
> > devm_gpio_regmap_register(dev, &gpio_config);
> >=20
> > Also, gpiolib will store ngpios in the gpio_chip structure, but while
> > using gpio-regmap, this structure is masked behind the opaque
> > gpio_regmap structure. So I believe there is no easy way to retrieve it=
s
> > value.
> >=20
> > This part of the code changed a lot, maybe it would be easier if I push
> > a new version of the series and we continue the discussion there?
>
> So, what seems need to be added is some flag to GPIO regmap configuration
> data structure and a code that is called after gpiochip_add_data() in
> gpio_regmap_register() to create a domain. This will solve the above issu=
e
> and helps other drivers to get rid of potential duplication of
> devm_regmap_add_irq_chip_fwnode() calls.
>
> Have you researched this path?

OK, so looking at the code, I believe it would need to:
- Add some flag in gpio_regmap_config structure, so
  gpio_regmap_register() creates a new IRQ domain.
- Add a function allowing to retrieve this domain out of the gpio_regmap
  structure.
- Allow to pass a domain in the regmap_irq_chip structure, so
  regmap_add_irq_chip_fwnode() use this domain instead of calling
  regmap_irq_create_domain().
- Make sure this domain is still populated with the IRQ data: number of
  IRQs, IRQ base but also a pointer on the regmap_irq_chip_data
  structure in .host_data. I believe this will be a bit tricky.
- Add a function allowing to retrieve ngpio out of the
  gpio_regmap.gpio_chip structure, so it can be used for IRQ setup and
  other places of the driver.

I'm sorry, but I feel like this is a lot of changes to solve this point.
I've been thinking about it, and I can suggest a different solution.

For gpios, I will remove the ngpios property of the device tree and use
a fixed value:
- For the today version of the chip, this is always 8.
- I a chip variant or a similar chip ever arise later with a different
  number of gpios, the fixed value can be set according to the
  "compatible" value.
- This removes any issue with the IRQ setup.

For gpos, we have to keep ngpios, as it depends of the implementation on
the board. That means ngpios will be used:
- For the gpio chip configuration: we let gpiolib retrieve it from the
  device tree.
- In gpio-regmap reg_mask_xlate callback: I can add a function allowing
  to retrieve it from gpio_regmap.gpio_chip, as suggested above.
- In max7360_set_gpos_count() to validate the coherency between
  requested gpios and keypad columns and set the correct configuration
  on the chip:
  - I can also retrieve the value from gpio_regmap.gpio_chip, but that
    means the check is made after the call to
    devm_gpio_regmap_register().
  - Or I will still need to retrieve it using device_property_read_u32()
    here.

How do you feel about this solution?

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


