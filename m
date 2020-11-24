Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A532C1FC2
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Nov 2020 09:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgKXIUo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Nov 2020 03:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgKXIUl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Nov 2020 03:20:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2DC0613CF
        for <linux-pwm@vger.kernel.org>; Tue, 24 Nov 2020 00:20:40 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khTYr-0004Ny-FW; Tue, 24 Nov 2020 09:20:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khTYj-0004BH-0Y; Tue, 24 Nov 2020 09:20:21 +0100
Date:   Tue, 24 Nov 2020 09:20:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <20201124082019.vpkr3xnp55arjpnp@pengutronix.de>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n7psjkl5oqhse6nm"
Content-Disposition: inline
In-Reply-To: <20201122222739.1455132-5-j.neuschaefer@gmx.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--n7psjkl5oqhse6nm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Nov 22, 2020 at 11:27:36PM +0100, Jonathan Neusch=E4fer wrote:
> The Netronix EC provides a PWM output which is used for the backlight
> on some ebook readers. This patches adds a driver for the PWM output.
>=20
> The .get_state callback is not implemented, because the PWM state can't
> be read back from the hardware.
>=20
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> ---
>=20
> v4:
> - Document hardware/driver limitations
> - Only accept normal polarity
> - Fix a typo ("zone" -> "zero")
> - change MAX_PERIOD_NS to 0xffff * 125
> - Clamp period to the maximum rather than returning an error
> - Rename private struct pointer to priv
> - Rearrage control flow in _probe to save a few lines and a temporary var=
iable
> - Add missing MODULE_ALIAS line
> - Spell out ODM
>=20
> v3:
> - https://lore.kernel.org/lkml/20200924192455.2484005-5-j.neuschaefer@gmx=
=2Enet/
> - Relicense as GPLv2 or later
> - Add email address to copyright line
> - Remove OF compatible string and don't include linux/of_device.h
> - Fix bogus ?: in return line
> - Don't use a comma after sentinels
> - Avoid ret |=3D ... pattern
> - Move 8-bit register conversion to ntxec.h
>=20
> v2:
> - https://lore.kernel.org/lkml/20200905133230.1014581-6-j.neuschaefer@gmx=
=2Enet/
> - Various grammar and style improvements, as suggested by Uwe Kleine-K=F6=
nig,
>   Lee Jones, and Alexandre Belloni
> - Switch to regmap
> - Prefix registers with NTXEC_REG_
> - Add help text to the Kconfig option
> - Use the .apply callback instead of the old API
> - Add a #define for the time base (125ns)
> - Don't change device state in .probe; this avoids multiple problems
> - Rework division and overflow check logic to perform divisions in 32 bits
> - Avoid setting duty cycle to zero, to work around a hardware quirk
> ---
>  drivers/pwm/Kconfig     |   8 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-ntxec.c | 166 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 175 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ntxec.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63be5362fd3a5..815f329ed5b46 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -350,6 +350,14 @@ config PWM_MXS
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-mxs.
>=20
> +config PWM_NTXEC
> +	tristate "Netronix embedded controller PWM support"
> +	depends on MFD_NTXEC
> +	help
> +	  Say yes here if you want to support the PWM output of the embedded
> +	  controller found in certain e-book readers designed by the original
> +	  design manufacturer Netronix.
> +
>  config PWM_OMAP_DMTIMER
>  	tristate "OMAP Dual-Mode Timer PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index cbdcd55d69eef..1deb29e6ae8e5 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
>  obj-$(CONFIG_PWM_MTK_DISP)	+=3D pwm-mtk-disp.o
>  obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
> +obj-$(CONFIG_PWM_NTXEC)		+=3D pwm-ntxec.o
>  obj-$(CONFIG_PWM_OMAP_DMTIMER)	+=3D pwm-omap-dmtimer.o
>  obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
>  obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
> diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
> new file mode 100644
> index 0000000000000..4f4f736d71aba
> --- /dev/null
> +++ b/drivers/pwm/pwm-ntxec.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * The Netronix embedded controller is a microcontroller found in some
> + * e-book readers designed by the original design manufacturer Netronix,=
 Inc.
