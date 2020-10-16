Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B3228FE43
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393964AbgJPGYq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 02:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393958AbgJPGYq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Oct 2020 02:24:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6EC061755
        for <linux-pwm@vger.kernel.org>; Thu, 15 Oct 2020 23:24:46 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kTJAS-0007Cd-IV; Fri, 16 Oct 2020 08:24:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kTJAQ-0002Px-Pc; Fri, 16 Oct 2020 08:24:42 +0200
Date:   Fri, 16 Oct 2020 08:24:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     vijayakannan.ayyathurai@intel.com, thierry.reding@gmail.com,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201016062439.lvpzbtxd4azku2fq@pengutronix.de>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201015104217.GR4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p7lj7w2fkz66s6lv"
Content-Disposition: inline
In-Reply-To: <20201015104217.GR4077@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--p7lj7w2fkz66s6lv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 01:42:17PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 15, 2020 at 03:36:09AM +0800, vijayakannan.ayyathurai@intel.c=
om wrote:
> > From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> >=20
> > The Intel Keem Bay SoC requires PWM support.
> > Add the pwm-keembay driver to enable this.
> >=20
> > Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
>=20
> Missed Co-developed-by?
>=20
> > Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@inte=
l.com>
> > Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.=
com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.c=
om>
> > ---
> >  drivers/pwm/Kconfig       |   9 ++
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-keembay.c | 233 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 243 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-keembay.c
> >=20
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 7dbcf6973d33..6129a9dbbfa8 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -254,6 +254,15 @@ config PWM_JZ4740
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-jz4740.
> > =20
> > +config PWM_KEEMBAY
> > +	tristate "Intel Keem Bay PWM driver"
> > +	depends on ARCH_KEEMBAY || COMPILE_TEST
> > +	help
> > +	  The platform driver for Intel Keem Bay PWM controller.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-keembay.
> > +
> >  config PWM_LP3943
> >  	tristate "TI/National Semiconductor LP3943 PWM support"
> >  	depends on MFD_LP3943
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 2c2ba0a03557..a1051122eb07 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
> >  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
> >  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
> >  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
> > +obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> >  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
> >  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
> >  obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
> > diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
> > new file mode 100644
> > index 000000000000..ced6d4010add
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-keembay.c
> > @@ -0,0 +1,233 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel Keem Bay PWM driver
> > + *
> > + * Copyright (C) 2020 Intel Corporation
> > + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> > + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
> > + *
> > + * Limitations:
> > + * - Upon disabling a channel, the currently running
> > + *   period will not be completed. However, upon
> > + *   reconfiguration of the duty cycle/period, the
> > + *   currently running period will be completed first.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/regmap.h>
> > +
> > +#define KMB_TOTAL_PWM_CHANNELS		6
> > +#define KMB_PWM_COUNT_MAX		U16_MAX
> > +#define KMB_PWM_EN_BIT			BIT(31)
> > +
> > +/* Mask */
> > +#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
> > +#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
> > +#define KMB_PWM_LEADIN_MASK		GENMASK(30, 0)
> > +
> > +/* PWM Register offset */
> > +#define KMB_PWM_LEADIN_OFFSET(ch)	(0x00 + 4 * (ch))
> > +#define KMB_PWM_HIGHLOW_OFFSET(ch)	(0x20 + 4 * (ch))
> > +
> > +struct keembay_pwm {
> > +	struct pwm_chip chip;
> > +	struct device *dev;
> > +	struct clk *clk;
> > +	void __iomem *base;
> > +};
> > +
> > +static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip *=
chip)
> > +{
> > +	return container_of(chip, struct keembay_pwm, chip);
> > +}
> > +
> > +static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u=
32 mask,
> > +					   u32 val, u32 offset)
> > +{
> > +	u32 buff =3D readl(priv->base + offset);
> > +
> > +	buff =3D u32_replace_bits(buff, val, mask);
> > +	writel(buff, priv->base + offset);
> > +}
> > +
> > +static void keembay_pwm_enable(struct keembay_pwm *priv, int ch)
> > +{
> > +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
> > +				KMB_PWM_LEADIN_OFFSET(ch));
> > +}
> > +
> > +static void keembay_pwm_disable(struct keembay_pwm *priv, int ch)
> > +{
> > +	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
> > +				KMB_PWM_LEADIN_OFFSET(ch));
> > +}
> > +
> > +static void keembay_pwm_get_state(struct pwm_chip *chip, struct pwm_de=
vice *pwm,
> > +				  struct pwm_state *state)
> > +{
> > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > +	unsigned long long high, low;
> > +	unsigned long clk_rate;
> > +	u32 highlow;
> > +
> > +	clk_rate =3D clk_get_rate(priv->clk);
> > +
> > +	/* Read channel enabled status */
> > +	highlow =3D readl(priv->base + KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> > +	if (highlow & KMB_PWM_EN_BIT)
> > +		state->enabled =3D true;
> > +	else
> > +		state->enabled =3D false;
> > +
> > +	/* Read period and duty cycle */
> > +	highlow =3D readl(priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> > +	low =3D FIELD_GET(KMB_PWM_LOW_MASK, highlow) * NSEC_PER_SEC;
> > +	high =3D FIELD_GET(KMB_PWM_HIGH_MASK, highlow) * NSEC_PER_SEC;
> > +	state->duty_cycle =3D DIV_ROUND_UP_ULL(high, clk_rate);
> > +	state->period =3D DIV_ROUND_UP_ULL(high + low, clk_rate);
> > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > +}
> > +
> > +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +			     const struct pwm_state *state)
> > +{
> > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > +	struct pwm_state current_state;
> > +	unsigned long long div;
> > +	unsigned long clk_rate;
> > +	u32 pwm_count =3D 0;
> > +	u16 high, low;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -ENOSYS;
> > +
> > +	/*
> > +	 * Configure the pwm repeat count as infinite at (15:0) and leadin
> > +	 * low time as 0 at (30:16), which is in terms of clock cycles.
> > +	 */
> > +	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> > +				KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> > +
> > +	keembay_pwm_get_state(chip, pwm, &current_state);
> > +
> > +	if (!state->enabled) {
> > +		if (current_state.enabled)
> > +			keembay_pwm_disable(priv, pwm->hwpwm);
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * The upper 16 bits and lower 16 bits of the KMB_PWM_HIGHLOW_OFFSET
> > +	 * register contain the high time and low time of waveform accordingl=
y.
> > +	 * All the values are in terms of clock cycles.
> > +	 */
> > +
> > +	clk_rate =3D clk_get_rate(priv->clk);
> > +	div =3D clk_rate * state->duty_cycle;
> > +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC);
> > +	if (div > KMB_PWM_COUNT_MAX)
> > +		return -ERANGE;
> > +
> > +	high =3D div;
> > +	div =3D clk_rate * state->period;
> > +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC);
> > +	div =3D div - high;
> > +	if (div > KMB_PWM_COUNT_MAX)
> > +		return -ERANGE;
> > +
> > +	low =3D div;
> > +
> > +	pwm_count =3D FIELD_PREP(KMB_PWM_HIGH_MASK, high) |
> > +		    FIELD_PREP(KMB_PWM_LOW_MASK, low);
> > +
> > +	writel(pwm_count, priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
> > +
> > +	if (state->enabled && !current_state.enabled)
> > +		keembay_pwm_enable(priv, pwm->hwpwm);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops keembay_pwm_ops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.apply =3D keembay_pwm_apply,
> > +	.get_state =3D keembay_pwm_get_state,
> > +};
> > +
> > +static int keembay_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct keembay_pwm *priv;
> > +	int ret;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->clk =3D devm_clk_get(dev, NULL);
> > +	if (IS_ERR(priv->clk))
> > +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get clock\n=
");
> > +
> > +	ret =3D clk_prepare_enable(priv->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base)) {
>=20
> > +		clk_disable_unprepare(priv->clk);
>=20
> See below.
>=20
> > +		return PTR_ERR(priv->base);
> > +	}
> > +
> > +	priv->chip.base =3D -1;
> > +	priv->chip.dev =3D dev;
> > +	priv->chip.ops =3D &keembay_pwm_ops;
> > +	priv->chip.npwm =3D KMB_TOTAL_PWM_CHANNELS;
> > +
> > +	ret =3D pwmchip_add(&priv->chip);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
>=20
> > +		clk_disable_unprepare(priv->clk);
>=20
> This messes up with ordering of things.
>=20
> That's why devm golden rule is either all or none. You may fix this by
> switching to devm_add_action_or_reset().
>=20
> One of possible way is like in below drivers:
>=20
> 	% git grep -n devm_add_action_or_reset.*disable_unprepare -- drivers/
>=20
> But it may be fixed in follow up change. Depends on maintainers' wishes.

