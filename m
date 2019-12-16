Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5A3121C2B
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Dec 2019 22:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfLPVvE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 16:51:04 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37005 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPVvE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 16:51:04 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep17so3601837pjb.4;
        Mon, 16 Dec 2019 13:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xJ7AuWshCK/rKZ+UPRR9KpKzBzzJ/zLDj2LbgfCe70=;
        b=oSKxRFjZilaMpzgJltlBgqaWD2rGZM/fE7M3YD9DmDc2pySzRC1UI+lQP1oTaQAYph
         0X9+m3tz2QUtTdRQtRUwvIUp8ZDFHQ2xR8EwDLncR3IxGipcVdKlXrs6HvUYKkrE4S2r
         76Lb6LToOunSXQE0eeb0m/5kAjTXeXyjqmswtKjj/8zVizRD7dygRaSrD8ps56uwdMzp
         Mvt0k+Kaz4mlZJEjrNQ3TFfbX6IaThMTNRcCyZoLlhBOnSYxJW/5ODbWAgpEPYPzQCzf
         g2hiliMLaLp2aMX70mLmNnMQN74giLfqQHOhPlPDevP69ZdMw9O/Gln7XsdvYVDp8n7o
         Ddig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xJ7AuWshCK/rKZ+UPRR9KpKzBzzJ/zLDj2LbgfCe70=;
        b=AMJb0kpXYPSTU4wxV/ICWD66hJxJmljg6FbIywVAOZAKOHIkeQxYmgU7gPE77QwUMC
         LUngfO2lL/n5/IFjzct2GmONESSfTV6koNr1mkRUUl8eJI2B+HDLPazfCU1Hbt2Z//J9
         ST6dFFaCgpOtejQI9Y00/98OVBFSFveh4YQ/uyhK7Lcriaepl3fLBnlwXlHJt1I3v4jT
         ZDE/yfjlL/sgJad89dnxKk8R0AP6YBqX2Rp4yesx6Hjy6pNw9in/BTpELMKDi4tXHB/A
         vWC5F5+ClyfGyWEdXVZLVI2cejQQOkuPu/DWT/HX8nDoUGPcB3Y2OraZ2riAktw1FJFi
         UJsA==
X-Gm-Message-State: APjAAAVkM32Gk7+Iv0J9D9bwIOjUWyUl18GxxTm1EELSgyB4peaDf8ml
        EOcSCK5gLTPGuyrCpxXnr6XtQMryERLV41HYnWM=
X-Google-Smtp-Source: APXvYqzEdkeB4ph9YGYvX3ZNEG9A0T3KWxL9/K8KzZe7uhifYuMF1e7WqVPnA59GN9mafj8sJCdPwzE4OoQbWUfLaRA=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr1873888pjq.132.1576533062790;
 Mon, 16 Dec 2019 13:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
In-Reply-To: <20191129191023.2209-1-miquel.raynal@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 16 Dec 2019 23:50:51 +0200
Message-ID: <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

I would like to be Cc'ed on the matters.

On Fri, Nov 29, 2019 at 9:13 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.

Thanks for an update!

Still I think it's wrong approach. What should be done is:
 - adding a pin configuration type of PWM (when, for example, argument
defines duty cycle and period)
 - conversion to pin control of this driver
 - enabling pin configuration PWM for it.

For now it looks like a custom way of doing it.
If GPIO maintainers are okay with it, I'll not object, just want to
have than something like TODO updated for the matter.

Taking above into consideration, I also provide my comments to the patch

...

>  #include <linux/bits.h>
> +#include <linux/bitmap.h>

It seems you need to take gpio/fixes branch as a base.

...

>  #define PCA_INT                        BIT(8)
>  #define PCA_PCAL               BIT(9)

> +#define MAX_PWM                        BIT(10)

Use same prefix.

...

> +#define PWM_MAX_COUNT 16
> +#define PWM_PER_REG 2

> +#define PWM_BITS_PER_REG (8 / PWM_PER_REG)

