Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE9AE1C23
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391184AbfJWNRz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Oct 2019 09:17:55 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54383 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbfJWNRz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Oct 2019 09:17:55 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MXYEr-1iVkTO0q2p-00YwUO; Wed, 23 Oct 2019 15:17:53 +0200
Received: by mail-qk1-f176.google.com with SMTP id w2so19692817qkf.2;
        Wed, 23 Oct 2019 06:17:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVRP7+XXLOGJ2qzxRPim87cYAH/HCvEjuapVyW383qOmJ2p6k/j
        r44ZulpoeG/MKquLWO2W2DrKHIC7YfqReeZDQ98=
X-Google-Smtp-Source: APXvYqwuwF999+RxRIbSV5NNX+xHenNtGFCAqCA+7Cahtx0tw1C0BafJPH8NNbUYS7dpsAsfv3lWqVq7b2MktsSH9qA=
X-Received: by 2002:a37:9442:: with SMTP id w63mr7981201qkd.138.1571836671589;
 Wed, 23 Oct 2019 06:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de> <20191023121458.GB11048@pi3>
In-Reply-To: <20191023121458.GB11048@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 15:17:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ktdA12vpi6zrTXs7-03efk2Ke_0_mQ9X40MLNcZnEqA@mail.gmail.com>
Message-ID: <CAK8P3a3ktdA12vpi6zrTXs7-03efk2Ke_0_mQ9X40MLNcZnEqA@mail.gmail.com>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:U1spPertaXPTso5CJBqN3itC6kIsQkitKvFOpXuZUkF7n9Dgmy6
 +jlyWhU42oj4t6ZztdvUm8YHBEQ7Y6VhrDKem6yvAiCDF3IcZwCSl4uQg6aib0HeUltEYoh
 8n84Je1GgeCfquk69wqeYJ166CJs8AgHBUxbI9HGlFaS5uLwzXjd+4sgsQHrdIx5VV5XEYb
 lW3KwwZ0Clc9+qFYFaSFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IQQX/1aQd6U=:2/HZS3UQ1BXkUgYtvzQNbJ
 4FzJPajCM9id9EM7B5VCR4XvBcm+uMGZUG63BGI4IHVW5SI0NYadiSkOEfoqOWrizzLK/K8wN
 b81STCOV4oV0ZwRdj4+VPx50TKjth8D8uz1YD/AH/i5HsYiPW0Q2PAJ3TgUQvX3pzTCAHx43/
 fUKUM++xVm29jA94vAj9ufb6o2gLanexMb+mLmFV0RkvsH59WiuuLYygG4dh/exJacpv3tnr/
 0G6i4XfvCBozYHzY+WvDeliu2Wt2o7+mCm9HBWyZMgfoMiaUOZFEvwOrtWH5FNuuOcpLyu/R+
 c89JyNOJfoRZMKxNiz7vQ7TjcQo1jN6kxz7+VZu3KSDhuqLpIfVwp+h/BSaVjVny5pXrA9yyH
 PzHjqCYdQnZkLdT7484NrXuTrW6TAGNhB9/7I8MIJzH7u4J1crc/8o1f4F8B3kDSNZ7gHgs0V
 TgHWwyEtOCO4poorlBpoBG93/yJeJNE8Lxfe0yFK4BiPC0wBzEjgeRfcg9UvBVJHtgGkqmZUX
 J+O7d6bThy0GIqG5fw4eboTWoISB62yRCg50sf2/CyOzhVfxuKcmSbMIhkLKDfBxIZjm3pej3
 4RSsbprGtHaRfrbOicCrT+9tcAq74Ar+3FYU1gRTm2p1CwPqGfDDssJtNnr7SM+W+75S2Hsml
 xP7/fYdQRym6pcChRqrw5hyigRv+8KCgsU2k+WM2Za6MEzhPiCUMjqZ6zP6Ab42eeVgbkKQff
 Z+UrgdgBcmejwdC4RNw/NERiOohLNV1HJoKx4UMEPDFZplvGBwfRbHRoxazS6buZJQyaV36hc
 0tisvUg/omTaQeBNTNh7K67oL+vcp8+lmzHCgMSCIIwowwxDqIXl2xu/fJ7gdoMG19juFH372
 py8sY0FmOY2495P77yVg==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 23, 2019 at 2:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
> > These can be build completely independently, so split
> > the two Kconfig symbols.
> >       config DEBUG_S3C_UART0
> > -             depends on PLAT_SAMSUNG || ARCH_EXYNOS
> > +             depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>
> How are you going to select DEBUG_S5PV210_UART now?

I don't see a problem here, the patch should not change the behavior at all.

The whole entry now looks like:

        config DEBUG_S3C_UART0
                depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
                select DEBUG_EXYNOS_UART if ARCH_EXYNOS
                select DEBUG_S3C24XX_UART if ARCH_S3C24XX
                select DEBUG_S3C64XX_UART if ARCH_S3C64XX
                select DEBUG_S5PV210_UART if ARCH_S5PV210
                bool "Use Samsung S3C UART 0 for low-level debug"

so this will work as before with any of ARCH_EXYNOS, ARCH_S3C24XX,
ARCH_S3C64XX and ARCH_S5PV210.

What am I missing?

     Arnd
