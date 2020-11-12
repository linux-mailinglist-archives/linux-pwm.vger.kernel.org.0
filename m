Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B582B0BA1
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 18:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgKLRv0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 12:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgKLRvZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 12:51:25 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D06C0613D1;
        Thu, 12 Nov 2020 09:51:25 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i7so4813208pgh.6;
        Thu, 12 Nov 2020 09:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EywCTDkeiYnus//+DkG9p7x5uOXcjsUoW/CpBJQjGh4=;
        b=V5FRj9dv8LZyKY//w8MnGopC83oSkh3/f67EKu2H49jcmyUNYveReXkMJBzGvyFd4q
         mKcvNnhVICd/UhAL/HH1jUpFUyrBz0394onSteeXHeV50i9Ez+UPXVRJ/ggkQfCzqgGm
         kZTUJSpVayCtwC4cSeh7i9ajykTWfmMo/ei8+RErGCyLv9pJdlXF4oU6ddtDfkVU1QZ3
         C/k7/c7VYeacSw8c3j9jFOs+fpuV13Cto+tr+PxtXt9xpKbVtuE00030bzHITnLQ8DGM
         vefvzjW/M2wcH5x0dDt9q//PluUhKPH7ylVjCzGUXYm7NdXATfhWLzirDL/eJBFpUpwn
         k6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EywCTDkeiYnus//+DkG9p7x5uOXcjsUoW/CpBJQjGh4=;
        b=e28/RxZ+ARc7dvK3ScOb7cdlXt99THlRc2eehygJRH565Wb3mbY3N4MsyeplAosISQ
         f33vgt+HuvDTiXul+CDzKFkcPtBRfWosQ9eSPJKDUqCXjSKPa9Iv955b8062n3HysKas
         0aYPsX3avOIz6Zpz4iP/ft9xqv206uf/+qaC9TOnLo6yaQgTaKRkjt0P+ONOD9mobpYp
         eJR8ndYvN/wCN5lY06RxFaElbhxdf/ZzjXwWlwtL4UwIifZpYNHfgZpLNfdeNvKtB0w9
         e06a9Mmzn2spHxiPvO9v5wRqFe1GANtXlrJNbUANj4nnFHbGWrxiOg9BvYiGQVU8K33F
         dqGQ==
X-Gm-Message-State: AOAM533fe6X4eJ5dfHMAQ4HA+d9OGTwRatLeHY4rlLXPV9lTSk0sCVh/
        BLWnIlefQZMwNtkuBXeWDG3PE151O1eInNO/ehk=
X-Google-Smtp-Source: ABdhPJxXX/B6x0+15Jl1eMPJKowvsEayj1f13ku4DPhKXTBbwSAC5XSxvuq5WfIMJ/rZXp3ScqiK3LDy0pqYaPrr47I=
X-Received: by 2002:a17:90b:fc6:: with SMTP id gd6mr287022pjb.181.1605203485218;
 Thu, 12 Nov 2020 09:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20201112163630.17177-1-nsaenzjulienne@suse.de> <20201112163630.17177-2-nsaenzjulienne@suse.de>
In-Reply-To: <20201112163630.17177-2-nsaenzjulienne@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 Nov 2020 19:52:14 +0200
Message-ID: <CAHp75Vf9E7UWVDMs=eRjLjoSN6SVOWw9thNdnR8ruCL6GmY7JQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] firmware: raspberrypi: Keep count of all consumers
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org,
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
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 12, 2020 at 6:40 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> When unbinding the firmware device we need to make sure it has no
> consumers left. Otherwise we'd leave them with a firmware handle
> pointing at freed memory.
>
> Keep a reference count of all consumers and introduce rpi_firmware_put()
> which will permit automatically decrease the reference count upon
> unbinding consumer drivers.

...

>  /**
> - * rpi_firmware_get - Get pointer to rpi_firmware structure.
>   * @firmware_node:    Pointer to the firmware Device Tree node.
>   *
> + * The reference to rpi_firmware has to be released with rpi_firmware_put().
> + *
>   * Returns NULL is the firmware device is not ready.
>   */
>  struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
>  {
>         struct platform_device *pdev = of_find_device_by_node(firmware_node);
> +       struct rpi_firmware *fw;
>
>         if (!pdev)
>                 return NULL;
>
> -       return platform_get_drvdata(pdev);
> +       fw = platform_get_drvdata(pdev);
> +       if (!fw)
> +               return NULL;
> +
> +       if (!kref_get_unless_zero(&fw->consumers))
> +               return NULL;

Don't we have a more traditional way of doing this, i.e.
try_module_get() coupled with get_device() ?

> +       return fw;
>  }


-- 
With Best Regards,
Andy Shevchenko
