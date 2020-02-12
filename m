Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9C15A1FF
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2020 08:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgBLH3T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Feb 2020 02:29:19 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41247 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBLH3S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Feb 2020 02:29:18 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1mSO-00025W-Fu; Wed, 12 Feb 2020 08:29:12 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1mSN-0001bJ-3P; Wed, 12 Feb 2020 08:29:11 +0100
Date:   Wed, 12 Feb 2020 08:29:11 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>, kernel@pengutronix.de,
        linux-clk@vger.kernel.org
Subject: About rounding in the clk framework [Was: Re: [PATCH 4/7] pwm:
 jz4740: Improve algorithm of clock calculation]
Message-ID: <20200212072911.nstwj7dgpvceebpy@pengutronix.de>
References: <20190812214838.e5hyhnlcyykjfvsb@pengutronix.de>
 <1565648183.2007.3@crapouillou.net>
 <20190813052726.g37upws5rlvrszc4@pengutronix.de>
 <1565694066.1856.1@crapouillou.net>
 <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
 <1565700448.1856.2@crapouillou.net>
 <20190813140903.rdwy7p3mhwetmlnt@pengutronix.de>
 <1565799035.1984.0@crapouillou.net>
 <20190814173218.zhg4se3pppano5m3@pengutronix.de>
 <1571662077.3.1@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571662077.3.1@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Stephen, hello Michael,

first some words about the context for the newcomers in this thread (or
those who already got the earlier mails some time ago and obliterated the
details):

The task at hand is to set the frequency of a parent clock to be able to
setup a PWM to yield a certain period and duty cycle. For that there is
an upper limit of the frequency and otherwise we want the clock to run
as fast as possible[1].

On Mon, Oct 21, 2019 at 02:47:57PM +0200, Paul Cercueil wrote:
> Le mer., août 14, 2019 at 19:32, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> a écrit :
> > On Wed, Aug 14, 2019 at 06:10:35PM +0200, Paul Cercueil wrote:
> > > Le mar. 13 août 2019 à 16:09, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= a écrit :
> > > > On Tue, Aug 13, 2019 at 02:47:28PM +0200, Paul Cercueil wrote:
> > > > > Le mar. 13 août 2019 à 14:33, Uwe Kleine-König a écrit :
> > > > > > Using clk_round_rate correctly without additional knowledge is hard. If
> > > > > > you assume at least some sane behaviour you'd still have to call it
> > > > > > multiple times. Assuming maxrate is the maximal rate you can handle
> > > > > > without overflowing your PWM registers you have to do:
> > > > > >
> > > > > > 	rate = maxrate;
> > > > > > 	rounded_rate = clk_round_rate(clk, rate);
> > > > > > 	while (rounded_rate > rate) {
> > > > > > 		if (rate < rounded_rate - rate) {
> > > > > > 			/*
> > > > > > 			 * clk doesn't support a rate smaller than
> > > > > > 			 * maxrate (or the round_rate callback doesn't
> > > > > > 			 * round consistently).
> > > > > > 			 */
> > > > > > 			 return -ESOMETHING;
> > > > > > 		}
> > > > > > 		rate = rate - (rounded_rate - rate)
> > > > > > 		rounded_rate = clk_round_rate(clk, rate);
> > > > > > 	}
> > > > > >
> > > > > > 	return rate;
> > > > > >
> > > > > > Probably it would be sensible to put that in a function provided by the
> > > > > > clk framework (maybe call it clk_round_rate_down and maybe with
> > > > > > additional checks).
> > > > >
> > > > > clk_round_rate_down() has been refused multiple times in the past for
> > > > > reasons that Stephen can explain.
> > > >
> > > > I'd be really interested in these reasons as I think the clk framework
> > > > should make it easy to solve common tasks related to clocks. And finding
> > > > out the biggest supported rate not bigger than a given maxrate is
> > > > something I consider such a common task.
> > > >
> > > > The first hit I found when searching was
> > > > https://lkml.org/lkml/2010/7/14/260 . In there Stephen suggested that
> > > > clk_round_rate with the current semantic is hardly useful and suggested
> > > > clk_round_rate_up() and clk_round_rate_down() himself.
> > > 
> > > That's from 2010, though.
> > 
> > If you have a better link please tell me.
> > 
> > > I agree that clk_round_rate_up() and clk_round_rate_down() should exist.
> > > Even if they return -ENOSYS if it's not implemented for a given clock
> > > controller.
> > 
> > ack.

Can you please explain what is the reason why clk_round_rate_up/down()
is a bad idea? Would it help to create a patch that introduces these
functions to get the discussion going?

> > > > > > > I came up with a much smarter alternative, that doesn't rely on the rounding
> > > > > > > method of clk_round_rate, and which is better overall (no loop needed). It
> > > > > > > sounds to me like you're bashing the code without making the effort to
> > > > > > > understand what it does.
> > > > > > >
> > > > > > > Thierry called it a "neat trick"
> > > > > > > (https://patchwork.kernel.org/patch/10836879/) so it cannot be as bad as you
> > > > > > > say.
> > > > > > [...]
> > > > > [...]
> > > >
> > > > So I think the code works indeed, but it feels like abusing
> > > > clk_set_max_rate. So I'd like to see some words from Stephen about this
> > > > procedure.

The approach here was as follows:

	clk_set_rate(clk, parentrate);
	clk_set_max_rate(clk, maxfreq);

I don't know what the exact purpose of clk_set_max_rate() is, but it
seems questionable to me if it is supposed to be used like that. (As a
side note: According to the FIXME in clk_set_rate_range() it doesn't even
guarantee that the rate of clk is <= maxfreq after the call.
clk_round_rate_down() would help here, too ...)

Best regards
Uwe

[1] This isn't necessarily the best clk freq, but a reasonable to work
    with.

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
