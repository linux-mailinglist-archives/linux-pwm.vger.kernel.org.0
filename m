Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7401F1A82
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 16:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgFHODH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbgFHODG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 10:03:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A1C08C5C2;
        Mon,  8 Jun 2020 07:03:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 64so1729983pfv.11;
        Mon, 08 Jun 2020 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+aQr4ltOBPgKWPYRtoONQ31Skv5eKmrxH9APXpc3gmc=;
        b=PORZ4wRgIlEuiisqZclMQuFXS7n+0u1TLevCyGi6DTbqoddFlz8jskYRf+2tBj3FuQ
         R+7tDFZNs2kA2TMHlAEpIoUs1/2ygjM4uyunQqNAxZCoiTdBi1PAdw+uU6lXpLbq+eVH
         Gk5ff3T/8NhAIQVROOCFuojkYpXOyE/1s+Uu6qZdN54x9z+8X3RHUVmSFLJ2pmPJTsRV
         5c9Ef7P3EVD9Q8wn2EzBqTDzo9NkreYBxjIezsUpteK4GhACzCPhYAKnACWiiZ5Xs/59
         39QUAyroKTe+H1X+fCV30k4au+WAr/uK6cfl519oRBhVkgXkD+LzlNw7JRP0q0IenXPk
         m49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+aQr4ltOBPgKWPYRtoONQ31Skv5eKmrxH9APXpc3gmc=;
        b=Boax2Co2l3YSc25y1J5p5c7je/FoTp79/DjwBkcBvFEHhe8hmN+Ns2b8uzNqmF9hRw
         hfuM6BgByOwPZ7HgTQFIQPmKRuRTc/vv7XixTrpI4eSBrDAqM/ToU5oxEmb9K9PzsWjb
         piPHIT0vQagV+uZ9z/7lYO6UlR+9h5mussk0LdmJUfciRC+Sse637BheQSVem9nQLokd
         Ijr5udtJldHzksUa8McApozTsRyxt9QxhHqJUhE78Xrri6meZJvSC9eFrRJzUyM3zQoo
         v/8aeAKNhFavlz2m5TOQceDKS3CyeGNxQtLX31lepbD32NK9e3yOvkkcrHP+EcyklUKk
         EgTQ==
X-Gm-Message-State: AOAM532M23Y/CqkvqQjQyC294nIteR+zxzgZoEdo6FyADRBqPHrS1pzl
        Jhx5aTsBV8elTBec8zUoU0Gw/5dJ
X-Google-Smtp-Source: ABdhPJwhD2uJLh5WXEKuGH5jDp3/C1nJu6/p5/1VMItlVIkNarKsam+vOmUmBsWLqN4e+m8oXeI2RA==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr20316405pgp.146.1591624986092;
        Mon, 08 Jun 2020 07:03:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ca6sm15135207pjb.46.2020.06.08.07.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 07:03:04 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: Add SFR NB6 sensor driver
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        jdelvare@suse.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20200607182524.3221837-1-noltari@gmail.com>
 <20200607182524.3221837-3-noltari@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b7d278a2-df5c-5d56-7829-b6ed798b2bdf@roeck-us.net>
Date:   Mon, 8 Jun 2020 07:03:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200607182524.3221837-3-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 6/7/20 11:25 AM, Álvaro Fernández Rojas wrote:
> SFR NeufBox 6 is equipped with an I2C connected chip to monitor voltage,
> temperature and other stats. It also has a PWM LEDs that can be manually
> controlled or set to specific hardware monitoring modes.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  drivers/hwmon/Kconfig     |  11 +
>  drivers/hwmon/Makefile    |   1 +
>  drivers/hwmon/nb6-hwmon.c | 466 ++++++++++++++++++++++++++++++++++++++

Missing Documentation/hwmon/nb6-hwmon.rst

>  3 files changed, 478 insertions(+)
>  create mode 100644 drivers/hwmon/nb6-hwmon.c
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 288ae9f63588..5523de75868d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1092,6 +1092,17 @@ config SENSORS_MENF21BMC_HWMON
>  	  This driver can also be built as a module. If so the module
>  	  will be called menf21bmc_hwmon.
>  
> +config SENSORS_NB6_HWMON
> +	tristate "SFR NeufBox 6 (NB6) Hardware Monitoring"
> +	depends on I2C
> +	depends on PWM
> +	help
> +	  If you say yes here you get support for SFR NeufBox 6 PWM LEDs,
> +	  temperature and voltage sensors.
> +
This driver should not support LEDs.

