Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9259421D22B
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2020 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgGMIsD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jul 2020 04:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgGMIsC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jul 2020 04:48:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB58C061755
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jul 2020 01:48:02 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1juu7w-00049g-AP; Mon, 13 Jul 2020 10:47:56 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1juu7q-0002yC-Fw; Mon, 13 Jul 2020 10:47:50 +0200
Date:   Mon, 13 Jul 2020 10:47:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
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
Message-ID: <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
 <20200709085006.b54ype3p4yu64upl@pengutronix.de>
 <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kbnayqgol27lp4uu"
Content-Disposition: inline
In-Reply-To: <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--kbnayqgol27lp4uu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Michael,

On Sat, Jul 11, 2020 at 07:28:05PM +0200, Michael Walle wrote:
> Am 2020-07-09 10:50, schrieb Uwe Kleine-K=F6nig:
> > On Mon, Jul 06, 2020 at 07:53:47PM +0200, Michael Walle wrote:
> > > diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
> > > new file mode 100644
> > > index 000000000000..8ee286b605bf
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-sl28cpld.c
> > > @@ -0,0 +1,187 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * sl28cpld PWM driver
> > > + *
> > > + * Copyright 2020 Kontron Europe GmbH
> > > + */
> >=20
> > Is there publically available documenation available? If so please add a
> > link here.
>=20
> Unfortunately not. But it should be easy enough and I'll describe it
> briefly in the header.

That's fine.

> > > +#include <linux/bitfield.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +/*
> > > + * PWM timer block registers.
> > > + */
> > > +#define PWM_CTRL		0x00
> > > +#define   PWM_ENABLE		BIT(7)
> > > +#define   PWM_MODE_250HZ	0
> > > +#define   PWM_MODE_500HZ	1
> > > +#define   PWM_MODE_1KHZ		2
> > > +#define   PWM_MODE_2KHZ		3
> > > +#define   PWM_MODE_MASK		GENMASK(1, 0)
> > > +#define PWM_CYCLE		0x01
> > > +#define   PWM_CYCLE_MAX		0x7f
> >=20
> > Please use a less generic prefix for your defines. Also I like having
> > the defines for field names include register name. Something like:
> >=20
> > 	#define PWM_SL28CPLD_CTRL		0x00
> > 	#define PWM_SL28CPLD_CTRL_ENABLE		BIT(7)
> > 	#define PWM_SL28CPLD_CTRL_MODE_MASK		GENMASK(1, 0)
>=20
> Ok.
>=20
> > 	#define
> > PWM_SL28CPLD_CTRL_MODE_250HZ		FIELD_PREP(PWM_SL28CPLD_CTRL_MODE_MASK,
> > 0)
>=20
> Shouldn't we just "#define ..MODE_250HZ 1" use FIELD_PREP inside the code,
> so you can actually use the normalized enumeration values, too?

yeah, looks sane.

> Actually, I'll rename the PWM_MODE to PWM_PRESCALER, because that is
> more accurate.

Whatever suits you and is consistent is fine for me.

