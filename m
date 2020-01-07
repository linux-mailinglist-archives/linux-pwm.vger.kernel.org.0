Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949FC132150
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2020 09:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgAGIZo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 7 Jan 2020 03:25:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45904 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGIZo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jan 2020 03:25:44 -0500
Received: by mail-ed1-f65.google.com with SMTP id v28so49605459edw.12;
        Tue, 07 Jan 2020 00:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vT2NN+xI4BcelZZCoGioMbTizcdEYSLI6ni70MbnF8c=;
        b=ZIzmmVIlTS9WEt4rJoZ85Xf5fPjZdF87B7kV/hX4D5K94C2l1i8pRYdmDQzKgH7hGW
         m38GA6s9JAoGladP/P9jdGwMONnnyq7+yU4xXepGDlhEYpGeN7iF2/3W2NPx0H8zvbJU
         KYrAsYwZX39weuXU1ce+5S/+sW+pbf01jXgQZxu6TL6EbjdZ1GL9HHR2A/U+nZRx8q3R
         mdK0ZXg2Tf98/4t++O3/H//zIxfjvmY+dcQHO33IqX4zBlAL0L9efj9NEiCfn0Npn1Z+
         x8UiciWKC6g1JVNVMK1Dn6gHh2YyHNJbo71IJx8yvzmDbHPv9uvoYymcG80oEVj4gEK0
         ZDXA==
X-Gm-Message-State: APjAAAWlf4w5AE74+Q6KniXGe27MJ2zFo//05Wf5Hju5EBkOxFqLjMyR
        xpNyUkNwdqCSWQWYc3WlnlE=
X-Google-Smtp-Source: APXvYqwRuI+Pu22h1HAS8nBuWY+NEdeOj5ioRnCb8N42vbhDOOIZ7fM0eRKg8UY44R4kju5amCGT3w==
X-Received: by 2002:a05:6402:221c:: with SMTP id cq28mr63552685edb.110.1578385542439;
        Tue, 07 Jan 2020 00:25:42 -0800 (PST)
Received: from pi3 ([194.230.155.149])
        by smtp.googlemail.com with ESMTPSA id ba29sm7398179edb.47.2020.01.07.00.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 00:25:41 -0800 (PST)
Date:   Tue, 7 Jan 2020 09:25:39 +0100
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
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: Enable compile testing for some of drivers
Message-ID: <20200107082539.GA31827@pi3>
References: <20191230172113.17222-1-krzk@kernel.org>
 <20191230172113.17222-2-krzk@kernel.org>
 <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200107072645.ko247bwhh3ibdu73@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 07, 2020 at 08:26:45AM +0100, Uwe Kleine-König wrote:
> Hello Krzysztof,
> 
> On Mon, Dec 30, 2019 at 06:21:13PM +0100, Krzysztof Kozlowski wrote:
> > Some of the PWM drivers can be compile tested to increase build
> > coverage.
> > 
> > The Meson PWM driver requires COMMON_CLK dependency.
> 
> I'm surprised that there are not more that need this. Is HAVE_CLK not
> enough?

Nope. E.g. for alpha architecture, HAVE_CLK is not set and without
COMMON_CLK:

drivers/pwm/pwm-meson.o: In function `meson_pwm_init_channels':
(.text+0x244): undefined reference to `devm_clk_register'

I guess other solution would be to add stubs for few clk functions...

> Also HAS_IOMEM is a typical requirement, but I tested with an ARCH=um
> config (which does't have HAS_IOMEM) and they all compile fine.

Because of !HAS_IOMEM, since some time ARCH=um does not support
COMPILE_TEST. Therefore HAS_IOMEM dependency is not needed for compile
testing (and for regular build it is selected by ARCH).

> 
> > @@ -318,7 +319,7 @@ config PWM_MEDIATEK
> >  
> >  config PWM_MXS
> >  	tristate "Freescale MXS PWM support"
> > -	depends on ARCH_MXS && OF
> > +	depends on (ARCH_MXS && OF) || COMPILE_TEST
> >  	select STMP_DEVICE
> >  	help
> >  	  Generic PWM framework driver for Freescale MXS.
> > @@ -328,7 +329,8 @@ config PWM_MXS
> >  
> >  config PWM_OMAP_DMTIMER
> >  	tristate "OMAP Dual-Mode Timer PWM support"
> > -	depends on OF && ARCH_OMAP && OMAP_DM_TIMER
> > +	depends on (ARCH_OMAP && OMAP_DM_TIMER) || COMPILE_TEST
> > +	depends on OF
> 
> I'm surprised that OF isn't required for PWM_MXS but is is for
> PWM_OMAP_DMTIMER. pwm-mxs compiles without CONFIG_OF, didn't test
> pwm-omap-dmtimer.

Since some time !OF has all necessary stubs so OF is actually needed
only for binding, not compiling.

Best regards,
Krzysztof

