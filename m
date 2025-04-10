Return-Path: <linux-pwm+bounces-5442-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4466A83E0B
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 11:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028129E78FF
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC6421A433;
	Thu, 10 Apr 2025 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dTA9pZNc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ADE20C03F;
	Thu, 10 Apr 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275832; cv=none; b=dMmNUKM0nfB/YTgJoeQ0s3qD129Nkuyzvq3msHFJeyaht7BZA8pFMsaU+1JaCSnbL8Igiq3wy/blPAk7Ybpvz38JD2AVVN99u8++xb3rxdy23ECaQ3lBTAZpibBQdBfudUT3wV2kFVn6WD1czCqGBfLREYe3bV+6ok3aNMaPyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275832; c=relaxed/simple;
	bh=ppKrKnV9+vX8mOGUnGEaL5bFCF0QWlj/y8uSyBVvFy8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=kjsdGRk6Py7brAGmd3wZb+w7pBi1NNjOm5TwuU1S4MpJISQUp/7k0vMvTujiUsIpArIMwtRIJmvBifLV18PCTcHSHse0QzHpK+tN1Yk7fd/TOrtQ02HCQQQ8jiovqbOz3L3V44UgiW5yB4LwNgH8/qq9+9peJK2QrwbYSiwtlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dTA9pZNc; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFC5720452;
	Thu, 10 Apr 2025 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744275827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9W47A03v/jaDinmYX8Ic5nO3KToJ83CC7MwvmAZCXYc=;
	b=dTA9pZNc+QUadR65S4fti1u2xJ3SvwiKAPBbWTB6SVSt07wWimcvPvJs8q7Fm69/089dd0
	FNu+gF4BiMDHyS9SSJ4VZSrCgRuwRk/YBV7jdjpw5w6+jfzhYy1UID0b/EAomZbjN1pwTx
	Mmt3B1Od1d9n5ePkwVdO3u4hztT62JC+oB6Yah3uXtaANP2f/DP7HmlX5hS48tOUyNKksN
	yu6QsX+wAIFB+u+IBZ+gQIat/xWilWheLzMJftn5fwco6lWhH+nigC3ZLP/aJwjoDX7sAU
	Rg/eXgCTs7xOE424fn6fMB48D8Fk4Wd46wpXgu4AHOdR9szuZRE+v2TPxubjBQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 11:03:46 +0200
Message-Id: <D92U6CMH9WWM.3JLM1KLZF4WF8@bootlin.com>
Subject: Re: [PATCH v6 07/12] gpio: regmap: Allow to allocate regmap-irq
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
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-7-7a2535876e39@bootlin.com>
 <Z_aiubEgXLaDpsoq@smile.fi.intel.com>
In-Reply-To: <Z_aiubEgXLaDpsoq@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Apr 9, 2025 at 6:39 PM CEST, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 04:55:54PM +0200, Mathieu Dubois-Briand wrote:
>> GPIO controller often have support for IRQ: allow to easily allocate
>> both gpio-regmap and regmap-irq in one operation.
>
>> =20
>> -		memcpy(d->prev_status_buf, d->status_buf, array_size(d->prev_status_b=
uf));
>> +		memcpy(d->prev_status_buf, d->status_buf,
>> +		       array_size(d->chip->num_regs, sizeof(d->prev_status_buf[0])));
>
> ...
>
>> +#ifdef CONFIG_REGMAP_IRQ
>> +	if (config->regmap_irq_chip) {
>> +		struct regmap_irq_chip_data *irq_chip_data;
>> +
>> +		ret =3D devm_regmap_add_irq_chip_fwnode(config->parent, dev_fwnode(co=
nfig->parent),
>> +						      config->regmap, config->regmap_irq_irqno,
>> +						      config->regmap_irq_flags, 0,
>> +						      config->regmap_irq_chip, &irq_chip_data);
>> +		if (ret)
>> +			goto err_free_gpio;
>> +
>> +		irq_domain =3D regmap_irq_get_domain(irq_chip_data);
>> +	} else
>> +#endif
>> +	irq_domain =3D config->irq_domain;
>
>> +
>
> This is blank line is not needed, but I not mind either way.
>

I can remove it, but as the line above is potentially part of the
"else", I have a small preference for keeping it.

>> +	if (irq_domain) {
>> +		ret =3D gpiochip_irqchip_add_domain(chip, irq_domain);
>>  		if (ret)
>>  			goto err_remove_gpiochip;
>>  	}
>
> ...
>
>> + * @regmap_irq_chip:	(Optional) Pointer on an regmap_irq_chip structure=
. If
>> + *			set, a regmap-irq device will be created and the IRQ
>> + *			domain will be set accordingly.
>
>> + * @regmap_irq_chip_data: (Optional) Pointer on an regmap_irq_chip_data
>> + *                      structure pointer. If set, it will be populated=
 with a
>> + *                      pointer on allocated regmap_irq data.
>
> Leftover?

Yes, sorry...

>
>> + * @regmap_irq_irqno	(Optional) The IRQ the device uses to signal inter=
rupts.
>> + * @regmap_irq_flags	(Optional) The IRQF_ flags to use for the interrup=
t.
>
> ...
>
>> +#ifdef CONFIG_REGMAP_IRQ
>> +	struct regmap_irq_chip *regmap_irq_chip;
>> +	int regmap_irq_irqno;
>
> Perhaps call it line?
>
> 	int regmap_irq_line;
>

Makes sense, thanks.

>> +	unsigned long regmap_irq_flags;
>> +#endif

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


