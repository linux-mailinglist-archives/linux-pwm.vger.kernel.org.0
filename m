Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3066C1594D8
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2020 17:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgBKQZk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Feb 2020 11:25:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58493 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgBKQZj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Feb 2020 11:25:39 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1YLw-0006Fa-Ay; Tue, 11 Feb 2020 17:25:36 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1YLu-0002ou-Uk; Tue, 11 Feb 2020 17:25:34 +0100
Date:   Tue, 11 Feb 2020 17:25:34 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/3] pwm: jz4740: Use clocks from TCU driver
Message-ID: <20200211162534.s2whc3ndfckn6j6i@pengutronix.de>
References: <20191116173613.72647-1-paul@crapouillou.net>
 <20191116173613.72647-2-paul@crapouillou.net>
 <20191117202028.4chgjv2kulyyq2eu@pengutronix.de>
 <1574031523.3.0@crapouillou.net>
 <20191118071538.46egokrswvjxdvfp@pengutronix.de>
 <1574074556.3.0@crapouillou.net>
 <20191118111933.vipfycc2j7j6esb7@pengutronix.de>
 <1574084574.3.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574084574.3.1@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Paul,

On Mon, Nov 18, 2019 at 02:42:54PM +0100, Paul Cercueil wrote:
> Le lun., nov. 18, 2019 at 12:19, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Mon, Nov 18, 2019 at 11:55:56AM +0100, Paul Cercueil wrote:
> > >  Le lun., nov. 18, 2019 at 08:15, Uwe Kleine-König
> > >  <u.kleine-koenig@pengutronix.de> a écrit :
> > >  > On Sun, Nov 17, 2019 at 11:58:43PM +0100, Paul Cercueil wrote:
> > >  > >  Le dim., nov. 17, 2019 at 21:20, Uwe Kleine-König
> > >  > >  <u.kleine-koenig@pengutronix.de> a écrit :
> > >  > >  > On Sat, Nov 16, 2019 at 06:36:11PM +0100, Paul Cercueil wrote:
> > >  > >  > >   struct jz4740_pwm_chip {
> > >  > >  > >   	struct pwm_chip chip;
> > >  > >  > >  -	struct clk *clk;
> > >  > >  >
> > >  > >  > What is the motivation to go away from this approach to store the clock?
> > >  > >
> > >  > >  It's actually not the same clock. Instead of obtaining "ext" clock from the
> > >  > >  probe, we obtain "timerX" clocks (X being the PWM channel) from the request
> > >  > >  callback.
> > >  >
> > >  > Before you used driver data and container_of to get it, now you used
> > >  > pwm_set_chip_data. I wondered why you changed the approach to store
> > >  > data. That the actual data is different now is another thing (and
> > >  > obviously ok).
> > > 
> > >  Thierry suggested it: https://lkml.org/lkml/2019/3/4/486
> > 
> > If you motivate that in the commit log (preferably with a better
> > rationale than "Thierry suggested it") that's fine for. (Do I claim now
> > without having read the rationale :-)
> 
> I don't really have a better rationale. The alternative was to have a
> "struct clk[NB_PWMS];" in the struct jz4740_pwm_chip, so this is arguably
> better. I'm not sure it's worth mentioning in the commit message, is it?

It depends what you want to achieve. An array in the chip data might be
too big, with per-pwm data your memory fragments. Still worth to mention
something like:

	The new code now uses a clk pointer per PWM (instead of a clk
	per pwm-chip before). So the pointer is stored in per-pwm data
	now.
 
> They are actually all in the same register range. Each channel has 4 32-bit
> registers, the first one is the CTRL (aka. TCSR) register which is written
> to here. The following two configure the duty/period values, the last one is
> the counter. The 'timer enable' bit is however in the global TCU registers
> area.
> 
> The clock bits of the TCSRs registers (including the TCSR registers of the
> watchdog and 64-bit OS timer) are controlled by the clocks driver. All
> register accesses are properly handled thanks to regmap, that we add in
> patch [2/3].

You reshuffled in v3 which obsoletes some of the statements here I
think. Will take a look there.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
