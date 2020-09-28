Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A458727A9A7
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgI1IgY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1IgW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 04:36:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30FC0613CF
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 01:36:21 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kModa-000084-2t; Mon, 28 Sep 2020 10:35:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kModO-0005Wh-8W; Mon, 28 Sep 2020 10:35:46 +0200
Date:   Mon, 28 Sep 2020 10:35:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20200928083546.gwu7ucx7os5yc5bn@pengutronix.de>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-5-j.neuschaefer@gmx.net>
 <20200925063037.fcrmqvpe5noi3ef4@pengutronix.de>
 <20200927211044.GC2510@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ydya4zilwk3y3dfw"
Content-Disposition: inline
In-Reply-To: <20200927211044.GC2510@latitude>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ydya4zilwk3y3dfw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sun, Sep 27, 2020 at 11:10:44PM +0200, Jonathan Neusch=E4fer wrote:
> On Fri, Sep 25, 2020 at 08:30:37AM +0200, Uwe Kleine-K=F6nig wrote:
> > > +	if (period > MAX_PERIOD_NS) {
> > > +		dev_warn(pwm->dev,
> > > +			 "Period is not representable in 16 bits after division by %u: %u=
\n",
> > > +			 TIME_BASE_NS, period);
> >=20
> > No error messages in .apply() please; this might spam the kernel log.
> >
> > Also the expectation when a too big period is requested is to configure
> > for the biggest possible period. So just do:
> >=20
> > 	if (period > MAX_PERIOD_NS) {
> > 		period =3D MAX_PERIOD_NS;
> >=20
> > 		if (duty > period)
> > 			duty =3D period;
> > 	}
> >=20
> > (or something equivalent).
>=20
> Okay, I'll adjust it.
>=20
> > > +	/*
> > > +	 * Writing a duty cycle of zone puts the device into a state where
> >=20
> > What is "zone"? A mixture of zero and one and so approximately 0.5?
>=20
> Oops, that's a typo. I just meant "zero".
>=20
> > > +	 * writing a higher duty cycle doesn't result in the brightness tha=
t it
> > > +	 * usually results in. This can be fixed by cycling the ENABLE regi=
ster.
> > > +	 *
> > > +	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
> > > +	 */
> > > +	if (state->enabled && duty !=3D 0) {
> > > +		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8=
(1));
> > > +		if (res)
> > > +			return res;
> > > +
> > > +		/* Disable the auto-off timer */
> > > +		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec=
_reg8(0xff));
> > > +		if (res)
> > > +			return res;
> > > +
> > > +		return regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_=
reg8(0xff));
> > > +	} else {
> > > +		return regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(=
0));
> > > +	}
> >=20
> > This code is wrong for state->enabled =3D false.
>=20
> Why?

Hm, I wonder the same. Probably I just misunderstood the code, sorry :-\

> > How does the PWM behave when .apply is called? Does it complete the
> > currently running period? Can it happen that when you switch from say
> >=20
> > 	.duty_cycle =3D 900 * TIME_BASE_NS (0x384)
> > 	.period =3D 1800 * TIME_BASE_NS (0x708)
> >=20
> > to
> >=20
> > 	.duty_cycle =3D 300 * TIME_BASE_NS (0x12c)
> > 	.period =3D 600 * TIME_BASE_NS (0x258)
> >=20
> > that a period with
> >=20
> > 	.duty_cycle =3D 388 * TIME_BASE_NS (0x184)
> > 	.period =3D 1800 * TIME_BASE_NS (0x708)
> > =09
> > (because only NTXEC_REG_PERIOD_HIGH was written when the new period
> > started) or something similar is emitted?
>=20
> Changes take effect after the low byte is written, so a result like 0x184
> in the above example should not happen.
>=20
> When the period and duty cycle are both changed, it temporarily results
> in an inconsistent state:
>=20
>  - period =3D 1800ns, duty cycle =3D 900ns
>  - period =3D  600ns, duty cycle =3D 900ns (!)
>  - period =3D  600ns, duty cycle =3D 300ns

Does this always happen, or only if a new cycle starts at an unlucky
moment?

> The inconsistent state of duty cycle > period is handled gracefully by
> the EC and it outputs a 100% duty cycle, as far as I can tell.

OK.

> I currently don't have a logic analyzer / oscilloscope to measure
> whether we get full PWM periods, or some kind of glitch when the new
> period starts in the middle of the last one.

You can even check this with an LED using something like:

	pwm_apply(mypwm, {.enabled =3D true, .duty_cycle =3D $big, .period =3D $bi=
g});
	pwm_apply(mypwm, {.enabled =3D false, ... });

=2E If the period is completed the LED is on for $big ns, if not the LED
is on for a timespan that is probably hardly noticable with the human
eye.

> > > +}
> > > +
> > > +static struct pwm_ops ntxec_pwm_ops =3D {
> > > +	.apply =3D ntxec_pwm_apply,
> >=20
> > Please implement a .get_state() callback. And enable PWM_DEBUG during
> > your tests.
>=20
> The device doesn't support reading back the PWM state. What should a
> driver do in this case?

Document it as a limitation, please.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ydya4zilwk3y3dfw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9xoF8ACgkQwfwUeK3K
7Am4PAf/d6jJ0rLJJBKslZzKA1ulRj6vzQKAWN3OQRe0DAiKrHOk9rREZywu8qab
ij5usrKGU9lnrCsUDqOskvJW8F9zTfl9R9stEmw6yFvXsx/PbcsJ7u5zQtdTwlgu
o5VSEJr9Ym/lRzeptOLVUnrO0s4DmLQEkf9Xe/9buxLDg97sFVeyurLLiHyblf7M
YzROKhF66NGleiw41Xe0NNeM3iEPwV8FoDUYYQSWiwG9B3ENVGEpp2jnvPArUC1x
E90X9u6xKIk2bxbmcE8pd+bDtdWpuL1DIyI4NjyePdN1JHcGsyJwNsg4dcY1uV8e
h+t4gHpfpZPaA+us9ukQsDxpX0iUxA==
=xFyB
-----END PGP SIGNATURE-----

--ydya4zilwk3y3dfw--
