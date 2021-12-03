Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7779467358
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Dec 2021 09:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379240AbhLCIoc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Dec 2021 03:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351142AbhLCIob (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Dec 2021 03:44:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CB1C061757
        for <linux-pwm@vger.kernel.org>; Fri,  3 Dec 2021 00:41:07 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so8297809eda.12
        for <linux-pwm@vger.kernel.org>; Fri, 03 Dec 2021 00:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLBHn9jsbKV7jZYY7Dm+t8lPDQRTZnoOfAaLgWh49GU=;
        b=LsIAHi4O7+rAKszJKyJ/QwZwolqgX7Xp85HCfWi/OAlf7oOjExVQVB3A1uF6oJMxXi
         gPosTZ3PyRq9IbJKMX4ESqDGYZZYcom4XQ8JtyMRl5tOE7xlwAkd4FpJbONadp6pWo7I
         oUoB99whrPg0HGUqiRetXBExiz97qDkf5NdxXb1GpetgxbWitUxWw81WWVuMwB7DeHg4
         F4fsE0Im8ySC6EvPdTGuYxXIdnTwT10W+OMVEHRanF7YSviRe6CvO4rDs/Sfax7qLy0G
         GQ8KIQPRWvs0w82uwlN5lRnk2skx92g4UPLasKF6asjvNdNubK/yYeFyTDsn7OcD+219
         BK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLBHn9jsbKV7jZYY7Dm+t8lPDQRTZnoOfAaLgWh49GU=;
        b=B27S1m5XB6LtWoi0Tr7tAhcHTP1NDKFrgHGBIH1Xt4RJVsod5aIaWzqNVXtUZB5mOu
         dCZdNxMHStK63UNDlpHqfj0UHtYqsJYZKXWB1aUj+ORfFxree1ZdBrWnzoYUDTuy8gbT
         2Uf6rUwCxYaknaFmfr71CX/wOGtZt+xJMLf8tAY+MXLuTrfd6nNFmd+J9h4PDhldpKga
         OD2v4afT7ihDoAA7Tj/2NEYhz9IZdD5JgFxucqLAtRiegciABE0f/7azb4LJ7fwuhcbY
         dr29aIQ3+Ru6ZkuX3Nl94cBbj0cDde1UkOIS/DgcREjjyiY/trQXqZxK0hx4c802yLH/
         isNA==
X-Gm-Message-State: AOAM533R0Jn3o+a2aLsXMax0sHk4XrDcqSm7yZrMOYHZHz7z5HbqBZiL
        A1ZKCuW5nCJTw01Ao7niyRqJdHDxg8rj1+4cAim4xA==
X-Google-Smtp-Source: ABdhPJzNHiauf+pMC5f/US+c9OIXcWbcKMNg90ABw6xCvQOgNu83JV2BIOiQy03TdGH6uVMTEr4y57dSuqO0jiYbpps=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr22268827ejc.77.1638520866276;
 Fri, 03 Dec 2021 00:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211202210839.79140-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 3 Dec 2021 09:40:55 +0100
Message-ID: <CAMRc=Md-TKUETLzf41D2KeQODac153_AumMTW4928XfJ70GRxQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: Get rid of duplicate of_node assignment in
 the drivers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Lindgren <tony@atomide.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Thu, Dec 2, 2021 at 10:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove these assignment all at once.
>
> For the details one may look into the of_gpio_dev_init() implementation.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

I have a bad feeling about this but I've gone through the drivers in
this patch and it seems like you don't update any of the drivers that
use multiple child OF nodes so I can't really point out any obvious
bug.

I have another change I'm working on that's related, let me send it shortly.

Bart
