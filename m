Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0092335786A
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Apr 2021 01:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhDGXWM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 19:22:12 -0400
Received: from mo-csw-fb1114.securemx.jp ([210.130.202.173]:46702 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhDGXWK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 19:22:10 -0400
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Apr 2021 19:22:10 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1114) id 137NGNUU008961; Thu, 8 Apr 2021 08:16:23 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 137NFq65028418; Thu, 8 Apr 2021 08:15:52 +0900
X-Iguazu-Qid: 2wHHUTCVsWIJiMGjLN
X-Iguazu-QSIG: v=2; s=0; t=1617837351; q=2wHHUTCVsWIJiMGjLN; m=D9V+guOt1uSRuU/40jPy0IESJDfn9L8tjjPEvjy8Z0s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1112) id 137NFokH021342
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 8 Apr 2021 08:15:50 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1F8911000CC;
        Thu,  8 Apr 2021 08:15:50 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 137NFnbw021286;
        Thu, 8 Apr 2021 08:15:49 +0900
Date:   Thu, 8 Apr 2021 08:15:48 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
X-TSB-HOP: ON
Message-ID: <20210407231548.4paov2fb33cpxxui@toshiba.co.jp>
References: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210212131910.557581-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210212164144.wcvy7jkxmrysqxux@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210212164144.wcvy7jkxmrysqxux@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Thanks for your review.

On Fri, Feb 12, 2021 at 05:41:44PM +0100, Uwe Kleine-König wrote:
> Hello Nobuhiro,
> 
> On Fri, Feb 12, 2021 at 10:19:10PM +0900, Nobuhiro Iwamatsu wrote:
> > Add driver for the PWM controller on Toshiba Visconti ARM SoC.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  drivers/pwm/Kconfig        |   9 ++
> >  drivers/pwm/Makefile       |   1 +
> >  drivers/pwm/pwm-visconti.c | 173 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 183 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-visconti.c
> > 

<snip>

> > diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> > new file mode 100644
> > index 000000000000..2aa140f1ec04
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-visconti.c
> > @@ -0,0 +1,173 @@
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
> > +
> > +
> > +#define PIPGM_PCSR(ch) (0x400 + 4 * (ch))
> > +#define PIPGM_PDUT(ch) (0x420 + 4 * (ch))
> > +#define PIPGM_PWMC(ch) (0x440 + 4 * (ch))
> > +
> > +#define PIPGM_PWMC_PWMACT		BIT(5)
> > +#define PIPGM_PWMC_CLK_MASK		GENMASK(1, 0)
> > +#define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
> > +#define PIPGM_PDUT_MAX			0xFFFF
> > +
> > +struct visconti_pwm_chip {
> > +	struct pwm_chip chip;
> > +	void __iomem *base;
> > +};
> > +
> > +#define to_visconti_chip(chip) \
> > +	container_of(chip, struct visconti_pwm_chip, chip)
> > +
> > +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			  const struct pwm_state *state)
> 
> Please align the continuation line to the opening parenthesis.
> 

I will fix this. 

