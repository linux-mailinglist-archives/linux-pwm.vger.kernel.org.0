Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B162CD0C5
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Dec 2020 09:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgLCIGN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Dec 2020 03:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388194AbgLCIGN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Dec 2020 03:06:13 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D9FC061A4D
        for <linux-pwm@vger.kernel.org>; Thu,  3 Dec 2020 00:05:27 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lt17so2114651ejb.3
        for <linux-pwm@vger.kernel.org>; Thu, 03 Dec 2020 00:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FZ8VxZZvqmh6ehr3KHE/PiRk3db+weOkpDGOlsh3YO8=;
        b=haDseJv+D02T10aLAxQHXG0BsYACsfkijqaB+ELZmfch2JYU9g6y9ryqDyIqWShXaW
         yaAZ88xKKVmpIrZKV/qetu3zM2AbVORk0wYWL03XQMh8ss+hr7Dc6CnNOdvjOspJC/vQ
         R2df0RgSro0FHNGu8o3DpusAvPeMobIgNjOfc7hfwHJ6Nvy0U69h0GmKMctPOdP8JHuK
         uCRMiqbef850rMYfMmIEUS0TzdqaTlcSg4Jgua9sT1AuBgZSfdy1txMa/Fszl/iCAsRa
         6RBF8zj3OIpntYgPprvZoROYfpZUKnhmmTVDrR3O2ZTkmVat83g3y0aDOoH39HHPuS4h
         RbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FZ8VxZZvqmh6ehr3KHE/PiRk3db+weOkpDGOlsh3YO8=;
        b=bYAOtaHC0ns4nGOSR/cdfcQPcR6tWNPsM/HORtShQ/Phdhy0YiSuTU3xqBhnGIYLoD
         DIM5gh+tQG9UKg8ZxuuoScUTzohMTny1B09ZKMp8T2K3i6jfudelV1rrfck3Zij0/mKV
         1p1l0Tk/HNk+ziKAh1V0Gc5yixbblXd0ejmcx8bXZrLtSLsmO5VaKutYMVrStODyxD3A
         juLU/K0jCC6VFPaqJEP0yAyBBxxSi8QqPymDCuxfJPeUyxc8SZOFOWV5EfJkmjIzpziN
         riC/t47DtXzaNmieSQLtrFS7kasmMrj5zpC+Sw9JwAuC+fu0ZK3Tq4/4mCavOYnQwIsQ
         u3Iw==
X-Gm-Message-State: AOAM531TfNQzB9OdK+yuXBHYmsSXCY8dHudOKOckl00dlTWX8UStuoHH
        oLuPI0rzP7zogyk6SwwCekz8OYvmu9sr8TCMZefk1g==
X-Google-Smtp-Source: ABdhPJxP2EJznI3pbg+Rqtm4SZQefIKFXf0kkiRRTqzbUDyEG5oMEZvNtOYbyFNg3cm8vTl+G0cfLIdKavT7T0DOD1k=
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr1414079ejr.429.1606982726027;
 Thu, 03 Dec 2020 00:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20201123183833.18750-1-nsaenzjulienne@suse.de> <20201123183833.18750-2-nsaenzjulienne@suse.de>
