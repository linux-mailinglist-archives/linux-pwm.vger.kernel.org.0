Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668113B24DC
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jun 2021 04:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFXCXM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Jun 2021 22:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFXCXM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Jun 2021 22:23:12 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C44DC061574
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 19:20:53 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id x196so5613717oif.10
        for <linux-pwm@vger.kernel.org>; Wed, 23 Jun 2021 19:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elO6w9RJ+ZJO/xt1Jl1xcIrqG/PEEh0s505CgHL6KNI=;
        b=IjF12AkVuHQhYJSPCi9sYcFeliJtEQYTwk5DV2g0wJlwOm71I6nacD3fZLdJ6kHZhx
         TBTfmgYq0wcwePrpASvb2ffISTOXzjrjVIyMBMCi1n72/MQSthtLRw4zVX+7/BOKGbBL
         wS5vuNttc51cXu3VYHKQ0jz0MEeZxauHkJRGss4+gUlxDWLBB/czLNrT5ynduhU2+RuN
         NawMNjZG/8uYp2FaoIk0U+A3wEhQTaes9jTtUmDbqigwO2l0zCZFoo8qS6rrneHae6BT
         DyNvcq7JBpIUs5wxCGtMfWy6DzLQnmmwIF5GguTUtWWiWJyAdGT/vwLSdU2qhW0Ge+bs
         3mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elO6w9RJ+ZJO/xt1Jl1xcIrqG/PEEh0s505CgHL6KNI=;
        b=gNWsO9goIZ3mWJVg29pb6cMzwKp4Hbd8K0nox/OFm5knoV0WCxjc5cldCapnAEXO+h
         IsNISHx4SPwN1l/ezaFU3myiykYfJOmrGgLgnWfw0wBuL5F1uk3JztLl4vmyDZvQiybc
         Vqcu4Z8OpohjKak6N01BnCOfYe1YWLB4SE9bGUjYn2GLy1gw5yQRo61MYGRvMU741ckY
         /mqukqrEC5nsHpjQfFt2HOMamoivzv/0PJRnho+XPahj/2O0Fmtfk1ZmxszGepEnucMX
         mtVYtwz6aaSQv0f7KjdeBozWyD5m4SqJKrqEXlcW2BIAnMbcq5uz78zI/Y3AUL0dfaaD
         1w3A==
X-Gm-Message-State: AOAM532xacEZLogDNtYE0JkZKVgY9/JH1zd13QNhEIUfiDXpcTX9RwP3
        6Y/bYEYNMeiglMq+R6ZyjlC2ew==
X-Google-Smtp-Source: ABdhPJxUW/QlvoF7ZZ5FkHKrb+X0J8yhgN0yOXXlJidA/dCMGuy8bcyYOTImxrVDgJgVCaG0lzKc3Q==
X-Received: by 2002:aca:b609:: with SMTP id g9mr2219355oif.145.1624501252587;
        Wed, 23 Jun 2021 19:20:52 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f2sm332161ooj.22.2021.06.23.19.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:20:52 -0700 (PDT)
Date:   Wed, 23 Jun 2021 21:20:49 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
Message-ID: <YNPsATzGIr+DFewv@yoga>
References: <20210623032755.1170809-1-bjorn.andersson@linaro.org>
 <20210623032755.1170809-2-bjorn.andersson@linaro.org>
 <CAD=FV=V+EbhabobCL9uU=W3vVXh=9mN+jW3FPKMLiftMAiTjhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=V+EbhabobCL9uU=W3vVXh=9mN+jW3FPKMLiftMAiTjhQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed 23 Jun 18:37 CDT 2021, Doug Anderson wrote:

> Hi,
> 
> On Tue, Jun 22, 2021 at 8:28 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > +static int ti_sn65dsi86_read_u16(struct ti_sn65dsi86 *pdata,
> > +                                unsigned int reg, u16 *val)
> > +{
> > +       unsigned int tmp;
> > +       int ret;
> > +
> > +       ret = regmap_read(pdata->regmap, reg, &tmp);
> > +       if (ret)
> > +               return ret;
> > +       *val = tmp;
> > +
> > +       ret = regmap_read(pdata->regmap, reg + 1, &tmp);
> > +       if (ret)
> > +               return ret;
> > +       *val |= tmp << 8;
> > +
> > +       return 0;
> > +}
> > +
> >  static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
> >                                    unsigned int reg, u16 val)
> 
> I suspect we might want to update this function to use
> regmap_bulk_write(). I believe that will allow PWM updates to happen
> in a single i2c transaction. I don't know whether the bridge chip
> implements that, but conceivably it could use this information to
> avoid discontinuities when updating the "high" and "low" parts of a
> register. Even if the bridge chip doesn't do anything special, though,
> it will reduce the amount of time that they are inconsistent because
> it'll be a single transaction on the bus rather than two separate
> ones.
> 