> > > +struct sl28cpld_pwm {
> > > +	struct pwm_chip pwm_chip;
> > > +	struct regmap *regmap;
> > > +	u32 offset;
> > > +};
> > > +
> > > +struct sl28cpld_pwm_periods {
> > > +	u8 ctrl;
> > > +	unsigned long duty_cycle;
> > > +};
> > > +
> > > +struct sl28cpld_pwm_config {
> > > +	unsigned long period_ns;
> > > +	u8 max_duty_cycle;
> > > +};
> > > +
> > > +static struct sl28cpld_pwm_config sl28cpld_pwm_config[] =3D {
> >=20
> > const ? (Or drop as the values can be easily computed, see below.)
> >=20
> > > +	[PWM_MODE_250HZ] =3D { .period_ns =3D 4000000, .max_duty_cycle =3D =
0x80 },
> > > +	[PWM_MODE_500HZ] =3D { .period_ns =3D 2000000, .max_duty_cycle =3D =
0x40 },
> > > +	[PWM_MODE_1KHZ]  =3D { .period_ns =3D 1000000, .max_duty_cycle =3D =
0x20 },
> > > +	[PWM_MODE_2KHZ]  =3D { .period_ns =3D  500000, .max_duty_cycle =3D =
0x10 },
> > > +};
> > > +
> > > +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
> > > +				   struct pwm_device *pwm,
> > > +				   struct pwm_state *state)
> > > +{
> > > +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> > > +	static struct sl28cpld_pwm_config *config;
> > > +	unsigned int reg;
> > > +	unsigned int mode;
> > > +
> > > +	regmap_read(priv->regmap, priv->offset + PWM_CTRL, &reg);
> > > +
> > > +	state->enabled =3D reg & PWM_ENABLE;
> >=20
> > Would it be more consisted to use FIELD_GET here, too?
>=20
> I had used FIELD_GET only for bit-fields with more than one bit,
> i.e. no flags. But that is just a matter of taste, I guess. I'd
> prefer to keep the simple "reg & PWM_ENABLE". If you insist on
> the FIELD_GET() I'll change it ;)

I think using FIELD_GET is more consistent, but I won't insist.

> > > +	mode =3D FIELD_GET(PWM_MODE_MASK, reg);
> > > +	config =3D &sl28cpld_pwm_config[mode];
> > > +	state->period =3D config->period_ns;
> >=20
> > I wonder if this could be done more effectively without the above table.
> > Something like:
> >=20
> > 	state->period =3D 4000000 >> mode.
>=20
> The reason I introduced a lookup table here was that I need a
> list of the supported modes; I wasn't aware of the rounding.

List of supported modes =3D [0, 1, 2, 3], isn't it?

> See also below.
>=20
> > (with a #define for 4000000 of course).
> >=20
> > > +	regmap_read(priv->regmap, priv->offset + PWM_CYCLE, &reg);
> > > +	pwm_set_relative_duty_cycle(state, reg, config->max_duty_cycle);
> >=20
> > Oh, what a creative idea to use pwm_set_relative_duty_cycle here.
>=20
> What is that helper for then? The former versions did the same
> calculations (i.e. DIV_ROUND_CLOSEST_ULL()) just open coded. But
> I guess then it was also rounding the wrong way.

Yes. In my book pwm_set_relative_duty_cycle is for consumers. And if
DIV_ROUND_CLOSEST_ULL is the right thing for them depends on their use
case.

> > Unfortunately it's using the wrong rounding strategy. Please enable
> > PWM_DEBUG which should diagnose these problems (given enough testing).
>=20
> Is there any written documentation on how to round, i.e. up or down?

There are the checks implemented for PWM_DEBUG. I started to work on the
documentation
(https://patchwork.ozlabs.org/project/linux-pwm/patch/20191209213233.29574-=
2-u.kleine-koenig@pengutronix.de/)
but didn't get feedback yet. (And the rounding rules are not included
there.)

> I had a look Documentation/driver-api/pwm.rst again. But couldn't find
> anything. A grep DIV_ROUND_CLOSEST_ULL() turns out that quite a few
> drivers use it, so I did the same ;)

Yes, the rounding requirement is new and many driver's are not
conforming (yet).

