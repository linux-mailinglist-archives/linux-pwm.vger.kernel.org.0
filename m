Return-Path: <linux-pwm+bounces-7942-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C288D3B1FD
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 17:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D54F3315319A
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084FA3ACEEC;
	Mon, 19 Jan 2026 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcTZj20V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E83ACEE4;
	Mon, 19 Jan 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840213; cv=none; b=a8cHpeWYidkD3gOLuk+TQcRsIEPxXKl0UMEONpyevPxA/HE0JlNLNRkbbt7Q/i88/FZc/gcH3hbpXG+4001JMJYXfYFdjesOQ+jjxcUHVAO1aoEJC14D4PXDMLAfYLsz0oUFy9+NhcmQICFevtKGvyDV9hY6r5vAf5RuaXMTBKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840213; c=relaxed/simple;
	bh=y0O6uLcQSS+dr6+IkVEKdp5NE1y2dYkf/EkDIouxOkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyqWEFK9IaVFbAUBnMJQmhFnap3wCLVtt1gyaHnJzlLH6sYerbG02+XCV+qMeh74DqZUcQlU1P5uo+ZWvtLp36t7IfVIMXWc4m5O57IKeZYmXIg6+khnOkTXRn0/VqLTH8ofMBXe1jowgKhoDwhSvlHIKgkw/cGMOMMp1ctX2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcTZj20V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F007CC19425;
	Mon, 19 Jan 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840213;
	bh=y0O6uLcQSS+dr6+IkVEKdp5NE1y2dYkf/EkDIouxOkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcTZj20VXKx3CmwEDj8omLU4BKPQZigQs2ykd1uB34yTphQi+odPNoTttXLhVIsRS
	 /9ViwwqnjeNM8Hldye5lXCbyAIBy2SZugbQExtkvLsw+bojzoWzttZYK2JF810Qzx6
	 qo30jLpLQYUOOhrsZ1y5MT+M1BOffFEzJ3LzJDFb/z3n7iTctzfifx4tlJNDPB3l+P
	 fL2BYNk3S1+mCIEkPSXyrh8Ce2lyKSKnOyXBJ5T82M2xOC3vzk6J+lpnwI167ybhvV
	 GqqS334TRam+g9o/VI+oJBNPyyh/olTHFjhbeQ1kUiA38RbFtkVtJvIOjjrPGw2302
	 MXmRYAUQ460rw==
Date: Mon, 19 Jan 2026 17:30:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: george.moussalem@outlook.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Baruch Siach <baruch@tkos.co.il>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Devi Priya <quic_devipriy@quicinc.com>, Baruch Siach <baruch.siach@siklu.com>
Subject: Re: [PATCH v19 2/6] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <eajmwhwb2wd3ts4fpbu262uscqqddns3o5rf4b2jeswugpgmao@sdtx5hkqxz62>
References: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
 <20251128-ipq-pwm-v19-2-13bc704cc6a5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="slf5ta6uz6bbwq2y"
Content-Disposition: inline
In-Reply-To: <20251128-ipq-pwm-v19-2-13bc704cc6a5@outlook.com>


--slf5ta6uz6bbwq2y
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v19 2/6] pwm: driver for qualcomm ipq6018 pwm block
MIME-Version: 1.0

Hello,

On Fri, Nov 28, 2025 at 02:29:14PM +0400, George Moussalem via B4 Relay wro=
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
> v18:
>=20
>   Added hardware notes and limitations based on own findings as
>   requested. NOTE: there's no publically available datasheet though.
>=20
>   Expanded comment on REG1_UPDATE to indicate that when this bit is set,
>   values for div and pre-div take effect. The hardware automatically
>   unsets it when the change is completed.
>=20
>   Added newline between MACRO definition and next comment
>=20
>   In config_div_and_duty, used mul_u64_u64_div_u64 to avoid overflow
>=20
>   Removed unncessary restriction of pwm_div to MAX_DIV - 1 after testing
>=20
>   Constrain pre_div to MAX_DIV is pre_div calculated is > MAX_DIV
>=20
>   Use of mul_u64_u64_div_u64 in .apply
>=20
>   Skip calculation of period and duty cycle when PWM_ENABLE REG is unset
>=20
>   Set duty cycle to period value when calculated duty cycle > period to
>   return a valid config
>=20
>   Removed .npwm as it's taken care of in devm_pwmchip_alloc
>=20
>   Added call to devm_clk_rate_exclusive_get to lock the clock rate
>=20
>   Start all kernel messages with a capital letter and end with \n.
>=20
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
>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-K=F6nig)
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
>  drivers/pwm/pwm-ipq.c | 239 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 252 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index bf2d101f67a1e0ae12a58b5630abd5cfd77ccc99..6393f4e91697ae471b1aba72e=
7ef3f94c5e18383 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -347,6 +347,18 @@ config PWM_INTEL_LGM
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
> index 0dc0d2b69025dbd27013285cd335d3cb1ca2ab3f..5630a521a7cffeb83ff8c8960=
e15eb23ddb1c9f8 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+=3D pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+=3D pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_INTEL_LGM)	+=3D pwm-intel-lgm.o
> +obj-$(CONFIG_PWM_IPQ)		+=3D pwm-ipq.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9955b185bc60f27d770f3833d=
5acd7f587595324
> --- /dev/null
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserv=
ed.
> + *
> + * Hardware notes / Limitations:
> + * - The PWM controller has no publicly available datasheet.
> + * - Each of the four channels is programmed via two 32-bit registers
> + *   (REG0 and REG1 at 8-byte stride).
> + * - Period and duty-cycle reconfiguration is fully atomic: new divider,
> + *   pre-divider, and high-duration values are latched by setting the
> + *   UPDATE bit (bit 30 in REG1). The hardware applies the new settings
> + *   at the beginning of the next period without disabling the output,
> + *   so the currently running period is always completed.
> + * - On disable (clearing the ENABLE bit 31 in REG1), the hardware
> + *   finishes the current period before stopping the output. The pin
> + *   is then driven to the inactive (low) level.
> + * - Upon disabling, the hardware resets the pre-divider (PRE_DIV) and d=
ivider
> + *   fields (PWM_DIV) in REG0 and REG1 to 0x0000 and 0x0001 respectively.
> + * - Only normal polarity is supported.
> + */
> +
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

