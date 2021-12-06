Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199404696C7
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Dec 2021 14:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbhLFNXf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Dec 2021 08:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243876AbhLFNXe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Dec 2021 08:23:34 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0C4C061746
        for <linux-pwm@vger.kernel.org>; Mon,  6 Dec 2021 05:20:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id r11so42576922edd.9
        for <linux-pwm@vger.kernel.org>; Mon, 06 Dec 2021 05:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvZZ98+ZsTYkg5d9GGJxZP1sUx5SwZWVJ8siiSeTEiQ=;
        b=2MOQRTdPkwhZdrDsZF8v1LkIe9VhVcu+CnHsKM9OdXefuBhdam0kh3pKuY/iXJ4jwh
         zU6Pi0uyyixDjjwk/OQSxSOoc3iQ4xccBh7VU5XFj2RJmmXBFIQ5+C1z5IVbt1IIXZI9
         dWJnZb7vMFYt3V5p/nBP65LNmmSKgBcIPbBTYhEdVlTDWAEZK/VS4uN6PLzPx/US5RWz
         mZbpnIm91JPS41EBzCzQXFGe1mimok+Yzh24z3yokPYDAKM6CqgeVZv0RUMAMUb6bGfj
         4BUxGDcldPfeerU2uRtK9S94iyKNhrpwRqnnngf6pKx2tQNdE8FduPUAGoYjZpp5I9Hz
         mHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvZZ98+ZsTYkg5d9GGJxZP1sUx5SwZWVJ8siiSeTEiQ=;
        b=kmIMW+wozaaYcdgKarKBtA2Q4eSQbwScamwqD63mBFuVRzFctV4Z2d2VqPArYlqyYX
         GXAMzFp2IIvkWSe80Z0R1y6YYic7j/fUOvJanOIFh359dsirQaSEBMumWQc8bIiKIE5F
         kC4ZMeRqhkkLHgbrRLXe0ZS3olDJEVBa4VQqHjBy2fdOO6E7FdVHCGf67WL4R41y1fCD
         b/HJLaJUrXdV9dcmf76fUC14BlAUs8vicdIbZql6EDpHM96Zgvc5xVD7tGIj/z83iLGG
         /f3e3qzZlG+lLQWNzD1Wx1rAnM7B1opmPGqzUOpwm9EZI2+eTJSQXMu0zXax8jP8x3h+
         zgog==
X-Gm-Message-State: AOAM531n6E0lg63l8nSQgmyCmqMJjXMAwsLL8BRgqMdGkjY/vi75xpkf
        j8QPqdo/R2Mx+4WdkTOsxpTJVklKYPd+CxM6BohEpw==
X-Google-Smtp-Source: ABdhPJxT2dlCIImgLcO5pXZfgOHvmQ1PFmCORP62C543H7xjg6esBcWHlJIUNIvBYImdxEeNXjaXGHzx8AiVjQpaFnY=
X-Received: by 2002:a17:906:7b53:: with SMTP id n19mr45793820ejo.538.1638796804233;
 Mon, 06 Dec 2021 05:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZbpKqG_uS2N8TW2-HL5CqnuKDpHVCabf66MyQQof0jOw@mail.gmail.com> <Ya4MFMWSyj4YbdNG@smile.fi.intel.com>
In-Reply-To: <Ya4MFMWSyj4YbdNG@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Dec 2021 14:19:53 +0100
Message-ID: <CAMRc=MfHir4B3X=Hhkb1_VBQJFE17=YEexDa-+cs2LnFASPRkA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: Get rid of duplicate of_node assignment in
 the drivers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Thierry Reding <treding@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-unisoc@lists.infradead.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Keerthy <j-keerthy@ti.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Dec 6, 2021 at 2:13 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Dec 05, 2021 at 01:06:07AM +0100, Linus Walleij wrote:
> > On Thu, Dec 2, 2021 at 10:17 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > GPIO library does copy the of_node from the parent device of
> > > the GPIO chip, there is no need to repeat this in the individual
> > > drivers. Remove these assignment all at once.
> > >
> > > For the details one may look into the of_gpio_dev_init() implementation.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > This is definitely a patch in the right direction, as Bart says
> > it can be a bit dangerous, the outliers are those drivers that
> > assign the .dev to something completely different than the
> > the dev where the of_node is copied from.
>
> I carefully checked these all and this patch series is only for the cases
> when I'm sure it's the same device, which is used as parent, and its of_node
> supplied.
>
> > The idea was definitely always to only assign it in the core
> > *unless* there is a reason to have a completely different
> > of_node for some reason.
> >
> > > +++ b/drivers/gpio/gpio-rda.c
> > > @@ -240,8 +240,6 @@ static int rda_gpio_probe(struct platform_device *pdev)
> > >         rda_gpio->chip.label = dev_name(dev);
> > >         rda_gpio->chip.ngpio = ngpios;
> > >         rda_gpio->chip.base = -1;
> > > -       rda_gpio->chip.parent = dev;
> > > -       rda_gpio->chip.of_node = np;
> >
> > Mention in the commit message that in this driver
> > you also drop the the .parent assignment because the
> > core will handle it.
>
> Okay, I will update it. Also I'll update to the last codebase (dunno if Bart
> is going to pull the IB from Lee where one of the drivers is gone: da53cc634cea
> ("gpio: bd70528 Drop BD70528 support").
>

I didn't plan to, just drop it from your patch.

Bart
