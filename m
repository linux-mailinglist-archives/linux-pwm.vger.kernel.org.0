Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D76E2D34AB
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 22:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgLHUzI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 15:55:08 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:46986 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgLHUzG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 8 Dec 2020 15:55:06 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id E5151C81EEA;
        Tue,  8 Dec 2020 21:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1607460864;
        bh=Pjtd9B2W0b+d8gQxR0Tl6F6nQvyZSrgF6dYokHJvpJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnV75IUnWomx4l3izgnashHsazN5/f30DrZ4qZAox6aXJhWBBFa+PR8hzMyxZ+V/y
         5ItryWKJTCzuDdu+rgZEM50UfZP7L7TDxN8+Z2aShPH1zQQ6LinMXeR1uu0T2v11ns
         lSgNebwJPiu7vjRvXbtkfbJYLassKaIjy95cKeW4=
Date:   Tue, 8 Dec 2020 21:54:22 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X8/n/glPx84G23t/@workstation.tuxnet>
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
 <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi everyone,

On Tue, Dec 08, 2020 at 07:26:37PM +0100, Uwe Kleine-König wrote:
> Hello Thierry, hello Sven,
> 
> On Tue, Dec 08, 2020 at 05:57:12PM +0100, Thierry Reding wrote:
> > On Tue, Dec 08, 2020 at 09:44:42AM -0500, Sven Van Asbroeck wrote:
> > > On Tue, Dec 8, 2020 at 4:10 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > If this is already in the old code, this probably warrants a separate
> > > > fix, and yes, I consider this a severe bug. (Consider one channel
> > > > driving a motor and reconfiguring an LED modifies the motor's speed.)
> > > >
> > > 
> > > I think you are 100% correct, this would be a severe bug. I have only used
> > > this chip to drive LEDs, where the actual period is not that important. But
> > > for motor control, it's a different story.
> > > 
> > > Basically you are suggesting: the period (prescaler) can only be changed iff
> > > its use-count is 1.
> > > 
> > > This however brings up a whole load of additional questions: consider the case
> > > where the chip outputs are also used in gpio mode. the gpio functionality
> > > only sets "full on" and "full off" bits. On a scope, a gpio output will look
> > > identical, no matter the value of the period. So when a gpio output is in use,
> > > does it increment the prescaler use-count ?
> > > 
> > > Example:
> > > 1. output 1: set pwm mode (enabled=true, duty_cycle=50%, period=1/200Hz)
> > > 2. output 2: set led mode (full-on bit set)
> > > 3. output 1: change period(enabled=true, duty_cycle=50%, period=1/100Hz)
> > > 
> > > Do we have to make (3) fail? I would say no: although output 2 is in use,
> > > it's not actually using the prescaler. Changing prescale won't modify
> > > output 2 in any way.
> > > 
> > > Which brings us to an even trickier question: what happens if a pwm output
> > > is set to 0% or 100% duty cycle? In that case, it'll behave like a gpio output.
> > > So when it's enabled, it does not use the prescaler.
> > > But! what happens if we now set that output to a different duty cycle?
> > > 
> > > Example:
> > > 1. output 1: set pwm mode (enabled=true, duty_cycle=50%,  period=1/200Hz)
> > > 2. output 2: set pwm mode (enabled=true, duty_cycle=100%, period=1/400Hz)
> > >   fail? no, because it's not actually using the period (it's full on)
> > > 3. output 2: set pwm mode (enabled=true, duty_cycle=100%, period=1/200Hz)
> > >   fail? no, because it's not actually using the period (it's full on)
> > > 4. output 1: set pwm mode (enabled=true, duty_cycle=50%,  period=1/400Hz)
> > >   fail? no, because only output 1 is using the prescaler
> > > 5. output 2: set pwm mode (enabled=true, duty_cycle=50%, period=1/400Hz)
> > >   fail? no, because output 2 is not changing the prescaler
> > > 6. output 2: set pwm mode (enabled=true, duty_cycle=50%, period=1/200Hz)
> > >   fail? yes, because output 2 is changing prescaler and it's already in use
> > > 
> > > IMHO all this can get very complicated and tricky.
> > 
> > Is this really that complicated?
> 
> I think it is.
> 
> > I sounds to me like the only thing that you need is to have some sort
> > of usage count for the prescaler. Whenever you want to use the
> > prescaler you check that usage count. If it is zero, then you can just
> > set it to whatever you need. If it isn't zero, that means somebody
> > else is already using it and you can't change it, which means you have
> > to check if you're trying to request the value that's already set. If
> > so, you can succeed, but otherwise you'll have to fail.
> 
> With this abstraction Sven's questions are changed to:
> 
> Does a PWM that runs at 0% or 100% use the prescaler?
> 
> If yes, you limit the possibilities of the brother channels. And if not,
> it will not be possible to go to a 50% relative duty cycle while
> retaining the period. Both sounds not optimal.

In my opinion, limiting the possibilities of brother channels is
preferrable to introducing another restriction: Not being able to
reconfigure a duty cycle from 0%/100% to something else while keeping
the previously set period.
Better deny the period change in the first place, even if the duty cycle
is 0% or 100%.

>  
> > > We can of course make this much simpler by assumung that gpio or on/off pwms
> > > are actually using the prescaler. But then we'd be limiting this chip's
> > > functionality.
> > 
> > Yeah, this is obviously much simpler, but the cost is a bit high, in my
> > opinion. I'm fine with this alternative if there aren't any use-cases
> > where multiple outputs are actually used.
> 
> This metric is wishy-washy; of course you can construct a use-case. I'd
> still go for this simpler option and assume the prescaler used if the
> PWM runs at 0% or 100%, but not when it is a GPIO.

I'd also prefer this solution.

Thanks,
Clemens
