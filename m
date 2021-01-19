Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665262FBA59
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 15:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbhASOw6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Jan 2021 09:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404563AbhASLBL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2021 06:01:11 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC234C061573
        for <linux-pwm@vger.kernel.org>; Tue, 19 Jan 2021 03:00:30 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s11so13679762edd.5
        for <linux-pwm@vger.kernel.org>; Tue, 19 Jan 2021 03:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z1Mdmn8iV3Ak3n2cPbHK34NCK8LkeMVKgCqIq+DA4PU=;
        b=gIFV2xLFjXPFSmH7l/eWhK7mjHGORXDPnJt11pNYnTxDzquCgMAr1qP3AHsXoEcSfa
         1RCM4BG3srAtPrEM1rIfKGVu0vNx/ltLjgJDunntPYu3ClQ1PIgRhBxUZAiYZPZGaJxf
         HiN5S/T5xzB2eHrU2sgY1VYqQjiGupe3BOiqmYprR+8jJKMvublol0inD8o/LiXMl+If
         CKaK3OVzWoODiJf/mfr6CKY71O8FIiko+hbPVCWEIQkflSZ/5uEQdIvpWjQEoG8VTZlJ
         krPS1dN7cUflvoOslaIgscyjRgWGqrC0/a7JiNNdAfU7G+MBkURRxrqm6bw5D9RD4Y18
         784g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z1Mdmn8iV3Ak3n2cPbHK34NCK8LkeMVKgCqIq+DA4PU=;
        b=EMsRuBVnKadGJa3jVy0J79qVhVGuXMxW2D4xCRrAGvxZyAAKxGNmgH+++spLTAIhBl
         pgKJyrqyiGqXbYiwADPpt/qtMgFCj+2p+F1HDWQWQrmrYTGXyZK0WgmYwEKI9qI0xk+2
         q754U009Ikm0VOgQFxdCzyHnIZzcAX0b8rwI+hEiP5RsBlGxFxDGlbUjWVsiQNy7diHZ
         GjxjXTsh/2NbJZJ1jtJtnjUgAIAkcY6jksBprO7CLsRwqKUCtF/L4Va6uicXtqAqkc4k
         XozzHMMplURg4Eo6gv91cwnRnH+vbTITI8L9xR29KN22kbPpTyvBn1oFgSkyPE4rDCcd
         ngMg==
X-Gm-Message-State: AOAM530DQcNWHPEPdjUk6Q40HOk9peeS9ng5USKF7Ld59EmhDYHtksJk
        X1J7HqY4vT9fCi/lr86HHdFk7qxLcQliKi8nr9a3jw==
X-Google-Smtp-Source: ABdhPJylPgcGxNAuKY13Hft24g7OxTBSxC5eCrvV5HPhowuwmrOD/G8UqN1buqjRZrgXgqnScMOgvarHdhW44CizCyM=
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr2965321edd.341.1611054029480;
 Tue, 19 Jan 2021 03:00:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610882271.git.baruch@tkos.co.il> <588373a200d20da0fa6c2a6c7f1928b4818097e9.1610882271.git.baruch@tkos.co.il>
In-Reply-To: <588373a200d20da0fa6c2a6c7f1928b4818097e9.1610882271.git.baruch@tkos.co.il>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 19 Jan 2021 12:00:18 +0100
Message-ID: <CAMpxmJU1mjek0rEzr34xFdPHDTuEe9i9wjwiLp=UezXKYNtcwQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] gpio: mvebu: fix pwm .get_state period calculation
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jan 17, 2021 at 2:17 PM Baruch Siach <baruch@tkos.co.il> wrote:
>
> The period is the sum of on and off values. That is, calculate period as
>
>   ($on + $off) / clkrate
>
> instead of
>
>   $off / clkrate - $on / clkrate
>
> that makes no sense.
>
> Reported-by: Russell King <linux@armlinux.org.uk>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 672681a976f5..a912a8fed197 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -676,20 +676,17 @@ static void mvebu_pwm_get_state(struct pwm_chip *ch=
ip,
>         else
>                 state->duty_cycle =3D 1;
>
> +       val =3D (unsigned long long) u; /* on duration */
>         regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), =
&u);
> -       val =3D (unsigned long long) u * NSEC_PER_SEC;
> +       val +=3D (unsigned long long) u; /* period =3D on + off duration =
*/
> +       val *=3D NSEC_PER_SEC;
>         do_div(val, mvpwm->clk_rate);
> -       if (val < state->duty_cycle) {
> +       if (val > UINT_MAX)
> +               state->period =3D UINT_MAX;
> +       else if (val)
> +               state->period =3D val;
> +       else
>                 state->period =3D 1;
> -       } else {
> -               val -=3D state->duty_cycle;
> -               if (val > UINT_MAX)
> -                       state->period =3D UINT_MAX;
> -               else if (val)
> -                       state->period =3D val;
> -               else
> -                       state->period =3D 1;
> -       }
>
>         regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset, &u)=
;
>         if (u)
> --
> 2.29.2
>

I applied this for fixes and will send out a PR to Linus T this week.
Once that's upstream I'll apply the rest for the next release.

Bartosz
