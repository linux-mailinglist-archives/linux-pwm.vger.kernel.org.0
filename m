Return-Path: <linux-pwm+bounces-5275-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26916A70426
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 15:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F513AE20A
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Mar 2025 14:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43ED25A352;
	Tue, 25 Mar 2025 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JaaoyTvB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86838258CF5;
	Tue, 25 Mar 2025 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913990; cv=none; b=DPAwStwOniu6N+v9c9dvsII2oEkucBnPJcLBbBSRxUMlyn5j1uy61TUEBHB3CZdybQmQKtpB7l+ysS+own1SR6t8HJFLLddwGdOdzb4QJ2YSDW+wqnyE3+sfQhpHe2X77VC4D5zdnFv5UqYKo0Jnc+Zn5q3zD+gbnjXOvfHspQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913990; c=relaxed/simple;
	bh=Wmu1jzHMguKR/j6+GdBi+IvxyFpZLNBWJYNpcPE9oZ4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=CBVctDP7M59IkNhEXZk/nPwSHBd117XodGb/e0a5LHhi9qTIPu6YrN0HlwErSp7AMI03xqzWi+p5z80qHDdos4+jvsDCHvAGLIPuj7odHHBOlpHvrZQ5IE6/oZAgTZIMGI///3HtdTPH1qaE/xWxqUBUqkAcl86a2/r8iiZCfvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JaaoyTvB; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9666742D46;
	Tue, 25 Mar 2025 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742913981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWoSyhuzGUD2BKO/up57XBRng0PtovCBvjlBXl3Nn3g=;
	b=JaaoyTvB3kRgI6AtDrGYSPzTm1Ztlp0v8sV+BSQNNPpZQAJ37uEMl+aq46HAVLPaZJp/GP
	amHzGxsfLaUbP2NQUuWFgxeFrk2FMZhWqUfCz1XuvtrbeZBXER7IjgNSvkbAVzuVGjYXta
	odLAZPKSmYmctJMbSfcCEQGuo+Brfe9VT0AYrhpcVCVoztOSIRgdPWrn4tUwwSQOYAHr8C
	9IgIeCjtz2NsvJoGjt5nEF8oBfIUBJvm8kigOSthauCf1fgB9fUErtwZZBKd/35RXYIl2K
	0gHnGak3WlVjQ70ed27JuL+IT4RnChAt5an7f2AbzYUoYXFCdG2k7GUHH5kB9w==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Mar 2025 15:46:20 +0100
Message-Id: <D8PFFWYR3ASD.YEZIXPNVZS4I@bootlin.com>
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
Subject: Re: [PATCH v5 08/11] gpio: max7360: Add MAX7360 gpio support
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-8-fb20baf97da0@bootlin.com>
 <Z9qviF1VeSYNvcPJ@smile.fi.intel.com>
In-Reply-To: <Z9qviF1VeSYNvcPJ@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeftedvgfegteehjeejtdefgffhteevvddtvdejleeghfefuefgledtteduvdetkeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopegsrhhglhessghguggvvhdrphhl
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Wed Mar 19, 2025 at 12:50 PM CET, Andy Shevchenko wrote:
> On Tue, Mar 18, 2025 at 05:26:24PM +0100, Mathieu Dubois-Briand wrote:
> > Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> >=20
> > Two sets of GPIOs are provided by the device:
> > - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities=
.
> >   These GPIOs also provide interrupts on input changes.
> > - Up to 6 GPOs, on unused keypad columns pins.
>
> ...
>
> > +		/*
> > +		 * Port GPIOs with interrupt-controller property: add IRQ
> > +		 * controller.
> > +		 */
> > +		gpio_config.regmap_irq_flags =3D IRQF_TRIGGER_LOW | IRQF_ONESHOT | I=
RQF_SHARED;
>
> But why is this being overridden? The DT or another firmware description =
has to
> provide the correct settings, no?
>

Ok, thinking about it, yes, IRQF_TRIGGER_LOW shoud come from firmware
description. But IRQF_ONESHOT and IRQF_SHARED should still come from
here, no?


I'm OK with all other points.

Thanks for your review!
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


