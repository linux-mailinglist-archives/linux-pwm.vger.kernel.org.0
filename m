Return-Path: <linux-pwm+bounces-4267-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF369E6708
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 06:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7735316395B
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 05:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27807198840;
	Fri,  6 Dec 2024 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3ZaZ0r3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC22198A0F;
	Fri,  6 Dec 2024 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464577; cv=none; b=t6Kj+/erwa52W3l3/o7A/LN7lA239iNh7EKq+7Ib+chuhdAsvfeQ7upudTX6M5yptQ37WaEOVSRtlMvUr/ZQ1nLT659t6Ldk6h7AvSbBTLJPApnCvKabmzE+mu28sX2riJE2SEvvLSk+xrVb0HLE0636RyYUp7vaAgqPsWoUIew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464577; c=relaxed/simple;
	bh=LG++rxkz6aF0UonSG/ss7Vo9oTgDBvUpV839JgjPuq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biNsIMYbewQP0ozKtqDx4X6RMaoBg5qHsaxwZGNEwtVWEV4z+1QdfhnA/RgS1vO0t85U8YZ+uyQGYnwCQ8r0PVVbjTqyxWqe1eBx8wUXhp9dV9f32AGwVn4Hiy0gmAEOwm/CdYQS87D6wiE9ay/srkvdIGuKrWhF1Dw3pDqhhCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3ZaZ0r3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so1129507a12.1;
        Thu, 05 Dec 2024 21:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733464574; x=1734069374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbPwtCFtDKOYfsAyd5gynahX6aE+Ern2nSGQPs3IvPQ=;
        b=d3ZaZ0r3vfY6mU92iA1xstNSRrrtfLKbJ0JEFlOYbpQtllVoiDsK2QAu2MC5NhxGcj
         rVzp8rGB6T/wnstO3TwRrZuDoCQkPVeXWBvKJv5oJUB36thLeGda1cv8u2QaISWhKsTb
         1awAXVLbPTy5RyqAgvr6R8Ji4wsZlPaRTh3OeSNBrfm0wf84HGB26Yj/1ddZ+ZF7eMsV
         OdG1Rary1I9f1ujTWONj/d+RUlImhS9BzKIY4GGE2kZeLK7cpjh7IChwd7VFhza9Top8
         54yoU2zJ0tBRIc3JP3cPx4lnnw2T2+3gg1lK3co3vycesfe+8gntiq/4C6F+uIbgdkqG
         /0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733464574; x=1734069374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbPwtCFtDKOYfsAyd5gynahX6aE+Ern2nSGQPs3IvPQ=;
        b=Tm6L6431JtnB8JYQ9bIJ2T5XwylvUVM6Q32SNH8QENthTrTOf66ZbCSLufEqBxeCi4
         3x3js+8lXoPuNZcb7e8PSfauPFIBZl40rMayaKXnfNw7ZUMWv46eKCrgXFZvdAig2Sc0
         udF2/fGBWLa13eM6ouQ7oZ5D25bGtbT62cMsXAiZmhHdoQTFDIG4Z2sSe77FL0HR9PDa
         shKu4NDQ9uX9LA1W9drhbHrQLaIFV6t/Dj/SU8sIWc1l0nyKtI2XmEHydXggWIZAbVm8
         Jl+1FjYQIlDn0CbDTXInoA7P5MjDaa8yAO+1NMtAtciTBbpcJMmvTHqsgLzY9gf346lO
         0hCw==
X-Forwarded-Encrypted: i=1; AJvYcCWoeZPN0CoP7UQW9Pe+fzTRhSgsAyB619yDf5TZLlh8cLiut+YnjJjGti79muGkzMorYfGGZarkxDFy@vger.kernel.org, AJvYcCWyuhzoktPyBy29lOHORniWjeDINPNI3it0GmWWXfvT+I5AC66qaAq6TpN47PVECiiMvWv2XEdWHeRF@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmU9nNiM1TNVnTdpi52ZPXvtcf03c5Jd/JZoW79ICHcoLQUfK
	MKgvb5YWxTZwTftG/MTb7VcFQDVqDhXc6iWbitF8FsH8KqIp3e8q
