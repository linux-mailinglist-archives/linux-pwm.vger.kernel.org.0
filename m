Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6396F3B23FA
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jun 2021 01:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFWXkQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Jun 2021 19:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWXkP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Jun 2021 19:40:15 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBCDC061574
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 16:37:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d5so3505925qtd.5
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WONgXOt259NVdTyfMZnx0dHjYeDk78pPL6ji8n09f9g=;
        b=H/3yDhsDG0M5JbRrZdKnRg4U+dXzUrxCjGHlP+Rk9bnPeY6z273qmGgIGcwF8TbD9O
         i9KTWIEv2QeMOYd029PBM4MDFd+qjYDJ+Di8aAWjPjW+8N588qZ95AE6nSfjEDmTOPJG
         u6VzPYYarW/z35DzsWykPXuyzFIuCZu7J+/sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WONgXOt259NVdTyfMZnx0dHjYeDk78pPL6ji8n09f9g=;
        b=DRozuyUNZ6ED793bTbl0/BjApBt+u6Ag6iPsOAXlXs8QWzYyW6vL2P1Niw5Dg8+qDb
         BPUmlXvXvsMfVMo170vCxWG87L6s9fGXs1CMSQdfzQQfnG9Tp324/QVDYyk5GPbkraRJ
         UihKObYpnebH3pZa8m5VITysIjRykoagX+11E/Hal9LkWe0MiDtan9Gh/2jNsUiOvDww
         fT0fJ//eg7D39P9Mn71KVKpRL/r8KLVtXrwVWP8BDyoI/X3lpIyLXPMLzfvUaUBNmT3M
         Bwyhm7nNfTPyUuIUWjEo+cByaXc2OSdq4y1HygNL3lP1oEPlm6hd0T9Pb894y1t7pAM/
         kPTw==
X-Gm-Message-State: AOAM532Sz2GATg7PA+1P74ihvjUiXkqba3yLzhKG9k/3OwamhxEyRFIH
        RrKZfSRRMtnktX/DJSvLPA6aX4G3yniAVg==
X-Google-Smtp-Source: ABdhPJxfV+CktbYWqtnu6ptopyEsIpUNZ6PEZWuXooi1G4lmA2jJ7C9whk71UF/3fAuhx2CWdnBNYQ==
X-Received: by 2002:ac8:40d3:: with SMTP id f19mr2271381qtm.355.1624491474353;
        Wed, 23 Jun 2021 16:37:54 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id y10sm1010468qtm.17.2021.06.23.16.37.53
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 16:37:53 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id g4so9821785qkl.1
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 16:37:53 -0700 (PDT)
X-Received: by 2002:a25:bcb:: with SMTP id 194mr949752ybl.32.1624491472679;
 Wed, 23 Jun 2021 16:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210623032755.1170809-1-bjorn.andersson@linaro.org> <20210623032755.1170809-2-bjorn.andersson@linaro.org>
In-Reply-To: <20210623032755.1170809-2-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 23 Jun 2021 16:37:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V+EbhabobCL9uU=W3vVXh=9mN+jW3FPKMLiftMAiTjhQ@mail.gmail.com>
Message-ID: <CAD=FV=V+EbhabobCL9uU=W3vVXh=9mN+jW3FPKMLiftMAiTjhQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Tue, Jun 22, 2021 at 8:28 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> +static int ti_sn65dsi86_read_u16(struct ti_sn65dsi86 *pdata,
> +                                unsigned int reg, u16 *val)
> +{
> +       unsigned int tmp;
> +       int ret;
> +
> +       ret = regmap_read(pdata->regmap, reg, &tmp);
> +       if (ret)
> +               return ret;
> +       *val = tmp;
> +
> +       ret = regmap_read(pdata->regmap, reg + 1, &tmp);
> +       if (ret)
> +               return ret;
> +       *val |= tmp << 8;
> +
> +       return 0;
> +}
> +
>  static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
>                                    unsigned int reg, u16 val)

I suspect we might want to update this function to use
regmap_bulk_write(). I believe that will allow PWM updates to happen
in a single i2c transaction. I don't know whether the bridge chip
implements that, but conceivably it could use this information to
avoid discontinuities when updating the "high" and "low" parts of a
register. Even if the bridge chip doesn't do anything special, though,
it will reduce the amount of time that they are inconsistent because
it'll be a single transaction on the bus rather than two separate
ones.


