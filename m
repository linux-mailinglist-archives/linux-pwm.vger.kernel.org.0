Return-Path: <linux-pwm+bounces-5256-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7421A6A0D9
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 08:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136441896033
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD4204F85;
	Thu, 20 Mar 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A2d7DrN7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED231E3769;
	Thu, 20 Mar 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457370; cv=none; b=AF7QRjiw+EC47/A1FMNw+TJu8KLqbjGEqMbjslp+/8Aooc7KGruv14DDnHh/R+gDBFDJeDgI2qN0a/oBf1KiZmqvEu5tN0VKfTbXtjl22KDXPG4s+EK1WT+23ovHQg99sMPFuJ610YmzVwmRi6A384SrSVbAVV2lXEOWyvzQs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457370; c=relaxed/simple;
	bh=COjos0khRUH9y6KLguMtzNcd2P1JRnsqbD84w4Yq88A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=cSYPN5RuRK3JY4ATwvheq3nCjnvD+EuQJ6ejAnQRmFfsz/HpKHH0x+DPWzFZoJF8JCsonF/Vv71/mjhR11tdE1iTFE4zPRVS7Juc+Jsx8Tk/VOjlCB8J+cj0TnAccygopnq8n4JRq2cgNrjyXR61F2UqL3SVjTXnN4QdxGJFHTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A2d7DrN7; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6614B42E7E;
	Thu, 20 Mar 2025 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742457358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8twcIz9qrGerD1E+A0oaKwo2dI3Ee3wQa3t5hEGonhc=;
	b=A2d7DrN7hvTOb7mYRP1SiVjjzU8D1VxR1xAMCzM9im2Fv5+IHM0w2NF+vgW0SGill6O0la
	uJ+Aq+rn6j2LWEl4zMPhYaaJ0HimXIl//j3wMyjQVZRQ2eithV4ijnZC3XTkE88Za5XqDo
	rNpFAF4U7daZWXhhTGWDBE8YpmIHJniXgwsdcU8FaE6jZm8s36mZEhjQFy0mOyN4rLCnke
	pv5TIhQk9v/bHrTYfh2vzoIN3kNQJnyydHUg2HnwcwtzXJ55wtluki4YiMxd7MJ/MlPwRG
	pUqOj8cimOFmE3pzF9/jrL4YVJeoC1lKtgN6DaMHnU1BNcS+/Fzc/nAWkZJyFQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 08:55:57 +0100
Message-Id: <D8KXKZ53OKGH.4LG4L2LRY9XS@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
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
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
 <Z9mksuMAlNCa447h@smile.fi.intel.com>
In-Reply-To: <Z9mksuMAlNCa447h@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkhffvufevofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehvedtkeffueelheektddvjefhiefhgedtudevgeehvdevlefgveetkeevleelteenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmegrieeimeefudektdemtgdtsggvmegslegrkeemvgehledvmeeirgeffhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemrgeiieemfedukedtmegttdgsvgemsgelrgekmegvheelvdemiegrfehfpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhor
 hhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Mar 18, 2025 at 5:52 PM CET, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:26:22PM +0100, Mathieu Dubois-Briand wrote:
> > GPIO controller often have support for IRQ: allow to easily allocate
> > both gpio-regmap and regmap-irq in one operation.
>
> ...
>
> > -	if (config->irq_domain) {
> > -		ret =3D gpiochip_irqchip_add_domain(chip, config->irq_domain);
>
> > +	irq_domain =3D config->irq_domain;
>
> Better to move it into #else, so we avoid double assignment (see below).
>

OK

> > +#ifdef CONFIG_GPIOLIB_IRQCHIP
> > +	if (config->regmap_irq_chip) {
> > +		struct regmap_irq_chip_data *irq_chip_data;
> > +
> > +		ret =3D devm_regmap_add_irq_chip_fwnode(config->parent, dev_fwnode(c=
onfig->parent),
> > +						      config->regmap, config->regmap_irq_irqno,
> > +						      config->regmap_irq_flags, 0,
> > +						      config->regmap_irq_chip, &irq_chip_data);
> > +		if (ret)
> > +			goto err_free_gpio;
> > +
> > +		irq_domain =3D regmap_irq_get_domain(irq_chip_data);
> > +		if (config->regmap_irq_chip_data)
> > +			*config->regmap_irq_chip_data =3D irq_chip_data;
>
> Hmm... I was under impression that we don't need this to be returned.
> Do we have any user of it right now? If not, no need to export until
> it is needed.
>

Right, I will remove it.

> > +	}
>
> 	} else
>
> > +#endif
>
> 	irq_domain =3D config->irq_domain;
>
> > +
> > +	if (irq_domain) {
> > +		ret =3D gpiochip_irqchip_add_domain(chip, irq_domain);
> >  		if (ret)
> >  			goto err_remove_gpiochip;
> >  	}
>
> ...
>
> > +#ifdef CONFIG_GPIOLIB_IRQCHIP
> > +	struct regmap_irq_chip *regmap_irq_chip;
> > +	struct regmap_irq_chip_data **regmap_irq_chip_data;
>
> But why double pointer?
>

I believe this has to be a double pointer, as it is going to be assigned
a pointer value: data buffer is allocated inside of
devm_regmap_add_irq_chip_fwnode().

But as you said, it's better to remove it and add it later if there is
an use case.

> > +	int regmap_irq_irqno;
> > +	unsigned long regmap_irq_flags;
> > +#endif

Thanks for your review.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


