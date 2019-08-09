Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DFB87CDC
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfHIOla (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 10:41:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57271 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfHIOl3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 10:41:29 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw657-0006jk-L2; Fri, 09 Aug 2019 16:41:25 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hw656-0000VK-JT; Fri, 09 Aug 2019 16:41:24 +0200
Date:   Fri, 9 Aug 2019 16:41:24 +0200
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
Message-ID: <20190809144124.3as3rtctlywxkudr@pengutronix.de>
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de>
 <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
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

On Fri, Aug 09, 2019 at 06:06:21PM +0800, Baolin Wang wrote:
> On Fri, 9 Aug 2019 at 17:10, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Thu, Aug 08, 2019 at 04:59:39PM +0800, Baolin Wang wrote:
> > > +{
> > > +     struct sprd_pwm_chip *spc =
> > > +             container_of(chip, struct sprd_pwm_chip, chip);
> > > +     struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> > > +     u64 div, tmp;
> > > +     u32 prescale, duty;
> > > +     int ret;
> > > +
> > > +     /*
> > > +      * NOTE: the clocks to PWM channel has to be enabled first before
> > > +      * writing to the registers.
> > > +      */
> > > +     if (!chn->clk_enabled) {
> > > +             ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
> >
> > Do you really need to enable all 8 clocks to configure a single channel?
> 
> We have 4 channels, and each channel use 2 clocks, so here only enable
> 2 clocks, see SPRD_PWM_NUM_CLKS.

Ah, I thought SPRD_PWM_NUM_CLKS was 8.

> > > +             if (ret) {
> > > +                     dev_err(spc->dev, "failed to enable pwm%u clock\n",
> > > +                             pwm->hwpwm);
> > > +                     return ret;
> > > +             }
> > > +
> > > +             chn->clk_enabled = true;
> > > +     }
> > > +
> > > +     duty = duty_ns * SPRD_PWM_MOD_MAX / period_ns;
> >
> > @Baolin: until we're there that there are framework requirements how to
> > round, please document at least how you do it here. Also describing the
> > underlying concepts would be good for the driver reader.
> >
> > Something like:
> >
> > /*
> >  * The hardware provides a counter that is feed by the source clock.
> >  * The period length is (PRESCALE + 1) * MOD counter steps.
> >  * The duty cycle length is (PRESCALE + 1) * DUTY counter steps.
> >  *
> >  * To keep the maths simple we're always using MOD = MOD_MAX.
> >  * The value for PRESCALE is selected such that the resulting period
> >  * gets the maximal length not bigger than the requested one with the
> >  * given settings (MOD = MOD_MAX and input clock).
> >  */
> 
> Yes, totally agree with you. I will add some documentation for our
> controller's setting.
> 
> >
> > @Thierry: having a framework guideline here would be good. Or still
> > better a guideline and a debug setting that notices drivers stepping out
> > of line.
> >
> > I assume using MOD = 0 is forbidden?
> >
> > > +     /*
> > > +      * According to the datasheet, the period_ns calculation formula
> > > +      * should be:
> > > +      * period_ns = 10^9 * (prescale + 1) * mod / clk_rate
> > > +      *
> > > +      * Then we can get the prescale formula:
> > > +      * prescale = (period_ns * clk_rate) / (10^9 * mod) -1
> > > +      */
> > > +     tmp = chn->clk_rate * period_ns;
> > > +     div = 1000000000ULL * SPRD_PWM_MOD_MAX;
> >
> > Please use NSEC_PER_SEC instead of 1000000000ULL.
> 
> Sure.
> 
> >
> > > +     prescale = div64_u64(tmp, div) - 1;
> >
> > If tmp is smaller than div you end up with prescale = 0xffffffff which
> > should be catched. What if prescale > 0xffff?
> 
> Usually we can not meet this case, but you are right, the prescale has
> a limit according to the register definition. So will add a validation
> here.
> 
> >
> > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_MOD, SPRD_PWM_MOD_MAX);
> > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_DUTY, duty);
> >
> > You're losing precision here as you always use SPRD_PWM_MOD_MAX, right?
> > (Just for my understanding, if this simpler approach is good enough
> > here that's fine.)
> 
> Yes, SPRD_PWM_MOD_MAX is good enough.

ok.
 
> >
> > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_LOW, SPRD_PWM_REG_MSK);
> > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PAT_HIGH, SPRD_PWM_REG_MSK);
> >
> > Please describe these two registers in a short comment.
> 
> Sure.
> 
> >
> > > +     sprd_pwm_write(spc, pwm->hwpwm, SPRD_PWM_PRESCALE, prescale);
> >
> > Is the configuration here atomic in the sense that the write of DUTY
> > above only gets effective when PRESCALE is written? If not, please add
> 
> Yes.
> 
> > a describing paragraph at the top of the driver similar to what is
> > written in pwm-sifive.c. When the PWM is already running before, how
> > does a configuration change effects the output? Is the currently running
> > period completed?
> 
> Anyway, I'll add some comments to explain how it works.

