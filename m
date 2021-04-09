Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2724635A863
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 23:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhDIVfl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 17:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhDIVfk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 17:35:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41EBC061762
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 14:35:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUymg-00030P-3i; Fri, 09 Apr 2021 23:35:22 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUymf-0002XY-F3; Fri, 09 Apr 2021 23:35:21 +0200
Date:   Fri, 9 Apr 2021 23:35:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <20210409213521.mni4jygws4ml53dk@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
 <YG4UNoBCQJkEEfwi@workstation.tuxnet>
 <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
 <YG78IHIMGtl8Pokp@orome.fritz.box>
 <YG8miEOZXsH0NTcA@workstation.tuxnet>
 <20210408173637.w26njwystfuyrgan@pengutronix.de>
 <YHA5sPuZmbSLU3aM@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s3vmzldvkbc4c6zk"
Content-Disposition: inline
In-Reply-To: <YHA5sPuZmbSLU3aM@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s3vmzldvkbc4c6zk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Apr 09, 2021 at 01:25:36PM +0200, Thierry Reding wrote:
> On Thu, Apr 08, 2021 at 07:36:37PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Apr 08, 2021 at 05:51:36PM +0200, Clemens Gruber wrote:
> > > On Thu, Apr 08, 2021 at 02:50:40PM +0200, Thierry Reding wrote:
> > > > Yes, I think that's basically what this is saying. I think we're pe=
rhaps
> > > > getting hung up on the terminology here. PWM_STAGGERING_ALLOWED giv=
es
> > > > the impression that we're dealing with some provider-specific featu=
re,
> > > > whereas what we really want to express is that the PWM doesn't care
> > > > exactly when the active cycle starts and based on that a provider t=
hat
> > > > can support it may optimize the EMI behavior.
> > > >=20
> > > > Maybe we can find a better name for this? Ultimately what this mean=
s is
> > > > that the consumer is primarily interested in the power output of th=
e PWM
> > > > rather than the exact shape of the signal. So perhaps something like
> > > > PWM_USAGE_POWER would be more appropriate.
> > >=20
> > > Yes, although it would then no longer be obvious that this feature le=
ads
> > > to improved EMI behavior, as long as we mention that in the docs, I
> > > think it's a good idea
> > >=20
> > > Maybe document it as follows?
> > > PWM_USAGE_POWER - Allow the driver to delay the start of the cycle
> > > for EMI improvements, as long as the power output stays the same
> >=20
> > I don't like both names, because for someone who is only halfway into
> > PWM stuff it is not understandable. Maybe ALLOW_PHASE_SHIFT?
>=20
> Heh... how's that any more understandable?

The questions that come to (my) mind when reading PWM_USAGE_POWER are:
So the PWM is allowed to use some power? The PWM is used to provide a
power source (like a regulator)? Has this something to do with a
permission to use the PWM (the power to use it)?

Please try googling for "usage power", and compare it with the results
you get for "phase shift".

> > When a consumer is only interested in the power output than
> >=20
> > 	.period =3D 20
> > 	.duty_cycle =3D 5
> >=20
> > would also be an allowed response for the request
> >=20
> > 	.period =3D 200
> > 	.duty_cycle =3D 50
> >=20
> > and this is not what is in the focus here.
>=20
> Actually, that's *exactly* what's important here. From a consumer point
> of view the output power is the key in this case.

OK, so if I understand you correctly, you want indeed allow

 	.period =3D 200
 	.duty_cycle =3D 50

when

	.period =3D 20
	.duty_cycle =3D 5

was requested? Do you want also allow .period =3D 20000 + .duty_cycle =3D
5000? How would you limit what is allowed? I'd expect we don't want to
allow .period =3D 20000000000 + .duty_cycle =3D 5000000000? What should a
driver for a PWM backlight pass to pwm_apply_state if the PWM period
should be between 4000000 ns and 16666666 ns? (This comes from the first
backlight datasheet I found where the valid range for the brightness
input is 60 to 250Hz.) Maybe saying that only making the period smaller
would be an idea; but the motor bridge I recently worked with[1] limits
the PWM frequency to "up to 20 kHz", so this isn't an universally good
idea either.

[1] https://www.st.com/resource/en/datasheet/vnh5019a-e.pdf

> The specifier is a description of a particular PWM in the consumer
> context. And the consumer not going to care what exactly the PWM
> controller might end up configuring to achieve best results. If the
> controller allows the phase shift to be changed and the constraints
> allow it, then that's great, but it isn't something that the consumer
> has to know if all it wants is that the power output is as requested.

Yes, if ALLOW_PHASE_SHIFT isn't what the consumer actually wants, they
shouldn't use it. Agreed.

> Put another way, the more generically we can describe the constraints
> or use cases, the more flexibility we get for drivers to fulfill those
> constraints.

Yes, from the POV of a lowlevel driver the more general the better. From
the POV of a consumer this isn't universally true, because the consumer
might only accept a subset of the freedom this general flag gives to the
lowlevel driver.

> For example one controller might support phase shifting
> and use that for PWM_USAGE_POWER for better EMI behaviour. But another
> PWM controller may not support it. But it could perhaps want to
> optimize the PWM signal by reversing the polarity of one channel or
> whatever other mechanism there may be.
>=20
> If we add a flag such as ALLOW_PHASE_SHIFT, then only controllers that
> support programmable phase shift will be able to support this.

That's wrong, drivers that support the polarity that was not requested
can make use of it, too. That's something you already pointed out
yourself (or I misunderstood you). (Then

	.period =3D X
	.duty_cycle =3D Y
	.polarity =3D PWM_POLARITY_NORMAL

is "equivalent" to

	.period =3D X
	.duty_cycle =3D X - Y
	.polarity =3D PWM_POLARITY_INVERSED

as the signals only differ by a phase shift.)

> If some other mechanism can also be used to support "equivalent power"
> use cases, that would have to be described as some other flag, which
> has essentially the same meaning. So you can get into a situation
> where you have multiple flags used for the same thing.

If they are for the same thing, you don't need another flag. Your
concern is only valid if all consumers that are ok to accept a phase
shifted PWM signal really only care about the relative duty cycle. I
think that's wrong. (All consumers that use the PWM as something like a
clock signal where something happens on the rising and/or falling edge
and want this something happen with a certain frequency care about the
period, but not the phase shift.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s3vmzldvkbc4c6zk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBwyJUACgkQwfwUeK3K
7Akdmgf/RRrVk0JmdkZzOTJLd04K3pmZal+637F+mDs0Lm4HKt83fvdzEQLinWSe
HLag4DAxHOGChJrboJyYhF1xBLSj8pp6M6RLi2W7CJVfhjYFFeYKLAah7IzNeCFe
D14/UKiRI3V+KfwLqAhd5Bg/xDJBAgCzJRaCzXJ1PUjoYx4Ezn9g5WPmTCT0RVoh
+j7CjTcRw3AvBLFeFSWGFvsb5KIYnpCS24pGr/2FIyIBoVMUBqqSSS2P2asvWT/P
0vaODlDO24qAHvbUeq1+dRKvStxj9P1fhbGeMt0rR+IOfZZH3LPlRf5OBp6mc1wM
KtW8WpbLbxjT8OP8IJYfWtR9QUDOdA==
=npIW
-----END PGP SIGNATURE-----

--s3vmzldvkbc4c6zk--
