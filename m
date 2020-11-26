Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455DA2C5E16
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Nov 2020 00:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388519AbgKZXUv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 26 Nov 2020 18:20:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:46377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388513AbgKZXUv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 26 Nov 2020 18:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606432783;
        bh=aahldzhXYRM/u5SxDDCGJhhv6lvuCoEtZATJFGAyWa0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EuJHSWL4ApzfPaymwZvTarishmG9H1b7hYjQF7iJMnHBIPYgyPkr8FqFJgQR7uW0U
         u22oI52vQDAg+28teYGzisUIo0bJIo3EHn2An4bkZ38PMmydaujv21Yq1EeSZMP3kB
         360RxXucWKVGcwvfJFv7llPf2UPOEWduSmaUZ2i0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KTy-1k19fZ1nk2-010PUi; Fri, 27
 Nov 2020 00:19:43 +0100
Date:   Fri, 27 Nov 2020 00:19:31 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20201126231931.GE456020@latitude>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-5-j.neuschaefer@gmx.net>
 <20201124082019.vpkr3xnp55arjpnp@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
In-Reply-To: <20201124082019.vpkr3xnp55arjpnp@pengutronix.de>
X-Provags-ID: V03:K1:7uuNql546Xcj+FmeEawv7Fy/oxIA22FnVQTJX/dZFCPZxk8tmL+
 tGUHxeL1WfXWPkE76uUF/GXjYCqrO9fQzkKzVsVmE1RUyWrG5AdsTFr1aO0v0StGSDsvgXg
 QgxO0Ig8aF2C1jYzwyePIcHGxc9jS07wrmJvrl2AAasxjRvZ/wVRjfVCXD00pNq9Ip9iXJR
 lJ/peJ2ZFLa0GZu9UYuiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2JV/9Ub+Jh8=:h/PPorApj6PW3vMSVe+n/n
 VzzVCiwZ6oVAW8bRi644c2sGQ/LTg3Ek8BuHQyjixFZVSqI9kCMqJc15EMCr8G6ubBChCn3vr
 sjhHyAgIz1RDH1gCxqDiwPpwQFNjfddVHvVH9lDGJGnkbK9W7p6/69QCENQyguFHTiZN5sQkn
 l3mTvHg/U4o7/EqvWHL0Bnws4/wDfa69a7fLRxceyo1ZiJyOFhMsJ8HvHv0puCvjMXx1lbmfa
 2SMnFOS2a3yWumHN0Y/8FXrQcn7PtirjsjMmmjhBWz0Z3fSxzdtGDDXUQke3WIrGl/mxrshHI
 AG5M0uzf4XTu+FpR3wVs04gy1q10rI2HyCLR5Ej9LxGqklHcwTseUpyNrUSeGlU807ep8d8OC
 ZjaMBRRTKas9ezf9+BNk9bYzOJ4SxwzRBw64E3vK/f61xrJaGr/g38IA7zNNEBU1eIaLfJ8PO
 aqacRWD2cfcGsuqKY0icMQ0aKQ6OHqYuneCMacrE6r25QNag9tUZfU7l2fZHDUEEISJJ7uY5q
 ++0vZGmG1q/MaxkkQToeo/Um5IUvp7OdtKFNym0zFh21mhTBYfxTeJiOzuGjnZKc7o7oVq7Rl
 PoXXYiI/i3N48gwMOYciufhadZb56x4E8Aku/jkHXGKlEU773ewO6e9W63VKLd+/T71fdg/01
 jAw3HKhWLZwnis09OayrlbqSg+JRco51yWPOdN+SlPwjnzrcWpNPq43LGGurSOfHspdQrMuR2
 fbu6KzW/eBVKMkNRaKQPHovpyBzZcFcJysUH9o67DG3aeBxNJajbjmvnItjRTv0q53mbySpYI
 F7h4eTs5HQWDNt9DNUB9y7KwXnPxM1fuLHCoKfAmtS602nNd8OKD95BAKtRqezV/hsG4jsbe7
 QL6FXys40HWHSsa3N9QQ==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 09:20:19AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Sun, Nov 22, 2020 at 11:27:36PM +0100, Jonathan Neusch=C3=A4fer wrote:
[...]
> > +/*
> > + * The time base used in the EC is 8MHz, or 125ns. Period and duty cyc=
le are
> > + * measured in this unit.
> > + */
> > +#define TIME_BASE_NS 125
> > +
> > +/*
> > + * The maximum input value (in nanoseconds) is determined by the time =
base and
> > + * the range of the hardware registers that hold the converted value.
> > + * It fits into 32 bits, so we can do our calculations in 32 bits as w=
ell.
> > + */
> > +#define MAX_PERIOD_NS (TIME_BASE_NS * 0xffff)
> > +
> > +static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm_dev,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct ntxec_pwm *priv =3D pwmchip_to_priv(pwm_dev->chip);
> > +	unsigned int duty =3D state->duty_cycle;
> > +	unsigned int period =3D state->period;
>=20
> state->duty_cycle and state->period are u64, so you're losing
> information here. Consider state->duty_cycle =3D 0x100000001 and
> state->period =3D 0x200000001.

Oh, good point, I didn't notice the truncation.

The reason I picked unsigned int was to avoid a 64-bit division;
I suppose I can do something like this:

    period =3D (u32)period / TIME_BASE_NS;
    duty =3D (u32)duty / TIME_BASE_NS;

