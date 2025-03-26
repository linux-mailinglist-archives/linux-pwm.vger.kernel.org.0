Return-Path: <linux-pwm+bounces-5286-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC4A7153F
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 12:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B1E188D8D0
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEB1CCEC8;
	Wed, 26 Mar 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TUF5oFvU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA31BEF74;
	Wed, 26 Mar 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986858; cv=none; b=CTEtYU0gyTGGp7Swn5qvJU9NLTnEA0YOciD+hwBCsT4AAhS4yso+OD0sGcrUc52UREHVbkix//S6agpazfR4yGEC6i5uKt9i8v1XSTXtzTFEBUDT8InwiJGyM6ndFj5ijFXVDz/yFoDljreuT3ndpYaV/ZdbUPyeHjEFvb5xiFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986858; c=relaxed/simple;
	bh=GE2f5tN/qrs1osKm348JtdX/kYHC5v1SQLpJiAUSdtI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=XX7KwE4jgege/LKdpWUkoTWMERbPz5m36a8db38IhRs2tYjL8AbGqWOc2K8MWKkoCvbmUuXRQlzZf+bNWAVE7/JZLkESP7KvRBAbW5T1RSWyOeNHypbHPycFnLhO191HQFRfnS5cvPjeVi8ePxGn8cBZeI9B7cEJ5aew57KD0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TUF5oFvU; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1BD5542E76;
	Wed, 26 Mar 2025 11:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742986848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE2f5tN/qrs1osKm348JtdX/kYHC5v1SQLpJiAUSdtI=;
	b=TUF5oFvUP1UgmZ2BOnZCz9Z2G146wpzLM5itfJZLhwMpIglNkeM8OjYInfj+nz0r+iZb3Z
	rl3v7ijxRThgN0RXQGNILrAEjMK+1F50TY/qa6VkiphCTby/owR1JcVZYXBH7vPQmYc7SJ
	dOxEUcPgzYD1E4wbxn5vfaicvCibTchkV27Ph0wTyhn+AXjfc+aKsKyHSGU7Oytr1XL1/y
	IoDTZSARXvoL8mlSmZRvXJqjCpgiWJw/ras4GN3dMeSJ+D1+KgZOnEoRZR67NC5jZps9GX
	8BK0aiiQ9WJ64ZbyRqBJVdg+OGMZ/jcvlgV27rcXDxm/yQD5mxFpYiOrafDEhg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Mar 2025 12:00:46 +0100
Message-Id: <D8Q59RC90U0H.SCFK1LVIKPGN@bootlin.com>
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
 <D8KYF2DZOBT4.1337YU51E0ZKH@bootlin.com>
 <D8P6L65D69PS.1VQKHJJA8TNL4@kernel.org>
In-Reply-To: <D8P6L65D69PS.1VQKHJJA8TNL4@kernel.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmegrieeimeefudektdemtgdtsggvmegslegrkeemvgehledvmeeirgeffhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemrgeiieemfedukedtmegttdgsvgemsgelrgekmegvheelvdemiegrfehfpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepr
 hhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Mar 25, 2025 at 8:50 AM CET, Michael Walle wrote:
> > > > +#ifdef CONFIG_GPIOLIB_IRQCHIP
> > >
> > > Why do we need this ifdef?
> > >
> >
> > Hum yes, on second thought we probably need to depend on
> > CONFIG_REGMAP_IRQ here.
>
> But then, you'd also require the regmap_irq support for chips that
> don't support IRQs at all. devm_regmap_add_irq_fwnode() seems to be
> missing a stub version.
>

Sorry, maybe my previous message was not clear, when I said "depend",
what I meant is having an "#ifdef CONFIG_REGMAP_IRQ" here in place of
"#ifdef CONFIG_GPIOLIB_IRQCHIP"

If CONFIG_REGMAP_IRQ is enabled, drivers/base/regmap/regmap-irq.c is
built, so we do have both devm_regmap_add_irq_chip_fwnode() and
regmap_irq_get_domain(). So this code block should compile and link
correctly.

I did some build tests with and without CONFIG_GPIOLIB_IRQCHIP and I
believe this is fine.

Or am I missing something?


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


