Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDDB3DC885
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Aug 2021 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhGaWFV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 31 Jul 2021 18:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhGaWFU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 31 Jul 2021 18:05:20 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1897C061799
        for <linux-pwm@vger.kernel.org>; Sat, 31 Jul 2021 15:05:12 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l17so18393409ljn.2
        for <linux-pwm@vger.kernel.org>; Sat, 31 Jul 2021 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eavS7+nVlKa3pE/nMERuVdSNOcLN0CSyw0CYPXJs2RE=;
        b=oxTawDKtE7gUMCEZTGVhmlVv2Y3WYDP+FS3lOaHPAgoD7WcgQjYd0RzzaaCmE3977P
         y2AZlp+prHKgerutQ7jx1R/cVL6lbK+WzauqEJucT+Izj+ziz0I0tc0O+XwvtPwksIj1
         ukvPhZPy1rocK17IvtjWMFHZ1JmoIIqK4FLNFIt716WQ3Pie0UvlUCbiTbUjKG2RTcHV
         7aLptfufBWxUeUNmjY6/SgCFLiwOzAyRIGpCOm9JFIGiWEdzkbX1t7kvgcWoJlruvGQV
         TNKC7K+DYoXaKkZDcceTWufkpcffdIMAe8eG+6751qHasEPk6w4m+/EI6Gd9NCUzZuvT
         oxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eavS7+nVlKa3pE/nMERuVdSNOcLN0CSyw0CYPXJs2RE=;
        b=j9BrbFSsjE8xPQGFfNEOgbWvL5TpEq9eg4Q7CvlDKBTvXYN1aTiYltjTLL6EPZPwhy
         AdeUKCULVjNG/wDjnJBif17ZztDuWMZnExAToK1hTEZtSIocO04V/lHXt/TYfAe4CmwF
         eX+ttCrlV/W1sP+r6JC7VRFV6hEGN4jPxdi6/SXW25lcF0OwzZYpu4C4s915/TCSchJ8
         adZ6fs5cPkyRjFvHRDquvoNeTS77Q0yrI8WBXxxQdoawF99w9QmX4oaw3tN5StRG9dav
         LMZTQklg5Gqnz8jdFt7Jsuvr18bEuVC/7al+48zm0Z/50k4Pz6EZpZwpH2eErb9MPzXM
         BvDA==
X-Gm-Message-State: AOAM533AdDo21+T0zit/GcWMba2y3dhFDC88HcdY44SWOniMMEco/ty3
        30lKfQA0LrmvIbSZ/uyz+t5XRQg00CFBTJGEyd4/kA==
X-Google-Smtp-Source: ABdhPJwTjpbUeZT+xrHLeSR/vD0UodSpw43lXDmx8pJiyALETra8HqJRQTMUGT7mTfcqIT7xDGsd2Eo06KRRqoQp1Bw=
X-Received: by 2002:a2e:bc14:: with SMTP id b20mr6401323ljf.200.1627769110442;
 Sat, 31 Jul 2021 15:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
In-Reply-To: <20210726115058.23729-1-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 1 Aug 2021 00:04:59 +0200
Message-ID: <CACRpkdYeqJFFwkc6pfSrz3-gaN_PjjV52jstqzR2sMa+bxbMuQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm: ep93xx: CCF conversion
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 26, 2021 at 1:51 PM Nikita Shubin <nikita.shubin@maquefel.me> wrote:

> This series series of patches converts ep93xx to Common Clock Framework.
>
> It consists of preparation patches to use clk_prepare_enable where it is
> needed, instead of clk_enable used in ep93xx drivers prior to CCF and
> a patch converting mach-ep93xx/clock.c to CCF.
>
> Link: https://lore.kernel.org/patchwork/cover/1445563/
> Link: https://lore.kernel.org/patchwork/patch/1435884/
>
> Alexander Sverdlin (7):
>   iio: ep93xx: Prepare clock before using it
>   spi: spi-ep93xx: Prepare clock before using it
>   Input: ep93xx_keypad: Prepare clock before using it
>   video: ep93xx: Prepare clock before using it
>   dmaengine: ep93xx: Prepare clock before using it
>   ASoC: cirrus: i2s: Prepare clock before using it
>   pwm: ep93xx: Prepare clock before using it
>
> Nikita Shubin (1):
>   ep93xx: clock: convert in-place to COMMON_CLK

This series is looking very good.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose the per-subsystem patches can be picked up by
each subsystem maintainer and then you can send the "big patch"
to the SoC tree.

Yours,
Linus Walleij
