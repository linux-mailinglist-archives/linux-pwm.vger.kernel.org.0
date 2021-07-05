Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55CB3BB7B2
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jul 2021 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhGEHXo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Jul 2021 03:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGEHXo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Jul 2021 03:23:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37EFC061574
        for <linux-pwm@vger.kernel.org>; Mon,  5 Jul 2021 00:21:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0IuX-0003wC-UY; Mon, 05 Jul 2021 09:20:57 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0IuV-0006YR-Ia; Mon, 05 Jul 2021 09:20:55 +0200
Date:   Mon, 5 Jul 2021 09:20:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <20210705072055.5mvux5h6zdewzabz@pengutronix.de>
References: <305eacc9c57c2404795b6be76a08915808e23108.1624771446.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3r25sk2paghtmnoo"
Content-Disposition: inline
In-Reply-To: <305eacc9c57c2404795b6be76a08915808e23108.1624771446.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3r25sk2paghtmnoo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

On Sun, Jun 27, 2021 at 08:24:04AM +0300, Baruch Siach wrote:
> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
> driver from downstream Codeaurora kernel tree. Removed support for older
> (V1) variants because I have no access to that hardware.
>=20
> Tested on IPQ6010 based hardware.
>=20
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v4:
>=20
>   Use div64_u64() to fix link for 32-bit targets ((kernel test robot
>   <lkp@intel.com>, Uwe Kleine-K=F6nig)
>=20
> v3:
>=20
>   s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>=20
>   Fix integer overflow on 32-bit targets (kernel test robot <lkp@intel.co=
m>)
>=20
> v2:
>=20
> Address Uwe Kleine-K=F6nig review comments:
>=20
>   Fix period calculation when out of range
>=20
>   Don't set period larger than requested
>=20
>   Remove PWM disable on configuration change
>=20
>   Implement .apply instead of non-atomic .config/.enable/.disable
>=20
>   Don't modify PWM on .request/.free
>=20
>   Check pwm_div underflow
>=20
>   Fix various code and comment formatting issues
>=20
> Other changes:
>=20
>   Use u64 divisor safe division
>=20
>   Remove now empty .request/.free
> ---
>  drivers/pwm/Kconfig   |  12 +++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-ipq.c | 238 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 251 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ipq.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c76adedd58c9..08add845596f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -260,6 +260,18 @@ config PWM_INTEL_LGM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-intel-lgm.
> =20
> +config PWM_IPQ
> +	tristate "IPQ PWM support"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on HAVE_CLK && HAS_IOMEM
> +	help
> +	  Generic PWM framework driver for IPQ PWM block which supports
> +	  4 pwm channels. Each of the these channels can be configured
> +	  independent of each other.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ipq.
> +
>  config PWM_IQS620A
>  	tristate "Azoteq IQS620A PWM support"
>  	depends on MFD_IQS62X || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..7402feae4b36 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_INTEL_LGM)	+=3D pwm-intel-lgm.o
> +obj-$(CONFIG_PWM_IPQ)		+=3D pwm-ipq.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> new file mode 100644
> index 000000000000..966b051573c8
> --- /dev/null
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserv=
ed.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/of_device.h>
> +
> +#define CLK_SRC_FREQ		(100*1000*1000)
> +#define MAX_PWM_DEVICES		4

MAX_PWM_DEVICES is only used once, in my book this doesn't need a define
then. (But if you still want to keep it, that's fine for me, too.)

> +/*
> + * Enable bit is set to enable output toggling in pwm device.
> + * Update bit is set to reflect the changed divider and high duration
> + * values in register.
> + */
> +#define PWM_ENABLE		0x80000000
> +#define PWM_UPDATE		0x40000000
> +
> +/* The frequency range supported is 1Hz to 100MHz */
> +#define MIN_PERIOD_NS	10
> +#define MAX_PERIOD_NS	1000000000

Please use a driver prefix for these defines.

> +
> +/*
> + * The max value specified for each field is based on the number of bits
> + * in the pwm control register for that field
> + */
> +#define MAX_PWM_CFG		0xFFFF
> +
> +#define PWM_CTRL_HI_SHIFT	16
> +
> +#define PWM_CFG_REG0 0 /*PWM_DIV PWM_HI*/
> +#define PWM_CFG_REG1 1 /*ENABLE UPDATE PWM_PRE_DIV*/
> +
> +struct ipq_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	void __iomem *mem;
> +};
> +
> +static struct ipq_pwm_chip *to_ipq_pwm_chip(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct ipq_pwm_chip, chip);
> +}
> +
> +static unsigned ipq_pwm_reg_offset(struct pwm_device *pwm, unsigned reg)
> +{
> +	return ((pwm->hwpwm * 2) + reg) * 4;
> +}
> +
> +static void config_div_and_duty(struct pwm_device *pwm, int pre_div,
> +			unsigned long long pwm_div, unsigned long period_ns,
> +			unsigned long long duty_ns)

