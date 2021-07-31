Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B73DC4D1
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Jul 2021 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhGaIHv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 31 Jul 2021 04:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGaIHu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 31 Jul 2021 04:07:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66B8C06175F;
        Sat, 31 Jul 2021 01:07:43 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso17678477pjf.4;
        Sat, 31 Jul 2021 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzB0Wv52KsFnVdP16+9dKjfpIjO/e956EYCnp3uw5/E=;
        b=COQp+wz4kVmTID7nr3HHUh9p/J2NOMrFfmoEnJGf7DdzS2ggaNvUdYp/yXlBna2+Tg
         +BDjYGgNBq7XVS65YFjKVSGV32q+O4gFrMeQXhpPWDe/0+Ac/93WNmMOdmpiOfaqEUN2
         5onz4ijj/6RAzknkzI5lD3VOvssIQ1jbgSLTa1Y/sCDEMFcXICQ+Sr1ZIGyHa8KjBPfo
         P80vyZmOTNr73Ft6QiYiwMMwbrULOVokx56VHzxGd8d1PE48ERk12p+ZgJysqzj1ySDw
         0pRzejEfv8dUUm0EvpUnFxMRaPAmYCoWlYutrq7NMhF+QhfePKe5i6SGigW88m+VFCm9
         4tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzB0Wv52KsFnVdP16+9dKjfpIjO/e956EYCnp3uw5/E=;
        b=ZRUGUcVok+V3k1K3T2LfqfZprPVkNsmhNzAp0HY4u6FrKRC1Vh49FdYhXD6/GMIshE
         MUcpn9MmfyLB6OTHXWqvrfVZvsI1SeG3MK0yfPCI1w4x0eBQ1TUxoful8u7G1w0G5fN4
         GItb/B9VhRSViVopGmg6xr7325CHuwREWxbq8mZnW6wT2z8AygCHjFt2sXwi+JZyuq6D
         xG/tunZy6mJJweJIVg3KNtpDLFadr4wSB7Zf0ze4d9ITzCSaFrLsQbk1JxRe2Rcy2b0v
         Lt/J+4actn0UWcKEnY0sPtpgUeiETGa3jZ5XxcM4iqjwziy3wuWihV8vvRwcBgtiir0D
         TSHA==
X-Gm-Message-State: AOAM531eAKM2bwv8gntFQeB0ZEo/6Y6tYYBh/yWQ6S/bbVTYNkfoOsVl
        d5Lj3/TvLASyS86W56wzy3cqr8KLOmjAYwjCe6s=
X-Google-Smtp-Source: ABdhPJyLYG6EfSxZbGTYMX3Nqur5AXec31dZTbExzR9cSxq9PzXJa1/vcRltYuuCpFlITVCEvyG9dHw47zXBhSlcFFc=
X-Received: by 2002:a17:903:2444:b029:12c:8eba:fd6a with SMTP id
 l4-20020a1709032444b029012c8ebafd6amr5994645pls.0.1627718863409; Sat, 31 Jul
 2021 01:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210722060654.nudpdtemosi64nlb@pengutronix.de> <YPkg0wtYIoHKpTUW@kunai>
 <20210722081817.2tsjzof4gvldq6ka@pengutronix.de> <YPlfcbkxiBmB+vw1@kunai>
 <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de> <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <20210728202547.7uvfwflpruku7yps@pengutronix.de> <20210728204033.GF22278@shell.armlinux.org.uk>
 <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
In-Reply-To: <162771727997.714452.2303764341103276867@swboyd.mtv.corp.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 31 Jul 2021 11:07:07 +0300
Message-ID: <CAHp75VebJrb2VLSz7j+gX1RsVggHt1hNu7QyMWmPsY7D+UjUFw@mail.gmail.com>
Subject: Re: About clk maintainership [Was: Re: [PULL] Add variants of
 devm_clk_get for prepared and enabled clocks enabled clocks]
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-spi <linux-spi@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jul 31, 2021 at 10:41 AM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Russell King (Oracle) (2021-07-28 13:40:34)
> > > I adapted the Subject in the hope to catch Stephen's and Michael's
> > > attention. My impression is that this thread isn't on their radar yet,
> > > but the topic here seems important enough to get a matching Subject.

> I still wonder if it would be better if we had some sort of DT binding
> that said "turn this clk on when the driver probes this device and keep
> it on until the driver is unbound".

DT is not the only way the clocks are established in the kernel.

> That would probably work well for
> quite a few drivers that don't want to ever call clk_get() or
> clk_prepare_enable() and could tie into the assigned-clock-rates
> property in a way that let us keep the platform details out of the
> drivers.

> We could also go one step further and make a clk pm domain when
> this new property is present and then have the clk be enabled based on
> runtime PM of the device (and if runtime PM is disabled then just enable
> it at driver probe time).

This sounds like a good idea from a usage perspective.

-- 
With Best Regards,
Andy Shevchenko
