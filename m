Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A671323F5
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2020 11:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgAGKmr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jan 2020 05:42:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33925 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKmr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2020 05:42:47 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iomJn-0005TW-KM; Tue, 07 Jan 2020 11:42:35 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iomJm-0004iE-4c; Tue, 07 Jan 2020 11:42:34 +0100
Date:   Tue, 7 Jan 2020 11:42:34 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, kernel@pengutronix.de,
        Richard Weinberger <richard@nod.at>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
Message-ID: <20200107104234.wq74fska3szrg4ii@pengutronix.de>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
 <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
 <20200107082539.GA31827@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107082539.GA31827@pi3>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Krzysztof,

On Tue, Jan 07, 2020 at 09:25:39AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Jan 07, 2020 at 08:26:45AM +0100, Uwe Kleine-König wrote:
> > On Mon, Dec 30, 2019 at 06:21:13PM +0100, Krzysztof Kozlowski wrote:
> > > Some of the PWM drivers can be compile tested to increase build
> > > coverage.
> > > 
> > > The Meson PWM driver requires COMMON_CLK dependency.
> > 
> > I'm surprised that there are not more that need this. Is HAVE_CLK not
> > enough?
> 
> Nope. E.g. for alpha architecture, HAVE_CLK is not set and without
> COMMON_CLK:
> 
> drivers/pwm/pwm-meson.o: In function `meson_pwm_init_channels':
> (.text+0x244): undefined reference to `devm_clk_register'

I see. devm_clk_register() only exists in include/linux/clk-provider.h.

> I guess other solution would be to add stubs for few clk functions...
> 
> > Also HAS_IOMEM is a typical requirement, but I tested with an ARCH=um
> > config (which does't have HAS_IOMEM) and they all compile fine.
> 
> Because of !HAS_IOMEM, since some time ARCH=um does not support
> COMPILE_TEST. Therefore HAS_IOMEM dependency is not needed for compile
> testing (and for regular build it is selected by ARCH).

Hehe, I didn't notice because for testing I just dropped the "depends on
..." lines in Kconfig instead of adding "|| COMPILE_TEST" :-) Still they
compile fine on UML.

Ah, since bc083a64b6c0 ("init/Kconfig: make COMPILE_TEST depend on
!UML") == v4.8-rc1~52^2~83 COMPILE_TEST cannot be enabled on UML, but
later 1bcbfbfdeb00 ("um: add dummy ioremap and iounmap functions")
== v4.13-rc1~8^2~6 UM got a dummy implementation. So maybe we could
revert bc083a64b6c0 today? (And if not, a comment about why near the
"depends on !UML" in init/Kconfig would be great.)

Orthogonal to that, I wonder if depending on HAS_IOMEM is right even
though the compile testers won't notice it missing. Or should HAS_IOMEM
be dropped?

> > > @@ -318,7 +319,7 @@ config PWM_MEDIATEK
> > >  
> > >  config PWM_MXS
> > >  	tristate "Freescale MXS PWM support"
> > > -	depends on ARCH_MXS && OF
> > > +	depends on (ARCH_MXS && OF) || COMPILE_TEST
> > >  	select STMP_DEVICE
> > >  	help
> > >  	  Generic PWM framework driver for Freescale MXS.
> > > @@ -328,7 +329,8 @@ config PWM_MXS
> > >  
> > >  config PWM_OMAP_DMTIMER
> > >  	tristate "OMAP Dual-Mode Timer PWM support"
> > > -	depends on OF && ARCH_OMAP && OMAP_DM_TIMER
> > > +	depends on (ARCH_OMAP && OMAP_DM_TIMER) || COMPILE_TEST
> > > +	depends on OF
> > 
> > I'm surprised that OF isn't required for PWM_MXS but is is for
> > PWM_OMAP_DMTIMER. pwm-mxs compiles without CONFIG_OF, didn't test
> > pwm-omap-dmtimer.
> 
> Since some time !OF has all necessary stubs so OF is actually needed
> only for binding, not compiling.

That doesn't explain why you handle PWM_MXS and PWM_OMAP_DMTIMER
differently though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
