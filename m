Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B8535A283
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhDIQDG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQDF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 12:03:05 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4089C061760;
        Fri,  9 Apr 2021 09:02:52 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 23E12C725C8;
        Fri,  9 Apr 2021 18:02:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617984171;
        bh=LIxPHBmo/KeqMZhUOvGy0UsxCNZtEfquEOWX7sW/jAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1W2OMqw1YYp+BDN8lYxuq8J/C2uG9MWqK6tUyJFGTNduiYyu0dXTdKazWKvRPkXZ
         94OlucJWrUfT92/uHqhoqBegM5iuKqUSeY83MhnJ1eVpuCJEfRmbHqJt57r1GHoJH8
         t1WgWpok32/ZSwSxB2yeqa/ZkPdlmBsaku0IkZ/4=
Date:   Fri, 9 Apr 2021 18:02:49 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/8] pwm: core: Support new PWM_STAGGERING_ALLOWED flag
Message-ID: <YHB6qQGTyVt8rh4Y@workstation.tuxnet>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-5-clemens.gruber@pqgruber.com>
 <20210407054658.qdsjkstqwynxeuxj@pengutronix.de>
 <YG4UNoBCQJkEEfwi@workstation.tuxnet>
 <20210407213403.h6n6l2t7vqoalceu@pengutronix.de>
 <YG78IHIMGtl8Pokp@orome.fritz.box>
 <YG8miEOZXsH0NTcA@workstation.tuxnet>
 <20210408173637.w26njwystfuyrgan@pengutronix.de>
 <YHA5sPuZmbSLU3aM@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHA5sPuZmbSLU3aM@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Apr 09, 2021 at 01:25:36PM +0200, Thierry Reding wrote:
> On Thu, Apr 08, 2021 at 07:36:37PM +0200, Uwe Kleine-König wrote:
> > On Thu, Apr 08, 2021 at 05:51:36PM +0200, Clemens Gruber wrote:
> > > On Thu, Apr 08, 2021 at 02:50:40PM +0200, Thierry Reding wrote:
> > > > Yes, I think that's basically what this is saying. I think we're perhaps
> > > > getting hung up on the terminology here. PWM_STAGGERING_ALLOWED gives
> > > > the impression that we're dealing with some provider-specific feature,
> > > > whereas what we really want to express is that the PWM doesn't care
> > > > exactly when the active cycle starts and based on that a provider that
> > > > can support it may optimize the EMI behavior.
> > > > 
> > > > Maybe we can find a better name for this? Ultimately what this means is
> > > > that the consumer is primarily interested in the power output of the PWM
> > > > rather than the exact shape of the signal. So perhaps something like
> > > > PWM_USAGE_POWER would be more appropriate.
> > > 
> > > Yes, although it would then no longer be obvious that this feature leads
> > > to improved EMI behavior, as long as we mention that in the docs, I
> > > think it's a good idea
> > > 
> > > Maybe document it as follows?
> > > PWM_USAGE_POWER - Allow the driver to delay the start of the cycle
> > > for EMI improvements, as long as the power output stays the same
> > 
> > I don't like both names, because for someone who is only halfway into
> > PWM stuff it is not understandable. Maybe ALLOW_PHASE_SHIFT?
> 
> Heh... how's that any more understandable?
> 
> > When a consumer is only interested in the power output than
> > 
> > 	.period = 20
> > 	.duty_cycle = 5
> > 
> > would also be an allowed response for the request
> > 
> > 	.period = 200
> > 	.duty_cycle = 50
> > 
> > and this is not what is in the focus here.
> 
> Actually, that's *exactly* what's important here. From a consumer point
> of view the output power is the key in this case. The specifier is a
> description of a particular PWM in the consumer context. And the
> consumer not going to care what exactly the PWM controller might end up
> configuring to achieve best results. If the controller allows the phase
> shift to be changed and the constraints allow it, then that's great, but
> it isn't something that the consumer has to know if all it wants is that
> the power output is as requested.
> 
> Put another way, the more generically we can describe the constraints or
> use cases, the more flexibility we get for drivers to fulfill those
> constraints. For example one controller might support phase shifting and
> use that for PWM_USAGE_POWER for better EMI behaviour. But another PWM
> controller may not support it. But it could perhaps want to optimize the
> PWM signal by reversing the polarity of one channel or whatever other
> mechanism there may be.
> 
> If we add a flag such as ALLOW_PHASE_SHIFT, then only controllers that
> support programmable phase shift will be able to support this. If some
> other mechanism can also be used to support "equivalent power" use
> cases, that would have to be described as some other flag, which has
> essentially the same meaning. So you can get into a situation where you
> have multiple flags used for the same thing.

I see what you mean. We have more flexibility with PWM_USAGE_POWER. The
only downside is that there is no real connection to the improved EMI
but I guess that's what documentation is for.

I will try to document it as follows:
- PWM_USAGE_POWER - Only care about the power output of the signal. This
  allows drivers (if supported) to optimize the signals, for example to
  improve EMI and reduce current spikes.

Maybe I then add a comment describing the specific optimization in the
pca9685 code, maybe like this:
If PWM_USAGE_POWER is set on a PWM, the pca9685 driver will phase shift
the individual channels relative to their channel number. This improves
EMI because the enabled channels no longer turn on at the same time,
while still maintaining the configured duty cycle.

Thanks,
Clemens
