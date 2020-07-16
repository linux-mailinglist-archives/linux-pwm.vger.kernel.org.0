Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B928B221C65
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Jul 2020 08:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgGPGKY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jul 2020 02:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgGPGKX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Jul 2020 02:10:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377CC061755
        for <linux-pwm@vger.kernel.org>; Wed, 15 Jul 2020 23:10:23 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvx5y-0004Ls-Bg; Thu, 16 Jul 2020 08:10:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvx5w-0008GV-5U; Thu, 16 Jul 2020 08:10:12 +0200
Date:   Thu, 16 Jul 2020 08:10:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 07/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200716061009.z7uu4lcwo3wk6dzb@pengutronix.de>
References: <20200709085006.b54ype3p4yu64upl@pengutronix.de>
 <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
 <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
 <c0594c34c712ce26b3936d42c92d2361@walle.cc>
 <20200714160856.rjqi7lv63geil3hm@pengutronix.de>
 <eedceb44cba9b54e0634f0e8e4f96f70@walle.cc>
 <20200715163620.xhi24mct5b64qpyp@pengutronix.de>
 <7d8e9f524f0fd81be282be0be50d16ad@walle.cc>
 <20200715181803.nmgi32tugpbuqvjg@pengutronix.de>
 <8debe0ee9aff2c49a7567069d7bb9477@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4bah6ckq6xdukftr"
Content-Disposition: inline
In-Reply-To: <8debe0ee9aff2c49a7567069d7bb9477@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4bah6ckq6xdukftr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Wed, Jul 15, 2020 at 10:41:25PM +0200, Michael Walle wrote:
> Am 2020-07-15 20:18, schrieb Uwe Kleine-K=F6nig:
> > On Wed, Jul 15, 2020 at 07:45:10PM +0200, Michael Walle wrote:
> > >=20
> > > Am 2020-07-15 18:36, schrieb Uwe Kleine-K=F6nig:
> > > > On Tue, Jul 14, 2020 at 11:09:28PM +0200, Michael Walle wrote:
> > > > > > My wishlist (just as it comes to my mind, so no guarantee of
> > > > > > completeness):
> > > > > >
> > > > > >  - can do 0% duty cycle for all supported period lengths
> > > > > >  - can do 100% duty cycle for all supported period lengths
> > > > > >  - supports both polarities
> > > > > >  - supports immediate change of configuration and after complet=
ion of
> > > > > >    the currently running period
> > > > > >  - atomic update (i.e. if you go from configuration A to config=
uration B
> > > > > >    the hardware guarantees to only emit periods of type A and t=
hen type
> > > > > >    B. (Depending on the item above, the last A period might be =
cut off.)
> > > > >
> > > > > We actually discussed this, because the implementation would be
> > > > > easier. But
> > > > > if the change takes place immediately you might end up with a lon=
ger
> > > > > duty
> > > > > cycle. Assume the PWM runs at 80% duty cycle and starts with the
> > > > > on-period.
> > > > > If you now change that to 50% you might end up with one successive
> > > > > duty
> > > > > cycle of "130%". Eg. the 80% of the old and right after that you
> > > > > switch to
> > > > > the new 50% and then you'd have a high output which corresponds t=
o a
> > > > > 130%
> > > > > cycle. I don't know if that is acceptable for all applications.
> > > >
> > > > I thought this is a "change takes place immediately" implementation=
?! So
> > > > these problems are actually real here. (And this not happening is
> > > > exactly
> > > > my wish here. Is there a mis-understanding?)
> > >=20
> > > I wasn't talking about the sl28cpld btw. What is the difference
> > > between
> > > your proposed "change take place immediately" and "after the cycle".
> > > I understand how the after the cycle should work. But how would the
> > > immediate change work in your ideal PWM?
> >=20
> > If the PWM is running at 1/3 duty cycle and reconfigured for 2/3, then
> > the two scenarios are (the * marks the moment where pwm_apply_state() is
> > called, ^ marks the start of a period):
> >=20
> > immediately:
> >=20
> >   __       __    _____    _____
> >  /  \_____/  \__/     \__/
> >  ^        ^     ^        ^
> >                 *
>=20
> Ok lets assume 2/3 and change it to 1/3:
>=20
>    ____     ______      __
>   /    \___/      \____/  \____
>   ^        ^   ^       ^
>                *
> This will then have a longer on period than any of the settings.

I think we agree here. With an immediate change to the new setting both
too long and too short signals can heppen. How bad this is depends on
the use. The consumers currently in the kernel probably don't care too
much.

> > > > > > > > What about disable()?
> > > > > > >
> > > > > > > Mhh well, it would do one 100% cycle.. mhh ;) Lets see if the=
re we can
> > > > > > > fix that (in hardware), not much we can do in the driver here=
=2E We are
> > > > > > > _very_ constraint in size, therefore all that little edge cas=
es fall
> > > > > > > off
> > > > > > > the table.
> > > > > >
> > > > > > You're saying that on disable the hardware emits a constant hig=
h level
> > > > > > for one cycle? I hope not ...
> > > > >
> > > > > Mh, I was mistaken, disabling the PWM will turn it off immediatel=
y,
> > > > > but
> > > >
> > > > And does turn off mean, the output gets inactive?
> > > > If so you might also disable the hardware if a 0% duty cycle is
> > > > configured assuming this saves some energy without modifying the
> > > > resulting wave form.
> > >=20
> > > Disabling it has some side effects like switching to another function
> > > for this multi function pin. So I'd rather keep it on ;)
> >=20
> > So IMHO you should also keep it on when pwm_apply_state is called with
> > state.enabled =3D false to ensure a low output.
>=20
> That won't work either, because that is how you would turn on that multi
> function. Ie. it is GPIO (default input) as long as the PWM is not enable=
d,
> otherwise its PWM.

I think you misunderstood what I wrote. The intended behaviour for a
disabled PWM (as in: pwm_apply_state() was called with state.enabled =3D
false) is that the output is a constant low (assuming a normal
polarity). If disabling your hardware results in something else, don't
disable the hardware. That's another item in the Limitations paragraph.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4bah6ckq6xdukftr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8P7z4ACgkQwfwUeK3K
7AkERwf7Bnq1RmmZZQEaEwO2ylFCpy6YKnXVLNIu3EmoJGn5P52CsM5A5Qfzg+lh
FqwhdDqowMO7BpePNly1bdYZzO32kuVb2rJUAgBcXtC06liNeJWCwXgCMola+8LC
ZXVn66RdWkQpBVO2mHjnTgOLorVIJuytb//evqyxYgNcicNwUGy5Nq9WtQM9OkBl
nwd1o+p5iqOvwJ5YfjJNTTKoDbzoG0RqfTcwSWiAazSZZBdcERzbCxUuKM+ci55y
0CjOU+OaEQU2lMc6h+0e+mlYO3+3fHL4wiOF32iRXEabMbaaUxVq+R46VJXBwwwM
CmDqF+afXcPaPzQqs1QqUj35WTTi5Q==
=t2cU
-----END PGP SIGNATURE-----

--4bah6ckq6xdukftr--
