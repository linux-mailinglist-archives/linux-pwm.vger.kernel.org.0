Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0CA614B71
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Nov 2022 14:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiKANPH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Nov 2022 09:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiKANPD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2022 09:15:03 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6641B9E3;
        Tue,  1 Nov 2022 06:14:59 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v81so7155097oie.5;
        Tue, 01 Nov 2022 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3VlahgZPry3IdZ8jTKpuTbzhBSV2xsDB4KjSBrCf7Y=;
        b=kKjGRndl4BncN+iRS0ABF6hPO2Bg+bAV7hMC4lkfXFs3dQa2w1BKLgoDHEghex4aYa
         24Nv5eH8rEw8kD8bQ4uMtpDgb6uO/erWGxBxLxq/TV1xQn4sWmzwi4zaqKn2SKV3o7b2
         h5CHVvaueEfow3PqX2qUfE6GFquWoH9b7kZvokWqSOK9IK3ao7JkcL4s3eIexOwrBWVB
         CrOD5DKttlspPQg//xxxEc8Gn39EzfG9GMFfaN2rILWkQPdJXBPmMmpBzvhch2n1HBDL
         4iEVlqL3hW+fnaiPwSbvMiteG6a6U1vaX5s0cpmfLfc29V75Sn+78bBjAM0PEDnv1HI4
         9X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3VlahgZPry3IdZ8jTKpuTbzhBSV2xsDB4KjSBrCf7Y=;
        b=e5X9tToJyU4yw6/jyTa1DI+tDwx0Y12smJEb8dz6giDP7WObZEWZIS0KG6jLtVWznp
         SNqzuvyYUm7eOeB5bwj9v9Zyqr8iqQHML5+oB0UcvmlwbZxSzjG2WVbCRd9ngh/QvIf0
         Q29E2uhH9dUI9DGssK7Oz+K8QMfyAYjFqMqGN9pDdkiy+xzHTkgYtUexCiADvrHlravu
         RKkEczFtpmUcr8NgY16kv/R4bBapylnU/+mqU3UbJGksVNGYsu8oByZ5gHyzUhLEE/C/
         Xf6++6OLAtiqW6d/BcI4Xke1OqHFROdXsJKAwEGunAJvvCEimZz9RhnRXOWO3JCnKw8L
         Jz7g==
X-Gm-Message-State: ACrzQf23eZv+2xYJapr0CHpS0Q5/JKL78ruVJ+Fj1X5aG4TgT/PQeHyA
        pkDX8aYTp5pecke9Ey+oIUE=
X-Google-Smtp-Source: AMsMyM5sw3f1NU66hIpRoH7a6Cf5DXCn0GANHce6RVGMjl8fmwqB7jkqFx0uQy+HXIWBStJXrVrUZw==
X-Received: by 2002:a05:6808:114a:b0:357:7649:d26f with SMTP id u10-20020a056808114a00b003577649d26fmr9643748oiu.111.1667308499080;
        Tue, 01 Nov 2022 06:14:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4-20020a4ab784000000b0044afc1ba91asm3391921oop.44.2022.11.01.06.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 06:14:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 1 Nov 2022 06:14:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, lee.jones@linaro.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com,
        garnermic@meta.com
Subject: Re: [v2 3/3] hwmon: Add Aspeed ast2600 TACH support
Message-ID: <20221101131456.GA1310110@roeck-us.net>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-4-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101095156.30591-4-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Nov 01, 2022 at 05:51:56PM +0800, Billy Tsai wrote:
> This patch add the support of Tachometer which can use to monitor the
> frequency of the input. The tach supports up to 16 channels and it's part
> function of multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  Documentation/hwmon/tach-aspeed-ast2600.rst |  28 ++

Also needs to be added to Documentation/hwmon/index.rst.

