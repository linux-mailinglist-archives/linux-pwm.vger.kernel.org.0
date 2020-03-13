Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7553184A3B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2020 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMPIE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Mar 2020 11:08:04 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38465 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgCMPIE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Mar 2020 11:08:04 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so4727290qva.5
        for <linux-pwm@vger.kernel.org>; Fri, 13 Mar 2020 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SOOQlRRgzDlXulXRP8XRTEOcJ9Vn73cRLOCRvsC8k8k=;
        b=HCDXxq87aocDekRum4B/LXDX9SF1VI2U+P9KwqgPbKzYarJVy8BfnZxuSi0CfRdDOQ
         wY9ozP3dhoaFPnHp3A6aHq2UUlIzxamc3mePHE7ZWqPT8AuwxOPp9dN3BsM0r2lGdovp
         hVu3BuiuGkVp+gNVnOQB+HJ418WHtW/Klwdii3BwJaJ5vYFiLeY9x7jEzCW/5P8wzkJ6
         uil2kUfMIaGFP6fh8Hd8Hyfy78Y7eqqBYertUSSx6cXnsj9S9xLh8A/mcaXtPo20sNQI
         WBqbzzD6DjJzo338cFMAXIwuzeoW6LXILLI4NiHYnuAZZPwwmfPpgvbBLOa1RRize2hh
         WxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SOOQlRRgzDlXulXRP8XRTEOcJ9Vn73cRLOCRvsC8k8k=;
        b=hK5kjK14FHuZ4IaKuTsXRzqC4lm1zZE8x3eMNFf0lMrtxQv1eHkeAkTc7j0BjIMvlG
         3ZV1HndSm2BmtMFocBqrl/8w0Ycf0zkkqKhsJ4VZl/5jPgEtfDAEKhIm//c1AZumXu2h
         PrFpeX3Dnwdgx3iytRnaAspH83HjXFXPmnxpBe16CMcN1RFCoShE4BJX812H8SRtmEFX
         +qkwTiJHGMGOHlo23+XjkaQkg0Snnejl1qYlnzQMzWwSNhbAV9K2rOZeVcbTmZo7llYm
         0Lgu7sqIykSsjG7HpZjTVxvqOjY3NMaWccH1kx9bOwcOM34pOI3sCEhFTAGlltZZA5l/
         Va6w==
X-Gm-Message-State: ANhLgQ04jMpvKqO8jtdwWGgIqcAMwkJhmRILS1/kFf81t78WzxbQgi36
        F/6lHUxLHJezV5PWaLwl7oA3k+4MsJJLhUNwpyj5jw==
X-Google-Smtp-Source: ADFU+vsr4VvdVsme22IZrRr8kk4PH4RJ+PJzWO7SPXEh5yD8T3iDX7tF19eM4qjC0r319DA6yAPCfAMIyzX9zM+pp18=
X-Received: by 2002:a0c:9104:: with SMTP id q4mr4269547qvq.61.1584112082892;
 Fri, 13 Mar 2020 08:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200313034244.26336-1-chris.packham@alliedtelesis.co.nz>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 13 Mar 2020 16:07:49 +0100
Message-ID: <CAMpxmJVmspJG9tnv7tTrCP4DA5v4H_3P_4n-O-ZHkOKXgtXhLQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: avoid error message for optional IRQ
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pt., 13 mar 2020 o 04:42 Chris Packham
<chris.packham@alliedtelesis.co.nz> napisa=C5=82(a):
>
> platform_get_irq() will generate an error message if the requested irq
> is not present
>
>   mvebu-gpio f1010140.gpio: IRQ index 3 not found
>
> use platform_get_irq_optional() to avoid the error message being
> generated.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/gpio/gpio-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index d2b999c7987f..3c9f4fb3d5a2 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -1247,7 +1247,7 @@ static int mvebu_gpio_probe(struct platform_device =
*pdev)
>          * pins.
>          */
>         for (i =3D 0; i < 4; i++) {
> -               int irq =3D platform_get_irq(pdev, i);
> +               int irq =3D platform_get_irq_optional(pdev, i);
>
>                 if (irq < 0)
>                         continue;
> --
> 2.25.1
>

Patch applied, thanks!

Bartosz