This is used below with:
	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);

Where does this limitation come from?

> +/*
> + * The max value specified for each field is based on the number of bits
> + * in the pwm control register for that field
> + */
> +#define IPQ_PWM_MAX_DIV		0xFFFF

Maybe use (depending on context) FIELD_MAX(IPQ_PWM_REG0_PWM_DIV) or
FIELD_MAX(IPQ_PWM_REG1_PRE_DIV).

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
> +
> +/*
> + * Enable bit is set to enable output toggling in pwm device.
> + * Update bit is set to trigger the change and is unset automatically
> + * to reflect the changed divider and high duration values in register.
> + */
> +#define IPQ_PWM_REG1_UPDATE		BIT(30)
> +#define IPQ_PWM_REG1_ENABLE		BIT(31)
> +
> +struct ipq_pwm_chip {
> +	struct clk *clk;

you're using clk_rate_exclusive_get(), so it's enough to call
clk_get_rate() once. Then you can store the rate here instead of the
clk itself.

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

Missing name prefix (i.e. rename to ipq_pwm_config_div_and_duty(), or
maybe even better: fold into ipq_pwm_apply()).

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
> +	hi_dur =3D mul_u64_u64_div_u64(duty_ns, rate, (pre_div + 1) * NSEC_PER_=
SEC);

With pre_div =3D 0xffff the multiplication in the 3rd parameter overflows.

> +	val =3D FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG0, val);
> +
> +	val =3D FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
> +
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
> +	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> +	duty_ns =3D min(state->duty_cycle, period_ns);
> +
> +	pwm_div =3D IPQ_PWM_MAX_DIV;

With pwm_div =3D 0xffff you cannot configure a 100% relative duty cycle,
right?

> +	pre_div =3D mul_u64_u64_div_u64(period_ns, rate, (u64)NSEC_PER_SEC * (p=
wm_div + 1));

according to the get_state() callback below we have:

            (PRE_DIV + 1) (PWM_DIV + 1)
	P =3D ---------------------------
	                RATE

The (first) +1 isn't accounted for in your formula.
=09
> +
> +	if (pre_div > IPQ_PWM_MAX_DIV)
> +		pre_div =3D IPQ_PWM_MAX_DIV;
> +
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
> +	reg1 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_REG1);
> +	state->enabled =3D reg1 & IPQ_PWM_REG1_ENABLE;
> +
> +	if (!state->enabled)
> +		return 0;
> +
> +	reg0 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_REG0);
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	pwm_div =3D FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
> +	hi_dur =3D FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
> +	pre_div =3D FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
> +
> +	/* No overflow here, both pre_div and pwm_div <=3D 0xffff */
> +	effective_div =3D (pre_div + 1) * (pwm_div + 1);

With pre_div =3D pwm_div =3D 0xffff this yields 0x100000000 which overflows
a (32 bit) unsigned int.

> +	state->period =3D DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC, rate=
);
> +
> +	hi_div =3D hi_dur * (pre_div + 1);
> +	state->duty_cycle =3D DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC, rate);
> +
> +	/*
> +	 * ensure a valid config is passed back to PWM core in case duty_cycle
> +	 * is > period (>100%)
> +	 */
> +	state->duty_cycle =3D min(state->duty_cycle, state->period);
> +
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
> +				"Failed to acquire resource\n");

Please align continuation lines to the opening (.

> +
> +	pwm->clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +				"Failed to get clock\n");
> +
> +	ret =3D devm_clk_rate_exclusive_get(dev, pwm->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				"Failed to lock clock rate\n");
> +
> +	chip->ops =3D &ipq_pwm_ops;
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
> +
> +	return ret;

You could return 0 here which is a tad clearer.

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

--slf5ta6uz6bbwq2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmluXA8ACgkQj4D7WH0S
/k6q2gf/c9EcOwg1bWFWh7Bblws5s4KQdE2+tPUp0x/yQjNWLD03wrEckfGbh8lM
7HUvqA8+WZwNCBpYrLWSlG+/9pSFl/5aZtIdZ7T2SulY4s9P/9uLxUj11OoY7E5i
4XuLIW9cPSFb8V2dhIVG8NW9dlEsJO5tEN/AIJ+GlpWBzIxhXNcqvCRR3XRXES63
ldO7lj61L7fwbr3IU0mAspYRLCJvD3rGGdYGNYXMCQ0M1nDSPWAY7+86/CFZmJjc
NwVve3bL4+TiEMe+Vx3Lj6GA2ccDH++2yzZQEY3woM+HE9YokJp3a2gpIP7XMeFJ
TJoEm++8pdRPcUonz0WjtLjTID3tNg==
=mjxV
-----END PGP SIGNATURE-----

--slf5ta6uz6bbwq2y--

