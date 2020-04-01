Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEEB19B6FF
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Apr 2020 22:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbgDAUcF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Apr 2020 16:32:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45971 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAUcD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Apr 2020 16:32:03 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jJk1m-0008RE-83; Wed, 01 Apr 2020 22:31:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jJk1l-0000ae-0p; Wed, 01 Apr 2020 22:31:57 +0200
Date:   Wed, 1 Apr 2020 22:31:56 +0200
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
Message-ID: <20200401203156.d7x5ynnnhob3jyoo@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <20200330191654.waoocllctanh5nk5@pengutronix.de>
 <20200331204559.GB2954599@ulmo>
 <20200401082227.sxtarbttsmmhs2of@pengutronix.de>
 <20200401182833.GB2978178@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200401182833.GB2978178@ulmo>
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

On Wed, Apr 01, 2020 at 08:28:33PM +0200, Thierry Reding wrote:
> On Wed, Apr 01, 2020 at 10:22:27AM +0200, Uwe Kleine-König wrote:
> > On Tue, Mar 31, 2020 at 10:45:59PM +0200, Thierry Reding wrote:
> > > I think there's a fine line to be walked here. I agree that we should
> > > aim to have as much consistency between drivers as possible. At the same
> > > time I think we need to be pragmatic. As Lokesh said, the particular use
> > > case here requires this type of on-the-fly adjustment of the PWM period
> > > without stopping and restarting the PWM. It doesn't work otherwise. So
> > > th alternative that you're proposing is to say that we don't support
> > > that use-case, even though it works just fine given this particular
> > > hardware. That's not really an option.
> > 
> > I understand your opinion here. The situation now is that in current
> > mainline the driver stops the hardware for reconfiguration and it
> > doesn't fit Lokesh's use case so he changed to on-the-fly update
> > (accepting that maybe a wrong period is emitted). What if someone relies
> > on the old behaviour? What if in a year someone comes and claims the
> > wrong period is bad for their usecase and changes back to
> > stop-to-update?
> 
> Relying on that old behaviour is wrong.  If you really need to rely on
> the PWM being stopped before reconfiguration, then you should
> explicitly request that by first disabling the PWM, then reconfiguring
> it and then reenabling it.

You got me wrong here. See below.

> > When I write a consumer driver, do I have a chance to know how the PWM,
> > that I happen to use, behaves? To be able to get my consumer driver
> > reliable I might need to know that however.
> 
> No, there's currently no way of knowing. As such, I think the most
> sensible thing to do at this point is to work with the API in order to
> get the behaviour that you want.

I want to switch from (duty_cycle, period) = (d1, p1) to
(duty_cycle, period) = (d2, p2) without seeing (d1, p2) or (d2, p1) on
the wire. How do I do this with Lokesh's patch applied?

In my eyes this is something sensible to rely on. I agree that relying
on a stop implemented by the driver is broken, but not wanting to seeing
a (d1, p2) is sane.

> Now if you're unlucky the driver won't support that and you'll notice
> eventually. But there's also nothing you can do about that if the
> hardware doesn't work that way. Even if the PWM framework had a way of
> querying these types of peculiarities it wouldn't really proved much of
> an advantage since the driver would just refuse to probe rather than
> attempting to do this and maybe succeeding because you got lucky.

It depends on the use case. If it's about a display that then has no
backlight the damage is limited. If however I drive a step motor that
rotates a laser some unexpected behaviour that only happens once in
100000 cases and so isn't catched during development is quite bad.

