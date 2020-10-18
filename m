Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2247291FBB
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Oct 2020 22:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgJRUNS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Oct 2020 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgJRUNS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Oct 2020 16:13:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92EBC061755;
        Sun, 18 Oct 2020 13:13:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so3909711pll.11;
        Sun, 18 Oct 2020 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiLTIFWZBdLPHI9PhMrRJ9NkcaJO2rf64KID/1y8Jq4=;
        b=fde92EDIsObRIuQ6dMVuPsAZJAM8IHZVlbubAro6fK9RG4G+9d5M3RzVjj1jXeLWnT
         01gNv3LUSZb+FEYm/4ge9xx+1Y1BM6Ec8n4fA0LjKyJ6t2s1PCaKV014NJJtmphIZ9zF
         XltJSB07ZBVu4yXg1oDDtWrccpoCeN70oUFfheQ/THSNeuYyohx9odsevJClK9PcUfT9
         IcGBzD0ntALg4ByThdeOv932AoOu1nVRMc81OVNlKz3FfQQR0MhEttGlu1eOvpfKMbUB
         I0q2mKNuAJMQo2u/w5bAN8h474Kih6uIJJtJJLfERAJfL7h2z0aG/iEhHaTKVWTymU0v
         RFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiLTIFWZBdLPHI9PhMrRJ9NkcaJO2rf64KID/1y8Jq4=;
        b=EMDcaRuFFeuW2iRhCamZVEnq5pxathPrYYhO1jBYYRoqDBCWbvVdSgiZuggkcpSY4k
         U5EEr8zZChPw6KYDCaeGZ3xwX7dTCrDkLTufRRZ9oy3Bouf2hTnSMOfjE6tlC/FcevGs
         NZV12LU/RvOmUt+P3P60hCskmEmUU3mxQ4k8WScWcJDwR99ptVNerwofe6GQpG4w+lIm
         o0KHbJ2EUe6wOgD+GUMgjusq7hCnqmhY1gmz+SxxnzOCrCP3AGE7WRFHQQWL+UqVeUjP
         Ut2yu9a9/g4341zfQX2rST/XZnAnuG7AdGdjsNqrLye5IJf7DXLBnYwBLfSTfnTLhm8W
         ulGw==
X-Gm-Message-State: AOAM53151UdsgYUXGzdCjq2DglY8Vl8GJ+ipdF2oS4WaNVO/LjlemtT+
        DsxAo8I64uQLYr5SnxliZNy4xWKw2VYjf5nY98k=
X-Google-Smtp-Source: ABdhPJx8fnfhCA+ESUnvRVW3CWZOAZBToPARtzSmbAQdW2rO8EA5SXLVMYJ777ifIGNSH0uGOEhsxV3OYTFKtjZDHhA=
X-Received: by 2002:a17:90a:be11:: with SMTP id a17mr13763307pjs.181.1603051996194;
 Sun, 18 Oct 2020 13:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201017052057.2698588-1-bjorn.andersson@linaro.org> <20201017052057.2698588-3-bjorn.andersson@linaro.org>
In-Reply-To: <20201017052057.2698588-3-bjorn.andersson@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 18 Oct 2020 23:12:59 +0300
Message-ID: <CAHp75VeVbK1Wx2BEPghtEbEghqDAF2jFFN9=ARLEw-rvTUZ3yw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Oct 17, 2020 at 8:41 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. It can operate on fixed parameters or based on a
> lookup-table, altering the duty cycle over time - which provides the
> means for e.g. hardware assisted transitions of LED brightness.

> +config LEDS_QCOM_LPG
> +       tristate "LED support for Qualcomm LPG"
> +       depends on LEDS_CLASS_MULTICOLOR
> +       depends on OF
> +       depends on SPMI


> +#include <linux/of.h>
> +#include <linux/of_device.h>

...

> +struct lpg {
> +       struct device *dev;
> +       struct regmap *map;

Can't you derive the former from the latter?

> +
> +       struct pwm_chip pwm;
> +
> +       const struct lpg_data *data;
> +
> +       u32 lut_base;
> +       u32 lut_size;
> +       unsigned long *lut_bitmap;
> +
> +       u32 triled_base;
> +       u32 triled_src;
> +
> +       struct lpg_channel *channels;
> +       unsigned int num_channels;
> +};

...

