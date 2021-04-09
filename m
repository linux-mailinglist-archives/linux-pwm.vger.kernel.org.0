Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3362435A861
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 23:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhDIVfj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 17:35:39 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:47788 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDIVfj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 17:35:39 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 139LYwRH008798; Sat, 10 Apr 2021 06:34:58 +0900
X-Iguazu-Qid: 2wHHssSnbYbFdnoxPc
X-Iguazu-QSIG: v=2; s=0; t=1618004098; q=2wHHssSnbYbFdnoxPc; m=D1xW780p6Id16TNwDIvBcVhNiqlRO90vFrM0M43hh+g=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1112) id 139LYv3Z027218
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 10 Apr 2021 06:34:57 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 2DC7E1000E5;
        Sat, 10 Apr 2021 06:34:57 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 139LYuoA006484;
        Sat, 10 Apr 2021 06:34:56 +0900
Date:   Sat, 10 Apr 2021 06:34:55 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
X-TSB-HOP: ON
Message-ID: <20210409213455.6f25m4jyttqn75hf@toshiba.co.jp>
References: <20210409090709.1918021-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409090709.1918021-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <YHBUjPjEpLYF/915@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHBUjPjEpLYF/915@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

Thanks for your review.

On Fri, Apr 09, 2021 at 03:20:12PM +0200, Thierry Reding wrote:
> On Fri, Apr 09, 2021 at 06:07:09PM +0900, Nobuhiro Iwamatsu wrote:
> > Add driver for the PWM controller on Toshiba Visconti ARM SoC.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  drivers/pwm/Kconfig        |   9 ++
> >  drivers/pwm/Makefile       |   1 +
> >  drivers/pwm/pwm-visconti.c | 193 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 203 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-visconti.c
> 
> Looks good, but I have a few minor comments, see below.
> 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 9a4f66ae8070..8ae68d6203fb 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -601,6 +601,15 @@ config PWM_TWL_LED
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called pwm-twl-led.
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
> >  config PWM_VT8500
> >  	tristate "vt8500 PWM support"
> >  	depends on ARCH_VT8500 || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 6374d3b1d6f3..d43b1e17e8e1 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -56,4 +56,5 @@ obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
> >  obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
> >  obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
> >  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
> > +obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
> >  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
> > diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> > new file mode 100644
> > index 000000000000..ff4a5f5b0009
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-visconti.c
> > @@ -0,0 +1,193 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Toshiba Visconti pulse-width-modulation controller driver
> > + *
> > + * Copyright (c) 2020 TOSHIBA CORPORATION
> > + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
> > + *
> > + * Authors: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > + *
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/platform_device.h>
> 
> Should be sorted alphabetically.
> 

I forgot it, I will fix.

> > +
> > +#define PIPGM_PCSR(ch) (0x400 + 4 * (ch))
> > +#define PIPGM_PDUT(ch) (0x420 + 4 * (ch))
> > +#define PIPGM_PWMC(ch) (0x440 + 4 * (ch))
> > +
> > +#define PIPGM_PWMC_PWMACT		BIT(5)
> > +#define PIPGM_PWMC_CLK_MASK		GENMASK(1, 0)
> > +#define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
> > +
> > +struct visconti_pwm_chip {
> > +	struct pwm_chip chip;
> > +	void __iomem *base;
> > +};
> > +
> > +#define to_visconti_chip(chip) \
> > +	container_of(chip, struct visconti_pwm_chip, chip)
> 
> I prefer these to be static inline functions because that tends to give
> better error messages than macros. Also, that's what's primarily used in
> the PWM drivers, even if there are a couple of outliers.
> 
> I'll go fix those up.

I see. I will change to use static inline functions..

