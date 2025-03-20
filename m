Return-Path: <linux-pwm+bounces-5257-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DC0A6A177
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 09:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1C0464B12
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0620C477;
	Thu, 20 Mar 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vs2Zs7IE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7984D135A53;
	Thu, 20 Mar 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459722; cv=none; b=EMvvw6yOUhmTFWac0XaOWqBsFyp9/xzWiIwBJC8XjYF7Kt4/+uVHSp36B/1s/4BDCTt9f9NOB9t8zDVcV/Pp/Qs7dIE37YL2VKeJXfphHQA47id/4YEnWF0dCF3M8o85ktYOJlqFF0HgRXyG6ERDTPICg6hxcSW/xzXqoCOuv/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459722; c=relaxed/simple;
	bh=sUziqnDx5HipdXEQZzKdU/xJa6kyN7gQKQ+NgAfVeEU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Lh1Vkfd7e/M7y6M0ZQ85anHZDQjOsDJa1jPrxB8JzBn+WOzsLpW1oWLY6Nl3g1apyaNDGEjOqqSCuSFU0XP0vQMIW/NZg8N60obpRtTqddMCSNCTdT7Z+OobX7w7urZHuOKGaaRnsGtUX1aeX+4w4lSYtUlse2UEFqBnzJnhSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vs2Zs7IE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63F1E44352;
	Thu, 20 Mar 2025 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742459716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akGvbcc/DlR2ufwKb6VM3ncFhbuTbmowB2fKkrdI8X0=;
	b=Vs2Zs7IEPUnrYZWWQRTcAjYTOYWWnkRbgrKvEU4tI1weTDrwLQd4wPE7ZDzmJKE90Ie4gD
	oiSV5oiBE1AeC6xRrpAmsRJu7nkHKa2ObeAlOfjz0xjz5MtGs9Yth5fSFLyLD/Fgpu87qJ
	iyfXg464IGz39lN7lIB1npGQBBed6W1dkioQvarDVMN5sTtQOw6rX+LB4k0/pcAuqh2Awc
	sF4hHRFk6vNNybfj4F9aXJBRagYyhXJvgRybpKtANdkjJGKZl0llddqEQwFq/uNrfJPwnX
	KjN4DAMMb4+/k2zAtRvsQNIUF2n8KRrvWcZ25vLbBfZWuuy/FfQI+vMEf/FN1A==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 09:35:15 +0100
Message-Id: <D8KYF2DZOBT4.1337YU51E0ZKH@bootlin.com>
Subject: Re: [PATCH v5 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>, "Lee Jones" <lee@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-6-fb20baf97da0@bootlin.com>
 <D8K23TCWC5TO.3T1YPKL3G0OY5@kernel.org>
In-Reply-To: <D8K23TCWC5TO.3T1YPKL3G0OY5@kernel.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmegrieeimeefudektdemtgdtsggvmegslegrkeemvgehledvmeeirgeffhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemrgeiieemfedukedtmegttdgsvgemsgelrgekmegvheelvdemiegrfehfpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepr
 hhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Mar 19, 2025 at 8:15 AM CET, Michael Walle wrote:
> Hi,
>
> > GPIO controller often have support for IRQ: allow to easily allocate
> > both gpio-regmap and regmap-irq in one operation.
> >
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> > ---
> >  drivers/gpio/gpio-regmap.c  | 23 +++++++++++++++++++++--
> >  include/linux/gpio/regmap.h | 15 +++++++++++++++
> >  2 files changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> > index 05f8781b5204..61d5f48b445d 100644
> > --- a/drivers/gpio/gpio-regmap.c
> > +++ b/drivers/gpio/gpio-regmap.c
> > @@ -203,6 +203,7 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
> >   */
> >  struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_conf=
ig *config)
> >  {
> > +	struct irq_domain *irq_domain;
> >  	struct gpio_regmap *gpio;
> >  	struct gpio_chip *chip;
> >  	int ret;
> > @@ -280,8 +281,26 @@ struct gpio_regmap *gpio_regmap_register(const str=
uct gpio_regmap_config *config
> >  	if (ret < 0)
> >  		goto err_free_gpio;
> > =20
> > -	if (config->irq_domain) {
> > -		ret =3D gpiochip_irqchip_add_domain(chip, config->irq_domain);
> > +	irq_domain =3D config->irq_domain;
> > +#ifdef CONFIG_GPIOLIB_IRQCHIP
>
> Why do we need this ifdef?
>

Hum yes, on second thought we probably need to depend on
CONFIG_REGMAP_IRQ here.

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
> I'm not a fan of misusing the config to return any data. Can we have
> a normal gpio_regmap_get_...()? Usually, the config is on the stack
> of the caller, what if you need to get irq_chip_data afterwards?
> Then your caller has to save it somewhere.
>

Yes, makes sense. As suggested by Andy Shevchenko, I will remove this
parameter as there is no user today: a way to retrieve it can be added
later if needed.

> Also, what is the advantage of this? Your caller doesn't have to
> call devm_regmap_add_irq_chip_fwnode(), but on the flip side you
> have to cram all its parameters in the gpio_regmap config. I'd like
> to keep that small and simple (but still extensible!). IMHO just
> setting the irq_domain is enough to achieve that.

This was a request from Andy on my previous series.

>
> -michael
>

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


