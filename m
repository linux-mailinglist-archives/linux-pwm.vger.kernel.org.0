Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3615521EF4C
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2020 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGNLbW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Jul 2020 07:31:22 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:53911 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgGNLbV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jul 2020 07:31:21 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9E9F923E3E;
        Tue, 14 Jul 2020 13:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594726275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53jZjqevdppNi/yPIRQg2AGTGap+wTalwrrJRLNTHkU=;
        b=oZPuaMI5n9JcNcJazDlv0RSFMj4WOC+gqar4/Co4Kxz7/Hb7U5vgBXcQs6GEpXf7dh4F+9
        okQu640x5S3A6ZNaTHQNsQlmknQW2gWwVclz7HLhS7lQthG7TrUC0pnvs2sO4NyNrfuNTI
        15AGe/n0EBgZBcrxLxoNeBaPdV1MhCo=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 14 Jul 2020 13:31:13 +0200
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
In-Reply-To: <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
 <20200709085006.b54ype3p4yu64upl@pengutronix.de>
 <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
 <20200713084750.qj4hquzd6uz6y526@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <c0594c34c712ce26b3936d42c92d2361@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Am 2020-07-13 10:47, schrieb Uwe Kleine-König:
> On Sat, Jul 11, 2020 at 07:28:05PM +0200, Michael Walle wrote:
>> Am 2020-07-09 10:50, schrieb Uwe Kleine-König:
>> > On Mon, Jul 06, 2020 at 07:53:47PM +0200, Michael Walle wrote:
>> > > diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
>> > > new file mode 100644
>> > > index 000000000000..8ee286b605bf
>> > > --- /dev/null
>> > > +++ b/drivers/pwm/pwm-sl28cpld.c
>> > > @@ -0,0 +1,187 @@
>> > > +// SPDX-License-Identifier: GPL-2.0-only
>> > > +/*
>> > > + * sl28cpld PWM driver
>> > > + *
>> > > + * Copyright 2020 Kontron Europe GmbH
>> > > + */
>> >
>> > Is there publically available documenation available? If so please add a
>> > link here.
>> 
>> Unfortunately not. But it should be easy enough and I'll describe it
>> briefly in the header.
> 
> That's fine.
> 
>> > > +#include <linux/bitfield.h>
>> > > +#include <linux/kernel.h>
>> > > +#include <linux/mod_devicetable.h>
>> > > +#include <linux/module.h>
>> > > +#include <linux/platform_device.h>
>> > > +#include <linux/pwm.h>
>> > > +#include <linux/regmap.h>
>> > > +
>> > > +/*
>> > > + * PWM timer block registers.
>> > > + */
>> > > +#define PWM_CTRL		0x00
>> > > +#define   PWM_ENABLE		BIT(7)
>> > > +#define   PWM_MODE_250HZ	0
>> > > +#define   PWM_MODE_500HZ	1
>> > > +#define   PWM_MODE_1KHZ		2
>> > > +#define   PWM_MODE_2KHZ		3
>> > > +#define   PWM_MODE_MASK		GENMASK(1, 0)
>> > > +#define PWM_CYCLE		0x01
>> > > +#define   PWM_CYCLE_MAX		0x7f
>> >
>> > Please use a less generic prefix for your defines. Also I like having
>> > the defines for field names include register name. Something like:
>> >
>> > 	#define PWM_SL28CPLD_CTRL		0x00
>> > 	#define PWM_SL28CPLD_CTRL_ENABLE		BIT(7)
>> > 	#define PWM_SL28CPLD_CTRL_MODE_MASK		GENMASK(1, 0)
>> 
>> Ok.
>> 
>> > 	#define
>> > PWM_SL28CPLD_CTRL_MODE_250HZ		FIELD_PREP(PWM_SL28CPLD_CTRL_MODE_MASK,
>> > 0)
>> 
>> Shouldn't we just "#define ..MODE_250HZ 1" use FIELD_PREP inside the 
>> code,
>> so you can actually use the normalized enumeration values, too?
> 
> yeah, looks sane.
> 
>> Actually, I'll rename the PWM_MODE to PWM_PRESCALER, because that is
>> more accurate.
> 
> Whatever suits you and is consistent is fine for me.
> 
>> > > +struct sl28cpld_pwm {
>> > > +	struct pwm_chip pwm_chip;
>> > > +	struct regmap *regmap;
>> > > +	u32 offset;
>> > > +};
>> > > +
>> > > +struct sl28cpld_pwm_periods {
>> > > +	u8 ctrl;
>> > > +	unsigned long duty_cycle;
>> > > +};
>> > > +
>> > > +struct sl28cpld_pwm_config {
>> > > +	unsigned long period_ns;
>> > > +	u8 max_duty_cycle;
>> > > +};
>> > > +
>> > > +static struct sl28cpld_pwm_config sl28cpld_pwm_config[] = {
>> >
>> > const ? (Or drop as the values can be easily computed, see below.)
>> >
>> > > +	[PWM_MODE_250HZ] = { .period_ns = 4000000, .max_duty_cycle = 0x80 },
>> > > +	[PWM_MODE_500HZ] = { .period_ns = 2000000, .max_duty_cycle = 0x40 },
>> > > +	[PWM_MODE_1KHZ]  = { .period_ns = 1000000, .max_duty_cycle = 0x20 },
>> > > +	[PWM_MODE_2KHZ]  = { .period_ns =  500000, .max_duty_cycle = 0x10 },
>> > > +};
>> > > +
>> > > +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
>> > > +				   struct pwm_device *pwm,
>> > > +				   struct pwm_state *state)
>> > > +{
>> > > +	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
>> > > +	static struct sl28cpld_pwm_config *config;
>> > > +	unsigned int reg;
>> > > +	unsigned int mode;
>> > > +
>> > > +	regmap_read(priv->regmap, priv->offset + PWM_CTRL, &reg);
>> > > +
>> > > +	state->enabled = reg & PWM_ENABLE;
>> >
>> > Would it be more consisted to use FIELD_GET here, too?
>> 
>> I had used FIELD_GET only for bit-fields with more than one bit,
>> i.e. no flags. But that is just a matter of taste, I guess. I'd
>> prefer to keep the simple "reg & PWM_ENABLE". If you insist on
>> the FIELD_GET() I'll change it ;)
> 
> I think using FIELD_GET is more consistent, but I won't insist.
> 
>> > > +	mode = FIELD_GET(PWM_MODE_MASK, reg);
>> > > +	config = &sl28cpld_pwm_config[mode];
>> > > +	state->period = config->period_ns;
>> >
>> > I wonder if this could be done more effectively without the above table.
>> > Something like:
>> >
>> > 	state->period = 4000000 >> mode.
>> 
>> The reason I introduced a lookup table here was that I need a
>> list of the supported modes; I wasn't aware of the rounding.
> 
> List of supported modes = [0, 1, 2, 3], isn't it?

Back then it was the list of supported periods. But because we do
the rounding now, we won't need it anymore.

>> See also below.
>> 
>> > (with a #define for 4000000 of course).
>> >
>> > > +	regmap_read(priv->regmap, priv->offset + PWM_CYCLE, &reg);
>> > > +	pwm_set_relative_duty_cycle(state, reg, config->max_duty_cycle);
>> >
>> > Oh, what a creative idea to use pwm_set_relative_duty_cycle here.
>> 
>> What is that helper for then? The former versions did the same
>> calculations (i.e. DIV_ROUND_CLOSEST_ULL()) just open coded. But
>> I guess then it was also rounding the wrong way.
> 
> Yes. In my book pwm_set_relative_duty_cycle is for consumers. And if
> DIV_ROUND_CLOSEST_ULL is the right thing for them depends on their use
> case.
> 
>> > Unfortunately it's using the wrong rounding strategy. Please enable
>> > PWM_DEBUG which should diagnose these problems (given enough testing).
>> 
>> Is there any written documentation on how to round, i.e. up or down?
> 
> There are the checks implemented for PWM_DEBUG. I started to work on 
> the
> documentation
> (https://patchwork.ozlabs.org/project/linux-pwm/patch/20191209213233.29574-2-u.kleine-koenig@pengutronix.de/)
> but didn't get feedback yet. (And the rounding rules are not included
> there.)
> 
>> I had a look Documentation/driver-api/pwm.rst again. But couldn't find
>> anything. A grep DIV_ROUND_CLOSEST_ULL() turns out that quite a few
>> drivers use it, so I did the same ;)
> 
> Yes, the rounding requirement is new and many driver's are not
> conforming (yet).

ok, I'll then compute everything then and drop the table.

>> > (Hmm, on second thought I'm not sure that rounding is relevant with the
>> > numbers of this hardware. Still it's wrong in general and I don't want
>> > to have others copy this.)
>> >
>> > > +}
>> > > +
>> > > +static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct
>> > > pwm_device *pwm,
>> > > +			      const struct pwm_state *state)
>> > > +{
>> > > +	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
>> > > +	struct sl28cpld_pwm_config *config;
>> > > +	unsigned int cycle;
>> > > +	int ret;
>> > > +	int mode;
>> > > +	u8 ctrl;
>> > > +
>> > > +	/* Get the configuration by comparing the period */
>> > > +	for (mode = 0; mode < ARRAY_SIZE(sl28cpld_pwm_config); mode++) {
>> > > +		config = &sl28cpld_pwm_config[mode];
>> > > +		if (state->period == config->period_ns)
>> > > +			break;
>> > > +	}
>> > > +
>> > > +	if (mode == ARRAY_SIZE(sl28cpld_pwm_config))
>> > > +		return -EINVAL;
>> >
>> > You're supposed to pick the biggest period that isn't bigger than the
>> > requested period. So something like:
>> >
>> > 	switch(period) {
>> > 	case 4000000 ... UINT_MAX:
>> > 		mode = 0;
>> > 		break;
>> > 	case 2000000 ... 3999999:
>> > 		mode = 1;
>> > 		break;
>> > 	...
>> > 	}
>> >
>> > (or:
>> >
>> > 	if period >= 4000000:
>> > 		mode = 0
>> > 	else:
>> > 		// I think ... please double-check
>> > 		mode = ilog2(4000000 / (period + 1)) + 1
>> >
>> > 	if mode > 3:
>> > 		return -ERANGE;
>> > )
>> 
>> I see. In this case I can of course drop the table. But the rounding
>> will be then very coarse for this driver. And there is no way to get
>> the value which is actually set, right? You can just read the cached
>> value. So that value might be far off the actual one set in the
>> hardware.
> 
> Yes, we once changed pwm_get_rate to return the actually implemented
> setting, but this broke some stuff; see commit
> 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3.
> 
> I already thought about proposing pwm_get_rate_hw(), but for now there
> is (AFAICT) no user who would need it. And it's hard to know which
> variant is actually preferred by consumers. My expectation is that most
> don't even care.
> 
> I also have a pwm_round_rate() function in mind that will give you the
> actual rate without applying it. This can then be used by consumers who
> care. But also there is no user who would need it today.

Ok. I take it that all such improvements are still in the making ;)

