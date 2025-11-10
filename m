Return-Path: <linux-pwm+bounces-7606-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3151AC46819
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 13:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F169718848AC
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Nov 2025 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E9630FC33;
	Mon, 10 Nov 2025 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw2Cp2OV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380030C378;
	Mon, 10 Nov 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776572; cv=none; b=iJ/hJS31DD4eWZomrPiuSOmZJc17PKPfw81jF6BacNLMpprMjcTAC5SM3FzB0/G3EMOqsX7sXy/7uvW9fghOK6+UzjVk7OzrjTRakOvgHDSupbFarV4Gsy31Mh/fLwJC6aNElsCffYz8qRRHg6e5pOxF+sURyVC0KSgRRtcyiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776572; c=relaxed/simple;
	bh=XrGN288uPItkrjhZH0VvpFLM0/u28Yzy4ppr+etlIDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5qtBPq8jNMhDi9L8twlPi+sGlvy4tcXKcbVdjv0gFwCjsMXSON2t16I09LFcc2Fi6bpTs+WKP5Jin6cMVf2HRzIcO6ymMwYpFnIkwanhwE/tjlj648XyqJgZbtGri0DsKGingaUmL6YPFmLMNPb6CWdY/aCgtO4am1D+V35cEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw2Cp2OV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC75C4CEFB;
	Mon, 10 Nov 2025 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762776571;
	bh=XrGN288uPItkrjhZH0VvpFLM0/u28Yzy4ppr+etlIDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uw2Cp2OVsvFD1zG8ewyCx5CI0fvGaK4GwJPVlSNY/ENJPy9CMc7J/Vp2qARXJDCyN
	 BJUFeDtNu5zn8yhQWBt9TcIPh4o5MC9i4y3dYyFgg3LU6eLJfYOLNzjPenrzumndO7
	 Fxvbc31bjIfkSaUthmBNOn2W3XwIinr75ogReLD9ltn8n6pR6l+j++I3WXFbAUWUtE
	 K66hA9hKzDC+FVemZIkB5WJtO6dtNzEBsr/O6BUXiTkdZKJBlFWg6gRQStlRUbjf4E
	 l0sQCdFniX6rKUphujcJtXa177ih7xxXw7kjL5Y+fRG4lM68lUCmOj2+VXqyaZkwDt
	 k8Oukg6UIza1g==
Date: Mon, 10 Nov 2025 13:09:28 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: george.moussalem@outlook.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Baruch Siach <baruch@tkos.co.il>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Devi Priya <quic_devipriy@quicinc.com>, Baruch Siach <baruch.siach@siklu.com>
Subject: Re: [PATCH v18 2/6] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <5rppg4xop5mrxe3gaiow4oyg5zqywx6iywz2vlf3wig7rjwo75@mgftj2h3ab4u>
References: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
 <20251029-ipq-pwm-v18-2-edbef8efbb8e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6hi5iuz7dweh53os"
Content-Disposition: inline
In-Reply-To: <20251029-ipq-pwm-v18-2-edbef8efbb8e@outlook.com>


--6hi5iuz7dweh53os
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v18 2/6] pwm: driver for qualcomm ipq6018 pwm block
MIME-Version: 1.0

Hello George,