I'd apreciate if you'd stick to the format in pwm-sifive.c to make it
easier to grep for that.
 
> > > +static void sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +                            struct pwm_state *state)
> > > +{
> > > +     struct sprd_pwm_chip *spc =
> > > +             container_of(chip, struct sprd_pwm_chip, chip);
> > > +     struct sprd_pwm_chn *chn = &spc->chn[pwm->hwpwm];
> > > +     u32 enabled, duty, prescale;
> > > +     u64 tmp;
> > > +     int ret;
> > > +
> > > +     ret = clk_bulk_prepare_enable(SPRD_PWM_NUM_CLKS, chn->clks);
> > > +     if (ret) {
> > > +             dev_err(spc->dev, "failed to enable pwm%u clocks\n",
> > > +                     pwm->hwpwm);
> > > +             return;
> > > +     }
> > > +
> > > +     chn->clk_enabled = true;
> > > +
> > > +     duty = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_DUTY) & SPRD_PWM_REG_MSK;
> > > +     prescale = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_PRESCALE) & SPRD_PWM_REG_MSK;
> > > +     enabled = sprd_pwm_read(spc, pwm->hwpwm, SPRD_PWM_ENABLE) & SPRD_PWM_ENABLE_BIT;
> > > +
> > > +     /*
> > > +      * According to the datasheet, the period_ns and duty_ns calculation
> > > +      * formula should be:
> > > +      * period_ns = 10^9 * (prescale + 1) * mod / clk_rate
> > > +      * duty_ns = 10^9 * (prescale + 1) * duty / clk_rate
> > > +      */
> > > +     tmp = (prescale + 1) * 1000000000ULL * SPRD_PWM_MOD_MAX;
> > > +     state->period = div64_u64(tmp, chn->clk_rate);
> >
> > This is not idempotent. If you apply the configuration that is returned
> > here this shouldn't result in a reconfiguration.
> 
> Since we may configure the  PWM in bootloader, so in kernel part we
> should get current PWM state to avoid reconfiguration if state
> configuration are same.

This is also important as some consumers might do something like:

	state = pwm_get_state(mypwm)
	if (something):
		state->duty = 0
	else:
		state->duty = state->period / 2
	pwm_set_state(mypwm, state)

and then period shouldn't get smaller in each step.
(This won't happen as of now because the PWM framework caches the last
state that was set and returns this for pwm_get_state. Still getting
this right would be good.)