> + * It contains RTC, battery monitoring, system power management, and PWM
> + * functionality.
> + *
> + * This driver implements PWM output.
> + *
> + * Copyright 2020 Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> + *
> + * Limitations:
> + * - The get_state callback is not implemented, because the current stat=
e of
> + *   the PWM output can't be read back from the hardware.
> + * - The hardware can only generate normal polarity output.
> + */
> +
> +#include <linux/mfd/ntxec.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +struct ntxec_pwm {
> +	struct device *dev;
> +	struct ntxec *ec;
> +	struct pwm_chip chip;
> +};
> +
> +static struct ntxec_pwm *pwmchip_to_priv(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct ntxec_pwm, chip);
> +}
> +
> +#define NTXEC_REG_AUTO_OFF_HI	0xa1
> +#define NTXEC_REG_AUTO_OFF_LO	0xa2
> +#define NTXEC_REG_ENABLE	0xa3
> +#define NTXEC_REG_PERIOD_LOW	0xa4
> +#define NTXEC_REG_PERIOD_HIGH	0xa5
> +#define NTXEC_REG_DUTY_LOW	0xa6
> +#define NTXEC_REG_DUTY_HIGH	0xa7
> +
> +/*
> + * The time base used in the EC is 8MHz, or 125ns. Period and duty cycle=
 are
> + * measured in this unit.
> + */
> +#define TIME_BASE_NS 125
> +
> +/*
> + * The maximum input value (in nanoseconds) is determined by the time ba=
se and
> + * the range of the hardware registers that hold the converted value.
> + * It fits into 32 bits, so we can do our calculations in 32 bits as wel=
l.
> + */
> +#define MAX_PERIOD_NS (TIME_BASE_NS * 0xffff)
> +
> +static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm=
_dev,
> +			   const struct pwm_state *state)
> +{
> +	struct ntxec_pwm *priv =3D pwmchip_to_priv(pwm_dev->chip);
> +	unsigned int duty =3D state->duty_cycle;
> +	unsigned int period =3D state->period;

state->duty_cycle and state->period are u64, so you're losing
information here. Consider state->duty_cycle =3D 0x100000001 and
state->period =3D 0x200000001.

> +	int res =3D 0;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (period > MAX_PERIOD_NS) {
> +		period =3D MAX_PERIOD_NS;
> +
> +		if (duty > period)
> +			duty =3D period;
> +	}
> +
> +	period /=3D TIME_BASE_NS;
> +	duty /=3D TIME_BASE_NS;
> +
> +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_HIGH, ntxec_reg=
8(period >> 8));
> +	if (res)
> +		return res;

I wonder if you can add some logic to the regmap in the mfd driver such
that ntxec_reg8 isn't necessary for all users.

> +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_PERIOD_LOW, ntxec_reg8=
(period));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_HIGH, ntxec_reg8(=
duty >> 8));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(priv->ec->regmap, NTXEC_REG_DUTY_LOW, ntxec_reg8(d=
uty));
> +	if (res)
> +		return res;

I think I already asked, but I don't remember the reply: What happens to
the output between these writes? A comment here about this would be
suitable.

> +
> +	/*
> +	 * Writing a duty cycle of zero puts the device into a state where
> +	 * writing a higher duty cycle doesn't result in the brightness that it
> +	 * usually results in. This can be fixed by cycling the ENABLE register.
> +	 *
> +	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
> +	 */
> +	if (state->enabled && duty !=3D 0) {
> +		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1)=
);
> +		if (res)
> +			return res;
> +
> +		/* Disable the auto-off timer */
> +		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_re=
g8(0xff));
> +		if (res)
> +			return res;
> +
> +		return regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg=
8(0xff));
> +	} else {
> +		return regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
> +	}
> +}
> +
> +static struct pwm_ops ntxec_pwm_ops =3D {

This can be const.

> +	.apply =3D ntxec_pwm_apply,

/*
 * The current state cannot be read out, so there is no .get_state
 * callback.
 */

Hmm, at least you could provice a .get_state() callback that reports the
setting that was actually implemented for in the last call to .apply()?

@Thierry: Do you have concerns here? Actually it would be more effective
to have a callback (like .apply()) that modfies its pwm_state
accordingly. (Some drivers did that in the past, but I changed that to
get an uniform behaviour in 71523d1812aca61e32e742e87ec064e3d8c615e1.)
The downside is that people have to understand that concept to properly
use it. I'm torn about the right approach.

> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int ntxec_pwm_probe(struct platform_device *pdev)
> +{
> +	struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
> +	struct ntxec_pwm *priv;
> +	struct pwm_chip *chip;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->ec =3D ec;
> +	priv->dev =3D &pdev->dev;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	chip =3D &priv->chip;
> +	chip->dev =3D &pdev->dev;
> +	chip->ops =3D &ntxec_pwm_ops;
> +	chip->base =3D -1;
> +	chip->npwm =3D 1;
> +
> +	return pwmchip_add(chip);
> +}
> +
> +static int ntxec_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ntxec_pwm *priv =3D platform_get_drvdata(pdev);
> +	struct pwm_chip *chip =3D &priv->chip;
> +
> +	return pwmchip_remove(chip);
> +}
> +
> +static struct platform_driver ntxec_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "ntxec-pwm",
> +	},
> +	.probe =3D ntxec_pwm_probe,
> +	.remove =3D ntxec_pwm_remove,
> +};
> +module_platform_driver(ntxec_pwm_driver);
> +
> +MODULE_AUTHOR("Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>");
> +MODULE_DESCRIPTION("PWM driver for Netronix EC");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ntxec-pwm");

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n7psjkl5oqhse6nm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+8wkAACgkQwfwUeK3K
7Ak9bgf+NapmOS9Fdc80KOeLtGA8StDYY66jDjFZZOGLqfzX2tmGPKOeUbbJkwtu
qMFOWSBJsJUz2WXM2EOO/vN5O/aXR3FDg8W4wHBLyC76yy0rzCVfkWy4KYvrps72
p/xjdZQTGZrnUKFdWfz1WGM+dja/sB5tXfIZnYJ2iJGoJ8JkOFXw/8Ug7156STd+
Nvvg4EF36jSwRi4XyIhiFxmFAdebQsMtxS4R3C9vE64ZtEibTNMCmgNgpm4lNYbm
cLMf7JgCt6DAviaQl+seBPYtigRAr3z5n8tPPSRyMvPS0PNs2IQEhs18UX9g/O2E
WQT2wSIwGHALFYjble0FTmZGIUdM0A==
=8Z7I
-----END PGP SIGNATURE-----

--n7psjkl5oqhse6nm--
