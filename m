Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E882C8E8D6
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfHOKLw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Aug 2019 06:11:52 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38937 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbfHOKLw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Aug 2019 06:11:52 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyCjU-0001A8-Ly; Thu, 15 Aug 2019 12:11:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyCjT-0005OP-Px; Thu, 15 Aug 2019 12:11:47 +0200
Date:   Thu, 15 Aug 2019 12:11:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190815101147.azbbjcvafwjx67wc@pengutronix.de>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
 <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
 <20190814150304.x44lalde3cwp67ge@pengutronix.de>
 <CAMz4kuLiS=cGTA=uEi9ABOVAOb1M0Pcd2a_xU5VsdLo1DGd0Hg@mail.gmail.com>
 <20190815061540.763ue2ogkvuyhzcu@pengutronix.de>
 <CAMz4kuL_74V3M-8Zo99GnLaYbmgfQXO-h0Yz5qeXLQQ0ZR3TkA@mail.gmail.com>
 <20190815085452.2cipewq3l3krnwzv@pengutronix.de>
 <CAMz4kuJs7pCXWyWd_WMK24JeLOzdVC8zPacRTp91nyTYDDdk5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4kuJs7pCXWyWd_WMK24JeLOzdVC8zPacRTp91nyTYDDdk5g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Thu, Aug 15, 2019 at 05:34:02PM +0800, Baolin Wang wrote:
