Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42B411F93A
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Dec 2019 17:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfLOQxf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 15 Dec 2019 11:53:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfLOQxf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 15 Dec 2019 11:53:35 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF5E206E0;
        Sun, 15 Dec 2019 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576428813;
        bh=bFOx7i8qct0z5oAogxrmFOWA7k/Cv5lRBU/in1X3NSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FJykHYuDtaCYiQxg8uUHd9jdLPUflBVGY7LZou13WKjZQBotZ4SqMgT22sK4iplka
         CmV3WdXbeog2yPr2tmNxfppjN28xoKMCJKwr0KVVJgEMklV9i84eCVa8zo0BiBgOCZ
         jKebk3p/Svi6IYXRovnuMrooP6bOg4O7wbjc5WmU=
Date:   Sun, 15 Dec 2019 16:53:28 +0000
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
Subject: Re: [PATCH v2 7/7] iio: position: Add support for Azoteq IQS624/625
 angle sensors
Message-ID: <20191215165328.789e8a16@archlinux>
In-Reply-To: <1575851866-18919-8-git-send-email-jeff@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
        <1575851866-18919-8-git-send-email-jeff@labundy.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 9 Dec 2019 00:38:41 +0000
Jeff LaBundy <jeff@labundy.com> wrote:

> This patch adds support for the Azoteq IQS624 and IQS625 angular position
> sensors, capable of reporting the angle of a rotating shaft down to 1 and
> 10 degrees of accuracy, respectively.
> 
> This patch also introduces a home for linear and angular position sensors.
> Unlike resolvers, they are typically contactless and use the Hall effect.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>

Looks good

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

