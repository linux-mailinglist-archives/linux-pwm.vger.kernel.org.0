Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDAB1F1D72
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 18:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgFHQev (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbgFHQeu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 12:34:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3698FC08C5C2;
        Mon,  8 Jun 2020 09:34:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so392558wmj.0;
        Mon, 08 Jun 2020 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=niq+balA3edV9j8k1sZdVUC5nRZNnyOdvleyt4whD4E=;
        b=Wo0x4GQ7fZoNhEnYcp5HCcWkRUzSv8LJo2kYBOOXLVVTOtwcZG3bQKCi8czaryF6qV
         f4NkbOST4arh3fnFbnFZKMM328ZlrlCUXJXCSG5YZHp88Duz3aXkHufzmN85Q2rqsekp
         f5q4E7dURsut9MvDWt5Yl51D1nEUyEnrezdcyzlf1vTjrOhfvR2ZsTy3qufw+U5y/azd
         qwCuYgb2ynTvz/tl6S2aaDY5W/DcFun5i8qv71vhDvvTtgxjQTG66djHPe/foKRQamUN
         RCKapUgAT/E9Z9n4cBdqjGyKXwz6NObz0kcBrErAt8TNUsWS53EGbNkvFUFmtWEACqm7
         PcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=niq+balA3edV9j8k1sZdVUC5nRZNnyOdvleyt4whD4E=;
        b=GFXZ7L3Iwgad+Ui8ho95jtcs/CFs7phYO+LptoNk7bEI0zFXg2jIk3zyj3Fyfxvi+x
         2nBpfDuFjFUQPNiLVeh4K6MqKeJdbqTns/m6xxBpRP0G4DxfTdQ2EyxaMqNk9t1emg3w
         aXfxvXXfmI3dxll8sgok9FWLkX4KUMW2VwXauhG1j+s3qde/BMtY8FtXBTWbw9O0dzhf
         WLGZ20jJk69EtYBGdwoZrAxL3o5wx+VNXo0yeq6Vjm6YdqKXBRnEGjtN5ejBAThKf9fb
         UmAw/awYoPY5x/rzCidtctNKa/GaJV8yVzAt2s9kj97G7pq3uEuotJymTEIcQJaX3uFw
         Fffg==
X-Gm-Message-State: AOAM531u30oVdcjtGkOhVFQ2xMW64BuvmP4HbBdUo2/Yxlk57GEJ9Vqg
        PVR/lk9NTeeFVo8hllx6TBQ=
X-Google-Smtp-Source: ABdhPJxrb5bvroqkSBjITdov+X5VgpD35Hs+agunVEHv14Kpk8PLNkCtIImcfiOIg1bIh6xPQ2I2Aw==
X-Received: by 2002:a1c:f007:: with SMTP id a7mr164438wmb.103.1591634088711;
        Mon, 08 Jun 2020 09:34:48 -0700 (PDT)
Received: from macbook-pro-alvaro.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id l2sm253181wru.58.2020.06.08.09.34.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 09:34:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/2] hwmon: Add SFR NB6 sensor driver
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <b7d278a2-df5c-5d56-7829-b6ed798b2bdf@roeck-us.net>
Date:   Mon, 8 Jun 2020 18:34:47 +0200
Cc:     jdelvare@suse.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <124E030B-3DFF-40B2-AF75-A7D383FD1595@gmail.com>
References: <20200607182524.3221837-1-noltari@gmail.com>
 <20200607182524.3221837-3-noltari@gmail.com>
 <b7d278a2-df5c-5d56-7829-b6ed798b2bdf@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Guenter,

Thanks for your comments, I will reimplement it as MFD.

Regards,
=C3=81lvaro.

