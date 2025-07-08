Return-Path: <linux-pwm+bounces-6774-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8DFAFD080
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B797816F0D1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35362E427D;
	Tue,  8 Jul 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUuLC44H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E882E266B;
	Tue,  8 Jul 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991684; cv=none; b=ewOlPRVk8P/WJlgs15QhyFbkOL3KqZ/ISOqZKXw3iuNIso8EfelTDFyFnO4ny3aAFlYRx/RuxZmGVLwonxcgQwL1F1849u/Gu5m5yJMA1zle4hAegMjFTxsOv9W842V91ZQed+a7Vci/gaWYMKMXaCe8jzbDvp4C0F8XDrqEpxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991684; c=relaxed/simple;
	bh=HpNObRKadWhSrebSF2cNSeXZlCFLar8vNDkH+4A64eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTJqByIJ/1Q/y4VOG058PS9wtGGq9jV9k2iGLm/tmjuJKxbQGcBp2qcIxnKYJsO2cQD9TgvbUH9qGnObbCjeH+dwd9tu+magvzjdJdzunaM94pFuv6YGYCysfqpkLLvM1lVHUGAsnhoy0AZrhK9ttkrHOz43I/5xptKCZS1fau0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUuLC44H; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so4421879a91.1;
        Tue, 08 Jul 2025 09:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751991682; x=1752596482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ay4uaTIVCOrHIsqJ4O/qAhgscjxCRVBq5gxdDz2Jfc=;
        b=gUuLC44Hc316Q3+2I79mv60ibx5roqVSV/vYIysvOBrTaR1jJqcL7qVzxrmA4MFcac
         CDwOl8bcgHIa8RrnDbvHuMRHHFVi+o5ljFf9X1znxzuXtmYlZi7mhFakNcDH6fzcP3Pk
         FVHkBa9vKGBGfMVpZ7VuVOeJblmhiCE8uubDTLT0vCiAvzCVRtpBTO5gO4Go79Ysjed+
         ZyOCHmZedkDaIGrS4qRwW/Gl1c+r1ZK8gMVT9k7CEpjV+snd30J3tCOqW8KE/usoj1Ii
         SzZErxhoW6hPtII2uYChWA2KUmsKYrBy5HCajdNFmv4zgENWFiMfNXnGAGi/G5/p1Qz+
         dRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751991682; x=1752596482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ay4uaTIVCOrHIsqJ4O/qAhgscjxCRVBq5gxdDz2Jfc=;
        b=oZdvF12YC95Sb1OGpY82vG4irUNfBatr4Nq/7lVdiNBX7bURBoBg4piepPEGX7pU5t
         OOcEJsIuQwxRcgECYahaVPqvl0ttew1D6EIiwxr0PPMGJWoNlEMsnNzcpcyMHHeRh5Qd
         zzg+MqtihadNDL51oVir4N5l9C1uiA6MLD3FEhADFTSIw3EWbOuWKePpIBaKRwHtPeD+
         lCf2M/ntw0AgeZauTo1fi3qgXfLsriasOvgA5hgpWzfsXwlobaOWmswvEdjCKgwg/rBp
         ndCWIliuhU/LD6pQlU66tGbYELGmKXh52OExIrmAMcqSuilXn2VnXuZm6WxkiuksPfqG
         2q2w==
X-Forwarded-Encrypted: i=1; AJvYcCU+KiaLLad6JXBHXFDPbHydTsNiA6B2YkpVl1aEQ6DwfocGGC1r8kzkXtPH+eGsfoLNXZpxYie3iqO35w==@vger.kernel.org, AJvYcCXawGZmAXCkofdYzY65P76ZVKi5aLn03YOyHivPhphcNK6jbvk3TKnXu+v9xe+g4U12+8VuT9r19/ir@vger.kernel.org, AJvYcCXkXosNVQ6muV+tY+UcdSIUN4htzZqGPu56z39AKYYq/7pQGplXRguCrANo4+JvTp1NxiNw/33T7RZlCUyx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wemQcpHEbItCyyStVHFmPwdnRWMCwcEIbmUB8bmU1fSkQTSh
	dNx4QP/MO0uR7rsvGhAPiT0OSAN4BImpGVn08n2iWBD9zkHuTIxP9N1/
