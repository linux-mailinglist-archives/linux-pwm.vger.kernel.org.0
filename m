Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE319972F
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2020 15:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgCaNO4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Mar 2020 09:14:56 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:43248 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730543AbgCaNO4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 31 Mar 2020 09:14:56 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id DBD62C63E20;
        Tue, 31 Mar 2020 15:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1585660494;
        bh=KYSATk71pJk6+doq/qSuxOdl/3paQs7CI/Dv0CuLfIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5XXO1WfibTi27ZwQixsdR01AyS9C7i8UMmwSOJ10R2wZ8t7Ld8rPtSky+h/eEWIu
         8SI+msTqXidjZrtr9JtPVh0OU8UiqugqcY10Nx75+5M/V1FipCWy9PsnbpKhUD76Gd
         DdZAW8ypwyKiAd1EvphKBHMhRSuRuiazwO7xuVaw=
Date:   Tue, 31 Mar 2020 15:14:52 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: (EXT) Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Message-ID: <20200331131452.GA6448@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
 <20200330130757.GC2431644@ulmo>
 <20200330133450.GA1530@workstation.tuxnet>
 <20200330154036.GB2817345@ulmo>
 <20200330160744.GA777@workstation.tuxnet>
 <452f4e03cc2a998c7a903251f99931935b1f872f.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452f4e03cc2a998c7a903251f99931935b1f872f.camel@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Mar 31, 2020 at 02:09:37PM +0200, Matthias Schiffer wrote:
> On Mon, 2020-03-30 at 18:07 +0200, Clemens Gruber wrote:
> > On Mon, Mar 30, 2020 at 05:40:36PM +0200, Thierry Reding wrote:
> > > On Mon, Mar 30, 2020 at 03:34:50PM +0200, Clemens Gruber wrote:
> > > > Hi,
> > > > 
> > > > On Mon, Mar 30, 2020 at 03:07:57PM +0200, Thierry Reding wrote:
> > > > > On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer
> > > > > wrote:
> > > > > > The interaction of the ALL_LED PWM channel with the other
> > > > > > channels was
> > > > > > not well-defined. As the ALL_LED feature does not seem very
> > > > > > useful and
> > > > > > it was making the code significantly more complex, simply
> > > > > > remove it.
> > > > > > 
> > > > > > Signed-off-by: Matthias Schiffer <
> > > > > > matthias.schiffer@ew.tq-group.com>
> > > > > > ---
> > > > > >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------
> > > > > > ------------
> > > > > >  1 file changed, 17 insertions(+), 98 deletions(-)
> > > > > 
> > > > > Applied, thanks.
> > > > > 
> > > > > Thierry
> > > > 
> > > > I was not reading the mailing list in the last weeks, so I only
> > > > saw the
> > > > patch today.
> > > > 
> > > > We are using the ALL_LED channel in production to reduce the
> > > > delay when
> > > > all 16 PWM outputs need to be set to the same duty cycle.
> > > > 
> > > > I am not sure it is a good idea to remove this feature.
> > > 
> > > Can you specify what platform this is and where the code is that
> > > does
> > > this. I can't really find any device tree users of this and I don't
> > > know
> > > if there's a good way to find out what other users there are, but
> > > this
> > > isn't the first time this driver has created confusion, so please
> > > help
> > > collect some more information about it's use so we can avoid this
> > > in the
> > > future.
> > 
> > The platform is ARM, it's a custom board with an NXP i.MX6. The
> > device
> > tree is not upstreamed. As there are multiple companies involved
> > in changes to this driver, I assume that it is in use, even though
> > there
> > are no in-tree users.
> > Also: As you can set the ALL channel from userspace, it will be very
> > difficult to find out how often the ALL feature is being used
> > somewhere.
> > 
> > > 
> > > I'll back out this particular patch since you're using it. Can you
> > > give
> > > the other three patches a try to see if they work for you?
> > 
> > Thanks! I saw your other mail. Patch 1 looks good to me. I will look
> > at
> > the new version of patches 3 and 4 and test them when they appear on
> > the
> > list.
> > 
> > Clemens
> 
> Thanks for the feedback, I'll have to respin my cleanup patches without
> removing this feature.
> 
> I wonder if we can come up with a sane semantics of how ALL_LED is
> supposed to interact with the individual channels? Optimally, changes
> made via ALL_LED should be reflected in the state of the other channels
> including their sysfs files, but I'm not sure if current APIs can
> support this cleanly. It might make sense to make requesting/exporting
> individual channels and ALL_LED mutually exclusive, so the state of a
> requested PWM can't change when it's supposed to be under exclusive
> control of one user. Of course, such a change can break existing users
> as well...

I agree that it would be a good idea to make this exclusive. This change
would at least not break our application, because we unexport the
ALL_LED channel before requesting an individual channel.
Not sure about other users, but using both individual and ALL channels
at the same time is probably not a reasonable/sane usecase..

> And what about state propagation in the other direction - how should
> the ALL_LED state reflect changes made to the other channels' settings?
> On the hardware side, the ALL_LED registers are write-only, as there
> aren't any sane values that could be returned.

According to the datashet (7.3.4) the individual registers are filled if
the ALL_LED channel is used. However, in .disable, the OFF registers are
reset to 0. (And the ON registers are not used, except for the FULL_ON
bit)
So there should not be any side effects, as long as the access to the
ALL_LED channel is made exclusive and the user has to free it before he
can request individual channels.

Another quirk is the same prescaler/period for all channels. But I am
not sure what we can do about that. Applications might already depend on
the fact that the last set period wins.

Clemens
