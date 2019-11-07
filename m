Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9EF27CF
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2019 07:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfKGGva (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Nov 2019 01:51:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38019 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKGGv3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Nov 2019 01:51:29 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iSbdX-0001kX-O4; Thu, 07 Nov 2019 07:51:19 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iSbdW-0007qU-3c; Thu, 07 Nov 2019 07:51:18 +0100
Date:   Thu, 7 Nov 2019 07:51:18 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 4/7] pwm: sun4i: Add support to output source clock
 directly
Message-ID: <20191107065118.j4s5cghj4ark7sql@pengutronix.de>
References: <20191105131456.32400-1-peron.clem@gmail.com>
 <20191105131456.32400-5-peron.clem@gmail.com>
 <20191105145659.ffezqntodsys4phn@pengutronix.de>
 <CAJiuCcdXr3y0oe19ZNaiQoN7Y39p54p8LjQjXfjHbTH8tbnrpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcdXr3y0oe19ZNaiQoN7Y39p54p8LjQjXfjHbTH8tbnrpw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Clément,

On Wed, Nov 06, 2019 at 10:24:39PM +0100, Clément Péron wrote:
> On Tue, 5 Nov 2019 at 15:57, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Nov 05, 2019 at 02:14:53PM +0100, Clément Péron wrote:
> > > +     bypass = state->enabled &&
> > > +              (state->period * clk_rate >= NSEC_PER_SEC) &&
> >
> > This is too coarse. With state->period = 1000000 this is fulfilled
> > (unless the multiplication overflows).
> 
> Sorry, misunderstood the previous mail
> 
> What about something like this ?
> ((state->period - 1) * clk_rate <= NSEC_PER_SEC) &&
> ((state->period + 1) * clk_rate >= NSEC_PER_SEC) &&
>  ((state->duty_cycle - 1) * 2 <= state->period) &&
>  ((state->duty_cycle + 1) * 2 >= state->period);
> 
> We are sure that the user is looking for a PWM around the OSC with a
> 50% duty cycle ?

This again is too strict. The general policy to fulfill a request is:

 1) provide the longest possible period not bigger than requested
 2) provide the longest possible duty cycle not bigger than requested
 3) if possible complete the currently running period before switching
    and don't return to the user before the new setting is active.
    Document the behaviour prominently because the code (usually)
    doesn't allow to understand the hardware's features here.
 4) A disabled PWM should output the inactive level

And then there is a corner case: If the user requests .duty_cycle = 0,
.enabled = 1 it is ok to provide .enabled = 0 iff otherwise 0% isn't
possible.

So the right check for bypass is:

  state->period * clk_rate >= NSEC_PER_SEC &&
  state->period * clk_rate < whatevercanbereachedwithoutbypass &&
  state->duty_cycle * clk_rate * 2 >= NSEC_PER_SEC

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
