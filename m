Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657DD49BD13
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 21:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiAYU1c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 15:27:32 -0500
Received: from mail.nic.cz ([217.31.204.67]:50180 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbiAYU1V (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 25 Jan 2022 15:27:21 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 15:27:20 EST
Received: from thinkpad (unknown [172.20.6.87])
        by mail.nic.cz (Postfix) with ESMTPSA id A8195140B1F;
        Tue, 25 Jan 2022 21:21:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1643142099; bh=2/BBOCSh+UnqoT3pZiRKXo1KxFXu8Ongk3sToN0mHyY=;
        h=Date:From:To;
        b=AMF3kC0eIzAK8oEkZe8emeRAd2u+Y271mYtVsKC23oLcC4C4K0xFdeG5Qr8A9v60m
         fwZPSGfNZkB5zLSk3ggArKelscITE9AfixBXdJjd8FrEhQjSTk8m5tklUupY1Z4ofH
         7xAl1qGaqirJsptB1IAUTZG0GiN/DTdWsvqGa/dw=
Date:   Tue, 25 Jan 2022 21:21:36 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To:     sven@svenschwermer.de
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, post@lespocky.de
Subject: Re: [RFC PATCH v2 2/2] leds: Add PWM multicolor driver
Message-ID: <20220125212136.7cfc645e@thinkpad>
In-Reply-To: <20220125151226.31049-3-sven@svenschwermer.de>
References: <20220125151226.31049-1-sven@svenschwermer.de>
        <20220125151226.31049-3-sven@svenschwermer.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WELCOMELIST,USER_IN_WHITELIST shortcircuit=ham
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.4 at mail
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 25 Jan 2022 16:12:26 +0100
sven@svenschwermer.de wrote:

> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> By allowing to group multiple monochrome PWM LEDs into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
>  drivers/leds/Kconfig               |   8 ++
>  drivers/leds/Makefile              |   1 +
>  drivers/leds/leds-pwm-multicolor.c | 184 +++++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/leds/leds-pwm-multicolor.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6090e647daee..bae1f63f6195 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -552,6 +552,14 @@ config LEDS_PWM
>  	help
>  	  This option enables support for pwm driven LEDs
>  
> +config LEDS_PWM_MULTICOLOR
> +	tristate "PWM driven multi-color LED Support"
> +	depends on LEDS_CLASS_MULTICOLOR
> +	depends on PWM
> +	help
> +	  This option enables support for PWM driven monochrome LEDs that are
> +	  grouped into multicolor LEDs.
> +
>  config LEDS_REGULATOR
>  	tristate "REGULATOR driven LED support"
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index e58ecb36360f..ba2c2c1edf12 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_LEDS_PCA963X)		+= leds-pca963x.o
>  obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
>  obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
>  obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
> +obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
>  obj-$(CONFIG_LEDS_REGULATOR)		+= leds-regulator.o
>  obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
>  obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
> diff --git a/drivers/leds/leds-pwm-multicolor.c b/drivers/leds/leds-pwm-multicolor.c
> new file mode 100644
> index 000000000000..c54bed4536d3
> --- /dev/null
> +++ b/drivers/leds/leds-pwm-multicolor.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PWM-based multi-color LED control
> + *
> + * Copyright 2022 Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
> +#include <linux/err.h>
> +#include <linux/pwm.h>
> +#include <linux/mutex.h>

sort headers alphabetically

> +
> +struct pwm_led {
> +	struct pwm_device *pwm;
> +	struct pwm_state pwmstate;

maybe rename pwmstate to just state?

> +};
> +
> +struct pwm_mc_led {
> +	struct led_classdev_mc mc_cdev;
> +	struct mutex lock;
> +	struct pwm_led leds[];
> +};
> +
> +static int led_pwm_mc_set(struct led_classdev *cdev,
> +			  enum led_brightness brightness)
> +{
> +	int i;
> +	unsigned long long duty;
> +	int ret = 0;
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct pwm_mc_led *priv = container_of(mc_cdev, struct pwm_mc_led, mc_cdev);
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +
> +	mutex_lock(&priv->lock);
> +
> +	for (i = 0; i < mc_cdev->num_colors; ++i) {
> +		duty = priv->leds[i].pwmstate.period;
> +		duty *= mc_cdev->subled_info[i].brightness;
> +		do_div(duty, cdev->max_brightness);
> +
> +		priv->leds[i].pwmstate.duty_cycle = duty;
> +		priv->leds[i].pwmstate.enabled = duty > 0;
> +		ret = pwm_apply_state(priv->leds[i].pwm,
> +				      &priv->leds[i].pwmstate);
> +		if (ret)
> +			break;
> +	}
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return ret;
> +}
> +
> +static int led_pwm_mc_probe(struct platform_device *pdev)
> +{
> +	struct fwnode_handle *mcnode, *fwnode;
> +	int count = 0;
> +	struct pwm_mc_led *priv;
> +	struct mc_subled *subled;
> +	struct led_classdev *cdev;
> +	struct pwm_led *pwmled;
> +	u32 color;
> +	int ret = 0;
> +	struct led_init_data init_data = {};
> +
> +	mcnode = device_get_named_child_node(&pdev->dev, "multi-led");
> +	if (!mcnode) {
> +		dev_err(&pdev->dev, "expected multi-led node\n");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	/* count the nodes inside the multi-led node */
> +	fwnode_for_each_child_node(mcnode, fwnode)
> +		++count;
> +
> +	priv = devm_kzalloc(&pdev->dev, struct_size(priv, leds, count),
> +			    GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	mutex_init(&priv->lock);
> +
> +	subled = devm_kcalloc(&pdev->dev, count, sizeof(*subled), GFP_KERNEL);
> +	if (!subled) {
> +		ret = -ENOMEM;
> +		goto destroy_mutex;
> +	}
> +	priv->mc_cdev.subled_info = subled;
> +
> +	/* init the multicolor's LED class device */
> +	cdev = &priv->mc_cdev.led_cdev;
> +	fwnode_property_read_string(mcnode, "label", &cdev->name);

	label is deprecated, do not introduce in new bindings

> +	cdev->brightness = LED_OFF;

dont use this LED_OFF/LED_ON constants, they are deprecated

> +	fwnode_property_read_u32(mcnode, "max-brightness",
> +				 &cdev->max_brightness);
> +	cdev->flags = LED_CORE_SUSPENDRESUME;
> +	cdev->brightness_set_blocking = led_pwm_mc_set;
> +
> +	/* iterate over the nodes inside the multi-led node */
> +	fwnode_for_each_child_node(mcnode, fwnode) {
> +		pwmled = &priv->leds[priv->mc_cdev.num_colors];
> +		pwmled->pwm = devm_fwnode_pwm_get(&pdev->dev, fwnode, NULL);
> +		if (IS_ERR(pwmled->pwm)) {
> +			ret = PTR_ERR(pwmled->pwm);
> +			dev_err(&pdev->dev, "unable to request PWM: %d\n", ret);

you need to release the fwnode with fwnode_handle_put(fwnode) here

> +			goto destroy_mutex;
> +		}
> +		pwm_init_state(pwmled->pwm, &pwmled->pwmstate);
> +
> +		ret = fwnode_property_read_u32(fwnode, "color", &color);
> +		if (ret) {
> +			dev_err(&pdev->dev, "cannot read color: %d\n", ret);

you need to release the fwnode with fwnode_handle_put(fwnode) here

> +			goto destroy_mutex;
> +		}
> +
> +		subled[priv->mc_cdev.num_colors].color_index = color;
> +		subled[priv->mc_cdev.num_colors].channel =
> +			priv->mc_cdev.num_colors;
> +		++priv->mc_cdev.num_colors;
> +	}
> +
> +	init_data.fwnode = mcnode;
> +	ret = devm_led_classdev_multicolor_register_ext(&pdev->dev,
> +							&priv->mc_cdev,
> +							&init_data);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to register multicolor PWM led for %s: %d\n",
> +			cdev->name, ret);
> +		goto destroy_mutex;
> +	}
> +
> +	ret = led_pwm_mc_set(cdev, cdev->brightness);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to set led PWM value for %s: %d",
> +			cdev->name, ret);
> +		goto destroy_mutex;
> +	}
> +

