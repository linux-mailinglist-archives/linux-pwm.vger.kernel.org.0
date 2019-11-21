Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03FCC105BC9
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 22:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKUVVm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 16:21:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50863 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUVVm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 16:21:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id l17so5336847wmh.0;
        Thu, 21 Nov 2019 13:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fO4pVQEm2tFvrKejphNId6GyRDtMLOe3dOR2m5M+DPY=;
        b=s905Hwyo2yzylx0oL6H5bsMpUU1msMF4sTnrz0kdukk+xXjNVZI2KGslsDI5yvUfhm
         wYwuGluIV86LmSwVjU36FhBTiiPilX8BTbwXBwSQ+LeRzbabzs0WYBzQqGLm0B1+n8J4
         hzKm8vmVsch25/auxKlWT2f1hNVjBgzZVHCqI3+tFuocIpLksD3FlaN7dpPVTIYdArhb
         7avvjNw4SNyyOAGvk4gPiz/QVDeOfwC08rvrKRWgiItm22pcSvo5tPSGrkvHetqUBhq9
         r6WXm1/kSY+BGB0DaBiBdBTb5xodgvxYV91TcjYXxOcRFpO2NAr7IJGNBujxLTUHyU/C
         YdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fO4pVQEm2tFvrKejphNId6GyRDtMLOe3dOR2m5M+DPY=;
        b=UVGaKV+l3E/MUVeB74cfzyftutJ+tDUqnhx7qn0sYWLU8cNR+oxfavD0asTKdt7fbp
         rsaHGlDxfgvQ4F3RWQpap/B+/2BlO/JypZWFDxJ00xLfOJuCntAnX2Dm5Cqt6AymxF42
         rf1kHceRTvufdNjCiqLg8OAe1oQwwoMmAHkpUjTm6WImaCbNMCnRdZ7ZJA1te+8ecPzP
         NFGLpimhZZD/oKTTriVRANVPyZV7x4vivp+KUFlt2x/q5aiihZFwqfl1f6yiN6r7lJxu
         l+9pCyzVxWi82wC6Ih5GI9VVBm2sR/FSXsDSoUoFmP8yQLFczuHttmSjEdqAazlHrhve
         n5Pw==
X-Gm-Message-State: APjAAAVuOFIdl03LYw1ZqCo1MCTOuVlJyD5EQ48LaosIA7Hj8Ok0moDH
        hzGW7E/PX2/myrp4401tirwToX1Fa4oZDcZilEU=
X-Google-Smtp-Source: APXvYqwMTEdhPuDLN8L/FnO3vbnOU6J7rg37EdlTNR4d3NVrgVGZGdTNRl41HTisKn1Zts7OlZ1KOF2ztqmQ7dMbYCA=
X-Received: by 2002:a1c:6405:: with SMTP id y5mr13357858wmb.175.1574371298600;
 Thu, 21 Nov 2019 13:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20191121195902.6906-1-peron.clem@gmail.com> <20191121195902.6906-6-peron.clem@gmail.com>
 <20191121211630.slgayfbuykwvlvdt@pengutronix.de>
In-Reply-To: <20191121211630.slgayfbuykwvlvdt@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 21 Nov 2019 22:21:27 +0100
Message-ID: <CAJiuCcdhH9zbRMMYsZbBYL-H8YWn2kimvJEjZ8Z8kF7Uh9MCpg@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] pwm: sun4i: Add support to output source clock directly
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Thu, 21 Nov 2019 at 22:16, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Nov 21, 2019 at 08:59:01PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
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
> > serve as clock source for AC200 chip which is integrated into same
> > package as H6 SoC.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1fa2057419fb..0fe9c680d6d0 100644
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
> > + *   and the currently running period is not guaranteed to be complete=
d
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
> > +         sun4i_pwm->data->has_direct_mod_clk_output) {
> > +             state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate=
);
> > +             state->duty_cycle =3D DIV_ROUND_UP_ULL(state->period, 2);
> > +             state->polarity =3D PWM_POLARITY_NORMAL;
> > +             state->enabled =3D true;
> > +             return;
> > +     }
> > +
> >       if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
> >           sun4i_pwm->data->has_prescaler_bypass)
> >               prescaler =3D 1;
> > @@ -149,13 +168,24 @@ static void sun4i_pwm_get_state(struct pwm_chip *=
chip,
> >
> >  static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
> >                              const struct pwm_state *state,
> > -                            u32 *dty, u32 *prd, unsigned int *prsclr)
> > +                            u32 *dty, u32 *prd, unsigned int *prsclr,
> > +                            bool *bypass)
> >  {
> >       u64 clk_rate, div =3D 0;
> >       unsigned int pval, prescaler =3D 0;
> >
> >       clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> >
> > +     *bypass =3D sun4i_pwm->data->has_direct_mod_clk_output &&
> > +               state->enabled &&
> > +               (state->period * clk_rate >=3D NSEC_PER_SEC) &&
> > +               (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
> > +               (state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC);
> > +
> > +     /* Skip calculation of other parameters if we bypass them */
> > +     if (*bypass)
> > +             return 0;
> > +
> >       if (sun4i_pwm->data->has_prescaler_bypass) {
> >               /* First, test without any prescaler when available */
> >               prescaler =3D PWM_PRESCAL_MASK;
> > @@ -206,6 +236,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >       int ret;
> >       unsigned int delay_us, prescaler;
> >       unsigned long now;
> > +     bool bypass;
> >
> >       pwm_get_state(pwm, &cstate);
> >
> > @@ -220,7 +251,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >       spin_lock(&sun4i_pwm->ctrl_lock);
> >       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> >
> > -     ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &pr=
escaler);
> > +     ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &pr=
escaler,
> > +                               &bypass);
> >       if (ret) {
> >               dev_err(chip->dev, "period exceeds the maximum value\n");
> >               spin_unlock(&sun4i_pwm->ctrl_lock);
> > @@ -229,6 +261,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               return ret;
> >       }
> >
> > +     if (sun4i_pwm->data->has_direct_mod_clk_output) {
> > +             if (bypass) {
> > +                     ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > +                     /* We can skip other parameter */
> > +                     sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> > +                     spin_unlock(&sun4i_pwm->ctrl_lock);
> > +                     return 0;
> > +             } else {
> > +                     ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > +             }
> > +     }
>
> This could be simplified to:
>
>         if (bypass) {
>                 ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
>                 /*
>                  * Other parameters are not relevant in this mode and so
>                  * writing them can be skipped
>                  */
>                 sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
>                 spin_unlock(&sun4i_pwm->ctrl_lock);
>                 return 0;
>         } else {
>                 ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
>         }
>
> which has the advantage(?) that the bypass bit is also (more obviously)
> cleared for SoCs that don't support it and it reduces the indention
> level.

This bit is not guaranteed to be reserved for all the SoC variants.

I don't think it's a good idea to set to 0 a bit which is undefined.

Regards,
Clement

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
