Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C661EF5BC
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFEKu4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 06:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgFEKu4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 06:50:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1EC08C5C2;
        Fri,  5 Jun 2020 03:50:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so2444893pjb.0;
        Fri, 05 Jun 2020 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jm0v4NSQR1eScm4hhrK2IVUXqo9gKL1/dYB+J6Im5x0=;
        b=K7KhDXCAN4clMZH/9uQj6/jxUV9WXBwbtZ3UN/nOr0eCOZx7zi8KmoNF1OOCbLvD/Q
         yCeXrjx95GEfn9SFJy/kuOFU0e5hZ7TxwAzd2yJ6KatQ9UAiQtKXcqZjeRrOxs6gUvvy
         /iD0SENH6qBwJH0O61kFDFhPIGIGy8OSbaVutwR5NpdNYCz0wbhqcsy2mVCoCe4WzyHL
         RiHAo/+E/znba4TKYpbeiFhAWsha+Fx0H0Le9HVZxYeLgyxR+cTOvGVHZhmGGYvDE0co
         oqFHhCL+74ImcrYmdoqftf3xhzH1oJLn1tecMG8FD2gp2mkeO2/RUFI/W5hSliYsW+VN
         vUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jm0v4NSQR1eScm4hhrK2IVUXqo9gKL1/dYB+J6Im5x0=;
        b=GQ5iqnQHB8idRGvkJqsPfkiaO35K9hJfbjIwFUSCBl84mhwqoz/mPDpwW/KFZGSGTM
         gJojmLwfMLRI8vtu7NZNDk7l6ELFKlwsVURJevZ0gVrZO/6A/Tc7Ne+vl79mGNfshWxq
         l4EO4pH2yQyH5gaSeAbfaY8O+8+uroyJx3Sc23yeb4HzCnMic8vGivwiQE0dEdyEXJRd
         MnZDUoBAzJnpP6mtVDNWrHP7a3/J7xqRP/hUtE2OipFVAkX3dut7TAGdafDSpni6v+Ml
         Y0Q+nVFhMpcJSjhHIoqWmeLvYaVO9scLqYWIuh6Snx6ykh1c+qZv0+7OpzQvKA8CUkJa
         rKRQ==
X-Gm-Message-State: AOAM532fgdzubpb8foLOLkInfngmJHRyDjQ4LKBY7r5dziPlHdFKEDYs
        nkB7OJxN2+sst1mMIrdU4tc9B0ooBGf+blB8xNfJBBmscnw=
X-Google-Smtp-Source: ABdhPJy8g7xgtcfoQmROz1emJfu6kg9Wd3RE5AUde8dS472m5XXCXD1Sghv319T4YYpsCAKy9z10aBn1woa6UmZUj/k=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr2414679pjq.228.1591354255458;
 Fri, 05 Jun 2020 03:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com> <8f042c2442852c29519c381833f3d289@walle.cc>
In-Reply-To: <8f042c2442852c29519c381833f3d289@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 13:50:43 +0300
Message-ID: <CAHp75VfY0BD4CFu6Thx1wE-U0Zt1q8uTOLxkWTMdFk0MBuhYFQ@mail.gmail.com>
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

On Fri, Jun 5, 2020 at 1:24 PM Michael Walle <michael@walle.cc> wrote:
> Am 2020-06-05 10:14, schrieb Andy Shevchenko:
> > On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:

...

> >> +static bool nowayout = WATCHDOG_NOWAYOUT;
> >> +module_param(nowayout, bool, 0);
> >> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
> >> (default="
> >> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT)
> >> ")");
> >> +
> >> +static int timeout;
> >> +module_param(timeout, int, 0);
> >> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> >
> > Guenter ACKed this, but I'm wondering why we still need module
> > parameters...
>
> How would a user change the nowayout or the timeout? For the latter
> there is
> a device tree entry, but thats not easy changable by the user.

Yes, it's more question to VIm and Guenter than to you.

...

> >> +       if (status & WDT_CTRL_EN) {
> >> +               sl28cpld_wdt_start(wdd);
> >
> >> +               set_bit(WDOG_HW_RUNNING, &wdd->status);
> >
> > Do you need atomic op here? Why?
>
> I'd say consistency, all watchdog drivers do it like that. I just
> had a look at where this is used, but it looks like access from
> userspace is protected by a lock.

Okay then.

-- 
With Best Regards,
Andy Shevchenko
