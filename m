Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF722C2B18
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Nov 2020 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbgKXPTs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Nov 2020 10:19:48 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:52390 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389434AbgKXPTs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 24 Nov 2020 10:19:48 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 0D44FC81EED;
        Tue, 24 Nov 2020 16:19:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1606231184;
        bh=Z5hEQgcqWKH3GQ4v5QKJlH9ei4XolCZLzG+jjlEV1ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+zxP0HPB29DYgoZTqCyqwWfKrQVW4RZRcuh6kk3hsMWBDU3D9h3w1aLveQBLYjmC
         3ZvBCsz05PtwVWKFH1WggMTQXmQ66rTGrk2rXuLL7xOlf6R6fGqxn08YnMCR73dH0+
         NOzdxAgkvdKLEknslHQ1QvvPWF2umDU2euFD4YaI=
Date:   Tue, 24 Nov 2020 16:19:42 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X70kjlZpIaN1T1ml@workstation.tuxnet>
References: <20201123163622.166048-1-clemens.gruber@pqgruber.com>
 <CAGngYiU8M0urUogQJf5-GS_rWmPa85TAVxdRD1EfkRK-EGQ7_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiU8M0urUogQJf5-GS_rWmPa85TAVxdRD1EfkRK-EGQ7_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 23, 2020 at 12:38:26PM -0500, Sven Van Asbroeck wrote:
> Hi Clemens, some cool changes, thank you !! Constructive feedback below.
> 
> On Mon, Nov 23, 2020 at 11:36 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > Changes since v1:
> > - Fixed a logic error
> > - Impoved PM runtime handling and fixed !CONFIG_PM
> > - Write default prescale reg value if invalid in probe
> > - Reuse full_off/_on functions throughout driver
> > - Use cached prescale value whenever possible
> >
> >  drivers/pwm/pwm-pca9685.c | 295 ++++++++++++++++++++------------------
> >  1 file changed, 159 insertions(+), 136 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 4a55dc18656c..47a69ee7951f 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -47,11 +47,11 @@
> >  #define PCA9685_ALL_LED_OFF_H  0xFD
> >  #define PCA9685_PRESCALE       0xFE
> >
> > +#define PCA9685_PRESCALE_DEF   0x1E    /* => default frequency of ~200 Hz */
> >  #define PCA9685_PRESCALE_MIN   0x03    /* => max. frequency of 1526 Hz */
> >  #define PCA9685_PRESCALE_MAX   0xFF    /* => min. frequency of 24 Hz */
> >
> >  #define PCA9685_COUNTER_RANGE  4096
> > -#define PCA9685_DEFAULT_PERIOD 5000000 /* Default period_ns = 1/200 Hz */
> >  #define PCA9685_OSC_CLOCK_MHZ  25      /* Internal oscillator with 25 MHz */
> >
> >  #define PCA9685_NUMREGS                0xFF
> > @@ -74,7 +74,7 @@
> >  struct pca9685 {
> >         struct pwm_chip chip;
> >         struct regmap *regmap;
> > -       int period_ns;
> > +       int prescale;
> >  #if IS_ENABLED(CONFIG_GPIOLIB)
> >         struct mutex lock;
> >         struct gpio_chip gpio;
> > @@ -87,6 +87,61 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
> >         return container_of(chip, struct pca9685, chip);
> >  }
> >
> > +static inline bool is_prescale_valid(int prescale)
> > +{
> > +       return prescale >= PCA9685_PRESCALE_MIN &&
> > +               prescale <= PCA9685_PRESCALE_MAX;
> > +}
> > +
> > +static void pca9685_pwm_full_off(struct pca9685 *pca, int index)
> > +{
> > +       int reg;
> > +
> > +       /*
> > +        * Set the full OFF bit to cause the PWM channel to be always off.
> > +        * The full OFF bit has precedence over the other register values.
> > +        */
> > +
> > +       if (index >= PCA9685_MAXCHAN)
> > +               reg = PCA9685_ALL_LED_OFF_H;
> > +       else
> > +               reg = LED_N_OFF_H(index);
> > +
> > +       regmap_write(pca->regmap, reg, LED_FULL);
> > +}
> > +
> > +static void pca9685_pwm_full_on(struct pca9685 *pca, int index)
> > +{
> > +       int reg;
> > +
> > +       /*
> > +        * Clear the OFF registers (including the full OFF bit) and set
> > +        * the full ON bit to cause the PWM channel to be always on.
> > +        */
> > +
> > +       if (index >= PCA9685_MAXCHAN)
> > +               reg = PCA9685_ALL_LED_OFF_L;
> > +       else
> > +               reg = LED_N_OFF_L(index);
> > +
> > +       regmap_write(pca->regmap, reg, 0);
> > +
> > +       if (index >= PCA9685_MAXCHAN)
> > +               reg = PCA9685_ALL_LED_OFF_H;
> > +       else
> > +               reg = LED_N_OFF_H(index);
> > +
> > +       regmap_write(pca->regmap, reg, 0);
> > +
> > +       if (index >= PCA9685_MAXCHAN)
> > +               reg = PCA9685_ALL_LED_ON_H;
> > +       else
> > +               reg = LED_N_ON_H(index);
> > +
> > +       regmap_write(pca->regmap, reg, LED_FULL);
> > +}
> > +
> > +
> >  #if IS_ENABLED(CONFIG_GPIOLIB)
> >  static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
> >  {
> > @@ -141,31 +196,27 @@ static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
> >         struct pwm_device *pwm = &pca->chip.pwms[offset];
> >         unsigned int value;
> >
> > -       regmap_read(pca->regmap, LED_N_ON_H(pwm->hwpwm), &value);
> > +       regmap_read(pca->regmap, LED_N_OFF_H(pwm->hwpwm), &value);
> >
> > -       return value & LED_FULL;
> > +       return !(value & LED_FULL);
> >  }
> >
> >  static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
> >                                  int value)
> >  {
> >         struct pca9685 *pca = gpiochip_get_data(gpio);
> > -       struct pwm_device *pwm = &pca->chip.pwms[offset];
> > -       unsigned int on = value ? LED_FULL : 0;
> > -
> > -       /* Clear both OFF registers */
> > -       regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0);
> > -       regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0);
> >
> > -       /* Set the full ON bit */
> > -       regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), on);
> > +       if (value)
> > +               pca9685_pwm_full_on(pca, offset);
> > +       else
> > +               pca9685_pwm_full_off(pca, offset);
> >  }
> >
> >  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
> >  {
> >         struct pca9685 *pca = gpiochip_get_data(gpio);
> >
> > -       pca9685_pwm_gpio_set(gpio, offset, 0);
> > +       pca9685_pwm_full_off(pca, offset);
> >         pm_runtime_put(pca->chip.dev);
> >         pca9685_pwm_clear_inuse(pca, offset);
> >  }
> > @@ -246,36 +297,75 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
> >         }
> >  }
> >
> > -static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > -                             int duty_ns, int period_ns)
> > +static void pca9685_set_prescale(struct pca9685 *pca, int prescale)
> > +{
> > +       /* Put chip into sleep mode */
> > +       pca9685_set_sleep_mode(pca, true);
> > +
> > +       /* Change the chip-wide output frequency */
> > +       regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
> > +
> > +       /* Wake the chip up */
> > +       pca9685_set_sleep_mode(pca, false);
> > +
> > +       pca->prescale = prescale;
> > +}
> 
> Refactoring this code as a "general purpose" function is very dangerous, IMHO.
> This code jumps over the runtime_pm's head to overwrite the sleep mode,
> and should be used only in very specific cases / places in the code, where this
> is guaranteed safe.
> 
> Leaving this as a function might give future contributors the idea that they
> can just call this anywhere.
> 
> Suggestion: for better maintainability, leave this code in pwm_apply, close to
> the comment that explains why it's safe to execute.

