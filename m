Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6D435E5B7
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhDMR5C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 13:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhDMR5B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 13:57:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A48C061574
        for <linux-pwm@vger.kernel.org>; Tue, 13 Apr 2021 10:56:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWNH9-0001gH-CJ; Tue, 13 Apr 2021 19:56:35 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWNH8-0005v0-T8; Tue, 13 Apr 2021 19:56:34 +0200
Date:   Tue, 13 Apr 2021 19:56:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v8 4/8] dt-bindings: pwm: Support new PWM_USAGE_POWER flag
Message-ID: <20210413175631.pwbynvwmnn7oog4m@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-4-clemens.gruber@pqgruber.com>
 <20210412162723.7hlhgqp6wlfbkeky@pengutronix.de>
 <YHWFs1f0XHkqbddp@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ky54kfraiix4vkcz"
Content-Disposition: inline
In-Reply-To: <YHWFs1f0XHkqbddp@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ky54kfraiix4vkcz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 01:51:15PM +0200, Thierry Reding wrote:
> On Mon, Apr 12, 2021 at 06:27:23PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 12, 2021 at 03:27:41PM +0200, Clemens Gruber wrote:
> > > Add the flag and corresponding documentation for PWM_USAGE_POWER.
> >=20
> > My concern here in the previous round was that PWM_USAGE_POWER isn't a
> > name that intuitively suggests its semantic. Do you disagree?
>=20
> I suggested PWM_USAGE_POWER because I think it accurately captures what
> we want here.
>=20
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > ---
> > >  Documentation/devicetree/bindings/pwm/pwm.txt | 3 +++
> > >  include/dt-bindings/pwm/pwm.h                 | 1 +
> > >  2 files changed, 4 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Document=
ation/devicetree/bindings/pwm/pwm.txt
> > > index 084886bd721e..fe3a28f887c0 100644
> > > --- a/Documentation/devicetree/bindings/pwm/pwm.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm.txt
> > > @@ -46,6 +46,9 @@ period in nanoseconds.
> > >  Optionally, the pwm-specifier can encode a number of flags (defined =
in
> > >  <dt-bindings/pwm/pwm.h>) in a third cell:
> > >  - PWM_POLARITY_INVERTED: invert the PWM signal polarity
> > > +- PWM_USAGE_POWER: Only care about the power output of the signal. T=
his
> > > +  allows drivers (if supported) to optimize the signals, for example=
 to
> > > +  improve EMI and reduce current spikes.
> >=20
> > IMHO there are too many open questions about which freedom this gives to
> > the lowlevel driver. If the consumer requests .duty_cycle =3D 25ns +
> > .period =3D 100ns, can the driver provide .duty_cycle =3D 25s + .period=
 =3D
> > 100s which nominally has the same power output? Let's not introduce more
> > ambiguity than there already is.
>=20
> The freedom given to the driver should be to adjust the signal within
> reasonable bounds. Changing the time unit by a factor of 1000000000 is
> not within reason, and I doubt anyone would interpret it that way, even
> if we didn't document this at all.

Please define a rule that allows to judge if any given implementation is
correct or not. For the record neither "within reasonable bounds" nor "a
factor of 1000000000 is not within reason" is good enough.

This is not only important to be able to review drivers that implement
it, but also for consumers, because they should know what to expect.

> To be frank I think that quest of yours to try and rid the PWM API of
> all ambiguity is futile.

I consider my quest about rounding reasonable. And I think this is
painful because when the PWM framework was introduced it was too much ad
hoc and the APIs were not thought through enough. And because I don't
want to have that repeated, I express my concerns here.

> I've been trying to be lenient because you seem
> motivated, but I think you're taking this too far. There are always
> going to be cases that aren't completely clear-cut and where drivers
> need the flexibility to cheat in order to be useful at all. If we get to
> a point where everything needs to be 100% accurate, the majority of the
> PWM controllers won't be usable at all.
>=20
> Don't let perfect be the enemy of good.

I admit here I don't have a constructive idea how to define what is
needed.

For example if we only care about the relative duty cycle, a consumer
requests

	.period =3D 1045
	.duty_cyle =3D 680

and the driver can provide multiples of 100 ns for both .period and
=2Eduty_cycle, the candidates that might be sensible to chose from are
(IMHO):

 - exact relative duty:

	.period =3D 104500
	.duty_cycle =3D 68000

 - round both values in the same direction, minimizing error

 	.period =3D 1100
	.duty_cycle =3D 700

   (requested relative duty =3D 65.07%, implemented =3D 63.64%; when
   rounding both down we get 60%)

 - round both values mathematically:=20

 	.period =3D 1000
	.duty_cycle =3D 700

   (yielding a relative duty of 70% instead of the requested 65.07%)

 - Maybe

 	.period =3D 1000
	.duty_cycle =3D 600

   might also be preferable for some consumers?! (60%)

 - Maybe

 	.period =3D 2000
	.duty_cycle =3D 1300

   is a good compromise because the relative duty is nearly exactly
   matched and the period is only stretched by a factor < 2.

In my eyes a driver author should be told which of these options should
be picked. Do you consider it obvious which of these options is the
objective best? If so why? Do you agree that we should tell driver
authors how to implement this before we have several drivers that all
implement their own ideas and getting this in a consistent state is
another pain?

(My bet is you are lax and don't consider consistency among drivers soo
important. In this case we don't agree. I think it's important for
consumer driver authors to be able to rely on some expectations
independently which lowlevel driver is in use.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ky54kfraiix4vkcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB120wACgkQwfwUeK3K
7AkVXwf/Q85RA3Alm9y+oU4JSwFqQYvgpIdHmvqarGeBuncdhYUjiRnnB/UV9EKU
auNZVYY4/+EtObhL/oBZti5V/tpLAO+aleSPwVr7ZmJvm6CtRjS2JTVS1FAQd195
UdSVBzCVF46uo7UViXZH9UGnohYl3+HxvAZSxL2z+AAoRyBG57zVFDZu0vbRH6Xl
o8Q0Jysl4pcMpWE2yLgI6aXDnUeNxaQikJy1nT3wU+g6FRngCQQNSwbYrz3GJ7L2
fgmZ6fIu7kEusztqdSQmmAa9/Ts1qQVCAuf+Zz+NcbFaaDdHou0lgM6T+ASe5M5U
6hsKqu9Q4qzg6/o4C1I/k2+yw20bww==
=YLWV
-----END PGP SIGNATURE-----

--ky54kfraiix4vkcz--