> +	  This driver can also be built as a module. If so, the module
> +	  will be called nb6-hwmon.
> +
>  config SENSORS_ADCXX
>  	tristate "National Semiconductor ADCxxxSxxx"
>  	depends on SPI_MASTER
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 3e32c21f5efe..5a35fde42bd8 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
>  obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
>  obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
>  obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
> +obj-$(CONFIG_SENSORS_NB6_HWMON)	+= nb6-hwmon.o
>  obj-$(CONFIG_SENSORS_NCT6683)	+= nct6683.o
>  obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
>  obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
> diff --git a/drivers/hwmon/nb6-hwmon.c b/drivers/hwmon/nb6-hwmon.c
> new file mode 100644
> index 000000000000..aebb6ebbf3a8
> --- /dev/null
> +++ b/drivers/hwmon/nb6-hwmon.c
> @@ -0,0 +1,466 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for SFR NeufBox 6 Hardware Monitoring
> + *
> + * Copyright 2020 Álvaro Fernández Rojas <noltari@gmail.com>
> + */
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/pwm.h>
> +#include <linux/sysfs.h>
> +
> +#define NB6_LEDS_PWM_REG	0x10
> +#define NB6_TEMP_REG		0x22
> +#define NB6_VOLTAGE_REG		0x24
> +#define NB6_DMESG_CTL_REG	0x26
> +#define NB6_DMESG_VAL_REG	0x27
> +#define NB6_LEDS_MODE_REG	0x31
> +#define NB6_RELEASE_REG		0x90
> +#define NB6_STATS_BOOT_REG	0xa0
> +#define NB6_STATS_PANIC_REG	0xa1
> +#define NB6_STATS_OOPS_REG	0xa2
> +#define NB6_WDT_REG		0xee
> +
> +#define NB6_DELAY		1000
> +#define NB6_DMESG_SIZE		512
> +#define NB6_I2C_RETRIES		5
> +#define NB6_LEDS_MODE_LEN	32
> +#define NB6_LEDS_PWM_COUNT	9
> +#define NB6_PWM(x)		(NB6_LEDS_PWM_REG + x)
> +#define NB6_WDT_LEN		10
> +
> +#define ADC_quantum(Vref)	((1000 * (Vref)) / 1024)
> +#define ADC_mV(Vref,x)		((ADC_quantum(Vref) * (x)) / 1000)
> +#define ADC_Temperature(t)	(1000 * (100 * ADC_mV(1800, t)) / 349)
> +#define MR1			82
> +#define MR2			20
> +#define ADC_Voltage(v)		((ADC_mV(2400, v) * ((10 * (MR1 + MR2)) / MR2)) / 10)
> +
> +struct nb6_data {
> +	struct pwm_chip pwm;
> +	struct i2c_client *i2c;
> +	struct device *dev;
> +	struct mutex lock;
> +	u8 leds_mode;
> +	u8 leds_pwm[NB6_LEDS_PWM_COUNT];
> +	u8 release;
> +	u8 stats_boot;
> +	u8 stats_panic;
> +	u8 stats_oops;
> +	u16 temperature;
> +	u16 voltage;
> +	u8 watchdog;
> +};
> +
> +enum LEDS_MODE {
> +	LEDS_MODE_DISABLE,
> +	LEDS_MODE_BOOT,
> +	LEDS_MODE_BOOT_MAIN,
> +	LEDS_MODE_BOOT_TFTP,
> +	LEDS_MODE_BOOT_RESCUE,
> +	LEDS_MODE_LOGIN,
> +	LEDS_MODE_BURNING,
> +	LEDS_MODE_DOWNLOAD,
> +	LEDS_MODE_WDT_TEMPERATURE,
> +	LEDS_MODE_WDT_VOLTAGE,
> +	LEDS_MODE_PANIC,
> +	LEDS_MODE_CONTROL,
> +	LEDS_MODE_NUM
> +};
> +
> +static char const *leds_modes_str[] = {
> +	[LEDS_MODE_DISABLE] = "disable",
> +	[LEDS_MODE_BOOT] = "boot",
> +	[LEDS_MODE_BOOT_MAIN] = "boot-main",
> +	[LEDS_MODE_BOOT_TFTP] = "boot-tftp",
> +	[LEDS_MODE_BOOT_RESCUE] = "boot-rescue",
> +	[LEDS_MODE_LOGIN] = "login",
> +	[LEDS_MODE_BURNING] = "burning",
> +	[LEDS_MODE_DOWNLOAD] = "downloading",
> +	[LEDS_MODE_WDT_TEMPERATURE] = "wdt-temperature",
> +	[LEDS_MODE_WDT_VOLTAGE] = "wdt-voltage",
> +	[LEDS_MODE_PANIC] = "panic",
> +	[LEDS_MODE_CONTROL] = "control",
> +};
> +
> +/* I2C Helpers */
> +
> +static u8 nb6_readb(struct nb6_data *data, u8 addr, u8 val)

