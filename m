Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1123A410D7A
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Sep 2021 23:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhISVbs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Sep 2021 17:31:48 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:35270 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhISVbs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 19 Sep 2021 17:31:48 -0400
X-Greylist: delayed 535 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2021 17:31:47 EDT
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 5F156C729FA;
        Sun, 19 Sep 2021 23:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1632086485;
        bh=W4bwPMqP8nSOjKU9TQJwR3PZHLDME7bJ9DGUBxvfU8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRant5hRfu+022RnYNR07udj3pqXk4Rxd3HMBBSwlsITuBf8wuE5NDfi6rNHQbgG0
         TZGs1i9Gi8H1LmZs7/Yf/BVKKxlJUpWMFHllKF8+37S0u4V/yTChvFzS8s/wmRg11J
         KHL0tU698xbC79emUCK9glSk0jod3Ex6rXAPN0Jg=
Date:   Sun, 19 Sep 2021 23:21:22 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>, bala.senthil@intel.com,
        Dipen Patel <dipenp@nvidia.com>
Subject: Re: [RFC PATCH v1 07/20] gpio: Add output event generation method to
 GPIOLIB and PMC Driver
Message-ID: <YUep0gtZkc6D3ukt@workstation.tuxnet>
References: <20210824164801.28896-1-lakshmi.sowjanya.d@intel.com>
 <20210824164801.28896-8-lakshmi.sowjanya.d@intel.com>
 <CACRpkdYJkPgaz-BvQ1X0PHRCCbn0hrMDabouDwHkn+pr9d-dSQ@mail.gmail.com>
 <20210917072755.d4ynxkp4scxrk6rq@pengutronix.de>
 <CACRpkdZmjWQ_mNw_JOZnkvvU15qS26gB3GL_9k=Vao3m=w_N9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZmjWQ_mNw_JOZnkvvU15qS26gB3GL_9k=Vao3m=w_N9w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Sep 19, 2021 at 09:38:58PM +0200, Linus Walleij wrote:
> On Fri, Sep 17, 2021 at 9:27 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Thu, Sep 16, 2021 at 11:42:04PM +0200, Linus Walleij wrote:
> > > On Tue, Aug 24, 2021 at 6:48 PM <lakshmi.sowjanya.d@intel.com> wrote:
> > >
> > > > From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> > > >
> > > > Intel Timed I/O hardware supports output scheduled in hardware. Enable
> > > > this functionality using GPIOlib
> > > >
> > > > Adds GPIOlib generate_output() hook into the driver. The driver is
> > > > supplied with a timestamp in terms of realtime system clock (the same
> > > > used for input timestamping). The driver must know how to translate this
> > > > into a timebase meaningful for the hardware.
> > > >
> > > > Adds userspace write() interface. Output can be selected using the line
> > > > event create ioctl. The write() interface takes a single timestamp
> > > > event request parameter. An output edge rising or falling is generated
> > > > for each event request.
> > > >
> > > > The user application supplies a trigger time in terms of the realtime
> > > > clock the driver converts this into the corresponding ART clock value
> > > > that is used to 'arm' the output.
> > > >
> > > > Work around device quirk that doesn't allow the output to be explicitly
> > > > set. Instead, count the output edges and insert an additional edge as
> > > > needed to reset the output to zero.
> > > >
> > > > Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
> > > > Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
> > > > Signed-off-by: Tamal Saha <tamal.saha@intel.com>
> > > > Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> > > > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > >
> > > So this is some street organ machine that generates sequences
> > > with determined timing between positive and negative edges
> > > right?
> > >
> > > I can't see how this hardware is different from a PWM, or well
> > > I do to some extent, you can control the period of several
> > > subsequent waves, but that is really just an elaborate version
> > > of PWM in my book.
> >
> > From looking in the patch I think this is more versatile than the PWM
> > framework abstracts. I wonder if there is a usecase for the
> > functionality that cannot be expressed using pwm_apply_state?!
> >
> > I remember we had approaches before that implemented repeating patterns
> > (something like: active for 5ms, inactive for 10 ms, active for 30 ms,
> > inactive for 10 ms, repeat) and limiting the number of periods
> > (something like: .duty_cycle = 5ms, .period = 20ms, after 5 periods go
> > into inactive state). These were considered to be too special to be
> > abstracted in drivers/pwm.
> >
> > > It seems to me that this part of the functionality belongs in the
> > > PWM subsystem which already has interfaces for similar
> > > things, and you should probably extend PWM to handle
> > > random waveforms rather than trying to shoehorn this
> > > into the GPIO subsystem.
> >
> > I agree that GPIO is a worse candidate than PWM to abstract that. But
> > I'm not convinced (yet?) that it's a good idea to extend PWM
> > accordingly.
> 
> Yeah it is a bit unfortunate.
> 
> I think we need to fully understand the intended usecase before
> we can deal with this: exactly what was this hardware constructed
> to handle? Sound? Robotic stepper motors? It must be something
> and apparently there are users.
> 
> Maybe even a new subsystem is needed, like a
> drivers/gpio-patterns or drivers/stepper-motor or whatever this
> is supposed to drive.

This would be interesting. Maybe even more abstract, not just supporting
GPIO patterns but also PWM patterns.

E.g. Set gpiochip1 line 2 to 1, wait 5ms, set it to 0
Or set pwmchip1 pwm 2 to 100%, wait 250ms, set it back to 50% duty cycle

This subsystem could then implement the patterns with hrtimers and be
usable with every GPIO or PWM device supported in Linux, and for
special hardware like the Intel Timed I/O, it could configure it to
output the pattern itself.

One usecase besides stepper motors and Robotics would be solenoid
valves: You often have different sequences for opening, closing and
maintenance. E.g. for liquid valves, especially if the liquid is
viscuous, you have to first use 100% duty cycle PWM for e.g. 250ms to
get it open and then dial back to 50% to keep it open without
overheating it.

Of course this can be done in userspace.. but it may also be useful to
have some kind of pattern generator in the kernel. What do you think?

Clemens
