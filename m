Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD44D2B88FD
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Nov 2020 01:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKSASS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 19:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgKSASS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Nov 2020 19:18:18 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F6C0613D4;
        Wed, 18 Nov 2020 16:18:16 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id y73so2074128vsc.5;
        Wed, 18 Nov 2020 16:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Y9gXZghoOUrVrn6RclX2UQm6Vhs++9lEGsZ/Vcac9c=;
        b=ZGA+7r0Y7+hiHeTdY+TH0qydKLtE0GeAYLi70W7N+tFZ/K/g5lR/i39zImLuu5l1zV
         9jrKaNDEVXxIiAeDyYT6dyziAFrlcbarEltlW+Ye3QxrNW9983PhKQoaCNWo0it0bJn8
         9MGkm5K/7Gn69LUK2iJ9ngGA/ea0w7sJearniBXy+kqKL8Rzt5sgSVirXLj7D34kuhrN
         T8R+3fbCh35OB3ulqEUeh/w3VudTuyEsDyFX3l++PIkkf4LN3AHVsL0SzFYk8chW4XcA
         mvPFux2f5H+QjF3twDdHlx3HqcTHE7lvaKdP0Lbsj5koHoFqWUcwbDQ5bpSkqP9DFeO0
         Al6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Y9gXZghoOUrVrn6RclX2UQm6Vhs++9lEGsZ/Vcac9c=;
        b=D6Us+93WuJw/cYfDc7H/pXqYOaPowxcs17zAdbdI0MrvhhSEUX7oizOufkJAxr/23B
         1q2mh7Qlf5F3LzFsEo6wHA29/XpxdSDKec9wt/squMx8MaNucjvuawdoQ20uBZHtrvO4
         KvvDiiIRQ5FfiRQEJuYMsjzvmdtazUd0viq2kwB7aJLCPwNYNC8SYnSpweOtJH7cXb5G
         kXeuAUqVV9qNHB+qxc83wd6vpyGEAJPSCFgh5qwYpD+CGBp7HfPtmI9M4UvtDBohKEy4
         mpkE/3RFz8jrSwMKMxTT17K/WD3QVFKOJTAmrE/QkBs4t3466FzTyqFA39G68gwSiO0s
         iGxg==
X-Gm-Message-State: AOAM530Nw+mvthyo5+5Yn6PzRef7rivqF/wyhxB9cljAGnUniGh2k2Y1
        lAVGFA6icsdfrpxbb0scdk8eJH6mFyE2zOsxHvI=
X-Google-Smtp-Source: ABdhPJw03GQ+5Yq1Ad09SuRnYgHdhT+3VGqA4NVRFcVTJy3avXV9Kt0XuAi1bnmtn1EgpT6m5TMOl13iVWo3Qa0uz4M=
X-Received: by 2002:a67:ff10:: with SMTP id v16mr6036457vsp.40.1605745095631;
 Wed, 18 Nov 2020 16:18:15 -0800 (PST)
MIME-Version: 1.0
References: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
In-Reply-To: <20201118174417.278011-1-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 18 Nov 2020 19:18:04 -0500
Message-ID: <CAGngYiV+oDeagaCfpeACMzQyDHVzk9ERbSBjW_fW5hoQANHqog@mail.gmail.com>
Subject: Re: [PATCH 1/3] pwm: pca9685: Switch to atomic API
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

Hi Clemens, thank you so much for this contribution.
I no longer have access to this chip, so I cannot test
the changes.

Some friendly/constructive feedback below.

