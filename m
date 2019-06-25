Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD720557B4
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2019 21:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfFYTUC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jun 2019 15:20:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36665 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfFYTUC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jun 2019 15:20:02 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hfqyv-0001Al-5M; Tue, 25 Jun 2019 21:19:53 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hfqys-0004bj-3v; Tue, 25 Jun 2019 21:19:50 +0200
Date:   Tue, 25 Jun 2019 21:19:50 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Message-ID: <20190625191950.2rvvputus4uavyjn@pengutronix.de>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <20190625074220.ckj7e7gwbszwknaa@pengutronix.de>
 <20190625095821.GD1516@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190625095821.GD1516@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jun 25, 2019 at 11:58:21AM +0200, Thierry Reding wrote:
> On Tue, Jun 25, 2019 at 09:42:20AM +0200, Uwe Kleine-König wrote:
> > On Wed, May 22, 2019 at 06:34:28PM +0200, Paul Cercueil wrote:
> > > When the driver probes, the PWM pin is automatically configured to its
> > > default state, which should be the "pwm" function. However, at this
> > > point we don't know the actual level of the pin, which may be active or
> > > inactive. As a result, if the driver probes without enabling the
> > > backlight, the PWM pin might be active, and the backlight would be
> > > lit way before being officially enabled.
> > 
> > I'm not sure I understand the problem completely here. Let me try to
> > summarize the problem you solve here:
> > 
> > The backlight device's default pinctrl contains the PWM function of the
> > PWM pin. As the PWM is (or at least might be) in an undefined state the
> > default pinctrl should only be switched to when it's clear if the
> > backlight should be on or off.
> > 
> > So you use the "init"-pinctrl to keep the PWM pin in some (undriven?)
> > state and by switching to "sleep" you prevent "default" getting active.
> > 
> > Did I get this right? If not, please correct me.
> > 
> > What is the PWM pin configured to in "init" in your case? Is the pinctrl
> > just empty? Or is it a gpio-mode (together with a gpio-hog)?
> > 
> > My thoughts to this is are:
> > 
> >  a) This is a general problem that applies (I think) to most if not all
> >     PWM consumers. If the PWM drives a motor, or makes your mobile
> >     vibrate, or drives an LED, or a clk, the PWM shouldn't start
> >     to do something before its consumer is ready.
> 
> Yes, it shouldn't start before it is explicitly told to do so by the
> consumer. One exception is if the PWM was already set up by firmware
> to run. So I think in general terms we always want the PWM to remain
> in the current state upon probe.

In the end this means that also pinmuxing should not be touched when the
PWM device probes.

> The atomic PWM API was designed with that in mind. The original use-
> case was to allow seamlessly taking over from a PWM regulator. In order
> to do so, the driver needs to be able to read back the hardware state
> and *not* initialize the PWM to some default state.
> 
> I think that same approach can be extended to backlights. The driver's
> probe needs to determine what the current state of the backlight is and
> preferable not touch it. And that basically propagates all the way to
> the display driver, which ultimately needs to determine whether or not
> the display configuration (including the backlight) is enabled.

Are you ambitious enough to handle cases like: PWM is running (maybe
because it cannot be disabled), but the pin is muxed to an "unconnected"
configuration such that the pin doesn't oscillate? In this case you'd
need an inspection function for pinmuxing.

> >  b) Thierry made it quite clear[1] that the PWM pin should be configured
> >     in a pinctrl of the pwm device, not the backlight (or more general:
> >     the consumer) device.
> > 
> > While I don't entirely agree with b) I think that even a) alone
> > justifies to think a bit more about the problem and preferably come up
> > with a solution that helps other consumers, too. Ideally if the
> > bootloader sets up the PWM to do something sensible, probing the
> > lowlevel PWM driver and the consumer driver should not interfere with
> > the bootloader's intention until the situation reaches a controlled
> > state. (I.e. if the backlight was left on by the bootloader to show a
> > nice logo, it should not flicker until a userspace program takes over
> > the display device.)
> 
> Yes, exactly that.
> 
> > A PWM is special in contrast to other devices as its intended behaviour
> > is only fixed once a consumer is present. Without a consumer it is
> > unknown if the PWM is inverted or not. And so the common approach that
> > pinctrl is setup by the device core only doesn't work without drawbacks
> > for PWMs.
> 
> Actually I don't think PWMs are special in this regard. A GPIO, for
> example, can also be active-low or active-high, and without a consumer
> there's not enough context to determine which one it should be.

Right, PWMs are more similar to GPIOs than to (say) backlight devices.
With your request to configure the pinmux for a PWM pin with the PWM
device instead of its consumer you're making some things more difficult.
For GPIOs it's quite common that they are muxed from their consumer
because there the same problems are present.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
