Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EAB1EF361
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 10:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgFEItU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgFEItU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 04:49:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E48C08C5C3
        for <linux-pwm@vger.kernel.org>; Fri,  5 Jun 2020 01:49:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so7683292wml.1
        for <linux-pwm@vger.kernel.org>; Fri, 05 Jun 2020 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ShIPEKLtHJNI7EgByJ7TzTteP7weEEoEK5XnGUnAnDA=;
        b=JHKB7BPtiDQpdqRj4iwj2PaCKo2ZYMwCEXh3GY/NEwFYFSE47qjrQmxrSB7T0iodw6
         RmMzOO/L8Msz58TpWxpu/ANCKEiUHGO9/amUCaByExYyC/UBu+ANQPXnWnataTsRLNix
         noronmmlyJ/akaNcxh7RNjTQtVPrDG5zYwQHZKYCxuIvGiMYbl2wO2WwNKj7bO+BZRDy
         VTU1uipZn/zZ7AeGaRUFx/ZnDlR4XWs6tXLm7o3NZNl0L9nq7dqN2eMCQ21F2xri8uAg
         nNF/9kpYLeZpM3I9M3QDpLL6TwDnOLzYVcNamQUkqcoCdclagZ4fvhx+DNoGufhzKrib
         5y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ShIPEKLtHJNI7EgByJ7TzTteP7weEEoEK5XnGUnAnDA=;
        b=RlhK49FMi2xItopg0MAq98v05CYTxTmuCy1srWX2WowsByr8v0JNrRRxDHnqkKdIsx
         v+gnTybSg0kT9922pGfdBouImz9pXvuDrsIFw/5wuu1BHYX1zkunOQlF+MYKBspNS9zf
         HUEhriGTf1rTVkdyZwcL6UJMeAxz5NaFvtdHSSz9MTK/VUVfwa+mw27jNbkA1d6uHPmu
         OQ1p6CMrC0bwVra/hr5LHduAXWQTXipKiV9oorlxp/wCNZIva8I4CUMjUodMLAYsI5K7
         NDKkbDbz/e4WORBtaO/c4gAOtRZ4lZ1wmTsLMzNfDvlqjTvTpDYk7ChVsLY0qdZMJfAU
         /96A==
X-Gm-Message-State: AOAM533EkcIYn6aY1v5EutI2S/rjFRSMrT1TG4E3JNTu9qLjCNPP7PN1
        AqnUFQQRjg697JEbHw7zDAjNzQJNCnw=
X-Google-Smtp-Source: ABdhPJzFLO8h/vvGcmXwgNoyFftB5nfR424h9jxB25M8PSh39Yyc0S54n+rRnjr0KPF2rHImbfY5hg==
X-Received: by 2002:a7b:cf02:: with SMTP id l2mr1609865wmg.136.1591346958101;
        Fri, 05 Jun 2020 01:49:18 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id j5sm11113810wrq.39.2020.06.05.01.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 01:49:17 -0700 (PDT)
Date:   Fri, 5 Jun 2020 09:49:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 05/11] pwm: add support for sl28cpld PWM controller
Message-ID: <20200605084915.GE3714@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-6-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200604211039.12689-6-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 04 Jun 2020, Michael Walle wrote:

> Add support for the PWM controller of the sl28cpld board management
> controller. This is part of a multi-function device driver.
> 
> The controller has one PWM channel and can just generate four distinct
> frequencies.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-sl28cpld.c | 201 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 212 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sl28cpld.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index cb8d739067d2..a39371c11ff6 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -437,6 +437,16 @@ config PWM_SIFIVE
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sifive.
>  
> +config PWM_SL28CPLD
> +	tristate "Kontron sl28 PWM support"
> +	depends on MFD_SL28CPLD
> +	help
> +	  Generic PWM framework driver for board management controller
> +	  found on the Kontron sl28 CPLD.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sl28cpld.
> +
>  config PWM_SPEAR
>  	tristate "STMicroelectronics SPEAr PWM support"
>  	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index a59c710e98c7..c479623724e8 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
> +obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>  obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
> diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
> new file mode 100644
> index 000000000000..d82303f509f5
> --- /dev/null
> +++ b/drivers/pwm/pwm-sl28cpld.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sl28cpld PWM driver.
> + *
> + * Copyright 2019 Kontron Europe GmbH

