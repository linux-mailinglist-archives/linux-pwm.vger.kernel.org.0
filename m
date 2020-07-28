Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54D7230509
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 10:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgG1IPM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 04:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgG1IPM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 04:15:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB475C0619D4
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 01:15:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so17353975wrs.11
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HvwG2XGS6BDybxzaDD/+TuGAKBON3irqrqJCB9747RQ=;
        b=xlfx3HvuSB0z5GqSk3Qy6MOhKencPFggfCX8hujwu/RDWI/B7jZFJe06PSK7DC1Ssx
         dEepVkCzLe6s8V+lH6GirW/mRTJKmhk6c2/3CEefSxa1CHXXvTMtYWGTVsITPhwpBdyC
         WJNtfWmkqvyaKoi3YA6pcFiJ07zI7lOAij4CpBfYTMN9v0amx/QgmB2ZMmTx7ka9M8Ul
         XWsw7ELJwLkLs8POxJOA5yZjZHraPZpoR1/5p8Kq+dIS1ikdFR6g4ru3FNnb8WZf9m2m
         9boRgLly3U5/fL5YqILefz1/moUHuZkSfLiE4f8IvsC3wdMHg1ixjCMqK+NfGRm/FPu4
         aoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HvwG2XGS6BDybxzaDD/+TuGAKBON3irqrqJCB9747RQ=;
        b=mHiG21WF06nhdvtZHoMInEHgcPUxqi5BrGokZ+jX6mTcFzwJQh4SdWVJgyDPxhNBe3
         gDwg2nDLYUzzjoXVwazLF+du0twRuajekXYuu/Cm9lnXGu9lRJdb6ZW0cFFC7o7cNl0s
         6nkhgcayA8E8+oqztWG2VZ0vtIIVIoViu15YzkhhX1B6FrsbEYO02RUWUXZxzpy4PSqv
         Jj0yKj/sePo8WgQBMaKdy1JhjqfVZJJ2qKOH8irbwf3ChAsJb5dae80zOQqwuvIVeMvB
         Wc6bVFM9+Ycb2B26RkQdbQvReZ1qjglZhGXGVz2ojOTuEk2vdRQTpKLg9AUdi3D8N0go
         Jy2w==
X-Gm-Message-State: AOAM533sTHy9HIsgZRha2/2zvuwd4gyLUOxGFHh5emRuIzbqNeEn1CaV
        0UL1z+65TnW7KMkKHF0s7HrLOg==
X-Google-Smtp-Source: ABdhPJyEBmzjP5p5bqlnkhXS1LyF2jze2TsaWelEULtD2Qvk55SkGf3FY3CVzhFz57n6yU7y/EsR2A==
X-Received: by 2002:adf:eccc:: with SMTP id s12mr26590888wro.157.1595924108740;
        Tue, 28 Jul 2020 01:15:08 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id p6sm2982576wmg.0.2020.07.28.01.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 01:15:08 -0700 (PDT)
Date:   Tue, 28 Jul 2020 09:15:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 01/13] mfd: add simple regmap based I2C driver
Message-ID: <20200728081506.GA2419169@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-2-michael@walle.cc>
 <20200728071949.GE1850026@dell>
 <23a9ecf5fe4f15b9b20a91cc292aca80@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23a9ecf5fe4f15b9b20a91cc292aca80@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 28 Jul 2020, Michael Walle wrote:

> Am 2020-07-28 09:19, schrieb Lee Jones:
> > On Sun, 26 Jul 2020, Michael Walle wrote:
> > 
> > > There are I2C devices which contain several different functions but
> > > doesn't require any special access functions. For these kind of
> > > drivers
> > > an I2C regmap should be enough.
> > > 
> > > Create an I2C driver which creates an I2C regmap and enumerates its
> > > children. If a device wants to use this as its MFD core driver, it has
> > > to add an individual compatible string. It may provide its own regmap
> > > configuration.
> > > 
> > > Subdevices can use dev_get_regmap() on the parent to get their regmap
> > > instance.
> > > 
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > ---
> > > Changes since v5:
> > >  - removed "select MFD_CORE" in Kconfig
> > >  - removed help text in Kconfig, we assume that the users of this
> > 
> > That's the opposite of what I asked for.
> 
> What is the use to describe the symbol, if it is not user selectable?
> I'm not aware this is done anywhere in the kernel, am I missing
> something?

