Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20134B818
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Mar 2021 17:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhC0QGB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Mar 2021 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0QFi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Mar 2021 12:05:38 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56FC0613B1;
        Sat, 27 Mar 2021 09:05:38 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id B4276CB478B;
        Sat, 27 Mar 2021 17:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1616861136;
        bh=QPLsMrmELyZRDmLYX2w/l2qB+1PgXZX0xEoCvX+7rAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ubbkyCUxq+dbxTxzPZutEONWDIfQy/30EdpvM+WbbyOjAPZQu94hbgxi+SOJYbEkn
         fMAaHv+evBuvnddCXj+HTQlX2O7d4caQ0CXCVdMG0OOH+6TxIBVynAlse95+1V+nVl
         kO59XJZXU20/CJdDsAjsklhei5bILbg4hZaqTJN8=
Date:   Sat, 27 Mar 2021 17:05:35 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YF9Xz0znW8cFfTpE@workstation.tuxnet>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <20210111203532.m3yvq6e5bcpjs7mc@pengutronix.de>
 <CAGngYiW=KhCOZX3tPMFykXzpWLpj3qusN2OXVPSfHLRcyts+wA@mail.gmail.com>
 <YBQ4c2cYYPDMjkeH@workstation.tuxnet>
 <CAGngYiWd0u=+DPhvK+8v9FT8Y1Evn1brWRheMNDXWFVVL-wNFw@mail.gmail.com>
 <YBRyG0vv3gRzygSB@workstation.tuxnet>
 <YFhhGpiHDELxIo9V@orome.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFhhGpiHDELxIo9V@orome.fritz.box>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On Mon, Mar 22, 2021 at 10:19:22AM +0100, Thierry Reding wrote:
> On Fri, Jan 29, 2021 at 09:37:47PM +0100, Clemens Gruber wrote:
> > Hi Sven,
> > 
> > On Fri, Jan 29, 2021 at 01:05:14PM -0500, Sven Van Asbroeck wrote:
> > > Hi Clemens,
> > > 
> > > On Fri, Jan 29, 2021 at 11:31 AM Clemens Gruber
> > > <clemens.gruber@pqgruber.com> wrote:
> > > >
> > > > Ok, so you suggest we extend our get_state logic to deal with cases
> > > > like the following:
> > > 
> > > Kind of. We can't control how other actors (bootloaders etc) program the
> > > chip. As far as I know, there are many, many different register settings that
> > > result in the same physical chip outputs. So if .probe() wants to preserve the
> > > existing chip settings, .get_state() has to be able to deal with every possible
> > > setting. Even invalid ones.
> > 
> > Is the driver really responsible for bootloaders that program the chip
> > with invalid values?
> > The chip comes out of PoR with sane default values. If the bootloader of
> > a user messes them up, isn't that a bootloader problem instead of a
> > Linux kernel driver problem?
> 
> It is ultimately a problem of the bootloader and where possible the
> bootloader should be fixed. However, fixing bootloaders sometimes isn't
> possible, or impractical, so the kernel has to be able to deal with
> hardware that's been badly programmed by the bootloader. Within reason,
> of course. Sometimes this can't be done in any other way than forcing a
> hard reset of the chip, but it should always be a last resort.
> 
> > > In addition, .apply() cannot make any assumptions as to which bits are
> > > already set/cleared on the chip. Including preserved, invalid settings.
> > > 
> > > This might get quite complex.
> > > 
> > > However if we reset the chip in .probe() to a known state (a normalized state,
> > > in the mathematical sense), then both .get_state() and .apply() become
> > > much simpler. because they only need to deal with known, normalized states.
> > 
> > Yes, I agree. This would however make it impossible to do a flicker-free
> > transition from bootloader to kernel, but that's not really a usecase I
> > have so I can live without it.
> > 
> > Another point in favor of resetting is that the driver already does it.
> > Removing the reset of the OFF register may break some boards who rely on
> > that behaviour.
> > My version only extended the reset to include the ON register.
> > 
> > > 
> > > In short, it's a tradeoff between code complexity, and user friendliness/
> > > features.
> > > 
> > > Sven
> > 
> > Thierry, Uwe, what's your take on this?
> > 
> > Thierry: Would you accept it if we continue to reset the registers in
> > .probe?
> 
> Yes, I think it's fine to continue to reset the registers since that's
> basically what the driver already does. It'd be great if you could
> follow up with a patch that removes the reset and leaves the hardware in
> whatever state the bootloader has set up. Then we can take that patch
> for a ride and see if there are any complains about it breaking. If
> there are we can always try to fix them, but as a last resort we can
> also revert, which then may be something we have to live with. But I
> think we should at least try to make this consistent with how other
> drivers do this so that people don't stumble over this particular
> driver's behaviour.

Thanks for your input!

Sounds good to me. I am currently preparing a new revision of the
series. As soon as that is reviewed and good to go, I will look into
removing the resets.

Clemens
