Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5865152505
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2019 09:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfFYHmd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jun 2019 03:42:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53533 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbfFYHmc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jun 2019 03:42:32 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hfg5v-0004yl-BO; Tue, 25 Jun 2019 09:42:23 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hfg5s-0005kx-EO; Tue, 25 Jun 2019 09:42:20 +0200
Date:   Tue, 25 Jun 2019 09:42:20 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Message-ID: <20190625074220.ckj7e7gwbszwknaa@pengutronix.de>
References: <20190522163428.7078-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190522163428.7078-1-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, May 22, 2019 at 06:34:28PM +0200, Paul Cercueil wrote:
> When the driver probes, the PWM pin is automatically configured to its
> default state, which should be the "pwm" function. However, at this
> point we don't know the actual level of the pin, which may be active or
> inactive. As a result, if the driver probes without enabling the
> backlight, the PWM pin might be active, and the backlight would be
> lit way before being officially enabled.

I'm not sure I understand the problem completely here. Let me try to
summarize the problem you solve here:

The backlight device's default pinctrl contains the PWM function of the
PWM pin. As the PWM is (or at least might be) in an undefined state the
default pinctrl should only be switched to when it's clear if the
backlight should be on or off.

So you use the "init"-pinctrl to keep the PWM pin in some (undriven?)
state and by switching to "sleep" you prevent "default" getting active.

Did I get this right? If not, please correct me.

What is the PWM pin configured to in "init" in your case? Is the pinctrl
just empty? Or is it a gpio-mode (together with a gpio-hog)?

My thoughts to this is are:

 a) This is a general problem that applies (I think) to most if not all
    PWM consumers. If the PWM drives a motor, or makes your mobile
    vibrate, or drives an LED, or a clk, the PWM shouldn't start
    to do something before its consumer is ready.

 b) Thierry made it quite clear[1] that the PWM pin should be configured
    in a pinctrl of the pwm device, not the backlight (or more general:
    the consumer) device.

While I don't entirely agree with b) I think that even a) alone
justifies to think a bit more about the problem and preferably come up
with a solution that helps other consumers, too. Ideally if the
bootloader sets up the PWM to do something sensible, probing the
lowlevel PWM driver and the consumer driver should not interfere with
the bootloader's intention until the situation reaches a controlled
state. (I.e. if the backlight was left on by the bootloader to show a
nice logo, it should not flicker until a userspace program takes over
the display device.)

A PWM is special in contrast to other devices as its intended behaviour
is only fixed once a consumer is present. Without a consumer it is
unknown if the PWM is inverted or not. And so the common approach that
pinctrl is setup by the device core only doesn't work without drawbacks
for PWMs.

So if a PWM driver is probing and the PWM hardware already runs at say
constant one, some instance must define if the pin is supposed to be
configured in its "default" or "sleep" pinctrl. IMHO this isn't possible
in general without knowing the polarity of the PWM. (And even if it were
known that the polarity is inversed, it might be hard to say if your
PWM's hardware doesn't implement a disabled state and has to simulate
that using a 0% duty cycle.)

Another thing that complicates the matter is that at least pwm-imx27 has
the annoying property that disabling it (in hardware) drives the pin low
irrespective of the configured polarity. So if you want this type of
device to behave properly on disable, it must first drive a 0% duty
cycle, then switch the pinctrl state and only then disable the hardware.
This rules out that the lowlevel driver is unaware of the pinctrl stuff
which would be nice (or an inverted PWM won't be disabled in hardware or
you need an ugly sequence of callbacks to disable glitch-free). Also if
there is no sleep state, you better don't disable an inversed pwm-imx27
at all (in hardware)? (Alternatively we could drop the (undocumented)
guarantee that a disabled PWM results in the pin staying in its idle
level.)

What are the ways out? I think that if we go and apply your patch, we
should at least write some documentation with the details to provide some
"standard" way to solve similar problems.

Also it might be a good idea to let a PWM know if it is inverted or not
such that even without the presence of a consumer it can determine if
the hardware is active or not at probe time (in most cases at least).

Best regards
Uwe

[1] https://www.spinics.net/lists/linux-pwm/msg08246.html

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
