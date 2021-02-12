Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654EF319B42
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Feb 2021 09:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBLIdO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Feb 2021 03:33:14 -0500
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:38578 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhBLIdL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Feb 2021 03:33:11 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 11C8Urdh007948; Fri, 12 Feb 2021 17:30:53 +0900
X-Iguazu-Qid: 34tMK0YvjHbwIp64gD
X-Iguazu-QSIG: v=2; s=0; t=1613118652; q=34tMK0YvjHbwIp64gD; m=XXCDxVKpf4aQwjavsXtZ3BLAX2tHngY0b2N6NzuemsQ=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id 11C8Upqq014136;
        Fri, 12 Feb 2021 17:30:52 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 11C8Upgm015122;
        Fri, 12 Feb 2021 17:30:51 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11C8Up9s023702;
        Fri, 12 Feb 2021 17:30:51 +0900
Date:   Fri, 12 Feb 2021 17:30:49 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     linux-pwm@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        devicetree@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM support
X-TSB-HOP: ON
Message-ID: <20210212083049.ue4iuojjz3qjj5jn@toshiba.co.jp>
References: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200917223140.227542-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <87zh5jjyhh.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh5jjyhh.fsf@kokedama.swc.toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi, 

Thanks for your review.

On Mon, Sep 21, 2020 at 06:00:26PM +0900, Punit Agrawal wrote:
> Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp> writes:
> 
> > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> >
> > Add a driver for the PWM controller on Toshiba Visconti ARM SoC.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  drivers/pwm/Kconfig        |   9 +++
> >  drivers/pwm/Makefile       |   1 +
> >  drivers/pwm/pwm-visconti.c | 141 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 151 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-visconti.c
> >
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index cb8d739067d2..f99d48f74c76 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -533,6 +533,15 @@ config PWM_TIEHRPWM
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-tiehrpwm.
> >  
> > +config PWM_VISCONTI
> > +	tristate "Toshiba Visconti PWM support"
> > +	depends on ARCH_VISCONTI || COMPILE_TEST
> > +	help
> > +	  PWM Subsystem driver support for Toshiba Visconti SoCs.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-visconti.
> > +
> 
> The entries in the file seem to be alphabetically sorted. Can you please
> move this to the appropriate location.
> 

OK, I will this.

> >  config PWM_TWL
> >  	tristate "TWL4030/6030 PWM support"
> >  	depends on TWL4030_CORE
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index a59c710e98c7..ef6dc1af7c17 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
> >  obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
> >  obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
> >  obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
> > +obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
> 
> Same comment as above.
> 
> >  obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
> >  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
> >  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> > diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> > new file mode 100644
> > index 000000000000..601450111166
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-visconti.c
> > @@ -0,0 +1,141 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Toshiba Visconti pulse-width-modulation controller driver
> > + *
> > + * Copyright (c) 2020 TOSHIBA CORPORATION
> > + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
> > + * Copyright (c) 2020 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > + *
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define PWMC0_PWMACT BIT(5)
> > +
> > +#define REG_PCSR(ch) (0x400 + 4 * (ch))
> > +#define REG_PDUT(ch) (0x420 + 4 * (ch))
> > +#define REG_PWM0(ch) (0x440 + 4 * (ch))
> > +
> > +struct visconti_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct device *dev;
> 
> "dev" can be dropped from the structure if ..
> 

Indeed. I will drop this.

