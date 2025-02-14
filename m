Return-Path: <linux-pwm+bounces-4881-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CCBA3592E
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 09:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299923ADB52
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770C227B83;
	Fri, 14 Feb 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I+Swiiek"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C9224885;
	Fri, 14 Feb 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522567; cv=none; b=XBgRWyz6cu4Qa9jFM0Vt67+Gab9eaJnDbyYgq8/v4baItJrWppN42h7mbWe/eYL4J3temVYO86t/fzZMnWtfFBbON5yGQMpwEF2Vq2cOasJgAWV97wfl8CRHVndnFk9s8a4uXsO3yaTEllAmbI92YIDDJ0Vr9GZscpR1jAQEOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522567; c=relaxed/simple;
	bh=YOuWlVlJF2/9JdvrDcQy0Y2zEBg9CBaU/IWtjC5i2MM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=tDCcGCtgAFZPgOHyG8D8oVJadxUtSK/toUDNEw7xvTfkvOsHx44Ve1Fb+2MHWgWupfBSZN12gZHNPUZUOuRQLUVwIIr0uAPn7vUww4Z6Yq9OniUHB/CRm8zOl4puzL1S+IOEAVOayHQ9pZA9+YsATdCYCtBVLTpH3p4JDIPUhs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I+Swiiek; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BF844444F;
	Fri, 14 Feb 2025 08:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739522562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7L/XQV8UaijUO2KR/30CL5wbDGjOf9zE9dTPVuOH4pk=;
	b=I+SwiieknndU+K/HVq7ErnKOzcepu/p2/98NciiCFqVoPuZETfbv/NMifaB06G261pGtlp
	p1is70BhxsZE2101yPaeX8t1TQu4opl+SrfQMnfxWWxt9HhGiPhHcnj8hHPgI+gg+YnU7a
	rGaIB7XJWv8JF8wwnUgOp+737pZ1JC2QuKseQ4EuIcFB8AloxwuH6wRCwJDJMJo5yuuCTw
	G1lVkVr4bSmOMgvGhLWMYuluaPoboYQaJm0vx0PD87rOPCDMtL4kHQ1xpBdbDBkvAKSM67
	0/7+gpt2R6sv2JDCHH7NdmnCxWA4lEOIHQu2nGKcZxFsPQ5TLJ1FA/wffYZQUQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 09:42:40 +0100
Message-Id: <D7S1A8EKR194.1L3ZLGX8V2ZT7@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
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
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com>
 <Z5eFGJspoGOINcG6@smile.fi.intel.com>
 <D7QHGB7D0VSG.X255SDU7DFOF@bootlin.com>
 <Z6y65SnrprvnpKEa@smile.fi.intel.com>
 <D7QLITNTXRUJ.3NA44E6PQMAUX@bootlin.com>
 <Z6zJljphfTuEhBTP@smile.fi.intel.com>
 <D7R9KGN6EMDM.1DCDL4P5RC23B@bootlin.com>
 <D7RD3K56C2CQ.1WGUSI809P246@bootlin.com>
 <Z65MalVYafUvR7LH@smile.fi.intel.com>
In-Reply-To: <Z65MalVYafUvR7LH@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegledvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffvufevhffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptefhieehheehgeehkeeuiefgkeffvdehgeefieevgfekfedthefhtdfhheeujeefnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu Feb 13, 2025 at 8:47 PM CET, Andy Shevchenko wrote:
> On Thu, Feb 13, 2025 at 02:45:31PM +0100, Mathieu Dubois-Briand wrote:
> > On Thu Feb 13, 2025 at 11:59 AM CET, Mathieu Dubois-Briand wrote:
> > > On Wed Feb 12, 2025 at 5:17 PM CET, Andy Shevchenko wrote:
> > > > On Wed, Feb 12, 2025 at 05:08:56PM +0100, Mathieu Dubois-Briand wro=
te:
> > > > > On Wed Feb 12, 2025 at 4:14 PM CET, Andy Shevchenko wrote:
> > > > > > On Wed, Feb 12, 2025 at 01:57:34PM +0100, Mathieu Dubois-Briand=
 wrote:
> > > > > > > On Mon Jan 27, 2025 at 2:07 PM CET, Andy Shevchenko wrote:
> > > > > > > > On Mon, Jan 13, 2025 at 01:42:28PM +0100, Mathieu Dubois-Br=
iand wrote:
>
> ...
>
> > > > > > > > > +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &=
ngpios)) {
> > > > > > > > > +		dev_err(&pdev->dev, "Missing ngpios OF property\n");
> > > > > > > > > +		return -ENODEV;
> > > > > > > > > +	}
> > > > > > > >
> > > > > > > > This is not needed, it is already done in GPIOLIB core.
> > > > > > >=20
> > > > > > > I believe this is still needed:
> > > > > > > - For gpos, we need the gpio count to correctly set the parti=
tion
> > > > > > >   between gpo and keypad columns in max7360_set_gpos_count().
> > > > > >
> > > > > > Shouldn't be that done somewhere in the GPIO valid mask initial=
isation?
> > > > > >
> > > > > > > - For gpios, we need the gpio count to setup the IRQs.
> > > > > >
> > > > > > Doesn't GPIOLIB parse the property before initializing the IRQ =
valid mask
> > > > > > and other init callbacks?
> > > > >=20
> > > > > No, I believe I have to register the IRQ before registering the G=
PIO, so
> > > > > I can get the IRQ domain.
> > > > >=20
> > > > > Right now I have something like:
> > > > >=20
> > > > > irq_chip->num_irqs =3D ngpios;
> > > > > devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev), max7360_gpi=
o->regmap,
> > > > > irq, flags, 0, irq_chip, &irq_chip_data);
> > > > > gpio_config.irq_domain =3D regmap_irq_get_domain(irq_chip_data);
> > > > > devm_gpio_regmap_register(dev, &gpio_config);
> > > > >=20
> > > > > Also, gpiolib will store ngpios in the gpio_chip structure, but w=
hile
> > > > > using gpio-regmap, this structure is masked behind the opaque
> > > > > gpio_regmap structure. So I believe there is no easy way to retri=
eve its
> > > > > value.
>
> Would it be needed in your driver ->probe() after all? (See also below)
>

