Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B246DFB9F
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 04:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfJVC0P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 22:26:15 -0400
Received: from p3plsmtpa06-05.prod.phx3.secureserver.net ([173.201.192.106]:54757
        "EHLO p3plsmtpa06-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730494AbfJVC0P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 22:26:15 -0400
Received: from labundy.com ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id MjsBiH1esLAS6MjsDiXjWF; Mon, 21 Oct 2019 19:26:14 -0700
Date:   Mon, 21 Oct 2019 21:26:11 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 4/8] hwmon: Add support for Azoteq IQS620AT temperature
 sensor
Message-ID: <20191022022611.GA2091@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-5-git-send-email-jeff@labundy.com>
 <20191021153825.GA15359@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021153825.GA15359@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfGJXJ7DKDqeffUp2x5+zWn/LaqyoEP3xy95w1Y78+RlMEddsI4mewX72fPuQnAgxR4Z7lgs/aCmFg1BckHEMss2fZ9C1uc8v9dmTBXoDJzclpMYQYbBq
 1jAtutivnffzYKh2uukMvwhcThkY8w5tQnThDTApdEoYkf+lh7pX8tAW4jj7c7UZYv7moIo66HstekJFcR23tTJqgev/YFgCDWTyU5ZC5klfppSWtd/2742j
 0BXveaq3EGWep0RQ+ZUsohAm79Ux2e9rDT2pS5dYngPWCMNXxx+jCg8oabYSSsylay7ioyaa/WHsx4ikTG4mQSu3sqhfP/iDS5lWsHsJxqdGFm8BmYTAJCmR
 EoL58591QT7m2AXMbZz8swPyM/jBZeCjrIvy2rWpbg00FqL1U1a6Nrj/A7/dMbf396gGaNepb99PPz94xifqjSRSKjz0Vo+CUZi8tB4UBJqPgkPYnrZTp13u
 Zm3WM2MGSCc3y53eSupeP4aDGEphBO2z0UPKjLwTXR7WLFJcNy9NpKC+XLfpvoUZTxDmOHXrTwB7x208/23o+AvJQQ9XmBU6sbJKXfkNLiJ1F/MhEl/j+/ib
 C0SZEEf5/7UkbNsUouwLrSt1OiL7aox0rs9qb7FeIfYPKZFL7Oebmy48KAbLgf7zaByVKurK69/v/Nk9RlyAHMe+DeHCN6ohlBNm5fsznilSSctiV777zgFB
 raGopmm02rQ=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Guenter,

Thank you for your prompt review.

On Mon, Oct 21, 2019 at 08:38:25AM -0700, Guenter Roeck wrote:
> On Sun, Oct 20, 2019 at 11:11:19PM -0500, Jeff LaBundy wrote:
> > This patch adds support for the Azoteq IQS620AT temperature sensor,
> > capable of reporting its absolute die temperature.
> > 
> > Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> 
> Seems to me this might be more feasible as iio driver.
> Jonathan, what do you think ?
> 

Interestingly enough, this actually started as an iio driver; however the
"When to Use" slide of [0] made me suspect that conventional devices with
the temperature sensing element integrated on the die belong in hwmon.

I then found the highly similar ad7314, which Jonathan himself appears to
have converted from iio to hwmon. Therefore, I placed this where existing
drivers seemed to match the most, especially since the temperature sensors
in iio generally use IR or a thermocouple.

That being said, I would be happy to move this into iio so long as Jonathan
does not mind, as it would limit the blast radius of this patch series.

> > ---
> >  drivers/hwmon/Kconfig         | 12 +++++-
> >  drivers/hwmon/Makefile        |  1 +
> >  drivers/hwmon/iqs620at-temp.c | 96 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 108 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/hwmon/iqs620at-temp.c
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 13a6b4a..3e56be6 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -385,6 +385,16 @@ config SENSORS_ATXP1
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called atxp1.
> >  
> > +config SENSORS_IQS620AT
> > +	tristate "Azoteq IQS620AT temperature sensor"
> > +	depends on MFD_IQS62X
> > +	help
> > +	  Say Y here if you want to build support for the Azoteq IQS620AT
> > +	  temperature sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called iqs620at-temp.
> > +
> >  config SENSORS_DS620
> >  	tristate "Dallas Semiconductor DS620"
> >  	depends on I2C
> > @@ -1593,7 +1603,7 @@ config SENSORS_ADS7871
> >  
> >  config SENSORS_AMC6821
> >  	tristate "Texas Instruments AMC6821"
> > -	depends on I2C 
> > +	depends on I2C
> 
> No unrelated changes, please, and most definitely no
> unrelated whitespace changes.
> 