> > > > > I know this is perhaps cheating a little, or turning a blind eye, but I
> > > > > don't know what the alternative would be. Do we want to tell people that
> > > > > a given PWM controller can't be used if it doesn't work according to our
> > > > > expectations? That's hard to argue if that controller works just fine
> > > > > for all known use-cases.
> > > > 
> > > > I'd like have some official policy here which of the alternatives is the
> > > > preferred cheat.
> > > > 
> > > > The situation here is that period and duty_cycle cannot be updated
> > > > atomically. So the two options are:
> > > > 
> > > >  - stop shortly
> > > >  - update with hardware running and maybe emit a broken period
> > > 
> > > I think we can already support both of those with the existing API. If
> > > a consumer wants to stop the PWM while reconfiguring, they should be
> > > able to do pwm_enable(), pwm_config(), pwm_enable() (or the atomic
> > > equivalent) and for the second case they can just do pwm_config() (or
> > > the atomic equivalent).
> > 
> > Yes, the consumer can force the stop and update. But assume I'm "only" a
> > consumer driver author and I want: atomic update and if this is not
> > possible I prefer "stop-to-update" over "on-the-fly-and-maybe-faulty".
> > So I cannot benefit from a good driver/hardware that can do atomic
> > updates? Or I have to patch each driver that I actually use to use
> > stop-to-update?
> 
> You could do what everybody does and just assume that atomic update
> works.

There are people out there that are more demanding. If you have 1000000
machines in the field and only then find out that they all fail to
operate correctly with a certain small but positive probability and you
have to send someone to each machine to fix that, that's bad.

> If it works with the particular PWM device/driver that you
> have that may be all you care about. Obviously that may not be true
> for a different chip.
> 
> On the other hand, if you absolutely must ensure that there must never
> be any glitches whatsoever but don't care whether the PWM goes through a
> disable/enable sequence, then doing so explicitly is going to be your
> best bet. From a consumer driver point of view it isn't going to matter
> because even if we had a way of distinguishing between these
> capabilities you'd still have to have code to deal with both.

There is a nice upside however: You have a good chance to notice this
problem before the 1000000 devices are shipped to production and then
escalate the problem and let the responsible people make an informed
choice.

> So the only relevant use-case here would be if you had a requirement to
> perform on-the-fly-and-strictly-correct updates. The API doesn't give
> those kinds of guarantees. So we would need an extension that consumers
> can query to determine whether what they want to do will work.
> 
> But like I said above, the chances that you will run into this are slim
> because use-cases are typically known ahead of time and devices are
> designed to be able to support them. So if you build a device that needs
> to support these strict requirements, then you need to make sure the
> hardware supports it, too. And when the hardware supports it, then the
> driver should implement ->config() or ->apply() in a way that allows
> this.

In my bubble that sometimes fails. The hardware is done and only then
someone notices that a certain case wasn't considered.

> > > Some hardware may actually require the PWM to be disabled before
> > > reconfiguring, so they won't be able to strictly adhere to the second
> > > use-case.
> > > 
> > > But as discussed above, I don't want to strive for a lowest common
> > > denominator that would preclude some more specific use-cases from
> > > working if the hardware supports it.
> > > 
> > > So I think we should aim for drivers to implement the semantics as
> > > closely as possible. If the hardware doesn't support some of these
> > > requirements strictly while a particular use-case depends on that, then
> > > that just means that the hardware isn't compatible with that use-case.
> > > Chances are that the system just isn't going to be designed to support
> > > that use-case in the first place if the hardware can't do it.
> > > 
> > > The sysfs interface is a bit of a special case here because it isn't
> > > possible to know what use-cases people are going to come up with.
> > 
> > In my eyes the sysfs interface isn't special here. You also don't know
> > what the OMAP PWM hardware is used for.
> 
> But platform designers will know what their device will be used for.

Right. But if you rely on the people chosing the components for the
platform to notice that the SoC's PWM has a glitch that is bad for the
use case I think that's naive.

> > > It's most likely that they'll try something and if it doesn't work
> > > they can see if a driver patch can improve things.
> > 
> > So either the group who prefers "stop-to-update" or the group who
> > prefers "on-the-fly-and-maybe-faulty" has to carry a system specific
> > driver patch?
> 
> No, the group that prefers "stop-to-update" should make that explicit
> and write a consumer driver that first disables, then reconfigured and
> then reenables the PWM.

Both groups prefer atomic updates, and just prefer different cluches if
atomic isn't possible. So doing an explicit stop is bad. Also I'd expect
the timing of a driver doing the stop is better than when the consumer
explicitly stops.

