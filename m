Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F07F4A70DF
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Feb 2022 13:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiBBMfM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Feb 2022 07:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiBBMfM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Feb 2022 07:35:12 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18ACC061714;
        Wed,  2 Feb 2022 04:35:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jx6so65573847ejb.0;
        Wed, 02 Feb 2022 04:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/AxST3kZDMpzARyG46hGcn8mCPMME4ss/BsebPInHE=;
        b=joa8kT/tqwsQO/2H4azBuGuxzy3fkDJg0QsLz3+5px3NLJZAo1pj6VmfM9N+STo5OM
         UmX4NdP44muyKhO2cT503cdq6v/f/8yMM61zbDV8LMZU1wbXiBK9pIUNcl2TkKETlYcS
         RuXb/kgSl1DA/OV5NTgYiJx/O+c4CBLPwzYnjtAQxg85277iz9MgyLtDfdTrrU+aIvkU
         oKMexEhX2Iw2PpeSK/28/XsL35iMy6dydjVymN/IoTrOPYYE5KDT3zSpShaWGTmNXVq4
         ZDvQAtFfZLsDy5m1y/z8oHc81m7VGJjLfIawY3/4prZh1LgosUUJWqXjEyGLTD+J7O/s
         UtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/AxST3kZDMpzARyG46hGcn8mCPMME4ss/BsebPInHE=;
        b=A4inmkQNz8Ahh4y2ayobh3BoElmDJVviD3y6dGHOLGPSmTgIi1aY8/hYrzXg0XrgNS
         tpymszk1AqBcReRtMv2SEXjVyWck7hOUd4vMN3lWPsUxMSxwG7iLDlBhVVEOTlsuMcc9
         Ek6TyXZ4TrXY/jHy7Tyof0eujSUZePb0UA0E2YTE+RUFAwYz5a172/Nc2E+yAaFsW/Gq
         cC5RxBP40h2CtSNAwlPQVMmvu54VZxUlGIozM3MWzpEJCdgRgAso8XndIu4zTJXQmmM7
         kHtUYbzx2jfipC0UZTQ4i/3YpF6JLbNCHW62B19XpFnZjD5jkqiuC73/mLBeOYKzV08K
         UIvg==
X-Gm-Message-State: AOAM531ZX95f/fAiv1FYbqHOCehXgHoSvFbwJ1ujihJCA+SzX4nQBv9X
        XAllJ7O+MruwkF26p4St07pxoScstcqpWWJl8h8=
X-Google-Smtp-Source: ABdhPJyHELkt8dvvT9YrhGvO60hQv1+t5WjXPq5ls2EQRa32m7FIpSxTcGVeBeYKrk5KD2h1vxnrrGIzkYSDS3WDF6I=
X-Received: by 2002:a17:906:c14d:: with SMTP id dp13mr25365825ejc.132.1643805310171;
 Wed, 02 Feb 2022 04:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20220126104844.246068-1-sven@svenschwermer.de> <20220126104844.246068-3-sven@svenschwermer.de>
In-Reply-To: <20220126104844.246068-3-sven@svenschwermer.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 2 Feb 2022 14:33:34 +0200
Message-ID: <CAHp75VfMTCvgib__PhnfB_g7xLhyNws5TDRyMVyzuAkT1ydY_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] leds: Add PWM multicolor driver
To:     sven@svenschwermer.de
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
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 26, 2022 at 11:05 PM <sven@svenschwermer.de> wrote:
>
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
>
> By allowing to group multiple monochrome PWM LEDs into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.

...

> +       help
> +         This option enables support for PWM driven monochrome LEDs that are
> +         grouped into multicolor LEDs.

What would be the module name if compiled as a module?

...

> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>

mod_devicetable.h

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>

property.h

> +#include <linux/pwm.h>

...

> +       int i;
> +       unsigned long long duty;
> +       int ret = 0;
> +       struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +       struct pwm_mc_led *priv = container_of(mc_cdev, struct pwm_mc_led, mc_cdev);

Can we order in reversed xmas tree order?

       struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
       struct pwm_mc_led *priv = container_of(mc_cdev, struct
pwm_mc_led, mc_cdev);
       unsigned long long duty;
       int ret = 0;
       int i;

Same for other functions.

...

> +               dev_err(&pdev->dev, "expected multi-led node\n");
> +               ret = -ENODEV;
> +               goto out;

return dev_err_probe(dev, -ENODEV, ...);

...

> +       /* count the nodes inside the multi-led node */
> +       fwnode_for_each_child_node(mcnode, fwnode)
> +               ++count;

Postincrement shall work the same way.

...

> +                       ret = PTR_ERR(pwmled->pwm);
> +                       dev_err(&pdev->dev, "unable to request PWM: %d\n", ret);
> +                       fwnode_handle_put(fwnode);
> +                       goto destroy_mutex;

fwnode_handle_put();
return dev_err_probe(...);

...

> +                       dev_err(&pdev->dev, "cannot read color: %d\n", ret);
> +                       fwnode_handle_put(fwnode);
> +                       goto destroy_mutex;

fwnode_handle_put();
return dev_err_probe();

> +               }

...

> +               ++priv->mc_cdev.num_colors;

Postincrement shall work the same way.

> +       }

...

> +               dev_err(&pdev->dev,
> +                       "failed to register multicolor PWM led for %s: %d\n",
> +                       cdev->name, ret);
> +               goto destroy_mutex;

return dev_err_probe();

...

> +               dev_err(&pdev->dev, "failed to set led PWM value for %s: %d",
> +                       cdev->name, ret);
> +               goto destroy_mutex;

return dev_err_probe();

...

> +destroy_mutex:
> +       mutex_destroy(&priv->lock);

Wrong ordering here and in ->remove().

Don't mix devm_* with non-devm_* calls.

> +release_mcnode:
> +       fwnode_handle_put(mcnode);

> +out:
> +       return ret;

Return directly.

> +}
> +
> +static int led_pwm_mc_remove(struct platform_device *pdev)
> +{
> +       struct pwm_mc_led *priv = platform_get_drvdata(pdev);
> +
> +       mutex_destroy(&priv->lock);
> +       return 0;
> +}

...

> +static const struct of_device_id of_pwm_leds_mc_match[] = {
> +       { .compatible = "pwm-leds-multicolor", },

> +       {},

No comma needed for terminator entry.

> +};

...

> +static struct platform_driver led_pwm_mc_driver = {
> +       .probe          = led_pwm_mc_probe,
> +       .remove         = led_pwm_mc_remove,
> +       .driver         = {
> +               .name   = "leds_pwm_multicolor",
> +               .of_match_table = of_pwm_leds_mc_match,
> +       },
> +};

> +

Redundant blank line.

> +module_platform_driver(led_pwm_mc_driver);


--
With Best Regards,
Andy Shevchenko