> > +	int res =3D 0;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	if (period > MAX_PERIOD_NS) {
> > +		period =3D MAX_PERIOD_NS;
> > +
> > +		if (duty > period)
> > +			duty =3D period;
> > +	}
> > +
> > +	period /=3D TIME_BASE_NS;
> > +	duty /=3D TIME_BASE_NS;
> > +
> > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_HIGH, ntxec_r=
eg8(period >> 8));
> > +	if (res)
> > +		return res;
>=20
> I wonder if you can add some logic to the regmap in the mfd driver such
> that ntxec_reg8 isn't necessary for all users.

I think that would involve:

1. adding custom register access functions to the regmap, which decide
   based on the register number whether a register needs 8-bit or 16-bit
   access. So far I have avoided information about registers into the
   main driver, when the registers are only used in the sub-drivers.

or

2. switching the regmap configuration to little endian, which would be
   advantageous for 8-bit registers, inconsequential for 16-bit
   registers that consist of independent high and low halves, and wrong
   for the 16-bit registers 0x41, which reads the battery voltage ADC
   value. It is also different from how the vendor kernel treats 16-bit
   registers.

Perhaps there is another option that I haven't considered yet.

>=20
> > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_LOW, ntxec_re=
g8(period));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_HIGH, ntxec_reg=
8(duty >> 8));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_LOW, ntxec_reg8=
(duty));
> > +	if (res)
> > +		return res;
>=20
> I think I already asked, but I don't remember the reply: What happens to
> the output between these writes? A comment here about this would be
> suitable.

I will add something like the following:

/*
 * Changes to the period and duty cycle take effect as soon as the
 * corresponding low byte is written, so the hardware may be configured
 * to an inconsistent state after the period is written and before the
 * duty cycle is fully written. If, in such a case, the old duty cycle
 * is longer than the new period, the EC will output 100% for a moment.
 */

>=20
> > +
> > +	/*
> > +	 * Writing a duty cycle of zero puts the device into a state where
> > +	 * writing a higher duty cycle doesn't result in the brightness that =
it
> > +	 * usually results in. This can be fixed by cycling the ENABLE regist=
er.
> > +	 *
> > +	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
> > +	 */
> > +	if (state->enabled && duty !=3D 0) {
> > +		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(=
1));
> > +		if (res)
> > +			return res;
> > +
> > +		/* Disable the auto-off timer */
> > +		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_=
reg8(0xff));
> > +		if (res)
> > +			return res;
> > +
> > +		return regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_r=
eg8(0xff));
> > +	} else {
> > +		return regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0=
));
> > +	}
> > +}
> > +
> > +static struct pwm_ops ntxec_pwm_ops =3D {
>=20
> This can be const.

Indeed, I'll change it.

> > +	.apply =3D ntxec_pwm_apply,
>=20
> /*
>  * The current state cannot be read out, so there is no .get_state
>  * callback.
>  */
>=20
> Hmm, at least you could provice a .get_state() callback that reports the
> setting that was actually implemented for in the last call to .apply()?

Yes... I see two options:

1. Caching the state in the driver's private struct. I'm not completely
   convinced of the value, given that the information is mostly
   available in the PWM core already (except for the adjustments that
   the driver makes).

2. Writing the adjusted state back into pwm_dev->state (via pwm_set_*).
   This seems a bit dirty.

> @Thierry: Do you have concerns here? Actually it would be more effective
> to have a callback (like .apply()) that modfies its pwm_state
> accordingly. (Some drivers did that in the past, but I changed that to
> get an uniform behaviour in 71523d1812aca61e32e742e87ec064e3d8c615e1.)
> The downside is that people have to understand that concept to properly
> use it. I'm torn about the right approach.

General guidance for such cases when the state can't be read back from
the hardware would be appreciated.


Thanks,
Jonathan Neusch=C3=A4fer

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl/AN/QACgkQCDBEmo7z
X9soyg/+Pla45ai7+kPvin4dWvIl1bD+Jhj1hthtr+7jq/aVPYDTE2OT2bSD9WZt
z4AZvfsNfWvulm90Okuer4jru4bLudbEIcMeAJa7J0S+m1uCFOrtDr+hk6BF3bb3
y7IJQpLxfbf476cwss7i+QmG+jupHo6LJeQWi9N3bJ3kh6uoqSyZr6rw3eg2Vvnv
I/2yW3B4yrKS/6Sx5n6VtpFRhSHZ9TwaOnHqXcAAHYAGsuoTM7iOkWXRWoE6zk9a
cfuxxdERLspDlrEjNFs8MsNDjRhXLDwYyJzyHFdcu8QVpEWzBEVUfWxV8MQ2N/Qb
P2knWpdreU/zOax3n/Q8lUDHNolc6UK5A/Ny5KGX/JXpMCRCWPsRt2qKIiFTVAmD
jjP0rMEVSWInIaQUFSpBcVet4dw9RiSXX6266eeVZ51NzBi0BlGfIf+e+/GSvQ/v
t1Qfyu2pMJO655dcytuo9Bp9oMTMe7iwpd/Sv2klG2/n7qfWHmSmwzMMh0NLeeOR
GdAETDxXS4Zb5eHrwuRS7TPSpAI7lDkZu7NiA9DRqGF4tmwEwPFE+w4wO9Z/frgp
njYCZqqyvcFcPkrJSoQYUIs3SP7pVEeAZVPsIwRY1F9zjpgu2StA9gcnS3CVMAYh
seTEQcD1eSz5C3x8PDaLE+UgAapgdEZbXoBA5HEtssw58abKFrc=
=QwrY
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