>> During testing I've also found the following problem: Assume we set
>> a period of 5000000ns; this will be rounded to 4000000ns and written
>> to the hardware. But the usable duty cycle is still 0..5000000ns. The
>> driver will translate this input in the following manner:
>>  - 0..4000000 -> 0%..100%
>>  - >4000000 -> 100%
>> Is this behavior intended?
> 
> It's expected.
ok

>> Even for PWM hardware which supports finer
>> grained frequencies there will be some upper and lower limits. Is
>> the user of the PWM supposed to know these?
> 
> There is nothing we can do on hardware imposed limits. In practise it
> doesn't seem to matter. Also note that most consumers get a proposed
> period length.
> 
>> > 	real_period = 4000000 >> mode;
>> >
>> > > +	ctrl = FIELD_PREP(PWM_MODE_MASK, mode);
>> > > +	if (state->enabled)
>> > > +		ctrl |= PWM_ENABLE;
>> > > +
>> > > +	cycle = pwm_get_relative_duty_cycle(state, config->max_duty_cycle);
>> >
>> > Again the rounding is wrong. You need need to round down the requested
>> > duty_cycle to the next possible value. So something like:
>> >
>> > 	duty_cycle = min(real_period, state->duty_cycle);
>> >
>> > 	cycle = duty_cycle * (0x80 >> mode) / (4000000 >> mode);
>> >
>> > which can be further simplified to
>> >
>> > 	cycle = duty_cycle / 31250
>> 
>> Mh, this made me think where that "magic" number is coming from. Turns
>> out this is the NSECS_PE_SEC / base clock of the PWM.
> 
> It's a simplification of the line above, so it is 4000000 / 0x80. (But
> it's not by chance this matches NSECS_PER_SEC / base clock of course.)
> 
>> I guess I'll rework the get_state() and apply() to just use this
>> base frequency, dropping the table etc.
>> 
>> Btw what about the polarity. Do I have to support it or can I
>> return an error code if its != PWM_POLARITY_NORMAL? If so, which
>> error code? EINVAL?
> 
> ..ooOO(Did I really miss that during review? Bummer)
> 
> If your hardware only support normal polarity, only implement this and
> return -EINVAL for inverted polarity requests.

