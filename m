Return-Path: <linux-pwm+bounces-4866-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113CCA323A7
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 11:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E1F3A259B
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 10:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4FC208960;
	Wed, 12 Feb 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+WZ44Y5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7702080EA;
	Wed, 12 Feb 2025 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356885; cv=none; b=lUeEFREWCbla/MNhqb/lt6PGhleQ5Bgqxe2grEL6b5CNUL6niB1rNaSc+vVJshqqH1B4rDoI3WpOtoJaRdnZzkGCKvf8qM7FRlDPKY6JMIJNJLF0XtXD/Doy4qnLghZ6VjvvDQ8LnH9+gDXHXrmXyCyl6h3xtR9UG9gaMvyA+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356885; c=relaxed/simple;
	bh=jGAzdAVwZda4xcQ9nvVvKe1NQZgLD61/Q9/xa6hPT1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2zBp67UtOH9hk4tGUxn56d7BuoqMiRz4st5BBgxM0IomeR8I6m/I4vnmZpIhIPxhA+Sp94tkEV1JJeXJgCTBiGq+EGjHsvPMDrAokdHvHzDXq5Dx1WSJtlw7C5GW902Dg5IjaLr9hOnZ9LCUOTgJ8CjV7u/MVC7zrdO5tvieXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+WZ44Y5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f44e7eae4so111788995ad.2;
        Wed, 12 Feb 2025 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739356883; x=1739961683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YQyjp6+29h2F3EYFjHKjF70n+p1GBygn5et5PTL1Z0=;
        b=A+WZ44Y5R1z1XV05wPgU1AB7QoF/L7SXxpMfiNSBADF+daE9yeO1si84O8x26K8EKI
         3LIuG6UabvntXuNUwGS4ZEwVZyG3cA0DfVK2WXl9yS4AMNHVIeM7uQgvQk/SyO37qPYn
         bRozDTUEi+0M/9mxLi9llmgdoXaChcJTuWiMAvAca5N7NQ2YCqeoJixe9uT0FtKE8xSk
         DHUBJSNCGBZlfY0Fp33La5jiko6PFSbMYqvBQMHPnLM9GfCAlaFVgLhiwAkw4bVZT3so
         uEhfP0zgXcU6LtFAQjXV9SBTMvzIg0qY6oW4/ZZ4+FuGefNAuopoVUp7E1iV3cTSfXuL
         VlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739356883; x=1739961683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YQyjp6+29h2F3EYFjHKjF70n+p1GBygn5et5PTL1Z0=;
        b=sLG3Fx8kJZg1fv4vLLcuHME9GSR+pPVgJDCqu0sE9FIzzbC/DZrkbmYA7fbugzC1xL
         uRkWbYQAfakU7RuMbK6s9dA4GzWgBRdSiFVoOwmy8E6xr7LxqAdrIgiOeyHFuH01Y0nK
         qAxZnv57V+htOYkw8rWa50U6zDvCVhfdJfhYyQakfU/59H6tUEL4YM4Y82SbEpr0ALlG
         ph21gfD3/LdUAKRQj3P6vM8Vc+n8auBhkzpK7zvErUN6OIksiOAz9OlR9ALH235Du9+z
         gGX9IXXKI6bh83ibsBy35Mpop3GeG4r1CeucDVnYueKL2+SUsqgkvFtsPg1ioXdeJOaf
         itUg==
X-Forwarded-Encrypted: i=1; AJvYcCUZZWNbpzAjDjojDkAW+SxV0JAxWi+eWH9/WwFfeVyeNEKCUL4Ovo7YuusSWZ/y0NVsp4HM7qLInGY0@vger.kernel.org, AJvYcCWNjPGIhAs3SaWt1zPG04KTbT24iIf0X34XW5Bxeew5CDqXlMSVSDSOTpMgRffxITrem3D3N7LPisEj@vger.kernel.org
X-Gm-Message-State: AOJu0YwHklpeY1soUUaUGeFiZ6xQSuLNFUbNsGeg2XJRszh4NOUBvv9/
	6md1mMonQWRw3StBO12m8VIic7tj/aFJCgRsMfoNBW4RTJm0PGgM
