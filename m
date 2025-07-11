Return-Path: <linux-pwm+bounces-6826-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318CAB012EF
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 07:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1692E1CA13A1
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Jul 2025 05:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A2E190477;
	Fri, 11 Jul 2025 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO9pKPpv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE84469D;
	Fri, 11 Jul 2025 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212747; cv=none; b=nl1tDd5CzEm5lFEo/eXfOeglxr8i++n8cwBXoGmyClnOKX8r7Urvr4pWaH/YxacrbOwEQS5+xkjXrDxM5yhzEWjSHMEY4fB6H/DEwnEnROYo6ykDw7kgHvNWF1w4ICd1IdW/1oydBRjdvc/96FP9DrBD/8ozPjG5ngHFlS/FyOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212747; c=relaxed/simple;
	bh=fFMHGIUYluhLy7nviSOyz9CgfN4/6iGPqgzze3p2MTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EURQI64zheVEZZX7fKbGftLMmPkpTIrHUeS7/na0OlE85XHfvv6t9lilCHD+5KQyh9i4VizwUTmrHIRDO+rquidv6LkKl/Kis6geMNAWpWTGiRWJfSWv4vMuHz/2jhfXBZRslw/b4eW2+yjH64vKeEt19SAHAtrgEzhVKyIIZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dO9pKPpv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so1131703f8f.0;
        Thu, 10 Jul 2025 22:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752212744; x=1752817544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnKpKVYBlXx1mNYoZnwtdoYmYku55diV41pmTK8o3EA=;
        b=dO9pKPpv8aHTLhAJz6QbAYfWBZt+tbpvGEWfqesLihv93EngNmevH/UjQoLZ0zZxs0
         IFhan9xQVDgLUK9Rfo3+QKK4/f1Ud7TlFSFdo58rJuWx9Mwwh+YKpdjzqf2vrU9zUdIh
         kAy1tgmAqMpQdC0dmoLNpVpKJGajsqqsyLxWROIAQWRAtcdc+OhhZdObmIo/xeUBuTgr
         QzR9L8rMe7AlfQOzeuqG7NhdotX7WnjyF28yVkzNeE0G+Bu+uGg0+BsYVsJc4v64PsbI
         sruJr+fiIKslXC8uRi46AsFNC0FsYL4AAIeZkcmufAIqu3g7Ag+80gU3o9fhtMH+Q8Ki
         i4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752212744; x=1752817544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnKpKVYBlXx1mNYoZnwtdoYmYku55diV41pmTK8o3EA=;
        b=aMcF5HjELmFfAEBjPiB8VCq+488xNa5v1EEiLi0U0mwpABOrPTplp5+DkXhHTfi6ZN
         opADffHSI2zgvVTESDbD9ygKVQ/zA8rELu9DOdkbU6W97lSCdSqbazQcbptJR4A7rhEi
         LEN6bgfmXIMMLlzd/pasw5MIcXT9K46J5yD8b3mqLKAuka95J3FzYYG/QlffGNI+wsTD
         eV61HbhRV9naSpfaKMMv/7oH7ay2i0NPohP9mH/mwd0iJHlxQ7Gy9IVOBTfUNdeFH43w
         C7nWXi2ZbQEt2YGzbhjJV0bJ9wbw78lKJ7sHBzDKa0Kmps2pQ+zz52RB6RfasVdVP4el
         /L+A==
X-Forwarded-Encrypted: i=1; AJvYcCV0vo8pA/tXmCp1GbS6WI4VtQnSL06DUR/grgv/WSJVtxV7a6SoeQ8gyngvp4v/vS5IYJpJ1WYO6YWZKg==@vger.kernel.org, AJvYcCX/mAbhhlndKNPVgqsIaSCcrJV8KgUGHzPRx/GCyaYKgCJSCZSQVjYdAlxlVrRP+oV36W6azjJCtJI3lzan@vger.kernel.org, AJvYcCXU7ZuYM43/WcVVQ8ZlfjgFY6HeBMAyhmRZyuF8Li10FzzGUe40g0CrKqi41LCiGaGFm9BQXxN5kJ4S@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNcUtZ+wAHnjmfxNIrMCClcyYo9363Tv2omdQl64B7Dj17wZL
	yroqd4izz+GkD5iNwobbW4sI44x1wo9mN4v3J8tHYUC0eqB+lA74WX+X
X-Gm-Gg: ASbGncuCiWibrMtlZYsqC/YmrXOlqWz2NkB6jHlii/ZtLPCj5I5nlBbtIWA1CN3LLvu
	n8yGFkt0jf1ec6IqYDwNluLBh7Bf1QU46JfNJHk2GZ/vmeejXltW4GhzvPHrtcmGNJR9lKYgRsd
	VK75Fh+TFK0JGvkpizn5+FaxF6BZNA7eQgfiDPeh6Y1cMkkfji+/6vBV16216YXPNm33VFGOwBA
	iP85WCNuYicegunGmcUqxM13FH+kdSvsTLNr4oxq07vsvbhFoi1ikCmhl6yPtQjwkY9Rrq0Mdlb
	WrCITX51Wtfu1M3HT17wjxojDM8GLEyq1Kx2gm2Cunn5G147JW/notHn15kfobme8rcM+IBIsv7
	nS1GkN8IUS4AUr23bhP48