My current assumption is that Lee will take this lot via an immutable branch
in MFD once it's ready.  Shout if a different path makes sense.
> ---
> Changes in v2:
>   - Merged 'Copyright' and 'Author' lines into one in introductory comments
>   - Replaced 'error' with 'ret' throughout
>   - Added iqs624_pos_angle_en and iqs624_pos_angle_get to remove duplicate
>     logic previously used throughout
>   - Refactored the logic in iqs624_pos_notifier and added a lock to safely
>     evaluate variables that may change in response to user action
>   - Refactored the logic in iqs624_pos_read_raw
>   - Added a lock to iqs624_pos_read_event_config to account for cases in which
>     the corresponding hardware state is in the process of being updated
>   - Refactored the logic in iqs624_pos_write_event_config and read the initial
>     angle in case it changed since having first been read in iqs624_pos_init
>   - Removed iqs624_pos_init as its logic has since been absorbed elsewhere
>   - Removed devm_add_action_or_reset failure message
>   - Eliminated tabbed alignment of platform_driver struct members
>   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> 
>  drivers/iio/Kconfig               |   1 +
>  drivers/iio/Makefile              |   1 +
>  drivers/iio/position/Kconfig      |  19 +++
>  drivers/iio/position/Makefile     |   7 +
>  drivers/iio/position/iqs624-pos.c | 284 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 312 insertions(+)
>  create mode 100644 drivers/iio/position/Kconfig
>  create mode 100644 drivers/iio/position/Makefile
>  create mode 100644 drivers/iio/position/iqs624-pos.c
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 5bd5185..d5c073a 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -88,6 +88,7 @@ source "drivers/iio/orientation/Kconfig"
>  if IIO_TRIGGER
>     source "drivers/iio/trigger/Kconfig"
>  endif #IIO_TRIGGER
> +source "drivers/iio/position/Kconfig"
>  source "drivers/iio/potentiometer/Kconfig"
>  source "drivers/iio/potentiostat/Kconfig"
>  source "drivers/iio/pressure/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index bff682a..1712011 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -31,6 +31,7 @@ obj-y += light/
>  obj-y += magnetometer/
>  obj-y += multiplexer/
>  obj-y += orientation/
> +obj-y += position/
>  obj-y += potentiometer/
>  obj-y += potentiostat/
>  obj-y += pressure/
> diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
> new file mode 100644
> index 0000000..eda67f0
> --- /dev/null
> +++ b/drivers/iio/position/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Linear and angular position sensors
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Linear and angular position sensors"
> +
> +config IQS624_POS
> +	tristate "Azoteq IQS624/625 angular position sensors"
> +	depends on MFD_IQS62X || COMPILE_TEST
> +	help
> +	  Say Y here if you want to build support for the Azoteq IQS624
> +	  and IQS625 angular position sensors.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called iqs624-pos.
> +
> +endmenu
> diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
> new file mode 100644
> index 0000000..3cbe7a7
> --- /dev/null
> +++ b/drivers/iio/position/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for IIO linear and angular position sensors
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +
> +obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
> diff --git a/drivers/iio/position/iqs624-pos.c b/drivers/iio/position/iqs624-pos.c
> new file mode 100644
> index 0000000..af629bf5
> --- /dev/null
> +++ b/drivers/iio/position/iqs624-pos.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Azoteq IQS624/625 Angular Position Sensors
> + *
> + * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
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
> +#define IQS624_POS_DEG_OUT			0x16
> +
> +#define IQS624_POS_SCALE1			(314159 / 180)
> +#define IQS624_POS_SCALE2			100000
> +
> +struct iqs624_pos_private {
> +	struct iqs62x_core *iqs62x;
> +	struct notifier_block notifier;
> +	struct mutex lock;
> +	bool angle_en;
> +	u16 angle;
> +};
> +
> +static int iqs624_pos_angle_en(struct iqs62x_core *iqs62x, bool angle_en)
> +{
> +	unsigned int event_mask = IQS624_HALL_UI_WHL_EVENT;
> +
> +	/*
> +	 * The IQS625 reports angular position in the form of coarse intervals,
> +	 * so only interval change events are unmasked. Conversely, the IQS624
> +	 * reports angular position down to one degree of resolution, so wheel
> +	 * movement events are unmasked instead.
> +	 */
> +	if (iqs62x->dev_desc->prod_num == IQS625_PROD_NUM)
> +		event_mask = IQS624_HALL_UI_INT_EVENT;
> +
> +	return regmap_update_bits(iqs62x->map, IQS624_HALL_UI, event_mask,
> +				  angle_en ? 0 : 0xFF);
> +}
> +
> +static int iqs624_pos_notifier(struct notifier_block *notifier,
> +			       unsigned long event_flags, void *context)
> +{
> +	struct iqs62x_event_data *event_data = context;
> +	struct iqs624_pos_private *iqs624_pos;
> +	struct iqs62x_core *iqs62x;
> +	struct iio_dev *indio_dev;
> +	u16 angle = event_data->ui_data;
> +	s64 timestamp;
> +	int ret;
> +
> +	iqs624_pos = container_of(notifier, struct iqs624_pos_private,
> +				  notifier);
> +	indio_dev = iio_priv_to_dev(iqs624_pos);
> +	timestamp = iio_get_time_ns(indio_dev);
> +
> +	iqs62x = iqs624_pos->iqs62x;
> +	if (iqs62x->dev_desc->prod_num == IQS625_PROD_NUM)
> +		angle = event_data->interval;
> +
> +	mutex_lock(&iqs624_pos->lock);
> +
> +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> +		ret = iqs624_pos_angle_en(iqs62x, iqs624_pos->angle_en);
> +		if (ret) {
> +			dev_err(indio_dev->dev.parent,
> +				"Failed to re-initialize device: %d\n", ret);
> +			ret = NOTIFY_BAD;
> +		} else {
> +			ret = NOTIFY_OK;
> +		}
> +	} else if (iqs624_pos->angle_en && (angle != iqs624_pos->angle)) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ANGL, 0,
> +						    IIO_EV_TYPE_CHANGE,
> +						    IIO_EV_DIR_NONE),
> +			       timestamp);
> +
> +		iqs624_pos->angle = angle;
> +		ret = NOTIFY_OK;
> +	} else {
> +		ret = NOTIFY_DONE;
> +	}
> +
> +	mutex_unlock(&iqs624_pos->lock);
> +
> +	return ret;
> +}
> +
> +static void iqs624_pos_notifier_unregister(void *context)
> +{
> +	struct iqs624_pos_private *iqs624_pos = context;
> +	struct iio_dev *indio_dev = iio_priv_to_dev(iqs624_pos);
> +	int ret;
> +
> +	ret = blocking_notifier_chain_unregister(&iqs624_pos->iqs62x->nh,
> +						 &iqs624_pos->notifier);
> +	if (ret)
> +		dev_err(indio_dev->dev.parent,
> +			"Failed to unregister notifier: %d\n", ret);
> +}
> +
> +static int iqs624_pos_angle_get(struct iqs62x_core *iqs62x, unsigned int *val)
> +{
> +	int ret;
> +	__le16 val_buf;
> +
> +	if (iqs62x->dev_desc->prod_num == IQS625_PROD_NUM)
> +		return regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
> +				   val);
> +
> +	ret = regmap_raw_read(iqs62x->map, IQS624_POS_DEG_OUT, &val_buf,
> +			      sizeof(val_buf));
> +	if (ret)
> +		return ret;
> +
> +	*val = le16_to_cpu(val_buf);
> +
> +	return 0;
> +}
> +
> +static int iqs624_pos_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
> +	struct iqs62x_core *iqs62x = iqs624_pos->iqs62x;
> +	unsigned int scale = 1;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iqs624_pos_angle_get(iqs62x, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		if (iqs62x->dev_desc->prod_num == IQS625_PROD_NUM) {
> +			ret = regmap_read(iqs62x->map, IQS624_INTERVAL_DIV,
> +					  &scale);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		*val = scale * IQS624_POS_SCALE1;
> +		*val2 = IQS624_POS_SCALE2;
> +		return IIO_VAL_FRACTIONAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int iqs624_pos_read_event_config(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir)
> +{
> +	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&iqs624_pos->lock);
> +	ret = iqs624_pos->angle_en;
> +	mutex_unlock(&iqs624_pos->lock);
> +
> +	return ret;
> +}
> +
> +static int iqs624_pos_write_event_config(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 enum iio_event_type type,
> +					 enum iio_event_direction dir,
> +					 int state)
> +{
> +	struct iqs624_pos_private *iqs624_pos = iio_priv(indio_dev);
> +	struct iqs62x_core *iqs62x = iqs624_pos->iqs62x;
> +	unsigned int val;
> +	int ret;
> +
> +	mutex_lock(&iqs624_pos->lock);
> +
> +	ret = iqs624_pos_angle_get(iqs62x, &val);
> +	if (ret)
> +		goto err_mutex;
> +
> +	ret = iqs624_pos_angle_en(iqs62x, state);
> +	if (ret)
> +		goto err_mutex;
> +
> +	iqs624_pos->angle = val;
> +	iqs624_pos->angle_en = state;
> +
> +err_mutex:
> +	mutex_unlock(&iqs624_pos->lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info iqs624_pos_info = {
> +	.read_raw = &iqs624_pos_read_raw,
> +	.read_event_config = iqs624_pos_read_event_config,
> +	.write_event_config = iqs624_pos_write_event_config,
> +};
> +
> +static const struct iio_event_spec iqs624_pos_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_CHANGE,
> +		.dir = IIO_EV_DIR_NONE,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_chan_spec iqs624_pos_channels[] = {
> +	{
> +		.type = IIO_ANGL,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec = iqs624_pos_events,
> +		.num_event_specs = ARRAY_SIZE(iqs624_pos_events),
> +	},
> +};
> +
> +static int iqs624_pos_probe(struct platform_device *pdev)
> +{
> +	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
> +	struct iqs624_pos_private *iqs624_pos;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*iqs624_pos));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	iqs624_pos = iio_priv(indio_dev);
> +	iqs624_pos->iqs62x = iqs62x;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->channels = iqs624_pos_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(iqs624_pos_channels);
> +	indio_dev->name = iqs62x->dev_desc->dev_name;
> +	indio_dev->info = &iqs624_pos_info;
> +
> +	mutex_init(&iqs624_pos->lock);
> +
> +	iqs624_pos->notifier.notifier_call = iqs624_pos_notifier;
> +	ret = blocking_notifier_chain_register(&iqs624_pos->iqs62x->nh,
> +					       &iqs624_pos->notifier);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       iqs624_pos_notifier_unregister,
> +				       iqs624_pos);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static struct platform_driver iqs624_pos_platform_driver = {
> +	.driver = {
> +		.name = IQS624_DRV_NAME_POS,
> +	},
> +	.probe = iqs624_pos_probe,
> +};
> +module_platform_driver(iqs624_pos_platform_driver);
> +
> +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> +MODULE_DESCRIPTION("Azoteq IQS624/625 Angular Position Sensors");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" IQS624_DRV_NAME_POS);
> --
> 2.7.4
> 