>  {
> @@ -253,6 +297,14 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
>
>         regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
>                            REFCLK_FREQ(i));
> +
> +#if defined(CONFIG_PWM)
> +       /*
> +        * The PWM refclk is based on the value written to SN_DPPLL_SRC_REG,
> +        * regardless of its actual sourcing.
> +        */
> +       pdata->pwm_refclk_freq = ti_sn_bridge_refclk_lut[i];
> +#endif

I really dislike #ifdefs inline in functions. Personally I'd rather
you just always put the member in the structure regardless of
CONFIG_PWM and always set it.


> +/*
> + * Limitations:
> + * - The PWM signal is not driven when the chip is powered down, or in its
> + *   reset state and the driver does not implement the "suspend state"
> + *   described in the documentation. In order to save power, state->enabled is
> + *   interpreted as denoting if the signal is expected to be valid, and is used to keep
> + *   the determine if the chip needs to be kept powered.

"and is used to keep the determine" ? Something about that wording
doesn't make sense to me.

> + * - Changing both period and duty_cycle is not done atomically, so the output
> + *   might briefly be a mix of the two settings.

In fact there's nothing atomic about _any_ of the updates, right?
We're setting the high and low bytes in separate transactions so if
you were watching carefully you might see this if you bumped the PWM
up by 1:

0x03ff
0x04ff
0x0400

> + */
> +static int ti_sn_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +                          const struct pwm_state *state)
> +{
> +       struct ti_sn65dsi86 *pdata = pwm_chip_to_ti_sn_bridge(chip);
> +       unsigned int pwm_en_inv;
> +       unsigned int backlight;
> +       unsigned int pre_div;
> +       unsigned int scale;
> +       u64 period_max;
> +       u64 actual;
> +       u64 period;
> +       int ret;
> +
> +       if (!pdata->pwm_enabled) {
> +               ret = pm_runtime_get_sync(pdata->dev);
> +               if (ret < 0)
> +                       return ret;

You hit the classic pm_runtime trap! :-) You must always call put even
if get fails. I think a "goto out" would do it?


> +       }
> +
> +       if (state->enabled) {
> +               if (!pdata->pwm_enabled) {
> +                       /*
> +                        * The chip might have been powered down while we
> +                        * didn't hold a PM runtime reference, so mux in the
> +                        * PWM function on the GPIO pin again.
> +                        */
> +                       ret = regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
> +                                                SN_GPIO_MUX_MASK << (2 * SN_PWM_GPIO_IDX),
> +                                                SN_GPIO_MUX_SPECIAL << (2 * SN_PWM_GPIO_IDX));
> +                       if (ret) {
> +                               dev_err(pdata->dev, "failed to mux in PWM function\n");
> +                               goto out;
> +                       }
> +               }
> +
> +               /*
> +                * Per the datasheet the PWM frequency is given by:
> +                *
> +                *   PWM_FREQ = REFCLK_FREQ / (PWM_PRE_DIV * BACKLIGHT_SCALE + 1)
> +                *
> +                * which can be rewritten:
> +                *
> +                *   T_pwm * REFCLK_FREQ - 1 = PWM_PRE_DIV * BACKLIGHT_SCALE
> +                *
> +                * In order to keep BACKLIGHT_SCALE within its 16 bits,
> +                * PWM_PRE_DIV must be:
> +                *
> +                *   PWM_PRE_DIV >= (T_pwm * REFCLK_FREQ - 1) / BACKLIGHT_SCALE_MAX;
> +                *
> +                * To simplify the search and optimize the resolution of the
> +                * PWM, the lowest possible PWM_PRE_DIV is used. Finally the
> +                * scale is calculated as:
> +                *
> +                *   BACKLIGHT_SCALE = (T_pwm * REFCLK_FREQ - 1) / PWM_PRE_DIV
> +                *
> +                * Here T_pwm is represented in seconds, so appropriate scaling
> +                * to nanoseconds is necessary.
> +                */
> +
> +               /* Minimum T_pwm is (0 * 0 + 1) / REFCLK_FREQ */
> +               if (state->period <= NSEC_PER_SEC / pdata->pwm_refclk_freq) {
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +
> +               /*
> +                * Maximum T_pwm is (255 * 65535 + 1) / * REFCLK_FREQ
> +                * Limit period to this to avoid overflows
> +                */
> +               period_max = div_u64((u64)NSEC_PER_SEC * (255 * 65535 + 1), pdata->pwm_refclk_freq);
> +               if (period > period_max)
> +                       period = period_max;
> +               else
> +                       period = state->period;
> +
> +               pre_div = DIV64_U64_ROUND_UP((period * pdata->pwm_refclk_freq - NSEC_PER_SEC),
> +                                            ((u64)NSEC_PER_SEC * BACKLIGHT_SCALE_MAX));
> +               scale = div64_u64(period * pdata->pwm_refclk_freq - NSEC_PER_SEC,
> +                                 (u64)NSEC_PER_SEC * pre_div);
> +
> +               /*
> +                * The documentation has the duty ratio given as:
> +                *
> +                *     duty          BACKLIGHT
> +                *   ------- = ---------------------
> +                *    period    BACKLIGHT_SCALE + 1
> +                *
> +                * Solve for BACKLIGHT gives us:
> +                */
> +               actual = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (pre_div * scale + 1),
> +                                         pdata->pwm_refclk_freq);
> +               backlight = div64_u64(state->duty_cycle * (scale + 1), actual);
> +               if (backlight > scale)
> +                       backlight = scale;
> +
> +               ret = regmap_write(pdata->regmap, SN_PWM_PRE_DIV_REG, pre_div);
> +               if (ret) {
> +                       dev_err(pdata->dev, "failed to update PWM_PRE_DIV\n");
> +                       goto out;
> +               }
> +
> +               ti_sn65dsi86_write_u16(pdata, SN_BACKLIGHT_SCALE_REG, scale);
> +               ti_sn65dsi86_write_u16(pdata, SN_BACKLIGHT_REG, backlight);
> +       }
> +
> +       pwm_en_inv = FIELD_PREP(SN_PWM_EN_MASK, !!state->enabled) |

