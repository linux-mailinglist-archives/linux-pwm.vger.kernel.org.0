Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFB482E4A
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbfHFJDA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 05:03:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44463 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfHFJDA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Aug 2019 05:03:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id e189so65335826oib.11;
        Tue, 06 Aug 2019 02:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GoRchG32wK+57YIoB/Z9on0l1bvksRGyUq3cA7SW1Ug=;
        b=M1Efzxn/lnbz899QC/zzbyzktEj1S5YZzENxG16rgfKobpxh2FM3gQOJtdtwZBBuaD
         BK4JWONJ4p2tFMQ6CjdjlSfi6voUtUQeNyd3WT0hFuvaoWbYKDykswunNX4WUFROQwSM
         V+9iRE68s5QuKKaQF3gfG8yy24FpT9++HZwd1m9xJd5O0tRY5cq8g3TRbWtW6QQSKk87
         mEMzmvMkXWjhw8MP92bDlZc5jSVkIeMhoVnre5sZbkxUH+nbgRcEYRsB5ylJzWmzdJHU
         kdWJiZsQ5ThRnh0vVGSI1MP/TgqgGU1jTqIyshEI+dkPt9vvv27q4ZeIDpyReTnuXRAI
         KHZQ==
X-Gm-Message-State: APjAAAXJEEVImTRcCm10hLhvaw3CojeQM5Pz7hynmIekYmPi4AIRHK1q
        KHpm5ewgMqxirepOnm5h/OnlaOe8rcD9et47fqo=
X-Google-Smtp-Source: APXvYqxzGJiTERBTt/7M/HP05WnrfispPCw7mN7L6XurRbVgKYHfbRY7XKsnhCbEImXgw55FG3o+3I2RUKDca/aHS2k=
X-Received: by 2002:a05:6808:3c5:: with SMTP id o5mr1947467oie.102.1565082179009;
 Tue, 06 Aug 2019 02:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 11:02:47 +0200
Message-ID: <CAMuHMdUAVGbvn0D=UkqhY6RpO70MR-4GBC8i931a+fV9f6+njg@mail.gmail.com>
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

On Mon, Jul 8, 2019 at 11:08 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> R-Car PWM controller requires the gpio to output zero duty,
> this patch allows to roll it back from gpio to mux when the gpio
> is freed.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> @@ -26,6 +26,7 @@
>  #include "../pinconf.h"
>
>  struct sh_pfc_pin_config {
> +       unsigned int mux_mark;

Due to padding, adding this field will increase memory consumption by
6 bytes per pin.
Probably sh_pfc_pin_group.{pins,mux} should be changed from unsigned int
to u16, but that's out of scope for this patch.

>         bool mux_set;
>         bool gpio_enabled;
>  };
> @@ -353,6 +354,15 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
>         spin_lock_irqsave(&pfc->lock, flags);
>
>         for (i = 0; i < grp->nr_pins; ++i) {
> +               int idx = sh_pfc_get_pin_index(pfc, grp->pins[i]);
> +               struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
> +
> +               /*
> +                * This doesn't assume the order which gpios are enabled
> +                * and then mux is set.

I'm sorry, I don't understand what you mean?
Can you please reword or elaborate?

> +                */
> +               WARN_ON(cfg->gpio_enabled);

Can this actually happen?
Should this cause a failure instead?

> +
>                 ret = sh_pfc_config_mux(pfc, grp->mux[i], PINMUX_TYPE_FUNCTION);
>                 if (ret < 0)
>                         goto done;
> @@ -364,6 +374,7 @@ static int sh_pfc_func_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
>                 struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
>
>                 cfg->mux_set = true;
> +               cfg->mux_mark = grp->mux[i];
>         }
>
>  done:
> @@ -417,6 +428,9 @@ static void sh_pfc_gpio_disable_free(struct pinctrl_dev *pctldev,
>
>         spin_lock_irqsave(&pfc->lock, flags);
>         cfg->gpio_enabled = false;
> +       /* If mux is already set, this configure it here */

configures

> +       if (cfg->mux_set)
> +               sh_pfc_config_mux(pfc, cfg->mux_mark, PINMUX_TYPE_FUNCTION);

Have you considered the case where more than one pin of a pinmux group
was used as a GPIO? In that case sh_pfc_gpio_disable_free() will be called
multiple times, possibly with the same mux_mark.

I don't think this will cause issues, though.

>         spin_unlock_irqrestore(&pfc->lock, flags);
>  }

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
