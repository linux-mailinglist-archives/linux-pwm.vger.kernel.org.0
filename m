Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A2522141F
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2020 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgGOSSN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Jul 2020 14:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGOSSM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jul 2020 14:18:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D23C061755
        for <linux-pwm@vger.kernel.org>; Wed, 15 Jul 2020 11:18:11 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvlyo-0003Sd-Lv; Wed, 15 Jul 2020 20:18:06 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvlyl-000415-ST; Wed, 15 Jul 2020 20:18:03 +0200
Date:   Wed, 15 Jul 2020 20:18:03 +0200
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
Message-ID: <20200715181803.nmgi32tugpbuqvjg@pengutronix.de>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
 <20200709085006.b54ype3p4yu64upl@pengutronix.de>
 <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
 <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
 <c0594c34c712ce26b3936d42c92d2361@walle.cc>
 <20200714160856.rjqi7lv63geil3hm@pengutronix.de>
 <eedceb44cba9b54e0634f0e8e4f96f70@walle.cc>
 <20200715163620.xhi24mct5b64qpyp@pengutronix.de>
 <7d8e9f524f0fd81be282be0be50d16ad@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f4urrnelako4gbo3"
Content-Disposition: inline
In-Reply-To: <7d8e9f524f0fd81be282be0be50d16ad@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--f4urrnelako4gbo3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 07:45:10PM +0200, Michael Walle wrote:
> Hi Uwe,
>=20
> Am 2020-07-15 18:36, schrieb Uwe Kleine-K=F6nig:
> > On Tue, Jul 14, 2020 at 11:09:28PM +0200, Michael Walle wrote:
> > > > My wishlist (just as it comes to my mind, so no guarantee of
> > > > completeness):
> > > >
> > > >  - can do 0% duty cycle for all supported period lengths
> > > >  - can do 100% duty cycle for all supported period lengths
> > > >  - supports both polarities
> > > >  - supports immediate change of configuration and after completion =
of
> > > >    the currently running period
> > > >  - atomic update (i.e. if you go from configuration A to configurat=
ion B
> > > >    the hardware guarantees to only emit periods of type A and then =
type
> > > >    B. (Depending on the item above, the last A period might be cut =
off.)
> > >=20
> > > We actually discussed this, because the implementation would be
> > > easier. But
> > > if the change takes place immediately you might end up with a longer
> > > duty
> > > cycle. Assume the PWM runs at 80% duty cycle and starts with the
> > > on-period.
> > > If you now change that to 50% you might end up with one successive
> > > duty
> > > cycle of "130%". Eg. the 80% of the old and right after that you
> > > switch to
> > > the new 50% and then you'd have a high output which corresponds to a
> > > 130%
> > > cycle. I don't know if that is acceptable for all applications.
> >=20
> > I thought this is a "change takes place immediately" implementation?! So
> > these problems are actually real here. (And this not happening is
> > exactly
> > my wish here. Is there a mis-understanding?)
>=20
> I wasn't talking about the sl28cpld btw. What is the difference between
> your proposed "change take place immediately" and "after the cycle".
> I understand how the after the cycle should work. But how would the
> immediate change work in your ideal PWM?

If the PWM is running at 1/3 duty cycle and reconfigured for 2/3, then
the two scenarios are (the * marks the moment where pwm_apply_state() is
called, ^ marks the start of a period):

immediately:

  __       __    _____    _____
 /  \_____/  \__/     \__/
 ^        ^     ^        ^
                *

after the cycle
  __       __       _____    _____
 /  \_____/  \_____/     \__/
 ^        ^        ^        ^
                *

and with my ideal PWM I can choose which of the two behaviours I want.

> > > > > > What about disable()?
> > > > >
> > > > > Mhh well, it would do one 100% cycle.. mhh ;) Lets see if there w=
e can
> > > > > fix that (in hardware), not much we can do in the driver here. We=
 are
> > > > > _very_ constraint in size, therefore all that little edge cases f=
all
> > > > > off
> > > > > the table.
> > > >
> > > > You're saying that on disable the hardware emits a constant high le=
vel
> > > > for one cycle? I hope not ...
> > >=20
> > > Mh, I was mistaken, disabling the PWM will turn it off immediately,
> > > but
> >=20
> > And does turn off mean, the output gets inactive?
> > If so you might also disable the hardware if a 0% duty cycle is
> > configured assuming this saves some energy without modifying the
> > resulting wave form.
>=20
> Disabling it has some side effects like switching to another function
> for this multi function pin. So I'd rather keep it on ;)

So IMHO you should also keep it on when pwm_apply_state is called with
state.enabled =3D false to ensure a low output.

> > > one 100% duty cycle may happen if you change from a higher to a lower
> > > duty cycle setting. See above.
> > >=20
> > > > I never programmed a CPLD to emulate a hardware PWM, but I wonder if
> > > > these are really edge cases that increase the size of the binary?!
> > >=20
> > > At the moment there is only one 8bit register which stores the value
> > > which is used for matching. If you want to change that setting after
> > > a whole cycle, you'd use another 8bit register to cache the new value.
> > > So this would at least needs 8 additional flip-flops. This doesn't
> > > sound much, but we are already near 100% usage of the CPLD. So its
> > > hard to convince people why this is really necessary.
> >=20
> > OK. (Maybe there is enough space to allow implementing 100% for mode 0?)
>=20
> Little bit here a little bit there ;) TBH there are some more critical
> bugs which would need to be fixed first. So this would need to be a
> limitation for now.

Ok for me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f4urrnelako4gbo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8PSFgACgkQwfwUeK3K
7AmGDwgAm95avWRsld3nTjBceB0wN2U3rfrBSGmvypuUp5vppogjIM6W07spEnxY
m/vKOHxNGrm4DNXqFfmv3F/gygTbLMtKr3kbPHWsfA+k3CeMS+zxCh6Fojbf3Jih
6Kh+ZnFNzyRwObAiK6biI5tyAJtJTvvlhrKZcLFraJce2wio8PLfUUPtDQiah1+9
UxVnKfhhhpr1yeH6ke0CFKNCdRv74oewtYgMZlfp1Uk5XXTeXWi8qqb+l/GsO1KG
OdAGj4vN1xPf/Ze7dGzxhXKoyDONSu9Hw5s2eQAJIVmstvVUjpN9IDOqYgbItZuN
mcyqN8M8SnBgByA7QXOG0VtnMpXpIA==
=43K8
-----END PGP SIGNATURE-----

--f4urrnelako4gbo3--
