Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCE71EF2DE
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFEIOf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 04:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEIOf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 04:14:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEDAC08C5C2;
        Fri,  5 Jun 2020 01:14:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ga6so2280958pjb.1;
        Fri, 05 Jun 2020 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dep05XtC6CuktEauurS07Sy6QGbgqiv3E+ii3Ovb+Ls=;
        b=DtPDLU5uvgVYNSLmyiKoOVclyfKzq/LadYhfYsydWTd6wNLn9WXOeNCQZ1eiRcsqpR
         eM+UfKM607A27ZS4k9+lPQo7wLpshrnQmdyy6M0YBnJNJB92lKYWsICiQ2QqDFyV2uuP
         mVmeaA7d2/jp9aUsu3rYaJnq2Nl9XtTb+Cm6x0hdWWSGxryrnI8gdVK8Ek+iQH8lpXnM
         sWKr4BOYZ/6PfVnuj1aa8yhI82S6X9Ifg9IgmLIIGZx3FhgRgITl0KKSBScv8VHg7Y2J
         iSbdP8PDzD4ZGltMHRLeHWEdsWOCm5HZzz7yODflx/bVmvni10eBB/Q6H+cMfcwqURca
         LIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dep05XtC6CuktEauurS07Sy6QGbgqiv3E+ii3Ovb+Ls=;
        b=T9f9K2WC1Jc92gyRyc5mYxpSQ5fPtUFWb1/wfbbjxwskeGMTs4iJWdiEGigA0ASAXQ
         jTFO2cXe0R9qCmaIm+eV41hCVt+7OfK+SoTEN0CftEYvf37SHMNV1NmhKoCpgjhn/T9j
         02RvA9W2vII2WnFIb4voH0IrMhonEWRE793X2W3TUyI7vntCT4uLMHF6vrvKzMKnHemq
         V+MeDUxjvlwqssBPKI1Qi7xZEiI657SLAlXnM+7udDYSSVL3K7rQqRBNUlRCF3bCy0qr
         +zTPi1J4aVZfxup+osX3aToWnAXdbwJ2HTatOldTbz2NK/dzkT0sJ74mayjVr4u5FE6Z
         j8kQ==
X-Gm-Message-State: AOAM530pEUsS+/F1qBjoeIoQDsDG53FfXjm8EvdSwJw75/fHmiJ1ynqe
        dzxcoDjBi5vwLH4ljw54aSF+y0sQctAiFN1NgGg=
X-Google-Smtp-Source: ABdhPJy6V7rCbEiJe15C6DeQ4diyGwP3W+IH+3LGFcotcY4Lzpv76z0aCO0s2xeMP6Sc/HpdiVeb+XHZ7d/jwbWAe/g=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr1713137pjq.228.1591344873732;
 Fri, 05 Jun 2020 01:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-5-michael@walle.cc>
In-Reply-To: <20200604211039.12689-5-michael@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 11:14:17 +0300
Message-ID: <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
To:     Michael Walle <michael@walle.cc>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
>
> Add support for the watchdog of the sl28cpld board management
> controller. This is part of a multi-function device driver.

...

> +#include <linux/of_device.h>

Didn't find a user of this.

...

> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int timeout;
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");

Guenter ACKed this, but I'm wondering why we still need module parameters...

...

> +       int ret;
> +
> +       ret = regmap_read(wdt->regmap, wdt->offset + WDT_COUNT, &val);
> +
> +       return (ret < 0) ? 0 : val;

Besides extra parentheses and questionable ' < 0' part, the following
would look better I think

ret = ...
if (ret)
  return 0;

return val;

...

> +       int ret;
> +
> +       ret = regmap_write(wdt->regmap, wdt->offset + WDT_TIMEOUT, timeout);
> +       if (!ret)
> +               wdd->timeout = timeout;
> +
> +       return ret;

Similar story here:

ret = ...
if (ret)
  return ret;

wdd->... = ...
return 0;

...

> +       ret = regmap_read(wdt->regmap, wdt->offset + WDT_CTRL, &status);

> +       if (ret < 0)

What ' < 0' means? Do we have some positive return values?
Ditto for all your code.

> +               return ret;

...

> +       if (status & WDT_CTRL_EN) {
> +               sl28cpld_wdt_start(wdd);

> +               set_bit(WDOG_HW_RUNNING, &wdd->status);

Do you need atomic op here? Why?

> +       }

...

> +static const struct of_device_id sl28cpld_wdt_of_match[] = {
> +       { .compatible = "kontron,sl28cpld-wdt" },

> +       {},

No comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
