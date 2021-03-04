Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53B532D410
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Mar 2021 14:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhCDNW7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Mar 2021 08:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbhCDNWz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Mar 2021 08:22:55 -0500
X-Greylist: delayed 608 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 Mar 2021 05:22:15 PST
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F84C061574;
        Thu,  4 Mar 2021 05:22:15 -0800 (PST)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id B19FCC72819;
        Thu,  4 Mar 2021 14:22:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1614864133;
        bh=s42k8uAo9kxNjLeN9HuZ/mbV6dmUP2yAZhrHu3lt1ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXoNOhNHQqlx4d8o+UngFwqgEBNUw4B9vfkQGLTIeM2p3lHG+GKpqzNJJ4hgOeDJ6
         zn1A3q2Cx0UPQqAejx2yQfpmuSP8e0PEH1gcogqnjSCuimEDnHKnB8TGnKQA1b9TMC
         XH9DDSXhuOdwyVaJ0mueNyaIok/mqn9ZHAXzcQhQ=
Date:   Thu, 4 Mar 2021 14:22:12 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YEDfBPsbZ5uxj/PP@workstation.tuxnet>
References: <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
 <CAGngYiXxfz7rtsw4zSj5QX7Lj7hvnoESqyUE_2__=oDaRmGGJQ@mail.gmail.com>
 <CAGngYiV5GGJvHTwG7k6mv76uR1RLnHOJoO8+d2ofiZAQi3K0BA@mail.gmail.com>
 <YBg5MlvJQ0N2u+j6@workstation.tuxnet>
 <20210301215248.ekclgxc7dq6asdz5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210301215248.ekclgxc7dq6asdz5@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Mar 01, 2021 at 10:52:48PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Feb 01, 2021 at 06:24:02PM +0100, Clemens Gruber wrote:
> > Hi Sven, Thierry, Uwe,
> > 
> > On Fri, Jan 29, 2021 at 05:16:51PM -0500, Sven Van Asbroeck wrote:
> > > Hi Clemens,
> > > 
> > > On Fri, Jan 29, 2021 at 4:24 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> > > >
> > > > LEN_ON = 409, LED_OFF = 1228 and
> > > > LED_ON = 419, LED_OFF = 1238
> > > > produce the same result. you can't see the difference between the two
> > > > when scoping the channel. there are probably more ways to do this,
> > > > some might surprise us. It's a tricky chip.
> > > 
> > > Please ignore this example, it's bogus. In my defence, it's a Friday
> > > afternoon here :)
> > 
> > Happens to the best of us :)
> > 
> > > 
> > > But consider the following: imagine the bootloader has enabled a few
> > > pwm channels, and the driver's .probe() has left them on/unchanged.
> > > Then the user enables another pwm channel, and tries to change the
> > > period/prescaler. How would pca9685_may_change_prescaler() know
> > > if changing the prescaler is allowed?
> > > 
> > > And the following: imagine the bootloader has enabled a few
> > > pwm channels, and the driver's .probe() has left them on/unchanged.
> > > After .probe(), the runtime_pm will immediately put the chip to sleep,
> > > because it's unaware that some channels are alive.
> > 
> > (We could read out the state in .probe. If a pwm is already enabled by
> > the bootloader, then the user can't change the period. Also, the chip
> > would not be put to sleep.
> > 
> > The user then can export channels and see if they are enabled. If he
> > wants to change the period, he needs to find the one enabled by the
> > bootloader and change the period there, before he requests more.
> > If the bootloader enabled more than one, then he has to disable all but
> > one to change the period.
> > 
> > Or did I miss something?)
> > 
> > > 
> > > I'm sure I'm overlooking a few complications here. probe not changing
> > > the existing configuration, will add a lot of complexity to the driver.
> > > I'm not saying this is necessarily bad, just a tradeoff. Or, a management
> > > decision.
> > 
> > But I agree that it is simpler if we keep the resets in probe. It would
> > also avoid a potentially breaking change for users that do not reset
> > their pca9685 chips in their bootloader code.
> 
> I would prefer to drop the reset. If the bootloader left with an invalid
> state, this is active for sure until the PWM driver is loaded. If you
> don't reset, the time is extended (usually) until the consumer comes
> along and corrects the setting. So the downside of not resetting is
> quite limited, but if you disable the PWM in .probe() the effect can be
> worse. And consistency dictates to not reset.
> 
> > Removing the resets could then be left as something to discuss further
> > in the future and something that belongs in a separate patch series?
> 
> That would be fine for me, too.

Great, then I will prepare a new series next week.

Thanks,
Clemens
