Return-Path: <linux-pwm+bounces-5289-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB58DA71954
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 15:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D143817C493
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8011F30D1;
	Wed, 26 Mar 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CKi9cPvQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D51DF74B;
	Wed, 26 Mar 2025 14:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000274; cv=none; b=jDsGQSJB+kU8nzCewMgrKsInlLVqUxpq7GUYovww2Ejj8eN2BxCcIZ87VLoZ/ZjZa0CxRqs4H0ud3PQE5JbsbIMj4unWA/9U3BdpUw4doFIzP48Ev3Vxw5/UbuV6Z54I2HUAIRuiY18GC/6CqxoASaLX2IZOAr6+H4yukP3zDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000274; c=relaxed/simple;
	bh=MRFbHFYyoyMaTfUFcp1d9FWNu6nUYKgM6cyNPev6wac=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=jl8/YPOKpdNzJyl51AK80IYAi4eAr2Mi9Kp11aQxdM/z7YPEoiwYaM+c4eyFDDSMoUkT4TP8SCF3Yd4eOsV6a6Cs7rzE0FjfcUyGkAC89o5JUuMscBOQTnby+C/ENaYfxZjaSZCHdCDqafDbgc3spLr97kt+6TsKBeV8AWNLMwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CKi9cPvQ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB964441AD;
	Wed, 26 Mar 2025 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743000269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0lbkNHAn2CaamDzuCJgBrXafC1b0VIzMu7nshNJuMY=;
	b=CKi9cPvQk6lyHYxyEVClQbnylCgh5fl8DfDVmLtPRv3GqxMfN8pQdPyEg8N7L7CCHlsgV6
	bikMtmCOeeqX171M/0wWMabEMOuUId8HmJUexDwrQfdryTgAF8HogfEnVY7zdg6A1/p7v5
	eeMgocO6zOYbvF9flBDbokxB85kcYR09ujdCipaUv8F+nHvUWyMU1ixFj3c5QWVwBiGFsz
	jaBTYyGjk2TsczvRZVMiyw/nJ0TpJMps2zY9kuwSUPuFVhg5R3Fl2HEtwZ6rLkwlhcdAyY
	RjcdrCDkKVEWNOGpv1CuBW3f+lNmtxJqyufpSQWyDqLrAPq6gf/aeODRpPD7Ig==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Mar 2025 15:44:28 +0100
Message-Id: <D8QA116WPNUE.11VKIHSG9N0OZ@bootlin.com>
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
In-Reply-To: <Z-LSHoYA1enEOeHC@smile.fi.intel.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfekieeftefhjeetveefudehuddvvdeuvddvudfgfffhveekffethfeuffdtudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmegrieeimeefudektdemtgdtsggvmegslegrkeemvgehledvmeeirgeffhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemrgeiieemfedukedtmegttdgsvgemsgelrgekmegvheelvdemiegrfehfpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhmpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Tue Mar 25, 2025 at 4:56 PM CET, Andy Shevchenko wrote:
> On Tue, Mar 25, 2025 at 03:37:29PM +0100, Mathieu Dubois-Briand wrote:
> > On Thu Mar 20, 2025 at 11:48 AM CET, Andy Shevchenko wrote:
> > > On Thu, Mar 20, 2025 at 08:50:00AM +0100, Uwe Kleine-K=C3=B6nig wrote=
:
> > > > On Wed, Mar 19, 2025 at 01:18:50PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-briand@b=
ootlin.com wrote:
>
> ...
>
> > > > > > +	chip =3D devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0)=
;
> > > > >=20
> > > > > This is quite worrying. The devm_ to parent makes a lot of assump=
tions that may
> > > > > not be realised. If you really need this, it has to have a very g=
ood comment
> > > > > explaining why and object lifetimes.
> > > >=20
> > > > Pretty sure this is broken. This results for example in the device =
link
> > > > being created on the parent. So if the pwm devices goes away a cons=
umer
> > > > might not notice (at least in the usual way). I guess this was done=
 to
> > > > ensure that #pwm-cells is parsed from the right dt node? If so, tha=
t
> > > > needs a different adaption. That will probably involve calling
> > > > device_set_of_node_from_dev().
> > >
> > > It's an MFD based driver, and MFD core cares about propagating fwnode=
 by
> > > default. I believe it should just work if we drop that '->parent' par=
t.
> >=20
> > Are you sure about that?
>
> Yes and no. If your DT looks like (pseudo code as I don't know
> DTS syntax by heart):
>
> 	device: {
> 		parent-property =3D value;
> 		child0:
> 			...
> 		child1:
> 			...
> 	}
>
> the parent-property value is automatically accessible via fwnode API,
> but I don't know what will happen to the cases when each of the children
> has its own compatible string. This might be your case, but again,
> I'm not an expert in DT.
>

On my side:
- Some MFD child do have a child node in the device tree, with an
  associated compatible value. No problem for these, they do get correct
  of_node/fwnode values pointing on the child device tree node.
- Some MFD child do not have any node in the device tree, and for these,
  they have to use properties from the parent (MFD) device tree node.
  And here we do have some problems.

> > On my side it does not work if I just drop the '->parent', this is why =
I
> > ended whit this (bad) pattern.
>
> > Now it does work if I do call device_set_of_node_from_dev() manually,
>
> AFAICT, this is wrong API to be called in the children. Are you talking a=
bout
> parent code?
>

I believe I cannot do it in the parent code, as I would need to do it
after the call to devm_mfd_add_devices(), and so it might happen after
the probe. I still tried to see how it behaved, and it looks like PWM
core really did not expect to get an of_node assigned to the device
after adding the PWM device.

So either I can do something in MFD core or in sub devices probe(), or I
need to come with a different way to do things.

> > so it's definitely better. But I believe the MFD core is not propagatin=
g
> > OF data, and I did not find where it would do that in the code. Yet it
> > does something like this for ACPI in mfd_acpi_add_device(). Or maybe we
> > do something bad in our MFD driver?
>
> ...or MFD needs something to have... Dunno.

I have something working with a very simple change in mfd-core.c, but
I'm really not confident it won't break anything else. I wish I could
get some insights from an MFD expert.

@@ -210,6 +210,8 @@ static int mfd_add_device(struct device *parent, int id=
,
                if (!pdev->dev.of_node)
                        pr_warn("%s: Failed to locate of_node [id: %d]\n",
                                cell->name, platform_id);
+       } else if (IS_ENABLED(CONFIG_OF) && parent->of_node) {
+               device_set_of_node_from_dev(&pdev->dev, parent);
        }


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


