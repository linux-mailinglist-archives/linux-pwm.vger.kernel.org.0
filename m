Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723B62C37D0
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Nov 2020 05:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKYDvf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Nov 2020 22:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYDvf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Nov 2020 22:51:35 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ABDC0613D4;
        Tue, 24 Nov 2020 19:51:34 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id p12so307923uam.1;
        Tue, 24 Nov 2020 19:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uS51WQ1NTmDfltGGpsC+YpnUZyidpZ3ywNerFc5c8l4=;
        b=oS5QeUhMkPyWIrkOfy7q2mWqx9X1PRD/XVc5dmvIBzLHH/tJLaI3Yd9o5KROY0JgI1
         umeTFvC9ERHNRpy6fskkTK8c0oEnjl/iu8zB4mHPgWxYNlovOoD/IeMjRhO8Jf2tRRxY
         M8r3sph4FgB1yU0M8Y/95nu7VjzA9SHdKu76YQF6JdnDOV2wCuqyHaASEPD4bctNAg9h
         K0T1Fj8zapasTNFkKsVpPt9/31oX8OaBmf8KiVSdtZfmr6nimJeDYiHLxsv4XYRiUMjs
         UBjYgO3mttAYuqYFsFs8OkNpIlyWjtqEo7hT5PKgmUoSWv3GqfG6lDXxlDIY6IYhvABF
         yEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uS51WQ1NTmDfltGGpsC+YpnUZyidpZ3ywNerFc5c8l4=;
        b=EWCuwZhVOcPCukput6flU/iarmJsQ39vcvLZFq2TIHSMZ67kDPc/1MwwEd/DEJ0XNP
         pRYK6cE/3acFoHHo4vUAGV7pk7H1XjzqaKs985ZQnPFbPmZR2IkdOfagbWGaekf6k4B1
         gtWp4Bif0f0Ol91qQv8UPcnxZyB/xglxeadiB+GdcZDT6bfp9A/7y90+kKVmGzDdE++r
         qi2cP/KQrH4bec29Xi5W5j/STQE/s/GW7s3/dufXopkNEOgW4sEGns70FGoafRlsgnE/
         El1lzngAFtqoAmrnlpfes56YlGyZje9i4g91dnKTtxuqlT82k+6u7R9yqlUblUlHhHf1
         OmDA==
X-Gm-Message-State: AOAM533KPuTU4vLsdPNNpFPBgaGqceBdp82HnhcFO7QifaYbpWU8Xx4c
        4VRaGbC4IkuXCypd08f6wuDWxGZzdCfdUgbcicU=
X-Google-Smtp-Source: ABdhPJy8W3emCMDnxU1mDz/AaTKlXhVfA7P7ZlLhM+xtIsI8KQUhkJIe5NuHuGktvhVQiewWwylVdrWq5gAL+3AHZNM=
X-Received: by 2002:ab0:1d83:: with SMTP id l3mr973832uak.41.1606276294038;
 Tue, 24 Nov 2020 19:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20201124181013.162176-1-clemens.gruber@pqgruber.com> <20201124181013.162176-3-clemens.gruber@pqgruber.com>
In-Reply-To: <20201124181013.162176-3-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 24 Nov 2020 22:51:23 -0500
Message-ID: <CAGngYiXtabaC9j+D081be0+FEVae+jBCBDH=S59f1o-JOn+Gzg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] pwm: pca9685: Support staggered output ON times
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

On Tue, Nov 24, 2020 at 1:10 PM Clemens Gruber
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
>
> Changes since v1:
> - Rebased
>
>  drivers/pwm/pwm-pca9685.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 2b82b35ff0de..37c80bc8edcf 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -75,6 +75,7 @@ struct pca9685 {
>         struct pwm_chip chip;
>         struct regmap *regmap;
>         int prescale;
> +       bool staggered_outputs;
>  #if IS_ENABLED(CONFIG_GPIOLIB)
>         struct mutex lock;
>         struct gpio_chip gpio;
> @@ -329,7 +330,7 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  {
>         struct pca9685 *pca = to_pca(chip);
>         unsigned long long duty, prescale;
> -       unsigned int reg;
> +       unsigned int on, off, reg;
>
>         if (state->polarity != PWM_POLARITY_NORMAL)
>                 return -EOPNOTSUPP;
> @@ -375,6 +376,32 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>         duty = (PCA9685_COUNTER_RANGE - 1) * state->duty_cycle;
>         duty = DIV_ROUND_UP_ULL(duty, state->period);
>
> +       if (pca->staggered_outputs) {
> +               if (pwm->hwpwm < PCA9685_MAXCHAN) {
> +                       /*
> +                        * To reduce EMI, the ON times of each channel are
> +                        * spread out evenly within the counter range, while
> +                        * still maintaining the configured duty cycle
> +                        */
> +                       on = pwm->hwpwm * PCA9685_COUNTER_RANGE /
> +                               PCA9685_MAXCHAN;
> +                       off = (on + duty) % PCA9685_COUNTER_RANGE;

Will pwm_get_state() still return the correct duty cycle in case
of staggered outputs?

> +                       regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm),
> +                                    on & 0xff);
> +                       regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm),
> +                                    (on >> 8) & 0xf);
> +                       regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm),
> +                                    off & 0xff);
> +                       regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm),
> +                                    (off >> 8) & 0xf);
> +                       return 0;
> +               }
> +
> +               /* No staggering possible if "all LEDs" channel is used */
> +               regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> +               regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
> +       }
> +
>         if (pwm->hwpwm >= PCA9685_MAXCHAN)
>                 reg = PCA9685_ALL_LED_OFF_L;
>         else
> @@ -470,6 +497,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>
>         regmap_write(pca->regmap, PCA9685_MODE2, reg);
>
> +       pca->staggered_outputs = device_property_read_bool(
> +               &client->dev, "staggered-outputs");
> +
>         /* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
>         regmap_read(pca->regmap, PCA9685_MODE1, &reg);
>         reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> @@ -478,6 +508,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>         /* Reset OFF registers to HW default (only full OFF bit is set) */
>         regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
>         regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
> +       /* Reset ON registers to HW default */
> +       regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> +       regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
>
>         pca->chip.ops = &pca9685_pwm_ops;
>         /* Add an extra channel for ALL_LED */
> --
> 2.29.2
>
