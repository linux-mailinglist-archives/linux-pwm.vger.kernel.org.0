Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9623B8768
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhF3RKr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 30 Jun 2021 13:10:47 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:44991 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhF3RKr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 13:10:47 -0400
Received: by mail-ua1-f54.google.com with SMTP id e7so1294695uaj.11;
        Wed, 30 Jun 2021 10:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BlLRBZUrK5kd6TP+hGlM+j82+IztuT3Be0/cnnqKIt8=;
        b=izEq2vp/3LvJdMG90Iuo00YYVGjIAVAsKgR8Lv6ww+39nxBvo0+04oVIyHd2dXP/9J
         hMEaXle7DdNFAUG5Xk6srGSCrY3KoEyn+ZyfE7+wnnCDua1TP+o3cTkkRZnU+w08wx+N
         QVbBvViXMR6QaD5UyVdb0EkFKJzhbKI/33rQ3GgLutHs9dbHKojqoS2XwZ4TMlVRmo8L
         d9YlWXJ2ndVa+1hA3biUUODi186DBfZjx/g2HV1JVhDn8odslpvAxjLOlXFvzRf76++q
         if/NC6vYjm8cY6Zcg1MUbpbvl8mnVhukrXtvLqYWV3XLZ0YGq/ZzBBk/eC2tO5iTfM8k
         FLvw==
X-Gm-Message-State: AOAM533SVwflMtxQT/Ww3zsnJr1uN14EyzOrR1etFbFEwsGzecH6VDFJ
        4Yw2s5IuQJM1nkHPrzwU4E3kLztzUfL2jbKnVaw=
X-Google-Smtp-Source: ABdhPJwLi7Df643q0DNXqGQPW+c2ZqiaEqnXcPUgLJ1OpVDUGkpu8XwDXb7fD22086sSUjh0fan9YdeV+sD09F7tY2M=
X-Received: by 2002:ab0:70b3:: with SMTP id q19mr34402745ual.2.1625072896719;
 Wed, 30 Jun 2021 10:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210411160451.1207799-1-u.kleine-koenig@pengutronix.de>
 <20210501160943.108821-1-u.kleine-koenig@pengutronix.de> <alpine.DEB.2.22.394.2106292138100.1194476@ramsan.of.borg>
 <20210630064826.4u2p37tlbriiwtsn@pengutronix.de> <CAMuHMdV0w8mxxLVT4abrD-FgqS9Kg4BLomDQbXS_csdMyqhypQ@mail.gmail.com>
 <20210630162128.ufmul6euxkwnou25@pengutronix.de>