On Wed, Nov 18, 2020 at 12:44 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> This switch to the atomic API goes hand in hand with a few fixes to
> previously experienced issues:
> - The duty cycle is no longer lost after disable/enable (previously the
>   OFF registers were cleared in disable and the user was required to
>   call config to restore the duty cycle settings)
> - The prescale register is now read out. If one sets a period resulting
>   in the same prescale register value, the sleep and write to the
>   register is skipped
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
>  drivers/pwm/pwm-pca9685.c | 233 ++++++++++++++++++++------------------
>  1 file changed, 124 insertions(+), 109 deletions(-)
>
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 4a55dc18656c..20f1314e6754 100644
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
> @@ -74,7 +73,7 @@
>  struct pca9685 {
>         struct pwm_chip chip;
>         struct regmap *regmap;
> -       int period_ns;
> +       int prescale;

You've decided to cache the prescale register...

>  #if IS_ENABLED(CONFIG_GPIOLIB)
>         struct mutex lock;
>         struct gpio_chip gpio;
> @@ -246,18 +245,117 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
>         }
>  }
>
> -static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -                             int duty_ns, int period_ns)
> +static void pca9685_pwm_full_off(struct pwm_chip *chip,
> +                                struct pwm_device *pwm)
> +{
> +       struct pca9685 *pca = to_pca(chip);
> +       int reg;
> +
> +       /*
> +        * Set the full OFF bit to cause the PWM channel to be always off.
> +        * The full OFF bit has precedence over the other register values.
> +        */
> +
> +       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> +               reg = PCA9685_ALL_LED_OFF_H;
> +       else
> +               reg = LED_N_OFF_H(pwm->hwpwm);
> +
> +       regmap_write(pca->regmap, reg, LED_FULL);
> +}
> +
> +static void pca9685_pwm_full_on(struct pwm_chip *chip,
> +                               struct pwm_device *pwm)
> +{
> +       struct pca9685 *pca = to_pca(chip);
> +       int reg;
> +
> +       /*
> +        * Clear the OFF registers (including the full OFF bit) and set
> +        * the full ON bit to cause the PWM channel to be always on.
> +        */
> +
> +       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> +               reg = PCA9685_ALL_LED_OFF_L;
> +       else
> +               reg = LED_N_OFF_L(pwm->hwpwm);
> +
> +       regmap_write(pca->regmap, reg, 0x0);
> +
> +       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> +               reg = PCA9685_ALL_LED_OFF_H;
> +       else
> +               reg = LED_N_OFF_H(pwm->hwpwm);
> +
> +       regmap_write(pca->regmap, reg, 0x0);
> +
> +       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> +               reg = PCA9685_ALL_LED_ON_H;
> +       else
> +               reg = LED_N_ON_H(pwm->hwpwm);
> +
> +       regmap_write(pca->regmap, reg, LED_FULL);
> +}
> +
> +static int pca9685_pwm_read_global_period(struct pca9685 *pca)

but in this function, you don't seem to use the cached prescale
value, but read it out again instead?

