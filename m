Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CDA25A585
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 08:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBGZx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 02:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBGZw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 02:25:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5CEC061244
        for <linux-pwm@vger.kernel.org>; Tue,  1 Sep 2020 23:25:51 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMDI-0006kj-Pz; Wed, 02 Sep 2020 08:25:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMDH-0006Cp-9e; Wed, 02 Sep 2020 08:25:43 +0200
Date:   Wed, 2 Sep 2020 08:25:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20200902062543.hf5resp6yci2zojc@pengutronix.de>
References: <1598437559-25828-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1598437559-25828-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="inimxhmz4tefclzw"
Content-Disposition: inline
In-Reply-To: <1598437559-25828-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--inimxhmz4tefclzw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 26, 2020 at 06:25:58PM +0800, vineetha.g.jaya.kumaran@intel.com=
 wrote:
> From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
>=20
> Enable PWM support for the Intel Keem Bay SoC.
>=20
> Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.=
com>
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
> ---
>  drivers/pwm/Kconfig       |   9 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-keembay.c | 228 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 238 insertions(+)
>  create mode 100644 drivers/pwm/pwm-keembay.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7dbcf69..0a68a167 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -560,4 +560,13 @@ config PWM_ZX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-zx.
> =20
> +config PWM_KEEMBAY
> +	tristate "Intel Keem Bay PWM driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  The platform driver for Intel Keem Bay PWM controller.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-keembay.

The symbols in drivers/pwm/Kconfig are ordered alphabetically.

> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 2c2ba0a..293e48f 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -54,3 +54,4 @@ obj-$(CONFIG_PWM_TWL)		+=3D pwm-twl.o
>  obj-$(CONFIG_PWM_TWL_LED)	+=3D pwm-twl-led.o
>  obj-$(CONFIG_PWM_VT8500)	+=3D pwm-vt8500.o
>  obj-$(CONFIG_PWM_ZX)		+=3D pwm-zx.o
> +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o

ditto.

> diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
> new file mode 100644
> index 00000000..3c7481f
> --- /dev/null
> +++ b/drivers/pwm/pwm-keembay.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Keem Bay PWM driver
> + *
> + * Copyright (C) 2020 Intel Corporation
> + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> + *
> + * Limitation:

Please make this "Limitations:" for consitency with other drivers. This
allows something like

	for f in drivers/pwm/pwm-*; do echo $f; sed -nr '/Limitations:/,/\*\/?$/p'=
 $f; done

to work nicely.

> + * - Upon disabling a channel, the currently running
> + *   period will not be completed. However, upon
> + *   reconfiguration of the duty cycle/period, the
> + *   currently running period will be completed first.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define KMB_TOTAL_PWM_CHANNELS		6
> +#define KMB_PWM_COUNT_MAX		0xffff
> +#define KMB_PWM_EN_BIT			BIT(31)
> +
> +/* Mask */
> +#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
> +#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
> +#define KMB_PWM_COUNT_MASK		GENMASK(31, 0)
> +
> +/* PWM Register offset */
> +#define KMB_PWM_LEADIN_OFFSET(ch)	(0x00 + 4 * (ch))
> +#define KMB_PWM_HIGHLOW_OFFSET(ch)	(0x20 + 4 * (ch))
> +
> +struct keembay_pwm {
> +	struct pwm_chip chip;
> +	struct device *dev;
> +	struct clk *clk;
> +	void __iomem *base;
> +};
> +
> +static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip *ch=
ip)
> +{
> +	return container_of(chip, struct keembay_pwm, chip);
> +}
> +
> +static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32=
 mask,
> +					   u32 val, u32 offset)
> +{
> +	u32 buff =3D readl(priv->base + offset);
> +
> +	buff =3D u32_replace_bits(buff, val, mask);
> +	writel(buff, priv->base + offset);
> +}
> +
> +static void keembay_pwm_enable(struct keembay_pwm *priv, int ch)
> +{
> +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
> +				KMB_PWM_LEADIN_OFFSET(ch));
> +}
> +
> +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch)
> +{
> +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
> +				KMB_PWM_LEADIN_OFFSET(ch));
> +}
> +
> +static void keembay_pwm_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	unsigned long long pwm_h_count, pwm_l_count;
> +	unsigned long clk_rate;
> +	u32 buff;
> +
> +	clk_rate =3D clk_get_rate(priv->clk);

clk_get_rate() must only be called when the clock is enabled. Unless I
miss something this isn't ensured here.

