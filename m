Return-Path: <linux-pwm+bounces-4114-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0644D9D40F0
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Nov 2024 18:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DA8B2A039
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Nov 2024 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD0A145324;
	Wed, 20 Nov 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z57fzUXX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3B146D57
	for <linux-pwm@vger.kernel.org>; Wed, 20 Nov 2024 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121394; cv=none; b=IidhJ50cV+Bro1fZsr6kwjo/QEPTDj+dlSu0dq6yzjBK0ceezRvqq/Qe+1YyLYnT5WG6k8O+boP8BXzNRBqGvOe3FnaYYI2FCrGYGyOKodjVo06Ap65iRa4xeRRZcS04oiQatt7VAbO5X3rBRtVdcvmIxsrv8TgS+tZmljmUEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121394; c=relaxed/simple;
	bh=r8NZcBs2sEz8e6FZ/2Ioskl9LkSBNEeddoM2OKnec6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/nWop/b1AhX57g2Rsr7RXkQITnBEhhtXTn3t+/IV1C+XF9I77SHFLWOF5sepqgUYx6F3fnoFObXGRLCLq9Nax25o6LLcFI6wIYWQWWxMAyenEtriuktQ8gCrkFvq26qMnQGpUTIkfMWjkwyM1HdXaje1or9u/1NEPYJ+x5rgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z57fzUXX; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6eebb54fc48so13128407b3.1
        for <linux-pwm@vger.kernel.org>; Wed, 20 Nov 2024 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732121390; x=1732726190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNJkcwRcgLMLMuE8q5mBbqQ2JyH7D/IwifRJTKex0/w=;
        b=z57fzUXXWoAIT8Z//4QcISN7xowssG3AeyusMRGkkcWUBa3gyJPb95pAZHVg2C2LIv
         LtYrqicOQiOR0+aKdxnutBz/uqQD14OiBc6E2GCc8PQrJCOc6m9/IOA4fWusg3hAOrLI
         Lvys9uP6d/OLHnfDfLfKcd57YDjLVZC8zyLthTYhbiTTLf/jZHGqs3vzCpMmVejE1vha
         eEElzpYRxtBkO6ANrXbL06yY2ABQM+27ovCLZYTJxXzY/tERCYjUahpt9qvesZUJPhdP
         FdQdERVMN9RTn9L8QjPe93C2oK0Kr85VXYStykITZfy8aN8sxgD00eRvcn7fEhLHgKyR
         uhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732121390; x=1732726190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNJkcwRcgLMLMuE8q5mBbqQ2JyH7D/IwifRJTKex0/w=;
        b=RS1Himeznbgh8AqipFF0MgrqDgf7Jim5JR0PZVwO0w8eCL+5RkEHhxE34zaVHUvg44
         NfMDz6KogOtBqjY6m9kPj4LNJVtL+2kOw06c/QEu8WBdHg0n7c7RzDaBUYUoccVoOyjF
         EM7BAU8Ldctqc6Je+XE4feEDQaNtXqCDziwpVatSoz+xb6OxAMlMm/1f65ha8QVC/841
         9gblgABNAPchIUknY5O21CF7mLVCgqJj/E+skf5pC72T77UYjscisg6DtubjihcyAq0e
         pZOGQUNLLieDh9XTpj3A8j3CGMvYF/NEyJtPxV1ETE8dJCbUE8r+EfKWZrAqQLm4aghb
         RF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLi9Dw1QIo6T6osNHxPeriXD4DwF/m1Zb8YknNJpOC4HePptYt4f+7ppbQRFK4CUSgo+4knKKfPJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRdUJfODLD33UkqYa+PD1C91R4VEr6fHJ2NOi9Rpmqncb8PJf
	NxgxxriZsLP21SanuuAWf2JaYUgIBEiqeqbLu0qA+wL9S/JEpSGzK665ImlEDC8=
X-Google-Smtp-Source: AGHT+IGwdWGaoYeSXKzm2/GlitpS+zOHktULnOeuKUobVI140EepHW/8+OKb4ahYFKL5oL68l9Ullw==
X-Received: by 2002:a05:690c:46c4:b0:6e3:4436:56ba with SMTP id 00721157ae682-6eebd141ebamr40783437b3.8.1732121389779;
        Wed, 20 Nov 2024 08:49:49 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4381340f8sm12779316d6.110.2024.11.20.08.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 08:49:49 -0800 (PST)
