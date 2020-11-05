Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D312A7A35
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 10:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgKEJOA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Nov 2020 04:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgKEJN6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Nov 2020 04:13:58 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD29BC0613CF
        for <linux-pwm@vger.kernel.org>; Thu,  5 Nov 2020 01:13:57 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id w13so1518271eju.13
        for <linux-pwm@vger.kernel.org>; Thu, 05 Nov 2020 01:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cosNbBc+pGCwoieZsWO9CcMsgFAi+qgVJh6/ZaKe1v0=;
        b=h2AbCJ6xtX9calmobLzMDdUmOt4016ZAljqf+kWZm3SpJ5dyWf5xX8QV+8uAKO7KzB
         whVd90vtF4kEq0FjKmV2eXJCusoVmf8b1ZXm4g19A6c9d3zpTGecCZcl0xPaOrSMnUzM
         OGxi6KTPLoJsWq0pzXzySThLXXe1GQN0O9JNP7hJsN0mTV3NqA97jL96kLNinAgMKhRQ
         8LQz93+7bzMlzUxaAtidPL1DLIRzbOEahVB/7cnJeyFT+Us2VOVrMCBQcnomz5KE/6GC
         gF+l6kEcCMCIt86RD/mLxN3qSNhWZV0UIk0wGcZ/d2v9DKiSjhWGarH/Lc5p3RkZiIJ/
         zceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cosNbBc+pGCwoieZsWO9CcMsgFAi+qgVJh6/ZaKe1v0=;
        b=hBibcobhO18Bqx+GhY/IxQ53M+eKJ2S1YXCeFgH0ONbHUmEX+GsyQTZZYkulmzjRm6
         G3Fyi6Z+ky45ZL0XpFKVeQKkme9V1kq/zigjhfRhA5fBeqDvV9U8uihWUhSqqxIL7BbS
         SCtmVMcVXxZfaGvSbZTHOKU1R90SWkGCsnpPwNt0xz1beBIaswumPE48NraqZZLLCBIs
         paTQVnxHpRwEZkjUZiHXFFv48YeUZQGXUoAoPHeJN800McGAl+OJQdMQuivKECQ43t5e
         3a/s/wHCc9Ammu2yf0Uls5+IbHSGGYVUDrZh7A4slVCwedql94pVFJfmaM4FlSIs/tR5
         z/vQ==
X-Gm-Message-State: AOAM5318lPnrPLgCwv6fRML+LdRSL6802jHn3V1XDeMCsP2btJ2zfLAA
        uiHVUbT8QIfTanWUEQcEn6ZnjceJFikDGQS/cR5SDw==
X-Google-Smtp-Source: ABdhPJyFgzr6/OtoGqHbIjxgJayFJFC6ooeiWsm56YhTmEcoAALq1JBufGgUh3laISQqZelpAaKQMgQ7rYi7EiPI/xk=
X-Received: by 2002:a17:907:420d:: with SMTP id oh21mr1350987ejb.429.1604567636515;
 Thu, 05 Nov 2020 01:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20201104103938.1286-1-nsaenzjulienne@suse.de> <20201104103938.1286-2-nsaenzjulienne@suse.de>
In-Reply-To: <20201104103938.1286-2-nsaenzjulienne@suse.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Nov 2020 10:13:45 +0100
Message-ID: <CAMpxmJWJRcQQiLitJCLWKmhQVQWr3bMDY=td5FEn5uy2YZfwkA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] firmware: raspberrypi: Introduce devm_rpi_firmware_get()
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

