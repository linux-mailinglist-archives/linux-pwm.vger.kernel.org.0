Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB4217E63B
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 19:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgCISB2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 14:01:28 -0400
Received: from muru.com ([72.249.23.125]:59418 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgCISB2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 9 Mar 2020 14:01:28 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A5E9C80FA;
        Mon,  9 Mar 2020 18:02:12 +0000 (UTC)
Date:   Mon, 9 Mar 2020 11:01:23 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 4/6] pwm: omap-dmtimer: Fix pwm disabling sequence
Message-ID: <20200309180123.GP37466@atomide.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-5-lokeshvutla@ti.com>
 <20200306181443.GJ37466@atomide.com>
 <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200309 04:53]:
> Hi Tony,
> 
> On 06/03/20 11:44 PM, Tony Lindgren wrote:
> > * Lokesh Vutla <lokeshvutla@ti.com> [200228 09:58]:
> >> pwm_omap_dmtimer_disable() calls .stop callback which abruptly stops the
> >> timer counter. This doesn't complete the current pwm cycle and
> >> immediately disables the pwm. Instead disable the auto reload
> >> functionality which allows to complete the current pwm cycle and then
> >> disables the timer.
> >>
> >> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >> ---
> >>  drivers/pwm/pwm-omap-dmtimer.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> >> index bc338619232d..89b3c25d02b8 100644
> >> --- a/drivers/pwm/pwm-omap-dmtimer.c
> >> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> >> @@ -93,8 +93,16 @@ static void pwm_omap_dmtimer_disable(struct pwm_chip *chip,
> >>  {
> >>  	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
> >>  
> >> +	/*
> >> +	 * Disable auto reload so that the current cycle gets completed and
> >> +	 * then the counter stops.
> >> +	 */
> >>  	mutex_lock(&omap->mutex);
> >> -	omap->pdata->stop(omap->dm_timer);
> >> +	omap->pdata->set_pwm(omap->dm_timer,
> >> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> >> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
> >> +			     false);
> >> +
> >>  	mutex_unlock(&omap->mutex);
> >>  }
> > 
> > I'm seeing an issue with this patch where after use something is
> > left on and power consumption stays higher by about 30 mW after
> > use.
> 
> Interesting...What is the PWM period and duty cycle in the test case?
> Can you dump the following registers before and after disabling:
> - TLDR
> - TMAR
> - TCLR

Here's the state dumped before and after in omap_dm_timer_set_pwm():

omap_timer 4803e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00000040
omap_timer 4803e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001842
omap_timer 4013e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00000040
omap_timer 4013e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001842
omap_timer 4013e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00001843
omap_timer 4013e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001841
omap_timer 4803e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00001843
omap_timer 4803e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001841

So looks like the start bit is still enabled after use?

I think the duty cycle depends on the strength set for rumble-test.c.

> > I can reproduce this easily on droid4 with Sebastian's rumble-test
> > app[0]. After use, I sometimes also hear the vibrator keep chirping
> > quietly, so there seems to be some pwm still happening after disable :)
> 
> hmm..The line clearly goes down on the scope after the current pwm duty cycle is
> done and never comes back.

OK

Regards,

Tony
