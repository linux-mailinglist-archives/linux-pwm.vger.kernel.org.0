Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBEA35ADCF
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhDJNxy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Apr 2021 09:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbhDJNxy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Apr 2021 09:53:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709E5C06138A
        for <linux-pwm@vger.kernel.org>; Sat, 10 Apr 2021 06:53:39 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVE3B-0007na-Oj; Sat, 10 Apr 2021 15:53:25 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVE37-00075f-D0; Sat, 10 Apr 2021 15:53:21 +0200
Date:   Sat, 10 Apr 2021 15:53:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210410135321.oissremqropvrpd3@pengutronix.de>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pjjfj46eow3hglsb"
Content-Disposition: inline
In-Reply-To: <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pjjfj46eow3hglsb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just a few small details left to criticize ...

On Sat, Apr 10, 2021 at 08:08:37AM +0900, Nobuhiro Iwamatsu wrote:
> diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> new file mode 100644
> index 000000000000..99d83f94ed86
> --- /dev/null
> +++ b/drivers/pwm/pwm-visconti.c
> @@ -0,0 +1,188 @@
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
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#define PIPGM_PCSR(ch) (0x400 + 4 * (ch))
> +#define PIPGM_PDUT(ch) (0x420 + 4 * (ch))
> +#define PIPGM_PWMC(ch) (0x440 + 4 * (ch))
> +
> +#define PIPGM_PWMC_PWMACT		BIT(5)
> +#define PIPGM_PWMC_CLK_MASK		GENMASK(1, 0)
> +#define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
> +
> +struct visconti_pwm_chip {
> +	struct pwm_chip chip;
> +	void __iomem *base;
> +};
> +
> +static inline struct visconti_pwm_chip *to_visconti_chip(struct pwm_chip=
 *chip)
> +{
> +	return container_of(chip, struct visconti_pwm_chip, chip);
> +}
> +
> +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct visconti_pwm_chip *priv =3D to_visconti_chip(chip);
> +	u32 period, duty_cycle, pwmc0;
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

Can you please put a paragraph analogous to the one in pwm-sifive in the
same format. This simplified keeping an overview about the oddities of
the various supported chips.

> +	 */
> +	if (!state->enabled) {
> +		writel(0, priv->base + PIPGM_PCSR(pwm->hwpwm));
> +		return 0;
> +	}
> +
> [...]
> +
> +static void visconti_pwm_get_state(struct pwm_chip *chip, struct pwm_dev=
ice *pwm,
> +				   struct pwm_state *state)
> +{
> +	struct visconti_pwm_chip *priv =3D chip_to_priv(chip);
> +	u32 period, duty, pwmc0, pwmc0_clk;
> +
> +	period =3D readl(priv->base + PIPGM_PCSR(pwm->hwpwm));
> +	if (period)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;

If PIPGM_PCSR is 0 the hardware is still active and setting a new
configuration completes the currently running period, right? Then I
think having always state->enabled =3D true is a better match.

> +	duty =3D readl(priv->base + PIPGM_PDUT(pwm->hwpwm));
> +	pwmc0 =3D readl(priv->base + PIPGM_PWMC(pwm->hwpwm));
> +	pwmc0_clk =3D pwmc0 & PIPGM_PWMC_CLK_MASK;
> +
> +	state->period =3D (period << pwmc0_clk) * NSEC_PER_USEC;
> +	state->duty_cycle =3D (duty << pwmc0_clk) * NSEC_PER_USEC;
> +	if (pwmc0 & PIPGM_PWMC_POLARITY_MASK)
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +	else
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +}
> +
> [...]
> +
> +static int visconti_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct visconti_pwm_chip *priv;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &visconti_pwm_ops;
> +	priv->chip.npwm =3D 4;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n"=
);

Thierry told to have picked up my patch to add the function
devm_pwmchip_add. I just double checked and it didn't made it into his
for-next branch yet. When you respin this series please check if the
patch landed in the mean time and then make use of it.

> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pjjfj46eow3hglsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBxrc4ACgkQwfwUeK3K
7An8Agf/TcwzA5y/ujLBdYV94szslblrl3cPR+Tm1hoCFo8LZcfQs4AX3UYuOLwq
hTmSL7Wx3MSsR4l5sVwmlxmve/mwCUK5PgHmC169R6143D2+Cl0d/fZW6NICIcCa
SA6uAs46vf0ytxYtim3kYXCZN5TDRU44de8feZn0f7dLEiAHSHSKQ4v82Ma1Tlkh
oCiLrNfhK7wYP4hwX4EW0aMvUM93lTrqD/7b1oMkyomw0mpowDmfAyeBsJL01NKP
T6d4ynlYC1ufBUdj9mfGGD153/lJuvLvKgVGR4PiBJDui8OhkZpTcwe64L/8x0eu
04ocjGLEvPWHRYU4rus88Z+z1PE6tQ==
=Y7I+
-----END PGP SIGNATURE-----

--pjjfj46eow3hglsb--
