Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0A363881
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Apr 2021 01:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhDRXVx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 19:21:53 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:54030 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhDRXVx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 19:21:53 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 13INL0TW024872; Mon, 19 Apr 2021 08:21:00 +0900
X-Iguazu-Qid: 34trpShQIDkL9fGb0y
X-Iguazu-QSIG: v=2; s=0; t=1618788060; q=34trpShQIDkL9fGb0y; m=htFKz+h4lbFLcahE26O7ZRAXTEyWViAHI8UFOYwBN5k=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 13INKxGT022101
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 08:20:59 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 19AA91000BB;
        Mon, 19 Apr 2021 08:20:59 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13INKwYW003126;
        Mon, 19 Apr 2021 08:20:58 +0900
Date:   Mon, 19 Apr 2021 08:20:01 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
X-TSB-HOP: ON
Message-ID: <20210418232001.lvx7ho2qo2ac2khy@toshiba.co.jp>
References: <20210418110904.1942806-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210418110904.1942806-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210418134411.vfltokielrwuygqa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210418134411.vfltokielrwuygqa@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for your review.

On Sun, Apr 18, 2021 at 03:44:11PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> just a few smaller issues left to fix.
> 
> On Sun, Apr 18, 2021 at 08:09:04PM +0900, Nobuhiro Iwamatsu wrote:
> > diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
> > new file mode 100644
> > index 000000000000..166b18ac1a3a
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-visconti.c
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Toshiba Visconti pulse-width-modulation controller driver
> > + *
> > + * Copyright (c) 2020 TOSHIBA CORPORATION
> > + * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
> 
> We're in 2021, so you might want to adapt the year in the copy right
> notice.

OK, I will update.

> 
> > + *
> > + * Authors: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > + *
> > + * Limitations:
> > + * - PIPGM_PWMC is a 2-bit divider (00: 1, 01: 2, 10: 4, 11: 8).
> 
> This is too detailed for the purpose of this section. Please either drop
> it or make this:
> 
>  - The fixed input clock is running at 1 MHz and is divided by either 1,
>    2, 4 or 8.


OK, I will add your sugggestion.

> 
> > + * - Fixed input clock running at 1 MHz.
> > + * - When the settings of the PWM are modified, the new values are shadowed
> > + *   in hardware until the PIPGM_PCSR register is written and the currently
> > + *   running period is completed. This way the hardware switches atomically
> > + *   from the old setting to the new.
> > + * - Disabling the hardware completes the currently running period and keeps
> > + *   the output at low level at all times.
> > + */
> > +
> > [...]
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
> 
> The linux coding style mandates that you should use braces for both
> branches. (i.e.
> 
> +	if (period > 0xffff) {
> +		pwmc0 = ilog2(period >> 16);
> +		BUG_ON(pwmc0 > 3);
> +	} else {
> +		pwmc0 = 0;
> +	}
> )

Oh, I fotgot it, I will fix this. Thanks you.

> 
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
> 
> Best regards
> Uwe


Best regards,
  Nobuhiro

