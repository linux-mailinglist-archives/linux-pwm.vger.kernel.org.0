Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA307EE970
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 21:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfKDU1T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Nov 2019 15:27:19 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53940 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKDU1T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 15:27:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id x4so7043826wmi.3;
        Mon, 04 Nov 2019 12:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eJjvkA6yQtTeToMH+yY3H7r37OYyno8T+dCsD7mJkTU=;
        b=EMQErTP5d17itNFyu7PdbWPHp5cK5cAgkGaCMaQn40UGPEaMM5vMNV5+resGySYHgK
         472qO460HJpl2i0elMfXUaWmN60cMbH8uqzRe+/ikjz+2lBb+5zye4B639vJbbKQJsm1
         6RaIQ0Oke2Eiejz1MR+MkLoqNQWJsD/ZKT1WQGAtobEFDhsmLNo/vhFrEfw00p6XHEpW
         yH2fHc2SKp15EXElFkLM+saatYaCma/k4bPIYvntGIq89qGt29fa7rfV2UqfY5HSMKds
         BKVZoCGC+sMsHl+8lOZLFq1gmRl2rD4WqjYmm2ysVaMx+jRwPTV2bX3LG37lnRN8G6ie
         M1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eJjvkA6yQtTeToMH+yY3H7r37OYyno8T+dCsD7mJkTU=;
        b=XNrYMPS/2uo1/GedvwKRsFjyw7EiWyCAyvCJuR3qa+fEujOZZgPBCydDnEYA/R1+O9
         wSjJnsDH7IsVh/RDh2TOFSt0cHWwMJRvKvk5X4HxgKGBIuYA++ZGZUelw62RKu8FzElX
         wfnRgSZWgS954vMgpEAHD24DzabHYW2A/PxRzM03Rp2XamGkFZei1NyVE/ToOEinGOf5
         pE7/2BBb1jfaB/Cr2lpH/OQSvfN0p0hkTZ0d4v79KLUnFO8S3FfMIQep42CmlIFxrrtG
         2TcQmyA21T8rVqaQkIlIgkhBB1pldhs6nWIcT2lTyccXkzh3wUSeZFrRoKKLGhXN+I/l
         U7ZA==
X-Gm-Message-State: APjAAAUZ5cycogOHtfQ+VHGhgtCM6/mlQt9ydBm5nGiOP34+tW2QFnAC
        y/0jJCsnJglYwq7sg1br9syP68dn08N5WFcKUlM=
X-Google-Smtp-Source: APXvYqxjf+inmW1al3DpwnzHpMgXt++cFW9P4wSUXNazxLr52mi3+w60kogzNGZ8yDGlRlLJ3xXXb3OJFfLdA9g0azQ=
X-Received: by 2002:a1c:6405:: with SMTP id y5mr831127wmb.175.1572899235350;
 Mon, 04 Nov 2019 12:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-1-peron.clem@gmail.com> <CAJiuCcdxHDwoQYBsrjK5dcOtMDie62DzJ84NH+bZzYHHv49fEQ@mail.gmail.com>
 <20191104201052.bxzdues2y4aqkukd@pengutronix.de> <524459750.Kvg9uK5Sr7@jernej-laptop>
