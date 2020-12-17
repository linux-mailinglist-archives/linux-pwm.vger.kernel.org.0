Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F3A2DCB99
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 05:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgLQEEc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Dec 2020 23:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgLQEEc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2020 23:04:32 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CF9C061794;
        Wed, 16 Dec 2020 20:03:51 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id m67so3820591vkg.7;
        Wed, 16 Dec 2020 20:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpvV4G1320CTcs8x7p4CfEdvxJWtV5tnsFEXn9LRPH0=;
        b=TKMEytSWe/cqxWm6g5cTDMI+7fdNKB///tfnib7Q4WpFIS+i51uonxTKysS/ImG9R5
         J1PR4KxmjnXVJx7TAaOmtHSkAGpIlYp1oAa7PZI7OwLq6tJ84NY4jNEGzd2J1dUpPZqg
         MFixL+YJkvYH7d07ZPMhwV2DjIrYf6wMkYm6erAczWSFNbP4jQ73NJw85q3Fv+3p+DBX
         it295E2eoliUyzkNHZ0ySglUXEJVuWHd78kc7MoRUp05p/QPG04FvY4Vwis+CCszJtxz
         K1HEWdvRvYS9t/4uYBKXc+quUcaXW8JSIiWbNGyCONTxivEyVlhd9DvU4594+NXLZXJg
         wBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpvV4G1320CTcs8x7p4CfEdvxJWtV5tnsFEXn9LRPH0=;
        b=Qn2nwN/juq6FULSTE8WgBY38dMJ2xGIOJZ9zXljyYxY9oaX+aEPgiRBtDYRjJaAUrK
         VCYmJ2DWNpM70/+QE0ryBiTw+nVok+4GU6rOz8rIJl3xGqZOfS+rz1RcqR4vBNM+UcKJ
         8Tn9Q8KPJdBo8k3lBB5xFoveYJUj5TPhGAv/PTxv2iYPTPoYJHgWBJzS0p+3E63Npx+L
         KIoBPGCFWKqXiHocDr3ANXXMeJ4g5yIoIivec2mkkBYkiaAWYzwwdLycSXfuK364G2yM
         PgtDsRt+cO8LPdFPAflKPc4bem3Ms96gH8PvQ7RwyR1+2meSJGrAEITeaKdJzvVRDXwp
         Sudg==
X-Gm-Message-State: AOAM533KnNNmbb9o0GyKGW5Zl4G5JRufqJ8AD2b76DHb828s2a9MgKY9
        je+Q66XK+Ne9x4JxkC4Q/UkCYT9XlUVV1A6XtPA=
X-Google-Smtp-Source: ABdhPJz0OJIv+LRrzEK6zUQBMMIDFInFxUEMu4weV89KWfpYwx75ylbOSuKYe2hLBmSvzV5mI7uxqMjFTwE6YzXv0MQ=
X-Received: by 2002:a1f:fc84:: with SMTP id a126mr25223346vki.23.1608177830721;
 Wed, 16 Dec 2020 20:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com> <20201215212228.185517-7-clemens.gruber@pqgruber.com>
In-Reply-To: <20201215212228.185517-7-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 16 Dec 2020 23:03:39 -0500
Message-ID: <CAGngYiWHrq0f=bQSRpkHtU6Uo4UJ8XoNTxdT6o8njE3cH3H2Mw@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] pwm: pca9685: Restrict period change for prescaler users
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Clemens, see below.

On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> Previously, the last used PWM channel could change the global prescale
> setting, even if other channels were already in use.
>
> Fix it by only allowing the first user of the prescaler to change the
> global chip-wide prescale setting. If there is more than one channel in
> use, the prescale settings resulting from the chosen periods must match.
>
> PWMs that are disabled or have a duty cycle of 0% or 100% are not
> considered to be using the prescaler as they have the full OFF or full
> ON bits set. This also applies to channels used as GPIOs.
>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 51 +++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index ff916980de49..438492d4aed4 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -23,11 +23,11 @@
>  #include <linux/bitmap.h>
>
>  /*
> - * Because the PCA9685 has only one prescaler per chip, changing the period of
> - * one channel affects the period of all 16 PWM outputs!
> - * However, the ratio between each configured duty cycle and the chip-wide
> - * period remains constant, because the OFF time is set in proportion to the
> - * counter range.
> + * Because the PCA9685 has only one prescaler per chip, only the first channel
> + * that uses the prescaler is allowed to change the prescale register.
> + * PWM channels requested afterwards must use a period that results in the same
> + * prescale setting as the one set by the first requested channel, unless they
> + * use duty cycles of 0% or 100% (prescaler not used for full OFF/ON).
>   */
>
>  #define PCA9685_MODE1          0x00
> @@ -80,6 +80,8 @@ struct pca9685 {
>         struct pwm_chip chip;
>         struct regmap *regmap;
>         bool staggered_outputs;
> +       struct mutex prescaler_users_lock;

Keep things simple by re-using the "struct mutex lock" below?
This code isn't performance-intensive, so having a single lock for
pwm/gpio requests + pwm_apply() is probably ok.

> +       DECLARE_BITMAP(prescaler_users, PCA9685_MAXCHAN + 1);

Rename to pwms_use_prescale ?

>  #if IS_ENABLED(CONFIG_GPIOLIB)
>         struct mutex lock;
>         struct gpio_chip gpio;
> @@ -92,6 +94,18 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
>         return container_of(chip, struct pca9685, chip);
>  }
>
> +/* This function is supposed to be called with the prescaler_users_lock held */
> +static inline bool pca9685_may_change_prescaler(struct pca9685 *pca, int channel)