This is out of date.

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +/*
> + * PWM timer block registers.
> + */
> +#define PWM_CTRL		0x00
> +#define   PWM_ENABLE		BIT(7)
> +#define   PWM_MODE_250HZ	0
> +#define   PWM_MODE_500HZ	1
> +#define   PWM_MODE_1KHZ		2
> +#define   PWM_MODE_2KHZ		3
> +#define   PWM_MODE_MASK		GENMASK(1, 0)
> +#define PWM_CYCLE		0x01
> +#define   PWM_CYCLE_MAX		0x7f
> +
> +struct sl28cpld_pwm {
> +	struct pwm_chip pwm_chip;
> +	struct regmap *regmap;
> +	u32 offset;
> +};
> +
> +struct sl28cpld_pwm_periods {
> +	u8 ctrl;
> +	unsigned long duty_cycle;
> +};
> +
> +struct sl28cpld_pwm_config {
> +	unsigned long period_ns;
> +	u8 max_duty_cycle;
> +};

Also, instead of hand rolling your own structure here, I think it
would be prudent to re-use something that already exists.  Seeing as
this will be used to describe possible state, perhaps 'struct
pwm_state' would be suitable - leaving polarity and enabled
unpopulated of course.

Ah wait (sorry, thinking allowed and on-the-fly here), what is
max_duty_cycle here?  I assume this does not have the same
meaning/value-type as the one in 'struct pwm_state'.  What does
max_duty_cycle represent in your use-case?

> +static struct sl28cpld_pwm_config sl28cpld_pwm_config[] = {
> +	[PWM_MODE_250HZ] = { .period_ns = 4000000, .max_duty_cycle = 0x80 },
> +	[PWM_MODE_500HZ] = { .period_ns = 2000000, .max_duty_cycle = 0x40 },
> +	[PWM_MODE_1KHZ] = { .period_ns = 1000000, .max_duty_cycle = 0x20 },
> +	[PWM_MODE_2KHZ] = { .period_ns =  500000, .max_duty_cycle = 0x10 },
> +};

Tiny nit: If you lined these up from the '{'s it would be easier to
see/compare the period_ns values at first glance, rather than having
to count the ' 's and '0's.

> +static inline struct sl28cpld_pwm *to_sl28cpld_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct sl28cpld_pwm, pwm_chip);
> +}

Why not save yourself the trouble and just:

  struct sl28cpld_pwm *pwm = dev_get_drvdata(chip->dev);

> +static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   struct pwm_state *state)
> +{
> +	struct sl28cpld_pwm *spc = to_sl28cpld_pwm(chip);
> +	static struct sl28cpld_pwm_config *config;
> +	unsigned int reg;
> +	unsigned long cycle;

Why is this 'long' here and 'long long' in *_apply()?

> +	unsigned int mode;
> +
> +	regmap_read(spc->regmap, spc->offset + PWM_CTRL, &reg);
> +
> +	state->enabled = reg & PWM_ENABLE;
> +
> +	mode = FIELD_GET(PWM_MODE_MASK, reg);
> +	config = &sl28cpld_pwm_config[mode];
> +	state->period = config->period_ns;
> +
> +	regmap_read(spc->regmap, spc->offset + PWM_CYCLE, &reg);
> +	cycle = reg * config->period_ns;
> +	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(cycle,
> +						  config->max_duty_cycle);
> +}
> +
> +static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct sl28cpld_pwm *spc = to_sl28cpld_pwm(chip);
> +	struct sl28cpld_pwm_config *config;
> +	unsigned long long cycle;
> +	int ret;
> +	int mode;
> +	u8 ctrl;
> +
> +	/* update config, first search best matching period */

Please use correct grammar (less full stops) in comments.

