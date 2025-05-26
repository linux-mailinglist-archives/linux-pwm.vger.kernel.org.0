Return-Path: <linux-pwm+bounces-6127-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D6AC3F03
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 14:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1297E3B4240
	for <lists+linux-pwm@lfdr.de>; Mon, 26 May 2025 12:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5F1FBCAF;
	Mon, 26 May 2025 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bM8bhV4z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5ED1BC5C;
	Mon, 26 May 2025 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260998; cv=none; b=ntZ5A7+Z5DuZ+x2xmyofKhmogVoPfKN1FC0pt3yzQDHYXvtTe08cjWYBvQNNlKGgeYZ+XdwHeEdKcXlijcKp6n0ytBWBV14FOLqaJ95M1hSe1Q6r2JZLPoQSVb3KE5B+yqmef9HYPdU0RAR0eiAvbXt9AmHzTQikawxGgh/YeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260998; c=relaxed/simple;
	bh=7RcKKcyw/mz1JEdzFQBQPEG8HmMMGUkhsGa4P9iWHbk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=EHFAw3GkzTX83M3qO368Qp2iNHVHRB9NbDmVGzcKjcRLfra3F7gAc1SzolBBPmmeC7//sfhCsjXdBNcRa+V8HwWdUEN35NiS3F3HQIPmPKue/c7BvQHkuYWYwmNhqeufO4ulnFoSMhy08e4EQrCsF/uMwReirT8wmIaIEjPYDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bM8bhV4z; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1942F43B29;
	Mon, 26 May 2025 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748260994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxMH5k+dYKIilp2PKuzRPktv59J5PhIs3BBDtjszt0o=;
	b=bM8bhV4zj/W2OP6qfF9wkW4EcChAuml0Pbcmn56RpgKhJrhogQK20f443bC4+ZMVr8yigP
	WoilBnTSYNUQIk5pWtir7Jpd5TIOqEfk2j5dutyxhoppi4XzXiCnsKGaNwzaYxzFKsY+jP
	qseUip5kW54H/5G10A3mVWaNgr7tsRgDcvumQjKbQfN2+BQ9aHnKdVXydK+coAvYLNyYf4
	Q9pjo/qe5pIzBsniojLrnxkGpoR3MC8y89GI/K4elRnN5kLWlsW1m8Vanvdh4YyoBmNvfw
	oOA72ORaBD89bYWOZryRc54hcWTsAhNiijZlrn1Drx2ZjuaKgwZVvgGfqLiTtA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 May 2025 14:03:12 +0200
Message-Id: <DA62SSMI7C52.V2QD509S95QW@bootlin.com>
Subject: Re: [PATCH v9 06/11] gpio: regmap: Allow to allocate regmap-irq
 device
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Michael Walle" <mwalle@kernel.org>, "Mark Brown"
 <broonie@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <andriy.shevchenko@intel.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
 <20250522-mdb-max7360-support-v9-6-74fc03517e41@bootlin.com>
 <CAMRc=MeT+b5dBOWyf6-BpTjk70nwVhLOpCY-JHNizBo5H1-AnQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeT+b5dBOWyf6-BpTjk70nwVhLOpCY-JHNizBo5H1-AnQ@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeegjeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkefhkeeifeethfejteevfeduheduvddvuedvvddugfffhfevkefftefhuefftddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemrgeiieemfedukedtmegttdgsvgemsgelrgekmegvheelvdemiegrfehfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmegrieeimeefudektdemtgdtsggvmegslegrkeemvgehledvmeeirgeffhdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu May 22, 2025 at 3:01 PM CEST, Bartosz Golaszewski wrote:
> On Thu, May 22, 2025 at 2:06=E2=80=AFPM Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
>>
>> GPIO controller often have support for IRQ: allow to easily allocate
>> both gpio-regmap and regmap-irq in one operation.
>>
>> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>> ---
>>  drivers/gpio/gpio-regmap.c  | 21 +++++++++++++++++++--
>>  include/linux/gpio/regmap.h | 11 +++++++++++
>>  2 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
>> index 87c4225784cf..9cbbbaf82609 100644
>> --- a/drivers/gpio/gpio-regmap.c
>> +++ b/drivers/gpio/gpio-regmap.c
>> @@ -215,6 +215,7 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
>>   */
>>  struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_confi=
g *config)
>>  {
>> +       struct irq_domain *irq_domain;
>>         struct gpio_regmap *gpio;
>>         struct gpio_chip *chip;
>>         int ret;
>> @@ -295,8 +296,24 @@ struct gpio_regmap *gpio_regmap_register(const stru=
ct gpio_regmap_config *config
>>         if (ret < 0)
>>                 goto err_free_gpio;
>>
>> -       if (config->irq_domain) {
>> -               ret =3D gpiochip_irqchip_add_domain(chip, config->irq_do=
main);
>> +#ifdef CONFIG_REGMAP_IRQ
>> +       if (config->regmap_irq_chip) {
>> +               struct regmap_irq_chip_data *irq_chip_data;
>> +
>> +               ret =3D devm_regmap_add_irq_chip_fwnode(config->parent, =
dev_fwnode(config->parent),
>> +                                                     config->regmap, co=
nfig->regmap_irq_line,
>> +                                                     config->regmap_irq=
_flags, 0,
>> +                                                     config->regmap_irq=
_chip, &irq_chip_data);
>
> I don't think using devres here is a good idea. There's no guarantee
> that gpio_regmap_register() will be called on device attach so you
> must not make the release of the resource depend on an associated
> detach which may never happen. Please use the non-managed variant
> here.

Right, I will make sure to use
regmap_add_irq_chip_fwnode()/regmap_del_irq_chip() here.

I should be able to send a new version in the coming days.

>
> Bart
>

Thanks for your review.
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