X-Gm-Gg: ASbGncs0wt/NRkLzp2Ch8BuDc1hZmYIq7G1eJVZtLrhGp0uxh5pHg0CqxB8qxXmvge3
	vo02k0XW4WW+ezAkPrF31U7LHQpylh2Mwf6jauvfIKrFwR0bn/itk0ey9blqZtAnB6N1q4PMGEu
	gBSKKlu6RRiNEBdSCrVpU4wIuvjFqu0GlT2HKnjtmkZROxara0zmFr57r6dvfTp6eZWMtAEtSxz
	SFZ2FIwDvrDYV5e//76W3Que7TCZYMnIuyAQy8n6j5egYUuOEvUc+73mgmYNSlALeoum0q7V/ZF
	R8WCriKiHYFRpBH8sMOjhhYZ6pY=
X-Google-Smtp-Source: AGHT+IGZ60nU8ZxdG/rsdttCQUnLk2ZqXDWX3RjvHZ+IkyfCt2i4bnXOFWji4A0jXqYf8xiUHOWNbQ==
X-Received: by 2002:a05:6a21:339f:b0:1db:e82e:c802 with SMTP id adf61e73a8af0-1e1871402f1mr2707707637.41.1733464574323;
        Thu, 05 Dec 2024 21:56:14 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd24de09c8sm615347a12.29.2024.12.05.21.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 21:56:13 -0800 (PST)
Message-ID: <6f1d42d7-1554-4545-b09d-8432e033a96e@gmail.com>
Date: Fri, 6 Dec 2024 13:56:11 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/2] pwm: Add Nuvoton MA35D1 PWM controller
 support
To: Trevor Gamblin <tgamblin@baylibre.com>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 cwweng@nuvoton.com
References: <20241024104309.169510-1-cwweng.linux@gmail.com>
 <20241024104309.169510-3-cwweng.linux@gmail.com>
 <5a6ad0dc-f777-4129-962f-e10a0f7d6ee1@baylibre.com>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <5a6ad0dc-f777-4129-962f-e10a0f7d6ee1@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Trevor,

Thanks for your suggestions.


