Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C581A3D5A50
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhGZMtC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 26 Jul 2021 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbhGZMtB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Jul 2021 08:49:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAABC061757;
        Mon, 26 Jul 2021 06:29:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso19779488pjb.1;
        Mon, 26 Jul 2021 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=T2M2m5EQciujNLUuC+pkqW7V+FPllhwGArTVEJKAIkM=;
        b=Z0wXUWdWTq+VvX8G1114JtKpwtaesv1bz8fgCrItkOuDJybb+hXQATg6BwXn9KLNEk
         GFPGnqcCBqN4iBZYuz99W5JiDaSkmKZmLj8+x+5G387GBkmMVCJhwpSYxaOtWhsE62jz
         AIExYtBRaosAhAF3OgpnnoRfj4z+GUbu3aOk4OXpM8Qo2PABg0pbgTbnlkaKs5Q1zXy8
         gWJZBbsqsaLXdujE//Cub1OYl/c2avOQH85ZbjDndYZ+chWgr7noE7jgXIjkJ52+VZG5
         AFMcv36Wz7jclvBGEk6JHewt71FMd3+R8gVkDFZm1a8lWFSJmysrmVYKN2TVxWtO6dyP
         oIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=T2M2m5EQciujNLUuC+pkqW7V+FPllhwGArTVEJKAIkM=;
        b=oDHcJsmdQFg9PairoKsqJ5YAv7z0mPb/YCoikH42T3+Obj/0qwKltAH1tgApUxJsrp
         3c1LSDsUYXyNmjQdPcWmnaliuXCs318iQ9h1Si5HJGFa6q0AoLuOEXyTuvHPDwYc713X
         1/FaWgXccXoVbnXZjrQppATRt74ZxKJZ+83UNPSL/J/9oRst0wT/9gbZn+OhWKUT0ywh
         xyJfDYBWOTMVJeB2JfAcpWWsS/TdEmUQwyxyu8OTJmc4Wl+R6zWPSszZQw6p4tfwkwwf
         I42t1nvNm4EYutxlxZODZYnaKukQsr8iTHYIKHBqqCKoGGBAMsG3Vlk7ImSW1IAiqNYq
         lfNA==
X-Gm-Message-State: AOAM5306+2PD3wemnxpEPd02a6GLIgtTR97oOZsT3HaFZb6SSWDBovcl
        h3UqGCLnFjK6C5MI6h/3FSctnPHOd3UK7zlqZOg=
X-Google-Smtp-Source: ABdhPJzhCeds9WV8564AJ6rlbVBLPbpaceRA7H8UZXRoRpjFu1G0dJrj1++YaMdxdpSrImDnVS1390rLEdYoZpvHDgs=
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr17323968pjb.228.1627306169156;
 Mon, 26 Jul 2021 06:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210625171434.3xusxpxjprcdqa47@pengutronix.de>
 <20210705080144.zfbzkm7l3gmnh6st@pengutronix.de> <20210722060654.nudpdtemosi64nlb@pengutronix.de>
 <YPkg0wtYIoHKpTUW@kunai> <20210722081817.2tsjzof4gvldq6ka@pengutronix.de>
 <YPlfcbkxiBmB+vw1@kunai> <CAHp75VfC=s12Unw3+Cn0ag71mM5i90=Jbwj4nYwB5cPKiUTRSA@mail.gmail.com>
 <20210723091331.wl33wtcvvnejuhau@pengutronix.de> <06e799be-b7c0-5b93-8586-678a449d2239@microchip.com>
 <CAHp75VeFXJ-0ak7=a0QCtKNdFpu98W6iJ2YuR4MpNx+U4rHe2A@mail.gmail.com> <YP6rdmi31FFrBMzE@ninjato>
In-Reply-To: <YP6rdmi31FFrBMzE@ninjato>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 26 Jul 2021 16:28:49 +0300
Message-ID: <CAHp75VeT-EX6U3+Y7dxoWWRZ7NqAEiNgPGW8YGVmWTuZKB4j+Q@mail.gmail.com>
Subject: Re: [PULL] Add variants of devm_clk_get for prepared and enabled
 clocks enabled clocks
To:     Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 26, 2021 at 3:33 PM Wolfram Sang <wsa@kernel.org> wrote:
>
>
> > The idea is that you will send a PR to CCF maintainers instead of
> > patches, although it's expected that patches appear in the mailing
> > list beforehand anyway.
>
> Depends a little. For me, a Rev-by from the driver maintainer is enough,
> and I'll pick them. That lowers the burden on the drivers maintainer
> side. May not work for high volumes of patches, but for I2C this works
> enough.

AFAICT in practice it's a mandatory requirement in I=C2=B2C subsys (in the
past you hadn't accepted a patch from us without a tag from the
maintainer) which makes it equal to sending PR by a maintainer. PR
makes less burden since subsys maintainer don't need to run many tools
or a tool many times to get the pile of patches.

--=20
With Best Regards,
Andy Shevchenko
