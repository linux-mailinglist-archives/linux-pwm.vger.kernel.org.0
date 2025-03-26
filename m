Return-Path: <linux-pwm+bounces-5291-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DABA71DB0
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 18:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D883B1895825
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Mar 2025 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3623FC4B;
	Wed, 26 Mar 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwZBU/wr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2623FC40;
	Wed, 26 Mar 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011205; cv=none; b=sIZ3zQDGss3+l+KqykOAtQF0GH4FZNNmvSwo9o0zvxMZlfJtSknCIHFgeMqRyEbOd9iLxLuO59DXhifDDburwhe2vRk22x6S82yAq9Pis+0B3bhEZo+v+O9T1j8QoB7pMrLFu2qfN0qKucDFhIuPEnBwYD9PXzwsQp27y2L+EY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011205; c=relaxed/simple;
	bh=AvNG/hFb03iHU1hJlpsi28BI0GT1J2rVhqAbx4wAt14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWc5EoclvlOUU6RWWwXPSnxipFyGYwgCG6trOuASJTfMNw6DK2jgmTMAAEUIUy3cIct4HCt8OGzMErqfeUkSlCrdDA7PHV7YY7EYYEnzW/ijRhlLfAt5gWfQ8fJc7fbUjqpyTsi48ZlijfZ4/QuamGD9jUBZWrLHJm4WQlxpzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwZBU/wr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619E8C4CEE2;
	Wed, 26 Mar 2025 17:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011204;
	bh=AvNG/hFb03iHU1hJlpsi28BI0GT1J2rVhqAbx4wAt14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwZBU/wrbL7pwOKX6uczn+NGSMx5r2yBaqpJczJjOvhbjR4Eioe5qxsFjonef8o21
	 47K1BT1mtZkz8YDQ5fFIt8L+H9Ix5WWNzolBtzZbRYj6jMQralisv0f6e3kUHCQa9i
	 rRfZfd1kt+vUYPsCAX5TPhCEisran3ayVI1h74u8bAqamtOWomzkpwhKv6fE0GJIUg
	 UqcBOQY3dH/S2y6rj1gDaSiE6jFZZlLoxZ4auXInK7PF7T9goDzb5FkrWoPn0H3gdm
	 NdXDV9mpbvyVPjUQiJuyQcIV9Bw1UT0kcCx6O2NUxC4qnAjNCk5QdAk/WAWBcT1lqp
	 xLT+6/XFaprJA==
Date: Wed, 26 Mar 2025 18:46:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <b5los4qt7atc75phmurtswymgyeh4tojpu4nctmq6tcd45an6n@rjm3n53z3imx>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
 <Z9qoGmNKcozbIjeH@smile.fi.intel.com>
 <hinocg3itjqizbmzgaxv6cfnhtus6wbykouiy6pa27cxnjjuuk@l5ppwh7md6ul>
 <Z9vydaUguJiVaHtU@smile.fi.intel.com>
 <D8PF958QL5AK.2JIE4F1N1NI0F@bootlin.com>
 <Z-LSHoYA1enEOeHC@smile.fi.intel.com>
 <D8QA116WPNUE.11VKIHSG9N0OZ@bootlin.com>
 <Z-Qh8yBMaCMhv_Ny@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5lu7dui2veijkixr"
Content-Disposition: inline
In-Reply-To: <Z-Qh8yBMaCMhv_Ny@smile.fi.intel.com>


--5lu7dui2veijkixr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

On Wed, Mar 26, 2025 at 05:49:07PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 26, 2025 at 03:44:28PM +0100, Mathieu Dubois-Briand wrote:
> > On Tue Mar 25, 2025 at 4:56 PM CET, Andy Shevchenko wrote:
> > > On Tue, Mar 25, 2025 at 03:37:29PM +0100, Mathieu Dubois-Briand wrote:
> > > > On Thu Mar 20, 2025 at 11:48 AM CET, Andy Shevchenko wrote:
> > > > > On Thu, Mar 20, 2025 at 08:50:00AM +0100, Uwe Kleine-K=F6nig wrot=
e:
> > > > > > On Wed, Mar 19, 2025 at 01:18:50PM +0200, Andy Shevchenko wrote:
> > > > > > > On Tue, Mar 18, 2025 at 05:26:20PM +0100, mathieu.dubois-bria=
nd@bootlin.com wrote:
>=20
> ...
>=20
> > > > > > > > +	chip =3D devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS=
, 0);
> > > > > > >=20
> > > > > > > This is quite worrying. The devm_ to parent makes a lot of as=
sumptions that may
> > > > > > > not be realised. If you really need this, it has to have a ve=
ry good comment
> > > > > > > explaining why and object lifetimes.
> > > > > >=20
> > > > > > Pretty sure this is broken. This results for example in the dev=
ice link
> > > > > > being created on the parent. So if the pwm devices goes away a =
consumer
> > > > > > might not notice (at least in the usual way). I guess this was =
done to
> > > > > > ensure that #pwm-cells is parsed from the right dt node? If so,=
 that
