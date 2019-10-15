Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F7ED7825
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2019 16:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfJOONx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Oct 2019 10:13:53 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:32997 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbfJOONl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Oct 2019 10:13:41 -0400
Received: by mail-vs1-f65.google.com with SMTP id p13so13260587vso.0
        for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2019 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/eFKQ/v4cr/yPgp0izVLyHlXJnLa4HICmgwi01lXvc=;
        b=y1zTKzdTdmsrc43HicE1W4OcK2myObdXuvjFUiN6jPSz0v4CsQcuh/7ktoHHvscwUe
         WAwmr+69J8UQWkzDEau4wVhaYHdaO4IdBaGAc7OY4t7+8gjIaturNOu7H8P+woacKeaX
         Q2AZx29vX20cH0G+wE6lGHbjFqhEgd6TDQt5NFwoEMYBFVyy98pBTsVcCU/gKEmrlJdN
         kXucwpHKaYU3S/aY7SwELglpgMrbYVpYBXYvalu8VW/Qx9KsRMtEKMtH8+zawqcSiAaB
         Tm6cWyWtdfchVHsvvoCwiwb379LpR2fZ0vwCzFIUCU3Atp7GrKAl4d9J2wJ6rvb4hXrN
         eWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/eFKQ/v4cr/yPgp0izVLyHlXJnLa4HICmgwi01lXvc=;
        b=VOyPnIXDnrqzlAZ5bcs/nGkDyXpKBhVjxfTP4wsszrYB51lA2P/KnYkWYiLUWkgRSM
         j2f1dKCzA4w3uOUNrFukmx7pu8r+gbp3Jl8Wsp8/NvIXt89jNrWFSn56Zx3IkHl1lZ7x
         PBGNF5wTjyT8AhlH2i6RiK4y5KAqnq1F8FvpEcYkCxJbalxf88RGFC1Fdj8yM85f87K/
         +I26001sguMUpiuinobsl69yPbi81AvZD5XSRQRCJyxU4xLdQ7AFugDYLCh1eZknMAVF
         6GHuqhV5+t9Ngrv0xd+0HGzNMbYHqExUgWBpg8mBLTL4UqdnsTBbu6xS8UcTHiVMbnMy
         LA9g==
X-Gm-Message-State: APjAAAVA/cd06/pGLcH9kMQguKsjdop85YJ35RovgUTrujHMq1TBn6n8
        DI5xO+atwI06iZtxCdr8o/aipwo81WK2HP73uw5p+Q==
X-Google-Smtp-Source: APXvYqxluszvLcVxMEdWdPelTTF58EOAxfZDkgM4jA/rH5H2Cc2i74AuIVwFlZIgVdMLDs2o7gG3CCQM2jc+SegK0h8=
X-Received: by 2002:a05:6102:5e1:: with SMTP id w1mr4153604vsf.191.1571148818927;
 Tue, 15 Oct 2019 07:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de>
In-Reply-To: <20191010203043.1241612-11-arnd@arndb.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Oct 2019 16:13:02 +0200
Message-ID: <CAPDyKFqkRApT-q4ssi1Hn2cmLY=0K7bKXdo-D42q+xACFcC9dQ@mail.gmail.com>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-pwm@vger.kernel.org,
        alsa-devel@alsa-project.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        linux-serial@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Olof Johansson <olof@lixom.net>,
        linux-spi@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 10 Oct 2019 at 22:38, Arnd Bergmann <arnd@arndb.de> wrote:
>
> These can be build completely independently, so split
> the two Kconfig symbols.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig.debug        | 6 +++---
>  arch/arm/Makefile             | 1 -
>  arch/arm/plat-samsung/Kconfig | 2 +-
>  drivers/mmc/host/Kconfig      | 2 +-
>  drivers/pwm/Kconfig           | 2 +-
>  drivers/spi/Kconfig           | 2 +-
>  drivers/tty/serial/Kconfig    | 2 +-
>  sound/soc/samsung/Kconfig     | 2 +-
>  8 files changed, 9 insertions(+), 10 deletions(-)

