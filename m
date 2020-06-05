Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379C81EFD34
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFEQE6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 12:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFEQE6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 12:04:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466ACC08C5C2;
        Fri,  5 Jun 2020 09:04:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q24so2907422pjd.1;
        Fri, 05 Jun 2020 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73E7RcoyD6PaDcTNS+l4UhJfaffhxVQRNwIljXNBTnY=;
        b=g39gSyKSZ6nFdS355NhJxXV7kRDPp92lfjop20jdOKudJotgA9Ley+ZJhs/ANJc3uk
         pDCQVLIAa3R1hAHTcDHOkQVw60cQN9Ez9VJjAavkzRmNoiMdOQLPyY4Yjn4K/DTONTKD
         RYpMjFy9eNrbO9NyUCQgWrii1EJkZEVv7LB8hG9G8/vTy94NRCaXNplr42FN0BbFoyiN
         eEy0gT7M5xNAUK0eulmJqkSnqL/pT5dYN/TjacCb/49FFpdjtd1KSTS3mn7WOaYvKU4o
         pRXg2LkXyORq06y5fGWS0NLv0VFPeVDB77y3Q+7LdyS1tru4TjQ7nhL8PR+qo4VfKptJ
         BSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73E7RcoyD6PaDcTNS+l4UhJfaffhxVQRNwIljXNBTnY=;
        b=mtene7sWzMnvCc54kfZayBCZAPHYQJZw1K7ZvcyOKuvkXTxpivBhrbhxaeoD6EiruA
         2zgWDeyK8+dftriUWxNi4Q4y1FccrOFfPk3N2FgcFpjpr1xLkXr2uidU8h0lnaLou7gf
         uHrTleQ+tIgxouyvqfbt+ag2uUeKlZ6uNQjAS7gti3v97+3HArr0+RPSHaH56mbFjxFH
         xVMxIP90dkxVVEW44PeG+k5FmDheSkX+BNPgeRo4Cchdf3yA22MX/MimNVrrP9nfRFMM
         uoU/d/rayHBf1yfKZKwVnDOiOfY0iFsHY+BkNQc34m5Ii3q/q3XN8dt0ZHcIK+Jjk7u+
         WugQ==
X-Gm-Message-State: AOAM530mXgYskB7GiM4ReieDyKGN2MXhBtyAkTe0LZV9jAfW+zSMNgbL
        i481U2+UTbVHrU6FKDkiyiTGij4Btr85msIyDyQZ1CkRisY=
X-Google-Smtp-Source: ABdhPJzPaq665EFE1ksqX24DQEG6g0+cqU1LKgTTLqD7rhez7XPSsEjdUlhj39QWiyrEeqMUme8o/zQYAwiDdMDxHs8=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr3950020pjq.228.1591373097587;
 Fri, 05 Jun 2020 09:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
 <8f042c2442852c29519c381833f3d289@walle.cc> <CAHp75VfY0BD4CFu6Thx1wE-U0Zt1q8uTOLxkWTMdFk0MBuhYFQ@mail.gmail.com>
 <871a4990-5b94-3a17-01d4-74998375f08b@roeck-us.net> <20200605140911.GO2428291@smile.fi.intel.com>
 <20200605150542.GA254229@roeck-us.net>
In-Reply-To: <20200605150542.GA254229@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 19:04:45 +0300
Message-ID: <CAHp75VduUG=XkvyZwdZDNqBh3KE67MWZWgqBN67fN6StAa469w@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 6:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Jun 05, 2020 at 05:09:11PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 05, 2020 at 06:52:00AM -0700, Guenter Roeck wrote:
> > > On 6/5/20 3:50 AM, Andy Shevchenko wrote:
> > > > On Fri, Jun 5, 2020 at 1:24 PM Michael Walle <michael@walle.cc> wrote:
> > > >> Am 2020-06-05 10:14, schrieb Andy Shevchenko:
> > > >>> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
> >
> > ...
> >
> > > >>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
> > > >>>> +module_param(nowayout, bool, 0);
> > > >>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
> > > >>>> (default="
> > > >>>> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT)
> > > >>>> ")");
> > > >>>> +
> > > >>>> +static int timeout;
> > > >>>> +module_param(timeout, int, 0);
> > > >>>> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
> > > >>>
> > > >>> Guenter ACKed this, but I'm wondering why we still need module
> > > >>> parameters...
> > > >>
> > > >> How would a user change the nowayout or the timeout? For the latter
> > > >> there is
> > > >> a device tree entry, but thats not easy changable by the user.
> > > >
> > > > Yes, it's more question to VIm and Guenter than to you.
> > > >
> > >
> > > Has support for providing module parameters with the kernel command line
> > > been discontinued/deprecated, or did it run out of favor ? Sorry if I
> > > missed that.
> >
> > Latter according to Greg KH. One of the (plenty) examples [1].
> >
> > [1]: https://www.mail-archive.com/driverdev-devel@linuxdriverproject.org/msg96495.html
> >
> What is the suggested replacement ?

In some mails he suggested to use sysfs.

-- 
With Best Regards,
Andy Shevchenko
