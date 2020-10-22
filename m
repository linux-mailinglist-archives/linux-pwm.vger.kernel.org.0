Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C392964E0
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369768AbgJVSwr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369695AbgJVSwr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Oct 2020 14:52:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E27C0613CE;
        Thu, 22 Oct 2020 11:52:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 144so1732850pfb.4;
        Thu, 22 Oct 2020 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPboJfWy2G3Fl7hwjyzYX4I9qIst4Uk/OLfG5LU/e2E=;
        b=VtKxX3880Ktn0xTFSYzIwEDHPTS945FNbgy5Gr9ePYlOcjKHowJfessighc9v6F0en
         LuknoiQUlSBxsAQPLJLt/drziu0AAwrOEzyhUcwmwHsfzlAgokLQ53YfZOV0mJ1FzJeD
         V/RcTixiSCbFKJCyLRQHl4yc2COxVriX0ZwYQmav4pYgvvT+EjnkpaVicrejbnDloVIk
         X69NaHzfPbEZYDyIKTszJJWoesjJRt/Mfyo263Y91yBXzQopSm8wFrQjL6KANAn1UNJ9
         np8MAbILaQqiWKg9w2R6c4aSkw1MLko9EBT4X7A/ELdcmFYyNndVmSZdwaD+9LAAHuWE
         zOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPboJfWy2G3Fl7hwjyzYX4I9qIst4Uk/OLfG5LU/e2E=;
        b=QCHyybLgWy+uSZjDMOQfwQ9xYEzADSD75z5wEMBomOjtmm9r/b+C26EwGLXP/wI7nO
         xDgwK7OGpq9vOQlQr7+S5GEadS33taigGK9huM7HEN7ELvm+TH3kgMYhD+kfticC++I5
         H9qN9tUCez4zfgZH1cuMQVrwRXsKbwlm883NMfJ9CjHG1FKmpW9qKzt88dreAFF1jVBd
         YgNxDgUFGH8X0GvhsuQpDR1hui0XVKSir8rUuGIhl64hS6nhrm1HJwge+W+43yCZ6YuK
         PlPT/KX+4/xzbChG4PWUHjxzpDfagGME5JoVbrvO5ubE+BdQ48DB5jd0K82jTtXcv5fV
         SRyw==
X-Gm-Message-State: AOAM533Ej2/Bk1d6zWrsO7HFpPnOcNpULMFogtjhxHSP6Vv39xp/8IEU
        FOXukWDUmZQgpiyVz2ML4wJqXmPvMOF8ibruUUM=
X-Google-Smtp-Source: ABdhPJxuxwguwZIz0oJ2B/3sUWcXzpnVtRm/MOSafV+Mdym/oG+j6niWLg7KAllKTq7L+Rkez2tw5MM5pbQzsafKqk0=
X-Received: by 2002:a05:6a00:22c2:b029:156:543:7c1d with SMTP id
 f2-20020a056a0022c2b029015605437c1dmr3771716pfj.40.1603392766581; Thu, 22 Oct
 2020 11:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201022155858.20867-1-nsaenzjulienne@suse.de> <20201022155858.20867-11-nsaenzjulienne@suse.de>
In-Reply-To: <20201022155858.20867-11-nsaenzjulienne@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Oct 2020 21:53:35 +0300
Message-ID: <CAHp75VcB5oxXs38UH5taVGj21wUi3sHYdRPOj3wxa3yXg0vmUA@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] pwm: Add Raspberry Pi Firmware based PWM bus
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Oct 22, 2020 at 9:05 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Adds support to control the PWM bus available in official Raspberry Pi
> PoE HAT. Only RPi's co-processor has access to it, so commands have to
> be sent through RPi's firmware mailbox interface.

>  drivers/pwm/pwm-raspberrypi.c | 221 ++++++++++++++++++++++++++++++++++

Name is completely confusing.
Please, make it unique enough to understand that this is exactly the
device it serves for.

For example, pwm-rpi-poe is better.

...

> + *  - Only normal polarity

Can't it be emulated? Isn't it 100% - duty cycle % ?


> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>

...

> +       ret = rpi_firmware_property(firmware, RPI_FIRMWARE_SET_POE_HAT_VAL,
> +                                   &msg, sizeof(msg));
> +       if (ret)
> +               return ret;

> +       else if (msg.ret)

Redundant 'else'

> +               return -EIO;

...

> +       ret = rpi_firmware_property(firmware, RPI_FIRMWARE_GET_POE_HAT_VAL,
> +                                   &msg, sizeof(msg));
> +       if (ret)
> +               return ret;

> +       else if (msg.ret)

Ditto.

> +               return -EIO;

...

> +       firmware_node = of_get_parent(dev->of_node);
> +       if (!firmware_node) {
> +               dev_err(dev, "Missing firmware node\n");
> +               return -ENOENT;
> +       }
> +
> +       firmware = rpi_firmware_get(firmware_node);
> +       of_node_put(firmware_node);
> +       if (!firmware)
> +               return -EPROBE_DEFER;

Looks like a hack.

...

> +       ret = pwmchip_remove(&rpipwm->chip);
> +       if (!ret)
> +               rpi_firmware_put(rpipwm->firmware);
> +
> +       return ret;

Can't you use the usual pattern?

  ret = ...
  if (ret)
    return ret;
  ...
  return 0;

-- 
With Best Regards,
Andy Shevchenko
