Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BB9170480
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgBZQfo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 11:35:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51987 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgBZQfn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 11:35:43 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6zes-0006KP-Qq; Wed, 26 Feb 2020 17:35:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6zer-0001iD-NE; Wed, 26 Feb 2020 17:35:37 +0100
Date:   Wed, 26 Feb 2020 17:35:37 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, kernel@pengutronix.de
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200226163537.5shrqno6zy56t2l4@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-4-lokeshvutla@ti.com>
 <20200224085531.zab5ewr2nfi2shem@pengutronix.de>
 <4aedb6d4-1823-ab46-b7e6-cc0b30f7747d@ti.com>
 <20200225064833.kmvaplfqqf53s3iy@pengutronix.de>
 <8e22912c-a65f-9efe-27e7-555cd144776f@ti.com>
 <20200225083846.4l4tnbjcpm6uggtl@pengutronix.de>
 <4d830367-403a-5cf5-abf0-7daccbece1ae@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d830367-403a-5cf5-abf0-7daccbece1ae@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Feb 25, 2020 at 04:56:02PM +0530, Lokesh Vutla wrote:
> Hi Uwe,
> 
> On 25/02/20 2:08 PM, Uwe Kleine-König wrote:
> > Hello Lokesh,
> > 
> > On Tue, Feb 25, 2020 at 01:29:57PM +0530, Lokesh Vutla wrote:
> >> On 25/02/20 12:18 PM, Uwe Kleine-König wrote:
> >>> On Tue, Feb 25, 2020 at 10:32:42AM +0530, Lokesh Vutla wrote:
> >>>> On 24/02/20 2:25 PM, Uwe Kleine-König wrote:
> >>>>> On Mon, Feb 24, 2020 at 10:51:34AM +0530, Lokesh Vutla wrote:
> >>>>>>  	omap->pdata->set_load(omap->dm_timer, true, load_value);
> >>>>>>  	omap->pdata->set_match(omap->dm_timer, true, match_value);
> >>>>>
> >>>>> (Without having looked into the depths of the driver I assume
> >>>>> .set_load() sets the period of the PWM and .set_match() the duty cycle.)
> >>>>
> >>>> Right.
> >>>>
> >>>>>
> >>>>> What happens on a running PWM if you change the period? Consider you
> >>>>> change from duty_cycle = 1000, period = 5000 to duty_cycle = 4000,
> >>>>> period = 10000. As you set the period first, can it happen the hardware
> >>>>> produces a cycle with duty_cycle = 1000, period = 10000?
> >>>>
> >>>> No. So, the current cycle is un affected with duty_cycle = 1000 and period =
> >>>> 5000. Starting from next cycle new settings gets reflected with duty_cycle =
> >>>> 4000 and period = 10000.
> >>>
> >>> Is the reference manual for this hardware publically available?
> >>
> >> AM335x TRM [0] Section 20.1.3.5 Pulse-Width Modulation (Page 4445).
> >>
> >> [0] http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
> > 
> > Great. This is BTW an opportunity to increase your patch count: Create a
> > patch that adds a reference to this document at the top of the driver.
> > 
> >>> So the .set_load callback just writes a shadow register and .set_match
> >>> latches it into hardware atomically with its own register changes? A
> >>> comment in the source code about this would be good. Also if .set_load
> >>> doesn't work without .set_match I wonder if it is sane to put their
> >>> logic in two different functions.
> >>
> >> Just to give a little bit of background:
> > 
> > Thanks, very appreciated.
> > 
> >> - The omap timer is an upward counter that can be started and stopped at any time.
> >> - Once the timer counter overflows, it gets loaded with a predefined load
> >> value.(Or can be configured to not re load at all).
> >> - Timer has a configurable output pin which can be toggled in the following two
> >> cases:
> >> 	- When the counter overflows
> >> 	- When the counter matches with a predefined register(match register).
> >>
> >> Using this o/p pin the driver tries to generate a PWM with period = (OVERFLOW -
> >> LOAD_VALUE) and duty_cycle = (MATCH_VALUE - LOAD_VALUE).
> >>
> >> .set_load will configure the load value .set_match will configure the match
> >> value. The configured values gets effected only in the next cycle of PWM.
> > 
> > Ah, so back to my original question: If you change from
> > duty_cycle/period = 1000/5000 to duty_cycle/period = 4000/10000 and
> > after you set the period but before you set the duty_cycle a period
> > happens to end, you get indeed a cycle with mixed settings, right?
> 
> hmm..you are right but the mixed period happens in a bit different case. Let me
> explain in bit more detail.
> 
> For omap dm timer, the load_value that gets set in the current period, will be
> reflected only in next cycle, as timer counter has to overflow to load this
> value. But in case of match register(which determines the duty cycle), the timer
> counter is continuously matched to it. So below are the cases where a mixed
> period can happen:
> 1) When signal is high and new match value is > current timer counter. Then the
> duty cycle gets reflected in the current cycle.(Duty_cycle for current period=
> new match value -  previous load  value).
> 2) When signal is high and new match value is < current timer counter. Then the
> period and duty cycle for the current cycle gets effected as well. Because the
> signal is pulled down only when counter matches with match register, and this
> happens only in the next cycle(after timer counter overflows). Then:
> 	- new Period for current cycle = (current period + new period)
> 	- new duty cycle for current cycle =  (current period + new duty_cycle).
> 
> I am able to observe the above mentioned 2 behaviors on the scope using beagle
> bone black. So the problem is with updating duty cycle when the signal is high.
> but when signal is low, nothing gets effected to the current cycle.
> 
> How do you want to go about this? Should we describe this as limitation in the
> driver as you asked?

OK, to sumarize: You have a counter that goes up. When it overflows it
gets reloaded with the load value and the output goes up. When
$counter = $match, the output goes down.

Having this is a comment at the top of the driver would be very welcome.

(I just noticed I duplicated this question about a racy update in
another end of this thread. This pops in my head too automatically :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
