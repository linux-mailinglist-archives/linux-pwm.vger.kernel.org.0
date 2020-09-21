Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1008271E08
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Sep 2020 10:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIUIex (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Sep 2020 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgIUIex (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2020 04:34:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE1C061755
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2020 01:34:53 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHHf-0002GP-71; Mon, 21 Sep 2020 10:34:51 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHHd-0007sz-Kh; Mon, 21 Sep 2020 10:34:49 +0200
Date:   Mon, 21 Sep 2020 10:34:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     vijayakannan.ayyathurai@intel.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com, kernel@pengutronix.de
Subject: Re: [PATCH v7 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20200921083449.mq4dxbavo5d4tozh@pengutronix.de>
References: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
 <20200909162719.7585-2-vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2o2qvymb54yazq6b"
Content-Disposition: inline
In-Reply-To: <20200909162719.7585-2-vijayakannan.ayyathurai@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2o2qvymb54yazq6b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 12:27:18AM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>=20
> The Intel Keem Bay SoC requires PWM support.
> Add the pwm-keembay driver to enable this.
>=20
> Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.=
com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/Kconfig       |   9 ++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-keembay.c | 232 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 242 insertions(+)
>  create mode 100644 drivers/pwm/pwm-keembay.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7dbcf6973d33..4f1fdbc2e5e3 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -254,6 +254,15 @@ config PWM_JZ4740
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-jz4740.
> =20
> +config PWM_KEEMBAY
> +	tristate "Intel Keem Bay PWM driver"
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  The platform driver for Intel Keem Bay PWM controller.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-keembay.

I wonder about the dependency. If this is an external chip it should be
possible to be used on platforms other than ARM64. If this is only part
of a certain SoC: Isn't there a more specific symbol than ARM64 to
depend on?

> +
>  config PWM_LP3943
>  	tristate "TI/National Semiconductor LP3943 PWM support"
>  	depends on MFD_LP3943
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 2c2ba0a03557..a1051122eb07 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
> +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
>  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
>  obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
> diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
> new file mode 100644
> index 000000000000..6f41b1c0ae9a
> --- /dev/null
> +++ b/drivers/pwm/pwm-keembay.c
> @@ -0,0 +1,232 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Keem Bay PWM driver
> + *
> + * Copyright (C) 2020 Intel Corporation
> + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
> + *
> + * Limitations:
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
> +#define KMB_PWM_LEADIN_MASK		GENMASK(30, 0)
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
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -ENOSYS;
> +
> +	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> +				KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> +
> +	keembay_pwm_get_state(chip, pwm, &current_state);
> +
> +	if (!state->enabled) {
> +		if (current_state.enabled)
> +			keembay_pwm_disable(priv, pwm->hwpwm);
> +		return 0;
> +	}
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
> +	div =3D DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);

Please round down here.

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

This isn't right, too.

I think the right formula is:

	div =3D (clk_rate * state->period) / NSEC_PER_SEC - pwm_h_count

Consider:

  clk_rate =3D 333334 [Hz]

  state.duty_cycle =3D 1000500 [ns]
  state.period =3D 2001000 [ns]

With your calculation (and rounding down in the divisions calculation)
this results in=20

pwm_h_count =3D 333
pwm_l_count =3D 333

and so a period length of 666 clock ticks (1997996 ns) while it should be
667 clock ticks (2000995 ns).

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
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get clock\n");
> +
> +	ret =3D clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
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
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;

clk_disable_unprepare is missing in the two last error paths.

> +}
> +
> +static int keembay_pwm_remove(struct platform_device *pdev)
> +{
> +	struct keembay_pwm *priv =3D platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&priv->chip);

clk_disable_unprepare is missing here, too.

> +}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2o2qvymb54yazq6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9oZaYACgkQwfwUeK3K
7Am4Ywf/UmInXshjV+uKRE5HGx4USSGv26/mbX8lD9XNDMG3P/IAXP31ygJlcunU
nL+KRd/ghUWCq1O1BAB676m+ZhTkho8Wsp8djPEwV0ZADZomxHAgcs0+tYsgr3ZT
l6jiBXIykbpI2MuQw16nQczLlMvsw5JS56Piysgrld2TLEQ478QHpJtvTpneEMl+
g5+lgTPM7tJkdm5ky/4hgSxRSSBCc64K75Affr4s7w4kYC3kDXn3K0iq8x7u+zuT
g/5p6IAbTlzGrU/r0/bJBHNkh+GGbCIDzrbmucrWS6mrAMaBwyf7rV8/TarYVu9b
O7Z9GNUR2/gHd55TJ9GDQnYl4N3XUQ==
=yiv6
-----END PGP SIGNATURE-----

--2o2qvymb54yazq6b--
