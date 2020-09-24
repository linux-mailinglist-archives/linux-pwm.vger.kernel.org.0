Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC72769C2
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 08:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgIXGzm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 02:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXGzm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Sep 2020 02:55:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE950C0613CE
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2020 23:55:41 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kLLAG-0003Yl-9X; Thu, 24 Sep 2020 08:55:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kLLAE-0002Rk-8W; Thu, 24 Sep 2020 08:55:34 +0200
Date:   Thu, 24 Sep 2020 08:55:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v13 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200924065534.e2anwghhtysv63e7@pengutronix.de>
References: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
 <befa655d8beb326fc8aa405a25a8b3e62b7e6a4a.1600158087.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lyhi37rmvs6eew2s"
Content-Disposition: inline
In-Reply-To: <befa655d8beb326fc8aa405a25a8b3e62b7e6a4a.1600158087.git.rahul.tanwar@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lyhi37rmvs6eew2s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

(hhm Thierry already announced to have taken this patch, so my review is
late.)

On Tue, Sep 15, 2020 at 04:23:37PM +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> This PWM controller does not have any other consumer, it is a
> dedicated PWM controller for fan attached to the system. Add
> driver for this PWM fan controller.
>=20
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/pwm/Kconfig         |  11 ++
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-intel-lgm.c | 246 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 258 insertions(+)
>  create mode 100644 drivers/pwm/pwm-intel-lgm.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7dbcf6973d33..4949c51fe90b 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -232,6 +232,17 @@ config PWM_IMX_TPM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx-tpm.
> =20
> +config PWM_INTEL_LGM
> +	tristate "Intel LGM PWM support"
> +	depends on HAS_IOMEM
> +	depends on (OF && X86) || COMPILE_TEST
> +	select REGMAP_MMIO
> +	help
> +	  Generic PWM fan controller driver for LGM SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-intel-lgm.
> +
>  config PWM_IQS620A
>  	tristate "Azoteq IQS620A PWM support"
>  	depends on MFD_IQS62X || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 2c2ba0a03557..e9431b151694 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
>  obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
> +obj-$(CONFIG_PWM_INTEL_LGM)	+=3D pwm-intel-lgm.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
> diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
> new file mode 100644
> index 000000000000..ea3df75a5971
> --- /dev/null
> +++ b/drivers/pwm/pwm-intel-lgm.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Intel Corporation.
> + *
> + * Limitations:
> + * - The hardware supports fixed period which is dependent on 2/3 or 4
> + *   wire fan mode.

The driver now hardcodes 2-wire mode. IMHO that is worth mentioning.

> +static void lgm_clk_disable(void *data)
> +{
> +	struct lgm_pwm_chip *pc =3D data;
> +
> +	clk_disable_unprepare(pc->clk);
> +}
> +
> +static int lgm_clk_enable(struct device *dev, struct lgm_pwm_chip *pc)
> +{
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(pc->clk);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, lgm_clk_disable, pc);
> +}

My first reflex here was to point out that lgm_clk_disable() isn't the
counter part to lgm_clk_enable() and so lgm_clk_disable() needs
adaption. On a second look this is correct and so I think the function
names are wrong. The usual naming would be to use _release instead of
_disable. Having said that the enable function could be named
devm_clk_enable and live in drivers/clk/clk-devres.c. (Or
devm_clk_get_enabled()?)

> +static void lgm_reset_control_assert(void *data)
> +{
> +	struct lgm_pwm_chip *pc =3D data;
> +
> +	reset_control_assert(pc->rst);
> +}
> +
> +static int lgm_reset_control_deassert(struct device *dev, struct lgm_pwm=
_chip *pc)
> +{
> +	int ret;
> +
> +	ret =3D reset_control_deassert(pc->rst);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, lgm_reset_control_assert, pc);
> +}

A similar comment applies here.

> +static int lgm_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct lgm_pwm_chip *pc;
> +	void __iomem *io_base;
> +	int ret;
> +
> +	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> +	if (!pc)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pc);
> +
> +	io_base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> +
> +	pc->regmap =3D devm_regmap_init_mmio(dev, io_base, &lgm_pwm_regmap_conf=
ig);
> +	if (IS_ERR(pc->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pc->regmap),
> +				     "failed to init register map\n");
> +
> +	pc->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(pc->clk))
> +		return dev_err_probe(dev, PTR_ERR(pc->clk), "failed to get clock\n");
> +
> +	ret =3D lgm_clk_enable(dev, pc);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");

You used dev_err_probe four times for six error paths. I wonder why you
didn't use it here (and below for a failing pwmchip_add()).

> +		return ret;
> +	}
> +
> +	pc->rst =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pc->rst))
> +		return dev_err_probe(dev, PTR_ERR(pc->rst),
> +				     "failed to get reset control\n");
> +
> +	ret =3D lgm_reset_control_deassert(dev, pc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot deassert reset control\n");

After lgm_reset_control_deassert is called pc->rst is unused. So there
is no need to have this member in struct lgm_pwm_chip. The same applies
to ->clk. (You have to pass rst (or clk) to devm_add_action_or_reset for
that to work. Looks like a nice idea anyhow.)

> +	pc->chip.dev =3D dev;
> +	pc->chip.ops =3D &lgm_pwm_ops;
> +	pc->chip.npwm =3D 1;

pc->chip.base should probably be set to -1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lyhi37rmvs6eew2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9sQuMACgkQwfwUeK3K
7AnOoQf9G5gIg3fUua32ajP2OiSRucao6yYZO6ublycEcs/7NSXp3KWtQtLwla0z
q+/cPupbA7DqmXLmAOWPqBnsWG4JFXK/KUUb9gQhuZstKPccDgz+VmgFpXchzkw/
g9lTMItQvExjVvwfSqUdU65cxPfEa4uOrRjcB0GNW8E1AztgXIaR36lEgPjuQPWV
GXJL9gklmnyPoSRjdwY8FXYWeJlXCJjK0qvRKoXQZbWODi6wcQOQUcf6Nc/Q/2zo
XlZLWz8Hs4D814jxHCuc8jWcVHZhZx91IF/ujkzFh7c+k3MuU10b/amvPCckbebu
7Qzh9E8mx+Rb2gL1F8dtdPCPzy/Hkg==
=hGAM
-----END PGP SIGNATURE-----

--lyhi37rmvs6eew2s--
