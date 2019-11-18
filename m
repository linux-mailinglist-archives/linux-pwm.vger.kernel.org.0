Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE961003AA
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 12:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfKRLTj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 06:19:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56295 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRLTj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 06:19:39 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iWf4B-000726-78; Mon, 18 Nov 2019 12:19:35 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iWf49-0000nC-ES; Mon, 18 Nov 2019 12:19:33 +0100
Date:   Mon, 18 Nov 2019 12:19:33 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/3] pwm: jz4740: Use clocks from TCU driver
Message-ID: <20191118111933.vipfycc2j7j6esb7@pengutronix.de>
References: <20191116173613.72647-1-paul@crapouillou.net>
 <20191116173613.72647-2-paul@crapouillou.net>
 <20191117202028.4chgjv2kulyyq2eu@pengutronix.de>
 <1574031523.3.0@crapouillou.net>
 <20191118071538.46egokrswvjxdvfp@pengutronix.de>
 <1574074556.3.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574074556.3.0@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Paul,

On Mon, Nov 18, 2019 at 11:55:56AM +0100, Paul Cercueil wrote:
> Le lun., nov. 18, 2019 at 08:15, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Sun, Nov 17, 2019 at 11:58:43PM +0100, Paul Cercueil wrote:
> > >  Le dim., nov. 17, 2019 at 21:20, Uwe Kleine-König
> > >  <u.kleine-koenig@pengutronix.de> a écrit :
> > >  > On Sat, Nov 16, 2019 at 06:36:11PM +0100, Paul Cercueil wrote:
> > >  > >   struct jz4740_pwm_chip {
> > >  > >   	struct pwm_chip chip;
> > >  > >  -	struct clk *clk;
> > >  >
> > >  > What is the motivation to go away from this approach to store the
> > > clock?
> > > 
> > >  It's actually not the same clock. Instead of obtaining "ext" clock
> > > from the
> > >  probe, we obtain "timerX" clocks (X being the PWM channel) from the
> > > request
> > >  callback.
> > 
> > Before you used driver data and container_of to get it, now you used
> > pwm_set_chip_data. I wondered why you changed the approach to store
> > data. That the actual data is different now is another thing (and
> > obviously ok).
> 
> Thierry suggested it: https://lkml.org/lkml/2019/3/4/486

If you motivate that in the commit log (preferably with a better
rationale than "Thierry suggested it") that's fine for. (Do I claim now
without having read the rationale :-)

> > >  > >   static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > >  > >   {
> > >  > >  +	struct clk *clk = pwm_get_chip_data(pwm);
> > >  > >  +
> > >  > >   	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
> > >  >
> > >  > What is the purpose of this call? I would have expected that all these
> > >  > would go away when converting to the clk stuff?!
> > > 
> > >  Some go away in patch [1/3] as they are clock-related, this one will go away
> > >  in patch [2/3] when the driver is converted to use regmap.
> > 
> > I'd like to understand what it does. Judging from the name I expect this
> > is somehow related to the clock stuff and so I wonder if the conversion
> > to the clk API is as complete as it should be.
> 
> It clears the PWM channel's CTRL register. That's the register used for
> instance to enable the PWM function of a TCU channel.

OK, so this is a register in a different register range than the PWM
related registers to set duty and period, right? Looking at the code,
this register has a bit to enable PWM mode and other than that bit
fields to tune the clock feeding the PWM counters, right?

This probably explains my resistance because such a setup if really hard
to map to nice code. At least the "PWM enable" bit doesn't fit the clk
abstraction, no good idea here. Maybe it's easier and more straight
forward to not wrap that register in a clock driver and only use a clk
for the parent? What is the motivation to convert this piece of hardware
to a clk driver? Or abstract it as a proper clk and provide a function
to enable PWM mode for channel X?

> > >  > >  -	jz4740_timer_stop(pwm->hwpwm);
> > >  > >  +	clk_disable_unprepare(clk);
> > >  > >  +	clk_put(clk);
> > >  > >   }
> > >  > >
> > >  > >   static int jz4740_pwm_enable(struct pwm_chip *chip, struct
> > > pwm_device *pwm)
> > >  > >  @@ -91,17 +110,21 @@ static int jz4740_pwm_apply(struct
> > > pwm_chip *chip, struct pwm_device *pwm,
> > >  > >   			    const struct pwm_state *state)
> > >  > >   {
> > >  > >   	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
> > >  > >  +	struct clk *clk = pwm_get_chip_data(pwm),
> > >  > >  +		   *parent_clk = clk_get_parent(clk);
> > >  > >  +	unsigned long rate, period, duty;
> > >  > >   	unsigned long long tmp;
> > >  > >  -	unsigned long period, duty;
> > >  > >   	unsigned int prescaler = 0;
> > >  > >   	uint16_t ctrl;
> > >  > >
> > >  > >  -	tmp = (unsigned long long)clk_get_rate(jz4740->clk) *
> > > state->period;
> > >  > >  +	rate = clk_get_rate(parent_clk);
> > >  >
> > >  > Why is it the parent's rate that is relevant here?
> > > 
> > >  We calculate the divider to be used for the "timerX" clock, so we
> > > need to
> > >  know the parent clock.
> > 
> > Then the approach here is wrong. You should not assume anything about
> > the internal details of the clock, that's the task of the clock driver.
> > As a consumer of the clock just request a rate (or use clk_round_rate to
> > find a good setting first) and use that.
> 
> Totally agreed. I wanted to do that, but you were fighting tooth and nails
> against my patch "Improve algorithm of clock calculation", remember?

No, I don't, but I looked that up :-) And I fighted because I thought
the clk API isn't used properly (and I think your problem is that the
clk API as is today doesn't give you what you want, so there is more
work to do on the clk side of the problem).

The conceptual problem I see is that currently the code uses some
internal knowledge about how this timer clock works but as soon as you
use the clk abstraction it's wrong to use such internal knowledge.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