X-Gm-Gg: ASbGnctMo4yEm7NZcvTPZSJxfa5Jaop6/EurDiQvBmO8+au0kgyx4RqOyCVCE4QfZJg
	nxCBDDsNUSuJ+Sndv4FaOOhoepv2dddEgc53Zi9uZyU8kQaNd6kaHvAOLbtrXF/dDpRpg3KB98O
	ixysPRLt/Favy5mbUQnuyqeGmUU+Fwk2UTaSkoTXaRsPFe9OF7H5ukMOb6pwhV1bc1M2d/EMduU
	9WnYJHaBBA/9OFnUIInnE1GtKvgmVQJx1e85ctGJX/ZhVjscUplPq6osyQdGNqXCeZy9GdgAvuC
	xVzY8iQ5QUuhT2113bRn8u5l7Nftg+szol4Sc105Dehr8dCqh+5cmSdoO2xBBh3WjY00
X-Google-Smtp-Source: AGHT+IG7fHsk50vr9pXagmuT+ZX4Yh0LGYL9EwtalbavDIXdjP2t7+2HdTqNPipABP7b7Tt+/gYa/g==
X-Received: by 2002:a17:902:e74a:b0:215:9f5a:a236 with SMTP id d9443c01a7336-220bbaafce5mr31717535ad.6.1739356882983;
        Wed, 12 Feb 2025 02:41:22 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36561c0bsm110057805ad.102.2025.02.12.02.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 02:41:22 -0800 (PST)
Message-ID: <ed945ca8-f66a-4706-94be-8e4ff48872e6@gmail.com>
Date: Wed, 12 Feb 2025 18:41:20 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 cwweng@nuvoton.com, Trevor Gamblin <tgamblin@baylibre.com>
References: <20241206085501.2623772-1-cwweng.linux@gmail.com>
 <20241206085501.2623772-3-cwweng.linux@gmail.com>
 <c4x3spvvlxmrfypfbl57pki2akwf4rmooufw26w5ku7rwurjw4@gwtae2pqrutk>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <c4x3spvvlxmrfypfbl57pki2akwf4rmooufw26w5ku7rwurjw4@gwtae2pqrutk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe,

Thanks for your reply.


