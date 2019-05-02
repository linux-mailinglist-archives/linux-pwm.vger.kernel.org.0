Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637691142E
	for <lists+linux-pwm@lfdr.de>; Thu,  2 May 2019 09:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfEBHdd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 May 2019 03:33:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45999 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfEBHdc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 May 2019 03:33:32 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hM6Dg-0003U5-Dp; Thu, 02 May 2019 09:33:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hM6De-0000jb-VY; Thu, 02 May 2019 09:33:26 +0200
Date:   Thu, 2 May 2019 09:33:26 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Message-ID: <20190502073326.sgqgkiexjkipvi27@pengutronix.de>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <CAD=FV=U71u39ZHkBBfAXVAP=_hY-bAw3L7JdhC=36jkUVxPOmQ@mail.gmail.com>
 <20190502091638.0f5a40b0@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502091638.0f5a40b0@collabora.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Boris,

On Thu, May 02, 2019 at 09:16:38AM +0200, Boris Brezillon wrote:
> On Mon, 29 Apr 2019 11:04:20 -0700
> Doug Anderson <dianders@chromium.org> wrote:
> 
> > Hi,
> > 
> > On Sun, Apr 28, 2019 at 11:56 PM Uwe Kleine-K�nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Thu, Apr 18, 2019 at 05:27:05PM -0700, Brian Norris wrote:  
> > > > Hi,
> > > >
> > > > I'm not sure if I'm misreading you, but I thought I'd add here before
> > > > this expires out of my inbox:
> > > >
> > > > On Mon, Apr 8, 2019 at 7:39 AM Uwe Kleine-K�nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:  
> > > > > My intention here is more to make all drivers behave the same way and
> > > > > because only two drivers updated the pwm_state this was the variant I
> > > > > removed.  
> > > >
> > > > To be clear, this patch on its own is probably breaking things. Just
> > > > because the other drivers don't implement the documented behavior
> > > > doesn't mean you should break this driver. Maybe the others just
> > > > aren't used in precise enough scenarios where this matters.
> > > >  
> > > > > When you say that the caller might actually care about the exact
> > > > > parameters I fully agree. In this case however the consumer should be
> > > > > able to know the result before actually applying it. So if you do
> > > > >
> > > > >         pwm_apply_state(pwm, { .period = 17, .duty_cycle = 12, ...})
> > > > >
> > > > > and this results in .period = 100 and .duty_cycle = 0 then probably the
> > > > > bad things you want to know about already happend. So my idea is a new
> > > > > function pwm_round_state() that does the adaptions to pwm_state without
> > > > > applying it to the hardware. After that pwm_apply_state could do the
> > > > > following:
> > > > >
> > > > >         rstate = pwm_round_state(pwm, state)
> > > > >         pwm.apply(pwm, state)
> > > > >         gstate = pwm_get_state(pwm)
> > > > >
> > > > >         if rstate != gstate:
> > > > >                 warn about problems  
> > > >
> > > > For our case (we're using this with pwm-regulator), I don't recall [*]
> > > > we need to be 100% precise about the period, but we do need to be as
> > > > precise as possible with the duty:period ratio -- so once we get the
> > > > "feedback" from the underlying PWM driver what the real period will
> > > > be, we adjust the duty appropriately.  
> > >
> > > I admit that I didn't understood the whole situation and (some) things
> > > are worse with my patches applied. I still think that changing the
> > > caller's state variable is bad design, but of course pwm_get_state
> > > should return the currently implemented configuration.  
> > 
> > Regardless of the pros and cons of the current situation, hopefully
> > we're in agreement that we shouldn't break existing users?  In general
> > I'll probably stay out of the debate as long as we end somewhere that
> > pwm_regulator is able to somehow know the actual state that it
> > programmed into the hardware.
> > 
> > +Boris too in case he has any comments.
> 
> Well, the pwm_round_state() approach sounds okay to me, though I don't
> really see why it's wrong to adjust the state in pwm_apply_state()
> (just like clk_set_rate() will round the rate for you by internally
> calling clk_round_rate() before applying the config).

This are two orthogonal things. The "should pwm_apply_state change the
state argument" isn't really comparable to the clk stuff, as there only
the frequency is provided that is passed by value, not by reference as
the PWM state.

The key argument for me to *not* change it is that it might yield
surprises, still more as today most drivers don't adapt. An -- I admit
constructed, not real-word -- case where adaption would go wrong is:

	pwm_apply_state(pwm1, &mystate);
	pwm_apply_state(pwm2, &mystate);

> Note that pwm_config() is doing exactly the same: it adjusts the
> config to HW caps, excepts in that case you don't know it.

I don't see what you mean here. I don't see any adaption.

> I do understand that some users might want to check how the HW will
> adjust the period/duty before applying the new setup, and in that
> regard, having pwm_round_rate() is a good thing. But in any case, it's
> hard for the user to decide how to adjust things to get what it wants
> (should he increase/decrease the period/duty?).

It depends on the use case. For one of them I suggested an algorithm.

> My impression is that most users care about the duty/period ratio with
> little interest in accurate period settings (as long as it's close
> enough to what they expect of course). For the round-up/down/closest
> aspect, I guess that's also something we can pass to the new API. So,
> rather than passing it a duty in ns, maybe we could pass it a ratio
> (percent is probably not precise enough for some use cases, so we could
> make it per-million).

Yeah, something like that would be good. Still for the device drivers I
would use the callback I suggested because that is easier to implement.
This way the complexity is once in the framework instead of in each
driver.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
