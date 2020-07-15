Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22EE221276
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2020 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGOQge (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Jul 2020 12:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGOQgd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jul 2020 12:36:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210B4C061755
        for <linux-pwm@vger.kernel.org>; Wed, 15 Jul 2020 09:36:33 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvkOQ-0001Gr-Qt; Wed, 15 Jul 2020 18:36:26 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvkOK-0000PJ-M9; Wed, 15 Jul 2020 18:36:20 +0200
Date:   Wed, 15 Jul 2020 18:36:20 +0200
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
Message-ID: <20200715163620.xhi24mct5b64qpyp@pengutronix.de>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
 <20200709085006.b54ype3p4yu64upl@pengutronix.de>
 <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
 <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
 <c0594c34c712ce26b3936d42c92d2361@walle.cc>
 <20200714160856.rjqi7lv63geil3hm@pengutronix.de>
 <eedceb44cba9b54e0634f0e8e4f96f70@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="43ja544hwta6zjxk"
Content-Disposition: inline
In-Reply-To: <eedceb44cba9b54e0634f0e8e4f96f70@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--43ja544hwta6zjxk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Tue, Jul 14, 2020 at 11:09:28PM +0200, Michael Walle wrote:
> > My wishlist (just as it comes to my mind, so no guarantee of
> > completeness):
> >=20
> >  - can do 0% duty cycle for all supported period lengths
> >  - can do 100% duty cycle for all supported period lengths
> >  - supports both polarities
> >  - supports immediate change of configuration and after completion of
> >    the currently running period
> >  - atomic update (i.e. if you go from configuration A to configuration B
> >    the hardware guarantees to only emit periods of type A and then type
> >    B. (Depending on the item above, the last A period might be cut off.)
>=20
> We actually discussed this, because the implementation would be easier. B=
ut
> if the change takes place immediately you might end up with a longer duty
> cycle. Assume the PWM runs at 80% duty cycle and starts with the on-perio=
d.
> If you now change that to 50% you might end up with one successive duty
> cycle of "130%". Eg. the 80% of the old and right after that you switch to
> the new 50% and then you'd have a high output which corresponds to a 130%
> cycle. I don't know if that is acceptable for all applications.

I thought this is a "change takes place immediately" implementation?! So
these problems are actually real here. (And this not happening is exactly
my wish here. Is there a mis-understanding?)

> >  - emits an irq when configuration changes
>=20
> Why would you need the interrupt?

To know that the new setting is active. Currently Thierry's ideal PWM
implementation blocks in pwm_apply_state() until the new setting is
active. So some signaling is nice.=20

> > > > If you change only cycle but not mode, does the hardware complete t=
he
> > > > currently running period?
> > >=20
> > > No it does not.
> >=20
> > Please document this as a Limitation.
>=20
> I've discussed this internally, for now its a limitation. In the worst
> case you'd do one 100% duty cycle. Maybe we can fix the hardware. I
> acknowledge that this is a severe limitation, esp. if you use the PWM
> for controlling stuff (for now its only LCD backlight.. so thats ok).

That happens if you reduce the duty cycle from A to B and the counter is
already bigger than B but smaller than A, right? The fix would be to
compare for counter >=3D match instead of counter =3D match. (Which then
would result in a period with a duty cycle bigger than B but smaller
than A. Also not ideal, but probably better.)

> > > > What about disable()?
> > >=20
> > > Mhh well, it would do one 100% cycle.. mhh ;) Lets see if there we can
> > > fix that (in hardware), not much we can do in the driver here. We are
> > > _very_ constraint in size, therefore all that little edge cases fall
> > > off
> > > the table.
> >=20
> > You're saying that on disable the hardware emits a constant high level
> > for one cycle? I hope not ...
>=20
> Mh, I was mistaken, disabling the PWM will turn it off immediately, but

And does turn off mean, the output gets inactive?
If so you might also disable the hardware if a 0% duty cycle is
configured assuming this saves some energy without modifying the
resulting wave form.

> one 100% duty cycle may happen if you change from a higher to a lower
> duty cycle setting. See above.
>=20
> > I never programmed a CPLD to emulate a hardware PWM, but I wonder if
> > these are really edge cases that increase the size of the binary?!
>=20
> At the moment there is only one 8bit register which stores the value
> which is used for matching. If you want to change that setting after
> a whole cycle, you'd use another 8bit register to cache the new value.
> So this would at least needs 8 additional flip-flops. This doesn't
> sound much, but we are already near 100% usage of the CPLD. So its
> hard to convince people why this is really necessary.

OK. (Maybe there is enough space to allow implementing 100% for mode 0?)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--43ja544hwta6zjxk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8PMIEACgkQwfwUeK3K
7AmkoQf/Xsa5eWznePZ+LGv5Ny4n0jnjIKQDxCWubAooelGqLEF0EsNjO6hA2ShJ
0/Bkwa4V22BFbXS2s4Ai4KcM6kEqxytEADlIAVvcfDxTq6aFqYrrNt+gYTLyFJvr
7WkzW1Jh1FZpqTQck7bUAyOd9VA9Y8aEwnqDnZbUrEctYnhylTz0ogj6RLw2EZqL
lT/EWHA461DnNoJ19v1QNBTolcDgOBMTZuk8bUBtYAJhf3Zf4m+YOYxTiOgNGOaQ
yKB5hXTsyURWKJhf0+0pDtWry6Dl2B6xCLa/rLbfkAMx00kaKGRCSd2o7bw+mCj5
71RVew6wqS5+tx2hi20V582pM4qAnA==
=G5tl
-----END PGP SIGNATURE-----

--43ja544hwta6zjxk--