You mean in menuconfig?

I find 'help's helpful even outside of menuconfig.

Surely I'm not the only one who reads them 'raw'?

> > >    driver will have a "select MFD_SIMPLE_MFD_I2C". Instead added
> > >    a small description to the driver itself.
> > >  - removed "struct simple_mfd_i2c_config" and use regmap_config
> > >    directly
> > >  - changed builtin_i2c_driver() to module_i2c_driver(), added
> > >    MODULE_ boilerplate
> > >  - cleaned up the included files
> > > 
> > > Changes since v4:
> > >  - new patch. Lee, please bear with me. I didn't want to delay the
> > >    new version (where a lot of remarks on the other patches were
> > >    addressed) even more, just because we haven't figured out how
> > >    to deal with the MFD part. So for now, I've included this one.
> > > 
> > >  drivers/mfd/Kconfig          |  5 ++++
> > >  drivers/mfd/Makefile         |  1 +
> > >  drivers/mfd/simple-mfd-i2c.c | 55
> > > ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 61 insertions(+)
> > >  create mode 100644 drivers/mfd/simple-mfd-i2c.c
> > > 
> > > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > > index 33df0837ab41..c08539c7a166 100644
> > > --- a/drivers/mfd/Kconfig
> > > +++ b/drivers/mfd/Kconfig
> > > @@ -1162,6 +1162,11 @@ config MFD_SI476X_CORE
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called si476x-core.
> > > 
> > > +config MFD_SIMPLE_MFD_I2C
> > > +	tristate
> > > +	depends on I2C
> > > +	select REGMAP_I2C
> > 
> > Please provide a full help.
> 
> See above.
> 
> > 
> > >  config MFD_SM501
> > >  	tristate "Silicon Motion SM501"
> > >  	depends on HAS_DMA
> > > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > > index a60e5f835283..78d24a3e7c9e 100644
> > > --- a/drivers/mfd/Makefile
> > > +++ b/drivers/mfd/Makefile
> > > @@ -264,3 +264,4 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> > >  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
> > > 
> > >  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> > > +obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
> > > diff --git a/drivers/mfd/simple-mfd-i2c.c
> > > b/drivers/mfd/simple-mfd-i2c.c
> > > new file mode 100644
> > > index 000000000000..45090ddad104
> > > --- /dev/null
> > > +++ b/drivers/mfd/simple-mfd-i2c.c
> > > @@ -0,0 +1,55 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * A very simple I2C MFD driver
> > 
> > Simple MFD - I2C
> 
> ok.
> 
> > > + * The driver enumerates its children and registers a common
> > > regmap. Use
> > > + * dev_get_regmap(pdev->dev.parent, NULL) in the child nodes to
> > > fetch that
> > > + * regmap instance.
> > 
> > This driver creates a single register map with the intention for it to
> > be shared by all sub-devices.  Children can use their parent's device
> > structure (dev.parent) in order reference it.
> 
> Should this be appended or should it replace my paragraph? If its the
> latter,
> the "enumeration of the children" is missing.

If you want to keep that part, try:

This driver creates a single register map with the intention for it to
be shared by all sub-devices.  Children can use their parent's device
structure (dev.parent) in order reference it.

Once the register map has been successfully initialised, any
sub-devices represented by child nodes in Device Tree will be
subsequently registered.

> > > + * In the future this driver might be extended to support also
> > > other interfaces
> > > + * like SPI etc.
> > 
> > Remove this please.
> 
> Why would you remove information about the intention of this driver? If
> someone
> looks for a place to implement its SPI/I3C/Slimbus MFD driver this might
> come
> in handy.

By all means put something similar in the commit log, but it has no
place in the driver itself.  Besides, if we were to add support for
SPI, it is likely to be a completely separate/unrelated driver.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
