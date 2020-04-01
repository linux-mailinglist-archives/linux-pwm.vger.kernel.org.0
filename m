Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53FE19B386
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Apr 2020 18:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbgDAQv6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Apr 2020 12:51:58 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:57474 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388555AbgDAQgo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 1 Apr 2020 12:36:44 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id C530EC425A3;
        Wed,  1 Apr 2020 18:36:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1585759002;
        bh=IPYAP+Th3gWr6c1GcWqNIip3jHxnwVBTe6y78MvI8lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugZWMCyav4coGCw7rKKWrZ9FiyO4+kuMLcOtv4VI+dX6Ydn8s6iUO/XwnBHf9iBW7
         0ZpFzHUamm3Ku5foVMNFg4SZOHqzxnK7n+KcwmIRZFzBRHw2CCtMGFAs3+8DHwACGl
         btyHxOyEQhQSKy+IH63DzU4cwLr8YFpWW7ENiLYk=
Date:   Wed, 1 Apr 2020 18:36:40 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Van Asbroeck <TheSven73@gmail.com>
Subject: Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle struct element
Message-ID: <20200401163640.GA91358@workstation.tuxnet>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200330130743.GB2431644@ulmo>
 <CAHp75Vc_=czuRtyqgnmnYfie50gDnzrNqq3Bt+Gp_42MikX6VA@mail.gmail.com>
 <20200330160238.GD2817345@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330160238.GD2817345@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 30, 2020 at 06:02:38PM +0200, Thierry Reding wrote:
> On Mon, Mar 30, 2020 at 04:18:22PM +0300, Andy Shevchenko wrote:
> > On Mon, Mar 30, 2020 at 4:09 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > On Wed, Feb 26, 2020 at 02:52:26PM +0100, Matthias Schiffer wrote:
> > > > duty_cycle was only set, never read.
> > > >
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > > > ---
> > > >  drivers/pwm/pwm-pca9685.c | 4 ----
> > > >  1 file changed, 4 deletions(-)
> > >
> > > Applied, thanks.
> > 
> > I'm not sure this patch is correct.
> 
> What makes you say that? If you look at the code, the driver sets this
> field to either 0 or some duty cycle value but ends up never using it.
> Why would it be wrong to remove that code?
> 
> > We already have broken GPIO in this driver. Do we need more breakage?
> 
> My understanding is that nobody was able to pinpoint exactly when this
> regressed, or if this only worked by accident to begin with. It sounds
> like Clemens has a way of testing this driver, so perhaps we can solve
> that GPIO issue while we're at it.
> 
> The last discussion on this seems to have been around the time when you
> posted a fix for it:
> 
>     https://patchwork.ozlabs.org/patch/1156012/
> 
> But then Sven had concerns that that also wasn't guaranteed to work:
> 
>     https://lkml.org/lkml/2019/6/2/73
> 
> So I think we could either apply your patch to restore the old behaviour
> which I assume you tested, so at least it seems to work in practice,
> even if there's still a potential race that Sven pointed out in the
> above link.
> 
> I'd prefer something alternative because it's obviously confusing and
> completely undocumented. Mika had already proposed something that's a
> little bit better, though still somewhat confusing.
> 
> Oh... actually reading further through those threads there seems to be a
> patch from Sven that was reviewed by Mika but then nothing happened:
> 
> 	https://lkml.org/lkml/2019/6/4/1039
> 
> with the corresponding patchwork URL:
> 
> 	https://patchwork.ozlabs.org/patch/1110083/
> 
> Andy, Clemens, do you have a way of testing the GPIO functionality of
> this driver? If so, it'd be great if you could check the above patch
> from Sven to fix PWM/GPIO interop.

Looks good. Tested it today and I can no longer reproduce the issues
when switching between PWM and GPIO modes.
It did not apply cleanly on the current mainline or for-next branch, so
I'll send a fixed up version of the patch with my Tested-by tag shortly.

I noticed an unrelated issue when disabling and enabling the channel
though, for which I will either send a patch or maybe try to convert the
driver to the atomic API first and then look if it is still a problem.
(Issue is that if you disable the channel, the LED_OFF counter is
cleared, which means you have to reconfigure the duty cycle after
reenabling. It's probably better if only the FULL_OFF bit is toggled in
enable/disable as it has precedence over the others anyway and then the
previous state would not be changed..?)

Clemens
