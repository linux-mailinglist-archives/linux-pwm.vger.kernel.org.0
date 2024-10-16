Return-Path: <linux-pwm+bounces-3671-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3E9A04ED
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 11:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57DE1C231B6
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388801CEAD3;
	Wed, 16 Oct 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="jddibJ96"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6978158D9C;
	Wed, 16 Oct 2024 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069244; cv=none; b=SDSdQAUn47MvHiOE4Dcl34oyFXlXmiygtkd8a98vowBHHCJBVflBz61MhbKIM/ikvoJC4w5VFpPR+WvLMpvxA87fTiNQmhNpNVJkWD8nHs06/q4L+P+3HazQ/GZ3uWd+1AkY78zLCHiJBSkoYukCHysAEvFvAGNWrpJXe3k24mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069244; c=relaxed/simple;
	bh=6IGxvc6NwaVw4PEo4Yzm/DjnoysdqVlUpzuzFQ9taw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZcAwnyuWCKbjT5cg/Az2t8AmvzZujKcP32Z2v/F4e7QrY4B5NJLMjL6P2KJexR4a3TvQ0n9j+gjHHifzfduWcELAGtkJivgNGdhMvEWNWmPjnpxHl2eFV+w5wlDMgzsJmtXH+MZogtNGr7uS9r1OCoBZX28Qup9nYOffaoQx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=jddibJ96; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1729069232; bh=6IGxvc6NwaVw4PEo4Yzm/DjnoysdqVlUpzuzFQ9taw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jddibJ96eXrb9Oku2KNGvGmJCESxJDcSf2TDnUU9GNm8gqlFHYeywhhBLPuLXQMEy
	 36ZjXsQeg7Uqr5lRKBXwxtGhkK546EQ3hkcmS88OzOCCpzupKO+9a6uNrDJqSkTLIx
	 Uh7e2BSA1MuDSaIsC7EzT4Gj/K7yKX9TOKitwEjogsomP5+meiRhxl6a4nRIt78h4v
	 24PKd7sAhYi0tuUJFtqgosSGAWea4YnG94eDaXWJnESzPLpeVmYyn0uxEMrLYiYVVq
	 MOHZUSQEV6ncrJnd2uGO0UK9oLZdLgVRreVtpMdKpOlRLWx53p5BnRjVSajYXFB2Me
	 eyRp4obaqiyRg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 6600A1002B3; Wed, 16 Oct 2024 10:00:32 +0100 (BST)
