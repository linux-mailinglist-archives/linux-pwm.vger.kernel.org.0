Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4401B19840E
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgC3TRB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 15:17:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgC3TQ7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 15:16:59 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jIzu3-0005Tx-LK; Mon, 30 Mar 2020 21:16:55 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jIzu2-00066n-JR; Mon, 30 Mar 2020 21:16:54 +0200
Date:   Mon, 30 Mar 2020 21:16:54 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200330191654.waoocllctanh5nk5@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200330141436.GG2431644@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Mon, Mar 30, 2020 at 04:14:36PM +0200, Thierry Reding wrote:
> On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-König wrote:
> > On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> > > Only the Timer control register(TCLR) cannot be updated when the timer
> > > is running. Registers like Counter register(TCRR), loader register(TLDR),
> > > match register(TMAR) can be updated when the counter is running. Since
> > > TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> > > timer for period/duty_cycle update.
> > 
> > I'm not sure what is sensible here. Stopping the PWM for a short period
> > is bad, but maybe emitting a wrong period isn't better. You can however
> > optimise it if only one of period or duty_cycle changes.
> > 
> > @Thierry, what is your position here? I tend to say a short stop is
> > preferable.
> 
> It's not clear to me from the above description how exactly the device
> behaves, but I suspect that it may latch the values in those registers
> and only update the actual signal output once a period has finished. I
> know of a couple of other devices that do that, so it wouldn't be
> surprising.
> 
> Even if that was not the case, I think this is just the kind of thing
> that we have to live with. Sometimes it just isn't possible to have all
> supported devices adhere strictly to an API. So I think the best we can
> do is have an API that loosely defines what's supposed to happen and
> make a best effort to implement those semantics. If a device deviates
> slightly from those expectations, we can always cross fingers and hope
> that things still work. And it looks like they are.
> 
> So I think if Lokesh and Tony agree that this is the right thing to do
> and have verified that things still work after this, that's about as
> good as it's going to get.

I'd say this isn't for the platform people to decide. My position here
is that the PWM drivers should behave as uniform as possible to minimize
surprises for consumers. And so it's a "PWM decision" that is to be made
here, not an "omap decision".

> I know this is perhaps cheating a little, or turning a blind eye, but I
> don't know what the alternative would be. Do we want to tell people that
> a given PWM controller can't be used if it doesn't work according to our
> expectations? That's hard to argue if that controller works just fine
> for all known use-cases.

I'd like have some official policy here which of the alternatives is the
preferred cheat.

The situation here is that period and duty_cycle cannot be updated
atomically. So the two options are:

 - stop shortly
 - update with hardware running and maybe emit a broken period

I tend to say "stop shortly" is the better alternative.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
