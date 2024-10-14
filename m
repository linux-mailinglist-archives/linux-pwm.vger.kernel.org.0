Return-Path: <linux-pwm+bounces-3638-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3692499CB9A
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 15:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AF61C22100
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683951A7060;
	Mon, 14 Oct 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="QOWd9gXn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328951514CB;
	Mon, 14 Oct 2024 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912774; cv=none; b=nuAFntL5YImRC3gZsFL1r6Zu13J7bWJuFHcmxnbcyB4yMW9ZtpeMFX27WCTmLcukU5Bjwx+TlspEkfbMVUaH2n9vcS2uFTnYhzH3bkHUea8FNnw5N2pqpaTdEEoAA5wLMO5VVa0xykqOUXd48U0W1zHg3hjwT7F++pcjRBtQkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912774; c=relaxed/simple;
	bh=uZWwnGxdHboEclJY91qbAhqkX3Y6zI+sBctCaoWuBMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtVLxwWSb7HLmPsIGFW7+wCOB/ifBrRHMlPnaR2Mx//s0gh/kHEsuG+jw4OCleILokAmF4wO5G2vdiseBJDaHs2OitLvcSIGfQ51PXbcYIRNiO0wpLOznwclEFJyaZ8sowqFgx+MCJTWirg6z9rKRQXkOOIfQb++w6y95qUJZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=QOWd9gXn; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1728912763; bh=uZWwnGxdHboEclJY91qbAhqkX3Y6zI+sBctCaoWuBMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOWd9gXnIEoHrW1Hi4WI9jemMr7j61kXHhw4WmOhhjHogI3WIF0S7zay214DUkDCg
	 6lWUTe8lcCjDjZJYZ2rBXob2IszMvxYjZf0VqkXZI7zpDv3dl8y7qb48T8mIMJ3e6w
	 JkYhRIKnlCMZWOvF01bvZNmcL9NjO54/9vxl8c4L6ti/Gh2eFSOrYEN0jEo8zcA9a1
	 /4KsEoZ7e9gjJUmbOTVKFydWN+gyPBQXaWEbqr81YDPHuWdVpVxpV9jn8G2s7+an+E
	 NGOvBmblGnsXUlEnaPI9JT6OkFTt6SJ0uYbuwSU6tpCu57Vd0D/fWBvmwttFJAjgie
	 zySpEMhsDFEag==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id F1C841002B3; Mon, 14 Oct 2024 14:32:42 +0100 (BST)
Date: Mon, 14 Oct 2024 14:32:42 +0100
From: Sean Young <sean@mess.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Juxin Gao <gaojuxin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v6 2/2] pwm: Add Loongson PWM controller support
Message-ID: <Zw0desnWJ_Gl-mlU@gofer.mess.org>
References: <cover.1728463622.git.zhoubinbin@loongson.cn>
 <aab9b84ca3ea7e37cc42ad1622724e8198b5b0ea.1728463622.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab9b84ca3ea7e37cc42ad1622724e8198b5b0ea.1728463622.git.zhoubinbin@loongson.cn>

