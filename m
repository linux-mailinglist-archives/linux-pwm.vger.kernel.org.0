Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE57221F6C5
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2020 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGNQJE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Jul 2020 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgGNQJD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jul 2020 12:09:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891E0C061755
        for <linux-pwm@vger.kernel.org>; Tue, 14 Jul 2020 09:09:03 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvNUI-0006MO-Nr; Tue, 14 Jul 2020 18:08:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jvNUG-00029L-H1; Tue, 14 Jul 2020 18:08:56 +0200
Date:   Tue, 14 Jul 2020 18:08:56 +0200
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
Message-ID: <20200714160856.rjqi7lv63geil3hm@pengutronix.de>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
 <20200709085006.b54ype3p4yu64upl@pengutronix.de>
 <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
 <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
 <c0594c34c712ce26b3936d42c92d2361@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ochzazkc36dtv4os"
Content-Disposition: inline
In-Reply-To: <c0594c34c712ce26b3936d42c92d2361@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ochzazkc36dtv4os
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Tue, Jul 14, 2020 at 01:31:13PM +0200, Michael Walle wrote:
> Am 2020-07-13 10:47, schrieb Uwe Kleine-K=F6nig:
> > I already thought about proposing pwm_get_rate_hw(), but for now there
> > is (AFAICT) no user who would need it. And it's hard to know which
> > variant is actually preferred by consumers. My expectation is that most
> > don't even care.
> >=20
> > I also have a pwm_round_rate() function in mind that will give you the
> > actual rate without applying it. This can then be used by consumers who
> > care. But also there is no user who would need it today.
>=20
> Ok. I take it that all such improvements are still in the making ;)

If you have a real use case, present it, then I give it a boost on my
todo list.

> > > But the PWM subsystem returns the cached state,
> > > right? get_state() is called only on device request (and during
> > > debug it seems). Actually, enabling PWM_DEBUG might choke on this
> > > workaround (".apply didn't pick the best available period"). Is
> > > this ok?
> >=20
> > hmm, I didn't consider this when writing the checks for PWM_DEBUG.
> > According to the currently checked rules the expected configuration is
> > to pick the 250Hz mode and use cycle =3D 0x7f.
>=20
> Not to use 0x80, which is the max_duty_cycle? Like its 0x40 for the 500Hz
> mode.

No, when I thought about a sane set of rules (and so checks for
PWM_DEBUG) I didn't consider a PWM that can implement 100% but not for
all otherwise available period lengths. I'm still amazed sometimes how
different the capabilities of different implementations for something so
seemingly easy like a PWM are.

> > Hmm, I have to think about
> > this. Maybe we should weaken the check to the cases with
> > 0 < duty_cycle < period. Thierry, what do you think?
> >=20
> > Special casing 0% and 100% is annoying, but insisting 250Hz + 0x7f seems
> > to be far from reality. (Is it?)
>=20
> If you mean by insisting to clip at 0x7f, yeah thats bad IMHO, because
> the user wants an all-high line, but in the end it would be a toggling
> line. It wouldn't be that bad for anything in between 0% and 100% but
> IMHO its bad for exactly 0% and 100%.
>=20
> You could also ask the driver about known quirks, like special 0% and
> 100% handling and exclude it from the tests accordingly.

Do you care enough to propose a patch? You're in the situation to test
it.

> > > > > +	ret =3D regmap_write(priv->regmap, priv->offset + PWM_CTRL, ctr=
l);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	return regmap_write(priv->regmap, priv->offset + PWM_CYCLE,
> > > > > (u8)cycle);
> > > >
> > > > I assume this can result in broken output? Consider the hardware ru=
ns
> > > > with mode =3D 1 & cycle =3D 0x23 and you want to go to mode =3D 0 &=
 cycle =3D
> > > > 0x42: Can this result in a period that has mode =3D 0 & cycle =3D 0=
x23?
> > >=20
> > > Isn't that always the case if a write may fail and there are more than
> > > one register to configure?
> >=20
> > Depending on hardware capabilities you might not be able to prevent
> > this yes. Unfortunately this is quite common.
> >=20
> > But there are hardware implementations that are not prone to such
> > failures. (E.g. the registers written can be only shadow values that are
> > latched into hardware only when the last value is written.)
>=20
> Maybe this could be improved in the future.

We should somewhere describe, what an ideal PWM can do.=20
My wishlist (just as it comes to my mind, so no guarantee of
completeness):

 - can do 0% duty cycle for all supported period lengths
 - can do 100% duty cycle for all supported period lengths
 - supports both polarities
 - supports immediate change of configuration and after completion of
   the currently running period
 - atomic update (i.e. if you go from configuration A to configuration B
   the hardware guarantees to only emit periods of type A and then type
   B. (Depending on the item above, the last A period might be cut off.)
 - emits an irq when configuration changes

> > If you change only cycle but not mode, does the hardware complete the
> > currently running period?
>=20
> No it does not.

Please document this as a Limitation.
=20
> > What about disable()?
>=20
> Mhh well, it would do one 100% cycle.. mhh ;) Lets see if there we can
> fix that (in hardware), not much we can do in the driver here. We are
> _very_ constraint in size, therefore all that little edge cases fall off
> the table.

You're saying that on disable the hardware emits a constant high level
for one cycle? I hope not ...

I never programmed a CPLD to emulate a hardware PWM, but I wonder if
these are really edge cases that increase the size of the binary?!

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ochzazkc36dtv4os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8N2JUACgkQwfwUeK3K
7AkhFQf/QeUghp0itjnebSKuCcU1Du1FgZx19oml+qdZdrWg9phaEQGAQxXc7m+N
HoMLWaZLv3O8L5DS4hpYKyj+hK1w7pN1qjuRbkevrgYUlDcU/NYeA+3UUfB7TAMz
N7muhIaeivH8Z4gJfLtnFtosfOHt3sqZTEYeX5frrCTHro4f7ecgwqkbtAv9MO+M
Ct382nabV/hgbpuyAya4PbeHtpJXqRVB4fgXFim8n86jJVZcqLgm+Cjk+NG3BABF
+gaDplLA8kTNTKJnKUxpMbKpsR4YBz6hqmP/YlhmWHweIwDy6HXMQyOkrnH0LINz
4YQ4iZLwcCQt6CY4bEP1h+aiZJjm+g==
=A67j
-----END PGP SIGNATURE-----

--ochzazkc36dtv4os--
