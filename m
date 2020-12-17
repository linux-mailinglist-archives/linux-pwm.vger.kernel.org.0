Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21382DCB92
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Dec 2020 05:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgLQEBw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Dec 2020 23:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgLQEBv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2020 23:01:51 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB1C0617A7;
        Wed, 16 Dec 2020 20:01:11 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id y25so5226272uaq.7;
        Wed, 16 Dec 2020 20:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPoC6m5W8VLKxto4R9D3lag/KjqB9wfQE1fVcUOFbDQ=;
        b=Wz729HH2Z5VFq9FmqP2PgZlVCmWrdLir3bZuEHB8H7YapU9l8lUMW7lFoGENk5LEHi
         SytDY3Og/CLasQAdxZ4vQOFa5TkzoyTjapj4eARnEBYO4GM8vkWgNTp56g4mBevm85TP
         M34J/YHblpnqszTYs+YrUSDvmAPhc6U+DROCBrCqSsNRvVMDu5+WP9MFTJutCw/080mA
         A+yrlHiN7nbX2aZnkXmWACmtdvL5aM2X5xznfhPrXTAV3nK1kGGLmul+whAvOrXbmliQ
         8+rm9+3HyM1HZ5l4h7QuHPbkWRIbgSPd08QcsbvwMKWcVe0aUt4+sqzDtrliIv8hcCCQ
         EeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPoC6m5W8VLKxto4R9D3lag/KjqB9wfQE1fVcUOFbDQ=;
        b=MkXRAjgi0Ptxc7m4O0tkWW0b2eUFaS5dM4KsUAql3oIePBI5JXfg121NfnlHmV757b
         2tkPWn7MLAEvqR3iKopqiyGEoNyqRSGFm9IDPBJ2iEEPEkMciaKTsxn2VpCkcx0cLz/N
         c8z9G61Jz6NFElzzzMK8MBxAtB8Zg9wfKj6Vbo+PyyR3CTGXvo1DjFMvjaceVvm6PSQm
         FIA5hmvZSWP7Ps07wtO6BbAZbNF5ExoaOp0d3cqKqr1LbGHSNi/J3IeunL6edkgtsXnb
         atQkIAOjGgaoT7uVzIze0qYxyN1hxqWrbc/9fdKDBWZJm5wOVMgJzW2GvcfEi6gTzGSb
         yhig==
X-Gm-Message-State: AOAM531FSmRg9ZQsfvBZOIPwENt2tY4unWlTKybAQUxnL+qKHT75io2t
        P882t2FR3NvHMzEw5/05GJQ1FtI9xfpWS5R+Qfk=
X-Google-Smtp-Source: ABdhPJzFO7nlS4CIq6+th8AWrd1r506MJDBKoTKi3+BP2xsSiKOvQJG65QJBFSFQcLVkkceMNAuwk9X9EnpnUcKgQSA=
X-Received: by 2002:ab0:3806:: with SMTP id x6mr22038369uav.58.1608177670487;
 Wed, 16 Dec 2020 20:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com> <20201216125320.5277-2-clemens.gruber@pqgruber.com>
In-Reply-To: <20201216125320.5277-2-clemens.gruber@pqgruber.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 16 Dec 2020 23:00:59 -0500
Message-ID: <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Dec 16, 2020 at 7:53 AM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> Implements .get_state to read-out the current hardware state.
>

I am not convinced that we actually need this.

Looking at the pwm core, .get_state() is only called right after .request(),
to initialize the cached value of the state. The core then uses the cached
value throughout, it'll never read out the h/w again, until the next .request().

In our case, we know that the state right after request is always disabled,
because:
- we disable all pwm channels on probe (in PATCH v5 4/7)
- .free() disables the pwm channel

Conclusion: .get_state() will always return "pwm disabled", so why do we
bother reading out the h/w?

Of course, if we choose to leave the pwm enabled after .free(), then
.get_state() can even be left out! Do we want that? Genuine question, I do
not know the answer.

> The hardware readout may return slightly different values than those
> that were set in apply due to the limited range of possible prescale and
> counter register values.
>
> Also note that although the datasheet mentions 200 Hz as default
> frequency when using the internal 25 MHz oscillator, the calculated
> period from the default prescaler register setting of 30 is 5079040ns.
>
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 41 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 1b5b5fb93b43..b3398963c0ff 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -331,6 +331,46 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>         return 0;
>  }
>
> +static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> +                                 struct pwm_state *state)
> +{
> +       struct pca9685 *pca = to_pca(chip);
> +       unsigned long long duty;
> +       unsigned int val;
> +
> +       /* Calculate (chip-wide) period from prescale value */
> +       regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> +       state->period = (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
> +                       (val + 1);
> +
> +       /* The (per-channel) polarity is fixed */
> +       state->polarity = PWM_POLARITY_NORMAL;
> +
> +       if (pwm->hwpwm >= PCA9685_MAXCHAN) {
> +               /*
> +                * The "all LEDs" channel does not support HW readout
> +                * Return 0 and disabled for backwards compatibility
> +                */
> +               state->duty_cycle = 0;
> +               state->enabled = false;
> +               return;
> +       }
> +
> +       duty = pca9685_pwm_get_duty(pca, pwm->hwpwm);
> +
> +       state->enabled = !!duty;
> +       if (!state->enabled) {
> +               state->duty_cycle = 0;
> +               return;
> +       } else if (duty == PCA9685_COUNTER_RANGE) {
> +               state->duty_cycle = state->period;
> +               return;
> +       }
> +
> +       duty *= state->period;
> +       state->duty_cycle = duty / PCA9685_COUNTER_RANGE;
> +}
> +
>  static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>         struct pca9685 *pca = to_pca(chip);
> @@ -353,6 +393,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>
>  static const struct pwm_ops pca9685_pwm_ops = {
>         .apply = pca9685_pwm_apply,
> +       .get_state = pca9685_pwm_get_state,
>         .request = pca9685_pwm_request,
>         .free = pca9685_pwm_free,
>         .owner = THIS_MODULE,
> --
> 2.29.2
>