> > +	void __iomem *base;
> > +};
> > +
> > +#define to_visconti_chip(chip) \
> > +	container_of(chip, struct visconti_pwm_chip, chip)
> > +
> > +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			  const struct pwm_state *state)
> > +{
> > +	struct visconti_pwm_chip *priv = to_visconti_chip(chip);
> > +	u32 period, duty, pwmc0;
> > +
> > +	dev_dbg(priv->dev, "%s: ch = %d en = %d p = 0x%llx d = 0x%llx\n", __func__,
> > +		pwm->hwpwm, state->enabled, state->period, state->duty_cycle);
> 
> ... the usage here is replaced by "chip->dev" instead of "priv->dev".
> 

I will fix this line.

> > +	if (state->enabled) {
> > +		period = state->period / 1000;
> > +		duty = state->duty_cycle / 1000;
> 
> Does it make sense to replace the constant 1000 here with the macro -
> NSEC_PER_USEC?


I see. I will change NSEC_PER_USEC instead of 1000.

> 
> Also, period and duty_cycle are defined as u64 in the pwm_state
> structure. Is there any chance for the values to be truncated due to
> them being u32 in the driver?

As you pointed out, the registers of this IP are 32bit.
Therefore, the value may be truncated. I will fix it.


> 
> > +		if (period < 0x10000)
> > +			pwmc0 = 0;
> > +		else if (period < 0x20000)
> > +			pwmc0 = 1;
> > +		else if (period < 0x40000)
> > +			pwmc0 = 2;
> > +		else if (period < 0x80000)
> > +			pwmc0 = 3;
> > +		else
> > +			return -EINVAL;
> > +
> > +		if (pwmc0) {
> > +			period /= BIT(pwmc0);
> > +			duty /= BIT(pwmc0);
> 
> It would be better to replace division with right-shift operator.
> 
> period >>= pwmc0;
> duty >>= pwmc0;

I will change to use shift.

> 
> > +		}
> > +
> > +		if (state->polarity == PWM_POLARITY_INVERSED)
> > +			pwmc0 |= PWMC0_PWMACT;
> > +
> > +		writel(pwmc0, priv->base + REG_PWM0(pwm->hwpwm));
> > +		writel(duty, priv->base + REG_PDUT(pwm->hwpwm));
> > +		writel(period, priv->base + REG_PCSR(pwm->hwpwm));
> > +	} else {
> > +		writel(0, priv->base + REG_PCSR(pwm->hwpwm));
> > +	}
> 
> One suggestion - the else condition can be handled first to reduce
> indentation for the state->enabled condition,
> 
> 
>         if (!state->enabled) {
>            ...
>            return 0;
>         }
> 
> 
>         <handle state enabled case>
> 
> But so far the driver is simple enough so I'll leave it upto you which
> way you prefer.


I see. 
I will change to your suggestion. 

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops visconti_pwm_ops = {
> > +	.apply = visconti_pwm_apply,
> > +	.owner = THIS_MODULE,
> > +};
> > +
> > +static int visconti_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct visconti_pwm_chip *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->dev = &pdev->dev;
> > +
> > +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base)) {
> > +		dev_err(dev, "unable to map I/O space\n");
> > +		return PTR_ERR(priv->base);
> > +	}
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	priv->chip.dev = dev;
> > +	priv->chip.ops = &visconti_pwm_ops;
> > +	priv->chip.base = -1;
> > +	priv->chip.npwm = 4;
> > +
> > +	ret = pwmchip_add(&priv->chip);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Cannot register visconti PWM: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	dev_info(&pdev->dev, "visconti PWM registered\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int visconti_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct visconti_pwm_chip *priv = platform_get_drvdata(pdev);
> > +
> > +	return pwmchip_remove(&priv->chip);
> > +}
> > +
> > +static const struct of_device_id visconti_pwm_of_match[] = {
> > +	{ .compatible = "toshiba,pwm-visconti", },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, visconti_pwm_of_match);
> > +
> > +static struct platform_driver visconti_pwm_driver = {
> > +	.driver = {
> > +		.name = "pwm-visconti",
> > +		.of_match_table = visconti_pwm_of_match,
> > +	},
> > +	.probe = visconti_pwm_probe,
> > +	.remove = visconti_pwm_remove,
> > +};
> > +
> > +module_platform_driver(visconti_pwm_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Toshiba");
> 
> Please use the author name / email here.
> 

I see. I will change MODULE_AUTHOR to my name and email.

> > +MODULE_ALIAS("platform:visconti-pwm");
> 
> Thanks,
> Punit
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