> +	for (mode = 0; mode < ARRAY_SIZE(sl28cpld_pwm_config); mode++) {
> +		config = &sl28cpld_pwm_config[mode];
> +		if (state->period == config->period_ns)
> +			break;
> +	}
> +
> +	if (mode == ARRAY_SIZE(sl28cpld_pwm_config))
> +		return -EINVAL;
> +
> +	ctrl = FIELD_PREP(PWM_MODE_MASK, mode);
> +	if (state->enabled)
> +		ctrl |= PWM_ENABLE;
> +
> +	cycle = state->duty_cycle * config->max_duty_cycle;
> +	do_div(cycle, state->period);

Forgive my ignorance (I'm new here!), but what are these 2 lines
doing?  Here we are multiplying the current duty_cycle with the
maximum value, then dividing by the period.

So in the case of PWM_MODE_1KHZ with a 50% duty cycle, you'd have:

   (500000 * 0x20[16]) / 1000000 = [0x10]16

Thus, the above gives as a proportional representation of the maximum
valid value for placement into the cycle control register(s), right?

Either way (whether I'm correct or not), I think it would be nice to
mention this in a comment.  Maybe even clarify with a simple example.

> +	/*
> +	 * The hardware doesn't allow to set max_duty_cycle if the
> +	 * 250Hz mode is enabled. But since this is "all-high" output
> +	 * just use the 500Hz mode with the duty cycle to max value.
> +	 */
> +	if (cycle == config->max_duty_cycle) {
> +		ctrl &= ~PWM_MODE_MASK;
> +		ctrl |= FIELD_PREP(PWM_MODE_MASK, PWM_MODE_500HZ);
> +		cycle = PWM_CYCLE_MAX;
> +	}

This is being executed even when 250Hz mode is not enabled.

Is that by design?  If so, it doesn't match the comment.

> +	ret = regmap_write(spc->regmap, spc->offset + PWM_CTRL, ctrl);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(spc->regmap, spc->offset + PWM_CYCLE, (u8)cycle);
> +}
> +
> +static const struct pwm_ops sl28cpld_pwm_ops = {
> +	.apply = sl28cpld_pwm_apply,
> +	.get_state = sl28cpld_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int sl28cpld_pwm_probe(struct platform_device *pdev)
> +{
> +	struct sl28cpld_pwm *pwm;

This is super confusing.  Here you call it 'pwm', but when you bring
the data to the fore for consumption, you call it something different
('spc') for some reason.

Is there logic behind this?

> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +
> +	pwm->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!pwm->regmap)
> +		return -ENODEV;
> +
> +	ret = device_property_read_u32(&pdev->dev, "reg", &pwm->offset);

Really?  Can you use the 'reg' property in this way?

Side question:
  Do any of your child address spaces actually overlap/intersect?

> +	if (ret)
> +		return -EINVAL;
> +
> +	/* initialize struct pwm_chip */

Proper grammar please.

> +	chip = &pwm->pwm_chip;
> +	chip->dev = &pdev->dev;
> +	chip->ops = &sl28cpld_pwm_ops;
> +	chip->base = -1;
> +	chip->npwm = 1;
> +
> +	ret = pwmchip_add(&pwm->pwm_chip);
> +	if (ret < 0)

Is '> 0' even valid?

Suggest "!ret" here, as you have done above.

> +		return ret;
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	return 0;
> +}
> +
> +static int sl28cpld_pwm_remove(struct platform_device *pdev)
> +{
> +	struct sl28cpld_pwm *pwm = platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&pwm->pwm_chip);
> +}
> +
> +static const struct of_device_id sl28cpld_pwm_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld-pwm" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
> +
> +static const struct platform_device_id sl28cpld_pwm_id_table[] = {
> +	{"sl28cpld-pwm"},

Spaces either side of the "'s please.

> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, sl28cpld_pwm_id_table);

What are you using this for?

> +static struct platform_driver sl28cpld_pwm_driver = {
> +	.probe = sl28cpld_pwm_probe,
> +	.remove	= sl28cpld_pwm_remove,
> +	.id_table = sl28cpld_pwm_id_table,
> +	.driver = {
> +		.name = KBUILD_MODNAME,

Please just use the quoted name in full.

> +		.of_match_table = sl28cpld_pwm_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_pwm_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld PWM Driver");

"SL28CPLD" ?

> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