>  drivers/hwmon/Kconfig                       |   9 +
>  drivers/hwmon/Makefile                      |   1 +
>  drivers/hwmon/tach-aspeed-ast2600.c         | 484 ++++++++++++++++++++
>  4 files changed, 522 insertions(+)
>  create mode 100644 Documentation/hwmon/tach-aspeed-ast2600.rst
>  create mode 100644 drivers/hwmon/tach-aspeed-ast2600.c
> 
> diff --git a/Documentation/hwmon/tach-aspeed-ast2600.rst b/Documentation/hwmon/tach-aspeed-ast2600.rst
> new file mode 100644
> index 000000000000..8967f60672dc
> --- /dev/null
> +++ b/Documentation/hwmon/tach-aspeed-ast2600.rst
> @@ -0,0 +1,28 @@
> +Kernel driver tach-aspeed-ast2600
> +==============================
> +
> +Supported chips:
> +	ASPEED AST2600
> +
> +Authors:
> +	<billy_tsai@aspeedtech.com>
> +
> +Description:
> +------------
> +This driver implements support for ASPEED AST2600 Fan Tacho controller.
> +The controller supports up to 16 tachometer inputs.
> +
> +The driver provides the following sensor accesses in sysfs:
> +=============== ======= =====================================================
> +fanX_input	ro	provide current fan rotation value in RPM as reported
> +			by the fan to the device.
> +fanX_div	rw	Fan divisor: Supported value are power of 4 (1, 4, 16
> +                        64, ... 4194304)
> +                        The larger divisor, the less rpm accuracy and the less
> +                        affected by fan signal glitch.
> +fanX_min	rw      Fan minimum RPM which can used to change the timeout
> +                        value for controller polling the result.
> +fanX_max	rw      Fan maximum RPM which can used to change the polling
> +                        period of the driver.
> +fanX_pulses	rw      Fan pulses per resolution.
> +=============== ======= ======================================================
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index fa2356398744..a84c15b73aa6 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -397,6 +397,15 @@ config SENSORS_ASPEED
>  	  This driver can also be built as a module. If so, the module
>  	  will be called aspeed_pwm_tacho.
>  
> +config SENSORS_TACH_ASPEED_AST2600
> +	tristate "ASPEED ast2600 Tachometer support"
> +	select REGMAP
> +	help
> +	  This driver provides support for Aspeed ast2600 Tachometer.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called tach-aspeed-ast2600.
> +
>  config SENSORS_ATXP1
>  	tristate "Attansic ATXP1 VID controller"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index d2497b2644e6..7e2d708e93b8 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
>  obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
>  obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
>  obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
> +obj-$(CONFIG_SENSORS_TACH_ASPEED_AST2600) += tach-aspeed-ast2600.o
>  obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
>  obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
>  obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
> diff --git a/drivers/hwmon/tach-aspeed-ast2600.c b/drivers/hwmon/tach-aspeed-ast2600.c
> new file mode 100644
> index 000000000000..599ed5db17a8
> --- /dev/null
> +++ b/drivers/hwmon/tach-aspeed-ast2600.c
> @@ -0,0 +1,484 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) ASPEED Technology Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

Not needed. Please check if there are other unnecessary includes.

> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/sysfs.h>
> +#include <linux/reset.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>

Please order include files in alphabetic order.

> +
> +/* The channel number of Aspeed tach controller */
> +#define TACH_ASPEED_NR_TACHS 16

#define<space>NAME<tab>value, please, and align the value.

> +/* TACH Control Register */
> +#define TACH_ASPEED_CTRL(ch) (((ch) * 0x10) + 0x08)
> +#define TACH_ASPEED_IER BIT(31)
> +#define TACH_ASPEED_INVERS_LIMIT BIT(30)
> +#define TACH_ASPEED_LOOPBACK BIT(29)
> +#define TACH_ASPEED_ENABLE BIT(28)
> +#define TACH_ASPEED_DEBOUNCE_MASK GENMASK(27, 26)
> +#define TACH_ASPEED_DEBOUNCE_BIT (26)

() around plain integers is not needed.

