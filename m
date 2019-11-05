Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0C6EFDC9
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 13:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfKEM6q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 07:58:46 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42185 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388678AbfKEM6q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 07:58:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so21234346wrf.9;
        Tue, 05 Nov 2019 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EbBVKTp3TAv641EyIKDqjqojRLx2ND1gdrPY2el5f7g=;
        b=VZEcu9xz9shvIsdGNSkSlsc2gfEgSSDku4HPpaR2nVZkeVS653tgcsFFeM+1PwScLP
         uFIfYRckoWBrGJj/vWEjitpWe1bSL/OrJuw3+IyUnQDUgQbv/Y2sSrm0SgHZMPoZhhGm
         t7L5sg80wT4jnLt3T3v0zzSvJqTYMq6YyTkr5ricx/VwzvdHFQ8cSyBmXRsrwGMR1O9q
         by6C/ug3oECowAguTc27m1SuyN9noC0lEEnQ99DqN+i/81ztkaXjcpGXGj7YAw6/8MeU
         +DxuWdodANOT+5MbUrtYDb6Tepg1inwTLNxSgy+5OBhXGRK1TrUpTW1gsM5f86B7+Tf9
         1SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EbBVKTp3TAv641EyIKDqjqojRLx2ND1gdrPY2el5f7g=;
        b=dINNP0GVLmIypH2qi+A7/DeZasE0Msz0cNOr/AtWewZI3KdaOiKqQU72KJgF7pkUwi
         UUm4fJkeK0E11LI9hXdX7Vqn+CJMKDRvMI3W1WFz42l7CcfYJILWNzzK0j8Z2fuyxPo8
         GoJMl37h1O3SkwEb1uBoLPtVYhhBHzNzBMHhXLVYFQ0UZdWKkasv2e4BOPP7cer7iSIZ
         mYQuxcK86yLicXrBl4PM2ET4lguApwYOgTzoqDDHyl1bmyvlFbx3i3raSjVj3ylRqoVo
         mB/p/tneYYQgNdOtMKTD3zE6zvDfIq8E++gcyvQLy2HBxzsnxqE7TCiL9RRgFU8vTTL6
         qdlw==
X-Gm-Message-State: APjAAAXD1Ca26wOyEIW3Zn7Wx4eiOuQvB6veqI+FB4KcqeywKUnDNcWX
        ct/h79NKvZcfdSeFa3ECLnaEb0YWDnAEACxfbV8=
X-Google-Smtp-Source: APXvYqzXcIldjXyqcQeNIUogKwZf4MmDYxHvGPy9t8BV0gGj8v8HgjgDjpF+P0vtdFNp+pJ5lsj4oW7eNcIaJp/y7q0=
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr28130527wrw.167.1572958722979;
 Tue, 05 Nov 2019 04:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-5-peron.clem@gmail.com>
 <20191104083835.m2pd4fvhn2ze6bjt@pengutronix.de> <CAJiuCccjgtMcJa-pZCB_DGN6L8m9bDTgQRoV6WUKPSjv8kn8vA@mail.gmail.com>
 <20191105072922.rku2of3cfphpfirq@pengutronix.de>
In-Reply-To: <20191105072922.rku2of3cfphpfirq@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 5 Nov 2019 13:58:31 +0100
Message-ID: <CAJiuCcdxvhra7L927UXMHHt3JZmWf8BCoWH4Jijyam2aEHfTPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] pwm: sun4i: Add support to output source clock directly
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, 5 Nov 2019 at 08:29, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hi Cl=C3=A9ment,
>
> On Mon, Nov 04, 2019 at 10:28:54PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Mon, 4 Nov 2019 at 09:38, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Sun, Nov 03, 2019 at 09:33:31PM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > >
> > > > PWM core has an option to bypass whole logic and output unchanged s=
ource
> > > > clock as PWM output. This is achieved by enabling bypass bit.
> > > >
> > > > Note that when bypass is enabled, no other setting has any meaning,=
 not