> > +{
> > +	struct visconti_pwm_chip *priv = to_visconti_chip(chip);
> > +	u32 period, duty, pwmc0;
> > +
> > +	dev_dbg(chip->dev, "%s: ch = %d en = %d p = 0x%llx d = 0x%llx\n", __func__,
> > +		pwm->hwpwm, state->enabled, state->period, state->duty_cycle);
> > +
> > +	/*
> > +	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
> > +	 * When the settings of the PWM are modified, the new values are shadowed in hardware until
> > +	 * the period register (PCSR) is written and the currently running period is completed. This
> > +	 * way the hardware switches atomically from the old setting to the new.
> > +	 * Also, disabling the hardware completes the currently running period and keeps the output
> > +	 * at low level at all times.
> 
> Did you just copy my optimal description or is your hardware really that
> nice?

Yes, this hardware works as you wrote.
And I added about the state if the sinnal when this hardware disabled.

> 
> Do you know scripts/checkpatch.pl? I bet it will tell you to limit your
> lines to approx. 80 chars where sensible.

Yes, I know. I ran scripts/checkpatch.pl before send patch.
I understand that the number of characters per line has been changed to
100 characters. Does the pwm driver recommend 80 characters?

> 
> > +	 */
> > +	if (!state->enabled) {
> > +		writel(0, priv->base + PIPGM_PCSR(pwm->hwpwm));
> > +		return 0;
> > +	}
> > +
> > +	period = state->period / NSEC_PER_USEC;
> 
> This becomes wrong if state->period > 1000 * 0xffffffff because you
> discard non-zero bits when reducing the size to u32.

Your point is correct. I will fix this.

> 
> > +	duty = state->duty_cycle / NSEC_PER_USEC;
> > +	if (period < 0x10000)
> > +		pwmc0 = 0;
> > +	else if (period < 0x20000)
> > +		pwmc0 = 1;
> > +	else if (period < 0x40000)
> > +		pwmc0 = 2;
> > +	else if (period < 0x80000)
> > +		pwmc0 = 3;
> > +	else
> > +		return -EINVAL;
> 
> This is equivalent to:
> 
> 	pwmc0 = ilog2(period >> 16);
> 	if (pwmc0 > 3)
> 		return -EINVAL;
> 

I see. And I noticed that there was a problem with the above code.
I will use ilog2.

> > +	if (duty > PIPGM_PDUT_MAX)
> > +		return -EINVAL;
> 
> I would expect that this check should only happen after duty is shifted
> below?! I think this cannot happen if you rely on the core to only give
> you states with duty_cycle <= period.

I see. I will fix this.

> 
> > +	period >>= pwmc0;
> > +	duty >>= pwmc0;
> > +
> > +	if (state->polarity == PWM_POLARITY_INVERSED)
> > +		pwmc0 |= PIPGM_PWMC_PWMACT;
> > +
> > +	writel(pwmc0, priv->base + PIPGM_PWMC(pwm->hwpwm));
> > +	writel(duty, priv->base + PIPGM_PDUT(pwm->hwpwm));
> > +	writel(period, priv->base + PIPGM_PCSR(pwm->hwpwm));
> 
> Please implement the following policy:
> 
> Pick the biggest possible period not bigger than the requested period.
> With that pick the biggest possible duty cycle not bigger than the
> requested duty cycle. That means (assuming I understood your hardware
> correctly):
> 
> 	u32 period, duty_cycle;
> 
> 	/*
> 	 * The biggest period the hardware can provide is
> 	 * 	(0xffff << 3) * 1000 ns
> 	 * This value fits easily in an u32, so simplify the maths by
> 	 * capping the values to 32 bit integers.
> 	 */
> 	if (state->period > (0xffff << 3) * 1000)
> 		period = (0xffff << 3) * 1000;
> 	else
> 		period = state->period;
> 
> 	if (state->duty_cycle > period)
> 		duty_cycle = period;
> 	else
> 		duty_cycle = state->duty_cycle;
> 
> 	/*
> 	 * The input clock runs fixed at 1 MHz, so we have only
> 	 * microsecond resolution and so can divide by
> 	 * NSEC_PER_SEC / CLKFREQ = 1000 without loosing precision.
> 	 */
> 	period /= 1000;
> 	duty_cycle /= 1000;
> 
> 	if (!period)
> 		/* period too small */
> 		return -ERANGE;
> 
> 	/*
> 	 * PWMC controls a divider that divides the input clk by a
> 	 * power of two between 1 and 8. As a smaller divider yields
> 	 * higher precision, pick the smallest possible one.
> 	 */
> 	pwmc0 = ilog2(period >> 16);
> 	BUG_ON(pwmc0 > 3);
> 
> 	period >>= pwmc0;
> 	duty_cycle >>= pwmc0;
> 	
> 	if (state->polarity == PWM_POLARITY_INVERSED)
> 		pwmc0 |= PIPGM_PWMC_PWMACT;
> 			
> 	writel(pwmc0, priv->base + PIPGM_PWMC(pwm->hwpwm));
> 	writel(duty, priv->base + PIPGM_PDUT(pwm->hwpwm));
> 	writel(period, priv->base + PIPGM_PCSR(pwm->hwpwm));
> 

Thank you for your suggestion. I will reconsider based on this code.

> > +	return 0;
> > +}
> > +
> > +static void visconti_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				   struct pwm_state *state)
> > +{
> > +[...]
> > +}
> 
> Looks good.
> 
> > [...]
> > 
> > +static struct platform_driver visconti_pwm_driver = {
> > +	.driver = {
> > +		.name = "pwm-visconti",
> > +		.of_match_table = visconti_pwm_of_match,
> > +	},
> > +	.probe = visconti_pwm_probe,
> > +	.remove = visconti_pwm_remove,
> > +};
> > +module_platform_driver(visconti_pwm_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>");
> > +MODULE_ALIAS("platform:visconti-pwm");
> 
> This must match the .name field of the platform driver, so it must be
> 
> MODULE_ALIAS("platform:pwm-visconti");

I forgot this mistake. I will fix.

> 
> Best regards
> Uwe

Best regards,
  Nobuhiro