Drop the inline? Only the compiler knows if inlining this function makes sense
on a platform (armv7, x86, etc). Compilers are usually better at this then
humans...

Rename to pca9685_prescaler_can_change() ?

> +{
> +       /*
> +        * A PWM channel may only change the prescaler if there are no users of
> +        * the prescaler yet or that same channel is the only one in use.
> +        */
> +       return bitmap_empty(pca->prescaler_users, PCA9685_MAXCHAN + 1) ||
> +               (bitmap_weight(pca->prescaler_users, PCA9685_MAXCHAN + 1) == 1 &&
> +                test_bit(channel, pca->prescaler_users));
> +}

I found this logic expression quite complex to read. Perhaps simplify by using
a few steps? For example:

/* if prescaler not in use, we can always change it */
if (empty) return true;
/* if more than one pwm is using the prescaler, we can never change it */
if (weight > 1) return false;
/* one pwm is using the prescaler, we can only change it if it's us */
return test_bit(us);

> +
>  static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
>  {
>         unsigned int on, off;
> @@ -337,16 +351,25 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>         duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
>         duty = DIV_ROUND_CLOSEST_ULL(duty, state->period);
>
> +       mutex_lock(&pca->prescaler_users_lock);
> +
>         if (!state->enabled || duty < 1) {
>                 pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> -               return 0;
> +               goto prescaler_unused;
>         } else if (duty == PCA9685_COUNTER_RANGE) {
>                 pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
> -               return 0;
> +               goto prescaler_unused;
>         }
>
>         regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
>         if (prescale != val) {
> +               if (!pca9685_may_change_prescaler(pca, pwm->hwpwm)) {
> +                       mutex_unlock(&pca->prescaler_users_lock);
> +                       dev_err(chip->dev,
> +                               "prescaler not set: already in use with different setting!\n");
> +                       return -EBUSY;
> +               }
> +
>                 /*
>                  * Putting the chip briefly into SLEEP mode
>                  * at this point won't interfere with the
> @@ -364,6 +387,14 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>         }
>
>         pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
> +
> +       set_bit(pwm->hwpwm, pca->prescaler_users);
> +       mutex_unlock(&pca->prescaler_users_lock);
> +       return 0;
> +
> +prescaler_unused:
> +       clear_bit(pwm->hwpwm, pca->prescaler_users);
> +       mutex_unlock(&pca->prescaler_users_lock);
>         return 0;
>  }

The need for the mutex makes this function quite "messy": we have to guard all
the exits, and that's easy to forget.

Maybe simplify the function by moving the mutex to a helper?
Example:

static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
     const struct pwm_state *state)
{
 ... just do stuff and don't worry about the mutex
}

static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
     const struct pwm_state *state)
{
    /* document why we serialize pwm_apply */
    mutex_lock();
    __pca9685_pwm_apply(chip, pwm, state);
    mutex_unlock();
}

>
> @@ -422,7 +453,11 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>         struct pca9685 *pca = to_pca(chip);
>
> +       mutex_lock(&pca->prescaler_users_lock);
> +       clear_bit(pwm->hwpwm, pca->prescaler_users);
>         pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> +       mutex_unlock(&pca->prescaler_users_lock);
> +
>         pm_runtime_put(chip->dev);
>         pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
>  }
> @@ -463,6 +498,8 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>
>         i2c_set_clientdata(client, pca);
>
> +       mutex_init(&pca->prescaler_users_lock);
> +
>         regmap_read(pca->regmap, PCA9685_MODE2, &reg);
>
>         if (device_property_read_bool(&client->dev, "invert"))
> --
> 2.29.2
>
