Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745E7AC1B0
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Sep 2023 14:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjIWMIj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 Sep 2023 08:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjIWMIj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 Sep 2023 08:08:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DA019A
        for <linux-pwm@vger.kernel.org>; Sat, 23 Sep 2023 05:08:26 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5FF8D3F66B
        for <linux-pwm@vger.kernel.org>; Sat, 23 Sep 2023 12:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695470905;
        bh=xmHOI9xHaJfSFKycbIsoC9mBUnTm7US6Zsq9xHlg7y8=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=T9BW6pPaHVpf3bqI/sUHUHTIrpDoQXnH1FtWaI30fd0ZRz1bcYQ03OjNoBeWwAksH
         YvkdKVntLFGopajhqYasThIbL3tUPTPvtOLK4Cpnx1okwP3KefA5ySKR33vUYPl6dA
         9dXzpHf3lG7/UN5ur8mG6EGFvBzi8bly1QrE28B/TD+KjTEj/T5jqxwLQDX9jMUuE/
         CTRpvY0gv93tDOSNZucB/R0crTk4PrnbruAAFGDjOtXSS6mdkzMJ1z343WpK2bVCp/
         5QJ/4Jv+siPGLQduL89H1677JCxGszfsAjGsUx1KzZWsPkSMvGwxfSWwF2bglDjXC8
         SzxxphNNvpU6A==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4180c46f2abso11011511cf.1
        for <linux-pwm@vger.kernel.org>; Sat, 23 Sep 2023 05:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695470904; x=1696075704;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmHOI9xHaJfSFKycbIsoC9mBUnTm7US6Zsq9xHlg7y8=;
        b=QiGuAFIN908iL3EurztvWBDbMnJT9wVdVrBhiwvL9vUhbxMMfN+C8sjxdLnOuOnthU
         bf8HJb9MmruTv5B1MYsdfXUUnblfeiu2qJ4YfqFuI8xJYJh5v/QwIy5TYFzYXyl0F65r
         gfJ42vDuxS55WIz2L52pE3ATIQexkbG46WtmzQcN1998CD9wUOQeq/uwDoFm8fkpw/Yv
         XqVhkq/tFzepVpPrw/njX+P6LWx4F6pRFKQotwnU8OhPDm0YJ/3SOIWV9iNzbNaJOs2c
         +p7GRGhib5ZSDNJ5ddVt302+myF1B746FHFFebGuyd8lon5vlTyWMWEs6kE8tSh4kFBo
         CXKQ==
X-Gm-Message-State: AOJu0Yx9zYA9Wj37WsY0e4Z9y+TTjtzdVFQGDgE3aIjZqOE+AygBuSLi
        xISjoxn40oZIaZDlzvXJ4YbHmC7RIXR1I3hqHzOOgu+FETpJPtstkvHwtNWvx9RgghYCG52K1lD
        1tgjpB2Nwa9RLHi1P3lmc8D29NX7fDIZYd0aDKOeYPV0OubUYob0E/WOtd88phw==
X-Received: by 2002:a05:622a:13ce:b0:412:258f:1b76 with SMTP id p14-20020a05622a13ce00b00412258f1b76mr2830716qtk.49.1695470904227;
        Sat, 23 Sep 2023 05:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/+Il0xseog5yAoxSzoaEcV8/tye5bH7xgyEnEeKrKyd4mOFX+E3GA4XasNt9L5qfHVk31t4uh07uTBKqg6WA=
X-Received: by 2002:a05:622a:13ce:b0:412:258f:1b76 with SMTP id
 p14-20020a05622a13ce00b00412258f1b76mr2830696qtk.49.1695470903954; Sat, 23
 Sep 2023 05:08:23 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 07:08:23 -0500
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230922092848.72664-3-william.qiu@starfivetech.com>
References: <20230922092848.72664-1-william.qiu@starfivetech.com> <20230922092848.72664-3-william.qiu@starfivetech.com>
Mime-Version: 1.0
Date:   Sat, 23 Sep 2023 07:08:23 -0500
Message-ID: <CAJM55Z8d368MAQPpnRO8giKmasN5XETP40i3JVdW_0gTF3Ktqg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] pwm: starfive: Add PWM driver support
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

