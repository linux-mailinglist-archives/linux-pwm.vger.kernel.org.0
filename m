Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA92B973C
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 17:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgKSQAS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Nov 2020 11:00:18 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:36716 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbgKSQAR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Nov 2020 11:00:17 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 053F4C6866D;
        Thu, 19 Nov 2020 17:00:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605801615;
        bh=+EByFA9DgtbSpmJVu8ypTg5YXyFZQXFlJcvMgKd16EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5B0zJsDUxZxq9qxtD/TtfPWDMIw/2NXszmc2emvIuWAX6mEKbMbbtVnCo741AA3n
         +ll6+OFWJwX94DGuAVKOiwwLdju5EZVHG/gV37yvM+y6BwybWY7KIrG0LAx9PhWV4x
         b0yCvdQ54KhOcn7hPvnOZHHFF2mgKbUe5WvqxNgc=
Date:   Thu, 19 Nov 2020 17:00:13 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH 1/3] pwm: pca9685: Switch to atomic API
Message-ID: <20201119160013.GA217674@workstation.tuxnet>
References: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
 <CAGngYiV+oDeagaCfpeACMzQyDHVzk9ERbSBjW_fW5hoQANHqog@mail.gmail.com>
 <20201119100005.GA703@workstation.tuxnet>
 <CAGngYiU7+X1AbadQ0kFBQOqxK-adowg6CTOMx260fyF1-rpO-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiU7+X1AbadQ0kFBQOqxK-adowg6CTOMx260fyF1-rpO-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 19, 2020 at 09:58:26AM -0500, Sven Van Asbroeck wrote:
> On Thu, Nov 19, 2020 at 5:00 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > > You appear to mix cached and uncached uses of prescale,
> > > is there a need for this? If not, perhaps pick one and use
> > > it consistently?
> >
> > Yes, sticking to the cached value is probably the way to go.
> >
> 
> I would suggest going one step further, and turn on the cache in
> regmap, i.e. .cache_type = REGCACHE_RBTREE, then:
> - no need to cache pca->prescale explicitly, you can just read it with
>   regmap_read() every time, and it won't result in bus activity.
>   then you can eliminate pca->prescale, which simplifies the driver.
> - pca9685_pwm_get_state() no longer results in bus reads, every regmap_read()
>   is cached, this is extremely efficient.
> - pca9685_pwm_apply() and pca9685_pwm_gpio_set() now only does bus writes if
>   registers actually change, i.e. calling pwm_apply() multiple times in a row
>   with the same parameters, writes the registers only once.

Interesting, I will look into that.

> 
> We can do this safely because this chip never actively writes to its
> registers (as far as I know).

I think so too.

> 
> But maybe that's a suggestion for a follow-up patch...
> 
> > > Also, if the prescale register contains an invalid value
> > > during probe(), e.g. 0x00 or 0x01, would it make sense
> > > to explicitly overwrite it with a valid setting?
> >
> > As long as it is overwritten with a correct setting when the PWM is used
> > for the first time, it should be OK?
> 
> I'm not sure. Consider the following scenario:
> - prescale register is invalid at probe, say it contains 0x02
> - user calls pwm_apply() but with an invalid period, which results
>   in a calculated prescale value of 0x02
> - pca9685_pwm_apply() skips prescale setup because prescale does not
>   change, returns OK(0)
> - user believes setup was ok, actually it's broken...

Makes sense. I will write the default prescale setting in case we read
an invalid one from the register.

> 
> Also, some people use this chip exclusively as a gpiochip, in that
> case the prescale register is never touched. So an invalid prescale
> at probe is never corrected.
> 
> Speaking of the gpiochip side, would it make sense to call
> pca9685_pwm_full_on()/_off() in pca9685_pwm_gpio_set() too?

Yes, I think so. Would be cleaner and we avoid setting all registers to
0 when the GPIO is disabled.

--

One thing I noticed: The driver currently assumes that it comes out of
POR in "active" state (comment at end of probe and PM calls).
However, the SLEEP bit is set by default / after POR.

Do you agree with the following solution?
1) In .probe: call pm_runtime_set_suspended() instead of _set_active()
   (If CONFIG_PM is enabled, the SLEEP bit will be cleared in .resume)
2) If !CONFIG_PM: Clear the SLEEP bit in .probe

Thanks,
Clemens
