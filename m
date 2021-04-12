Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF635B8C1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 04:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhDLC42 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 22:56:28 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:48866 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbhDLC40 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 22:56:26 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 13C2tjog004380; Mon, 12 Apr 2021 11:55:45 +0900
X-Iguazu-Qid: 2wHHbBTw9oTB1wCMQ2
X-Iguazu-QSIG: v=2; s=0; t=1618196144; q=2wHHbBTw9oTB1wCMQ2; m=9uJ55xIbdsLQncU0AQqqoL2GwZXsyD3WLl9bqMvC8I0=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1113) id 13C2tidL026921
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 11:55:44 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id D3E101000B5;
        Mon, 12 Apr 2021 11:55:43 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13C2thUK003848;
        Mon, 12 Apr 2021 11:55:43 +0900
Date:   Mon, 12 Apr 2021 11:55:36 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
X-TSB-HOP: ON
Message-ID: <20210412025536.i5chpp6sighunvfx@toshiba.co.jp>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210410135321.oissremqropvrpd3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210410135321.oissremqropvrpd3@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for your review.

On Sat, Apr 10, 2021 at 03:53:21PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> just a few small details left to criticize ...
> 
> On Sat, Apr 10, 2021 at 08:08:37AM +0900, Nobuhiro Iwamatsu wrote:
> > diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> > new file mode 100644
> > index 000000000000..99d83f94ed86
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-visconti.c
> > @@ -0,0 +1,188 @@
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
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
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
> > +static inline struct visconti_pwm_chip *to_visconti_chip(struct pwm_chip *chip)
> > +{
> > +	return container_of(chip, struct visconti_pwm_chip, chip);
> > +}
> > +
> > +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			      const struct pwm_state *state)
> > +{
> > +	struct visconti_pwm_chip *priv = to_visconti_chip(chip);
> > +	u32 period, duty_cycle, pwmc0;
> > +
> > +	/*
> > +	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
> > +	 * When the settings of the PWM are modified, the new values are shadowed in hardware until
> > +	 * the period register (PCSR) is written and the currently running period is completed. This
> > +	 * way the hardware switches atomically from the old setting to the new.
> > +	 * Also, disabling the hardware completes the currently running period and keeps the output
> > +	 * at low level at all times.
> 
> Can you please put a paragraph analogous to the one in pwm-sifive in the
> same format. This simplified keeping an overview about the oddities of
> the various supported chips.

OK, I will check pwm-sifive's, and add.

> 
> > +	 */
> > +	if (!state->enabled) {
> > +		writel(0, priv->base + PIPGM_PCSR(pwm->hwpwm));
> > +		return 0;
> > +	}
> > +
> > [...]
> > +
> > +static void visconti_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				   struct pwm_state *state)
> > +{
> > +	struct visconti_pwm_chip *priv = chip_to_priv(chip);
> > +	u32 period, duty, pwmc0, pwmc0_clk;
> > +
> > +	period = readl(priv->base + PIPGM_PCSR(pwm->hwpwm));
> > +	if (period)
> > +		state->enabled = true;
> > +	else
> > +		state->enabled = false;
> 
> If PIPGM_PCSR is 0 the hardware is still active and setting a new
> configuration completes the currently running period, right? Then I
> think having always state->enabled = true is a better match.
>
If PIPGM_PCSR is 0, the hardware is stopped. Even if the settings of
other registers are written, the values of other registers will not work
unless PIPGM_PCSR is written.

However, as a logic, if PIPGM_PCSR becomes 0, it is only
visconti_pwm_apply () in this driver,
so I think that this process should always be state-> enabled = true
as you pointed out.
I wil drop this, thanks.


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
> > [...]
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
> > +	priv->chip.npwm = 4;
> > +
> > +	ret = pwmchip_add(&priv->chip);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n");
> 
> Thierry told to have picked up my patch to add the function
> devm_pwmchip_add. I just double checked and it didn't made it into his
> for-next branch yet. When you respin this series please check if the
> patch landed in the mean time and then make use of it.
> 

OKay.

> > +	return 0;
> > +}
> 
> Best regards
> Uwe

Best regards,
  Nobuhiro