On Wed, Nov 4, 2020 at 11:39 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> When unbinding the firmware device we need to make sure it has no
> consumers left. Otherwise we'd leave them with a firmware handle
> pointing at freed memory.
>
> Keep a reference count of all consumers and introduce
> devm_rpi_firmware_get() which will automatically decrease the reference
> count upon unbinding consumer drivers.
>
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Changes since v2:
>  - Create devm_rpi_firmware_get()
>
>  drivers/firmware/raspberrypi.c             | 46 ++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |  8 ++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> index 2371d08bdd17..74bdb3bde9dc 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -11,7 +11,9 @@
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/refcount.h>
>  #include <linux/slab.h>
> +#include <linux/wait.h>
>  #include <soc/bcm2835/raspberrypi-firmware.h>
>
>  #define MBOX_MSG(chan, data28)         (((data28) & ~0xf) | ((chan) & 0x=
f))
> @@ -27,6 +29,9 @@ struct rpi_firmware {
>         struct mbox_chan *chan; /* The property channel. */
>         struct completion c;
>         u32 enabled;
> +
> +       refcount_t consumers;
> +       wait_queue_head_t wait;
>  };
>
>  static DEFINE_MUTEX(transaction_lock);
> @@ -247,6 +252,8 @@ static int rpi_firmware_probe(struct platform_device =
*pdev)
>         }
>
>         init_completion(&fw->c);
> +       refcount_set(&fw->consumers, 1);
> +       init_waitqueue_head(&fw->wait);
>
>         platform_set_drvdata(pdev, fw);
>
> @@ -275,11 +282,21 @@ static int rpi_firmware_remove(struct platform_devi=
ce *pdev)
>         rpi_hwmon =3D NULL;
>         platform_device_unregister(rpi_clk);
>         rpi_clk =3D NULL;
> +
> +       wait_event(fw->wait, refcount_dec_if_one(&fw->consumers));
>         mbox_free_channel(fw->chan);
>
>         return 0;
>  }
>
> +static void rpi_firmware_put(void *data)
> +{
> +       struct rpi_firmware *fw =3D data;
> +
> +       refcount_dec(&fw->consumers);
> +       wake_up(&fw->wait);
> +}
> +
>  /**
>   * rpi_firmware_get - Get pointer to rpi_firmware structure.
>   * @firmware_node:    Pointer to the firmware Device Tree node.
> @@ -297,6 +314,35 @@ struct rpi_firmware *rpi_firmware_get(struct device_=
node *firmware_node)
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
> +                                          struct device_node *firmware_n=
ode)
> +{
> +       struct platform_device *pdev =3D of_find_device_by_node(firmware_=
node);
> +       struct rpi_firmware *fw;
> +
> +       if (!pdev)
> +               return NULL;
> +
> +       fw =3D platform_get_drvdata(pdev);
> +       if (!fw)
> +               return NULL;
> +
> +       if (!refcount_inc_not_zero(&fw->consumers))
> +               return NULL;
> +
> +       if (devm_add_action_or_reset(dev, rpi_firmware_put, fw))
> +               return NULL;
> +
> +       return fw;
> +}
> +EXPORT_SYMBOL_GPL(devm_rpi_firmware_get);

Usually I'd expect the devres variant to simply call
rpi_firmware_get() and then schedule a release callback which would
call whatever function is the release counterpart for it currently.
Devres actions are for drivers which want to schedule some more
unusual tasks at driver detach. Any reason for designing it this way?

Bartosz

> +
>  static const struct of_device_id rpi_firmware_of_match[] =3D {
>         { .compatible =3D "raspberrypi,bcm2835-firmware", },
>         {},
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm=
2835/raspberrypi-firmware.h
> index cc9cdbc66403..8fe64f53a394 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -141,6 +141,8 @@ int rpi_firmware_property(struct rpi_firmware *fw,
>  int rpi_firmware_property_list(struct rpi_firmware *fw,
>                                void *data, size_t tag_size);
>  struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)=
;
> +struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
> +                                          struct device_node *firmware_n=
ode);
>  #else
>  static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag=
,
>                                         void *data, size_t len)
> @@ -158,6 +160,12 @@ static inline struct rpi_firmware *rpi_firmware_get(=
struct device_node *firmware
>  {
>         return NULL;
>  }
> +
> +static inline struct rpi_firmware *devm_rpi_firmware_get(struct device *=
dev,
> +                                       struct device_node *firmware_node=
)
> +{
> +       return NULL;
> +}
>  #endif
>
>  #endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
> --
> 2.29.1
>
