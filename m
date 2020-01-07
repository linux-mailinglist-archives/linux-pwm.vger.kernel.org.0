Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0517813246C
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2020 12:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgAGLEE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 7 Jan 2020 06:04:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45639 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgAGLEE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2020 06:04:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so49948890edw.12;
        Tue, 07 Jan 2020 03:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ptBtaLfSefXKIlF4+ATcVDfD9CqQtKSIYDSRdZx4Dts=;
        b=eVXkihyWBjCuraKu083wbSrBVI9yMv26kq3qNMgx+p0Ci+wCVx9J+zeYmJ84MBirIL
         Juv4yHoaO2UPzphKzbWeXgpxLdOK58FA/TBZLwrI2mxlqYC+h5EOvrzOri01tMEk9JlO
         EBvifdogEquBi9YohbYNuCbMG5gSw6+iJc3P1sU8e5zJGA/PRVHZ2iCy8THl1L7JUlJ5
         ZkHJ3zzAROMyMgYS3vqRcrDSDYKuKOO6VcLeAQEdkdUuqz4DWAL4OFDqol6ZzXSd/YqZ
         JsZC7BS2lJZ8bb0QtAxy55UB2mYSma7jd+gKnjl/fajF0q1F2XtLYE4mPFE3AAR/Lmgd
         o+Ew==
X-Gm-Message-State: APjAAAVw2yqKVwUjuXUkVEymj30KX9c+G/4erhwMG4/qDtUITiwGPR+y
        g08bHUQda60MNSsvSjRd5p8=
X-Google-Smtp-Source: APXvYqzKoAnAzDFoVmt8WsrTLEo61oVGbLtxhYn9w1G9R8M+n/U0qKkIJnksdqHSF0YmF+wOzkLZyQ==
X-Received: by 2002:a17:906:c4d:: with SMTP id t13mr112159727ejf.198.1578395042449;
        Tue, 07 Jan 2020 03:04:02 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id x8sm7492342eds.88.2020.01.07.03.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 03:04:01 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:03:59 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
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
Message-ID: <20200107110359.GA32423@pi3>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
 <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
 <20200107082539.GA31827@pi3>
 <20200107104234.wq74fska3szrg4ii@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200107104234.wq74fska3szrg4ii@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 07, 2020 at 11:42:34AM +0100, Uwe Kleine-König wrote:
> > I guess other solution would be to add stubs for few clk functions...
> > 
> > > Also HAS_IOMEM is a typical requirement, but I tested with an ARCH=um
> > > config (which does't have HAS_IOMEM) and they all compile fine.
> > 
> > Because of !HAS_IOMEM, since some time ARCH=um does not support
> > COMPILE_TEST. Therefore HAS_IOMEM dependency is not needed for compile
> > testing (and for regular build it is selected by ARCH).
> 
> Hehe, I didn't notice because for testing I just dropped the "depends on
> ..." lines in Kconfig instead of adding "|| COMPILE_TEST" :-) Still they
> compile fine on UML.
> 
> Ah, since bc083a64b6c0 ("init/Kconfig: make COMPILE_TEST depend on
> !UML") == v4.8-rc1~52^2~83 COMPILE_TEST cannot be enabled on UML, but
> later 1bcbfbfdeb00 ("um: add dummy ioremap and iounmap functions")
> == v4.13-rc1~8^2~6 UM got a dummy implementation. So maybe we could
> revert bc083a64b6c0 today? (And if not, a comment about why near the
> "depends on !UML" in init/Kconfig would be great.)
> 
> Orthogonal to that, I wonder if depending on HAS_IOMEM is right even
> though the compile testers won't notice it missing. Or should HAS_IOMEM
> be dropped?

I think yes, it can be dropped, but this would require:
1. Fixing any dependencies on HAS_IOMEM, e.g.:
    WARNING: unmet direct dependencies detected for MFD_SYSCON
      Depends on [n]: HAS_IOMEM [=n]
      Selected by [y]:
      - PHY_DA8XX_USB [=y] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y])

2. Checking if all of stubs are implemented (not only IOMEM but maybe
   DMA as well). Also 1bcbfbfdeb00 brought only few stubs. Still we
   need devm_ioremap_resource() and others.

Quick test shows mentioned "unmet direct dependencies" and:
    phy-pxa-usb.c:(.text+0x2f5): undefined reference to `devm_ioremap_resource'
    dma-iommu.c:(.text+0x179): undefined reference to `dma_pgprot'

> 
> > > > @@ -318,7 +319,7 @@ config PWM_MEDIATEK
> > > >  
> > > >  config PWM_MXS
> > > >  	tristate "Freescale MXS PWM support"
> > > > -	depends on ARCH_MXS && OF
> > > > +	depends on (ARCH_MXS && OF) || COMPILE_TEST
> > > >  	select STMP_DEVICE
> > > >  	help
> > > >  	  Generic PWM framework driver for Freescale MXS.
> > > > @@ -328,7 +329,8 @@ config PWM_MXS
> > > >  
> > > >  config PWM_OMAP_DMTIMER
> > > >  	tristate "OMAP Dual-Mode Timer PWM support"
> > > > -	depends on OF && ARCH_OMAP && OMAP_DM_TIMER
> > > > +	depends on (ARCH_OMAP && OMAP_DM_TIMER) || COMPILE_TEST
> > > > +	depends on OF
> > > 
> > > I'm surprised that OF isn't required for PWM_MXS but is is for
> > > PWM_OMAP_DMTIMER. pwm-mxs compiles without CONFIG_OF, didn't test
> > > pwm-omap-dmtimer.
> > 
> > Since some time !OF has all necessary stubs so OF is actually needed
> > only for binding, not compiling.
> 
> That doesn't explain why you handle PWM_MXS and PWM_OMAP_DMTIMER
> differently though.

You're right, I missed this. None of them require OF for building so
separate "depends on OF" makes sense only for readability of this.  Let
me send v2 to make it similar to PWM_MXS.


Best regards,
Krzysztof

