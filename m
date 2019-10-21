Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43FDEF5A
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfJUOVp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 10:21:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37013 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfJUOVp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 10:21:45 -0400
Received: by mail-io1-f67.google.com with SMTP id 1so4763730iou.4
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=33dlnADx6dfzgm6Xw9lpOZyLoYoTdhZ+EPQoMyvvLic=;
        b=ZLqHBJYzYFLAZR/l1VkAxoeFCjdWPCndITLAftLlGSjtR/5spnkYcgio9rc0SdAndN
         t7g5ZNF81N0xqtRzs71sEGeGHWdg/jjuGKceHNIGe0fgmyYN8jAY1hb4nzhEGFSFIbjB
         o5fru8/C8nyqiakcJBhccInBHLd14KF1Z/6rTZIsihai5fkqvXLs8qDWjl/NMF2tlTUq
         UGCyBhOVKOuCYxm4HuOu+E9yeOhIZDqd+8IppMynvV6NLpwfQVwLMaQ+htBWxwKo1oZY
         tVeg9vHJLQt1o9n+M5+XJwf6AC5e8iWXCbSJn+NbIZvm3ndYFCb5W4B0iButvZHW/ca+
         E3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=33dlnADx6dfzgm6Xw9lpOZyLoYoTdhZ+EPQoMyvvLic=;
        b=V9bBCi74yPvc/IEcuOXzuIJA/qLQhtlNWPGg8YjSXcNX3lFodpDyxaKqpTSxusfbhD
         Al+jsgiwgJ8Cth4ng/emAnLAw/xQ4/tfLdWVi4iSOL/dJIU0CX3hyt8n7FPkaXgxxQJx
         tP4Lg3A8n37PaEz654RNKsf6ThONMs0WJozMmtz7dXFEUpiiplingNmGESVXGWVLbEdX
         ei8EiDdbhJ+U0F+J0KgBNUIwIoXSkoD4rJvHb8UaxzOyPhIE8lFDf3a9CUkRbJ4zivBg
         YHG8dYIVUHbWAe21ILFUkhFACY3TXpmdsouJylQkbP6F9/xGjtImeZbnsQBPshAd6+r+
         Xr0w==
X-Gm-Message-State: APjAAAXV6Pb4T3ATQYm2Ib97gwPoNPqmeGd+JC0RvHgOY9hWZdzYJqpb
        +2AS1drPSHAgkfve8+4jGGvyJXWE8Xw1qRLr9mM=
X-Google-Smtp-Source: APXvYqz+7q9AZHGJhX6pcsN19NEQRUp0xvR56dnSDL65UGpbhusrjCviuSXfr5ZA0aeT3Fbn2+UO5evWIBa1QR8Wn+g=
X-Received: by 2002:a02:a11e:: with SMTP id f30mr17824655jag.95.1571667704012;
 Mon, 21 Oct 2019 07:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
 <20191021105739.1357629-4-thierry.reding@gmail.com> <5e129df5-1110-29ea-35ce-4c2274b135fe@ysoft.com>
In-Reply-To: <5e129df5-1110-29ea-35ce-4c2274b135fe@ysoft.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 21 Oct 2019 09:21:32 -0500
Message-ID: <CAHCN7xKSUysQ+zv1TFdPBqcvkHryT0pA3W0SL2iEWtadi34DWg@mail.gmail.com>
Subject: Re: [PATCH 4/4] pwm: imx27: Unconditionally write state to hardware
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 21, 2019 at 8:49 AM Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.=
com> wrote:
>
> +Adam
>
> On 21. 10. 19 12:57, Thierry Reding wrote:
> > The i.MX driver currently uses a shortcut and doesn't write all of the
> > state through to the hardware when the PWM is disabled. This causes an
> > inconsistent state to be read back by consumers with the result of them
> > malfunctioning.
> >
> > Fix this by always writing the full state through to the hardware
> > registers so that the correct state can always be read back.
>
> Gave it another shot and got expected results.
>
> Tested-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>

Tested-by: Adam Ford <aford173@gmail.com>

