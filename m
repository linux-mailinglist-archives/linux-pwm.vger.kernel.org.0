Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012AC2DCB96
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 05:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgLQEDt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Dec 2020 23:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgLQEDt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2020 23:03:49 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF97FC061794;
        Wed, 16 Dec 2020 20:03:08 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id x4so14202058vsp.7;
        Wed, 16 Dec 2020 20:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6CNtTVVyY6d10mDbLdiGXg4JU+0YRuk7ZSRjZDJfRM=;
        b=Rk49oQeUKJDu4aLrLWz+S0TSDHJbx6QUWv7FTRiqmsM1gMv0pFh5cTRgtjwAfjObWn
         Tr6OGV9r1KBb0k0+aAmAFxH6qyfP4eqcSixSmRL+SCY618hE2UQP4wUEh+xCfwESuGkF
         k9rna7RAj4PuLa4f33x9bvlNbOg2rjMS5jf/qEpNWrggkBCN4lqqgw7WR3vP4PI9y1GR
         6f30dSvQu7EpMIxlZm6tH+tjHIE3h+b+CiXfau1yWekwWFsF17bB1EzDeBTOGikFuw2v
         FdhY7TfdKIvVyifgix9Kvrvv6O9L+jlIbYPmJvxpsW1qMl3LK0dkcjrVliBMhH3vsg89
         FG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6CNtTVVyY6d10mDbLdiGXg4JU+0YRuk7ZSRjZDJfRM=;
        b=RkHIVvwxZbdwNjzWSEO/IgJOPF6uJHyiTG/D3NWRqsJ6b57nh7u/HCbyY5vky602SR
         QBHCa5pOhgP+vK1JGTNk8R8lDUVkfbmQiHDMhHoWflsUpkD1jGT5Gr4/kvqNdcXdxB1C
         RdPU1Q3tEo0gmpxVb+bW5JWwp1nfMLglBlLM4Yxmlar+VAUN9EdPeUCCfvQFN5rA1atN
         SqgIbnLlpbvzCyEL+RHnVbhdjk+T/7jl9t20IkvdNy/67BmhsldF8tWVlU19QIKwTRKN
         Hi1RBeqerxIspHUfdfISrzMHL8a1uWHGxLML4DWohs8hjYNpBhcwWDcSqtMYWjPMdt8i
         4SXg==
X-Gm-Message-State: AOAM533QZrpuTAFW844xJGRvb1CI/3vcV3KdgTsq5ZvR9dzfYA56cd70
        XER+3HiLMgPpWsbR5G62FtEsAkC4bVjm//MC10E=
X-Google-Smtp-Source: ABdhPJwHl27mFn6pJei0jyv0vIKawPChnFpPlZcvSXoOyziQHcleuCbgG0V2gVWtY8iBmBJ2J6aF2Hxch0YTRU+Lp9A=
X-Received: by 2002:a67:2287:: with SMTP id i129mr33549984vsi.15.1608177787893;
 Wed, 16 Dec 2020 20:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com> <20201215212228.185517-5-clemens.gruber@pqgruber.com>
