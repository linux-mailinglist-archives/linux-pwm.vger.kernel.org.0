Return-Path: <linux-pwm+bounces-2518-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF4790D683
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 17:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF28B24A50
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6881A01B9;
	Tue, 18 Jun 2024 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFU/fJNi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677D1A00CF;
	Tue, 18 Jun 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719235; cv=none; b=uISn4HKfM5+6osFDcB0EOY1Tlshrr6b0OKmbRjorFqsIYYxx7ibhhVQ3z9Z0kLl2u+BzS1wH0jDkG9ntXPk/LEUCmF+tjaR5SJFxYyY6LNf9Pla1eFSOX1LnzDxdtn+n52SV7dQiaqze6wSz2ZvAd3bwB2RRNxpyGkgwJoUBwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719235; c=relaxed/simple;
	bh=M+uc6GTvoNAckqEvB4YdUBo7gTDSwvEY9HdmtBtM0OA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUEMjG3C5POw2oTDoARBqnYZfJshcF5DK+HAMqyFDnOzmrTQyDgKpdWNC+FVRw2S4OQ27kh6EY03Swj52uPoaBThKqPJj7rMEIxlT7ek8+Sy0K6QH7SPclw7rDB/Y2rJ6O1+WqVlNqMYs2L/NPAka5WC2SapFhVDBeV2FV8v1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFU/fJNi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cc7e85b4bso2284452a12.0;
        Tue, 18 Jun 2024 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719231; x=1719324031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4ELQwjzHA4yApdsWewX3oXEq3EZwSJvDLoYd1jNQ34=;
        b=YFU/fJNiLdWH8K5pTEa8pKMdTc8UeFGXXaecMbItRVi4/091B7mJ6hPwY2Fc8U2av8
         qFJYnuCGEUpcbnM472oqomhNm/cRU6LyfLPwTDLLv5FRPVal9KbDnkCCpvJSd1K5U9mE
         gYcnC098z3Gkze3wC+FPMRVyT3TEs60A2hO6dyHFnK42ocMoGaYFsBDvZqW/LhNwTiXK
         hB+EFpw/oLtNzkqME+7uarAjt1vWOpDGXAEmarzxH/O3Dv9AHm2k/XRp3sdsxwf/+DNU
         YB5LrQGpFNNbUWnmkkrhXdUMhawpTXfJ6+xbzaSYskPpeajROVJmAB/aIck0K+JH3soJ
         HEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719231; x=1719324031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4ELQwjzHA4yApdsWewX3oXEq3EZwSJvDLoYd1jNQ34=;
        b=tR4nMkREcZ8Awn9lxhIsvBVyEieW4PNT0M5GPQjflET4hdTJPESQVpwroje9L3Ymxj
         ZEtClSj1EjRQPkpRxO8CG/0lNWOUB3iXTUHVcEiJxLrkWtYlT3E9EyxsKMdTxNKjMOGL
         4zfoRevnVw/LiX1bExnfi7mXzkZrMQ3HlIeIV5aV+b5d+kyoqxFiybyG6CY8zZacsE2s
         KsJ+whuuN5Ecy+VqaKWo0lVzfwKZzRRFLu4G7nvBkhL738j+H2EEX8OVTtivCBavRj0c
         xcSeqa9hx43lpJ1aAuXNVsT50bxg6L1ydI8lcCr4uMok3HwRLC3Wg/GO7ZjEidpNxvW9
         Ru/g==
X-Forwarded-Encrypted: i=1; AJvYcCUVs5dF93p/EwERhr7XLYEVB0tl+Hhb/9hKPvDoUhsVJCopONSRlPnw7ps6qXZZuEX35j452vCld8DTS12uDC+uWyHbPhLxbEBY0LLeMfQpQlzGaTgriYAeF/ZYdI9rywWxqFNd+GgOofWTIGa93QRgQJBmCiXP6LdFrmJGFLHLC6n1YiGnkOFpExZEmS0iJ+YjdWTkDo57a3cJlZcieFNbtX/JkhYDcOuhf6OtR1hrHymWlEAZ1g9p7VS2rOAOtfEa2Yxsb1cRqDVmDK36LSJ3HzA+hXL/y7CIVGi5nCPQs41N4S2fwx5bl7g9h1i9DEVtJriwxburcrqvngVxZyu8V6wRQWXqzBN0BnRSETOPKKKb4aTr+8ngGuCy7C67QF4oKKsqiME1w8dnrxoHeA8JOU0B2ziP
X-Gm-Message-State: AOJu0YxSn0OKja92Tmq5FI9ORdYeNEm/CNMwhPs2kyD7LyKKpQhO89E0
	1JLilEhsZeBohDIKYKfPJenhKNVbe7sUUMjwQ27BbllJPbmPctNI