> > > > > > needs a different adaption. That will probably involve calling
> > > > > > device_set_of_node_from_dev().
> > > > >
> > > > > It's an MFD based driver, and MFD core cares about propagating fw=
node by
> > > > > default. I believe it should just work if we drop that '->parent'=
 part.
> > > >=20
> > > > Are you sure about that?
> > >
> > > Yes and no. If your DT looks like (pseudo code as I don't know
> > > DTS syntax by heart):
> > >
> > > 	device: {
> > > 		parent-property =3D value;
> > > 		child0:
> > > 			...
> > > 		child1:
> > > 			...
> > > 	}
> > >
> > > the parent-property value is automatically accessible via fwnode API,
> > > but I don't know what will happen to the cases when each of the child=
ren
> > > has its own compatible string. This might be your case, but again,
> > > I'm not an expert in DT.
> > >
> >=20
> > On my side:
> > - Some MFD child do have a child node in the device tree, with an
> >   associated compatible value. No problem for these, they do get correct
> >   of_node/fwnode values pointing on the child device tree node.
> > - Some MFD child do not have any node in the device tree, and for these,
> >   they have to use properties from the parent (MFD) device tree node.
> >   And here we do have some problems.
> >=20
> > > > On my side it does not work if I just drop the '->parent', this is =
why I
> > > > ended whit this (bad) pattern.
> > >
> > > > Now it does work if I do call device_set_of_node_from_dev() manuall=
y,
> > >
> > > AFAICT, this is wrong API to be called in the children. Are you talki=
ng about
> > > parent code?
> > >
> >=20
> > I believe I cannot do it in the parent code, as I would need to do it
> > after the call to devm_mfd_add_devices(), and so it might happen after
> > the probe. I still tried to see how it behaved, and it looks like PWM
> > core really did not expect to get an of_node assigned to the device
> > after adding the PWM device.
> >=20
> > So either I can do something in MFD core or in sub devices probe(), or I
> > need to come with a different way to do things.
> >=20
> > > > so it's definitely better. But I believe the MFD core is not propag=
ating
> > > > OF data, and I did not find where it would do that in the code. Yet=
 it
> > > > does something like this for ACPI in mfd_acpi_add_device(). Or mayb=
e we
> > > > do something bad in our MFD driver?
> > >
> > > ...or MFD needs something to have... Dunno.
> >=20
> > I have something working with a very simple change in mfd-core.c, but
> > I'm really not confident it won't break anything else. I wish I could
> > get some insights from an MFD expert.
> >=20
> > @@ -210,6 +210,8 @@ static int mfd_add_device(struct device *parent, in=
t id,
> >                 if (!pdev->dev.of_node)
> >                         pr_warn("%s: Failed to locate of_node [id: %d]\=
n",
> >                                 cell->name, platform_id);
> > +       } else if (IS_ENABLED(CONFIG_OF) && parent->of_node) {
> > +               device_set_of_node_from_dev(&pdev->dev, parent);
>=20
> The use of this API is inappropriate here AFAICT. It drops the parent ref=
count
> and on the second call to it you will have a warning from refcount librar=
y.

device_set_of_node_from_dev() does:

	of_node_put(pdev->dev->of_node);
	pdev->dev->of_node =3D of_node_get(parent->of_node);
	pdev->dev->of_node_reused =3D true;

Note that pdev isn't the platform device associated with the parent
device but the just allocated one representing the subdevice so
pdev->dev->of_node is NULL and the parent refcount isn't dropped.

But I'm unsure if this is the right place to call it or if
device_set_node() is indeed enough (also I wonder if
device_set_of_node_from_dev() should care for fwnode). I'll keep that
question for someone else.

Best regards
Uwe

--5lu7dui2veijkixr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfkPXYACgkQj4D7WH0S
/k4upQf6Axdao5zBz0Hz+STtYka9LKGhVF1UCfWMMwRHWmDbeIDAZCPDl/+rT/hu
OSH3njTdWTwTU5hL3AIs7mJdtCh8xT+9OPFMuEVow3yAX0TMY4R5xl1V8wlH1tLH
biRhSL2JC8OV3g52kT2HqPuE9m99ZmdXM6Ds8NsnKUILuXkElmMNkZ/rhwNljPob
tuXUqo4fAUQvDYaoh6gMfPqlYH2s3DYyifQksS3GW84rxsij2ueSoZ/2mVBWU25H
Hhjzxw/illE3NCs06OsCv06iYPyWIQFfgj25K/8ipW4SQPQ0KZ5sz8+PUGHd/flu
1yV8XatGYEduOwHyDfteDk83GtkVyw==
=XSI3
-----END PGP SIGNATURE-----

--5lu7dui2veijkixr--

