Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491EF108032
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2019 21:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKWUBN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 Nov 2019 15:01:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47707 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWUBN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 Nov 2019 15:01:13 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iYbad-0002X6-7w; Sat, 23 Nov 2019 21:01:07 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iYbaU-0004d5-BV; Sat, 23 Nov 2019 21:00:58 +0100
Date:   Sat, 23 Nov 2019 21:00:58 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v8 5/6] pwm: sun4i: Add support to output source clock
 directly
Message-ID: <20191123200058.kz2farbyvruybtjj@pengutronix.de>
References: <20191121195902.6906-1-peron.clem@gmail.com>
 <20191121195902.6906-6-peron.clem@gmail.com>
 <20191121211630.slgayfbuykwvlvdt@pengutronix.de>
 <CAJiuCcdhH9zbRMMYsZbBYL-H8YWn2kimvJEjZ8Z8kF7Uh9MCpg@mail.gmail.com>
 <CAJiuCcd8VK2xHqRuWTVpNvw4e+rCR9-KjOSF5KsTcN9qQhaNVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcd8VK2xHqRuWTVpNvw4e+rCR9-KjOSF5KsTcN9qQhaNVw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Nov 23, 2019 at 03:05:48PM +0100, Clément Péron wrote:
> Hi Uwe,
> 
> On Thu, 21 Nov 2019 at 22:21, Clément Péron <peron.clem@gmail.com> wrote:
> >
> > Hi Uwe,
> >
> > On Thu, 21 Nov 2019 at 22:16, Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Thu, Nov 21, 2019 at 08:59:01PM +0100, Clément Péron wrote:
> > > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > >
> > > > PWM core has an option to bypass whole logic and output unchanged source
> > > > clock as PWM output. This is achieved by enabling bypass bit.
> > > >
> > > > Note that when bypass is enabled, no other setting has any meaning, not
> > > > even enable bit.
> > > >
> > > > This mode of operation is needed to achieve high enough frequency to
> > > > serve as clock source for AC200 chip which is integrated into same
> > > > package as H6 SoC.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > > > ---
> > > >  drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 46 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > index 1fa2057419fb..0fe9c680d6d0 100644
> > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > @@ -3,6 +3,10 @@
> > > >   * Driver for Allwinner sun4i Pulse Width Modulation Controller
> > > >   *
> > > >   * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > > + *
> > > > + * Limitations:
> > > > + * - When outputing the source clock directly, the PWM logic will be bypassed
> > > > + *   and the currently running period is not guaranteed to be completed
> > > >   */
> > > >
> > > >  #include <linux/bitops.h>
> > > > @@ -73,6 +77,7 @@ static const u32 prescaler_table[] = {
> > > >
> > > >  struct sun4i_pwm_data {
> > > >       bool has_prescaler_bypass;
> > > > +     bool has_direct_mod_clk_output;
> > > >       unsigned int npwm;
> > > >  };
> > > >
> > > > @@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
> > > >
> > > >       val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > >
> > > > +     /*
> > > > +      * PWM chapter in H6 manual has a diagram which explains that if bypass
> > > > +      * bit is set, no other setting has any meaning. Even more, experiment
> > > > +      * proved that also enable bit is ignored in this case.
> > > > +      */
> > > > +     if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
> > > > +         sun4i_pwm->data->has_direct_mod_clk_output) {
> > > > +             state->period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate);
> > > > +             state->duty_cycle = DIV_ROUND_UP_ULL(state->period, 2);
> > > > +             state->polarity = PWM_POLARITY_NORMAL;
> > > > +             state->enabled = true;
> > > > +             return;
> > > > +     }
> > > > +
> > > >       if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
> > > >           sun4i_pwm->data->has_prescaler_bypass)
> > > >               prescaler = 1;
> > > > @@ -149,13 +168,24 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
> > > >
> > > >  static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
> > > >                              const struct pwm_state *state,
> > > > -                            u32 *dty, u32 *prd, unsigned int *prsclr)
> > > > +                            u32 *dty, u32 *prd, unsigned int *prsclr,
> > > > +                            bool *bypass)
> > > >  {
> > > >       u64 clk_rate, div = 0;
> > > >       unsigned int pval, prescaler = 0;
> > > >
> > > >       clk_rate = clk_get_rate(sun4i_pwm->clk);
> > > >
> > > > +     *bypass = sun4i_pwm->data->has_direct_mod_clk_output &&
> > > > +               state->enabled &&
> > > > +               (state->period * clk_rate >= NSEC_PER_SEC) &&
> > > > +               (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
> > > > +               (state->duty_cycle * clk_rate * 2 >= NSEC_PER_SEC);
> > > > +
> > > > +     /* Skip calculation of other parameters if we bypass them */
> > > > +     if (*bypass)
> > > > +             return 0;
> > > > +
> > > >       if (sun4i_pwm->data->has_prescaler_bypass) {
> > > >               /* First, test without any prescaler when available */
> > > >               prescaler = PWM_PRESCAL_MASK;
> > > > @@ -206,6 +236,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > >       int ret;
> > > >       unsigned int delay_us, prescaler;
> > > >       unsigned long now;
> > > > +     bool bypass;
> > > >
> > > >       pwm_get_state(pwm, &cstate);
> > > >
> > > > @@ -220,7 +251,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > >       spin_lock(&sun4i_pwm->ctrl_lock);
> > > >       ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > >
> > > > -     ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler);
> > > > +     ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
> > > > +                               &bypass);
> > > >       if (ret) {
> > > >               dev_err(chip->dev, "period exceeds the maximum value\n");
> > > >               spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > @@ -229,6 +261,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > >               return ret;
> > > >       }
> > > >
> > > > +     if (sun4i_pwm->data->has_direct_mod_clk_output) {
> > > > +             if (bypass) {
> > > > +                     ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > > > +                     /* We can skip other parameter */
> > > > +                     sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> > > > +                     spin_unlock(&sun4i_pwm->ctrl_lock);
> > > > +                     return 0;
> > > > +             } else {
> > > > +                     ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > > > +             }
> > > > +     }
> > >
> > > This could be simplified to:
> > >
> > >         if (bypass) {
> > >                 ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > >                 /*
> > >                  * Other parameters are not relevant in this mode and so
> > >                  * writing them can be skipped
> > >                  */
> > >                 sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> > >                 spin_unlock(&sun4i_pwm->ctrl_lock);
> > >                 return 0;
> > >         } else {
> > >                 ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > >         }
> > >
> > > which has the advantage(?) that the bypass bit is also (more obviously)
> > > cleared for SoCs that don't support it and it reduces the indention
> > > level.
> >
> > This bit is not guaranteed to be reserved for all the SoC variants.
> >
> > I don't think it's a good idea to set to 0 a bit which is undefined.
> 
> Let me know if you agree or not with this and I send the v9 according
> to your answer.

If my suggestion is not safe according to the documentation, it is
obviously wrong. So only take it into account if a zero can be safely
written.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
