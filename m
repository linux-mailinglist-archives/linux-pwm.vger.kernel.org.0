Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7F721C581
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2020 19:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgGKR2O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 11 Jul 2020 13:28:14 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42299 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgGKR2N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Jul 2020 13:28:13 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CF69A226F6;
        Sat, 11 Jul 2020 19:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594488487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37z1OtFPWIJPH7irUlc2rZc8jjASFLh7CuJiY+XA99s=;
        b=ESE8FLhSCtlx/GvzFNxFzl0AbnmfrwEKt6CkeBBy0ddNNGM8Tn3WTEnA328CC0lu4mh1mV
        a//cK3sr6xYVFrEB1gCTVA3Gzl5IxkkaYGhWz3SoiHHkmu1jcWRY1WMgO23ic8hPwP7bDh
        /QvNAd9FFN5pasrXko2aaSlILEZHDIY=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 11 Jul 2020 19:28:05 +0200
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 07/13] pwm: add support for sl28cpld PWM controller
In-Reply-To: <20200709085006.b54ype3p4yu64upl@pengutronix.de>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-8-michael@walle.cc>
 <20200709085006.b54ype3p4yu64upl@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <72858253a9094074e9c8cd7a4e1db09f@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

first of all, thank you for that thorough review.

Am 2020-07-09 10:50, schrieb Uwe Kleine-König:
> On Mon, Jul 06, 2020 at 07:53:47PM +0200, Michael Walle wrote:
>> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
>> new file mode 100644
>> index 000000000000..8ee286b605bf
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-sl28cpld.c
>> @@ -0,0 +1,187 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * sl28cpld PWM driver
>> + *
>> + * Copyright 2020 Kontron Europe GmbH
>> + */
> 
> Is there publically available documenation available? If so please add 
> a
> link here.

Unfortunately not. But it should be easy enough and I'll describe it
briefly in the header.

>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +
>> +/*
>> + * PWM timer block registers.
>> + */
>> +#define PWM_CTRL		0x00
>> +#define   PWM_ENABLE		BIT(7)
>> +#define   PWM_MODE_250HZ	0
>> +#define   PWM_MODE_500HZ	1
>> +#define   PWM_MODE_1KHZ		2
>> +#define   PWM_MODE_2KHZ		3
>> +#define   PWM_MODE_MASK		GENMASK(1, 0)
>> +#define PWM_CYCLE		0x01
>> +#define   PWM_CYCLE_MAX		0x7f
> 
> Please use a less generic prefix for your defines. Also I like having
> the defines for field names include register name. Something like:
> 
> 	#define PWM_SL28CPLD_CTRL		0x00
> 	#define PWM_SL28CPLD_CTRL_ENABLE		BIT(7)
> 	#define PWM_SL28CPLD_CTRL_MODE_MASK		GENMASK(1, 0)

Ok.

> 	#define
> PWM_SL28CPLD_CTRL_MODE_250HZ		FIELD_PREP(PWM_SL28CPLD_CTRL_MODE_MASK,
> 0)

Shouldn't we just "#define ..MODE_250HZ 1" use FIELD_PREP inside the 
code,
so you can actually use the normalized enumeration values, too?

Actually, I'll rename the PWM_MODE to PWM_PRESCALER, because that is
more accurate.

