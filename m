Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF50308E91
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Jan 2021 21:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhA2Uid (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Jan 2021 15:38:33 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:57998 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231485AbhA2Uia (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 29 Jan 2021 15:38:30 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 55628C6B26F;
        Fri, 29 Jan 2021 21:37:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1611952668;
        bh=M77IeiI3LvLSKSlLTtriV575WwpoQQQ6BC6g1xaE4bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w0xNUbE6qYayxulO8c/Jz7MWooXrxEyeZRUOk1v0bPhzt5bpcGm0F21WrgyMtxLiZ
         oRcEXbD6RyApswoXvRG9HPdmvg2K6jzJoSRVSvoWgZhMfmEs+AxtDlyom636a+O+ZT
         4/EjuGjie34HOl6HMvZ2gCk90nZ5g92ca3RdXvEE=
Date:   Fri, 29 Jan 2021 21:37:47 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YBRyG0vv3gRzygSB@workstation.tuxnet>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sven,

On Fri, Jan 29, 2021 at 01:05:14PM -0500, Sven Van Asbroeck wrote:
> Hi Clemens,
> 
> On Fri, Jan 29, 2021 at 11:31 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > Ok, so you suggest we extend our get_state logic to deal with cases
> > like the following:
> 
> Kind of. We can't control how other actors (bootloaders etc) program the
> chip. As far as I know, there are many, many different register settings that
> result in the same physical chip outputs. So if .probe() wants to preserve the
> existing chip settings, .get_state() has to be able to deal with every possible
> setting. Even invalid ones.

Is the driver really responsible for bootloaders that program the chip
with invalid values?
The chip comes out of PoR with sane default values. If the bootloader of
a user messes them up, isn't that a bootloader problem instead of a
Linux kernel driver problem?

> In addition, .apply() cannot make any assumptions as to which bits are
> already set/cleared on the chip. Including preserved, invalid settings.
> 
> This might get quite complex.
> 
> However if we reset the chip in .probe() to a known state (a normalized state,
> in the mathematical sense), then both .get_state() and .apply() become
> much simpler. because they only need to deal with known, normalized states.

Yes, I agree. This would however make it impossible to do a flicker-free
transition from bootloader to kernel, but that's not really a usecase I
have so I can live without it.

Another point in favor of resetting is that the driver already does it.
Removing the reset of the OFF register may break some boards who rely on
that behaviour.
My version only extended the reset to include the ON register.

> 
> In short, it's a tradeoff between code complexity, and user friendliness/
> features.
> 
> Sven

Thierry, Uwe, what's your take on this?

Thierry: Would you accept it if we continue to reset the registers in
.probe?

Thanks,
Clemens
