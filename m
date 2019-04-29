Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA674E356
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Apr 2019 15:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfD2NLb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Apr 2019 09:11:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48079 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2NLa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Apr 2019 09:11:30 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hL648-0007RH-17; Mon, 29 Apr 2019 15:11:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hL647-0008FN-4r; Mon, 29 Apr 2019 15:11:27 +0200
Date:   Mon, 29 Apr 2019 15:11:27 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the
 caller of pwm_apply_state()
Message-ID: <20190429131127.x535uhhtputb7zwl@pengutronix.de>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <20190429111855.GC7747@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190429111855.GC7747@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Apr 29, 2019 at 01:18:55PM +0200, Thierry Reding wrote:
> On Mon, Apr 29, 2019 at 08:56:13AM +0200, Uwe Kleine-König wrote:
> > On Thu, Apr 18, 2019 at 05:27:05PM -0700, Brian Norris wrote:
> > > Hi,
> > > 
> > > I'm not sure if I'm misreading you, but I thought I'd add here before
> > > this expires out of my inbox:
> > > 
> > > On Mon, Apr 8, 2019 at 7:39 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > My intention here is more to make all drivers behave the same way and
> > > > because only two drivers updated the pwm_state this was the variant I
> > > > removed.
> > > 
> > > To be clear, this patch on its own is probably breaking things. Just
> > > because the other drivers don't implement the documented behavior
> > > doesn't mean you should break this driver. Maybe the others just
> > > aren't used in precise enough scenarios where this matters.
> > > 
> > > > When you say that the caller might actually care about the exact
> > > > parameters I fully agree. In this case however the consumer should be
> > > > able to know the result before actually applying it. So if you do
> > > >
> > > >         pwm_apply_state(pwm, { .period = 17, .duty_cycle = 12, ...})
> > > >
> > > > and this results in .period = 100 and .duty_cycle = 0 then probably the
> > > > bad things you want to know about already happend. So my idea is a new
> > > > function pwm_round_state() that does the adaptions to pwm_state without
> > > > applying it to the hardware. After that pwm_apply_state could do the
> > > > following:
> > > >
> > > >         rstate = pwm_round_state(pwm, state)
> > > >         pwm.apply(pwm, state)
> > > >         gstate = pwm_get_state(pwm)
> > > >
> > > >         if rstate != gstate:
> > > >                 warn about problems
> > > 
> > > For our case (we're using this with pwm-regulator), I don't recall [*]
> > > we need to be 100% precise about the period, but we do need to be as
> > > precise as possible with the duty:period ratio -- so once we get the
> > > "feedback" from the underlying PWM driver what the real period will
> > > be, we adjust the duty appropriately.
> > 
> > I admit that I didn't understood the whole situation and (some) things
> > are worse with my patches applied. I still think that changing the
> > caller's state variable is bad design, but of course pwm_get_state
> > should return the currently implemented configuration.
> > 
> > > So I don't see that "warning" would really help for this particular case.
> > > 
> > > > But before doing that I think it would be sensible to also fix the rules
> > > > how the round_state callback is supposed to round.
> > > 
> > > I'm not quite sure I grok exactly what you're planning, but I would
> > > much appreciate if you didn't break things on the way toward fixing
> > > them ;)
> > 
> > There are currently no rules how the driver should behave for example if
> > the consumer requests
> > 
> > 	.duty_cycle = 10, .period = 50
> > 
> > and the hardware can only implement multiples of 3 for both values. The
> > obvious candidates are:
> > 
> >  - .duty_cycle = 9, .period = 51 (round nearest for both)
> >  - .duty_cycle = 12, .period = 51 (round up)
> >  - .duty_cycle = 9, .period = 48 (round down)
> >  - .duty_cycle = 9, .period = 45 (round duty_cycle and keep proportion)
> >  - return error (which code?)
> > 
> > And there are some other variants (e.g. round duty_cycle to nearest and
> > period in the same direction) that might be sensible.
> 
> The problem is that probably all of the above are valid, though maybe
> not for all cases. The choice of algorithm probably depends on both the
> PWM driver and the consumer, so I don't think fixing things to one such
> algorithm is going to improve anything.

But if you have pwm_round_state (which implements rounding down for
example) you could easily implement a helper that rounds nearest or up.
If however each driver rounds the way it prefers coming up with a helper
for rounding up is considerably harder.

> > Also it should be possible to know the result before actually
> > configuring the hardware. Otherwise things might already go wrong
> > because the driver implements a setting that is too far from the
> > requested configuration.
> 
> I agree.
> 
> Perhaps somebody with more experience with pwm-regulator can chime in
> here, but it sounds to me like if you really want to accurately output a
> voltage, you may want to hand-tune the duty-cycle/period pairs that are
> used for pwm-regulator.

This might be more ugly than needed because then you have to setup the
table in dependance of the used PWM. Looking at the pwm-regulator code I
think the binding is badly worded. The "Duty-Cycle" parameter is used as
second parameter to pwm_set_relative_duty_cycle (with scale = 100). So
with the regulator defined in the Voltage Table Example of
Documentation/devicetree/bindings/regulator/pwm-regulator.txt you'd have
to configure

	.duty_cycle = 2534, .period = 8448
	
to get 1.056 V.

Note that my considerations are not only about pwm-regulators.

Also in general I prefer a suitable and well reviewed algorithm (if
possible) over a requirement to provide a hand-tuned table of values in
a machine-specific device tree.

> According to the device tree bindings there's
> already support for a voltage table mode where an exact duty-cycle to
> output voltage correspondence is defined. This is as opposed to the
> continuous voltage mode where the duty cycle is linearly interpolated
> based on the requested output voltage.
> 
> pwm-regulator in voltage table mode could run in "strict" mode with zero
> deviation allowed, on the assumption that duty-cycle values were hand-
> picked to give the desired results. For continuous voltage mode it
> probably doesn't matter all that much, since very exact results can't be
> guaranteed anyway.

I don't understand the last sentence? Why is it impossible to get exact
results in continuous voltage mode?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
