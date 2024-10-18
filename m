Return-Path: <linux-pwm+bounces-3701-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0779A3783
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 09:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5DC2876D6
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFAB18A952;
	Fri, 18 Oct 2024 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="YQZxR0fD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029818A928;
	Fri, 18 Oct 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237593; cv=none; b=RhXB7HewNf8Gn2v2ZbhOmeQ1BbQ39Hbj8/1DOUUCzBUnTo8PjQYnudWGEELhgkm5pasrDcsfoLEg4aHMQ9T/5pqmyWG5UCJv9gOlZ4d7VaSTK2SE+BGaQuVbxjgvxC+MWoGSS4D3QKzrNDJtarBO7gHMue+lwmZ7Mez+BY4eDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237593; c=relaxed/simple;
	bh=sfxyH3CCteK+m0zEA4Sv5bH7E5P6haA9Zbq45UkQSsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWr3kVbFZ60yc4WVt5p0U3yx2Qqv6AhsWiWNs3NfEyMkKHxSbBmiT1swUHmJifkvSoCTtOYh4ry0R+Yv9HEZ1k2f1V0GAN0ZBBd0uuUOGt/I49gvLsCbd35FSLW8wxl8I52dRDsEkiEGhcgFf8hGt0h8J/tUnTUXpMs5RiWAroA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=YQZxR0fD; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1729237588; bh=sfxyH3CCteK+m0zEA4Sv5bH7E5P6haA9Zbq45UkQSsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQZxR0fDyeSEp83aZMTJm3ilN0wy4kQi1mkaESPEtg2fUN70ZnrlVBG7eq2W7KvLB
	 EW6vj2h7+Nte6+9bTpkWopfLNfWreOjDJQam1wSB5MR853BxueZ8+YGWFfQRcTNiqR
	 iMLL2ZXy5rQ9occLNa8DbbB6g5M8AJXxNqXHHg+psaw2bQkTsefDHzi/R2wLU/ZHNs
	 3Gl36ZeSi7h3uoj11xvTjZZaN+g1KafMfvycU/XGUh2QGsAIoWoPvFf+2eip3fDLID
	 PmUt/gNFDlkPAHHSsfShF5YfGsQw7q/45Wxvi/e2razbPSDmxh9qyZ+G4p8fgLCGGl
	 QyQgEuRYl+Z+w==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 5C7031002B3; Fri, 18 Oct 2024 08:46:28 +0100 (BST)
Date: Fri, 18 Oct 2024 08:46:28 +0100
From: Sean Young <sean@mess.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	ychuang3@nuvoton.com, schung@nuvoton.com
Subject: Re: [PATCH 2/2] pwm: Add Nuvoton PWM controller support
Message-ID: <ZxISVBz1Os0T4eqP@gofer.mess.org>
References: <20241018034857.568-1-cwweng.linux@gmail.com>
 <20241018034857.568-3-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018034857.568-3-cwweng.linux@gmail.com>

On Fri, Oct 18, 2024 at 03:48:57AM +0000, Chi-Wen Weng wrote:
> This commit adds a generic PWM framework driver for Nuvoton MA35D1
> PWM controller.
> 
> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
> ---
>  drivers/pwm/Kconfig      |   9 +++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ma35d1.c | 169 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ma35d1.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..97b9e83af020 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -411,6 +411,15 @@ config PWM_LPSS_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpss-platform.
>  
> +config PWM_MA35D1
> +	tristate "Nuvoton MA35D1 PWM support"
> +	depends on ARCH_MA35 || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for Nuvoton MA35D1.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-ma35d1.
> +
>  config PWM_MESON
>  	tristate "Amlogic Meson PWM driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..c1d3a1d8add0 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MA35D1)	+= pwm-ma35d1.o
>  obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
>  obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
> diff --git a/drivers/pwm/pwm-ma35d1.c b/drivers/pwm/pwm-ma35d1.c
> new file mode 100644
> index 000000000000..dc2f1f494a91
> --- /dev/null
> +++ b/drivers/pwm/pwm-ma35d1.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the Nuvoton MA35D1 PWM controller
> + *
> + * Copyright (C) 2024 Nuvoton Corporation
> + *               Chi-Wen Weng <cwweng@nuvoton.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/math64.h>
> +
> +/* The following are registers for PWM controller */
> +#define REG_PWM_CTL0            (0x00)
> +#define REG_PWM_CNTEN           (0x20)
> +#define REG_PWM_PERIOD0         (0x30)
> +#define REG_PWM_CMPDAT0         (0x50)
> +#define REG_PWM_WGCTL0          (0xB0)
> +#define REG_PWM_POLCTL          (0xD4)
> +#define REG_PWM_POEN            (0xD8)
> +
> +#define PWM_TOTAL_CHANNELS      6
> +#define PWM_CH_REG_SIZE         4
> +
> +struct nuvoton_pwm {
> +	void __iomem *base;
> +	u64 clkrate;
> +};
> +
> +static inline struct nuvoton_pwm *to_nuvoton_pwm(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct nuvoton_pwm *nvtpwm;
> +	unsigned int ch = pwm->hwpwm;
> +
> +	nvtpwm = to_nuvoton_pwm(chip);
> +	if (state->enabled) {
> +		u64 duty_cycles, period_cycles;
> +
> +		/* Calculate the duty and period cycles */
> +		duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
> +						  state->duty_cycle, NSEC_PER_SEC);
> +		if (duty_cycles > 0xFFFF)
> +			duty_cycles = 0xFFFF;
> +
> +		period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
> +						    state->period, NSEC_PER_SEC);
> +		if (period_cycles > 0xFFFF)
> +			period_cycles = 0xFFFF;

