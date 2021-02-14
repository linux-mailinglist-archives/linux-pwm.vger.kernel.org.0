Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E115B31B0D6
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Feb 2021 15:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhBNOrf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Feb 2021 09:47:35 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:50520 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhBNOrd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 14 Feb 2021 09:47:33 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 2B2B9C727E0;
        Sun, 14 Feb 2021 15:46:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1613314011;
        bh=sxi7a6E8cRH4ZwXVlJ0++ebboH+ZCqj50zgHlBOdnPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xw3sdAsHZOtda3rZh7oPB+C/nGMt6R03OGoXlhK5VwQYhvW1mZdbmFcF2dTAwYNlf
         J+sIYMEjkhYj8wXKclccHIlliuTxLidO7c7MghieT0yS8E5VtBloE3cS7Kappk1MCn
         9CIOnrVoEDC48W8yi1vucbOEdJ2t+MKK/hIGebps=
Date:   Sun, 14 Feb 2021 15:46:49 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YCk32T6md0c1lHnp@workstation.tuxnet>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBRyG0vv3gRzygSB@workstation.tuxnet>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi all,

On Fri, Jan 29, 2021 at 09:37:47PM +0100, Clemens Gruber wrote:
> Hi Sven,
> 
> On Fri, Jan 29, 2021 at 01:05:14PM -0500, Sven Van Asbroeck wrote:
> > Hi Clemens,
> > 
> > On Fri, Jan 29, 2021 at 11:31 AM Clemens Gruber
> > <clemens.gruber@pqgruber.com> wrote:
> > >
> > > Ok, so you suggest we extend our get_state logic to deal with cases
> > > like the following:
> > 
> > Kind of. We can't control how other actors (bootloaders etc) program the
> > chip. As far as I know, there are many, many different register settings that
> > result in the same physical chip outputs. So if .probe() wants to preserve the
> > existing chip settings, .get_state() has to be able to deal with every possible
> > setting. Even invalid ones.
> 
> Is the driver really responsible for bootloaders that program the chip
> with invalid values?
> The chip comes out of PoR with sane default values. If the bootloader of
> a user messes them up, isn't that a bootloader problem instead of a
> Linux kernel driver problem?
> 
> > In addition, .apply() cannot make any assumptions as to which bits are
> > already set/cleared on the chip. Including preserved, invalid settings.
> > 
> > This might get quite complex.
> > 
> > However if we reset the chip in .probe() to a known state (a normalized state,
> > in the mathematical sense), then both .get_state() and .apply() become
> > much simpler. because they only need to deal with known, normalized states.
> 
> Yes, I agree. This would however make it impossible to do a flicker-free
> transition from bootloader to kernel, but that's not really a usecase I
> have so I can live without it.
> 
> Another point in favor of resetting is that the driver already does it.
> Removing the reset of the OFF register may break some boards who rely on
> that behaviour.
> My version only extended the reset to include the ON register.
> 
> > 
> > In short, it's a tradeoff between code complexity, and user friendliness/
> > features.
> > 
> > Sven
> 
> Thierry, Uwe, what's your take on this?
> 
> Thierry: Would you accept it if we continue to reset the registers in
> .probe?
> 
> Thanks,
> Clemens

I realize that it is a difficult time at the moment, but it is a little
bit frustrating not getting any response from the maintainer.

I think the best way forward is to just keep the register resets in
probe as they are. If this is to be changed, I think it should be done
in a separate patchset and by someone who has a usecase requiring it.

Best regards,
Clemens
