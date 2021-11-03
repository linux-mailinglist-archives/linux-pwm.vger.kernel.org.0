Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6582E444199
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Nov 2021 13:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhKCMf1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Nov 2021 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhKCMf1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Nov 2021 08:35:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E765C061714
        for <linux-pwm@vger.kernel.org>; Wed,  3 Nov 2021 05:32:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id f10so2333265ilu.5
        for <linux-pwm@vger.kernel.org>; Wed, 03 Nov 2021 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tDdYp1cUnzplnw8xIPr07k5DnDOdOwaeISoz7QL9yx0=;
        b=JDrX1rqTut67mHyiDD55M7whnH4nzQ4v9Zb05BvlLbymXMVBtKR9whNpcPmwxMaYsw
         mc3JPmDaupFPjd+psSBTGwZ4woU42baz+lpyR+8Y+Knn+UArvVp7DUBcU2uvrqR92zo3
         a9mnlsA2WNzAPA+hQGU08xficIzDH7gMbO19zQ+ENYXABu8YIn6DApnrq12AoEOsG9Ry
         RKg+C6/MoNQzcnM7ZOOxg6orfZ4/7D21XJTNNzff0aoDs120MXaaxo/ocWxySelEHhRR
         YRBdDmuDsJP+ClFYcxafj0Scxb+uM6ulz7G2FUOVcfbXLF9SJGT5ayQ28HKv4HnFjCbB
         hMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tDdYp1cUnzplnw8xIPr07k5DnDOdOwaeISoz7QL9yx0=;
        b=3jOsRIfEWLB2yaOEDDW7pvK0X6qEWZ4PkQmogq0PV5FDtGGlA+hmyDC0HyIMCqsDXo
         3O0lK7bQbeTZcwDv1K9PjerlpAJWdnLaoKjDHm6GfqHGfpMLDdZFTXSlLyMhbttVwVlg
         BaaB6X4oapkjOy+TjxQeBk4dTuq2rm2vudg6r+qA8uLg5rbjWMqRf6v7gYp7Ssd5NR4Z
         ilRGTPSiYXvW4CM1i89WsgkXB+yoTFKR6+mGcWvp08ncN8XAYLOK4GQeqW9Vv+xcUO4E
         YB9RyjaZmrrKfqd8j3F8i1ccCBOPJ6Tfb/HZ4rpJolh1xE3uQraMplTnE1m53Favftm9
         VlKg==
X-Gm-Message-State: AOAM533TBTCW21XawgwXp6XtMNFp1jw2azyC+oAKf+V3ipv7+UO1y1Fr
        OyNw4GMPzO0jtFAiZjI1rsIWUBXdjMR034Fqv1uesQ==
X-Google-Smtp-Source: ABdhPJyqczhhuSEjdk42q4884tP/2XraLAkEL5KVvM/Y3XOAJo7ixOsXUZsUGoMHtEfn7Mpjr0KOfXmDwAngG9O55F0=
X-Received: by 2002:a05:6e02:1bcb:: with SMTP id x11mr24928470ilv.94.1635942769924;
 Wed, 03 Nov 2021 05:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <YX1KCclMB/HTZ22c@fedora> <CAMuHMdW5thqxWz37er3BHwqee_agvhHVDK5p8Hrx7HCKOdFjLA@mail.gmail.com>
In-Reply-To: <CAMuHMdW5thqxWz37er3BHwqee_agvhHVDK5p8Hrx7HCKOdFjLA@mail.gmail.com>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Wed, 3 Nov 2021 09:32:38 -0300
Message-ID: <CAH7FV3mKnigzrA42NYEweiphOaYbr2gjhR=VLVzwmxJ+oSpwOw@mail.gmail.com>
Subject: Re: [PATCH v3] backlight: lp855x: Switch to atomic PWM API
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Em ter., 2 de nov. de 2021 =C3=A0s 05:39, Geert Uytterhoeven
<geert@linux-m68k.org> escreveu:
>
> Hi Ma=C3=ADra,
>
> On Sat, Oct 30, 2021 at 3:35 PM Ma=C3=ADra Canal <maira.canal@usp.br> wro=
te:
> > Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> > replace it for the atomic PWM API.
> >
> > Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
>
> Thanks for your patch!
>
> > --- a/drivers/video/backlight/lp855x_bl.c
> > +++ b/drivers/video/backlight/lp855x_bl.c
> > @@ -233,9 +233,8 @@ static int lp855x_configure(struct lp855x *lp)
> >
> >  static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
> >  {
> > -       unsigned int period =3D lp->pdata->period_ns;
> > -       unsigned int duty =3D br * period / max_br;
> > -       struct pwm_device *pwm;
> > +       struct pwm_device *pwm =3D NULL;
> > +       struct pwm_state state;
> >
> >         /* request pwm device with the consumer name */
> >         if (!lp->pwm) {
> > @@ -245,18 +244,16 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, in=
t br, int max_br)
> >
> >                 lp->pwm =3D pwm;
> >
> > -               /*
> > -                * FIXME: pwm_apply_args() should be removed when switc=
hing to
> > -                * the atomic PWM API.
> > -                */
> > -               pwm_apply_args(pwm);
> > +               pwm_init_state(lp->pwm, &state);
> > +               state.period =3D lp->pdata->period_ns;
> >         }
> >
> > -       pwm_config(lp->pwm, duty, period);
> > -       if (duty)
> > -               pwm_enable(lp->pwm);
> > -       else
> > -               pwm_disable(lp->pwm);
> > +       pwm_get_state(lp->pwm, &state);
> > +
> > +       state.duty_cycle =3D br * state.period / max_br;
>
> Above is a 64-by-32 division, which should not be open-coded, as
> that will cause link failures on 32-bit platform (cfr. "undefined
> reference to `__udivdi3'", as reported by the kernel test robot).
> Please use div_u64() instead.

Hi Geert,

Thank you for the suggestion! I fixed this problem a bit differently
and submitted the v4. I made use of the PWM API and applied the
pwm_set_relative_duty_cycle function, which solved this division
problem.

>
> > +       state.enabled =3D state.duty_cycle;
> > +
> > +       pwm_apply_state(lp->pwm, &state);
> >  }
> >
> >  static int lp855x_bl_update_status(struct backlight_device *bl)
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
