Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9932DCB89
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 04:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgLQD67 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Dec 2020 22:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgLQD67 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2020 22:58:59 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22307C061794;
        Wed, 16 Dec 2020 19:58:19 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id 73so1206454uac.8;
        Wed, 16 Dec 2020 19:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxHl6uMDPBAYc3Mnlkf2KnVb1MtvvXydzM8BwcZZtBM=;
        b=hRW6+ix3bjtSBh+N1sx9jBCyr0aFo5QXpVF1tc0faAiVOnFVhtRkB6iQ9CdtE1uSKD
         7efFjNjqwBkVNEk6rUykPKSg25ol0VHg3hc6FyjAkocBW9BEz6Ie9S2JAwIjlDZ3YJhK
         um6/YtoEUTcW7z8vTSTQoEzSsgPc/zxsfzIClUdOKEBwErrWNoiE48i4CzdhwHSwOCUi
         T5NyIPV2F2HpOOCF7v+2tQIPCkvrULqVK9KCMzegyzWJcHD1/G1u4hXCEsBz7bbjPDxk
         GZuKMEDFz7UGgAb+NH2cA7t3gvD3tgQ3KBGlScya5NeO5FAcYpksTHMqlieKBTpXzq6v
         0+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxHl6uMDPBAYc3Mnlkf2KnVb1MtvvXydzM8BwcZZtBM=;
        b=NfnHl7t8+D16cnYO4bYWgygBaB5Z1S3GoW1162IdixTYsWvU1jWn1AC3si3DRXMkx3
         CKydRBWA0GhIxvImUHhSYlnGm4Q+EXbyzGNARrG0jKBMBc+7R6hnvAVrhZ8DuO9fJptT
         kAAbShxgKukGuHTeL8lBAtBzM8Uvb2h6z3IHGBimugIrsUViEyahP/3k5udtkn964cJx
         tsNNEhlu848RJRxtgtZqb1Ct6avBmKyHyCdboUKZ4A+mimD9C+r9kvH91+HYyaCFrTQ+
         /dFVybQrLG1/FcKGuEJzAN0zERdWkmUNKTvauePXZKyR35nUfdW59CYlxlyg5aG/7LH6
         atcQ==
X-Gm-Message-State: AOAM531h0PVQuhw39InIEYLmr+BKhh5pa+Ol7vMLZbocLTiiJvV0M90C
        qwz433/WiRAMD8NrA2DypEWq6BVdSWfYFziTVyY=
X-Google-Smtp-Source: ABdhPJwbOHVcnLp/DRQRbdkRBILzoWjxiHC9C47KhHG7l4rPUJpP4j0OaKXnAKosWL6K+KL4q7vR10MopKQwfwbxdUo=
X-Received: by 2002:ab0:2a1a:: with SMTP id o26mr35590638uar.101.1608177498133;
 Wed, 16 Dec 2020 19:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
In-Reply-To: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 16 Dec 2020 22:58:07 -0500
Message-ID: <CAGngYiWbQ2STTgh2OwJTqQ-niBDbbn+OdMkk7PMzYnrZWzSy9Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] pwm: pca9685: Switch to atomic API
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

Hi Clemens, this looks compact, simple and neat. I like it a lot !!

Few very minor nits below.

