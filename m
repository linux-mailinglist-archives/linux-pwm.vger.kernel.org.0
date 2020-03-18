Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D982518946A
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 04:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCRD1V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 23:27:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40591 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCRD1V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 23:27:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so10541700plk.7;
        Tue, 17 Mar 2020 20:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=famkI3hno7KZXTrvwWBMRYQiftA+3wDNqSrv5TQiosw=;
        b=s3W2023EwlwkIVfaLfOMBUbgRUoZ2LXssBduY20TQ/8bdm2TE4Sa7Mzhzu8McZutwl
         Bs/uVKNqIKYsWLJLy/kAK9AqX89YcLCaY4/ATFhDoPJrulsTeT3RPMSHeAlSeVlcWDeK
         V1UDYnR1yeu7JURcTab0aQWYc1Xu4CDVWrycnVoT6bJ5TCQu4dQsnRSgxoYowJe5Mq7g
         zJ8Ir/cNqFoeHAuG50nCfV4X5RbkBdVWgzEfbqK0S9NQgdq6o072CFLRh6wfowzCesUW
         eB8YBhs13bgZy0Tlf+HyWHhSKVll3j/EuTPW534XiuTzE0XDFbvu2fxeVccn12Fkiz5w
         8oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=famkI3hno7KZXTrvwWBMRYQiftA+3wDNqSrv5TQiosw=;
        b=q5t4tbO12sfqIbyV8B+B70IW92SyHGJTDvOH6SlOQZt4b82gjW5sZlmOTAFuInR39H
         VP+L3u8aHpTiEEgWWQXcinLqa6Sh4GFKQii0VOfeMvjJqarC+QtLL3EMIFgO3WJCc5tF
         sEA4VF97AKPgdv2TnFsQRwqUCP7HiwTdn99d91f4vdEhhYG2H9p3wi77nieB5jrA9VOW
         3sA06GHJd8zi0Q2nDpsWuOKhSr4B1O9SQ93j7y89iRRwNtq+1cEG2N2hWmvu+cPUuiIJ
         /qlYhjcoKxt5wgbn9jERkBL//JAibBytUdWknENDPX+JQWibtjoHkAiG5Px9vBrEth4H
         r3YQ==
X-Gm-Message-State: ANhLgQ1O17Lzl8HW7BwTZ/7mR+U5CslcFbcdN5p0J04ovUUBTrbJPC+h
        0x5W5xGkmXCpg+5veWYYIPs=
X-Google-Smtp-Source: ADFU+vv9pl7AVgQk4Gtwa9o4zMFtd2PO2UWEXO/u0Kmva3biTu9yXhSQHkfKWgER7jXQyVIf6QURXw==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr2399221pjb.79.1584502039376;
        Tue, 17 Mar 2020 20:27:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j19sm4417468pfe.102.2020.03.17.20.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 20:27:18 -0700 (PDT)
Subject: Re: [PATCH 14/18] hwmon: add support for the sl28cpld hardware
 monitoring controller
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
 <20200317205017.28280-15-michael@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <11700297-affd-8bdc-2414-3dc7f2b62798@roeck-us.net>
Date:   Tue, 17 Mar 2020 20:27:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317205017.28280-15-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 3/17/20 1:50 PM, Michael Walle wrote:
> This adds support for the hardware monitoring controller of the sl28cpld
> board management controller. This driver is part of a multi-function
> device.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/hwmon/Kconfig          |  10 +++
>  drivers/hwmon/Makefile         |   1 +
>  drivers/hwmon/sl28cpld-hwmon.c | 146 +++++++++++++++++++++++++++++++++

Please also provide Documentation/hwmon/sl28cpld.

>  3 files changed, 157 insertions(+)
>  create mode 100644 drivers/hwmon/sl28cpld-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 05a30832c6ba..c98716f78cfa 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1412,6 +1412,16 @@ config SENSORS_RASPBERRYPI_HWMON
>  	  This driver can also be built as a module. If so, the module
>  	  will be called raspberrypi-hwmon.
>  
> +config SENSORS_SL28CPLD
> +	tristate "Kontron's SMARC-sAL28 hardware monitoring driver"
> +	depends on MFD_SL28CPLD
> +	help
> +	  If you say yes here you get support for a fan connected to the
> +	  input of the SMARC connector of Kontron's SMARC-sAL28 module.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sl28cpld-hwmon.
> +
>  config SENSORS_SHT15
>  	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
>  	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b0b9c8e57176..dfb0f8cda2dd 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -155,6 +155,7 @@ obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
>  obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>  obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
>  obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
> +obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>  obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>  obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
>  obj-$(CONFIG_SENSORS_SHT3x)	+= sht3x.o
> diff --git a/drivers/hwmon/sl28cpld-hwmon.c b/drivers/hwmon/sl28cpld-hwmon.c
> new file mode 100644
> index 000000000000..7ac42bb0a48c
> --- /dev/null
> +++ b/drivers/hwmon/sl28cpld-hwmon.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SMARC-sAL28 fan hardware monitoring driver.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/bitfield.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +#include <linux/hwmon.h>
> +
Alphabetic order of include files, please.

