Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B860A105187
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 12:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfKULiS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 06:38:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40526 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKULiS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 06:38:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id y5so3285856wmi.5;
        Thu, 21 Nov 2019 03:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ymYVwgS3u3Is3vut5facTUt0ewbtP1AkLC3XruiyyFw=;
        b=OJ6+E/4mIpJrfVzL/CzFsbRw9we7mEYlDp7DNWT6XbKCr1OrAw8g8vkoD6Zs3L6d8R
         hFeiCRE2bXcNKEx3SQ90HrjFvdsXhWvMLEA7FVszTd/tmVlXQO1/2/3WJztfGHejQgTE
         WkdYVkpVof2pqJKS4FIm4spQpy+ApI2GQrGbcWnv/TG+Wd/zda3fYSCiV/DrJBGNfcaN
         Qa7hf0RMxxsUcNWy9dpER6xwRV8EVUvOq33j0V4M1c4CwKJVcmbM53K2QQtDUFtd4jq9
         rlmman9bZojiY3ADvfPfD+x20y1L1m2pbHD+y+1UQ5T6clpXW2zDmEZDepGYU5ULxFGE
         +1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ymYVwgS3u3Is3vut5facTUt0ewbtP1AkLC3XruiyyFw=;
        b=CQCeLXAdMFvAxsrKf6aIIfuU4xiIO0Fhp90rL2bQx3UXg+f5kiPPy7FkQMyODMwNSw
         ItsPZYlxgqcmgAr0oLWGjJ0NNwL5R2S3fwm41viYVAU4uDBvSh8vTusZglgsmavC/dSt
         gIirNU2y7Qjyn8d23WlDuy/8CI3OBiutDYzD3ZYiiQAcZi9OLSmya0ILKCnWHESrq6EM
         07ZuwngGEXX86EGI/BHTSvoe4dGmvCAfrdvtKDxskhhI0/y382KEb7l1fepyhVQHI+RD
         l6rEn9JYELqDwMICXEojOOCIlJTR/2/gPrYHulT5XaJTnRwE9vLjzkDlIp2k1TsIxspl
         SwsQ==
X-Gm-Message-State: APjAAAVmD4PeiK4NWltdAoGghsce7mHI11bP8Lr0gPK41FWrzxdJrmRw
        si0s7lgaDioQLUOHYAZRVOc8Yxb+Q3vUrqjx8Dw=
X-Google-Smtp-Source: APXvYqyR9LDxGzxU1MMCH+7C5pWOo65/JRU9WwJr6HTbFIdaYXl6lkFahCsi/SxbBT63istEhq66gV2+uvSK+1/4UPs=
X-Received: by 2002:a7b:c934:: with SMTP id h20mr2550286wml.56.1574336294490;
 Thu, 21 Nov 2019 03:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20191119175319.16561-1-peron.clem@gmail.com> <20191119175319.16561-6-peron.clem@gmail.com>
 <20191121073647.phutknyb3tzp44ye@pengutronix.de>
In-Reply-To: <20191121073647.phutknyb3tzp44ye@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 21 Nov 2019 12:38:03 +0100
Message-ID: <CAJiuCcd3p-=G9TEadARPmCs6cS7gi61M4CaxX17=NOHwo9onzA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] pwm: sun4i: Add support to output source clock directly
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
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

On Thu, 21 Nov 2019 at 08:36, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Cl=C3=A9ment,
>
> On Tue, Nov 19, 2019 at 06:53:16PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
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
> >  drivers/pwm/pwm-sun4i.c | 92 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 64 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index ce83d479ba0e..a1d8851b18f0 100644
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
> > @@ -149,13 +168,23 @@ static void sun4i_pwm_get_state(struct pwm_chip *=
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
> > +     *bypass =3D state->enabled &&
> > +               (state->period * clk_rate >=3D NSEC_PER_SEC) &&
> > +               (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
> > +               (state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC);
> > +
> > +     /* Skip calculation of other parameters if we bypass them */
> > +     if (*bypass && sun4i_pwm->data->has_direct_mod_clk_output)
> > +             return 0;
> > +
>
> Hmm, so if my PWM doesn't support the bypass bit *bypass might still be
> true on return of sun4i_pwm_calculate. It doesn't hurt because the value
> is only used after another check of has_direct_mod_clk_output, but still
> this is a bit confusing.

Ok will change this

>
> >       if (sun4i_pwm->data->has_prescaler_bypass) {
> >               /* First, test without any prescaler when available */
> >               prescaler =3D PWM_PRESCAL_MASK;
> > @@ -202,10 +231,11 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >  {
> >       struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> >       struct pwm_state cstate;
> > -     u32 ctrl;
> > +     u32 ctrl, period, duty, val;
> >       int ret;
> > -     unsigned int delay_us;
> > +     unsigned int delay_us, prescaler;
> >       unsigned long now;
> > +     bool bypass;
> >
> >       pwm_get_state(pwm, &cstate);
> >
> > @@ -220,43 +250,48 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >       spin_lock(&sun4i_pwm->ctrl_lock);
> >       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> >
> > -     if ((cstate.period !=3D state->period) ||
> > -         (cstate.duty_cycle !=3D state->duty_cycle)) {
> > -             u32 period, duty, val;
> > -             unsigned int prescaler;n write the register and return
But
> > +     ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &pr=
escaler,
> > +                               &bypass);
> > +     if (ret) {
> > +             dev_err(chip->dev, "period exceeds the maximum value\n");
> > +             spin_unlock(&sun4i_pwm->ctrl_lock);
> > +             if (!cstate.enabled)
> > +                     clk_disable_unprepare(sun4i_pwm->clk);
> > +             return ret;
> > +     }
> >
> > -             ret =3D sun4i_pwm_calculate(sun4i_pwm, state,
> > -                                       &duty, &period, &prescaler);
> > -             if (ret) {
> > -                     dev_err(chip->dev, "period exceeds the maximum va=
lue\n");
> > -                     spin_unlock(&sun4i_pwm->ctrl_lock);
> > -                     if (!cstate.enabled)
> > -                             clk_disable_unprepare(sun4i_pwm->clk);
> > -                     return ret;
>
> This would be a bit easier to review if this commit was split into two
> patches. One that drops the check for cstate.period !=3D state->period et=
c
> (which otherwise is nearly empty when ignoring whitespace changes), and
> a second that then adds bypass support.

Ok

>
>
> > +     if (sun4i_pwm->data->has_direct_mod_clk_output) {
> > +             if (bypass) {
> > +                     ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > +                     /* We can skip apply of other parameters */
> > +                     goto bypass_mode;
>
> I would prefer to use goto only for error handling. Not sure if there is
> a nice way to do that.

As the PWM is necessarily enabled we can write the register and return
but not sure it's more proper.

sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
spin_unlock(&sun4i_pwm->ctrl_lock);
return 0;

Regards,
Cl=C3=A9ment

>
> > +             } else {
> > +                     ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> >               }
> > +     }
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
