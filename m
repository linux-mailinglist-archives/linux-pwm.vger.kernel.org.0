Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC04C1FC715
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jun 2020 09:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgFQHSr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 17 Jun 2020 03:18:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45569 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHSq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 17 Jun 2020 03:18:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id p70so881530oic.12;
        Wed, 17 Jun 2020 00:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbNjBfQChq86KCqMUr/PrecFByo1h6xqIQX3C8q/kck=;
        b=M5MzLtCL+GbFcqDPsSaW+l0ywkmX+pqSMG1hSoUoYkGFrOe/4ZpZ/6Z9fbQJhDVaR+
         Oee8mcqylWMrUhBZNPNlAuQbsw/b8i02/TRRUFnyl21XIhPPvZu4D4d7xhTj+yAgGafH
         q4gGOZdEKkDy5XycOMftdP2QXVf5TmPoRLPn2wdZpi+L73uGGkUayoFq8g9H0V4R1v/4
         sS7a/8cEkr4UKU0dYv8AEqA98gZSfefkhn4wf1YWBA4czNqBrdYyMIBOO9oa4UpcFeTq
         Ex4rexyWW4y0inybMYWHV5WJAIW+8oBN/e6foA9pQqtO27IA5EeJdvRkVo8lhkc8MuUe
         dFMA==
X-Gm-Message-State: AOAM532KOTjlqo2djycUfoGF2FZoph5UYMZB0HHsXL1r+sbFHsDQOJfG
        N2mPTz0EeRIw5VTDUQZJVw06owXD0xAnPxkiDGc=
X-Google-Smtp-Source: ABdhPJy2BJl8lH7KWshHjFs2QyMUqtCXHxi/voSfLuUWyFefGalG6ul8iDspOWJlZF5Q8XoTbLrAz6CFfpwp4GQnVjI=
X-Received: by 2002:aca:849:: with SMTP id 70mr6140466oii.153.1592378325516;
 Wed, 17 Jun 2020 00:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200615141606.2814208-1-thierry.reding@gmail.com> <20200615141606.2814208-2-thierry.reding@gmail.com>
In-Reply-To: <20200615141606.2814208-2-thierry.reding@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 17 Jun 2020 09:18:34 +0200
Message-ID: <CAMuHMdWaKgNOz02eVXkFnGRpsjdNNGVtuCf0setigH31-9aXQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] video: ssd1307fb: Print PWM period using 64-bit
 format specifier
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On Mon, Jun 15, 2020 at 4:17 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> The PWM core will soon change the duty cycle and period of PWMs to 64
> bits to allow for a broader range of values. Use a 64-bit format
> specifier to avoid a warning when that change is made.
>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -312,7 +312,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
>                 /* Enable the PWM */
>                 pwm_enable(par->pwm);
>
> -               dev_dbg(&par->client->dev, "Using PWM%d with a %dns period.\n",
> +               dev_dbg(&par->client->dev, "Using PWM%d with a %lluns period.\n",
>                         par->pwm->pwm, pwm_get_period(par->pwm));
>         }

This change must be done together with changing the return type of
pwm_get_period(), else you will get a compiler warning, and will print a
bogus value.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