> +#define TACH_ASPEED_IO_EDGE_MASK GENMASK(25, 24)
> +#define TACH_ASPEED_IO_EDGE_BIT (24)
> +#define TACH_ASPEED_CLK_DIV_T_MASK GENMASK(23, 20)
> +#define TACH_ASPEED_CLK_DIV_BIT (20)
> +#define TACH_ASPEED_THRESHOLD_MASK GENMASK(19, 0)
> +/* [27:26] */
> +#define DEBOUNCE_3_CLK 0x00
> +#define DEBOUNCE_2_CLK 0x01
> +#define DEBOUNCE_1_CLK 0x02
> +#define DEBOUNCE_0_CLK 0x03
> +/* [25:24] */
> +#define F2F_EDGES 0x00
> +#define R2R_EDGES 0x01
> +#define BOTH_EDGES 0x02
> +/* [23:20] */
> +/* divisor = 4 to the nth power, n = register value */
> +#define DEFAULT_TACH_DIV 1024
> +#define DIV_TO_REG(divisor) (ilog2(divisor) >> 1)
> +
> +/* TACH Status Register */
> +#define TACH_ASPEED_STS(ch) (((ch) * 0x10) + 0x0C)
> +
> +/*PWM_TACH_STS */
> +#define TACH_ASPEED_ISR BIT(31)
> +#define TACH_ASPEED_PWM_OUT BIT(25)
> +#define TACH_ASPEED_PWM_OEN BIT(24)
> +#define TACH_ASPEED_DEB_INPUT BIT(23)
> +#define TACH_ASPEED_RAW_INPUT BIT(22)
> +#define TACH_ASPEED_VALUE_UPDATE BIT(21)
> +#define TACH_ASPEED_FULL_MEASUREMENT BIT(20)
> +#define TACH_ASPEED_VALUE_MASK GENMASK(19, 0)
> +/**********************************************************
> + * Software setting
> + *********************************************************/
> +#define DEFAULT_FAN_MIN_RPM 1000
> +#define DEFAULT_FAN_PULSE_PR 2
> +/*
> + * Add this value to avoid CPU consuming a lot of resources in waiting rpm
> + * updating. Assume the max rpm of fan is 60000, the fastest period of updating
> + * tach value will be equal to (1000000 * 2 * 60) / (2 * max_rpm) = 1000us.
> + */
> +#define DEFAULT_FAN_MAX_RPM 60000
> +
> +struct aspeed_tach_channel_params {
> +	int limited_inverse;
> +	u16 threshold;
> +	u8 tach_edge;
> +	u8 tach_debounce;
> +	u8 pulse_pr;
> +	u32 min_rpm;
> +	u32 max_rpm;
> +	u32 divisor;
> +	u32 sample_period; /* unit is us */
> +	u32 polling_period; /* unit is us */
> +};
> +
> +struct aspeed_tach_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct clk *clk;
> +	struct reset_control *reset;
> +	bool tach_present[TACH_ASPEED_NR_TACHS];
> +	struct aspeed_tach_channel_params *tach_channel;
> +};
> +
> +static void aspeed_update_tach_sample_period(struct aspeed_tach_data *priv,
> +					     u8 fan_tach_ch)
> +{
> +	u32 tach_period_us;
> +	u8 pulse_pr = priv->tach_channel[fan_tach_ch].pulse_pr;
> +	u32 min_rpm = priv->tach_channel[fan_tach_ch].min_rpm;
> +
> +	/*
> +	 * min(Tach input clock) = (PulsePR * minRPM) / 60
> +	 * max(Tach input period) = 60 / (PulsePR * minRPM)
> +	 * Tach sample period > 2 * max(Tach input period) = (2*60) / (PulsePR * minRPM)
> +	 */
> +	tach_period_us = (USEC_PER_SEC * 2 * 60) / (pulse_pr * min_rpm);
> +	/* Add the margin (about 1.5) of tach sample period to avoid sample miss */
> +	tach_period_us = (tach_period_us * 1500) >> 10;
> +	dev_dbg(priv->dev, "tach%d sample period = %dus", fan_tach_ch, tach_period_us);
> +	priv->tach_channel[fan_tach_ch].sample_period = tach_period_us;
> +}
> +
> +static void aspeed_update_tach_polling_period(struct aspeed_tach_data *priv,
> +					     u8 fan_tach_ch)
> +{
> +	u32 tach_period_us;
> +	u8 pulse_pr = priv->tach_channel[fan_tach_ch].pulse_pr;
> +	u32 max_rpm = priv->tach_channel[fan_tach_ch].max_rpm;
> +
> +	tach_period_us = (USEC_PER_SEC * 2 * 60) / (pulse_pr * max_rpm);
> +	dev_dbg(priv->dev, "tach%d polling period = %dus", fan_tach_ch, tach_period_us);
> +	priv->tach_channel[fan_tach_ch].polling_period = tach_period_us;
> +}
> +
> +static void aspeed_tach_ch_enable(struct aspeed_tach_data *priv, u8 tach_ch,
> +				  bool enable)
> +{
> +	if (enable)
> +		regmap_set_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
> +				TACH_ASPEED_ENABLE);
> +	else
> +		regmap_clear_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
> +				   TACH_ASPEED_ENABLE);
> +}
> +
> +static int aspeed_get_fan_tach_ch_rpm(struct aspeed_tach_data *priv,
> +				      u8 fan_tach_ch)
> +{
> +	u32 raw_data, tach_div, val;
> +	unsigned long clk_source;
> +	u64 rpm;
> +	int ret;
> +
> +	/* Restart the Tach channel to guarantee the value is fresh */
> +	aspeed_tach_ch_enable(priv, fan_tach_ch, false);
> +	aspeed_tach_ch_enable(priv, fan_tach_ch, true);

Is that really needed ? Doesn't the controller measure values continuously ?

> +	ret = regmap_read_poll_timeout(
> +		priv->regmap, TACH_ASPEED_STS(fan_tach_ch), val,
> +		(val & TACH_ASPEED_FULL_MEASUREMENT) &&
> +			(val & TACH_ASPEED_VALUE_UPDATE),
> +		priv->tach_channel[fan_tach_ch].polling_period,
> +		priv->tach_channel[fan_tach_ch].sample_period);

Please fix multi-line alignment everywhere. Go up to 100 columns if needed.

> +
> +	if (ret) {
> +		/* return 0 if we didn't get an answer because of timeout*/
> +		if (ret == -ETIMEDOUT)
> +			return 0;
> +		else
> +			return ret;

else after return is unnecessary, and why would a timeout be be ignored ?

> +	}
> +
> +	raw_data = val & TACH_ASPEED_VALUE_MASK;
> +	/*
> +	 * We need the mode to determine if the raw_data is double (from
> +	 * counting both edges).
> +	 */
> +	if (priv->tach_channel[fan_tach_ch].tach_edge == BOTH_EDGES)
> +		raw_data <<= 1;
> +
> +	tach_div = raw_data * (priv->tach_channel[fan_tach_ch].divisor) *
> +		   (priv->tach_channel[fan_tach_ch].pulse_pr);
> +
> +	clk_source = clk_get_rate(priv->clk);
> +	dev_dbg(priv->dev, "clk %ld, raw_data %d , tach_div %d\n", clk_source,
> +		raw_data, tach_div);
> +
> +	if (tach_div == 0)
> +		return -EDOM;

If the fan is off or not connected, would that return an error ?
If so, that would be inappropriate; it should return a speed
of 0 in that case.

> +
> +	rpm = (u64)clk_source * 60;
> +	do_div(rpm, tach_div);
> +
> +	return rpm;
> +}
> +
> +static int aspeed_tach_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			int channel, long *val)
> +{
> +	struct aspeed_tach_data *priv = dev_get_drvdata(dev);
> +	u32 reg_val;
> +	int ret;
> +
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		ret = aspeed_get_fan_tach_ch_rpm(priv, channel);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		break;
> +	case hwmon_fan_min:
> +		*val = priv->tach_channel[channel].min_rpm;
> +		break;
> +	case hwmon_fan_max:
> +		*val = priv->tach_channel[channel].max_rpm;
> +		break;
> +	case hwmon_fan_div:
> +		regmap_read(priv->regmap, TACH_ASPEED_CTRL(channel), &reg_val);
> +		reg_val = FIELD_GET(TACH_ASPEED_CLK_DIV_T_MASK, reg_val);
> +		*val = 1 << (reg_val << 1);

BIT() ?

> +		break;
> +	case hwmon_fan_pulses:
> +		*val = priv->tach_channel[channel].pulse_pr;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	return 0;
> +}
> +
> +static int aspeed_tach_hwmon_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			 int channel, long val)
> +{
> +	struct aspeed_tach_data *priv = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_fan_min:
> +		priv->tach_channel[channel].min_rpm = val;
> +		aspeed_update_tach_sample_period(priv, channel);
> +		break;
> +	case hwmon_fan_max:
> +		priv->tach_channel[channel].max_rpm = val;
> +		aspeed_update_tach_polling_period(priv, channel);
> +		break;
> +	case hwmon_fan_div:
> +		if ((is_power_of_2(val) && !(ilog2(val) % 2))) {
> +			priv->tach_channel[channel].divisor = val;
> +			regmap_write_bits(
> +				priv->regmap, TACH_ASPEED_CTRL(channel),
> +				TACH_ASPEED_CLK_DIV_T_MASK,
> +				DIV_TO_REG(priv->tach_channel[channel].divisor)
> +					<< TACH_ASPEED_CLK_DIV_BIT);
> +		} else {
> +			dev_err(dev,
> +				"fan_div value %ld not supported. Only support power of 4\n",
> +				val);
> +			return -EINVAL;
> +		}

Error case should be handled first, making else unnecessary.

> +		break;
> +	case hwmon_fan_pulses:
> +		priv->tach_channel[channel].pulse_pr = val;
> +		aspeed_update_tach_sample_period(priv, channel);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static umode_t aspeed_tach_dev_is_visible(const void *drvdata, enum hwmon_sensor_types type,
> +				  u32 attr, int channel)
> +{
> +	const struct aspeed_tach_data *priv = drvdata;
> +
> +	if (!priv->tach_present[channel])
> +		return 0;
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		return 0444;
> +	case hwmon_fan_min:
> +	case hwmon_fan_max:
> +	case hwmon_fan_div:
> +	case hwmon_fan_pulses:
> +		return 0644;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_ops aspeed_tach_ops = {
> +	.is_visible = aspeed_tach_dev_is_visible,
> +	.read = aspeed_tach_hwmon_read,
> +	.write = aspeed_tach_hwmon_write,
> +};
> +
> +static const struct hwmon_channel_info *aspeed_tach_info[] = {
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES,
> +			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
> +				   HWMON_F_DIV | HWMON_F_PULSES),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info aspeed_tach_chip_info = {
> +	.ops = &aspeed_tach_ops,
> +	.info = aspeed_tach_info,
> +};
> +
> +static void aspeed_create_fan_tach_channel(struct aspeed_tach_data *priv,
> +					   u32 tach_ch)
> +{
> +	priv->tach_present[tach_ch] = true;
> +	priv->tach_channel[tach_ch].limited_inverse = 0;
> +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
> +			  TACH_ASPEED_INVERS_LIMIT,
> +			  priv->tach_channel[tach_ch].limited_inverse ?
> +				  TACH_ASPEED_INVERS_LIMIT :
> +				  0);
> +
> +	priv->tach_channel[tach_ch].tach_debounce = DEBOUNCE_3_CLK;
> +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
> +			  TACH_ASPEED_DEBOUNCE_MASK,
> +			  priv->tach_channel[tach_ch].tach_debounce
> +				  << TACH_ASPEED_DEBOUNCE_BIT);
> +
> +	priv->tach_channel[tach_ch].tach_edge = F2F_EDGES;
> +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
> +			  TACH_ASPEED_IO_EDGE_MASK,
> +			  priv->tach_channel[tach_ch].tach_edge
> +				  << TACH_ASPEED_IO_EDGE_BIT);
> +
> +	priv->tach_channel[tach_ch].divisor = DEFAULT_TACH_DIV;
> +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
> +			  TACH_ASPEED_CLK_DIV_T_MASK,
> +			  DIV_TO_REG(priv->tach_channel[tach_ch].divisor)
> +				  << TACH_ASPEED_CLK_DIV_BIT);
> +
> +	priv->tach_channel[tach_ch].threshold = 0;
> +	regmap_write_bits(priv->regmap, TACH_ASPEED_CTRL(tach_ch),
> +			  TACH_ASPEED_THRESHOLD_MASK,
> +			  priv->tach_channel[tach_ch].threshold);
> +
> +	priv->tach_channel[tach_ch].pulse_pr = DEFAULT_FAN_PULSE_PR;
> +	priv->tach_channel[tach_ch].min_rpm = DEFAULT_FAN_MIN_RPM;
> +	aspeed_update_tach_sample_period(priv, tach_ch);
> +
> +	priv->tach_channel[tach_ch].max_rpm = DEFAULT_FAN_MAX_RPM;
> +	aspeed_update_tach_polling_period(priv, tach_ch);
> +
> +	aspeed_tach_ch_enable(priv, tach_ch, true);
> +}
> +
> +static int aspeed_tach_create_fan(struct device *dev, struct device_node *child,
> +				  struct aspeed_tach_data *priv)
> +{
> +	u32 tach_channel;
> +	int ret;
> +
> +	ret = of_property_read_u32(child, "reg", &tach_channel);
> +	if (ret)
> +		return ret;
> +
> +	aspeed_create_fan_tach_channel(priv, tach_channel);
> +
> +	return 0;
> +}
> +
> +static void aspeed_tach_reset_assert(void *data)
> +{
> +	struct reset_control *rst = data;
> +
> +	reset_control_assert(rst);
> +}
> +
> +static int aspeed_tach_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np, *child;
> +	struct aspeed_tach_data *priv;
> +	struct device *hwmon;
> +	struct platform_device *parent_dev;
> +	int ret;
> +
> +	np = dev->parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unsupported tach device binding\n");
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	priv->tach_channel =
> +		devm_kzalloc(dev,
> +			     TACH_ASPEED_NR_TACHS * sizeof(*priv->tach_channel),
> +			     GFP_KERNEL);
> +
> +	priv->regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap)) {
> +		dev_err(priv->dev, "Couldn't get regmap\n");
> +		return -ENODEV;

Why replace the reported error ?

> +	}
> +	parent_dev = of_find_device_by_node(np);
> +	priv->clk = devm_clk_get_enabled(&parent_dev->dev, 0);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");
> +
> +	priv->reset = devm_reset_control_get_shared(&parent_dev->dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(dev, PTR_ERR(priv->reset),
> +				     "Couldn't get reset control\n");
> +
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Couldn't deassert reset control\n");
> +
> +	ret = devm_add_action_or_reset(dev, aspeed_tach_reset_assert,
> +				       priv->reset);
> +	if (ret)
> +		return ret;
> +
> +	for_each_child_of_node(dev->of_node, child) {
> +		ret = aspeed_tach_create_fan(dev, child, priv);
> +		if (ret) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}
> +
> +	hwmon = devm_hwmon_device_register_with_info(
> +		dev, "aspeed_tach", priv, &aspeed_tach_chip_info, NULL);

Please watch out for multi-line alignment (checkpatch --strict); go up to 100
columns if needed.

> +	ret = PTR_ERR_OR_ZERO(hwmon);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register hwmon device\n");
> +	return 0;
> +}
> +
> +static const struct of_device_id of_stach_match_table[] = {
> +	{
> +		.compatible = "aspeed,ast2600-tach",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_stach_match_table);
> +
> +static struct platform_driver aspeed_tach_driver = {
> +	.probe		= aspeed_tach_probe,
> +	.driver		= {
> +		.name	= "aspeed_tach",
> +		.of_match_table = of_stach_match_table,
> +	},
> +};
> +
> +module_platform_driver(aspeed_tach_driver);
> +
> +MODULE_AUTHOR("Billy Tsai <billy_tsai@aspeedtech.com>");
> +MODULE_DESCRIPTION("Aspeed ast2600 TACH device driver");
> +MODULE_LICENSE("GPL v2");
> +
> -- 
> 2.25.1
> 
