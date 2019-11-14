Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F8FD100
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Nov 2019 23:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKNWgb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Nov 2019 17:36:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39708 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNWgb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Nov 2019 17:36:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id t26so8159292wmi.4;
        Thu, 14 Nov 2019 14:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RVuenm9Qi2pw+STW4ZtMyXnbY+dRwGZQd6cok8GsC1M=;
        b=P9vKR2GWHbPY7STfXXInk+UIPKLvMJfeivMHW7HZGEMbjb15YJ1xDERjzAeqnoF4tU
         SRh7rAuY7x1sUzF30nhAS3cqIHus5guXb1IVBXgXRUGtaQaizyed0p0GMr1TXtCwdMI6
         pwQC7ANmkxp64rgZkLmZtYbIL3c5W9PE4Fir8yw0LeNYj4iWTSnGws7mX9iFqwkqH0L9
         5RxEIJNUojdI72q9Cq496qwe/v54onHciEGhAH9PA0Knb7Q4CEW+zZMS6/P/sqhPy2br
         oDg7QM1wX9w+UrMwqUhgZhMZI55QqDjbe+2pIK7DorvfYkO+vmMTEgjE16JmfEoQnkiZ
         q3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RVuenm9Qi2pw+STW4ZtMyXnbY+dRwGZQd6cok8GsC1M=;
        b=sN0rGs5uT4glCURPa6lRzyK9f8ifgDp9sXj1gbC4qMs2qWFN//VJVwv1dvZPwNRDKH
         UUbTq6kyG9LrYRvCbz+2vLBGV48790iX15zpRTYQ7wYFyXtG8jmMny7/XkeGDKDNtSTK
         P1Id7f2YtQxZkLpjwNo7Clq3+j+6tXNXe3otzWOxf2ZabSIRGm+DMR8bR6RYhKW5IHIc
         /p0HquvEdtsUEnwVKa9rxHnC6xvRRbnc/jbQtUeq6+7WZE5ipLbkPTZWrE7biLk+LBxe
         HXOyYLs/sg72xC1dNZyyB4lvwpZsc3/lstQJc5qyP+Z/SOs7f1gXMSrS+WAjwaZ8vpLW
         vDbg==
X-Gm-Message-State: APjAAAXbo+PogTRlYFrp6Kqkyd0kd9d6X1uBlZvNlxkRo87VwZYIBWmr
        lWwaM/3y5PcreUWbQNo7fg3XeeUEVrYWf6Y+/Jg=
X-Google-Smtp-Source: APXvYqydkqVGAsZY/QfQUfncgiKmd2qGu81mlw7Lyn/j6hx/Zt8E9beVOYAmq795PN88N0QMg3qiHr5bP6gMpLIuoQw=
X-Received: by 2002:a1c:6405:: with SMTP id y5mr11626914wmb.175.1573770987981;
 Thu, 14 Nov 2019 14:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20191108084517.21617-1-peron.clem@gmail.com> <20191108084517.21617-4-peron.clem@gmail.com>
 <20191113083524.aqtf2ed4ltuiazjg@pengutronix.de>
In-Reply-To: <20191113083524.aqtf2ed4ltuiazjg@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 14 Nov 2019 23:36:16 +0100
Message-ID: <CAJiuCccqyPbxRLjv1NRy6eukMnma8OUJGKvVHHDSKwybNJgKrg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] pwm: sun4i: Add an optional probe for bus clock
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

On Wed, 13 Nov 2019 at 09:35, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Nov 08, 2019 at 09:45:13AM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
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
> >  drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 2b9a2a78591f..a10022d6c0fd 100644
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
> > @@ -363,9 +364,38 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >       if (IS_ERR(pwm->base))
> >               return PTR_ERR(pwm->base);
> >
> > -     pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > -     if (IS_ERR(pwm->clk))
> > +     /* Get all clocks and reset line */
> > +     pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
> > +     if (IS_ERR(pwm->clk)) {
> > +             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "get clock failed %pe\n",
> > +                             pwm->clk);
> >               return PTR_ERR(pwm->clk);
> > +     }
> > +
> > +     /*
> > +      * Fallback for old dtbs with a single clock and no name.
> > +      * If a parent has a clock-name called "mod" whereas the
> > +      * current node is unnamed the clock reference will be
> > +      * incorrectly obtained and will not go into this fallback.
>
> For me "old dtbs" suggests that today a device tree should have a "mod"
> clock. Is this true also for machines other than H6? And I'd put the
> comment before the acquisition of the "mod" clock. Something like:

Agree to remove the "old dtbs" but specifying the SoC instead
of the reason is less clear for me.

I would prefer to have something like this:

A clock is explicitly called "mod" when several clocks are referenced.
However, when only one clock is declared this one is unamed.
So we request "mod" first (and ignore the corner case that a parent
provides a "mod" clock)
and if this is not found we fall back to the first clock of the PWM.

What do you think?

>
>         /*
>          * A clock called "mod" is only required on H6 (for now) and on
>          * other SoCs we expect an unnamed clock. So we request "mod"
>          * first (and ignore the corner case that a parent provides a
>          * "mod" clock) and if this is not found we fall back to the
>          * first clock of the PWM.
>          */
>
> > +      */
> > +     if (!pwm->clk) {
> > +             pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +             if (IS_ERR(pwm->clk)) {
> > +                     if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                             dev_err(&pdev->dev, "get clock failed %pe=
\n",
> > +                                     pwm->clk);
> > +                     return PTR_ERR(pwm->clk);
> > +             }
> > +     }
> > +
> > +     pwm->bus_clk =3D devm_clk_get_optional(&pdev->dev, "bus");
> > +     if (IS_ERR(pwm->bus_clk)) {
> > +             if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
> > +                     dev_err(&pdev->dev, "get bus_clock failed %pe\n",
> > +                             pwm->bus_clk);
> > +             return PTR_ERR(pwm->bus_clk);
> > +     }
> >
> >       pwm->rst =3D devm_reset_control_get_optional_shared(&pdev->dev, N=
ULL);
> >       if (IS_ERR(pwm->rst)) {
> > @@ -382,6 +412,17 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >               return ret;
> >       }
> >
> > +     /*
> > +      * We're keeping the bus clock on for the sake of simplicity.
> > +      * Actually it only needs to be on for hardware register
> > +      * accesses.
> > +      */
> > +     ret =3D clk_prepare_enable(pwm->bus_clk);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Cannot prepare and enable bus_clk\n"=
);
> > +             goto err_bus;
> > +     }
> > +
>
> Would it make sense to split this patch into "Prefer "mod" clock to
> (unnamed) clock" and "Introduce optional bus clock"?

Yes I will do in v5,

Regards,
Cl=C3=A9ment
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
