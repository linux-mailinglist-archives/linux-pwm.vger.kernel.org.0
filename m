Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D16C22166C
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2020 22:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOUl3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Jul 2020 16:41:29 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:47993 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGOUl2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Jul 2020 16:41:28 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 71B5922F2E;
        Wed, 15 Jul 2020 22:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594845686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3U1SBlUinuhJl85Sa7kxkMj4b/Hr+xewNJibfLEqa4=;
        b=hQlqcyEGsOVJe8ki27bM0+KSN+OCVOGswOIHehFP1dm0qd6dipPO3oo/L/wS1eVkX+PjVm
        0SFJ8KAlGWHXIQ7OMAkMDh5iLsvJe2Hq9hj0tYmRZ38nXzdFfbWodOAdvpk/46dwyXR/sf
        93Hvn3zCQTK2J/heKqDRRN15nXhUsxU=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 15 Jul 2020 22:41:25 +0200
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 07/13] pwm: add support for sl28cpld PWM controller
In-Reply-To: <20200715181803.nmgi32tugpbuqvjg@pengutronix.de>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
 <20200709085006.b54ype3p4yu64upl@pengutronix.de>
 <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
 <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
 <c0594c34c712ce26b3936d42c92d2361@walle.cc>
 <20200714160856.rjqi7lv63geil3hm@pengutronix.de>
 <eedceb44cba9b54e0634f0e8e4f96f70@walle.cc>
 <20200715163620.xhi24mct5b64qpyp@pengutronix.de>
 <7d8e9f524f0fd81be282be0be50d16ad@walle.cc>
 <20200715181803.nmgi32tugpbuqvjg@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <8debe0ee9aff2c49a7567069d7bb9477@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Am 2020-07-15 20:18, schrieb Uwe Kleine-König:
> On Wed, Jul 15, 2020 at 07:45:10PM +0200, Michael Walle wrote:
>> 
>> Am 2020-07-15 18:36, schrieb Uwe Kleine-König:
>> > On Tue, Jul 14, 2020 at 11:09:28PM +0200, Michael Walle wrote:
>> > > > My wishlist (just as it comes to my mind, so no guarantee of
>> > > > completeness):
>> > > >
>> > > >  - can do 0% duty cycle for all supported period lengths
>> > > >  - can do 100% duty cycle for all supported period lengths
>> > > >  - supports both polarities
>> > > >  - supports immediate change of configuration and after completion of
>> > > >    the currently running period
>> > > >  - atomic update (i.e. if you go from configuration A to configuration B
>> > > >    the hardware guarantees to only emit periods of type A and then type
>> > > >    B. (Depending on the item above, the last A period might be cut off.)
>> > >
>> > > We actually discussed this, because the implementation would be
>> > > easier. But
>> > > if the change takes place immediately you might end up with a longer
>> > > duty
>> > > cycle. Assume the PWM runs at 80% duty cycle and starts with the
>> > > on-period.
>> > > If you now change that to 50% you might end up with one successive
>> > > duty
>> > > cycle of "130%". Eg. the 80% of the old and right after that you
>> > > switch to
>> > > the new 50% and then you'd have a high output which corresponds to a
>> > > 130%
>> > > cycle. I don't know if that is acceptable for all applications.
>> >
>> > I thought this is a "change takes place immediately" implementation?! So
>> > these problems are actually real here. (And this not happening is
>> > exactly
>> > my wish here. Is there a mis-understanding?)
>> 
>> I wasn't talking about the sl28cpld btw. What is the difference 
>> between
>> your proposed "change take place immediately" and "after the cycle".
>> I understand how the after the cycle should work. But how would the
>> immediate change work in your ideal PWM?
> 
> If the PWM is running at 1/3 duty cycle and reconfigured for 2/3, then
> the two scenarios are (the * marks the moment where pwm_apply_state() 
> is
> called, ^ marks the start of a period):
> 
> immediately:
> 
>   __       __    _____    _____
>  /  \_____/  \__/     \__/
>  ^        ^     ^        ^
>                 *

Ok lets assume 2/3 and change it to 1/3:

    ____     ______      __
   /    \___/      \____/  \____
   ^        ^   ^       ^
                *
This will then have a longer on period than any of the settings.

> and with my ideal PWM I can choose which of the two behaviours I want.

Ahh, that I've missed.

>> > > > > > What about disable()?
>> > > > >
>> > > > > Mhh well, it would do one 100% cycle.. mhh ;) Lets see if there we can
>> > > > > fix that (in hardware), not much we can do in the driver here. We are
>> > > > > _very_ constraint in size, therefore all that little edge cases fall
>> > > > > off
>> > > > > the table.
>> > > >
>> > > > You're saying that on disable the hardware emits a constant high level
>> > > > for one cycle? I hope not ...
>> > >
>> > > Mh, I was mistaken, disabling the PWM will turn it off immediately,
>> > > but
>> >
>> > And does turn off mean, the output gets inactive?
>> > If so you might also disable the hardware if a 0% duty cycle is
>> > configured assuming this saves some energy without modifying the
>> > resulting wave form.
>> 
>> Disabling it has some side effects like switching to another function
>> for this multi function pin. So I'd rather keep it on ;)
> 
> So IMHO you should also keep it on when pwm_apply_state is called with
> state.enabled = false to ensure a low output.

That won't work either, because that is how you would turn on that multi
function. Ie. it is GPIO (default input) as long as the PWM is not 
enabled,
otherwise its PWM.

-michael
