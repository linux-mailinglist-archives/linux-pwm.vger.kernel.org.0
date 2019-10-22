Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A795E0321
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 13:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbfJVLjA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Oct 2019 07:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387871AbfJVLjA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Oct 2019 07:39:00 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E32821872;
        Tue, 22 Oct 2019 11:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571744338;
        bh=DVRQXGi/+LcNMdfe1uvXxUIxjGqQJhmmqWuLFKF4gZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gSl5IXb8ScsTc9HHPMrMPwKV5ZgCOPKQ7veYp3gNVGbQpi7ch8O7XJROO87hnwSRu
         CLLswAhZHtgtyaE2Fp+ZhKEiasC/AHIWtPJHvhBSnRxyqRhsMlV7V4CT6ldr3asbvx
         g7Zpjky6fD6MmgCYllddeYe85b6yLrf363Lea+IA=
Date:   Tue, 22 Oct 2019 12:23:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 6/8] iio: light: Add support for Azoteq IQS621 ambient
 light sensor
Message-ID: <20191022121949.0b6b27d4@archlinux>
In-Reply-To: <1571631083-4962-7-git-send-email-jeff@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
        <1571631083-4962-7-git-send-email-jeff@labundy.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 20 Oct 2019 23:11:21 -0500
Jeff LaBundy <jeff@labundy.com> wrote:

> This patch adds support for the Azoteq IQS621 ambient light sensor,
> capable of reporting intensity directly in units of lux.

If they are in lux, should be using IIO_CHAN_INFO_PROCESSED to indicate
that.  I was wondering why we had no scale then noticed this comment.

Other than that, this looks good to me.  So with that tidied up in V2.
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One trivial comment to perhaps drop an error print as overly verbose inline.

> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
>  drivers/iio/light/Kconfig      |  10 ++
>  drivers/iio/light/Makefile     |   1 +
>  drivers/iio/light/iqs621-als.c | 361 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 372 insertions(+)
>  create mode 100644 drivers/iio/light/iqs621-als.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 4a1a883..aad26dc 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -162,6 +162,16 @@ config GP2AP020A00F
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called gp2ap020a00f.
>  
> +config IQS621_ALS
> +	tristate "Azoteq IQS621 ambient light sensor"
> +	depends on MFD_IQS62X
> +	help
> +	  Say Y here if you want to build support for the Azoteq IQS621
> +	  ambient light sensor.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called iqs621-als.
> +
>  config SENSORS_ISL29018
>  	tristate "Intersil 29018 light and proximity sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 00d1f9b..aa34358 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
>  obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
>  obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
> +obj-$(CONFIG_IQS621_ALS)	+= iqs621-als.o
>  obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
>  obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_ISL29125)		+= isl29125.o
> diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
> new file mode 100644
> index 0000000..92a6173
> --- /dev/null
> +++ b/drivers/iio/light/iqs621-als.c
> @@ -0,0 +1,361 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Azoteq IQS621 Ambient Light Sensor
> + *
> + * Copyright (C) 2019
> + * Author: Jeff LaBundy <jeff@labundy.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/iqs62x.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define IQS621_ALS_FLAGS			0x16
> +#define IQS621_ALS_FLAGS_LIGHT			BIT(7)
> +
> +#define IQS621_ALS_UI_OUT			0x17
> +
> +#define IQS621_ALS_THRESH_DARK			0x80
> +#define IQS621_ALS_THRESH_DARK_MAX		1020
> +#define IQS621_ALS_THRESH_DARK_SHIFT		2
> +
> +#define IQS621_ALS_THRESH_LIGHT			0x81
> +#define IQS621_ALS_THRESH_LIGHT_MAX		4080
> +#define IQS621_ALS_THRESH_LIGHT_SHIFT		4
> +
> +struct iqs621_als_private {
> +	struct iqs62x_core *iqs62x;
> +	struct notifier_block notifier;
> +	struct mutex lock;
> +	bool event_en;
> +	u8 thresh_light;
> +	u8 thresh_dark;
> +	u8 flags;
> +};
> +
> +static int iqs621_als_init(struct iqs621_als_private *iqs621_als)
> +{
> +	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
> +	unsigned int val;
> +	int error;
> +
> +	mutex_lock(&iqs621_als->lock);
> +
> +	error = regmap_write(iqs62x->map, IQS621_ALS_THRESH_LIGHT,
> +			     iqs621_als->thresh_light);
> +	if (error)
> +		goto err_mutex;
> +
> +	error = regmap_write(iqs62x->map, IQS621_ALS_THRESH_DARK,
> +			     iqs621_als->thresh_dark);
> +	if (error)
> +		goto err_mutex;
> +
> +	error = regmap_read(iqs62x->map, IQS621_ALS_FLAGS, &val);
> +	if (error)
> +		goto err_mutex;
> +	iqs621_als->flags = val;
> +
> +	error = regmap_update_bits(iqs62x->map, IQS620_GLBL_EVENT_MASK,
> +				   iqs62x->dev_desc->als_mask,
> +				   iqs621_als->event_en ? 0 : 0xFF);
> +
> +err_mutex:
> +	mutex_unlock(&iqs621_als->lock);
> +
> +	return error;
> +}
> +
> +static int iqs621_als_notifier(struct notifier_block *notifier,
> +			       unsigned long event_flags, void *context)
> +{
> +	struct iqs62x_event_data *event_data = context;
> +	struct iqs621_als_private *iqs621_als;
> +	struct iio_dev *indio_dev;
> +	enum iio_event_direction dir;
> +	int error;
> +
> +	iqs621_als = container_of(notifier, struct iqs621_als_private,
> +				  notifier);
> +	indio_dev = iio_priv_to_dev(iqs621_als);
> +
> +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> +		error = iqs621_als_init(iqs621_als);
> +		if (error) {
> +			dev_err(indio_dev->dev.parent,
> +				"Failed to re-initialize device: %d\n", error);
> +			return NOTIFY_BAD;
> +		}
> +
> +		return NOTIFY_OK;
> +	}
> +
> +	if (!((event_data->als_flags ^ iqs621_als->flags) &
> +	    IQS621_ALS_FLAGS_LIGHT))
> +		return NOTIFY_DONE;
> +
> +	iqs621_als->flags = event_data->als_flags;
> +
> +	if (!iqs621_als->event_en)
> +		return NOTIFY_OK;
> +
> +	dir = iqs621_als->flags & IQS621_ALS_FLAGS_LIGHT ? IIO_EV_DIR_RISING :
> +							   IIO_EV_DIR_FALLING;
> +
> +	iio_push_event(indio_dev,
> +		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +					    IIO_EV_TYPE_THRESH, dir),
> +		       iio_get_time_ns(indio_dev));
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void iqs621_als_notifier_unregister(void *context)
> +{
> +	struct iqs621_als_private *iqs621_als = context;
> +	struct iio_dev *indio_dev = iio_priv_to_dev(iqs621_als);
> +	int error;
> +
> +	error = blocking_notifier_chain_unregister(&iqs621_als->iqs62x->nh,
> +						   &iqs621_als->notifier);
> +	if (error)
> +		dev_err(indio_dev->dev.parent,
> +			"Failed to unregister notifier: %d\n", error);
> +}
> +
> +static int iqs621_als_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
> +	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
> +	int error;
> +	__le16 val_buf;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		error = regmap_raw_read(iqs62x->map, IQS621_ALS_UI_OUT,
> +					&val_buf, sizeof(val_buf));
> +		if (error)
> +			return error;
> +
> +		*val = le16_to_cpu(val_buf);
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int iqs621_als_read_event_config(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir)
> +{
> +	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
> +
> +	return iqs621_als->event_en;
> +}
> +
> +static int iqs621_als_write_event_config(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 enum iio_event_type type,
> +					 enum iio_event_direction dir,
> +					 int state)
> +{
> +	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
> +	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
> +	int error;
> +
> +	mutex_lock(&iqs621_als->lock);
> +
> +	error = regmap_update_bits(iqs62x->map, IQS620_GLBL_EVENT_MASK,
> +				   iqs62x->dev_desc->als_mask,
> +				   state ? 0 : 0xFF);
> +	if (!error)
> +		iqs621_als->event_en = state;
> +
> +	mutex_unlock(&iqs621_als->lock);
> +
> +	return error;
> +}
> +
> +static int iqs621_als_read_event_value(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       enum iio_event_info info,
> +				       int *val, int *val2)
> +{
> +	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		*val = iqs621_als->thresh_light;
> +		*val <<= IQS621_ALS_THRESH_LIGHT_SHIFT;
> +		return IIO_VAL_INT;
> +
> +	case IIO_EV_DIR_FALLING:
> +		*val = iqs621_als->thresh_dark;
> +		*val <<= IQS621_ALS_THRESH_DARK_SHIFT;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					enum iio_event_info info,
> +					int val, int val2)
> +{
> +	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
> +	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
> +	int error = -EINVAL;
> +
> +	mutex_lock(&iqs621_als->lock);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		if (val > IQS621_ALS_THRESH_LIGHT_MAX)
> +			break;
> +		val >>= IQS621_ALS_THRESH_LIGHT_SHIFT;
> +
> +		error = regmap_write(iqs62x->map, IQS621_ALS_THRESH_LIGHT, val);
> +		if (!error)
> +			iqs621_als->thresh_light = val;
> +		break;
> +
> +	case IIO_EV_DIR_FALLING:
> +		if (val > IQS621_ALS_THRESH_DARK)
> +			break;
> +		val >>= IQS621_ALS_THRESH_DARK_SHIFT;
> +
> +		error = regmap_write(iqs62x->map, IQS621_ALS_THRESH_DARK, val);
> +		if (!error)
> +			iqs621_als->thresh_dark = val;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&iqs621_als->lock);
> +
> +	return error;
> +}
> +
> +static const struct iio_info iqs621_als_info = {
> +	.read_raw = &iqs621_als_read_raw,
> +	.read_event_config = iqs621_als_read_event_config,
> +	.write_event_config = iqs621_als_write_event_config,
> +	.read_event_value = iqs621_als_read_event_value,
> +	.write_event_value = iqs621_als_write_event_value,
> +};
> +
> +static const struct iio_event_spec iqs621_als_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
> +static const struct iio_chan_spec iqs621_als_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec = iqs621_als_events,
> +		.num_event_specs = ARRAY_SIZE(iqs621_als_events),
> +	},
> +};
> +
> +static int iqs621_als_probe(struct platform_device *pdev)
> +{
> +	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
> +	struct iqs621_als_private *iqs621_als;
> +	struct iio_dev *indio_dev;
> +	unsigned int val;
> +	int error;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*iqs621_als));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->channels = iqs621_als_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(iqs621_als_channels);
> +	indio_dev->name = iqs62x->dev_desc->dev_name;
> +	indio_dev->info = &iqs621_als_info;
> +
> +	iqs621_als = iio_priv(indio_dev);
> +	iqs621_als->iqs62x = iqs62x;
> +
> +	error = regmap_read(iqs62x->map, IQS621_ALS_THRESH_LIGHT, &val);
> +	if (error)
> +		return error;
> +	iqs621_als->thresh_light = val;
> +
> +	error = regmap_read(iqs62x->map, IQS621_ALS_THRESH_DARK, &val);
> +	if (error)
> +		return error;
> +	iqs621_als->thresh_dark = val;
> +
> +	mutex_init(&iqs621_als->lock);
> +
> +	error = iqs621_als_init(iqs621_als);
> +	if (error)
> +		return error;
> +
> +	iqs621_als->notifier.notifier_call = iqs621_als_notifier;
> +	error = blocking_notifier_chain_register(&iqs621_als->iqs62x->nh,
> +						 &iqs621_als->notifier);
> +	if (error) {
> +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", error);
> +		return error;
> +	}
> +
> +	error = devm_add_action_or_reset(&pdev->dev,
> +					 iqs621_als_notifier_unregister,
> +					 iqs621_als);
> +	if (error) {

This one can only fail if a memory allocation fails (IIRC) so it feels
a bit paranoid to worry about this little corner case when you are
fairly (correctly in my view) sparse in error message for other cases..

> +		dev_err(&pdev->dev, "Failed to add action: %d\n", error);
> +		return error;
> +	}
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static struct platform_driver iqs621_als_platform_driver = {
> +	.driver = {
> +		.name	= IQS621_DRV_NAME_ALS,
> +	},
> +	.probe		= iqs621_als_probe,
> +};
> +module_platform_driver(iqs621_als_platform_driver);
> +
> +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> +MODULE_DESCRIPTION("Azoteq IQS621 Ambient Light Sensor");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" IQS621_DRV_NAME_ALS);

