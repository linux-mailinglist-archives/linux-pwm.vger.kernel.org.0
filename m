Return-Path: <linux-pwm+bounces-3706-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6B39A3B94
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 12:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E3A1F2538C
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6523D20100F;
	Fri, 18 Oct 2024 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvdjgAta"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CA201008;
	Fri, 18 Oct 2024 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247547; cv=none; b=lec3elgcuHZnXjIPzR+vDdl4d9zuzQFHhCE0yVWFrVY61ZYHOEZn9o4JABbBmIulH1jZYNmUFrWRTq6/0CjhgmsHVegBfSWhLNKcSsI7PrDe6G7YbKmtOLhQcEVebiyc6BqehqGjdaFuyQg4KauxVIpi+l0ROyTFDA6Th+BOO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247547; c=relaxed/simple;
	bh=zkfkKthYJfncPyhdOzGq428nIpwkee/T5OMvW8RVGEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zdgy9iF+v30DZL4fcrybhC0OCCZRFy6PWVek2BXFGnciC/FvvjwN+xCNlUHSETSayn8m221Ig7yCaAZei3AMsB1U/2/bB3QwLt0+yMU3UNeh/t/eBbu5a0aYKo2E7xR3AdrcYASBNoubEuUHIYkGtuEkw5V+dOiNqoU0DFqsrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvdjgAta; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so1367288a91.0;
        Fri, 18 Oct 2024 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729247545; x=1729852345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=It0v5HNkSU+Rmz/ZDBbkG5jiiUzn/njeWhVUBBNUkzw=;
        b=UvdjgAtaasVDWiiGVHmHwWr+JVdGnhbA1jhqYFb0EvgRFJa+rL4yoiv/545OddXQU9
         acMEwyS86FizB71zoFK8RFH5ZmUD86b15At7DK6MCt08MfZC7M55IS1C5EyzOyj/PMVv
         wgr4IgjSOhnJKvruSuehIjq2/lcaKXqGQSaONve6zIwNBx0kk2Mrzs/aXrw/Cm5s7rYt
         5m9FhAlzUDdX+FranI3wz6IqiNgJBwVbrF57/xe2vredPU4/I561eWPxo3hNoJMVQ29o
         /186pR+y6AnGi9eG0fhlKZbC1aueWvXJrXP92E077tCH8VPBJUtWAt6AxyRxji7+WBzi
         MxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247545; x=1729852345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=It0v5HNkSU+Rmz/ZDBbkG5jiiUzn/njeWhVUBBNUkzw=;
        b=Fwlkl90dp4C8BKAlIueTsc0VbsThS35zCJ3J99T0ZJlruCSehgbSqAU/a6QZu8FdFs
         dBVdapJWu8qlft3LLVBa4fWysyfWW935g3zFh8B8MzGWB+uk3DniHhDO5ssP432dmvof
         Aqae5kGseH1e28s5QBSQDH5kz8m+/a5G/bcGiy1Romxi/g4QrfImqX5fWNumP2l9Z8hu
         qNJQGqjdhC1zEUy6BW138FqA+tu2JJ0U+CC2VozI8+BkmuTShQs2sqnB9oX/29p5FT8Z
         HVuf9tRR0pU6uJ7i8sgPee5HjA3oaZKdOndM2uqpv4I2W3wPTNtVgtqt9UUg8Uore9x2
         f3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUV2cIHJtUVAR5+y34Cn7KoRf+lt1u4TtwnC0T7dasnoI7g08DbB4ULkGdFT75hPpKzvWfyFSnbO3pY@vger.kernel.org, AJvYcCV4qvWN7XnFkBjlGctgdir2J9/QmrNiFmgX+P48QhVCdRGBzyXAmaJwqJfxjD69AzGV8Gm5OuzFNiSg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+z4C5K4QVN2UXZfwGJgXVph+Edd9QbqNfUEV6WQFxDWLJzdnz
	sjTLeaYUWg9J+Ey1wduTxM6xzACh9TFY/BOVcqvU8UDKuqy4iv5P
X-Google-Smtp-Source: AGHT+IEjaF51vDWkP1d66i4QUaDT2EYgD9d6dqf5GgnQtBD6PPo0KgSEmzFSFUMI+LCH2EvGUctdOg==
X-Received: by 2002:a17:90a:4942:b0:2e2:b219:40a2 with SMTP id 98e67ed59e1d1-2e5616eba35mr2532915a91.28.1729247544702;
        Fri, 18 Oct 2024 03:32:24 -0700 (PDT)