Please also use a consistent prefix for function names.

I suggest to use u64 for some of the parameters. While this doesn't
change anything, it is cleaner as the caller passes variables of this
type.

> +{
> +	unsigned long hi_dur;
> +	unsigned long long quotient;
> +	unsigned long val =3D 0;
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(pwm->chip);
> +
> +	/*
> +	 * high duration =3D pwm duty * (pwm div + 1)
> +	 * pwm duty =3D duty_ns / period_ns
> +	 */
> +	quotient =3D (pwm_div + 1) * duty_ns;
> +	hi_dur =3D div64_u64(quotient, period_ns);
> +
> +	val |=3D ((hi_dur & MAX_PWM_CFG) << PWM_CTRL_HI_SHIFT);
> +	val |=3D (pwm_div & MAX_PWM_CFG);
> +	writel(val, ipq_chip->mem + ipq_pwm_reg_offset(pwm, PWM_CFG_REG0));

I consider it a bit irritating that the mask is called ...CFG but the
shift define is called ..._CTRL_....

I suggest something like:

	#define IPQ_PWM_REG0	...
	#define IPQ_PWM_REG0_HI		0xffff0000
	#define IPQ_PWM_REG0_DIV	0x0000ffff

	...

	val =3D FIELD_PREP(IPQ_PWM_REG0_HI, hi_dur) |
		FIELD_PREP(IPQ_PWM_REG0_DIV, pwm_div);

	ipq_pwm_writel(ipq_chip, val, PWM_CFG_REG0);

> +	val =3D pre_div & MAX_PWM_CFG;
> +	writel(val, ipq_chip->mem + ipq_pwm_reg_offset(pwm, PWM_CFG_REG1));
> +}
> +
> +static int ipq_pwm_enable(struct pwm_device *pwm)

This is only called once. The caller (ipq_pwm_apply()) just before
called config_div_and_duty() which already wrote PWM_CFG_REG1. If you
unroll these calls you might fix a glitch or make it more unlikely.

> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(pwm->chip);
> +	unsigned offset =3D ipq_pwm_reg_offset(pwm, PWM_CFG_REG1);
> +	unsigned long val;
> +
> +	val =3D readl(ipq_chip->mem + offset);
> +	val |=3D PWM_ENABLE | PWM_UPDATE;
> +	writel(val, ipq_chip->mem + offset);
> +
> +	return 0;
> +}
> +
> +static void ipq_pwm_disable(struct pwm_device *pwm)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(pwm->chip);
> +	unsigned offset =3D ipq_pwm_reg_offset(pwm, PWM_CFG_REG1);
> +	unsigned long val;
> +
> +	val =3D readl(ipq_chip->mem + offset);
> +	val |=3D PWM_UPDATE;
> +	val &=3D ~PWM_ENABLE;
> +	writel(val, ipq_chip->mem + offset);
> +}
> +
> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(chip);
> +	unsigned long freq;
> +	int pre_div, close_pre_div, close_pwm_div;
> +	int pwm_div;
> +	long long diff;
> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> +	unsigned long min_diff =3D rate;
> +	uint64_t fin_ps;
> +	u64 period_ns, duty_ns;
> +
> +	if (state->period < MIN_PERIOD_NS)
> +		return -ERANGE;

MIN_PERIOD_NS depends on clk_get_rate(ipq_chip->clk), doesn't it?

> +	period_ns =3D min_t(u64, state->period, MAX_PERIOD_NS);
> +	duty_ns =3D min_t(u64, state->duty_cycle, period_ns);

If you define MAX_PERIOD_NS as (u64)1000000000 you can just use min().

> +
> +	/* freq in Hz for period in nano second*/

Space before the closing */ please

