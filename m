Return-Path: <linux-pwm+bounces-5274-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3684BA703E0
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 15:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C17347A5436
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 14:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0342F25A350;
	Tue, 25 Mar 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EKIkRHBn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDD1EE7AD;
	Tue, 25 Mar 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913455; cv=none; b=R+fO8Nxu2HC7GlqjqN/dZ7cHhAEUL4iOwEGIYmy6fozUzGen6m/SMNbVs1icBLkf93QaRLfFYSebYScRG+rLyzEQpa7MRqaCl+xdetwrHXl/9ewiUsXEGTcaux8BMhX1cOe7CTy5d4enhZ4aEUz1JRwfcdj2ehVlvzokjkpTnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913455; c=relaxed/simple;
	bh=xG0/szBJu70OcmWh3jP2ZdEvOWwAmwJE5cR+2i2FUho=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Jnno6hNEuIkpz0LAT+0DekLhzH+MNvkasiEdzBju8PNGiOsSt5oCB0O7Primu4f7UcjMqN2nOVrZFOTSoPHJFLYoh4iQ0Gt1PahtL00qBrvlga6I2z4wYvYGRQ3Pr7schVyzaigCoSGEmyqITtxNm08UoHCK2hP1tqDELz1lHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EKIkRHBn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1492D204D0;
	Tue, 25 Mar 2025 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742913451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7Lwuf+qvv4mXLFIz/xryFk97UaX7ituYqVU5VC582Q=;
	b=EKIkRHBnaD+ebuEP9QkMglemu93QomYfbnyYHq2w7ok+JIR0mZR+xtbQ6mUmS+7E6F7Hy+
	J9HLaysErfvKeD7PbRM2FJJK3J/FIwf9nfiMrW5jAQSTVp3lamJqxSYbblZ2BBinv3Ns9s
	WEo1Jemw16AEw0cQfvjqFTbLA7z221hCH/vjcabpP4BC9woUHy7EaKxt5zz03Ww7rOavJ3
	chzklLDfz3TaeSGnogpWJuL+09KD73zc50SHW69n6rC+dRBJdKD1/85bc+vYT7uyPY8k2k
	Knw5FVm98oubsOb1COUpsDzJQ6YEmSDTbM6y3/0LVOuySu4zlZhxEisOcNfGvg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Mar 2025 15:37:29 +0100
Message-Id: <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
 <Z9vydaUguJiVaHtU@smile.fi.intel.com>
In-Reply-To: <Z9vydaUguJiVaHtU@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhklhgvihhnvghksehkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu Mar 20, 2025 at 11:48 AM CET, Andy Shevchenko wrote:
> On Thu, Mar 20, 2025 at 08:50:00AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Wed, Mar 19, 2025 at 01:18:50PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@bootl=
in.com wrote:
>
> ...
>
> > > > +	chip =3D devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);
> > >=20
> > > This is quite worrying. The devm_ to parent makes a lot of assumption=
s that may
> > > not be realised. If you really need this, it has to have a very good =
comment
> > > explaining why and object lifetimes.
> >=20
> > Pretty sure this is broken. This results for example in the device link
> > being created on the parent. So if the pwm devices goes away a consumer
> > might not notice (at least in the usual way). I guess this was done to
> > ensure that #pwm-cells is parsed from the right dt node? If so, that
> > needs a different adaption. That will probably involve calling
> > device_set_of_node_from_dev().
>
> It's an MFD based driver, and MFD core cares about propagating fwnode by
> default. I believe it should just work if we drop that '->parent' part.

Are you sure about that?

On my side it does not work if I just drop the '->parent', this is why I
ended whit this (bad) pattern.

Now it does work if I do call device_set_of_node_from_dev() manually, so
it's definitely better. But I believe the MFD core is not propagating
OF data, and I did not find where it would do that in the code. Yet it
does something like this for ACPI in mfd_acpi_add_device(). Or maybe we
do something bad in our MFD driver?


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