Received: from [172.19.1.42] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e56129d8f9sm1437157a91.36.2024.10.18.03.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:32:24 -0700 (PDT)
Message-ID: <3614f140-49ea-4dc7-a416-7a09d108aa1f@gmail.com>
Date: Fri, 18 Oct 2024 18:32:23 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: Add Nuvoton PWM controller support
To: Sean Young <sean@mess.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com
References: <20241018034857.568-1-cwweng.linux@gmail.com>
 <20241018034857.568-3-cwweng.linux@gmail.com>
 <ZxISVBz1Os0T4eqP@gofer.mess.org>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <ZxISVBz1Os0T4eqP@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sean,

Thank you for your reply.

On 2024/10/18 下午 03:46, Sean Young wrote:
> On Fri, Oct 18, 2024 at 03:48:57AM +0000, Chi-Wen Weng wrote:
>> This commit adds a generic PWM framework driver for Nuvoton MA35D1
>> PWM controller.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
>> ---
>>   drivers/pwm/Kconfig      |   9 +++
>>   drivers/pwm/Makefile     |   1 +
>>   drivers/pwm/pwm-ma35d1.c | 169 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 179 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-ma35d1.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 0915c1e7df16..97b9e83af020 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -411,6 +411,15 @@ config PWM_LPSS_PLATFORM
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-lpss-platform.
>>   
>> +config PWM_MA35D1
>> +	tristate "Nuvoton MA35D1 PWM support"
>> +	depends on ARCH_MA35 || COMPILE_TEST
>> +	help
>> +	  Generic PWM framework driver for Nuvoton MA35D1.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-ma35d1.
>> +
>>   config PWM_MESON
>>   	tristate "Amlogic Meson PWM driver"
>>   	depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 9081e0c0e9e0..c1d3a1d8add0 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
>>   obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
>>   obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
>>   obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
>> +obj-$(CONFIG_PWM_MA35D1)	+= pwm-ma35d1.o
>>   obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
>>   obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
>>   obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
>> diff --git a/drivers/pwm/pwm-ma35d1.c b/drivers/pwm/pwm-ma35d1.c
>> new file mode 100644
>> index 000000000000..dc2f1f494a91
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-ma35d1.c
>> @@ -0,0 +1,169 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for the Nuvoton MA35D1 PWM controller
>> + *
>> + * Copyright (C) 2024 Nuvoton Corporation
>> + *               Chi-Wen Weng <cwweng@nuvoton.com>
>> + */
>> +
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/io.h>
>> +#include <linux/clk.h>
>> +#include <linux/math64.h>
>> +
>> +/* The following are registers for PWM controller */
>> +#define REG_PWM_CTL0            (0x00)
>> +#define REG_PWM_CNTEN           (0x20)
>> +#define REG_PWM_PERIOD0         (0x30)
>> +#define REG_PWM_CMPDAT0         (0x50)
>> +#define REG_PWM_WGCTL0          (0xB0)
>> +#define REG_PWM_POLCTL          (0xD4)
>> +#define REG_PWM_POEN            (0xD8)
>> +
>> +#define PWM_TOTAL_CHANNELS      6
>> +#define PWM_CH_REG_SIZE         4
>> +
>> +struct nuvoton_pwm {
>> +	void __iomem *base;
>> +	u64 clkrate;
>> +};
>> +
>> +static inline struct nuvoton_pwm *to_nuvoton_pwm(struct pwm_chip *chip)
>> +{
>> +	return pwmchip_get_drvdata(chip);
>> +}
>> +
>> +static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			     const struct pwm_state *state)
>> +{
>> +	struct nuvoton_pwm *nvtpwm;
>> +	unsigned int ch = pwm->hwpwm;
>> +
>> +	nvtpwm = to_nuvoton_pwm(chip);
>> +	if (state->enabled) {
>> +		u64 duty_cycles, period_cycles;
>> +
>> +		/* Calculate the duty and period cycles */
>> +		duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
>> +						  state->duty_cycle, NSEC_PER_SEC);
>> +		if (duty_cycles > 0xFFFF)
>> +			duty_cycles = 0xFFFF;
>> +
>> +		period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
>> +						    state->period, NSEC_PER_SEC);
>> +		if (period_cycles > 0xFFFF)
>> +			period_cycles = 0xFFFF;
> If a period is not supported, return -EINVAL - maybe even do a dev_err().
> Same for the duty cycle above. It might make sense to calculate the period
> first, so that the error is more likely to be about the period than the
> duty cycle.
>
> Then again I don't know if all the drivers do this, but at least some of
> them do.

Uwe has explained it.   Thanks Uwe.