On Wed, Oct 29, 2025 at 12:36:58PM +0400, George Moussalem via B4 Relay wro=
te:
> From: Devi Priya <quic_devipriy@quicinc.com>
>=20
> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
> driver from downstream Codeaurora kernel tree. Removed support for older
> (V1) variants because I have no access to that hardware.
>=20
> Tested on IPQ5018 and IPQ6010 based hardware.
>=20
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
> v17:
>=20
>   Removed unnecessary code comments
>=20
> v16:
>=20
>   Simplified code to calculate divs and duty cycle as per Uwe's comments
>=20
>   Removed unused pwm_chip struct from ipq_pwm_chip struct
>=20
>   Removed unnecessary cast as per Uwe's comment
>=20
>   Replaced devm_clk_get & clk_prepare_enable by devm_clk_get_enabled
>=20
>   Replaced pwmchip_add by devm_pwmchip_add and removed .remove function
>=20
>   Removed .owner from driver struct
>=20
> v15:
>=20
>   No change
>=20
> v14:
>=20
>   Picked up the R-b tag
>=20
> v13:
>=20
>   Updated the file name to match the compatible
>=20
>   Sorted the properties and updated the order in the required field
>=20
>   Dropped the syscon node from examples
>=20
> v12:
>=20
>   Picked up the R-b tag
>=20
> v11:
>=20
>   No change
>=20
> v10:
>=20
>   No change
>=20
> v9:
>=20
>   Add 'ranges' property to example (Rob)
>=20
>   Drop label in example (Rob)
>=20
> v8:
>=20
>   Add size cell to 'reg' (Rob)
>=20
> v7:
>=20
>   Use 'reg' instead of 'offset' (Rob)
>=20
>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
>=20
>   Use single cell address/size in example node (Bjorn)
>=20
>   Move '#pwm-cells' lower in example node (Bjorn)
>=20
>   List 'reg' as required
>=20
> v6:
>=20
>   Device node is child of TCSR; remove phandle (Rob Herring)
>=20
>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-K=C3=B6nig)
>=20
> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>     Andersson, Kathiravan T)
>=20
> v4: Update the binding example node as well (Rob Herring's bot)
>=20
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>=20
> v2: Make #pwm-cells const (Rob Herring)
> ---
>  drivers/pwm/Kconfig   |  12 +++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-ipq.c | 212 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 225 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0b47456e2d57bbdda54b1318911994812e315612..e9bdb7f3b8114db4b15ce0488=
fbf0b78aad7625f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -337,6 +337,18 @@ config PWM_INTEL_LGM
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
> index aed403f0a42b339778c37150007635d7efccfd51..8611373257cb88e1b4f762b15=
a59ff265aff0173 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_INTEL_LGM)	+=3D pwm-intel-lgm.o
> +obj-$(CONFIG_PWM_IPQ)		+=3D pwm-ipq.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..bd6b3ad86596e3c5b19f80f97=
fe7913a8ce2d940
> --- /dev/null
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserv=
ed.
> + */

Many drivers describe some basic properties here in a paragraph that
(for history reasons) is titled "Limitations". Questions to answer are:
 - Can glitches happen on configuration?
 - Is the currently running period completed on reconfiguration?=20
 - Is the currently running period completed on disable?
 - What happens on disable? (constant low output? High-Z?)

Look e.g. into pwm-sl28cpld.c for how to format that.

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/math64.h>
> +#include <linux/of_device.h>
> +#include <linux/bitfield.h>
> +#include <linux/units.h>
> +
> +/* The frequency range supported is 1 Hz to clock rate */
> +#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
> +
> +/*
> + * The max value specified for each field is based on the number of bits
> + * in the pwm control register for that field
> + */
> +#define IPQ_PWM_MAX_DIV		0xFFFF
> +
> +/*
> + * Two 32-bit registers for each PWM: REG0, and REG1.
> + * Base offset for PWM #i is at 8 * #i.
> + */
> +#define IPQ_PWM_REG0			0
> +#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
> +#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
> +
> +#define IPQ_PWM_REG1			4
> +#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)

empty line here please

> +/*
> + * Enable bit is set to enable output toggling in pwm device.
> + * Update bit is set to reflect the changed divider and high duration
> + * values in register.
> + */
> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
> +
> +struct ipq_pwm_chip {
> +	struct clk *clk;
> +	void __iomem *mem;
> +};
> +
> +static struct ipq_pwm_chip *ipq_pwm_from_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned in=
t reg)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(pwm->chip);
> +	unsigned int off =3D 8 * pwm->hwpwm + reg;
> +
> +	return readl(ipq_chip->mem + off);
> +}
> +
> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned int reg,
> +			      unsigned int val)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(pwm->chip);
> +	unsigned int off =3D 8 * pwm->hwpwm + reg;
> +
> +	writel(val, ipq_chip->mem + off);
> +}
> +
> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre=
_div,
> +				unsigned int pwm_div, unsigned long rate, u64 duty_ns,
> +				bool enable)
> +{
> +	unsigned long hi_dur;
> +	unsigned long val =3D 0;
> +
> +	/*
> +	 * high duration =3D pwm duty * (pwm div + 1)
> +	 * pwm duty =3D duty_ns / period_ns
> +	 */
> +	hi_dur =3D div64_u64(duty_ns * rate, (pre_div + 1) * NSEC_PER_SEC);

Better use mul_u64_u64_div_u64() here to prevent duty_ns * rate
overflowing.

> +	val =3D FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG0, val);
> +
> +	val =3D FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);

I guess these writes only take effect after IPQ_PWM_REG1_UPDATE is set?

> +	/* PWM enable toggle needs a separate write to REG1 */
> +	val |=3D IPQ_PWM_REG1_UPDATE;
> +	if (enable)
> +		val |=3D IPQ_PWM_REG1_ENABLE;
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
> +}
> +
> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(chip);
> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> +	unsigned int pre_div, pwm_div;
> +	u64 period_ns, duty_ns;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC, rate))
> +		return -ERANGE;
> +
> +	if ((unsigned long long)rate > 16ULL * GIGA)
> +		return -EINVAL;

