Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EC81D0165
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2020 23:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbgELV70 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 May 2020 17:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgELV70 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 12 May 2020 17:59:26 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE0320747;
        Tue, 12 May 2020 21:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589320765;
        bh=4dasN4F5KmkSKWYO6iCX27SovkkmrwOz4v79E3noBoE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YP8cdrrciz6AD9mCNgRNuJ+8S0lvXGBwqGJDrSI3wsmZuR3wa9tIBQq17NCfG4NIB
         VEawFqp/icGBa36IKtrVNQyqEalQcCR4mR6xMppuuWZm7r3wGLAub9CheUDp5AcFtj
         x9b8IX516ah2hZFdoFmwu0PaGIRDtcOuiGZ77vHg=
Received: by mail-ot1-f49.google.com with SMTP id v17so3876397ote.0;
        Tue, 12 May 2020 14:59:24 -0700 (PDT)
X-Gm-Message-State: AGi0PubcxI9B6ddOH7OCrahvVNrApfuUU2Cs+8Q8d2gfarfzZSK5DYDn
        gCmz+NL6+BGEs/Kk2a9ZCoYWIp8Dlkk1xZCT+w==
X-Google-Smtp-Source: APiQypL834c2wGEHb5CE5fdAX3mpa8t0DYv6uZcEwNHKazXdfkA0BR+2q+GjZ5cn3tT0/I4L/tNi+T2+uBKaDwLcHj4=
X-Received: by 2002:a05:6830:4d6:: with SMTP id s22mr18608313otd.129.1589320764152;
 Tue, 12 May 2020 14:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200423174543.17161-1-michael@walle.cc> <20200423174543.17161-6-michael@walle.cc>
 <20200511211359.GB3518@bogus> <f0fafa63047f00e912013b137e4db15c@walle.cc>
In-Reply-To: <f0fafa63047f00e912013b137e4db15c@walle.cc>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 May 2020 16:59:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJBAghgdKmH1OfpH0B508st7Gx3GMtjufjZvBWM_c6GAQ@mail.gmail.com>
Message-ID: <CAL_JsqJBAghgdKmH1OfpH0B508st7Gx3GMtjufjZvBWM_c6GAQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] mfd: Add support for Kontron sl28cpld management controller
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 11, 2020 at 4:45 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-05-11 23:13, schrieb Rob Herring:
> > On Thu, Apr 23, 2020 at 07:45:32PM +0200, Michael Walle wrote:
> >> This patch adds core support for the board management controller found
> >> on the SMARC-sAL28 board. It consists of the following functions:
> >>  - watchdog
> >>  - GPIO controller
> >>  - PWM controller
> >>  - fan sensor
> >>  - interrupt controller
> >>
> >> At the moment, this controller is used on the Kontron SMARC-sAL28
> >> board.
> >>
> >> Please note that the MFD driver is defined as bool in the Kconfig
> >> because the next patch will add interrupt support.
> >>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >> ---
> >>  drivers/mfd/Kconfig    |  19 +++++
> >>  drivers/mfd/Makefile   |   2 +
> >>  drivers/mfd/sl28cpld.c | 153
> >> +++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 174 insertions(+)
> >>  create mode 100644 drivers/mfd/sl28cpld.c
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index 0a59249198d3..be0c8d93c526 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -2060,5 +2060,24 @@ config SGI_MFD_IOC3
> >>        If you have an SGI Origin, Octane, or a PCI IOC3 card,
> >>        then say Y. Otherwise say N.
> >>
> >> +config MFD_SL28CPLD
> >> +    bool "Kontron sl28 core driver"
> >> +    depends on I2C=y
> >> +    depends on OF
> >> +    select REGMAP_I2C
> >> +    select MFD_CORE
> >> +    help
> >> +      This option enables support for the board management controller
> >> +      found on the Kontron sl28 CPLD. You have to select individual
> >> +      functions, such as watchdog, GPIO, etc, under the corresponding
> >> menus
> >> +      in order to enable them.
> >> +
> >> +      Currently supported boards are:
> >> +
> >> +            Kontron SMARC-sAL28
> >> +
> >> +      To compile this driver as a module, choose M here: the module will
> >> be
> >> +      called sl28cpld.
> >> +
> >>  endmenu
> >>  endif
> >> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> >> index f935d10cbf0f..9bc38863b9c7 100644
> >> --- a/drivers/mfd/Makefile
> >> +++ b/drivers/mfd/Makefile
> >> @@ -259,3 +259,5 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)   += rohm-bd718x7.o
> >>  obj-$(CONFIG_MFD_STMFX)     += stmfx.o
> >>
> >>  obj-$(CONFIG_SGI_MFD_IOC3)  += ioc3.o
> >> +
> >> +obj-$(CONFIG_MFD_SL28CPLD)  += sl28cpld.o
> >> diff --git a/drivers/mfd/sl28cpld.c b/drivers/mfd/sl28cpld.c
> >> new file mode 100644
> >> index 000000000000..1e5860cc7ffc
> >> --- /dev/null
> >> +++ b/drivers/mfd/sl28cpld.c
> >> @@ -0,0 +1,153 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * MFD core for the sl28cpld.
> >> + *
> >> + * Copyright 2019 Kontron Europe GmbH
> >> + */
> >> +
> >> +#include <linux/i2c.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/mfd/core.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_platform.h>
> >> +#include <linux/regmap.h>
> >> +
> >> +#define SL28CPLD_VERSION    0x03
> >> +#define SL28CPLD_WATCHDOG_BASE      0x04
> >> +#define SL28CPLD_HWMON_FAN_BASE     0x0b
> >> +#define SL28CPLD_PWM0_BASE  0x0c
> >> +#define SL28CPLD_PWM1_BASE  0x0e
> >> +#define SL28CPLD_GPIO0_BASE 0x10
> >> +#define SL28CPLD_GPIO1_BASE 0x15
> >> +#define SL28CPLD_GPO_BASE   0x1a
> >> +#define SL28CPLD_GPI_BASE   0x1b
> >> +#define SL28CPLD_INTC_BASE  0x1c
> >
> > If you want to use 'reg' in the binding, these are the numbers you
> > should be using rather than making up numbering!
>
> My motivation is that I don't want to hardcode the internal addresses
> of the management controller in the device tree. For example if they
> will move around with a later update of the controller, so a driver can
> be compatible with both the old and the new version. If they are in the
> device tree, only one register layout is possible.

I don't understand, if the addresses change, then the above defines
have to change. So your driver is only compatible with 1 version. If
you change the CPLD, then that's a h/w change and your h/w description
(DT) should change. That can either be the compatible string changing
and updating the driver with new match data such as register offsets
or all the differences are in DT and there's no kernel change.

> > However, I still don't think you need any child nodes. All the data in
> > the DT binding is right here in the driver already. There's no
> > advantage
> > to putting child nodes in DT, because this driver still has to be
> > updated if you add more nodes.
>
> But then any phandle will reference the mfd device. And for example
> there
> are two different interrupt controllers, that is the INTC and the
> GPIO[01],
> which will then be combined into one device tree node, right?

You either have to add a cell for 'bank' or divide the 1st cell into a
bank and index. Both have been done before.

To go the other direction, AIUI you shouldn't need OF_MFD_CELL_REG
entries if you have the child devices in DT. Pick one way or the
other. It's ultimately a judgement call. For a one-off device, sub
devices in DT doesn't really buy you anything. If you have sub-blocks
showing up multiple devices, then sub devices makes sense. If there's
only 2-3 combinations, then it's a toss up.

Rob
