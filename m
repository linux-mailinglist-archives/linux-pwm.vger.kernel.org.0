Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13608FB4E
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Aug 2019 08:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHPGpM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Aug 2019 02:45:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56513 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfHPGpM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Aug 2019 02:45:12 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyVz3-0007BQ-Lk; Fri, 16 Aug 2019 08:45:09 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyVz2-0005zZ-9y; Fri, 16 Aug 2019 08:45:08 +0200
Date:   Fri, 16 Aug 2019 08:45:08 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH v3 2/2] pwm: sprd: Add Spreadtrum PWM support
Message-ID: <20190816064508.5tyimuqcjcr2hbkp@pengutronix.de>
References: <20190814150304.x44lalde3cwp67ge@pengutronix.de>
 <CAMz4kuLiS=cGTA=uEi9ABOVAOb1M0Pcd2a_xU5VsdLo1DGd0Hg@mail.gmail.com>
 <20190815061540.763ue2ogkvuyhzcu@pengutronix.de>
 <CAMz4kuL_74V3M-8Zo99GnLaYbmgfQXO-h0Yz5qeXLQQ0ZR3TkA@mail.gmail.com>
 <20190815085452.2cipewq3l3krnwzv@pengutronix.de>
 <CAMz4kuJs7pCXWyWd_WMK24JeLOzdVC8zPacRTp91nyTYDDdk5g@mail.gmail.com>
 <20190815101147.azbbjcvafwjx67wc@pengutronix.de>
 <CAMz4ku+AAGC6TgxOA5EZGFeqpsq_Q8=S+DkDk9Rm_G=yAshJ0w@mail.gmail.com>
 <20190815122518.hzy57s635ubohywh@pengutronix.de>
 <CAMz4kuJBbTrR9+7XfDhRtmJovFJnne_RPGrdOYe09mdRDrDrig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMz4kuJBbTrR9+7XfDhRtmJovFJnne_RPGrdOYe09mdRDrDrig@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Baolin,

On Fri, Aug 16, 2019 at 10:44:41AM +0800, Baolin Wang wrote:
> On Thu, 15 Aug 2019 at 20:25, Uwe Kleine-K�nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Thu, Aug 15, 2019 at 07:05:53PM +0800, Baolin Wang wrote:
> > > On Thu, 15 Aug 2019 at 18:11, Uwe Kleine-K�nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Thu, Aug 15, 2019 at 05:34:02PM +0800, Baolin Wang wrote:
> > > > > On Thu, 15 Aug 2019 at 16:54, Uwe Kleine-K�nig
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > On Thu, Aug 15, 2019 at 04:16:32PM +0800, Baolin Wang wrote:
> > > > > > > On Thu, 15 Aug 2019 at 14:15, Uwe Kleine-K�nig
> > > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > > On Thu, Aug 15, 2019 at 11:34:27AM +0800, Baolin Wang wrote:
> > > > > > > > > On Wed, 14 Aug 2019 at 23:03, Uwe Kleine-K�nig
> > > > > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > > > > On Wed, Aug 14, 2019 at 08:46:11PM +0800, Baolin Wang wrote:
> > > > > > > > > > > +      * To keep the maths simple we're always using MOD = SPRD_PWM_MOD_MAX.
> > > > > > > > > >
> > > > > > > > > > Did you spend some thoughts about how wrong your period can get because
> > > > > > > > > > of that "lazyness"?
> > > > > > > > > >
> > > > > > > > > > Let's assume a clk rate of 100/3 MHz. Then the available period lengths
> > > > > > > > > > are:
> > > > > > > > > >
> > > > > > > > > >         PRESCALE =  0  ->  period =   7.65 �s
> > > > > > > > > >         PRESCALE =  1  ->  period =  15.30 �s
> > > > > > > > > >         ...
> > > > > > > > > >         PRESCALE = 17  ->  period = 137.70 �s
> > > > > > > > > >         PRESCALE = 18  ->  period = 145.35 �s
> > > > > > > > > >
> > > > > > > > > > So the error can be up to (nearly) 7.65 �s (or in general
> > > > > > > > >
> > > > > > > > > Yes, but for our use case (pwm backlight), the precision can meet our
> > > > > > > > > requirement. Moreover, we usually do not change the period, just
> > > > > > > > > adjust the duty to change the back light.
> > > > > > > >
> > > > > > > > Is this a license requirement for you SoC to only drive a backlight with
> > > > > > > > the PWM? The idea of having a PWM driver on your platform is that it can
> > > > > > > > also be used to control a step motor or a laser.
> > > > > > >
> > > > > > > Not a license requirement. Until now we have not got any higher
> > > > > > > precision requirements, and we've run this driver for many years in
> > > > > > > our downstream kernel.
> > > > > >
> > > > > > I understood that you're not ambitious to do something better than "it
> > > > > > worked for years".
> > > > >
> > > > > How do you know that?
> > > >
> > > > I showed you how you could match the requested PWM output better and
> > > > you refused telling it worked for years and the added precision isn't
> > > > necessary for a backlight.
> > >
> > > Please I said the reason, it is not that I do not want a better
> > > precision. The problem is we do not know how much precision to be
> > > asked by users if no use case
> >
> > I don't understand the problem here. If you are asked for period =
> > 145340 ns and configure the hardware to yield 137700 ns in reply to that
> > but you could provide 144780 ns I don't understand why you need a use
> > case as 144780 ns is objectively better than 137700 ns. A better match
> 
> You are wrong, we will provide 145350 ns with
> DIV_ROUND_CLOSEST_ULL()., which is better than your 144780.

There are two problems with your statement:

 - You're ignoring the fact that I base my argumentation on not using
   DIV_ROUND_CLOSEST_ULL because it has downsides I pointed out to you.
   If my suggested algorithm targeted a closest match (and not
   closest-but-not-bigger) it would pick 145350 ns, too. (I didn't check
   if something in the interval [145331, 145349] could be achieved. If
   there is, this should of course be preferred.)
   I obviously would have to pick a different example request to show
   that "targeting nearest with MOD always 255" is for some requests
   worse (probably by a similar factor) than "targeting nearest".
   It's not surprising that your apple is a better apple than my orange.

 - It's not objective that when 145340 ns was requested 145350 ns is
   better than 144780 ns. Some approximations are obviously better than
   others, but these two are not comparable in a way that all PWM
   consumers agree.

I'm not perfect and I do mistakes of course. But I'm still convinced
that my argumentation here is right.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