> > > > even enable bit.
> > > >
> > > > This mode of operation is needed to achieve high enough frequency t=
o
> > > > serve as clock source for AC200 chip, which is integrated into same
> > > > package as H6 SoC.
> > >
> > > I think the , should be dropped.
> > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > ---
> > > >  drivers/pwm/pwm-sun4i.c | 39 +++++++++++++++++++++++++++++++++++++=
+-
> > > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > index b5e7ac364f59..2441574674d9 100644
> > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > @@ -3,6 +3,10 @@
> > > >   * Driver for Allwinner sun4i Pulse Width Modulation Controller
> > > >   *
> > > >   * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-el=
ectrons.com>
> > > > + *
> > > > + * Limitations:
> > > > + * - When outputing the source clock directly, the PWM logic will =
be bypassed
> > > > + *   and the currently running period is not guaranted to be compl=
eted
> > >
> > > Typo: guaranted  -> guaranteed
> > >
> > > >   */
> > > >
> > > >  #include <linux/bitops.h>
> > > > @@ -73,6 +77,7 @@ static const u32 prescaler_table[] =3D {
> > > >
> > > >  struct sun4i_pwm_data {
> > > >       bool has_prescaler_bypass;
> > > > +     bool has_direct_mod_clk_output;
> > > >       unsigned int npwm;
> > > >  };
> > > >
> > > > @@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chi=
p *chip,
> > > >
> > > >       val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > > >
> > > > +     /*
> > > > +      * PWM chapter in H6 manual has a diagram which explains that=
 if bypass
> > > > +      * bit is set, no other setting has any meaning. Even more, e=
xperiment
> > > > +      * proved that also enable bit is ignored in this case.
> > > > +      */
> > > > +     if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
> > > > +         data->has_direct_mod_clk_output) {
> > > > +             state->period =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,=
 clk_rate);
> > > > +             state->duty_cycle =3D state->period / 2;
> > > > +             state->polarity =3D PWM_POLARITY_NORMAL;
> > > > +             state->enabled =3D true;
> > > > +             return;
> > > > +     }
> > >
> > > Not sure how the rest of sun4i_pwm_get_state behaves, but I would pre=
fer
> > > to let .get_state() round up which together with .apply_state() round=
ing
> > > down yields sound behaviour.
> > Ok
> > >
> > > > +
> > > >       if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK=
) &&
> > > >           sun4i_pwm->data->has_prescaler_bypass)
> > > >               prescaler =3D 1;
> > > > @@ -203,7 +222,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> > > >  {
> > > >       struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> > > >       struct pwm_state cstate;
> > > > -     u32 ctrl;
> > > > +     u32 ctrl, clk_rate;
> > > > +     bool bypass;
> > > >       int ret;
> > > >       unsigned int delay_us;
> > > >       unsigned long now;
> > > > @@ -218,6 +238,16 @@ static int sun4i_pwm_apply(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > > >               }
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Although it would make much more sense to check for bypass=
 in
> > > > +      * sun4i_pwm_calculate(), value of bypass bit also depends on=
 "enabled".
> > > > +      * Period is allowed to be rounded up or down.
> > > > +      */
> > > > +     clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> > > > +     bypass =3D ((state->period * clk_rate >=3D NSEC_PER_SEC &&
> > > > +                state->period * clk_rate < NSEC_PER_SEC + clk_rate=
) &&
> > > > +               state->enabled);
> > >
> > > I guess the compiler is smart enough here, but checking for
> > > state->enabled is cheaper than the other checks, so putting this at t=
he
> > > start of the expression seems sensible.
> > >
> > > The comment doesn't match the code. You don't round up state->period.
> > > (This is good, please fix the comment.) I think dropping the check
> > >
> > >         state->period * clk_rate < NSEC_PER_SEC + clk_rate
> > >
> > > would be fine, too.
> > Ok
> >
> > >
> > > I'd like to have a check for
> > >
> > >         state->duty_cycle * clk_rate >=3D NSEC_PER_SEC / 2 &&
> > >         state->duty_cycle * clk_rate < NSEC_PER_SEC
> > >
> > > here. If this isn't true rather disable the PWM or output a 100% duty
> > > cycle with a larger period.
> >
> > Why not just having the duty_cycle is 50% only ?
> > state->duty_cycle * 2 =3D=3D state->period;
>
> Yeah, for the bypass case you can only provide a 50% duty cycle. The
> problem you have to address is that you cannot rely on your consumer to
> request only 50% duty cycles. So you have to implement some behaviour if
> your consumer requests period =3D 1 / clk_rate and 20% duty cycle.

So you request to add a new patch in this series for fixing the actual
PWM behavior at corner case?

This series just want to add a new device and a new bypass
functionality and I can't measure the output of PWM and testing it
properly.
Can this be done in another patch/series ?

Regards,
Cl=C3=A9ment

>
> Where I want to get the pwm framework as a whole is to let lowlevel
> drivers round down both duty_cycle and period to the next possible values
> in their .apply callback to be able to provide a more uniform behaviour
> for consumers. So here this would mean:
>
>  - 1 / clk_rate <=3D state->period < smallest value without bypass &&
>    0 <=3D state->duty_cycle < state->period / 2
>         =3D> provide a constant 0
>
>  - 1 / clk_rate <=3D state->period < smallest value without bypass &&
>    state->period / 2 <=3D state->duty_cycle < state->period
>         =3D> use bypass mode providing 50% duty cycle
>
>  - 1 / clk_rate <=3D state->period < smallest value without bypass &&
>    state->period =3D=3D state->duty_cycle
>         =3D> provide a constant 1
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
