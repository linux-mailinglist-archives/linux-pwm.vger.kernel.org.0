Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D810183117
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 14:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfHFMBc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 08:01:32 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33992 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFMBb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Aug 2019 08:01:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so5515177oil.1;
        Tue, 06 Aug 2019 05:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCdcvTi4EtCG1tpy5aHZlX8nMWD9zO1iDHZPMFLJdQY=;
        b=IYWW092zdYQFyxJCoZEHGt9WnUzgUB7tR7apA1Yjui8unJgfxxLiCq9yMxscJJ43T/
         2pzYHrfkYP3kZziEUg54VfiJCNDwz7qGlNze7Vpat5yTWeWJogVNkDl2nUfFXOdXeEoy
         r//mCxCReE3zalwPbxSpweMxfbSTk8CNo+rUlm0LACNPPl5bri3xkQtY/Y7qQIyT1J4n
         Bh3uWOilGtiyCKFXRye1n+BsTEfevGLGw11LZNWZBLf++AUYN5bA4JdOA3bCcilYZiCR
         vuK8Kr2PlmMIH1PBQnLvO/IC/AN/MLpPmK5iKCwieiz3gzKh1QqaiR21UDoPbJOC/cgO
         NIfQ==
X-Gm-Message-State: APjAAAWP571cptLZidY8siVOd9Gj/gRZw76KD/hJmWeRwQYbawfb057B
        uiTvjQamZY+YFMcxZL7DbVWrET70tcdk4D4X5PU=
X-Google-Smtp-Source: APXvYqzbVofQFNU84ewJ0VqF7ayxSoWIfRRYLegv+gXGaZsT8e/x5Fc4jZwLnXJsKAE4AqGMwebPQLeBx8/x3Xb4Fpg=
X-Received: by 2002:a05:6808:3c5:: with SMTP id o5mr2432490oie.102.1565092890301;
 Tue, 06 Aug 2019 05:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdUAVGbvn0D=UkqhY6RpO70MR-4GBC8i931a+fV9f6+njg@mail.gmail.com> <OSBPR01MB4536870EEEE634B06199722ED8D50@OSBPR01MB4536.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4536870EEEE634B06199722ED8D50@OSBPR01MB4536.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 14:01:18 +0200
Message-ID: <CAMuHMdUM6ykuSZzujoU+9A52O=Vj=M9hHaVm95MszpKKv74j4w@mail.gmail.com>
Subject: Re: [PATCH RFC 3/7] pinctrl: sh-pfc: Rollback to mux if requires when
 the gpio is freed
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Shimoda-san,

On Tue, Aug 6, 2019 at 1:38 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Tuesday, August 6, 2019 6:03 PM
> > On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > R-Car PWM controller requires the gpio to output zero duty,
> > > this patch allows to roll it back from gpio to mux when the gpio
> > > is freed.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> > > +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> > > @@ -26,6 +26,7 @@
> > >  #include "../pinconf.h"
> > >
> > >  struct sh_pfc_pin_config {
> > > +       unsigned int mux_mark;
> >
> > Due to padding, adding this field will increase memory consumption by
> > 6 bytes per pin.
>
> I see.
>
> > Probably sh_pfc_pin_group.{pins,mux} should be changed from unsigned int
> > to u16, but that's out of scope for this patch.
>
> I got it.

For now, please don't worry about it. I can make that change later, as it will
affect all drivers.

> > > @@ -353,6 +354,15 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
> > >         spin_lock_irqsave(&pfc->lock, flags);
> > >
> > >         for (i = 0; i < grp->nr_pins; ++i) {
> > > +               int idx = sh_pfc_get_pin_index(pfc, grp->pins[i]);
> > > +               struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
> > > +
> > > +               /*
> > > +                * This doesn't assume the order which gpios are enabled
> > > +                * and then mux is set.
> >
> > I'm sorry, I don't understand what you mean?
> > Can you please reword or elaborate?
>
> I was also difficult to remember what I meant...
> Anyway, this meant,
>  1) if a device has the default pinctrl-0 property, the set_mux() ops is called
>     before the device driver's probe() function is called by pinctrl_bind_pins() first,
>  2) so that any device drivers cannot call gpiod_get() before the 1).
>
> However, this comments don't cover an imbalance pinctrl/gpio handling.
> For example (as pseudo):
>  - SCIF driver uses SCIF2 pinctrl,
>  - but, IOMMU driver gets the SCIF2 pins before SCIF driver is probed.
>
> So, I'd like to revise the comments as following. What do you think?
>
> --
> This driver cannot manage both gpio and mux when the gpio pin
> is already enabled. So, this function failed.
> --
>
> > > +                */
> > > +               WARN_ON(cfg->gpio_enabled);
> >
> > Can this actually happen?
>
> This cannot happen actually.
>
> > Should this cause a failure instead?
>
> I think so.

OK.

> > > +       if (cfg->mux_set)
> > > +               sh_pfc_config_mux(pfc, cfg->mux_mark, PINMUX_TYPE_FUNCTION);
> >
> > Have you considered the case where more than one pin of a pinmux group
> > was used as a GPIO? In that case sh_pfc_gpio_disable_free() will be called
> > multiple times, possibly with the same mux_mark.
>
> I haven't considered the case. But, about the mux_mark, I checked the values and then
> they are not the same.

IC. At first I thought they were the internal enum for the whole pin group, but
I was wrong.
They are the mux *_MARK enu, which is unique for each pin/function combo.

> For example (debug printk patch):
> diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
> index bc29066..fdac71b 100644
> --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> @@ -349,7 +349,7 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
>         unsigned int i;
>         int ret = 0;
>
> -       dev_dbg(pctldev->dev, "Configuring pin group %s\n", grp->name);
> +       dev_info(pctldev->dev, "Configuring pin group %s\n", grp->name);
>
>         spin_lock_irqsave(&pfc->lock, flags);
>
> @@ -375,6 +375,7 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
>
>                 cfg->mux_set = true;
>                 cfg->mux_mark = grp->mux[i];
> +               dev_info(pctldev->dev, "%d: %x\n", i, cfg->mux_mark);
>         }
>
>  done:
> --
> 2.7.4
>
> For example (log):
> [    0.497647] sh-pfc e6060000.pin-controller: Configuring pin group scif2_data_a
> [    0.497711] sh-pfc e6060000.pin-controller: 0: 77b
> [    0.497715] sh-pfc e6060000.pin-controller: 1: 760

Thanks for checking!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
