Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1296B25
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 23:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfHTVI7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 17:08:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45153 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTVI7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Aug 2019 17:08:59 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i0BNB-000229-HZ; Tue, 20 Aug 2019 23:08:57 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i0BN9-000174-9E; Tue, 20 Aug 2019 23:08:55 +0200
Date:   Tue, 20 Aug 2019 23:08:55 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH RFC] pwm: add debug knob to help driver authors
Message-ID: <20190820210855.wrphefr4n3kwib4e@pengutronix.de>
References: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
 <c9a4e48b-92e9-90a0-a0c4-a571f6afa7b3@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9a4e48b-92e9-90a0-a0c4-a571f6afa7b3@ysoft.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Michal,

On Tue, Aug 20, 2019 at 04:29:10PM +0200, Michal Vokáč wrote:
> On 15. 08. 19 11:38, Uwe Kleine-König wrote:
> > This patch adds some additional checks to the pwm core that help getting
> > the details right. The check about rounding isn't approved yet, but I
> > consider that sensible as it helps consistency when all drivers round in
> > the same direction. The other checks are in line with what I understood
> > are the intended requirements.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > this patch is only compile tested up to now but still I think it adds
> > useful diagnostics for driver authors that helps even more than an exact
> > documentation. Feedback welcome.
> 
> First of all, thank you for your continuous effort to improve the situation!
> I just tried your patch on our imx6 platform. Here are my few cents.

Great. I didn't test my patch at all because I first wanted to collect
some feedback if such a debug knob is considered a good idea. So I
really appreciate your feedback.
 
> >   drivers/pwm/Kconfig |  8 +++++++
> >   drivers/pwm/core.c  | 56 +++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 64 insertions(+)
> > 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index a7e57516959e..76105cfd581d 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -33,6 +33,14 @@ config PWM_SYSFS
> >   	bool
> >   	default y if SYSFS
> > +config PWM_DEBUG
> > +	bool "Additional checks for correctness of lowlevel drivers"
> 
> I am not native speaker too but this sounds weird to me. And as
> a driver author I would maybe like to see the word "debug" somewhere
> in the prompt for this option so its purpose is more obvious?
> 
> What about something like "PWM lowlevel drivers debugging" or
> "PWM lowlevel drivers additional checks and debug messages" ?

Yeah, also a depend on DEBUG_KERNEL is probably sensible, similar to
what DEBUG_GPIO does.

> > +	help
> > +	  This option enables some additional checks to help lowlevel driver
> > +	  authors to get their callbacks implemented correctly.
> > +	  It is expected to introduce some runtime overhead and diagnostic
> > +	  output to the kernel log, so only enable while working on a driver.
> > +
> >   config PWM_AB8500
> >   	tristate "AB8500 PWM support"
> >   	depends on AB8500_CORE && ARCH_U8500
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 8edfac17364e..6ce341a4574d 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -467,12 +467,68 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
> >   		return 0;
> >   	if (pwm->chip->ops->apply) {
> > +		struct pwm_state state_pre = *state;
> > +
> >   		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
> >   		if (err)
> >   			return err;
> > +		if (IS_ENABLED(CONFIG_PWM_DEBUG)) {
> > +			if (pwm->chip->ops->get_state) {
> > +				struct pwm_state state_post = { 0, };
> > +
> > +				pwm->chip->ops->get_state(pwm->chip, pwm, &state_post);
> > +
> > +				if (state_post.period != state->period ||
> > +				    state_post.duty_cycle != state->duty_cycle ||
> > +				    state_post.polarity != state->polarity ||
> > +				    state_post.enabled != state->enabled) {
> > +
> > +					dev_warn(pwm->chip->dev,
> > +						 ".apply is supposed to modify the pwm_state parameter to match the actual output.\n");
> 
> I tend to turn the warning messages around to more emphasize there
> is something wrong in the driver. Maybe something like:
> 						"pwm_state parameter does not match actual output! Update .apply to modify the state please.\n"

BTW: Before making the expectation on .apply to modify the state
parameter official, I wonder if this is sensible. Most of the time the
consumer doesn't seem to care. And providing the actual implemented
parameters is some extra effort.

I think it is more sensible to let lowlevel drivers not modify the state
argument and change the PWM core instead to call .get_state() in
pwm_get_state. (And maybe cache the result for later calls.)

Also in general it would probably be helpful to put some details about
the configured state in the debug warnings to make them more helpful in
case they are just forwarded to the PWM list.

> > +				}
> > +
> > +				if (state_pre.polarity == state_post.polarity &&
> > +				    state_pre.enabled &&
> > +				    (state_pre.period > state_post.period ||
> > +				     state_pre.duty_cycle > state_post.period)) {
> > +
> > +					dev_warn(pwm->chip->dev,
> > +						 ".apply is supposed to round down both period and duty_cycle.\n");
> 
> And here something like:
> 						 "period or duty_cycle is not rounded down. Update .apply to do so please.\n"

fine.

> > +
> > +				}
> > +
> > +				*state = state_post;
> > +
> > +				/* reapply state_post and check it is unmodified */
> > +				err = pwm->chip->ops->apply(pwm->chip, pwm, state);
> 
> Here you reapply even if the pre and post states match.

Yeah, I don't think optimizing the debug code is a critical thing to do
:-)

> On imx6 that means you just wrote to the PWM_PWMPR register.
> Such write "results in the counter being reset to zero and the start of
> a new count period." viz 51.7.5 in the RM.
> 
> That means the current period most probably was not completed when you
> applied the new configuration. Which is one of the requirements we are
> finally trying to met.
> 
> Hmm, now while I just finished the above paragraph I think the answer
> to this is that it is responsibility of the PWM driver to ensure such
> requirement is met. So that is just another opportunity how to improve
> the pwm-imx27 driver .)

Yeah, I thought a bit about how this could be catched by core debug
code, but this isn't trivial. I think the condition is:

If the configured output is actually changed by a call to .apply() the
callback must not return earlier that $oldperiod after the previous
.apply() was entered.

This is definitively something I want to have checked, but I postponed
that to later.

> [...]
> 
> While testing the patch I tried to configure some extreme values
> and got quite strange results.
> 
> The best resolution of the i.MX6 PWM is ~15ns.
> 
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 1000 > period
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 45 > duty_cycle
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [352446.858141] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
> 30
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 30 > duty_cycle
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
> 30
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 15 > duty_cycle
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [352511.598175] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
> 0
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 30 > duty_cycle
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [352538.138203] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
> 15

Oh wow, so the result of configuring duty_cycle = 30ns depends on the
previous state.

> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 45 > duty_cycle
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [352559.248184] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
> 30
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 60 > duty_cycle
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [353811.638114] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
> 45
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 75 > duty_cycle
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# [353819.718146] pwm-imx27 2080000.pwm: .apply is supposed to modify the pwm_state parameter to match the actual output.
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
> 61
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# echo 76 > duty_cycle
> root@hydraco:/sys/class/pwm/pwmchip0/pwm0# cat duty_cycle
> 76
> 
> So the driver refuses to configure a certain duty_cycle value, e.g. 30,
> but it happily configures it when you try the next higher one, e.g. 45.
> I suppose it is related to rounding in the pwm-imx27 driver but I did
> spent much time thinking about the root cause yet, sorry.
> 
> Anyway, your patch already prove to be useful ;)

\o/

Best regards and thanks for your feedback,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
