Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E1BE1DC2
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405678AbfJWOM3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Oct 2019 10:12:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44482 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405316AbfJWOM3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 10:12:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id r16so15850605edq.11;
        Wed, 23 Oct 2019 07:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcTMyT1DxjA7fFrS2w24JzXu+0SnoZwJUx+ToqxoQbY=;
        b=FnUPTeClwtKNqLjQPMFpQm0p4bhUkbflqUYO7UEG+hyFyZVhjZiTsf4NoFA9XYyTe+
         V/dhZuVxT3Og3mA0VGA6bPYauFduz338RgypJymPhfRg51npRHOlTYhy+YNyDVFa71CQ
         pDXm3uKCqadjRMENRqPDgHPQbW0WnDZ8HxH+OSIvm669GTsR1Py5j/6hN8iftKbNYuQj
         Cdn3tnGQqeWvA6whCrU2M3gSRLIWrkkfFeNtMOXiKvzwQZKZhIuXzpCaVXfxsKLS8y3h
         ewjtgPv+7Qn9QzeZrh97+/bVEZ/VUGo75ZCNX68eHbcP8LS7UhxRs/H/LCm53dl331Ai
         uqCg==
X-Gm-Message-State: APjAAAXsFKwQJnoIOXwHhJO0UHlYmbfpppfA6Q8hEGWo6tnmE51WHufL
        QdETKQ90T0PcgEi0bINFee0=
X-Google-Smtp-Source: APXvYqxkd9DwWDZi/qHKDFHlMK0H8AlyVBKbEwPxz7lMmEqyzeKCvZ18JbP/k1gOjozG9nkYwgwxAA==
X-Received: by 2002:a50:ee8d:: with SMTP id f13mr25391791edr.285.1571839945480;
        Wed, 23 Oct 2019 07:12:25 -0700 (PDT)
Received: from pi3 ([194.230.155.217])
        by smtp.googlemail.com with ESMTPSA id p9sm60974edx.4.2019.10.23.07.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 07:12:24 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:12:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
Message-ID: <20191023141221.GA11575@pi3>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de>
 <20191023121458.GB11048@pi3>
 <CAK8P3a3ktdA12vpi6zrTXs7-03efk2Ke_0_mQ9X40MLNcZnEqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ktdA12vpi6zrTXs7-03efk2Ke_0_mQ9X40MLNcZnEqA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 23, 2019 at 03:17:35PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 23, 2019 at 2:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
> > > These can be build completely independently, so split
> > > the two Kconfig symbols.
> > >       config DEBUG_S3C_UART0
> > > -             depends on PLAT_SAMSUNG || ARCH_EXYNOS
> > > +             depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
> >
> > How are you going to select DEBUG_S5PV210_UART now?
> 
> I don't see a problem here, the patch should not change the behavior at all.
> 
> The whole entry now looks like:
> 
>         config DEBUG_S3C_UART0
>                 depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>                 select DEBUG_EXYNOS_UART if ARCH_EXYNOS
>                 select DEBUG_S3C24XX_UART if ARCH_S3C24XX
>                 select DEBUG_S3C64XX_UART if ARCH_S3C64XX
>                 select DEBUG_S5PV210_UART if ARCH_S5PV210
>                 bool "Use Samsung S3C UART 0 for low-level debug"
> 
> so this will work as before with any of ARCH_EXYNOS, ARCH_S3C24XX,
> ARCH_S3C64XX and ARCH_S5PV210.
> 
> What am I missing?

Ah, everything is OK, I mixed up removed with added line so it looked
reversed (removal of ARCH_S5PV210).

Looks good.

Best regards,
Krzysztof