William Qiu wrote:
> Add Pulse Width Modulation driver support for StarFive
> JH7100 and JH7110 SoC.
>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS                |   7 ++
>  drivers/pwm/Kconfig        |   9 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-starfive.c | 190 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 207 insertions(+)
>  create mode 100644 drivers/pwm/pwm-starfive.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf0f54c24f81..bc2155bd2712 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20495,6 +20495,13 @@ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
>  F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>  F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
>
> +STARFIVE JH71X0 PWM DRIVERS
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/starfive,jh7100-pwm.yaml
> +F:	drivers/pwm/pwm-starfive-ptc.c
> +
>  STARFIVE JH71X0 RESET CONTROLLER DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  M:	Hal Feng <hal.feng@starfivetech.com>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8ebcddf91f7b..e2ee0169f6e4 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -569,6 +569,15 @@ config PWM_SPRD
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sprd.
>
> +config PWM_STARFIVE
> +	tristate "StarFive PWM support"
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	help
> +	  Generic PWM framework driver for StarFive SoCs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-starfive.
> +
>  config PWM_STI
>  	tristate "STiH4xx PWM support"
>  	depends on ARCH_STI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c822389c2a24..93b954376873 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>  obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
> +obj-$(CONFIG_PWM_STARFIVE)	+= pwm-starfive.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
> diff --git a/drivers/pwm/pwm-starfive.c b/drivers/pwm/pwm-starfive.c

Hi William,

You never answered my questions about what PTC is short for and if there are
other PWMs on the JH7110. You just removed -ptc from the name of this file..

> new file mode 100644
> index 000000000000..d390349fc95d
> --- /dev/null
> +++ b/drivers/pwm/pwm-starfive.c
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PWM driver for the StarFive JH71x0 SoC
> + *
> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>
> +
> +/* Access PTC register (CNTR, HRC, LRC and CTRL) */
> +#define REG_PTC_BASE_ADDR_SUB(base, N)	((base) + (((N) > 3) ? \
> +					(((N) % 4) * 0x10 + (1 << 15)) : ((N) * 0x10)))
> +#define REG_PTC_RPTC_CNTR(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N))
> +#define REG_PTC_RPTC_HRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x4)
> +#define REG_PTC_RPTC_LRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x8)
> +#define REG_PTC_RPTC_CTRL(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0xC)

..but these defines

> +
> +/* PTC_RPTC_CTRL register bits*/
> +#define PTC_EN      BIT(0)
> +#define PTC_ECLK    BIT(1)
> +#define PTC_NEC     BIT(2)
> +#define PTC_OE      BIT(3)
> +#define PTC_SIGNLE  BIT(4)
> +#define PTC_INTE    BIT(5)
> +#define PTC_INT     BIT(6)
> +#define PTC_CNTRRST BIT(7)
> +#define PTC_CAPTE   BIT(8)

..and these defines are still prefixed with *PTC where I'd expect something like
STARFIVE_PWM_, and below structs and function names are also still
using starfive_pwm_ptc_
where I'd expect starfive_pwm_. Please be consistant in your naming.