>
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> > ---
> >   drivers/pwm/pwm-imx27.c | 120 ++++++++++++++++++++-------------------=
-
> >   1 file changed, 59 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > index 4113d5cd4c62..59d8b1289808 100644
> > --- a/drivers/pwm/pwm-imx27.c
> > +++ b/drivers/pwm/pwm-imx27.c
> > @@ -230,70 +230,68 @@ static int pwm_imx27_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >
> >       pwm_get_state(pwm, &cstate);
> >
> > -     if (state->enabled) {
> > -             c =3D clk_get_rate(imx->clk_per);
> > -             c *=3D state->period;
> > -
> > -             do_div(c, 1000000000);
> > -             period_cycles =3D c;
> > -
> > -             prescale =3D period_cycles / 0x10000 + 1;
> > -
> > -             period_cycles /=3D prescale;
> > -             c =3D (unsigned long long)period_cycles * state->duty_cyc=
le;
> > -             do_div(c, state->period);
> > -             duty_cycles =3D c;
> > -
> > -             /*
> > -              * according to imx pwm RM, the real period value should =
be
> > -              * PERIOD value in PWMPR plus 2.
> > -              */
> > -             if (period_cycles > 2)
> > -                     period_cycles -=3D 2;
> > -             else
> > -                     period_cycles =3D 0;
> > -
> > -             /*
> > -              * Wait for a free FIFO slot if the PWM is already enable=
d, and
> > -              * flush the FIFO if the PWM was disabled and is about to=
 be
> > -              * enabled.
> > -              */
> > -             if (cstate.enabled) {
> > -                     pwm_imx27_wait_fifo_slot(chip, pwm);
> > -             } else {
> > -                     ret =3D pwm_imx27_clk_prepare_enable(chip);
> > -                     if (ret)
> > -                             return ret;
> > -
> > -                     pwm_imx27_sw_reset(chip);
> > -             }
> > -
> > -             writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > -             writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> > -
> > -             /*
> > -              * Store the duty cycle for future reference in cases whe=
re
> > -              * the MX3_PWMSAR register can't be read (i.e. when the P=
WM
> > -              * is disabled).
> > -              */
> > -             imx->duty_cycle =3D duty_cycles;
> > -
> > -             cr =3D MX3_PWMCR_PRESCALER_SET(prescale) |
> > -                  MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITE=
N |
> > -                  FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HI=
GH) |
> > -                  MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
> > -
> > -             if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > -                     cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
> > -                                     MX3_PWMCR_POUTC_INVERTED);
> > -
> > -             writel(cr, imx->mmio_base + MX3_PWMCR);
> > -     } else if (cstate.enabled) {
> > -             writel(0, imx->mmio_base + MX3_PWMCR);
> > +     c =3D clk_get_rate(imx->clk_per);
> > +     c *=3D state->period;
> >
> > -             pwm_imx27_clk_disable_unprepare(chip);
> > +     do_div(c, 1000000000);
> > +     period_cycles =3D c;
> > +
> > +     prescale =3D period_cycles / 0x10000 + 1;
> > +
> > +     period_cycles /=3D prescale;
> > +     c =3D (unsigned long long)period_cycles * state->duty_cycle;
> > +     do_div(c, state->period);
> > +     duty_cycles =3D c;
> > +
> > +     /*
> > +      * according to imx pwm RM, the real period value should be PERIO=
D
> > +      * value in PWMPR plus 2.
> > +      */
> > +     if (period_cycles > 2)
> > +             period_cycles -=3D 2;
> > +     else
> > +             period_cycles =3D 0;
> > +
> > +     /*
> > +      * Wait for a free FIFO slot if the PWM is already enabled, and f=
lush
> > +      * the FIFO if the PWM was disabled and is about to be enabled.
> > +      */
> > +     if (cstate.enabled) {
> > +             pwm_imx27_wait_fifo_slot(chip, pwm);
> > +     } else {
> > +             ret =3D pwm_imx27_clk_prepare_enable(chip);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             pwm_imx27_sw_reset(chip);
> >       }
> >
> > +     writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > +     writel(period_cycles, imx->mmio_base + MX3_PWMPR);
> > +
> > +     /*
> > +      * Store the duty cycle for future reference in cases where the
> > +      * MX3_PWMSAR register can't be read (i.e. when the PWM is disabl=
ed).
> > +      */
> > +     imx->duty_cycle =3D duty_cycles;
> > +
> > +     cr =3D MX3_PWMCR_PRESCALER_SET(prescale) |
> > +          MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
> > +          FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
> > +          MX3_PWMCR_DBGEN;
> > +
> > +     if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > +             cr |=3D FIELD_PREP(MX3_PWMCR_POUTC,
> > +                             MX3_PWMCR_POUTC_INVERTED);
> > +
> > +     if (state->enabled)
> > +             cr |=3D MX3_PWMCR_EN;
> > +
> > +     writel(cr, imx->mmio_base + MX3_PWMCR);
> > +
> > +     if (!state->enabled && cstate.enabled)
> > +             pwm_imx27_clk_disable_unprepare(chip);
> > +
> >       return 0;
> >   }
> >
> >
>
