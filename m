Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C96189477
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 04:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCRD3B (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 23:29:01 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34229 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCRD3A (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 23:29:00 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so610454pje.1;
        Tue, 17 Mar 2020 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GiXuvKb0HLa/6CPxbR7nTzAdgqyD7OsjsZ7DuW4XA4A=;
        b=Fw2YEZ0ohw2GP1aEtEpH0aF0uBLcA33Iu5Sk5RUO8icmWfheQKdS+pSHpWabKusCbK
         2rhUDSv4/DshmB8aFE/Ccjk1nIxJDlUKNGpc4ba5QhF7732S2QECukEVxPe5eGFf16Eu
         HOK1PToDFa54fQohyW2TozdJqBpjxI1C1LnRLkF6h3GlEZV1krlrEtPT+w6gB0PxqSui
         D9gBllp+xGXvoAbtDIB+iO6bvXuN1jtZONHd6fsrynd4aREIUzNhNVIivQv5fansoZih
         jwYFERHrd6z45ffrxDw1CCxWZ3BqRkJQQa/ZYJKUJ2ZQD+xnkEZ6ZDFB3Za1PvrkjHrz
         vnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GiXuvKb0HLa/6CPxbR7nTzAdgqyD7OsjsZ7DuW4XA4A=;
        b=iOj1mD+5ngykjNkTzF3wBXi4qxqI6ehscgnQ/OpNwDlLnYtHvQsjyr05Rz2ljpwnXP
         SLEh1DDVjXVaONqaFK1xcsWudGXa6wzW2pi/ncfwyIrWTCe/0gao8M1TYK14N+tBGvp6
         o7PLhzoC6NO7gwFkWZhB7s/dAP72U9rXvwvTXJYdxTIPWV8QRUwL99AbamLvH7XslzmZ
         w94sJMkUtdr2hLa7Ca0O1wJK8BtKxARozRBo+Vhfn1rDIEjk0GU5M6iTOXu7WjQfpks5
         Y/g2fQPePtWAzlQjXB6Sdj00r/Op/QQArWEF27VaE+cgHHR1QwGa/QXNVEfhnMibrJ/8
         wPPg==
X-Gm-Message-State: ANhLgQ2WLZQKv/Ag/shFOD9RcWgoLf/8532f4kCdEel10CePBMYCgFjf
        RWFGGY8AVf2d/wKQYEXWdKg=
X-Google-Smtp-Source: ADFU+vvnxuas9L2UuJtC23tNT/S1LM+25rtOQXfHSKBgPSpPRGH3KahUe8pqpzaO/7/qTif3avIlUA==
X-Received: by 2002:a17:90a:bd86:: with SMTP id z6mr2455805pjr.15.1584502138444;
        Tue, 17 Mar 2020 20:28:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j38sm3883958pgi.51.2020.03.17.20.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 20:28:57 -0700 (PDT)
Subject: Re: [PATCH 05/18] mfd: Add support for Kontron sl28cpld management
 controller
To:     Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-6-michael@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <1ea0ae38-c91d-810b-1474-71f17b66fbd0@roeck-us.net>
Date:   Tue, 17 Mar 2020 20:28:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317205017.28280-6-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 3/17/20 1:50 PM, Michael Walle wrote:
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
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mfd/Kconfig    |  21 ++++++
>  drivers/mfd/Makefile   |   2 +
>  drivers/mfd/sl28cpld.c | 155 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+)
>  create mode 100644 drivers/mfd/sl28cpld.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3c547ed575e6..01588c366476 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2059,5 +2059,26 @@ config SGI_MFD_IOC3
>  	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
>  	  then say Y. Otherwise say N.
>  
> +config MFD_SL28CPLD
> +	tristate "Kontron sl28 core driver"
> +	depends on I2C=y

Why I2C=y and not just I2C ?

> +	depends on OF
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	select SL28CPLD_IRQ
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
> index 000000000000..789f21f90752
> --- /dev/null
> +++ b/drivers/mfd/sl28cpld.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MFD core for the CPLD on a SMARC-sAL28 board.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +
> +#define SL28CPLD_VERSION 0x03
> +#define SL28CPLD_WATCHDOG_BASE 0x4
> +#define SL28CPLD_HWMON_FAN_BASE 0xb
> +#define SL28CPLD_PWM0_BASE 0xc
> +#define SL28CPLD_PWM1_BASE 0xe
> +#define SL28CPLD_GPIO0_BASE 0x10
> +#define SL28CPLD_GPIO1_BASE 0x15
> +#define SL28CPLD_GPO_BASE 0x1a
> +#define SL28CPLD_GPI_BASE 0x1b
> +#define SL28CPLD_INTC_BASE 0x1c
> +
> +/* all subdevices share the same IRQ */
> +#define SL28CPLD_IRQ 0
> +
> +#define SL28CPLD_MIN_REQ_VERSION 14
> +
> +struct sl28cpld {
> +	struct device *dev;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_config sl28cpld_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.reg_stride = 1,
> +};
> +
> +static struct resource sl28cpld_watchdog_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_WATCHDOG_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_hwmon_fan_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_HWMON_FAN_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_pwm0_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_PWM0_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_pwm1_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_PWM1_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_gpio0_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_GPIO0_BASE, 1),
> +	DEFINE_RES_IRQ(SL28CPLD_IRQ),
> +};
> +
> +static struct resource sl28cpld_gpio1_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_GPIO1_BASE, 1),
> +	DEFINE_RES_IRQ(SL28CPLD_IRQ),
> +};
> +
> +static struct resource sl28cpld_gpo_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_GPO_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_gpi_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_GPI_BASE, 1),
> +};
> +
> +static struct resource sl28cpld_intc_resources[] = {
> +	DEFINE_RES_REG(SL28CPLD_INTC_BASE, 1),
> +	DEFINE_RES_IRQ(SL28CPLD_IRQ),
> +};
> +
> +static const struct mfd_cell sl28cpld_devs[] = {
> +	OF_MFD_CELL("sl28cpld-wdt", sl28cpld_watchdog_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-wdt"),
> +	OF_MFD_CELL("sl28cpld-fan", sl28cpld_hwmon_fan_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-fan"),
> +	OF_MFD_CELL("sl28cpld-pwm", sl28cpld_pwm0_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-pwm"),
> +	OF_MFD_CELL("sl28cpld-pwm", sl28cpld_pwm1_resources, NULL, 0, 1,
> +		    "kontron,sl28cpld-pwm"),
> +	OF_MFD_CELL("sl28cpld-gpio", sl28cpld_gpio0_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-gpio"),
> +	OF_MFD_CELL("sl28cpld-gpio", sl28cpld_gpio1_resources, NULL, 0, 1,
> +		    "kontron,sl28cpld-gpio"),
> +	OF_MFD_CELL("sl28cpld-gpo", sl28cpld_gpo_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-gpo"),
> +	OF_MFD_CELL("sl28cpld-gpi", sl28cpld_gpi_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-gpi"),
> +	OF_MFD_CELL("sl28cpld-intc", sl28cpld_intc_resources, NULL, 0, 0,
> +		    "kontron,sl28cpld-intc"),
> +};
> +
> +static int sl28cpld_probe(struct i2c_client *i2c)
> +{
> +	struct sl28cpld *sl28cpld;
> +	struct device *dev = &i2c->dev;
> +	unsigned int cpld_version;
> +	int ret;
> +
> +	sl28cpld = devm_kzalloc(dev, sizeof(*sl28cpld), GFP_KERNEL);
> +	if (!sl28cpld)
> +		return -ENOMEM;
> +
> +	sl28cpld->regmap = devm_regmap_init_i2c(i2c, &sl28cpld_regmap_config);
> +	if (IS_ERR(sl28cpld->regmap))
> +		return PTR_ERR(sl28cpld->regmap);
> +
> +	ret = regmap_read(sl28cpld->regmap, SL28CPLD_VERSION, &cpld_version);
> +	if (ret)
> +		return ret;
> +
> +	if (cpld_version < SL28CPLD_MIN_REQ_VERSION) {
> +		dev_err(dev, "unsupported CPLD version %d\n", cpld_version);
> +		return -ENODEV;
> +	}
> +
> +	sl28cpld->dev = dev;
> +	i2c_set_clientdata(i2c, sl28cpld);
> +
> +	dev_info(dev, "successfully probed. CPLD version %d\n", cpld_version);
> +
> +	return devm_mfd_add_devices(dev, -1, sl28cpld_devs,
> +				    ARRAY_SIZE(sl28cpld_devs), NULL,
> +				    i2c->irq, NULL);
> +}
> +
> +static const struct of_device_id sl28cpld_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_of_match);
> +
> +static struct i2c_driver sl28cpld_driver = {
> +	.probe_new = sl28cpld_probe,
> +	.driver = {
> +		.name = "sl28cpld",
> +		.of_match_table = of_match_ptr(sl28cpld_of_match),
> +	},
> +};
> +module_i2c_driver(sl28cpld_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld MFD Core Driver");
> +MODULE_LICENSE("GPL");
> 

