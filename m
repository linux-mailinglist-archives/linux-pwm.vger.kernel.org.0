Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB16211F90A
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Dec 2019 17:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLOQfC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 15 Dec 2019 11:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfLOQfC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 15 Dec 2019 11:35:02 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716D1206C3;
        Sun, 15 Dec 2019 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576427700;
        bh=Qj/LMjimQUlWIIpHUTnD39DZUW7SiK2YRr6BXqJi6do=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bGVuxnYiCa1P1cvk6XuW+mSLDWYnV1wclXRRj6lv7wS6yUxtg4uwu8ec/LuP01nCa
         PF70kSEat7MYJiIh62g5WCI8jMqx92F7noPAWq8ivgwsh8dBw/ar8gA5CQ2Sm9UHQ+
         efRShABgs+OrBsNFTiO8KLKPDoB0vzG/xV6J8IUQ=
Date:   Sun, 15 Dec 2019 16:34:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/7] iio: temperature: Add support for Azoteq
 IQS620AT temperature sensor
Message-ID: <20191215163455.25ff929f@archlinux>
In-Reply-To: <1575851866-18919-6-git-send-email-jeff@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
        <1575851866-18919-6-git-send-email-jeff@labundy.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 9 Dec 2019 00:38:38 +0000
Jeff LaBundy <jeff@labundy.com> wrote:

> This patch adds support for the Azoteq IQS620AT temperature sensor,
> capable of reporting its absolute die temperature.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Moved the driver from hwmon to iio
>   - Merged 'Copyright' and 'Author' lines into one in introductory comments
>   - Replaced 'error' with 'ret' throughout
>   - Eliminated tabbed alignment of platform_driver struct members
>   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> 
>  drivers/iio/temperature/Kconfig         | 10 ++++
>  drivers/iio/temperature/Makefile        |  1 +
>  drivers/iio/temperature/iqs620at-temp.c | 97 +++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 drivers/iio/temperature/iqs620at-temp.c
> 
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index e1ccb40..f1f2a14 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -4,6 +4,16 @@
>  #
>  menu "Temperature sensors"
> 
> +config IQS620AT_TEMP
> +	tristate "Azoteq IQS620AT temperature sensor"
> +	depends on MFD_IQS62X || COMPILE_TEST
> +	help
> +	  Say Y here if you want to build support for the Azoteq IQS620AT
> +	  temperature sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called iqs620at-temp.
> +
>  config LTC2983
>  	tristate "Analog Devices Multi-Sensor Digital Temperature Measurement System"
>  	depends on SPI
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index d6b850b..90c1131 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for industrial I/O temperature drivers
>  #
> 
> +obj-$(CONFIG_IQS620AT_TEMP) += iqs620at-temp.o
>  obj-$(CONFIG_LTC2983) += ltc2983.o
>  obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
>  obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
> diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperature/iqs620at-temp.c
> new file mode 100644
> index 0000000..d20cb6ad
> --- /dev/null
> +++ b/drivers/iio/temperature/iqs620at-temp.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Azoteq IQS620AT Temperature Sensor
> + *
> + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/iqs62x.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define IQS620_TEMP_UI_OUT			0x1A
> +
> +#define IQS620_TEMP_SCALE			1000
> +#define IQS620_TEMP_OFFSET			(-100)
> +
> +static int iqs620_temp_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct iqs62x_core *iqs62x = iio_device_get_drvdata(indio_dev);
> +	int ret;
> +	__le16 val_buf;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_raw_read(iqs62x->map, IQS620_TEMP_UI_OUT, &val_buf,
> +				      sizeof(val_buf));
> +		if (ret)
> +			return ret;
> +
> +		*val = le16_to_cpu(val_buf);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = IQS620_TEMP_SCALE;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = IQS620_TEMP_OFFSET;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info iqs620_temp_info = {
> +	.read_raw = &iqs620_temp_read_raw,
> +};
> +
> +static const struct iio_chan_spec iqs620_temp_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +};
> +
> +static int iqs620_temp_probe(struct platform_device *pdev)
> +{
> +	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, 0);
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	iio_device_set_drvdata(indio_dev, iqs62x);
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->channels = iqs620_temp_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(iqs620_temp_channels);
> +	indio_dev->name = iqs62x->dev_desc->dev_name;
> +	indio_dev->info = &iqs620_temp_info;
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static struct platform_driver iqs620_temp_platform_driver = {
> +	.driver = {
> +		.name = IQS620_DRV_NAME_TEMP,
> +	},
> +	.probe = iqs620_temp_probe,
> +};
> +module_platform_driver(iqs620_temp_platform_driver);
> +
> +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> +MODULE_DESCRIPTION("Azoteq IQS620AT Temperature Sensor");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" IQS620_DRV_NAME_TEMP);
> --
> 2.7.4
> 

