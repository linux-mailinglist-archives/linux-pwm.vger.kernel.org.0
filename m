Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26222C46C3
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Nov 2020 18:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbgKYR2R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Nov 2020 12:28:17 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:37450 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732469AbgKYR2R (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 25 Nov 2020 12:28:17 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 84804C81EED;
        Wed, 25 Nov 2020 18:28:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1606325294;
        bh=5Jb6iatCRPIVZK7/khB6ZO3GMcwJebtuMG5SMJqkQoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPzd6edkUMCHs23d1821Sw4aiJJfQKOF0J4390OrXFl7/r34ZAfRnKujUkGdgcT7J
         I2j/P8RhaFy6j8i9sde0fu2CAiBqePoVqnSxaVZZ9aAoLEoD0ZoW8BE6nfwii8N8eS
         tLjs17iGN/8GYDyD9IiDedwc9spBE3gmVG6mgja0=
Date:   Wed, 25 Nov 2020 18:28:13 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X76ULTpaWHLkkz/u@workstation.tuxnet>
References: <20201124181013.162176-1-clemens.gruber@pqgruber.com>
 <CAGngYiX8KOTQCScWo_o1BRa8CGHBQzWZGz1FmzkwGEmyNgPaxQ@mail.gmail.com>
 <X74XPAy+SJRmQUSH@workstation.tuxnet>
 <X75kXv7l9RbTOS7S@workstation.tuxnet>
 <CAGngYiViOMO6uM7UeYO5fNMdc+QEjLt+L1TdTii+smTvsmV=aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiViOMO6uM7UeYO5fNMdc+QEjLt+L1TdTii+smTvsmV=aQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sven,

On Wed, Nov 25, 2020 at 10:04:32AM -0500, Sven Van Asbroeck wrote:
> On Wed, Nov 25, 2020 at 3:35 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > >
> > > The datasheet I found for this chip indicates that every ALL_LED_XXX register
> > > is write-only. Those registers cannot be read back from the chip.
> > >
> > > Datasheet "Rev. 4 - 16 April 2015"
> >
> > Thanks, good catch! Would you agree that we should just return 0 duty
> > cycle and disabled state if the "all LEDs" channel is used?
> 
> I think get_state() for the all led channel should just return -ENOTSUPP,
> if the pwm core will allow that.
> 
> Because it's the truth, the chip does not support reading from the all led
> channel.

I thought about that too, but get_state is a void function and there is
no error/errno variable in pwm_state that could signal a problem.

> 
> When we start buffering the all led state, we make the code much
> more complex, and again we'll run into all sorts of subtle corner cases.

What's the lesser evil in your opinion, always returning 0 duty and
disabled for the ALL channel or caching it?

> 
> > > > +
> > > > +       if (duty < PCA9685_COUNTER_RANGE) {
> > >
> > > How can duty >= 4096 ?
> > >
> > > > +               duty *= state->period;
> > > > +               state->duty_cycle = duty / (PCA9685_COUNTER_RANGE - 1);
> > >
> > > is this calculation correct?
> > > imagine led_on = 0 (default), and led_off = 4095
> > > then the led is off for one single tick per cycle
> > > but the above formula would calculate it as full on (period == duty_cycle)?
> 
> I just wanted to make sure you hadn't overlooked the two comments above.

Yes I saw them, thanks. You are suggesting that we change the scaling of
the relative duty cycle from 0..4095 to 0..4096 and in .apply_state we
do full OFF if 0 and full ON if 4096, so we still have a 4095 duty state
with a single tick off?
Then in .get_state: duty_cycle = (duty * period) / COUNTER_RANGE

Please let me know if I misunderstood you.

> 
> --
> 
> Each time I read the code, my thoughts get interrupted by all this
> if hwpwm >= MAXCHAN then { one macro } else { another macro } business
> which is spread around in the code !
> 
> Same thing with the splitting of the value between H and L registers.
> Same thing with the LED_FULL bit.

Yes, this is indeed confusing.

> 
> Maybe the code will be much more readable if we do the following?
> 
> - keep pca9685_pwm_full_off/full_on but rename to pca9685_pwm_set_full_off/on
> - create pca9685_pwm_is_full_off/on
> - create pca9685_pwm_set_on_time/set_off_time
> 
> Then LED_FULL, >= MAXCHAN, and register splits are fully confined to
> these functions, and we can call them freely in the rest of the code,
> without getting confused by these details.

Great idea!

> 
> --
> 
> > I noticed something else that does not look great:
> > Let's say you set up pwm channel 0 with a period of 5000000 and after
> > that you set up pwm channel 1 with a period of 40000000.
> > So far so good. But if you now set pwm channel 0's period to 5000000
> > again, the period stays at 40000000. (Tested with /sys/class/pwm)
> >
> 
> If the driver isn't buggy, this should work ok. Changing the period on one
> channel changes the global prescale, which in turn changes the period on
> every other channel. But that's ok, because the ON/OFF times are relative
> to a 4096-tick counter, so all duty cycles are preserved.
> 
> Example:
> 1. SET channel 0 : duty  50_000 period 100_000 (real duty cycle = 0.5)
> 2. SET channel 1 : duty  50_000 period 200_000 (real duty cycle = 0.25)
> 3. GET channel 0 : duty 100_000 period 200_000 (real duty cycle STILL 0.5)
> 
> I think this is acceptable behaviour.

Yes the effect of a global period change to the duty cycles of other
channels is acceptable but that was not what I meant.

I meant that with sysfs, the period does not change if the new value is
the same as the last time that channel's period was set.
See my example above.

But we probably can't do anything about that.

> 
> --
> 
> I have been thinking about how this patch caches the global prescaler.
> There is a possible synchronization issue. Sysfs will always work ok, because
> it uses a mutex to protect accesses to pwm_set_state(), which means set_state()
> will never be called concurrently.
> 
> But I do not think there's any protection when the driver is used as a client
> in the devicetree, like so:
> 
> &i2c1 {
>         my_pca: pwm@0 {
>                 compatible = "nxp,pca9685-pwm";
>                 reg = <0>;
>         };
> };
> 
> acme_device@0 {
>         pwms = <&my_pca 2 10000000>;
> };
> 
> acme_device@1 {
>         pwms = <&my_pca 1 20000000>;
> };
> 
> For most pwm drivers, this is fine, because their registers are strictly
> separated: writes to channel 0 and 1 do not touch the same registers.
> 
> But in our case, because of the cached prescale, things can go very wrong.
> 
> I think this can be solved by simply not caching prescale. Everything then
> stays on the stack, and the last thread to set the prescaler wins.

OK, regmap accesses are protected with locks but what about the SLEEP
bit that needs to be set/cleared + sleep. Shouldn't we only allow one
thread at one time to change the prescaler of a chip? Otherwise, there
could be synchronization issues there too. (Possible writing to the
prescale register with the SLEEP bit unset by another thread)

If we drop the cache we would have to read the prescale register
whenever we need it (for every channel) but with the upcoming regmap
cache feature, this would probably be OK.

Do you think this should be solved in the same patch as the atomic API
conversion or can we do this in a follow-up patch?

Thanks,
Clemens