X-Google-Smtp-Source: AGHT+IG56CjchONS6I1JegFr/43CXmjz4UPasXM/HnpGFAACjVWB6VLqx/Impr4a3DUI4prupBUQPg==
X-Received: by 2002:a50:998c:0:b0:57c:c171:2fb6 with SMTP id 4fb4d7f45d1cf-57cf7a4e148mr1877504a12.1.1718719231063;
        Tue, 18 Jun 2024 07:00:31 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.07.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:30 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:53 +0300
Subject: [PATCH v3 19/23] power: supply: s2dos05: Add fuel gauge driver for
 s2dos05
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-19-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719185; l=18925;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=M+uc6GTvoNAckqEvB4YdUBo7gTDSwvEY9HdmtBtM0OA=;
 b=wYpibWI2SfJGhhqeC25dhyZfx7jwIHK7peeTCQGamB97n/dYfX6y9D6lfjfMafBFp9MtQEP2c
 PSrkGaJweMFBPaMye7WabuIUy9Ns45BE7DW5DmrdldpFpOVCId66k3E
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add fuel gauge driver for s2dos05 PMIC. It uses adc to measure power
on each power output s2dos05 provides, including regulator outputs
and AVDD, ELVSS, ELVDD lines. Driver registers power supply for each
corresponding power line.

Adc can be disabled and enabled via sysfs.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 MAINTAINERS                       |   1 +
 drivers/power/supply/Kconfig      |   8 +
 drivers/power/supply/Makefile     |   1 +
 drivers/power/supply/s2dos05-fg.c | 427 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/s2dos05.h       | 123 +++++++++++
 5 files changed, 560 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bee700a5e648..2c5d9a74f977 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19910,6 +19910,7 @@ F:	Documentation/devicetree/bindings/regulator/samsung,s5m*.yaml
 F:	drivers/clk/clk-s2mps11.c
 F:	drivers/mfd/s2dos*.c
 F:	drivers/mfd/sec*.c
+F:	drivers/power/supply/s2dos*.c
 F:	drivers/regulator/s2dos*.c
 F:	drivers/regulator/s2m*.c
 F:	drivers/regulator/s5m*.c
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index a3fdfcb5aa64..22090b150885 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -964,6 +964,14 @@ config CHARGER_SURFACE
 	  Microsoft Surface devices, i.e. Surface Pro 7, Surface Laptop 3,
 	  Surface Book 3, and Surface Laptop Go.
 
+config FUEL_GAUGE_S2DOS05
+	tristate "Power measurement driver for s2dos05 pmic"
+	depends on MFD_S2DOS_CORE
+	help
+	  This driver measures power consumption of s2dos05 regulator consumers.
+
+	  Say M or Y here to include power measurement ability in s2dos05 pmic.
+
 config BATTERY_UG3105
 	tristate "uPI uG3105 battery monitor driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index e1abad8b6b75..fcea83c8aa79 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
 obj-$(CONFIG_BATTERY_ACER_A500)	+= acer_a500_battery.o
 obj-$(CONFIG_BATTERY_SURFACE)	+= surface_battery.o
 obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
