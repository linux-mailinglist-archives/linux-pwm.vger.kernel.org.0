Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 140F0143F64
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2020 15:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAUOXE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 21 Jan 2020 09:23:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44195 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUOXD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 21 Jan 2020 09:23:03 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ituQm-0007TS-GA; Tue, 21 Jan 2020 15:23:00 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ituQl-0008Sh-BZ; Tue, 21 Jan 2020 15:22:59 +0100
Date:   Tue, 21 Jan 2020 15:22:59 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: About rounding in the PWM framework [Was: Re: [PATCH v5] gpio:
 pca953x: Add Maxim MAX7313 PWM support]
Message-ID: <20200121142259.c56h2dpxtiha6xp6@pengutronix.de>
References: <20200107133130.1338-1-miquel.raynal@bootlin.com>
 <20200120121329.GC206171@ulmo>
 <20200120134137.54dc307e@xps13>
 <20200120141944.GD206171@ulmo>
 <20200120144457.eznywc423ehw6kuc@pengutronix.de>
 <20200121125607.GA899558@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121125607.GA899558@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Tue, Jan 21, 2020 at 01:56:07PM +0100, Thierry Reding wrote:
> On Mon, Jan 20, 2020 at 03:44:57PM +0100, Uwe Kleine-König wrote:
> > Yeah, it's something like clk_round_rate that I want in the end. And to
> > make it actually workable the IMHO only sane approach is to allow
> > rounding in one direction without limit. And as pwm_apply_state() should
> > be consistent with pwm_round_state() the former must round without
> > limit, too.
> 
> Agreed on the point that both pwm_round_state() and pwm_apply_state()
> should do the same rounding. In fact, in most cases I'd expect drivers
> to implement the bulk of ->apply() and ->round() in the same function
> that basically constructs the new state that will be applied to the
> hardware in ->apply() but will be returned from ->round().
> 
> I'm not so sure about rounding without limit, though. I think it makes
> sense to allow rounding to happen if you can match things closely enough
> for it not to matter in most cases.

The problem is to define "close enough". And if we can agree on some
definition, I wouldn't want to implement this policy in each and every
driver. That's why I think implementing something easy like "always
round down" is the right way for the lowlevel drivers. Allowing to round
in both directions makes working with pwm_round_rate quite a bit more
difficult, as does imposing a limit.

With that the PWM core could implement a policy uniformly for all
lowlevel drivers in a single place. You could even implement an API
function that picks the available period that is nearest to the
requested value.

> Strictly speaking we're already breaking use-cases that require a
> fixed period because there's currently no way for consumers to
> determine what the exact state is that is going to get applied.
> Consumers could read back the state, but we already know that that
> doesn't yield the correct result for some drivers.

Currently this is true for all drivers as the core caches the value that
was last set and a driver cannot give any feedback.

> Also, in practice, for the large majority of use-cases the exact period
> doesn't matter as long as the actual numbers are close enough to the
> requested values and the duty cycle/period ratio is about the same as
> what was requested.

Can you describe which policy you think should be implemented in
pwm_apply_state()?

> [...]
> That still means that we'll be ignoring mismatches between fixed-period
> producers and variable-period consumers. Allowing producers to overwrite
> whatever is passed in (without potentially being able to get anywhere
> near the requested values) is making it too easy to get things wrong,
> don't you think?

A sharp knife is a great tool. Of course you can hurt yourself or others
with it. But does that convince you to cut your vegetables with a
dull-edged knife?

> > > However, ignoring period settings because the controller supports only a
> > > fixed period seems a bit of an extreme.
> > 
> > So the setting I want is:
> > 
> > 	if (request.period < HW_PERIOD)
> > 		fail();
> > 		
> > and with the reasoning above, that's the only sensible thing (apart from
> > the revered policy of rounding up and so failing for requested periods
> > that are bigger than the implementable period).
> 
> But that's just as arbitrary as anything else. request.period ==
> HW_PERIOD - 1 might be an entirely fine setting in many cases.

Ack. Technically it's arbitrary as anything else, exactly my point. But
among the many arbitrary policies it is I think one of the very few that
can easily be worked with and allows to let a consumer make an informed
choice without jumping through more hoops than necessary.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