In-Reply-To: <524459750.Kvg9uK5Sr7@jernej-laptop>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 4 Nov 2019 21:27:04 +0100
Message-ID: <CAJiuCcfCo2QiKEvaRphcBkdTtFui3ympU9aikJTmXDa4OoiXZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] pwm: sun4i: Add an optional probe for bus clock
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, 4 Nov 2019 at 21:19, Jernej =C5=A0krabec <jernej.skrabec@siol.net> =
wrote:
>
> Dne ponedeljek, 04. november 2019 ob 21:10:52 CET je Uwe Kleine-K=C3=B6ni=
g
> napisal(a):
> > Hello Cl=C3=A9ment,
> >
> > On Mon, Nov 04, 2019 at 07:07:00PM +0100, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > On Mon, 4 Nov 2019 at 09:24, Uwe Kleine-K=C3=B6nig
> > >
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Sun, Nov 03, 2019 at 09:33:30PM +0100, Cl=C3=A9ment P=C3=A9ron w=
rote:
> > > > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > >
> > > > > H6 PWM core needs bus clock to be enabled in order to work.
> > > > >
> > > > > Add an optional probe for it and a fallback for previous
> > > > > bindings without name on module clock.
> > > > >
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > > ---
> > > > >
> > > > >  drivers/pwm/pwm-sun4i.c | 36 +++++++++++++++++++++++++++++++++++=
+
> > > > >  1 file changed, 36 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > > index d194b8ebdb00..b5e7ac364f59 100644
> > > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > > @@ -78,6 +78,7 @@ struct sun4i_pwm_data {
> > > > >
> > > > >  struct sun4i_pwm_chip {
> > > > >
> > > > >       struct pwm_chip chip;
> > > > >
> > > > > +     struct clk *bus_clk;
> > > > >
> > > > >       struct clk *clk;
> > > > >       struct reset_control *rst;
> > > > >       void __iomem *base;
> > > > >
> > > > > @@ -367,6 +368,31 @@ static int sun4i_pwm_probe(struct platform_d=
evice
> > > > > *pdev)> >
> > > > Adding more context here:
> > > > |       pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > > > |
> > > > >       if (IS_ERR(pwm->clk))
> > > > >
> > > > >               return PTR_ERR(pwm->clk);
> > > > >
> > > > > +     /* Get all clocks and reset line */
> > > > > +     pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
> > > > > +     if (IS_ERR(pwm->clk)) {
> > > > > +             dev_err(&pdev->dev, "get clock failed %ld\n",
> > > > > +                     PTR_ERR(pwm->clk));
> > > > > +             return PTR_ERR(pwm->clk);
> > > > > +     }
> > > >
> > > > I guess you want to drop the first assignment to pwm->clk.
> > >
> > > devm_clk_get_optional will return NULL if there is no entry, I don't
> > > get where I need to drop it assignment.
> >
> > With your patch the code looks as follows:
> >
> >       pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> >       if (IS_ERR(pwm->clk))
> >               return PTR_ERR(pwm->clk);
> >
> >       /* Get all clocks and reset line */
> >       pwm->clk =3D devm_clk_get_optional(&pdev->dev, "mod");
>
> Actually, it's the other way around, e.g. "mod" clock is checked first.

The first devm_clk_get is indeed wrong, I will remove it!

>
> >       ...
> >
> > The assignment to pwm->clk above the comment is the one I suggested to
> > drop.
>
> Neither can be dropped. DT files for other SoCs don't have clock-names
> property, so search for "mod" clock will fail and then fallback option wi=
thout
> name is used.
>
> Best regards,
> Jernej
>
> >
> > > > > +     /* Fallback for old dtbs with a single clock and no name */
> > > > > +     if (!pwm->clk) {
> > > > > +             pwm->clk =3D devm_clk_get(&pdev->dev, NULL);
> > > > > +             if (IS_ERR(pwm->clk)) {
> > > > > +                     dev_err(&pdev->dev, "get clock failed %ld\n=
",
> > > > > +                             PTR_ERR(pwm->clk));
> > > > > +                     return PTR_ERR(pwm->clk);
> > > > > +             }
> > > > > +     }
> > > >
> > > > There is a slight change of behaviour if I'm not mistaken. If you h=
ave
> > > >
> > > > this:
> > > >         clocks =3D <&clk1>;
> > > >         clock-names =3D "mod";
> > > >
> > > >         pwm {
> > > >
> > > >                 compatible =3D "allwinner,sun4i-a10-pwm"
> > > >                 clocks =3D <&clk2>;
> > > >
> > > >         }
> > > >
> > > > you now use clk1 instead of clk2 before.
> > > >
> > > > Assuming this is only a theoretical problem, at least pointing this=
 out
> > > > in the commit log would be good I think.
> > >
> > > Yes it's correct and as you said the driver don't check for a correct
> > > device tree, that why it's now optional probe.
> > > Let's assume that's the device-tree is correct, I will add a comment
> > > in the commit log.
> >
> > If the mod clock was shared by all peripherals on the bus this would be
> > IMHO quite elegant. Probably it depends on what you mean by saying
> > "incorrect" if this snippet is incorrect. (It can be part of a valid dt=
b
> > that even complies to the binding documentation. However that's not how
> > any existing allwinner hardware looks like.) But let's stop arguing as
> > we agree it's a corner case and if you mention it in the commit log
> > we're both happy.
> >
> > > > What is that clock used for? Is it required to access the hardware
> > > > registers? Or is it only required while the PWM is enabled? If so y=
ou
> > > > could enable the clock more finegrainded.
> > >
> > > Regarding the datasheet it's required to access the hardware.
> > > page 261 :
> > > https://linux-sunxi.org/File:Allwinner_H6_V200_User_Manual_V1.1.pdf
> > So enabling the bus clock is called "open APB1 Bus gating" in that
> > manual? If I understand that correctly the bus clock then only need to
> > be on while accessing the registers and could be disabled once the
> > hardware is programmed and running.
> >
> > Can you please describe that in a comment. Something like:
> >
> >       /*
> >        * We're keeping the bus clock on for the sake of simplicity.
> >        * Actually it only needs to be on for hardware register
> >        * accesses.
> >        */
> >
> > should be fine. This way it's at least obvious that the handling could
> > be improved.
> >
> > Best regards
> > Uwe
>
>
>
>