you need to release mcnode with fwnode_handle_put(). You increased reference
count with device_get_named_child_node()

> +	platform_set_drvdata(pdev, priv);
> +	return 0;
> +
> +destroy_mutex:
> +	mutex_destroy(&priv->lock);
> +out:

here as well you need to release mcnode with fwnode_handle_put()

> +	return ret;
> +}
> +
> +static int led_pwm_mc_remove(struct platform_device *pdev)
> +{
> +	struct pwm_mc_led *priv = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&priv->lock);
> +	return 0;
> +}
> +
> +static const struct of_device_id of_pwm_leds_mc_match[] = {
> +	{ .compatible = "pwm-leds-multicolor", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_pwm_leds_mc_match);
> +
> +static struct platform_driver led_pwm_mc_driver = {
> +	.probe		= led_pwm_mc_probe,
> +	.remove		= led_pwm_mc_remove,
> +	.driver		= {
> +		.name	= "leds_pwm_multicolor",
> +		.of_match_table = of_pwm_leds_mc_match,
> +	},
> +};
> +
> +module_platform_driver(led_pwm_mc_driver);
> +
> +MODULE_AUTHOR("Sven Schwermer <sven.schwermer@disruptive-technologies.com>");
> +MODULE_DESCRIPTION("multi-color PWM LED driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:leds-pwm-multicolor");