I recently sent a patch to address this in a still more comfortable way:

	https://lore.kernel.org/r/20201013082132.661993-1-u.kleine-koenig@pengutro=
nix.de

Other than that I don't think there is a real issue to fix here, yes,
the unroll order doesn't match the init order, but here this is about
ioremap vs clk_prepare_enable, so I'm fine with the status quo.

(I assume I didn't miss a real issue here. Please tell if so.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p7lj7w2fkz66s6lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+JPKQACgkQwfwUeK3K
7AmfqAf+N3+ecOBetoOMS8k626neZr+hlhuHihzI5Egys7fOcL4g9U55NDp63OFv
PjfmwObwLNUiLgloNkcSpuDFHLoU0VQiGG3fog1Jk986CR6tDoqGTLofqYXXPXLI
s/A0raPY+wrJpGopgjhmrYztRA35hIrV/GrUgdrcKSj8+lnuSMm1pAeybKtHZB5z
zrrO0Dpix77l1YLeJBeMXgwsVLDD25G+YNLj27zT+NyI2E8rX1JXKeUldp47AVab
VYSx6R4rVl3Y95dke9VOOGMtKbDok3UutfSOcwMT1nNv4nNVNIqcW3T4b3F2V1Jx
tVkKOK6YRjm2YpM3mhbGkPhFftZyLg==
=HggG
-----END PGP SIGNATURE-----

--p7lj7w2fkz66s6lv--
