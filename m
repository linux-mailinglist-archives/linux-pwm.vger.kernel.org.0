Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8679EEE6EC
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfKDSHP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Nov 2019 13:07:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53624 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfKDSHP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 13:07:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id x4so6595186wmi.3;
        Mon, 04 Nov 2019 10:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D72jRVZqmBfC7+Kb0tuNNuuY7Rbqh0u4ZcubYxJiVEw=;
        b=gg9RZglh3dQ4I9+Zrbd1c//TX0x8bXkbzTd7d9zunTP8ch+dDb4GuNaR8AxJbaDO4c
         gMzwKdy0JWl8EtwbGmeZ0f5nux/vtpAGkzSuPORs8AmbWG9FpekLb+jivIWLgha5NMgB
         s9MAaYyn/7ZheraWZiRQjs0d0MQLB88RCjv82Skmh3/0Fm4oXhzXXa/7J2wML4wuDVes
         P64tXVOd2Jy8BEbF5Mnzr6Q2nnVaWxs3zKkOQlmIzW1vUhqhrxyVIyvJCR6YQl7yqxJi
         /ta4JBzY6klYitSHVeFATcHL878nhxbkfevLByjfHmWcgKKfPyxBr+sqESD2oVWEWcj8
         ZYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D72jRVZqmBfC7+Kb0tuNNuuY7Rbqh0u4ZcubYxJiVEw=;
        b=hW4HU1wEqU/nNySx9eKQeCWwwWqiqfA9fm05w0aSHdwtEm7UZgLN61ViBrYLLZ5yey
         d2sUFLgaLJmNbQVAVhoxH1laZfDbiFS+hzUeKak5r0Uok766bgyDmfX0M1bXZ/4bqrET
         +EPNz/6jmgqWppr6esMq1IJJqbqhP9pJY+NmtQqABFW26R6mut6n68kepZDzRmxyPx69
         vNR+DIFg2HB7hHkga48l6rD13qdpPSt3+/Ph0VVCDeJOkzUsK1Ta8cj9vBvWfSggkg2e
         qkIh9fM3OuLGpBenI/RUwG/HPH11mNjpFmkkonU6NfJh/6+2QoWb+TgZePbTa/h1NOqd
         PafA==
X-Gm-Message-State: APjAAAW5zXPv3+Xzk9i69Li3UJ7h2we/FHHNXKzdr7FovHmrzl7peY+M
        RV54WNFXGE3tzmq6UflDR8OvEmMYu80BI98Bvec=
X-Google-Smtp-Source: APXvYqxE/svCT32/l15YGFj4OySpY2sp1btqvHGxgQbUQ4gig2jWXLFKgpgss9RjBjRgyjDvqnAyDZbUF5kA36KzIRQ=
X-Received: by 2002:a1c:480a:: with SMTP id v10mr360011wma.138.1572890831792;
 Mon, 04 Nov 2019 10:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-4-peron.clem@gmail.com>
 <20191104082410.qdgcnphkamlzaipf@pengutronix.de>
In-Reply-To: <20191104082410.qdgcnphkamlzaipf@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 4 Nov 2019 19:07:00 +0100
Message-ID: <CAJiuCcdxHDwoQYBsrjK5dcOtMDie62DzJ84NH+bZzYHHv49fEQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] pwm: sun4i: Add an optional probe for bus clock
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
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, 4 Nov 2019 at 09:24, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Sun, Nov 03, 2019 at 09:33:30PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM core needs bus clock to be enabled in order to work.
> >
> > Add an optional probe for it and a fallback for previous
> > bindings without name on module clock.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index d194b8ebdb00..b5e7ac364f59 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -78,6 +78,7 @@ struct sun4i_pwm_data {
> >
> >  struct sun4i_pwm_chip {
> >       struct pwm_chip chip;
> > +     struct clk *bus_clk;
> >       struct clk *clk;
> >       struct reset_control *rst;
> >       void __iomem *base;
> > @@ -367,6 +368,31 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
>
> Adding more context here:
>
> |       pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> >       if (IS_ERR(pwm->clk))
> >               return PTR_ERR(pwm->clk);
> >
> > +     /* Get all clocks and reset line */
> > +     pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
> > +     if (IS_ERR(pwm->clk)) {
> > +             dev_err(&pdev->dev, "get clock failed %ld\n",
> > +                     PTR_ERR(pwm->clk));
> > +             return PTR_ERR(pwm->clk);
> > +     }
>
> I guess you want to drop the first assignment to pwm->clk.

devm_clk_get_optional will return NULL if there is no entry, I don't
get where I need to drop it assignment.

>
> > +     /* Fallback for old dtbs with a single clock and no name */
> > +     if (!pwm->clk) {
> > +             pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +             if (IS_ERR(pwm->clk)) {
> > +                     dev_err(&pdev->dev, "get clock failed %ld\n",
> > +                             PTR_ERR(pwm->clk));
> > +                     return PTR_ERR(pwm->clk);
> > +             }
> > +     }
>
> There is a slight change of behaviour if I'm not mistaken. If you have
> this:
>
>         clocks =3D <&clk1>;
>         clock-names =3D "mod";
>
>         pwm {
>                 compatible =3D "allwinner,sun4i-a10-pwm"
>                 clocks =3D <&clk2>;
>         }
>
> you now use clk1 instead of clk2 before.
>
> Assuming this is only a theoretical problem, at least pointing this out
> in the commit log would be good I think.

Yes it's correct and as you said the driver don't check for a correct
device tree,
that why it's now optional probe.
Let's assume that's the device-tree is correct, I will add a comment
in the commit log.

>
> > +     pwm->bus_clk =3D devm_clk_get_optional(&pdev->dev, "bus");
> > +     if (IS_ERR(pwm->bus_clk)) {
> > +             dev_err(&pdev->dev, "get bus_clock failed %ld\n",
> > +                     PTR_ERR(pwm->bus_clk));
> > +             return PTR_ERR(pwm->bus_clk);
> > +     }
> > +
> >       pwm->rst =3D devm_reset_control_get_optional(&pdev->dev, NULL);
> >       if (IS_ERR(pwm->rst)) {
> >               if (PTR_ERR(pwm->rst) =3D=3D -EPROBE_DEFER)
> > @@ -381,6 +407,13 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >               return ret;
> >       }
> >
> > +     /* Enable bus clock */
> > +     ret =3D clk_prepare_enable(pwm->bus_clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Cannot prepare_enable bus_clk\n");
>
> I'd do s/prepare_enable/prepare and enable/ here.
Ok

>
> > +             goto err_bus;
> > +     }
> > +
> >       pwm->chip.dev =3D &pdev->dev;
> >       pwm->chip.ops =3D &sun4i_pwm_ops;
> >       pwm->chip.base =3D -1;
> > @@ -401,6 +434,8 @@ static int sun4i_pwm_probe(struct platform_device *=
pdev)
> >       return 0;
> >
> >  err_pwm_add:
> > +     clk_disable_unprepare(pwm->bus_clk);
> > +err_bus:
> >       reset_control_assert(pwm->rst);
> >
> >       return ret;
>
> What is that clock used for? Is it required to access the hardware
> registers? Or is it only required while the PWM is enabled? If so you
> could enable the clock more finegrainded.

Regarding the datasheet it's required to access the hardware.
page 261 : https://linux-sunxi.org/File:Allwinner_H6_V200_User_Manual_V1.1.=
pdf

Regards,
Cl=C3=A9ment

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