Message-ID: <5a6ad0dc-f777-4129-962f-e10a0f7d6ee1@baylibre.com>
Date: Wed, 20 Nov 2024 11:49:48 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/2] pwm: Add Nuvoton MA35D1 PWM controller
 support
To: Chi-Wen Weng <cwweng.linux@gmail.com>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 cwweng@nuvoton.com
References: <20241024104309.169510-1-cwweng.linux@gmail.com>
 <20241024104309.169510-3-cwweng.linux@gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20241024104309.169510-3-cwweng.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 2024-10-24 06:43, Chi-Wen Weng wrote:
> This commit adds a generic PWM framework driver for Nuvoton MA35D1
> PWM controller.
>
> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
> ---
>   drivers/pwm/Kconfig      |   9 +++
>   drivers/pwm/Makefile     |   1 +
>   drivers/pwm/pwm-ma35d1.c | 169 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 179 insertions(+)
>   create mode 100644 drivers/pwm/pwm-ma35d1.c
I don't see a MAINTAINERS entry? That needs to be added in the bindings 
patch first, and then it should be updated to list this driver file.
>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..97b9e83af020 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -411,6 +411,15 @@ config PWM_LPSS_PLATFORM
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called pwm-lpss-platform.
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
>   config PWM_MESON
>   	tristate "Amlogic Meson PWM driver"
>   	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..c1d3a1d8add0 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
>   obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
>   obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
>   obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MA35D1)	+= pwm-ma35d1.o
>   obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
>   obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
>   obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
> diff --git a/drivers/pwm/pwm-ma35d1.c b/drivers/pwm/pwm-ma35d1.c
> new file mode 100644
> index 000000000000..0c4eec4a0b07
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
These should be organized alphabetically.
> +
> +/* The following are registers for PWM controller */
> +#define REG_PWM_CTL0            (0x00)
> +#define REG_PWM_CNTEN           (0x20)
> +#define REG_PWM_PERIOD0         (0x30)
> +#define REG_PWM_CMPDAT0         (0x50)
> +#define REG_PWM_WGCTL0          (0xB0)
> +#define REG_PWM_POLCTL          (0xD4)
> +#define REG_PWM_POEN            (0xD8)

These too, I think - it will make it more readable for others.

You should also prefix all of your macros to be more explicit about 
their use, e.g. MA35D1_REG_PWM_CTL0. That way it's clearer that they're 
specific to this driver and not from elsewhere.

> +
> +#define PWM_TOTAL_CHANNELS      6
> +#define PWM_CH_REG_SIZE         4
And these.
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
It would be good to create a macro for this value 0xFFFF, e.g. 
MA35D1_MAX_PWM_RATE.
> +
> +		period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
> +						    state->period, NSEC_PER_SEC);
> +		if (period_cycles > 0xFFFF)
> +			period_cycles = 0xFFFF;
> +
> +		/* Write the duty and period cycles to registers */
> +		writel(duty_cycles, nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));
> +		writel(period_cycles, nvtpwm->base + REG_PWM_PERIOD0 + (ch * PWM_CH_REG_SIZE));

Since you are using things like

nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE)

and similar so frequently, I suggest creating more macros for these 
sorts of accesses to improve readability, e.g.

#define MA35D1_PWM_CMPDAT0_ADDR(base, ch) 	base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));

or even

#define MA35D1_PWM_CMPDAT0_ADDR(nvtpwm, ch) 	nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));

and then use those instead.

> +		/* Enable counter */
> +		writel(readl(nvtpwm->base + REG_PWM_CNTEN) | BIT(ch),
> +		       nvtpwm->base + REG_PWM_CNTEN);
Same for cases like this.
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
> +	chip->atomic = true;
> +
> +	ret = devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
> +
> +	return 0;
> +}

As a final note, please be aware that there is a change to the PWM 
subsystem coming in 6.13. You don't need to do anything now, but it's 
worth considering how the driver might change once that hits mainline.

You can find the changes here: 
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/?h=pwm/duty_offset 
.

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
> +MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
> +MODULE_DESCRIPTION("Nuvoton MA35D1 PWM driver");
> +MODULE_LICENSE("GPL");

