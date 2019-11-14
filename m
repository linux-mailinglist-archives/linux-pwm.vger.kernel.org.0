Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6AFD119
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Nov 2019 23:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNWrP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Nov 2019 17:47:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42274 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWrP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Nov 2019 17:47:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so8717246wrf.9;
        Thu, 14 Nov 2019 14:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JGRlcMeoKAOOhjcDJOF5DFr5u4BH2xeU+rJMkirYWaY=;
        b=eoX51meUHmLR8wQIfteVxzkvSZri+BeLozXZmXDuNhJcArpEX+XUjnEc506JaWySMF
         fvfTvmAQPASJqGPozMCGBtFSbhzGbCjWqUf5lEc9CFOS/S4CNSyVFPebOVza2DnCJ+Jc
         nivEEojQyUnOkHQV/qTkqlr31rG86Qver7ATIhE1o3SVN3YaFUUke59puk/mNRsDvi1L
         743tCms9wMdlL3+oXMxB3JymLJbpIGtsel0gDu0efrr/npXxjoPi4ScrRX4FX5XlEALV
         r++Sfbs/rw2znawKFhrfSeNb0rfkBzWPA0NPnExU6BhIcHPccLYQvxNPoJFG4pOj0Vd8
         OUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JGRlcMeoKAOOhjcDJOF5DFr5u4BH2xeU+rJMkirYWaY=;
        b=T7RYs0hnQAn3nWkMCYhe+2JEirn701YtDTRL3NNBRVJsFXxKNDKuetRTvL67M+4WbA
         /spfzu8kPgcxH/wLi1IZzWtuSFLFUdK+fii1Qdz02L2cl845thpYoTgokOTVBBMAQst6
         +4t5ksnV+gfqEYeDItsq/n1m2K23vXHMr5RnMQqgrXyBb+G46fDu5GD/CKaqvQ4L/2Z7
         tgaBVBmC3LcVdj4kluXx0QTozLdp7fOpwgPYHFq52CTPWLQDXan+/lBQ44pztewsSKUc
         9HSfncigNilJx9ja1FcIoNm9h1jUjIXkdXulAObRAvD8Cl93+ys1j0QpBJ2awvun5OnE
         ZaWA==
X-Gm-Message-State: APjAAAVZXFMrvH5cpzuGBbjJPR8o7RRvj0caGWXSkomJAlc7K2sSmS8n
        4UMna6L/lXycJbQSdI3XFEwr7zaDkkRDjj+rcfg=
X-Google-Smtp-Source: APXvYqwuKMxsXT28TKbuQooL9rQ1QVttKzL0StbnqApJLFSD/gam1Od9P5ARGt5yH6+H78iilIRoigLLmxYsdIh2VJ4=
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr11270259wro.270.1573771632171;
 Thu, 14 Nov 2019 14:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20191108084517.21617-1-peron.clem@gmail.com> <20191108084517.21617-5-peron.clem@gmail.com>
 <20191113085858.76rad3vpszknu4cp@pengutronix.de>
In-Reply-To: <20191113085858.76rad3vpszknu4cp@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 14 Nov 2019 23:47:00 +0100
Message-ID: <CAJiuCceYg7WC=peHYeC=eE-HOsKH_SdsKyWwkWY5VpeY+uzaKA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] pwm: sun4i: Add support to output source clock directly
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
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Wed, 13 Nov 2019 at 09:58, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Nov 08, 2019 at 09:45:14AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
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
> >  drivers/pwm/pwm-sun4i.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index a10022d6c0fd..9cc928ab47bc 100644
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
>
> I first thought you're losing precision here by reusing state->period
> here, but with a divisor of 2 everything is fine.
>
> > +             state->polarity =3D PWM_POLARITY_NORMAL;
> > +             state->enabled =3D true;
> > +             return;
> > +     }
> > +
> >       if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_MASK) &&
> >           sun4i_pwm->data->has_prescaler_bypass)
> >               prescaler =3D 1;
> > @@ -204,6 +223,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> >       struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(chip);
> >       struct pwm_state cstate;
> >       u32 ctrl;
> > +     bool bypass =3D false;
> >       int ret;
> >       unsigned int delay_us;
> >       unsigned long now;
> > @@ -218,9 +238,24 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               }
> >       }
> >
> > +     /*
> > +      * Although it would make much more sense to check for bypass in
> > +      * sun4i_pwm_calculate(), value of bypass bit also depends on "en=
abled".
>
> I don't understand this reasoning. sun4i_pwm_calculate knows about
> .enabled and also sun4i_pwm->data->has_direct_mod_clk_output. Maybe just
> add a bool *bypass as parameter and move the logic there?

I asked myself the same question, however the sun4i_pwm_calculate is
only called when period or duty_cycle is updated not when state is
toggled between disabled / enabled.

Should we also call it when the state is switched to enabled ?

Regards,
Cl=C3=A9ment

>
> > +      */
> > +     if (state->enabled) {
> > +             u32 clk_rate =3D clk_get_rate(sun4i_pwm->clk);
> > +             bypass =3D (state->period * clk_rate >=3D NSEC_PER_SEC) &=
&
> > +                      (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
> > +                      (state->duty_cycle * clk_rate * 2 >=3D NSEC_PER_=
SEC);
> > +     }
> > +
>
> This looks right now.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