ok

>> I know I could just invert the duty cycle in
>> software, but shouldn't this be done in the core for any controller
>> which doesn't support changing the polarity in hardware?
> 
> Please don't. This should indeed be done at the framework level. (But
> I'm not convinced doing this unconditionally is a good idea.)
> 
>> > > +	/*
>> > > +	 * The hardware doesn't allow to set max_duty_cycle if the
>> > > +	 * 250Hz mode is enabled, thus we have to trap that here.
>> > > +	 * But because a 100% duty cycle is equal on all modes, i.e.
>> >
>> > It depends on how picky you are if you can agree here.
>> 
>> why is that? The only drawback is that the mode is changed without
>> the user seeing it.
> 
> Ideally periods are completed before they change. So if a user requests
> .period = .duty_cycle = 100ms with having the PWM disabled before and
> afterwards, the expectation is that it is active for (an integer
> multiple of) 100 ms. But honestly there are not many hardware
> implementation + driver combos that get this right.
> 
>> But the PWM subsystem returns the cached state,
>> right? get_state() is called only on device request (and during
>> debug it seems). Actually, enabling PWM_DEBUG might choke on this
>> workaround (".apply didn't pick the best available period"). Is
>> this ok?
> 
> hmm, I didn't consider this when writing the checks for PWM_DEBUG.
> According to the currently checked rules the expected configuration is
> to pick the 250Hz mode and use cycle = 0x7f.

Not to use 0x80, which is the max_duty_cycle? Like its 0x40 for the 
500Hz
mode.

> Hmm, I have to think about
> this. Maybe we should weaken the check to the cases with
> 0 < duty_cycle < period. Thierry, what do you think?
> 
> Special casing 0% and 100% is annoying, but insisting 250Hz + 0x7f 
> seems
> to be far from reality. (Is it?)

If you mean by insisting to clip at 0x7f, yeah thats bad IMHO, because
the user wants an all-high line, but in the end it would be a toggling
line. It wouldn't be that bad for anything in between 0% and 100% but
IMHO its bad for exactly 0% and 100%.

You could also ask the driver about known quirks, like special 0% and
100% handling and exclude it from the tests accordingly.


>> > > +	ret = regmap_write(priv->regmap, priv->offset + PWM_CTRL, ctrl);
>> > > +	if (ret)
>> > > +		return ret;
>> > > +
>> > > +	return regmap_write(priv->regmap, priv->offset + PWM_CYCLE,
>> > > (u8)cycle);
>> >
>> > I assume this can result in broken output? Consider the hardware runs
>> > with mode = 1 & cycle = 0x23 and you want to go to mode = 0 & cycle =
>> > 0x42: Can this result in a period that has mode = 0 & cycle = 0x23?
>> 
>> Isn't that always the case if a write may fail and there are more than
>> one register to configure?
> 
> Depending on hardware capabilities you might not be able to prevent
> this yes. Unfortunately this is quite common.
> 
> But there are hardware implementations that are not prone to such
> failures. (E.g. the registers written can be only shadow values that 
> are
> latched into hardware only when the last value is written.)

Maybe this could be improved in the future.

> 
>> For example, have a look at pwm-iqs620a.c.
>> Btw. the get_state might also fail, but there is no return value to
>> return the error.
> 
> Yes, changing this is on my todo list.
> 
>> > If this cannot be avoided, please document this in the Limitations
>> > paragraph.
>> 
>> Sure. There might be (or most likely are) gliches when you change the
>> mode.
> 
> If you change only cycle but not mode, does the hardware complete the
> currently running period?

No it does not.

> What about disable()?

Mhh well, it would do one 100% cycle.. mhh ;) Lets see if there we can
fix that (in hardware), not much we can do in the driver here. We are
_very_ constraint in size, therefore all that little edge cases fall off
the table.

I'll post a new version soon.

-michael
