Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B45168E779
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfHOIy6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Aug 2019 04:54:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57047 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbfHOIy6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Aug 2019 04:54:58 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyBX3-0001Lc-9t; Thu, 15 Aug 2019 10:54:53 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyBX2-000227-Kc; Thu, 15 Aug 2019 10:54:52 +0200
Date:   Thu, 15 Aug 2019 10:54:52 +0200
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
Subject: Re: [PATCH v3 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190815085452.2cipewq3l3krnwzv@pengutronix.de>
References: <65a34dd943b0260bfe45ec76dcf414a67e5d8343.1565785291.git.baolin.wang@linaro.org>
 <446eb284a096a1fd8998765669b1c9a2f78d7d22.1565785291.git.baolin.wang@linaro.org>
 <20190814150304.x44lalde3cwp67ge@pengutronix.de>
 <CAMz4kuLiS=cGTA=uEi9ABOVAOb1M0Pcd2a_xU5VsdLo1DGd0Hg@mail.gmail.com>
 <20190815061540.763ue2ogkvuyhzcu@pengutronix.de>
 <CAMz4kuL_74V3M-8Zo99GnLaYbmgfQXO-h0Yz5qeXLQQ0ZR3TkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4kuL_74V3M-8Zo99GnLaYbmgfQXO-h0Yz5qeXLQQ0ZR3TkA@mail.gmail.com>
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

On Thu, Aug 15, 2019 at 04:16:32PM +0800, Baolin Wang wrote:
> On Thu, 15 Aug 2019 at 14:15, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Thu, Aug 15, 2019 at 11:34:27AM +0800, Baolin Wang wrote:
> > > On Wed, 14 Aug 2019 at 23:03, Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Wed, Aug 14, 2019 at 08:46:11PM +0800, Baolin Wang wrote:
> > > > > +     /*
> > > > > +      * The hardware provides a counter that is feed by the source clock.
> > > > > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> > > > > +      * Thus the period_ns and duty_ns calculation formula should be:
> > > > > +      * period_ns = NSEC_PER_SEC * (prescale + 1) * mod / clk_rate
> > > > > +      * duty_ns = NSEC_PER_SEC * (prescale + 1) * duty / clk_rate
> > > > > +      */
> > > > > +     val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
> > > > > +     prescale = val & SPRD_PWM_PRESCALE_MSK;
> > > > > +     tmp = (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> > > > > +     state->period = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > > > > +
> > > > > +     val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
> > > > > +     duty = val & SPRD_PWM_DUTY_MSK;
> > > > > +     tmp = (prescale + 1) * NSEC_PER_SEC * duty;
> > > > > +     state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> > > > > +
> > > > > +     /* Disable PWM clocks if the PWM channel is not in enable state. */
> > > > > +     if (!state->enabled)
> > > > > +             clk_bulk_disable_unprepare(SPRD_PWM_CHN_CLKS_NUM, chn->clks);
> > > > > +}
> > > > > +
> > > > > +static int sprd_pwm_config(struct sprd_pwm_chip *spc, struct pwm_device *pwm,
> > > > > +                        int duty_ns, int period_ns)
> > > > > +{
> > > > > +     struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> > > > > +     u32 prescale, duty;
> > > > > +     u64 tmp;
> > > > > +
> > > > > +     /*
> > > > > +      * The hardware provides a counter that is feed by the source clock.
> > > > > +      * The period length is (PRESCALE + 1) * MOD counter steps.
> > > > > +      * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> > > > > +      *
> > > > > +      * To keep the maths simple we're always using MOD = SPRD_PWM_MOD_MAX.
> > > >
> > > > Did you spend some thoughts about how wrong your period can get because
> > > > of that "lazyness"?
> > > >
> > > > Let's assume a clk rate of 100/3 MHz. Then the available period lengths
> > > > are:
> > > >
> > > >         PRESCALE =  0  ->  period =   7.65 µs
> > > >         PRESCALE =  1  ->  period =  15.30 µs
> > > >         ...
> > > >         PRESCALE = 17  ->  period = 137.70 µs
> > > >         PRESCALE = 18  ->  period = 145.35 µs
> > > >
> > > > So the error can be up to (nearly) 7.65 µs (or in general
> > >
> > > Yes, but for our use case (pwm backlight), the precision can meet our
> > > requirement. Moreover, we usually do not change the period, just
> > > adjust the duty to change the back light.
> >
> > Is this a license requirement for you SoC to only drive a backlight with
> > the PWM? The idea of having a PWM driver on your platform is that it can
> > also be used to control a step motor or a laser.
> 
> Not a license requirement. Until now we have not got any higher
> precision requirements, and we've run this driver for many years in
> our downstream kernel.

I understood that you're not ambitious to do something better than "it
worked for years".

> > > > PRESCALE = 18 and MOD = 254 you get a period of 144.78 µs and so the
> > > > error is only 0.56 µs which is a factor of 13 better.
> > > >
> > > > Hmm.
> > > >
> > > > > +      * The value for PRESCALE is selected such that the resulting period
> > > > > +      * gets the maximal length not bigger than the requested one with the
> > > > > +      * given settings (MOD = SPRD_PWM_MOD_MAX and input clock).
> > > > > +      */
> > > > > +     duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> > > >
> > > > I wonder if you loose some precision here as you use period_ns but might
> > > > actually implement a shorter period.
> > > >
> > > > Quick example, again consider clk_rate = 100 / 3 MHz,
> > > > period_ns = 145340, duty_ns = 72670. Then you end up with
> > > >
> > > >         PRESCALE = 17
> > > >         MOD = 255
> > > >         DUTY = 127
> > >
> > > Incorrect, we will get PRESCALE = 18,  MOD = 255, DUTY = 127.
> > >
> > > > That corresponds to period_ns = 137700, duty_ns = 68580. With DUTY = 134
> > > > you get 72360 ns which is still smaller than the requested 72670 ns.
> > >
> > > Incorrect, with DUTY = 134 (PRESCALE = 18  ->  period = 145.35 µs),
> > > duty_ns = 76380ns
> >
> > Yes, as above. When using rounding-closest your error is not in [0, 7.65
> > µs] but in [-3.825 µs, 3.825 µs]. Doesn't make it better.
> 
> Actually our use case really dose not care about this error.

I assume that Thierry will apply your patch anyhow. But be prepared that
you get a patch from me then to improve precision. It would be a waste
of resources not to do that after doing all the necessary math already.

> > > > (But then again it is not obvious which of the two is the "better"
> > > > approximation because Thierry doesn't seem to see the necessity to
> > > > discuss or define a policy here.)
> > >
> > > Like I said, this is the simple calculation formula which can meet our
> > > requirement (we limit our DUTY value can only be 0 - 254).
> > > duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> >
> > simple is often good but sometimes different from correct. And even with
> 
> I do not think this is incorrect.

Well, "correct" is probably not the right term. The problem is that my
efforts to improve the PWM framework are not going forward. And so the
suggestions I made here are not normative (yet) and undocumented.

> > rounding closest instead of rounding down you're giving away precision
> > here and the size of the error interval is the same, it is just centered
> > around 0 instead of only positive. If I hadn't spend so much time with
> > pwm reviews this week I'd try to come up with an example.
> 
> I am very appreciated for your comments.
> 
> > > > (And to pick up the thoughts about not using SPRD_PWM_MOD_MAX
> > > > unconditionally, you could also use
> > > >
> > > >         PRESCALE = 18
> > > >         MOD = 254
> > > >         DUTY = 127
> > > >
> > > > yielding period_ns = 144780 and duty_ns = 72390. Summary:
> > > >
> > > >         Request:                 72670 / 145340
> > > >         your result:             68580 / 137700
> > > >         also possible:           72390 / 144780
> > > >
> > > > Judge yourself.)
> > > >
> > > > > +     tmp = (u64)chn->clk_rate * period_ns;
> > > > > +     do_div(tmp, NSEC_PER_SEC);
> > > > > +     prescale = DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
> > > >
> > > > Now that you use DIV_ROUND_CLOSEST_ULL the comment is wrong because you
> > > > might provide a period bigger than the requested one. Also you divide
> > >
> > > Again, that's the precision can meet our requirement.
> >
> > If you go back to rounding down, use the matching rounding up in
> > .get_state and adapt your comment describing you're sticking to MOD=255
> > to say explicitly that you're loosing precision I can live with that. I
> > even did the math for .get_state in my previous mail for you.
> >
> > The idea of the requirement to round down is that I want to introduce
> > this as policy for the PWM framework to get some uniform behaviour from
> 
> Have you made a consensus about this? Documented it?

I tried. Check the pwm patchwork, there are uncommented patches that
first try to document the current status quo. When these are "in" I
intend to discuss the improvements I have in mind. But don't expect this
to be quickly done as even the (AFAICT) noncontroversial documentation
patches[1] fail to get applied.

> > all lowlevel drivers. If you do this now I won't bother you later when
> > the requirement is implemented in your driver. And the comment helps
> > someone who evaluates your SoC to judge if there is still work to do if
> > they have higher requirements for the PWM.
> 
> So what you asked is something like below, right?
> diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
> index 96f8aa0..1d3db94 100644
> --- a/drivers/pwm/pwm-sprd.c
> +++ b/drivers/pwm/pwm-sprd.c
> @@ -103,12 +103,12 @@ static void sprd_pwm_get_state(struct pwm_chip
> *chip, struct pwm_device *pwm,
>         val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE);
>         prescale = val & SPRD_PWM_PRESCALE_MSK;
>         tmp = (prescale + 1) * NSEC_PER_SEC * SPRD_PWM_MOD_MAX;
> -       state->period = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> +       state->period = DIV_ROUND_UP_ULL(tmp, chn->clk_rate);
> 
>         val = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY);
>         duty = val & SPRD_PWM_DUTY_MSK;
>         tmp = (prescale + 1) * NSEC_PER_SEC * duty;
> -       state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
> +       state->duty_cycle = DIV_ROUND_UP_ULL(tmp, chn->clk_rate);
> 
>         /* Disable PWM clocks if the PWM channel is not in enable state. */
>         if (!state->enabled)
> @@ -135,8 +135,8 @@ static int sprd_pwm_config(struct sprd_pwm_chip
> *spc, struct pwm_device *pwm,
>         duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> 
>         tmp = (u64)chn->clk_rate * period_ns;
> -       do_div(tmp, NSEC_PER_SEC);
> -       prescale = DIV_ROUND_CLOSEST_ULL(tmp, SPRD_PWM_MOD_MAX) - 1;
> +       div = 1000000000ULL * SPRD_PWM_MOD_MAX;
> +       prescale = div64_u64(tmp, div) - 1;
>         if (prescale > SPRD_PWM_PRESCALE_MSK)
>                 prescale = SPRD_PWM_PRESCALE_MSK;

This goes in the right direction for sure.

Without taking paper and pencil I wouldn't be surprised if the
calculation of duty_cycle in .get_state didn't match the calculation of
DUTY in .apply yet though.

> But our MOD is constant, it did not help to improve the precision.
> Instead, like you said, when period_ns = 145340, we will set PRESCALE
> = 17, so in .get_state(), user will get period_ns = 137700 (error
> is145340 -  137700).
> 
> But if we use DIV_ROUND_CLOSEST, in .get_state(), user will get
> period_ns = 145350 (error is 145350 -  145340).

In this case DIV_ROUND_CLOSEST seems to get nearer to the requested
value than when rounding down. But this example was constructed to show
your original algorithm to be bad, and just because you modify your
algorithm to perform better on that constructed example doesn't imply
the new one is better. Moreover you implement a bigger period than
requested which is something I intend to forbid in the future.

And note that with PWMs there is no "objective" metric that can tell you
which of two implementable outputs better match a given request. It
depends on the use case, so the best we can do is to tell our users our
metric and with that in mind they can create a request that then fits
their needs.

> > > > twice instead of once before. (I don't know what architecture your SoC
> > > > uses, but compared to a multiplication a division is usually expensive.)
> > > > Also the math is more complicated now as you have a round-down div and a
> > > > round-closest div.
> > > >
> > > > My preference for how to fix that is to restore the behaviour of v2 that
> > > > matches the comment and adapt .get_state() instead.
> > >
> > > Using DIV_ROUND_CLOSEST_ULL can get a same prescale which matches with
> > > .get_state().
> >
> > I don't get you here. Do you say that with DIV_ROUND_CLOSEST_ULL you get
> > the same result but DIV_ROUND_CLOSEST_ULL matches .get_state while
> > rounding down doesn't? I cannot follow.
> 
> Yes, that's what I mean.

But that is logically broken. If both approaches yield the same
results it cannot be true that exactly one of them matches the inverse
of .get_state.

I'm still confused.

Best regards
Uwe

[1] https://patchwork.ozlabs.org/patch/1021566/

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
