Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08842F675D
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 18:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbhANRRH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jan 2021 12:17:07 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:50404 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbhANRRG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 14 Jan 2021 12:17:06 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 44B7CC72850;
        Thu, 14 Jan 2021 18:16:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1610644584;
        bh=dJPbqZ1Jbt5L0QkAHLpVnebnADXkNq4/ESRuPoctNcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xEL9UfBU/ZFPyxyZ8U1sEpsycVXzKLciypjT3/L1gqg6wvsWTuTnfKZS8WBqGjx3s
         iNKsR71K/cmHtib1phAxTtIXG52M6c9FhMF8j6ChTQkqrTIya+kMDkZ6Odab1yR7Rp
         h4g4uXReO8e4KcGkRX7NEYVmQF0yBhsghYYOSWUU=
Date:   Thu, 14 Jan 2021 18:16:22 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YAB8ZmtOxRV1QN4l@workstation.tuxnet>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, Jan 11, 2021 at 09:35:32PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Dec 17, 2020 at 06:43:04PM +0100, Clemens Gruber wrote:
> > On Wed, Dec 16, 2020 at 11:00:59PM -0500, Sven Van Asbroeck wrote:
> > > On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
> > > <clemens.gruber@pqgruber.com> wrote:
> > > >
> > > > Implements .get_state to read-out the current hardware state.
> > > >
> > > 
> > > I am not convinced that we actually need this.
> > > 
> > > Looking at the pwm core, .get_state() is only called right after .request(),
> > > to initialize the cached value of the state. The core then uses the cached
> > > value throughout, it'll never read out the h/w again, until the next .request().
> > > 
> > > In our case, we know that the state right after request is always disabled,
> > > because:
> > > - we disable all pwm channels on probe (in PATCH v5 4/7)
> > > - .free() disables the pwm channel
> > > 
> > > Conclusion: .get_state() will always return "pwm disabled", so why do we
> > > bother reading out the h/w?
> > 
> > If there are no plans for the PWM core to call .get_state more often in
> > the future, we could just read out the period and return 0 duty and
> > disabled.
> > 
> > Thierry, Uwe, what's your take on this?
> 
> I have some plans here. In the past I tried to implement them (see
> commit 01ccf903edd65f6421612321648fa5a7f4b7cb10), but this failed
> (commit 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3).
> 
> > > Of course, if we choose to leave the pwm enabled after .free(), then
> > > .get_state() can even be left out! Do we want that? Genuine question, I do
> > > not know the answer.
> > 
> > I do not think we should leave it enabled after free. It is less
> > complicated if we know that unrequested channels are not in use.
> 
> My position here is: A consumer should disable a PWM before calling
> pwm_put. The driver should however not enforce this and so should not
> modify the hardware state in .free().
> 
> Also .probe should not change the PWM configuration.

I see. This would also allow PWMs initialized in the bootloader (e.g.
backlights) to stay on between the bootloader and Linux and avoid
flickering.

If no one objects, I would then no longer reset period and duty cycles
in the driver (and for our projects, reset them in the bootloader code
to avoid leaving PWMs on after a kernel panic and watchdog reset, etc.)

And if there is no pre-known state of the registers, we actually need
the .get_state function fully implemented.

Thanks,
Clemens
