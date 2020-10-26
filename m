Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18AF298F97
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Oct 2020 15:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781644AbgJZOlK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Oct 2020 10:41:10 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:45746 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781769AbgJZOlK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Oct 2020 10:41:10 -0400
Received: by mail-ej1-f67.google.com with SMTP id dt13so13901026ejb.12
        for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2020 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDYrLy8MUIe7IoCpuFE7hK+pFTNu/TtbAvwKtQzdYkQ=;
        b=sLh9lD/aEhUvcqIQXEWD7t5aDKLUDdR+uqzwDNqjQgdKANR+b3CYvFxcSZbZoia/vr
         4pV66OyowpCbPkWGTKaHkNzEXXDXDLVs/2Au+libKtUB44Y6qk/gYUIc1eebF4oFDt79
         tTk8TkWc5arOSKs7iOkVrAE4WBBMtrp5xmxj63/dFYZRAqMhUvGZwfvkRD1JUaLztwtP
         fySCKqaIs4Gnn3iOsEGE1OUB2KaEzABTkDBjuG/jvsvUkYTH2qRjZb0Fsk2Hc5H1w8Xh
         zWDPI2Bf93CUBZCgaf7WwQXZOvxC0mzLBEEwrf0fS1WQ4fobts9ef4tCi6yBGIBGpTF9
         InFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDYrLy8MUIe7IoCpuFE7hK+pFTNu/TtbAvwKtQzdYkQ=;
        b=YaWo/ZlV7zCuefTEU1B9lyeglzFvBBli3LLabsGve+N6g2mHa8PbxkE6ZFv3MUYIWd
         lmOEUivBFtRH82SgulSClXB6ubrFCz48iYvahXSuEC/7CJlXb37/MAUJwYm0KnTi55mx
         kUSNmHvsTPJYXrtHoQEJhlmOtDUKRyzhi8TSX6ACkg+iUlk7LeMtk3AKWDpc3/oxxjgF
         rtv+bwhtD/9y3F9NNkr7L5wAgngyUlTHJTazpTyp/uewcdsPWDi7RA8YeUstahtt4d+2
         8O8F4XPZXXeQKrjdEP+1cVruw5IfftZGefE1z9bhjA/jdiQfBUg6v0eD32Z1pm31Yypf
         PaGQ==
X-Gm-Message-State: AOAM5302gpbxiIPPzoQqD1L0n4yrkwks2UUrzEJRB4yCQZ+gOAuMyPH0
        GN7BBTYjllZ3qHflzJ4ZHFBKZCDF6Ofi1Jw5hG9YWg==
X-Google-Smtp-Source: ABdhPJxQDYouxITNJmwaaThzvVD1XAnzZMqtFtlNEJHpFQRcHDR6KLCgV7rHNgQP+OYdjgQSxIklzpD34tDNLPLfNDQ=
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr15297794eje.363.1603723266555;
 Mon, 26 Oct 2020 07:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201022155858.20867-1-nsaenzjulienne@suse.de> <20201022155858.20867-4-nsaenzjulienne@suse.de>
In-Reply-To: <20201022155858.20867-4-nsaenzjulienne@suse.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 26 Oct 2020 15:40:55 +0100
Message-ID: <CAMpxmJXw12hKYCuMDjG-Ns6n=mXmr4B2x3HJaAJ19wH_xDUMag@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] gpio: raspberrypi-exp: Release firmware handle
 on unbind
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>, wahrenst@gmx.net,
        Linux Input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 22, 2020 at 5:59 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Upon unbinding the device make sure we release RPi's firmware interface.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/gpio/gpio-raspberrypi-exp.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-raspberrypi-exp.c
> index bb100e0124e6..c008336e1131 100644
> --- a/drivers/gpio/gpio-raspberrypi-exp.c
> +++ b/drivers/gpio/gpio-raspberrypi-exp.c
> @@ -231,8 +231,19 @@ static int rpi_exp_gpio_probe(struct platform_device *pdev)
>         rpi_gpio->gc.get = rpi_exp_gpio_get;
>         rpi_gpio->gc.set = rpi_exp_gpio_set;
>         rpi_gpio->gc.can_sleep = true;
> +       platform_set_drvdata(pdev, rpi_gpio);
>
> -       return devm_gpiochip_add_data(dev, &rpi_gpio->gc, rpi_gpio);
> +       return gpiochip_add_data(&rpi_gpio->gc, rpi_gpio);
> +}
> +
> +static int rpi_exp_gpio_remove(struct platform_device *pdev)
> +{
> +       struct rpi_exp_gpio *rpi_gpio = platform_get_drvdata(pdev);
> +
> +       gpiochip_remove(&rpi_gpio->gc);
> +       rpi_firmware_put(rpi_gpio->fw);
> +
> +       return 0;
>  }
>
>  static const struct of_device_id rpi_exp_gpio_ids[] = {
> @@ -247,6 +258,7 @@ static struct platform_driver rpi_exp_gpio_driver = {
>                 .of_match_table = of_match_ptr(rpi_exp_gpio_ids),
>         },
>         .probe  = rpi_exp_gpio_probe,
> +       .remove = rpi_exp_gpio_remove,
>  };
>  module_platform_driver(rpi_exp_gpio_driver);
>
> --
> 2.28.0
>

Why not introduce devm_rpi_firmware_get()? That would allow you to
keep the driver elegant without re-adding remove().

Bartosz
