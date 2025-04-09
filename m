Return-Path: <linux-pwm+bounces-5414-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C7A829B5
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0EF189BE32
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7126A1A3;
	Wed,  9 Apr 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ix2TEgoL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59636268FD9;
	Wed,  9 Apr 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210988; cv=none; b=hjCCN1EwMr3KF2d/uTUBfAnKoOQZKOP8G2lCI1no53J3yr3S8czl3QZizU7po8Uva+DpfyjVoxo0+CjGXVO4sYXMZKRGw3GhUa3d1vg5qBSmt+EryEviPaPRRxgLpbn7DiZ1lx/F6/0uxiC1VUSK8QezgsW6TM/0j6UC2Z1bsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210988; c=relaxed/simple;
	bh=WHJ4LovyJrxl5EK3BIit//giAHu49PuHqs/AksiK6AU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=PaZ9OIk/IQNBsS2w0CCQCNo6jiLF07EGc775BOP6rcf3gLCj/E1z1ETGvH4d86ES1EycbA1lnsr503SyQi10iZI50FO/2dMxKqQhFKpr78aCO5jb4cbMu4HFbFnT5Z9GKabfvQksMqAWmmgX8AlLKTmld2vtJGARLWchx7aiJXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ix2TEgoL; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98D5C4430B;
	Wed,  9 Apr 2025 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744210983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9gM/l5OKvGr50qvVz6x+1aTIoh5bB8RYs0HNFuGAgs=;
	b=ix2TEgoLM4yAjkBg057KQCjyr6sDxDDEphw3JZl5nxAXZLJh8KV274BimmVwiDYmjYz1ea
	a6pK8iEBJ+8+wIB/SJRbRj/VlmQoihWNGZ2yo77B1UMqlEBliGqLilbg4bvWFnix8bJ2F3
	FSFzJxQzi4bCnwfIXA3EfDU/Dxi5sg2PU89BiEg3BqWUAdFIWLLagC/gXMibxLQGOTh9DQ
	8ekjQohgNWBlS+303yNnHpiBd+vNyQp51sFshsLhgRBHgQ7t184zBDXmoyjUOzDPw9TS5u
	OvVnKU/bBHObZFe04/l2WAdIZ2FhW9IX//U41+3IgC7zeb3eMzMrPgJYke1ANw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Apr 2025 17:03:02 +0200
Message-Id: <D9276VFZ6GYJ.EO9D1V7C4JSI@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 03/12] pinctrl: Add MAX7360 pinctrl driver
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-3-7a2535876e39@bootlin.com>
In-Reply-To: <20250409-mdb-max7360-support-v6-3-7a2535876e39@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeifeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkhffvufevofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtffeuleettdefiefffedthfetkeegvdeujeettdejffekvdfgueefjefgteetveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Apr 9, 2025 at 4:55 PM CEST, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
> can be used either for GPIO, PWM or rotary encoder functionalities.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ...
> diff --git a/drivers/pinctrl/pinctrl-max7360.c b/drivers/pinctrl/pinctrl-=
max7360.c
> ...
> +static int max7360_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	struct pinctrl_desc *pd;
> +	struct max7360_pinctrl *chip;
> +	struct device *dev =3D &pdev->dev;
> +
> +	regmap =3D dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");
> +
> +	chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	pd =3D &chip->pinctrl_desc;
> +
> +	pd->pctlops =3D &max7360_pinctrl_ops;
> +	pd->pmxops =3D &max7360_pmxops;
> +	pd->name =3D dev_name(dev);
> +	pd->pins =3D max7360_pins;
> +	pd->npins =3D MAX7360_MAX_GPIO;
> +	pd->owner =3D THIS_MODULE;
> +
> +	device_set_of_node_from_dev(dev, dev->parent);

Ok, so this goes a bit against what I said I was going to do on my
previous series, let me explain why. Same reasoning applies for both
uses, in PWM and pinctrl drivers.

With my previous experiments, I came to the conclusion that:
- Either we should use device_set_of_node_from_dev() as I do here.
- Or we should add more subnodes in the device tree binding.
- Also, copying the fwnode with device_set_node() was not possible, as
  the kernel would then try to apply pinctrl on both the parent and
  child device.

I previously said the second solution was probably the way to go, but I
changed my mind for two reasons.

First having more subnodes in the device tree was already rejected in
the past in the reviews of the dt-bindings patch. This do makes sense as
it would be describing device internals (which should not be made in
DT), just to ease one specific software implementation (which should
also be avoided). So I believe this change would again be rejected.
https://lore.kernel.org/lkml/58c80c2a-2532-4bc5-9c9f-52480b3af52a@kernel.or=
g/

But the the second reason is, doing
'git grep "device_set_of_node_from_dev.*parent"', I found several
drivers using device_set_of_node_from_dev() for a similar need. Some of
these uses are also for MFD child devices:
- gpio-adp5585.c / pwm-adp5585.c,
- pwm-ntxec.c,
- max77620-regulator.c / max77620_thermal.c.

So, based on this, I believe using device_set_of_node_from_dev() in
these two drivers is the way to go.

> +	chip->pctldev =3D devm_pinctrl_register(dev, pd, chip);
> +	if (IS_ERR(chip->pctldev))
> +		return dev_err_probe(dev, PTR_ERR(chip->pctldev), "can't register cont=
roller\n");
> +
> +	return 0;
> +}
> +




--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