> +
> +	/* Read channel enabled status */
> +	buff =3D readl(priv->base + KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> +	if (buff & KMB_PWM_EN_BIT)
> +		state->enabled =3D true;
> +	else
> +		state->enabled =3D false;
> +
> +	/* Read period and duty cycle */
> +	buff =3D readl(priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> +	pwm_l_count =3D FIELD_GET(KMB_PWM_LOW_MASK, buff) * NSEC_PER_SEC;
> +	pwm_h_count =3D FIELD_GET(KMB_PWM_HIGH_MASK, buff) * NSEC_PER_SEC;
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(pwm_h_count, clk_rate);
> +	state->period =3D DIV_ROUND_UP_ULL(pwm_h_count + pwm_l_count, clk_rate);
> +}
> +
> +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> +	struct pwm_state current_state;
> +	u16 pwm_h_count, pwm_l_count;
> +	unsigned long long div;
> +	unsigned long clk_rate;
> +	u32 pwm_count =3D 0;
> +
> +	keembay_pwm_get_state(chip, pwm, &current_state);

This can be moved after the test for state->polarity.

> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -ENOSYS;
> +
> +	if (!state->enabled && current_state.enabled) {
> +		keembay_pwm_disable(priv, pwm->hwpwm);
> +		return 0;
> +	}

if (!state->enabled) {
	if (current_state.enabled)
		keembay_pwm_disable(priv, pwm->hwpwm);
	return 0;
}

> +
> +	/*
> +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register contain
> +	 * the high time of the waveform, while the last 16 bits contain
> +	 * the low time of the waveform, in terms of clock cycles.
> +	 *
> +	 * high time =3D clock rate * duty cycle
> +	 * low time =3D  clock rate * (period - duty cycle)
> +	 *
> +	 * e.g. For period 50us, duty cycle 30us, and clock rate 500MHz:
> +	 * high time =3D 500MHz * 30us =3D 0x3A98
> +	 * low time =3D 500MHz * 20us =3D 0x2710
> +	 * Value written to KMB_PWM_HIGHLOW_OFFSET =3D 0x3A982710
> +	 */
> +
> +	clk_rate =3D clk_get_rate(priv->clk);
> +
> +	/* Configure waveform high time */
> +	div =3D clk_rate * state->duty_cycle;

Since v5.9-rc1 (commit a9d887dc1c60ed67f2271d66560cdcf864c4a578)
state->duty_cycle is a 64 bit type. So div being unsigned long isn't
big enough on some platforms.

> +	div =3D DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);
> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	pwm_h_count =3D div;
> +
> +	/* Configure waveform low time */
> +	div =3D clk_rate * (state->period - state->duty_cycle);
> +	div =3D DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);
> +	if (div > KMB_PWM_COUNT_MAX)
> +		return -ERANGE;
> +
> +	pwm_l_count =3D div;
> +
> +	pwm_count =3D FIELD_PREP(KMB_PWM_HIGH_MASK, pwm_h_count) |
> +		    FIELD_PREP(KMB_PWM_LOW_MASK, pwm_l_count);
> +
> +	writel(pwm_count, priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> +
> +	if (state->enabled && !current_state.enabled)
> +		keembay_pwm_enable(priv, pwm->hwpwm);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops keembay_pwm_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.apply =3D keembay_pwm_apply,
> +	.get_state =3D keembay_pwm_get_state,
> +};
> +
> +static int keembay_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct keembay_pwm *priv;
> +	int ret, ch;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get clock\n");
> +
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->chip.base =3D -1;
> +	priv->chip.dev =3D dev;
> +	priv->chip.ops =3D &keembay_pwm_ops;
> +	priv->chip.npwm =3D KMB_TOTAL_PWM_CHANNELS;
> +
> +	ret =3D pwmchip_add(&priv->chip);
> +	if (ret) {
> +		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	/* Ensure enable bit for each channel is cleared at boot */
> +	for (ch =3D 0; ch < KMB_TOTAL_PWM_CHANNELS; ch++)
> +		keembay_pwm_disable(priv, ch);

=2Eprobe() is not supposed to change the state of the PWM.

> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--inimxhmz4tefclzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9POuMACgkQwfwUeK3K
7Ak/VQf8CqexPp6+y0ivwCJkzGL+dehE/6i/dJgFEZOXZW/EYqma1DvmEGEEYDVB
cuhr0kqu2pgaEvq6nvyZf8thoTkR5KoQ3Nd0cqeeSS+bN9yGCqttGMLahAzMVIaD
ddd5VlX3z3sPRXJoJlY5uZXcmRw6AvdEsmSvtwPIALlyCfBZuBOgyreX+TA4fT2B
4ipPikY1Z9+KOMusAJjkJpjok9lw53ZGf18uu6MBBztNDQXE9rmG64Yia5iThZ0u
E5R5nU6+s/PtDUJtZHTcAdPIXQfDIvLuBGAbiiVSQpHhKJRtui6dnqGNqGzQUi0I
3tfAi5xEV9/C5ONJRkI/Lc8KYjxwhg==
=RoIZ
-----END PGP SIGNATURE-----

--inimxhmz4tefclzw--
