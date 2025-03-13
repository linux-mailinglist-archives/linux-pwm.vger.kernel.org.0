Return-Path: <linux-pwm+bounces-5174-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0CA5FC4E
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 17:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CFC162B3C
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6721F268FED;
	Thu, 13 Mar 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gB5+ydLY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBDC944F;
	Thu, 13 Mar 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884187; cv=none; b=C73V521vapuoNtusHkl1OrtGkuyIGqIEwnCsxz/hqeBujZn6STHkP1WSEszm/rqnbgfUGQdj08zE+vl1t3UVE/yKVxfJrbrh70p2HK1VZJkhCbv7Nv8o4Y8LqlJpO/jAqko/kmoO6zkLW1Q5PkKrVCmZzaQ4vD2RqPgTdzPZ66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884187; c=relaxed/simple;
	bh=nE5EpPB4If8RqZq+HFcWNMkObw2tBdQFgI8fiUTDjP4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=ZhEBVqOFwN0ZOEX3ZXEudYPOiTPwHgBzeWlrdHQ1t2tzZiUbKd1BYPb3QgsStcXttxQ0BosbnBqXFUdLCh8d/QtOCESWtdnKLkihzcua6OIpxqxT5bCQThkmYo+RrOU0eOsscybIyOylyCC+jz2QgyKr3lru5TqdJG2WY+favWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gB5+ydLY; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E64B2442CE;
	Thu, 13 Mar 2025 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741884182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMMCggDw9vDK2Yxc6oEQTEtAehkSZ19aO0voX4jpN6E=;
	b=gB5+ydLYSuiVzCjCgsFLD1v5Xg6uPAl9hgRIkOQ62erSYfMfiN8CxjC/KEIp7uMIb3FgiW
	CkGGDvjg1H8uDThSdWsan1bxhecSegifJ/ZMy3q0RqOM3UKZ+vCOuiRLhlW9BrhNvaNzHU
	98ZmovIgKi0dfziYVoixlN3vCydQDuRXH+XRTMEmdAkTPVqrO48lL1dFBb9o7KNscuRQma
	PuDBH+wTgnFfnwSCSg4cEoHci33rnawP30QclnihHIffpvp+FbmbTZ+BGcjieQUiwlN4vb
	VWav564x6se7tOYtg2OPwbPYx9QH/UuQR1u97o8geAjybwSQiOXEEVHmcUzR+Q==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 17:43:00 +0100
Message-Id: <D8FAEPI26C8F.397VN87KK9VIO@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
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
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
 <Z69oa8_LKFxUacbj@smile.fi.intel.com>
 <D7UOIHL2WOZP.LLGRKMILNJFU@bootlin.com>
 <Z7OXQqyPjtGgTySf@smile.fi.intel.com>
In-Reply-To: <Z7OXQqyPjtGgTySf@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekgeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvffuvefhofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeihfetgfdtudelteeuvdetjeeihfegledtgffgtdeivdduhedvveekjeegkeelteenucffohhmrghinheprghnrghlohhgrdgtohhmpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhop
 ehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Mon Feb 17, 2025 at 9:08 PM CET, Andy Shevchenko wrote:
> On Mon, Feb 17, 2025 at 12:20:13PM +0100, Mathieu Dubois-Briand wrote:
> > To provide a bit more details, there is basically two set of pins usabl=
e
> > as GPIOs.
> >=20
> > On one side we have what I refer to as GPIOs:
> >   - PORT0 to PORT7 pins of the chip.
> >   - Shared with PWM and rotary encoder functionalities. Functionality
> >     selection can be made independently for each pin. We have to ensure
> >     the same pin is not used by two drivers at the same time. E.g. we
> >     cannot have at the same time GPIO4 and PWM4.
> >   - Supports input and interrupts.
> >   - Outputs may be configured as constant current.
> >   - 8 GPIOS supported, so ngpios is fixed to MAX7360_MAX_GPIO.
> >   - maxim,max7360-gpio compatible, gpio_function =3D=3D MAX7360_GPIO_PO=
RT.
> >=20
> > On the other side, we have what I refer to as GPOs:
> >   - COL2 to COL7 pins of the chip.
> >   - Shared with the keypad functionality. Selections is made by
> >     partitioning the pins: first pins for keypad columns, last pins for
> >     GPOs. Partition is described by the ngpios property.
> >   - Only support outputs.
> >   - maxim,max7360-gpo compatible, gpio_function =3D=3D MAX7360_GPIO_COL=
.
> >=20
> > > Or you mean that there output only GPIO lines in HW after all?
> > > Is there a link to the datasheet?
> >=20
> > A datasheet is available on https://www.analog.com/en/products/max7360.=
html
>
> Thank you for this good elaboration!
> I will check on the datasheet later on, having one week off.
>

Thanks for your feedback! Sorry I haven't been able to work on this
series for the last few weeks, but I finally had the opportunity to
integrate your comments.

> But what I have read above sounds to me like the following:
>
> 1) the PORT0-PORT7 should be just a regular pin control with the respecti=
ve
> function being provided (see pinctrl-cy8c95x0.c as an example);
>

Ok, so I created a pin control driver for the PORT pins. This will
effectively help to prevent concurrent use of pins in place of the
request()/free() callbacks.

My only concern is: as there is no real pin muxing on the chip, my
.set_mux callabck in pinmux_ops structure is not doing anything. It
looks like I'm not the only one
(drivers/pinctrl/pinctrl-microchip-sgpio.c does the same thing), but I
hope this is OK.

> 2) the COL2 COL7 case can be modeled as a simplest GPIO (GPO) driver with
> reserved lines property (this will set valid mask and let GPIOLIB to refu=
se any
> use of the keypad connected pins.
>

I mostly went that way, just a few notes.

I chose to not use the reserved lines property in the device tree, but
instead implemented a gpiolib init_valid_mask() callback. In believe
this is better, as:
- We can automatically generate the valid gpios mask, based on the
  number of columns used.
- It allows to get rid of the compatibility check between the number of
  columns and the number of GPIOs provided by the device tree: DT
  provides the number of columns, we deduct the number of GPIOs.

I chose to number GPIOs from 0 to 7.
- This might be a bit questionable, as GPIO 0 and 1 will always be
  invalid: pins 0 and 1 of the chip cannot be used as GPIOs. I'm
  definitely open to discussion on this point.
- Yet I believe it simplifies everything for the user: pin numbers and
  GPIO numbers are the same instead of having an offset of 2.
- It also simplifies a bit the GPIO driver code.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


