Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC482C429A
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Nov 2020 16:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbgKYPEo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Nov 2020 10:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgKYPEo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Nov 2020 10:04:44 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447E7C0613D4;
        Wed, 25 Nov 2020 07:04:44 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id y78so1352882vsy.6;
        Wed, 25 Nov 2020 07:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpVYQAqnvy4rHeUw87Uisf5E4OSMaWyqznDJ4TU5XYI=;
        b=ZPCbtWaDTQJhHDLjtg3Kn0VDf3V9qpZoM1TEgAR3mCp10uupQhZtKJcqv47q8CN0pJ
         ku4wnHzGt8fdGI0Z6e3SxYH8yYPIn9bZufy17ecdwDlx8XOGyRub5B3tD3BXJm30V8XJ
         cO5+jMPjBMwyw1FcTgVZi8lCGTZ9CIxMkEy/v+AkhsUF1NGWN7nzvosVdDJNZBYOUqNh
         AOHtxkloUX2MUcGtHkqY6ZvK7joJkEn6BhxtqQ+MIHbL1ANxnfzo89Dz6ZGsKL8rKorO
         oxQBHzuvPEcD4Iu5Z90PakGacZkwHoxdDqGxIEgzyKxXoMlwKwPHfKoeimYW0EMhOC93
         8fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpVYQAqnvy4rHeUw87Uisf5E4OSMaWyqznDJ4TU5XYI=;
        b=iTvf+ACxd4eP4CAaKQiAvTVG1Boq25NIffTgdzPv1QVkYTola/cAjPGBppBBB296rE
         xhKbvWY7DbKz/T/NvfwY2x5l8I10hScV54js+5CalvLbn2WLjUFyf0m0lwUQuUGjahfW
         H96jwc40Y7XoPew2AcGSctqh4DlyX0FnQFYvwuGNf7TSYQ+4RUVi8kptJQvOS4tvc55m
         1sZe55UlvCE/HSr0EZhwF6/lnP5WsPxKDA+LDOrLmw2B7pi10BUmImOd0aMnZtaKb9x1
         tR1MGorkMOaeb2UrTXF40qhz6B2NCaV3iV3LhXHcZs/rDbvTw37NLns/cpo2xy6h5rD6
         yLmg==
X-Gm-Message-State: AOAM5313fPNdKUPI6njEDSfBjo2ZQBxMYZrwEO5Mp7rgWDIgBKe9LnNz
        8SklJB00UUcYZuN3JcszZSMKBKAvkDScvn5dFD4=
X-Google-Smtp-Source: ABdhPJysKbLV0+lnEyHZOdjaKI59dxmhvB/wRyV0ulqq8xAIt0LW3DjTrRRJgb4gVQ0QCBZa/cyKDpXLoI2PzZ0AhfY=
X-Received: by 2002:a67:b347:: with SMTP id b7mr2257166vsm.15.1606316683254;
 Wed, 25 Nov 2020 07:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20201124181013.162176-1-clemens.gruber@pqgruber.com>
 <CAGngYiX8KOTQCScWo_o1BRa8CGHBQzWZGz1FmzkwGEmyNgPaxQ@mail.gmail.com>
 <X74XPAy+SJRmQUSH@workstation.tuxnet> <X75kXv7l9RbTOS7S@workstation.tuxnet>
In-Reply-To: <X75kXv7l9RbTOS7S@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 25 Nov 2020 10:04:32 -0500
Message-ID: <CAGngYiViOMO6uM7UeYO5fNMdc+QEjLt+L1TdTii+smTvsmV=aQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] pwm: pca9685: Switch to atomic API
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 25, 2020 at 3:35 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> >
> > The datasheet I found for this chip indicates that every ALL_LED_XXX register
> > is write-only. Those registers cannot be read back from the chip.
> >
> > Datasheet "Rev. 4 - 16 April 2015"
>
> Thanks, good catch! Would you agree that we should just return 0 duty
> cycle and disabled state if the "all LEDs" channel is used?

I think get_state() for the all led channel should just return -ENOTSUPP,
if the pwm core will allow that.

Because it's the truth, the chip does not support reading from the all led
channel.

When we start buffering the all led state, we make the code much
more complex, and again we'll run into all sorts of subtle corner cases.

> > > +
> > > +       if (duty < PCA9685_COUNTER_RANGE) {
> >
> > How can duty >= 4096 ?
> >
> > > +               duty *= state->period;
> > > +               state->duty_cycle = duty / (PCA9685_COUNTER_RANGE - 1);
> >
> > is this calculation correct?
> > imagine led_on = 0 (default), and led_off = 4095
> > then the led is off for one single tick per cycle
> > but the above formula would calculate it as full on (period == duty_cycle)?

I just wanted to make sure you hadn't overlooked the two comments above.

--

Each time I read the code, my thoughts get interrupted by all this
if hwpwm >= MAXCHAN then { one macro } else { another macro } business
which is spread around in the code !

Same thing with the splitting of the value between H and L registers.
Same thing with the LED_FULL bit.

Maybe the code will be much more readable if we do the following?

- keep pca9685_pwm_full_off/full_on but rename to pca9685_pwm_set_full_off/on
- create pca9685_pwm_is_full_off/on
- create pca9685_pwm_set_on_time/set_off_time

Then LED_FULL, >= MAXCHAN, and register splits are fully confined to
these functions, and we can call them freely in the rest of the code,
without getting confused by these details.

--

> I noticed something else that does not look great:
> Let's say you set up pwm channel 0 with a period of 5000000 and after
> that you set up pwm channel 1 with a period of 40000000.
> So far so good. But if you now set pwm channel 0's period to 5000000
> again, the period stays at 40000000. (Tested with /sys/class/pwm)
>

If the driver isn't buggy, this should work ok. Changing the period on one
channel changes the global prescale, which in turn changes the period on
every other channel. But that's ok, because the ON/OFF times are relative
to a 4096-tick counter, so all duty cycles are preserved.

Example:
1. SET channel 0 : duty  50_000 period 100_000 (real duty cycle = 0.5)
2. SET channel 1 : duty  50_000 period 200_000 (real duty cycle = 0.25)
3. GET channel 0 : duty 100_000 period 200_000 (real duty cycle STILL 0.5)

I think this is acceptable behaviour.

--

I have been thinking about how this patch caches the global prescaler.
There is a possible synchronization issue. Sysfs will always work ok, because
it uses a mutex to protect accesses to pwm_set_state(), which means set_state()
will never be called concurrently.

But I do not think there's any protection when the driver is used as a client
in the devicetree, like so:

&i2c1 {
        my_pca: pwm@0 {
                compatible = "nxp,pca9685-pwm";
                reg = <0>;
        };
};

acme_device@0 {
        pwms = <&my_pca 2 10000000>;
};

acme_device@1 {
        pwms = <&my_pca 1 20000000>;
};

For most pwm drivers, this is fine, because their registers are strictly
separated: writes to channel 0 and 1 do not touch the same registers.

But in our case, because of the cached prescale, things can go very wrong.

I think this can be solved by simply not caching prescale. Everything then
stays on the stack, and the last thread to set the prescaler wins.
