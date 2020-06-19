Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA4200221
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2020 08:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgFSGrF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Jun 2020 02:47:05 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44476 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgFSGrC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Jun 2020 02:47:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id x202so7564988oix.11;
        Thu, 18 Jun 2020 23:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obSLRSGUdtL1aSsm/uf2ID8ufq/D3V0gORBSH0QDde0=;
        b=n91YsgLoij0lvALblDHm4hqnsTAVBPsYQmh1EltPTykSDCDJhz2m8IbjCSEAIo9Lcf
         Q73OLP9sOOub7cRl2Byb612G7Y18u/U1SHJxGdixhUV2xj53ajhse84+Zo8Gui7/SjzQ
         PFTivm9BkDxkS0YxcS/WdXGz8Ba0TULkymYeUge1NbQz7LFmaNfo4i85RHZoEdVGfGpB
         Fa6rFLH+wQAuCEWwPb9Px7BAyDfuN3uwwi8tOfB1As+zz8/GFCcgLgA8JLlONnLc9LgK
         92TTko4nNcO3+Yd/+wvfh6P7SvB86bTBxYWqsdgQ0xilwAdhgLNaVj3MHfeldlhf9C5r
         Og0w==
X-Gm-Message-State: AOAM533iOCMXjlprY/ccrPfNpGKT6MOOS0AOUHYREER0unvcmhinHJT1
        3jrjDaCW1TgnXXbNVu5TFFYuytb+UG+hFSNqTpfhqA==
X-Google-Smtp-Source: ABdhPJyM/HIf32MqGOd016BpCM/MH9LqQadoHNgeCyy6v07UdPWFKyqvPx+AZn/Je52XhLCCn8CJo6EWO0pqYb4es34=
X-Received: by 2002:aca:849:: with SMTP id 70mr1908872oii.153.1592549221910;
 Thu, 18 Jun 2020 23:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-2-thierry.reding@gmail.com> <CAMuHMdWaKgNOz02eVXkFnGRpsjdNNGVtuCf0setigH31-9aXQg@mail.gmail.com>
 <20200618200507.GA2905@codeaurora.org>
In-Reply-To: <20200618200507.GA2905@codeaurora.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Jun 2020 08:46:50 +0200
Message-ID: <CAMuHMdUv8xic7L=UJzCmJ+WepvADBYvcaPCmaN0BzCvcbgvx6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: ssd1307fb: Print PWM period using 64-bit
 format specifier
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Guru,

On Thu, Jun 18, 2020 at 10:05 PM Guru Das Srinagesh
<gurus@codeaurora.org> wrote:
> On Wed, Jun 17, 2020 at 09:18:34AM +0200, Geert Uytterhoeven wrote:
> > On Mon, Jun 15, 2020 at 4:17 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > > The PWM core will soon change the duty cycle and period of PWMs to 64
> > > bits to allow for a broader range of values. Use a 64-bit format
> > > specifier to avoid a warning when that change is made.
> > >
> > > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> >
> > > --- a/drivers/video/fbdev/ssd1307fb.c
> > > +++ b/drivers/video/fbdev/ssd1307fb.c
> > > @@ -312,7 +312,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
> > >                 /* Enable the PWM */
> > >                 pwm_enable(par->pwm);
> > >
> > > -               dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
> > > +               dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.\n",
> > >                         par->pwm->pwm, pwm_get_period(par->pwm));
> > >         }
> >
> > This change must be done together with changing the return type of
> > pwm_get_period(), else you will get a compiler warning, and will print a
> > bogus value.
>
> Hi Geert,
>
> Yes, this is already being done in the patch series [1] that forms the
> base for this specific patch.
>
> [1] https://lore.kernel.org/lkml/64f9ba1c9d6c49a397f12846493707883cee430f.1591136989.git.gurus@codeaurora.org/

IC, but the "will soon" suggested otherwise.
In any case, not combining both into a single patch causes a bisection
regression, regardless of the order in which they are applied.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
