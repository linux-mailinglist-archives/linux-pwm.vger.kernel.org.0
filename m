Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0A9114091
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2019 13:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfLEMJr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Dec 2019 07:09:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55941 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfLEMJr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Dec 2019 07:09:47 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1icpx2-0002bk-RP; Thu, 05 Dec 2019 13:09:44 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1icpx2-0003wW-58; Thu, 05 Dec 2019 13:09:44 +0100
Date:   Thu, 5 Dec 2019 13:09:44 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pwm: Changes for v5.5-rc1
Message-ID: <20191205120944.jxcculyf46bu2k67@pengutronix.de>
References: <20191205061044.1006766-1-thierry.reding@gmail.com>
 <20191205075958.jrz3xuthyh7wv6uu@pengutronix.de>
 <20191205084102.GA1401169@ulmo>
 <20191205100535.y7avzoswkxe43py7@pengutronix.de>
 <20191205110425.GA1498132@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191205110425.GA1498132@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Thu, Dec 05, 2019 at 12:04:25PM +0100, Thierry Reding wrote:
> On Thu, Dec 05, 2019 at 11:05:35AM +0100, Uwe Kleine-König wrote:
> > On Thu, Dec 05, 2019 at 09:41:02AM +0100, Thierry Reding wrote:
> > > Review for this came in after v5.4-rc7, so I didn't consider it for
> > > v5.5. I'll pick it up after v5.5-rc1.
> > 
> > I got Steven's mail on Oct 24 which is the week between -rc4 and -rc5,
> > but ok, I won't argue.
> 
> Both my inbox and patchwork say that the email arrived on November 13.

Ah, you're right. Oct 24 was the date I sent the patch. Don't know what
I saw before. Please forgive my wrong correction.

> > > >  - The series starting with "pwm: omap-dmtimer: remove pwmchip in
> > > >    .remove before making it unfunctional" from November which IMHO is
> > > >    simple and contains two fixes
> > > >    (https://patchwork.ozlabs.org/project/linux-pwm/list/?series=142030)
> > > 
> > > Same here.
> > 
> > Does "after v5.5-rc1" mean "for v5.5" or "for v5.6-rc1". I agree that
> > the tracing stuff is merge window material (very useful though in my
> > eyes) while the omap-dmtimer series (at least the first 3 of 4 patches)
> > is about fixes.
> 
> These all change code that's been like this for more than 4 years and
> nobody's ever reported a bug.

That nobody uncovered a certain bug before should not stop us fixing it
quickly.

> The very worst that can happen here is that we leak a device
> reference, but these are platform devices, so they aren't going to go
> anywhere anyway.

Unless someone unloads the driver or unbinds it from the device. Even if
you question that this warrants an urgent fix (which I disagree to),
then patch 2 fixes an error path and patch 3 an unconditional resouce
leak (both in .probe).

> > > > And I'm still waiting for feedback on
> > > > 
> > > >  - "Documentation: pwm: rework documentation for the framework" (since
> > > >    January)
> > > 
> > > Please resend this, I can't find it in my inbox.
> > 
> > :-|, given that I sent this already twice, pinged several times
> > (https://patchwork.ozlabs.org/patch/1021566/,
> > https://patchwork.ozlabs.org/patch/1000709/) and also asked at least
> > once before in a mail where I pinged several patches using a list.
> 
> I find patchwork always difficult for reviewing, but that patch is
> particularly difficult to review. You're basically rewriting all of the
> documentation in a way that you think is better. It'd be much easier to
> review if this was done more incrementally.
> 
> It looks like your goals could be easily met by just extending the
> existing documentation, or bringing it up-to-date with the API.

OK, will try to split it in smaller chunks.

> > > >  - "pwm: add debug knob to help driver authors" (since August)
> > > 
> > > My recollection is that this flagged a bunch of issues right out of the
> > > box, so I'm hesitant to apply it without wider concensus that we want
> > > this, or some effort to address the issues that this flags.
> > 
> > I didn't want you to apply it. That it is not ready for that is out of
> > the question. I assume the patch doesn't apply anymore and needs work
> > for sure. The last mail in the respective thread had a single paragraph:
> > 
> > 	do you consider the idea here worthwile? If so I'd update the
> > 	patch to current mainline and address the feedback I got so far.
> > 
> > This is still interesting, as I don't want to spend my time working on
> > an idea that is then turned down in the end for conceptual reasons.
> 
> There's nothing conceptually wrong about it. The one problem that I see
> with it is that we can't force people to use it because it's noisy when
> things go wrong, and they currently do go wrong. On the other hand, if
> we don't enforce its use, developers are likely to just ignore its
> existence.

I agree that it doesn't help when a driver author has this disabled. But
still it helps to catch problems if testers know it or during review
something is catched and then you only need to point to this Kconfig
setting instead of referencing the documentation or otherwise explain
what you want.
And even if there is only a 0.2 chance that a prospective pwm driver
author will enable it and so have a better driver in patch submission
round 1 it's already worth the effort in my eyes.

All in all I think "but some might not profit unless you force them"
isn't a reason good enough to not do something for those who might
notice and benefit from your work. And even if it's only me who benefits
that's good enough, too (assuming there are no downsides for others).

> So I think we need to get drivers into a little better shape so that we

For getting there having this knob configurable (and default off) is
already helpful.

> eliminate at least all of the issues that currently exist. Then we can
> merge this and maybe opportunistically enforce this during a release
> cycle to see if there's any fallout.

And if there is fallout just having to change some Kconfig magic to
disable the checks would be good. So having PWM_DEBUG seems like a good
idea to me.

Not sure that defaulting to all these checks is a good idea as at least
some of them introduce some delays waiting for completed periods. Having
this configurable seems to work for other subsystems just fine (judging
from looking at the output of 

	git grep DEBUG drivers/*/Kconfig

).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
