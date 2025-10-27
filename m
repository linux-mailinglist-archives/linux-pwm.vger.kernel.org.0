Return-Path: <linux-pwm+bounces-7494-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D890EC0F5E1
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 17:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F31B34F6F3
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98542314D2D;
	Mon, 27 Oct 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvleBac2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66651314D21;
	Mon, 27 Oct 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583074; cv=none; b=jylQUyZNQnZfyJBzgsF2jwOTwSbSTEM2TWg91Qyjd0Zj8VndmYivZlYaAy0ek3H63RaTz5E1AP9iD4PCWcQdKqpc3m+KjQ40MOwetHineH3eOZ0Vr5rTmxzI/Q6hZGqeBoqgWPCLoFvRd4toNthkOr9Ig2uXSnuDdy2fg1JHLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583074; c=relaxed/simple;
	bh=21RiINEN36Kj6DIkoNYOiEWHWjhn8ZI77MCyUdcuneM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgIOvatgoRD+rakZnlGoPl0ylyBt8VqX+uBiohu7js+XXcMlMAX4TgXPb8B1xb1tPeafYlRNlGCrmIpxHFZXzlO4CfqC/X3/Oe+dued4J7m92iU9IQkS56Y6Z57Feh/dFoqqynhxLv2yp4Z1RQDZ/iefbSkGU7qrc+ahj98K5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvleBac2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D9AC4CEF1;
	Mon, 27 Oct 2025 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761583074;
	bh=21RiINEN36Kj6DIkoNYOiEWHWjhn8ZI77MCyUdcuneM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvleBac2Iw+jY3wFGFtSex0/8H4Nq6AflNoC0ugItLhS9xcbTfkoPC0cHBocuba/R
	 WYrwQeNUl/wegVvi3AhiqgecV9X9w52ydiUoxqbZ+jWJK3lXy09uV1PWoWzP0N0EL3
	 FYBv36qpSDUX6yRfj4/yE8Wtv1lzmXX6yeM1vtsfSlT6qAsxePFlXZD7nXChAwt9On
	 FoW4MSV4K/qek3nf5bKc7cODFrK7br/2UIm5ywNxjw5IcqfUWrrkxAwpM8GbNYWGIY
	 2vdUaxPbXL0O2iBr9CRqdWPg6RRZjHSO4S7HhKk9QkCmft+/TOIYLbj4cf8tSQvLbu
	 6C10eV0fgmjvw==
Date: Mon, 27 Oct 2025 11:40:46 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: george.moussalem@outlook.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Devi Priya <quic_devipriy@quicinc.com>, Baruch Siach <baruch.siach@siklu.com>
Subject: Re: [PATCH v17 2/9] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <miewxvmo4rbayu7lkivcxyl2rwtubchvrx3cknzto2jt6wkpvi@3ruz4nxbezxa>
References: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
 <20251008-ipq-pwm-v17-2-9bd43edfc7f7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008-ipq-pwm-v17-2-9bd43edfc7f7@outlook.com>