In-Reply-To: <20210630162128.ufmul6euxkwnou25@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Jun 2021 19:08:05 +0200
Message-ID: <CAMuHMdVp2=+GSOGoF03=EY1a6MRgRKA7Ta-4jn7tjP3TFZMn4Q@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: Ensure for legacy drivers that pwm->state stays consistent
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, Jun 30, 2021 at 6:21 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Jun 30, 2021 at 12:22:22PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Jun 30, 2021 at 8:48 AM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Jun 29, 2021 at 09:44:38PM +0200, Geert Uytterhoeven wrote:
> > > > On Sat, 1 May 2021, Uwe Kleine-König wrote:
> > > > > Without this change it can happen that if changing the polarity succeeded
> > > > > but changing duty_cycle and period failed pwm->state contains a mixture
> > > > > between the old and the requested state.
> > > > >
> > > > > So remember the initial state before starting to modify the configuration
> > > > > and restore it when one of the required callback fails.
> > > > >
> > > > > Compared to the previous implementation .disable() (if necessary) is called
> > > > > earlier to prevent a glitch.
> > > > >
> > > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > >
> > > > Thanks for your patch, which is now commit d7bff84fe7ed8c3b ("pwm:
> > > > Ensure for legacy drivers that pwm->state stays consistent") in
> > > > pwm/for-next.
> > > >
> > > > This commit broke the backlight on the Atmark Techno Armadillo 800 EVA
> > > > board (arch/arm/boot/dts/r8a7740-armadillo800eva.dts), which now shows a
> > > > black screen.  Reverting the commit fixes the problem.
> > > >
> > > > Do you have an idea what is wrong, and how to fix it?
> > >
> > > I starred at the patch for some time now and couldn't find a problem.
> > > Looking at drivers/pwm/pwm-renesas-tpu.c I don't see something obvious.
> > > (The .set_polarity callback is faulty as I doesn't commit the request to
> > > hardware, but that shouldn't matter here.)
> > >
> > > I guess the first request the backlight driver emits is
> > >
> > >         .period = 33333,
> > >         .duty_cycle = 33333,
> > >         .enabled = true,
> > >         .polarity = PWM_POLARITY_INVERSED,
> > >
> > > which should result into the following driver calls (with and without
> > > the breaking commit):
> > >
> > >         tpu_pwm_set_polarity(chip, pwm, PWM_POLARITY_INVERSED);
> > >         tpu_pwm_config(chip, pwm, 33333, 33333);
> > >         tpu_pwm_enable(chip, pwm);
> > >
> > > Can you confirm that?
> >
> > tpu_pwm_config() is no longer called:
> >
> >      renesas-tpu-pwm e6600000.pwm: tpu_pwm_set_polarity:334: channel
> > 2, polarity = 1
> >     -renesas-tpu-pwm e6600000.pwm: tpu_pwm_config:257: channel = 2,
> > duty_ns = 0, period_ns = 33333
> >     -renesas-tpu-pwm e6600000.pwm: tpu_pwm_config:257: channel = 2,
> > duty_ns = 33333, period_ns = 33333
> >      renesas-tpu-pwm e6600000.pwm: tpu_pwm_enable:346: channel 2
>
> OK, I see a problem (though this doesn't explain the display staying
> off directly after boot):
>
> After doing:
>
>         pwm_apply_state(pwm, { .period = 33333, .duty_cycle = 0, .enabled = false, .polarity = ..});
>
> .period and .duty_cycle are assumed to be set even though calling
> ->config was skipped because .enabled is false.
>
> So when
>
>         pwm_apply_state(pwm, { .period = 33333, .duty_cycle = 0, .enabled = true, .polarity = ..});
>
> is called next, ->config isn't called because the core assumes
> .duty_cycle and .period are already setup fine.
>
> So we either must not skip calling ->config when .enabled is false:
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index ab38627bcacd..f8a5a095a410 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -558,12 +558,8 @@ static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
>                 pwm->state.polarity = state->polarity;
>         }
>
> -       if (!state->enabled) {
> -               if (pwm->state.enabled)
> -                       chip->ops->disable(chip, pwm);
> -
> -               return 0;
> -       }
> +       if (!state->enabled && pwm->state.enabled)
> +               chip->ops->disable(chip, pwm);
>
>         if (state->period != pwm->state.period ||
>             state->duty_cycle != pwm->state.duty_cycle) {
> @@ -577,7 +573,7 @@ static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
>                 pwm->state.duty_cycle = state->duty_cycle;
>         }
>
> -       if (!pwm->state.enabled) {
> +       if (state->enabled && !pwm->state.enabled) {
>                 err = chip->ops->enable(chip, pwm);
>                 if (err)
>                         goto rollback;

Works.

> or we have to call ->config unconditionally:
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index ab38627bcacd..05d7afe25b42 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -565,17 +565,21 @@ static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
>                 return 0;
>         }
>
> +       /*
> +        * We cannot skip this even if state->period == pwm->state.period &&
> +        * state->duty_cycle == pwm->state.duty_cycle because we might have
> +        * exited early in the last call to pwm_apply_state because of
> +        * !state->enabled and so the two values in pwm->state might not be
> +        * configured in hardware.
> +        */
> +       err = chip->ops->config(pwm->chip, pwm,
> +                               state->duty_cycle,
> +                               state->period);
> +       if (err)
> +               goto rollback;
> +
> +       pwm->state.period = state->period;
> +       pwm->state.duty_cycle = state->duty_cycle;
> -       if (state->period != pwm->state.period ||
> -           state->duty_cycle != pwm->state.duty_cycle) {
> -               err = chip->ops->config(pwm->chip, pwm,
> -                                       state->duty_cycle,
> -                                       state->period);
> -               if (err)
> -                       goto rollback;
> -
> -               pwm->state.period = state->period;
> -               pwm->state.duty_cycle = state->duty_cycle;
> -       }
>
>         if (!pwm->state.enabled) {
>                 err = chip->ops->enable(chip, pwm);
>
> I slightly prefer the latter patch, but if this is indeed your problem
> both should fix it for you.
>
> Can you give that a try please?

Works, too.

Thanks!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
