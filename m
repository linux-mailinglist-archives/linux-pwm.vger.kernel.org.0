Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4390EEE69A
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfKDRuT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Nov 2019 12:50:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38666 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfKDRuT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 12:50:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id v9so18169431wrq.5;
        Mon, 04 Nov 2019 09:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m94FYTExTuK3Mfiu36VL06K2ivGj3SQOoQZxQ/LDw2c=;
        b=cr0DotEmhjNmnCMQXTyhOY2KyKrQak+kBGAXu2Kxf/WFotSGU/E3UHz3vLBBzElv9Z
         RXahCdVzNwqaWjNR1NVUnULozga+oIO7hfV8YVpOF+S8pBiBOkJAb/kWeEFj0ydy2pXQ
         CEV0VElav1xCD0qfDPwQie5UoD/aL3xvbRSRKCwgvRxDEmGSfd7O6irvCWfYX5328Ndn
         o0scwGV+72tfu0tL0NxZ3K+nx/+W2rt5nUF1EQgKT3ztd+wMp+RbWM419FDsmmMqgPzH
         xOJMsOvf4U9netx0WYcWLaDvS/F+nM2PZ4dAYLYNfsbKuwmtF/jCzXcQ44af+lTsErYl
         ELmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m94FYTExTuK3Mfiu36VL06K2ivGj3SQOoQZxQ/LDw2c=;
        b=mrcHKJ+wOkFiKEBcUvprKHrrR9rG+jEOm3UOp7sY9390K/0LFPegY73Vsv3c0t7Cdn
         0AEkvz1rKkwQcHtsr19kZ13o+he75jfKVNXBq++lCNVXvz21H56ovakHopJeGmka5Lck
         L9aIp/Zo+hs+ojpThtJqdmyGqPztxWNKLn4HBwbotoRl8oV8ylgc/5wkwdBJVqGAYxyn
         yjLlDEqeg1TUbApjoXSVQtJbYdr5DusDWp0UaYbgd4u0rTrX+Hw5riaz5akJq4sb2AHH
         5vPQLTYNBKllO+FtBjyjB2t01YNkI4eo+/pRcORphLem9Fcv5rEZne2Z63sywVaKmstV
         akHg==
X-Gm-Message-State: APjAAAUrIyIeNkk4VOg/vLvAocvDL9t+MXRdUc92q8Wj459MUKYkFhVQ
        RTHYErIZ27GdLUz6wqTJQNunlByHisI4s3j0sIs=
X-Google-Smtp-Source: APXvYqwlmheL10KRkZaC8TiycingWU/KdZ9jEWxiWxUEKoexcK5EdWf6Y7aSbQLpvNsAFVsuhvFwI6EPxiqiRGviaUM=
X-Received: by 2002:a5d:4b42:: with SMTP id w2mr23682320wrs.360.1572889815473;
 Mon, 04 Nov 2019 09:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-3-peron.clem@gmail.com>
 <20191104081157.373v22atswsaktbe@pengutronix.de>
In-Reply-To: <20191104081157.373v22atswsaktbe@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 4 Nov 2019 18:50:04 +0100
Message-ID: <CAJiuCcfEjE9qWqKyv5kyW_hTwO=L8eCuSoBEBvLZYm9JAV0O-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] pwm: sun4i: Add an optional probe for reset line
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
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 4 Nov 2019 at 09:11, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> adding Philipp Zabel (=3D reset controller maintainer) to Cc: and so I'm
> not stripping the uncommented parts of the patch.
>
> On Sun, Nov 03, 2019 at 09:33:29PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM core needs deasserted reset line in order to work.
> >
> > Add an optional probe for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/pwm/pwm-sun4i.c | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 6f5840a1a82d..d194b8ebdb00 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pwm.h>
> > +#include <linux/reset.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/time.h>
> > @@ -78,6 +79,7 @@ struct sun4i_pwm_data {
> >  struct sun4i_pwm_chip {
> >       struct pwm_chip chip;
> >       struct clk *clk;
> > +     struct reset_control *rst;
> >       void __iomem *base;
> >       spinlock_t ctrl_lock;
> >       const struct sun4i_pwm_data *data;
> > @@ -365,6 +367,20 @@ static int sun4i_pwm_probe(struct platform_device =
*pdev)
> >       if (IS_ERR(pwm->clk))
> >               return PTR_ERR(pwm->clk);
> >
> > +     pwm->rst =3D devm_reset_control_get_optional(&pdev->dev, NULL);
> > +     if (IS_ERR(pwm->rst)) {
> > +             if (PTR_ERR(pwm->rst) =3D=3D -EPROBE_DEFER)
> > +                     return PTR_ERR(pwm->rst);
> > +             dev_info(&pdev->dev, "no reset control found\n");
>
> I would degrade this to a dev_dbg. Otherwise this spams the log for all
> unaffected machines. devm_reset_control_get_optional() is defined in a
> section that has a comment "These inline function calls will be removed
> once all consumers have been moved over to the new explicit API.", so I
> guess you want devm_reset_control_get_optional_exclusive or even
> devm_reset_control_get_optional_shared here.
Thanks for pointing this, I will change it.

>
> @Philipp: maybe a check in checkpatch that warns about introduction of
> such new instances would be good?!
>
> > +     }
> > +
> > +     /* Deassert reset */
> > +     ret =3D reset_control_deassert(pwm->rst);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "Cannot deassert reset control\n");
> > +             return ret;
> > +     }
> > +
> >       pwm->chip.dev =3D &pdev->dev;
> >       pwm->chip.ops =3D &sun4i_pwm_ops;
> >       pwm->chip.base =3D -1;
> > @@ -377,19 +393,31 @@ static int sun4i_pwm_probe(struct platform_device=
 *pdev)
> >       ret =3D pwmchip_add(&pwm->chip);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
> > -             return ret;
> > +             goto err_pwm_add;
> >       }
> >
> >       platform_set_drvdata(pdev, pwm);
> >
> >       return 0;
> > +
> > +err_pwm_add:
> > +     reset_control_assert(pwm->rst);
> > +
> > +     return ret;
> >  }
> >
> >  static int sun4i_pwm_remove(struct platform_device *pdev)
> >  {
> >       struct sun4i_pwm_chip *pwm =3D platform_get_drvdata(pdev);
> > +     int ret;
> > +
> > +     ret =3D pwmchip_remove(&pwm->chip);
> > +     if (ret)
> > +             return ret;
> > +
> > +     reset_control_assert(pwm->rst);
> >
> > -     return pwmchip_remove(&pwm->chip);
> > +     return 0;
> >  }
> >
> >  static struct platform_driver sun4i_pwm_driver =3D {
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
