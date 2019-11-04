Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9910EEB17
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 22:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfKDV3J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Nov 2019 16:29:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50335 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfKDV3J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 16:29:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id 11so18404540wmk.0;
        Mon, 04 Nov 2019 13:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tp7E0KMvbL6BOAUu2NNrtQeKJbNH0Cxz/NvxU3jQlik=;
        b=PtstzIB3y4gOTVfBvLknyAu6/bRt6HO26iBUPi+jtjtcHKqtC3BAX5Vglcl36CTDXk
         vdyO63PGHx/jlldvBKhG8dxzO7elOem1o6UxjLObum4u9ajaoYO15TOxkzTfyi9+RJHj
         8OQSze8CiegkGhAtfI3YvVvmgWMysT+QVDDuxjtgzHuQ4Puuj5RAelKdHfv8VvA95X/9
         HEgwmpl6TybsMjv1V37wNav+xhxMHOHetk02mcJCJc12/4hedag2qv6OhSzyzep+xrjV
         aMz2z1v45p9bp93fv6GljUmPm9IfNkk8wxwViMJJJhPGskW53ydGxQTTzjsNzJljfi0G
         3jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tp7E0KMvbL6BOAUu2NNrtQeKJbNH0Cxz/NvxU3jQlik=;
        b=bGqdcvmEEsuUex7IEna/S4sCp0IM6mLN652DaTIvVi5irxQCZV2ifWZS/WZfesxnUu
         l3h0MXQZaXvkLIOeC4wMq/6FyHV/6DOUC0Osqh9QRHkGUiB9ZW3+QMilCZPDfHzFM9+/
         OKyibZHx7JkVIDi6g4Wf82aNXh2qCpiNkli3l79NUVXx5uobSu3zuSG/4Is51fym7Zqu
         Tl/GKB61zpf/7KFPBf5bHFHqJsI4ffNfHLUPJ26WsiZCtBblAFT0kFl6NK01ZvyfTUue
         mWgxaGiSXZuIXBNYTqPw8VAghrzt4b3fXnLmDGgKp4cm32y0LjwGfympaSSdmkRrT3D9
         PmYA==
X-Gm-Message-State: APjAAAXMWHR/NgWexXFAXFdBRloXWRpKS4ngvlFki6BJ4zkVTkb7kRso
        /abVpIhrVq3juctp7fjEXGQeBHp54zhRec8EozI=
X-Google-Smtp-Source: APXvYqyn++80Z0P0IqvOwdBOky/MrB6MAOFkJrrpZmla4Vmh4glLP0MhXJPlaBoPF3H93AUZ23e4xWA86T3r+VljyWI=
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr937906wmf.119.1572902945693;
 Mon, 04 Nov 2019 13:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-5-peron.clem@gmail.com>
 <20191104083835.m2pd4fvhn2ze6bjt@pengutronix.de>
In-Reply-To: <20191104083835.m2pd4fvhn2ze6bjt@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 4 Nov 2019 22:28:54 +0100
Message-ID: <CAJiuCccjgtMcJa-pZCB_DGN6L8m9bDTgQRoV6WUKPSjv8kn8vA@mail.gmail.com>
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

Hi Uwe

On Mon, 4 Nov 2019 at 09:38, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Sun, Nov 03, 2019 at 09:33:31PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > PWM core has an option to bypass whole logic and output unchanged sourc=
e
> > clock as PWM output. This is achieved by enabling bypass bit.
> >
> > Note that when bypass is enabled, no other setting has any meaning, not
> > even enable bit.
> >
> > This mode of operation is needed to achieve high enough frequency to
> > serve as clock source for AC200 chip, which is integrated into same
> > package as H6 SoC.
>
> I think the , should be dropped.
>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 39 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index b5e7ac364f59..2441574674d9 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -3,6 +3,10 @@
> >   * Driver for Allwinner sun4i Pulse Width Modulation Controller
> >   *
> >   * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electr=
ons.com>
> > + *
> > + * Limitations:
> > + * - When outputing the source clock directly, the PWM logic will be b=
ypassed
> > + *   and the currently running period is not guaranted to be completed
>
> Typo: guaranted  -> guaranteed
>
> >   */
> >
> >  #include <linux/bitops.h>
> > @@ -73,6 +77,7 @@ static const u32 prescaler_table[] =3D {
> >
> >  struct sun4i_pwm_data {
> >       bool has_prescaler_bypass;
> > +     bool has_direct_mod_clk_output;
> >       unsigned int npwm;
> >  };
> >
> > @@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chip *c=
hip,
> >
> >       val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> >
> > +     /*
> > +      * PWM chapter in H6 manual has a diagram which explains that if =
bypass
> > +      * bit is set, no other setting has any meaning. Even more, exper=
iment
> > +      * proved that also enable bit is ignored in this case.
> > +      */
> > +     if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
> > +         data->has_direct_mod_clk_output) {
> > +             state->period =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, clk=
_rate);
> > +             state->duty_cycle =3D state->period / 2;
> > +             state->polarity =3D PWM_POLARITY_NORMAL;
> > +             state->enabled =3D true;
> > +             return;
> > +     }
>
> Not sure how the rest of sun4i_pwm_get_state behaves, but I would prefer
> to let .get_state() round up which together with .apply_state() rounding
> down yields sound behaviour.
Ok
>
> > +
> >       if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
> >           sun4i_pwm->data->has_prescaler_bypass)
> >               prescaler =3D 1;
> > @@ -203,7 +222,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >  {
> >       struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> >       struct pwm_state cstate;
> > -     u32 ctrl;
> > +     u32 ctrl, clk_rate;
> > +     bool bypass;
> >       int ret;
> >       unsigned int delay_us;
> >       unsigned long now;
> > @@ -218,6 +238,16 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               }
> >       }
> >
> > +     /*
> > +      * Although it would make much more sense to check for bypass in
> > +      * sun4i_pwm_calculate(), value of bypass bit also depends on "en=
abled".
> > +      * Period is allowed to be rounded up or down.
> > +      */
> > +     clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> > +     bypass =3D ((state->period * clk_rate >=3D NSEC_PER_SEC &&
> > +                state->period * clk_rate < NSEC_PER_SEC + clk_rate) &&
> > +               state->enabled);
>
> I guess the compiler is smart enough here, but checking for
> state->enabled is cheaper than the other checks, so putting this at the
> start of the expression seems sensible.
>
> The comment doesn't match the code. You don't round up state->period.
> (This is good, please fix the comment.) I think dropping the check
>
>         state->period * clk_rate < NSEC_PER_SEC + clk_rate
>
> would be fine, too.
Ok

>
> I'd like to have a check for
>
>         state->duty_cycle * clk_rate >=3D NSEC_PER_SEC / 2 &&
>         state->duty_cycle * clk_rate < NSEC_PER_SEC
>
> here. If this isn't true rather disable the PWM or output a 100% duty
> cycle with a larger period.

Why not just having the duty_cycle is 50% only ?
state->duty_cycle * 2 =3D=3D state->period;

Regards,
Clement

>
> > +
> >       spin_lock(&sun4i_pwm->ctrl_lock);
> >       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> >
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
