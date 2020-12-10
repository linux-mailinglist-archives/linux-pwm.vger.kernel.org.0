Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF79F2D6933
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 21:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404499AbgLJUzM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 15:55:12 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:40098 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404659AbgLJUzB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Dec 2020 15:55:01 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id A8367C81EEA;
        Thu, 10 Dec 2020 21:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1607633655;
        bh=X4WI2Y0nEZz36vS1lQMGtUinhxJgA/U2CrFn0uScwR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3VXeZES3M9qENZAHLJr+OJ/YKfV4CqXTwii34TMbxYo7fyaoNHh5tROTJMg/26BV
         bvd7CsAXbDoQ0W92v+KBFZlThBlAHodynTXcF5a32fOqxClDIChwGZb4+x2XgpJ/zN
         4CNnS4HHpJSSOgksnB+/gQzflieBc9gNYByKRXkY=
Date:   Thu, 10 Dec 2020 21:54:13 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X9KK9UrXu+b8F+IT@workstation.tuxnet>
References: <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo>
 <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
 <X9JWlVPb9ZGdB4q9@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X9JWlVPb9ZGdB4q9@ulmo>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Dec 10, 2020 at 06:10:45PM +0100, Thierry Reding wrote:
> On Thu, Dec 10, 2020 at 10:01:24AM +0100, Uwe Kleine-König wrote:
> > Hello Thierry,
> > 
> > On Wed, Dec 09, 2020 at 06:02:16PM +0100, Thierry Reding wrote:
> > > On Tue, Dec 08, 2020 at 07:26:37PM +0100, Uwe Kleine-König wrote:
> > > > Hello Thierry, hello Sven,
> > > > 
> > > > On Tue, Dec 08, 2020 at 05:57:12PM +0100, Thierry Reding wrote:
> > > > > On Tue, Dec 08, 2020 at 09:44:42AM -0500, Sven Van Asbroeck wrote:
> > > > > > Which brings us to an even trickier question: what happens if a pwm output
> > > > > > is set to 0% or 100% duty cycle? In that case, it'll behave like a gpio output.
> > > > > > So when it's enabled, it does not use the prescaler.
> > > > > > But! what happens if we now set that output to a different duty cycle?
> > > > > > 
> > > > > > Example:
> > > > > > 1. output 1: set pwm mode (enabled=true, duty_cycle=50%,  period=1/200Hz)
> > > > > > 2. output 2: set pwm mode (enabled=true, duty_cycle=100%, period=1/400Hz)
> > > > > >   fail? no, because it's not actually using the period (it's full on)
> > > > > > 3. output 2: set pwm mode (enabled=true, duty_cycle=100%, period=1/200Hz)
> > > > > >   fail? no, because it's not actually using the period (it's full on)
> > > > > > 4. output 1: set pwm mode (enabled=true, duty_cycle=50%,  period=1/400Hz)
> > > > > >   fail? no, because only output 1 is using the prescaler
> > > > > > 5. output 2: set pwm mode (enabled=true, duty_cycle=50%, period=1/400Hz)
> > > > > >   fail? no, because output 2 is not changing the prescaler
> > > > > > 6. output 2: set pwm mode (enabled=true, duty_cycle=50%, period=1/200Hz)
> > > > > >   fail? yes, because output 2 is changing prescaler and it's already in use
> > > > > > 
> > > > > > IMHO all this can get very complicated and tricky.
> > > > > 
> > > > > Is this really that complicated?
> > > > 
> > > > I think it is.
> > > 
> > > Care to specify what exactly is complicated about it? You're just saying
> > > that you don't like the restrictions that this implements, but there's
> > > really nothing we can do about that because the hardware just doesn't
> > > give you that flexibility.
> > 
> > The complicated thing is to chose how to map the hardware imposed
> > limitations to the consumers of the two (or more?) channels. And the
> > problem is there is no golden way that is objectively better than all
> > others.
> > 
> > > > > I sounds to me like the only thing that you need is to have some sort
> > > > > of usage count for the prescaler. Whenever you want to use the
> > > > > prescaler you check that usage count. If it is zero, then you can just
> > > > > set it to whatever you need. If it isn't zero, that means somebody
> > > > > else is already using it and you can't change it, which means you have
> > > > > to check if you're trying to request the value that's already set. If
> > > > > so, you can succeed, but otherwise you'll have to fail.
> > > > 
> > > > With this abstraction Sven's questions are changed to:
> > > > 
> > > > Does a PWM that runs at 0% or 100% use the prescaler?
> > > > 
> > > > If yes, you limit the possibilities of the brother channels. And if not,
> > > > it will not be possible to go to a 50% relative duty cycle while
> > > > retaining the period. Both sounds not optimal.
> > > 
> > > Again, this is a restriction imposed by the hardware design and there's
> > > nothing in software that we can do about that. The only thing I proposed
> > > was a simple way to detect the circumstances and make sure we can deal
> > > with it.
> > 
> > The point I want to make is, that with the usage counter you suggested
> > you just shifted the problem and didn't solve it. I agree we need a
> > usage counter, but you still have to think about how you want to answer
> > the original questions by Sven. Depending on that you have to
> > consider a channel running at 0% or 100% a user, or not.  (Or the other
> > way round: You select a policy if you consider 0% and 100% a use and
> > implicitly answer the questions with it.)
> 
> The way I see it, and I think this matches what was said earlier, we
> have two options:
> 
>   1) Use two channels as proper PWMs. In that case, if they happen to
>      run at the same period, they are free to choose the duty-cycle and
>      can be treated as independent PWM channels. If the run at different
>      periods, one of them can only be used as either full-on or full-off
>      PWM. It would still be a PWM, but just with additional restrictions
>      on the duty cycle.
> 
>   2) Use one channel as full PWM and the other channel as GPIO.
> 
> 2) is a subset of 1) because we can implement 2) using 1) by treating
> the full-on/full-off PWM as a GPIO pin. In my opinion, that makes the
> first policy better because it is more flexible.
> 
> > > And that's obviously subject to the kind of policy we want to implement.
> > > I don't think it's necessarily a bad thing to give people the most
> > > flexibility. If they know that one PWM channel is only ever going to be
> > > full-on/full-off, then they can still use that other channel in whatever
> > > way they want. If, on the other hand, we assume that the prescaler is
> > > always going to be used we limit the flexibility even if we don't
> > > necessarily have to.
> > 
> > I think we agree here, just with different words. The only thing I doubt
> > is: You wrote: "If they know $X, then they can still use that other
> > channel in whatever way they want." Who is "they"? How can they know
> > that $X is valid for someone else, or anyone else? Or is it enough that
> > "they" know this about their own use? Now Clemens wants to improve the
> > driver, does he need to consider "them" in the mainline driver
> > implementation? If Clemens chooses one way or the other, will there be
> > someone who then will produce a use case contradicting the implemented
> > policy? How will you (or who will then) decide which use-case is more
> > important?
> 
> "They" refers to whoever writes the DT. Given the hardware restrictions,
> the use-cases are already limited, so you are not going to get into a
> situation where option 1) wouldn't work for any *supported* use-cases.
> You can obviously always come up with a use-case where it wouldn't work,
> but if that's not supported by the hardware, then obviously there's not
> a thing we can do about it, as we already concluded.
> 
> However, if you know that your hardware is restricted in this way, then
> the hardware designers will already have ensured that the supported use-
> cases don't conflict with the hardware.
> 
> So if for example you want to support both a PWM fan and an LED with the
> two outputs, then that's going to work because you can select a period
> that works for both and run them both at the same period but at
> different duty cycles.
> 
> If you have some other setup where one use-case requires the PWM period
> to be adjustable, then by definition with this hardware the second
> channel can't be required to be adjustable as well. In that case you can
> not rely on the second channel to be anything but full-on/full-off. But
> that's still enough to implement a basic LED, so that's what the board
> might support.
> 
> Now you can obviously implement a simple LED using either a GPIO or a
> PWM, so it doesn't really matter in that case which policy we choose
> here. However, a GPIO is a special case of a PWM, so I think modelling
> the second output as a full PWM is better policy because it gives you a
> tiny bit more flexibility.
> 
> So what I'm saying is that the hardware already dictates the set of
> possible use-cases, so if anyone is going to use this in a way that
> isn't supported, then it's okay to fail.
> 
> > > Obviously if you want to use both channels at partial duty-cycles there
> > > isn't much you can do and you really have to make sure they both run at
> > > the same frequency/period. But that's usually something that you can
> > > deal with by just choosing a period that works for both.
> > >
> > > And if that's not possible, well, then you better just use a different
> > > PWM controller to begin with, because you just can't make it work.
> > 
> > Yes.
> > 
> > > > > > We can of course make this much simpler by assumung that gpio or on/off pwms
> > > > > > are actually using the prescaler. But then we'd be limiting this chip's
> > > > > > functionality.
> > > > > 
> > > > > Yeah, this is obviously much simpler, but the cost is a bit high, in my
> > > > > opinion. I'm fine with this alternative if there aren't any use-cases
> > > > > where multiple outputs are actually used.
> > > > 
> > > > This metric is wishy-washy; of course you can construct a use-case. I'd
> > > > still go for this simpler option and assume the prescaler used if the
> > > > PWM runs at 0% or 100%, but not when it is a GPIO.
> > > 
> > > I don't understand what you're saying here. On one hand you seem to
> > > object to what I was saying, but then you agree with it?
> > > 
> > > And I'm not asking anyone to make up any artificial use-case. What I'm
> > > saying is that if there aren't any existing use-cases that would break
> > > if we assume a pre-scaler is used for full-on/full-off, then I'm okay
> > > with making that assumption and simplifying the driver. If there were
> > > use-cases, then that assumption would break existing users and that's
> > > not something I'm willing to accept.
> > > 
> > > Anything wrong with that metric in your opinion?
> > 
> > The part I called wishy-washy is: "[....] if there aren't any use-cases
> > where [...]". Who should decide what are (relevant) use-cases? We
> > already agreed above that we talk about a hardware that doesn't allow us
> > to consider it consisting of 2 independent channels and so we somehow
> > have to limit their capabilities exposed by the PWM API. And whatever
> > compromise we make, it's not hard to find a more or less realistic use
> > case where the compromise hurts. So my interpretation of your words are:
> > "I'm fine with this alternative if $somethingimpossible" which is not
> > helpful.
> > 
> > So yes, there is something wrong with your metric because it's IMHO
> > impossible for a driver author to actually use it.
> 
> Like I said, that's not what I was saying. I was merely saying that if
> there aren't any use-cases that current users rely on that would be
> broken by using this simpler implementation, then I'm okay with it, even
> if it's less flexible than a more complicated implementation. It should
> be possible to determine what the current users are by inspecting device
> trees present in the kernel. Anything outside the kernel isn't something
> we need to consider, as usual.

I grepped for pca9685 and found no current in-kernel users of this
driver.

After reading your reasoning in this mail and rethinking the whole
situation, I do no longer have any objections to the more complex
solution. (Allowing 0% and 100% duty cycle channels with any period)

I first thought it would be too confusing to block users from changing a
duty cycle when in reality the period is the problem.
However, if we log an error message, explaining that the periods have to
match if duty cycles > 0 and < 100% are used, I think it's OK.

Uwe, Sven: Do you have any objections?

If not, I will prepare a v5 next week.

Thanks,
Clemens