> +	freq =3D div64_u64(NSEC_PER_SEC, period_ns);
> +	fin_ps =3D div64_u64(NSEC_PER_SEC * 1000ULL, rate);
> +	close_pre_div =3D MAX_PWM_CFG;
> +	close_pwm_div =3D MAX_PWM_CFG;
> +
> +	for (pre_div =3D 0; pre_div <=3D MAX_PWM_CFG; pre_div++) {
> +		pwm_div =3D DIV64_U64_ROUND_CLOSEST(period_ns * 1000,
> +						  fin_ps * (pre_div + 1));
> +		pwm_div--;
> +		if (pwm_div < 0 || pwm_div > MAX_PWM_CFG)
> +			continue;
> +
> +		diff =3D ((uint64_t)freq * (pre_div + 1) * (pwm_div + 1))
> +			- (uint64_t)rate;
> +
> +		if (diff < 0) /* period larger than requested */
> +			continue;
> +		if (diff =3D=3D 0) { /* bingo */
> +			close_pre_div =3D pre_div;
> +			close_pwm_div =3D pwm_div;
> +			break;
> +		}
> +		if (diff < min_diff) {
> +			min_diff =3D diff;
> +			close_pre_div =3D pre_div;
> +			close_pwm_div =3D pwm_div;
> +		}

I didn't check deeply, but I assume this calculation can be done more
efficiently. Also I wonder if DIV64_U64_ROUND_CLOSEST is right. When you
implement a .get_state() callback (which usually helps me to understand
how the hardware works) I'm willing to take a closer look.

> +	}
> +
> +	/* config divider values for the closest possible frequency */
> +	config_div_and_duty(pwm, close_pre_div, close_pwm_div,
> +			    period_ns, duty_ns);
> +	if (state->enabled)
> +		ipq_pwm_enable(pwm);
> +	else
> +		ipq_pwm_disable(pwm);
> +
> +	return 0;
> +}
> +
> +static struct pwm_ops ipq_pwm_ops =3D {
> +	.apply =3D ipq_pwm_apply,

Please implement a .get_state() function. (And in general, test your patch
with PWM_DEBUG enabled.)

> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int ipq_pwm_probe(struct platform_device *pdev)
> +{
> +	struct ipq_pwm_chip *pwm;
> +	struct device *dev;
> +	int ret;
> +
> +	dev =3D &pdev->dev;

This can go to the line declaring dev.

> +	pwm =3D devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	pwm->mem =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->mem))
> +		return PTR_ERR(pwm->mem);
> +
> +	pwm->clk =3D devm_clk_get(dev, "core");
> +	if (IS_ERR(pwm->clk))

Error message please. Preferably using dev_err_probe().

> +		return PTR_ERR(pwm->clk);
> +
> +	ret =3D clk_set_rate(pwm->clk, CLK_SRC_FREQ);
> +	if (ret)

ditto.

> +		return ret;

empty line here?

> +	ret =3D clk_prepare_enable(pwm->clk);
> +	if (ret)

ditto.

> +		return ret;
> +
> +	pwm->chip.dev =3D dev;
> +	pwm->chip.ops =3D &ipq_pwm_ops;
> +	pwm->chip.npwm =3D MAX_PWM_DEVICES;
> +
> +	ret =3D pwmchip_add(&pwm->chip);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "pwmchip_add() failed\n");
> +		clk_disable_unprepare(pwm->clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ipq_pwm_remove(struct platform_device *pdev)
> +{
> +	struct ipq_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> +
> +	pwmchip_remove(&pwm->chip);

clk_disable_unprepare missing here.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id pwm_ipq_dt_match[] =3D {
> +	{ .compatible =3D "qcom,ipq6018-pwm", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
> +
> +static struct platform_driver ipq_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "ipq-pwm",
> +		.owner =3D THIS_MODULE,

Setting owner isn't necessary any more since v3.11 (commit 9447057eaff8
("platform_device: use a macro instead of platform_driver_register").

> +		.of_match_table =3D pwm_ipq_dt_match,
> +	},
> +	.probe =3D ipq_pwm_probe,
> +	.remove =3D ipq_pwm_remove,
> +};
> +
> +module_platform_driver(ipq_pwm_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> --=20
> 2.30.2
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3r25sk2paghtmnoo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDistQACgkQwfwUeK3K
7AmIfwf/c+s+Q3cnq1VOQMgIICX2BHS7UOXrukPHXbX6wkuAChPD3CGM1BASDKkd
Fc67pZC/1++O7Kw+iXmamWkkBjt4QSqICe15NbW4ScSx9SBnCpORb2ngpOaLdzl9
rKKp498T67btim2EE15xwqI5iLMyljlXEQxsFcmA7STe5ctQx3GgvPHY9bbrGau+
q2wHzgp04U1tmFXlHNxmMWVrec4tndvcW6nKPL1lZAs4h6N1oNHwVykaZDVcvTxl
/NH9dkWW+3IOiwKFnIeMIBYPvHohRaSZ+yTD8lTTk++yzK2GjaMxHUBTWDadu55J
VnnsvoHTf+404EsVF8gNhnXu26Vg0w==
=xkHO
-----END PGP SIGNATURE-----

--3r25sk2paghtmnoo--
