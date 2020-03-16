Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106F7186ED3
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 16:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbgCPPmn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 16 Mar 2020 11:42:43 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39470 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731744AbgCPPmn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 11:42:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id d63so18254220oig.6;
        Mon, 16 Mar 2020 08:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XywL93GNIBZ8gRLKR1H3RwOaGbS2IwA5VZm4LJMEXBU=;
        b=WortaCuVNot1VqFBwvYl/jWmG+M0c9HVAZMoYi6zLCZl4ELDpzqG4BywqyXwmwXj5v
         WjScr2syiieeh3oNXn2SA4GzAs2MA9OXnyfAcSAPtrUWumMEPhtnqxAfOzzz/5gDGXpi
         rM0qbHUex+ZObQSf4hp/2e3dPxZ4MqYSaD3+Fa/iEydaEWnqelP/oZniVy7tlJV5Rm5T
         ONa79bum24llK8s3phE5dGNR+cJL8bwI1g4ET3xSLnw1+eWV97YrGHswYLU88km04Hmi
         ek5JBf20CH1GisV85Wq4RPTI1KHV3pqihAGOoi9DlslLNmeme3lH91yRd5MipfFz7/Av
         D45A==
X-Gm-Message-State: ANhLgQ2y35Us/mr3jCfiVBcrR5IweTceegBuIFAPgxT1f5EdmuyduTB2
        m+DAJbBIG4iGI1xAqmgqbn0DQFLZw4glzbLAs0E=
X-Google-Smtp-Source: ADFU+vswFKiv/QLJB5qQp0kVOY4SDPiUqyu2V1iAHSbZxHlh02o3MjbBS5TwP/MXGm+ZdJnFhB0JqQVzo9UJW73mmo4=
X-Received: by 2002:aca:ad93:: with SMTP id w141mr147327oie.54.1584373362766;
 Mon, 16 Mar 2020 08:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-2-geert+renesas@glider.be> <20200316154008.e4yfe2bdeuju5e4g@pengutronix.de>
In-Reply-To: <20200316154008.e4yfe2bdeuju5e4g@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Mar 2020 16:42:31 +0100
Message-ID: <CAMuHMdURCdwZD+FT3jxFzrZEwaMsZpp6HcD3_CwtFBq8E72vyA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pwm: rcar: Fix late Runtime PM enablement
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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

On Mon, Mar 16, 2020 at 4:40 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Mon, Mar 16, 2020 at 11:32:14AM +0100, Geert Uytterhoeven wrote:
> > Runtime PM should be enabled before calling pwmchip_add(), as PWM users
> > can appear immediately after the PWM chip has been added.
> > Likewise, Runtime PM should be disabled after the removal of the PWM
> > chip.
> >
> > Fixes: ed6c1476bf7f16d5 ("pwm: Add support for R-Car PWM Timer")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/pwm/pwm-rcar.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
> > index 2685577b6dd45be7..7ab9eb6616d950cb 100644
> > --- a/drivers/pwm/pwm-rcar.c
> > +++ b/drivers/pwm/pwm-rcar.c
> > @@ -229,24 +229,28 @@ static int rcar_pwm_probe(struct platform_device *pdev)
> >       rcar_pwm->chip.base = -1;
> >       rcar_pwm->chip.npwm = 1;
> >
> > +     pm_runtime_enable(&pdev->dev);
> > +
> >       ret = pwmchip_add(&rcar_pwm->chip);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
> > +             pm_runtime_disable(&pdev->dev);
> >               return ret;
> >       }
> >
> > -     pm_runtime_enable(&pdev->dev);
> > -
>
> Wouldn't it be wiser to do the pm_runtime_enable in .request, or even in
> .apply when enabled=true?

Wouldn't that mean that the device cannot be powered down until the first
time a PWM is used?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