Sorry about that; it seems the original file had some trailing whitespace
here and my editor cropped it automatically. Unfortunately I didn't catch
it until after I sent out the series.

> >  	help
> >  	  If you say yes here you get support for the Texas Instruments
> >  	  AMC6821 hardware monitoring chips.
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 40c036e..2360add 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -83,6 +83,7 @@ obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
> >  obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
> >  obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
> >  obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
> > +obj-$(CONFIG_SENSORS_IQS620AT)	+= iqs620at-temp.o
> >  obj-$(CONFIG_SENSORS_IT87)	+= it87.o
> >  obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
> >  obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
> > diff --git a/drivers/hwmon/iqs620at-temp.c b/drivers/hwmon/iqs620at-temp.c
> > new file mode 100644
> > index 0000000..0af49b6
> > --- /dev/null
> > +++ b/drivers/hwmon/iqs620at-temp.c
> > @@ -0,0 +1,96 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS620AT Temperature Sensor
> > + *
> > + * Copyright (C) 2019
> > + * Author: Jeff LaBundy <jeff@labundy.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/iqs62x.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#define IQS620_TEMP_UI_OUT			0x1A
> > +
> > +static umode_t iqs620_temp_is_visible(const void *drvdata,
> > +				      enum hwmon_sensor_types type,
> > +				      u32 attr, int channel)
> > +{
> > +	if (type != hwmon_temp || attr != hwmon_temp_input)
> > +		return 0;
> > +
> > +	return 0444;
> > +}
> > +
> > +static int iqs620_temp_read(struct device *dev, enum hwmon_sensor_types type,
> > +			    u32 attr, int channel, long *val)
> > +{
> > +	struct iqs62x_core *iqs62x = dev_get_drvdata(dev);
> > +	int error;
> > +	__le16 val_buf;
> > +
> > +	if (type != hwmon_temp || attr != hwmon_temp_input)
> > +		return -EINVAL;
> 
> 			-EOPNOTSUPP

Sure thing; will do.

> > +
> > +	error = regmap_raw_read(iqs62x->map, IQS620_TEMP_UI_OUT, &val_buf,
> > +				sizeof(val_buf));
> > +	if (error)
> > +		return error;
> > +
> > +	*val = (le16_to_cpu(val_buf) - 100) * 1000;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_ops iqs620_temp_ops = {
> > +	.is_visible = iqs620_temp_is_visible,
> > +	.read = iqs620_temp_read,
> > +};
> > +
> > +static const struct hwmon_channel_info *iqs620_temp_channel_info[] = {
> > +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_chip_info iqs620_temp_chip_info = {
> > +	.ops = &iqs620_temp_ops,
> > +	.info = iqs620_temp_channel_info,
> > +};
> > +
> > +static int iqs620_temp_probe(struct platform_device *pdev)
> > +{
> > +	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
> > +	struct device *hdev;
> > +	int error = 0;
> > +
> > +	hdev = devm_hwmon_device_register_with_info(&pdev->dev,
> > +						    iqs62x->dev_desc->dev_name,
> > +						    iqs62x,
> > +						    &iqs620_temp_chip_info,
> > +						    NULL);
> > +	if (IS_ERR(hdev)) {
> > +		error = PTR_ERR(hdev);
> > +		dev_err(&pdev->dev, "Failed to register device: %d\n", error);
> 
> Such an error would either be static, caused by bad attributes,
> or a bad name, which is already logged, or a memory allocation
> failure, which is also already logged. The error message does
> therefore not add any value.
> 

Sure thing; I'll remove the error message.

> > +	}
> > +
> > +	return error;
> > +}
> > +
> > +static struct platform_driver iqs620_temp_platform_driver = {
> > +	.driver = {
> > +		.name	= IQS620_DRV_NAME_TEMP,
> > +	},
> > +	.probe		= iqs620_temp_probe,
> > +};
> > +module_platform_driver(iqs620_temp_platform_driver);
> > +
> > +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> > +MODULE_DESCRIPTION("Azoteq IQS620AT Temperature Sensor");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:" IQS620_DRV_NAME_TEMP);
> > -- 
> > 2.7.4
> > 
> 

Kind regards,
Jeff LaBundy

[0]: https://elinux.org/images/b/ba/ELC_2017_-_Industrial_IO_and_You-_Nonsense_Hacks%21.pdf
