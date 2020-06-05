Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3341EF5A5
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgFEKsj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgFEKsj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 06:48:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55140C08C5C2;
        Fri,  5 Jun 2020 03:48:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nm22so2436911pjb.4;
        Fri, 05 Jun 2020 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hT5EtYTIJL/7KK1ErJ4XuTZSMU98O4NGYES7BTZShfU=;
        b=gUKniJAYthQYiCeLiJbQxp6vsgIMrYFTG3Tn0ztGQdAgJJ5SIzW9Qq+1WYjhN7yVaR
         dqPLJ6u8EPjvcsgOjNTxo0b6um16kDUcqfOuHSlYC0SJku2U0ceSI9Em09ln4GUbFpph
         kvSRDrMrLoPz0APi14wENlVfArV0pT3I/24PCyUfjYagBh1sTwgvy1kuLA9mVFd7eZ8u
         UCNaiWg/sKwjqaA+PU4vDlTyu64d24et0BTHPfF25369Vb/euo3Q0WtQ4cbeWcZ6S9Uj
         d6X7vp1YGXR6zxgqI4DmlTY86u6lNf5+TOFVpXVzPF2q/ePDeJZABOF3KAJD9Fg23qY/
         +I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hT5EtYTIJL/7KK1ErJ4XuTZSMU98O4NGYES7BTZShfU=;
        b=FRA8QDzfdJnC4uIS2DVn6L1IWOjf36Sq12DKVn9dJykZjX3wzo6tKKvC9UapxDOYOD
         4OrKPUM6M1pUdOADUU7+1jD4RBZi0RlCKrBvq5j5A0yYy4TOL++2rSr38krSlYStsC41
         0XL2dgutsAOaBIxwueCaP26BetJ23QJUhThJT7kmw0IRAFe/8CatG8WZxmIwZVd+DZ9d
         a/Y7R3I0rqdjMEMkCzo6b5vbA9UP5+NcFAjkfDRaOfWroD5JSbojx6j0TiBoFfkJDrCZ
         fskRGrQKyB4qFdnD8US9KcrMcHZLG3CIQN6FL5DpGxnD89aON/Z08iBJ8FC0d7yabKXe
         Pncg==
X-Gm-Message-State: AOAM5303MifNn6hhyEJHg5Deobmzy7CEPHJRHS56wYy2FP3edaoZggUW
        QWBfV3uGNEmINh9I5S7dTz8ePwPRIJfBM78M8dY=
X-Google-Smtp-Source: ABdhPJxJO5Y4Qm5YMH+m2+d6tv9L1OTX95vElklp0iU6q2z5TlX53tziLrdZX6T1mwhQ2rSUj09xKWtdLeKZgYN0Lsw=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr2258157pjd.181.1591354118825;
 Fri, 05 Jun 2020 03:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-3-michael@walle.cc>
 <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com> <8ed988b3e0bc48ea9219d0847c1b1b8e@walle.cc>
In-Reply-To: <8ed988b3e0bc48ea9219d0847c1b1b8e@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 13:48:27 +0300
Message-ID: <CAHp75Vf00w_UUvXULVd=OgSVM+p_pmNMJRPVnf8GNZW10c_j5w@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
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

On Fri, Jun 5, 2020 at 1:09 PM Michael Walle <michael@walle.cc> wrote:
> Am 2020-06-05 10:01, schrieb Andy Shevchenko:
> > On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:

...

> >> +       bool "Kontron sl28 core driver"
> >> +       depends on I2C=y
> >
> > Why not module?
>
> There are users of the interupt lines provided by the interrupt
> controller.
> For example, the gpio-button driver. If this is compiled into the kernel
> (which it is by default in the arm64 defconfig), probing will fail
> because
> the interrupt is not found. Is there a better way for that? I guess the
> same
> is true for the GPIO driver.

And GPIO nicely handles this via deferred probe mechanism. Why it
can't be used here?
So, we really need to have a strong argument to limit module nowadays
to be only builtin.

...

> >> +       depends on OF
> >
> > I didn't find an evidence this is needed.

> >> +#include <linux/of_platform.h>
> >
> > No evidence of user of this.
> > I think you meant mod_devicetable.h.
>
> devm_of_platform_populate(), so I need CONFIG_OF, too right?

Ah, this explains header, thanks!
But it doesn't explain depends OF.

So, perhaps,

depends OF || COMPILE_TEST will be more informative, i.e.
tells "okay, this driver can be compiled w/o OF, but won't be functional".

-- 
With Best Regards,
Andy Shevchenko