Date: Wed, 16 Oct 2024 10:00:32 +0100
From: Sean Young <sean@mess.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, unicorn_wang@outlook.com,
	inochiama@outlook.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: Re: [PATCH v4 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
Message-ID: <Zw-AsJjZIaa_OIfq@gofer.mess.org>
References: <cover.1729037302.git.unicorn_wang@outlook.com>
 <cc69b47d068ff339db4c93d3103ed80d10a172d0.1729037302.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc69b47d068ff339db4c93d3103ed80d10a172d0.1729037302.git.unicorn_wang@outlook.com>

On Wed, Oct 16, 2024 at 08:20:18AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add a PWM driver for PWM controller in Sophgo SG2042 SoC.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>

LGTM.

Signed-off-by: Sean Young <sean@mess.org>

> ---
>  drivers/pwm/Kconfig             |  10 ++
>  drivers/pwm/Makefile            |   1 +
>  drivers/pwm/pwm-sophgo-sg2042.c | 181 ++++++++++++++++++++++++++++++++
>  3 files changed, 192 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..ec85f3895936 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -584,6 +584,16 @@ config PWM_SL28CPLD
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sl28cpld.
>  
> +config PWM_SOPHGO_SG2042
> +	tristate "Sophgo SG2042 PWM support"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  PWM driver for the PWM controller on Sophgo SG2042 SoC. The PWM
> +	  controller supports outputing 4 channels of PWM waveforms.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm_sophgo_sg2042.
> +
>  config PWM_SPEAR
>  	tristate "STMicroelectronics SPEAr PWM support"
>  	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..539e0def3f82 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
> +obj-$(CONFIG_PWM_SOPHGO_SG2042)	+= pwm-sophgo-sg2042.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>  obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> new file mode 100644
> index 000000000000..bed753877851
> --- /dev/null
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo SG2042 PWM Controller Driver
> + *
> + * Copyright (C) 2024 Sophgo Technology Inc.
> + * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
> + *
> + * Limitations:
> + * - After reset, the output of the PWM channel is always high.
> + *   The value of HLPERIOD/PERIOD is 0.
> + * - When HLPERIOD or PERIOD is reconfigured, PWM will start to
> + *   output waveforms with the new configuration after completing
> + *   the running period.
> + * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
> + *   be stopped and the output is pulled to high.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +
> +#include <asm/div64.h>
> +
> +/*
> + * Offset RegisterName
> + * 0x0000 HLPERIOD0
> + * 0x0004 PERIOD0
> + * 0x0008 HLPERIOD1
> + * 0x000C PERIOD1
> + * 0x0010 HLPERIOD2
> + * 0x0014 PERIOD2
> + * 0x0018 HLPERIOD3
> + * 0x001C PERIOD3
> + * Four groups and every group is composed of HLPERIOD & PERIOD
> + */
> +#define SG2042_HLPERIOD(chan) ((chan) * 8 + 0)
> +#define SG2042_PERIOD(chan) ((chan) * 8 + 4)
> +
> +#define SG2042_PWM_CHANNELNUM	4
> +
> +/**
> + * struct sg2042_pwm_ddata - private driver data
> + * @base:		base address of mapped PWM registers
> + * @clk_rate_hz:	rate of base clock in HZ
> + */
> +struct sg2042_pwm_ddata {
> +	void __iomem *base;
> +	unsigned long clk_rate_hz;
> +};
> +
> +static void pwm_sg2042_config(void __iomem *base, unsigned int chan, u32 period, u32 hlperiod)
> +{
> +	writel(period, base + SG2042_PERIOD(chan));
> +	writel(hlperiod, base + SG2042_HLPERIOD(chan));
> +}
> +
> +static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
> +	u32 hlperiod;
> +	u32 period;
> +
> +	if (state->polarity == PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		pwm_sg2042_config(ddata->base, pwm->hwpwm, 0, 0);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Period of High level (duty_cycle) = HLPERIOD x Period_clk
> +	 * Period of One Cycle (period) = PERIOD x Period_clk
> +	 */
> +	period = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC), U32_MAX);
> +	hlperiod = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle, NSEC_PER_SEC), U32_MAX);
> +
> +	if (hlperiod > period) {
> +		dev_err(pwmchip_parent(chip), "period < hlperiod, failed to apply current setting\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(pwmchip_parent(chip), "chan[%u]: period=%u, hlperiod=%u\n",
> +		pwm->hwpwm, period, hlperiod);
> +
> +	pwm_sg2042_config(ddata->base, pwm->hwpwm, period, hlperiod);
> +
> +	return 0;
> +}
> +
> +static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +				struct pwm_state *state)
> +{
> +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
> +	unsigned int chan = pwm->hwpwm;
> +	u32 hlperiod;
> +	u32 period;
> +
> +	period = readl(ddata->base + SG2042_PERIOD(chan));
> +	hlperiod = readl(ddata->base + SG2042_HLPERIOD(chan));
> +
> +	if (!period && !hlperiod)
> +		state->enabled = false;
> +	else
> +		state->enabled = true;
> +
> +	state->period = DIV_ROUND_UP_ULL((u64)period * NSEC_PER_SEC, ddata->clk_rate_hz);
> +	state->duty_cycle = DIV_ROUND_UP_ULL((u64)hlperiod * NSEC_PER_SEC, ddata->clk_rate_hz);
> +
> +	state->polarity = PWM_POLARITY_NORMAL;
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_sg2042_ops = {
> +	.apply = pwm_sg2042_apply,
> +	.get_state = pwm_sg2042_get_state,
> +};
> +
> +static const struct of_device_id sg2042_pwm_ids[] = {
> +	{ .compatible = "sophgo,sg2042-pwm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
> +
> +static int pwm_sg2042_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sg2042_pwm_ddata *ddata;
> +	struct pwm_chip *chip;
> +	struct clk *clk;
> +	int ret;
> +
> +	chip = devm_pwmchip_alloc(dev, SG2042_PWM_CHANNELNUM, sizeof(*ddata));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	ddata = pwmchip_get_drvdata(chip);
> +
> +	ddata->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->base))
> +		return PTR_ERR(ddata->base);
> +
> +	clk = devm_clk_get_enabled(dev, "apb");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get base clk\n");
> +
> +	ret = devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
> +
> +	ddata->clk_rate_hz = clk_get_rate(clk);
> +	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
> +
> +	chip->ops = &pwm_sg2042_ops;
> +	chip->atomic = true;
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver pwm_sg2042_driver = {
> +	.driver	= {
> +		.name = "sg2042-pwm",
> +		.of_match_table = sg2042_pwm_ids,
> +	},
> +	.probe = pwm_sg2042_probe,
> +};
> +module_platform_driver(pwm_sg2042_driver);
> +
> +MODULE_AUTHOR("Chen Wang");
> +MODULE_DESCRIPTION("Sophgo SG2042 PWM driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

