Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76C1F0DFB
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Jun 2020 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgFGSZd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 7 Jun 2020 14:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgFGSZb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 7 Jun 2020 14:25:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB513C061A0E;
        Sun,  7 Jun 2020 11:25:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so15004064wrw.8;
        Sun, 07 Jun 2020 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3u6I1hebmbjbYc0RjRj/RsAbtcWKcjZ8Fwma5R8UD+k=;
        b=cd9lDgM+XwhnZ3YwXG4K64aIxGsUFBvgwoeXA0bLsmZ5PmNN+q0mDO9rPsnwa9Ol8b
         lkuawibB1tf+oB+SdrYfmkj8piZ0E2vXlHAA13ijrohoKnWi620Bd4UTxKSTsTiItz8H
         jkI/uuNqWFO/oiktrpsmfVXk/nFWuxQhZurV7ir3P4SxdmcLddMCyyAykPYKiDJTVx87
         J+hYzK1zwO/I/Mxz/cV4IVeu8puh/5GvbmegrfaMIsds+a7K/urFKMCk3CBWGRlOxD66
         TElES5VhjxRCy+Gj4SmvuRnjhGQBNmLkd4NRBcqeq6h2evtcBopBWZ5CC6oqqMhHqz46
         QZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3u6I1hebmbjbYc0RjRj/RsAbtcWKcjZ8Fwma5R8UD+k=;
        b=MEyGp7440e7Li7J4DJpJBPTyE6TzrS4PI+pVmHS62/LWU6dgh0Dd8e4APl7DVpw/Zi
         baQjyUeFVENi3lUlBn0fFmkgS1db+/w5pAGTuM8pxfC81YtSwJNbOaNefeltJiQXTG4r
         fifI1xYOlyF35UJ+K7sTWWmLq7AMzim2gbbZIN505wFsWKfW4c3O87nB7ZpjLT8WgSEd
         LvmLIcj6z+kXUt+Jcq1xx4kbaOIRSUGocVLSmQh1Iyn31VJx3ccItxjSv8GpvT5UhaHF
         T5qMa80Yww2+Y9xh3H/LKyQQWF2N8zA653qhuYsf4GWBh8aYfY/KwwqoLMBGtpcFNoUO
         wkeQ==
X-Gm-Message-State: AOAM530PonhArhzBOE237pNqd1pBzkPwE0XOnGuVUWzH8TYjKo4ezawD
        47anJ4yg+LQQ3/caBrADk2kQRNgx9Dw=
X-Google-Smtp-Source: ABdhPJyW6jCR6zND4xFgzr8IYjAJPM6xwGfbbgqHHpN/5rXrwIPq88e76gQq2mG8vTNlgu8GGqxmkQ==
X-Received: by 2002:a05:6000:1c7:: with SMTP id t7mr19704577wrx.14.1591554328935;
        Sun, 07 Jun 2020 11:25:28 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id h18sm20434981wru.7.2020.06.07.11.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:25:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/2] hwmon: Add SFR NB6 sensor driver
Date:   Sun,  7 Jun 2020 20:25:24 +0200
Message-Id: <20200607182524.3221837-3-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607182524.3221837-1-noltari@gmail.com>
References: <20200607182524.3221837-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SFR NeufBox 6 is equipped with an I2C connected chip to monitor voltage,
temperature and other stats. It also has a PWM LEDs that can be manually
controlled or set to specific hardware monitoring modes.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/hwmon/Kconfig     |  11 +
 drivers/hwmon/Makefile    |   1 +
 drivers/hwmon/nb6-hwmon.c | 466 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 478 insertions(+)
 create mode 100644 drivers/hwmon/nb6-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 288ae9f63588..5523de75868d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1092,6 +1092,17 @@ config SENSORS_MENF21BMC_HWMON
 	  This driver can also be built as a module. If so the module
 	  will be called menf21bmc_hwmon.
 
+config SENSORS_NB6_HWMON
+	tristate "SFR NeufBox 6 (NB6) Hardware Monitoring"
+	depends on I2C
+	depends on PWM
+	help
+	  If you say yes here you get support for SFR NeufBox 6 PWM LEDs,
+	  temperature and voltage sensors.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nb6-hwmon.
+
 config SENSORS_ADCXX
 	tristate "National Semiconductor ADCxxxSxxx"
 	depends on SPI_MASTER
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 3e32c21f5efe..5a35fde42bd8 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
 obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
 obj-$(CONFIG_SENSORS_MLXREG_FAN) += mlxreg-fan.o
 obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
+obj-$(CONFIG_SENSORS_NB6_HWMON)	+= nb6-hwmon.o
 obj-$(CONFIG_SENSORS_NCT6683)	+= nct6683.o
 obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
 obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
