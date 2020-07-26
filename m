Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD59122DDA8
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jul 2020 11:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGZJTB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 05:19:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:33213 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgGZJTB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Jul 2020 05:19:01 -0400
IronPort-SDR: Iv2VaoVkLV6UjxmMvI+Uy2P/GBNd1pdhGa1f+AqVFkxY/R7sDvYU1xTgnCS/9hiub7icRPdW6A
 CHS7CKaWNrRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="150868924"
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="150868924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 02:18:52 -0700
IronPort-SDR: Z4TYiw1c1o2TkE6KU2miscl1K06z4FRIEze0ktepLtTtHycAhZLVflE5nFRzH/2p5eIocc0wqI
 rQOKnub5oSlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="327727628"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2020 02:18:47 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jzcnt-0045sX-QV; Sun, 26 Jul 2020 12:18:45 +0300
Date:   Sun, 26 Jul 2020 12:18:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 08/13] hwmon: add support for the sl28cpld hardware
 monitoring controller
Message-ID: <20200726091845.GL3703480@smile.fi.intel.com>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-9-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725231834.25642-9-michael@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jul 26, 2020 at 01:18:29AM +0200, Michael Walle wrote:
> Add support for the hardware monitoring controller of the sl28cpld board
> management controller. This driver is part of a multi-function device.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Michael Walle <michael@walle.cc>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Changes since v5:
>  - none
> 
> Changes since v4:
>  - update copyright year
>  - remove #include <linux/of_device.h>, suggested by Andy.
>  - use PTR_ERR_OR_ZERO(), suggested by Andy.
>  - remove the platform device table
>  - don't use KBUID_MODNAME
> 
> Changes since v3:
>  - see cover letter
> 
>  Documentation/hwmon/index.rst    |   1 +
>  Documentation/hwmon/sl28cpld.rst |  36 ++++++++
>  drivers/hwmon/Kconfig            |  10 +++
>  drivers/hwmon/Makefile           |   1 +
>  drivers/hwmon/sl28cpld-hwmon.c   | 142 +++++++++++++++++++++++++++++++
>  5 files changed, 190 insertions(+)
>  create mode 100644 Documentation/hwmon/sl28cpld.rst
>  create mode 100644 drivers/hwmon/sl28cpld-hwmon.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 750d3a975d82..d90c43c82936 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -154,6 +154,7 @@ Hardware Monitoring Kernel Drivers
>     sht3x
>     shtc1
>     sis5595
> +   sl28cpld
>     smm665
>     smsc47b397
>     smsc47m192
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
> index 8dc28b26916e..a02829ec7386 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1479,6 +1479,16 @@ config SENSORS_RASPBERRYPI_HWMON
>  	  This driver can also be built as a module. If so, the module
>  	  will be called raspberrypi-hwmon.
>  
> +config SENSORS_SL28CPLD
> +	tristate "Kontron sl28cpld hardware monitoring driver"
> +	select MFD_SIMPLE_MFD_I2C
> +	help
> +	  If you say yes here you get support for the fan supervisor of the
> +	  sl28cpld board management controller.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called sl28cpld-hwmon.
> +
>  config SENSORS_SHT15
>  	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
>  	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index a8f4b35b136b..dee8511f9348 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -159,6 +159,7 @@ obj-$(CONFIG_SENSORS_S3C)	+= s3c-hwmon.o
>  obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>  obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
>  obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
> +obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>  obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>  obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
>  obj-$(CONFIG_SENSORS_SHT3x)	+= sht3x.o
> diff --git a/drivers/hwmon/sl28cpld-hwmon.c b/drivers/hwmon/sl28cpld-hwmon.c
> new file mode 100644
> index 000000000000..e48f58ec5b9c
> --- /dev/null
> +++ b/drivers/hwmon/sl28cpld-hwmon.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sl28cpld hardware monitoring driver
> + *
> + * Copyright 2020 Kontron Europe GmbH
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
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
> +	struct sl28cpld_hwmon *hwmon;
> +	struct device *hwmon_dev;
> +	int ret;
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
> +	ret = device_property_read_u32(&pdev->dev, "reg", &hwmon->offset);
> +	if (ret)
> +		return -EINVAL;
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +				"sl28cpld_hwmon", hwmon,
> +				&sl28cpld_hwmon_chip_info, NULL);
> +	if (IS_ERR(hwmon_dev))
> +		dev_err(&pdev->dev, "failed to register as hwmon device");
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id sl28cpld_hwmon_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld-fan" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_hwmon_of_match);
> +
> +static struct platform_driver sl28cpld_hwmon_driver = {
> +	.probe = sl28cpld_hwmon_probe,
> +	.driver = {
> +		.name = "sl28cpld-fan",
> +		.of_match_table = sl28cpld_hwmon_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_hwmon_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld Hardware Monitoring Driver");
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


