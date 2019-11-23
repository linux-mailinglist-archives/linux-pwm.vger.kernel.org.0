Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD930107EB5
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2019 15:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfKWOGD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 Nov 2019 09:06:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39544 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfKWOGC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 Nov 2019 09:06:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so10850516wmi.4;
        Sat, 23 Nov 2019 06:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LzBH6Boadl2X4V0qpKJ4GfJzn4lxVk+taIl7e3TfpSk=;
        b=cVo0f2SQMjG9Hgm32KC4vK1EUx4QadFWHUqq7hfcMMWd+XuTsowzRLm3k0R/vUC8HK
         IkHaynx9K6q1/mekm7TxG6YSsLMpuulArhGMSyaAc0DJJ1OcMyVHXtKRUN4eBpYOYHuS
         F1a/7LyF/FotC/2joRQLgndM9zVKLVziEKlwYZZwlfB06tadQsqqGJ6Y/8nDrmj+N/HE
         7sQPjZe7S8gSTA7DcOiR8D+zkfpPG4NPwR5ApV6hN4VWMi5UEx9eTLaUtujLdwwvC0YI
         cbZzRF+j+eLqIv7BpJT0kvu8mtTYKWtk2ooCYEiqH5MeRgtF+JEbp37IfMILyiqamr8X
         4XTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LzBH6Boadl2X4V0qpKJ4GfJzn4lxVk+taIl7e3TfpSk=;
        b=qUcUmg1/4i4ggEm1tMJJPdFPJ+xa+6geWJt/llm+i0i87iRo0R+eO7Fpy+7kTOggMf
         eqM8sN52k32Z7CUBSLX+izzhmaNxgIIetIxtH9PsOsRgQLqCr+j3wxAwvveGvGm1zFC1
         Lun/LaDfLd667848WSTQqKlTJNyAg8dEnBcmfITp5XYztqiZMVqVFeFa5qWrnA+ygzS3
         FYfvSzBaAlc90EGIevbxUhTOvJro3SjqFrV3cW07TCpYWMaEQCv9wYBRN/c5f49j+bg7
         EnUuQi5eQjj2ykssY9Ti8rXDzo0G3AgHALIqAF/VWvOlJC5XlD3Ogb4n33d4rEhAjlZ4
         g7wA==
X-Gm-Message-State: APjAAAUo1SwxJ6QnG9XhSMLYjujcf37agSo0tlJj1c6UblVJx05ij+l/
        o7sKwgY7SMCwzyX/NXodCxVobbctfHCV/2a5bYs=
X-Google-Smtp-Source: APXvYqzVqWiQ+apKsrT0oBiaeec4gy/zoma0dtQBf07yF7JGCR5SNhAzslSYZ+fTDlHPoKxtqDWGDPl4l7/aBmKHdYM=
X-Received: by 2002:a7b:c411:: with SMTP id k17mr20668890wmi.119.1574517959360;
 Sat, 23 Nov 2019 06:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20191121195902.6906-1-peron.clem@gmail.com> <20191121195902.6906-6-peron.clem@gmail.com>
 <20191121211630.slgayfbuykwvlvdt@pengutronix.de> <CAJiuCcdhH9zbRMMYsZbBYL-H8YWn2kimvJEjZ8Z8kF7Uh9MCpg@mail.gmail.com>
In-Reply-To: <CAJiuCcdhH9zbRMMYsZbBYL-H8YWn2kimvJEjZ8Z8kF7Uh9MCpg@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 23 Nov 2019 15:05:48 +0100
Message-ID: <CAJiuCcd8VK2xHqRuWTVpNvw4e+rCR9-KjOSF5KsTcN9qQhaNVw@mail.gmail.com>
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

On Thu, 21 Nov 2019 at 22:21, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi Uwe,
>
> On Thu, 21 Nov 2019 at 22:16, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Thu, Nov 21, 2019 at 08:59:01PM +0100, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > PWM core has an option to bypass whole logic and output unchanged sou=
rce
> > > clock as PWM output. This is achieved by enabling bypass bit.
> > >
> > > Note that when bypass is enabled, no other setting has any meaning, n=
ot
> > > even enable bit.
> > >
> > > This mode of operation is needed to achieve high enough frequency to
> > > serve as clock source for AC200 chip which is integrated into same
> > > package as H6 SoC.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 46 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > index 1fa2057419fb..0fe9c680d6d0 100644
> > > --- a/drivers/pwm/pwm-sun4i.c
> > > +++ b/drivers/pwm/pwm-sun4i.c
> > > @@ -3,6 +3,10 @@
> > >   * Driver for Allwinner sun4i Pulse Width Modulation Controller
> > >   *
> > >   * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-elec=
trons.com>
> > > + *
> > > + * Limitations:
> > > + * - When outputing the source clock directly, the PWM logic will be=
 bypassed