X-Google-Smtp-Source: AGHT+IHtqioAYntSDpTDEdGFY4zwVuLDOBSL7zFY8jr3cx1WUfnp1TZmiyDiWT/tY3I51VreD8vT6w==
X-Received: by 2002:a05:6000:385:b0:3a4:d0dc:184d with SMTP id ffacd0b85a97d-3b5f3578564mr728786f8f.27.1752212743669;
        Thu, 10 Jul 2025 22:45:43 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:657:c100:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd537c6fsm37310735e9.21.2025.07.10.22.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 22:45:43 -0700 (PDT)
Date: Fri, 11 Jul 2025 07:45:41 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: dimitri.fedrau@liebherr.com,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 2/2] hwmon: add support for MC33XS2410 hardware
 monitoring
Message-ID: <20250711054541.GA3276@legfed1>
References: <20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com>
 <20250708-mc33xs2410-hwmon-v4-2-95b9e3ea5f5c@liebherr.com>
 <4d041e33-4730-4baa-acd7-31597af3f338@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d041e33-4730-4baa-acd7-31597af3f338@roeck-us.net>

Hi Guenter,

thanks for the quicke review, will add the documentation in v5.

Best regards,
Dimitri Fedrau

Am Tue, Jul 08, 2025 at 09:21:19AM -0700 schrieb Guenter Roeck:
> On Tue, Jul 08, 2025 at 06:13:04PM +0200, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > The device is able to monitor temperature, voltage and current of each of
> > the four outputs. Add basic support for monitoring the temperature of the
> > four outputs and the die temperature.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> >  drivers/hwmon/Kconfig            |  10 +++
> >  drivers/hwmon/Makefile           |   1 +
> >  drivers/hwmon/mc33xs2410_hwmon.c | 179 +++++++++++++++++++++++++++++++++++++++
> 
> Code looks good, except the documentation is missing.
> Please add to Documentation/hwmon/.
> 
> Thanks,
> Guenter
> 
> >  3 files changed, 190 insertions(+)
> > 
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 079620dd42862ef5e026697e9e1b1fcd5b8be298..9d28fcf7cd2a6f9e2f54694a717bd85ff4047b46 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -700,6 +700,16 @@ config SENSORS_MC13783_ADC
> >          help
> >            Support for the A/D converter on MC13783 and MC13892 PMIC.
> >  
> > +config SENSORS_MC33XS2410
> > +	tristate "MC33XS2410 HWMON support"
> > +	depends on PWM_MC33XS2410
> > +	help
> > +	  If you say yes here you get hardware monitoring support for
> > +	  MC33XS2410.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called mc33xs2410_hwmon.
> > +
> >  config SENSORS_FSCHMD
> >  	tristate "Fujitsu Siemens Computers sensor chips"
> >  	depends on (X86 || COMPILE_TEST) && I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 48e5866c0c9a7677089d1001a9c5ae4adebff5d5..cd8bc4752b4dbf015c6eb46157626f4e8f87dfae 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -165,6 +165,7 @@ obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
> >  obj-$(CONFIG_MAX31827) += max31827.o
> >  obj-$(CONFIG_SENSORS_MAX77705) += max77705-hwmon.o
> >  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
> > +obj-$(CONFIG_SENSORS_MC33XS2410) += mc33xs2410_hwmon.o
> >  obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
> >  obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
> >  obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
> > diff --git a/drivers/hwmon/mc33xs2410_hwmon.c b/drivers/hwmon/mc33xs2410_hwmon.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..71a14932c6ccaf8d15b045b55093238d924160ea
> > --- /dev/null
> > +++ b/drivers/hwmon/mc33xs2410_hwmon.c
> > @@ -0,0 +1,179 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2025 Liebherr-Electronics and Drives GmbH
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/mc33xs2410.h>
> > +#include <linux/module.h>
> > +
> > +/* ctrl registers */
> > +
> > +#define MC33XS2410_TEMP_WT			0x29
> > +#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
> > +
> > +/* diag registers */
> > +
> > +/* chan in { 1 ... 4 } */
> > +#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
> > +#define MC33XS2410_OUT_STA_OTW			BIT(8)
> > +
> > +#define MC33XS2410_TS_TEMP_DIE			0x26
> > +#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)
> > +
> > +/* chan in { 1 ... 4 } */
> > +#define MC33XS2410_TS_TEMP(chan)		(0x2f + (chan) - 1)
> > +
> > +static const struct hwmon_channel_info * const mc33xs2410_hwmon_info[] = {
> > +	HWMON_CHANNEL_INFO(temp,
> > +			   HWMON_T_LABEL | HWMON_T_INPUT,
> > +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> > +			   HWMON_T_ALARM,
> > +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> > +			   HWMON_T_ALARM,
> > +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> > +			   HWMON_T_ALARM,
> > +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> > +			   HWMON_T_ALARM),
> > +	NULL,
> > +};
> > +
> > +static umode_t mc33xs2410_hwmon_is_visible(const void *data,
> > +					   enum hwmon_sensor_types type,
> > +					   u32 attr, int channel)
> > +{
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +	case hwmon_temp_alarm:
> > +	case hwmon_temp_label:
> > +		return 0444;
> > +	case hwmon_temp_max:
> > +		return 0644;
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> > +static int mc33xs2410_hwmon_read(struct device *dev,
> > +				 enum hwmon_sensor_types type,
> > +				 u32 attr, int channel, long *val)
> > +{
> > +	struct spi_device *spi = dev_get_drvdata(dev);
> > +	u16 reg_val;
> > +	int ret;
> > +	u8 reg;
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +		reg = (channel == 0) ? MC33XS2410_TS_TEMP_DIE :
> > +				       MC33XS2410_TS_TEMP(channel);
> > +		ret = mc33xs2410_read_reg_diag(spi, reg, &reg_val);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/* LSB is 0.25 degree celsius */
> > +		*val = FIELD_GET(MC33XS2410_TS_TEMP_MASK, reg_val) * 250 - 40000;
> > +		return 0;
> > +	case hwmon_temp_alarm:
> > +		ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel),
> > +					       &reg_val);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = FIELD_GET(MC33XS2410_OUT_STA_OTW, reg_val);
> > +		return 0;
> > +	case hwmon_temp_max:
> > +		ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_TEMP_WT, &reg_val);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/* LSB is 1 degree celsius */
> > +		*val = FIELD_GET(MC33XS2410_TEMP_WT_MASK, reg_val) * 1000 - 40000;
> > +		return 0;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int mc33xs2410_hwmon_write(struct device *dev,
> > +				  enum hwmon_sensor_types type, u32 attr,
> > +				  int channel, long val)
> > +{
> > +	struct spi_device *spi = dev_get_drvdata(dev);
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_max:
> > +		val = clamp_val(val, -40000, 215000);
> > +
> > +		/* LSB is 1 degree celsius */
> > +		val = (val / 1000) + 40;
> > +		return mc33xs2410_modify_reg(spi, MC33XS2410_TEMP_WT,
> > +					     MC33XS2410_TEMP_WT_MASK, val);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static const char *const mc33xs2410_temp_label[] = {
> > +	"Central die temperature",
> > +	"Channel 1 temperature",
> > +	"Channel 2 temperature",
> > +	"Channel 3 temperature",
> > +	"Channel 4 temperature",
> > +};
> > +
> > +static int mc33xs2410_read_string(struct device *dev,
> > +				  enum hwmon_sensor_types type,
> > +				  u32 attr, int channel, const char **str)
> > +{
> > +	*str = mc33xs2410_temp_label[channel];
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct hwmon_ops mc33xs2410_hwmon_hwmon_ops = {
> > +	.is_visible = mc33xs2410_hwmon_is_visible,
> > +	.read = mc33xs2410_hwmon_read,
> > +	.read_string = mc33xs2410_read_string,
> > +	.write = mc33xs2410_hwmon_write,
> > +};
> > +
> > +static const struct hwmon_chip_info mc33xs2410_hwmon_chip_info = {
> > +	.ops = &mc33xs2410_hwmon_hwmon_ops,
> > +	.info = mc33xs2410_hwmon_info,
> > +};
> > +
> > +static int mc33xs2410_hwmon_probe(struct auxiliary_device *adev,
> > +				  const struct auxiliary_device_id *id)
> > +{
> > +	struct device *dev = &adev->dev;
> > +	struct spi_device *spi = container_of(dev->parent, struct spi_device, dev);
> > +	struct device *hwmon;
> > +
> > +	hwmon = devm_hwmon_device_register_with_info(dev, NULL, spi,
> > +						     &mc33xs2410_hwmon_chip_info,
> > +						     NULL);
> > +	return PTR_ERR_OR_ZERO(hwmon);
> > +}
> > +
> > +static const struct auxiliary_device_id mc33xs2410_hwmon_ids[] = {
> > +	{
> > +		.name = "pwm_mc33xs2410.hwmon",
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(auxiliary, mc33xs2410_hwmon_ids);
> > +
> > +static struct auxiliary_driver mc33xs2410_hwmon_driver = {
> > +	.probe = mc33xs2410_hwmon_probe,
> > +	.id_table = mc33xs2410_hwmon_ids,
> > +};
> > +module_auxiliary_driver(mc33xs2410_hwmon_driver);
> > +
> > +MODULE_DESCRIPTION("NXP MC33XS2410 hwmon driver");
> > +MODULE_AUTHOR("Dimitri Fedrau <dimitri.fedrau@liebherr.com>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_IMPORT_NS("PWM_MC33XS2410");
> > 
> > -- 
> > 2.39.5
> > 
> > 
> > 