No necessarily in the probe with the changes previously described, but I
will need it in other functions. So either I get it in the probe and
store it, or I will need to retrieve it by other means.

> > > > > This part of the code changed a lot, maybe it would be easier if =
I push
> > > > > a new version of the series and we continue the discussion there?
> > > >
> > > > So, what seems need to be added is some flag to GPIO regmap configu=
ration
> > > > data structure and a code that is called after gpiochip_add_data() =
in
> > > > gpio_regmap_register() to create a domain. This will solve the abov=
e issue
> > > > and helps other drivers to get rid of potential duplication of
> > > > devm_regmap_add_irq_chip_fwnode() calls.
> > > >
> > > > Have you researched this path?
> > >
> > > OK, so looking at the code, I believe it would need to:
> > > - Add some flag in gpio_regmap_config structure, so
> > >   gpio_regmap_register() creates a new IRQ domain.
>
> Easy.
>
> > > - Add a function allowing to retrieve this domain out of the gpio_reg=
map
> > >   structure.
>
> Easy, as there is an API available for regmaps, so it looks like one-line=
r.
>
> > > - Allow to pass a domain in the regmap_irq_chip structure, so
> > >   regmap_add_irq_chip_fwnode() use this domain instead of calling
> > >   regmap_irq_create_domain().
>
> You need this because of...? (Please, remind me what the obstacle is ther=
e
> that requires this to be done)
>

OK, maybe I misunderstood you idea. Or maybe I misunderstood something
about IRQ domains.

So what I understood is, in the probe, we first call
gpio_regmap_register(), that will create a new IRQ domain, and we call
regmap_add_irq_chip_fwnode() in second. But this second call will again
create an IRQ domain, so we would end-up with a second one. We have to
prevent this second creation and make it use the one we created first.

Did I miss something?

> > > - Make sure this domain is still populated with the IRQ data: number =
of
> > >   IRQs, IRQ base but also a pointer on the regmap_irq_chip_data
> > >   structure in .host_data. I believe this will be a bit tricky.
>
> Hmm... But wouldn't gpio-regmap internals have all this information avail=
able?
>

I don't think so. It will not know the IRQ base nor the
regmap_irq_chip_data as it is not created at this point.

> > > - Add a function allowing to retrieve ngpio out of the
> > >   gpio_regmap.gpio_chip structure, so it can be used for IRQ setup an=
d
> > >   other places of the driver.
>
> I'm not sure where it can be needed.
>

Let's discuss this on the next version, but yes, I do need to know ngpio
in the driver.

> > > I'm sorry, but I feel like this is a lot of changes to solve this poi=
nt.
> > > I've been thinking about it, and I can suggest a different solution.
> > >
> > > For gpios, I will remove the ngpios property of the device tree and u=
se
> > > a fixed value:
> > > - For the today version of the chip, this is always 8.
> > > - I a chip variant or a similar chip ever arise later with a differen=
t
> > >   number of gpios, the fixed value can be set according to the
> > >   "compatible" value.
> > > - This removes any issue with the IRQ setup.
> > >
> > > For gpos, we have to keep ngpios, as it depends of the implementation=
 on
> > > the board. That means ngpios will be used:
> > > - For the gpio chip configuration: we let gpiolib retrieve it from th=
e
> > >   device tree.
> > > - In gpio-regmap reg_mask_xlate callback: I can add a function allowi=
ng
> > >   to retrieve it from gpio_regmap.gpio_chip, as suggested above.
> > > - In max7360_set_gpos_count() to validate the coherency between
> > >   requested gpios and keypad columns and set the correct configuratio=
n
> > >   on the chip:
> > >   - I can also retrieve the value from gpio_regmap.gpio_chip, but tha=
t
> > >     means the check is made after the call to
> > >     devm_gpio_regmap_register().
> > >   - Or I will still need to retrieve it using device_property_read_u3=
2()
> > >     here.
> > >
> > > How do you feel about this solution?
> >=20
> > Actually there is an additional issue: today, relying on gpiolib to
> > parse the "ngpios" property does not work with gpio-regmap.
> >=20
> > The gpiochip_get_ngpios() function in gpiolib is called in
> > gpiochip_add_data_with_key(), but when using gpio_regmap_register(),
> > we first ensure ngpio is set correctly before calling anything.
> >=20
> > Yet I believe this check can safely be removed, allowing the magic in
> > gpiolib happen as expected.
>
> Not really. I'm about to send a series to address this issue.
> Please, test.

I will test it today.

>
> ...
>
> P.S.
> Maybe it's time to send a new version based on this discussion even
> if not finished / working, so we can see the exact issues we still have
> and target them.

Sure, I will send a new version, probably today.

Thanks again for your help.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