You bulk_write in ti_sn_aux_transfer() so I don't see why it wouldn't
work here, I'll update this - even though I don't know if it will
actually result in the two bytes being updated "atomically".

> 
> >  {
> > @@ -253,6 +297,14 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
> >
> >         regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
> >                            REFCLK_FREQ(i));
> > +
> > +#if defined(CONFIG_PWM)
> > +       /*
> > +        * The PWM refclk is based on the value written to SN_DPPLL_SRC_REG,
> > +        * regardless of its actual sourcing.
> > +        */
> > +       pdata->pwm_refclk_freq = ti_sn_bridge_refclk_lut[i];
> > +#endif
> 
> I really dislike #ifdefs inline in functions. Personally I'd rather
> you just always put the member in the structure regardless of
> CONFIG_PWM and always set it.
> 

I'd be happy to do so.

> 
> > +/*
> > + * Limitations:
> > + * - The PWM signal is not driven when the chip is powered down, or in its
> > + *   reset state and the driver does not implement the "suspend state"
> > + *   described in the documentation. In order to save power, state->enabled is
> > + *   interpreted as denoting if the signal is expected to be valid, and is used to keep
> > + *   the determine if the chip needs to be kept powered.
> 
> "and is used to keep the determine" ? Something about that wording
> doesn't make sense to me.
> 

Let's subtract "keep the" from that sentence...

> > + * - Changing both period and duty_cycle is not done atomically, so the output
> > + *   might briefly be a mix of the two settings.
> 
> In fact there's nothing atomic about _any_ of the updates, right?
> We're setting the high and low bytes in separate transactions so if
> you were watching carefully you might see this if you bumped the PWM
> up by 1:
> 
> 0x03ff
> 0x04ff
> 0x0400
> 

I've tested this several times with

    for i in `seq 4095`; do echo $i > /sys/class/backlight/backlight/brightness; done

And I am not able to see that "transient", but let's improve the u16
write anyways.

> > + */
> > +static int ti_sn_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                          const struct pwm_state *state)
> > +{
> > +       struct ti_sn65dsi86 *pdata = pwm_chip_to_ti_sn_bridge(chip);
> > +       unsigned int pwm_en_inv;
> > +       unsigned int backlight;
> > +       unsigned int pre_div;
> > +       unsigned int scale;
> > +       u64 period_max;
> > +       u64 actual;
> > +       u64 period;
> > +       int ret;
> > +
> > +       if (!pdata->pwm_enabled) {
> > +               ret = pm_runtime_get_sync(pdata->dev);
> > +               if (ret < 0)
> > +                       return ret;
> 
> You hit the classic pm_runtime trap! :-) You must always call put even
> if get fails. I think a "goto out" would do it?
> 

Another one bits the dust...

Thanks for teaching me.

> 
> > +       }
> > +
> > +       if (state->enabled) {
> > +               if (!pdata->pwm_enabled) {
> > +                       /*
> > +                        * The chip might have been powered down while we
> > +                        * didn't hold a PM runtime reference, so mux in the
> > +                        * PWM function on the GPIO pin again.
> > +                        */
> > +                       ret = regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
> > +                                                SN_GPIO_MUX_MASK << (2 * SN_PWM_GPIO_IDX),
> > +                                                SN_GPIO_MUX_SPECIAL << (2 * SN_PWM_GPIO_IDX));
> > +                       if (ret) {
> > +                               dev_err(pdata->dev, "failed to mux in PWM function\n");
> > +                               goto out;
> > +                       }
> > +               }
> > +
> > +               /*
> > +                * Per the datasheet the PWM frequency is given by:
> > +                *
> > +                *   PWM_FREQ = REFCLK_FREQ / (PWM_PRE_DIV * BACKLIGHT_SCALE + 1)
> > +                *
> > +                * which can be rewritten:
> > +                *
> > +                *   T_pwm * REFCLK_FREQ - 1 = PWM_PRE_DIV * BACKLIGHT_SCALE
> > +                *
> > +                * In order to keep BACKLIGHT_SCALE within its 16 bits,
> > +                * PWM_PRE_DIV must be:
> > +                *
> > +                *   PWM_PRE_DIV >= (T_pwm * REFCLK_FREQ - 1) / BACKLIGHT_SCALE_MAX;
> > +                *
> > +                * To simplify the search and optimize the resolution of the
> > +                * PWM, the lowest possible PWM_PRE_DIV is used. Finally the
> > +                * scale is calculated as:
> > +                *
> > +                *   BACKLIGHT_SCALE = (T_pwm * REFCLK_FREQ - 1) / PWM_PRE_DIV
> > +                *
> > +                * Here T_pwm is represented in seconds, so appropriate scaling
> > +                * to nanoseconds is necessary.
> > +                */
> > +
> > +               /* Minimum T_pwm is (0 * 0 + 1) / REFCLK_FREQ */
> > +               if (state->period <= NSEC_PER_SEC / pdata->pwm_refclk_freq) {
> > +                       ret = -EINVAL;
> > +                       goto out;
> > +               }
> > +
> > +               /*
> > +                * Maximum T_pwm is (255 * 65535 + 1) / * REFCLK_FREQ
> > +                * Limit period to this to avoid overflows
> > +                */
> > +               period_max = div_u64((u64)NSEC_PER_SEC * (255 * 65535 + 1), pdata->pwm_refclk_freq);
> > +               if (period > period_max)
> > +                       period = period_max;
> > +               else
> > +                       period = state->period;
> > +
> > +               pre_div = DIV64_U64_ROUND_UP((period * pdata->pwm_refclk_freq - NSEC_PER_SEC),
> > +                                            ((u64)NSEC_PER_SEC * BACKLIGHT_SCALE_MAX));
> > +               scale = div64_u64(period * pdata->pwm_refclk_freq - NSEC_PER_SEC,
> > +                                 (u64)NSEC_PER_SEC * pre_div);
> > +
> > +               /*
> > +                * The documentation has the duty ratio given as:
> > +                *
> > +                *     duty          BACKLIGHT
> > +                *   ------- = ---------------------
> > +                *    period    BACKLIGHT_SCALE + 1
> > +                *
> > +                * Solve for BACKLIGHT gives us:
> > +                */
> > +               actual = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (pre_div * scale + 1),
> > +                                         pdata->pwm_refclk_freq);
> > +               backlight = div64_u64(state->duty_cycle * (scale + 1), actual);
> > +               if (backlight > scale)
> > +                       backlight = scale;
> > +
> > +               ret = regmap_write(pdata->regmap, SN_PWM_PRE_DIV_REG, pre_div);
> > +               if (ret) {
> > +                       dev_err(pdata->dev, "failed to update PWM_PRE_DIV\n");
> > +                       goto out;
> > +               }
> > +
> > +               ti_sn65dsi86_write_u16(pdata, SN_BACKLIGHT_SCALE_REG, scale);
> > +               ti_sn65dsi86_write_u16(pdata, SN_BACKLIGHT_REG, backlight);
> > +       }
> > +
> > +       pwm_en_inv = FIELD_PREP(SN_PWM_EN_MASK, !!state->enabled) |
> 
> nit: no need for "!!". state->enabled is a boolean.
> 