+obj-$(CONFIG_FUEL_GAUGE_S2DOS05)	+= s2dos05-fg.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_pmi8998_charger.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
diff --git a/drivers/power/supply/s2dos05-fg.c b/drivers/power/supply/s2dos05-fg.c
new file mode 100644
index 000000000000..d2070f90c80c
--- /dev/null
+++ b/drivers/power/supply/s2dos05-fg.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * s2dos05-fg.c
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd
+ *              http://www.samsung.com
+ * Copyright (c) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
+ *
+ */
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/mfd/samsung/s2dos-core.h>
+#include <linux/mfd/samsung/s2dos05.h>
+
+#define SYNC_MODE	1
+#define ASYNC_MODE	2
+
+struct s2dos05_fg {
+	struct regmap *regmap;
+	struct device *dev;
+	u8 adc_sync_mode;
+	struct power_supply	*psy_elvdd;
+	struct power_supply	*psy_elvss;
+	struct power_supply	*psy_avdd;
+	struct power_supply	*psy_buck;
+	struct power_supply	*psy_ldo1;
+	struct power_supply	*psy_ldo2;
+	struct power_supply	*psy_ldo3;
+	struct power_supply	*psy_ldo4;
+};
+
+static const unsigned int power_coeffs[8] = {POWER_ELVDD, POWER_ELVSS, POWER_AVDD,
+	POWER_BUCK, POWER_L1, POWER_L2, POWER_L3, POWER_L4};
+
+static void s2dos05_is_online(struct s2dos05_fg *drv_data, int *val)
+{
+	unsigned int adc_ctrl2;
+
+	regmap_read(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL2, &adc_ctrl2);
+	if ((adc_ctrl2 & ADC_EN_MASK) > 0)
+		*val = 1;
+	else
+		*val = 0;
+}
+
+static void s2dos05_start_measurement_if_async(struct s2dos05_fg *drv_data, unsigned int channel)
+{
+	unsigned int temp;
+
+	if (drv_data->adc_sync_mode == ASYNC_MODE) {
+		regmap_read(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL1, &temp);
+		if (!(temp & PWRMT_EN_CHK))
+			return;
+
+		regmap_update_bits(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL1,
+							ADC_ASYNCRD_MASK, ADC_ASYNCRD_MASK);
+		usleep_range(2000, 2100);
+	}
+}
+
+static void s2dos05_adc_read_power(struct s2dos05_fg *drv_data, unsigned int channel, int *val)
+{
+	unsigned int data_l, data_h, adc_val;
+
+	regmap_update_bits(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL2, ADC_PTR_MASK,
+				2*channel);
+	regmap_read(drv_data->regmap, S2DOS05_REG_PWRMT_DATA,
+				&data_l);
+
+	regmap_update_bits(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL2, ADC_PTR_MASK,
+				2*channel+1);
+	regmap_read(drv_data->regmap, S2DOS05_REG_PWRMT_DATA,
+				&data_h);
+
+	adc_val = ((data_h & 0xff) << 8) | (data_l & 0xff);
+	*val = adc_val * power_coeffs[channel] / 100;
+}
+
+static int s2dos05_get_adc_validity(struct s2dos05_fg *drv_data)
+{
+	unsigned int adc_validity;
+
+	regmap_read(drv_data->regmap, S2DOS05_REG_OCL, &adc_validity);
+	return !!(adc_validity | ADC_VALID_MASK);
+}
+
+static ssize_t adc_en_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct s2dos05_fg *drv_data = dev_get_drvdata(dev);
+	unsigned int adc_ctrl3;
+
+	regmap_read(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL2, &adc_ctrl3);
+	if ((adc_ctrl3 & ADC_EN_MASK) > 0)
+		return snprintf(buf, PAGE_SIZE, "ADC enable (%x)\n", adc_ctrl3);
+	else
+		return snprintf(buf, PAGE_SIZE, "ADC disable (%x)\n", adc_ctrl3);
+}
+
+static ssize_t adc_en_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct s2dos05_fg *drv_data = dev_get_drvdata(dev);
+	int ret;
+	unsigned int temp, val;
+
+	ret = kstrtouint(buf, 16, &temp);
+	if (ret)
+		return -EINVAL;
+
+	switch (temp) {
+	case 0:
+		val = 0x00;
+		break;
+	case 1:
+		val = 0x80;
+		break;
+	default:
+		val = 0x00;
+		break;
+	}
+
+	regmap_update_bits(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL2, ADC_EN_MASK,
+				val);
+	return count;
+}
+
+static ssize_t adc_sync_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct s2dos05_fg *drv_data = dev_get_drvdata(dev);
+
+	switch (drv_data->adc_sync_mode) {
+	case SYNC_MODE:
+		return snprintf(buf, PAGE_SIZE, "SYNC_MODE (%d)\n", drv_data->adc_sync_mode);
+	case ASYNC_MODE:
+		return snprintf(buf, PAGE_SIZE, "ASYNC_MODE (%d)\n", drv_data->adc_sync_mode);
+	default:
+		return snprintf(buf, PAGE_SIZE, "error (%d)\n", drv_data->adc_sync_mode);
+	}
+}
+
+static ssize_t adc_sync_mode_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct s2dos05_fg *drv_data = dev_get_drvdata(dev);
+	int ret;
+	u8 temp;
+
+	ret = kstrtou8(buf, 16, &temp);
+	if (ret)
+		return -EINVAL;
+
+	switch (temp) {
+	case SYNC_MODE:
+		drv_data->adc_sync_mode = 1;
+		break;
+	case ASYNC_MODE:
+		drv_data->adc_sync_mode = 2;
+		break;
+	default:
+		drv_data->adc_sync_mode = 1;
+		break;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(adc_en);
+static DEVICE_ATTR_RW(adc_sync_mode);
+
+static int s2dos05_fg_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val,
+					 unsigned int channel
+					 )
+{
+	struct s2dos05_fg *drv_data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		s2dos05_is_online(drv_data, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		if (s2dos05_get_adc_validity(drv_data))
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+		else
+			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		break;
+	case POWER_SUPPLY_PROP_POWER_NOW:
+		s2dos05_start_measurement_if_async(drv_data, channel);
+		s2dos05_adc_read_power(drv_data, channel, &val->intval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int s2dos05_fg_get_property_elvdd(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val
+					 )
+{
+	return s2dos05_fg_get_property(psy, psp, val, CHANNEL_ELVDD);
+}
+
+static int s2dos05_fg_get_property_elvss(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val
+					 )
+{
+	return s2dos05_fg_get_property(psy, psp, val, CHANNEL_ELVSS);
+}
+
+static int s2dos05_fg_get_property_avdd(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val
+					 )
+{
+	return s2dos05_fg_get_property(psy, psp, val, CHANNEL_AVDD);
+}
+
+static int s2dos05_fg_get_property_buck(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val
+					 )
+{
+	return s2dos05_fg_get_property(psy, psp, val, CHANNEL_BUCK);
+}
+
+static int s2dos05_fg_get_property_ldo1(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val
+					 )
+{
+	return s2dos05_fg_get_property(psy, psp, val, CHANNEL_L1);
+}
+
+static int s2dos05_fg_get_property_ldo2(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val
+					 )
+{
+	return s2dos05_fg_get_property(psy, psp, val, CHANNEL_L2);
+}
+
+static int s2dos05_fg_get_property_ldo3(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val
+					 )
+{
+	return s2dos05_fg_get_property(psy, psp, val, CHANNEL_L3);
+}
+
+static int s2dos05_fg_get_property_ldo4(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val
+					 )
+{
+	return s2dos05_fg_get_property(psy, psp, val, CHANNEL_L4);
+}
+
+static void s2dos05_powermeter_init(struct s2dos05_fg *drv_data)
+{
+	/*  SMP_NUM = 1100(16384) ~16s in case of aync mode */
+	regmap_write(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL1, 0x0C);
+	regmap_update_bits(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL2, POWER_MODE,
+			POWER_MODE);
+	/* ADC EN */
+	regmap_update_bits(drv_data->regmap, S2DOS05_REG_PWRMT_CTRL2,
+			ADC_EN_MASK, ADC_EN_MASK);
+
+}
+
+static void s2dos05_powermeter_deinit(struct s2dos05_fg *s2dos05)
+{
+	/* ADC turned off */
+	regmap_write(s2dos05->regmap, S2DOS05_REG_PWRMT_CTRL2, 0);
+}
+
+static enum power_supply_property s2dos05_fg_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_POWER_NOW,
+};
+
+static const struct power_supply_desc s2dos05_elvdd_fg_desc = {
+	.name		= "s2dos05_elvdd",
+	.type		= POWER_SUPPLY_TYPE_UNKNOWN,
+	.get_property	= s2dos05_fg_get_property_elvdd,
+	.properties	= s2dos05_fg_properties,
+	.num_properties	= ARRAY_SIZE(s2dos05_fg_properties),
+};
+
+static const struct power_supply_desc s2dos05_elvss_fg_desc = {
+	.name		= "s2dos05_elvss",
+	.type		= POWER_SUPPLY_TYPE_UNKNOWN,
+	.get_property	= s2dos05_fg_get_property_elvss,
+	.properties	= s2dos05_fg_properties,
+	.num_properties	= ARRAY_SIZE(s2dos05_fg_properties),
+};
+
+static const struct power_supply_desc s2dos05_avdd_fg_desc = {
+	.name		= "s2dos05_avdd",
+	.type		= POWER_SUPPLY_TYPE_UNKNOWN,
+	.get_property	= s2dos05_fg_get_property_avdd,
+	.properties	= s2dos05_fg_properties,
+	.num_properties	= ARRAY_SIZE(s2dos05_fg_properties),
+};
+
+static const struct power_supply_desc s2dos05_buck_fg_desc = {
+	.name		= "s2dos05_buck",
+	.type		= POWER_SUPPLY_TYPE_UNKNOWN,
+	.get_property	= s2dos05_fg_get_property_buck,
+	.properties	= s2dos05_fg_properties,
+	.num_properties	= ARRAY_SIZE(s2dos05_fg_properties),
+};
+
+static const struct power_supply_desc s2dos05_ldo1_fg_desc = {
+	.name		= "s2dos05_ldo1",
+	.type		= POWER_SUPPLY_TYPE_UNKNOWN,
+	.get_property	= s2dos05_fg_get_property_ldo1,
+	.properties	= s2dos05_fg_properties,
+	.num_properties	= ARRAY_SIZE(s2dos05_fg_properties),
+};
+
+static const struct power_supply_desc s2dos05_ldo2_fg_desc = {
+	.name		= "s2dos05_ldo2",
+	.type		= POWER_SUPPLY_TYPE_UNKNOWN,
+	.get_property	= s2dos05_fg_get_property_ldo2,
+	.properties	= s2dos05_fg_properties,
+	.num_properties	= ARRAY_SIZE(s2dos05_fg_properties),
+};
+
+static const struct power_supply_desc s2dos05_ldo3_fg_desc = {
+	.name		= "s2dos05_ldo3",
+	.type		= POWER_SUPPLY_TYPE_UNKNOWN,
+	.get_property	= s2dos05_fg_get_property_ldo3,
+	.properties	= s2dos05_fg_properties,
+	.num_properties	= ARRAY_SIZE(s2dos05_fg_properties),
+};
+
+static const struct power_supply_desc s2dos05_ldo4_fg_desc = {
+	.name		= "s2dos05_ldo4",
+	.type		= POWER_SUPPLY_TYPE_UNKNOWN,
+	.get_property	= s2dos05_fg_get_property_ldo4,
+	.properties	= s2dos05_fg_properties,
+	.num_properties	= ARRAY_SIZE(s2dos05_fg_properties),
+};
+
+static int s2dos05_fuelgauge_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct s2dos_core *iodev = dev_get_drvdata(dev->parent);
+	struct s2dos05_fg	*drv_data;
+	struct power_supply_config pscfg = {};
+	int ret;
+
+	drv_data = devm_kzalloc(dev, sizeof(struct s2dos05_fg),
+							GFP_KERNEL);
+	if (!drv_data)
+		ret = -ENOMEM;
+
+	drv_data->regmap = iodev->regmap;
+	s2dos05_powermeter_init(drv_data);
+	pscfg.drv_data = drv_data;
+
+	drv_data->psy_elvdd = devm_power_supply_register(dev, &s2dos05_elvdd_fg_desc, &pscfg);
+	drv_data->psy_elvss = devm_power_supply_register(dev, &s2dos05_elvss_fg_desc, &pscfg);
+	drv_data->psy_avdd = devm_power_supply_register(dev, &s2dos05_avdd_fg_desc, &pscfg);
+	drv_data->psy_buck = devm_power_supply_register(dev, &s2dos05_buck_fg_desc, &pscfg);
+	drv_data->psy_ldo1 = devm_power_supply_register(dev, &s2dos05_ldo1_fg_desc, &pscfg);
+	drv_data->psy_ldo2 = devm_power_supply_register(dev, &s2dos05_ldo2_fg_desc, &pscfg);
+	drv_data->psy_ldo3 = devm_power_supply_register(dev, &s2dos05_ldo3_fg_desc, &pscfg);
+	drv_data->psy_ldo4 = devm_power_supply_register(dev, &s2dos05_ldo4_fg_desc, &pscfg);
+
+	platform_set_drvdata(pdev, drv_data);
+
+	ret = device_create_file(&pdev->dev, &dev_attr_adc_en);
+	if (ret) {
+		dev_err(dev, "failed: create adc enable sysfs entry\n");
+		goto err;
+	}
+	ret = device_create_file(&pdev->dev, &dev_attr_adc_sync_mode);
+	if (ret) {
+		dev_err(dev, "failed: create adc sync mode sysfs entry\n");
+		goto err;
+	}
+
+err:
+	device_remove_file(dev, &dev_attr_adc_en);
+	device_remove_file(dev, &dev_attr_adc_sync_mode);
+
+	return 0;
+}
+
+static void s2dos05_fuelgauge_remove(struct platform_device *pdev)
+{
+	struct s2dos05_fg *info = platform_get_drvdata(pdev);
+
+	s2dos05_powermeter_deinit(info);
+
+	device_remove_file(&pdev->dev, &dev_attr_adc_en);
+	device_remove_file(&pdev->dev, &dev_attr_adc_sync_mode);
+}
+
+static const struct platform_device_id s2dos05_platform_ids[] = {
+	{"s2dos05-fg", 0},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, s2dos05_platform_ids);
+
+static struct platform_driver s2dos05_platform_driver = {
+	.driver = {
+		.name = "s2dos05-fg",
+	},
+	.probe = s2dos05_fuelgauge_probe,
+	.id_table = s2dos05_platform_ids,
+	.remove_new = s2dos05_fuelgauge_remove,
+};
+module_platform_driver(s2dos05_platform_driver);
+
+MODULE_DESCRIPTION("s2dos05 power meter");
+MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/s2dos05.h b/include/linux/mfd/s2dos05.h
new file mode 100644
index 000000000000..8d216064bc78
--- /dev/null
+++ b/include/linux/mfd/s2dos05.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ * s2dos05.h
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd
+ *              http://www.samsung.com
+ *
+ */
+
+#ifndef __LINUX_MFD_S2DOS05_H
+#define __LINUX_MFD_S2DOS05_H
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MFD_DEV_NAME "s2dos05"
+
+struct s2dos05_dev {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+/* S2DOS05 registers */
+/* Slave Addr : 0xC0 */
+enum S2DOS05_reg {
+	S2DOS05_REG_DEV_ID,
+	S2DOS05_REG_TOPSYS_STAT,
+	S2DOS05_REG_STAT,
+	S2DOS05_REG_EN,
+	S2DOS05_REG_LDO1_CFG,
+	S2DOS05_REG_LDO2_CFG,
+	S2DOS05_REG_LDO3_CFG,
+	S2DOS05_REG_LDO4_CFG,
+	S2DOS05_REG_BUCK_CFG,
+	S2DOS05_REG_BUCK_VOUT,
+	S2DOS05_REG_IRQ_MASK = 0x0D,
+	S2DOS05_REG_SSD_TSD = 0x0E,
+	S2DOS05_REG_OCL = 0x10,
+	S2DOS05_REG_IRQ = 0x11
+};
+
+/* S2DOS05 regulator ids */
+enum S2DOS05_regulators {
+	S2DOS05_LDO1,
+	S2DOS05_LDO2,
+	S2DOS05_LDO3,
+	S2DOS05_LDO4,
+	S2DOS05_BUCK1,
+	S2DOS05_REG_MAX,
+};
+
+#define S2DOS05_IRQ_PWRMT_MASK	BIT(5)
+#define S2DOS05_IRQ_TSD_MASK	BIT(4)
+#define S2DOS05_IRQ_SSD_MASK	BIT(3)
+#define S2DOS05_IRQ_SCP_MASK	BIT(2)
+#define S2DOS05_IRQ_UVLO_MASK	BIT(1)
+#define S2DOS05_IRQ_OCD_MASK	BIT(0)
+
+#define S2DOS05_BUCK_MIN1	506250
+#define S2DOS05_LDO_MIN1	1500000
+#define S2DOS05_LDO_MIN2	2700000
+#define S2DOS05_BUCK_STEP1	6250
+#define S2DOS05_LDO_STEP1	25000
+#define S2DOS05_LDO_VSEL_MASK	0x7F
+#define S2DOS05_LDO_FD_MASK	0x80
+#define S2DOS05_BUCK_VSEL_MASK	0xFF
+#define S2DOS05_BUCK_FD_MASK	0x08
+
+#define S2DOS05_ENABLE_MASK_L1	BIT(0)
+#define S2DOS05_ENABLE_MASK_L2	BIT(1)
+#define S2DOS05_ENABLE_MASK_L3	BIT(2)
+#define S2DOS05_ENABLE_MASK_L4	BIT(3)
+#define S2DOS05_ENABLE_MASK_B1	BIT(4)
+
+#define S2DOS05_RAMP_DELAY	12000
+
+#define S2DOS05_ENABLE_TIME_LDO		50
+#define S2DOS05_ENABLE_TIME_BUCK	350
+
+#define S2DOS05_ENABLE_SHIFT	0x06
+#define S2DOS05_LDO_N_VOLTAGES	(S2DOS05_LDO_VSEL_MASK + 1)
+#define S2DOS05_BUCK_N_VOLTAGES (S2DOS05_BUCK_VSEL_MASK + 1)
+
+#define S2DOS05_PMIC_EN_SHIFT	6
+#define S2DOS05_REGULATOR_MAX (S2DOS05_REG_MAX)
+
+/* ----------power meter ----------*/
+#define S2DOS05_REG_PWRMT_CTRL1		0x0A
+#define S2DOS05_REG_PWRMT_CTRL2		0x0B
+#define S2DOS05_REG_PWRMT_DATA	0x0C
+#define S2DOS05_REG_IRQ_MASK	0x0D
+
+#define CHANNEL_ELVDD	0
+#define CHANNEL_ELVSS	1
+#define CHANNEL_AVDD	2
+#define CHANNEL_BUCK	3
+#define CHANNEL_L1	4
+#define CHANNEL_L2	5
+#define CHANNEL_L3	6
+#define CHANNEL_L4	7
+
+#define POWER_ELVDD			24500
+#define POWER_ELVSS			24500
+#define POWER_AVDD			3060
+#define POWER_BUCK			1525
+#define POWER_L1			5000
+#define POWER_L2			5000
+#define POWER_L3			5000
+#define POWER_L4			5000
+
+/* S2DOS05_REG_OCL */
+#define ADC_VALID_MASK			BIT(7)
+/* S2DOS05_REG_PWRMT_CTRL1 */
+#define ADC_ASYNCRD_MASK		BIT(7)
+#define PWRMT_EN_CHK			BIT(6)
+#define SMPNUM_MASK			0x0F
+/* S2DOS05_REG_PWRMT_CTRL2 */
+#define ADC_EN_MASK			BIT(7)
+#define ADC_PTR_MASK			0x0F
+#define POWER_MODE			BIT(4)
+#define RAWCURRENT_MODE			BIT(5)
+
+#define S2DOS05_MAX_ADC_CHANNEL		8
+
+#endif /*  __LINUX_MFD_S2DOS05_H */

-- 
2.39.2


