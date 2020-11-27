Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5782C605D
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Nov 2020 08:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389690AbgK0HLt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Nov 2020 02:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730898AbgK0HLt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Nov 2020 02:11:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70580C0613D1
        for <linux-pwm@vger.kernel.org>; Thu, 26 Nov 2020 23:11:49 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kiXuY-0004j1-Sa; Fri, 27 Nov 2020 08:11:18 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kiXuO-0005V3-4E; Fri, 27 Nov 2020 08:11:08 +0100
Date:   Fri, 27 Nov 2020 08:11:05 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>
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
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20201127071105.k2rb4iykeqevbao5@pengutronix.de>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-5-j.neuschaefer@gmx.net>
 <20201124082019.vpkr3xnp55arjpnp@pengutronix.de>
 <20201126231931.GE456020@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bhqij5tyy3v6pwu3"
Content-Disposition: inline
In-Reply-To: <20201126231931.GE456020@latitude>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bhqij5tyy3v6pwu3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Fri, Nov 27, 2020 at 12:19:31AM +0100, Jonathan Neusch=E4fer wrote:
> On Tue, Nov 24, 2020 at 09:20:19AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sun, Nov 22, 2020 at 11:27:36PM +0100, Jonathan Neusch=E4fer wrote:
> [...]
> > > +/*
> > > + * The time base used in the EC is 8MHz, or 125ns. Period and duty c=
ycle are
> > > + * measured in this unit.
> > > + */
> > > +#define TIME_BASE_NS 125
> > > +
> > > +/*
> > > + * The maximum input value (in nanoseconds) is determined by the tim=
e base and
> > > + * the range of the hardware registers that hold the converted value.
> > > + * It fits into 32 bits, so we can do our calculations in 32 bits as=
 well.
> > > + */
> > > +#define MAX_PERIOD_NS (TIME_BASE_NS * 0xffff)
> > > +
> > > +static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm_dev,
> > > +			   const struct pwm_state *state)
> > > +{
> > > +	struct ntxec_pwm *priv =3D pwmchip_to_priv(pwm_dev->chip);
> > > +	unsigned int duty =3D state->duty_cycle;
> > > +	unsigned int period =3D state->period;
> >=20
> > state->duty_cycle and state->period are u64, so you're losing
> > information here. Consider state->duty_cycle =3D 0x100000001 and
> > state->period =3D 0x200000001.
>=20
> Oh, good point, I didn't notice the truncation.
>=20
> The reason I picked unsigned int was to avoid a 64-bit division;
> I suppose I can do something like this:
>=20
>     period =3D (u32)period / TIME_BASE_NS;
>     duty =3D (u32)duty / TIME_BASE_NS;

You can do that after you checked period > MAX_PERIOD_NS below, yes.
Something like:

	if (state->polarity !=3D PWM_POLARITY_NORMAL)
		return -EINVAL;

	if (state->period > MAX_PERIOD_NS) {
		period =3D MAX_PERIOD_NS;
	else
		period =3D state->period;

	if (state->duty_cycle > period)
		duty_cycle =3D period;
	else
		duty_cycle =3D state->duty_cycle;

should work with even keeping the local variables as unsigned int.

> > > +	int res =3D 0;
> > > +
> > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +		return -EINVAL;
> > > +
> > > +	if (period > MAX_PERIOD_NS) {
> > > +		period =3D MAX_PERIOD_NS;
> > > +
> > > +		if (duty > period)
> > > +			duty =3D period;
> > > +	}
> > > +
> > > +	period /=3D TIME_BASE_NS;
> > > +	duty /=3D TIME_BASE_NS;
> > > +
> > > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_HIGH, ntxec=
_reg8(period >> 8));
> > > +	if (res)
> > > +		return res;
> >=20
> > I wonder if you can add some logic to the regmap in the mfd driver such
> > that ntxec_reg8 isn't necessary for all users.
>=20
> I think that would involve:
>=20
> 1. adding custom register access functions to the regmap, which decide
>    based on the register number whether a register needs 8-bit or 16-bit
>    access. So far I have avoided information about registers into the
>    main driver, when the registers are only used in the sub-drivers.
>=20
> or
>=20
> 2. switching the regmap configuration to little endian, which would be
>    advantageous for 8-bit registers, inconsequential for 16-bit
>    registers that consist of independent high and low halves, and wrong
>    for the 16-bit registers 0x41, which reads the battery voltage ADC
>    value. It is also different from how the vendor kernel treats 16-bit
>    registers.
>=20
> Perhaps there is another option that I haven't considered yet.

I don't know enough about regmap to teach you something here. But maybe
Mark has an idea. (I promoted him from Cc: to To:, maybe he will
notice.)

> > > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_LOW, ntxec_=
reg8(period));
> > > +	if (res)
> > > +		return res;
> > > +
> > > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_HIGH, ntxec_r=
eg8(duty >> 8));
> > > +	if (res)
> > > +		return res;
> > > +
> > > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_LOW, ntxec_re=
g8(duty));
> > > +	if (res)
> > > +		return res;
> >=20
> > I think I already asked, but I don't remember the reply: What happens to
> > the output between these writes? A comment here about this would be
> > suitable.
>=20
> I will add something like the following:
>=20
> /*
>  * Changes to the period and duty cycle take effect as soon as the
>  * corresponding low byte is written, so the hardware may be configured
>  * to an inconsistent state after the period is written and before the
>  * duty cycle is fully written. If, in such a case, the old duty cycle
>  * is longer than the new period, the EC will output 100% for a moment.
>  */