Can we simple put 4 here?

...

> +#define PWM_INTENSITY_MASK GENMASK(PWM_BITS_PER_REG - 1, 0)

Please use plain numbers for the GENMASK() arguments.

...

> +struct max7313_pwm_data {
> +       struct gpio_desc *desc;
> +};

Are you plan to extend this? Can we directly use struct gpio_desc pointer?

...

> +       if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
> +           chip->driver_data & MAX_PWM) {

Can't we simple check only for a flag for now?

> +               if (reg >= MAX7313_MASTER &&
> +                   reg < (MAX7313_INTENSITY + bank_sz))
> +                       return true;
> +       }

...

> +       if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
> +           chip->driver_data & MAX_PWM) {
> +               if (reg >= MAX7313_MASTER &&
> +                   reg < (MAX7313_INTENSITY + bank_sz))
> +                       return true;
> +       }

This is a duplicate from above. Need a helper?

...

> +/*
> + * Max7313 PWM specific methods
> + *
> + * Limitations:
> + * - Does not support a disabled state
> + * - Period fixed to 31.25ms
> + * - Only supports normal polarity
> + * - Some glitches cannot be prevented
> + */

Can we have below in a separate file and attach it to the gpio-pca953x
code iff CONFIG_PWM != n?

...

> +       mutex_lock(&pca_chip->i2c_lock);

> +       regmap_read(pca_chip->regmap, reg, &val);

No error check?

> +       mutex_unlock(&pca_chip->i2c_lock);

...

> +       if (shift)

Redundant.

> +               val >>= shift;

...

> +       mutex_lock(&pca_chip->i2c_lock);
> +       regmap_read(pca_chip->regmap, reg, &output);
> +       mutex_unlock(&pca_chip->i2c_lock);

No error check?

...

> +       mutex_lock(&pca_chip->i2c_lock);
> +       regmap_read(pca_chip->regmap, reg, &output);
> +       mutex_unlock(&pca_chip->i2c_lock);

No error check?

...

> +static int max7313_pwm_request(struct pwm_chip *chip,
> +                              struct pwm_device *pwm)
> +{
> +       struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> +       struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> +       struct max7313_pwm_data *data;
> +       struct gpio_desc *desc;
> +
> +       desc = gpiochip_request_own_desc(&pca_chip->gpio_chip, pwm->hwpwm,
> +                                        "max7313-pwm", GPIO_ACTIVE_HIGH, 0);
> +       if (IS_ERR(desc)) {

> +               dev_err(&pca_chip->client->dev,

Can't we get to struct device easily?
If it's possible maybe we could move next line to this one?

> +                       "pin already in use (probably as GPIO): %ld\n",
> +                       PTR_ERR(desc));
> +               return PTR_ERR(desc);
> +       }

> +       return 0;
> +}

...

> +       if (intensity)
> +               set_bit(pwm->hwpwm, max_pwm->active_pwm);
> +       else
> +               clear_bit(pwm->hwpwm, max_pwm->active_pwm);

assign_bit()

By the way, do you really need it to be atomic? Perhaps __asign_bit()?

...

> +       active = bitmap_weight(max_pwm->active_pwm, PWM_MAX_COUNT);

> +       if (!active)

In this case more readable will be active == 0 since you compare this
to the exact value.

> +               ret = max7313_pwm_set_master_intensity(pca_chip, 0);
> +       else if (active == 1)
> +               ret = max7313_pwm_set_master_intensity(pca_chip,
> +                                                      PWM_INTENSITY_MASK);

...

> +       if (IS_ENABLED(CONFIG_PWM)) {

I'm not sure it eliminates all PWM related callbacks.

> +               ret = max7313_pwm_probe(&client->dev, chip);
> +               if (ret) {
> +                       dev_err(&client->dev, "pwm probe failed, %d\n", ret);
> +                       return ret;
> +               }
> +       }

--
With Best Regards,
Andy Shevchenko