On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> The switch to the atomic API goes hand in hand with a few fixes to
> previously experienced issues:
> - The duty cycle is no longer lost after disable/enable (previously the
>   OFF registers were cleared in disable and the user was required to
>   call config to restore the duty cycle settings)
> - If one sets a period resulting in the same prescale register value,
>   the sleep and write to the register is now skipped
>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
> Changes since v4:
> - Patches split up
> - Use a single set_duty function
> - Improve readability / new macros
> - Added a patch to restrict prescale changes to the first user
>
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
>  drivers/pwm/pwm-pca9685.c | 253 +++++++++++++-------------------------
>  1 file changed, 87 insertions(+), 166 deletions(-)
>
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 4a55dc18656c..1b5b5fb93b43 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -51,7 +51,6 @@
>  #define PCA9685_PRESCALE_MAX   0xFF    /* => min. frequency of 24 Hz */
>
>  #define PCA9685_COUNTER_RANGE  4096
> -#define PCA9685_DEFAULT_PERIOD 5000000 /* Default period_ns = 1/200 Hz */
>  #define PCA9685_OSC_CLOCK_MHZ  25      /* Internal oscillator with 25 MHz */
>
>  #define PCA9685_NUMREGS                0xFF
> @@ -71,10 +70,14 @@
>  #define LED_N_OFF_H(N) (PCA9685_LEDX_OFF_H + (4 * (N)))
>  #define LED_N_OFF_L(N) (PCA9685_LEDX_OFF_L + (4 * (N)))
>
> +#define REG_ON_H(C)    ((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_H : LED_N_ON_H((C)))
> +#define REG_ON_L(C)    ((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_L : LED_N_ON_L((C)))
> +#define REG_OFF_H(C)   ((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_H : LED_N_OFF_H((C)))
> +#define REG_OFF_L(C)   ((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L : LED_N_OFF_L((C)))

Yes !!