In-Reply-To: <20201215212228.185517-5-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 16 Dec 2020 23:02:57 -0500
Message-ID: <CAGngYiXCS-FwQkA7nzizXw_5417_u7VmPAXPbZeDv4dUFs2cog@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] pwm: pca9685: Support staggered output ON times
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
> The PCA9685 supports staggered LED output ON times to minimize current
> surges and reduce EMI.
> When this new option is enabled, the ON times of each channel are
> delayed by channel number x counter range / 16, which avoids asserting
> all enabled outputs at the same counter value while still maintaining
> the configured duty cycle of each output.
>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 62 +++++++++++++++++++++++++++++++--------
>  1 file changed, 50 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 38aadaf50996..ff916980de49 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -79,6 +79,7 @@
>  struct pca9685 {
>         struct pwm_chip chip;
>         struct regmap *regmap;
> +       bool staggered_outputs;
>  #if IS_ENABLED(CONFIG_GPIOLIB)
>         struct mutex lock;
>         struct gpio_chip gpio;
> @@ -93,45 +94,79 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
>
>  static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
>  {
> +       unsigned int on, off;
> +
>         if (duty == 0) {
>                 /* Set the full OFF bit, which has the highest precedence */
>                 regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
> +               return;
>         } else if (duty >= PCA9685_COUNTER_RANGE) {
>                 /* Set the full ON bit and clear the full OFF bit */
>                 regmap_write(pca->regmap, REG_ON_H(channel), LED_FULL);
>                 regmap_write(pca->regmap, REG_OFF_H(channel), 0);
> -       } else {
> -               /* Set OFF time (clears the full OFF bit) */
> -               regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
> -               regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
> -               /* Clear the full ON bit */
> -               regmap_write(pca->regmap, REG_ON_H(channel), 0);
> +               return;
> +       }
> +
> +       if (pca->staggered_outputs) {
> +               if (channel < PCA9685_MAXCHAN) {
> +                       /*
> +                        * To reduce EMI, the ON times of each channel are
> +                        * spread out evenly within the counter range, while
> +                        * still maintaining the configured duty cycle
> +                        */
> +                       on = channel * PCA9685_COUNTER_RANGE / PCA9685_MAXCHAN;
> +                       off = (on + duty) % PCA9685_COUNTER_RANGE;
> +                       regmap_write(pca->regmap, REG_ON_L(channel), on & 0xff);
> +                       regmap_write(pca->regmap, REG_ON_H(channel), (on >> 8) & 0xf);
> +                       regmap_write(pca->regmap, REG_OFF_L(channel), off & 0xff);
> +                       regmap_write(pca->regmap, REG_OFF_H(channel), (off >> 8) & 0xf);
> +                       return;
> +               }
> +               /* No staggering possible if "all LEDs" channel is used */
> +               regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
>         }
> +       /* Set OFF time (clears the full OFF bit) */
> +       regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
> +       regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
> +       /* Clear the full ON bit */
> +       regmap_write(pca->regmap, REG_ON_H(channel), 0);
>  }

I find the set_duty() function quite hard to follow.
Can we simplify this by eliminating the !staggered_outputs special case?
E.g. always calculate and write 'on' and 'off'.
But if !staggered_outputs => on = 0 and off = duty.

Yes this adds one extra/unnecessary register write in the !staggered case,
but simplicity/maintainability >>> efficiency here. And this "issue" will
disappear when we switch on regmap caching.

>
>  static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
>  {
> -       unsigned int off_h, val;
> +       unsigned int off, on, val;
>
>         if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
>                 /* Hardware readout not supported for "all LEDs" channel */
>                 return 0;
>         }
>
> -       regmap_read(pca->regmap, LED_N_OFF_H(channel), &off_h);
> -       if (off_h & LED_FULL) {
> +       regmap_read(pca->regmap, LED_N_OFF_H(channel), &off);
> +       if (off & LED_FULL) {
>                 /* Full OFF bit is set */
>                 return 0;
>         }
>
> -       regmap_read(pca->regmap, LED_N_ON_H(channel), &val);
> -       if (val & LED_FULL) {
> +       regmap_read(pca->regmap, LED_N_ON_H(channel), &on);
> +       if (on & LED_FULL) {
>                 /* Full ON bit is set */
>                 return PCA9685_COUNTER_RANGE;
>         }
>
>         regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> -       return ((off_h & 0xf) << 8) | (val & 0xff);
> +       off = ((off & 0xf) << 8) | (val & 0xff);
> +
> +       if (pca->staggered_outputs) {
> +               regmap_read(pca->regmap, LED_N_ON_L(channel), &val);
> +               on = ((on & 0xf) << 8) | (val & 0xff);
> +
> +               if (off >= on)
> +                       return off - on;
> +               else
> +                       return off + PCA9685_COUNTER_RANGE - on;

I think the if/else is unnecessary. unsigned int is twos-complement,
so we can just write:

        return (off - on) & 0xfff; (or PCA9685_COUNTER_RANGE - 1)

and it will "magically" work even if off < on.


> +       }
> +
> +       return off;
>  }

As in set_duty(), consider removing the !staggered_outputs special case,
to make this function clearer and simpler.

>
>  #if IS_ENABLED(CONFIG_GPIOLIB)
> @@ -442,6 +477,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>
>         regmap_write(pca->regmap, PCA9685_MODE2, reg);
>
> +       pca->staggered_outputs = device_property_read_bool(
> +               &client->dev, "nxp,staggered-outputs");
> +
>         /* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
>         regmap_read(pca->regmap, PCA9685_MODE1, &reg);
>         reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> --
> 2.29.2
>