On 2025/2/7 下午 05:28, Uwe Kleine-König wrote:
> Hello,
>
> On Fri, Dec 06, 2024 at 04:55:01PM +0800, Chi-Wen Weng wrote:
>> [...]
>> diff --git a/drivers/pwm/pwm-ma35d1.c b/drivers/pwm/pwm-ma35d1.c
>> new file mode 100644
>> index 000000000000..380f17b20a3d
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-ma35d1.c
>> @@ -0,0 +1,179 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for the Nuvoton MA35D1 PWM controller
>> + *
>> + * Copyright (C) 2024 Nuvoton Corporation
>> + *               Chi-Wen Weng <cwweng@nuvoton.com>
> Please add some information here about the hardware. The idea is to get
> some info about the device's capabilities. Please stick to the format
> that many other drivers are using such that
>
> 	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/pwm-ma35d1.c
>
> emits the info for your driver. Things to mention are: possible glitches
> during .apply(); behaviour of the pin when the PWM is disabled (constant
> signal? High-Z?)
>
> Also a link to a reference manual would be awesome.
Okay, I will add the information into driver.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/math64.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +
>> +/* The following are registers address offset for MA35D1 PWM controller */
>> +#define MA35D1_REG_PWM_CTL0            (0x00)
>> +#define MA35D1_REG_PWM_CNTEN           (0x20)
>> +#define MA35D1_REG_PWM_PERIOD0         (0x30)
>> +#define MA35D1_REG_PWM_CMPDAT0         (0x50)
>> +#define MA35D1_REG_PWM_WGCTL0          (0xB0)
>> +#define MA35D1_REG_PWM_POLCTL          (0xD4)
>> +#define MA35D1_REG_PWM_POEN            (0xD8)
>> +
>> +/* The following are register address of MA35D1 PWM controller */
>> +#define MA35D1_PWM_CH_REG_SIZE         4
>> +#define MA35D1_PWM_CMPDAT0_ADDR(base, ch)     ((base) + MA35D1_REG_PWM_CMPDAT0 + \
>> +					       ((ch) * MA35D1_PWM_CH_REG_SIZE))
>> +#define MA35D1_PWM_CNTEN_ADDR(base)           ((base) + MA35D1_REG_PWM_CNTEN)
>> +#define MA35D1_PWM_PERIOD0_ADDR(base, ch)     ((base) + MA35D1_REG_PWM_PERIOD0 + \
>> +					       ((ch) * MA35D1_PWM_CH_REG_SIZE))
>> +#define MA35D1_PWM_POEN_ADDR(base)            ((base) + MA35D1_REG_PWM_POEN)
>> +#define MA35D1_PWM_POLCTL_ADDR(base)          ((base) + MA35D1_REG_PWM_POLCTL)
> I would drop the base part in these defines and add them to the above
> list sorted by address.
>
> So something like:
>
> #define MA35D1_REG_PWM_CTL0		0x00
> #define MA35D1_REG_PWM_CNTEN		0x20
> #define MA35D1_REG_PWM_PERIOD(ch)	(0x30 + 4 * (ch))
> #define MA35D1_REG_PWM_CMPDAT(ch)	(0x50 + 4 * (ch))
> #define MA35D1_REG_PWM_WGCTL0		0xB0
> #define MA35D1_REG_PWM_POLCTL		0xD4
> #define MA35D1_REG_PWM_POEN		0xD8
>
> To make up for the missing base, I'd create wrappers for readl and
> writel à la:
>
> 	static u32 nuvoton_pwm_readl(struct nuvoton_pwm *nvtpwm, unsigned int offset);
> 	static void nuvoton_pwm_writel(struct nuvoton_pwm *nvtpwm, unsigned int offset, u32 value);
>
> As you see I wouldn't use a define for 4, because IMHO that hurts
> readability. But I don't feel strong here.

It really can let my driver more readable. Thanks.


>
>> +#define MA35D1_PWM_MAX_COUNT           0xFFFF
>> +#define MA35D1_PWM_TOTAL_CHANNELS      6
> s/TOTAL/NUM/
Okay, I will modify it in next version.
>> +
>> +struct nuvoton_pwm {
>> +	void __iomem *base;
>> +	u64 clkrate;
> clk_get_rate() returns an unsigned long value. Please stick to that for
> .clkrate as there is no use to double the size of this struct on 32-bit
> platforms just to store zeros and padding.
Okay, I will modify it in next version.
>> +};
>> +
>> +static inline struct nuvoton_pwm *to_nuvoton_pwm(struct pwm_chip *chip)
>> +{
>> +	return pwmchip_get_drvdata(chip);
>> +}
> I slightly prefer nuvoton_pwm_from_chip() for this function's name to
> have the same function prefix for all functions here.
Okay, I will modify it in next version.
>> +
>> +static int nuvoton_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			     const struct pwm_state *state)
>> +{
>> +	struct nuvoton_pwm *nvtpwm;
>> +	u32 ch = pwm->hwpwm;
>> +
>> +	nvtpwm = to_nuvoton_pwm(chip);
>> +	if (state->enabled) {
>> +		u64 duty_cycles, period_cycles;
>> +
>> +		/* Calculate the duty and period cycles */
>> +		duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
>> +						  state->duty_cycle, NSEC_PER_SEC);
>> +		if (duty_cycles > MA35D1_PWM_MAX_COUNT)
>> +			duty_cycles = MA35D1_PWM_MAX_COUNT;
>> +
>> +		period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
>> +						    state->period, NSEC_PER_SEC);
>> +		if (period_cycles > MA35D1_PWM_MAX_COUNT)
>> +			period_cycles = MA35D1_PWM_MAX_COUNT;
>> +
>> +		/* Write the duty and period cycles to registers */
>> +		writel(duty_cycles, MA35D1_PWM_CMPDAT0_ADDR(nvtpwm->base, ch));
>> +		writel(period_cycles, MA35D1_PWM_PERIOD0_ADDR(nvtpwm->base, ch));
>> +		/* Enable counter */
>> +		writel(readl(MA35D1_PWM_CNTEN_ADDR(nvtpwm->base)) | BIT(ch),
>> +		       MA35D1_PWM_CNTEN_ADDR(nvtpwm->base));
>> +		/* Enable output */
>> +		writel(readl(MA35D1_PWM_POEN_ADDR(nvtpwm->base)) | BIT(ch),
>> +		       MA35D1_PWM_POEN_ADDR(nvtpwm->base));
> Can this result in glitches? E.g. is it possible to see a waveform with
> the old period_cycles but the new duty_cycles output? If you switch
> polarity, do you see the new settings with the wrong polarity for some
> time? Setup polarity before enabling the counter and output? Maybe only
> enable the counter when the output is enabled to be sure to emit the
> first edge with the correct timing?