X-Gm-Gg: ASbGncs3JDxStA2QyDsoU0Dkw25lwR+stMg7dOpUw+MI7Wy8nwoeFurCz0u+cKK3QLf
	boAZALa1H5hfstUzT9TQRFUuhN7yXsRhqEMTfJWEd9gURtOISzJBp8jXI/ULNBB0yeV7UbJcjVZ
	vktde8N0V6NE0XIqzOERUC8Zd9RfPhWclNSTZWP5Xv6sjZrvaD3iKQQ5gw9kTg+otqNx9Y2Ti43
	KgughUMXHjE2vBARNGHxQkHoropg7nc5KCSqKlOLzEag6aG1u+Fm7t5U0+J0fVM9YPKEQGlBwaL
	1YAV5rVce7foasmrs7Sqgtv9ft5+3B0Yjjc6F29I/d+xUpPah88aOjRdmRIeWm1PwY77ZbL6t+4
	=
X-Google-Smtp-Source: AGHT+IFRc6ZrOprHZvt7Dpdkq9y6tl30nltp/+5QTxZO0d92bleTR4jJJCeDI8CVUAhTVuTbjLr+1g==
X-Received: by 2002:a17:90b:3dd0:b0:312:db8f:9a09 with SMTP id 98e67ed59e1d1-31c2df1df70mr599003a91.14.1751991681641;
        Tue, 08 Jul 2025 09:21:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c220a8389sm2473569a91.36.2025.07.08.09.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:21:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 8 Jul 2025 09:21:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: dimitri.fedrau@liebherr.com
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v4 2/2] hwmon: add support for MC33XS2410 hardware
 monitoring
Message-ID: <4d041e33-4730-4baa-acd7-31597af3f338@roeck-us.net>
References: <20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com>
 <20250708-mc33xs2410-hwmon-v4-2-95b9e3ea5f5c@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-mc33xs2410-hwmon-v4-2-95b9e3ea5f5c@liebherr.com>

On Tue, Jul 08, 2025 at 06:13:04PM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> The device is able to monitor temperature, voltage and current of each of
> the four outputs. Add basic support for monitoring the temperature of the
> four outputs and the die temperature.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  drivers/hwmon/Kconfig            |  10 +++
>  drivers/hwmon/Makefile           |   1 +
>  drivers/hwmon/mc33xs2410_hwmon.c | 179 +++++++++++++++++++++++++++++++++++++++

Code looks good, except the documentation is missing.
Please add to Documentation/hwmon/.

Thanks,
Guenter