On Thu, Oct 10, 2024 at 04:30:26PM +0800, Binbin Zhou wrote:
> This commit adds a generic PWM framework driver for the PWM controller
> found on Loongson family chips.
> 
> Co-developed-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  MAINTAINERS                |   1 +
>  drivers/pwm/Kconfig        |  12 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-loongson.c | 287 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 301 insertions(+)
>  create mode 100644 drivers/pwm/pwm-loongson.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 18d2c65c744f..9d033799c6ec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13388,6 +13388,7 @@ M:	Binbin Zhou <zhoubinbin@loongson.cn>
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
> +F:	drivers/pwm/pwm-loongson.c
>  
>  LOONGSON-2 SOC SERIES CLOCK DRIVER
>  M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..ef02a44d83a7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -351,6 +351,18 @@ config PWM_KEEMBAY
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-keembay.
>  
> +config PWM_LOONGSON
> +	tristate "Loongson PWM support"
> +	depends on MACH_LOONGSON64 || COMPILE_TEST
> +	depends on COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Loongson family.
> +	  It can be found on Loongson-2K series cpus and Loongson LS7A
> +	  bridge chips.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-loongson.
> +
>  config PWM_LP3943
>  	tristate "TI/National Semiconductor LP3943 PWM support"
>  	depends on MFD_LP3943
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..7c18c9be419f 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
>  obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
> +obj-$(CONFIG_PWM_LOONGSON)	+= pwm-loongson.o
>  obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
>  obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> new file mode 100644
> index 000000000000..cdd320ed3060
> --- /dev/null
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.
> + *
> + * Loongson PWM driver
> + *
> + * For Loongson's PWM IP block documentation please refer Chapter 11 of
> + * Reference Manual: https://loongson.github.io/LoongArch-Documentation/Loongson-7A1000-usermanual-EN.pdf
> + *
> + * Author: Juxin Gao <gaojuxin@loongson.cn>
> + * Further cleanup and restructuring by:
> + *         Binbin Zhou <zhoubinbin@loongson.cn>
> + *
> + * Limitations:
> + * - The buffer register value should be written before the CTRL register.
> + * - When disabled the output is driven to 0 independent of the configured
> + *   polarity.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/units.h>
> +
> +/* Loongson PWM registers */
> +#define LOONGSON_PWM_REG_DUTY		0x4 /* Low Pulse Buffer Register */
> +#define LOONGSON_PWM_REG_PERIOD		0x8 /* Pulse Period Buffer Register */
> +#define LOONGSON_PWM_REG_CTRL		0xc /* Control Register */
> +
> +/* Control register bits */
> +#define LOONGSON_PWM_CTRL_EN		BIT(0)  /* Counter Enable Bit */
> +#define LOONGSON_PWM_CTRL_OE		BIT(3)  /* Pulse Output Enable Control Bit, Valid Low */
> +#define LOONGSON_PWM_CTRL_SINGLE	BIT(4)  /* Single Pulse Control Bit */
> +#define LOONGSON_PWM_CTRL_INTE		BIT(5)  /* Interrupt Enable Bit */
> +#define LOONGSON_PWM_CTRL_INT		BIT(6)  /* Interrupt Bit */
> +#define LOONGSON_PWM_CTRL_RST		BIT(7)  /* Counter Reset Bit */
> +#define LOONGSON_PWM_CTRL_CAPTE		BIT(8)  /* Measurement Pulse Enable Bit */
> +#define LOONGSON_PWM_CTRL_INVERT	BIT(9)  /* Output flip-flop Enable Bit */
> +#define LOONGSON_PWM_CTRL_DZONE		BIT(10) /* Anti-dead Zone Enable Bit */
> +
> +#define LOONGSON_PWM_FREQ_STD		(50 * HZ_PER_KHZ)
> +
> +struct pwm_loongson_suspend_store {
> +	u32 ctrl;
> +	u32 duty;
> +	u32 period;
> +};
> +
> +struct pwm_loongson_ddata {
> +	struct clk *clk;
> +	void __iomem *base;
> +	u64 clk_rate;
> +	struct pwm_loongson_suspend_store lss;
> +};
> +
> +static inline struct pwm_loongson_ddata *to_pwm_loongson_ddata(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static inline u32 pwm_loongson_readl(struct pwm_loongson_ddata *ddata, u32 offset)
> +{
> +	return readl(ddata->base + offset);
> +}
> +
> +static inline void pwm_loongson_writel(struct pwm_loongson_ddata *ddata,
> +				       u32 val, u32 offset)
> +{
> +	writel(val, ddata->base + offset);
> +}
> +
> +static int pwm_loongson_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> +				     enum pwm_polarity polarity)
> +{
> +	u16 val;
> +	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> +
> +	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +
> +	if (polarity == PWM_POLARITY_INVERSED)
> +		/* Duty cycle defines LOW period of PWM */
> +		val |= LOONGSON_PWM_CTRL_INVERT;
> +	else
> +		/* Duty cycle defines HIGH period of PWM */
> +		val &= ~LOONGSON_PWM_CTRL_INVERT;
> +
> +	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
> +
> +	return 0;
> +}
> +
> +static void pwm_loongson_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	u32 val;
> +	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> +
> +	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +	val &= ~LOONGSON_PWM_CTRL_EN;
> +	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
> +}
> +
> +static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	u32 val;
> +	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> +
> +	val = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +	val |= LOONGSON_PWM_CTRL_EN;
> +	pwm_loongson_writel(ddata, val, LOONGSON_PWM_REG_CTRL);
> +
> +	return 0;
> +}
> +
> +static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			       u64 duty_ns, u64 period_ns)
> +{
> +	u32 duty, period;
> +	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> +
> +	/* duty = duty_ns * ddata->clk_rate / NSEC_PER_SEC */
> +	duty = mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_SEC);
> +	pwm_loongson_writel(ddata, duty, LOONGSON_PWM_REG_DUTY);
> +
> +	/* period = period_ns * ddata->clk_rate / NSEC_PER_SEC */
> +	period = mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC);
> +	pwm_loongson_writel(ddata, period, LOONGSON_PWM_REG_PERIOD);
> +
> +	return 0;
> +}
> +
> +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      const struct pwm_state *state)
> +{
> +	int ret;
> +	u64 period, duty_cycle;
> +	bool enabled = pwm->state.enabled;
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			pwm_loongson_disable(chip, pwm);
> +		return 0;
> +	}
> +
> +	ret = pwm_loongson_set_polarity(chip, pwm, state->polarity);
> +	if (ret)
> +		return ret;
> +
> +	period = min(state->period, NANOHZ_PER_HZ);
> +	duty_cycle = min(state->duty_cycle, NANOHZ_PER_HZ);
> +
> +	ret = pwm_loongson_config(chip, pwm, duty_cycle, period);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled && state->enabled)
> +		ret = pwm_loongson_enable(chip, pwm);
> +
> +	return ret;
> +}
> +
> +static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +	u32 duty, period, ctrl;
> +	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> +
> +	duty = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> +	period = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
> +	ctrl = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +
> +	/* duty & period have a max of 2^32, so we can't overflow */
> +	state->duty_cycle = DIV64_U64_ROUND_UP((u64)duty * NSEC_PER_SEC, ddata->clk_rate);
> +	state->period = DIV64_U64_ROUND_UP((u64)period * NSEC_PER_SEC, ddata->clk_rate);
> +	state->polarity = (ctrl & LOONGSON_PWM_CTRL_INVERT) ? PWM_POLARITY_INVERSED :
> +			  PWM_POLARITY_NORMAL;
> +	state->enabled = (ctrl & LOONGSON_PWM_CTRL_EN) ? true : false;
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_loongson_ops = {
> +	.apply = pwm_loongson_apply,
> +	.get_state = pwm_loongson_get_state,
> +};
> +
> +static int pwm_loongson_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct pwm_chip *chip;
> +	struct pwm_loongson_ddata *ddata;
> +	struct device *dev = &pdev->dev;
> +
> +	chip = devm_pwmchip_alloc(dev, 1, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata = to_pwm_loongson_ddata(chip);
> +
> +	ddata->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->base))
> +		return PTR_ERR(ddata->base);
> +
> +	if (!has_acpi_companion(dev)) {
> +		ddata->clk = devm_clk_get_enabled(dev, NULL);
> +		if (IS_ERR(ddata->clk))
> +			return dev_err_probe(dev, PTR_ERR(ddata->clk),
> +					     "failed to get pwm clock\n");
> +		ddata->clk_rate = clk_get_rate(ddata->clk);
> +	} else {
> +		ddata->clk_rate = LOONGSON_PWM_FREQ_STD;
> +	}
> +
> +	chip->ops = &pwm_loongson_ops;

