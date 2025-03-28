Return-Path: <linux-pwm+bounces-5298-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F91A74527
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 09:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653ED3B20AE
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Mar 2025 08:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72D7212FA5;
	Fri, 28 Mar 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TGw4g1GH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2B212B2D;
	Fri, 28 Mar 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743149604; cv=none; b=AlGUes2mST9cEWFW3/ZFM/3Ha6qOyZeYlDAYjjM/LoN0GNq+Uz0ewA9RJvaatVWnbcuPPdqrvNmzVDL52PtYmF9XA++YXEJNsK9gfusCZauf6+rxd86v/2xZW3AHM+iG+V2hwVA4aBEnI1Kha2ihD0FH/FvPCKfevD5eXjNP30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743149604; c=relaxed/simple;
	bh=RyvNWz0sMdrFpEUWP+y0PIBVy1EY5vpDKot95FF/a9w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=P01u7GMPuU1lyZwu7SzFvjiTZoPXWwZh+ewdOFOfeguR0OQ4h43/avOcmqos0fc9N9g9uGDforegpIfDyQ9t6bCwbWkAAivsm+YztUOgmaWz371NqLD0dHP/BDz3Yy7qCcMRcxzAIGABYDW2f57gcgZatouF9VBVicWi+QUwRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TGw4g1GH; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C7D1442A4;
	Fri, 28 Mar 2025 08:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743149594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1l7rwlWipHxE1nh0I+e9gf68ZY10wQc1Xc25v8rX8k=;
	b=TGw4g1GHdma+JykKfwDiay4yYSZJ4teJAeb8kc784F4azipDQAmMitNJINtnz6XDoF2NEu
	Hz+p8bpj+hSPLBOJ+lJVskJXArLoYU2WNQhHJJd0w1n381T/pLSR0ZWJki01G0+jZvwECa
	Awt6H9sArSI1aCDApuTHDP623C6Ek2I4p4/BO0uH8GyDvhSyjh9h6C31VVfzF6Fu4UDC4Z
	5oGCRzZgacYonyyplvOS3wPzOlwDxL+4HfrDwVLoosWsJF+/tb1JrKPa7EmSC9gtJ1wmut
	MnhuCczQqU1+3Vn+vRG2fCua3bB/eBzIyFgbyrc931QyWBMdq7/cUxsNEVujEg==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Mar 2025 09:13:12 +0100
Message-Id: <D8RQYJXP0KMK.3L8A8YVZKID89@bootlin.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Lee Jones"
 <lee@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Kamel Bouhara"
 <kamel.bouhara@bootlin.com>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Michael Walle" <mwalle@kernel.org>, "Mark
 Brown" <broonie@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
 <Z9vydaUguJiVaHtU@smile.fi.intel.com>
 <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
 <Z-LSHoYA1enEOeHC@smile.fi.intel.com>
 <D8QA116WPNUE.11VKIHSG9N0OZ@bootlin.com>
 <Z-Qh8yBMaCMhv_Ny@smile.fi.intel.com>
 <D8R4B2PKIWSU.2LWTN50YP7SMX@bootlin.com>
 <Z-WQAC8Fc90C1Ax6@smile.fi.intel.com>
In-Reply-To: <Z-WQAC8Fc90C1Ax6@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhklhgvihhnvghksehkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Thu Mar 27, 2025 at 6:50 PM CET, Andy Shevchenko wrote:
> On Thu, Mar 27, 2025 at 03:28:08PM +0100, Mathieu Dubois-Briand wrote:
> > On Wed Mar 26, 2025 at 4:49 PM CET, Andy Shevchenko wrote:
>
> > > The use of this API is inappropriate here AFAICT. It drops the parent=
 refcount
> > > and on the second call to it you will have a warning from refcount li=
brary.
> > >
> > > It should be as simple as device_set_node().
> > >
> > > >         }
> > >
> > > With that, the conditional becomes
> > >
> > > 	} else if (is_of_node(fwnode)) {
> > > 		device_set_node(&pdev->dev, fwnode);
> > > 	}
> > >
> > > where fwnode is something like
> > >
> > > 	struct fwnode_handle *fwnode =3D dev_fwnode(parent);
> >=20
> > I tried to use device_set_node(), but then I got some other issue: as w=
e
> > now have several devices with the same firmware node, they all share th=
e
> > same properties. In particular, if we do use pinctrl- properties to
> > apply some pinmmuxing, all devices will try to apply this pinmuxing and
> > of course all but one will fail.
> >=20
> > And this makes me think again about the whole thing, maybe copying the
> > fwnode or of_node from the parent is not the way to go.
> >=20
> > So today we rely on the parent node for four drivers:
> > - keypad and rotary, just to ease a bit the parsing of some properties,
> >   such as the keymap with matrix_keypad_build_keymap(). I can easily do
> >   it another way.
> > - PWM and pinctrl drivers, are a bit more complicated, as in both case
> >   the device tree node associated with the device is used internally. I=
n
> >   one case to find the correct PWM device for PWM clients listed in the
> >   device tree, in the other case to find the pinctrl device when
> >   applying pinctrl described in the device tree.
> >=20
> > So maybe I have to find a better way for have this association. One way
> > would be to modify the device tree bindings to add a PWM and a pinctrl
> > node, with their own compatible, so they are associated to the
> > corresponding device. But maybe there is a better way to do it.
>
> Okay, so the main question now, why do the device share their properties
> to begin with? It can be done via fwnode graph or similar APIs (in case
> it is _really_ needed).

I wouldn't say the properties are shared: we have a single node in the
device tree as this is just one device. But as we create several
(software) devices in the MFD driver, we now have several devices linked
with a single device tree node.

One solution would be to create more subnodes in the device tree, one
for pinctrl and one for PWM, but this feels a bit like describing our
software implementation in the device tree instead of describing the
hardware.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


