Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B571AE0899
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfJVQVC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 22 Oct 2019 12:21:02 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731795AbfJVQVB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 12:21:01 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MS3zP-1iSkhU2FY3-00TUuV; Tue, 22 Oct 2019 18:20:59 +0200
Received: by mail-qt1-f173.google.com with SMTP id e14so7848020qto.1;
        Tue, 22 Oct 2019 09:20:58 -0700 (PDT)
X-Gm-Message-State: APjAAAUEAGN4gaRKmWrYNcXWxxrjr9EpakHb0V6ccEo0QzQadSWzAwwv
        gi0XGRiecf2QPS6ja97yKeDLEfmUA3j4tbdrYnA=
X-Google-Smtp-Source: APXvYqyoLKHktNxYMbHgU6oEzWDucDHxX3DzLUXc70BjhpXFB5K+Mcs4VGMIh8ghBPfcQzJ4zkTEBWIuMQ3o+13CFPs=
X-Received: by 2002:ac8:33d4:: with SMTP id d20mr4201539qtb.204.1571761258010;
 Tue, 22 Oct 2019 09:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de> <20191011055149.4dudr4tk2znpt65u@pengutronix.de>
 <CAK8P3a1st8gR7u+8-oyP6HrzZdmrzhq7PRonYuz0a5O8rfKaSA@mail.gmail.com> <20191022155307.izh4ryorm7thw7tq@pengutronix.de>
In-Reply-To: <20191022155307.izh4ryorm7thw7tq@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Oct 2019 18:20:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1mvbss6Q-CQBYRAf7ozYgyOu3WFGkoaSaoJriUbuRACA@mail.gmail.com>
Message-ID: <CAK8P3a1mvbss6Q-CQBYRAf7ozYgyOu3WFGkoaSaoJriUbuRACA@mail.gmail.com>
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
X-Provags-ID: V03:K1:xTdslASVHIHUrHhldeTRZ3xwo4TLBMkIDaRn2OpT7m/YuhjhG+R
 XGtLKP+rAYVQiiYn/reZitmB/yJfTdP5fj6vMJUJFpaR5pumcjBEOGsubcXG0r84wqo5Vjy
 oPlP0Md5i33LzD8vXTAQWgxCYETGOKt/+y1WK7gZy58SMqd960JFgp3qz3CXZlZ4EMlJ59A
 5yJ1p/dha+zR44g0r7y6Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NJVNCE6D9/4=:bQGwHELXkragiXw7Rw7/m4
 cHgkoRcooelGES7hld6EZ6U3fPNI4aQcn2SzNGd1oxjRjSBfC42rcMDeSqjLJi03n9AVA/pXH
 QHlMuSwVgihQOffzuDk9O5VPAq5Qfas81/sgr7ZOZNtf1R/cjPX0dk0F2yCWzFbU8rTEBY27C
 ShF/6dAHu7qwO7BoBwm24P/B8U2olEHn8+iuaMLTd8utDAy0dk0mdsza8yVFoqODzpALUTBtg
 oPPJGBik0a9OjAb0DA8YEW6NmX1EQCUr/5pVQjH/HTSQ4Z0R8NFmelbccjIPAwWpCm6NoGk+Q
 8DqCRptOiP7sk+WvgIs7nIbEh8IQBN+u9HGIhLoKMUn6ej1QlOSaauLdRCfuVwOHpS3XuM1yy
 k7jdRuRC++5kMpIbjnLic9McD2VL+BB8q0CJqKBa9tetAZcnsO2cRrcqML/187XpJaIsuPj+E
 jbrPVbjqKOjvRCkme/fMeAq+SCUK5q17S+Smc35ARQ1UK++KS5vWD98uhH3sQL57lLM5D8J5c
 ZlXey4O0CH1rEt5ujM5dbf+Y1cBFHxfxDDqTVb1bRnVf6ftgbh2w4WT8+gwXeONDdieFsDhdt
 jnry3ZefwYP/WCamKpQ5MGN7ycwY8j09z7bBQK8xjMQORv0LJTo01vCyTStmHqhQ/DUmIV1Xb
 /MG8pQ0LzLbNVFWedHIXfivsczUsdG32euwZ5/z+bIPT+XZ35hQSc9TWJuupODk5qK778jkB+
 NLOEjcM9133PGsomXQTIgpgnDo8xv0c0lWj1V5ecvMH2/9wj2YmLVPGhL1ptIuWnJwk5WKg04
 D/sgim9q7VMsNDuoaAjMA+iTJM+tzsUmNuDIioG5BY6EmhPHiKdm9TxLSA+uSxQUKBooQ0aQP
 fybl0M2Y7nN//7Hhcm4A==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 22, 2019 at 5:53 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The background of my question was me wondering if builds
> for PLAT_S3C24XX=y (before your patch series) don't need plat-samsung.

What I found is that the DT-based platforms (exynos and s5p) need almost nothing
from plat-samsung, while the board files and the s3c24xx/s3c64xx power
management
needs almost all of it.

      Arnd