>  3 files changed, 190 insertions(+)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 079620dd42862ef5e026697e9e1b1fcd5b8be298..9d28fcf7cd2a6f9e2f54694a717bd85ff4047b46 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -700,6 +700,16 @@ config SENSORS_MC13783_ADC
>          help
>            Support for the A/D converter on MC13783 and MC13892 PMIC.
>  
> +config SENSORS_MC33XS2410
> +	tristate "MC33XS2410 HWMON support"
> +	depends on PWM_MC33XS2410
> +	help
> +	  If you say yes here you get hardware monitoring support for
> +	  MC33XS2410.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called mc33xs2410_hwmon.
> +
>  config SENSORS_FSCHMD
>  	tristate "Fujitsu Siemens Computers sensor chips"
>  	depends on (X86 || COMPILE_TEST) && I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 48e5866c0c9a7677089d1001a9c5ae4adebff5d5..cd8bc4752b4dbf015c6eb46157626f4e8f87dfae 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -165,6 +165,7 @@ obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
>  obj-$(CONFIG_MAX31827) += max31827.o
>  obj-$(CONFIG_SENSORS_MAX77705) += max77705-hwmon.o
>  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
> +obj-$(CONFIG_SENSORS_MC33XS2410) += mc33xs2410_hwmon.o
>  obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
>  obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
>  obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
> diff --git a/drivers/hwmon/mc33xs2410_hwmon.c b/drivers/hwmon/mc33xs2410_hwmon.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..71a14932c6ccaf8d15b045b55093238d924160ea
> --- /dev/null
> +++ b/drivers/hwmon/mc33xs2410_hwmon.c
> @@ -0,0 +1,179 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Liebherr-Electronics and Drives GmbH
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/hwmon.h>
> +#include <linux/mc33xs2410.h>
> +#include <linux/module.h>
> +
> +/* ctrl registers */
> +
> +#define MC33XS2410_TEMP_WT			0x29
> +#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
> +
> +/* diag registers */
> +
> +/* chan in { 1 ... 4 } */
> +#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
> +#define MC33XS2410_OUT_STA_OTW			BIT(8)
> +
> +#define MC33XS2410_TS_TEMP_DIE			0x26
> +#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)
> +
> +/* chan in { 1 ... 4 } */
> +#define MC33XS2410_TS_TEMP(chan)		(0x2f + (chan) - 1)
> +
> +static const struct hwmon_channel_info * const mc33xs2410_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_LABEL | HWMON_T_INPUT,
> +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> +			   HWMON_T_ALARM,
> +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> +			   HWMON_T_ALARM,
> +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> +			   HWMON_T_ALARM,
> +			   HWMON_T_LABEL | HWMON_T_INPUT | HWMON_T_MAX |
> +			   HWMON_T_ALARM),
> +	NULL,
> +};
> +
> +static umode_t mc33xs2410_hwmon_is_visible(const void *data,
> +					   enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_alarm:
> +	case hwmon_temp_label:
> +		return 0444;
> +	case hwmon_temp_max:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int mc33xs2410_hwmon_read(struct device *dev,
> +				 enum hwmon_sensor_types type,
> +				 u32 attr, int channel, long *val)
> +{
> +	struct spi_device *spi = dev_get_drvdata(dev);
> +	u16 reg_val;
> +	int ret;
> +	u8 reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		reg = (channel == 0) ? MC33XS2410_TS_TEMP_DIE :
> +				       MC33XS2410_TS_TEMP(channel);
> +		ret = mc33xs2410_read_reg_diag(spi, reg, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* LSB is 0.25 degree celsius */
> +		*val = FIELD_GET(MC33XS2410_TS_TEMP_MASK, reg_val) * 250 - 40000;
> +		return 0;
> +	case hwmon_temp_alarm:
> +		ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel),
> +					       &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = FIELD_GET(MC33XS2410_OUT_STA_OTW, reg_val);
> +		return 0;
> +	case hwmon_temp_max:
> +		ret = mc33xs2410_read_reg_ctrl(spi, MC33XS2410_TEMP_WT, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* LSB is 1 degree celsius */
> +		*val = FIELD_GET(MC33XS2410_TEMP_WT_MASK, reg_val) * 1000 - 40000;
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int mc33xs2410_hwmon_write(struct device *dev,
> +				  enum hwmon_sensor_types type, u32 attr,
> +				  int channel, long val)
> +{
> +	struct spi_device *spi = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		val = clamp_val(val, -40000, 215000);
> +
> +		/* LSB is 1 degree celsius */
> +		val = (val / 1000) + 40;
> +		return mc33xs2410_modify_reg(spi, MC33XS2410_TEMP_WT,
> +					     MC33XS2410_TEMP_WT_MASK, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const char *const mc33xs2410_temp_label[] = {
> +	"Central die temperature",
> +	"Channel 1 temperature",
> +	"Channel 2 temperature",
> +	"Channel 3 temperature",
> +	"Channel 4 temperature",
> +};
> +
> +static int mc33xs2410_read_string(struct device *dev,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int channel, const char **str)
> +{
> +	*str = mc33xs2410_temp_label[channel];
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops mc33xs2410_hwmon_hwmon_ops = {
> +	.is_visible = mc33xs2410_hwmon_is_visible,
> +	.read = mc33xs2410_hwmon_read,
> +	.read_string = mc33xs2410_read_string,
> +	.write = mc33xs2410_hwmon_write,
> +};
> +
> +static const struct hwmon_chip_info mc33xs2410_hwmon_chip_info = {
> +	.ops = &mc33xs2410_hwmon_hwmon_ops,
> +	.info = mc33xs2410_hwmon_info,
> +};
> +
> +static int mc33xs2410_hwmon_probe(struct auxiliary_device *adev,
> +				  const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &adev->dev;
> +	struct spi_device *spi = container_of(dev->parent, struct spi_device, dev);
> +	struct device *hwmon;
> +
> +	hwmon = devm_hwmon_device_register_with_info(dev, NULL, spi,
> +						     &mc33xs2410_hwmon_chip_info,
> +						     NULL);
> +	return PTR_ERR_OR_ZERO(hwmon);
> +}
> +
> +static const struct auxiliary_device_id mc33xs2410_hwmon_ids[] = {
> +	{
> +		.name = "pwm_mc33xs2410.hwmon",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, mc33xs2410_hwmon_ids);
> +
> +static struct auxiliary_driver mc33xs2410_hwmon_driver = {
> +	.probe = mc33xs2410_hwmon_probe,
> +	.id_table = mc33xs2410_hwmon_ids,
> +};
> +module_auxiliary_driver(mc33xs2410_hwmon_driver);
> +
> +MODULE_DESCRIPTION("NXP MC33XS2410 hwmon driver");
> +MODULE_AUTHOR("Dimitri Fedrau <dimitri.fedrau@liebherr.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("PWM_MC33XS2410");
> 
> -- 
> 2.39.5
> 
> 
> 

