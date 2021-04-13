Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E826C35E728
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 21:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhDMTio (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhDMTin (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 15:38:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C096C061574
        for <linux-pwm@vger.kernel.org>; Tue, 13 Apr 2021 12:38:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWOra-0003b7-NH; Tue, 13 Apr 2021 21:38:18 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWOra-0003y5-9m; Tue, 13 Apr 2021 21:38:18 +0200
Date:   Tue, 13 Apr 2021 21:38:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <20210413193818.r7oqzdzbxqf5sjj3@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412161808.lp2amdfopw74lvz7@pengutronix.de>
 <YHR3wP4Fk3jidnri@workstation.tuxnet>
 <20210412201019.vouxx4daumusrcvr@pengutronix.de>
 <YHWKehtYFSaHt1hC@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ttooeqacrohtzhf"
Content-Disposition: inline
In-Reply-To: <YHWKehtYFSaHt1hC@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4ttooeqacrohtzhf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Tue, Apr 13, 2021 at 02:11:38PM +0200, Clemens Gruber wrote:
> On Mon, Apr 12, 2021 at 10:10:19PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 12, 2021 at 06:39:28PM +0200, Clemens Gruber wrote:
> > > On Mon, Apr 12, 2021 at 06:18:08PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Apr 12, 2021 at 03:27:38PM +0200, Clemens Gruber wrote:
> > > > > The switch to the atomic API goes hand in hand with a few fixes to
> > > > > previously experienced issues:
> > > > > - The duty cycle is no longer lost after disable/enable (previous=
ly the
> > > > >   OFF registers were cleared in disable and the user was required=
 to
> > > > >   call config to restore the duty cycle settings)
> > > > > - If one sets a period resulting in the same prescale register va=
lue,
> > > > >   the sleep and write to the register is now skipped
> > > > > - Previously, only the full ON bit was toggled in GPIO mode (and =
full
> > > > >   OFF cleared if set to high), which could result in both full OF=
F and
> > > > >   full ON not being set and on=3D0, off=3D0, which is not allowed=
 according
> > > > >   to the datasheet
> > > > > - The OFF registers were reset to 0 in probe, which could lead to=
 the
> > > > >   forbidden on=3D0, off=3D0. Fixed by resetting to POR default (f=
ull OFF)
> > > > >=20
> > > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > > ---
> > > > > Changes since v7:
> > > > > - Moved check for !state->enabled before prescaler configuration
> > > > > - Removed unnecessary cast
> > > > > - Use DIV_ROUND_DOWN in .apply
> > > > >=20
> > > > > Changes since v6:
> > > > > - Order of a comparison switched for improved readability
> > > > >=20
> > > > > Changes since v5:
> > > > > - Function documentation for set_duty
> > > > > - Variable initializations
> > > > > - Print warning if all LEDs channel
> > > > > - Changed EOPNOTSUPP to EINVAL
> > > > > - Improved error messages
> > > > > - Register reset corrections moved to this patch
> > > > >=20
> > > > > Changes since v4:
> > > > > - Patches split up
> > > > > - Use a single set_duty function
> > > > > - Improve readability / new macros
> > > > > - Added a patch to restrict prescale changes to the first user
> > > > >=20
> > > > > Changes since v3:
> > > > > - Refactoring: Extracted common functions
> > > > > - Read prescale register value instead of caching it
> > > > > - Return all zeros and disabled for "all LEDs" channel state
> > > > > - Improved duty calculation / mapping to 0..4096
> > > > >=20
> > > > > Changes since v2:
> > > > > - Always set default prescale value in probe
> > > > > - Simplified probe code
> > > > > - Inlined functions with one callsite
> > > > >=20
> > > > > Changes since v1:
> > > > > - Fixed a logic error
> > > > > - Impoved PM runtime handling and fixed !CONFIG_PM
> > > > > - Write default prescale reg value if invalid in probe
> > > > > - Reuse full_off/_on functions throughout driver
> > > > > - Use cached prescale value whenever possible
> > > > >=20
> > > > >  drivers/pwm/pwm-pca9685.c | 259 +++++++++++++-------------------=
------
> > > > >  1 file changed, 89 insertions(+), 170 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > > > index 4a55dc18656c..827b57ced3c2 100644
> > > > > --- a/drivers/pwm/pwm-pca9685.c
> > > > > +++ b/drivers/pwm/pwm-pca9685.c
> > > > > @@ -51,7 +51,6 @@
> > > > >  #define PCA9685_PRESCALE_MAX	0xFF	/* =3D> min. frequency of 24 H=
z */
> > > > > =20
> > > > >  #define PCA9685_COUNTER_RANGE	4096
> > > > > -#define PCA9685_DEFAULT_PERIOD	5000000	/* Default period_ns =3D =
1/200 Hz */
> > > > >  #define PCA9685_OSC_CLOCK_MHZ	25	/* Internal oscillator with 25 =
MHz */
> > > > > =20
> > > > >  #define PCA9685_NUMREGS		0xFF
> > > > > @@ -71,10 +70,14 @@
> > > > >  #define LED_N_OFF_H(N)	(PCA9685_LEDX_OFF_H + (4 * (N)))
> > > > >  #define LED_N_OFF_L(N)	(PCA9685_LEDX_OFF_L + (4 * (N)))
> > > > > =20
> > > > > +#define REG_ON_H(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED_=
ON_H : LED_N_ON_H((C)))
> > > > > +#define REG_ON_L(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED_=
ON_L : LED_N_ON_L((C)))
> > > > > +#define REG_OFF_H(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED=
_OFF_H : LED_N_OFF_H((C)))
> > > > > +#define REG_OFF_L(C)	((C) >=3D PCA9685_MAXCHAN ? PCA9685_ALL_LED=
_OFF_L : LED_N_OFF_L((C)))
> > > >=20
> > > > I'd like to see these named PCA9685_REG_ON_H etc.
> > >=20
> > > I did not use the prefix because the existing LED_N_ON/OFF_H/L also do
> > > not have a prefix. If the prefix is mandatory, I think LED_N_.. should
> > > also be prefixed, right?
> >=20
> > I'd like to seem the prefixed (and assume that Thierry doesn't agree).
> > IMHO it's good style and even though it yields longer name usually it
> > yields easier understandable code. (But this seems to be subjective.)
>=20
> I am not sure I want to also rename the existing LED_N_OFF stuff in this
> patch. Maybe we can discuss unifying the macros (either with or without
> prefix) in a later patch and I keep the REG_ON_ stuff for now without to
> match the LED_N_ stuff?