On Wed, Oct 08, 2025 at 07:32:54PM +0400, George Moussalem via B4 Relay wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
> driver from downstream Codeaurora kernel tree. Removed support for older
> (V1) variants because I have no access to that hardware.
> 
> Tested on IPQ5018 and IPQ6010 based hardware.
> 
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> v17:
> 
>   Removed unnecessary code comments
> 
> v16:
> 
>   Simplified code to calculate divs and duty cycle as per Uwe's comments
> 
>   Removed unused pwm_chip struct from ipq_pwm_chip struct
> 
>   Removed unnecessary cast as per Uwe's comment
> 
>   Replaced devm_clk_get & clk_prepare_enable by devm_clk_get_enabled
> 
>   Replaced pwmchip_add by devm_pwmchip_add and removed .remove function
> 
>   Removed .owner from driver struct
> 
> v15:
> 
>   No change
> 
> v14:
> 
>   Picked up the R-b tag
> 
> v13:
> 
>   Updated the file name to match the compatible
> 
>   Sorted the properties and updated the order in the required field
> 
>   Dropped the syscon node from examples
> 
> v12:
> 
>   Picked up the R-b tag
> 
> v11:
> 
>   No change
> 
> v10:
> 
>   No change
> 
> v9:
> 
>   Add 'ranges' property to example (Rob)
> 
>   Drop label in example (Rob)
> 
> v8:
> 
>   Add size cell to 'reg' (Rob)
> 
> v7:
> 
>   Use 'reg' instead of 'offset' (Rob)
> 
>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> 
>   Use single cell address/size in example node (Bjorn)
> 
>   Move '#pwm-cells' lower in example node (Bjorn)
> 
>   List 'reg' as required
> 
> v6:
> 
>   Device node is child of TCSR; remove phandle (Rob Herring)
> 
>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
> 
> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>     Andersson, Kathiravan T)
> 
> v4: Update the binding example node as well (Rob Herring's bot)
> 
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
> v2: Make #pwm-cells const (Rob Herring)
> ---
>  drivers/pwm/Kconfig   |  12 +++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-ipq.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index c2fd3f4b62d9ea422a51a73fa87dc7a73703ebaf..33ac49251b3cc957bc356aa39199b748577d295f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -337,6 +337,18 @@ config PWM_INTEL_LGM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-intel-lgm.
>  
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
> index dfa8b4966ee19af18ea47080db4adf96c326f3d7..74e07f654d43dfee83e7bb3a49e41acf8ae011fc 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
>  obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
>  obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
>  obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
> +obj-$(CONFIG_PWM_IPQ)		+= pwm-ipq.o
>  obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
> diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..bd6b3ad86596e3c5b19f80f97fe7913a8ce2d940
> --- /dev/null
> +++ b/drivers/pwm/pwm-ipq.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserved.
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
> +static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned int reg)
> +{
> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
> +	unsigned int off = 8 * pwm->hwpwm + reg;
> +
> +	return readl(ipq_chip->mem + off);
> +}
> +
> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned int reg,
> +			      unsigned int val)
> +{
> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
> +	unsigned int off = 8 * pwm->hwpwm + reg;
> +
> +	writel(val, ipq_chip->mem + off);
> +}
> +
> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre_div,
> +				unsigned int pwm_div, unsigned long rate, u64 duty_ns,
> +				bool enable)
> +{
> +	unsigned long hi_dur;
> +	unsigned long val = 0;
> +
> +	/*
> +	 * high duration = pwm duty * (pwm div + 1)
> +	 * pwm duty = duty_ns / period_ns
> +	 */
> +	hi_dur = div64_u64(duty_ns * rate, (pre_div + 1) * NSEC_PER_SEC);
> +
> +	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG0, val);
> +
> +	val = FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
> +
> +	/* PWM enable toggle needs a separate write to REG1 */
> +	val |= IPQ_PWM_REG1_UPDATE;
> +	if (enable)
> +		val |= IPQ_PWM_REG1_ENABLE;
> +	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
> +}
> +
> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
> +	unsigned long rate = clk_get_rate(ipq_chip->clk);
> +	unsigned int pre_div, pwm_div;
> +	u64 period_ns, duty_ns;
> +
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC, rate))
> +		return -ERANGE;
> +
> +	if ((unsigned long long)rate > 16ULL * GIGA)
> +		return -EINVAL;
> +
> +	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> +	duty_ns = min(state->duty_cycle, period_ns);
> +
> +	/* Restrict pwm_div to 0xfffe */
> +	pwm_div = IPQ_PWM_MAX_DIV - 1;
> +	pre_div = DIV64_U64_ROUND_UP(period_ns * rate, (u64)NSEC_PER_SEC * (pwm_div + 1));
> +
> +	if (pre_div > IPQ_PWM_MAX_DIV)
> +		return -ERANGE;
> +
> +	config_div_and_duty(pwm, pre_div, pwm_div, rate, duty_ns, state->enabled);
> +
> +	return 0;
> +}
> +
> +static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     struct pwm_state *state)
> +{
> +	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
> +	unsigned long rate = clk_get_rate(ipq_chip->clk);
> +	unsigned int pre_div, pwm_div, hi_dur;
> +	u64 effective_div, hi_div;
> +	u32 reg0, reg1;
> +
> +	reg0 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG0);
> +	reg1 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG1);
> +
> +	state->polarity = PWM_POLARITY_NORMAL;
> +	state->enabled = reg1 & IPQ_PWM_REG1_ENABLE;
> +
> +	pwm_div = FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
> +	hi_dur = FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
> +	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
> +
> +	/* No overflow here, both pre_div and pwm_div <= 0xffff */
> +	effective_div = (pre_div + 1) * (pwm_div + 1);
> +	state->period = DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC, rate);
> +
> +	hi_div = hi_dur * (pre_div + 1);
> +	state->duty_cycle = DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC, rate);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops ipq_pwm_ops = {
> +	.apply = ipq_pwm_apply,
> +	.get_state = ipq_pwm_get_state,
> +};
> +
> +static int ipq_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ipq_pwm_chip *pwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, 4, sizeof(*pwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	pwm = ipq_pwm_from_chip(chip);
> +
> +	pwm->mem = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->mem))
> +		return dev_err_probe(dev, PTR_ERR(pwm->mem),
> +				"regs map failed");
> +
> +	pwm->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +				"failed to get clock");
> +
> +	chip->ops = &ipq_pwm_ops;
> +	chip->npwm = 4;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to add pwm chip\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id pwm_ipq_dt_match[] = {
> +	{ .compatible = "qcom,ipq6018-pwm", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
> +
> +static struct platform_driver ipq_pwm_driver = {
> +	.driver = {
> +		.name = "ipq-pwm",
> +		.of_match_table = pwm_ipq_dt_match,
> +	},
> +	.probe = ipq_pwm_probe,
> +};
> +
> +module_platform_driver(ipq_pwm_driver);
> +
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.51.0
> 
> 

