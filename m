Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9019CC63
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2020 23:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388635AbgDBVa4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Apr 2020 17:30:56 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36382 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBVa4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Apr 2020 17:30:56 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so2027207pjb.1;
        Thu, 02 Apr 2020 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UUPOa3XdCHYcoLx/8Rv7jexCWtPWMH0y/BtvQy0KvdE=;
        b=Osr4o8aHTJp+wpPLX6iRSAfZZFYcURj2YXurTPtrrGopI9GgL09N58zNW5yiUzQ6lh
         c+VTP115iCVVfBIMcGoSfmdMaiYMYGyRA4Mrf5XFQGewHOz+cwGrgrvhndDpm13smzLA
         Ho2SOHxfzDoCTRD1p+FfemjenJnCXoTL5sqif8IU5iN0NDcRbXRQU7AA5E2nntEuLZBE
         yQrl2SSJ0SoeHVLbyVr8nHiMy6ZhWEDtkPzo09w1aPoHmm88WQ4ZfjIy0kQ04/rf+RsI
         Xate3bhRXxD6BJic2DAyP6KWtyCcT4bqeIGOxivC5zlLSyW7/fRolQGsNwXKb+63i27G
         f3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UUPOa3XdCHYcoLx/8Rv7jexCWtPWMH0y/BtvQy0KvdE=;
        b=rgO9tJ8iMr+MV4YZIk8x0UTgl0RAQVPHZwqjHvTvW0CgVVSNPBb0XK9au50RQ8KO1J
         fwykCuJpK3rxv4AbrZSSEZ3bHzL9dtIgVuIkNzsomToToC/Odgc8kQ7CGZAo3vdMy960
         1i8klBTvSS6cszmjotOGZ1ZSZRuEbsJUjxcKXm1ZC/P5W5S8RnDf1Dz7rb+/OzVpKvMr
         cXmd59cEl3yEWIl0ZHHvQ4lcpjMNvi6XcIosXfnPnxBH7k9ntatr+qLG/+EiBnn/P5zr
         HUpz2d1qcyY/UFAcIhfRsHBnOihmLWar67X7vY6rHPnU1Sn+Ec6BNCHWEEF6XuIKMeIC
         u50A==
X-Gm-Message-State: AGi0PuaDZpK7uJ8sWHiHIujicC7vsh30AQDAdNV78KyTAwEFqnuet5hZ
        DQKAp0lgLTW/RN+Wl3Vy49Q=
X-Google-Smtp-Source: APiQypKypSVnD6UnnrTZinEFkK2Xx8fadJPwB459UiNAc04C+ERmDX3ifauRzwJEo71PQoblfxnGhQ==
X-Received: by 2002:a17:90a:f48c:: with SMTP id bx12mr5896086pjb.64.1585863053480;
        Thu, 02 Apr 2020 14:30:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3sm699454pfd.140.2020.04.02.14.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Apr 2020 14:30:52 -0700 (PDT)
Date:   Thu, 2 Apr 2020 14:30:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
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
Subject: Re: [PATCH v2 12/16] hwmon: add support for the sl28cpld hardware
 monitoring controller
Message-ID: <20200402213051.GA129260@roeck-us.net>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-13-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402203656.27047-13-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 02, 2020 at 10:36:52PM +0200, Michael Walle wrote:
> This adds support for the hardware monitoring controller of the sl28cpld
> board management controller. This driver is part of a multi-function
> device.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  Documentation/hwmon/sl28cpld.rst |  36 ++++++++

Needs to be added to Documentation.hwmon/index.rst.
Otherwise looks good. With that fixed, please feel free to add

Acked-by: Guenter Roeck <linux@roeck-us.net>

in the next version.

Guenter

>  drivers/hwmon/Kconfig            |  10 ++
>  drivers/hwmon/Makefile           |   1 +
>  drivers/hwmon/sl28cpld-hwmon.c   | 151 +++++++++++++++++++++++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 Documentation/hwmon/sl28cpld.rst
>  create mode 100644 drivers/hwmon/sl28cpld-hwmon.c
> 
> diff --git a/Documentation/hwmon/sl28cpld.rst b/Documentation/hwmon/sl28cpld.rst
> new file mode 100644
> index 000000000000..7ed65f78250c
> --- /dev/null
> +++ b/Documentation/hwmon/sl28cpld.rst
> @@ -0,0 +1,36 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver sl28cpld
> +======================
> +
> +Supported chips:
> +
> +   * Kontron sl28cpld
> +
> +     Prefix: 'sl28cpld'
> +
> +     Datasheet: not available
> +
> +Authors: Michael Walle <michael@walle.cc>
> +
> +Description
> +-----------
> +
> +The sl28cpld is a board management controller which also exposes a hardware
> +monitoring controller. At the moment this controller supports a single fan
> +supervisor. In the future there might be other flavours and additional
> +hardware monitoring might be supported.
> +
> +The fan supervisor has a 7 bit counter register and a counter period of 1
> +second. If the 7 bit counter overflows, the supervisor will automatically
> +switch to x8 mode to support a wider input range at the loss of
> +granularity.
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported.
> +
> +======================= ========================================================
> +fan1_input		Fan RPM. Assuming 2 pulses per revolution.
> +======================= ========================================================
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
> index 000000000000..c79bdfed8332
> --- /dev/null
> +++ b/drivers/hwmon/sl28cpld-hwmon.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sl28cpld hardware monitoring driver.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define FAN_INPUT		0x00
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
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	hwmon = devm_kzalloc(&pdev->dev, sizeof(*hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return -ENOMEM;
> +
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
> +				"sl28cpld_hwmon", hwmon,
> +				&sl28cpld_hwmon_chip_info, NULL);
> +	if (IS_ERR(hwmon_dev)) {
> +		dev_err(&pdev->dev, "failed to register as hwmon device");
> +		return PTR_ERR(hwmon_dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sl28cpld_hwmon_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld-fan" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_hwmon_of_match);
> +
> +static const struct platform_device_id sl28cpld_hwmon_id_table[] = {
> +	{ "sl28cpld-fan" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(platform, sl28cpld_hwmon_id_table);
> +
> +static struct platform_driver sl28cpld_hwmon_driver = {
> +	.probe = sl28cpld_hwmon_probe,
> +	.id_table = sl28cpld_hwmon_id_table,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = sl28cpld_hwmon_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_hwmon_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld Hardware Monitoring Driver");
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");