I see your point. I will undo the refactoring.

> 
> > +
> > +static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                                 struct pwm_state *state)
> > +{
> > +       struct pca9685 *pca = to_pca(chip);
> > +       unsigned int val, duty;
> > +       int reg;
> > +
> > +       /* Calculate (chip-wide) period from cached prescale value */
> > +       state->period = (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
> > +                       (pca->prescale + 1);
> > +
> > +       /* The (per-channel) polarity is fixed */
> > +       state->polarity = PWM_POLARITY_NORMAL;
> > +
> > +       /* Read out current duty cycle and enabled state */
> > +       reg = pwm->hwpwm >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_H :
> > +               LED_N_OFF_H(pwm->hwpwm);
> > +       regmap_read(pca->regmap, reg, &val);
> > +       duty = (val & 0xf) << 8;
> > +
> > +       state->enabled = !(val & LED_FULL);
> > +
> > +       reg = pwm->hwpwm >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L :
> > +               LED_N_OFF_L(pwm->hwpwm);
> > +       regmap_read(pca->regmap, reg, &val);
> > +       duty |= (val & 0xff);
> > +
> > +       if (duty < PCA9685_COUNTER_RANGE) {
> > +               duty *= state->period;
> > +               state->duty_cycle = duty / (PCA9685_COUNTER_RANGE - 1);
> > +       } else
> > +               state->duty_cycle = 0;
> > +}
> > +
> > +static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +                            const struct pwm_state *state)
> >  {
> >         struct pca9685 *pca = to_pca(chip);
> > -       unsigned long long duty;
> > +       unsigned long long duty, prescale;
> >         unsigned int reg;
> > -       int prescale;
> >
> > -       if (period_ns != pca->period_ns) {
> > -               prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
> > -                                            PCA9685_COUNTER_RANGE * 1000) - 1;
> > +       if (state->polarity != PWM_POLARITY_NORMAL)
> > +               return -EOPNOTSUPP;
> >
> > -               if (prescale >= PCA9685_PRESCALE_MIN &&
> > -                       prescale <= PCA9685_PRESCALE_MAX) {
> > +       prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
> > +                                        PCA9685_COUNTER_RANGE * 1000) - 1;
> > +       if (prescale != pca->prescale) {
> > +               if (is_prescale_valid(prescale)) {
> >                         /*
> >                          * Putting the chip briefly into SLEEP mode
> >                          * at this point won't interfere with the
> >                          * pm_runtime framework, because the pm_runtime
> >                          * state is guaranteed active here.
> >                          */
> > -                       /* Put chip into sleep mode */
> > -                       pca9685_set_sleep_mode(pca, true);
> > -
> > -                       /* Change the chip-wide output frequency */
> > -                       regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
> > -
> > -                       /* Wake the chip up */
> > -                       pca9685_set_sleep_mode(pca, false);
> > -
> > -                       pca->period_ns = period_ns;
> > +                       pca9685_set_prescale(pca, (int)prescale);
> >                 } else {
> >                         dev_err(chip->dev,
> >                                 "prescaler not set: period out of bounds!\n");
> > @@ -283,46 +373,18 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >                 }
> >         }
> >
> > -       if (duty_ns < 1) {
> > -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -                       reg = PCA9685_ALL_LED_OFF_H;
> > -               else
> > -                       reg = LED_N_OFF_H(pwm->hwpwm);
> > -
> > -               regmap_write(pca->regmap, reg, LED_FULL);
> > -
> > +       if (!state->enabled || state->duty_cycle < 1) {
> > +               pca9685_pwm_full_off(pca, pwm->hwpwm);
> >                 return 0;
> >         }
> >
> > -       if (duty_ns == period_ns) {
> > -               /* Clear both OFF registers */
> > -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -                       reg = PCA9685_ALL_LED_OFF_L;
> > -               else
> > -                       reg = LED_N_OFF_L(pwm->hwpwm);
> > -
> > -               regmap_write(pca->regmap, reg, 0x0);
> > -
> > -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -                       reg = PCA9685_ALL_LED_OFF_H;
> > -               else
> > -                       reg = LED_N_OFF_H(pwm->hwpwm);
> > -
> > -               regmap_write(pca->regmap, reg, 0x0);
> > -
> > -               /* Set the full ON bit */
> > -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -                       reg = PCA9685_ALL_LED_ON_H;
> > -               else
> > -                       reg = LED_N_ON_H(pwm->hwpwm);
> > -
> > -               regmap_write(pca->regmap, reg, LED_FULL);
> > -
> > +       if (state->duty_cycle == state->period) {
> > +               pca9685_pwm_full_on(pca, pwm->hwpwm);
> >                 return 0;
> >         }
> >
> > -       duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
> > -       duty = DIV_ROUND_UP_ULL(duty, period_ns);
> > +       duty = (PCA9685_COUNTER_RANGE - 1) * state->duty_cycle;
> > +       duty = DIV_ROUND_UP_ULL(duty, state->period);
> >
> >         if (pwm->hwpwm >= PCA9685_MAXCHAN)
> >                 reg = PCA9685_ALL_LED_OFF_L;
> > @@ -349,64 +411,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >         return 0;
> >  }
> >
> > -static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > -{
> > -       struct pca9685 *pca = to_pca(chip);
> > -       unsigned int reg;
> > -
> > -       /*
> > -        * The PWM subsystem does not support a pre-delay.
> > -        * So, set the ON-timeout to 0
> > -        */
> > -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -               reg = PCA9685_ALL_LED_ON_L;
> > -       else
> > -               reg = LED_N_ON_L(pwm->hwpwm);
> > -
> > -       regmap_write(pca->regmap, reg, 0);
> > -
> > -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -               reg = PCA9685_ALL_LED_ON_H;
> > -       else
> > -               reg = LED_N_ON_H(pwm->hwpwm);
> > -
> > -       regmap_write(pca->regmap, reg, 0);
> > -
> > -       /*
> > -        * Clear the full-off bit.
> > -        * It has precedence over the others and must be off.
> > -        */
> > -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -               reg = PCA9685_ALL_LED_OFF_H;
> > -       else
> > -               reg = LED_N_OFF_H(pwm->hwpwm);
> > -
> > -       regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
> > -
> > -       return 0;
> > -}
> > -
> > -static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > -{
> > -       struct pca9685 *pca = to_pca(chip);
> > -       unsigned int reg;
> > -
> > -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -               reg = PCA9685_ALL_LED_OFF_H;
> > -       else
> > -               reg = LED_N_OFF_H(pwm->hwpwm);
> > -
> > -       regmap_write(pca->regmap, reg, LED_FULL);
> > -
> > -       /* Clear the LED_OFF counter. */
> > -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -               reg = PCA9685_ALL_LED_OFF_L;
> > -       else
> > -               reg = LED_N_OFF_L(pwm->hwpwm);
> > -
> > -       regmap_write(pca->regmap, reg, 0x0);
> > -}
> > -
> >  static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> >  {
> >         struct pca9685 *pca = to_pca(chip);
> > @@ -422,15 +426,14 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> >  {
> >         struct pca9685 *pca = to_pca(chip);
> >
> > -       pca9685_pwm_disable(chip, pwm);
> > +       pca9685_pwm_full_off(pca, pwm->hwpwm);
> >         pm_runtime_put(chip->dev);
> >         pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
> >  }
> >
> >  static const struct pwm_ops pca9685_pwm_ops = {
> > -       .enable = pca9685_pwm_enable,
> > -       .disable = pca9685_pwm_disable,
> > -       .config = pca9685_pwm_config,
> > +       .get_state = pca9685_pwm_get_state,
> > +       .apply = pca9685_pwm_apply,
> >         .request = pca9685_pwm_request,
> >         .free = pca9685_pwm_free,
> >         .owner = THIS_MODULE,
> > @@ -448,7 +451,7 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >  {
> >         struct pca9685 *pca;
> >         unsigned int reg;
> > -       int ret;
> > +       int prescale = 0, ret;
> >
> >         pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
> >         if (!pca)
> > @@ -461,10 +464,17 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >                         ret);
> >                 return ret;
> >         }
> > -       pca->period_ns = PCA9685_DEFAULT_PERIOD;
> >
> >         i2c_set_clientdata(client, pca);
> >
> > +       regmap_read(pca->regmap, PCA9685_PRESCALE, &prescale);
> > +       if (is_prescale_valid(prescale))
> > +               pca->prescale = prescale;
> > +       else {
> > +               /* If invalid, use HW default prescale value */
> > +               pca9685_set_prescale(pca, PCA9685_PRESCALE_DEF);
> > +       }
> > +
> >         regmap_read(pca->regmap, PCA9685_MODE2, &reg);
> >
> >         if (device_property_read_bool(&client->dev, "invert"))
> > @@ -505,14 +515,20 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >                 return ret;
> >         }
> >
> > -       /* The chip comes out of power-up in the active state */
> > -       pm_runtime_set_active(&client->dev);
> > -       /*
> > -        * Enable will put the chip into suspend, which is what we
> > -        * want as all outputs are disabled at this point
> > -        */
> > +       /* Set runtime PM status according to chip sleep state */
> > +       if (reg & MODE1_SLEEP)
> > +               pm_runtime_set_suspended(&client->dev);
> > +       else
> > +               pm_runtime_set_active(&client->dev);
> > +
> > +       /* If active, enable puts chip into suspend until first use */
> >         pm_runtime_enable(&client->dev);
> >
> > +       if (!IS_ENABLED(CONFIG_PM)) {
> > +               /* Wake the chip up on non-PM environments */
> > +               pca9685_set_sleep_mode(pca, false);
> > +       }
> > +
> 
> IMHO this is quite complex probe code, with all kinds of subtle corner cases.
> 
> Normally in a probe() function, we want code that:
> - is simple && easy to understand
> - puts the chip in a known state (no corner cases due to leftover state)
> - if this takes a one or two extra reads/writes that's fine - clarity is more
>   important than efficiency in a probe() function, which executes maybe
>   once a day?
> 
> I feel that the pca9685 is a chip with lots of little "gotchas". Best to keep
> things as simple as possible?

Fair enough.

> 
> Suggestion:
> 
> probe()
> {
>     ...
> 
>     /* Always initialize with default prescale, but chip must be
>      * in sleep mode while changing prescaler.
>      */
>     pca9685_set_sleep_mode(pca, true);
>     pca->prescale = PCA9685_PRESCALE_DEF;
>     regmap_write(pca->regmap, PCA9685_PRESCALE, pca->prescale);
>     pm_runtime_set_suspended(&client->dev);
>     pm_runtime_enable(&client->dev);
> 
>     if (!IS_ENABLED(CONFIG_PM)) {
>         /* Wake the chip up on non-PM environments */
>         pca9685_set_sleep_mode(pca, false);
>     }
> 
>     return 0;
> }

Looks good to me.

Thanks for your review!

Clemens
