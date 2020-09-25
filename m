Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648092780BB
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 08:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgIYGb2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 02:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgIYGav (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Sep 2020 02:30:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE7C0613CE
        for <linux-pwm@vger.kernel.org>; Thu, 24 Sep 2020 23:30:50 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kLhFh-0004L4-Nz; Fri, 25 Sep 2020 08:30:41 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kLhFe-0004uE-0b; Fri, 25 Sep 2020 08:30:38 +0200
Date:   Fri, 25 Sep 2020 08:30:37 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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
Subject: Re: [PATCH v3 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20200925063037.fcrmqvpe5noi3ef4@pengutronix.de>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-5-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iyspp2jcs5lu5zk3"
Content-Disposition: inline
In-Reply-To: <20200924192455.2484005-5-j.neuschaefer@gmx.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--iyspp2jcs5lu5zk3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Thu, Sep 24, 2020 at 09:24:52PM +0200, Jonathan Neusch=E4fer wrote:
> The Netronix EC provides a PWM output which is used for the backlight
> on some ebook readers. This patches adds a driver for the PWM output.
>=20
> The .get_state callback is not implemented, because the PWM state can't
> be read back from the hardware.
>=20
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> ---
>=20
> v3:
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
>  drivers/pwm/pwm-ntxec.c | 161 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 170 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ntxec.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7dbcf6973d335..530dfda38d65e 100644
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
> +	  controller found in certain e-book readers designed by the ODM
> +	  Netronix.

Is it only me who had to look up what ODM means? If not, maybe spell it
out?

> +
>  config PWM_OMAP_DMTIMER
>  	tristate "OMAP Dual-Mode Timer PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 2c2ba0a035577..1cc50dba22d1b 100644
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
> index 0000000000000..50da2dc14bb03
> --- /dev/null
> +++ b/drivers/pwm/pwm-ntxec.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * The Netronix embedded controller is a microcontroller found in some
> + * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
> + * battery monitoring, system power management, and PWM functionality.
> + *
> + * This driver implements PWM output.
> + *
> + * Copyright 2020 Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
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
> +static struct ntxec_pwm *pwmchip_to_pwm(struct pwm_chip *chip)
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
> +#define MAX_PERIOD_NS (TIME_BASE_NS * 0x10000 - 1)

The maximal configurable period length is 0xffff, so I would have
expected MAX_PERIOD_NS to be 0xffff * TIME_BASE_NS?

> +static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm=
_dev,
> +			   const struct pwm_state *state)
> +{
> +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(pwm_dev->chip);
> +	unsigned int duty =3D state->duty_cycle;
> +	unsigned int period =3D state->period;
> +	int res =3D 0;
> +

I assume your device only supports normal polarity? If so, please check
for it here and point out this limitation in the header (in the format
that is for example used in pwm-sifive.c to make it easy to grep for
that).

> +	if (period > MAX_PERIOD_NS) {
> +		dev_warn(pwm->dev,
> +			 "Period is not representable in 16 bits after division by %u: %u\n",
> +			 TIME_BASE_NS, period);

No error messages in .apply() please; this might spam the kernel log.

Also the expectation when a too big period is requested is to configure
for the biggest possible period. So just do:

	if (period > MAX_PERIOD_NS) {
		period =3D MAX_PERIOD_NS;

		if (duty > period)
			duty =3D period;
	}

(or something equivalent).

> +		return -ERANGE;
> +	}
> +
> +	period /=3D TIME_BASE_NS;
> +	duty /=3D TIME_BASE_NS;
> +
> +	res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_HIGH, ntxec_reg8=
(period >> 8));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_LOW, ntxec_reg8(=
period));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_HIGH, ntxec_reg8(d=
uty >> 8));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_LOW, ntxec_reg8(du=
ty));
> +	if (res)
> +		return res;
> +
> +	/*
> +	 * Writing a duty cycle of zone puts the device into a state where

What is "zone"? A mixture of zero and one and so approximately 0.5?

> +	 * writing a higher duty cycle doesn't result in the brightness that it
> +	 * usually results in. This can be fixed by cycling the ENABLE register.
> +	 *
> +	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
> +	 */
> +	if (state->enabled && duty !=3D 0) {
> +		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1));
> +		if (res)
> +			return res;
> +
> +		/* Disable the auto-off timer */
> +		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_reg=
8(0xff));
> +		if (res)
> +			return res;
> +
> +		return regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg8=
(0xff));
> +	} else {
> +		return regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
> +	}

This code is wrong for state->enabled =3D false.

How does the PWM behave when .apply is called? Does it complete the
currently running period? Can it happen that when you switch from say

	.duty_cycle =3D 900 * TIME_BASE_NS (0x384)
	.period =3D 1800 * TIME_BASE_NS (0x708)

to

	.duty_cycle =3D 300 * TIME_BASE_NS (0x12c)
	.period =3D 600 * TIME_BASE_NS (0x258)

that a period with

	.duty_cycle =3D 388 * TIME_BASE_NS (0x184)
	.period =3D 1800 * TIME_BASE_NS (0x708)
=09
(because only NTXEC_REG_PERIOD_HIGH was written when the new period
started) or something similar is emitted?

> +}
> +
> +static struct pwm_ops ntxec_pwm_ops =3D {
> +	.apply =3D ntxec_pwm_apply,

Please implement a .get_state() callback. And enable PWM_DEBUG during
your tests.

> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int ntxec_pwm_probe(struct platform_device *pdev)
> +{
> +	struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
> +	struct ntxec_pwm *pwm;

Please don't call this variable pwm. I would expect that a variable with
this name is of type pwm_device. I would have called it "ddata" (and the
type would be named ntxec_pwm_ddata for me); another usual name is "priv".

> +	struct pwm_chip *chip;
> +	int res;
> +
> +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->ec =3D ec;
> +	pwm->dev =3D &pdev->dev;
> +
> +	chip =3D &pwm->chip;
> +	chip->dev =3D &pdev->dev;
> +	chip->ops =3D &ntxec_pwm_ops;
> +	chip->base =3D -1;
> +	chip->npwm =3D 1;
> +
> +	res =3D pwmchip_add(chip);
> +	if (res < 0)
> +		return res;
> +
> +	platform_set_drvdata(pdev, pwm);

If you do the platform_set_drvdata earlier you can just do

	return pwmchip_add(chip);

> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iyspp2jcs5lu5zk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9tjosACgkQwfwUeK3K
7An6eQgAiyVqAnvWSzB6ypXG63i//HCOee0falc+84GtztQmatgUqLoO0aut1Qpn
y/K+67THG0a3g+jEWn8jIlv+TiuK6ZjSZZYlGyJ6fl48d11QO3rPAn0lhSEy3xb7
a/FKhKExJjMpQfKKUwIcqakv37fK5QEd5ZRQaULigi9TDdHHSVWmNOxVKjxp2KtL
Q1xx0tCEVDS/7cjHtA3A5tpHbPIyTUeaeny/6YEiVzjlbaFBwzb00/d5cQE1Ls4s
IQi/KS7CQCgmxba5xCE3ZClQ1Dswh5Ys2sAviSOozHTsp42mKWern5nsXrGYHuD8
vmCiBkT9c4sk9BFRc2fYceTzEpP7Ow==
=qy2w
-----END PGP SIGNATURE-----

--iyspp2jcs5lu5zk3--
