Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEFA182673
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 01:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbgCLA6y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 20:58:54 -0400
Received: from muru.com ([72.249.23.125]:59826 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387411AbgCLA6x (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 11 Mar 2020 20:58:53 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4E4C780CD;
        Thu, 12 Mar 2020 00:59:38 +0000 (UTC)
Date:   Wed, 11 Mar 2020 17:58:49 -0700
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
Message-ID: <20200312005849.GY37466@atomide.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-5-lokeshvutla@ti.com>
 <20200306181443.GJ37466@atomide.com>
 <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
 <20200309180123.GP37466@atomide.com>
 <666dbb7a-db98-d16a-ee73-27d353d2a317@ti.com>
 <20200310155242.GT37466@atomide.com>
 <296e28b7-7925-5dfa-ce5a-c0b2a2f1c2e0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296e28b7-7925-5dfa-ce5a-c0b2a2f1c2e0@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200311 04:14]:
> 
> 
> On 10/03/20 9:22 PM, Tony Lindgren wrote:
> > * Lokesh Vutla <lokeshvutla@ti.com> [200310 07:06]:
> >> Hi Tony,
> >>
> >> [...snip...]
> >>
> >>>>>>  
> >>>>>> +	/*
> >>>>>> +	 * Disable auto reload so that the current cycle gets completed and
> >>>>>> +	 * then the counter stops.
> >>>>>> +	 */
> >>>>>>  	mutex_lock(&omap->mutex);
> >>>>>> -	omap->pdata->stop(omap->dm_timer);
> >>>>>> +	omap->pdata->set_pwm(omap->dm_timer,
> >>>>>> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> >>>>>> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
> >>>>>> +			     false);
> >>>>>> +
> >>>>>>  	mutex_unlock(&omap->mutex);
> >>>>>>  }
> >>>>>
> >>>>> I'm seeing an issue with this patch where after use something is
> >>>>> left on and power consumption stays higher by about 30 mW after
> >>>>> use.
> >>>>
> >>>> Interesting...What is the PWM period and duty cycle in the test case?
> >>>> Can you dump the following registers before and after disabling:
> >>>> - TLDR
> >>>> - TMAR
> >>>> - TCLR
> >>>
> >>> Here's the state dumped before and after in omap_dm_timer_set_pwm():
> >>>
> >>> omap_timer 4803e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00000040
> >>> omap_timer 4803e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001842
> >>> omap_timer 4013e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00000040
> >>> omap_timer 4013e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001842
> >>> omap_timer 4013e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00001843
> >>> omap_timer 4013e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001841
> >>> omap_timer 4803e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00001843
> >>> omap_timer 4803e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001841
> >>>
> >>
> >> Looking at the registers:
> >> period = 327 *(1000/clk_freq in MHz) ns
> >> duty_cycle =  perioid.
> >>
> >> I did simulate this behavior on BeagleBoneBlack on timer7. PWM is going down
> >> after disabling.
> >>
> >>> So looks like the start bit is still enabled after use?
> >>
> >> Right, that is expected. The start bit gets disabled automatically once the pwm
> >> period completes. This is because auto reload bit is off. That's the main idea
> >> of this patch so that PWM period is completed after disabling, else PWM is
> >> stopped abruptly.
> > 
> > OK
> > 
> >> Not sure why it is not happening in your case. If you think it is not needed, I
> >> can drop this patch and add a limitation saying that PWM gets disabled
> >> immediately without completing the current cycle.
> > 
> > Could it be that we now have the cpu_pm notifier restore something
> > invalid after exiting idle that restarts the counter?
> 
> If that's the case, mis behavior should have happened without this patch as well.

Hmm but without this patch we stop the timer so enable bit is
cleared before we ever save context. I think now we can have
enable bit still on, save the context, and keep restoring the
enable bit that never has a chance to clear if we do this at
a fast enough rate.

> Is it possible for you to dump the registers when you are observing higher power
> consumption after the use?

Well they seem to be the same as in the dump above, here are the regs
dumped after use with chirping happening:

$ sudo rwmem 0x4803e000+0x60
0x4803e000 = 0x4fff1301
0x4803e004 = 0000000000
0x4803e008 = 0000000000
0x4803e00c = 0000000000
0x4803e010 = 0x0000000c
0x4803e014 = 0000000000
0x4803e018 = 0000000000
0x4803e01c = 0000000000
0x4803e020 = 0000000000
0x4803e024 = 0x00000003
0x4803e028 = 0000000000
0x4803e02c = 0000000000
0x4803e030 = 0000000000
0x4803e034 = 0000000000
0x4803e038 = 0x00001841
0x4803e03c = 0x00000402
0x4803e040 = 0xfffffeb8
0x4803e044 = 0xffffffff
0x4803e048 = 0000000000
0x4803e04c = 0xfffffffe
0x4803e050 = 0000000000
0x4803e054 = 0000000000
0x4803e058 = 0000000000
0x4803e05c = 0000000000

$ sudo rwmem 0x4013e000+0x60
0x4013e000 = 0x4fff0301
0x4013e004 = 0000000000
0x4013e008 = 0000000000
0x4013e00c = 0000000000
0x4013e010 = 0000000000
0x4013e014 = 0000000000
0x4013e018 = 0000000000
0x4013e01c = 0000000000
0x4013e020 = 0000000000
0x4013e024 = 0x00000003
0x4013e028 = 0000000000
0x4013e02c = 0000000000
0x4013e030 = 0000000000
0x4013e034 = 0000000000
0x4013e038 = 0x00001841
0x4013e03c = 0x00000407
0x4013e040 = 0xfffffeb8
0x4013e044 = 0xffffffff
0x4013e048 = 0000000000
0x4013e04c = 0xfffffffe
0x4013e050 = 0000000000
0x4013e054 = 0000000000
0x4013e058 = 0000000000
0x4013e05c = 0000000000

So looks like the enable bit is never cleared now.

> However, I see an issue with the patch itself as pm_runtime is not disabled
> after the pwm is stopped. Not sure how that could be nullified with this approach.

Hmm yeah not sure what could be used to clear things
when the current cycle is completed unless there's
some interrupt for it.

Regards,

Tony