This will never return an error.

> +{
> +	int status;
> +	unsigned i;
> +
> +	for (i = 0; i < NB6_I2C_RETRIES; i++) {
> +		status = i2c_smbus_read_byte_data(data->i2c, addr);
> +		if (status >= 0)
> +			return status;
> +		udelay(NB6_DELAY);
> +	}
> +

Is that system really that bad ? That needs an explanation.

> +	dev_err(data->dev, "read error (%d): addr=0x%02x", status, addr);
> +
> +	return val;

Obviously this error case was never reached.

> +}
> +
> +static u16 nb6_readw(struct nb6_data *data, u8 addr, u16 val)

This will never return an error.

> +{
> +	u8 tmp;
> +
> +	tmp = nb6_readb(data, addr, (val >> 8) & 0xff);

This ignores any received errors and, worse, converts errors
into pretty much random data.

> +	val = (val & 0xff) | (tmp << 8);
> +
> +	tmp = nb6_readb(data, addr + 1, val & 0xff);
> +	val = (val & 0xff00) | tmp;
> +
> +	return val;
> +}
> +
> +static s32 nb6_writeb(struct nb6_data *data, u8 addr, u8 val)
> +{
> +	int status;
> +	unsigned i;
> +
> +	for (i = 0; i < NB6_I2C_RETRIES; i++) {
> +		status = i2c_smbus_write_byte_data(data->i2c, addr, val);
> +		if (!status)
> +			return 0;
> +		udelay(NB6_DELAY);
> +	}
> +
> +	dev_err(data->dev, "write error (%d): addr=0x%02x val=0x%02x", status, addr, val);
> +
> +	return status;
> +}
> +
> +static inline void leds_mode_update(struct nb6_data *data, u8 val)
> +{
> +	if ((data->leds_mode != val) &&
> +	    !nb6_writeb(data, NB6_LEDS_MODE_REG, val))
> +		data->leds_mode = val;
> +}
> +
> +static inline void leds_pwm_update(struct nb6_data *data, u8 id, u8 val)
> +{
> +	if ((data->leds_pwm[id] != val) &&
> +	    !nb6_writeb(data, NB6_PWM(id), val))
> +		data->leds_pwm[id] = val;
> +}
> +
> +/* Hardware Monitoring */
> +
> +static ssize_t dmesg_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct nb6_data *data = dev_get_drvdata(dev);
> +	unsigned i;
> +
> +	mutex_lock(&data->lock);
> +
> +	if (nb6_writeb(data, NB6_DMESG_CTL_REG, 0)) {
> +		mutex_unlock(&data->lock);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < NB6_DMESG_SIZE; i++)
> +		buf[i] = nb6_readb(data, NB6_DMESG_VAL_REG, ~0);
> +
> +	mutex_unlock(&data->lock);
> +
> +	*buf = '\0';
> +
> +	return i + 1;
> +}
> +
> +static DEVICE_ATTR_RO(dmesg);
> +

Non-standard attributes need to be explained and their need must be discussed.