> > > +     tmp = (prescale + 1) * 1000000000ULL * duty;
> > > +     state->duty_cycle = div64_u64(tmp, chn->clk_rate);
> > > +
> > > +     state->enabled = !!enabled;
> > > +
> > > +     /* Disable PWM clocks if the PWM channel is not in enable state. */
> > > +     if (!enabled) {
> > > +             clk_bulk_disable_unprepare(SPRD_PWM_NUM_CLKS, chn->clks);
> > > +             chn->clk_enabled = false;
> > > +     }
> > > +}
> > > +
> > > +static const struct pwm_ops sprd_pwm_ops = {
> > > +     .config = sprd_pwm_config,
> > > +     .enable = sprd_pwm_enable,
> > > +     .disable = sprd_pwm_disable,
> > > +     .get_state = sprd_pwm_get_state,
> > > +     .owner = THIS_MODULE,
> > > +};
> > > +
> > > +static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
> > > +{
> > > +     struct clk *clk_parent, *clk_pwm;
> > > +     int ret, i, clk_index = 0;
> > > +
> > > +     clk_parent = devm_clk_get(spc->dev, "source");
> > > +     if (IS_ERR(clk_parent)) {
> > > +             dev_err(spc->dev, "failed to get source clock\n");
> > > +             return PTR_ERR(clk_parent);
> > > +     }
> > > +
> > > +     for (i = 0; i < SPRD_PWM_NUM; i++) {
> > > +             struct sprd_pwm_chn *chn = &spc->chn[i];
> > > +             int j;
> > > +
> > > +             for (j = 0; j < SPRD_PWM_NUM_CLKS; ++j)
> > > +                     chn->clks[j].id = sprd_pwm_clks[clk_index++];
> > > +
> > > +             ret = devm_clk_bulk_get(spc->dev, SPRD_PWM_NUM_CLKS, chn->clks);
> > > +             if (ret) {
> > > +                     if (ret == -ENOENT)
> > > +                             break;
> >
> > devm_clk_bulk_get_optional ? I'm sure you don't want to get all 8 clocks
> > 8 times.
> 
> This is not optional, each channel has 2 required clocks, and we have
> 4 channels. (SPRD_PWM_NUM_CLKS == 2)

I see. Currently it is not possible to use channel 2 if there are no
clocks for channel 0, right? There is no hardware related problem here,
just a shortcoming of the driver?

> > > +
> > > +                     dev_err(spc->dev, "failed to get channel clocks\n");
> > > +                     return ret;
> > > +             }
> > > +
> > > +             clk_pwm = chn->clks[1].clk;
> >
> > This 1 looks suspicious. Are you using all clocks provided in the dtb at
> > all? You're not using i in the loop at all, this doesn't look right.
> 
> Like I said above, each channel has 2 clocks: enable clock and pwm
> clock, the 2nd clock of each channel's bulk clocks is the pwm clock,
> which is used to set the source clock. I know this's not easy to read,
> so do you have any good suggestion?

Not sure this is easily possible to rework to make this clearer.
 
Do these clks have different uses? e.g. one to enable register access
and the other to enable the pwm output? If so just using
devm_clk_bulk_get isn't the right thing because you should be able know
if clks[0] or clks[1] is the one you need to enable the output (or
register access).

> > > +             if (!clk_set_parent(clk_pwm, clk_parent))
> > > +                     chn->clk_rate = clk_get_rate(clk_pwm);
> > > +             else
> > > +                     chn->clk_rate = SPRD_PWM_DEFAULT_CLK;
> >
> > I don't know all the clock framework details, but I think there are
> > better ways to ensure that a given clock is used as parent for another
> > given clock. Please read the chapter about "Assigned clock parents and
> > rates" in the clock bindings and check if this could be used for the
> > purpose here and so simplify the driver.
> 
> Actually there are many other drivers set the parent clock like this,
> and we want a default clock if failed to set the parent clock.

These might be older than the clk framework capabilities, or the
reviewers didn't pay attention to this detail; both shouldn't be a
reason to not make it better here.

> > > +     return 0;
> > > +}
> > > +
> > > +static int sprd_pwm_remove(struct platform_device *pdev)
> > > +{
> > > +     struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
> > > +     int i;
> > > +
> > > +     for (i = 0; i < spc->num_pwms; i++)
> > > +             pwm_disable(&spc->chip.pwms[i]);
> >
> > This is wrong. You must not call pwm_disable here. It's the consumer's
> > responsibility to disable the hardware.
> 
> Emm, I saw some drivers did like this, like pwm-spear.c.
> Could you elaborate on what's the problem if the driver issues pwm_disable?

This is a function to be called from code that called pwm_get before
(i.e. pwm consumers). This just doesn't explode because up to now the
PWM framework is only a thin wrapper around the lowlevel driver
callbacks.

The reasoning is similar to what I wrote in commit
f82d15e223403b05fffb33ba792b87a8620f6fee. I'd like to have a PWM_DEBUG
setting that catches such problems but the discussion with Thierry to
even document the expectations is stuck, see
https://patchwork.ozlabs.org/patch/1021566/.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
