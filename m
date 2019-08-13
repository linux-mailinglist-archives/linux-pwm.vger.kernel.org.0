Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDB868B89B
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Aug 2019 14:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfHMMdh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Aug 2019 08:33:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48451 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHMMdg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Aug 2019 08:33:36 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxVzZ-0000ny-8r; Tue, 13 Aug 2019 14:33:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hxVzX-0004N0-LM; Tue, 13 Aug 2019 14:33:31 +0200
Date:   Tue, 13 Aug 2019 14:33:31 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
Message-ID: <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
References: <20190809123031.24219-1-paul@crapouillou.net>
 <20190809123031.24219-5-paul@crapouillou.net>
 <20190809170551.u4ybilf5ay2rsvnn@pengutronix.de>
 <1565370885.2091.2@crapouillou.net>
 <20190812061520.lwzk3us4ginwwxov@pengutronix.de>
 <1565642590.2007.1@crapouillou.net>
 <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
 <1565648183.2007.3@crapouillou.net>
 <20190813052726.g37upws5rlvrszc4@pengutronix.de>
 <1565694066.1856.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565694066.1856.1@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Paul,

On Tue, Aug 13, 2019 at 01:01:06PM +0200, Paul Cercueil wrote:
> Le mar. 13 août 2019 à 7:27, Uwe =?iso-8859-1?q?Kleine-K=F6nig?=
> <u.kleine-koenig@pengutronix.de> a écrit :
> > [adding Stephen Boyd to Cc]
> > 
> > On Tue, Aug 13, 2019 at 12:16:23AM +0200, Paul Cercueil wrote:
> > > Le lun. 12 août 2019 à 23:48, Uwe Kleine-König a écrit :
> > > > On Mon, Aug 12, 2019 at 10:43:10PM +0200, Paul Cercueil wrote:
> > > > > Le lun. 12 août 2019 à 8:15, Uwe Kleine-König a écrit :
> > > > > > On Fri, Aug 09, 2019 at 07:14:45PM +0200, Paul Cercueil wrote:
> > > > > > > Le ven. 9 août 2019 à 19:05, Uwe Kleine-König a écrit :
> > > > > > > > On Fri, Aug 09, 2019 at 02:30:28PM +0200, Paul Cercueil wrote:
> > > > > > > > > [...]
> > > > > > > > >  +	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
> > > > > > > > >  +	ret = clk_set_max_rate(clk, parent_rate);
> > > > > > > >
> > > > > > > > What is the purpose of this call? IIUC this limits the allowed range of
> > > > > > > > rates for clk. I assume the idea is to prevent other consumers to change
> > > > > > > > the rate in a way that makes it unsuitable for this pwm. But this only
> > > > > > > > makes sense if you had a notifier for clk changes, doesn't it? I'm
> > > > > > > > confused.
> > > > > > >
> > > > > > > Nothing like that. The second call to clk_set_max_rate() might have set
> > > > > > > a maximum clock rate that's lower than the parent's rate, and we want to
> > > > > > > undo that.
> > > > > >
> > > > > > I still don't get the purpose of this call. Why do you limit the clock
> > > > > > rate at all?
> > > > >
> > > > > As it says below, we "limit the clock to a maximum rate that still gives
> > > > > us a period value which fits in 16 bits". So that the computed hardware
> > > > > values won't overflow.
> > > >
> > > > But why not just using clk_set_rate? You want to have the clock running
> > > > at a certain rate, not any rate below that certain rate, don't you?
> > > 
> > >  I'll let yourself answer yourself:
> > >  https://patchwork.ozlabs.org/patch/1018969/
> > 
> > In that thread I claimed that you used clk_round_rate wrongly, not that
> > you should use clk_set_max_rate(). (The claim was somewhat weakend by
> > Stephen, but still I think that clk_round_rate is the right approach.)
> 
> Well, you said that I shouln't rely on the fact that clk_round_rate() will
> round down. That completely defeats the previous algorithm. So please tell
> me how to use it correctly, because I don't see it.

