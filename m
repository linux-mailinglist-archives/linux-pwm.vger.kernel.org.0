Return-Path: <linux-pwm+bounces-5175-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A7A5FD08
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74511642A7
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CA5157493;
	Thu, 13 Mar 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f9YXGkic"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B782866;
	Thu, 13 Mar 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885629; cv=none; b=DXE25jQ89o/hgBjqcnoc+1i4r4wBWC1Qzv4PGB7THIGKuTld9oHqFXFTVpTNzpoIS0QIAFu6KBAG/EyaTw/GpsrE+DYmr8g9k8EGc65sXnEcgE0+XQSl2ODygDGSpVYn/77gUwHnATR+ERc907K2AMmUx+jhzDQmZsTykZIvetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885629; c=relaxed/simple;
	bh=vkOsjnIORLiASLqr6cdadJ2D+eTpDu50byGNU1MrW6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=rrhIEet2FVRpHepsVZvefkWbm37T7Cy0JsImdFxKVfWHZmtZwsvlnFzFV/j60aCHxDcExUGgQT2N6gblGci2MUOBjHyqL1lmq4OZFeXXhQLjVbn2viZS1BfKOdXph+2T8a3Y5gmsSv3sIEFCHE4QbWJecRuO1LJUeJHQYww64ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f9YXGkic; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7A27442C0;
	Thu, 13 Mar 2025 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741885624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuP7Qu6XVahPWDXCilj3JK1+JDBx3eCUFtnTEr6FYhE=;
	b=f9YXGkicpzSQULa82kjSTsGvh/az/3b3pJHsqQIqYf90pBx+cwWb+RnOyu6KYHk9EljSNC
	uu0P4ngdnDbwAMJqBKRgbzQq8+PzgzTdzIPYQqLKzT+fFSs0GE7YyLAdGF/kS7/qU7yfXs
	3x70Jn2oJiD5EBzH/YmP7lD7VoUj4ypbtlfjvspLahue1fZgbMNwCXQrzkh7yrdocUbIoV
	YXIBht0AuY2wR/FxJnY9Oy9Ks+JbY4D1JeaitU43GkhUnGE7E6zZ7fKJeltpOhPieASMnp
	NEzIQbkBTo4OrmRk7oea+L+LL3+RqIesneYhrvLfMyMS4UYBtGL6FplbNaD1Kw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 18:07:03 +0100
Message-Id: <D8FAX4E29LZK.3VUK90WB04MV2@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Fri Feb 14, 2025 at 4:59 PM CET, Andy Shevchenko wrote:
> On Fri, Feb 14, 2025 at 12:49:57PM +0100, Mathieu Dubois-Briand wrote:
> > Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
>
> ...
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

I believe this comment has been a bit outdated by our discussion on
using GPIO valid mask, but I believe we could not use the ->set_config()
callback here: this callback is made to configure a single pin while the
gpos/keypad columns repartition is global.

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

Ok, this is a bit more clear to me now. So I came up with something, it
will be part of the next iteration, probably during the next week.

This required to add a few additional fields to the gpio_regmap_config
structure, specifying the IRQ configuration:

+ * @regmap_irq_chip:   (Optional) Pointer on an regmap_irq_chip structure.=
 If
+ *                     set, a regmap-irq device will be created and the IR=
Q
+ *                     domain will be set accordingly.
+ * @regmap_irq_chip_data: (Optional) Pointer on an regmap_irq_chip_data
+ *                      structure pointer. If set, it will be populated wi=
th a
+ *                      pointer on allocated regmap_irq data.
+ * @regmap_irq_irqno   (Optional) The IRQ the device uses to signal interr=
upts.
+ * @regmap_irq_flags   (Optional) The IRQF_ flags to use for the interrupt=
.

>
> ...
>
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

So as I reworked the keypad columns GPIOs, PORT GPIOs and the COL GPIOs
are a bit more similar on this point. So far I now use a constant value
assigned in the driver for both, as I believe there is no way the number
of GPIOs could be a different. Yet I can easily switch back to a value
provided by a device property.

Thanks again for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


