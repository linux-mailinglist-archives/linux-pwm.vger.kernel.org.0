Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E162D1E48
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 00:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLGXXC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Dec 2020 18:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLGXXB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Dec 2020 18:23:01 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4666BC061794;
        Mon,  7 Dec 2020 15:22:21 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id s42so1164946uad.11;
        Mon, 07 Dec 2020 15:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyulQIBa+FPhqdzmJpIIwOi39pozbfZA19qbByJE+wo=;
        b=QhOTXKAjIPu1NrWdlsbc4FWbrJDVwdNwkP9hwUn7bwoMDNM1KKPJklN7KApvz2fmSM
         7wXK2shvxPguoXdwobotf1Qt6hE3xiL/R9UaVfLAQLgvqWbKA6OzFKYEKKxO5B1mfLve
         kSLuZ4MW3JsSn/nhblA1GZJU/wra2PGhLvhkHTueMD9uHRVWRjBDAuXiGc7tMEiVt0wz
         4zTw2fziPuHZD5np39l0pEhXIFQMdmuu6cFEsoNCivcQLFnyHBAkizLgjdJ359b/4Gs3
         lF2CckP4Dmm/DZDrFpDy6ODx3Z6WoPSah4HI+073ltypzBEhtM9Gzvnstlp3bC7VxVX6
         lnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyulQIBa+FPhqdzmJpIIwOi39pozbfZA19qbByJE+wo=;
        b=TsYXQE1OpBaken+9WA5BKhygON/RCoXFWOUZJOQSW66VapZdyZzYGpPb6ckb584UpE
         rme38VMzskBy4JI89751APYLbRDIAKPf8axF4ikgmG3E5NteY/CzULfoXJrG7ld7+Vnx
         HohrK8RkBuAEWGQzSOK6pVI3tNJuIdJMUQWP0zNC2fMHVRToe4qUb4pzk/cd8noUn/Rk
         vIm00gcyYR5/vj1Nv4ffGZ4lmsXGR5XYpulwVWjwV3QXgDTL4yUQpZPmeELzlctDU3rw
         mgHXIEo96Ri6vPaTO5Y2x4ysky+0Q54rY90VnGP6EYSA4SpIELTh7M1c2c17wq1Uh6Or
         uPbg==
X-Gm-Message-State: AOAM533/2DZG+EE2C+A2c/pAB3XMwsI9oVQmHSGdZ6+3pRIYmdqS6XYg
        mM4QEr0t4QIbL4zIWjn4RSOgWM5f/8h/9gPL5OQ=
X-Google-Smtp-Source: ABdhPJx4q4QPIeaeIVRodupxnvDF7hwQiM/Mvym70FDSbnw+AgafEStN46WGBjEOzEzem2g7PbytPAEL7i79BwUQ8Ss=
X-Received: by 2002:a9f:2e0d:: with SMTP id t13mr4844642uaj.41.1607383339698;
 Mon, 07 Dec 2020 15:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
In-Reply-To: <20201207193629.493241-1-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 7 Dec 2020 18:22:08 -0500
Message-ID: <CAGngYiXcm0OD1giGS3tuQSAcRs24rq5w77D+FfaWDZHvj=LQRQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
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

