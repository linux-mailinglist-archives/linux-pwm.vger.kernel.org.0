Return-Path: <linux-pwm+bounces-5283-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BB9A706E0
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 17:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3DE189E13C
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD07125DAE6;
	Tue, 25 Mar 2025 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dctl210D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1222254B09;
	Tue, 25 Mar 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919980; cv=none; b=q63e/V+ST+mlQ9LJW7oQ6Abi1YVWEr5vUup16+Neu5pFNZ2Vmj5C3oM41jOpK63WI9hKve9p8MEsVJe/3qDVJWPpV/IEcqZj7ez/ZulF+JRbtD0X8olYbu854ndIp5LJGr9PJIi/bQJFmIVpXVJ4e4g4FJ1EVcvtZ6I1a3JeuFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919980; c=relaxed/simple;
	bh=924u+n0bgOIBMTiTtWUkSIOHz+odrnzAw+tnUn+dn6M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=EiGhx3G8v3C9LUtTwHX3LHM3Smdp3oJJj//mwhIh/hKWYfeRJxF03HfBktBI5CKJOs5GsifH0Hi7A2eTDFgzF6IGda1m8uR5nPB1U8TyeExTOjPqEYDf2zHJpMvgfgePUGwRpfx58apWhK0tm+gbWR9/3dJI+K9gbN/eouV9fEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dctl210D; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B9D44433F;
	Tue, 25 Mar 2025 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742919974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RP2g3c4m72SDfdBZEvu1xhvowzJhly7QJTbUZeDQDo=;
	b=dctl210DyqgmeRPmqeUNeEnRssv4YmnnnCiMEbFSwBFIdj+TsnpmpGWFZmBLyvC3uRPPB7
	HDeYVa3zCuVh9s0IYdN1fArd/WKKN2jNkpV/YBis6TbVSjOYvEXXy+8PdAnR0jW2nXjGAj
	YEFWnPMQC3n6+YHCi3SAfY6i0GMAHfD7MwqUNKBzDxv4cK/m3pn2OrTT/jV5VwFnsoAavq
	l8Q2velsMMpy28KHi3g2J3Wc7UGbO9biaIdCSW0lAYNKXBbzdfthn+mPPy1fbyg58n4APx
	uybWTDONI49eB0nemMrHZVt2jRe47nTvOBvri4ylzINB0JyEPqbAHl/BxEALzQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Mar 2025 17:26:12 +0100
Message-Id: <D8PHKDVTYTQ5.1HT80KX538PRQ@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 02/11] mfd: Add max7360 support
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
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-2-fb20baf97da0@bootlin.com>
 <Z9qmDkwSpZHxwuQj@smile.fi.intel.com>
In-Reply-To: <Z9qmDkwSpZHxwuQj@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvffuvefhofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeethfeiheehheegheekueeigfekffdvheegfeeivefgkeeftdehhfdthfehueejfeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Mar 19, 2025 at 12:10 PM CET, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:26:18PM +0100, mathieu.dubois-briand@bootlin.c=
om wrote:
> > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +	ret =3D max7360_mask_irqs(regmap);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Could not mask interrupts\n");
>
> Hmm... As far as I can read this masks GPIO interrups. Does it do anythin=
g
> else? If it's covered by the GPIO/pin control drivers, one want probably =
to
> see that to be done there in the respective callback (init_hw_irq or alik=
e,
> I don't remember the name by heart).
>

Hum, I'm not sure I can do that.

So the "inti" interrupt line is shared across the GPIO and the rotary
encoder functionalities.

On reset, GPIO interrupts are not masked. This means, if we do the
masking in the GPIO driver and the GPIO driver is not loaded but the
rotary encoder driver is, the rotary encoder driver might get a lot of
spurious interrupts.

So I believe it makes sense to mask the interrupts here, setting the
chip in a sane configuration, whatever child drivers are present.

Any thought about that?

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


