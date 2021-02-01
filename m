Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC830ADB4
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Feb 2021 18:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhBARYt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Feb 2021 12:24:49 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:41310 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230171AbhBARYq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 1 Feb 2021 12:24:46 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 9353EC72B41;
        Mon,  1 Feb 2021 18:24:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1612200243;
        bh=+ts/5g1qWFJkzk5tLXZNFyB6pmP9M4qhq/bTMqcP9Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxJvTVxKZ+KJc3ii4sC5rtg8sDwtwuvR1fBUzxxtcTzzz0S42qGNMonJW9FypDKR5
         gvHnfcfdr2hw5kxY3BXBI+y7qfwLIv9ryvn9ImzFBaeT5Rp+zUg2BKRXgxc7KC0kVD
         AKB//FPqOHjscfmOmQBJFxzJAbEAbl+BLp5BoFJQ=
Date:   Mon, 1 Feb 2021 18:24:02 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YBg5MlvJQ0N2u+j6@workstation.tuxnet>
References: <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
 <CAGngYiXxfz7rtsw4zSj5QX7Lj7hvnoESqyUE_2__=oDaRmGGJQ@mail.gmail.com>
 <CAGngYiV5GGJvHTwG7k6mv76uR1RLnHOJoO8+d2ofiZAQi3K0BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiV5GGJvHTwG7k6mv76uR1RLnHOJoO8+d2ofiZAQi3K0BA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sven, Thierry, Uwe,

On Fri, Jan 29, 2021 at 05:16:51PM -0500, Sven Van Asbroeck wrote:
> Hi Clemens,
> 
> On Fri, Jan 29, 2021 at 4:24 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> >
> > LEN_ON = 409, LED_OFF = 1228 and
> > LED_ON = 419, LED_OFF = 1238
> > produce the same result. you can't see the difference between the two
> > when scoping the channel. there are probably more ways to do this,
> > some might surprise us. It's a tricky chip.
> 
> Please ignore this example, it's bogus. In my defence, it's a Friday
> afternoon here :)

Happens to the best of us :)

> 
> But consider the following: imagine the bootloader has enabled a few
> pwm channels, and the driver's .probe() has left them on/unchanged.
> Then the user enables another pwm channel, and tries to change the
> period/prescaler. How would pca9685_may_change_prescaler() know
> if changing the prescaler is allowed?
> 
> And the following: imagine the bootloader has enabled a few
> pwm channels, and the driver's .probe() has left them on/unchanged.
> After .probe(), the runtime_pm will immediately put the chip to sleep,
> because it's unaware that some channels are alive.

(We could read out the state in .probe. If a pwm is already enabled by
the bootloader, then the user can't change the period. Also, the chip
would not be put to sleep.

The user then can export channels and see if they are enabled. If he
wants to change the period, he needs to find the one enabled by the
bootloader and change the period there, before he requests more.
If the bootloader enabled more than one, then he has to disable all but
one to change the period.

Or did I miss something?)

> 
> I'm sure I'm overlooking a few complications here. probe not changing
> the existing configuration, will add a lot of complexity to the driver.
> I'm not saying this is necessarily bad, just a tradeoff. Or, a management
> decision.

But I agree that it is simpler if we keep the resets in probe. It would
also avoid a potentially breaking change for users that do not reset
their pca9685 chips in their bootloader code.
There might be users out there that depend on the driver to reset the
OFF registers in .probe.

If Thierry agrees / allows it, I can keep the resets for now.

Removing the resets could then be left as something to discuss further
in the future and something that belongs in a separate patch series?

Clemens