>> +
>> +		/* Write the duty and period cycles to registers */
>> +		writel(duty_cycles, nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));
>> +		writel(period_cycles, nvtpwm->base + REG_PWM_PERIOD0 + (ch * PWM_CH_REG_SIZE));
>> +		/* Enable counter */
>> +		writel(readl(nvtpwm->base + REG_PWM_CNTEN) | BIT(ch),
>> +		       nvtpwm->base + REG_PWM_CNTEN);
>> +		/* Enable output */
>> +		writel(readl(nvtpwm->base + REG_PWM_POEN) | BIT(ch),
>> +		       nvtpwm->base + REG_PWM_POEN);
>> +	} else {
>> +		/* Disable counter */
>> +		writel(readl(nvtpwm->base + REG_PWM_CNTEN) & ~BIT(ch),
>> +		       nvtpwm->base + REG_PWM_CNTEN);
>> +		/* Disable output */
>> +		writel(readl(nvtpwm->base + REG_PWM_POEN) & ~BIT(ch),
>> +		       nvtpwm->base + REG_PWM_POEN);
>> +	}
>> +
>> +	/* Set polarity state to register */
>> +	if (state->polarity == PWM_POLARITY_NORMAL)
>> +		writel(readl(nvtpwm->base + REG_PWM_POLCTL) & ~BIT(ch),
>> +		       nvtpwm->base + REG_PWM_POLCTL);
>> +	else
>> +		writel(readl(nvtpwm->base + REG_PWM_POLCTL) | BIT(ch),
>> +		       nvtpwm->base + REG_PWM_POLCTL);
>> +
>> +	return 0;
>> +}
>> +
>> +static int nuvoton_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +				 struct pwm_state *state)
>> +{
>> +	struct nuvoton_pwm *nvtpwm;
>> +	unsigned int duty_cycles, period_cycles, cnten, outen, polarity;
>> +	unsigned int ch = pwm->hwpwm;
>> +
>> +	nvtpwm = to_nuvoton_pwm(chip);
>> +
>> +	cnten = readl(nvtpwm->base + REG_PWM_CNTEN);
>> +	outen = readl(nvtpwm->base + REG_PWM_POEN);
>> +	duty_cycles = readl(nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));
>> +	period_cycles = readl(nvtpwm->base + REG_PWM_PERIOD0 + (ch * PWM_CH_REG_SIZE));
>> +	polarity = readl(nvtpwm->base + REG_PWM_POLCTL) & BIT(ch);
>> +
>> +	state->enabled = (cnten & BIT(ch)) && (outen & BIT(ch));
>> +	state->polarity = polarity ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
>> +	state->duty_cycle = DIV64_U64_ROUND_UP((u64)duty_cycles * NSEC_PER_SEC, nvtpwm->clkrate);
>> +	state->period = DIV64_U64_ROUND_UP((u64)period_cycles * NSEC_PER_SEC, nvtpwm->clkrate);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops nuvoton_pwm_ops = {
>> +	.apply = nuvoton_pwm_apply,
>> +	.get_state = nuvoton_pwm_get_state,
>> +};
>> +
>> +static int nuvoton_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct pwm_chip *chip;
>> +	struct nuvoton_pwm *nvtpwm;
>> +	struct clk *clk;
>> +	int ret;
>> +
>> +	chip = devm_pwmchip_alloc(&pdev->dev, PWM_TOTAL_CHANNELS, sizeof(*nvtpwm));
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +
>> +	nvtpwm = to_nuvoton_pwm(chip);
>> +
>> +	nvtpwm->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(nvtpwm->base))
>> +		return PTR_ERR(nvtpwm->base);
>> +
>> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
>> +	if (IS_ERR(clk))
>> +		return dev_err_probe(&pdev->dev, PTR_ERR(clk), "unable to get the clock");
>> +
>> +	nvtpwm->clkrate = clk_get_rate(clk);
>> +	if (nvtpwm->clkrate > NSEC_PER_SEC)
>> +		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
>> +
>> +	chip->ops = &nuvoton_pwm_ops;
> I think you can add chip->atomic = true; here
Ok.  I will add it.  Thanks.
>
> Sean
>
>> +
>> +	ret = devm_pwmchip_add(&pdev->dev, chip);
>> +	if (ret < 0)
>> +		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id nuvoton_pwm_of_match[] = {
>> +	{ .compatible = "nuvoton,ma35d1-pwm" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, nuvoton_pwm_of_match);
>> +
>> +static struct platform_driver nuvoton_pwm_driver = {
>> +	.probe = nuvoton_pwm_probe,
>> +	.driver = {
>> +		.name = "nuvoton-pwm",
>> +		.of_match_table = nuvoton_pwm_of_match,
>> +	},
>> +};
>> +module_platform_driver(nuvoton_pwm_driver);
>> +
>> +MODULE_ALIAS("platform:nuvoton-pwm");
>> +MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
>> +MODULE_DESCRIPTION("Nuvoton MA35D1 PWM driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.25.1

Thanks.

Chi-Wen Weng


