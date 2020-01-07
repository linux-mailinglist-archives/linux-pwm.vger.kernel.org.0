Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF7C13254B
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2020 12:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgAGLyf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 7 Jan 2020 06:54:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44991 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGLye (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2020 06:54:34 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so50083392edb.11;
        Tue, 07 Jan 2020 03:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/Gn0sKgSVl88I9a03JnH76quh+NEJOSZxLuBtN1E4nM=;
        b=hjmrMruxWKayIIiKpd6opxDDDTRSn6ZzPPS0R1eflAMdqPfKJh6hdHokzvSks5n6RN
         2fOx38+VMKrauHVc1pfL8NcwzAFjKR3pA4dOMqZE5IiTCBx1Df1BSsyE5w+28VOBL/uv
         de+TVd71tExYz4GlYIpSYoEHJmdq2FcCMHxIe+45VxW1Yq6Qy+Bp4/UL9ziWIwIDZR1H
         q8lSPJzJ0/fqtLMVX25yc2SU8NU3JXFDHVGb45utfpaUqLnJmtSqfkNUj/j8dzngQzVb
         Z0+fDLz0rZS2tUeBklswCtVSs1v3bdlfSOffLt7PhFq1jmOC1HX7iQ5HmH0tZTAU9Eoz
         p8ZA==
X-Gm-Message-State: APjAAAUv1hNxNGQBG4mBWia4pGMD935zUR4o09RjDXFjDdh4Pjj058aL
        w/egO9pAabpKazrtXbxugpA=
X-Google-Smtp-Source: APXvYqx1yeqLv4KsAcheDnbCECVEgnRO87Tbb4/fx7f3mlExaDwzc4evn6w18FnCcsfNgAflvXHFmw==
X-Received: by 2002:aa7:cf81:: with SMTP id z1mr114422714edx.157.1578398072576;
        Tue, 07 Jan 2020 03:54:32 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id cw15sm7677487edb.44.2020.01.07.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 03:54:31 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:54:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Weinberger <richard@nod.at>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-tegra@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
Message-ID: <20200107115429.GA32632@pi3>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
 <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
 <20200107082539.GA31827@pi3>
 <20200107104234.wq74fska3szrg4ii@pengutronix.de>
 <20200107110359.GA32423@pi3>
 <20200107113354.ggq6zarewq5ip354@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200107113354.ggq6zarewq5ip354@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 07, 2020 at 12:33:54PM +0100, Uwe Kleine-König wrote:
> On Tue, Jan 07, 2020 at 12:03:59PM +0100, Krzysztof Kozlowski wrote:
> > On Tue, Jan 07, 2020 at 11:42:34AM +0100, Uwe Kleine-König wrote:
> > > > I guess other solution would be to add stubs for few clk functions...
> > > > 
> > > > > Also HAS_IOMEM is a typical requirement, but I tested with an ARCH=um
> > > > > config (which does't have HAS_IOMEM) and they all compile fine.
> > > > 
> > > > Because of !HAS_IOMEM, since some time ARCH=um does not support
> > > > COMPILE_TEST. Therefore HAS_IOMEM dependency is not needed for compile
> > > > testing (and for regular build it is selected by ARCH).
> > > 
> > > Hehe, I didn't notice because for testing I just dropped the "depends on
> > > ..." lines in Kconfig instead of adding "|| COMPILE_TEST" :-) Still they
> > > compile fine on UML.
> > > 
> > > Ah, since bc083a64b6c0 ("init/Kconfig: make COMPILE_TEST depend on
> > > !UML") == v4.8-rc1~52^2~83 COMPILE_TEST cannot be enabled on UML, but
> > > later 1bcbfbfdeb00 ("um: add dummy ioremap and iounmap functions")
> > > == v4.13-rc1~8^2~6 UM got a dummy implementation. So maybe we could
> > > revert bc083a64b6c0 today? (And if not, a comment about why near the
> > > "depends on !UML" in init/Kconfig would be great.)
> > > 
> > > Orthogonal to that, I wonder if depending on HAS_IOMEM is right even
> > > though the compile testers won't notice it missing. Or should HAS_IOMEM
> > > be dropped?
> > 
> > I think yes, it can be dropped, but this would require:
> > 1. Fixing any dependencies on HAS_IOMEM, e.g.:
> >     WARNING: unmet direct dependencies detected for MFD_SYSCON
> >       Depends on [n]: HAS_IOMEM [=n]
> >       Selected by [y]:
> >       - PHY_DA8XX_USB [=y] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y])
> 
> I don't understand that warning. What did you modify to trigger that?
> Probably related to the big "if HAS_IOMEM" in drivers/mfd/Kconfig?!

OK, that's actually from my other patch to illustrate the problem:
https://lore.kernel.org/linux-arm-kernel/20200103164710.4829-2-krzk@kernel.org/

After reverting of bc083a64b6c0, every driver that selects MFD_SYSCON
(or some other parts) has to depend on HAS_IOMEM.

> 
> > 2. Checking if all of stubs are implemented (not only IOMEM but maybe
> >    DMA as well). Also 1bcbfbfdeb00 brought only few stubs. Still we
> >    need devm_ioremap_resource() and others.
> 
> A problem is that it's unclear (to me at least) what the presence of
> HAS_IOMEM actually implies. I thought it's about ioremap + readl +
> writel (including their respective variants). Does it really include dma
> stuff, too?
> 
> > Quick test shows mentioned "unmet direct dependencies" and:
> >     phy-pxa-usb.c:(.text+0x2f5): undefined reference to `devm_ioremap_resource'
> >     dma-iommu.c:(.text+0x179): undefined reference to `dma_pgprot'
> 
> dma_pgprot seems to depend on HAS_DMA though, not HAS_IOMEM.
> 
> (Oh, HAS_DMA is defined using "depends on !NO_DMA" + "default y".
> NO_DMA has three different definitions. Two of them (in
> drivers/crypto/ccree/cc_hw_queue_defs.h and arch/arm/include/asm/dma.h)
> unrelated.)

Yes, HAS_DMA is the second missing piece for UM.

Best regards,
Krzysztof

