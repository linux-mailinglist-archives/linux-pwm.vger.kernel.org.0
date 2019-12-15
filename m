Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE41311F933
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Dec 2019 17:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfLOQrS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 15 Dec 2019 11:47:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfLOQrS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 15 Dec 2019 11:47:18 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1179620726;
        Sun, 15 Dec 2019 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576428436;
        bh=CdHVZ3U+vBI1VrQ8qAY8Un23GoZpL1/cKvkxUOub+PE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SXKhmT3o39CNc+k78LyV/twvZYtJQ9ZM9FCGr6Jw9WZeW/76HO57MBiCdnO7t09dR
         LT0K9kRjsabyKa0iTZLbvZf4N70Nvib0+vyTY+IRCUYje2qsWVG75cutm9IAExYATn
         nv6Bb3b6DMvj6mO1UQ6deFum52XblQi7Qe9nwWb0=
Date:   Sun, 15 Dec 2019 16:47:11 +0000
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
Subject: Re: [PATCH v2 6/7] iio: light: Add support for Azoteq IQS621/622
 ambient light sensors
Message-ID: <20191215164711.0bd0241d@archlinux>
In-Reply-To: <1575851866-18919-7-git-send-email-jeff@labundy.com>
References: <1575851866-18919-1-git-send-email-jeff@labundy.com>
        <1575851866-18919-7-git-send-email-jeff@labundy.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 9 Dec 2019 00:38:39 +0000
Jeff LaBundy <jeff@labundy.com> wrote:

> This patch adds support for the Azoteq IQS621 and IQS622 ambient light
> sensors, both of which can report a four-bit representation of ambient
> light intensity.
> 
> The IQS621 can additionally report illuminace directly in units of lux,
> while the IQS622 can report a four-bit representation of infrared light
> intensity. Furthermore, the IQS622 can report a unitless measurement of
> a target's proximity to the device.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Nice little driver :)

Jonathan