Ahh, you're right.

> 
> > +                    FIELD_PREP(SN_PWM_INV_MASK, state->polarity == PWM_POLARITY_INVERSED);
> > +       ret = regmap_write(pdata->regmap, SN_PWM_EN_INV_REG, pwm_en_inv);
> > +       if (ret) {
> > +               dev_err(pdata->dev, "failed to update PWM_EN/PWM_INV\n");
> > +               goto out;
> > +       }
> > +
> > +       pdata->pwm_enabled = !!state->enabled;
> 
> nit: no need for "!!". state->enabled is a boolean.
> 
> 
> > +out:
> > +
> > +       if (!pdata->pwm_enabled)
> > +               pm_runtime_put_sync(pdata->dev);
> > +
> > +       return ret;
> > +}
> 
> note: I didn't look at _any_ of your logic here. I figure that you and
> Uwe already broke your brains on it. I'll try to take a quick peek
> once you guys come to come agreement.
> 

I think we're approaching a conclusion, at which time I certainly
appreciate the additional review :)

> One note: in theory it ought to be not impossible to measure this even
> if you're not an EE if you happen to have access to something like a
> Salae Logic 16. The PWM ought to go out on the cable connecting to the
> LCD on one of the pins and those pins tend to be easy enough to probe
> that even a noob like myself can probe them. Of course it does mean
> opening up your device...
> 

If I had access to the signal I would have already thrown my
oscilloscope at it and answered the question. But I only have this chip
inside my production-Lenovo Yoga C630...

> 
> > +static int ti_sn_bridge_gpio_request(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       struct ti_sn65dsi86 *pdata = gpiochip_get_data(chip);
> > +
> > +       if (offset == SN_PWM_GPIO_IDX)
> > +               return ti_sn_pwm_pin_request(pdata);
> > +
> > +       return 0;
> > +}
> > +
> > +
> >  static void ti_sn_bridge_gpio_free(struct gpio_chip *chip, unsigned int offset)
> 
> nit: did you need two blank lines before this function?
> 

No.

> 
> > @@ -1500,6 +1829,12 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
> >                         return ret;
> >         }
> >
> > +       if (IS_ENABLED(CONFIG_PWM)) {
> > +               ret = ti_sn65dsi86_add_aux_device(pdata, &pdata->pwm_aux, "pwm");
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> 
> nit: also update the comment block above that says "Soon the PWM
> provided by the bridge chip..."
> 

Missed that one, thanks.

Regards,
Bjorn
