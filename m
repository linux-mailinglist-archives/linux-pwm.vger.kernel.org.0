Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB6105BFD
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 22:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKUVbp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 16:31:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46480 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfKUVbp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 16:31:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so2797050wrl.13;
        Thu, 21 Nov 2019 13:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SoUQjIpFH9P3ATfJoGFUNE500XWpftLyS5ervo+RPr0=;
        b=UEfE1SngNpm6u6VyDXcMCWEbOBNvZBhnOw/HHfv1NOUt8C4HjuZ9AVT61Krh9rYZ/G
         B/Qe30Em1qPbRb2B058RM3d4A2kv+3Lc//WvO/36DQBUdBGD04iWs23v0p99nY4Dd866
         54tqpQ18Vf1uCwiNcgeaSxVX/QHM3yk1LDR0ZZxNH86mpwxzxYL6waZFQS5I1T1yiszg
         6t3lmLXpM48Yz4Mfamr8dzJtFHf5gfnD06jm3D9x5WjzO+syTHvNsAxd2foMhBS/NIuL
         ZPLYsGtC5XvkQWb7edA9heFd1VfbOeC24cLpaDwaU6Ue/kyT2U3rn0MUdXrFjLfbrCXt
         ghZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SoUQjIpFH9P3ATfJoGFUNE500XWpftLyS5ervo+RPr0=;
        b=P52y49VV3T+3MJs7izU5qZ8kgKVKi83myUWd3+w+NPAUyXoOX+gk7P5/uJaVgZ34qS
         0GRyChZuLk+iuMftlnJVwA1jsmDGkb9innXoHYqZodQpKXWHH0p35oZOgpR6nGN7kiEd
         pKgztfj8cDEB8xdJLrzSqPHREcfTxUnYAYqAq+UMCsGUjBwLqH0qhKE79a1GrfFV5vKv
         pT7rabLyhj0pmWKbhkojm5GHaaE4YbowvrxU917/50tltiPUebcSSHs//8Vk5RD63gUH
         4IGcXbUm55v8+EPsdzx4+5ooVQJUJnmijrAkQ18ovWMZnxUBcWdcu8fNC67zMxMkRMz+
         f+og==
X-Gm-Message-State: APjAAAV74KCzHkn4oU7cfULbDN4Y9bFGKWnt0dR+TyM5/UCWqDC+r+x5
        6ArZflc1fJeT/G3/UfTfHLMWzvGPfdEO5zBFxOA=
X-Google-Smtp-Source: APXvYqxsJhXfTc8mMDtjZSX8K/+oYy2Mi3i1Rsn27A6eUuEv2h+lplYbUwux8ECvZizvbfOakcuTlnkkQPqrPK41ZIk=
X-Received: by 2002:a5d:5411:: with SMTP id g17mr13463079wrv.360.1574371902690;
 Thu, 21 Nov 2019 13:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20191121195902.6906-1-peron.clem@gmail.com> <20191121195902.6906-4-peron.clem@gmail.com>
 <20191121210559.pz3nsyomqfrjuoe4@pengutronix.de>
In-Reply-To: <20191121210559.pz3nsyomqfrjuoe4@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 21 Nov 2019 22:31:31 +0100
Message-ID: <CAJiuCcfj7rngTgbZQDwjKoLgRGcqsYscBvrCP095zzyASKSqdQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] pwm: sun4i: Add an optional probe for bus clock
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
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

On Thu, 21 Nov 2019 at 22:06, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Nov 21, 2019 at 08:58:59PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM core needs bus clock to be enabled in order to work.
> >
> > Add an optional probe for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 369990ae7d09..66befd8d6f9c 100644
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
> > @@ -391,6 +392,14 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >               }
> >       }
> >
> > +     pwm->bus_clk =3D devm_clk_get_optional(&pdev->dev, "bus");
> > +     if (IS_ERR(pwm->bus_clk)) {
> > +             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "get bus clock failed %pe\n",
> > +                             pwm->bus_clk);
> > +             return PTR_ERR(pwm->bus_clk);
> > +     }
> > +
> >       pwm->rst =3D devm_reset_control_get_optional_shared(&pdev->dev, N=
ULL);
> >       if (IS_ERR(pwm->rst)) {
> >               if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > @@ -407,6 +416,17 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >               return ret;
> >       }
> >
> > +     /*
> > +      * We're keeping the bus clock on for the sake of simplicity.
> > +      * Actually it only needs to be on for hardware register accesses=
.
> > +      */
> > +     ret =3D clk_prepare_enable(pwm->bus_clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Cannot prepare and enable bus_clk %d=
\n",
> > +                     ret);
>
> nitpick: other error messages in this driver start with a lower case
> letter.
>
> Until there is an equivalent for %pe that consumes an int, I suggest to
> use
>
>         dev_err(&pdev->dev, "Cannot prepare and enable bus_clk: %pe\n",
>                 ERR_PTR(ret));
>
> to benefit from a symbolic error name instead of an error constant.

Ok i will fix both

Thanks,
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