> El 8 jun 2020, a las 16:03, Guenter Roeck <linux@roeck-us.net> =
escribi=C3=B3:
>=20
> On 6/7/20 11:25 AM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
>> SFR NeufBox 6 is equipped with an I2C connected chip to monitor =
voltage,
>> temperature and other stats. It also has a PWM LEDs that can be =
manually
>> controlled or set to specific hardware monitoring modes.
>>=20
>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>> ---
>> drivers/hwmon/Kconfig     |  11 +
>> drivers/hwmon/Makefile    |   1 +
>> drivers/hwmon/nb6-hwmon.c | 466 =
++++++++++++++++++++++++++++++++++++++
>=20
> Missing Documentation/hwmon/nb6-hwmon.rst
>=20
>> 3 files changed, 478 insertions(+)
>> create mode 100644 drivers/hwmon/nb6-hwmon.c
>>=20
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 288ae9f63588..5523de75868d 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1092,6 +1092,17 @@ config SENSORS_MENF21BMC_HWMON
>> 	  This driver can also be built as a module. If so the module
>> 	  will be called menf21bmc_hwmon.
>>=20
>> +config SENSORS_NB6_HWMON
>> +	tristate "SFR NeufBox 6 (NB6) Hardware Monitoring"
>> +	depends on I2C
>> +	depends on PWM
>> +	help
>> +	  If you say yes here you get support for SFR NeufBox 6 PWM =
LEDs,
>> +	  temperature and voltage sensors.
>> +
> This driver should not support LEDs.
>=20
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called nb6-hwmon.
>> +
>> config SENSORS_ADCXX
>> 	tristate "National Semiconductor ADCxxxSxxx"
>> 	depends on SPI_MASTER
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 3e32c21f5efe..5a35fde42bd8 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MCP3021)	+=3D mcp3021.o
>> obj-$(CONFIG_SENSORS_TC654)	+=3D tc654.o
>> obj-$(CONFIG_SENSORS_MLXREG_FAN) +=3D mlxreg-fan.o
>> obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) +=3D menf21bmc_hwmon.o
>> +obj-$(CONFIG_SENSORS_NB6_HWMON)	+=3D nb6-hwmon.o
>> obj-$(CONFIG_SENSORS_NCT6683)	+=3D nct6683.o
>> obj-$(CONFIG_SENSORS_NCT6775)	+=3D nct6775.o
>> obj-$(CONFIG_SENSORS_NCT7802)	+=3D nct7802.o
>> diff --git a/drivers/hwmon/nb6-hwmon.c b/drivers/hwmon/nb6-hwmon.c
>> new file mode 100644
>> index 000000000000..aebb6ebbf3a8
>> --- /dev/null
>> +++ b/drivers/hwmon/nb6-hwmon.c
>> @@ -0,0 +1,466 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Driver for SFR NeufBox 6 Hardware Monitoring
>> + *
>> + * Copyright 2020 =C3=81lvaro Fern=C3=A1ndez Rojas =
<noltari@gmail.com>
>> + */
>> +#include <linux/delay.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/err.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pwm.h>
>> +#include <linux/sysfs.h>
>> +
>> +#define NB6_LEDS_PWM_REG	0x10
>> +#define NB6_TEMP_REG		0x22
>> +#define NB6_VOLTAGE_REG		0x24
>> +#define NB6_DMESG_CTL_REG	0x26
>> +#define NB6_DMESG_VAL_REG	0x27
>> +#define NB6_LEDS_MODE_REG	0x31
>> +#define NB6_RELEASE_REG		0x90
>> +#define NB6_STATS_BOOT_REG	0xa0
>> +#define NB6_STATS_PANIC_REG	0xa1
>> +#define NB6_STATS_OOPS_REG	0xa2
>> +#define NB6_WDT_REG		0xee
>> +
>> +#define NB6_DELAY		1000
>> +#define NB6_DMESG_SIZE		512
>> +#define NB6_I2C_RETRIES		5
>> +#define NB6_LEDS_MODE_LEN	32
>> +#define NB6_LEDS_PWM_COUNT	9
>> +#define NB6_PWM(x)		(NB6_LEDS_PWM_REG + x)
>> +#define NB6_WDT_LEN		10
>> +
>> +#define ADC_quantum(Vref)	((1000 * (Vref)) / 1024)
>> +#define ADC_mV(Vref,x)		((ADC_quantum(Vref) * (x)) / =
1000)
>> +#define ADC_Temperature(t)	(1000 * (100 * ADC_mV(1800, t)) / 349)
>> +#define MR1			82
>> +#define MR2			20
>> +#define ADC_Voltage(v)		((ADC_mV(2400, v) * ((10 * (MR1 =
+ MR2)) / MR2)) / 10)
>> +
>> +struct nb6_data {
>> +	struct pwm_chip pwm;
>> +	struct i2c_client *i2c;
>> +	struct device *dev;
>> +	struct mutex lock;
>> +	u8 leds_mode;
>> +	u8 leds_pwm[NB6_LEDS_PWM_COUNT];
>> +	u8 release;
>> +	u8 stats_boot;
>> +	u8 stats_panic;
>> +	u8 stats_oops;
>> +	u16 temperature;
>> +	u16 voltage;
>> +	u8 watchdog;
>> +};
>> +
>> +enum LEDS_MODE {
>> +	LEDS_MODE_DISABLE,
>> +	LEDS_MODE_BOOT,
>> +	LEDS_MODE_BOOT_MAIN,
>> +	LEDS_MODE_BOOT_TFTP,
>> +	LEDS_MODE_BOOT_RESCUE,
>> +	LEDS_MODE_LOGIN,
>> +	LEDS_MODE_BURNING,
>> +	LEDS_MODE_DOWNLOAD,
>> +	LEDS_MODE_WDT_TEMPERATURE,
>> +	LEDS_MODE_WDT_VOLTAGE,
>> +	LEDS_MODE_PANIC,
>> +	LEDS_MODE_CONTROL,
>> +	LEDS_MODE_NUM
>> +};
>> +
>> +static char const *leds_modes_str[] =3D {
>> +	[LEDS_MODE_DISABLE] =3D "disable",
>> +	[LEDS_MODE_BOOT] =3D "boot",
>> +	[LEDS_MODE_BOOT_MAIN] =3D "boot-main",
>> +	[LEDS_MODE_BOOT_TFTP] =3D "boot-tftp",
>> +	[LEDS_MODE_BOOT_RESCUE] =3D "boot-rescue",
>> +	[LEDS_MODE_LOGIN] =3D "login",
>> +	[LEDS_MODE_BURNING] =3D "burning",
>> +	[LEDS_MODE_DOWNLOAD] =3D "downloading",
>> +	[LEDS_MODE_WDT_TEMPERATURE] =3D "wdt-temperature",
>> +	[LEDS_MODE_WDT_VOLTAGE] =3D "wdt-voltage",
>> +	[LEDS_MODE_PANIC] =3D "panic",
>> +	[LEDS_MODE_CONTROL] =3D "control",
>> +};
>> +
>> +/* I2C Helpers */
>> +
>> +static u8 nb6_readb(struct nb6_data *data, u8 addr, u8 val)
>=20
> This will never return an error.
>=20
>> +{
>> +	int status;
>> +	unsigned i;
>> +
>> +	for (i =3D 0; i < NB6_I2C_RETRIES; i++) {
>> +		status =3D i2c_smbus_read_byte_data(data->i2c, addr);
>> +		if (status >=3D 0)
>> +			return status;
>> +		udelay(NB6_DELAY);
>> +	}
>> +
>=20
> Is that system really that bad ? That needs an explanation.
>=20
>> +	dev_err(data->dev, "read error (%d): addr=3D0x%02x", status, =
addr);
>> +
>> +	return val;
>=20
> Obviously this error case was never reached.
>=20
>> +}
>> +
>> +static u16 nb6_readw(struct nb6_data *data, u8 addr, u16 val)
>=20
> This will never return an error.
>=20
>> +{
>> +	u8 tmp;
>> +
>> +	tmp =3D nb6_readb(data, addr, (val >> 8) & 0xff);
>=20
> This ignores any received errors and, worse, converts errors
> into pretty much random data.
>=20
>> +	val =3D (val & 0xff) | (tmp << 8);
>> +
>> +	tmp =3D nb6_readb(data, addr + 1, val & 0xff);
>> +	val =3D (val & 0xff00) | tmp;
>> +
>> +	return val;
>> +}
>> +
>> +static s32 nb6_writeb(struct nb6_data *data, u8 addr, u8 val)
>> +{
>> +	int status;
>> +	unsigned i;
>> +
>> +	for (i =3D 0; i < NB6_I2C_RETRIES; i++) {
>> +		status =3D i2c_smbus_write_byte_data(data->i2c, addr, =
val);
>> +		if (!status)
>> +			return 0;
>> +		udelay(NB6_DELAY);
>> +	}
>> +
>> +	dev_err(data->dev, "write error (%d): addr=3D0x%02x val=3D0x%02x",=
 status, addr, val);
>> +
>> +	return status;
>> +}
>> +
>> +static inline void leds_mode_update(struct nb6_data *data, u8 val)
>> +{
>> +	if ((data->leds_mode !=3D val) &&
>> +	    !nb6_writeb(data, NB6_LEDS_MODE_REG, val))
>> +		data->leds_mode =3D val;
>> +}
>> +
>> +static inline void leds_pwm_update(struct nb6_data *data, u8 id, u8 =
val)
>> +{
>> +	if ((data->leds_pwm[id] !=3D val) &&
>> +	    !nb6_writeb(data, NB6_PWM(id), val))
>> +		data->leds_pwm[id] =3D val;
>> +}
>> +
>> +/* Hardware Monitoring */
>> +
>> +static ssize_t dmesg_show(struct device *dev, struct =
device_attribute *attr,
>> +			  char *buf)
>> +{
>> +	struct nb6_data *data =3D dev_get_drvdata(dev);
>> +	unsigned i;
>> +
>> +	mutex_lock(&data->lock);
>> +
>> +	if (nb6_writeb(data, NB6_DMESG_CTL_REG, 0)) {
>> +		mutex_unlock(&data->lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i =3D 0; i < NB6_DMESG_SIZE; i++)
>> +		buf[i] =3D nb6_readb(data, NB6_DMESG_VAL_REG, ~0);
>> +
>> +	mutex_unlock(&data->lock);
>> +
>> +	*buf =3D '\0';
>> +
>> +	return i + 1;
>> +}
>> +
>> +static DEVICE_ATTR_RO(dmesg);
>> +
>=20
> Non-standard attributes need to be explained and their need must be =
discussed.
>=20
>> +static ssize_t leds_mode_show(struct device *dev,
>> +			      struct device_attribute *attr, char *buf)
>> +{
>> +	struct nb6_data *data =3D dev_get_drvdata(dev);
>> +	loff_t off =3D 0;
>> +	unsigned i;
>> +
>> +	mutex_lock(&data->lock);
>> +	data->leds_mode =3D nb6_readb(data, NB6_LEDS_MODE_REG, =
data->leds_mode);
>> +	mutex_unlock(&data->lock);
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(leds_modes_str); i++) {
>> +		off +=3D sprintf(buf + off,
>> +			       (i =3D=3D data->leds_mode) ? "[%s] " : =
"%s ",
>> +			       leds_modes_str[i]);
>> +	}
>> +
>> +	off +=3D sprintf(buf + off, "\n");
>> +
>> +	return off;
>> +}
>> +
>> +static ssize_t leds_mode_store(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       const char *buf, size_t count)
>> +{
>> +	struct nb6_data *data =3D dev_get_drvdata(dev);
>> +	char _s[NB6_LEDS_MODE_LEN];
>> +	char *s;
>> +	unsigned i;
>> +
>> +	snprintf(_s, sizeof(_s), "%s", buf);
>> +	s =3D strstrip(_s);
>> +	for (i =3D 0; i < ARRAY_SIZE(leds_modes_str); i++) {
>> +		if (!strcmp(s, leds_modes_str[i])) {
>> +			leds_mode_update(data, i);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(leds_mode);
>> +
>=20
> I won't accept any attributes not associated with hardware monitoring.
>=20
>> +static ssize_t release_show(struct device *dev, struct =
device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	struct nb6_data *data =3D dev_get_drvdata(dev);
>> +
>> +	mutex_lock(&data->lock);
>> +	data->release =3D nb6_readb(data, NB6_RELEASE_REG, =
data->release);
>> +	mutex_unlock(&data->lock);
>> +
>> +	return sprintf(buf, "%u\n", data->release);
>> +}
>> +
>> +static DEVICE_ATTR_RO(release);
>> +
>=20
> And I will most definitely not accept unexplained non-standard =
attributes.
>=20
>> +static ssize_t stats_show(struct device *dev, struct =
device_attribute *attr,
>> +			  char *buf)
>> +{
>> +	struct nb6_data *data =3D dev_get_drvdata(dev);
>> +
>> +	mutex_lock(&data->lock);
>> +	data->stats_boot =3D nb6_readb(data, NB6_STATS_BOOT_REG,
>> +				     data->stats_boot);
>> +	data->stats_panic =3D nb6_readb(data, NB6_STATS_PANIC_REG,
>> +				      data->stats_panic);
>> +	data->stats_oops =3D nb6_readb(data, NB6_STATS_OOPS_REG,
>> +				     data->stats_oops);
>> +	mutex_unlock(&data->lock);
>> +
>> +	return sprintf(buf, "boot: %u\npanic: %u\noops: %u\n",
>> +		       data->stats_boot, data->stats_panic, =
data->stats_oops);
>> +}
>> +
>> +static DEVICE_ATTR_RO(stats);
>> +
>> +static ssize_t temperature_show(struct device *dev,
>> +				struct device_attribute *da, char *buf)
>> +{
>> +	struct nb6_data *data =3D dev_get_drvdata(dev);
>> +
>> +	mutex_lock(&data->lock);
>> +	data->temperature =3D nb6_readw(data, NB6_TEMP_REG, =
data->temperature);
>> +	mutex_unlock(&data->lock);
>> +
>> +	return sprintf(buf, "%u\n", ADC_Temperature(data->temperature));
>> +}
>> +
>> +static DEVICE_ATTR_RO(temperature);
>> +
>> +static ssize_t voltage_show(struct device *dev, struct =
device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	struct nb6_data *data =3D dev_get_drvdata(dev);
>> +
>> +	mutex_lock(&data->lock);
>> +	data->voltage =3D nb6_readw(data, NB6_VOLTAGE_REG, =
data->voltage);
>> +	mutex_unlock(&data->lock);
>> +
>> +	return sprintf(buf, "%u\n", ADC_Voltage(data->voltage));
>> +}
>> +
>> +static DEVICE_ATTR_RO(voltage);
>> +
>=20
> This are not standard hardware monitoring attributes.
>=20
>> +static ssize_t watchdog_show(struct device *dev,
>> +			     struct device_attribute *attr, char *buf)
>> +{
>> +	struct nb6_data *data =3D dev_get_drvdata(dev);
>> +
>> +	mutex_lock(&data->lock);
>> +	data->watchdog =3D nb6_readb(data, NB6_WDT_REG, data->watchdog);
>> +	mutex_unlock(&data->lock);
>> +
>> +	return sprintf(buf, "%u\n", data->watchdog);
>> +}
>> +
>> +static ssize_t watchdog_store(struct device *dev,
>> +			      struct device_attribute *attr, const char =
*buf,
>> +			      size_t len)
>> +{
>> +	struct nb6_data *data =3D dev_get_drvdata(dev);
>> +	unsigned long val;
>> +	int ret;
>> +
>> +	ret =3D kstrtoul(buf, 0, &val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	if (!nb6_writeb(data, NB6_WDT_REG, val))
>> +		data->watchdog =3D val;
>> +	mutex_unlock(&data->lock);
>> +
>> +	return len;
>> +}
>> +
>> +static DEVICE_ATTR_RW(watchdog);
>> +
>=20
> While there are situations where we accept a watchdog driver as part
> of a hardware monitoring driver, it has to be a standard watchdog
> driver, not a random attribute such as "watchdog" and "status".
>=20
>> +static struct attribute *nb6_attrs[] =3D {
>> +	&dev_attr_dmesg.attr,
>> +	&dev_attr_leds_mode.attr,
>> +	&dev_attr_release.attr,
>> +	&dev_attr_stats.attr,
>> +	&dev_attr_temperature.attr,
>> +	&dev_attr_voltage.attr,
>> +	&dev_attr_watchdog.attr,
>> +	NULL,
>> +};
>=20
> Not a single standard hardware monitoring attribute.
>=20
>> +
>> +ATTRIBUTE_GROUPS(nb6);
>> +
>> +/* PWM */
>> +
>> +static inline struct nb6_data *to_nb6_pwm(struct pwm_chip *chip)
>> +{
>> +	return container_of(chip, struct nb6_data, pwm);
>> +}
>> +
>> +static int nb6_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
>> +{
>> +	struct nb6_data *data =3D to_nb6_pwm(chip);
>> +
>> +	mutex_lock(&data->lock);
>> +	if (!nb6_writeb(data, NB6_PWM(pwm->hwpwm), 0))
>> +		data->leds_pwm[pwm->hwpwm] =3D 0;
>> +	else
>> +		data->leds_pwm[pwm->hwpwm] =3D ~0;
>> +	mutex_unlock(&data->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static void nb6_pwm_free(struct pwm_chip *chip, struct pwm_device =
*pwm)
>> +{
>> +	struct nb6_data *data =3D to_nb6_pwm(chip);
>> +	unsigned i;
>> +
>> +	mutex_lock(&data->lock);
>> +	for (i =3D 0; i < NB6_LEDS_PWM_COUNT; i++) {
>> +		if (data->leds_pwm[i]) {
>> +			leds_mode_update(data, LEDS_MODE_DISABLE);
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&data->lock);
>> +}
>> +
>> +static int nb6_pwm_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
>> +			  int duty_ns, int period_ns)
>> +{
>> +	struct nb6_data *data =3D to_nb6_pwm(chip);
>> +
>> +	mutex_lock(&data->lock);
>> +	leds_mode_update(data, LEDS_MODE_CONTROL);
>> +	leds_pwm_update(data, pwm->hwpwm, duty_ns);
>> +	mutex_unlock(&data->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int nb6_pwm_enable(struct pwm_chip *chip, struct pwm_device =
*pwm)
>> +{
>> +	struct nb6_data *data =3D to_nb6_pwm(chip);
>> +
>> +	mutex_lock(&data->lock);
>> +	leds_mode_update(data, LEDS_MODE_CONTROL);
>> +	mutex_unlock(&data->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static void nb6_pwm_disable(struct pwm_chip *chip, struct pwm_device =
*pwm)
>> +{
>> +	struct nb6_data *data =3D to_nb6_pwm(chip);
>> +
>> +	mutex_lock(&data->lock);
>> +	leds_pwm_update(data, pwm->hwpwm, 0);
>> +	mutex_unlock(&data->lock);
>> +}
>> +
>> +static const struct pwm_ops nb6_pwm_ops =3D {
>> +	.request =3D nb6_pwm_request,
>> +	.free =3D nb6_pwm_free,
>> +	.config =3D nb6_pwm_config,
>> +	.enable =3D nb6_pwm_enable,
>> +	.disable =3D nb6_pwm_disable,
>> +	.owner =3D THIS_MODULE,
>> +};
>> +
>> +/* Driver */
>> +
>> +static int nb6_hwmon_probe(struct i2c_client *client,
>> +			   const struct i2c_device_id *id)
>> +{
>> +	struct device *dev =3D &client->dev;
>> +	struct nb6_data *data;
>> +	struct device *hwmon_dev;
>> +	int ret;
>> +
>> +	data =3D devm_kzalloc(dev, sizeof(struct nb6_data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->dev =3D dev;
>> +	data->i2c =3D client;
>> +	data->leds_mode =3D LEDS_MODE_NUM;
>> +	i2c_set_clientdata(client, data);
>> +	mutex_init(&data->lock);
>> +
>> +	hwmon_dev =3D devm_hwmon_device_register_with_groups(dev, =
client->name,
>> +							   data,
>> +							   nb6_groups);
>=20
> New drivers must use devm_hwmon_device_register_with_info().
>=20
>> +	if (IS_ERR(hwmon_dev))
>> +		return PTR_ERR(hwmon_dev);
>> +
>> +	data->pwm.dev =3D dev;
>> +	data->pwm.ops =3D &nb6_pwm_ops;
>> +	data->pwm.base =3D -1;
>> +	data->pwm.npwm =3D NB6_LEDS_PWM_COUNT;
>> +
>> +	ret =3D pwmchip_add(&data->pwm);
>> +	if (ret < 0)
>> +		return ret;
>> +
>=20
> This very much looks like a multi-function chip (hardware monitoring,
> pwm, LEDs, and possibly watchdog) and should be implemented as such.
>=20
>> +	return 0;
>> +};
>> +
>> +static const struct of_device_id nb6_hwmon_of_match[] =3D {
>> +	{ .compatible =3D "sfr,nb6_hwmon" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, nb6_hwmon_of_match);
>> +
>> +static struct i2c_driver nb6_hwmon_driver =3D {
>> +	.class =3D I2C_CLASS_HWMON,
>> +	.driver =3D {
>> +		.name =3D "nb6-hwmon",
>> +		.of_match_table =3D of_match_ptr(nb6_hwmon_of_match),
>> +	},
>> +	.probe =3D nb6_hwmon_probe,
>> +};
>> +module_i2c_driver(nb6_hwmon_driver);

