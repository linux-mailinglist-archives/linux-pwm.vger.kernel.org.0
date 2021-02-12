Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9531A305
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Feb 2021 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBLQnZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Feb 2021 11:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhBLQmp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Feb 2021 11:42:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29262C061756
        for <linux-pwm@vger.kernel.org>; Fri, 12 Feb 2021 08:42:04 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lAbVt-0003Jl-6x; Fri, 12 Feb 2021 17:41:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lAbVo-0006yD-Oe; Fri, 12 Feb 2021 17:41:44 +0100
Date:   Fri, 12 Feb 2021 17:41:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210212164144.wcvy7jkxmrysqxux@pengutronix.de>
References: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210212131910.557581-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ssz6scb22myda7o"
Content-Disposition: inline
In-Reply-To: <20210212131910.557581-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2ssz6scb22myda7o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nobuhiro,

On Fri, Feb 12, 2021 at 10:19:10PM +0900, Nobuhiro Iwamatsu wrote:
> Add driver for the PWM controller on Toshiba Visconti ARM SoC.
>=20
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/pwm/Kconfig        |   9 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-visconti.c | 173 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 183 insertions(+)
>  create mode 100644 drivers/pwm/pwm-visconti.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 9a4f66ae8070..8ae68d6203fb 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -601,6 +601,15 @@ config PWM_TWL_LED
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-twl-led.
> =20
> +config PWM_VISCONTI
> +	tristate "Toshiba Visconti PWM support"
> +	depends on ARCH_VISCONTI || COMPILE_TEST
> +	help
> +	  PWM Subsystem driver support for Toshiba Visconti SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-visconti.
> +
>  config PWM_VT8500
>  	tristate "vt8500 PWM support"
>  	depends on ARCH_VT8500 || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 6374d3b1d6f3..d43b1e17e8e1 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -56,4 +56,5 @@ obj-$(CONFIG_PWM_TIECAP)	+=3D pwm-tiecap.o
>  obj-$(CONFIG_PWM_TIEHRPWM)	+=3D pwm-tiehrpwm.o
>  obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
> +obj-$(CONFIG_PWM_VISCONTI)	+=3D pwm-visconti.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
> diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> new file mode 100644
> index 000000000000..2aa140f1ec04
> --- /dev/null
> +++ b/drivers/pwm/pwm-visconti.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Toshiba Visconti pulse-width-modulation controller driver
> + *
> + * Copyright (c) 2020 TOSHIBA CORPORATION
> + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
> + *
> + * Authors: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pwm.h>
> +#include <linux/platform_device.h>
> +
> +
> +#define PIPGM_PCSR(ch) (0x400 + 4 * (ch))
> +#define PIPGM_PDUT(ch) (0x420 + 4 * (ch))
> +#define PIPGM_PWMC(ch) (0x440 + 4 * (ch))
> +
> +#define PIPGM_PWMC_PWMACT		BIT(5)
> +#define PIPGM_PWMC_CLK_MASK		GENMASK(1, 0)
> +#define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
> +#define PIPGM_PDUT_MAX			0xFFFF
> +
> +struct visconti_pwm_chip {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +};
> +
> +#define to_visconti_chip(chip) \
> +	container_of(chip, struct visconti_pwm_chip, chip)
> +
> +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			  const struct pwm_state *state)

Please align the continuation line to the opening parenthesis.