> +#define FAN_INPUT		0
> +#define   FAN_SCALE_X8		BIT(7)
> +#define   FAN_VALUE_MASK	GENMASK(6, 0)
> +
> +struct sl28cpld_hwmon {
> +	struct regmap *regmap;
> +	u32 offset;
> +};
> +
> +static umode_t sl28cpld_hwmon_is_visible(const void *data,
> +					 enum hwmon_sensor_types type,
> +					 u32 attr, int channel)
> +{
> +	return 0444;
> +}
> +
> +static int sl28cpld_hwmon_read(struct device *dev,
> +			       enum hwmon_sensor_types type, u32 attr,
> +			       int channel, long *input)
> +{
> +	struct sl28cpld_hwmon *hwmon = dev_get_drvdata(dev);
> +	unsigned int value;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		ret = regmap_read(hwmon->regmap, hwmon->offset + FAN_INPUT,
> +				  &value);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * The register has a 7 bit value and 1 bit which indicates the
> +		 * scale. If the MSB is set, then the lower 7 bit has to be
> +		 * multiplied by 8, to get the correct reading.
> +		 */
> +		if (value & FAN_SCALE_X8)
> +			value = FIELD_GET(FAN_VALUE_MASK, value) << 3;
> +
> +		/*
> +		 * The counter period is 1000ms and the sysfs specification
> +		 * says we should asssume 2 pulses per revolution.
> +		 */
> +		value *= 60 / 2;
> +
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	*input = value;
> +	return 0;
> +}
> +
> +static const u32 sl28cpld_hwmon_fan_config[] = {
> +	HWMON_F_INPUT,
> +	0
> +};
> +
> +static const struct hwmon_channel_info sl28cpld_hwmon_fan = {
> +	.type = hwmon_fan,
> +	.config = sl28cpld_hwmon_fan_config,
> +};
> +
> +static const struct hwmon_channel_info *sl28cpld_hwmon_info[] = {
> +	&sl28cpld_hwmon_fan,
> +	NULL
> +};
> +
> +static const struct hwmon_ops sl28cpld_hwmon_ops = {
> +	.is_visible = sl28cpld_hwmon_is_visible,
> +	.read = sl28cpld_hwmon_read,
> +};
> +
> +static const struct hwmon_chip_info sl28cpld_hwmon_chip_info = {
> +	.ops = &sl28cpld_hwmon_ops,
> +	.info = sl28cpld_hwmon_info,
> +};
> +
> +static int sl28cpld_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct device *hwmon_dev;
> +	struct sl28cpld_hwmon *hwmon;
> +	struct resource *res;
> +
> +	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
Maybe do this first ?

> +	hwmon->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!hwmon->regmap)
> +		return -ENODEV;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> +	if (!res)
> +		return -EINVAL;
> +	hwmon->offset = res->start;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +							 "sl28cpld_hwmon",
> +							 hwmon,
> +							 &sl28cpld_hwmon_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev)) {
> +		dev_err(&pdev->dev, "failed to register as hwmon device");
> +		return PTR_ERR(hwmon_dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id sl28cpld_hwmon_id_table[] = {
> +	{"sl28cpld-fan", 0},
> +};
> +MODULE_DEVICE_TABLE(platform, sl28cpld_hwmon_id_table);
> +
> +static struct platform_driver sl28cpld_hwmon_driver = {
> +	.probe = sl28cpld_hwmon_probe,
> +	.id_table = sl28cpld_hwmon_id_table,

I'd have expected an of_match_table.

> +	.driver = {
> +		.name = "sl28cpld-hwmon",
> +	},
> +};
> +module_platform_driver(sl28cpld_hwmon_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld Hardware Monitoring Driver");
> +MODULE_LICENSE("GPL");
> 

