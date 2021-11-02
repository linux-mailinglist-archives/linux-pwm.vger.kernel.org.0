Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9625F4429A3
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Nov 2021 09:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKBIm1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 2 Nov 2021 04:42:27 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:36400 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhKBIm1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Nov 2021 04:42:27 -0400
Received: by mail-ua1-f44.google.com with SMTP id e10so36591796uab.3;
        Tue, 02 Nov 2021 01:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vtHObjXz/fBAC2wVKkwQJuDdB+3lhXmiXIXLkWkTc/M=;
        b=QRjdTDM7DGiXoPUsGRBHxFmP30NWTeiX+m8+IeTa/riO77kl5T24MmY8cVXrxXxslI
         OIyFVa7AjwOABF9Gqnz8/miuV2Uyx0Kou2g3SAWOM7ItKkQiIwauQTAe5jIxX9Ct+UPS
         13EzHDKOteOrg5SQsWYORbt71WTyxyGh9FsVTpq89YdyFb3gSWuBPqbmUJK3n8kW8EKN
         wCv+2O2TINOjQ5WHRT+UJwG5+E6UJB4/r5OrB1eXVd/pOI/7zHbptijEBRBLYl6u9Sdc
         1B2DbbzmhMufte6hTUM4e7CmLVJHd5h0BG+nip+kNHzSTqsG+jg+hdfIjEjAkQjkD+hN
         mtbA==
X-Gm-Message-State: AOAM531Yy2wADEp+VAhKDmGhl4Ufa+6j+oa1zFU8MkLAH6B6js7Epgbp
        Y2veFyerT4gKM0sw+ebH4aWlcNmeMXwKmw==
X-Google-Smtp-Source: ABdhPJzaZy7uW+fnKl5lEyCferMvOTPDGz+HhS234VwPunT4zBn9WGDVPTO3F5C7Ce+j1k1Ce6kkRA==
X-Received: by 2002:a05:6102:3750:: with SMTP id u16mr37365166vst.60.1635842391918;
        Tue, 02 Nov 2021 01:39:51 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id l8sm885718vse.30.2021.11.02.01.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 01:39:51 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id ay21so16052961uab.12;
        Tue, 02 Nov 2021 01:39:50 -0700 (PDT)
X-Received: by 2002:ab0:2bd2:: with SMTP id s18mr35296866uar.78.1635842390754;
 Tue, 02 Nov 2021 01:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <YX1KCclMB/HTZ22c@fedora>
In-Reply-To: <YX1KCclMB/HTZ22c@fedora>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Nov 2021 09:39:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5thqxWz37er3BHwqee_agvhHVDK5p8Hrx7HCKOdFjLA@mail.gmail.com>
Message-ID: <CAMuHMdW5thqxWz37er3BHwqee_agvhHVDK5p8Hrx7HCKOdFjLA@mail.gmail.com>
Subject: Re: [PATCH v3] backlight: lp855x: Switch to atomic PWM API
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Maíra,

On Sat, Oct 30, 2021 at 3:35 PM Maíra Canal <maira.canal@usp.br> wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
>
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

Thanks for your patch!

> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -233,9 +233,8 @@ static int lp855x_configure(struct lp855x *lp)
>
>  static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
>  {
> -       unsigned int period = lp->pdata->period_ns;
> -       unsigned int duty = br * period / max_br;
> -       struct pwm_device *pwm;
> +       struct pwm_device *pwm = NULL;
> +       struct pwm_state state;
>
>         /* request pwm device with the consumer name */
>         if (!lp->pwm) {
> @@ -245,18 +244,16 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
>
>                 lp->pwm = pwm;
>
> -               /*
> -                * FIXME: pwm_apply_args() should be removed when switching to
> -                * the atomic PWM API.
> -                */
> -               pwm_apply_args(pwm);
> +               pwm_init_state(lp->pwm, &state);
> +               state.period = lp->pdata->period_ns;
>         }
>
> -       pwm_config(lp->pwm, duty, period);
> -       if (duty)
> -               pwm_enable(lp->pwm);
> -       else
> -               pwm_disable(lp->pwm);
> +       pwm_get_state(lp->pwm, &state);
> +
> +       state.duty_cycle = br * state.period / max_br;

Above is a 64-by-32 division, which should not be open-coded, as
that will cause link failures on 32-bit platform (cfr. "undefined
reference to `__udivdi3'", as reported by the kernel test robot).
Please use div_u64() instead.

> +       state.enabled = state.duty_cycle;
> +
> +       pwm_apply_state(lp->pwm, &state);
>  }
>
>  static int lp855x_bl_update_status(struct backlight_device *bl)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
