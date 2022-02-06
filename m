Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E744AB1DD
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Feb 2022 21:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiBFUAl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Feb 2022 15:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiBFUAk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Feb 2022 15:00:40 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE8C06173B;
        Sun,  6 Feb 2022 12:00:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m4so36221292ejb.9;
        Sun, 06 Feb 2022 12:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTcHMW07DmnMKOyj2vpUuonEZX070Sp+0SsBM62iyZM=;
        b=G/bZUhPWzsQuPCtycNt8+jYoCylaoAahqpeq4O+dcACmY9dbng97/BxKW6ak7TLPg+
         8NRPYCikC87upQ3D06kAvnvkZO+byzB97ll9Xtkr8vDQPuh5uCK7YVnyGyGn1biTOuC6
         xD/D5z69DzVq4f/WfV4fpAYXRHZmOsoSWeIfpz0G/j2zkI5+YIEQNo3YoXCo1+PNRrfQ
         /ElRzIwvy8MKNHgiKIu9DvkxUmAXv739v5d9RZqAEI2jINePWI9zAMrwF+KOS7oRmzRo
         wP2XDjKSr3tnVgqydCq9cMuB+Mew/lT2oiRquA7kx2klJsQahb3ZbzJKht1kQuo4SCtk
         E7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTcHMW07DmnMKOyj2vpUuonEZX070Sp+0SsBM62iyZM=;
        b=kTCsYKWgjnTHRw0bYsw4QX28vI47ir30rZXR0A+k2xSELgXpe/r/SjssoDzA+33FMx
         OswcOvXn//ERTZkjZ5bPE9kv0VQZhCFsU5aa9s8pAZtTuCum7kjDsdyBZbZe6o+fPLR/
         azb8zA0bYdeOEg0M56hhrmIRjwOKsifGIHbeOuT6EXDYVeEth82hKeWOvn4BuYER/C2s
         Rg6JZVf8hPdAlxUf+wS+zB8Bn+sAZog2wHpcJM+SM7/i72JK4nQHlfLmat63es+4WhOX
         ATBBKyqaPwD30KsyXXGGtDTNGhSVoNuCthds6sw8y41s4q1Kflkaf+ou1cu5F044gPoF
         knmw==
X-Gm-Message-State: AOAM533ZvBDi5MGgCr+p8zFKRJa0HoEY5ibND2cEo6pw5iz2oW4oAR/H
        Y0yUUTjjlprCkMGWYeBninxLS6KY4iqPTUHS8S6HnvvJ5hU=
X-Google-Smtp-Source: ABdhPJz3X4NJtIHykJJel+M19l/yEmAIjO7Da1Gf/WtBPH0vVO8ufvDAVwe9fftMC6cdFeJU91NSwGvhuo+k31lMl8A=
X-Received: by 2002:a17:906:c14d:: with SMTP id dp13mr7465684ejc.132.1644177637993;
 Sun, 06 Feb 2022 12:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20220206193554.171070-1-sven@svenschwermer.de> <20220206193554.171070-3-sven@svenschwermer.de>
In-Reply-To: <20220206193554.171070-3-sven@svenschwermer.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 6 Feb 2022 22:00:02 +0200
Message-ID: <CAHp75VdnALJCiNazgRPja=c9wB9sudZcQ7+pZ0oOzJ3QARTtaw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] leds: Add PWM multicolor driver
To:     Sven Schwermer <sven@svenschwermer.de>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        post@lespocky.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Feb 6, 2022 at 9:36 PM <sven@svenschwermer.de> wrote:
>
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
>
> By allowing to group multiple monochrome PWM LEDs into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.