> +static ssize_t leds_mode_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct nb6_data *data = dev_get_drvdata(dev);
> +	loff_t off = 0;
> +	unsigned i;
> +
> +	mutex_lock(&data->lock);
> +	data->leds_mode = nb6_readb(data, NB6_LEDS_MODE_REG, data->leds_mode);
> +	mutex_unlock(&data->lock);
> +
> +	for (i = 0; i < ARRAY_SIZE(leds_modes_str); i++) {
> +		off += sprintf(buf + off,
> +			       (i == data->leds_mode) ? "[%s] " : "%s ",
> +			       leds_modes_str[i]);
> +	}
> +
> +	off += sprintf(buf + off, "\n");
> +
> +	return off;
> +}
> +
> +static ssize_t leds_mode_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct nb6_data *data = dev_get_drvdata(dev);
> +	char _s[NB6_LEDS_MODE_LEN];
> +	char *s;
> +	unsigned i;
> +
> +	snprintf(_s, sizeof(_s), "%s", buf);
> +	s = strstrip(_s);
> +	for (i = 0; i < ARRAY_SIZE(leds_modes_str); i++) {
> +		if (!strcmp(s, leds_modes_str[i])) {
> +			leds_mode_update(data, i);
> +			break;
> +		}
> +	}
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(leds_mode);
> +

I won't accept any attributes not associated with hardware monitoring.

> +static ssize_t release_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct nb6_data *data = dev_get_drvdata(dev);
> +
> +	mutex_lock(&data->lock);
> +	data->release = nb6_readb(data, NB6_RELEASE_REG, data->release);
> +	mutex_unlock(&data->lock);
> +
> +	return sprintf(buf, "%u\n", data->release);
> +}
> +
> +static DEVICE_ATTR_RO(release);
> +

And I will most definitely not accept unexplained non-standard attributes.

> +static ssize_t stats_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	struct nb6_data *data = dev_get_drvdata(dev);
> +
> +	mutex_lock(&data->lock);
> +	data->stats_boot = nb6_readb(data, NB6_STATS_BOOT_REG,
> +				     data->stats_boot);
> +	data->stats_panic = nb6_readb(data, NB6_STATS_PANIC_REG,
> +				      data->stats_panic);
> +	data->stats_oops = nb6_readb(data, NB6_STATS_OOPS_REG,
> +				     data->stats_oops);
> +	mutex_unlock(&data->lock);
> +
> +	return sprintf(buf, "boot: %u\npanic: %u\noops: %u\n",
> +		       data->stats_boot, data->stats_panic, data->stats_oops);
> +}
> +
> +static DEVICE_ATTR_RO(stats);
> +
> +static ssize_t temperature_show(struct device *dev,
> +				struct device_attribute *da, char *buf)
> +{
> +	struct nb6_data *data = dev_get_drvdata(dev);
> +
> +	mutex_lock(&data->lock);
> +	data->temperature = nb6_readw(data, NB6_TEMP_REG, data->temperature);
> +	mutex_unlock(&data->lock);
> +
> +	return sprintf(buf, "%u\n", ADC_Temperature(data->temperature));
> +}
> +
> +static DEVICE_ATTR_RO(temperature);
> +
> +static ssize_t voltage_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct nb6_data *data = dev_get_drvdata(dev);
> +
> +	mutex_lock(&data->lock);
> +	data->voltage = nb6_readw(data, NB6_VOLTAGE_REG, data->voltage);
> +	mutex_unlock(&data->lock);
> +
> +	return sprintf(buf, "%u\n", ADC_Voltage(data->voltage));
> +}
> +
> +static DEVICE_ATTR_RO(voltage);
> +

This are not standard hardware monitoring attributes.

> +static ssize_t watchdog_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct nb6_data *data = dev_get_drvdata(dev);
> +
> +	mutex_lock(&data->lock);
> +	data->watchdog = nb6_readb(data, NB6_WDT_REG, data->watchdog);
> +	mutex_unlock(&data->lock);
> +
> +	return sprintf(buf, "%u\n", data->watchdog);
> +}
> +
> +static ssize_t watchdog_store(struct device *dev,
> +			      struct device_attribute *attr, const char *buf,
> +			      size_t len)
> +{
> +	struct nb6_data *data = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&data->lock);
> +	if (!nb6_writeb(data, NB6_WDT_REG, val))
> +		data->watchdog = val;
> +	mutex_unlock(&data->lock);
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RW(watchdog);
> +