>> +struct sl28cpld_pwm {
>> +	struct pwm_chip pwm_chip;
>> +	struct regmap *regmap;
>> +	u32 offset;
>> +};
>> +
>> +struct sl28cpld_pwm_periods {
>> +	u8 ctrl;
>> +	unsigned long duty_cycle;
>> +};
>> +
>> +struct sl28cpld_pwm_config {
>> +	unsigned long period_ns;
>> +	u8 max_duty_cycle;
>> +};
>> +
>> +static struct sl28cpld_pwm_config sl28cpld_pwm_config[] = {
> 
> const ? (Or drop as the values can be easily computed, see below.)
> 
>> +	[PWM_MODE_250HZ] = { .period_ns = 4000000, .max_duty_cycle = 0x80 },
>> +	[PWM_MODE_500HZ] = { .period_ns = 2000000, .max_duty_cycle = 0x40 },
>> +	[PWM_MODE_1KHZ]  = { .period_ns = 1000000, .max_duty_cycle = 0x20 },
>> +	[PWM_MODE_2KHZ]  = { .period_ns =  500000, .max_duty_cycle = 0x10 },
>> +};
>> +
>> +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
>> +				   struct pwm_device *pwm,
>> +				   struct pwm_state *state)
>> +{
>> +	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
>> +	static struct sl28cpld_pwm_config *config;
>> +	unsigned int reg;
>> +	unsigned int mode;
>> +
>> +	regmap_read(priv->regmap, priv->offset + PWM_CTRL, &reg);
>> +
>> +	state->enabled = reg & PWM_ENABLE;
> 
> Would it be more consisted to use FIELD_GET here, too?

I had used FIELD_GET only for bit-fields with more than one bit,
i.e. no flags. But that is just a matter of taste, I guess. I'd
prefer to keep the simple "reg & PWM_ENABLE". If you insist on
the FIELD_GET() I'll change it ;)

>> +
>> +	mode = FIELD_GET(PWM_MODE_MASK, reg);
>> +	config = &sl28cpld_pwm_config[mode];
>> +	state->period = config->period_ns;
> 
> I wonder if this could be done more effectively without the above 
> table.
> Something like:
> 
> 	state->period = 4000000 >> mode.

The reason I introduced a lookup table here was that I need a
list of the supported modes; I wasn't aware of the rounding.
See also below.

> (with a #define for 4000000 of course).
> 
>> +	regmap_read(priv->regmap, priv->offset + PWM_CYCLE, &reg);
>> +	pwm_set_relative_duty_cycle(state, reg, config->max_duty_cycle);
> 
> Oh, what a creative idea to use pwm_set_relative_duty_cycle here.

What is that helper for then? The former versions did the same
calculations (i.e. DIV_ROUND_CLOSEST_ULL()) just open coded. But
I guess then it was also rounding the wrong way.

> Unfortunately it's using the wrong rounding strategy. Please enable
> PWM_DEBUG which should diagnose these problems (given enough testing).

Is there any written documentation on how to round, i.e. up or down?
I had a look Documentation/driver-api/pwm.rst again. But couldn't find
anything. A grep DIV_ROUND_CLOSEST_ULL() turns out that quite a few
drivers use it, so I did the same ;)

> (Hmm, on second thought I'm not sure that rounding is relevant with the
> numbers of this hardware. Still it's wrong in general and I don't want
> to have others copy this.)
> 
>> +}
>> +
>> +static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct 
>> pwm_device *pwm,
>> +			      const struct pwm_state *state)
>> +{
>> +	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
>> +	struct sl28cpld_pwm_config *config;
>> +	unsigned int cycle;
>> +	int ret;
>> +	int mode;
>> +	u8 ctrl;
>> +
>> +	/* Get the configuration by comparing the period */
>> +	for (mode = 0; mode < ARRAY_SIZE(sl28cpld_pwm_config); mode++) {
>> +		config = &sl28cpld_pwm_config[mode];
>> +		if (state->period == config->period_ns)
>> +			break;
>> +	}
>> +
>> +	if (mode == ARRAY_SIZE(sl28cpld_pwm_config))
>> +		return -EINVAL;
> 
> You're supposed to pick the biggest period that isn't bigger than the
> requested period. So something like:
> 
> 	switch(period) {
> 	case 4000000 ... UINT_MAX:
> 		mode = 0;
> 		break;
> 	case 2000000 ... 3999999:
> 		mode = 1;
> 		break;
> 	...
> 	}
> 
> (or:
> 
> 	if period >= 4000000:
> 		mode = 0
> 	else:
> 		// I think ... please double-check
> 		mode = ilog2(4000000 / (period + 1)) + 1
> 
> 	if mode > 3:
> 		return -ERANGE;
> )

I see. In this case I can of course drop the table. But the rounding
will be then very coarse for this driver. And there is no way to get
the value which is actually set, right? You can just read the cached
value. So that value might be far off the actual one set in the
hardware.

During testing I've also found the following problem: Assume we set
a period of 5000000ns; this will be rounded to 4000000ns and written
to the hardware. But the usable duty cycle is still 0..5000000ns. The
driver will translate this input in the following manner:
  - 0..4000000 -> 0%..100%
  - >4000000 -> 100%
Is this behavior intended? Even for PWM hardware which supports finer
grained frequencies there will be some upper and lower limits. Is
the user of the PWM supposed to know these?

> 
> 	real_period = 4000000 >> mode;
> 
>> +	ctrl = FIELD_PREP(PWM_MODE_MASK, mode);
>> +	if (state->enabled)
>> +		ctrl |= PWM_ENABLE;
>> +
>> +	cycle = pwm_get_relative_duty_cycle(state, config->max_duty_cycle);
> 
> Again the rounding is wrong. You need need to round down the requested
> duty_cycle to the next possible value. So something like:
> 
> 	duty_cycle = min(real_period, state->duty_cycle);
> 
> 	cycle = duty_cycle * (0x80 >> mode) / (4000000 >> mode);
> 
> which can be further simplified to
> 
> 	cycle = duty_cycle / 31250

Mh, this made me think where that "magic" number is coming from. Turns
out this is the NSECS_PE_SEC / base clock of the PWM.

I guess I'll rework the get_state() and apply() to just use this
base frequency, dropping the table etc.

Btw what about the polarity. Do I have to support it or can I
return an error code if its != PWM_POLARITY_NORMAL? If so, which
error code? EINVAL? I know I could just invert the duty cycle in
software, but shouldn't this be done in the core for any controller
which doesn't support changing the polarity in hardware?

> 
> .
> 
>> +	/*
>> +	 * The hardware doesn't allow to set max_duty_cycle if the
>> +	 * 250Hz mode is enabled, thus we have to trap that here.
>> +	 * But because a 100% duty cycle is equal on all modes, i.e.
> 
> It depends on how picky you are if you can agree here.

why is that? The only drawback is that the mode is changed without
the user seeing it. But the PWM subsystem returns the cached state,
right? get_state() is called only on device request (and during
debug it seems). Actually, enabling PWM_DEBUG might choke on this
workaround (".apply didn't pick the best available period"). Is
this ok?

> Please document
> this in a Limitations paragraph at the top of the driver similar to
> drivers/pwm/pwm-rcar.c and others.

sure.

> 
>> +	 * it is just a "all-high" output, we trap any case with a
>> +	 * 100% duty cycle and use the 500Hz mode.
> 
> Please only trap on 250Hz mode. (Can be done using: if (cycle == 0x80) 
> I
> think)

you are correct.

> 
>> +	 */
>> +	if (cycle == config->max_duty_cycle) {
>> +		ctrl &= ~PWM_MODE_MASK;
>> +		ctrl |= FIELD_PREP(PWM_MODE_MASK, PWM_MODE_500HZ);
>> +		cycle = PWM_CYCLE_MAX;
> 
> I would have expected 0x40 here instead of 0x7f?

Yes, but technically, any value above 0x40 will do it. But you
are correct, that is wrong and misleading.

>> +	}
>> +
>> +	ret = regmap_write(priv->regmap, priv->offset + PWM_CTRL, ctrl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return regmap_write(priv->regmap, priv->offset + PWM_CYCLE, 
>> (u8)cycle);
> 
> I assume this can result in broken output? Consider the hardware runs
> with mode = 1 & cycle = 0x23 and you want to go to mode = 0 & cycle =
> 0x42: Can this result in a period that has mode = 0 & cycle = 0x23?

Isn't that always the case if a write may fail and there are more than
one register to configure? For example, have a look at pwm-iqs620a.c.
Btw. the get_state might also fail, but there is no return value to
return the error.

> If this cannot be avoided, please document this in the Limitations
> paragraph.

Sure. There might be (or most likely are) gliches when you change the
mode.

> 
>> +}
>> +
>> +static const struct pwm_ops sl28cpld_pwm_ops = {
>> +	.apply = sl28cpld_pwm_apply,
>> +	.get_state = sl28cpld_pwm_get_state,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static int sl28cpld_pwm_probe(struct platform_device *pdev)
>> +{
>> +	struct sl28cpld_pwm *priv;
>> +	struct pwm_chip *chip;
>> +	int ret;
>> +
>> +	if (!pdev->dev.parent)
>> +		return -ENODEV;
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!priv->regmap)
>> +		return -ENODEV;
>> +
>> +	ret = device_property_read_u32(&pdev->dev, "reg", &priv->offset);
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	/* Initialize the pwm_chip structure */
>> +	chip = &priv->pwm_chip;
>> +	chip->dev = &pdev->dev;
>> +	chip->ops = &sl28cpld_pwm_ops;
>> +	chip->base = -1;
>> +	chip->npwm = 1;
>> +
>> +	ret = pwmchip_add(&priv->pwm_chip);
>> +	if (ret)
>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	return 0;
>> +}
> 
> Please add error messages with some details for the error paths
> (preferable using %pe to indicate the error code).

Ok.

> 
>> +static int sl28cpld_pwm_remove(struct platform_device *pdev)
>> +{
>> +	struct sl28cpld_pwm *priv = platform_get_drvdata(pdev);
>> +
>> +	return pwmchip_remove(&priv->pwm_chip);
>> +}
>> +
>> +static const struct of_device_id sl28cpld_pwm_of_match[] = {
>> +	{ .compatible = "kontron,sl28cpld-pwm" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
>> +
>> +static struct platform_driver sl28cpld_pwm_driver = {
>> +	.probe = sl28cpld_pwm_probe,
>> +	.remove	= sl28cpld_pwm_remove,
>> +	.driver = {
>> +		.name = "sl28cpld-pwm",
>> +		.of_match_table = sl28cpld_pwm_of_match,
>> +	},
>> +};
>> +module_platform_driver(sl28cpld_pwm_driver);
>> +
>> +MODULE_DESCRIPTION("sl28cpld PWM Driver");
>> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
>> +MODULE_LICENSE("GPL");

-michael
