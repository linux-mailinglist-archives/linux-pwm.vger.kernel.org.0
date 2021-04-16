Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A96361B61
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Apr 2021 10:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbhDPIIX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Apr 2021 04:08:23 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:51128 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhDPIIW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Apr 2021 04:08:22 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 13G87UGW003391; Fri, 16 Apr 2021 17:07:30 +0900
X-Iguazu-Qid: 34tr9jB2dbDVDmZAI3
X-Iguazu-QSIG: v=2; s=0; t=1618560450; q=34tr9jB2dbDVDmZAI3; m=yhkDNzpcSRv3VLZjqeMnV3i50xF81NUOuQ8lkDquMT8=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1511) id 13G87Sx8021320
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 17:07:28 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id BE3501000AA;
        Fri, 16 Apr 2021 17:07:28 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13G87Sho013100;
        Fri, 16 Apr 2021 17:07:28 +0900
Date:   Fri, 16 Apr 2021 17:07:21 +0900
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
Message-ID: <20210416080721.oa7xdvu22w2b2rkf@toshiba.co.jp>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210410135321.oissremqropvrpd3@pengutronix.de>
 <20210412025536.i5chpp6sighunvfx@toshiba.co.jp>
 <20210412070232.6q3cgqvuj53p4cmi@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412070232.6q3cgqvuj53p4cmi@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

Thanks for your review.

On Mon, Apr 12, 2021 at 09:02:32AM +0200, Uwe Kleine-König wrote:
> On Mon, Apr 12, 2021 at 11:55:36AM +0900, Nobuhiro Iwamatsu wrote:
> > Hi Uwe,
> > 
> > Thanks for your review.
> > 
> > On Sat, Apr 10, 2021 at 03:53:21PM +0200, Uwe Kleine-König wrote:
> > > Hello,
> > > 
> > > just a few small details left to criticize ...
> > > 
> > > On Sat, Apr 10, 2021 at 08:08:37AM +0900, Nobuhiro Iwamatsu wrote:
> > > > diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> > > > new file mode 100644
> > > > index 000000000000..99d83f94ed86
> > > > --- /dev/null
> > > > +++ b/drivers/pwm/pwm-visconti.c
> > > > @@ -0,0 +1,188 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Toshiba Visconti pulse-width-modulation controller driver
> > > > + *
> > > > + * Copyright (c) 2020 TOSHIBA CORPORATION
> > > > + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
> > > > + *
> > > > + * Authors: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > > > + *
> > > > + */
> > > > +
> > > > +#include <linux/err.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/pwm.h>
> > > > +
> > > > +#define PIPGM_PCSR(ch) (0x400 + 4 * (ch))
> > > > +#define PIPGM_PDUT(ch) (0x420 + 4 * (ch))
> > > > +#define PIPGM_PWMC(ch) (0x440 + 4 * (ch))
> > > > +
> > > > +#define PIPGM_PWMC_PWMACT		BIT(5)
> > > > +#define PIPGM_PWMC_CLK_MASK		GENMASK(1, 0)
> > > > +#define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
> > > > +
> > > > +struct visconti_pwm_chip {
> > > > +	struct pwm_chip chip;
> > > > +	void __iomem *base;
> > > > +};
> > > > +
> > > > +static inline struct visconti_pwm_chip *to_visconti_chip(struct pwm_chip *chip)
> > > > +{
> > > > +	return container_of(chip, struct visconti_pwm_chip, chip);
> > > > +}
> > > > +
> > > > +static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +			      const struct pwm_state *state)
> > > > +{
> > > > +	struct visconti_pwm_chip *priv = to_visconti_chip(chip);
> > > > +	u32 period, duty_cycle, pwmc0;
> > > > +
> > > > +	/*
> > > > +	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
> > > > +	 * When the settings of the PWM are modified, the new values are shadowed in hardware until
> > > > +	 * the period register (PCSR) is written and the currently running period is completed. This
> > > > +	 * way the hardware switches atomically from the old setting to the new.
> > > > +	 * Also, disabling the hardware completes the currently running period and keeps the output
> > > > +	 * at low level at all times.
> > > 
> > > Can you please put a paragraph analogous to the one in pwm-sifive in the
> > > same format. This simplified keeping an overview about the oddities of
> > > the various supported chips.
> > 
> > OK, I will check pwm-sifive's, and add.

I will add the following :

 * Limitations:
 * - PIPGM_PWMC is a 2-bit divider (00: 1, 01: 2, 10: 4, 11: 8) for the input
 *   clock running at 1 MHz.
 * - When the settings of the PWM are modified, the new values are shadowed
 *   in hardware until the PIPGM_PCSR register is written and the currently
 *   running period is completed. This way the hardware switches atomically
 *   from the old setting to the new.
 * - Disabling the hardware completes the currently running period and keeps
 *   the output at low level at all times.


> > 
> > > 
> > > > +	 */
> > > > +	if (!state->enabled) {
> > > > +		writel(0, priv->base + PIPGM_PCSR(pwm->hwpwm));
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > [...]
> > > > +
> > > > +static void visconti_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +				   struct pwm_state *state)
> > > > +{
> > > > +	struct visconti_pwm_chip *priv = chip_to_priv(chip);
> > > > +	u32 period, duty, pwmc0, pwmc0_clk;
> > > > +
> > > > +	period = readl(priv->base + PIPGM_PCSR(pwm->hwpwm));
> > > > +	if (period)
> > > > +		state->enabled = true;
> > > > +	else
> > > > +		state->enabled = false;
> > > 
> > > If PIPGM_PCSR is 0 the hardware is still active and setting a new
> > > configuration completes the currently running period, right? Then I
> > > think having always state->enabled = true is a better match.
> >
> > If PIPGM_PCSR is 0, the hardware is stopped. Even if the settings of
> > other registers are written, the values of other registers will not work
> > unless PIPGM_PCSR is written.
> 
> Correct me if I'm wrong, but how I understand it, PCSR is special as the
> other registers are shadow until PCSR is written. (And that is
> irrespective of which value is active in PCSR or what is written to
> PCSR.)

This is correct.

>  
> > However, as a logic, if PIPGM_PCSR becomes 0, it is only
> > visconti_pwm_apply () in this driver,
> > so I think that this process should always be state-> enabled = true
> > as you pointed out.
> > I wil drop this, thanks.
> 
> For me the critical (and only) difference between "off" and
> "duty cycle = 0" is that when a new configuration is to be applied. In
> the "off" state a new period can (and should) start immediately, while
> with "duty_cycle = 0" the rising edge should be delayed until the
> currently running period is over.[1]
> 
> So the thing to do here (IMHO) is:
> 
> Iff with PIPGM_PCSR = 0 configuring a new setting (that is finalized
> with writing a non-zero value to PIPGM_PCSR) completes the currently
> running period, then always assume the PWM as enabled.

Yes, this device works that way.

> 
> And so if the hardware is stopped and the counter is reset when 0 is
> written to PIPGM_PCSR, model that as enabled = false.

I don't think the current this driver can handle the above.
As far as I can see your comment, I think I need to implement this,
but after writing 0 to PIPGM_PCSR, driver need to confirm that signal has
changed to low level and change state->enabled to false. 
But with this device has no way of knowing that the signal has changed
to low level.

> 
> Best regards
> Uwe
> 
> [1] In practise this is more difficult because several PWMs don't
> complete periods in general. But the hardware under discussion luckily
> isn't one of these. And (worse) there are other hardware implementations
> where off doesn't emit an inactive level.

I see.

Best regards,
  Nobuhiro