> ---
> Changes in v2:
>   - Merged 'Copyright' and 'Author' lines into one in introductory comments
>   - Replaced 'error' with 'ret' throughout
>   - Merged support for the closely related IQS622 (formerly represented by
>     a separate iio/proximity driver)
>   - Added support for unitless ambient light intensity (IQS621 and IQS622)
>     and infrared light intensity (IQS622 only)
>   - Moved the read of IQS621_ALS_FLAGS to iqs621_als_write_event_config to
>     account for the fact that IQS621_ALS_FLAGS may have changed in between
>     having first been read in iqs621_als_init and the time at which events
>     are enabled, thereby eliminating the need to call iqs621_als_init from
>     iqs621_als_probe
>   - Refactored the logic in iqs621_als_notifier and added a lock to safely
>     evaluate variables that may change in response to user action
>   - Added locks to iqs621_als_read_event_config/value to account for cases in
>     which the corresponding hardware state is in the process of being updated
>   - Refactored the logic in iqs621_als_read/write_event_value and removed all
>     #defines that could instead be represented by simple math
>   - Based the decision whether to select the IQS622 IR touch vs. proximity
>     threshold on the single proximity threshold written by user space, and
>     added a comment to describe the difference between either threshold
>   - Replaced IIO_CHAN_INFO_RAW with IIO_CHAN_INFO_PROCESSED for the IIO_LIGHT
>     channel (IQS621 only)
>   - Removed devm_add_action_or_reset failure message
>   - Eliminated tabbed alignment of platform_driver struct members
>   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
> 
>  drivers/iio/light/Kconfig      |  10 +
>  drivers/iio/light/Makefile     |   1 +
>  drivers/iio/light/iqs621-als.c | 614 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 625 insertions(+)
>  create mode 100644 drivers/iio/light/iqs621-als.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 9968f98..baf7958b 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -173,6 +173,16 @@ config GP2AP020A00F
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called gp2ap020a00f.
> 
> +config IQS621_ALS
> +	tristate "Azoteq IQS621/622 ambient light sensors"
> +	depends on MFD_IQS62X || COMPILE_TEST
> +	help
> +	  Say Y here if you want to build support for the Azoteq IQS621
> +	  and IQS622 ambient light sensors.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called iqs621-als.
> +
>  config SENSORS_ISL29018
>  	tristate "Intersil 29018 light and proximity sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index c98d1ce..988e8f4 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
>  obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
>  obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
> +obj-$(CONFIG_IQS621_ALS)	+= iqs621-als.o
>  obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
>  obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_ISL29125)		+= isl29125.o
> diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
> new file mode 100644
> index 0000000..a4dd718
> --- /dev/null
> +++ b/drivers/iio/light/iqs621-als.c
> @@ -0,0 +1,614 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Azoteq IQS621/622 Ambient Light Sensors
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
> +#define IQS621_ALS_FLAGS_LIGHT			BIT(7)
> +#define IQS621_ALS_FLAGS_RANGE			GENMASK(3, 0)
> +
> +#define IQS621_ALS_UI_OUT			0x17
> +
> +#define IQS621_ALS_THRESH_DARK			0x80
> +#define IQS621_ALS_THRESH_LIGHT			0x81
> +
> +#define IQS622_IR_RANGE				0x15
> +#define IQS622_IR_FLAGS				0x16
> +#define IQS622_IR_FLAGS_TOUCH			BIT(1)
> +#define IQS622_IR_FLAGS_PROX			BIT(0)
> +
> +#define IQS622_IR_UI_OUT			0x17
> +
> +#define IQS622_IR_THRESH_PROX			0x91
> +#define IQS622_IR_THRESH_TOUCH			0x92
> +
> +struct iqs621_als_private {
> +	struct iqs62x_core *iqs62x;
> +	struct notifier_block notifier;
> +	struct mutex lock;
> +	bool light_en;
> +	bool range_en;
> +	bool prox_en;
> +	u8 als_flags;
> +	u8 ir_flags_mask;
> +	u8 ir_flags;
> +	u8 thresh_light;
> +	u8 thresh_dark;
> +	u8 thresh_prox;
> +};
> +
> +static int iqs621_als_init(struct iqs621_als_private *iqs621_als)
> +{
> +	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
> +	unsigned int event_mask = 0;
> +	int ret;
> +
> +	switch (iqs621_als->ir_flags_mask) {
> +	case IQS622_IR_FLAGS_TOUCH:
> +		ret = regmap_write(iqs62x->map, IQS622_IR_THRESH_TOUCH,
> +				   iqs621_als->thresh_prox);
> +		break;
> +
> +	case IQS622_IR_FLAGS_PROX:
> +		ret = regmap_write(iqs62x->map, IQS622_IR_THRESH_PROX,
> +				   iqs621_als->thresh_prox);
> +		break;
> +
> +	default:
> +		ret = regmap_write(iqs62x->map, IQS621_ALS_THRESH_LIGHT,
> +				   iqs621_als->thresh_light);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(iqs62x->map, IQS621_ALS_THRESH_DARK,
> +				   iqs621_als->thresh_dark);
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	if (iqs621_als->light_en || iqs621_als->range_en)
> +		event_mask |= iqs62x->dev_desc->als_mask;
> +
> +	if (iqs621_als->prox_en)
> +		event_mask |= iqs62x->dev_desc->ir_mask;
> +
> +	return regmap_update_bits(iqs62x->map, IQS620_GLBL_EVENT_MASK,
> +				  event_mask, 0);
> +}
> +
> +static int iqs621_als_notifier(struct notifier_block *notifier,
> +			       unsigned long event_flags, void *context)
> +{
> +	struct iqs62x_event_data *event_data = context;
> +	struct iqs621_als_private *iqs621_als;
> +	struct iio_dev *indio_dev;
> +	bool light_new, light_old;
> +	bool prox_new, prox_old;
> +	u8 range_new, range_old;
> +	s64 timestamp;
> +	int ret;
> +
> +	iqs621_als = container_of(notifier, struct iqs621_als_private,
> +				  notifier);
> +	indio_dev = iio_priv_to_dev(iqs621_als);
> +	timestamp = iio_get_time_ns(indio_dev);
> +
> +	mutex_lock(&iqs621_als->lock);
> +
> +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> +		ret = iqs621_als_init(iqs621_als);
> +		if (ret) {
> +			dev_err(indio_dev->dev.parent,
> +				"Failed to re-initialize device: %d\n", ret);
> +			ret = NOTIFY_BAD;
> +		} else {
> +			ret = NOTIFY_OK;
> +		}
> +
> +		goto err_mutex;
> +	}
> +
> +	if (!iqs621_als->light_en && !iqs621_als->range_en &&
> +	    !iqs621_als->prox_en) {
> +		ret = NOTIFY_DONE;
> +		goto err_mutex;
> +	}
> +
> +	/* IQS621 only */
> +	light_new = event_data->als_flags & IQS621_ALS_FLAGS_LIGHT;
> +	light_old = iqs621_als->als_flags & IQS621_ALS_FLAGS_LIGHT;
> +
> +	if (iqs621_als->light_en && light_new && !light_old)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       timestamp);
> +	else if (iqs621_als->light_en && !light_new && light_old)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING),
> +			       timestamp);
> +
> +	/* IQS621 and IQS622 */
> +	range_new = event_data->als_flags & IQS621_ALS_FLAGS_RANGE;
> +	range_old = iqs621_als->als_flags & IQS621_ALS_FLAGS_RANGE;
> +
> +	if (iqs621_als->range_en && (range_new > range_old))
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
> +						    IIO_EV_TYPE_CHANGE,
> +						    IIO_EV_DIR_RISING),
> +			       timestamp);
> +	else if (iqs621_als->range_en && (range_new < range_old))
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
> +						    IIO_EV_TYPE_CHANGE,
> +						    IIO_EV_DIR_FALLING),
> +			       timestamp);
> +
> +	/* IQS622 only */
> +	prox_new = event_data->ir_flags & iqs621_als->ir_flags_mask;
> +	prox_old = iqs621_als->ir_flags & iqs621_als->ir_flags_mask;
> +
> +	if (iqs621_als->prox_en && prox_new && !prox_old)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       timestamp);
> +	else if (iqs621_als->prox_en && !prox_new && prox_old)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING),
> +			       timestamp);
> +
> +	iqs621_als->als_flags = event_data->als_flags;
> +	iqs621_als->ir_flags = event_data->ir_flags;
> +	ret = NOTIFY_OK;
> +
> +err_mutex:
> +	mutex_unlock(&iqs621_als->lock);
> +
> +	return ret;
> +}
> +
> +static void iqs621_als_notifier_unregister(void *context)
> +{
> +	struct iqs621_als_private *iqs621_als = context;
> +	struct iio_dev *indio_dev = iio_priv_to_dev(iqs621_als);
> +	int ret;
> +
> +	ret = blocking_notifier_chain_unregister(&iqs621_als->iqs62x->nh,
> +						 &iqs621_als->notifier);
> +	if (ret)
> +		dev_err(indio_dev->dev.parent,
> +			"Failed to unregister notifier: %d\n", ret);
> +}
> +
> +static int iqs621_als_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct iqs621_als_private *iqs621_als = iio_priv(indio_dev);
> +	struct iqs62x_core *iqs62x = iqs621_als->iqs62x;
> +	int ret;
> +	__le16 val_buf;
> +
> +	switch (chan->type) {
> +	case IIO_INTENSITY:
> +		ret = regmap_read(iqs62x->map, chan->address, val);
> +		if (ret)
> +			return ret;
> +
> +		*val &= IQS621_ALS_FLAGS_RANGE;
> +		return IIO_VAL_INT;
> +
> +	case IIO_PROXIMITY:
> +	case IIO_LIGHT:
> +		ret = regmap_raw_read(iqs62x->map, chan->address, &val_buf,
> +				      sizeof(val_buf));
> +		if (ret)
> +			return ret;
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
> +	int ret;
> +
> +	mutex_lock(&iqs621_als->lock);
> +
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		ret = iqs621_als->light_en;
> +		break;
> +
> +	case IIO_INTENSITY:
> +		ret = iqs621_als->range_en;
> +		break;
> +
> +	case IIO_PROXIMITY:
> +		ret = iqs621_als->prox_en;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&iqs621_als->lock);
> +
> +	return ret;
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
> +	unsigned int val;
> +	int ret;
> +
> +	mutex_lock(&iqs621_als->lock);
> +
> +	ret = regmap_read(iqs62x->map, iqs62x->dev_desc->als_flags, &val);
> +	if (ret)
> +		goto err_mutex;
> +	iqs621_als->als_flags = val;
> +
> +	switch (chan->type) {
> +	case IIO_LIGHT:
> +		ret = regmap_update_bits(iqs62x->map, IQS620_GLBL_EVENT_MASK,
> +					 iqs62x->dev_desc->als_mask,
> +					 iqs621_als->range_en | state ? 0 :
> +									0xFF);
> +		if (!ret)
> +			iqs621_als->light_en = state;
> +		break;
> +
> +	case IIO_INTENSITY:
> +		ret = regmap_update_bits(iqs62x->map, IQS620_GLBL_EVENT_MASK,
> +					 iqs62x->dev_desc->als_mask,
> +					 iqs621_als->light_en | state ? 0 :
> +									0xFF);
> +		if (!ret)
> +			iqs621_als->range_en = state;
> +		break;
> +
> +	case IIO_PROXIMITY:
> +		ret = regmap_read(iqs62x->map, IQS622_IR_FLAGS, &val);
> +		if (ret)
> +			goto err_mutex;
> +		iqs621_als->ir_flags = val;
> +
> +		ret = regmap_update_bits(iqs62x->map, IQS620_GLBL_EVENT_MASK,
> +					 iqs62x->dev_desc->ir_mask,
> +					 state ? 0 : 0xFF);
> +		if (!ret)
> +			iqs621_als->prox_en = state;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +err_mutex:
> +	mutex_unlock(&iqs621_als->lock);
> +
> +	return ret;
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
> +	int ret = IIO_VAL_INT;
> +
> +	mutex_lock(&iqs621_als->lock);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		*val = iqs621_als->thresh_light * 16;
> +		break;
> +
> +	case IIO_EV_DIR_FALLING:
> +		*val = iqs621_als->thresh_dark * 4;
> +		break;
> +
> +	case IIO_EV_DIR_EITHER:
> +		if (iqs621_als->ir_flags_mask == IQS622_IR_FLAGS_TOUCH)
> +			*val = iqs621_als->thresh_prox * 4;
> +		else
> +			*val = iqs621_als->thresh_prox;
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	mutex_unlock(&iqs621_als->lock);
> +
> +	return ret;
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
> +	unsigned int thresh_reg, thresh_val;
> +	u8 ir_flags_mask, *thresh_cache;
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&iqs621_als->lock);
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		thresh_reg = IQS621_ALS_THRESH_LIGHT;
> +		thresh_val = val / 16;
> +
> +		thresh_cache = &iqs621_als->thresh_light;
> +		ir_flags_mask = 0;
> +		break;
> +
> +	case IIO_EV_DIR_FALLING:
> +		thresh_reg = IQS621_ALS_THRESH_DARK;
> +		thresh_val = val / 4;
> +
> +		thresh_cache = &iqs621_als->thresh_dark;
> +		ir_flags_mask = 0;
> +		break;
> +
> +	case IIO_EV_DIR_EITHER:
> +		/*
> +		 * The IQS622 supports two detection thresholds, both measured
> +		 * in the same arbitrary units reported by read_raw: proximity
> +		 * (0 through 255 in steps of 1), and touch (0 through 1020 in
> +		 * steps of 4).
> +		 *
> +		 * Based on the single detection threshold chosen by the user,
> +		 * select the hardware threshold that gives the best trade-off
> +		 * between range and resolution.
> +		 *
> +		 * By default, the close-range (but coarse) touch threshold is
> +		 * chosen during probe.
> +		 */
> +		switch (val) {
> +		case 0 ... 255:
> +			thresh_reg = IQS622_IR_THRESH_PROX;
> +			thresh_val = val;
> +
> +			ir_flags_mask = IQS622_IR_FLAGS_PROX;
> +			break;
> +
> +		case 256 ... 1020:
> +			thresh_reg = IQS622_IR_THRESH_TOUCH;
> +			thresh_val = val / 4;
> +
> +			ir_flags_mask = IQS622_IR_FLAGS_TOUCH;
> +			break;
> +
> +		default:
> +			goto err_mutex;
> +		}
> +
> +		thresh_cache = &iqs621_als->thresh_prox;
> +		break;
> +
> +	default:
> +		goto err_mutex;
> +	}
> +
> +	if (thresh_val > 0xFF)
> +		goto err_mutex;
> +
> +	ret = regmap_write(iqs62x->map, thresh_reg, thresh_val);
> +	if (ret)
> +		goto err_mutex;
> +
> +	*thresh_cache = thresh_val;
> +	iqs621_als->ir_flags_mask = ir_flags_mask;
> +
> +err_mutex:
> +	mutex_unlock(&iqs621_als->lock);
> +
> +	return ret;
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
> +static const struct iio_event_spec iqs621_als_range_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_CHANGE,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +static const struct iio_event_spec iqs621_als_light_events[] = {
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
> +		.type = IIO_INTENSITY,
> +		.address = IQS621_ALS_FLAGS,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec = iqs621_als_range_events,
> +		.num_event_specs = ARRAY_SIZE(iqs621_als_range_events),
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.address = IQS621_ALS_UI_OUT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.event_spec = iqs621_als_light_events,
> +		.num_event_specs = ARRAY_SIZE(iqs621_als_light_events),
> +	},
> +};
> +
> +static const struct iio_event_spec iqs622_als_prox_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +				 BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
> +static const struct iio_chan_spec iqs622_als_channels[] = {
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel2 = IIO_MOD_LIGHT_BOTH,
> +		.address = IQS622_ALS_FLAGS,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec = iqs621_als_range_events,
> +		.num_event_specs = ARRAY_SIZE(iqs621_als_range_events),
> +		.modified = true,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.address = IQS622_IR_RANGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.modified = true,
> +	},
> +	{
> +		.type = IIO_PROXIMITY,
> +		.address = IQS622_IR_UI_OUT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.event_spec = iqs622_als_prox_events,
> +		.num_event_specs = ARRAY_SIZE(iqs622_als_prox_events),
> +	},
> +};
> +
> +static int iqs621_als_probe(struct platform_device *pdev)
> +{
> +	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
> +	struct iqs621_als_private *iqs621_als;
> +	struct iio_dev *indio_dev;
> +	unsigned int val;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*iqs621_als));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	iqs621_als = iio_priv(indio_dev);
> +	iqs621_als->iqs62x = iqs62x;
> +
> +	if (iqs62x->dev_desc->prod_num == IQS622_PROD_NUM) {
> +		ret = regmap_read(iqs62x->map, IQS622_IR_THRESH_TOUCH, &val);
> +		if (ret)
> +			return ret;
> +		iqs621_als->thresh_prox = val;
> +		iqs621_als->ir_flags_mask = IQS622_IR_FLAGS_TOUCH;
> +
> +		indio_dev->channels = iqs622_als_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(iqs622_als_channels);
> +	} else {
> +		ret = regmap_read(iqs62x->map, IQS621_ALS_THRESH_LIGHT, &val);
> +		if (ret)
> +			return ret;
> +		iqs621_als->thresh_light = val;
> +
> +		ret = regmap_read(iqs62x->map, IQS621_ALS_THRESH_DARK, &val);
> +		if (ret)
> +			return ret;
> +		iqs621_als->thresh_dark = val;
> +
> +		indio_dev->channels = iqs621_als_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(iqs621_als_channels);
> +	}
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->name = iqs62x->dev_desc->dev_name;
> +	indio_dev->info = &iqs621_als_info;
> +
> +	mutex_init(&iqs621_als->lock);
> +
> +	iqs621_als->notifier.notifier_call = iqs621_als_notifier;
> +	ret = blocking_notifier_chain_register(&iqs621_als->iqs62x->nh,
> +					       &iqs621_als->notifier);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&pdev->dev,
> +				       iqs621_als_notifier_unregister,
> +				       iqs621_als);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static struct platform_driver iqs621_als_platform_driver = {
> +	.driver = {
> +		.name = IQS621_DRV_NAME_ALS,
> +	},
> +	.probe = iqs621_als_probe,
> +};
> +module_platform_driver(iqs621_als_platform_driver);
> +
> +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> +MODULE_DESCRIPTION("Azoteq IQS621/622 Ambient Light Sensors");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" IQS621_DRV_NAME_ALS);
> --
> 2.7.4
> 