> +{
> +       unsigned int prescale = 0;
> +
> +       regmap_read(pca->regmap, PCA9685_PRESCALE, &prescale);
> +
> +       if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX)
> +               return 0;
> +
> +       return (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
> +               (prescale + 1);
> +}
> +
> +static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +                                 struct pwm_state *state)
> +{
> +       struct pca9685 *pca = to_pca(chip);
> +       unsigned int val, duty;
> +       int reg;
> +
> +       /* Read out (chip-wide) period */
> +       state->period = pca9685_pwm_read_global_period(pca);
> +
> +       /* The (per-channel) polarity is fixed */
> +       state->polarity = PWM_POLARITY_NORMAL;
> +
> +       /* Read out current duty cycle and enabled state */
> +       reg = pwm->hwpwm >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_H :
> +               LED_N_OFF_H(pwm->hwpwm);
> +       regmap_read(pca->regmap, reg, &val);
> +       duty = (val & 0xf) << 8;
> +
> +       state->enabled = !(val & LED_FULL);
> +
> +       reg = pwm->hwpwm >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L :
> +               LED_N_OFF_L(pwm->hwpwm);
> +       regmap_read(pca->regmap, reg, &val);
> +       duty |= (val & 0xff);
> +
> +       if (duty < PCA9685_COUNTER_RANGE) {
> +               duty *= state->period;
> +               state->duty_cycle = duty / (PCA9685_COUNTER_RANGE - 1);
> +       } else
> +               state->duty_cycle = 0;
> +}
> +
> +static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +                            const struct pwm_state *state)
>  {
>         struct pca9685 *pca = to_pca(chip);
> -       unsigned long long duty;
> +       unsigned long long duty, prescale;
>         unsigned int reg;
> -       int prescale;
>
> -       if (period_ns != pca->period_ns) {
> -               prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
> -                                            PCA9685_COUNTER_RANGE * 1000) - 1;
> +       if (state->polarity != PWM_POLARITY_NORMAL)
> +               return -EOPNOTSUPP;
>
> +       prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
> +                                        PCA9685_COUNTER_RANGE * 1000) - 1;
> +       if (prescale != pca->prescale) {

Use of cached prescale here, all good.

>                 if (prescale >= PCA9685_PRESCALE_MIN &&
>                         prescale <= PCA9685_PRESCALE_MAX) {
>                         /*
> @@ -270,12 +368,13 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>                         pca9685_set_sleep_mode(pca, true);
>
>                         /* Change the chip-wide output frequency */
> -                       regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
> +                       regmap_write(pca->regmap, PCA9685_PRESCALE,
> +                                    (int)prescale);
>
>                         /* Wake the chip up */
>                         pca9685_set_sleep_mode(pca, false);
>
> -                       pca->period_ns = period_ns;
> +                       pca->prescale = (int)prescale;
>                 } else {
>                         dev_err(chip->dev,
>                                 "prescaler not set: period out of bounds!\n");
> @@ -283,46 +382,18 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>                 }
>         }
>
> -       if (duty_ns < 1) {
> -               if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -                       reg = PCA9685_ALL_LED_OFF_H;
> -               else
> -                       reg = LED_N_OFF_H(pwm->hwpwm);
> -
> -               regmap_write(pca->regmap, reg, LED_FULL);
> -
> +       if (!state->enabled || state->duty_cycle < 1) {
> +               pca9685_pwm_full_off(chip, pwm);
>                 return 0;
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
> -
> +       if (state->duty_cycle == state->period) {
> +               pca9685_pwm_full_on(chip, pwm);
>                 return 0;
>         }
>
> -       duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
> -       duty = DIV_ROUND_UP_ULL(duty, period_ns);
> +       duty = (PCA9685_COUNTER_RANGE - 1) * state->duty_cycle;
> +       duty = DIV_ROUND_UP_ULL(duty, state->period);
>
>         if (pwm->hwpwm >= PCA9685_MAXCHAN)
>                 reg = PCA9685_ALL_LED_OFF_L;
> @@ -349,64 +420,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>         return 0;
>  }
>
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
> -
> -       /*
> -        * Clear the full-off bit.
> -        * It has precedence over the others and must be off.
> -        */
> -       if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -               reg = PCA9685_ALL_LED_OFF_H;
> -       else
> -               reg = LED_N_OFF_H(pwm->hwpwm);
> -
> -       regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
> -
> -       return 0;
> -}
> -
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
> @@ -422,15 +435,14 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>         struct pca9685 *pca = to_pca(chip);
>
> -       pca9685_pwm_disable(chip, pwm);
> +       pca9685_pwm_full_off(chip, pwm);
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
> @@ -448,7 +460,7 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>  {
>         struct pca9685 *pca;
>         unsigned int reg;
> -       int ret;
> +       int prescale = 0, ret;
>
>         pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
>         if (!pca)
> @@ -461,10 +473,13 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>                         ret);
>                 return ret;
>         }
> -       pca->period_ns = PCA9685_DEFAULT_PERIOD;
>
>         i2c_set_clientdata(client, pca);
>
> +       regmap_read(pca->regmap, PCA9685_PRESCALE, &prescale);
> +       if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX)
> +               pca->prescale = prescale;

I'm not sure this will cache the prescale value correctly,
the logic seems inverted.

You appear to mix cached and uncached uses of prescale,
is there a need for this? If not, perhaps pick one and use
it consistently?

Perhaps you can define a is_prescale_valid() helper,
which is easier to read.
And it can be easily negated:
    if (!is_prescale_valid(prescale))
without getting confused between </>. <=/>=, and ||/&&.

Also, if the prescale register contains an invalid value
during probe(), e.g. 0x00 or 0x01, would it make sense
to explicitly overwrite it with a valid setting?

> +
>         regmap_read(pca->regmap, PCA9685_MODE2, &reg);
>
>         if (device_property_read_bool(&client->dev, "invert"))
> --
> 2.29.2
>
