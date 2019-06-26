Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC77564F6
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFZI6h (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 04:58:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40935 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZI6g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 04:58:36 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hg3l8-0006dR-FY; Wed, 26 Jun 2019 10:58:30 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hg3l5-0008VO-Se; Wed, 26 Jun 2019 10:58:27 +0200
Date:   Wed, 26 Jun 2019 10:58:27 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Message-ID: <20190626085827.fija4kfzb5uhwosi@pengutronix.de>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
 <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
 <20190625093839.GB1516@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625093839.GB1516@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jun 25, 2019 at 11:38:39AM +0200, Thierry Reding wrote:
> On Mon, Jun 24, 2019 at 12:28:44PM +0100, Daniel Thompson wrote:
> > [...] although given pwm-backlight is essentially a wrapper driver
> > round a PWM I wondered why the pinctrl was on the backlight node
> > (rather than the PWM node).
> 
> I agree with this. We're defining the pin control state for the PWM pin,
> so in my opinion it should be the PWM driver that controls it.
> 
> One reason why I think this is important is if we ever end up with a
> device that requires pins from two different controllers to be
> configured at runtime, then how would we model that? Since pin control
> states cannot be aggregated, so you'd have to have multiple "default"
> states, each for the pins that they control.

I thought you can do:

	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_in_first_pincontroller>, <&pinctrl_in_another_controller>;

if two (or more) controllers are involved.
 
> On the other hand if we associate the pin control states with each of
> the resources that need those states, then when those resources are
> controlled, they will automatically know how to deal with the states.
> The top-level device (i.e. backlight) doesn't need to concern itself
> with those details.

So the options are:

 a) put "active" and "inactive" pinctrls into the pwm-node, and nothing
    related to the involved PWM pins in the consumer

 b) put the PWM pin config in the consumer's "default" pinctrl (and
    maybe leave it out int "init" if you want smooth taking over).

(Or maybe use "enabled" and "disabled" in a) to match the pwm_states
.enabled?)

The advantages I see in b) over a) are:

 - "default" and "init" are a known pinctrl concept that most people
   should have understood.

 - You have all pinctrl config for the backlight in a single place.

 - none of the involved driver must explicitly handle pinctrl stuff

You presume that b) being commonly done is a sign of "our device trees
and kernel subsystems still maturing". But maybe it's only that the
capabilities provided by pinctrl subsystem without extra effort is good
enough?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