It's not big deal (the comment I gave you), the code looks fine to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> ---
>
> Notes:
>     Changes in v4:
>     * Remove mutex destruction and remove function
>     * Include missing headers
>     * Use post-increment instead of pre-increment
>     * Variable declarations in reverse xmas tree order
>     * Use dev_err_probe where possible
>     * Return immediately where possible
>     * Cosmetic changes
>     * Document LKM name
>
>     Changes in v3:
>     * Release fwnode handles
>     * Sort header includes
>     * Remove deprecated device tree properties
>     * Remove deprecated LED_OFF
>     * Remove subled channel assignment
>     * s/pwmstate/state/
>
>  drivers/leds/Kconfig               |  11 ++
>  drivers/leds/Makefile              |   1 +
>  drivers/leds/leds-pwm-multicolor.c | 170 +++++++++++++++++++++++++++++
>  3 files changed, 182 insertions(+)
>  create mode 100644 drivers/leds/leds-pwm-multicolor.c
>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6090e647daee..e70a46704076 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -552,6 +552,17 @@ config LEDS_PWM
>         help
>           This option enables support for pwm driven LEDs
>
> +config LEDS_PWM_MULTICOLOR
> +       tristate "PWM driven multi-color LED Support"
> +       depends on LEDS_CLASS_MULTICOLOR
> +       depends on PWM
> +       help
> +         This option enables support for PWM driven monochrome LEDs that are
> +         grouped into multicolor LEDs.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called leds-pwm-multicolor.
> +
>  config LEDS_REGULATOR
>         tristate "REGULATOR driven LED support"
>         depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index e58ecb36360f..ba2c2c1edf12 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_LEDS_PCA963X)            += leds-pca963x.o
>  obj-$(CONFIG_LEDS_PM8058)              += leds-pm8058.o
>  obj-$(CONFIG_LEDS_POWERNV)             += leds-powernv.o
>  obj-$(CONFIG_LEDS_PWM)                 += leds-pwm.o
> +obj-$(CONFIG_LEDS_PWM_MULTICOLOR)      += leds-pwm-multicolor.o
>  obj-$(CONFIG_LEDS_REGULATOR)           += leds-regulator.o
>  obj-$(CONFIG_LEDS_S3C24XX)             += leds-s3c24xx.o
>  obj-$(CONFIG_LEDS_SC27XX_BLTC)         += leds-sc27xx-bltc.o
> diff --git a/drivers/leds/leds-pwm-multicolor.c b/drivers/leds/leds-pwm-multicolor.c
> new file mode 100644
> index 000000000000..96712b8ca98e
> --- /dev/null
> +++ b/drivers/leds/leds-pwm-multicolor.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PWM-based multi-color LED control
> + *
> + * Copyright 2022 Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +
> +struct pwm_led {
> +       struct pwm_device *pwm;
> +       struct pwm_state state;
> +};
> +
> +struct pwm_mc_led {
> +       struct led_classdev_mc mc_cdev;
> +       struct mutex lock;
> +       struct pwm_led leds[];
> +};
> +
> +static int led_pwm_mc_set(struct led_classdev *cdev,
> +                         enum led_brightness brightness)
> +{
> +       struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +       struct pwm_mc_led *priv = container_of(mc_cdev, struct pwm_mc_led, mc_cdev);
> +       unsigned long long duty;
> +       int ret = 0;
> +       int i;
> +
> +       led_mc_calc_color_components(mc_cdev, brightness);
> +
> +       mutex_lock(&priv->lock);
> +
> +       for (i = 0; i < mc_cdev->num_colors; i++) {
> +               duty = priv->leds[i].state.period;
> +               duty *= mc_cdev->subled_info[i].brightness;
> +               do_div(duty, cdev->max_brightness);
> +
> +               priv->leds[i].state.duty_cycle = duty;
> +               priv->leds[i].state.enabled = duty > 0;
> +               ret = pwm_apply_state(priv->leds[i].pwm,
> +                                     &priv->leds[i].state);
> +               if (ret)
> +                       break;
> +       }
> +
> +       mutex_unlock(&priv->lock);
> +
> +       return ret;
> +}
> +
> +static int led_pwm_mc_probe(struct platform_device *pdev)
> +{
> +       struct fwnode_handle *mcnode, *fwnode;
> +       struct led_init_data init_data = {};
> +       struct led_classdev *cdev;
> +       struct mc_subled *subled;
> +       struct pwm_mc_led *priv;
> +       struct pwm_led *pwmled;
> +       int count = 0;
> +       int ret = 0;
> +       u32 color;
> +
> +       mcnode = device_get_named_child_node(&pdev->dev, "multi-led");
> +       if (!mcnode)
> +               return dev_err_probe(&pdev->dev, -ENODEV,
> +                                    "expected multi-led node\n");
> +
> +       /* count the nodes inside the multi-led node */
> +       fwnode_for_each_child_node(mcnode, fwnode)
> +               count++;
> +
> +       priv = devm_kzalloc(&pdev->dev, struct_size(priv, leds, count),
> +                           GFP_KERNEL);
> +       if (!priv) {
> +               ret = -ENOMEM;
> +               goto release_mcnode;
> +       }
> +       mutex_init(&priv->lock);
> +
> +       subled = devm_kcalloc(&pdev->dev, count, sizeof(*subled), GFP_KERNEL);
> +       if (!subled) {
> +               ret = -ENOMEM;
> +               goto release_mcnode;
> +       }
> +       priv->mc_cdev.subled_info = subled;
> +
> +       /* init the multicolor's LED class device */
> +       cdev = &priv->mc_cdev.led_cdev;
> +       fwnode_property_read_u32(mcnode, "max-brightness",
> +                                &cdev->max_brightness);
> +       cdev->flags = LED_CORE_SUSPENDRESUME;
> +       cdev->brightness_set_blocking = led_pwm_mc_set;
> +
> +       /* iterate over the nodes inside the multi-led node */
> +       fwnode_for_each_child_node(mcnode, fwnode) {
> +               pwmled = &priv->leds[priv->mc_cdev.num_colors];
> +               pwmled->pwm = devm_fwnode_pwm_get(&pdev->dev, fwnode, NULL);
> +               if (IS_ERR(pwmled->pwm)) {
> +                       ret = PTR_ERR(pwmled->pwm);
> +                       dev_err(&pdev->dev, "unable to request PWM: %d\n", ret);
> +                       fwnode_handle_put(fwnode);
> +                       goto release_mcnode;
> +               }
> +               pwm_init_state(pwmled->pwm, &pwmled->state);
> +
> +               ret = fwnode_property_read_u32(fwnode, "color", &color);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "cannot read color: %d\n", ret);
> +                       fwnode_handle_put(fwnode);
> +                       goto release_mcnode;
> +               }
> +
> +               subled[priv->mc_cdev.num_colors].color_index = color;
> +               priv->mc_cdev.num_colors++;
> +       }
> +
> +       init_data.fwnode = mcnode;
> +       ret = devm_led_classdev_multicolor_register_ext(&pdev->dev,
> +                                                       &priv->mc_cdev,
> +                                                       &init_data);
> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "failed to register multicolor PWM led for %s: %d\n",
> +                       cdev->name, ret);
> +               goto release_mcnode;
> +       }
> +
> +       ret = led_pwm_mc_set(cdev, cdev->brightness);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "failed to set led PWM value for %s: %d",
> +                                    cdev->name, ret);
> +
> +       platform_set_drvdata(pdev, priv);
> +       return 0;
> +
> +release_mcnode:
> +       fwnode_handle_put(mcnode);
> +       return ret;
> +}
> +
> +static const struct of_device_id of_pwm_leds_mc_match[] = {
> +       { .compatible = "pwm-leds-multicolor", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, of_pwm_leds_mc_match);
> +
> +static struct platform_driver led_pwm_mc_driver = {
> +       .probe          = led_pwm_mc_probe,
> +       .driver         = {
> +               .name   = "leds_pwm_multicolor",
> +               .of_match_table = of_pwm_leds_mc_match,
> +       },
> +};
> +module_platform_driver(led_pwm_mc_driver);
> +
> +MODULE_AUTHOR("Sven Schwermer <sven.schwermer@disruptive-technologies.com>");
> +MODULE_DESCRIPTION("multi-color PWM LED driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:leds-pwm-multicolor");
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
