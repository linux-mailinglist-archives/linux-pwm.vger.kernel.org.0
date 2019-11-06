Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5825F20C4
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2019 22:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKFVYx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Nov 2019 16:24:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33958 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFVYw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Nov 2019 16:24:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id e6so318795wrw.1;
        Wed, 06 Nov 2019 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Soz8WtFTFYQ3Yhy0YEr2VY/OqOycp6OKY0yTpNQTkFw=;
        b=r9vZIVJCWykgW/nN32WfACkf4jz43sN6bgKR6zhShogOCOQ1tUniFQrEZ7lQR8IVS0
         kRTQUCpXGp7ylRNvNqIdROXtKQ9kzd3KXzBsEPJSyide6Wet9MtfJcAJLf8cJYnBzna4
         FCVqZDkR7pW1YLwLvuvG08bcbw9Sxu4aizimdlNddnw3ZKHc0ol6TNoSpm31APRDnFW7
         CLQkt8Tcu+K3iHBpKFFfBKFtfybdZBKJtpogFJP7u0v12bN4l3YbmuNjgPoxJo0mzA3Y
         zeWVechXbanbAjOJgizujceGFHrNI2GP2FSkyBmKT+dc69S9B8DZM3lJtaCgaGsoWlc8
         by9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Soz8WtFTFYQ3Yhy0YEr2VY/OqOycp6OKY0yTpNQTkFw=;
        b=Q/AmRNFmKq3jAN16yOmIC0gQbjlbDJvvB0TCMHMYizGefybPnkJAP9DBAT9Dudd/iD
         i48jT1koleQRZv0o9qDHz8i1o2XEJs+m4fcdH7f/ep6btvuD+4hQvs7RpRsj6qDYtLqZ
         JMCGYhLGCpwANYY0LFFGu4DIx9S/sH2NmrDwmeii2KKg++TXE63mUkRvIIKb42PPdmCD
         ouMWcECYBoaTjU9kwVjqZQnY+ZFZxrZFFG4nq2IHq0XMm8fMn19Sl+B0va8nwoO3YQKz
         mOOcKGqTLyDjmbONUUM7GOczG2+bEx0bRsdQiV0WuGu0FLJB7E8g9vPim/Iy0IgMe+Pu
         z6gw==
X-Gm-Message-State: APjAAAXqaE6o2SnH4Wf0AY+rL2J2OUa4zIaEXW61mPnsVMTlMN5FTHto
        ujhmNkrw0D9kWtrdloYP5Vb46XdJ+xru0InLKuk=
X-Google-Smtp-Source: APXvYqzxY2Zi37gqEk4onhPJdIaLEgv2hV0xed9u6vFW9KegQrjOjRehlIouz7HG5lrDsV9X9J4GPfU2gXyZn+dqNXM=
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr4633064wrw.167.1573075490460;
 Wed, 06 Nov 2019 13:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20191105131456.32400-1-peron.clem@gmail.com> <20191105131456.32400-5-peron.clem@gmail.com>
 <20191105145659.ffezqntodsys4phn@pengutronix.de>
In-Reply-To: <20191105145659.ffezqntodsys4phn@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 6 Nov 2019 22:24:39 +0100
Message-ID: <CAJiuCcdXr3y0oe19ZNaiQoN7Y39p54p8LjQjXfjHbTH8tbnrpw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] pwm: sun4i: Add support to output source clock directly
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
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, 5 Nov 2019 at 15:57, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Nov 05, 2019 at 02:14:53PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
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
> >  drivers/pwm/pwm-sun4i.c | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 54e19fa56a4e..810abf47c261 100644
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
> > +             state->duty_cycle =3D state->period / 2;
>
> Please round up here.
Ok
>
> > +             state->polarity =3D PWM_POLARITY_NORMAL;
> > +             state->enabled =3D true;
> > +             return;
> > +     }
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
> > @@ -218,6 +238,15 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               }
> >       }
> >
> > +     /*
> > +      * Although it would make much more sense to check for bypass in
> > +      * sun4i_pwm_calculate(), value of bypass bit also depends on "en=
abled".
> > +      */
> > +     clk_rate =3D clk_get_rate(sun4i_pwm->clk);
>
> clk_get_rate must not be called if the clk might be off.
Ok,

>
> > +     bypass =3D state->enabled &&
> > +              (state->period * clk_rate >=3D NSEC_PER_SEC) &&
>
> This is too coarse. With state->period =3D 1000000 this is fulfilled
> (unless the multiplication overflows).

Sorry, misunderstood the previous mail

What about something like this ?
((state->period - 1) * clk_rate <=3D NSEC_PER_SEC) &&
((state->period + 1) * clk_rate >=3D NSEC_PER_SEC) &&
 ((state->duty_cycle - 1) * 2 <=3D state->period) &&
 ((state->duty_cycle + 1) * 2 >=3D state->period);

We are sure that the user is looking for a PWM around the OSC with a
50% duty cycle ?

Regards,
Clement

>
> > +              (state->duty_cycle * 2 =3D=3D state->period);
>
> This is too strict. See my previous mail about how this should be done.
>
> If bypass is true (and the hardware support it) you can skip the
> calculation of the other parameters.
Yes correct and also we can skip


>
> > +
> >       spin_lock(&sun4i_pwm->ctrl_lock);
> >       ctrl =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
> >
> > @@ -265,6 +294,13 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >               ctrl &=3D ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
> >       }
> >
> > +     if (sun4i_pwm->data->has_direct_mod_clk_output) {
> > +             if (bypass)
> > +                     ctrl |=3D BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > +             else
> > +                     ctrl &=3D ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
> > +     }
> > +
> >       sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
> >
> >       spin_unlock(&sun4i_pwm->ctrl_lock);
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