> > > + *   and the currently running period is not guaranteed to be comple=
ted
> > >   */
> > >
> > >  #include <linux/bitops.h>
> > > @@ -73,6 +77,7 @@ static const u32 prescaler_table[] =3D {
> > >
> > >  struct sun4i_pwm_data {
> > >       bool has_prescaler_bypass;
> > > +     bool has_direct_mod_clk_output;
> > >       unsigned int npwm;
> > >  };
> > >
> > > @@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chip =
*chip,
> > >
> > >       val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > >
> > > +     /*
> > > +      * PWM chapter in H6 manual has a diagram which explains that i=
f bypass
> > > +      * bit is set, no other setting has any meaning. Even more, exp=
eriment
> > > +      * proved that also enable bit is ignored in this case.
> > > +      */
> > > +     if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
> > > +         sun4i_pwm->data->has_direct_mod_clk_output) {
> > > +             state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_ra=
te);
> > > +             state->duty_cycle =3D DIV_ROUND_UP_ULL(state->period, 2=
);
> > > +             state->polarity =3D PWM_POLARITY_NORMAL;
> > > +             state->enabled =3D true;
> > > +             return;
> > > +     }
> > > +
> > >       if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) =
&&
> > >           sun4i_pwm->data->has_prescaler_bypass)
> > >               prescaler =3D 1;
> > > @@ -149,13 +168,24 @@ static void sun4i_pwm_get_state(struct pwm_chip=
 *chip,
> > >
> > >  static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
> > >                              const struct pwm_state *state,
> > > -                            u32 *dty, u32 *prd, unsigned int *prsclr=
)
> > > +                            u32 *dty, u32 *prd, unsigned int *prsclr=
,
> > > +                            bool *bypass)
> > >  {
> > >       u64 clk_rate, div =3D 0;
> > >       unsigned int pval, prescaler =3D 0;
> > >
> > >       clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> > >
> > > +     *bypass =3D sun4i_pwm->data->has_direct_mod_clk_output &&
> > > +               state->enabled &&
> > > +               (state->period * clk_rate >=3D NSEC_PER_SEC) &&
> > > +               (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
> > > +               (state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_SEC);
> > > +
> > > +     /* Skip calculation of other parameters if we bypass them */
> > > +     if (*bypass)
> > > +             return 0;
> > > +
> > >       if (sun4i_pwm->data->has_prescaler_bypass) {
> > >               /* First, test without any prescaler when available */
> > >               prescaler =3D PWM_PRESCAL_MASK;
> > > @@ -206,6 +236,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> > >       int ret;
> > >       unsigned int delay_us, prescaler;
> > >       unsigned long now;
> > > +     bool bypass;
> > >
> > >       pwm_get_state(pwm, &cstate);
> > >
> > > @@ -220,7 +251,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> > >       spin_lock(&sun4i_pwm->ctrl_lock);
> > >       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> > >
> > > -     ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &=
prescaler);
> > > +     ret =3D sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &=
prescaler,
> > > +                               &bypass);
> > >       if (ret) {
> > >               dev_err(chip->dev, "period exceeds the maximum value\n"=
);
> > >               spin_unlock(&sun4i_pwm->ctrl_lock);
> > > @@ -229,6 +261,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >               return ret;
> > >       }
> > >
> > > +     if (sun4i_pwm->data->has_direct_mod_clk_output) {
> > > +             if (bypass) {
> > > +                     ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > > +                     /* We can skip other parameter */
> > > +                     sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG)=
;
> > > +                     spin_unlock(&sun4i_pwm->ctrl_lock);
> > > +                     return 0;
> > > +             } else {
> > > +                     ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > > +             }
> > > +     }
> >
> > This could be simplified to:
> >
> >         if (bypass) {
> >                 ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> >                 /*
> >                  * Other parameters are not relevant in this mode and s=
o
> >                  * writing them can be skipped
> >                  */
> >                 sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> >                 spin_unlock(&sun4i_pwm->ctrl_lock);
> >                 return 0;
> >         } else {
> >                 ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> >         }
> >
> > which has the advantage(?) that the bypass bit is also (more obviously)
> > cleared for SoCs that don't support it and it reduces the indention
> > level.
>
> This bit is not guaranteed to be reserved for all the SoC variants.
>
> I don't think it's a good idea to set to 0 a bit which is undefined.

Let me know if you agree or not with this and I send the v9 according
to your answer.

Regards,
Cl=C3=A9ment

>
> Regards,
> Clement
>
> >
> > Best regards
> > Uwe
> >
> > --
> > Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> > Industrial Linux Solutions                 | https://www.pengutronix.de=
/ |
