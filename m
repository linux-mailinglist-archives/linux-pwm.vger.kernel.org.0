Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE11EF688
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFELjQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 07:39:16 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:35571 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgFELjQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 07:39:16 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8E63422FEC;
        Fri,  5 Jun 2020 13:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591357150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82fCU3j2UFl91wX9eMDPOe26ZaWLsjPW25Pdt7Qzeqw=;
        b=YqNXpf3MZvxSAINYteCPGwmZC+Bn5rwA7bDeQdwcEcjLALel/t7uq4t0EjmqtV/Rtj+hJK
        zCso13VslSjtALjMRk8yWkwy9CmtTvSvPp5v9u1CBRENViZ+psv/LCtwLQJiH22Y+O63Sk
        Tpq2i+mKVRY7oXST+pqHs/gGX54dWkc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jun 2020 13:39:09 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 05/11] pwm: add support for sl28cpld PWM controller
In-Reply-To: <20200605084915.GE3714@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-6-michael@walle.cc> <20200605084915.GE3714@dell>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <9b539d32c70da72bea0abac0f7cd8e1c@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-05 10:49, schrieb Lee Jones:
> On Thu, 04 Jun 2020, Michael Walle wrote:
> 
>> Add support for the PWM controller of the sl28cpld board management
>> controller. This is part of a multi-function device driver.
>> 
>> The controller has one PWM channel and can just generate four distinct
>> frequencies.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/pwm/Kconfig        |  10 ++
>>  drivers/pwm/Makefile       |   1 +
>>  drivers/pwm/pwm-sl28cpld.c | 201 
>> +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 212 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-sl28cpld.c
>> 
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index cb8d739067d2..a39371c11ff6 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -437,6 +437,16 @@ config PWM_SIFIVE
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-sifive.
>> 
>> +config PWM_SL28CPLD
>> +	tristate "Kontron sl28 PWM support"
>> +	depends on MFD_SL28CPLD
>> +	help
>> +	  Generic PWM framework driver for board management controller
>> +	  found on the Kontron sl28 CPLD.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-sl28cpld.
>> +
>>  config PWM_SPEAR
>>  	tristate "STMicroelectronics SPEAr PWM support"
>>  	depends on PLAT_SPEAR || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index a59c710e98c7..c479623724e8 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
>>  obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
>>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>>  obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>> +obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
>>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>>  obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
>>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
>> new file mode 100644
>> index 000000000000..d82303f509f5
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-sl28cpld.c
>> @@ -0,0 +1,201 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * sl28cpld PWM driver.
>> + *
>> + * Copyright 2019 Kontron Europe GmbH
> 
> This is out of date.

ok

> 
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
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
>> +
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
> 
> Also, instead of hand rolling your own structure here, I think it
> would be prudent to re-use something that already exists.  Seeing as
> this will be used to describe possible state, perhaps 'struct
> pwm_state' would be suitable - leaving polarity and enabled
> unpopulated of course.
> 
> Ah wait (sorry, thinking allowed and on-the-fly here), what is
> max_duty_cycle here?  I assume this does not have the same
> meaning/value-type as the one in 'struct pwm_state'.  What does
> max_duty_cycle represent in your use-case?

Its the max value of the PWM_CYCLE register, with one exception
of the 250Hz mode. There it would be 0x7f; but it is used as a scaling
factor too. Thus I added the "fixup" below.

>> +static struct sl28cpld_pwm_config sl28cpld_pwm_config[] = {
>> +	[PWM_MODE_250HZ] = { .period_ns = 4000000, .max_duty_cycle = 0x80 },
>> +	[PWM_MODE_500HZ] = { .period_ns = 2000000, .max_duty_cycle = 0x40 },
>> +	[PWM_MODE_1KHZ] = { .period_ns = 1000000, .max_duty_cycle = 0x20 },
>> +	[PWM_MODE_2KHZ] = { .period_ns =  500000, .max_duty_cycle = 0x10 },
>> +};
> 
> Tiny nit: If you lined these up from the '{'s it would be easier to
> see/compare the period_ns values at first glance, rather than having
> to count the ' 's and '0's.

yep.

> 
>> +static inline struct sl28cpld_pwm *to_sl28cpld_pwm(struct pwm_chip 
>> *chip)
>> +{
>> +	return container_of(chip, struct sl28cpld_pwm, pwm_chip);
>> +}
> 
> Why not save yourself the trouble and just:
> 
>   struct sl28cpld_pwm *pwm = dev_get_drvdata(chip->dev);