I think you can add here:

        chip->atomic = true;

As far as I can see, the driver does not do any sleeping operations
in pwm_loongson_apply(). This probably should be tested with
CONFIG_PWM_DEBUG and CONFIG_DEBUG_ATOMIC_SLEEP just to be sure.

Thanks,
Sean


> +	dev_set_drvdata(dev, chip);
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static int pwm_loongson_suspend(struct device *dev)
> +{
> +	struct pwm_chip *chip = dev_get_drvdata(dev);
> +	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> +
> +	ddata->lss.ctrl = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_CTRL);
> +	ddata->lss.duty = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_DUTY);
> +	ddata->lss.period = pwm_loongson_readl(ddata, LOONGSON_PWM_REG_PERIOD);
> +
> +	clk_disable_unprepare(ddata->clk);
> +
> +	return 0;
> +}
> +
> +static int pwm_loongson_resume(struct device *dev)
> +{
> +	int ret;
> +	struct pwm_chip *chip = dev_get_drvdata(dev);
> +	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
> +
> +	ret = clk_prepare_enable(ddata->clk);
> +	if (ret)
> +		return ret;
> +
> +	pwm_loongson_writel(ddata, ddata->lss.ctrl, LOONGSON_PWM_REG_CTRL);
> +	pwm_loongson_writel(ddata, ddata->lss.duty, LOONGSON_PWM_REG_DUTY);
> +	pwm_loongson_writel(ddata, ddata->lss.period, LOONGSON_PWM_REG_PERIOD);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(pwm_loongson_pm_ops, pwm_loongson_suspend,
> +				pwm_loongson_resume);
> +
> +static const struct of_device_id pwm_loongson_of_ids[] = {
> +	{ .compatible = "loongson,ls7a-pwm" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, pwm_loongson_of_ids);
> +
> +static const struct acpi_device_id pwm_loongson_acpi_ids[] = {
> +	{ "LOON0006" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, pwm_loongson_acpi_ids);
> +
> +static struct platform_driver pwm_loongson_driver = {
> +	.probe = pwm_loongson_probe,
> +	.driver = {
> +		.name = "loongson-pwm",
> +		.pm = pm_ptr(&pwm_loongson_pm_ops),
> +		.of_match_table = pwm_loongson_of_ids,
> +		.acpi_match_table = pwm_loongson_acpi_ids,
> +	},
> +};
> +module_platform_driver(pwm_loongson_driver);
> +
> +MODULE_DESCRIPTION("Loongson PWM driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited.");
> +MODULE_LICENSE("GPL");
> -- 
> 2.43.5
> 

