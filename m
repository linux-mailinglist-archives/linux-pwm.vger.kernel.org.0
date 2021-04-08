Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519983588DA
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Apr 2021 17:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhDHPvx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Apr 2021 11:51:53 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:48226 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231480AbhDHPvw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 8 Apr 2021 11:51:52 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 84BBCC725C9;
        Thu,  8 Apr 2021 17:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617897097;
        bh=AMEGjPMVXU6NF/ooieuKiCC18uHqlMYSC9N3lkrl9MM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1PPIiyvsqhvD1bpuv8rBI4rQCctG5p3a1WwUhIsXDdwQLxv0OmOZQjXKVoLbIJDO
         2SNK+iApJFZQJM8YAr4yQFhXoAvh3a/rWkpVeDXd4FnxSu2U9m7HsyD6k9R4TMxJjh
         rPJvrbsOWETnF9EsLnZ687iWVuiQMRP5rllDYw9U=
Date:   Thu, 8 Apr 2021 17:51:36 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <YG8miEOZXsH0NTcA@workstation.tuxnet>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
 <YG4UNoBCQJkEEfwi@workstation.tuxnet>
 <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
 <YG78IHIMGtl8Pokp@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG78IHIMGtl8Pokp@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 08, 2021 at 02:50:40PM +0200, Thierry Reding wrote:
> On Wed, Apr 07, 2021 at 11:34:03PM +0200, Uwe Kleine-König wrote:
> > On Wed, Apr 07, 2021 at 10:21:10PM +0200, Clemens Gruber wrote:
> > > On Wed, Apr 07, 2021 at 07:46:58AM +0200, Uwe Kleine-König wrote:
> > > > On Tue, Apr 06, 2021 at 06:41:37PM +0200, Clemens Gruber wrote:
> > > > > If the flag PWM_STAGGERING_ALLOWED is set on a channel, the PWM driver
> > > > > may (if supported by the HW) delay the ON time of the channel relative
> > > > > to the channel number.
> > > > > This does not alter the duty cycle ratio and is only relevant for PWM
> > > > > chips with less prescalers than channels, which would otherwise assert
> > > > > multiple or even all enabled channels at the same time.
> > > > > 
> > > > > If this feature is supported by the driver and the flag is set on
> > > > > multiple channels, their ON times are spread out to improve EMI and
> > > > > reduce current spikes.
> > > > 
> > > > As said in reply to patch 4/8 already: I don't like this idea and
> > > > think this should be made explicit using a new offset member in struct
> > > > pwm_state instead. That's because I think that the wave form a PWM
> > > > generates should be (completely) defined by the consumer and not by a
> > > > mix between consumer and device tree. Also the consumer has no (sane)
> > > > way to determine if staggering is in use or not.
> > > 
> > > I don't think offsets are ideal for this feature: It makes it more
> > > cumbersome for the user, because he has to allocate the offsets
> > > himself instead of a simple on/off switch.
> > > The envisioned usecase is: "I want better EMI behavior and don't care
> > > about the individual channels no longer being asserted at the exact same
> > > time".
> > 
> > The formal thing is: "I want better EMI behavior and don't care if
> > periods start with the active phase, it might be anywhere, even over a
> > period boundary." Being asserted at the exact same time is just a detail
> > for the pca9685.
> >  
> > > > One side effect (at least for the pca9685) is that when programming a
> > > > new duty cycle it takes a bit longer than without staggering until the
> > > > new setting is active. 
> > > 
> > > Yes, but it can be turned off if this is a problem, now even per-PWM.
> > 
> > Yes and that is a good thing. (BTW: I'd call it per-PWM-consumer, but
> > details.)
> > 
> > > > Another objection I have is that we already have some technical debt
> > > > because there are already two different types of drivers (.apply vs
> > > > .config+.set_polarity+.enable+.disable) and I would like to unify this
> > > > first before introducing new stuff.
> > > 
> > > But there is already PWM_POLARITY_INVERTED, which can be set in the DT.
> > > I am only adding another flag.
> > 
> > I understand your reasoning, and similar to "This diplay backlight needs
> > an inverted PWM (as a low duty-cycle results in a high brightness" this
> > semantic "This consumer doesn't care if the active cycle is anywhere in
> > the period". Hmm, maybe I just have to think about it a bit more to
> > become friends with that thought.
> 
> Yes, I think that's basically what this is saying. I think we're perhaps
> getting hung up on the terminology here. PWM_STAGGERING_ALLOWED gives
> the impression that we're dealing with some provider-specific feature,
> whereas what we really want to express is that the PWM doesn't care
> exactly when the active cycle starts and based on that a provider that
> can support it may optimize the EMI behavior.
> 
> Maybe we can find a better name for this? Ultimately what this means is
> that the consumer is primarily interested in the power output of the PWM
> rather than the exact shape of the signal. So perhaps something like
> PWM_USAGE_POWER would be more appropriate.

Yes, although it would then no longer be obvious that this feature leads
to improved EMI behavior, as long as we mention that in the docs, I
think it's a good idea

Maybe document it as follows?
PWM_USAGE_POWER - Allow the driver to delay the start of the cycle
for EMI improvements, as long as the power output stays the same

> 
> Come to think of it, a flag like that might even be useful to implement
> the common case of emulating inverted polarity with reversing the duty
> cycle. That is, if PWM_USAGE_POWER | PWM_POLARITY_INVERSED was specified
> and the PWM provider did not support polarity inversion, the inversion
> could still be implemented using emulation. Currently we push that logic
> down into consumers, but this could be a way to bring that up into
> drivers, or perhaps even the core.

Interesting, but that would be left for another series in the future, I
assume?

Thanks,
Clemens
