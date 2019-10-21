Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D596ADF1B6
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfJUPia (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 11:38:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34413 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUPia (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 11:38:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id k20so8053962pgi.1;
        Mon, 21 Oct 2019 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mneNdGWjVVKo8B+zdhy64uwhIH/0K1XV0srlpATT8LE=;
        b=ZrhVxJGchkE7C02M03rRvYxTu5UfWNWNiYKO98tOD87iwgjKPh2sJQxjXwOv6xrU5o
         c1Zor46UCsdpSO0zZaCsvEiyJd7FOxe9Fc6Du0WqA0//pwqahy8pi5bkFJiG2pp4bo64
         NTjUYHrDV52gBtEvJX+uZNNP6tzYF1jsY8PsWRihZFJeFO5GBV7kQaCK+t/ESx/4neki
         9tcDxjvtglasVbZf5TxieKULnwExW07dk3U+GlTV62vW3hJJOM8sgWD9oETdHT1+OqB2
         ynf8LuQKk6OXgfsEc/9iTtqdedZMkT2oY+t4Xqz2Qwl18z9erJZOYS41q7t/fhlifnpf
         dbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mneNdGWjVVKo8B+zdhy64uwhIH/0K1XV0srlpATT8LE=;
        b=jvIBUHMU7usAosGB9RuadscjGQake9sJIrm3Ywhk50DDlvJNrJRAAgKjzqXFzQFe0N
         LJzKVV1o6Vg4QAgVziFtL+TqVqTBkhWEBX28hNexSDVvnw0JzrdFjGwCN5qNRtPIbw51
         GnskEkc8iQHEDn2Qq/+VehO+qiDmRpmFLbWMEL7T6vlmP+k289XSH8iPsuTzVt0m1KNK
         Oi6AmqGsSjzTCMFR1/xM8hENkUi+bRuBp/5b3/DY41kDnhAVdFBCwP5tRRW+sI/2H6to
         pB/NXbvb8TJ87ZeZCKsb+6m1amnFSFuIdHd2hSyjwBSXy96DwUg2wKAmvX/YrXIIYLV7
         yZ8w==
X-Gm-Message-State: APjAAAVQMaJ3EOZ8D0Z5JXWCeBgZhR1Y8eS6+YQxTAFCZ/CgNlJu4yZQ
        l/rB9Vnynp77EZ2Xt9L/w14=
X-Google-Smtp-Source: APXvYqwVzWa+4lrH4hhsxVRP4M887b9OhSnZeuc0KxOfOfDMeGuLfw9V56cNc8S0MamFn3aK50BZfg==
X-Received: by 2002:a63:77cc:: with SMTP id s195mr13982330pgc.293.1571672308362;
        Mon, 21 Oct 2019 08:38:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j11sm5954568pgk.3.2019.10.21.08.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 08:38:27 -0700 (PDT)
Date:   Mon, 21 Oct 2019 08:38:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 4/8] hwmon: Add support for Azoteq IQS620AT temperature
 sensor
Message-ID: <20191021153825.GA15359@roeck-us.net>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-5-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571631083-4962-5-git-send-email-jeff@labundy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Oct 20, 2019 at 11:11:19PM -0500, Jeff LaBundy wrote:
> This patch adds support for the Azoteq IQS620AT temperature sensor,
> capable of reporting its absolute die temperature.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>

Seems to me this might be more feasible as iio driver.
Jonathan, what do you think ?

> ---
>  drivers/hwmon/Kconfig         | 12 +++++-
>  drivers/hwmon/Makefile        |  1 +
>  drivers/hwmon/iqs620at-temp.c | 96 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hwmon/iqs620at-temp.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 13a6b4a..3e56be6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -385,6 +385,16 @@ config SENSORS_ATXP1
>  	  This driver can also be built as a module. If so, the module
>  	  will be called atxp1.
>  
> +config SENSORS_IQS620AT
> +	tristate "Azoteq IQS620AT temperature sensor"
> +	depends on MFD_IQS62X
> +	help
> +	  Say Y here if you want to build support for the Azoteq IQS620AT
> +	  temperature sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called iqs620at-temp.
> +
>  config SENSORS_DS620
>  	tristate "Dallas Semiconductor DS620"
>  	depends on I2C
> @@ -1593,7 +1603,7 @@ config SENSORS_ADS7871
>  
>  config SENSORS_AMC6821
>  	tristate "Texas Instruments AMC6821"
> -	depends on I2C 
> +	depends on I2C

No unrelated changes, please, and most definitely no
unrelated whitespace changes.

>  	help
>  	  If you say yes here you get support for the Texas Instruments
>  	  AMC6821 hardware monitoring chips.
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 40c036e..2360add 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
>  obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
>  obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
>  obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
> +obj-$(CONFIG_SENSORS_IQS620AT)	+= iqs620at-temp.o
>  obj-$(CONFIG_SENSORS_IT87)	+= it87.o
>  obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
>  obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
> diff --git a/drivers/hwmon/iqs620at-temp.c b/drivers/hwmon/iqs620at-temp.c
> new file mode 100644
> index 0000000..0af49b6
> --- /dev/null
> +++ b/drivers/hwmon/iqs620at-temp.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Azoteq IQS620AT Temperature Sensor
> + *
> + * Copyright (C) 2019
> + * Author: Jeff LaBundy <jeff@labundy.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/iqs62x.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define IQS620_TEMP_UI_OUT			0x1A
> +
> +static umode_t iqs620_temp_is_visible(const void *drvdata,
> +				      enum hwmon_sensor_types type,
> +				      u32 attr, int channel)
> +{
> +	if (type != hwmon_temp || attr != hwmon_temp_input)
> +		return 0;
> +
> +	return 0444;
> +}
> +
> +static int iqs620_temp_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	struct iqs62x_core *iqs62x = dev_get_drvdata(dev);
> +	int error;
> +	__le16 val_buf;
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_input)
> +		return -EINVAL;

			-EOPNOTSUPP
> +
> +	error = regmap_raw_read(iqs62x->map, IQS620_TEMP_UI_OUT, &val_buf,
> +				sizeof(val_buf));
> +	if (error)
> +		return error;
> +
> +	*val = (le16_to_cpu(val_buf) - 100) * 1000;
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops iqs620_temp_ops = {
> +	.is_visible = iqs620_temp_is_visible,
> +	.read = iqs620_temp_read,
> +};
> +
> +static const struct hwmon_channel_info *iqs620_temp_channel_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info iqs620_temp_chip_info = {
> +	.ops = &iqs620_temp_ops,
> +	.info = iqs620_temp_channel_info,
> +};
> +
> +static int iqs620_temp_probe(struct platform_device *pdev)
> +{
> +	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
> +	struct device *hdev;
> +	int error = 0;
> +
> +	hdev = devm_hwmon_device_register_with_info(&pdev->dev,
> +						    iqs62x->dev_desc->dev_name,
> +						    iqs62x,
> +						    &iqs620_temp_chip_info,
> +						    NULL);
> +	if (IS_ERR(hdev)) {
> +		error = PTR_ERR(hdev);
> +		dev_err(&pdev->dev, "Failed to register device: %d\n", error);

Such an error would either be static, caused by bad attributes,
or a bad name, which is already logged, or a memory allocation
failure, which is also already logged. The error message does
therefore not add any value.

> +	}
> +
> +	return error;
> +}
> +
> +static struct platform_driver iqs620_temp_platform_driver = {
> +	.driver = {
> +		.name	= IQS620_DRV_NAME_TEMP,
> +	},
> +	.probe		= iqs620_temp_probe,
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