If a period is not supported, return -EINVAL - maybe even do a dev_err().
Same for the duty cycle above. It might make sense to calculate the period
first, so that the error is more likely to be about the period than the
duty cycle.

Then again I don't know if all the drivers do this, but at least some of
them do.

> +
> +		/* Write the duty and period cycles to registers */
> +		writel(duty_cycles, nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));
> +		writel(period_cycles, nvtpwm->base + REG_PWM_PERIOD0 + (ch * PWM_CH_REG_SIZE));
> +		/* Enable counter */
> +		writel(readl(nvtpwm->base + REG_PWM_CNTEN) | BIT(ch),
> +		       nvtpwm->base + REG_PWM_CNTEN);
> +		/* Enable output */
> +		writel(readl(nvtpwm->base + REG_PWM_POEN) | BIT(ch),
> +		       nvtpwm->base + REG_PWM_POEN);
> +	} else {
> +		/* Disable counter */
> +		writel(readl(nvtpwm->base + REG_PWM_CNTEN) & ~BIT(ch),
> +		       nvtpwm->base + REG_PWM_CNTEN);
> +		/* Disable output */
> +		writel(readl(nvtpwm->base + REG_PWM_POEN) & ~BIT(ch),
> +		       nvtpwm->base + REG_PWM_POEN);
> +	}
> +
> +	/* Set polarity state to register */
> +	if (state->polarity == PWM_POLARITY_NORMAL)
> +		writel(readl(nvtpwm->base + REG_PWM_POLCTL) & ~BIT(ch),
> +		       nvtpwm->base + REG_PWM_POLCTL);
> +	else
> +		writel(readl(nvtpwm->base + REG_PWM_POLCTL) | BIT(ch),
> +		       nvtpwm->base + REG_PWM_POLCTL);
> +
> +	return 0;
> +}
> +
> +static int nuvoton_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct nuvoton_pwm *nvtpwm;
> +	unsigned int duty_cycles, period_cycles, cnten, outen, polarity;
> +	unsigned int ch = pwm->hwpwm;
> +
> +	nvtpwm = to_nuvoton_pwm(chip);
> +
> +	cnten = readl(nvtpwm->base + REG_PWM_CNTEN);
> +	outen = readl(nvtpwm->base + REG_PWM_POEN);
> +	duty_cycles = readl(nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));
> +	period_cycles = readl(nvtpwm->base + REG_PWM_PERIOD0 + (ch * PWM_CH_REG_SIZE));
> +	polarity = readl(nvtpwm->base + REG_PWM_POLCTL) & BIT(ch);
> +
> +	state->enabled = (cnten & BIT(ch)) && (outen & BIT(ch));
> +	state->polarity = polarity ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	state->duty_cycle = DIV64_U64_ROUND_UP((u64)duty_cycles * NSEC_PER_SEC, nvtpwm->clkrate);
> +	state->period = DIV64_U64_ROUND_UP((u64)period_cycles * NSEC_PER_SEC, nvtpwm->clkrate);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops nuvoton_pwm_ops = {
> +	.apply = nuvoton_pwm_apply,
> +	.get_state = nuvoton_pwm_get_state,
> +};
> +
> +static int nuvoton_pwm_probe(struct platform_device *pdev)
> +{
> +	struct pwm_chip *chip;
> +	struct nuvoton_pwm *nvtpwm;
> +	struct clk *clk;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(&pdev->dev, PWM_TOTAL_CHANNELS, sizeof(*nvtpwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	nvtpwm = to_nuvoton_pwm(chip);
> +
> +	nvtpwm->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(nvtpwm->base))
> +		return PTR_ERR(nvtpwm->base);
> +
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "unable to get the clock");
> +
> +	nvtpwm->clkrate = clk_get_rate(clk);
> +	if (nvtpwm->clkrate > NSEC_PER_SEC)
> +		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
> +
> +	chip->ops = &nuvoton_pwm_ops;

I think you can add chip->atomic = true; here


Sean

> +
> +	ret = devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id nuvoton_pwm_of_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-pwm" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, nuvoton_pwm_of_match);
> +
> +static struct platform_driver nuvoton_pwm_driver = {
> +	.probe = nuvoton_pwm_probe,
> +	.driver = {
> +		.name = "nuvoton-pwm",
> +		.of_match_table = nuvoton_pwm_of_match,
> +	},
> +};
> +module_platform_driver(nuvoton_pwm_driver);
> +
> +MODULE_ALIAS("platform:nuvoton-pwm");
> +MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
> +MODULE_DESCRIPTION("Nuvoton MA35D1 PWM driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