diff --git a/drivers/hwmon/nb6-hwmon.c b/drivers/hwmon/nb6-hwmon.c
new file mode 100644
index 000000000000..aebb6ebbf3a8
--- /dev/null
+++ b/drivers/hwmon/nb6-hwmon.c
@@ -0,0 +1,466 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for SFR NeufBox 6 Hardware Monitoring
+ *
+ * Copyright 2020 Álvaro Fernández Rojas <noltari@gmail.com>
+ */
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/pwm.h>
+#include <linux/sysfs.h>
+
+#define NB6_LEDS_PWM_REG	0x10
+#define NB6_TEMP_REG		0x22
+#define NB6_VOLTAGE_REG		0x24
+#define NB6_DMESG_CTL_REG	0x26
+#define NB6_DMESG_VAL_REG	0x27
+#define NB6_LEDS_MODE_REG	0x31
+#define NB6_RELEASE_REG		0x90
+#define NB6_STATS_BOOT_REG	0xa0
+#define NB6_STATS_PANIC_REG	0xa1
+#define NB6_STATS_OOPS_REG	0xa2
+#define NB6_WDT_REG		0xee
+
+#define NB6_DELAY		1000
+#define NB6_DMESG_SIZE		512
+#define NB6_I2C_RETRIES		5
+#define NB6_LEDS_MODE_LEN	32
+#define NB6_LEDS_PWM_COUNT	9
+#define NB6_PWM(x)		(NB6_LEDS_PWM_REG + x)
+#define NB6_WDT_LEN		10
+
+#define ADC_quantum(Vref)	((1000 * (Vref)) / 1024)
+#define ADC_mV(Vref,x)		((ADC_quantum(Vref) * (x)) / 1000)
+#define ADC_Temperature(t)	(1000 * (100 * ADC_mV(1800, t)) / 349)
+#define MR1			82
+#define MR2			20
+#define ADC_Voltage(v)		((ADC_mV(2400, v) * ((10 * (MR1 + MR2)) / MR2)) / 10)
+
+struct nb6_data {
+	struct pwm_chip pwm;
+	struct i2c_client *i2c;
+	struct device *dev;
+	struct mutex lock;
+	u8 leds_mode;
+	u8 leds_pwm[NB6_LEDS_PWM_COUNT];
+	u8 release;
+	u8 stats_boot;
+	u8 stats_panic;
+	u8 stats_oops;
+	u16 temperature;
+	u16 voltage;
+	u8 watchdog;
+};
+
+enum LEDS_MODE {
+	LEDS_MODE_DISABLE,
+	LEDS_MODE_BOOT,
+	LEDS_MODE_BOOT_MAIN,
+	LEDS_MODE_BOOT_TFTP,
+	LEDS_MODE_BOOT_RESCUE,
+	LEDS_MODE_LOGIN,
+	LEDS_MODE_BURNING,
+	LEDS_MODE_DOWNLOAD,
+	LEDS_MODE_WDT_TEMPERATURE,
+	LEDS_MODE_WDT_VOLTAGE,
+	LEDS_MODE_PANIC,
+	LEDS_MODE_CONTROL,
+	LEDS_MODE_NUM
+};
+
+static char const *leds_modes_str[] = {
+	[LEDS_MODE_DISABLE] = "disable",
+	[LEDS_MODE_BOOT] = "boot",
+	[LEDS_MODE_BOOT_MAIN] = "boot-main",
+	[LEDS_MODE_BOOT_TFTP] = "boot-tftp",
+	[LEDS_MODE_BOOT_RESCUE] = "boot-rescue",
+	[LEDS_MODE_LOGIN] = "login",
+	[LEDS_MODE_BURNING] = "burning",
+	[LEDS_MODE_DOWNLOAD] = "downloading",
+	[LEDS_MODE_WDT_TEMPERATURE] = "wdt-temperature",
+	[LEDS_MODE_WDT_VOLTAGE] = "wdt-voltage",
+	[LEDS_MODE_PANIC] = "panic",
+	[LEDS_MODE_CONTROL] = "control",
+};
+
+/* I2C Helpers */
+
+static u8 nb6_readb(struct nb6_data *data, u8 addr, u8 val)
+{
+	int status;
+	unsigned i;
+
+	for (i = 0; i < NB6_I2C_RETRIES; i++) {
+		status = i2c_smbus_read_byte_data(data->i2c, addr);
+		if (status >= 0)
+			return status;
+		udelay(NB6_DELAY);
+	}
+
+	dev_err(data->dev, "read error (%d): addr=0x%02x", status, addr);
+
+	return val;
+}
+
+static u16 nb6_readw(struct nb6_data *data, u8 addr, u16 val)
+{
+	u8 tmp;
+
+	tmp = nb6_readb(data, addr, (val >> 8) & 0xff);
+	val = (val & 0xff) | (tmp << 8);
+
+	tmp = nb6_readb(data, addr + 1, val & 0xff);
+	val = (val & 0xff00) | tmp;
+
+	return val;
+}
+
+static s32 nb6_writeb(struct nb6_data *data, u8 addr, u8 val)
+{
+	int status;
+	unsigned i;
+
+	for (i = 0; i < NB6_I2C_RETRIES; i++) {
+		status = i2c_smbus_write_byte_data(data->i2c, addr, val);
+		if (!status)
+			return 0;
+		udelay(NB6_DELAY);
+	}
+
+	dev_err(data->dev, "write error (%d): addr=0x%02x val=0x%02x", status, addr, val);
+
+	return status;
+}
+
+static inline void leds_mode_update(struct nb6_data *data, u8 val)
+{
+	if ((data->leds_mode != val) &&
+	    !nb6_writeb(data, NB6_LEDS_MODE_REG, val))
+		data->leds_mode = val;
+}
+
+static inline void leds_pwm_update(struct nb6_data *data, u8 id, u8 val)
+{
+	if ((data->leds_pwm[id] != val) &&
+	    !nb6_writeb(data, NB6_PWM(id), val))
+		data->leds_pwm[id] = val;
+}
+
+/* Hardware Monitoring */
+
+static ssize_t dmesg_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct nb6_data *data = dev_get_drvdata(dev);
+	unsigned i;
+
+	mutex_lock(&data->lock);
+
+	if (nb6_writeb(data, NB6_DMESG_CTL_REG, 0)) {
+		mutex_unlock(&data->lock);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < NB6_DMESG_SIZE; i++)
+		buf[i] = nb6_readb(data, NB6_DMESG_VAL_REG, ~0);
+
+	mutex_unlock(&data->lock);
+
+	*buf = '\0';
+
+	return i + 1;
+}
+
+static DEVICE_ATTR_RO(dmesg);
+
+static ssize_t leds_mode_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct nb6_data *data = dev_get_drvdata(dev);
+	loff_t off = 0;
+	unsigned i;
+
+	mutex_lock(&data->lock);
+	data->leds_mode = nb6_readb(data, NB6_LEDS_MODE_REG, data->leds_mode);
+	mutex_unlock(&data->lock);
+
+	for (i = 0; i < ARRAY_SIZE(leds_modes_str); i++) {
+		off += sprintf(buf + off,
+			       (i == data->leds_mode) ? "[%s] " : "%s ",
+			       leds_modes_str[i]);
+	}
+
+	off += sprintf(buf + off, "\n");
+
+	return off;
+}
+
+static ssize_t leds_mode_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct nb6_data *data = dev_get_drvdata(dev);
+	char _s[NB6_LEDS_MODE_LEN];
+	char *s;
+	unsigned i;
+
+	snprintf(_s, sizeof(_s), "%s", buf);
+	s = strstrip(_s);
+	for (i = 0; i < ARRAY_SIZE(leds_modes_str); i++) {
+		if (!strcmp(s, leds_modes_str[i])) {
+			leds_mode_update(data, i);
+			break;
+		}
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(leds_mode);
+
+static ssize_t release_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct nb6_data *data = dev_get_drvdata(dev);
+
+	mutex_lock(&data->lock);
+	data->release = nb6_readb(data, NB6_RELEASE_REG, data->release);
+	mutex_unlock(&data->lock);
+
+	return sprintf(buf, "%u\n", data->release);
+}
+
+static DEVICE_ATTR_RO(release);
+
+static ssize_t stats_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct nb6_data *data = dev_get_drvdata(dev);
+
+	mutex_lock(&data->lock);
+	data->stats_boot = nb6_readb(data, NB6_STATS_BOOT_REG,
+				     data->stats_boot);
+	data->stats_panic = nb6_readb(data, NB6_STATS_PANIC_REG,
+				      data->stats_panic);
+	data->stats_oops = nb6_readb(data, NB6_STATS_OOPS_REG,
+				     data->stats_oops);
+	mutex_unlock(&data->lock);
+
+	return sprintf(buf, "boot: %u\npanic: %u\noops: %u\n",
+		       data->stats_boot, data->stats_panic, data->stats_oops);
+}
+
+static DEVICE_ATTR_RO(stats);
+
+static ssize_t temperature_show(struct device *dev,
+				struct device_attribute *da, char *buf)
+{
+	struct nb6_data *data = dev_get_drvdata(dev);
+
+	mutex_lock(&data->lock);
+	data->temperature = nb6_readw(data, NB6_TEMP_REG, data->temperature);
+	mutex_unlock(&data->lock);
+
+	return sprintf(buf, "%u\n", ADC_Temperature(data->temperature));
+}
+
+static DEVICE_ATTR_RO(temperature);
+
+static ssize_t voltage_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct nb6_data *data = dev_get_drvdata(dev);
+
+	mutex_lock(&data->lock);
+	data->voltage = nb6_readw(data, NB6_VOLTAGE_REG, data->voltage);
+	mutex_unlock(&data->lock);
+
+	return sprintf(buf, "%u\n", ADC_Voltage(data->voltage));
+}
+
+static DEVICE_ATTR_RO(voltage);
+
+static ssize_t watchdog_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct nb6_data *data = dev_get_drvdata(dev);
+
+	mutex_lock(&data->lock);
+	data->watchdog = nb6_readb(data, NB6_WDT_REG, data->watchdog);
+	mutex_unlock(&data->lock);
+
+	return sprintf(buf, "%u\n", data->watchdog);
+}
+
+static ssize_t watchdog_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t len)
+{
+	struct nb6_data *data = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&data->lock);
+	if (!nb6_writeb(data, NB6_WDT_REG, val))
+		data->watchdog = val;
+	mutex_unlock(&data->lock);
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(watchdog);
+
+static struct attribute *nb6_attrs[] = {
+	&dev_attr_dmesg.attr,
+	&dev_attr_leds_mode.attr,
+	&dev_attr_release.attr,
+	&dev_attr_stats.attr,
+	&dev_attr_temperature.attr,
+	&dev_attr_voltage.attr,
+	&dev_attr_watchdog.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(nb6);
+
+/* PWM */
+
+static inline struct nb6_data *to_nb6_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct nb6_data, pwm);
+}
+
+static int nb6_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct nb6_data *data = to_nb6_pwm(chip);
+
+	mutex_lock(&data->lock);
+	if (!nb6_writeb(data, NB6_PWM(pwm->hwpwm), 0))
+		data->leds_pwm[pwm->hwpwm] = 0;
+	else
+		data->leds_pwm[pwm->hwpwm] = ~0;
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static void nb6_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct nb6_data *data = to_nb6_pwm(chip);
+	unsigned i;
+
+	mutex_lock(&data->lock);
+	for (i = 0; i < NB6_LEDS_PWM_COUNT; i++) {
+		if (data->leds_pwm[i]) {
+			leds_mode_update(data, LEDS_MODE_DISABLE);
+			break;
+		}
+	}
+	mutex_unlock(&data->lock);
+}
+
+static int nb6_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			  int duty_ns, int period_ns)
+{
+	struct nb6_data *data = to_nb6_pwm(chip);
+
+	mutex_lock(&data->lock);
+	leds_mode_update(data, LEDS_MODE_CONTROL);
+	leds_pwm_update(data, pwm->hwpwm, duty_ns);
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static int nb6_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct nb6_data *data = to_nb6_pwm(chip);
+
+	mutex_lock(&data->lock);
+	leds_mode_update(data, LEDS_MODE_CONTROL);
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static void nb6_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct nb6_data *data = to_nb6_pwm(chip);
+
+	mutex_lock(&data->lock);
+	leds_pwm_update(data, pwm->hwpwm, 0);
+	mutex_unlock(&data->lock);
+}
+
+static const struct pwm_ops nb6_pwm_ops = {
+	.request = nb6_pwm_request,
+	.free = nb6_pwm_free,
+	.config = nb6_pwm_config,
+	.enable = nb6_pwm_enable,
+	.disable = nb6_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+/* Driver */
+
+static int nb6_hwmon_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct nb6_data *data;
+	struct device *hwmon_dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(struct nb6_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+	data->i2c = client;
+	data->leds_mode = LEDS_MODE_NUM;
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->lock);
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+							   data,
+							   nb6_groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	data->pwm.dev = dev;
+	data->pwm.ops = &nb6_pwm_ops;
+	data->pwm.base = -1;
+	data->pwm.npwm = NB6_LEDS_PWM_COUNT;
+
+	ret = pwmchip_add(&data->pwm);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+};
+
+static const struct of_device_id nb6_hwmon_of_match[] = {
+	{ .compatible = "sfr,nb6_hwmon" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, nb6_hwmon_of_match);
+
+static struct i2c_driver nb6_hwmon_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "nb6-hwmon",
+		.of_match_table = of_match_ptr(nb6_hwmon_of_match),
+	},
+	.probe = nb6_hwmon_probe,
+};
+module_i2c_driver(nb6_hwmon_driver);
-- 
2.26.2