For the mmc parts:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 9c4f2d6deb06..4c4e97ae4fcb 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -998,7 +998,7 @@ choice
>                   via SCIFA4 on Renesas SH-Mobile AG5 (SH73A0).
>
>         config DEBUG_S3C_UART0
> -               depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +               depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>                 select DEBUG_EXYNOS_UART if ARCH_EXYNOS
>                 select DEBUG_S3C24XX_UART if ARCH_S3C24XX
>                 select DEBUG_S3C64XX_UART if ARCH_S3C64XX
> @@ -1010,7 +1010,7 @@ choice
>                   by the boot-loader before use.
>
>         config DEBUG_S3C_UART1
> -               depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +               depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>                 select DEBUG_EXYNOS_UART if ARCH_EXYNOS
>                 select DEBUG_S3C24XX_UART if ARCH_S3C24XX
>                 select DEBUG_S3C64XX_UART if ARCH_S3C64XX
> @@ -1022,7 +1022,7 @@ choice
>                   by the boot-loader before use.
>
>         config DEBUG_S3C_UART2
> -               depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +               depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>                 select DEBUG_EXYNOS_UART if ARCH_EXYNOS
>                 select DEBUG_S3C24XX_UART if ARCH_S3C24XX
>                 select DEBUG_S3C64XX_UART if ARCH_S3C64XX
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index f492d7c338fe..a1bc15cda751 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -235,7 +235,6 @@ machine-$(CONFIG_PLAT_SPEAR)                += spear
>  # by CONFIG_* macro name.
>  plat-$(CONFIG_ARCH_OMAP)       += omap
>  plat-$(CONFIG_ARCH_S3C64XX)    += samsung
> -plat-$(CONFIG_ARCH_S5PV210)    += samsung
>  plat-$(CONFIG_PLAT_ORION)      += orion
>  plat-$(CONFIG_PLAT_PXA)                += pxa
>  plat-$(CONFIG_PLAT_S3C24XX)    += samsung
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 740bdb23f38a..1530946cc672 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -4,7 +4,7 @@
>
>  config PLAT_SAMSUNG
>         bool
> -       depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
> +       depends on PLAT_S3C24XX || ARCH_S3C64XX
>         default y
>         select GENERIC_IRQ_CHIP
>         select NO_IOPORT_MAP
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 400a581c918c..16a0e5430b44 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -275,7 +275,7 @@ config MMC_SDHCI_TEGRA
>
>  config MMC_SDHCI_S3C
>         tristate "SDHCI support on Samsung S3C SoC"
> -       depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_EXYNOS)
> +       depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS)
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           often referrered to as the HSMMC block in some of the Samsung S3C
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index e3a2518503ed..8eb738cac0c7 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -394,7 +394,7 @@ config PWM_ROCKCHIP
>
>  config PWM_SAMSUNG
>         tristate "Samsung PWM support"
> -       depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +       depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>         help
>           Generic PWM framework driver for Samsung.
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 6f7fdcbb9151..355391ee643d 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -625,7 +625,7 @@ config SPI_S3C24XX_FIQ
>
>  config SPI_S3C64XX
>         tristate "Samsung S3C64XX series type SPI"
> -       depends on (PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST)
> +       depends on (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST)
>         help
>           SPI driver for Samsung S3C64XX and newer SoCs.
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 4789b5d62f63..17f01cf3009c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -237,7 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
>
>  config SERIAL_SAMSUNG
>         tristate "Samsung SoC serial support"
> -       depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +       depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS
>         select SERIAL_CORE
>         help
>           Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index 638983123d8f..7a0035dd9995 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig SND_SOC_SAMSUNG
>         tristate "ASoC support for Samsung"
> -       depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
> +       depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>         depends on COMMON_CLK
>         select SND_SOC_GENERIC_DMAENGINE_PCM
>         ---help---
> --
> 2.20.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
