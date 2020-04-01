Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 850B819A727
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Apr 2020 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgDAIWe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Apr 2020 04:22:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33543 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDAIWd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Apr 2020 04:22:33 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jJYdo-0007pE-MB; Wed, 01 Apr 2020 10:22:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jJYdn-0000Pf-AB; Wed, 01 Apr 2020 10:22:27 +0200
Date:   Wed, 1 Apr 2020 10:22:27 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200401082227.sxtarbttsmmhs2of@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <20200330191654.waoocllctanh5nk5@pengutronix.de>
 <20200331204559.GB2954599@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200331204559.GB2954599@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Tue, Mar 31, 2020 at 10:45:59PM +0200, Thierry Reding wrote:
> On Mon, Mar 30, 2020 at 09:16:54PM +0200, Uwe Kleine-König wrote:
> > On Mon, Mar 30, 2020 at 04:14:36PM +0200, Thierry Reding wrote:
> > > On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-König wrote:
> > > > On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> > > > > Only the Timer control register(TCLR) cannot be updated when the timer
> > > > > is running. Registers like Counter register(TCRR), loader register(TLDR),
> > > > > match register(TMAR) can be updated when the counter is running. Since
> > > > > TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> > > > > timer for period/duty_cycle update.
> > > > 
> > > > I'm not sure what is sensible here. Stopping the PWM for a short period
> > > > is bad, but maybe emitting a wrong period isn't better. You can however
> > > > optimise it if only one of period or duty_cycle changes.
> > > > 
> > > > @Thierry, what is your position here? I tend to say a short stop is
> > > > preferable.
> > > 
> > > It's not clear to me from the above description how exactly the device
> > > behaves, but I suspect that it may latch the values in those registers
> > > and only update the actual signal output once a period has finished. I
> > > know of a couple of other devices that do that, so it wouldn't be
> > > surprising.
> > > 
> > > Even if that was not the case, I think this is just the kind of thing
> > > that we have to live with. Sometimes it just isn't possible to have all
> > > supported devices adhere strictly to an API. So I think the best we can
> > > do is have an API that loosely defines what's supposed to happen and
> > > make a best effort to implement those semantics. If a device deviates
> > > slightly from those expectations, we can always cross fingers and hope
> > > that things still work. And it looks like they are.
> > > 
> > > So I think if Lokesh and Tony agree that this is the right thing to do
> > > and have verified that things still work after this, that's about as
> > > good as it's going to get.
> > 
> > I'd say this isn't for the platform people to decide. My position here
> > is that the PWM drivers should behave as uniform as possible to minimize
> > surprises for consumers. And so it's a "PWM decision" that is to be made
> > here, not an "omap decision".
> 
> I think there's a fine line to be walked here. I agree that we should
> aim to have as much consistency between drivers as possible. At the same
> time I think we need to be pragmatic. As Lokesh said, the particular use
> case here requires this type of on-the-fly adjustment of the PWM period
> without stopping and restarting the PWM. It doesn't work otherwise. So
> th alternative that you're proposing is to say that we don't support
> that use-case, even though it works just fine given this particular
> hardware. That's not really an option.

I understand your opinion here. The situation now is that in current
mainline the driver stops the hardware for reconfiguration and it
doesn't fit Lokesh's use case so he changed to on-the-fly update
(accepting that maybe a wrong period is emitted). What if someone relies
on the old behaviour? What if in a year someone comes and claims the
wrong period is bad for their usecase and changes back to
stop-to-update?

When I write a consumer driver, do I have a chance to know how the PWM,
that I happen to use, behaves? To be able to get my consumer driver
reliable I might need to know that however.

> > > I know this is perhaps cheating a little, or turning a blind eye, but I
> > > don't know what the alternative would be. Do we want to tell people that
> > > a given PWM controller can't be used if it doesn't work according to our
> > > expectations? That's hard to argue if that controller works just fine
> > > for all known use-cases.
> > 
> > I'd like have some official policy here which of the alternatives is the
> > preferred cheat.
> > 
> > The situation here is that period and duty_cycle cannot be updated
> > atomically. So the two options are:
> > 
> >  - stop shortly
> >  - update with hardware running and maybe emit a broken period
> 
> I think we can already support both of those with the existing API. If
> a consumer wants to stop the PWM while reconfiguring, they should be
> able to do pwm_enable(), pwm_config(), pwm_enable() (or the atomic
> equivalent) and for the second case they can just do pwm_config() (or
> the atomic equivalent).

Yes, the consumer can force the stop and update. But assume I'm "only" a
consumer driver author and I want: atomic update and if this is not
possible I prefer "stop-to-update" over "on-the-fly-and-maybe-faulty".
So I cannot benefit from a good driver/hardware that can do atomic
updates? Or I have to patch each driver that I actually use to use
stop-to-update?

> Some hardware may actually require the PWM to be disabled before
> reconfiguring, so they won't be able to strictly adhere to the second
> use-case.
> 
> But as discussed above, I don't want to strive for a lowest common
> denominator that would preclude some more specific use-cases from
> working if the hardware supports it.
> 
> So I think we should aim for drivers to implement the semantics as
> closely as possible. If the hardware doesn't support some of these
> requirements strictly while a particular use-case depends on that, then
> that just means that the hardware isn't compatible with that use-case.
> Chances are that the system just isn't going to be designed to support
> that use-case in the first place if the hardware can't do it.
> 
> The sysfs interface is a bit of a special case here because it isn't
> possible to know what use-cases people are going to come up with.

In my eyes the sysfs interface isn't special here. You also don't know
what the OMAP PWM hardware is used for.

> It's most likely that they'll try something and if it doesn't work
> they can see if a driver patch can improve things.

So either the group who prefers "stop-to-update" or the group who
prefers "on-the-fly-and-maybe-faulty" has to carry a system specific
driver patch?

> One possible extension that I can imagine would be to introduce some
> sort of capability structure that drivers can fill in to describe the
> behaviour of the hardware. Drivers like pwm-omap-dmtimer, for example,
> could describe that they are able to change the period and/or duty cycle
> while the PWM is on. There could be another capability bit that says
> that the current period will finish before new settings are applied. Yet
> another capability could describe that duty-cycle and period can be
> applied atomically. Consumers could then check those capabilities to see
> if they match their requirements.
> 
> But then again, I think that would just make things overly complicated.
> None of the existing consumers need that, so it doesn't seem like there
> is much demand for that feature. In practice I suspect most consumers
> work fine despite potentially small deviations in how the PWM behaves.

I think the status quo is what I asked about above: People use sysfs and
if the PWM behaves different than needed, the driver is patched and most
of the time not mainlined. If your focus is to support a certain
industrial system with a defined use case, this is fine. If however you
target for an universal framework that works for any combination of
consumer + lowlevel driver without patching (that at least is able to
diagnose: This PWM cannot provide what my consumer needs), this is bad.
Also this means that whenever a system designer changes something on
their machine (kernel update, different hardware, an new usecase for a
PWM) they might have to reverify if the given PWM driver behaves as
needed.

My suggestion for now is to start documenting how the drivers behave
expanding how limitations are documented in some drivers. So maybe
change from "Limitations" to "Implementation and Hardware Details"?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