> +struct starfive_pwm_ptc_device {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	void __iomem *regs;
> +	u32 clk_rate; /* PWM APB clock frequency */
> +};
> +
> +static inline struct starfive_pwm_ptc_device *
> +chip_to_starfive_ptc(struct pwm_chip *chip)
> +
> +{
> +	return container_of(chip, struct starfive_pwm_ptc_device, chip);
> +}
> +
> +static int starfive_pwm_ptc_get_state(struct pwm_chip *chip,
> +				      struct pwm_device *dev,
> +				      struct pwm_state *state)
> +{
> +	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
> +	u32 period_data, duty_data, ctrl_data;
> +
> +	period_data = readl(REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
> +	duty_data = readl(REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
> +	ctrl_data = readl(REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
> +
> +	state->period = DIV_ROUND_CLOSEST_ULL((u64)period_data * NSEC_PER_SEC, pwm->clk_rate);
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL((u64)duty_data * NSEC_PER_SEC, pwm->clk_rate);
> +	state->polarity = PWM_POLARITY_INVERSED;
> +	state->enabled = (ctrl_data & PTC_EN) ? true : false;
> +
> +	return 0;
> +}
> +
> +static int starfive_pwm_ptc_apply(struct pwm_chip *chip,
> +				  struct pwm_device *dev,
> +				  const struct pwm_state *state)
> +{
> +	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
> +	u32 period_data, duty_data, ctrl_data = 0;
> +
> +	if (state->polarity != PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	period_data = DIV_ROUND_CLOSEST_ULL(state->period * pwm->clk_rate,
> +					    NSEC_PER_SEC);
> +	duty_data = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * pwm->clk_rate,
> +					  NSEC_PER_SEC);
> +
> +	writel(period_data, REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
> +	writel(duty_data, REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
> +	writel(0,  REG_PTC_RPTC_CNTR(pwm->regs, dev->hwpwm));
> +
> +	ctrl_data = readl(REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
> +	if (state->enabled)
> +		writel(ctrl_data | PTC_EN | PTC_OE, REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
> +	else
> +		writel(ctrl_data & ~(PTC_EN | PTC_OE), REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm));
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops starfive_pwm_ptc_ops = {
> +	.get_state	= starfive_pwm_ptc_get_state,
> +	.apply		= starfive_pwm_ptc_apply,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int starfive_pwm_ptc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct starfive_pwm_ptc_device *pwm;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	chip = &pwm->chip;
> +	chip->dev = dev;
> +	chip->ops = &starfive_pwm_ptc_ops;
> +	chip->npwm = 8;
> +	chip->of_pwm_n_cells = 3;
> +
> +	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pwm->regs))
> +		return dev_err_probe(dev, PTR_ERR(pwm->regs),
> +				     "Unable to map IO resources\n");
> +
> +	pwm->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(pwm->clk))
> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> +				     "Unable to get pwm's clock\n");
> +
> +	pwm->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pwm->rst))
> +		return dev_err_probe(dev, PTR_ERR(pwm->rst),
> +				     "Unable to get pwm's reset\n");
> +
> +	ret = reset_control_deassert(pwm->rst);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable clock for pwm: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pwm->clk_rate = clk_get_rate(pwm->clk);
> +	if (pwm->clk_rate <= 0) {
> +		dev_warn(dev, "Failed to get APB clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot register PTC: %d\n", ret);
> +		clk_disable_unprepare(pwm->clk);
> +		reset_control_assert(pwm->rst);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int starfive_pwm_ptc_remove(struct platform_device *dev)
> +{
> +	struct starfive_pwm_ptc_device *pwm = platform_get_drvdata(dev);
> +
> +	reset_control_assert(pwm->rst);
> +	clk_disable_unprepare(pwm->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id starfive_pwm_ptc_of_match[] = {
> +	{ .compatible = "starfive,jh7100-pwm" },
> +	{ .compatible = "starfive,jh7110-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, starfive_pwm_ptc_of_match);
> +
> +static struct platform_driver starfive_pwm_ptc_driver = {
> +	.probe = starfive_pwm_ptc_probe,
> +	.remove = starfive_pwm_ptc_remove,
> +	.driver = {
> +		.name = "pwm-starfive-ptc",

Here

> +		.of_match_table = starfive_pwm_ptc_of_match,
> +	},
> +};
> +module_platform_driver(starfive_pwm_ptc_driver);
> +
> +MODULE_AUTHOR("Jieqin Chen");
> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
> +MODULE_DESCRIPTION("StarFive PWM PTC driver");

..and here you're also still calling the driver PTC without explaining why.

> +MODULE_LICENSE("GPL");
> --
> 2.34.1
>
