Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95922303EA
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 09:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgG1HT4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgG1HTz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 03:19:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91748C0619D5
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 00:19:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so13640958wrm.12
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=A6d3Z8kZUGC925O1zWNYM0bo3uk23MCvzFLEsbquiGg=;
        b=JXEuNNcHl2rzr+ED0k+nl9svIqEnZlG4uG4Ljc30XUWAj7SnsAlzcGFXU0TA0qySQp
         2hN8vHtrdyO41dqHRHbNgoPQzccQFeCCY6lxquSVVAhovTXq6dPgHYkQUkx8svw4D+R0
         S4BMdFPVl/rUzIVO23T1URDRTzQGmFn9sx0zrNCH204f4ED8wjuqjvMVBZi6Ppsks+19
         hQ7s7EkaKV6A5zuNCyrLunYI0x5kEFw4WpSbXhjth3EzCbft0KrRwaTWixEGNYRb6VuB
         tNNZE8QWXi5j313UCjrpXPViIvmQh52nbvxLtzHyVIeCG53hZNdFNx7NVcKvUdxb0ZLk
         0Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A6d3Z8kZUGC925O1zWNYM0bo3uk23MCvzFLEsbquiGg=;
        b=bywDg50/nD2n6MxLtqbe51Yv1OUV/ePYjcTFH0ujXFKv+daBUJ5lgDQI8C8dpZwlrT
         OWxZtYbVxTo5YsZ4TuHpironmv9qdJMKNqYG/29XYaT98Ut5sSMPvRgJd7hzN+SM2x3H
         +dswUI47lrfsJZESJJsfVQs4BPIr/E/eS5i5fotM9qfh3LlE8OFy+gW/TWJLVwAIOO/a
         FaPvhmnoV6zCyQplfC8LrYCjvf79hCiRu9wh4jVUXQHDYM5vuOiZZXdY+M5ywhwvDyGj
         tcPW6K1PaO/oElbOLFxiBA6E8jbRH7ETDTOwDFEmZaqJeKBNsNHFblRd9qMYGKLnC3hT
         30bQ==
X-Gm-Message-State: AOAM531QT+pKSutc+6BgL6UWYAVg+7+4vNW1/e3EgH47FzljS4+N5KsP
        5ILLrGznsvNP/1XphOuszU16Og==
X-Google-Smtp-Source: ABdhPJz+8EDiCF+tZuc+BFokpxg7sLtYNmRW3CW3BfMrYAARno5y9fdOlWpYou7Mu+g++TZQFZ/NPw==
X-Received: by 2002:adf:f289:: with SMTP id k9mr24097714wro.203.1595920792029;
        Tue, 28 Jul 2020 00:19:52 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j11sm15809923wrq.69.2020.07.28.00.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 00:19:51 -0700 (PDT)
Date:   Tue, 28 Jul 2020 08:19:49 +0100
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
Message-ID: <20200728071949.GE1850026@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200725231834.25642-2-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 26 Jul 2020, Michael Walle wrote:

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
> Changes since v5:
>  - removed "select MFD_CORE" in Kconfig
>  - removed help text in Kconfig, we assume that the users of this

That's the opposite of what I asked for.

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
>  drivers/mfd/Kconfig          |  5 ++++
>  drivers/mfd/Makefile         |  1 +
>  drivers/mfd/simple-mfd-i2c.c | 55 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>  create mode 100644 drivers/mfd/simple-mfd-i2c.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 33df0837ab41..c08539c7a166 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1162,6 +1162,11 @@ config MFD_SI476X_CORE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called si476x-core.
>  
> +config MFD_SIMPLE_MFD_I2C
> +	tristate
> +	depends on I2C
> +	select REGMAP_I2C

Please provide a full help.

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
> index 000000000000..45090ddad104
> --- /dev/null
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * A very simple I2C MFD driver

Simple MFD - I2C

> + * The driver enumerates its children and registers a common regmap. Use
> + * dev_get_regmap(pdev->dev.parent, NULL) in the child nodes to fetch that
> + * regmap instance.

This driver creates a single register map with the intention for it to
be shared by all sub-devices.  Children can use their parent's device
structure (dev.parent) in order reference it. 

> + * In the future this driver might be extended to support also other interfaces
> + * like SPI etc.

Remove this please.

> + */

'\n' here.

> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +
> +static const struct regmap_config simple_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int simple_mfd_i2c_probe(struct i2c_client *i2c)
> +{
> +	const struct regmap_config *config;
> +	struct regmap *regmap;
> +
> +	config = device_get_match_data(&i2c->dev);
> +	if (!config)
> +		config = &simple_regmap_config;
> +
> +	regmap = devm_regmap_init_i2c(i2c, config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return devm_of_platform_populate(&i2c->dev);
> +}
> +
> +static const struct of_device_id simple_mfd_i2c_of_match[] = {
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> +
> +static struct i2c_driver simple_mfd_i2c_driver = {
> +	.probe_new = simple_mfd_i2c_probe,
> +	.driver = {
> +		.name = "simple-mfd-i2c",
> +		.of_match_table = simple_mfd_i2c_of_match,
> +	},
> +};
> +module_i2c_driver(simple_mfd_i2c_driver);
> +
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_DESCRIPTION("Simple I2C MFD driver");

Simple MFD - I2C driver

> +MODULE_LICENSE("GPL v2");

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