> If they don't *need* to update the PWM on the fly, then performing two
> additional steps that would be happening anyway won't matter, right?

I don't agree here. Moreover the consumer might be preempted between
stop and reconfiguration. (And you don't want to disable preemption over
a pwm-API calls as they might take quite some time assuming they block
until periods are completed.)

> > > One possible extension that I can imagine would be to introduce some
> > > sort of capability structure that drivers can fill in to describe the
> > > behaviour of the hardware. Drivers like pwm-omap-dmtimer, for example,
> > > could describe that they are able to change the period and/or duty cycle
> > > while the PWM is on. There could be another capability bit that says
> > > that the current period will finish before new settings are applied. Yet
> > > another capability could describe that duty-cycle and period can be
> > > applied atomically. Consumers could then check those capabilities to see
> > > if they match their requirements.
> > > 
> > > But then again, I think that would just make things overly complicated.
> > > None of the existing consumers need that, so it doesn't seem like there
> > > is much demand for that feature. In practice I suspect most consumers
> > > work fine despite potentially small deviations in how the PWM behaves.
> > 
> > I think the status quo is what I asked about above: People use sysfs and
> > if the PWM behaves different than needed, the driver is patched and most
> > of the time not mainlined. If your focus is to support a certain
> > industrial system with a defined use case, this is fine. If however you
> > target for an universal framework that works for any combination of
> > consumer + lowlevel driver without patching (that at least is able to
> > diagnose: This PWM cannot provide what my consumer needs), this is bad.
> 
> Again, my response to this is: how is this going to be beneficial? In
> practice the way that this would work is that the consumer driver would
> fail if presented with a PWM that doesn't meet the strict requirements.
> Now if the requirements really are that strict, then that sounds like a
> good idea.
> 
> But one issue I foresee with this is that we'll end up giving consumers
> too much of a toolkit to restrict things. What if the consumer driver
> author assumes wrongly that a given set of requirements exists?

If you want to catch usage errors you're doomed anyhow.

> What if for some combination of hardware that doesn't strictly conform
> to those requirements it might still work?

Then this is a bug that can be fixed. And it's a bug that is not in the
PWM framework's area, so we even don't really have to care.

> Sometimes you may not notice the difference, at other times there may
> be some impact like a visual glitch or so, but that may be something
> that users are willing to accept rather than not have support at all.

If laxer requirements are ok, they shouldn't request strict ones.

> > Also this means that whenever a system designer changes something on
> > their machine (kernel update, different hardware, an new usecase for a
> > PWM) they might have to reverify if the given PWM driver behaves as
> > needed.
> 
> I don't expect this type of change to happen very often.

Yeah, I also expect that most things don't break on such a change. But
Lokesh's patch is an example that justifies to be vigilant because the
implemented change in behaviour is a good one for Lokesh but might break
things for someone else. And I don't expect that the common test
coverage to be that good to catch the glitch during test.

> There's always going to be some type of fine-tuning before a driver's
> behaviour is completely stabilized. And then there could still always
> be other factors impacting behaviour that aren't even related to the
> PWM framework.

I think I don't get what you intend to say here. I understand "As
updating the kernel might make a PLL unstable, changing behaviour for
the PWM is fine."

> I suspect that most people will have an array of tests to validate that
> everything still works after a kernel update. Obviously we don't want a
> new kernel to behave completely differently, but we're not talking about
> that here. This is merely dropping a needless disable/enable from a
> configuration. If somebody was relying on this happening they were wrong
> to rely on it to begin with because the API does not guarantee it.
> 
> > My suggestion for now is to start documenting how the drivers behave
> > expanding how limitations are documented in some drivers. So maybe
> > change from "Limitations" to "Implementation and Hardware Details"?
> 
> Yes, collecting such information is always a good idea.

So Lokesh's patch should at least be amended to add something like

 * Limitations:
 * - When changing both duty cycle and period, we cannot prevent in
 *   software that the output might produce a period with mixed
 *   settings (new period length and old duty cycle) without stopping
 *   the hardware.

at the top of the driver.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
