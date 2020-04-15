Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A41AA9C4
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2020 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636577AbgDOOTN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Apr 2020 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636572AbgDOOTK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Apr 2020 10:19:10 -0400
X-Greylist: delayed 104073 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 07:19:10 PDT
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CD5C061A0E
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2020 07:19:10 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOisT-0008Kf-GZ; Wed, 15 Apr 2020 16:18:57 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOisS-0008E9-SS; Wed, 15 Apr 2020 16:18:56 +0200
Date:   Wed, 15 Apr 2020 16:18:56 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bibek Basu <bbasu@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
Message-ID: <20200415141856.ck3w3gtae4bsxyfl@pengutronix.de>
References: <1585917303-10573-1-git-send-email-spatra@nvidia.com>
 <20200403151050.nh2mrffkqdqtkozq@pengutronix.de>
 <BYAPR12MB3014C0178A7360662C6FA8B7ADDB0@BYAPR12MB3014.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR12MB3014C0178A7360662C6FA8B7ADDB0@BYAPR12MB3014.namprd12.prod.outlook.com>
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

On Wed, Apr 15, 2020 at 09:03:35AM +0000, Sandipan Patra wrote:
> Thank you Uwe for reviewing the changes.
> And sorry for the delay in my response.

No problem, I didn't held my breath :-)

> > -----Original Message-----
> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Sent: Friday, April 3, 2020 8:41 PM
> > To: Sandipan Patra <spatra@nvidia.com>
> > Cc: Thierry Reding <treding@nvidia.com>; robh+dt@kernel.org; Jonathan
> > Hunter <jonathanh@nvidia.com>; Bibek Basu <bbasu@nvidia.com>; Laxman
> > Dewangan <ldewangan@nvidia.com>; linux-pwm@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] pwm: tegra: dynamic clk freq configuration by PWM driver
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Fri, Apr 03, 2020 at 06:05:03PM +0530, Sandipan Patra wrote:
> > > Added support for dynamic clock freq configuration in pwm kernel driver.
> > > Earlier the pwm driver used to cache boot time clock rate by pwm clock
> > > parent during probe. Hence dynamically changing pwm frequency was not
> > > possible for all the possible ranges. With this change, dynamic
> > > calculation is enabled and it is able to set the requested period from
> > > sysfs knob provided the value is supported by clock source.
> > 
> > Without having looked closely at the patch (yet), just for my
> > understanding: If the PWM is running and the frequency changes, the output
> > changes, too, right? If so, do we need a notifier that prevents a frequency
> > change when the PWM is running?
> 
> Yes, frequency can be changed anytime but by the same process who has 
> acquired the channel. So if a process is already running/using the channel,
> same process can only modify the frequency.

How is this enforced? Does some other peripheral get its input clock
from the clock in question? What is the motivation to modify the
frequency other than modifying the PWM output?
 
> > And slightly orthogonal to this patch: The tegra driver needs some love to make
> > it use the atomic callback .apply() instead of
> > .config()/.enable()/.disable() and a .get_state() implementation.
> 
> Understood to upgrade pwm-tegra driver with using .apply()
> I will work on this with a new change request soon.

That's great (but still not holding my breath :-)

> > > Changes mainly have 2 parts:
> > >   - T186 and later chips [1]
> > >   - T210 and prior chips [2]
> > >
> > > For [1] - Changes implemented to set pwm period dynamically and
> > >           also checks added to allow only if requested period(ns) is
> > >           below or equals to higher range.
> > >
> > > For [2] - Only checks if the requested period(ns) is below or equals
> > >           to higher range defined by max clock limit. The limitation
> > >           in T210 or prior chips are due to the reason of having only
> > >           one pwm-controller supporting multiple channels. But later
> > >           chips have multiple pwm controller instances each having
> > >         single channel support.
> > >
> > > Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> > > ---
> > >  drivers/pwm/pwm-tegra.c | 45
> > > +++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 43 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c index
> > > aa12fb3..d3ba33c 100644
> > > --- a/drivers/pwm/pwm-tegra.c
> > > +++ b/drivers/pwm/pwm-tegra.c
> > > @@ -4,7 +4,7 @@
> > >   *
> > >   * Tegra pulse-width-modulation controller driver
> > >   *
> > > - * Copyright (c) 2010, NVIDIA Corporation.
> > > + * Copyright (c) 2010-2020, NVIDIA Corporation.
> > >   * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.de>
> > >   */
> > >
> > > @@ -83,10 +83,51 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > >       val = (u32)c << PWM_DUTY_SHIFT;
> > >
> > >       /*
> > > +      * Its okay to ignore the fraction part since we will be trying to set
> > > +      * slightly lower value to rate than the actual required rate
> > 
> > s/actual/actually/
> 
> Noted. I will update in the follow up patch.

Just spotted: s/Its/It's/

> > > +     /*
> > > +      *  Period in nano second has to be <= highest allowed period
> > > +      *  based on the max clock rate of the pwm controller.
> > > +      *
> > > +      *  higher limit = max clock limit >> PWM_DUTY_WIDTH
> > > +      */
> > > +     if (rate > (pc->soc->max_frequency >> PWM_DUTY_WIDTH))
> > > +             return -EINVAL;
> > 
> > Related to my question above: What happens if the rate increases after this
> > check?
> 
> Discussed above with my understanding. Please help me understand if 
> you are referring to any other possibilities that rate can be changed. 