On Mon, Dec 7, 2020 at 2:37 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> The switch to the atomic API goes hand in hand with a few fixes to
> previously experienced issues:
> - The duty cycle is no longer lost after disable/enable (previously the
>   OFF registers were cleared in disable and the user was required to
>   call config to restore the duty cycle settings)
> - If one sets a period resulting in the same prescale register value,
>   the sleep and write to the register is now skipped
> - The prescale register is now set to the default value in probe. On
>   systems without CONFIG_PM, the chip is woken up at probe time.
>
> The hardware readout may return slightly different values than those
> that were set in apply due to the limited range of possible prescale and
> counter register values. If one channel is reconfigured with new duty
> cycle and period, the others will keep the same relative duty cycle to
> period ratio as they had before, even though the per-chip / global
> frequency changed. (The PCA9685 has only one prescaler!)
>
> Note that although the datasheet mentions 200 Hz as default frequency
> when using the internal 25 MHz oscillator, the calculated period from
> the default prescaler register setting of 30 is 5079040ns.
>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
> Changes since v3:
> - Refactoring: Extracted common functions
> - Read prescale register value instead of caching it
> - Return all zeros and disabled for "all LEDs" channel state
> - Improved duty calculation / mapping to 0..4096
>
> Changes since v2:
> - Always set default prescale value in probe
> - Simplified probe code
> - Inlined functions with one callsite
>
> Changes since v1:
> - Fixed a logic error
> - Impoved PM runtime handling and fixed !CONFIG_PM
> - Write default prescale reg value if invalid in probe
> - Reuse full_off/_on functions throughout driver
> - Use cached prescale value whenever possible
>
>  drivers/pwm/pwm-pca9685.c | 335 ++++++++++++++++++++------------------
>  1 file changed, 175 insertions(+), 160 deletions(-)
>
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 4a55dc18656c..0425e0bcb81e 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -47,11 +47,11 @@
>  #define PCA9685_ALL_LED_OFF_H  0xFD
>  #define PCA9685_PRESCALE       0xFE
>
> +#define PCA9685_PRESCALE_DEF   0x1E    /* => default frequency of ~200 Hz */
>  #define PCA9685_PRESCALE_MIN   0x03    /* => max. frequency of 1526 Hz */
>  #define PCA9685_PRESCALE_MAX   0xFF    /* => min. frequency of 24 Hz */
>
>  #define PCA9685_COUNTER_RANGE  4096
> -#define PCA9685_DEFAULT_PERIOD 5000000 /* Default period_ns = 1/200 Hz */
>  #define PCA9685_OSC_CLOCK_MHZ  25      /* Internal oscillator with 25 MHz */
>
>  #define PCA9685_NUMREGS                0xFF
> @@ -74,7 +74,6 @@
>  struct pca9685 {
>         struct pwm_chip chip;
>         struct regmap *regmap;
> -       int period_ns;
>  #if IS_ENABLED(CONFIG_GPIOLIB)
>         struct mutex lock;
>         struct gpio_chip gpio;
> @@ -87,6 +86,81 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
>         return container_of(chip, struct pca9685, chip);
>  }
>
> +static void pca9685_pwm_set_full_off(struct pca9685 *pca, int index, bool enable)
> +{
> +       unsigned int val = enable ? LED_FULL : 0;
> +
> +       /* Note: The full OFF bit has the highest precedence */
> +
> +       if (index >= PCA9685_MAXCHAN) {
> +               regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, val);
> +               return;
> +       }
> +       regmap_update_bits(pca->regmap, LED_N_OFF_H(index), LED_FULL, val);
> +}
> +
> +static bool pca9685_pwm_is_full_off(struct pca9685 *pca, int index)
> +{
> +       unsigned int val = 0;
> +
> +       if (index >= PCA9685_MAXCHAN)
> +               return false;
> +
> +       regmap_read(pca->regmap, LED_N_OFF_H(index), &val);
> +       return val & LED_FULL;
> +}
> +
> +static void pca9685_pwm_set_full_on(struct pca9685 *pca, int index, bool enable)
> +{
> +       unsigned int val = enable ? LED_FULL : 0;
> +
> +       if (index >= PCA9685_MAXCHAN) {
> +               regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, val);
> +               return;
> +       }
> +       regmap_update_bits(pca->regmap, LED_N_ON_H(index), LED_FULL, val);
> +}

If the "full off" bit is set, calling pwm_set_full_on(pca, index, true)
won't actually bring the led full on, correct ?

This can be very confusing. See below for a suggestion to make this clearer.