> +{
> +	struct visconti_pwm_chip *priv =3D to_visconti_chip(chip);
> +	u32 period, duty, pwmc0;
> +
> +	dev_dbg(chip->dev, "%s: ch =3D %d en =3D %d p =3D 0x%llx d =3D 0x%llx\n=
", __func__,
> +		pwm->hwpwm, state->enabled, state->period, state->duty_cycle);
> +
> +	/*
> +	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
> +	 * When the settings of the PWM are modified, the new values are shadow=
ed in hardware until
> +	 * the period register (PCSR) is written and the currently running peri=
od is completed. This
> +	 * way the hardware switches atomically from the old setting to the new.
> +	 * Also, disabling the hardware completes the currently running period =
and keeps the output
> +	 * at low level at all times.

Did you just copy my optimal description or is your hardware really that
nice?

Do you know scripts/checkpatch.pl? I bet it will tell you to limit your
lines to approx. 80 chars where sensible.

> +	 */
> +	if (!state->enabled) {
> +		writel(0, priv->base + PIPGM_PCSR(pwm->hwpwm));
> +		return 0;
> +	}
> +
> +	period =3D state->period / NSEC_PER_USEC;

This becomes wrong if state->period > 1000 * 0xffffffff because you
discard non-zero bits when reducing the size to u32.

> +	duty =3D state->duty_cycle / NSEC_PER_USEC;
> +	if (period < 0x10000)
> +		pwmc0 =3D 0;
> +	else if (period < 0x20000)
> +		pwmc0 =3D 1;
> +	else if (period < 0x40000)
> +		pwmc0 =3D 2;
> +	else if (period < 0x80000)
> +		pwmc0 =3D 3;
> +	else
> +		return -EINVAL;

This is equivalent to:

	pwmc0 =3D ilog2(period >> 16);
	if (pwmc0 > 3)
		return -EINVAL;

> +	if (duty > PIPGM_PDUT_MAX)
> +		return -EINVAL;

I would expect that this check should only happen after duty is shifted
below?! I think this cannot happen if you rely on the core to only give
you states with duty_cycle <=3D period.

> +	period >>=3D pwmc0;
> +	duty >>=3D pwmc0;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		pwmc0 |=3D PIPGM_PWMC_PWMACT;
> +
> +	writel(pwmc0, priv->base + PIPGM_PWMC(pwm->hwpwm));
> +	writel(duty, priv->base + PIPGM_PDUT(pwm->hwpwm));
> +	writel(period, priv->base + PIPGM_PCSR(pwm->hwpwm));

Please implement the following policy:

Pick the biggest possible period not bigger than the requested period.
With that pick the biggest possible duty cycle not bigger than the
requested duty cycle. That means (assuming I understood your hardware
correctly):

	u32 period, duty_cycle;

	/*
	 * The biggest period the hardware can provide is
	 * 	(0xffff << 3) * 1000 ns
	 * This value fits easily in an u32, so simplify the maths by
	 * capping the values to 32 bit integers.
	 */
	if (state->period > (0xffff << 3) * 1000)
		period =3D (0xffff << 3) * 1000;
	else
		period =3D state->period;

	if (state->duty_cycle > period)
		duty_cycle =3D period;
	else
		duty_cycle =3D state->duty_cycle;

	/*
	 * The input clock runs fixed at 1 MHz, so we have only
	 * microsecond resolution and so can divide by
	 * NSEC_PER_SEC / CLKFREQ =3D 1000 without loosing precision.
	 */
	period /=3D 1000;
	duty_cycle /=3D 1000;

	if (!period)
		/* period too small */
		return -ERANGE;

	/*
	 * PWMC controls a divider that divides the input clk by a
	 * power of two between 1 and 8. As a smaller divider yields
	 * higher precision, pick the smallest possible one.
	 */
	pwmc0 =3D ilog2(period >> 16);
	BUG_ON(pwmc0 > 3);

	period >>=3D pwmc0;
	duty_cycle >>=3D pwmc0;
=09
	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
		pwmc0 |=3D PIPGM_PWMC_PWMACT;
		=09
	writel(pwmc0, priv->base + PIPGM_PWMC(pwm->hwpwm));
	writel(duty, priv->base + PIPGM_PDUT(pwm->hwpwm));
	writel(period, priv->base + PIPGM_PCSR(pwm->hwpwm));

> +	return 0;
> +}
> +
> +static void visconti_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				   struct pwm_state *state)
> +{
> +[...]
> +}

Looks good.

> [...]
>=20
> +static struct platform_driver visconti_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-visconti",
> +		.of_match_table =3D visconti_pwm_of_match,
> +	},
> +	.probe =3D visconti_pwm_probe,
> +	.remove =3D visconti_pwm_remove,
> +};
> +module_platform_driver(visconti_pwm_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>");
> +MODULE_ALIAS("platform:visconti-pwm");

This must match the .name field of the platform driver, so it must be

MODULE_ALIAS("platform:pwm-visconti");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2ssz6scb22myda7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAmr8QACgkQwfwUeK3K
7AkXrQf+OSZRSopiaKm+LYuAkFlcVUCiRoyePIf28ohZt07zPF8u7HCGb/tYHXKl
3pDlplkZoXolQzi3RsTENbH8SMB0ceHzsW2/8G8Dnpz9t7FIaWOLYsjuj3xxHKhs
EVW1US87mi/4ZT7CwyMiDFSou2zVCe8hI9VHEWYRb6+jfIIIdbWkpOFlwACGOqpl
3F/ACImmr6uQbzAjWunk1xkV3wB2nv7qPe6KvMxs0AzZ664cGxTG6VaWYCheJAl6
fI/iXHpZQgUgIEQTXOMDaK/xmow/VC6X9EdkHBj1g/ejWMfIX/hrGajxlIVZ9eYj
Xmdy3VgdkYYKEDox/WxUyHM6JfUZag==
=f243
-----END PGP SIGNATURE-----

--2ssz6scb22myda7o--