> +static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
> +                        size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> +{
> +       unsigned int idx;
> +       u8 val[2];

__be16 val;

> +       int i;
> +
> +       /* Hardware does not behave when LO_IDX == HI_IDX */
> +       if (len == 1)
> +               return -EINVAL;
> +
> +       idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
> +                                        0, len, 0);
> +       if (idx >= lpg->lut_size)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < len; i++) {
> +               val[0] = pattern[i].brightness & 0xff;
> +               val[1] = pattern[i].brightness >> 8;

cpu_to_be16();

> +
> +               regmap_bulk_write(lpg->map,
> +                                 lpg->lut_base + LPG_LUT_REG(idx + i), val, 2);
> +       }
> +
> +       bitmap_set(lpg->lut_bitmap, idx, len);
> +
> +       *lo_idx = idx;
> +       *hi_idx = idx + len - 1;
> +
> +       return 0;
> +}

...

> +static void lpg_calc_freq(struct lpg_channel *chan, unsigned int period_us)
> +{
> +       int             n, m, clk, div;
> +       int             best_m, best_div, best_clk;
> +       unsigned int    last_err, cur_err, min_err;
> +       unsigned int    tmp_p, period_n;
> +
> +       if (period_us == chan->period_us)
> +               return;
> +
> +       /* PWM Period / N */
> +       if (period_us < ((unsigned int)(-1) / NSEC_PER_USEC)) {

Please, replace all these -1 with castings to unsigned types with
corresponding limits, like
UINT_MAX here.

> +               period_n = (period_us * NSEC_PER_USEC) >> 6;
> +               n = 6;
> +       } else {
> +               period_n = (period_us >> 9) * NSEC_PER_USEC;
> +               n = 9;
> +       }

Why inconsistency in branches? Can you rather derive n and calculate
only once like

           period_n = (period_us >> n) * NSEC_PER_USEC;

?

> +       min_err = (unsigned int)(-1);
> +       last_err = (unsigned int)(-1);
> +       best_m = 0;
> +       best_clk = 0;
> +       best_div = 0;
> +       for (clk = 0; clk < NUM_PWM_CLK; clk++) {
> +               for (div = 0; div < NUM_PWM_PREDIV; div++) {
> +                       /* period_n = (PWM Period / N) */
> +                       /* tmp_p = (Pre-divide * Clock Period) * 2^m */
> +                       tmp_p = lpg_clk_table[div][clk];
> +                       for (m = 0; m <= NUM_EXP; m++) {
> +                               if (period_n > tmp_p)
> +                                       cur_err = period_n - tmp_p;
> +                               else
> +                                       cur_err = tmp_p - period_n;
> +
> +                               if (cur_err < min_err) {
> +                                       min_err = cur_err;
> +                                       best_m = m;
> +                                       best_clk = clk;
> +                                       best_div = div;
> +                               }
> +
> +                               if (m && cur_err > last_err)
> +                                       /* Break for bigger cur_err */
> +                                       break;
> +
> +                               last_err = cur_err;
> +                               tmp_p <<= 1;
> +                       }
> +               }
> +       }
> +
> +       /* Use higher resolution */
> +       if (best_m >= 3 && n == 6) {
> +               n += 3;
> +               best_m -= 3;
> +       }
> +
> +       chan->clk = best_clk;
> +       chan->pre_div = best_div;
> +       chan->pre_div_exp = best_m;
> +       chan->pwm_size = n;
> +
> +       chan->period_us = period_us;
> +}
> +
> +static void lpg_calc_duty(struct lpg_channel *chan, unsigned int duty_us)
> +{
> +       unsigned long max = (1 << chan->pwm_size) - 1;

BIT() ?

> +       unsigned long val;
> +
> +       /* Figure out pwm_value with overflow handling */

> +       if (duty_us < 1 << (sizeof(val) * 8 - chan->pwm_size))

BITS_PER_TYPE, but actually BITS_PER_LONG here.

BIT(BITS_PER_LONG - ...)

> +               val = (duty_us << chan->pwm_size) / chan->period_us;
> +       else
> +               val = duty_us / (chan->period_us >> chan->pwm_size);
> +
> +       if (val > max)
> +               val = max;
> +
> +       chan->pwm_value = val;
> +}

...

> +static void lpg_enable_glitch(struct lpg_channel *chan)
> +{
> +       struct lpg *lpg = chan->lpg;
> +
> +       regmap_update_bits(lpg->map, chan->base + PWM_TYPE_CONFIG_REG,
> +                          LPG_ENABLE_GLITCH_REMOVAL, 0);
> +}