> +
> +static bool pca9685_pwm_is_full_on(struct pca9685 *pca, int index)
> +{
> +       unsigned int val = 0;
> +
> +       if (index >= PCA9685_MAXCHAN)
> +               return false;
> +
> +       regmap_read(pca->regmap, LED_N_ON_H(index), &val);
> +       return val & LED_FULL;
> +}
> +
> +static void pca9685_pwm_set_off_time(struct pca9685 *pca, int index, unsigned int off)
> +{
> +       int reg;
> +
> +       /* Note: This function also clears the full OFF bit */
> +
> +       reg = index >= PCA9685_MAXCHAN ?
> +               PCA9685_ALL_LED_OFF_L : LED_N_OFF_L(index);
> +       regmap_write(pca->regmap, reg, off & 0xff);
> +
> +       reg = index >= PCA9685_MAXCHAN ?
> +               PCA9685_ALL_LED_OFF_H : LED_N_OFF_H(index);
> +       regmap_write(pca->regmap, reg, (off >> 8) & 0xf);
> +}
> +
> +static unsigned int pca9685_pwm_off_time(struct pca9685 *pca, int index)
> +{
> +       unsigned int off, val = 0;
> +
> +       if (index >= PCA9685_MAXCHAN)
> +               return 0;
> +
> +       regmap_read(pca->regmap, LED_N_OFF_H(index), &val);
> +       off = (val & 0xf) << 8;
> +
> +       regmap_read(pca->regmap, LED_N_OFF_L(index), &val);
> +       return off | (val & 0xff);
> +}
> +
>  #if IS_ENABLED(CONFIG_GPIOLIB)
>  static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
>  {
> @@ -138,34 +212,31 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
>  static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
>  {
>         struct pca9685 *pca = gpiochip_get_data(gpio);
> -       struct pwm_device *pwm = &pca->chip.pwms[offset];
> -       unsigned int value;
> -
> -       regmap_read(pca->regmap, LED_N_ON_H(pwm->hwpwm), &value);
>
> -       return value & LED_FULL;
> +       return !pca9685_pwm_is_full_off(pca, offset);
>  }
>
>  static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
>                                  int value)
>  {
>         struct pca9685 *pca = gpiochip_get_data(gpio);
> -       struct pwm_device *pwm = &pca->chip.pwms[offset];
> -       unsigned int on = value ? LED_FULL : 0;
> -
> -       /* Clear both OFF registers */
> -       regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0);
> -       regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0);
>
> -       /* Set the full ON bit */
> -       regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), on);
> +       if (value) {
> +               pca9685_pwm_set_full_on(pca, offset, true);
> +               /* Clear full OFF bit last */
> +               pca9685_pwm_set_full_off(pca, offset, false);
> +       } else {
> +               /* Set full OFF bit first */
> +               pca9685_pwm_set_full_off(pca, offset, true);
> +               pca9685_pwm_set_full_on(pca, offset, false);
> +       }
>  }
>
>  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
>  {
>         struct pca9685 *pca = gpiochip_get_data(gpio);
>
> -       pca9685_pwm_gpio_set(gpio, offset, 0);
> +       pca9685_pwm_set_full_off(pca, offset, true);
>         pm_runtime_put(pca->chip.dev);
>         pca9685_pwm_clear_inuse(pca, offset);
>  }
> @@ -246,165 +317,98 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
>         }
>  }
>
> -static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -                             int duty_ns, int period_ns)
> +static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +                                 struct pwm_state *state)
>  {
>         struct pca9685 *pca = to_pca(chip);
>         unsigned long long duty;
> -       unsigned int reg;
> -       int prescale;
> -
> -       if (period_ns != pca->period_ns) {
> -               prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
> -                                            PCA9685_COUNTER_RANGE * 1000) - 1;
> -
> -               if (prescale >= PCA9685_PRESCALE_MIN &&
> -                       prescale <= PCA9685_PRESCALE_MAX) {
> -                       /*
> -                        * Putting the chip briefly into SLEEP mode
> -                        * at this point won't interfere with the
> -                        * pm_runtime framework, because the pm_runtime
> -                        * state is guaranteed active here.
> -                        */
> -                       /* Put chip into sleep mode */
> -                       pca9685_set_sleep_mode(pca, true);
> -
> -                       /* Change the chip-wide output frequency */
> -                       regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
> -
> -                       /* Wake the chip up */
> -                       pca9685_set_sleep_mode(pca, false);
> -
> -                       pca->period_ns = period_ns;
> -               } else {
> -                       dev_err(chip->dev,
> -                               "prescaler not set: period out of bounds!\n");
> -                       return -EINVAL;
> -               }
> -       }
> +       unsigned int val = 0;
>
> -       if (duty_ns < 1) {
> -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -                       reg = PCA9685_ALL_LED_OFF_H;
> -               else
> -                       reg = LED_N_OFF_H(pwm->hwpwm);
> +       /* Calculate (chip-wide) period from prescale value */
> +       regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> +       state->period = (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
> +                       (val + 1);
>
> -               regmap_write(pca->regmap, reg, LED_FULL);
> +       /* The (per-channel) polarity is fixed */
> +       state->polarity = PWM_POLARITY_NORMAL;
>
> -               return 0;
> +       if (pwm->hwpwm >= PCA9685_MAXCHAN) {
> +               /*
> +                * The "all LEDs" channel does not support HW readout
> +                * Return 0 and disabled for backwards compatibility
> +                */
> +               state->duty_cycle = 0;
> +               state->enabled = false;
> +               return;
>         }
>
> -       if (duty_ns == period_ns) {
> -               /* Clear both OFF registers */
> -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -                       reg = PCA9685_ALL_LED_OFF_L;
> -               else
> -                       reg = LED_N_OFF_L(pwm->hwpwm);
> -
> -               regmap_write(pca->regmap, reg, 0x0);
> -
> -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -                       reg = PCA9685_ALL_LED_OFF_H;
> -               else
> -                       reg = LED_N_OFF_H(pwm->hwpwm);
> -
> -               regmap_write(pca->regmap, reg, 0x0);
> -
> -               /* Set the full ON bit */
> -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -                       reg = PCA9685_ALL_LED_ON_H;
> -               else
> -                       reg = LED_N_ON_H(pwm->hwpwm);
> +       state->enabled = !pca9685_pwm_is_full_off(pca, pwm->hwpwm);
>
> -               regmap_write(pca->regmap, reg, LED_FULL);
> -
> -               return 0;
> +       if (state->enabled && pca9685_pwm_is_full_on(pca, pwm->hwpwm)) {
> +               state->duty_cycle = state->period;
> +               return;
>         }
>
> -       duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
> -       duty = DIV_ROUND_UP_ULL(duty, period_ns);
> -
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_OFF_L;
> -       else
> -               reg = LED_N_OFF_L(pwm->hwpwm);
> -
> -       regmap_write(pca->regmap, reg, (int)duty & 0xff);
> -
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_OFF_H;
> -       else
> -               reg = LED_N_OFF_H(pwm->hwpwm);
> -
> -       regmap_write(pca->regmap, reg, ((int)duty >> 8) & 0xf);
> -
> -       /* Clear the full ON bit, otherwise the set OFF time has no effect */
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_ON_H;
> -       else
> -               reg = LED_N_ON_H(pwm->hwpwm);
> -
> -       regmap_write(pca->regmap, reg, 0);
> -
> -       return 0;
> +       duty = pca9685_pwm_off_time(pca, pwm->hwpwm) * state->period;
> +       state->duty_cycle = duty / PCA9685_COUNTER_RANGE;
>  }
>
> -static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +                            const struct pwm_state *state)
>  {
>         struct pca9685 *pca = to_pca(chip);
> -       unsigned int reg;
> -
> -       /*
> -        * The PWM subsystem does not support a pre-delay.
> -        * So, set the ON-timeout to 0
> -        */
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_ON_L;
> -       else
> -               reg = LED_N_ON_L(pwm->hwpwm);
> +       unsigned long long duty, prescale;
> +       unsigned int val = 0;
>
> -       regmap_write(pca->regmap, reg, 0);
> +       if (state->polarity != PWM_POLARITY_NORMAL)
> +               return -EOPNOTSUPP;
>
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_ON_H;
> -       else
> -               reg = LED_N_ON_H(pwm->hwpwm);
> -
> -       regmap_write(pca->regmap, reg, 0);
> -
> -       /*
> -        * Clear the full-off bit.
> -        * It has precedence over the others and must be off.
> -        */
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_OFF_H;
> -       else
> -               reg = LED_N_OFF_H(pwm->hwpwm);
> +       prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
> +                                        PCA9685_COUNTER_RANGE * 1000) - 1;
> +       if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX) {
> +               dev_err(chip->dev, "prescaler not set: period out of bounds!\n");
> +               return -EINVAL;
> +       }
>
> -       regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
> +       regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> +       if (prescale != val) {
> +               /*
> +                * Putting the chip briefly into SLEEP mode
> +                * at this point won't interfere with the
> +                * pm_runtime framework, because the pm_runtime
> +                * state is guaranteed active here.
> +                */
> +               /* Put chip into sleep mode */
> +               pca9685_set_sleep_mode(pca, true);
>
> -       return 0;
> -}
> +               /* Change the chip-wide output frequency */
> +               regmap_write(pca->regmap, PCA9685_PRESCALE, (int)prescale);
>
> -static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -       struct pca9685 *pca = to_pca(chip);
> -       unsigned int reg;
> +               /* Wake the chip up */
> +               pca9685_set_sleep_mode(pca, false);
> +       }
>
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_OFF_H;
> -       else
> -               reg = LED_N_OFF_H(pwm->hwpwm);
> +       duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
> +       duty = DIV_ROUND_CLOSEST_ULL(duty, state->period);
>
> -       regmap_write(pca->regmap, reg, LED_FULL);
> +       if (!state->enabled || duty < 1) {
> +               /* Set full OFF bit first */
> +               pca9685_pwm_set_full_off(pca, pwm->hwpwm, true);
> +               pca9685_pwm_set_full_on(pca, pwm->hwpwm, false);
> +               return 0;
> +       }
>
> -       /* Clear the LED_OFF counter. */
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_OFF_L;
> -       else
> -               reg = LED_N_OFF_L(pwm->hwpwm);
> +       if (duty == PCA9685_COUNTER_RANGE) {
> +               pca9685_pwm_set_full_on(pca, pwm->hwpwm, true);
> +               /* Clear full OFF bit last */
> +               pca9685_pwm_set_full_off(pca, pwm->hwpwm, false);

I think "this bit first, this bit last" can be confusing and fragile.
It is also repeated in a few different places.
Suggestion on how to improve this, below.

> +               return 0;
> +       }
>
> -       regmap_write(pca->regmap, reg, 0x0);
> +       pca9685_pwm_set_off_time(pca, pwm->hwpwm, duty);
> +       /* Clear full ON bit after OFF time was set */
> +       pca9685_pwm_set_full_on(pca, pwm->hwpwm, false);
> +       return 0;
>  }

