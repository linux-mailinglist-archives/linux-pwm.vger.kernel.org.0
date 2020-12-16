Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACB32DBEC3
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Dec 2020 11:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgLPKhQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Dec 2020 05:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgLPKhQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Dec 2020 05:37:16 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C07C06138C
        for <linux-pwm@vger.kernel.org>; Wed, 16 Dec 2020 02:35:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c7so24258995edv.6
        for <linux-pwm@vger.kernel.org>; Wed, 16 Dec 2020 02:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eY8G+T0bh4LN6y+cxgn4OGYQRTzOO5yifrdrjlzP4xo=;
        b=uevDLfBCO9sybtFyuI9g0Jolsd9EIBafOCpuddeg/PnCFSM0EIJre/eAALMhnVHa1v
         83YoKSEg+yR8N+zEKwZfM7aMKPgHaCtkF/tcxOzNRi5oANZuwiXZpP3j13oNGY09WA5v
         yXWleMUI961UX04vP2i+JyTBwDg3gmTwFBaJG21MyjvPIvS0q42WPOr9DxCrikyW+maS
         mLTgJuAGMEVcbKP4H62TiepZhlR8xOao/xrd8/bwY3yyBlt1asvDICr7SDTW2gcOQTnG
         8YPueB0fePMYSHsf+E2QxDnkCb5EsA562nE6n44yZbys+7ZFEl/PaVizHAPgH7MdhjAV
         a70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eY8G+T0bh4LN6y+cxgn4OGYQRTzOO5yifrdrjlzP4xo=;
        b=PJXOXjoBdU+Dbrbh6cwsjJDiBRHX0337AdM45UOtj9Dp49j1ar470hM2Fk/VAMUo92
         AG0oQn5rLIT7Atc9wUOIvy847mnof+OAra1EpPJ+vHvUu2hw05kUqI+0Ena/SVLCbYLi
         qJsFSIVm9ldlbEp6ODc6isi90LZyhJOVYoKlUZO5xI/14bFrBR5mpXUPgp3Fc0qltmwv
         bmwEtdtS1E+kQB6zPjapkBJibMWcQfNoqen2ykm2v6JG6BgKwbOOefJM5/sD98lTIPjx
         GY7Dy11XQmJjaBo/Xu4SUb7wkSAu6xCswKR7y/RIfUKR4RxFHApyhIPOyMmNoGyVCUfn
         H9Nw==
X-Gm-Message-State: AOAM530uEQH3vKiAzX/hs85Ksf/gAb+RH86dsGjT+cg3hyGvlQw5t1dX
        yT/BW7Q3yR0WLg5pm5MoS+NLtVJ9rhan9OxZ7qTS9A==
X-Google-Smtp-Source: ABdhPJyahnUh0rw5wbWB1tMgwq0uvYik/i1xvch+qmo0s2+lLe+wAf2QZmn9/oHa2jA6RYanoM46HmiqgQq+MjTAhu8=
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr29018379edt.213.1608114954502;
 Wed, 16 Dec 2020 02:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20201211164801.7838-1-nsaenzjulienne@suse.de> <20201211164801.7838-3-nsaenzjulienne@suse.de>
In-Reply-To: <20201211164801.7838-3-nsaenzjulienne@suse.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 16 Dec 2020 11:35:43 +0100
Message-ID: <CAMpxmJX5t=LWpLkY=uYNK9r4rmStuSfmGc7=zcnu4_oHkQevWQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] firmware: raspberrypi: Introduce devm_rpi_firmware_get()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>, wahrenst@gmx.net,
        Linux Input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Dec 11, 2020 at 5:48 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> It'll simplify the firmware handling for most consumers.
>
> Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>
> Changes since v4:
>  - Rearrange function calls for clarity, same functionality
>
> Changes since v2:
> - Create devm_rpi_firmware_get()
>
>  drivers/firmware/raspberrypi.c             | 29 ++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |  8 ++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> index b65e4c495772..250e01680742 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -243,6 +243,13 @@ void rpi_firmware_put(struct rpi_firmware *fw)
>  }
>  EXPORT_SYMBOL_GPL(rpi_firmware_put);
>
> +static void devm_rpi_firmware_put(void *data)
> +{
> +       struct rpi_firmware *fw = data;
> +
> +       rpi_firmware_put(fw);
> +}
> +
>  static int rpi_firmware_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -331,6 +338,28 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
>  }
>  EXPORT_SYMBOL_GPL(rpi_firmware_get);
>
> +/**
> + * devm_rpi_firmware_get - Get pointer to rpi_firmware structure.
> + * @firmware_node:    Pointer to the firmware Device Tree node.
> + *
> + * Returns NULL is the firmware device is not ready.
> + */
> +struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
> +                                          struct device_node *firmware_node)
> +{
> +       struct rpi_firmware *fw;
> +
> +       fw = rpi_firmware_get(firmware_node);
> +       if (!fw)
> +               return NULL;
> +
> +       if (devm_add_action_or_reset(dev, devm_rpi_firmware_put, fw))
> +               return NULL;
> +
> +       return fw;
> +}
> +EXPORT_SYMBOL_GPL(devm_rpi_firmware_get);
> +
>  static const struct of_device_id rpi_firmware_of_match[] = {
>         { .compatible = "raspberrypi,bcm2835-firmware", },
>         {},
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
> index fdfef7fe40df..73ad784fca96 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -142,6 +142,8 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
>                                void *data, size_t tag_size);
>  void rpi_firmware_put(struct rpi_firmware *fw);
>  struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
> +struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
> +                                          struct device_node *firmware_node);
>  #else
>  static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
>                                         void *data, size_t len)
> @@ -160,6 +162,12 @@ static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware
>  {
>         return NULL;
>  }
> +
> +static inline struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
> +                                       struct device_node *firmware_node)
> +{
> +       return NULL;
> +}
>  #endif
>
>  #endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
> --
> 2.29.2
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
