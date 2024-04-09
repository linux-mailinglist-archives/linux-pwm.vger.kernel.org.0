Return-Path: <linux-pwm+bounces-1877-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B63989D38E
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Apr 2024 09:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA643B20C8E
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Apr 2024 07:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19F7D096;
	Tue,  9 Apr 2024 07:49:21 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857547D08A
	for <linux-pwm@vger.kernel.org>; Tue,  9 Apr 2024 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648960; cv=none; b=a0ARsyfcOursPG73fKxansPQoSq3dXT2vTWzaK8W781QCGBaaIQZvrDTrRDBZCn95F4/YL134yKFU0QP2KrZqrTbsU6hFjUPITkU4xIRLGas6lMv3+Ueeki4jLfAnix1uyFOVEUmFxmyHmZckgGQBqMFLSz07kF9qjx0wJkrR3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648960; c=relaxed/simple;
	bh=5j4TuV8vRcRLAfu1YCJFfxKchwrk9RM8qUNUR2+nVuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxBhG81uWP5LuNT7eSJxxWvANi1UF8JBLvIx4NDXbxffsPvohK+oJ1yFbUrelZc9UEehre6C7c7xDZH21BNcWqx3AX48kD6TMiH+gQvISmfEEE6uYVUQUr9AZguer283hfX1DGWekN0zUpT6zs/3jbx+Tf6Q45dLrGk1+SXEBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ru6EE-0007YK-38; Tue, 09 Apr 2024 09:49:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ru6ED-00BGR6-GK; Tue, 09 Apr 2024 09:49:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ru6ED-00GoJV-1N;
	Tue, 09 Apr 2024 09:49:13 +0200
Date: Tue, 9 Apr 2024 09:49:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: John Ernberg <john.ernberg@actia.se>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 8/8] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Message-ID: <z6g6zbzwaejozhb7hxjnta2tawifa5diblz6ktdt6hnngazkfr@xclx4ooiuw63>
References: <8d3acfc431ecd431d6cced032dcb58ad2579474c.1710670958.git.u.kleine-koenig@pengutronix.de>
 <20240408154233.890293-1-john.ernberg@actia.se>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yv6ye4ccej6tofoz"
Content-Disposition: inline
In-Reply-To: <20240408154233.890293-1-john.ernberg@actia.se>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--yv6ye4ccej6tofoz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo,

On Mon, Apr 08, 2024 at 03:42:39PM +0000, John Ernberg wrote:
> Seeing this patch set made me excited.

\o/

> Did you consider or try a pwm_line model structure, that is connected to =
a file
> descriptor, more like request_line from gpio chardevs?

I'd be open for an extension that simplifies detection of which (chip,
hwpwm) pair corresponds to which usage. It could be fed from a device
tree like:

	&pwm0 {
		compatible =3D ...;
		reg =3D <...>;
		#pwm-cells =3D <3>;
		pwm-names =3D "motor-control", "backlight", "", "status-led";
	}

and provide a function in libpwm that allows to determine the chipid of
the chip corresponding to &pwm0 (or an open fd to that device) and 3
when "status-led" is searched for.

This could be done completely in userspace I think (by inspecting
sysfs), so I wonder if this could be a complete userspace
implementation. I like keeping the kernel API simple, i.e. let it only
work (as it is now) only using chipid and hwpwm. Hmm, maybe make pwm
names a kernel concept exposed to sysfs to not have to hardcode the dt
details into libpwm?!

> We have been using gpio chardevs for a while and really benefitted from t=
hat
> over the sysfs interface. I wrote a simple wrapper around the PWM sysfs
> interface mimicing the way gpio chardevs work for PWM using dirfd, to mak=
e our
> application design more streamlined.

libpwm can also fall back to sysfs when the character devices are
missing. If you want to compare the two implementation and create a best
of two merge from it, that would be great.

> With this patch set I do not see how we can name the PWMs in the device t=
ree
> nor during request which is a big benefit with GPIO when we need to suppo=
rt
> multiple hardwares. Nor can I see how we would inspect which pins are
> allocated or their names when debugging.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yv6ye4ccej6tofoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYU8vgACgkQj4D7WH0S
/k7zmggAoEhtQonGIKDZOmPqv8gcL2jXzIYA6dEv1ETX/fxe1AmuABF/m+TAgxdz
+PGKZ3ypzDfySoklMpPJOEA85NeUgwTzg9f3IJhluJsK0IrTswJ/dwe5Ct6EYLIj
plU2ey2BKleiM5xJgQRrmlf7ATKmFGUp6Yu13AsIuOyNjkVYeW4tO4gXnLLBSrs7
AGSmIA9q74jJt+dipUSt73Fwma8xXLnwwxmpaArPxbHVhMXigmrZm+H3Cjl9ZcHX
uX6D1UA2URscsdcWb5xWEQ8ZCN+2Eqttgx2cn+0VJXMouVpCNTaNTIhmPGfbW+Rx
7XeJKoGhDCZR9jwEE/gZllxyt3ufIw==
=qgo8
-----END PGP SIGNATURE-----

--yv6ye4ccej6tofoz--

