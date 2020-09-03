Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE025BE60
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 11:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgICJXm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 05:23:42 -0400
Received: from 7of9.connected.by.freedominter.net ([185.238.129.13]:43274 "EHLO
        7of9.schinagl.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgICJXm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2020 05:23:42 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2020 05:23:41 EDT
Received: from [10.2.11.237] (unknown [10.2.11.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 75F70163BCC2;
        Thu,  3 Sep 2020 11:15:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1599124531; bh=BHuXmSRCVrpP3Xc0hGA8rU4Z4avIxXUjbyZKxlH8+Rc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WhQ6lVGcCt1i+4YBMYoUtcH8ouZX997lGfHPR/c8gSz9P5COhIvFEW2ywGdV2E8Y/
         6r/FKLVXeA3HOkypfs5ry4DCbISjOb0v+yIm8SHwesNDHvACoyGU+JUIXBSsu/vAgM
         HPDUglfN4u6TUP5DbSPQO0UvRUlDqXnWWe8KRvSQ=
Subject: Re: [PATCH 2/2] pwm: Add GPIO PWM driver
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
Cc:     kernel@axis.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
 <20200814155513.31936-2-vincent.whitchurch@axis.com>
From:   Olliver Schinagl <oliver@schinagl.nl>
Message-ID: <703362fe-1454-c16e-180a-76bfc4e3ab3f@schinagl.nl>
Date:   Thu, 3 Sep 2020 11:15:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200814155513.31936-2-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hey Vincent,

On 14-08-2020 17:55, Vincent Whitchurch wrote:
> Add a software PWM which toggles a GPIO from a high-resolution timer.
> 
> This will naturally not be as accurate or as efficient as a hardware
> PWM, but it is useful in some cases.  I have for example used it for
> evaluating LED brightness handling (via leds-pwm) on a board where the
> LED was just hooked up to a GPIO, and for a simple verification of the
> timer frequency on another platform.
> 
> Since high-resolution timers are used, sleeping gpio chips are not
> supported and are rejected in the probe function.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> While preparing this driver for posting, I found a pwm-gpio driver posted to
> the lists way back in 2015 by Olliver Schinagl:
> 
>   https://lore.kernel.org/linux-pwm/1445895161-2317-8-git-send-email-o.schinagl@ultimaker.com/
> 
Thanks for reminding me there :) As I think I still use this driver, I 
don't mind migrating to this one (if merged) but how do you suggests to 
proceed with regards to multiple PWM's, as this is how I am using it 
currently. E.g. how do we merge them? I'm fine with 'taking the simpler 
code method' for a start point, but i guess I solved that part 
(somewhat) in 2015 :p

> This driver was developed independently, but since both drivers are trivial
> they are quite similar.  The main difference I see (apart from the usage of
> newer APIs and DT schemas) is that this driver only supports one PWM per
> instance, which makes for simpler code.  I also reject sleeping GPIO chips
> explicitly while that driver uses gpio_set_value_cansleep() from a hrtimer,
> which is a no-no.
That was indeed my bad :)

But I think we didn't get much feedback back then, and it was never 
merged sadly :(

Olliver

> 
>   drivers/pwm/Kconfig    |  10 ++++
>   drivers/pwm/Makefile   |   1 +
>   drivers/pwm/pwm-gpio.c | 123 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 134 insertions(+)
>   create mode 100644 drivers/pwm/pwm-gpio.c
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 7dbcf6973d33..20e4fda82e61 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -181,6 +181,16 @@ config PWM_FSL_FTM
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called pwm-fsl-ftm.
>   
> +config PWM_GPIO
> +	tristate "GPIO PWM support"
> +	depends on OF && GPIOLIB
> +	help
> +	  Generic PWM framework driver for a software PWM toggling a GPIO pin
> +	  from kernel high-resolution timers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-gpio.
> +
>   config PWM_HIBVT
>   	tristate "HiSilicon BVT PWM support"
>   	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 2c2ba0a03557..2e045f063cd1 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>   obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
>   obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
>   obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
> +obj-$(CONFIG_PWM_GPIO)		+= pwm-gpio.o
>   obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
>   obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
>   obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
> diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
> new file mode 100644
> index 000000000000..e579aca0f937
> --- /dev/null
> +++ b/drivers/pwm/pwm-gpio.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2020 Axis Communications AB */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/hrtimer.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/pwm.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +
> +struct pwm_gpio {
> +	struct pwm_chip chip;
> +	struct hrtimer hrtimer;
> +	struct gpio_desc *gpio;
> +	ktime_t on_interval;
> +	ktime_t off_interval;
> +	bool invert;
> +	bool on;
> +};
> +
> +static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *hrtimer)
> +{
> +	struct pwm_gpio *gpwm = container_of(hrtimer, struct pwm_gpio, hrtimer);
> +	bool newon = !gpwm->on;
> +
> +	gpwm->on = newon;
> +	gpiod_set_value(gpwm->gpio, newon ^ gpwm->invert);
> +
> +	hrtimer_forward_now(hrtimer, newon ? gpwm->on_interval : gpwm->off_interval);
> +
> +	return HRTIMER_RESTART;
> +}
> +
> +static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
> +	struct pwm_gpio *gpwm = container_of(chip, struct pwm_gpio, chip);
> +
> +	hrtimer_cancel(&gpwm->hrtimer);
> +
> +	if (!state->enabled) {
> +		gpiod_set_value(gpwm->gpio, 0);
> +		return 0;
> +	}
> +
> +	gpwm->on_interval = ns_to_ktime(state->duty_cycle);
> +	gpwm->off_interval = ns_to_ktime(state->period - state->duty_cycle);
> +	gpwm->invert = state->polarity == PWM_POLARITY_INVERSED;
> +
> +	gpwm->on = !!gpwm->on_interval;
> +	gpiod_set_value(gpwm->gpio, gpwm->on ^ gpwm->invert);
> +
> +	if (gpwm->on_interval && gpwm->off_interval)
> +		hrtimer_start(&gpwm->hrtimer, gpwm->on_interval, HRTIMER_MODE_REL);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_gpio_ops = {
> +	.owner = THIS_MODULE,
> +	.apply = pwm_gpio_apply,
> +};
> +
> +static int pwm_gpio_probe(struct platform_device *pdev)
> +{
> +	struct pwm_gpio *gpwm;
> +	int ret;
> +
> +	gpwm = devm_kzalloc(&pdev->dev, sizeof(*gpwm), GFP_KERNEL);
> +	if (!gpwm)
> +		return -ENOMEM;
> +
> +	gpwm->gpio = devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
> +	if (IS_ERR(gpwm->gpio))
> +		return PTR_ERR(gpwm->gpio);
> +
> +	if (gpiod_cansleep(gpwm->gpio))
> +		return -EINVAL;
> +
> +	gpwm->chip.dev = &pdev->dev;
> +	gpwm->chip.ops = &pwm_gpio_ops;
> +	gpwm->chip.base = pdev->id;
> +	gpwm->chip.npwm = 1;
> +
> +	hrtimer_init(&gpwm->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	gpwm->hrtimer.function = pwm_gpio_timer;
> +
> +	ret = pwmchip_add(&gpwm->chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, gpwm);
> +
> +	return 0;
> +}
> +
> +static int pwm_gpio_remove(struct platform_device *pdev)
> +{
> +	struct pwm_gpio *gpwm = platform_get_drvdata(pdev);
> +
> +	return pwmchip_remove(&gpwm->chip);
> +}
> +
> +static const struct of_device_id pwm_gpio_dt_ids[] = {
> +	{ .compatible = "pwm-gpio", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pwm_gpio_dt_ids);
> +
> +static struct platform_driver pwm_gpio_driver = {
> +	.driver = {
> +		.name = "pwm-gpio",
> +		.of_match_table = pwm_gpio_dt_ids,
> +	},
> +	.probe = pwm_gpio_probe,
> +	.remove = pwm_gpio_remove,
> +};
> +
> +module_platform_driver(pwm_gpio_driver);
> +
> +MODULE_LICENSE("GPL v2");
> 
