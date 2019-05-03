Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC7041343C
	for <lists+linux-pwm@lfdr.de>; Fri,  3 May 2019 21:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfECT7L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 May 2019 15:59:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41101 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfECT7L (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 May 2019 15:59:11 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hMeKp-0007oB-J3; Fri, 03 May 2019 21:59:07 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hMeKn-0006un-1K; Fri, 03 May 2019 21:59:05 +0200
Date:   Fri, 3 May 2019 21:59:05 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Message-ID: <20190503195904.zbqdfpowks6vwhv6@pengutronix.de>
References: <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
 <20190502091638.0f5a40b0@collabora.com>
 <20190502073326.sgqgkiexjkipvi27@pengutronix.de>
 <20190502100951.23ef9ed1@collabora.com>
 <20190502084243.anz5myut63g4torn@pengutronix.de>
 <20190503105915.GA32400@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503105915.GA32400@ulmo>
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

On Fri, May 03, 2019 at 12:59:15PM +0200, Thierry Reding wrote:
> On Thu, May 02, 2019 at 10:42:43AM +0200, Uwe Kleine-König wrote:
> > On Thu, May 02, 2019 at 10:09:51AM +0200, Boris Brezillon wrote:
> > > On Thu, 2 May 2019 09:33:26 +0200
> > > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Thu, May 02, 2019 at 09:16:38AM +0200, Boris Brezillon wrote:
> > > > > I do understand that some users might want to check how the HW will
> > > > > adjust the period/duty before applying the new setup, and in that
> > > > > regard, having pwm_round_rate() is a good thing. But in any case, it's
> > > > > hard for the user to decide how to adjust things to get what it wants
> > > > > (should he increase/decrease the period/duty?).  

Whenever I wrote pwm_round_rate I actually meant pwm_round_state.

> > > > It depends on the use case. For one of them I suggested an algorithm.
> > > 
> > > Yes, I was just trying to say that passing a PWM state to
> > > pwm_round_state() is not enough, we need extra info if we want to make
> > > it useful, like the rounding policy, the accepted deviation on period,
> > > duty or the duty/period ratio, ....
> > 
> > Ack. My suggestion is that round_rate should do:
> > 
> > 	if polarity is unsupported:
> > 		polarity = !polarity
> > 		duty_cycle = period - duty_cycle
> 
> This should really be up to the consumer. The PWM framework or driver
> doesn't know whether or not the consumer cares about the polarity or
> whether it only cares about the power output.

You don't understand my idea. If the hardware cannot implement the
requested state the round_state function has to return a best
approximation according to some rules. After that the consumer can
decide if they want that or not. As the hardware isn't touched nothing
bad happens.

(Well, apart from that I still cannot imagine a use case where with the
current possibilities of the PWM API a consumer can really care about
the polarity.)

> > 	period = biggest supportable period <= requested period, 0 if no
> > 		such period exists.
> > 
> > 	duty_cycle = biggest supportable duty cycle <= requested
> > 		duty_cycle, 0 if no such value exists
> 
> This doesn't really work. We need some way to detect "value does not
> exist" that is different from value == 0, because value == 0 is a
> legitimate use-case.

Same as above. If I asked for duty_cycle = 5 ns and get back duty_cycle
= 0 ns this means the driver cannot implement a duty_cycle in the
interval (0, 5] ns, nothing more. 

> > This would allow to let the consumer (or framework helper function)
> > decide which deviation is ok.
> 
> So what's the consumer supposed to do if it gets back these values?

If the value is then known to be the best (or good enough if the
consumer doesn't really care), it is used. Otherwise a different state
is rounded or the consumer gives up if it becomes clear that the
hardware cannot satisfy their needs.

> How does it know how to scale them if the deviation is not okay?

It depends on what the consumer considers optimal. I already gave one
example code how I think pwm_round_state should be used. Another is:

If the consumer wants a period as near as possible to a given target
period the algorithm with the round_state function as suggested would
look as follows (duty_cycle ignored here for the ease of discussion):

		mystate.period = target_period
		...
		pwm_round_state(pwm, &mystate)

		if (mystate.period == target_period)
			return mystate.period

		mystate.period = 2 * target_period - mystate.period
		pwm_round_state(pwm, &mystate)

		if (mystate.period < target_period)
			return mystate.period;

		do {
			best_bigger = mystate.period
			mystate.period -= 1
			pwm_round_state(pwm, &mystate)
		} while (mystate.period > target_period)

		return best_bigger

> What in case the hardware can do achieve a good period that is
> slightly bigger than the requested period and which would give a very
> good result?

The above algorithm answers this question.

Theoretically the requirements for pwm_round_state could be changed such
that it is supposed to yield the nearest hit instead of the next smaller
one, but this only shifts the complexity to a different area. (I think
my suggestion is the better one though because the math for the lowlevel
drivers and also the helper functions is easier then. Also the search
terminates earlier if the consumer wants something bigger than the
driver can implement. Moreover "biggest value not bigger than requested"
is (IMHO) easier to understand for the affected coders than "nearest
value" because there are more ugly special cases. (Consider I ask for
(duty_cycle, period) = (10, 20) and the driver can implement (9, 18) and
(12, 21). Which of these is nearer?))

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
