Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A54B898CB
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2019 10:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfHLIgE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Aug 2019 04:36:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50669 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfHLIgE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Aug 2019 04:36:04 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx5o6-0001lO-8V; Mon, 12 Aug 2019 10:35:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hx5o4-0005vW-EO; Mon, 12 Aug 2019 10:35:56 +0200
Date:   Mon, 12 Aug 2019 10:35:56 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190812083556.dvprpwv6mjy3cjae@pengutronix.de>
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de>
 <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
 <20190809144124.3as3rtctlywxkudr@pengutronix.de>
 <CAMz4ku+o6dCyxhR3-5yM+zr2nBpTQG5A8Pbnxpo7yRciwPbv3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4ku+o6dCyxhR3-5yM+zr2nBpTQG5A8Pbnxpo7yRciwPbv3Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Baolin,

On Mon, Aug 12, 2019 at 03:29:07PM +0800, Baolin Wang wrote:
> Hi Uwe,
> 
> On Fri, 9 Aug 2019 at 22:41, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Aug 09, 2019 at 06:06:21PM +0800, Baolin Wang wrote:
> > > On Fri, 9 Aug 2019 at 17:10, Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> > > > > +static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > > +                            struct pwm_state *state)
> > > > > +{
> > > > > +     struct sprd_pwm_chip *spc =
> > > > > +             container_of(chip, struct sprd_pwm_chip, chip);
> > > > > +     struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> > > > > +     u32 enabled, duty, prescale;
> > > > > +     u64 tmp;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
> > > > > +     if (ret) {
> > > > > +             dev_err(spc->dev, "failed to enable pwm%u clocks\n",
> > > > > +                     pwm->hwpwm);
> > > > > +             return;
> > > > > +     }
> > > > > +
> > > > > +     chn->clk_enabled = true;
> > > > > +
> > > > > +     duty = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY) & SPRD_PWM_REG_MSK;
> > > > > +     prescale = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE) & SPRD_PWM_REG_MSK;
> > > > > +     enabled = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE) & SPRD_PWM_ENABLE_BIT;
> > > > > +
> > > > > +     /*
> > > > > +      * According to the datasheet, the period_ns and duty_ns calculation
> > > > > +      * formula should be:
> > > > > +      * period_ns = 10^9 * (prescale + 1) * mod / clk_rate
> > > > > +      * duty_ns = 10^9 * (prescale + 1) * duty / clk_rate
> > > > > +      */
> > > > > +     tmp = (prescale + 1) * 1000000000ULL * SPRD_PWM_MOD_MAX;
> > > > > +     state->period = div64_u64(tmp, chn->clk_rate);
> > > >
> > > > This is not idempotent. If you apply the configuration that is returned
> > > > here this shouldn't result in a reconfiguration.
> > >
> > > Since we may configure the  PWM in bootloader, so in kernel part we
> > > should get current PWM state to avoid reconfiguration if state
> > > configuration are same.
> >
> > This is also important as some consumers might do something like:
> >
> >         state = pwm_get_state(mypwm)
> >         if (something):
> >                 state->duty = 0
> >         else:
> >                 state->duty = state->period / 2
> >         pwm_set_state(mypwm, state)
> >
> > and then period shouldn't get smaller in each step.
> > (This won't happen as of now because the PWM framework caches the last
> > state that was set and returns this for pwm_get_state. Still getting
> > this right would be good.)
> 
> I understood your concern, but the period can be configured in
> bootloader, we have no software things to save the accurate period.

I don't understand what you're saying here. The bootloader configuring
the hardware is a usual use-case. That's why we have the .get_state
callback in the first place.

> Moreover I think I can change to use DIV_ROUND_CLOSET_ULL to keep the
> accuracy.

DIV_ROUND_CLOSEST_ULL still doesn't match what the apply callback uses.
With the lack of an official statement from the maintainer I'd prefer
.apply to round down and implement .get_state such that

	pwm_apply(pwm, pwm_get_state(pwm))

is a no-op.
 
> > > > > +
> > > > > +                     dev_err(spc->dev, "failed to get channel clocks\n");
> > > > > +                     return ret;
> > > > > +             }
> > > > > +
> > > > > +             clk_pwm = chn->clks[1].clk;
> > > >
> > > > This 1 looks suspicious. Are you using all clocks provided in the dtb at
> > > > all? You're not using i in the loop at all, this doesn't look right.
> > >
> > > Like I said above, each channel has 2 clocks: enable clock and pwm
> > > clock, the 2nd clock of each channel's bulk clocks is the pwm clock,
> > > which is used to set the source clock. I know this's not easy to read,
> > > so do you have any good suggestion?
> >
> > Not sure this is easily possible to rework to make this clearer.
> >
> > Do these clks have different uses? e.g. one to enable register access
> > and the other to enable the pwm output? If so just using
> 
> Yes.

So assuming one of the clocks is for operation of the output and the
other for accessing the registers, the latter can be disabled at the end
of each callback?

> > devm_clk_bulk_get isn't the right thing because you should be able know
> > if clks[0] or clks[1] is the one you need to enable the output (or
> > register access).
> 
> We've fixed the clock order in bulk clocks by the array
> 'sprd_pwm_clks', maybe I should define one readable macro instead of
> magic number.

ack.

> > > > > +             if (!clk_set_parent(clk_pwm, clk_parent))
> > > > > +                     chn->clk_rate = clk_get_rate(clk_pwm);
> > > > > +             else
> > > > > +                     chn->clk_rate = SPRD_PWM_DEFAULT_CLK;
> > > >
> > > > I don't know all the clock framework details, but I think there are
> > > > better ways to ensure that a given clock is used as parent for another
> > > > given clock. Please read the chapter about "Assigned clock parents and
> > > > rates" in the clock bindings and check if this could be used for the
> > > > purpose here and so simplify the driver.
> > >
> > > Actually there are many other drivers set the parent clock like this,
> > > and we want a default clock if failed to set the parent clock.
> >
> > These might be older than the clk framework capabilities, or the
> > reviewers didn't pay attention to this detail; both shouldn't be a
> > reason to not make it better here.
> 
> The clock framework supplies 'assigned-clocks' and
> 'assigned-clock-parents' properties to set parent, but for our case we
> still want to set a default clock rate if failed to set parent when
> met some abnormal things.

Without understanding the complete problem I'd say this is out of the
area the driver should care about.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
