Return-Path: <linux-pwm+bounces-4872-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16770A32B28
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 17:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56143A2E58
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4D21129F;
	Wed, 12 Feb 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gaZMkbsC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219E1B21AD;
	Wed, 12 Feb 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376542; cv=none; b=hbSGvQ+grgZMeKEvHGCBSgiFuuC9WU/KahFQ6IRMLni3LQcTGCjH3+/OVUjd0Xo4GlK/1s1kcOa4I6g12vMQ3gmlI32GgpnhZX5fPb4txtSp5jI1Du2jFCpaw1+U0dtLfXeSk3TippTrH4cMW7ENJnvTz5HCvms6P4EW78txExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376542; c=relaxed/simple;
	bh=JGAXxpEzZDp19Tm9FZ+cQGfxxod/rH2XENZjBdQ9YNc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=TgzCdR41Qkx67nM7AMVJOGelBfl8sp56KgjvIFSDY0A+DEI8COBfAG4e2lHsUzfTbhu66dQQUF8AaGG+tXUNnkWzIJOiimnUCU7B9HZ6bilyjs/55MG9/xe3pMpaZrmFFl45MUAtpE75V5Q6cTfl3m7132c8f67Np9OJnzOk8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gaZMkbsC; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B60AA441B7;
	Wed, 12 Feb 2025 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739376537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pm1shtqxNGtjXJC058AWPq2zZ6H04g+5wOZ4AwYEAdo=;
	b=gaZMkbsCMNA4g3MAXZ62NrfgKcsAf0zgxcB53muCcxn3u/vvbQnMylh0prT3oM+PEup30c
	DbbSy+f0cNBSLL0MpsbGvqN04Y4CrgNApzKHsW/RV8CtFBubgfmP5Fh3BFF8Vlt/2bAeH6
	BAPl7cvjpzh0LjWAIZ6W22X9UjuZ713brxI9JX+c9DYs5frq6D1DAgCqvknNnOlPNfP6iY
	KnYnqI9InDjwJLthokxPvubL8FtcJT5pVmYPLBiI5RudMtuZOPHXjJ+TgBET0cEMZqJ068
	x4WOa5QxJvpYjTWRdOh3hJxHCCZDot2NU51IXeQuKwEcPFUBXeYV7OSStbsOxA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 17:08:56 +0100
Message-Id: <D7QLITNTXRUJ.3NA44E6PQMAUX@bootlin.com>
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
In-Reply-To: <Z6y65SnrprvnpKEa@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Feb 12, 2025 at 4:14 PM CET, Andy Shevchenko wrote:
> On Wed, Feb 12, 2025 at 01:57:34PM +0100, Mathieu Dubois-Briand wrote:
> > On Mon Jan 27, 2025 at 2:07 PM CET, Andy Shevchenko wrote:
> > > On Mon, Jan 13, 2025 at 01:42:28PM +0100, Mathieu Dubois-Briand wrote=
:
>
> ...
>
> > > > +	parent =3D to_platform_device(pdev->dev.parent);
> > >
> > > Why do you need this? Can't the fwnode be propagated to the children =
and then
> > > the respective APIs to be used?
> >=20
> > I'm not sure to understand this correctly, what do you mean by
> > propagating the fwnode to the children?
> >=20
> > Just a quick summary of the situation and what I try to do. The device
> > tree looks like this, only keeping the interesting properties:
> >=20
> > io-expander@38 {
> >   ...
> >   interrupts =3D <23 IRQ_TYPE_LEVEL_LOW>,
> >                <24 IRQ_TYPE_LEVEL_LOW>;
> >   interrupt-names =3D "inti", "intk";
> >=20
> >   max7360_gpio: gpio {
> >     ...
> >   };
> >=20
> >   max7360_gpo: gpo {
> >     ...
> >   };
> > };
> >=20
> > Our pdev fwnode points either to the "gpio" or "gpo" nodes, the one fro=
m
> > our parent device points to "io-expander@38". Here we need to get the
> > "inti" interrupt from the parent node. What would be the correct way to
> > do it?
>
> Ah, I see now. This is being used only for IRQs, but don't you want to ca=
ll
> actually fwnode_irq_get_byname()? It will makes the intention clearer.
>

Sure! I can definitely call fwnode_irq_get_byname().

>
> > > > +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
> > > > +		dev_err(&pdev->dev, "Missing ngpios OF property\n");
> > > > +		return -ENODEV;
> > > > +	}
> > >
> > > This is not needed, it is already done in GPIOLIB core.
> >=20
> > I believe this is still needed:
> > - For gpos, we need the gpio count to correctly set the partition
> >   between gpo and keypad columns in max7360_set_gpos_count().
>
> Shouldn't be that done somewhere in the GPIO valid mask initialisation?
>
> > - For gpios, we need the gpio count to setup the IRQs.
>
> Doesn't GPIOLIB parse the property before initializing the IRQ valid mask
> and other init callbacks?

No, I believe I have to register the IRQ before registering the GPIO, so
I can get the IRQ domain.

Right now I have something like:

irq_chip->num_irqs =3D ngpios;
devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev), max7360_gpio->regmap,=
 irq, flags, 0, irq_chip, &irq_chip_data);
gpio_config.irq_domain =3D regmap_irq_get_domain(irq_chip_data);
devm_gpio_regmap_register(dev, &gpio_config);

Also, gpiolib will store ngpios in the gpio_chip structure, but while
using gpio-regmap, this structure is masked behind the opaque
gpio_regmap structure. So I believe there is no easy way to retrieve its
value.

This part of the code changed a lot, maybe it would be easier if I push
a new version of the series and we continue the discussion there?

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


