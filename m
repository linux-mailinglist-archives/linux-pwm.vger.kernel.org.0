Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336E182E9A
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Aug 2019 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbfHFJVu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Aug 2019 05:21:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35394 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfHFJVu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Aug 2019 05:21:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so14122578otq.2;
        Tue, 06 Aug 2019 02:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urr6E8f3gQEUozPyIxS3wGCINMGR4U0Dy92WYUJwa6A=;
        b=jwmpHzrMwAkxqmtZTXORXLM5HmV/Zh36W5WeWm/Ep5JsN4M53Pf7yc4a02B6okZKjj
         4SPPw/mtHpQtzpAj6NZi8yddWdOtesC/W5F58UUA0LgEd41hHNdRzeRMcqtpmm2EK+vk
         Aglx3xjSqg6IZR+ox5xgXBJmx99gXo6aJRyiDEamnbrv88ZKb6QPdsjBH/QpYiUzeJNC
         e5lGgwKNiNVEHiA/LY5gp4O48TTcXT5rpQf/0qLYxQppdYY2CHBQHWh+6B/Xfw93GokP
         0wH/fI982NWgh6JAclG5qgPUUKm/9mr9M5yYy8sgbEKGxNuF94BRYMNXuyBmVz8GX9Mu
         X0Qg==
X-Gm-Message-State: APjAAAUwY6Edj4k8+09nklLuGjqDb3KYf2w+2iF5QOq5snboGcGnie03
        EaYlQJSti8PnI8jWqnxcvllDEMLMdoc5oANSQFg=
X-Google-Smtp-Source: APXvYqwzCrQrS16Rg2ZrR/of7O5i3ZAsfGUcS1N5wXJHkw2loOAj1aA4nb7ivT99DOzEtKA6UCHhV8gjN6lUiflXwhs=
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr2353199otc.250.1565083309368;
 Tue, 06 Aug 2019 02:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1562576868-8124-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 11:21:38 +0200
Message-ID: <CAMuHMdWSKAeiF4e9ZtyJq0Tejre35Ajok5Uf-ToDO4n+A6j6BQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] dt-bindings: pwm: rcar: Add specific gpios
 property to output duty zero
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
> The R-Car SoCs PWM Timer cannot output duty zero. So, this patch
> adds a specific gpio property to output it.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> @@ -26,6 +26,9 @@ Required Properties:
>  - pinctrl-0: phandle, referring to a default pin configuration node.
>  - pinctrl-names: Set to "default".
>
> +Optional properties:
> +- renesas,duty-zero-gpios: Specify GPIO for outputting duty zero.
> +
>  Example: R8A7743 (RZ/G1M) PWM Timer node
>
>         pwm0: pwm@e6e30000 {

I'm not so fond of adding a property to specify this explicitly: the PFC
driver already knows the mapping from the PWM output pin to the GPIO
number. However, I agree it is not easy to obtain this in a generic way.

For a PWM block with a single pin, it's easy: the pin you want to switch
between GPIO and pin function is the single pin in the single pin
control group specified in the board DT.

For blocks with multiple pins (e.g. SPI, UART), it is more complex, and
depends on the granularity of the pin control groups.
E.g. for UART, Renesas SoCs typically use 3 pin control groups ("data"
for RXD/TXD, "ctrl" for RTS/CTS, and "clk" for clock), and the pin
control driver (at least for sh-pfc) does not know which pin corresponds
to which GPIO inside each group.  Perhaps this information should be
added, with an API to retrieve it?

Anyone who has a good suggestion?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