> 
> > +
> > +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			      const struct pwm_state *state)
> > +{
> > +	struct visconti_pwm_chip *priv = to_visconti_chip(chip);
> > +	u32 period, duty_cycle, pwmc0;
> > +
> > +	dev_dbg(chip->dev, "%s: ch = %d en = %d p = 0x%llx d = 0x%llx\n", __func__,
> > +		pwm->hwpwm, state->enabled, state->period, state->duty_cycle);
> 
> Don't the trace points work for you?

Yes, we can get this information by using the trace function. I will
drop this.

> 
> > +
> > +	/*
> > +	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
> > +	 * When the settings of the PWM are modified, the new values are shadowed in hardware until
> > +	 * the period register (PCSR) is written and the currently running period is completed. This
> > +	 * way the hardware switches atomically from the old setting to the new.
> > +	 * Also, disabling the hardware completes the currently running period and keeps the output
> > +	 * at low level at all times.
> > +	 */
> > +	if (!state->enabled) {
> > +		writel(0, priv->base + PIPGM_PCSR(pwm->hwpwm));
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * The biggest period the hardware can provide is
> > +	 *	(0xffff << 3) * 1000 ns
> > +	 * This value fits easily in an u32, so simplify the maths by
> > +	 * capping the values to 32 bit integers.
> > +	 */
> > +	if (state->period > (0xffff << 3) * 1000)
> > +		period = (0xffff << 3) * 1000;
> > +	else
> > +		period = state->period;
> > +
> > +	if (state->duty_cycle > period)
> > +		duty_cycle = period;
> > +	else
> > +		duty_cycle = state->duty_cycle;
> > +
> > +	/*
> > +	 * The input clock runs fixed at 1 MHz, so we have only
> > +	 * microsecond resolution and so can divide by
> > +	 * NSEC_PER_SEC / CLKFREQ = 1000 without loosing precision.
> > +	 */
> > +	period /= 1000;
> > +	duty_cycle /= 1000;
> > +
> > +	if (!period)
> > +		/* period too small */
> > +		return -ERANGE;
> 
> Maybe braces around this so the two-line "block" doesn't look wrong,
> even if it actually isn't. Or perhaps put the comment above the check
> for the same effect.

I see, it's readability.

> 
> Quite frankly, I'd just drop the comment because the code itself is
> clear and the comment doesn't add anything.

OK, I will drop this comment.

> 
> > +
> > +	/*
> > +	 * PWMC controls a divider that divides the input clk by a
> > +	 * power of two between 1 and 8. As a smaller divider yields
> > +	 * higher precision, pick the smallest possible one.
> > +	 */
> > +	if (period > 0xffff) {
> > +		pwmc0 = ilog2(period >> 16);
> > +		BUG_ON(pwmc0 > 3);
> > +	} else
> > +		pwmc0 = 0;
> > +
> > +	period >>= pwmc0;
> > +	duty_cycle >>= pwmc0;
> > +
> > +	if (state->polarity == PWM_POLARITY_INVERSED)
> > +		pwmc0 |= PIPGM_PWMC_PWMACT;
> > +	writel(pwmc0, priv->base + PIPGM_PWMC(pwm->hwpwm));
> > +	writel(duty_cycle, priv->base + PIPGM_PDUT(pwm->hwpwm));
> > +	writel(period, priv->base + PIPGM_PCSR(pwm->hwpwm));
> > +
> > +	return 0;
> > +}
> > +
> > +static void visconti_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				   struct pwm_state *state)
> > +{
> > +	struct visconti_pwm_chip *priv = to_visconti_chip(chip);
> > +	u32 period, duty, pwmc0, pwmc0_clk;
> > +
> > +	period = readl(priv->base + PIPGM_PCSR(pwm->hwpwm));
> > +	if (period)
> > +		state->enabled = true;
> > +	else
> > +		state->enabled = false;
> > +
> > +	duty = readl(priv->base + PIPGM_PDUT(pwm->hwpwm));
> > +	pwmc0 = readl(priv->base + PIPGM_PWMC(pwm->hwpwm));
> > +	pwmc0_clk = pwmc0 & PIPGM_PWMC_CLK_MASK;
> > +
> > +	state->period = (period << pwmc0_clk) * NSEC_PER_USEC;
> > +	state->duty_cycle = (duty << pwmc0_clk) * NSEC_PER_USEC;
> > +	if (pwmc0 & PIPGM_PWMC_POLARITY_MASK)
> > +		state->polarity = PWM_POLARITY_INVERSED;
> > +	else
> > +		state->polarity = PWM_POLARITY_NORMAL;
> > +}
> > +
> > +static const struct pwm_ops visconti_pwm_ops = {
> > +	.apply = visconti_pwm_apply,
> > +	.get_state = visconti_pwm_get_state,
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
> > +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	priv->chip.dev = dev;
> > +	priv->chip.ops = &visconti_pwm_ops;
> > +	priv->chip.base = -1;
> 
> There's no need for this anymore. The current PWM tree will always
> assume base = -1.

I see. I will drop this.

> 
> > +	priv->chip.npwm = 4;
> > +
> > +	ret = pwmchip_add(&priv->chip);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n");
> > +
> > +	dev_dbg(&pdev->dev, "visconti PWM registered\n");
> 
> Maybe not the best use of a debug message. There are better ways to
> check if a device has successfully bound to a driver than relying on
> debug messages.

I will drop this line. it says there are better way to check, but what is it?

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int visconti_pwm_remove(struct platform_device *pdev)
> > +{
> > +	struct visconti_pwm_chip *priv = platform_get_drvdata(pdev);
> > +
> > +	return pwmchip_remove(&priv->chip);
> 
> I think Uwe would prefer this to be done separately because he's working
> towards removing the return value from pwmchip_remove() and if we start
> ignoring it in new drivers that will make life easier going forward.
> 
> So this should just be:
> 
> 	pwmchip_remove(&priv->chip);
> 
> 	return 0;

I understand your suggestion.
However, it looks like the pwmchip_remove() hasn't been updated yet.
I will wait for the update of pwmchip_remove.

> 
> Thierry

Best regards,
  Nobuhiro
