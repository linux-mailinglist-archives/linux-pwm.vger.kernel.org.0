Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A042170434
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBZQV7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 11:21:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41475 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZQV7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 11:21:59 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6zRa-0005Au-A1; Wed, 26 Feb 2020 17:21:54 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6zRZ-0001L4-HM; Wed, 26 Feb 2020 17:21:53 +0100
Date:   Wed, 26 Feb 2020 17:21:53 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: Implement .apply callback
Message-ID: <20200226162153.4vlx2z6wurpdy4az@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-5-lokeshvutla@ti.com>
 <20200224090706.xsujpc3yiqlmmrmm@pengutronix.de>
 <cee31e10-17b4-1cfb-5c77-a58a142c338d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cee31e10-17b4-1cfb-5c77-a58a142c338d@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Lokesh,

On Tue, Feb 25, 2020 at 10:31:45AM +0530, Lokesh Vutla wrote:
> Hi Uwe,
> 
> On 24/02/20 2:37 PM, Uwe Kleine-König wrote:
> > On Mon, Feb 24, 2020 at 10:51:35AM +0530, Lokesh Vutla wrote:
> >> Implement .apply callback and drop the legacy callbacks(enable, disable,
> >> config, set_polarity).
> >>
> >> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >> ---
> >>  drivers/pwm/pwm-omap-dmtimer.c | 141 +++++++++++++++++++--------------
> >>  1 file changed, 80 insertions(+), 61 deletions(-)
> >>
> 
> [..snip..]
> 
> >> -static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
> >> -					 struct pwm_device *pwm,
> >> -					 enum pwm_polarity polarity)
> >> +/**
> >> + * pwm_omap_dmtimer_apply() - Changes the state of the pwm omap dm timer.
> >> + * @chip:	Pointer to PWM controller
> >> + * @pwm:	Pointer to PWM channel
> >> + * @state:	New sate to apply
> >> + *
> >> + * Return 0 if successfully changed the state else appropriate error.
> >> + */
> >> +static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
> >> +				  struct pwm_device *pwm,
> >> +				  const struct pwm_state *state)
> >>  {
> >>  	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
> >> +	int ret = 0;
> >>  
> >> -	/*
> >> -	 * PWM core will not call set_polarity while PWM is enabled so it's
> >> -	 * safe to reconfigure the timer here without stopping it first.
> >> -	 */
> >>  	mutex_lock(&omap->mutex);
> >> -	omap->pdata->set_pwm(omap->dm_timer,
> >> -			     polarity == PWM_POLARITY_INVERSED,
> >> -			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> >> +
> >> +	if (pwm_is_enabled(pwm) && !state->enabled) {
> > 
> > In my book calling PWM API functions (designed for PWM consumers) is not
> > so nice. I would prefer you checking the hardware registers or cache the
> > state locally instead of relying on the core here.
> 
> .start and .stop apis does read the hardware registers and check the state
> before making any changes. Do you want to drop off the pwm_is_enabled(pwm) check
> here?

The IMHO more natural approach would be to look into the hardware
registers instead of asking the framework.

> > It would be great to have a general description at the top of the driver
> > (like for example drivers/pwm/pwm-sifive.c) that answers things like:
> > 
> >  - Does calling .stop completes the currently running period (it
> >    should)?
> 
> Existing driver implementation abruptly stops the cycle. I can make changes such
> that it completes the currently running period.

That would be good for correctness.

> >  - Does changing polarity, duty_cycle and period complete the running
> >    period?
> 
> - Polarity can be changed only when the pwm is not running. Ill add extra guards
> to reflect this behavior.
> - Changing duty_cycle and period does complete the running period and new values
> gets reflected in next cycle.

Is there are race with the hardware? I.e. can it happen that when a new
cycle starts just when you configured the new period but not the
duty_cycle yet a mixed cycle is output?

> >  - How does the hardware behave on disable? (i.e. does it output the
> >    state the pin is at in that moment? Does it go High-Z?)
> 
> Now that I am making changes to complete the current period on disable, the pin
> goes to Low after disabling(completing the cycle).
> 
> Ill add all these points as you mentioned in v2.

Great

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