Yes, enable counter should be after the output is enabled. Will fix in 
next version.


>> +	} else {
>> +		/* Disable counter */
>> +		writel(readl(MA35D1_PWM_CNTEN_ADDR(nvtpwm->base)) & ~BIT(ch),
>> +		       MA35D1_PWM_CNTEN_ADDR(nvtpwm->base));
>> +		/* Disable output */
>> +		writel(readl(MA35D1_PWM_POEN_ADDR(nvtpwm->base)) & ~BIT(ch),
>> +		       MA35D1_PWM_POEN_ADDR(nvtpwm->base));
> Maybe add another wrapper for this kind of rmw operation. Also I suggest
> to introduce a name for BIT(ch) here such that this can become:
>
> 	nuvoton_pwm_rmw(nvtpwm, MA35D1_REG_PWM_POEN, MA35D1_REG_PWM_POEN_EN(ch), 0);
>
> (Assuming "EN0" is the name of the bit for channel 0 in
> MA35D1_REG_PWM_POEN.)
Okay, I will modify it next version.
>> +	}
>> +
>> +	/* Set polarity state to register */
>> +	if (state->polarity == PWM_POLARITY_NORMAL)
>> +		writel(readl(MA35D1_PWM_POLCTL_ADDR(nvtpwm->base)) & ~BIT(ch),
>> +		       MA35D1_PWM_POLCTL_ADDR(nvtpwm->base));
>> +	else
>> +		writel(readl(MA35D1_PWM_POLCTL_ADDR(nvtpwm->base)) | BIT(ch),
>> +		       MA35D1_PWM_POLCTL_ADDR(nvtpwm->base));
> You can skip setting up period if !state->enabled.
Yes, it should be skip if !state->enabled.
>> +	return 0;
>> +}
>> +
>> [...]
>> +
>> +static int nuvoton_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct pwm_chip *chip;
>> +	struct nuvoton_pwm *nvtpwm;
>> +	struct clk *clk;
>> +	int ret;
>> +
>> +	chip = devm_pwmchip_alloc(&pdev->dev, MA35D1_PWM_TOTAL_CHANNELS, sizeof(*nvtpwm));
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
> Please start all error messages with a capital letter and end them with
> \n.
>
> devm_clk_rate_exclusive_get(&pdev->dev, clk) here please.
Okay, I will modify it in next version.
>> +
>> +	nvtpwm->clkrate = clk_get_rate(clk);
>> +	if (nvtpwm->clkrate > NSEC_PER_SEC)
>> +		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
> 	return dev_err_probe(&pdev->dev, -EINVAL, "PWM clock out of range (%lu)\n", nvtpwm->clkrate);
Okay, I will modify it in next version.
>> +
>> +	chip->ops = &nuvoton_pwm_ops;
>> +	chip->atomic = true;
>> +
>> +	ret = devm_pwmchip_add(&pdev->dev, chip);
>> +	if (ret < 0)
>> +		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
>> +
>> +	return 0;
>> +}
> Best regards
> Uwe


Thanks.

Chi-Wen Weng