What is this check for?=20
> +
> +	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> +	duty_ns =3D min(state->duty_cycle, period_ns);
> +
> +	/* Restrict pwm_div to 0xfffe */

Please sketch the reason for that in the comment, too.

> +	pwm_div =3D IPQ_PWM_MAX_DIV - 1;
> +	pre_div =3D DIV64_U64_ROUND_UP(period_ns * rate, (u64)NSEC_PER_SEC * (p=
wm_div + 1));
> +
> +	if (pre_div > IPQ_PWM_MAX_DIV)
> +		return -ERANGE;

If a too big period is requested just pick the biggest possible period.

	if (pre_div > IPQ_PWM_MAX_DIV)
		pre_div =3D IPQ_PWM_MAX_DIV;

If you assert that rate =E2=89=A4 0xffff * NSEC_PER_SEC you can use

	pre_div =3D mul_u64_u64_div_u64(state->period, rate, (u64)NSEC_PER_SEC * (=
pwm_div + 1))

without limiting period to IPQ_PWM_MAX_PERIOD_NS first.

> +	config_div_and_duty(pwm, pre_div, pwm_div, rate, duty_ns, state->enable=
d);
> +
> +	return 0;
> +}
> +
> +static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip =3D ipq_pwm_from_chip(chip);
> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> +	unsigned int pre_div, pwm_div, hi_dur;
> +	u64 effective_div, hi_div;
> +	u32 reg0, reg1;
> +
> +	reg0 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_REG0);
> +	reg1 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_REG1);
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	state->enabled =3D reg1 & IPQ_PWM_REG1_ENABLE;

You're allowed to skip calculating .period and .duty_cycle (and even
reading IPQ_PWM_REG0) if IPQ_PWM_REG1_ENABLE is unset.

> +	pwm_div =3D FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
> +	hi_dur =3D FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
> +	pre_div =3D FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
> +
> +	/* No overflow here, both pre_div and pwm_div <=3D 0xffff */
> +	effective_div =3D (pre_div + 1) * (pwm_div + 1);
> +	state->period =3D DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC, rate=
);
> +
> +	hi_div =3D hi_dur * (pre_div + 1);
> +	state->duty_cycle =3D DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC, rate);

Please make sure to return a valid config here, i.e. cope for
IPQ_PWM_REG0_HI_DURATION > IPQ_PWM_REG0_PWM_DIV + 1.

> +	return 0;
> +}
> +
> +static const struct pwm_ops ipq_pwm_ops =3D {
> +	.apply =3D ipq_pwm_apply,
> +	.get_state =3D ipq_pwm_get_state,
> +};
> +
> +static int ipq_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct ipq_pwm_chip *pwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, 4, sizeof(*pwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	pwm =3D ipq_pwm_from_chip(chip);
> +
> +	pwm->mem =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->mem))
> +		return dev_err_probe(dev, PTR_ERR(pwm->mem),
> +				"regs map failed");

"Failed to map registers\n" please. Start with a capital letter and add
a trailing \n for the other messages, too, please.

> +
> +	pwm->clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +				"failed to get clock");

Please add a call to devm_clk_rate_exclusive_get() here.

> +	chip->ops =3D &ipq_pwm_ops;
> +	chip->npwm =3D 4;

Don't assign .npwm here. This is already cared for by the call to
devm_pwmchip_alloc() above.

> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to add pwm chip\n");
> +
> +	return ret;
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
> +		.of_match_table =3D pwm_ipq_dt_match,
> +	},
> +	.probe =3D ipq_pwm_probe,
> +};
> +
> +module_platform_driver(ipq_pwm_driver);
> +
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--6hi5iuz7dweh53os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkR1fUACgkQj4D7WH0S
/k7HzQf/Vj+6ITdZebeV72mNX8kaodrCpudU5kOUwmF0rjhoUD8CHxumn1aKwCQH
wSHMEJwFfJx1d89i5yM7C1LwbBSnGBYi8baQQaSNRRAxSluiCEWRCfNirJ+ikvp5
XN+gEvoby3G1tisqejA3+CAGjUFCCEIF6fjnszhwdD/eEfOLjlkE/T8w1Wb71Ul4
xJpxqeUBwHv6JBMani8yrX7SN5d8SkDZRkME9k0rKA++AH4fZB3W+jSCrg3goJ26
6dyYHOfJK0ka2yfOSlWS5No/4dV8z9rjnQYdn0cmj0be7xWoVNXf2tbIMtdoSAmj
pUeREielkpmEzxIzLZH/upb2Ize0xw==
=buTX
-----END PGP SIGNATURE-----

--6hi5iuz7dweh53os--