looks better, yes.

> 
>> +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
>> +				   struct pwm_device *pwm,
>> +				   struct pwm_state *state)
>> +{
>> +	struct sl28cpld_pwm *spc = to_sl28cpld_pwm(chip);
>> +	static struct sl28cpld_pwm_config *config;
>> +	unsigned int reg;
>> +	unsigned long cycle;
> 
> Why is this 'long' here and 'long long' in *_apply()?

cycle has a max value of "u8_max * <defined ulong from config above>",
where below it might be "ulong * ulong". But for consinstency, I could
make it unsigned long long here, too.

>> +	unsigned int mode;
>> +
>> +	regmap_read(spc->regmap, spc->offset + PWM_CTRL, &reg);
>> +
>> +	state->enabled = reg & PWM_ENABLE;
>> +
>> +	mode = FIELD_GET(PWM_MODE_MASK, reg);
>> +	config = &sl28cpld_pwm_config[mode];
>> +	state->period = config->period_ns;
>> +
>> +	regmap_read(spc->regmap, spc->offset + PWM_CYCLE, &reg);
>> +	cycle = reg * config->period_ns;
>> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(cycle,
>> +						  config->max_duty_cycle);
>> +}
>> +
>> +static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct 
>> pwm_device *pwm,
>> +			      const struct pwm_state *state)
>> +{
>> +	struct sl28cpld_pwm *spc = to_sl28cpld_pwm(chip);
>> +	struct sl28cpld_pwm_config *config;
>> +	unsigned long long cycle;
>> +	int ret;
>> +	int mode;
>> +	u8 ctrl;
>> +
>> +	/* update config, first search best matching period */
> 
> Please use correct grammar (less full stops) in comments.

ok

> 
>> +	for (mode = 0; mode < ARRAY_SIZE(sl28cpld_pwm_config); mode++) {
>> +		config = &sl28cpld_pwm_config[mode];
>> +		if (state->period == config->period_ns)
>> +			break;
>> +	}
>> +
>> +	if (mode == ARRAY_SIZE(sl28cpld_pwm_config))
>> +		return -EINVAL;
>> +
>> +	ctrl = FIELD_PREP(PWM_MODE_MASK, mode);
>> +	if (state->enabled)
>> +		ctrl |= PWM_ENABLE;
>> +
>> +	cycle = state->duty_cycle * config->max_duty_cycle;
>> +	do_div(cycle, state->period);
> 
> Forgive my ignorance (I'm new here!), but what are these 2 lines
> doing?  Here we are multiplying the current duty_cycle with the
> maximum value, then dividing by the period.
> 
> So in the case of PWM_MODE_1KHZ with a 50% duty cycle, you'd have:
> 
>    (500000 * 0x20[16]) / 1000000 = [0x10]16
> 
> Thus, the above gives as a proportional representation of the maximum
> valid value for placement into the cycle control register(s), right?

correct.

> Either way (whether I'm correct or not), I think it would be nice to
> mention this in a comment.  Maybe even clarify with a simple example.

yes, I'll also look into the helper Andy mentioned. Thus it might be
even self explanatory.

>> +	/*
>> +	 * The hardware doesn't allow to set max_duty_cycle if the
>> +	 * 250Hz mode is enabled. But since this is "all-high" output
>> +	 * just use the 500Hz mode with the duty cycle to max value.
>> +	 */
>> +	if (cycle == config->max_duty_cycle) {
>> +		ctrl &= ~PWM_MODE_MASK;
>> +		ctrl |= FIELD_PREP(PWM_MODE_MASK, PWM_MODE_500HZ);
>> +		cycle = PWM_CYCLE_MAX;
>> +	}
> 
> This is being executed even when 250Hz mode is not enabled.
> 
> Is that by design?

Yes because the mode doesn't matter if you have a duty cycle of 100%.
You'd be free to choose any mode except 250Hz.

> If so, it doesn't match the comment.

Mh? Ok its a bit confusing and it might imply that this is only done
for the 250Hz case. But it doensn't mention it is _only_ used for this
mode.

/*
  * The hardware doesn't allow to set max_duty_cycle if the
  * 250Hz mode is enabled, thus we have to trap that here.
  * But because a 100% duty cycle is equal on all modes, i.e.
  * it is just a "all-high" output, we trap any case with a
  * 100% duty cycle and use the 500Hz mode.
  */

>> +	ret = regmap_write(spc->regmap, spc->offset + PWM_CTRL, ctrl);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return regmap_write(spc->regmap, spc->offset + PWM_CYCLE, 
>> (u8)cycle);
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
>> +	struct sl28cpld_pwm *pwm;
> 
> This is super confusing.  Here you call it 'pwm', but when you bring
> the data to the fore for consumption, you call it something different
> ('spc') for some reason.

yeah it is :(

> Is there logic behind this?

And no it is not. sorry for that.

>> +	struct pwm_chip *chip;
>> +	int ret;
>> +
>> +	if (!pdev->dev.parent)
>> +		return -ENODEV;
>> +
>> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>> +	if (!pwm)
>> +		return -ENOMEM;
>> +
>> +	pwm->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!pwm->regmap)
>> +		return -ENODEV;
>> +
>> +	ret = device_property_read_u32(&pdev->dev, "reg", &pwm->offset);
> 
> Really?  Can you use the 'reg' property in this way?

Well formerly it was IORESOURCE_REG, which gives you a register offset,
see commit 72dcb1197228b ("resources: Add register address resource 
type").
There is also the of_get_address(), but I doubt that would be correct 
here,
because it does bus mapping etc.
So I looked at how other MFD drivers does it, most of the MFD have the
advantage of having fixed register offsets and then just use hardcoded
offsets. But there are some drivers which pull their offset out of the
reg property from the device tree itself.

$ grep -r "read_u32.*\"reg\"" drivers/
$ grep -r "read_u32.*\"reg\".*base" drivers/

Does anyone have a better idea?

> Side question:
>   Do any of your child address spaces actually overlap/intersect?

nope. they are distinct.

> 
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	/* initialize struct pwm_chip */
> 
> Proper grammar please.
ok

> 
>> +	chip = &pwm->pwm_chip;
>> +	chip->dev = &pdev->dev;
>> +	chip->ops = &sl28cpld_pwm_ops;
>> +	chip->base = -1;
>> +	chip->npwm = 1;
>> +
>> +	ret = pwmchip_add(&pwm->pwm_chip);
>> +	if (ret < 0)
> 
> Is '> 0' even valid?
> 
> Suggest "!ret" here, as you have done above.

Yes, same comment as Andy had on the other patches.

>> +		return ret;
>> +
>> +	platform_set_drvdata(pdev, pwm);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sl28cpld_pwm_remove(struct platform_device *pdev)
>> +{
>> +	struct sl28cpld_pwm *pwm = platform_get_drvdata(pdev);
>> +
>> +	return pwmchip_remove(&pwm->pwm_chip);
>> +}
>> +
>> +static const struct of_device_id sl28cpld_pwm_of_match[] = {
>> +	{ .compatible = "kontron,sl28cpld-pwm" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
>> +
>> +static const struct platform_device_id sl28cpld_pwm_id_table[] = {
>> +	{"sl28cpld-pwm"},
> 
> Spaces either side of the "'s please.

ok

> 
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(platform, sl28cpld_pwm_id_table);
> 
> What are you using this for?

They are from the time when these drivers were mfd_cells. But I wanted
to keep them here, if in the future there is another mfd driver which
uses these drivers.

>> +static struct platform_driver sl28cpld_pwm_driver = {
>> +	.probe = sl28cpld_pwm_probe,
>> +	.remove	= sl28cpld_pwm_remove,
>> +	.id_table = sl28cpld_pwm_id_table,
>> +	.driver = {
>> +		.name = KBUILD_MODNAME,
> 
> Please just use the quoted name in full.

Mhh, is there any rule for this? Sometimes KBUILD_MODNAME is used
and sometimes an hardcoded name. I thought KBUILD_MODNAME is nice
because it is filled automatically. And the platform probe use
the .id_table anyway.

>> +		.of_match_table = sl28cpld_pwm_of_match,
>> +	},
>> +};
>> +module_platform_driver(sl28cpld_pwm_driver);
>> +
>> +MODULE_DESCRIPTION("sl28cpld PWM Driver");
> 
> "SL28CPLD" ?

Actually no, I want to call that "sl28cpld". The first part
is "sl28" (not SL28) and sl28CPLD looks pretty weird. I tried
to be consistent on Kconfig/dt-bindings/drivers about this
naming.

>> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
>> +MODULE_LICENSE("GPL");

-- 
-michael