While there are situations where we accept a watchdog driver as part
of a hardware monitoring driver, it has to be a standard watchdog
driver, not a random attribute such as "watchdog" and "status".

> +static struct attribute *nb6_attrs[] = {
> +	&dev_attr_dmesg.attr,
> +	&dev_attr_leds_mode.attr,
> +	&dev_attr_release.attr,
> +	&dev_attr_stats.attr,
> +	&dev_attr_temperature.attr,
> +	&dev_attr_voltage.attr,
> +	&dev_attr_watchdog.attr,
> +	NULL,
> +};

Not a single standard hardware monitoring attribute.

> +
> +ATTRIBUTE_GROUPS(nb6);
> +
> +/* PWM */
> +
> +static inline struct nb6_data *to_nb6_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct nb6_data, pwm);
> +}
> +
> +static int nb6_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct nb6_data *data = to_nb6_pwm(chip);
> +
> +	mutex_lock(&data->lock);
> +	if (!nb6_writeb(data, NB6_PWM(pwm->hwpwm), 0))
> +		data->leds_pwm[pwm->hwpwm] = 0;
> +	else
> +		data->leds_pwm[pwm->hwpwm] = ~0;
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}
> +
> +static void nb6_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct nb6_data *data = to_nb6_pwm(chip);
> +	unsigned i;
> +
> +	mutex_lock(&data->lock);
> +	for (i = 0; i < NB6_LEDS_PWM_COUNT; i++) {
> +		if (data->leds_pwm[i]) {
> +			leds_mode_update(data, LEDS_MODE_DISABLE);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&data->lock);
> +}
> +
> +static int nb6_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  int duty_ns, int period_ns)
> +{
> +	struct nb6_data *data = to_nb6_pwm(chip);
> +
> +	mutex_lock(&data->lock);
> +	leds_mode_update(data, LEDS_MODE_CONTROL);
> +	leds_pwm_update(data, pwm->hwpwm, duty_ns);
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}
> +
> +static int nb6_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct nb6_data *data = to_nb6_pwm(chip);
> +
> +	mutex_lock(&data->lock);
> +	leds_mode_update(data, LEDS_MODE_CONTROL);
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}
> +
> +static void nb6_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct nb6_data *data = to_nb6_pwm(chip);
> +
> +	mutex_lock(&data->lock);
> +	leds_pwm_update(data, pwm->hwpwm, 0);
> +	mutex_unlock(&data->lock);
> +}
> +
> +static const struct pwm_ops nb6_pwm_ops = {
> +	.request = nb6_pwm_request,
> +	.free = nb6_pwm_free,
> +	.config = nb6_pwm_config,
> +	.enable = nb6_pwm_enable,
> +	.disable = nb6_pwm_disable,
> +	.owner = THIS_MODULE,
> +};
> +
> +/* Driver */
> +
> +static int nb6_hwmon_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct nb6_data *data;
> +	struct device *hwmon_dev;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(struct nb6_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev = dev;
> +	data->i2c = client;
> +	data->leds_mode = LEDS_MODE_NUM;
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->lock);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> +							   data,
> +							   nb6_groups);

New drivers must use devm_hwmon_device_register_with_info().

> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	data->pwm.dev = dev;
> +	data->pwm.ops = &nb6_pwm_ops;
> +	data->pwm.base = -1;
> +	data->pwm.npwm = NB6_LEDS_PWM_COUNT;
> +
> +	ret = pwmchip_add(&data->pwm);
> +	if (ret < 0)
> +		return ret;
> +

This very much looks like a multi-function chip (hardware monitoring,
pwm, LEDs, and possibly watchdog) and should be implemented as such.

> +	return 0;
> +};
> +
> +static const struct of_device_id nb6_hwmon_of_match[] = {
> +	{ .compatible = "sfr,nb6_hwmon" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, nb6_hwmon_of_match);
> +
> +static struct i2c_driver nb6_hwmon_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "nb6-hwmon",
> +		.of_match_table = of_match_ptr(nb6_hwmon_of_match),
> +	},
> +	.probe = nb6_hwmon_probe,
> +};
> +module_i2c_driver(nb6_hwmon_driver);
> 