Using clk_round_rate correctly without additional knowledge is hard. If
you assume at least some sane behaviour you'd still have to call it
multiple times. Assuming maxrate is the maximal rate you can handle
without overflowing your PWM registers you have to do:

	rate = maxrate;
	rounded_rate = clk_round_rate(clk, rate);
	while (rounded_rate > rate) {
		if (rate < rounded_rate - rate) {
			/*
			 * clk doesn't support a rate smaller than
			 * maxrate (or the round_rate callback doesn't
			 * round consistently).
			 */
			 return -ESOMETHING;
		}
		rate = rate - (rounded_rate - rate)
		rounded_rate = clk_round_rate(clk, rate);
	}

	return rate;

Probably it would be sensible to put that in a function provided by the
clk framework (maybe call it clk_round_rate_down and maybe with
additional checks).

> I came up with a much smarter alternative, that doesn't rely on the rounding
> method of clk_round_rate, and which is better overall (no loop needed). It
> sounds to me like you're bashing the code without making the effort to
> understand what it does.
> 
> Thierry called it a "neat trick"
> (https://patchwork.kernel.org/patch/10836879/) so it cannot be as bad as you
> say.

Either that or Thierry failed to see the downside. The obvious downside
is that once you set the period to something long (and so the clk was
limited to a small frequency) you never make the clock any faster
afterwards.

Also I wonder how clk_set_max_rate() is supposed to be used like that or
if instead some work should be invested to make it easier for clk
consumers to use clk_round_rate() (e.g. by providing helper functions
like the above). Stephen, can you shed some light into this?
 
> > The upside of clk_round_rate is that it allows you to test for the
> > capabilities of the clock without actually changing it before you found
> > a setting you consider to be good.
> 
> I know what clk_round_rate() is for. But here we don't do trial-and-error to
> find the first highest clock rate that works, we compute the maximum clock
> we can use and limit the clock rate to that.
> 
> > 
> > >  It's enough to run it below a certain rate, yes. The actual rate
> > > doesn't
> > >  actually matter that much.
> > 
> > 1 Hz would be fine? I doubt it.
> 
> We use the highest possible clock rate. We wouldn't use 1 Hz unless it's the
> highest clock rate available.

That's wrong. If the clk already runs at 1 Hz and you call
clk_set_max_rate(rate, somethingincrediblehigh); it still runs at 1 Hz
afterwards. (Unless I missed something.)

> > > > >  E.g. if at a rate of 12 MHz your computed hardware value for the period
> > > > >  is 0xf000, then at a rate of 24 MHz it won't fit in 16 bits. So the clock
> > > > >  rate must be reduced to the highest possible that will still give you a
> > > > >  < 16-bit value.
> > > > >
> > > > >  We always want the highest possible clock rate that works, for the sake of
> > > > >  precision.
> > > >
> > > > This is dubious; but ok to keep the driver simple. (Consider a PWM that
> > > > can run at i MHz for i in [1, .. 30]. If a period of 120 ns and a duty
> > > > cycle of 40 ns is requested you can get an exact match with 25 MHz, but
> > > > not with 30 MHz.)
> > >
> > > The clock rate is actually (parent_rate >> (2 * x) )
> > > for x = 0, 1, 2, ...
> > >
> > > So if your parent_rate is 30 MHz the next valid one is 7.5 MHz, and the
> > > next one is 1.875 MHz. It'd be very unlikely that you get a better match at
> > > a lower clock.
> > 
> > If the smaller freqs are all dividers of the fastest that's fine. Please
> > note in a code comment that you're assuming this.
> 
> No, I am not assuming this. The current driver just picks the highest clock
> rate that works. We're not changing the behaviour here.

But you hide it behind clk API functions that don't guarantee this
behaviour. And even if it works for you it might not for the next person
who copies your code to support another hardware.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