> On Thu, 15 Aug 2019 at 16:54, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Thu, Aug 15, 2019 at 04:16:32PM +0800, Baolin Wang wrote:
> > > On Thu, 15 Aug 2019 at 14:15, Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Thu, Aug 15, 2019 at 11:34:27AM +0800, Baolin Wang wrote:
> > > > > On Wed, 14 Aug 2019 at 23:03, Uwe Kleine-König
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > On Wed, Aug 14, 2019 at 08:46:11PM +0800, Baolin Wang wrote:
> > > > > > > +     /*
> > > > > > > +      * The hardware provides a counter that is feed by the source clock.
> > > > > > > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > > > > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> > > > > > > +      * Thus the period_ns and duty_ns calculation formula should be:
> > > > > > > +      * period_ns = NSEC_PER_SEC * (prescale + 1) * mod / clk_rate
> > > > > > > +      * duty_ns = NSEC_PER_SEC * (prescale + 1) * duty / clk_rate
> > > > > > > +      */
> > > > > > > +     val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
> > > > > > > +     prescale = val & SPRD_PWM_PRESCALE_MSK;
> > > > > > > +     tmp = (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > > > > > > +     state->period = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > > > > > > +
> > > > > > > +     val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> > > > > > > +     duty = val & SPRD_PWM_DUTY_MSK;
> > > > > > > +     tmp = (prescale + 1) * NSEC_PER_SEC * duty;
> > > > > > > +     state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > > > > > > +
> > > > > > > +     /* Disable PWM clocks if the PWM channel is not in enable state. */
> > > > > > > +     if (!state->enabled)
> > > > > > > +             clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
> > > > > > > +                        int duty_ns, int period_ns)
> > > > > > > +{
> > > > > > > +     struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> > > > > > > +     u32 prescale, duty;
> > > > > > > +     u64 tmp;
> > > > > > > +
> > > > > > > +     /*
> > > > > > > +      * The hardware provides a counter that is feed by the source clock.
> > > > > > > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > > > > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> > > > > > > +      *
> > > > > > > +      * To keep the maths simple we're always using MOD = SPRD_PWM_MOD_MAX.
> > > > > >
> > > > > > Did you spend some thoughts about how wrong your period can get because
> > > > > > of that "lazyness"?
> > > > > >
> > > > > > Let's assume a clk rate of 100/3 MHz. Then the available period lengths
> > > > > > are:
> > > > > >
> > > > > >         PRESCALE =  0  ->  period =   7.65 µs
> > > > > >         PRESCALE =  1  ->  period =  15.30 µs
> > > > > >         ...
> > > > > >         PRESCALE = 17  ->  period = 137.70 µs
> > > > > >         PRESCALE = 18  ->  period = 145.35 µs
> > > > > >
> > > > > > So the error can be up to (nearly) 7.65 µs (or in general
> > > > >
> > > > > Yes, but for our use case (pwm backlight), the precision can meet our
> > > > > requirement. Moreover, we usually do not change the period, just
> > > > > adjust the duty to change the back light.
> > > >
> > > > Is this a license requirement for you SoC to only drive a backlight with
> > > > the PWM? The idea of having a PWM driver on your platform is that it can
> > > > also be used to control a step motor or a laser.
> > >
> > > Not a license requirement. Until now we have not got any higher
> > > precision requirements, and we've run this driver for many years in
> > > our downstream kernel.
> >
> > I understood that you're not ambitious to do something better than "it
> > worked for years".
> 
> How do you know that?

I showed you how you could match the requested PWM output better and
you refused telling it worked for years and the added precision isn't
necessary for a backlight.

> If there are some cases expect a higher precision, then we can analyze
> how precision asked by the user, then we have a goal to improve it,
> even improve the hardware. But now, I said there are no these use
> cases, why I should add more mathematics to increase load and
> complication.
> 
> > > > > > PRESCALE = 18 and MOD = 254 you get a period of 144.78 µs and so the
> > > > > > error is only 0.56 µs which is a factor of 13 better.
> > > > > >
> > > > > > Hmm.
> > > > > >
> > > > > > > +      * The value for PRESCALE is selected such that the resulting period
> > > > > > > +      * gets the maximal length not bigger than the requested one with the
> > > > > > > +      * given settings (MOD = SPRD_PWM_MOD_MAX and input clock).
> > > > > > > +      */
> > > > > > > +     duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > > > > >
> > > > > > I wonder if you loose some precision here as you use period_ns but might
> > > > > > actually implement a shorter period.
> > > > > >
> > > > > > Quick example, again consider clk_rate = 100 / 3 MHz,
> > > > > > period_ns = 145340, duty_ns = 72670. Then you end up with
> > > > > >
> > > > > >         PRESCALE = 17
> > > > > >         MOD = 255
> > > > > >         DUTY = 127
> > > > >
> > > > > Incorrect, we will get PRESCALE = 18,  MOD = 255, DUTY = 127.
> > > > >
> > > > > > That corresponds to period_ns = 137700, duty_ns = 68580. With DUTY = 134
> > > > > > you get 72360 ns which is still smaller than the requested 72670 ns.
> > > > >
> > > > > Incorrect, with DUTY = 134 (PRESCALE = 18  ->  period = 145.35 µs),
> > > > > duty_ns = 76380ns
> > > >
> > > > Yes, as above. When using rounding-closest your error is not in [0, 7.65
> > > > µs] but in [-3.825 µs, 3.825 µs]. Doesn't make it better.
> > >
> > > Actually our use case really dose not care about this error.
> >
> > I assume that Thierry will apply your patch anyhow. But be prepared that
> > you get a patch from me then to improve precision. It would be a waste
> > of resources not to do that after doing all the necessary math already.
> 
> Glad to see your improvement without introducing complicated and more
> mathematics.

I don't understand you. Either you or me will improve the precision. The
maths is the same for both cases. I would prefer you do it, otherwise I
will have the problem later that I must get you to invest the time to
test or I'd have to argue the change to go in untested.

> > > > all lowlevel drivers. If you do this now I won't bother you later when
> > > > the requirement is implemented in your driver. And the comment helps
> > > > someone who evaluates your SoC to judge if there is still work to do if
> > > > they have higher requirements for the PWM.
> > >
> > > So what you asked is something like below, right?
> > > diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> > > index 96f8aa0..1d3db94 100644
> > > --- a/drivers/pwm/pwm-sprd.c
> > > +++ b/drivers/pwm/pwm-sprd.c
> > > @@ -103,12 +103,12 @@ static void sprd_pwm_get_state(struct pwm_chip
> > > *chip, struct pwm_device *pwm,
> > >         val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
> > >         prescale = val & SPRD_PWM_PRESCALE_MSK;
> > >         tmp = (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > > -       state->period = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > > +       state->period = DIV_ROUND_UP_ULL(tmp, chn->clk_rate);
> > >
> > >         val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> > >         duty = val & SPRD_PWM_DUTY_MSK;
> > >         tmp = (prescale + 1) * NSEC_PER_SEC * duty;
> > > -       state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > > +       state->duty_cycle = DIV_ROUND_UP_ULL(tmp, chn->clk_rate);
> > >
> > >         /* Disable PWM clocks if the PWM channel is not in enable state. */
> > >         if (!state->enabled)
> > > @@ -135,8 +135,8 @@ static int sprd_pwm_config(struct sprd_pwm_chip
> > > *spc, struct pwm_device *pwm,
> > >         duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > >
> > >         tmp = (u64)chn->clk_rate * period_ns;
> > > -       do_div(tmp, NSEC_PER_SEC);
> > > -       prescale = DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
> > > +       div = 1000000000ULL * SPRD_PWM_MOD_MAX;
> > > +       prescale = div64_u64(tmp, div) - 1;
> > >         if (prescale > SPRD_PWM_PRESCALE_MSK)
> > >                 prescale = SPRD_PWM_PRESCALE_MSK;
> >
> > This goes in the right direction for sure.
> >
> > Without taking paper and pencil I wouldn't be surprised if the
> > calculation of duty_cycle in .get_state didn't match the calculation of
> > DUTY in .apply yet though.
> >
> > > But our MOD is constant, it did not help to improve the precision.
> > > Instead, like you said, when period_ns = 145340, we will set PRESCALE
> > > = 17, so in .get_state(), user will get period_ns = 137700 (error
> > > is145340 -  137700).
> > >
> > > But if we use DIV_ROUND_CLOSEST, in .get_state(), user will get
> > > period_ns = 145350 (error is 145350 -  145340).
> >
> > In this case DIV_ROUND_CLOSEST seems to get nearer to the requested
> > value than when rounding down. But this example was constructed to show
> > your original algorithm to be bad, and just because you modify your
> > algorithm to perform better on that constructed example doesn't imply
> > the new one is better. Moreover you implement a bigger period than
> > requested which is something I intend to forbid in the future.
> >
> > And note that with PWMs there is no "objective" metric that can tell you
> > which of two implementable outputs better match a given request. It
> > depends on the use case, so the best we can do is to tell our users our
> > metric and with that in mind they can create a request that then fits
> > their needs.
> 
> Yes, that should be asked by the use case, some cases do not care a
> little bigger period than requested.

So for some cases it is beneficial to be predictable and for other it
isn't. So the only safe thing to do for a lowlevel driver is to be
predictable always because it cannot (and shouldn't) tell if the current
request is one of cases where precision matters.

> As you said, what you asked did not get a consensus yet, so I'd like
> to wait for Thierry's suggestion.
> 
> > > > > > twice instead of once before. (I don't know what architecture your SoC
> > > > > > uses, but compared to a multiplication a division is usually expensive.)
> > > > > > Also the math is more complicated now as you have a round-down div and a
> > > > > > round-closest div.
> > > > > >
> > > > > > My preference for how to fix that is to restore the behaviour of v2 that
> > > > > > matches the comment and adapt .get_state() instead.
> > > > >
> > > > > Using DIV_ROUND_CLOSEST_ULL can get a same prescale which matches with
> > > > > .get_state().
> > > >
> > > > I don't get you here. Do you say that with DIV_ROUND_CLOSEST_ULL you get
> > > > the same result but DIV_ROUND_CLOSEST_ULL matches .get_state while
> > > > rounding down doesn't? I cannot follow.
> > >
> > > Yes, that's what I mean.
> >
> > But that is logically broken. If both approaches yield the same
> > results it cannot be true that exactly one of them matches the inverse
> > of .get_state.
> 
> What I mean is use DIV_ROUND_CLOSEST_ULL we can get a nearer value to
> the requested like above example.

But given that it's unclear if 137700 ns or 145350 ns is better when
145340 ns was requested this is not a strong argument to use
DIV_ROUND_CLOSEST_ULL. With the global picture for the pwm framework in
mind it is sensible to request the same rounding from all drivers to get
a consistent behaviour. And I believe the maths with rounding down is
easier than when rounding up or nearest. That's why I argue in this
direction.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
