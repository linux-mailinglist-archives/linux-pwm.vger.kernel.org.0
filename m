Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2901CE73C
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2020 23:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgEKVOF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 May 2020 17:14:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44808 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgEKVOE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 May 2020 17:14:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id j4so8770821otr.11;
        Mon, 11 May 2020 14:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HdAuOfdZA600kVwfN3f7G2AtZ+Xb7Hh7BuebX0KzsAE=;
        b=jQf22+dyNr+Np4elOVlxvcJ7OHHtfxN+m9Gjh4+5+tHMHj2nineMh+6XuSMC2nYYDW
         fsYjpzLIiwY+F96Lx39xSVYl6Y+VViv/trHBP+f3jyZRogmuu/DhgOmA7Vop7X3xkwZ/
         yZWBFzh4AdpAqOhLBIXlvDrIqRZGZWnjXewITi5jvN4/Fa+fX+9JmYRMqXCVs5q5yECf
         D9DBNq3bJd+vVRG0sXlzI8zCrxGrlkEu8p0Hn76y3VBsLVHBjnGBioHPog+7P8RUZccP
         VSohNJn/g8syyCzkRlXu9XzLqvb8ZSyTSZ0uztmE0D9c9GIoPaBzLP6t9bHvRqh16Em9
         t+RQ==
X-Gm-Message-State: AGi0PuYSGSjNmYzhA/gUeysOVxR338WMATEr/I0rJBzpcrZhXoBCBNMK
        N4DZFFVoO2QjoQdInwIMTw==
X-Google-Smtp-Source: APiQypKIP9UgQDUWZjuB+VBbVoiTW/wp1xETY9x89lhBnQtgOkr+ezeDT4hcpLFrxd2JxPUQjERcxQ==
X-Received: by 2002:a05:6830:1449:: with SMTP id w9mr10291024otp.230.1589231641881;
        Mon, 11 May 2020 14:14:01 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 61sm2946252otp.13.2020.05.11.14.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:14:01 -0700 (PDT)
Received: (nullmailer pid 21700 invoked by uid 1000);
        Mon, 11 May 2020 21:13:59 -0000
Date:   Mon, 11 May 2020 16:13:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 05/16] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200511211359.GB3518@bogus>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-6-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423174543.17161-6-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 23, 2020 at 07:45:32PM +0200, Michael Walle wrote:
> This patch adds core support for the board management controller found
> on the SMARC-sAL28 board. It consists of the following functions:
>  - watchdog
>  - GPIO controller
>  - PWM controller
>  - fan sensor
>  - interrupt controller
> 
> At the moment, this controller is used on the Kontron SMARC-sAL28 board.
> 
> Please note that the MFD driver is defined as bool in the Kconfig
> because the next patch will add interrupt support.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mfd/Kconfig    |  19 +++++
>  drivers/mfd/Makefile   |   2 +
>  drivers/mfd/sl28cpld.c | 153 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 174 insertions(+)
>  create mode 100644 drivers/mfd/sl28cpld.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0a59249198d3..be0c8d93c526 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2060,5 +2060,24 @@ config SGI_MFD_IOC3
>  	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
>  	  then say Y. Otherwise say N.
>  
> +config MFD_SL28CPLD
> +	bool "Kontron sl28 core driver"
> +	depends on I2C=y
> +	depends on OF
> +	select REGMAP_I2C
> +	select MFD_CORE
> +	help
> +	  This option enables support for the board management controller
> +	  found on the Kontron sl28 CPLD. You have to select individual
> +	  functions, such as watchdog, GPIO, etc, under the corresponding menus
> +	  in order to enable them.
> +
> +	  Currently supported boards are:
> +
> +		Kontron SMARC-sAL28
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sl28cpld.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f935d10cbf0f..9bc38863b9c7 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -259,3 +259,5 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
>  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> +
> +obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
> diff --git a/drivers/mfd/sl28cpld.c b/drivers/mfd/sl28cpld.c
> new file mode 100644
> index 000000000000..1e5860cc7ffc
> --- /dev/null
> +++ b/drivers/mfd/sl28cpld.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MFD core for the sl28cpld.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +
> +#define SL28CPLD_VERSION	0x03
> +#define SL28CPLD_WATCHDOG_BASE	0x04
> +#define SL28CPLD_HWMON_FAN_BASE	0x0b
> +#define SL28CPLD_PWM0_BASE	0x0c
> +#define SL28CPLD_PWM1_BASE	0x0e
> +#define SL28CPLD_GPIO0_BASE	0x10
> +#define SL28CPLD_GPIO1_BASE	0x15
> +#define SL28CPLD_GPO_BASE	0x1a
> +#define SL28CPLD_GPI_BASE	0x1b
> +#define SL28CPLD_INTC_BASE	0x1c

If you want to use 'reg' in the binding, these are the numbers you 
should be using rather than making up numbering!

However, I still don't think you need any child nodes. All the data in 
the DT binding is right here in the driver already. There's no advantage 
to putting child nodes in DT, because this driver still has to be 
updated if you add more nodes.

Rob
