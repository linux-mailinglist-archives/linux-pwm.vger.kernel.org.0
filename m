Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1932CBDD2
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 14:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgLBNHA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 08:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbgLBNHA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 08:07:00 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BAC0617A6
        for <linux-pwm@vger.kernel.org>; Wed,  2 Dec 2020 05:06:13 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c198so7036745wmd.0
        for <linux-pwm@vger.kernel.org>; Wed, 02 Dec 2020 05:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7bzhGlEDs3RVzaSNxmlfokQcY9/nLGPy3zIRO283eDU=;
        b=hoUlgFcojtGx5MWR+uH0MtOMHiRv4HBtzmnVHFXTJOTubmJGqCwD+erZkS0kUu9Ww+
         HPzUPepiFQ4rB6N8rM4XqGYA/zGW/SHTvumDI6Cl9fZl6JP6NmFZTPhL4ioeOKpcQzhd
         ymo8qOrFVkO1qG1joUwaT3f+D4Xzz7PjqfshDvctduRl4zUeDFSG2UCB8zDwksUMnbkP
         g5Z73nZjsc1qRqzFS5YvP92HlUpx2kC51PYaLy3dcMtdgAb47sm84n3LXCzgZaUP+J82
         wX86L/38M1NIwYOllJXJddHMFgn6uQXDxixe4J8weDtJNzegT4PRQgQVnHB7j88TGjsW
         nN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7bzhGlEDs3RVzaSNxmlfokQcY9/nLGPy3zIRO283eDU=;
        b=L0hGOJ7gJUUNwPl+d5AymDK+YvT6BvLJWy+ZeZq9Un9ntDPXe5Gk0ZDNX7+7HqTgG0
         YMPpiJdrLwv15qJg1VZVFE8IHQh3J20QKbR1x74xqQhUJxqXGHv5s7EX3citP7GfvsnB
         /UvPbx/ruljko9A47g1fNpaPaXhi7j8I9iC4hDOiphXG/9vxsc2LFOVir78RApGw4jU4
         ibySEyNOocoQ0x12XNAWz/QYAnAbLDtwklbiWs4MDNq3zqGBOfl+yBuPo/oDM6l/OMKg
         HBaOZ/gv0eQjcXQtmm3BAu0g9LqMLu61UV6+HhzdGs/whWnH1GWXdZWkOQX3L/pyCNu+
         Uphg==
X-Gm-Message-State: AOAM5314obbFKUgtFUNpGQVqVg1zowTJ5SW0HdPoguRMQ2xfDxHPnKj/
        cDV6ap8EEKcK3PturxjEbby5eA==
X-Google-Smtp-Source: ABdhPJxGawSFJDcD4PpSw5SstbEcGDeQR9jU6qHm7uM9dlQbOvte5ZrJEXWIXJfUg22zIA3A0lGfmw==
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr3096055wmi.146.1606914372431;
        Wed, 02 Dec 2020 05:06:12 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id 35sm1986863wro.71.2020.12.02.05.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 05:06:11 -0800 (PST)
Date:   Wed, 2 Dec 2020 13:06:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 3/7] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20201202130609.GM4801@dell>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-4-j.neuschaefer@gmx.net>
 <20201202130520.GL4801@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201202130520.GL4801@dell>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 02 Dec 2020, Lee Jones wrote:

> On Sun, 22 Nov 2020, Jonathan Neuschäfer wrote:
> 
> > The Netronix embedded controller is a microcontroller found in some
> > e-book readers designed by the original design manufacturer Netronix,
> > Inc. It contains RTC, battery monitoring, system power management, and
> > PWM functionality.
> > 
> > This driver implements register access and version detection.
> > 
> > Third-party hardware documentation is available at:
> > 
> >   https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-controller
> > 
> > The EC supports interrupts, but the driver doesn't make use of them so
> > far.
> > 
> > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> > ---
> > 
> > v4:
> > - include asm/unaligned.h after linux/*
> > - Use put_unaligned_be16 instead of open-coded big-endian packing
> > - Clarify that 0x90=0xff00 causes an error in downstream kernel too
> > - Add commas after non-sentinel positions
> > - ntxec.h: declare structs device and regmap
> > - Replace WARN_ON usage and add comments to explain errors
> > - Replace dev_alert with dev_warn when the result isn't handled
> > - Change subdevice registration error message to dev_err
> > - Declare ntxec_reg8 as returning __be16
> > - Restructure version detection code
> > - Spell out ODM
> > 
> > v3:
> > - https://lore.kernel.org/lkml/20200924192455.2484005-4-j.neuschaefer@gmx.net/
> > - Add (EC) to CONFIG_MFD_NTXEC prompt
> > - Relicense as GPLv2 or later
> > - Add email address to copyright line
> > - remove empty lines in ntxec_poweroff and ntxec_restart functions
> > - Split long lines
> > - Remove 'Install ... handler' comments
> > - Make naming of struct i2c_client parameter consistent
> > - Remove struct ntxec_info
> > - Rework 'depends on' lines in Kconfig, hard-depend on I2C, select REGMAP_I2C and
> >   MFD_CORE
> > - Register subdevices via mfd_cells
> > - Move 8-bit register conversion to ntxec.h
> > 
> > v2:
> > - https://lore.kernel.org/lkml/20200905133230.1014581-4-j.neuschaefer@gmx.net/
> > - Add a description of the device to the patch text
> > - Unify spelling as 'Netronix embedded controller'.
> >   'Netronix' is the proper name of the manufacturer, but 'embedded controller'
> >   is just a label that I have assigned to the device.
> > - Switch to regmap, avoid regmap use in poweroff and reboot handlers.
> >   Inspired by cf84dc0bb40f4 ("mfd: rn5t618: Make restart handler atomic safe")
> > - Use a list of known-working firmware versions instead of checking for a
> >   known-incompatible version
> > - Prefix registers with NTXEC_REG_
> > - Define register values as constants
> > - Various style cleanups as suggested by Lee Jones
> > - Don't align = signs in struct initializers [Uwe Kleine-König]
> > - Don't use dev_dbg for an error message
> > - Explain sleep in poweroff handler
> > - Remove (struct ntxec).client
> > - Switch to .probe_new in i2c driver
> > - Add .remove callback
> > - Make CONFIG_MFD_NTXEC a tristate option
> > ---
> >  drivers/mfd/Kconfig       |  11 ++
> >  drivers/mfd/Makefile      |   1 +
> >  drivers/mfd/ntxec.c       | 216 ++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/ntxec.h |  34 ++++++
> >  4 files changed, 262 insertions(+)
> >  create mode 100644 drivers/mfd/ntxec.c
> >  create mode 100644 include/linux/mfd/ntxec.h

[...]

> > +	/* Bail out if we encounter an unknown firmware version */
> > +	switch (version) {
> > +	case 0xd726: /* found in Kobo Aura */
> 
> No magic numbers.
> 
> Please submit a subsequent patch to define this.
> 
> > +		break;
> > +	default:
> > +		dev_err(ec->dev,
> > +			"Netronix embedded controller version %04x is not supported.\n",
> > +			version);
> > +		return -ENODEV;
> > +	}
> 
> Applied, thanks.

Sorry, that should have been:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