Is the value pair taken over by hardware atomically? That is, is it
really "will" in your last line, or only "might". (E.g. when changing
=66rom duty_cycle, period =3D 1000, 2000 to 500, 800 and a new cycle begins
after reducing period, the new duty_cycle is probably written before the
counter reaches 500. Do we get a 100% cycle here?)

Other than that the info is fine. Make sure to point this out in the
Limitations paragraph at the top of the driver please, too.

> > > +	.apply =3D ntxec_pwm_apply,
> >=20
> > /*
> >  * The current state cannot be read out, so there is no .get_state
> >  * callback.
> >  */
> >=20
> > Hmm, at least you could provice a .get_state() callback that reports the
> > setting that was actually implemented for in the last call to .apply()?
>=20
> Yes... I see two options:
>=20
> 1. Caching the state in the driver's private struct. I'm not completely
>    convinced of the value, given that the information is mostly
>    available in the PWM core already (except for the adjustments that
>    the driver makes).
>=20
> 2. Writing the adjusted state back into pwm_dev->state (via pwm_set_*).
>    This seems a bit dirty.

2. isn't a good option. Maybe regmap caches this stuff anyhow for 1. (or
can be made doing that)?

> > @Thierry: Do you have concerns here? Actually it would be more effective
> > to have a callback (like .apply()) that modfies its pwm_state
> > accordingly. (Some drivers did that in the past, but I changed that to
> > get an uniform behaviour in 71523d1812aca61e32e742e87ec064e3d8c615e1.)
> > The downside is that people have to understand that concept to properly
> > use it. I'm torn about the right approach.
>=20
> General guidance for such cases when the state can't be read back from
> the hardware would be appreciated.

Yes, improving the documentation would be great here. Thierry, can you
please comment on
https://lore.kernel.org/r/20191209213233.29574-2-u.kleine-koenig@pengutroni=
x.de
which I'm waiting on before describing our understanding in more detail.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bhqij5tyy3v6pwu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/ApoYACgkQwfwUeK3K
7AmYZwf+J6US2IXSfdNf13pfIzPBZoONExW3QTW85bUyBa5LTWseYRyLRl6p1NvF
Q6o4UqfQOhnvYRtKutHpB2Lg8CxGkDaCzEpR8+1bWik9jkS4BT0OVNws/iPofW4I
6iYvVJSCmaYBPCTlk9Lt1Qbs/mPfofAkrm6XhSbjE4EgzIFvJcNDXSJxTkb9S2K/
Cu5sjcDwIRCKTuMQIp6oOs9z/IM+B8k6lH5QWTQOXynsCUY+jGi4GdS3+x4OEseh
wcDswihbhdbUIM+G0Em96PyNavGWL/0/F8QvQowmrb8jdgFEN70o+KOt4P+TEIxo
4ypy4rH9S1pc6C+6/R4TNw+WT47oag==
=oulu
-----END PGP SIGNATURE-----

--bhqij5tyy3v6pwu3--
