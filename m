Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 435C419E6C7
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Apr 2020 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgDDRft (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Apr 2020 13:35:49 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:33482 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgDDRft (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 4 Apr 2020 13:35:49 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id DC68DC726E3;
        Sat,  4 Apr 2020 19:35:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1586021748;
        bh=/fComAiMOskQAqf/UfIUYXWfRZk4X9H3xzWxUvkHj3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKpFGX2xzaf4wi4HV7XuaUHhbQe2RAKVpLKCzqAdur/qPj3Je/xLiqEXEbdWJUs8r
         3Eh2cBzxyJhXDVccN5iSo3jdY56KDl0Zx5bStwmvIWMGrFJbtbXJ4wbCoOnYgedNfs
         izo4sOfJhTz+VXVJCjRd3WBWJATSlwYBnN19fI0M=
Date:   Sat, 4 Apr 2020 19:35:46 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
Message-ID: <20200404173546.GA55833@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de>
 <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
 <20200330151231.GA1650@workstation.tuxnet>
 <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, Apr 03, 2020 at 07:50:07PM -0400, Sven Van Asbroeck wrote:
> On Mon, Mar 30, 2020 at 11:12 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > On Wed, Feb 26, 2020 at 06:03:02PM +0100, Matthias Schiffer wrote:
> > > As it turns out, this driver is broken in yet another way I didn't find
> > > before: For changing the global prescaler the chip needs to be put into
> > > sleep mode, but the driver doesn't follow the restart sequence
> > > described in the datasheet when waking it back up. In consequence,
> > > changing the period of one PWM does not only modify the period of all
> > > PWMs (which is bad enough, but can't be avoided with this hardware),
> > > but it also leaves all PWMs disabled...
> >
> > I am unable to reproduce this: If I set a specific duty cycle on a
> > channel and then change the period, the channel stays active.
> > I can see the brightness of an LED decrease if I increase the period.
> 
> What happens when pwm channels 0 and 1 are both enabled, and
> you change the pwm period of channel 0. Does channel 1 remain
> on?

Yes. Both channels remain on.

Let's say I configure a period of 5ms for both channels 0 and 1, as well
as a duty cycle of 4ms, meaning a relative duty cycle of 80%.
If I then increase the period of channel 0 to 10ms, there will be a
relative duty cycle of 40% on channel 0, but channel 1 will remain at a
relative duty cycle of 80%.
This is due to the relative nature of the internal ON/OFF times. For
the channel with the period change however, we recalculate the duty_ns
to period_ns ratio and reprogram the ON/OFF registers, because the user
might have already given us a different duty cycle in .config / .apply.

As the user is setting the duty cycle in nanoseconds, it makes sense
that the relative duty cycle decreases in an absolute period increase.
As for the behavior that the other channels remain at the same relative
duty cycle: Not sure how we can avoid this, other than reprogramming all
15 other channels if one of them is changed and that's not really
acceptable, I think.

Clemens
