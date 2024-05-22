Return-Path: <linux-pwm+bounces-2220-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625B68CBF32
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 12:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938BD1C20DF7
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C68248C;
	Wed, 22 May 2024 10:23:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D582492
	for <linux-pwm@vger.kernel.org>; Wed, 22 May 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373431; cv=none; b=Ceu2w19HexudU5huKLBrid4h9y3oORWQ5s1QOCy3JUQwumUkx8xYY5ps2lwGxFV4xSW/wao9ldYt+G1uj0F9tc4i94qkNZtSJcwJGDMtveBuj03T+32ScU15wE74CvoQnM+JjLnR1371gWwdgRzKP/a7ELpeSvpakRSVg3G8ANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373431; c=relaxed/simple;
	bh=8Jv2FoH6NJPjGOP0LC/PqVRnbeV7oAwm/+X5xjFYdEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMPam8VGDfDt0Ng0Y3EupJ1NCyemf4IRcb18uJnzoVKU9Qt4jL4flOrOkt2zgZ0WhVbBjFanSjiSqz5eaN/jY6hjFgLlrUOiy4pwrHbfVFM5mRBZKt7UKDONLbeM43ie1ZM++ln4ZG7mjAxKqCinV4kHoCj8kfeiXgXCz/6xx7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9j8I-0000WW-JS; Wed, 22 May 2024 12:23:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9j8H-002Vkx-RJ; Wed, 22 May 2024 12:23:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9j8H-009uTO-2Q;
	Wed, 22 May 2024 12:23:41 +0200
Date: Wed, 22 May 2024 12:23:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH 5/5] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <kn46i4ejb7demlieowowwur7mps6bmlaiqctxuh2gufi7vnon3@ourzmteng7gk>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
 <20240520195942.11582-6-laurent.pinchart@ideasonboard.com>
 <dl7a6puox5lc36fpto2fgyfgmpd3uboqc4lcfdtuaxzzsboqld@alw7vyi7pqjz>
 <20240521100922.GF16345@pendragon.ideasonboard.com>
 <xobmekjwqanow765yr42tsgknc5gc7szjublq6ywgbmoxovlr5@v3sofz5bmkol>
 <20240522101335.GE1935@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="njhuclhgrbcf33b5"
Content-Disposition: inline
In-Reply-To: <20240522101335.GE1935@pendragon.ideasonboard.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--njhuclhgrbcf33b5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Laurent,

On Wed, May 22, 2024 at 01:13:35PM +0300, Laurent Pinchart wrote:
> On Tue, May 21, 2024 at 03:05:53PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, May 21, 2024 at 01:09:22PM +0300, Laurent Pinchart wrote:
> > > On Tue, May 21, 2024 at 10:51:26AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, May 20, 2024 at 10:59:41PM +0300, Laurent Pinchart wrote:
> > > > > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > > > > +		swap(on, off);
> > > >=20
> > > > Uhh, no. Either you can do inverted polarity or you cannot. Don't c=
laim
> > > > you can.
> > >=20
> > > OK, but what's the rationale ? This is also an area where I couldn't
> > > find documentation.
> >=20
> > I don't have a good rationale here. IMHO this inverted polarity stuff is
> > only a convenience for consumers because the start of the period isn't
> > visible from the output wave form (apart from (maybe) the moment where
> > you change the configuration) and so
> >=20
> > 	.period =3D 5000, duty_cycle =3D 1000, polarity =3D PWM_POLARITY_NORMAL
> >=20
> > isn't distinguishable from
> >=20
> > 	.period =3D 5000, duty_cycle =3D 4000, polarity =3D PWM_POLARITY_INVER=
SED
> >=20
> > . But it's a historic assumption of the pwm core that there is a
> > relevant difference between the two polarities and I want at least a
> > consistent behaviour among the lowlevel drivers. BTW, this convenience
> > is the reason I'm not yet clear how I want to implemement a duty_offset.
>=20
> Consistency is certainly good. Inverting the duty cycle to implement
> inverted polarity would belong in the PWM core if we wanted to implement
> it in software I suppose. I'll drop it from the driver.

This isn't as easy as it sounds however. From the POV of the PWM core
the capabilities of the currently used hardware are unclear. So if a
request with (say) normal polarity and a certain duty_cycle + period
fails, it's unknown if it would be beneficial to try with inverted
polarity and if that is OK for the requesting consumer. So there is
information missing in both directions.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--njhuclhgrbcf33b5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZNx6wACgkQj4D7WH0S
/k7gSQf/eP3kBKkVvjsZKN2YXLxC/e3LV/e5b/nZfHIgt3CEctZeTQcGfZLQa5V+
WVkCjKeolCGJXYxsB84okaHK/6GPQ+cWMquFk4qbN28WgIHSj+7HJCkaqDY14Ar/
9oW8fVNG4s9ZpbeQPJ4iH4b5zrx+JSQRzeW2hw9l+XvCeMG8d9Eno8m9CERF72ud
6dL1fkPvxjtFklYNgqwGavc65n+kqme2GvfHu87ZkPHb4lLH14tMtlZOmlaIKGpS
hUJSMQugUreF6MndO9VsMpmKK80YigNY7L4d8D19W1H5nwvTaxuO5kwahMbYas0f
4LqNkFV5ycdF43EAUXChc/1w57dTyQ==
=s0N3
-----END PGP SIGNATURE-----

--njhuclhgrbcf33b5--

