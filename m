Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700D52D9BFC
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Dec 2020 17:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439657AbgLNQKB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Dec 2020 11:10:01 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:52848 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439348AbgLNQJz (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 14 Dec 2020 11:09:55 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 4BBA2C89267;
        Mon, 14 Dec 2020 17:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1607962146;
        bh=G9Z4MsYhqRoB5YjLUrciZJYEuLucfTov5ztQjtq513Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ob7jByr7eJOKnTIA7SJFIt9OpHQvU8lmnDfCZngfqThvvVY+J1aIkZBzRmM31AchI
         9Q7NSBJcVWvFgMkL6lGcep5dDT46qvvClA/pz6l2fT6ELW/XmqT4rCVN3NxBUI7dB8
         +DVlJsEPuHb2V4KByzAiKmlgTNdK1gPrQRXlm+wc=
Date:   Mon, 14 Dec 2020 17:09:05 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X9eOIfixWlsE1JWC@workstation.tuxnet>
References: <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo>
 <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
 <X9JWlVPb9ZGdB4q9@ulmo>
 <20201210203926.ouzrq3ff5k6zhlvt@pengutronix.de>
 <X9Mu8zrJjFTe6fJq@ulmo>
 <20201211103454.tqcfzy3ayn2gz7k4@pengutronix.de>
 <X9d2iFCzSkqLu8zR@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9d2iFCzSkqLu8zR@ulmo>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Dec 14, 2020 at 03:28:24PM +0100, Thierry Reding wrote:
> On Fri, Dec 11, 2020 at 11:34:54AM +0100, Uwe Kleine-König wrote:
> > Hello Thierry,
> > 
> > On Fri, Dec 11, 2020 at 09:33:55AM +0100, Thierry Reding wrote:
> > > On Thu, Dec 10, 2020 at 09:39:26PM +0100, Uwe Kleine-König wrote:
> > > > On Thu, Dec 10, 2020 at 06:10:45PM +0100, Thierry Reding wrote:
> > > > > Like I said, that's not what I was saying. I was merely saying that if
> > > > > there aren't any use-cases that current users rely on that would be
> > > > > broken by using this simpler implementation, then I'm okay with it, even
> > > > > if it's less flexible than a more complicated implementation. It should
> > > > > be possible to determine what the current users are by inspecting device
> > > > > trees present in the kernel. Anything outside the kernel isn't something
> > > > > we need to consider, as usual.
> > > > 
> > > > If "users in mainline" is the criteria that's a word.
> > > 
> > > I didn't say "users in mainline", I said "use-cases". What I don't want
> > > to happen is for this change under discussion to break any existing use-
> > > cases of any existing users in the kernel. I said that we can determine
> > > what the existing users are by looking at which device trees use the
> > > compatible strings that the driver matches on.
> > > 
> > > > So you agree we remove the following drivers?:
> > > > 
> > > >  - pwm-hibvt.c
> > > >    Last driver specific change in Feb 2019, no mainline user
> > > >  - pwm-sprd.c
> > > >    Last driver specific change in Aug 2019, no mainline user
> > > 
> > > No, that's an extrapolation of what I was saying above. Drivers with no
> > > apparent users are a separate topic, so don't conflate it with the issue
> > > at hand.
> > 
> > I cannot follow (and I think that's the problem between us and why those
> > conflicts happen between us). For me it's a logic consequence of
> > "Anything outside the kernel isn't something we need to consider, as
> > usual." that drivers that are untouched for some period and have no
> > mainline users can/should go away. (Is "extrapolation" as strong as
> > "implication", or has it subjective interpretation added? My dictionary
> > isn't accurate enough for that question.) But it seems there is
> > something with my logic or you not saying exactly what you actually
> > mean. (Did I miss any option? If yes it might be covered by a problem in
> > my logic.)
> 
> To me this is not as black and white as it seems to be for you. First I
> wasn't talking about unused drivers, but about use-cases that are not
> represented in mainline. Secondly I didn't say anything about removing
> support for use-cases that weren't in use upstream. All I said was that
> I didn't want any changes to regress existing use-cases.
> 
> "Guessing" how that statement reflects on my thoughts about unused
> drivers is extrapolation. Your logic implication could've been correct,
> but in this case it wasn't because I consider a driver that was
> upstreamed to be part of the kernel, and people invested a fair amount
> of work to get it to that point, so I'm in no hurry to get rid of them.
> Instead, I prefer to give people the benefit of the doubt and assume
> that they had planned to get users upstream and for some reason just
> haven't gotten around to it.
> 
> On the other hand, almost 18-24 months without activity is quite long. A
> compromise that works well for me is to keep drivers, even unused ones,
> as long as they're not getting in the way.
> 
> > Having said that, even in the question at hand (i.e. what is the better
> > compromise for mapping the inter-channel hardware limitations to
> > software policy in the pac9685 driver) the idea "let's inspecting device
> > trees present in the kernel" doesn't work, because for this driver there
> > are none, too. (It might be used by a mainline machine via ACPI, but
> > this is even less possible to consider for our judgements than a device
> > tree with such a device and no user but the sysfs PWM interface.)
> 
> Perhaps Clemens and Sven can shed some light into how this driver is
> being used. There clearly seem to be people interested in this driver,
> so why are there no consumers of this upstream. What's keeping people
> from upstreaming device trees that make use of this?

Our DT using the pca9685 is for an embedded board within a product and
that board within is not sold alone.
That's the reason why I did not upstream it yet, because I did not know
if it is acceptable to upstream DTs for boards that are not really of
great use to other people, because they can't (easily) get the hardware,
unless they buy a big beer dispensing system.
If that's not an issue then I am willig to upstream it of course.

Clemens