While consistency is fine I agree that this patch is already big and
letting it do the things similar to other stuff in this driver is ok.

> > > > Consider the following request: state->period =3D 4177921 [ns] +
> > > > state->duty_cycle =3D 100000 [ns], then we get
> > > > PRESCALE =3D round(25 * state->period / 4096000) - 1 =3D 25 and so =
an actual
> > > > period of 4096000 / 25 * (25 + 1) =3D 4259840 [ns]. If you now calc=
ulate
> > > > the duty using 4096 * 100000 / 4177920 =3D 98, this corresponds to =
an
> > > > actual duty cycle of 98 * 4259840 / 4096 =3D 101920 ns while you sh=
ould
> > > > actually configure 96 to get 99840 ns.
> > > >=20
> > > > So in the end I'd like to have the following:
> > > >=20
> > > > 	PRESCALE =3D round-down(25 * state->period / 4096000) - 1
> > > >=20
> > > > (to get the biggest period not bigger than state->period) and
> > > >=20
> > > > 	duty =3D round-down(state->duty_cycle * 25 / ((PRESCALE + 1) * 100=
0))
> > > >=20
> > > > (to get the biggest duty cycle not bigger than state->duty_cycle). =
With
> > > > the example above this yields
> > > >=20
> > > > 	PRESCALE =3D 24
> > > > 	duty =3D 100
> > > >=20
> > > > which results in
> > > >=20
> > > > 	.period =3D 4096000 / 25 * 25 =3D 4096000 [ns]
> > > > 	.duty_cycle =3D 100000 [ns]
> > > > =09
> > > > Now you have a mixture of old and new with no consistent behaviour.=
 So
