Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA7DDF76B
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 23:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfJUVZp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 17:25:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38203 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfJUVZp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 17:25:45 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMfBP-0003d5-TV; Mon, 21 Oct 2019 23:25:43 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMfBP-0002Pe-8q; Mon, 21 Oct 2019 23:25:43 +0200
Date:   Mon, 21 Oct 2019 23:25:43 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Revert "pwm: Let pwm_get_state() return the last
 implemented state"
Message-ID: <20191021212543.d24sh4pfofqpmuu4@pengutronix.de>
References: <20191021105830.1357795-1-thierry.reding@gmail.com>
 <20191021111847.c5j4qycyqy5wmynh@pengutronix.de>
 <20191021141721.GA1476994@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021141721.GA1476994@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 21, 2019 at 04:17:21PM +0200, Thierry Reding wrote:
> On Mon, Oct 21, 2019 at 01:18:47PM +0200, Uwe Kleine-König wrote:
> > On Mon, Oct 21, 2019 at 12:58:30PM +0200, Thierry Reding wrote:
> > > It turns out that commit 01ccf903edd6 ("pwm: Let pwm_get_state() return
> > > the last implemented state") causes backlight failures on a number of
> > > boards. The reason is that some of the drivers do not write the full
> > > state through to the hardware registers, which means that ->get_state()
> > > subsequently does not return the correct state. Consumers which rely on
> > > pwm_get_state() returning the current state will therefore get confused
> > > and subsequently try to program a bad state.
> > > 
> > > Before this change can be made, existing drivers need to be more
> > > carefully audited and fixed to behave as the framework expects. Until
> > > then, keep the original behaviour of returning the software state that
> > > was applied rather than reading the state back from hardware.
> > 
> > I would really prefer to fix that in the framework instead. This is
> 
> There's nothing to fix in the framework. The framework isn't broken, the
> drivers are.

The drivers behave in a way that result in unexpected behaviour for
consumers. There are several ways to fix this, adapting the drivers to
the consumer's expectations is only one of them.

> > something that affects several drivers (cros-ec, imx27, atmel, imx-tpm,
> > lpss, meson, sifive, sprd and stm32-lp). This is im my eyes really
> > sufficient to justify a framework wide solution instead of adapting
> > several drivers in a way that doesn't affect the values programmed to
> > hardware.
> 
> Can you come up with a proposal for how to want to implement this in the
> framework?

My preferred solution is to make consumers not expect that
pwm_get_state() keeps .duty_cycle and .period for disabled PWMs. For
that consumers must be moved away from the idiom:

	pwm_get_state(mypwm, &state);
	state.enabled = true;
	pwm_apply_state(mypwm, &state);

IMHO it is very artificial from a lowlevel driver's POV to differentiate
between

	.period = 1000000, .duty_cycle = 50000, .enabled = false

and

	.period = 100, .duty_cycle = 0, .enabled = false

because the respective expected behaviour is completely identical (apart
from the requirement under discussion). So I'd do something like:

	if (!state->enabled) {
		state->period = 1;
		state->duty_cycle = 0;
	}

after calling the driver's .get_state callback once all in-tree
consumers are converted to provide a uniform behaviour to consumers.

The next best solution is to cache the values for .period and
.duty_cycle for disabled PWMs only. But the ugly detail then is that
pwm_get_state() sometimes returns actually implemented values and
sometimes requested values. (The same holds true for the approach to
make lowlevel drivers cache these values.)

So it makes probably more sense to introduce two new functions

	pwm_get_applied_state()
	pwm_get_implemented_state()

with the first having the semantic of pwm_get_state() before
01ccf903edd6 and the latter of after 01ccf903edd6. Then today's users of
pwm_get_state can be converted to the right of these two. But I'm not
convinced this is a good idea now. Maybe we should first clean up the
already started stuff (like converting lowlevel drivers and consumers to
the atomic API). Maybe renaming pwm_get_state to pwm_get_applied_state
is something that is easy enough to justify already today?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