> +
>  struct pca9685 {
>         struct pwm_chip chip;
>         struct regmap *regmap;
> -       int period_ns;
>  #if IS_ENABLED(CONFIG_GPIOLIB)
>         struct mutex lock;
>         struct gpio_chip gpio;
> @@ -87,6 +90,49 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
>         return container_of(chip, struct pca9685, chip);
>  }
>
> +static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
> +{

Add brief function documentation to clarify that 'duty' sets the duty cycle
_ratio_ to 'duty/4096' on ? I.e.
duty == 2048 => duty cycle ratio = 2048/4096 = 50%  on
duty == 4096 => duty cycle ratio = 4096/4086 = 100% on etc

> +       if (duty == 0) {
> +               /* Set the full OFF bit, which has the highest precedence */
> +               regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
> +       } else if (duty >= PCA9685_COUNTER_RANGE) {
> +               /* Set the full ON bit and clear the full OFF bit */
> +               regmap_write(pca->regmap, REG_ON_H(channel), LED_FULL);
> +               regmap_write(pca->regmap, REG_OFF_H(channel), 0);
> +       } else {
> +               /* Set OFF time (clears the full OFF bit) */
> +               regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
> +               regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
> +               /* Clear the full ON bit */
> +               regmap_write(pca->regmap, REG_ON_H(channel), 0);
> +       }
> +}
> +
> +static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
> +{
> +       unsigned int off_h, val;
> +
> +       if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
> +               /* Hardware readout not supported for "all LEDs" channel */
> +               return 0;
> +       }
> +
> +       regmap_read(pca->regmap, LED_N_OFF_H(channel), &off_h);
> +       if (off_h & LED_FULL) {

I believe this may trigger bots which are monitoring patches on LKML:
if regmap_read() somehow fails, off_h will be used uninitialized.

Prevent by initializing off_h and val?

> +               /* Full OFF bit is set */
> +               return 0;
> +       }
> +
> +       regmap_read(pca->regmap, LED_N_ON_H(channel), &val);
> +       if (val & LED_FULL) {
> +               /* Full ON bit is set */
> +               return PCA9685_COUNTER_RANGE;
> +       }
> +
> +       regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> +       return ((off_h & 0xf) << 8) | (val & 0xff);
> +}
> +
>  #if IS_ENABLED(CONFIG_GPIOLIB)
>  static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
>  {
> @@ -138,34 +184,23 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
>  static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
>  {
>         struct pca9685 *pca = gpiochip_get_data(gpio);
> -       struct pwm_device *pwm = &pca->chip.pwms[offset];
> -       unsigned int value;
>
> -       regmap_read(pca->regmap, LED_N_ON_H(pwm->hwpwm), &value);
> -
> -       return value & LED_FULL;
> +       return pca9685_pwm_get_duty(pca, offset) != 0;
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
> +       pca9685_pwm_set_duty(pca, offset, value ? PCA9685_COUNTER_RANGE : 0);
>  }
>
>  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
>  {
>         struct pca9685 *pca = gpiochip_get_data(gpio);
>
> -       pca9685_pwm_gpio_set(gpio, offset, 0);
> +       pca9685_pwm_set_duty(pca, offset, 0);
>         pm_runtime_put(pca->chip.dev);
>         pca9685_pwm_clear_inuse(pca, offset);
>  }
> @@ -246,167 +281,56 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
>         }
>  }
>
> -static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -                             int duty_ns, int period_ns)
> +static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +                            const struct pwm_state *state)
>  {
>         struct pca9685 *pca = to_pca(chip);
> -       unsigned long long duty;
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
> +       unsigned long long duty, prescale;
> +       unsigned int val = 0;
>
> -       if (duty_ns < 1) {
> -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -                       reg = PCA9685_ALL_LED_OFF_H;
> -               else
> -                       reg = LED_N_OFF_H(pwm->hwpwm);
> +       if (state->polarity != PWM_POLARITY_NORMAL)
> +               return -EOPNOTSUPP;
>
> -               regmap_write(pca->regmap, reg, LED_FULL);
> -
> -               return 0;
> +       prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
> +                                        PCA9685_COUNTER_RANGE * 1000) - 1;
> +       if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX) {
> +               dev_err(chip->dev, "prescaler not set: period out of bounds!\n");

would "pwm not changed: period out of bounds" be a clearer error message here?

> +               return -EINVAL;
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
> -
> -               regmap_write(pca->regmap, reg, LED_FULL);
> +       duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
> +       duty = DIV_ROUND_CLOSEST_ULL(duty, state->period);
>
> +       if (!state->enabled || duty < 1) {
> +               pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> +               return 0;
> +       } else if (duty == PCA9685_COUNTER_RANGE) {
> +               pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
>                 return 0;
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
> -}
> -
> -static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -       struct pca9685 *pca = to_pca(chip);
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
> -
> -       regmap_write(pca->regmap, reg, 0);
> -
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_ON_H;
> -       else
> -               reg = LED_N_ON_H(pwm->hwpwm);
> -
> -       regmap_write(pca->regmap, reg, 0);
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
> -       /*
> -        * Clear the full-off bit.
> -        * It has precedence over the others and must be off.
> -        */
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_OFF_H;
> -       else
> -               reg = LED_N_OFF_H(pwm->hwpwm);
> +               /* Change the chip-wide output frequency */
> +               regmap_write(pca->regmap, PCA9685_PRESCALE, (int)prescale);
>
> -       regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
> +               /* Wake the chip up */
> +               pca9685_set_sleep_mode(pca, false);
> +       }
>
> +       pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
>         return 0;
>  }
>
> -static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -       struct pca9685 *pca = to_pca(chip);
> -       unsigned int reg;
> -
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_OFF_H;
> -       else
> -               reg = LED_N_OFF_H(pwm->hwpwm);
> -
> -       regmap_write(pca->regmap, reg, LED_FULL);
> -
> -       /* Clear the LED_OFF counter. */
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_OFF_L;
> -       else
> -               reg = LED_N_OFF_L(pwm->hwpwm);
> -
> -       regmap_write(pca->regmap, reg, 0x0);
> -}
> -
>  static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>         struct pca9685 *pca = to_pca(chip);
> @@ -422,15 +346,13 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>         struct pca9685 *pca = to_pca(chip);
>
> -       pca9685_pwm_disable(chip, pwm);
> +       pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
>         pm_runtime_put(chip->dev);
>         pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
>  }
>
>  static const struct pwm_ops pca9685_pwm_ops = {
> -       .enable = pca9685_pwm_enable,
> -       .disable = pca9685_pwm_disable,
> -       .config = pca9685_pwm_config,
> +       .apply = pca9685_pwm_apply,
>         .request = pca9685_pwm_request,
>         .free = pca9685_pwm_free,
>         .owner = THIS_MODULE,
> @@ -461,7 +383,6 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>                         ret);
>                 return ret;
>         }
> -       pca->period_ns = PCA9685_DEFAULT_PERIOD;
>
>         i2c_set_clientdata(client, pca);
>
> --
> 2.29.2
>