> > > > please either stick to the old behaviour or do it right immediately.
> > >=20
> > > I avoided rounding down the prescale value because the datasheet has =
an
> > > example where a round-closest is used, see page 25.
> >=20
> > The hardware guy who wrote this data sheet wasn't aware of the rounding
> > rules for Linux PWM drivers :-)
> >=20
> > > With your suggested round-down, the example with frequency of 200 Hz
> > > would no longer result in 30 but 29 and that contradicts the datashee=
t.
> >=20
> > Well, with PRESCALE =3D 30 we get a frequency of 196.88 Hz and with
> > PRESCALE =3D 29 we get a frequency of 203.45 Hz. So no matter if you pi=
ck
> > 29 or 30, you don't get 200 Hz. And which of the two possible values is
> > the better one depends on the consumer, no matter what rounding
> > algorithm the data sheet suggests. Also note that the math here contains
> > surprises you don't expect at first. For example, what PRESCALE value
> > would you pick to get 284 Hz? [If my mail was a video, I'd suggest to
> > press Space now to pause and let you think first :-)] The data sheet's
> > formula suggests:
> >=20
> > 	round(25 MHz / (4096 * 284)) - 1 =3D 20
> >=20
> > The resulting frequency when picking PRESCALE =3D 20 is 290.644 Hz (so =
an
> > error of 6.644 Hz). If instead you pick PRESCALE =3D 21 you get 277.433=
 Hz
> > (error =3D 6.567 Hz), so 21 is the better choice.
> >=20
> > Exercise for the reader:
> >  What is the correct formula to really determine the PRESCALE value that
> >  yields the best approximation (i.e. minimizing
> >  abs(real_freq - target_freq)) for a given target_freq?

I wonder if you tried this.

> > These things don't happen when you round down only.
>=20
> Sure, but it might also be counterintuitive that the Linux driver does
> not use the same formula as the datasheet. And when using 200 Hz, 29 is
> a little closer than 30.

First let me state that I consider keeping the math as is in this patch
a good idea. So to argue already for the future:

I value consistency among the various pwm lowlevel drivers higher than
what an individual hardware engineer happened to write in a data sheet.
That engineer was successful in describing the functionality of the chip
and that's where her/his job ends. How a driver should behave is to be
decided by us.

> I once measured the actual frequency and the internal oscillator is not
> very accurate, so even if you think you should get 196.88 Hz, the actual
> frequency measured with a decent scope is about 206 Hz and varies from
> chip to chip (~=A0205-207 Hz).

Huh. Did you do further measurements that suggest that the oscillator
doesn't run at 25 MHz but maybe at 26 MHz (which would yield 204.7552
Hz)? (Assume this is true, what do you think: Should be use the formula
that matches reality, or should we stick to the formula defined in the
data sheet?)
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4ttooeqacrohtzhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB18yYACgkQwfwUeK3K
7AlZtQf/dpKKWaEi2dVgMtedbzwCCGkr6zzvO9pydXc8m9t6W19n2jq0BiYtDaoZ
ZWTP9sq1S8N8EkoRm1gKF99ZXlzo+Z/7wFa99F2tEB/go/2oWAnVwSvYyyCUKxtv
ZkeqBYrciJOCdH1fD9fgm+rucUOjklMLJ1Betx9h7Nizx90ecNH+39ezXkX0JDVW
QULrqiQWqXIb981QvhlxOt2x2sxMr9PmqvraSkY4vK/1vQgKiw5eQaLjfjx/p847
Sm7IQMxwTG+QHfpdIFnS8gtQRvg+gUUR8Vrx7RMQ7IHkFtRlf+lVMU/oM0Joy8cc
22XVndQuXAuI1k1U4cgxyjN8N+26Ow==
=gQNC
-----END PGP SIGNATURE-----

--4ttooeqacrohtzhf--