In-Reply-To: <20201123183833.18750-2-nsaenzjulienne@suse.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 3 Dec 2020 09:05:15 +0100
Message-ID: <CAMpxmJX6zdoYek2THEj2x8ycJYz-bxqE_5RnOz1sYv0vwLSFpA@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] firmware: raspberrypi: Keep count of all consumers
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Nov 23, 2020 at 7:38 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> When unbinding the firmware device we need to make sure it has no
> consumers left. Otherwise we'd leave them with a firmware handle
> pointing at freed memory.
>
> Keep a reference count of all consumers and introduce rpi_firmware_put()
> which will permit automatically decrease the reference count upon
> unbinding consumer drivers.
>
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>
> Changes since v3:
> - Use kref instead of waiting on refcount
>
>  drivers/firmware/raspberrypi.c             | 37 +++++++++++++++++++---
>  include/soc/bcm2835/raspberrypi-firmware.h |  2 ++
>  2 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> index 30259dc9b805..ed793aef7851 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/dma-mapping.h>
> +#include <linux/kref.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
> @@ -27,6 +28,8 @@ struct rpi_firmware {
>         struct mbox_chan *chan; /* The property channel. */
>         struct completion c;
>         u32 enabled;
> +
> +       struct kref consumers;
>  };
>
>  static DEFINE_MUTEX(transaction_lock);
> @@ -225,12 +228,27 @@ static void rpi_register_clk_driver(struct device *=
dev)
>                                                 -1, NULL, 0);
>  }
>
> +static void rpi_firmware_delete(struct kref *kref)
> +{
> +       struct rpi_firmware *fw =3D container_of(kref, struct rpi_firmwar=
e,
> +                                              consumers);
> +
> +       mbox_free_channel(fw->chan);
> +       kfree(fw);
> +}
> +
> +void rpi_firmware_put(struct rpi_firmware *fw)
> +{
> +       kref_put(&fw->consumers, rpi_firmware_delete);
> +}
> +EXPORT_SYMBOL_GPL(rpi_firmware_put);
> +
>  static int rpi_firmware_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
>         struct rpi_firmware *fw;
>
> -       fw =3D devm_kzalloc(dev, sizeof(*fw), GFP_KERNEL);

One nit from my side: maybe add a comment here saying that you really
want to use non-managed kzalloc() because you're going to get people
blindly converting it to devm_kzalloc() very soon.

Bartosz

> +       fw =3D kzalloc(sizeof(*fw), GFP_KERNEL);
>         if (!fw)
>                 return -ENOMEM;
>
> @@ -247,6 +265,7 @@ static int rpi_firmware_probe(struct platform_device =
*pdev)
>         }
>
>         init_completion(&fw->c);
> +       kref_init(&fw->consumers);
>
>         platform_set_drvdata(pdev, fw);
>
> @@ -275,25 +294,35 @@ static int rpi_firmware_remove(struct platform_devi=
ce *pdev)
>         rpi_hwmon =3D NULL;
>         platform_device_unregister(rpi_clk);
>         rpi_clk =3D NULL;
> -       mbox_free_channel(fw->chan);
> +
> +       rpi_firmware_put(fw);
>
>         return 0;
>  }
>
>  /**
> - * rpi_firmware_get - Get pointer to rpi_firmware structure.
>   * @firmware_node:    Pointer to the firmware Device Tree node.
>   *
> + * The reference to rpi_firmware has to be released with rpi_firmware_pu=
t().
> + *
>   * Returns NULL is the firmware device is not ready.
>   */
>  struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
>  {
>         struct platform_device *pdev =3D of_find_device_by_node(firmware_=
node);
> +       struct rpi_firmware *fw;
>
>         if (!pdev)
>                 return NULL;
>
> -       return platform_get_drvdata(pdev);
> +       fw =3D platform_get_drvdata(pdev);
> +       if (!fw)
> +               return NULL;
> +
> +       if (!kref_get_unless_zero(&fw->consumers))
> +               return NULL;
> +
> +       return fw;
>  }
>  EXPORT_SYMBOL_GPL(rpi_firmware_get);
>
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm=
2835/raspberrypi-firmware.h
> index cc9cdbc66403..fdfef7fe40df 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -140,6 +140,7 @@ int rpi_firmware_property(struct rpi_firmware *fw,
>                           u32 tag, void *data, size_t len);
>  int rpi_firmware_property_list(struct rpi_firmware *fw,
>                                void *data, size_t tag_size);
> +void rpi_firmware_put(struct rpi_firmware *fw);
>  struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)=
;
>  #else
>  static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag=
,
> @@ -154,6 +155,7 @@ static inline int rpi_firmware_property_list(struct r=
pi_firmware *fw,
>         return -ENOSYS;
>  }
>
> +static inline void rpi_firmware_put(struct rpi_firmware *fw) { }
>  static inline struct rpi_firmware *rpi_firmware_get(struct device_node *=
firmware_node)
>  {
>         return NULL;
> --
> 2.29.2
>
