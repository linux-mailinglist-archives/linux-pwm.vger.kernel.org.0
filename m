Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0FDE05BB
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 16:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfJVOBc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 22 Oct 2019 10:01:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfJVOBc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 10:01:32 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Ml6Vg-1hbmf00qzM-00lVCj; Tue, 22 Oct 2019 16:01:30 +0200
Received: by mail-qk1-f173.google.com with SMTP id u184so16330124qkd.4;
        Tue, 22 Oct 2019 07:01:29 -0700 (PDT)
X-Gm-Message-State: APjAAAXylN35vLp7LcKQWl1mf/SQRyJQ+Jhfx/+/q50VBkwkAbUAvipI
        gNDSSJZLA0cTPMgfqe6gRRGBTM0Cjfe+mrVbDZM=
X-Google-Smtp-Source: APXvYqzNJSBsmzArUiJoxHmomaDqQtkgb7eiZl33ieH3Pnwwm1/FZ2lXqT+Z19UoP0NfH21IBu5WdckCCzmNgI5QFYQ=
X-Received: by 2002:a37:a50f:: with SMTP id o15mr1985123qke.3.1571752888552;
 Tue, 22 Oct 2019 07:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de> <20191011055149.4dudr4tk2znpt65u@pengutronix.de>
In-Reply-To: <20191011055149.4dudr4tk2znpt65u@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Oct 2019 16:01:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1st8gR7u+8-oyP6HrzZdmrzhq7PRonYuz0a5O8rfKaSA@mail.gmail.com>
Message-ID: <CAK8P3a1st8gR7u+8-oyP6HrzZdmrzhq7PRonYuz0a5O8rfKaSA@mail.gmail.com>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
        Jaroslav Kysela <perex@perex.cz>,
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
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:Hv7SAjdeGUOuU0McebMKe8pPPZg0PjMGWOl/Urvv+a4u20VCEki
 BFcgNMzF1Ce2YeJaDkJj/8e1qZD+QsK9q7XCqvXzzhWPfq25ha/TveFndkJVh3L2f/jhBlx
 JciffjQ98mgELP72Tjk9qG3zcowbLTUYNBfBre1jKWUn5R768dPB81VhbT5M0AnUbkgzJYs
 ZewkdgDUCJWp7CJE7usUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hRmFgw04pHw=:GuyhHbXPjvHIFHW4LRgnKZ
 JUUU3xWSamtSYw54My8YFjIeR73SnkKRIsMIAdVCUi9rvsNxaJDcJxRYNlfLkI9DzpPfqpQTA
 I7G1r69BMop3/1BDwtYEmRW0ol67cpVwD/kRph1WTOrhogNP4yfHwpwAygty8a9J5EPEFMil9
 KWPpH/57iFFSeaJ2YSuFIPyWMBBLQl++b3TSh0BHi/XCSUDfvpjhqMgO4R1ah5Jw6OWW4lHMu
 wHzuHnAmBRT9HCPxwqvPkFsKoJ1IkKua7U8vB/6Pt2WkXimrVAhOKtzbeh+tQnF5aArHzooI2
 BKkzGzuHxPakyMObe5/QrkDyKv89Rg1fE1Tjf2oCbGlQXVnxUPsgKK6hM9Ocm7HgKQY4sdfBG
 /B2HCfkNZwHUdK6ZWvg84yx54x5BvnSLxf8zXn78HzDm+IsVlr1PDezP3mgrfXj3zQK+h+l7G
 Glkjok+W2Nb8gODf1HZ31B3Yw8cStsgywOo2itc9dTJ2hFqEvHrGQA0urUm+7j/uW0JJ6MsQ+
 bC9PCelDGsrVTiO2ViP/Lpam7+ce0lYliOJv1EkYMITtMm//AcupeTwf0O/j9mghlw2gSMgdL
 ezJMy71zKCYvT99BZzOgTJuaUEOtzv9Eu0ZzW5YJaI1iZZ2mMr4uA00vDupp4Q8dQfW5k3RHY
 6k4TnW4N/haFxfLXHSwFbv9quv8KHVwTWLUXy9ygc3odU+r+hpSfgfAPD/wYDJlCHDLu7X0LF
 l4A+x3+t3SGQHn8iI91phMXHlOW5YMGjvfVpPrU6aJZzSJWKOCAewYLuFBiF6C7SiNgfB7jbe
 2Pq0cXaLg4l7xTsen5u4CNRbXmq2yYggxPCbU73Fyk5nVz+3xg8cIrHy/l7DmXg1wfM444Q9S
 tU94dcFtWb1hgiPPpMyw==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 11, 2019 at 7:51 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Oct 10, 2019 at 10:29:55PM +0200, Arnd Bergmann wrote:
> > These can be build completely independently, so split
> > the two Kconfig symbols.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I'd mention the two symbols' names you're working on in the commit log.
> I guess it's about PLAT_SAMSUNG and ARCH_S5PV210. And I wouldn't call it
> "split" which IMHO suggests there was only one symbol before.
>
> Maybe:
>
>         Don't imply PLAT_SAMSUNG if ARCH_S5PV210 is enabled
>
> would be a better subject line?

Ok, changed to

ARM: s5pv210: don't imply CONFIG_PLAT_SAMSUNG

> > @@ -235,7 +235,6 @@ machine-$(CONFIG_PLAT_SPEAR)              += spear
> >  # by CONFIG_* macro name.
> >  plat-$(CONFIG_ARCH_OMAP)     += omap
> >  plat-$(CONFIG_ARCH_S3C64XX)  += samsung
> > -plat-$(CONFIG_ARCH_S5PV210)  += samsung
>
> Would it make more sense to make this
>
>         plat-$(PLAT_SAMSUNG) += samsung
>
> (in a separate patch)? Hmm, it seems there is no plat-y for
> PLAT_S3C24XX=y builds. Is this intended? If yes, the directory name
> containing "samsung" suggests something that seems untrue.

By the end of the series, the plat-samsung directory is completely
removed (folded into mach-s3c), so that would only add more
churn for the same result I think.

     Arnd
