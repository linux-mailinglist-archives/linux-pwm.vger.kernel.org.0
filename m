Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2121FF9F
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2020 23:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgGNVJd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Jul 2020 17:09:33 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:33871 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgGNVJc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jul 2020 17:09:32 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 169EE22FB3;
        Tue, 14 Jul 2020 23:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594760969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AoDvP+OzW/wwTOs72I67TRZ+06uoGV7X/2qnpc/9rQ=;
        b=BZmzeIaSbj+Tme4+wzwLPgEdCz+d98gFzXsqF4qIFLcAjIRaiy4OrJjoCkFdo4ipBQc2D+
        /ZHLBmbLwwnIY+C153lVLlu1QhkmQK09njzFQ6aCqKUZRs5EhN3s/iGw8tLFCiBfFe7L83
        lIJT60kEw2+nPfy8vgOjxtuXcwQezIs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 14 Jul 2020 23:09:28 +0200
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
In-Reply-To: <20200714160856.rjqi7lv63geil3hm@pengutronix.de>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
 <20200709085006.b54ype3p4yu64upl@pengutronix.de>
 <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
 <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
 <c0594c34c712ce26b3936d42c92d2361@walle.cc>
 <20200714160856.rjqi7lv63geil3hm@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <eedceb44cba9b54e0634f0e8e4f96f70@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Am 2020-07-14 18:08, schrieb Uwe Kleine-König:
> On Tue, Jul 14, 2020 at 01:31:13PM +0200, Michael Walle wrote:
>> Am 2020-07-13 10:47, schrieb Uwe Kleine-König:
>> > I already thought about proposing pwm_get_rate_hw(), but for now there
>> > is (AFAICT) no user who would need it. And it's hard to know which
>> > variant is actually preferred by consumers. My expectation is that most
>> > don't even care.
>> >
>> > I also have a pwm_round_rate() function in mind that will give you the
>> > actual rate without applying it. This can then be used by consumers who
>> > care. But also there is no user who would need it today.
>> 
>> Ok. I take it that all such improvements are still in the making ;)
> 
> If you have a real use case, present it, then I give it a boost on my
> todo list.

Not really.

>> > > But the PWM subsystem returns the cached state,
>> > > right? get_state() is called only on device request (and during
>> > > debug it seems). Actually, enabling PWM_DEBUG might choke on this
>> > > workaround (".apply didn't pick the best available period"). Is
>> > > this ok?
>> >
>> > hmm, I didn't consider this when writing the checks for PWM_DEBUG.
>> > According to the currently checked rules the expected configuration is
>> > to pick the 250Hz mode and use cycle = 0x7f.
>> 
>> Not to use 0x80, which is the max_duty_cycle? Like its 0x40 for the 
>> 500Hz
>> mode.
> 
> No, when I thought about a sane set of rules (and so checks for
> PWM_DEBUG) I didn't consider a PWM that can implement 100% but not for
> all otherwise available period lengths. I'm still amazed sometimes how
> different the capabilities of different implementations for something 
> so
> seemingly easy like a PWM are.
> 
>> > Hmm, I have to think about
>> > this. Maybe we should weaken the check to the cases with
>> > 0 < duty_cycle < period. Thierry, what do you think?
>> >
>> > Special casing 0% and 100% is annoying, but insisting 250Hz + 0x7f seems
>> > to be far from reality. (Is it?)
>> 
>> If you mean by insisting to clip at 0x7f, yeah thats bad IMHO, because
>> the user wants an all-high line, but in the end it would be a toggling
>> line. It wouldn't be that bad for anything in between 0% and 100% but
>> IMHO its bad for exactly 0% and 100%.
>> 
>> You could also ask the driver about known quirks, like special 0% and
>> 100% handling and exclude it from the tests accordingly.
> 
> Do you care enough to propose a patch? You're in the situation to test
> it.

Ok. I'll come up with something outside of this patch series.

>> > > > > +	ret = regmap_write(priv->regmap, priv->offset + PWM_CTRL, ctrl);
>> > > > > +	if (ret)
>> > > > > +		return ret;
>> > > > > +
>> > > > > +	return regmap_write(priv->regmap, priv->offset + PWM_CYCLE,
>> > > > > (u8)cycle);
>> > > >
>> > > > I assume this can result in broken output? Consider the hardware runs
>> > > > with mode = 1 & cycle = 0x23 and you want to go to mode = 0 & cycle =
>> > > > 0x42: Can this result in a period that has mode = 0 & cycle = 0x23?
>> > >
>> > > Isn't that always the case if a write may fail and there are more than
>> > > one register to configure?
>> >
>> > Depending on hardware capabilities you might not be able to prevent
>> > this yes. Unfortunately this is quite common.
>> >
>> > But there are hardware implementations that are not prone to such
>> > failures. (E.g. the registers written can be only shadow values that are
>> > latched into hardware only when the last value is written.)
>> 
>> Maybe this could be improved in the future.
> 
> We should somewhere describe, what an ideal PWM can do.
> My wishlist (just as it comes to my mind, so no guarantee of
> completeness):
> 
>  - can do 0% duty cycle for all supported period lengths
>  - can do 100% duty cycle for all supported period lengths
>  - supports both polarities
>  - supports immediate change of configuration and after completion of
>    the currently running period
>  - atomic update (i.e. if you go from configuration A to configuration 
> B
>    the hardware guarantees to only emit periods of type A and then type
>    B. (Depending on the item above, the last A period might be cut 
> off.)

We actually discussed this, because the implementation would be easier. 
But
if the change takes place immediately you might end up with a longer 
duty
cycle. Assume the PWM runs at 80% duty cycle and starts with the 
on-period.
If you now change that to 50% you might end up with one successive duty
cycle of "130%". Eg. the 80% of the old and right after that you switch 
to
the new 50% and then you'd have a high output which corresponds to a 
130%
cycle. I don't know if that is acceptable for all applications.

>  - emits an irq when configuration changes

Why would you need the interrupt?

> 
>> > If you change only cycle but not mode, does the hardware complete the
>> > currently running period?
>> 
>> No it does not.
> 
> Please document this as a Limitation.

I've discussed this internally, for now its a limitation. In the worst
case you'd do one 100% duty cycle. Maybe we can fix the hardware. I
acknowledge that this is a severe limitation, esp. if you use the PWM
for controlling stuff (for now its only LCD backlight.. so thats ok).

>> > What about disable()?
>> 
>> Mhh well, it would do one 100% cycle.. mhh ;) Lets see if there we can
>> fix that (in hardware), not much we can do in the driver here. We are
>> _very_ constraint in size, therefore all that little edge cases fall 
>> off
>> the table.
> 
> You're saying that on disable the hardware emits a constant high level
> for one cycle? I hope not ...

Mh, I was mistaken, disabling the PWM will turn it off immediately, but
one 100% duty cycle may happen if you change from a higher to a lower
duty cycle setting. See above.

> I never programmed a CPLD to emulate a hardware PWM, but I wonder if
> these are really edge cases that increase the size of the binary?!

At the moment there is only one 8bit register which stores the value
which is used for matching. If you want to change that setting after
a whole cycle, you'd use another 8bit register to cache the new value.
So this would at least needs 8 additional flip-flops. This doesn't
sound much, but we are already near 100% usage of the CPLD. So its
hard to convince people why this is really necessary.

-michael
