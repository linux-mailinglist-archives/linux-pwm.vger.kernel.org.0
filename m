Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4122C48B3
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Nov 2020 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgKYTrM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Nov 2020 14:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgKYTrL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Nov 2020 14:47:11 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E8AC0613D4;
        Wed, 25 Nov 2020 11:47:07 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id m16so1823312vsl.8;
        Wed, 25 Nov 2020 11:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6gDMqBpdDHnbrFTSNes0LPiehq/y1BzrpPL6GqPF2w=;
        b=nWMQ7Om6JUXtAgWIh33a3d0HB/Ox7ft2RKbwI6AHYz7bIbJypjR5UKJGiNZl2eoj8+
         CRsvhm5F+VtgUvY6ka8FDHqfnQ0+ujjBz39o4xRhPOJnS7DIo54xkX+gGjp1PdztgObW
         1oJxNMWoyQQ4JJ1sgRCxb2Ze4MiGhh0g15aHsYoBYGWUj8QNzefFGABPPaaWQ4Ym0Z+I
         Ixn5b2YpwXUPHwCvUpmszUpxMmYhOe08ss3gXQV1nqfd87/oaf6zBvHyOpZnKggQ4txZ
         Kho3YUBx1PxOa9pnwEeZIzAgssN7cD6gw8+wRvvEqbwZyQ3eWWYZvTP4irQF4bVbJi2r
         wPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6gDMqBpdDHnbrFTSNes0LPiehq/y1BzrpPL6GqPF2w=;
        b=DY3iEpwxluGJ+aVyqToa4VCAsG4FTs8RTeKnpoAXN4BG0xTTY4DAtzbvcfWHpJc2Ox
         oJZ/Lvx1extWt74n261UVKc4W6s+XaJvIZW30bAJHtgyz+pPJuDVtR0ZKOc2EqD9Hm0c
         FQjDzFbYSRrZaZvpbeaL8EuegpZLDoxXSB4Tw0ouzOA7NEpraTh8RcQL+qcpvRfJJAAX
         DkHv2kA6FAPBFWtIX5mUUqykBdZBh+6OhuKlhUWmDsLMSFZSmpgiJ7QM+PU0P80oklyq
         VqABeeIrBbkRyg3Gs5IVHWJwyIyQcaLb51IlIXdLPeao6J0MgVXp77UIx5E+ycly3+Qx
         yUqQ==
X-Gm-Message-State: AOAM531hPPHDr1a8sF85I4U3OrUllKQEq9xkWd27HLqsv0vnGxW2HrWi
        +CsXELOn6wb1SsjL1hh6jV8aY64o1vOveA/9wxg=
X-Google-Smtp-Source: ABdhPJykjE3DUNCC98xQG/ZidWev84crgp1EFM6B/1Q5kvNhMkYSl2U1qbJ5TUWoZVCmT3IvcPIoDKt89SlDs+/C5pc=
X-Received: by 2002:a67:2ac1:: with SMTP id q184mr3536286vsq.57.1606333626786;
 Wed, 25 Nov 2020 11:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20201124181013.162176-1-clemens.gruber@pqgruber.com>
 <CAGngYiX8KOTQCScWo_o1BRa8CGHBQzWZGz1FmzkwGEmyNgPaxQ@mail.gmail.com>
 <X74XPAy+SJRmQUSH@workstation.tuxnet> <X75kXv7l9RbTOS7S@workstation.tuxnet>
 <CAGngYiViOMO6uM7UeYO5fNMdc+QEjLt+L1TdTii+smTvsmV=aQ@mail.gmail.com> <X76ULTpaWHLkkz/u@workstation.tuxnet>
In-Reply-To: <X76ULTpaWHLkkz/u@workstation.tuxnet>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 25 Nov 2020 14:46:55 -0500
Message-ID: <CAGngYiWVYy=U0bkK7w321Qc7eu9+bEC7asvJAuX7t+OLfimOAQ@mail.gmail.com>
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

On Wed, Nov 25, 2020 at 12:28 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> What's the lesser evil in your opinion, always returning 0 duty and
> disabled for the ALL channel or caching it?
>

I would definitely suggest returning a pwm_state consisting of all zeroes
for the "all led" channel, instead of caching stuff.

And I don't think it's in any way evil: from a user point of view, reading
back the "all led" channel state makes no sense. Why? Because setting
that channel is just a write to all 16 channels at once. And those channels
may change over time.

For example:
1. set all leds channel = enabled, 50% duty cycle
   => all 16 leds are enabled at 50% duty cycle
2. set led 0 = disabled
3. set led 1 = enabled, 70% duty cycle
4. imagine we now read back the "all leds" state, what should it return?
   it makes no sense, because not all leds are in the same state !

>
> Please let me know if I misunderstood you.
>

All good, thanks !

>
> I meant that with sysfs, the period does not change if the new value is
> the same as the last time that channel's period was set.
> See my example above.
>
> But we probably can't do anything about that.
>

Oh I see what you mean. This is because the pwm core makes certain basic
assumptions about pwm devices. It assumes that channels are completely
independent, ie. setting channel X state won't influence channel Y.
And that's not the case for this chip.

I think the current pwm core behaviour is not ideal for us, but acceptable.
Let's get our own house in order before worrying about the core's behaviour.

>
> OK, regmap accesses are protected with locks but what about the SLEEP
> bit that needs to be set/cleared + sleep. Shouldn't we only allow one
> thread at one time to change the prescaler of a chip? Otherwise, there
> could be synchronization issues there too. (Possible writing to the
> prescale register with the SLEEP bit unset by another thread)

Good point. Luckily, the runtime_pm code is completely thread-safe.
It's quite common for drivers to use that code from multiple threads.
That's the cool thing about re-using existing kernel infrastructure,
you get all of that for free, and tested too.

You only reach the danger zone if you're doing things that the core
is completely not expecting. In this case, the core doesn't expect
that a pwm_apply() on one channel modifies any unprotected shared state.

>
> If we drop the cache we would have to read the prescale register
> whenever we need it (for every channel) but with the upcoming regmap
> cache feature, this would probably be OK.

We only need to read the prescale register during pwm_get_state() and
pwm_apply(), correct? I count many regmap_read()s in those functions.

One extra regmap_read() to retrieve the prescale, won't make much difference,
even when regmap cache is off.

>
> Do you think this should be solved in the same patch as the atomic API
> conversion or can we do this in a follow-up patch?
>

Suggestion: in the atomic API patch, do not cache prescale, just read it
out as needed. This is slightly slower, but I suspect that the code
will become shorter and simpler.

Then if you have time && motivation left, enable regmap cache.
But watch out... you'll probably have to invalidate the cache
each time the driver writes to an ALL_LED register. Because that
implies a write to 16 other registers.

But the efficiency saving is probably very limited, and may not be
worth the added complexity.
