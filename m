Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE3E07FD
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbfJVPxx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Oct 2019 11:53:53 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58365 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388789AbfJVPxx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 11:53:53 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMwT7-0006Ja-Jx; Tue, 22 Oct 2019 17:53:09 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMwT5-0002EX-5J; Tue, 22 Oct 2019 17:53:07 +0200
Date:   Tue, 22 Oct 2019 17:53:07 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
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
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
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
Message-ID: <20191022155307.izh4ryorm7thw7tq@pengutronix.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de>
 <20191011055149.4dudr4tk2znpt65u@pengutronix.de>
 <CAK8P3a1st8gR7u+8-oyP6HrzZdmrzhq7PRonYuz0a5O8rfKaSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1st8gR7u+8-oyP6HrzZdmrzhq7PRonYuz0a5O8rfKaSA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Tue, Oct 22, 2019 at 04:01:12PM +0200, Arnd Bergmann wrote:
> > > @@ -235,7 +235,6 @@ machine-$(CONFIG_PLAT_SPEAR)              += spear
> > >  # by CONFIG_* macro name.
> > >  plat-$(CONFIG_ARCH_OMAP)     += omap
> > >  plat-$(CONFIG_ARCH_S3C64XX)  += samsung
> > > -plat-$(CONFIG_ARCH_S5PV210)  += samsung
> >
> > Would it make more sense to make this
> >
> >         plat-$(PLAT_SAMSUNG) += samsung
> >
> > (in a separate patch)? Hmm, it seems there is no plat-y for
> > PLAT_S3C24XX=y builds. Is this intended? If yes, the directory name
> > containing "samsung" suggests something that seems untrue.
> 
> By the end of the series, the plat-samsung directory is completely
> removed (folded into mach-s3c), so that would only add more
> churn for the same result I think.

fine for me. The background of my question was me wondering if builds
for PLAT_S3C24XX=y (before your patch series) don't need plat-samsung.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