On 2024/11/21 上午 12:49, Trevor Gamblin wrote:
> Hello,
>
> On 2024-10-24 06:43, Chi-Wen Weng wrote:
>> This commit adds a generic PWM framework driver for Nuvoton MA35D1
>> PWM controller.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
>> ---
>>   drivers/pwm/Kconfig      |   9 +++
>>   drivers/pwm/Makefile     |   1 +
>>   drivers/pwm/pwm-ma35d1.c | 169 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 179 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-ma35d1.c
> I don't see a MAINTAINERS entry? That needs to be added in the 
> bindings patch first, and then it should be updated to list this 
> driver file.
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 0915c1e7df16..97b9e83af020 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -411,6 +411,15 @@ config PWM_LPSS_PLATFORM
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-lpss-platform.
>>   +config PWM_MA35D1
>> +    tristate "Nuvoton MA35D1 PWM support"
>> +    depends on ARCH_MA35 || COMPILE_TEST
>> +    help
>> +      Generic PWM framework driver for Nuvoton MA35D1.
>> +
>> +      To compile this driver as a module, choose M here: the module
>> +      will be called pwm-ma35d1.
>> +
>>   config PWM_MESON
>>       tristate "Amlogic Meson PWM driver"
>>       depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 9081e0c0e9e0..c1d3a1d8add0 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)    += pwm-lpc32xx.o
>>   obj-$(CONFIG_PWM_LPSS)        += pwm-lpss.o
>>   obj-$(CONFIG_PWM_LPSS_PCI)    += pwm-lpss-pci.o
>>   obj-$(CONFIG_PWM_LPSS_PLATFORM)    += pwm-lpss-platform.o
>> +obj-$(CONFIG_PWM_MA35D1)    += pwm-ma35d1.o
>>   obj-$(CONFIG_PWM_MESON)        += pwm-meson.o
>>   obj-$(CONFIG_PWM_MEDIATEK)    += pwm-mediatek.o
>>   obj-$(CONFIG_PWM_MICROCHIP_CORE)    += pwm-microchip-core.o
>> diff --git a/drivers/pwm/pwm-ma35d1.c b/drivers/pwm/pwm-ma35d1.c
>> new file mode 100644
>> index 000000000000..0c4eec4a0b07
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-ma35d1.c
>> @@ -0,0 +1,169 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for the Nuvoton MA35D1 PWM controller
>> + *
>> + * Copyright (C) 2024 Nuvoton Corporation
>> + *               Chi-Wen Weng <cwweng@nuvoton.com>
>> + */
>> +
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/io.h>
>> +#include <linux/clk.h>
>> +#include <linux/math64.h>
> These should be organized alphabetically.
>> +
>> +/* The following are registers for PWM controller */
>> +#define REG_PWM_CTL0            (0x00)
>> +#define REG_PWM_CNTEN           (0x20)
>> +#define REG_PWM_PERIOD0         (0x30)
>> +#define REG_PWM_CMPDAT0         (0x50)
>> +#define REG_PWM_WGCTL0          (0xB0)
>> +#define REG_PWM_POLCTL          (0xD4)
>> +#define REG_PWM_POEN            (0xD8)
>
> These too, I think - it will make it more readable for others.
>
> You should also prefix all of your macros to be more explicit about 
> their use, e.g. MA35D1_REG_PWM_CTL0. That way it's clearer that 
> they're specific to this driver and not from elsewhere.
>
>> +
>> +#define PWM_TOTAL_CHANNELS      6
>> +#define PWM_CH_REG_SIZE         4
> And these.
>> +
>> +struct nuvoton_pwm {
>> +    void __iomem *base;
>> +    u64 clkrate;
>> +};
>> +
>> +static inline struct nuvoton_pwm *to_nuvoton_pwm(struct pwm_chip *chip)
>> +{
>> +    return pwmchip_get_drvdata(chip);
>> +}
>> +
>> +static int nuvoton_pwm_apply(struct pwm_chip *chip, struct 
>> pwm_device *pwm,
>> +                 const struct pwm_state *state)
>> +{
>> +    struct nuvoton_pwm *nvtpwm;
>> +    unsigned int ch = pwm->hwpwm;
>> +
>> +    nvtpwm = to_nuvoton_pwm(chip);
>> +    if (state->enabled) {
>> +        u64 duty_cycles, period_cycles;
>> +
>> +        /* Calculate the duty and period cycles */
>> +        duty_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
>> +                          state->duty_cycle, NSEC_PER_SEC);
>> +        if (duty_cycles > 0xFFFF)
>> +            duty_cycles = 0xFFFF;
> It would be good to create a macro for this value 0xFFFF, e.g. 
> MA35D1_MAX_PWM_RATE.
>> +
>> +        period_cycles = mul_u64_u64_div_u64(nvtpwm->clkrate,
>> +                            state->period, NSEC_PER_SEC);
>> +        if (period_cycles > 0xFFFF)
>> +            period_cycles = 0xFFFF;
>> +
>> +        /* Write the duty and period cycles to registers */
>> +        writel(duty_cycles, nvtpwm->base + REG_PWM_CMPDAT0 + (ch * 
>> PWM_CH_REG_SIZE));
>> +        writel(period_cycles, nvtpwm->base + REG_PWM_PERIOD0 + (ch * 
>> PWM_CH_REG_SIZE));
>
> Since you are using things like
>
> nvtpwm->base + REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE)
>
> and similar so frequently, I suggest creating more macros for these 
> sorts of accesses to improve readability, e.g.
>
> #define MA35D1_PWM_CMPDAT0_ADDR(base, ch)     base + REG_PWM_CMPDAT0 + 
> (ch * PWM_CH_REG_SIZE));
>
> or even
>
> #define MA35D1_PWM_CMPDAT0_ADDR(nvtpwm, ch)     nvtpwm->base + 
> REG_PWM_CMPDAT0 + (ch * PWM_CH_REG_SIZE));
>
> and then use those instead.
>
>> +        /* Enable counter */
>> +        writel(readl(nvtpwm->base + REG_PWM_CNTEN) | BIT(ch),
>> +               nvtpwm->base + REG_PWM_CNTEN);
> Same for cases like this.
>> +        /* Enable output */
>> +        writel(readl(nvtpwm->base + REG_PWM_POEN) | BIT(ch),
>> +               nvtpwm->base + REG_PWM_POEN);
>> +    } else {
>> +        /* Disable counter */
>> +        writel(readl(nvtpwm->base + REG_PWM_CNTEN) & ~BIT(ch),
>> +               nvtpwm->base + REG_PWM_CNTEN);
>> +        /* Disable output */
>> +        writel(readl(nvtpwm->base + REG_PWM_POEN) & ~BIT(ch),
>> +               nvtpwm->base + REG_PWM_POEN);
>> +    }
>> +
>> +    /* Set polarity state to register */
>> +    if (state->polarity == PWM_POLARITY_NORMAL)
>> +        writel(readl(nvtpwm->base + REG_PWM_POLCTL) & ~BIT(ch),
>> +               nvtpwm->base + REG_PWM_POLCTL);
>> +    else
>> +        writel(readl(nvtpwm->base + REG_PWM_POLCTL) | BIT(ch),
>> +               nvtpwm->base + REG_PWM_POLCTL);
>> +
>> +    return 0;
>> +}
>> +
>> +static int nuvoton_pwm_get_state(struct pwm_chip *chip, struct 
>> pwm_device *pwm,
>> +                 struct pwm_state *state)
>> +{
>> +    struct nuvoton_pwm *nvtpwm;
>> +    unsigned int duty_cycles, period_cycles, cnten, outen, polarity;
>> +    unsigned int ch = pwm->hwpwm;
>> +
>> +    nvtpwm = to_nuvoton_pwm(chip);
>> +
>> +    cnten = readl(nvtpwm->base + REG_PWM_CNTEN);
>> +    outen = readl(nvtpwm->base + REG_PWM_POEN);
>> +    duty_cycles = readl(nvtpwm->base + REG_PWM_CMPDAT0 + (ch * 
>> PWM_CH_REG_SIZE));
>> +    period_cycles = readl(nvtpwm->base + REG_PWM_PERIOD0 + (ch * 
>> PWM_CH_REG_SIZE));
>> +    polarity = readl(nvtpwm->base + REG_PWM_POLCTL) & BIT(ch);
>> +
>> +    state->enabled = (cnten & BIT(ch)) && (outen & BIT(ch));
>> +    state->polarity = polarity ? PWM_POLARITY_INVERSED : 
>> PWM_POLARITY_NORMAL;
>> +    state->duty_cycle = DIV64_U64_ROUND_UP((u64)duty_cycles * 
>> NSEC_PER_SEC, nvtpwm->clkrate);
>> +    state->period = DIV64_U64_ROUND_UP((u64)period_cycles * 
>> NSEC_PER_SEC, nvtpwm->clkrate);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct pwm_ops nuvoton_pwm_ops = {
>> +    .apply = nuvoton_pwm_apply,
>> +    .get_state = nuvoton_pwm_get_state,
>> +};
>> +
>> +static int nuvoton_pwm_probe(struct platform_device *pdev)
>> +{
>> +    struct pwm_chip *chip;
>> +    struct nuvoton_pwm *nvtpwm;
>> +    struct clk *clk;
>> +    int ret;
>> +
>> +    chip = devm_pwmchip_alloc(&pdev->dev, PWM_TOTAL_CHANNELS, 
>> sizeof(*nvtpwm));
>> +    if (IS_ERR(chip))
>> +        return PTR_ERR(chip);
>> +
>> +    nvtpwm = to_nuvoton_pwm(chip);
>> +
>> +    nvtpwm->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(nvtpwm->base))
>> +        return PTR_ERR(nvtpwm->base);
>> +
>> +    clk = devm_clk_get_enabled(&pdev->dev, NULL);
>> +    if (IS_ERR(clk))
>> +        return dev_err_probe(&pdev->dev, PTR_ERR(clk), "unable to 
>> get the clock");
>> +
>> +    nvtpwm->clkrate = clk_get_rate(clk);
>> +    if (nvtpwm->clkrate > NSEC_PER_SEC)
>> +        return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of 
>> range");
>> +
>> +    chip->ops = &nuvoton_pwm_ops;
>> +    chip->atomic = true;
>> +
>> +    ret = devm_pwmchip_add(&pdev->dev, chip);
>> +    if (ret < 0)
>> +        return dev_err_probe(&pdev->dev, ret, "unable to add pwm 
>> chip");
>> +
>> +    return 0;
>> +}
>
> As a final note, please be aware that there is a change to the PWM 
> subsystem coming in 6.13. You don't need to do anything now, but it's 
> worth considering how the driver might change once that hits mainline.
>
> You can find the changes here: 
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/?h=pwm/duty_offset 
> .
>
>> +
>> +static const struct of_device_id nuvoton_pwm_of_match[] = {
>> +    { .compatible = "nuvoton,ma35d1-pwm" },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(of, nuvoton_pwm_of_match);
>> +
>> +static struct platform_driver nuvoton_pwm_driver = {
>> +    .probe = nuvoton_pwm_probe,
>> +    .driver = {
>> +        .name = "nuvoton-pwm",
>> +        .of_match_table = nuvoton_pwm_of_match,
>> +    },
>> +};
>> +module_platform_driver(nuvoton_pwm_driver);
>> +
>> +MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
>> +MODULE_DESCRIPTION("Nuvoton MA35D1 PWM driver");
>> +MODULE_LICENSE("GPL");

Per Uwe's commet, I will keep the registers in address order.

Otherwise I will modify in next version.


Thanks.

Chi-Wen Weng



