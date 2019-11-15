Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3636FD6FF
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2019 08:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKOHf4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Nov 2019 02:35:56 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45789 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOHfz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Nov 2019 02:35:55 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVW8y-0006Dh-PE; Fri, 15 Nov 2019 08:35:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVW8x-0000cb-Kd; Fri, 15 Nov 2019 08:35:47 +0100
Date:   Fri, 15 Nov 2019 08:35:47 +0100
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
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>, kernel@pengutronix.de
Subject: Re: [PATCH v4 4/7] pwm: sun4i: Add support to output source clock
 directly
Message-ID: <20191115073547.iflhs6vqdsmyjla3@pengutronix.de>
References: <20191108084517.21617-1-peron.clem@gmail.com>
 <20191108084517.21617-5-peron.clem@gmail.com>
 <20191113085858.76rad3vpszknu4cp@pengutronix.de>
 <CAJiuCceYg7WC=peHYeC=eE-HOsKH_SdsKyWwkWY5VpeY+uzaKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCceYg7WC=peHYeC=eE-HOsKH_SdsKyWwkWY5VpeY+uzaKA@mail.gmail.com>
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

On Thu, Nov 14, 2019 at 11:47:00PM +0100, Clément Péron wrote:
> On Wed, 13 Nov 2019 at 09:58, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Nov 08, 2019 at 09:45:14AM +0100, Clément Péron wrote:
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > +     /*
> > > +      * Although it would make much more sense to check for bypass in
> > > +      * sun4i_pwm_calculate(), value of bypass bit also depends on "enabled".
> >
> > I don't understand this reasoning. sun4i_pwm_calculate knows about
> > .enabled and also sun4i_pwm->data->has_direct_mod_clk_output. Maybe just
> > add a bool *bypass as parameter and move the logic there?
> 
> I asked myself the same question, however the sun4i_pwm_calculate is
> only called when period or duty_cycle is updated not when state is
> toggled between disabled / enabled.
> 
> Should we also call it when the state is switched to enabled ?

Given that the check

	if ((cstate.period != state->period) ||
	    (cstate.duty_cycle != state->duty_cycle)) {

is not perfect anyhow (because if I toggle between

	pwm_apply_state(pwm, { .period = 50000001, .duty_cycle = 25000000, .enabled = true });

and

	pwm_apply_state(pwm, { .period = 50000000, .duty_cycle = 25000000, .enabled = true });

the code recalculates every parameter while it (probably) doesn't make a
difference.) And also given that cstate is filled by pwm_get_state which
might change its semantic slightly in the future I would say calculating
the needed parameter always is also cleaner. (But I'm aware this isn't
objective enough to overrule different opinions.) While I'm a fan of
avoid unneeded calculations, I think having a simple driver is more
important.

(And apart from that I don't like lowlevel drivers calling the pwm API
that is designed for consumers.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
