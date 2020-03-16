Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A87186FA1
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbgCPQGY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 16 Mar 2020 12:06:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34231 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbgCPQGY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 12:06:24 -0400
Received: by mail-oi1-f193.google.com with SMTP id j5so2333921oij.1;
        Mon, 16 Mar 2020 09:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rc8x4JoRxpMLTtdaopLALsj2Woe1AItkKJ30SeIYoao=;
        b=MbPYj8Gsa4XtZZs4KTcP3eWKJjDUYzp95BDAnmcggCT52mr0picn0S71OvukyCmQIJ
         lYN6Dwf+dw0Pjz3sv4ejPKpAnm14KYN99EkjQIS+gEO08GRR/yxxEz5NEIjIZnx9Qkw3
         UujNFPG5T54rW9462BJmLG7YdxIGn/j2qean7M6OlfmlJn4YSwW6p3uuGgu9If1RDTnM
         l1DJCNTiAuBMbj+Fgc/ryuPnTg+a0w2TAviLcdY/eIPE03IodgRInRhWlt8L2jVt2iZ3
         nPl7ynheuHj1vpD5AT8J5gu36cakxF5bGvx1X0jyuI15OM1n0EpHtKZp+y9ZH7lQ5N+7
         PZ6A==
X-Gm-Message-State: ANhLgQ3mGTSaolZcN07vStQNMKS6tROBg7T2QZ4vQCjZqeeCj7I6yL7p
        1Xo6wCLT8WaVybOV/FrGx0mGNpe7jUs0T7/SynE=
X-Google-Smtp-Source: ADFU+vuHJNyTd8QtyAUKBd6EzrFf9wjQKv5v4tokGRQZy3awnusvju9feJSF/Cl/iaualsqpQvPqhNXDuVNI7CSxQt4=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr153675oig.153.1584374783404;
 Mon, 16 Mar 2020 09:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-3-geert+renesas@glider.be> <20200316160108.qylpoglfhhqvqqwt@pengutronix.de>
In-Reply-To: <20200316160108.qylpoglfhhqvqqwt@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Mar 2020 17:06:12 +0100
Message-ID: <CAMuHMdXP=QpOTpr8Ave0jvJ_KPPK5_R=_2F5JDNR7zvQk3W5PQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] pwm: renesas-tpu: Fix late Runtime PM enablement
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Mar 16, 2020 at 5:01 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Mar 16, 2020 at 11:32:15AM +0100, Geert Uytterhoeven wrote:
> > Runtime PM should be enabled before calling pwmchip_add(), as PWM users
> > can appear immediately after the PWM chip has been added.
> > Likewise, Runtime PM should always be disabled after the removal of the
> > PWM chip, even if the latter failed.
> >
> > Fixes: 99b82abb0a35b073 ("pwm: Add Renesas TPU PWM driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/pwm/pwm-renesas-tpu.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> > index 4a855a21b782dea3..8032acc84161a9dd 100644
> > --- a/drivers/pwm/pwm-renesas-tpu.c
> > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > @@ -415,16 +415,17 @@ static int tpu_probe(struct platform_device *pdev)
> >       tpu->chip.base = -1;
> >       tpu->chip.npwm = TPU_CHANNEL_MAX;
> >
> > +     pm_runtime_enable(&pdev->dev);
> > +
> >       ret = pwmchip_add(&tpu->chip);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "failed to register PWM chip\n");
> > +             pm_runtime_disable(&pdev->dev);
> >               return ret;
> >       }
> >
> >       dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
> >
> > -     pm_runtime_enable(&pdev->dev);
> > -
> >       return 0;
> >  }
> >
> > @@ -434,12 +435,10 @@ static int tpu_remove(struct platform_device *pdev)
> >       int ret;
> >
> >       ret = pwmchip_remove(&tpu->chip);
> > -     if (ret)
> > -             return ret;
> >
> >       pm_runtime_disable(&pdev->dev);
> >
> > -     return 0;
> > +     return ret;
> >  }
>
> Maybe I was a bit quick with my reply to the previous patch. I wonder if
> it is right to call pm_runtime_disable if pwmchip_remove failed?

While the pwmchip may still exist, the hardware is unmapped and no
longer accessible.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