I think pwm_apply() is broken in the following scenario:

1. pwm_apply(enable=false)
2. pwm_apply(enable=true, duty_cycle=50%, period=200Hz)
3. result: pwm still full off (disabled)

and that is because pwm_apply() clears the "full off" bit only when the user
requests "full on".

I attribute this to the confusing nature of this chip. It's hard to keep the
chip's complete state fully in one's head.

One possible way to keep this manageable is by writing the functions in terms of
*led state* and not in terms of the *bits* it sets:

- set_full_on() should make the led go full on. So it sets "full on"
  and clears "full off" bits.
- set_full_off() should make the led go full off. So it sets the "full off" bit.
- set_duty() brings the led into duty mode. So it should clear "full off",
  clear "full on", and write the on/off times.

And actually, all that's needed is a single function, because duty == 0 means
"full off" and duty == 4095 means "full on".

Example in pseudo code:

static void pca9685_pwm_set_duty(struct pca9685 *pca, int index,
unsigned int duty)
{
    if (duty == 0) {
        /* full off takes precedence */
        regmap_write(full_off(index), ON);
    } else if (duty >= (COUNTER_RANGE - 1)) {
        regmap_write(full_on(index), ON);
        regmap_write(full_off(index), OFF);
    } else {
        regmap_write(off_time(index), duty);
        regmap_write(full_on(index), OFF);
        regmap_write(full_off(index), OFF);
    }
}

