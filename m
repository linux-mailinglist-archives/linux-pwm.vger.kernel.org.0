Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E7319B68
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Feb 2021 09:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhBLInj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Feb 2021 03:43:39 -0500
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:51438 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBLInh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Feb 2021 03:43:37 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 11C8f5UC008286; Fri, 12 Feb 2021 17:41:05 +0900
X-Iguazu-Qid: 34tMYNXf5Z1bu3U7ze
X-Iguazu-QSIG: v=2; s=0; t=1613119264; q=34tMYNXf5Z1bu3U7ze; m=8BaUyYyvKED2mAc4XY3oZMbnl8h2XtUI4pdMIUeCCLo=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1511) id 11C8f3T5038654;
        Fri, 12 Feb 2021 17:41:04 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 11C8f3PF020430;
        Fri, 12 Feb 2021 17:41:03 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11C8f3F5032333;
        Fri, 12 Feb 2021 17:41:03 +0900
Date:   Fri, 12 Feb 2021 17:40:56 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM support
X-TSB-HOP: ON
Message-ID: <20210212084056.atz2jzlbn66prrwx@toshiba.co.jp>
References: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200917223140.227542-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20200922071409.lkmnhs73fu472va6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922071409.lkmnhs73fu472va6@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Thanks for your review.

On Tue, Sep 22, 2020 at 09:14:09AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Sep 18, 2020 at 07:31:40AM +0900, Nobuhiro Iwamatsu wrote:
> > diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> > new file mode 100644
> > index 000000000000..601450111166
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-visconti.c
> > @@ -0,0 +1,141 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> The SPDX guys deprecated "GPL-2.0" as identifier and recommend
> "GPL-2.0-only" instead. As in the kernel both are allowed I prefer the
> latter.
> 
I see. I will change to GPL-2.0-only.


> > +/*
> > + * Toshiba Visconti pulse-width-modulation controller driver
> > + *
> > + * Copyright (c) 2020 TOSHIBA CORPORATION
> > + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
> > + * Copyright (c) 2020 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > + *
> > + */
> 
> If there is a publically available manual, please add a link here.
> 

This device's manual is not open yet. If it is opened, I will add.


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
> 
> Please us a prefix for the register defines. Also it would be great if
> it would be obvious from the naming to which register the PWMACT bit
> belongs.
> 

I will change this.

> > +struct visconti_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct device *dev;
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
> > +	if (state->enabled) {
> > +		period = state->period / 1000;
> > +		duty = state->duty_cycle / 1000;
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
> > +		}
> 
> You can drop the if and just make this:
> 
> 	period <<= pwmc0;
> 	duty <<= pwmc0;
> 
> as this is a noop if pwmc0 is zero.
> 

I will fix this.


> > +		if (state->polarity == PWM_POLARITY_INVERSED)
> > +			pwmc0 |= PWMC0_PWMACT;
> > +
> > +		writel(pwmc0, priv->base + REG_PWM0(pwm->hwpwm));
> > +		writel(duty, priv->base + REG_PDUT(pwm->hwpwm));
> > +		writel(period, priv->base + REG_PCSR(pwm->hwpwm));
> 
> Some comments about the function of the hardware would be good.
> Something like (I assume the optimal hardware here, please adapt to
> reality):
> 
> 	pwmc is a 2-bit divider for the input clock running at 1 MHz.
> 	When the settings of the PWM are modified, the new values are
> 	shadowed in hardware until the period register (PCSR) is written
> 	and the currently running period is completed. This way the
> 	hardware switches atomically from the old setting to the new.
> 	Also disabling the hardware completes the currently running
> 	period and then the output drives the inactive state.
> 
> (I'm sure however this is wrong because you don't consider
> state->polarity in the !state-enabled case.)
> 
> If your hardware doesn't behave as indicated please add a Limitations
> paragraph at the beginning of the driver as is done for several other
> drivers already describing the shortcomings.
> 

OK, I will add a comment about IP restrictions as you pointed out.


> > +	} else {
> > +		writel(0, priv->base + REG_PCSR(pwm->hwpwm));
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops visconti_pwm_ops = {
> > +	.apply = visconti_pwm_apply,
> 
> Please implement .get_state(). (And test it using PWM_DEBUG.)
> 

OK, I will add get_state() function.

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
> 
> You can better use
> 
> 	priv->dev = dev;
> 
> here. (But I agree to the previous review that it makes little sense to
> keep this member in struct visconti_pwm_chip.)
> 

OK, I will remove dev from visconti_pwm_chip.

> > +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base)) {
> > +		dev_err(dev, "unable to map I/O space\n");
> 
> devm_platform_ioremap_resource already emits an error message on failure,
> so no need to add another.

OK, I will drop error message.

> 
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
> 
> Please use dev_err_probe here or %pe for the error code.
> 


I will chakge to using  dev_err_probe.

> > +		return ret;
> > +	}
> > +
> > +	dev_info(&pdev->dev, "visconti PWM registered\n");
> 
> Please degrade this to dev_dbg.

I will change to dev_dbg.

> 
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
> 
> Please drop the empty line before MODULE_DEVICE_TABLE.
> 

OK, I will drop this.

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
> 
> The empty line before module_platform_driver is also unusual.
> 
OK, I will drop this.

> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Toshiba");
> > +MODULE_ALIAS("platform:visconti-pwm");
> 
> This is wrong; as the driver name is pwm-visconti this should be
> MODULE_ALIAS("platform:pwm-visconti");

OK, I will change to "platform:pwm-visconti".

> 
> Best regards
> Uwe
> 

Thanks!

Best regards,
  Nobuhiro

> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

