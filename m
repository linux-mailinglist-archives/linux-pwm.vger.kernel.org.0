Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB619BCBE
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Aug 2019 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfHXJZ6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Aug 2019 05:25:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46419 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHXJZ6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Aug 2019 05:25:58 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1SJ0-0002Yt-TG; Sat, 24 Aug 2019 11:25:54 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1SIz-0000pl-Bu; Sat, 24 Aug 2019 11:25:53 +0200
Date:   Sat, 24 Aug 2019 11:25:53 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] pwm: bcm2835: Minor fixes
Message-ID: <20190824092553.j4rjpzaz4m6yaa5t@pengutronix.de>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Stefan,

On Sat, Aug 24, 2019 at 09:07:22AM +0200, Stefan Wahren wrote:
> This small patch series contains minor fixes for clock handling and the
> period range check.

I'd like to understand the various different usecases of PWMs. The
in-kernel consumers are kind of obvious, but sysfs users are not. It
seems you are one of the latter.

Would you mind sharing what you control using the PWM? Does it bother
you that the sysfs interface doesn't allow atomic configuration?

Assuming you have some interest in this driver: It still uses the legacy
stuff implementing .config, .enable, .disable, .set_polarity. Are you
willing to test (or even implement) a switch to .apply instead?

Just from a quick lock into the driver I wonder a few things, maybe you
can shed some light here. If there is publicly available documenation
for this piece of hardware, feel free to point this out, then I might be
able to work out some of the answers myself.

The overall (and common) design of the PWM is an input clk, a counter, a
duty and a period register.

The slightly simplified logic in .config is:

	scaler = DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
	writel(DIV_ROUND_CLOSEST(duty_ns, scaler), PWM_DUTY);
	writel(DIV_ROUND_CLOSEST(period_ns, scaler), PWM_PERIOD);

This is loosing precision while the calculation could be cheaper (in CPU
cycles) and more exact when using:

	writel(DIV_ROUND_CLOSEST(duty_ns * rate, NSEC_PER_SEC), PWM_DUTY);
	writel(DIV_ROUND_CLOSEST(period_ns * rate, NSEC_PER_SEC), PWM_PERIOD);

This is only two divisions instead of three. And assuming a rate of 9.2
MHz and a request of duty_ns = 499945, period_ns = 999891 the original
calculation yields

	DUTY = 4587
	PERIOD = 9173

	real_duty_ns = 498586.95652173914
	real_period_ns = 997065.2173913043

	error_duty_ns = 1358.0434782608645
	error_period_ns = 2825.7826086956775

With my suggestion you'd get

	DUTY = 4599
	PERIOD = 9199

	real_duty_ns = 499891.3043478261
	real_period_ns = 999891.304347826

	error_duty_ns = 53.69565217389027
	error_period_ns = -0.30434782605152577

(But having said this, I'd prefer to use rounding down instead of
rounding closest).

Also I wonder if reprogramming the hardware completes the currently
running period and how the hardware behaves on disable. (In the latter
case I'm interested in "Does it complete the running period?" and "Which
state does the output stop in?")

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