static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int index)
{
    if (WARN_ON(index >= PCA9685_MAXCHAN)) {
        /* register not readable, should never happen */
        return 0;
    }
    if (full_off(index) is ON)
        return 0;
    else if (full_on(index) is ON)
        return COUNTER_RANGE - 1;
    return off_time(index);
}

I suspect that once all on/off register accesses go through these two functions,
things will look simpler and there will be less risk of getting it wrong.

To prevent a forest of "index >= PCA9685_MAXCHAN" checks, I suggest creating
an helper function or macro, e.g.

static unsigned int led_off_h(int index)
{
    return (index >= PCA9685_MAXCHAN) ? PCA9685_ALL_LED_OFF_H :
LED_N_OFF_H(index);
}

then setting a register looks simple:
regmap_write(pca->regmap, led_off_h(index), LED_FULL);

>
>  static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -422,15 +426,14 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>         struct pca9685 *pca = to_pca(chip);
>
> -       pca9685_pwm_disable(chip, pwm);
> +       pca9685_pwm_set_full_off(pca, pwm->hwpwm, true);
>         pm_runtime_put(chip->dev);
>         pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
>  }
>
>  static const struct pwm_ops pca9685_pwm_ops = {
> -       .enable = pca9685_pwm_enable,
> -       .disable = pca9685_pwm_disable,
> -       .config = pca9685_pwm_config,
> +       .get_state = pca9685_pwm_get_state,
> +       .apply = pca9685_pwm_apply,
>         .request = pca9685_pwm_request,
>         .free = pca9685_pwm_free,
>         .owner = THIS_MODULE,
> @@ -461,7 +464,6 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>                         ret);
>                 return ret;
>         }
> -       pca->period_ns = PCA9685_DEFAULT_PERIOD;
>
>         i2c_set_clientdata(client, pca);
>
> @@ -505,14 +507,20 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>                 return ret;
>         }
>
> -       /* The chip comes out of power-up in the active state */
> -       pm_runtime_set_active(&client->dev);
>         /*
> -        * Enable will put the chip into suspend, which is what we
> -        * want as all outputs are disabled at this point
> +        * Always initialize with default prescale, but chip must be
> +        * in sleep mode while changing prescaler.
>          */
> +       pca9685_set_sleep_mode(pca, true);
> +       regmap_write(pca->regmap, PCA9685_PRESCALE, PCA9685_PRESCALE_DEF);
> +       pm_runtime_set_suspended(&client->dev);
>         pm_runtime_enable(&client->dev);
>
> +       if (!IS_ENABLED(CONFIG_PM)) {
> +               /* Wake the chip up on non-PM environments */
> +               pca9685_set_sleep_mode(pca, false);
> +       }
> +
>         return 0;
>  }
>
> @@ -524,7 +532,14 @@ static int pca9685_pwm_remove(struct i2c_client *client)
>         ret = pwmchip_remove(&pca->chip);
>         if (ret)
>                 return ret;
> +
>         pm_runtime_disable(&client->dev);
> +
> +       if (!IS_ENABLED(CONFIG_PM)) {
> +               /* Put chip in sleep state on non-PM environments */
> +               pca9685_set_sleep_mode(pca, true);
> +       }
> +
>         return 0;
>  }
>
> --
> 2.29.2
>
