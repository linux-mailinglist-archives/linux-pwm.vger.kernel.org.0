Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DEF294
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Apr 2019 11:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfD3JOo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Apr 2019 05:14:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33243 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfD3JOo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Apr 2019 05:14:44 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hLOqX-0000Qt-9W; Tue, 30 Apr 2019 11:14:41 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hLOqV-00074D-6L; Tue, 30 Apr 2019 11:14:39 +0200
Date:   Tue, 30 Apr 2019 11:14:39 +0200
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
Message-ID: <20190430091439.vgr2thlqq3m43hks@pengutronix.de>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
 <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
 <1707507.TOMHpQGrZ7@phil>
 <CAD=FV=WZHouhGcxOgNG3006XajJQaAp0uq9WjeKRikQx1ru4TA@mail.gmail.com>
 <20190408143914.uucb5dwafq3cnsmk@pengutronix.de>
 <CA+ASDXO=szekU97iTDK9vqWjT+JtAKeCNTyoY=8aSi5d+v4mkA@mail.gmail.com>
 <20190429065613.n52uwgys5eugmssd@pengutronix.de>
 <20190429111855.GC7747@ulmo>
 <20190429131127.x535uhhtputb7zwl@pengutronix.de>
 <20190429162847.GE7747@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190429162847.GE7747@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Mon, Apr 29, 2019 at 06:28:47PM +0200, Thierry Reding wrote:
> On Mon, Apr 29, 2019 at 03:11:27PM +0200, Uwe Kleine-König wrote:
> > On Mon, Apr 29, 2019 at 01:18:55PM +0200, Thierry Reding wrote:
> > > On Mon, Apr 29, 2019 at 08:56:13AM +0200, Uwe Kleine-König wrote:
> > > > There are currently no rules how the driver should behave for example if
> > > > the consumer requests
> > > > 
> > > > 	.duty_cycle = 10, .period = 50
> > > > 
> > > > and the hardware can only implement multiples of 3 for both values. The
> > > > obvious candidates are:
> > > > 
> > > >  - .duty_cycle = 9, .period = 51 (round nearest for both)
> > > >  - .duty_cycle = 12, .period = 51 (round up)
> > > >  - .duty_cycle = 9, .period = 48 (round down)
> > > >  - .duty_cycle = 9, .period = 45 (round duty_cycle and keep proportion)
> > > >  - return error (which code?)
> > > > 
> > > > And there are some other variants (e.g. round duty_cycle to nearest and
> > > > period in the same direction) that might be sensible.
> > > 
> > > The problem is that probably all of the above are valid, though maybe
> > > not for all cases. The choice of algorithm probably depends on both the
> > > PWM driver and the consumer, so I don't think fixing things to one such
> > > algorithm is going to improve anything.
> > 
> > But if you have pwm_round_state (which implements rounding down for
> > example) you could easily implement a helper that rounds nearest or up.
> > If however each driver rounds the way it prefers coming up with a helper
> > for rounding up is considerably harder.
> 
> pwm_round_state() is fundamentally racy. What if, for example, you have
> two consumers racing to set two PWMs provided by the same controller. If
> you have some dependency between the two PWMs (perhaps they need to
> share the same divider or something like that), then between the time
> where pwm_round_state() returns and pwm_apply_state() is called, the
> results of the pwm_round_state() may no longer be valid.

Yes, that's somewhat right. That is a problem that all approaches have
that allow to determine the result of a given request without actually
applying it. (Same for clk_round_rate() for example.) I think that it
won't be possible to map all use cases without such an approach however.

But the effect of the race can be minimised if I calculate a good
PWM state (which might not be optimal because of the race) and then use
pwm_apply_state_exact().

Having said that, we already have a very similar problem today. Each
driver that does clk_get_rate without installing a notifier for
frequency changes might suffer from unexpected results if another clk
consumer changes the given clk.

> > > > Also it should be possible to know the result before actually
> > > > configuring the hardware. Otherwise things might already go wrong
> > > > because the driver implements a setting that is too far from the
> > > > requested configuration.
> > > 
> > > I agree.
> > > 
> > > Perhaps somebody with more experience with pwm-regulator can chime in
> > > here, but it sounds to me like if you really want to accurately output a
> > > voltage, you may want to hand-tune the duty-cycle/period pairs that are
> > > used for pwm-regulator.
> > 
> > This might be more ugly than needed because then you have to setup the
> > table in dependance of the used PWM.
> 
> Well, that's what you have to do anyway. I mean, you can't write one
> voltage table that works for one device and then expect it to work for
> every other device. DT by definition is a board-level definition.

We're talking about different things here. I want that if you assembled
the same type of pwm-regulator to an imx machine and a rockchip machine
the representation of this regulator in the respective device trees
would look identical (apart from the handle to the PWM). Of course this
doesn't work for two different types of regulators.

The datasheet of the regulator for sure is also agnostic to the actual
PWM driving the input and provides a generic table or formula.

> > Looking at the pwm-regulator code I
> > think the binding is badly worded. The "Duty-Cycle" parameter is used as
> > second parameter to pwm_set_relative_duty_cycle (with scale = 100). So
> > with the regulator defined in the Voltage Table Example of
> > Documentation/devicetree/bindings/regulator/pwm-regulator.txt you'd have
> > to configure
> > 
> > 	.duty_cycle = 2534, .period = 8448
> > 	
> > to get 1.056 V.
> 
> Hm... indeed. Requiring the duty-cycle to be in percent is not a good
> idea. That's going to lead to rounding one way or another.
> 
> > 
> > Note that my considerations are not only about pwm-regulators.
> > 
> > Also in general I prefer a suitable and well reviewed algorithm (if
> > possible) over a requirement to provide a hand-tuned table of values in
> > a machine-specific device tree.
> 
> I agree that an algorithm is usually better, but if you can't create an
> algorithm that works, it's usually better to have a hand-coded fallback
> rather than have no working system at all.

We're in agreement here. And as there are cases where a suitable
algorithm exists, we need some support in the PWM API to actually
implement these. pwm_round_state is the best I'm aware of as it is
powerful enough to map all requirements I currently think necessary and
still it is not too hard to implement the needed callback for the device
drivers.

> > > According to the device tree bindings there's
> > > already support for a voltage table mode where an exact duty-cycle to
> > > output voltage correspondence is defined. This is as opposed to the
> > > continuous voltage mode where the duty cycle is linearly interpolated
> > > based on the requested output voltage.
> > > 
> > > pwm-regulator in voltage table mode could run in "strict" mode with zero
> > > deviation allowed, on the assumption that duty-cycle values were hand-
> > > picked to give the desired results. For continuous voltage mode it
> > > probably doesn't matter all that much, since very exact results can't be
> > > guaranteed anyway.
> > 
> > I don't understand the last sentence? Why is it impossible to get exact
> > results in continuous voltage mode?
> 
> I didn't say it was impossible. I said it can't be guaranteed. There may
> very well be combinations of drivers and consumers where the results
> will be accurate, but there may very well be other combinations where
> the results won't be. So if you don't know the exact combination, you
> can't be sure that the result will be accurate.

Either I don't understand what you intend to say, or I fail to see its
relevance here. If the device tree specifies a PWM regulator with
continuous voltage mode the right thing to do with a request for a
certain voltage is to exactly calculate the needed PWM setting with the
parameters provided and rely on the PWM driver to implement what it
promises. If the PWM driver is buggy or the device tree representation
is inaccurate, well there is nothing the PWM framework or the
pwm-regulator driver can do about it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
