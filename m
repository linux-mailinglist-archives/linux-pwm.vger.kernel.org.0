Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA38A249B25
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Aug 2020 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHSKuu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Aug 2020 06:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgHSKum (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Aug 2020 06:50:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE46C061345
        for <linux-pwm@vger.kernel.org>; Wed, 19 Aug 2020 03:50:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so21047446wrh.3
        for <linux-pwm@vger.kernel.org>; Wed, 19 Aug 2020 03:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4RmXTztNi9GECVJ0aExOfbDAQwAs/L9NUvmPr5zTDmQ=;
        b=ERogb2s4FfcGN+xlF7eyTokoRdK3yXUkX5DCmxcs6ryf2cnndWX8BXtWptZQGoegaG
         h2xyVy0cL20IGeE7Cewi+jv2xtYQwOD/NsxENYOaSSe7I/GzWmSLn/Sj8sx9oYcclOJy
         ufVFHG5/68JQLEcpPPGaoHC/g5m33RFk5eTtCnmNL7F71equk8cU4pEi27jCme1qd92Y
         XXUt7mBjyq7yNNxCbiQUVRGH9IYdJTsEK9/yJN4092pCX6c46GIQ1luYsJUKlHkJ/6pz
         BdyK/zwxkymS2DbgmINneTd8rPFgyjniVsUz3QJEl9oPmrsjn1PXqqnCIso8yEfBMW7K
         0r+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4RmXTztNi9GECVJ0aExOfbDAQwAs/L9NUvmPr5zTDmQ=;
        b=TpuWo93ODd48Sp5d8416vY1Cvifw8vXtF7fXb9sXl6HEeDwwiW05iLuRVEQ46aGYSy
         iPKFBktTnPZkklVIDlVHi42E77EIJ1J+SUSXsfHrRFfcAwHh6OOeHLsyzBeGgDT57EbS
         ap4avfo6lE42Dsry116Vm9m+jJ1JzRRnNl7cjd/bJTN5UllooCCPtXIgX80vARdWbOsJ
         hxJMLKXTCe2EvVoG68OseHZB/913eHDo5nDNIU8XYO6hJQ3MUoSlxeEV65b9sliUD7ky
         IFOrQB7HxBFdn0mBfCHqoo5335rHS8OU+6UJ4f0NXUCV5Us+o51fHIlVvPwmBCKXZMyA
         xRCA==
X-Gm-Message-State: AOAM530+H6qGw2IzAWKWD0PBNfZhjegk5HinwrS0bmzPUlYNrTQ+JtWe
        2cBUNR546B+YcuvgYPTo1AcmaA==
X-Google-Smtp-Source: ABdhPJza8zEikaAPOOg7a9HyT7lA1V+4By8Z2PwqI0jCPWrX/9vBtS3FYNySJ64ShjNUv4gCE8rU5A==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr24140484wrx.310.1597834239664;
        Wed, 19 Aug 2020 03:50:39 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id i7sm41641170wrs.25.2020.08.19.03.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 03:50:39 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:50:29 +0100
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
Subject: Re: [PATCH v8 01/13] mfd: add simple regmap based I2C driver
Message-ID: <20200819105029.GH4354@dell>
References: <20200813124832.17349-1-michael@walle.cc>
 <20200813124832.17349-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200813124832.17349-2-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 13 Aug 2020, Michael Walle wrote:

> There are I2C devices which contain several different functions but
> doesn't require any special access functions. For these kind of drivers
> an I2C regmap should be enough.
> 
> Create an I2C driver which creates an I2C regmap and enumerates its
> children. If a device wants to use this as its MFD core driver, it has
> to add an individual compatible string. It may provide its own regmap
> configuration.
> 
> Subdevices can use dev_get_regmap() on the parent to get their regmap
> instance.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v7:
>  - none
> 
> Changes since v6:
>  - added SIMPLE_MFD_I2C help text
>  - revised description in module header
> 
> Changes since v5:
>  - removed "select MFD_CORE" in Kconfig
>  - removed help text in Kconfig, we assume that the users of this
>    driver will have a "select MFD_SIMPLE_MFD_I2C". Instead added
>    a small description to the driver itself.
>  - removed "struct simple_mfd_i2c_config" and use regmap_config
>    directly
>  - changed builtin_i2c_driver() to module_i2c_driver(), added
>    MODULE_ boilerplate
>  - cleaned up the included files
> 
> Changes since v4:
>  - new patch. Lee, please bear with me. I didn't want to delay the
>    new version (where a lot of remarks on the other patches were
>    addressed) even more, just because we haven't figured out how
>    to deal with the MFD part. So for now, I've included this one.
> 
>  drivers/mfd/Kconfig          | 12 ++++++++
>  drivers/mfd/Makefile         |  1 +
>  drivers/mfd/simple-mfd-i2c.c | 56 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 drivers/mfd/simple-mfd-i2c.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 33df0837ab41..6e1a38944d28 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1162,6 +1162,18 @@ config MFD_SI476X_CORE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called si476x-core.
>  
> +config MFD_SIMPLE_MFD_I2C
> +	tristate
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  This driver creates a single register map with the intention for it
> +	  to be shared by all sub-devices.
> +
> +	  Once the register map has been successfully initialised, any
> +	  sub-devices represented by child nodes in Device Tree will be
> +	  subsequently registered.
> +
>  config MFD_SM501
>  	tristate "Silicon Motion SM501"
>  	depends on HAS_DMA
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index a60e5f835283..78d24a3e7c9e 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -264,3 +264,4 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> +obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> new file mode 100644
> index 000000000000..09b40ebfdf07
> --- /dev/null
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Simple MFD - I2C
> + *
> + * This driver creates a single register map with the intention for it to be
> + * shared by all sub-devices.  Children can use their parent's device structure
> + * (dev.parent) in order reference it.

Nit: "in order *to* reference it"

Once fixed, please add my:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