The goal to reach is: The only way to modify the PWM output should be to call
pwm_apply_state() (or its legacy relatives).

> > Also the division above is just done to compare the requested period value with
> > the allowed range.
> > 
> > Your check is:
> > 
> >         NSEC_PER_SEC / period_ns > (max_frequency >> PWM_DUTY_WIDTH)
> > 
> > This is equivalent to
> > 
> >         period_ns <= NSEC_PER_SEC / (max_frequency >> PWM_DUTY_WIDTH)
> > 
> > where the right side is constant per PWM type. (Rounding might need
> > addressing.)
> 
> I will update this calculation in the probe since max_frequency value is
> Different for each chip. Also please note that at this point the rate is not
> the actual pwm output rate. It's just a reference for what should be the
> source clock rate and then requested with clk_set_rate();
> Actual rounding is required while setting pwm controller output rate is
> done later down in same function. 

I think I understood. Will check again in your next patch round.

> > > +              * clk_set_rate() can not be called again in config because
> > > +              * T210 or any prior chip supports one pwm-controller and
> > > +              * multiple channels. Hence in this case cached clock rate
> > > +              * will be considered which was stored during probe.
> > 
> > I don't understand that. If
> 
> The if part is for SoCs which have single channel per pwm instance. i.e. T186, 
> T194 etc. For controllers with single channel, dynamic clock rate configuration
> is possible. The other part is for legacy controller which has multiple channels
> for single pwm instance. The pwm controllers having multiple channels share
> the source clock. So it does not allow dynamic clock configuration since it
> will affect users on the other channels.

The usual approach here is to allow changes iff all other channels are
off or unused.

> > > +              */
> > > +             rate = pc->clk_rate >> PWM_DUTY_WIDTH;
> > > +     }
> > >
> > >       /* Consider precision in PWM_SCALE_WIDTH rate calculation */
> > >       hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
> > 
> > I took a deeper look into the driver now. Just to ensure, I understood the PWMs
> > behaviour right:
> > 
> > There is an ENABLE bit (with obvious semantics), a 13-bit SCALE value and an 8-
> > bit DUTY value. There is an internal counter incrementing by one each (SCALE +
> > 1) clock cycles and resets at 256. The counter going from 0 to 256 defines the
> > period length. On counter reset the output gets active and on reaching DUTY the
> > output gets inactive.
> > 
> > So we have:
> > 
> >         .period = 256 * (SCALE + 1) / clkrate
> >         .duty_cycle = DUTY * (SCALE + 1) / clkrate
> > 
> > Right?
> 
> Yes. Right.

Ideally this would be described in a code comment.

> >  - When .duty_ns == .period the assignment of DUTY overflows.
> >    (Can the PWM provide 100% duty cycle at all?)
> 
> Yes, PWM controller is capable to provide 100% duty cycle.
> Bits 30:16 are dedicated for pulse width out of which only 24:16 (9 bits)
> are used. Only 8 bits are usable [23:16] for varying pulse width.
> To achieve 100% duty cycle, Bit [24] needs to be programmed of this
> register to 1'b1.

This needs to be documented in a driver comment to be understandable for
people being interested in this driver later.

If Bit[24] is 1, should [23:16] be zero, or is it "don't care" then?

> >  - The comment "Since the actual PWM divider is the register's frequency
> >    divider field minus 1, we need to decrement to get the correct value
> >    to write to the register." seems wrong. If I understand correctly, we
> >    need to do s/minus/plus/. If the register holds a 0, the divider
> >    isn't -1 for sure?!
> 
> Yes, you are right. The comment needs a correction. It will be plus 1 
> instead of minus 1. I will update the comment in the follow up patch.
> Otherwise the calculation is correct.
> rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
> here rate is the divider value to be set.

If a certain duty+period is requested the driver is supposed to provide
an output such that:

	implemented_period = max{ possible periods <= requested period }
	implemented_duty = max{ possible duty <= requested duty }

so I think DIV_ROUND_CLOSEST_ULL is wrong.
(If the driver provided the modern callback instead of
.config/.enable/.disable CONFIG_PWM_DEBUG would help you here.)
 
> > How does the PWM behave when it gets disabled? Does it complete the
> > currently running period? Does the output stop at the inactive level, or where it
> > just happens to be? How does a running PWM behave when the register is
> > updated? Does it complete the currently running period?
>
> Yes, it allows to write the bit during any active and inactive time of the
> width. Hence the pwm gets disabled as soon as the enable bit is set to 0.

OK, so the output stops oscillating as soon as the PWM_ENABLE bit is
cleared in hardware. How does the output behave then? (Does the output
become inactive? Or does it drive the output level where it just happens
to be?) I assume that the register write in tegra_pwm_config() also
results in aborting the currently running period and start of a new one
with the new settings?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