nit: no need for "!!". state->enabled is a boolean.


> +                    FIELD_PREP(SN_PWM_INV_MASK, state->polarity == PWM_POLARITY_INVERSED);
> +       ret = regmap_write(pdata->regmap, SN_PWM_EN_INV_REG, pwm_en_inv);
> +       if (ret) {
> +               dev_err(pdata->dev, "failed to update PWM_EN/PWM_INV\n");
> +               goto out;
> +       }
> +
> +       pdata->pwm_enabled = !!state->enabled;

nit: no need for "!!". state->enabled is a boolean.


> +out:
> +
> +       if (!pdata->pwm_enabled)
> +               pm_runtime_put_sync(pdata->dev);
> +
> +       return ret;
> +}

note: I didn't look at _any_ of your logic here. I figure that you and
Uwe already broke your brains on it. I'll try to take a quick peek
once you guys come to come agreement.

One note: in theory it ought to be not impossible to measure this even
if you're not an EE if you happen to have access to something like a
Salae Logic 16. The PWM ought to go out on the cable connecting to the
LCD on one of the pins and those pins tend to be easy enough to probe
that even a noob like myself can probe them. Of course it does mean
opening up your device...


> +static int ti_sn_bridge_gpio_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct ti_sn65dsi86 *pdata = gpiochip_get_data(chip);
> +
> +       if (offset == SN_PWM_GPIO_IDX)
> +               return ti_sn_pwm_pin_request(pdata);
> +
> +       return 0;
> +}
> +
> +
>  static void ti_sn_bridge_gpio_free(struct gpio_chip *chip, unsigned int offset)

nit: did you need two blank lines before this function?


> @@ -1500,6 +1829,12 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
>                         return ret;
>         }
>
> +       if (IS_ENABLED(CONFIG_PWM)) {
> +               ret = ti_sn65dsi86_add_aux_device(pdata, &pdata->pwm_aux, "pwm");
> +               if (ret)
> +                       return ret;
> +       }
> +

nit: also update the comment block above that says "Soon the PWM
provided by the bridge chip..."


-Doug
