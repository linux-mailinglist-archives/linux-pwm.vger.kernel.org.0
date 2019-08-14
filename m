Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE758CF46
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 11:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfHNJXp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 05:23:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47725 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNJXp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 05:23:45 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxpVM-0000pP-7X; Wed, 14 Aug 2019 11:23:40 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxpVL-0004Xl-K7; Wed, 14 Aug 2019 11:23:39 +0200
Date:   Wed, 14 Aug 2019 11:23:39 +0200
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
Subject: Re: [PATCH v2 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190814092339.73ybj5mycklvpnrq@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <4f6e3110b4d7e0a2f7ab317bba98a933de12e5da.1565703607.git.baolin.wang@linaro.org>
 <20190813151612.v6x6e6kzxflkpu7b@pengutronix.de>
 <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4kuJURx=fPE6+0gP4ukzMcXr_z3t1ZH0K3Gv6=o4Od4uc7w@mail.gmail.com>
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

On Wed, Aug 14, 2019 at 04:42:28PM +0800, Baolin Wang wrote:
> On Tue, 13 Aug 2019 at 23:16, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Aug 13, 2019 at 09:46:41PM +0800, Baolin Wang wrote:
> > [...]
> Not really, our hardware's method is, when you changed a new
> configuration (MOD or duty is changed) , the hardware will wait for a
> while to complete current period, then change to the new period.

Can you describe that in more detail? This doesn't explain why MOD must be
configured before DUTY. Is there another reason for that?

> > > +static int sprd_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +                       struct pwm_state *state)
> > > +{
> > > +     struct sprd_pwm_chip *spc =
> > > +             container_of(chip, struct sprd_pwm_chip, chip);
> > > +     struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> > > +     struct pwm_state cstate;
> > > +     int ret;
> > > +
> > > +     pwm_get_state(pwm, &cstate);
> >
> > I don't like it when pwm drivers call pwm_get_state(). If ever
> > pwm_get_state would take a lock, this would deadlock as the lock is
> > probably already taken when your .apply() callback is running. Moreover
> > the (expensive) calculations are not used appropriately. See below.
> 
> I do not think so, see:
> 
> static inline void pwm_get_state(const struct pwm_device *pwm, struct
> pwm_state *state)
> {
>         *state = pwm->state;
> }

OK, the PWM framework currently caches this for you. Still I would
prefer if you didn't call PWM API functions in your lowlevel driver.
There is (up to now) nothing bad that will happen if you do it anyhow,
but when the PWM framework evolves it might (and I want to work on such
an evolution). You must not call clk_get_rate() in a .set_rate()
callback of a clock either.
 
> > > +     if (state->enabled) {
> > > +             if (!cstate.enabled) {
> >
> > To just know the value of cstate.enabled you only need to read the
> > register with the ENABLE flag. That is cheaper than calling get_state.
> >
> > > +                     /*
> > > +                      * The clocks to PWM channel has to be enabled first
> > > +                      * before writing to the registers.
> > > +                      */
> > > +                     ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS,
> > > +                                                   chn->clks);
> > > +                     if (ret) {
> > > +                             dev_err(spc->dev,
> > > +                                     "failed to enable pwm%u clocks\n",
> > > +                                     pwm->hwpwm);
> > > +                             return ret;
> > > +                     }
> > > +             }
> > > +
> > > +             if (state->period != cstate.period ||
> > > +                 state->duty_cycle != cstate.duty_cycle) {
> >
> > This is a coarse check. If state->period and cstate.period only differ
> > by one calling sprd_pwm_config(spc, pwm, state->duty_cycle,
> > state->period) probably results in a noop. So you're doing an expensive
> > division to get an unreliable check. It would be better to calculate the
> > register values from the requested state and compare the register
> > values. The costs are more or less the same than calling .get_state and
> > the check is reliable. And you don't need to spend another division to
> > calculate the new register values.
> 
> Same as above comment.

When taking the caching into account (which I wouldn't) the check is
still incomplete. OK, you could argue avoiding the recalculation in 90%
(to just say some number) of the cases where it is unnecessary is good.
 
> >
> > > +                     ret = sprd_pwm_config(spc, pwm, state->duty_cycle,
> > > +                                           state->period);
> > > +                     if (ret)
> > > +                             return ret;
> > > +             }
> > > +
> > > +             sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 1);
> > > +     } else if (cstate.enabled) {
> > > +             sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_ENABLE, 0);
> > > +
> > > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
> >
> > Assuming writing SPRD_PWM_ENABLE = 0 to the hardware completes the
> > currently running period and the write doesn't block that long: Does
> > disabling the clocks interfere with completing the period?
> 
> Writing SPRD_PWM_ENABLE = 0 will stop the PWM immediately, will not
> waiting for completing the currently period.

The currently active period is supposed to be completed. If you cannot
implement this please point this out as limitation at the top of the
driver.

Honestly I think most pwm users won't mind and they should get the
possibility to tell they prefer pwm_apply_state to return immediately
even if this could result in a spike. But we're not there yet.
(Actually there are three things a PWM consumer might want:

 a) stop immediately;
 b) complete the currently running period, then stop and return only
    when the period is completed; or
 c) complete the currently running period and then stop, return immediately if
    possible.

Currently the expected semantic is b).

> > > +static int sprd_pwm_remove(struct platform_device *pdev)
> > > +{
> > > +     struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
> > > +     int ret, i;
> > > +
> > > +     ret = pwmchip_remove(&spc->chip);
> > > +
> > > +     for (i = 0; i < spc->num_pwms; i++) {
> > > +             struct sprd_pwm_chn *chn = &spc->chn[i];
> > > +
> > > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
> >
> > If a PWM was still running you're effectively stopping it here, right?
> > Are you sure you don't disable once more than you enabled?
> 
> Yes, you are right. I should check current enable status of the PWM channel.
> Thanks for your comments.

I didn't recheck, but I think the right approach is to not fiddle with
the clocks at all and rely on the PWM framework to not let someone call
sprd_pwm_remove when a PWM is still in use.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
