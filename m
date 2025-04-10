Return-Path: <linux-pwm+bounces-5438-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9BBA83D23
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 10:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23763A61A0
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A2C20AF84;
	Thu, 10 Apr 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VCK3utvl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB243AB7;
	Thu, 10 Apr 2025 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274253; cv=none; b=k30X7/q8RjU1r5KboCzDKNU1QMGZfKiv8C0DJ9sax/K5lJPfZSanEezDrGkSBlK1/4sZUcyBLBMrjuyiUhhGAdk9urMZCtzXTFZIIjgMv0OEeQAAeD87ky2N4CMowb1Z7MIAOtcuJedx/dzknNdfo45ipS5fiEJAxlaYJkFpy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274253; c=relaxed/simple;
	bh=Y7XTCca+Ph4nBDuMHEhEUQiVE0QAjFs5rJ9LGz+9ujc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=MMn+gDcl9H71p44FLai5hFsHFptgYqY5C3HwoUsmggspudPEbUpxmOxfvZOAU4lY0dBlvCVHVrdckEQIix4MZmU+uOR6VlWf9CD7w79ySirj3A2+FtOERGvnyEuvNV5YhiEcrksjVNj/poxgOsIFfNR6PUHFWcooYGvrbEG1Zro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VCK3utvl; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03A5943291;
	Thu, 10 Apr 2025 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744274248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9BN7vcK50A+/Pthg8cvvrb8KO1u3e1IMqjO+eqc8PU=;
	b=VCK3utvlpNaG8Nj54Qfx1SeidjGbSasYRCW2akCLiGnOh8qAjgfYQ264I85//qvfGjLI/8
	RfNGXTQURWYWA2fTVOuzoFjvY0brFLsa7WPPg4K5XcXkI965yZgol0iRb9d+zCdvWpRyaj
	NkCJetYOOrAf4q9LIwKHmMjI6PO3KTqApsypbj+s/xn29GefSU2esaEpWJ7qUs5z26YXV0
	TXxT/zyRLn2z3fwGDcj7f4CAiPR/fVIAYADNeM4B9etZDx5zcw4EKlck9LxyXvfChi+Ovt
	Wz3Xx9CO5LCo9gHBRrXveivzkWs0U6SeczUWxvU1yCa/xNmTJbb+/vQxjSZmVw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Apr 2025 10:37:27 +0200
Message-Id: <D92TM7350HVV.19ONAJBTPEAU6@bootlin.com>
Subject: Re: [PATCH v6 03/12] pinctrl: Add MAX7360 pinctrl driver
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
 <20250409-mdb-max7360-support-v6-3-7a2535876e39@bootlin.com>
 <D9276VFZ6GYJ.EO9D1V7C4JSI@bootlin.com>
 <Z_ahLqrMASFXbG5Q@smile.fi.intel.com>
In-Reply-To: <Z_ahLqrMASFXbG5Q@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhefhhfelhfekjeeugedtudelueetffejfffhkeeivedvveelgfetfeelveetvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhop
 ehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Apr 9, 2025 at 6:32 PM CEST, Andy Shevchenko wrote:
> On Wed, Apr 09, 2025 at 05:03:02PM +0200, Mathieu Dubois-Briand wrote:
>> On Wed Apr 9, 2025 at 4:55 PM CEST, Mathieu Dubois-Briand wrote:
>> > Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
>> > can be used either for GPIO, PWM or rotary encoder functionalities.
>
> ...
>
> The all the rest of the driver LGTM, but the below.
>
>> > +	device_set_of_node_from_dev(dev, dev->parent);
>>=20
>> Ok, so this goes a bit against what I said I was going to do on my
>> previous series, let me explain why. Same reasoning applies for both
>> uses, in PWM and pinctrl drivers.
>>=20
>> With my previous experiments, I came to the conclusion that:
>> - Either we should use device_set_of_node_from_dev() as I do here.
>> - Or we should add more subnodes in the device tree binding.
>
>> - Also, copying the fwnode with device_set_node() was not possible, as
>>   the kernel would then try to apply pinctrl on both the parent and
>>   child device.
>
> Hmm... I need to refresh my memory with the old discussions. Can you poin=
t out
> to the problem statement with that approach?
>

I mentioned here briefly in my previous series: https://lore.kernel.org/lkm=
l/D8R4B2PKIWSU.2LWTN50YP7SMX@bootlin.com/

So the issue is, if I copy the parent fwnode using device_set_node(),
the kernel is trying to apply any pinctrl defined on the node with
pinctrl- properties on both the parent and the child node. Of course,
only the first one will succeed, as two devices cannot request the same
pins at the same time.

>> I previously said the second solution was probably the way to go, but I
>> changed my mind for two reasons.
>>=20
>> First having more subnodes in the device tree was already rejected in
>> the past in the reviews of the dt-bindings patch. This do makes sense as
>> it would be describing device internals (which should not be made in
>> DT), just to ease one specific software implementation (which should
>> also be avoided). So I believe this change would again be rejected.
>> https://lore.kernel.org/lkml/58c80c2a-2532-4bc5-9c9f-52480b3af52a@kernel=
.org/
>>=20
>> But the the second reason is, doing
>> 'git grep "device_set_of_node_from_dev.*parent"', I found several
>> drivers using device_set_of_node_from_dev() for a similar need. Some of
>> these uses are also for MFD child devices:
>> - gpio-adp5585.c / pwm-adp5585.c,
>> - pwm-ntxec.c,
>> - max77620-regulator.c / max77620_thermal.c.
>>=20
>> So, based on this, I believe using device_set_of_node_from_dev() in
>> these two drivers is the way to go.
>
> The problem with this solution is that, It's OF-centric. Which shouldn't =
be
> done in a new code (and I don't see impediments to avoid it). Yes, it doe=
s
> the right thing for the case, but only on OF systems. Note, fwnode is a l=
ist
> of maximum of two entries (yeah, designed like that right now), can you u=
tilise
> that somehow?

Looking at MFD code, I believe ACPI MFD child devices already get the
parent fwnode, except if a fwnode exists for them.

https://elixir.bootlin.com/linux/v6.13.7/source/drivers/mfd/mfd-core.c#L90

Thanks for your review.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