> > (Hmm, on second thought I'm not sure that rounding is relevant with the
> > numbers of this hardware. Still it's wrong in general and I don't want
> > to have others copy this.)
> >=20
> > > +}
> > > +
> > > +static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct
> > > pwm_device *pwm,
> > > +			      const struct pwm_state *state)
> > > +{
> > > +	struct sl28cpld_pwm *priv =3D dev_get_drvdata(chip->dev);
> > > +	struct sl28cpld_pwm_config *config;
> > > +	unsigned int cycle;
> > > +	int ret;
> > > +	int mode;
> > > +	u8 ctrl;
> > > +
> > > +	/* Get the configuration by comparing the period */
> > > +	for (mode =3D 0; mode < ARRAY_SIZE(sl28cpld_pwm_config); mode++) {
> > > +		config =3D &sl28cpld_pwm_config[mode];
> > > +		if (state->period =3D=3D config->period_ns)
> > > +			break;
> > > +	}
> > > +
> > > +	if (mode =3D=3D ARRAY_SIZE(sl28cpld_pwm_config))
> > > +		return -EINVAL;
> >=20
> > You're supposed to pick the biggest period that isn't bigger than the
> > requested period. So something like:
> >=20
> > 	switch(period) {
> > 	case 4000000 ... UINT_MAX:
> > 		mode =3D 0;
> > 		break;
> > 	case 2000000 ... 3999999:
> > 		mode =3D 1;
> > 		break;
> > 	...
> > 	}
> >=20
> > (or:
> >=20
> > 	if period >=3D 4000000:
> > 		mode =3D 0
> > 	else:
> > 		// I think ... please double-check
> > 		mode =3D ilog2(4000000 / (period + 1)) + 1
> >=20
> > 	if mode > 3:
> > 		return -ERANGE;
> > )
>=20
> I see. In this case I can of course drop the table. But the rounding
> will be then very coarse for this driver. And there is no way to get
> the value which is actually set, right? You can just read the cached
> value. So that value might be far off the actual one set in the
> hardware.

Yes, we once changed pwm_get_rate to return the actually implemented
setting, but this broke some stuff; see commit
40a6b9a00930fd6b59aa2eb6135abc2efe5440c3.

I already thought about proposing pwm_get_rate_hw(), but for now there
is (AFAICT) no user who would need it. And it's hard to know which
variant is actually preferred by consumers. My expectation is that most
don't even care.

I also have a pwm_round_rate() function in mind that will give you the
actual rate without applying it. This can then be used by consumers who
care. But also there is no user who would need it today.

> During testing I've also found the following problem: Assume we set
> a period of 5000000ns; this will be rounded to 4000000ns and written
> to the hardware. But the usable duty cycle is still 0..5000000ns. The
> driver will translate this input in the following manner:
>  - 0..4000000 -> 0%..100%
>  - >4000000 -> 100%
> Is this behavior intended?

It's expected.

> Even for PWM hardware which supports finer
> grained frequencies there will be some upper and lower limits. Is
> the user of the PWM supposed to know these?

There is nothing we can do on hardware imposed limits. In practise it
doesn't seem to matter. Also note that most consumers get a proposed
period length.

> > 	real_period =3D 4000000 >> mode;
> >=20
> > > +	ctrl =3D FIELD_PREP(PWM_MODE_MASK, mode);
> > > +	if (state->enabled)
> > > +		ctrl |=3D PWM_ENABLE;
> > > +
> > > +	cycle =3D pwm_get_relative_duty_cycle(state, config->max_duty_cycle=
);
> >=20
> > Again the rounding is wrong. You need need to round down the requested
> > duty_cycle to the next possible value. So something like:
> >=20
> > 	duty_cycle =3D min(real_period, state->duty_cycle);
> >=20
> > 	cycle =3D duty_cycle * (0x80 >> mode) / (4000000 >> mode);
> >=20
> > which can be further simplified to
> >=20
> > 	cycle =3D duty_cycle / 31250
>=20
> Mh, this made me think where that "magic" number is coming from. Turns
> out this is the NSECS_PE_SEC / base clock of the PWM.

It's a simplification of the line above, so it is 4000000 / 0x80. (But
it's not by chance this matches NSECS_PER_SEC / base clock of course.)

> I guess I'll rework the get_state() and apply() to just use this
> base frequency, dropping the table etc.
>=20
> Btw what about the polarity. Do I have to support it or can I
> return an error code if its !=3D PWM_POLARITY_NORMAL? If so, which
> error code? EINVAL?

=2E.ooOO(Did I really miss that during review? Bummer)

If your hardware only support normal polarity, only implement this and
return -EINVAL for inverted polarity requests.

> I know I could just invert the duty cycle in
> software, but shouldn't this be done in the core for any controller
> which doesn't support changing the polarity in hardware?

Please don't. This should indeed be done at the framework level. (But
I'm not convinced doing this unconditionally is a good idea.)

> > > +	/*
> > > +	 * The hardware doesn't allow to set max_duty_cycle if the
> > > +	 * 250Hz mode is enabled, thus we have to trap that here.
> > > +	 * But because a 100% duty cycle is equal on all modes, i.e.
> >=20
> > It depends on how picky you are if you can agree here.
>=20
> why is that? The only drawback is that the mode is changed without
> the user seeing it.

Ideally periods are completed before they change. So if a user requests
=2Eperiod =3D .duty_cycle =3D 100ms with having the PWM disabled before and
afterwards, the expectation is that it is active for (an integer
multiple of) 100 ms. But honestly there are not many hardware
implementation + driver combos that get this right.

> But the PWM subsystem returns the cached state,
> right? get_state() is called only on device request (and during
> debug it seems). Actually, enabling PWM_DEBUG might choke on this
> workaround (".apply didn't pick the best available period"). Is
> this ok?

hmm, I didn't consider this when writing the checks for PWM_DEBUG.
According to the currently checked rules the expected configuration is
to pick the 250Hz mode and use cycle =3D 0x7f. Hmm, I have to think about
this. Maybe we should weaken the check to the cases with
0 < duty_cycle < period. Thierry, what do you think?

Special casing 0% and 100% is annoying, but insisting 250Hz + 0x7f seems
to be far from reality. (Is it?)=20

> > > +	ret =3D regmap_write(priv->regmap, priv->offset + PWM_CTRL, ctrl);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return regmap_write(priv->regmap, priv->offset + PWM_CYCLE,
> > > (u8)cycle);
> >=20
> > I assume this can result in broken output? Consider the hardware runs
> > with mode =3D 1 & cycle =3D 0x23 and you want to go to mode =3D 0 & cyc=
le =3D
> > 0x42: Can this result in a period that has mode =3D 0 & cycle =3D 0x23?
>=20
> Isn't that always the case if a write may fail and there are more than
> one register to configure?

Depending on hardware capabilities you might not be able to prevent
this yes. Unfortunately this is quite common.

But there are hardware implementations that are not prone to such
failures. (E.g. the registers written can be only shadow values that are
latched into hardware only when the last value is written.)

> For example, have a look at pwm-iqs620a.c.
> Btw. the get_state might also fail, but there is no return value to
> return the error.

Yes, changing this is on my todo list.

> > If this cannot be avoided, please document this in the Limitations
> > paragraph.
>=20
> Sure. There might be (or most likely are) gliches when you change the
> mode.

If you change only cycle but not mode, does the hardware complete the
currently running period? What about disable()?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kbnayqgol27lp4uu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8MH7MACgkQwfwUeK3K
7AmS/wgAgHtz0usxb1L3V3EzTvq2Es3IDi4siQeD/8CLuqVRsqsIERfdSp8yrehG
nvdw5AWxPCQbnMPqdw3l/jIpTYJBMXGkkq6ISgoP5l3oJgcTUXV2A88J8jLbxYpQ
v7NrAqFHXELiZDD3fy4INiUmItloGTnpYWlZ0Bdjjvom9ZBUlUF+KDV0n+HWdyJ6
+GZIHtcifIDydf2Bd5lpUMVdyw6y1gm/WC3sXbRjIetzRKe7QNLUVffWH9uXtWI1
/gU0+/i77tZrrr/xNUFnhA86kJtRzdg64ek+x/DL90QNhI3/AvEeVhmcj3/ZFl9K
OP7/l4770EssKbeTeU7MojZVu8YqRQ==
=UAV3
-----END PGP SIGNATURE-----

--kbnayqgol27lp4uu--