Here and everywhere else when function declared as void there is no
possibility to know if we do something useful or already screwed up
the things.

> +static void lpg_apply_pwm_value(struct lpg_channel *chan)
> +{
> +       u8 val[] = { chan->pwm_value & 0xff, chan->pwm_value >> 8 };


__le16 and cpu_to_le16()

> +       struct lpg *lpg = chan->lpg;
> +
> +       if (!chan->enabled)
> +               return;
> +
> +       regmap_bulk_write(lpg->map, chan->base + PWM_VALUE_REG, val, 2);
> +}

> +#define LPG_PATTERN_CONFIG_LO_TO_HI    BIT(4)
> +#define LPG_PATTERN_CONFIG_REPEAT      BIT(3)
> +#define LPG_PATTERN_CONFIG_TOGGLE      BIT(2)
> +#define LPG_PATTERN_CONFIG_PAUSE_HI    BIT(1)
> +#define LPG_PATTERN_CONFIG_PAUSE_LO    BIT(0)

Did I miss bits.h inclusion at the beginning of the file?

...

> +static int lpg_blink_set(struct lpg_led *led,
> +                        unsigned long delay_on, unsigned long delay_off)
> +{
> +       struct lpg_channel *chan;
> +       unsigned int period_us;
> +       unsigned int duty_us;
> +       int i;
> +
> +       if (!delay_on && !delay_off) {
> +               delay_on = 500;
> +               delay_off = 500;
> +       }

Homegrown duty cycle?
I mean, why simply not to pass the duty cycle in percentage in the first place?

> +       duty_us = delay_on * USEC_PER_MSEC;
> +       period_us = (delay_on + delay_off) * USEC_PER_MSEC;
> +
> +       for (i = 0; i < led->num_channels; i++) {
> +               chan = led->channels[i];
> +
> +               lpg_calc_freq(chan, period_us);
> +               lpg_calc_duty(chan, duty_us);
> +
> +               chan->enabled = true;
> +               chan->ramp_enabled = false;
> +
> +               lpg_apply(chan);
> +       }
> +
> +       return 0;
> +}

> +#define interpolate(x1, y1, x2, y2, x) \
> +       ((y1) + ((y2) - (y1)) * ((x) - (x1)) / ((x2) - (x1)))

Can you rather create a generic one under lib/ or start include/linux/math.h ?

https://elixir.bootlin.com/linux/latest/A/ident/interpolate

...

> +out:

Useless label.

> +       return ret;

...

> +       ret = of_property_read_u32(np, "color", &color);
> +       if (ret < 0 && ret != -EINVAL)

This check is fishy. Either you have optional property or not, in the
latter case return any error code.

> +               return ret;
> +
> +       chan->color = color;

So, it may be -EINVAL?!

> +       ret = of_property_read_u32_array(np, "qcom,dtest", dtest, 2);
> +       if (ret < 0 && ret != -EINVAL) {
> +               dev_err(lpg->dev, "malformed qcom,dtest of %pOFn\n", np);
> +               return ret;
> +       } else if (!ret) {
> +               chan->dtest_line = dtest[0];
> +               chan->dtest_value = dtest[1];
> +       }

Ditto.

...

> +       ret = of_property_read_u32(np, "color", &color);
> +       if (ret < 0 && ret != -EINVAL)
> +               return ret;

Ditto.

...

> +       size = sizeof(*led) + num_channels * sizeof(struct lpg_channel *);

Use respective helpers from overflow.h.

> +       led = devm_kzalloc(lpg->dev, size, GFP_KERNEL);
> +       if (!led)
> +               return -ENOMEM;

...

> +static const struct of_device_id lpg_of_table[] = {
> +       { .compatible = "qcom,pm8916-pwm", .data = &pm8916_pwm_data },
> +       { .compatible = "qcom,pm8941-lpg", .data = &pm8941_lpg_data },
> +       { .compatible = "qcom,pm8994-lpg", .data = &pm8994_lpg_data },
> +       { .compatible = "qcom,pmi8994-lpg", .data = &pmi8994_lpg_data },
> +       { .compatible = "qcom,pmi8998-lpg", .data = &pmi8998_lpg_data },

> +       {},

No comma needed for terminator lines.

> +};

-- 
With Best Regards,
Andy Shevchenko
