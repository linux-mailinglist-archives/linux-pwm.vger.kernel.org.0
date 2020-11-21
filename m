Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F532BC01C
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Nov 2020 15:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgKUO6r (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 21 Nov 2020 09:58:47 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:42150 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbgKUO6r (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 21 Nov 2020 09:58:47 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 206B5C81EE6;
        Sat, 21 Nov 2020 15:58:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605970725;
        bh=X7Fb/le7jJZZn56k8bDHn1hGRtZJ8YcitVPw1rcB7pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gp4rfGUUKdoan+cR+QrF42Ari1GTO7j7if1OryQ7huMAM9UYJUb+W9mCnK9PavzpJ
         YTh7yWqBhvpBRA6sAO2dweiGsebdmb7Q6iww5nglrQ/XhTEeGHHqAc+nQuMA8X014f
         mdPYEvQBVTE1gLFSR63dZbD/yBtuW4MvBFPmr5Gk=
Date:   Sat, 21 Nov 2020 15:58:43 +0100
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
Message-ID: <X7krI+JkhCO5nYC+@workstation.tuxnet>
References: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
 <CAGngYiV+oDeagaCfpeACMzQyDHVzk9ERbSBjW_fW5hoQANHqog@mail.gmail.com>
 <20201119100005.GA703@workstation.tuxnet>
 <CAGngYiU7+X1AbadQ0kFBQOqxK-adowg6CTOMx260fyF1-rpO-Q@mail.gmail.com>
 <20201119160013.GA217674@workstation.tuxnet>
 <CAGngYiUELShMgFnvq6XzF0v=2UAwj7gJsPmbdGkmyAbzhM8OLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiUELShMgFnvq6XzF0v=2UAwj7gJsPmbdGkmyAbzhM8OLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 19, 2020 at 12:29:26PM -0500, Sven Van Asbroeck wrote:
> On Thu, Nov 19, 2020 at 11:00 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > One thing I noticed: The driver currently assumes that it comes out of
> > POR in "active" state (comment at end of probe and PM calls).
> > However, the SLEEP bit is set by default / after POR.
> 
> Very good point, the comment is probably not correct.
> 
> It would be wrong to assume that the chip is in any particular
> state when probe() runs. There is no reset pin, so the CPU running
> Linux could have reset while manipulating the chip, there could even
> be leftover state from a bootloader talking to the chip, etc...
> 
> I remember running into this myself at the time.
> 
> However, we want to make sure that the runtime pm puts the chip to sleep,
> no matter its initial state. So the current code is correct, but the
> comment can be changed to:
> 
> /*
>  * Chip activity state unknown. Tell the runtime pm that the chip is
>  * active, so pm_runtime_enable() will force it into suspend.
>  * Which is what we want as all outputs are disabled at this point.
>  */

I think it is better if we set the correct runtime pm state in .probe,
depending on the SLEEP bit being set. Then, if the chip is already in
SLEEP state, there is no need for the suspend function to be called.

> > 2) If !CONFIG_PM: Clear the SLEEP bit in .probe
> 
> Is anyone likely to use this driver without CONFIG_PM? My kernel won't even
> build without it...
> 
> If you personally have no use for it, then I would not bother with the
> !CONFIG_PM case. Just formalize in Kconfig that the driver needs PM.
> 
> I think we can add "depends on PM" or "select PM", I am not sure which one
> to use here.

I'd rather continue supporting this driver with !CONFIG_PM. (In our
company we have a product with a !CONFIG_PM build using this driver)

I am thinking about the following solution:
#ifdef CONFIG_PM
  /* Set runtime PM status according to chip sleep state */
  if (reg & MODE1_SLEEP)
    pm_runtime_set_suspended(..);
  else
    pm_runtime_set_active(..);

  pm_runtime_enable(..);
#else
  /* If in SLEEP state on non-PM environments, wake the chip up */
  if (reg & MODE1_SLEEP)
    pca9685_set_sleep_mode(.., false)
#endif

--

About the regmap cache: I looked into it and think it is a good idea but
it's probably best to get these patches merged first and then rework the
driver to using the regmap cache?

Thanks for your help!

Clemens
