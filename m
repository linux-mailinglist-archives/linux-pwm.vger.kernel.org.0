Return-Path: <linux-pwm+bounces-3245-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA99783E1
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0641C21B83
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936613DBB6;
	Fri, 13 Sep 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqlNIIHM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60B13C9A2;
	Fri, 13 Sep 2024 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240128; cv=none; b=OBn+k7G97zddafSNlnohI8/xapl/NZX0OCIDrxn9vSDkuVsZY7XTfLJqt30nRAbPXqF8POjcCoI/3j/3/itWHaVzws1FacMeOFazGHJY4NexMOCqJLAdC54vuOwrDKQNOc87YNOoRJA0RLCEa2Dr77G6c756ZPZ5M+X+yPMT3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240128; c=relaxed/simple;
	bh=p+WSYslVsxknZs6ezCVMZEXQSewZUJ6+jj6SYxMX/RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxRjiard7tbSwj8ubLAzLCwPgEjCmMkQ/Ys2h/vcfg4j4ZFyxUJr7BWWkOd92Exhn6wbQCsawAzvd0b+ulJghCx3rLqRQqEPRIe38lBbos/l4mYpzuw95+qrzECoWCaG5HhEYBQvaZE9bF2V4CzdCtay+NtFjNYPBagNozR43N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqlNIIHM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso60308166b.3;
        Fri, 13 Sep 2024 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240124; x=1726844924; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pupmYNFojwa4AS9hnAothqKw0lYUAY5hOWiwFnl9YiU=;
        b=FqlNIIHM4XlJYpm9Jxek9ehqnWFKaJyPGYDTGhYDaxmXnLANA5q7kjvtDY6azUOzSk
         nmxb0Jufr5Oz615Ekmt+8VjWGXUOqzSY3axxGIOkPmSgze4ssl6z07W2iwsXpKMyE68r
         Pu1PjZ3rR6+9rlXLXt6LdkcpWH7ePG0cFGzbl+KlXNO/8tyy9U9jzLbqrOlpdtVmUNfI
         5PzHMAnx9w/eesdk+JGOhPSYpdo97FhTLp9SC1Hpa7h906pld04kSlpgr4qFbMRIPmWE
         8vkRzT55f6Qka/6OG0sw03RnQ3NARjDc/FLiEVDCNyB6GAkZxUmtBeF6A+FnF+xZcLYs
         lJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240124; x=1726844924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pupmYNFojwa4AS9hnAothqKw0lYUAY5hOWiwFnl9YiU=;
        b=BO/QV4POMnx74ixOK/abiO87kxYTzH3gKN4DvnLic9Jhps/HITo1yfJiWAAAEi3PjL
         rxsvcyPdKHBi1sSoJ7dXfZwwJVU57yrEj07aPyoX5dcnQvifx0dPlnLLuDsa8IzBAwnH
         laSjnBSF+96icz51cetP1PwV8eGoVqxjAsHKpfeDEf7c8iwRBKWr7tEnFhtNwDu7B8XP
         e5CZM7DvSHSa7ykYacSr7ZkxnQrwmrJGmbC0nFv26ETAhGBIIRcmQyS1JnKLQ3I0We5z
         L/jNNjuI1siVq1tifzJB8XBcjcqJK0N2qOWx7B5776g/aBZ/7IZPBN6kjR8tkbdEPc4s
         PJjg==
X-Forwarded-Encrypted: i=1; AJvYcCURbIlyspscZCPXXgu7Qh43OPjaea9NK/DKuiIgSxrMkKPa3mspflQITNP8RNgXSy8BGa4/GQJI03eeeLADFg==@vger.kernel.org, AJvYcCVaZYqE2iyDedDr1qhPYWm19TfGMwljXu/b9kmWmy54FWZSz442eDXQ5Pv0whQspAfsHd/7eUJ1QbN/@vger.kernel.org, AJvYcCW5L7PCayNzsngEiz1yP1MriTgV/CIN8Qh4tS63skH81gB/1jqfw7Yn5fZT4wVPTjE+Gggk6WC6HZ4BOA==@vger.kernel.org, AJvYcCWcCJfDUbNlxaYsen4RMaztFXRQS9mJaU9ku1h51e3kj3w22Pa95+hX8nTp3+h9nCyO0IYIL9FzOzm/CjjGa/auNa4=@vger.kernel.org, AJvYcCWx9egTSdVtB5tRUjqMP4xCODmGLhueET052l/rf54nSroaykOKOwUbQH7jx88nUmnN+jiyyO5YSoXurzTq@vger.kernel.org, AJvYcCX9MQXgECu5AXy7yKUIkrSHMEwOl+ioMXcC3YxLWfbRyPkZ6eGi0hxpENbvFa54319JnbkJ+qJQgxll@vger.kernel.org, AJvYcCXAGVpvquCv7/9Qv+fZL6Sa+6eT4tXq9R+RXCaARhTxGESmcZCO1nUbDbFG87Ao5qaktOD6gay8vNvM@vger.kernel.org, AJvYcCXq1XIt96Elb6rgL2KpgnVVqRrOl7P4Zn7X3UssitswASBCT54BWnJd1OZn4P12q/ly3IRlOBb/TwlBRRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNcrS02rPXcl87tBeDT6osjceayk9XeYMe02JxuH7/UCxD7rY
	zbPisc/Ylk8URo2y9ljP2AEnfwEUODRdYiFyAGwhwLd91rf/XYrDRo/E8g==
X-Google-Smtp-Source: AGHT+IEwbSvNiugjatMh5BW7pw654QzCKiuKr8XxbLHe0e9IwPRYy9qAEQel0IXS+Gtge68TspDb6g==
X-Received: by 2002:a05:6402:1e88:b0:5c4:235a:e66 with SMTP id 4fb4d7f45d1cf-5c4235a119amr1712431a12.34.1726240124417;
        Fri, 13 Sep 2024 08:08:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:43 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:55 +0300
Subject: [PATCH v4 12/27] power: supply: max77705: Add fuel gauge driver
 for Maxim 77705
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-12-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=14886;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=p+WSYslVsxknZs6ezCVMZEXQSewZUJ6+jj6SYxMX/RQ=;
 b=94tpNsMnOvVyHJE97Q0jZ//9/tTO1wnWXgUdGLy2Yw50uE3n/30goPk3ZKiHeeEdsNpW7TCbX
 tzHZMdgRaGkBbPNOWjbPF0sR6MUuK4B/r31+uyv3CWk7WFVhnSvNn74
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add driver for Maxim 77705 fuel gauge (part of max77705
MFD driver) providing power supply class information to userspace.

The driver is configured through DTS (battery and system related
settings).

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes for V4:
- rework driver from scratch
- change word delimiters in filenames to "_"
- remove debugfs code
- cleanup header
---
 drivers/power/supply/Kconfig               |   7 +
 drivers/power/supply/Makefile              |   1 +
 drivers/power/supply/max77705_fuel_gauge.c | 348 +++++++++++++++++++++++++++++
 include/linux/power/max77705_fuelgauge.h   |  65 ++++++
 4 files changed, 421 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index fe84d2004f57..0b2da9d88a80 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -579,6 +579,13 @@ config CHARGER_MAX77705
 	help
 	  Say Y to enable support for the Maxim MAX77705 battery charger.
 
+config FUEL_GAUGE_MAX77705
+	tristate "MAX77705 fuel gauge driver"
+	depends on MFD_MAX77705
+	default n
+	help
+	  Say Y to enable support for MAXIM MAX77705 fuel gauge driver.
+
 config CHARGER_MAX77976
 	tristate "Maxim MAX77976 battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index daa9228fa04b..b949600a6207 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
 obj-$(CONFIG_CHARGER_MAX77705)	+= max77705_charger.o
+obj-$(CONFIG_FUEL_GAUGE_MAX77705)	+= max77705_fuel_gauge.o
 obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
 obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
 obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
diff --git a/drivers/power/supply/max77705_fuel_gauge.c b/drivers/power/supply/max77705_fuel_gauge.c
new file mode 100644
index 000000000000..90d695bfdf9f
--- /dev/null
+++ b/drivers/power/supply/max77705_fuel_gauge.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.org>
+//
+// Fuel gauge driver for MAXIM 77705 charger/power-supply.
+
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/max77693-common.h>
+#include <linux/mfd/max77705-private.h>
+#include <linux/power/max77705_fuelgauge.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+static const char *max77705_fuelgauge_model		= "max77705";
+static const char *max77705_fuelgauge_manufacturer	= "Maxim Integrated";
+
+static enum power_supply_property max77705_fuelgauge_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
+};
+
+static int max77705_fg_read_reg(struct max77705_fuelgauge_data *fuelgauge,
+				unsigned int reg, unsigned int *val)
+{
+	struct regmap *regmap = fuelgauge->regmap;
+	u8 data[2];
+	int ret;
+
+	ret = regmap_noinc_read(regmap, reg, data, sizeof(data));
+	if (ret < 0)
+		return ret;
+
+	*val = (data[1] << 8) + data[0];
+
+	return 0;
+}
+
+static int max77705_fg_read_temp(struct max77705_fuelgauge_data *fuelgauge,
+				 int *val)
+{
+	struct regmap *regmap = fuelgauge->regmap;
+	u8 data[2] = { 0, 0 };
+	int ret, temperature = 0;
+
+	ret = regmap_noinc_read(regmap, TEMPERATURE_REG, data, sizeof(data));
+	if (ret < 0)
+		return ret;
+
+	if (data[1] & BIT(7))
+		temperature = ((~(data[1])) & 0xFF) + 1;
+	else
+		temperature = data[1] & 0x7f;
+
+	temperature *= 10;
+	temperature += data[0] * 10 / 256;
+	*val = temperature;
+
+	return 0;
+}
+
+static int max77705_fg_check_battery_present(struct max77705_fuelgauge_data
+					     *fuelgauge, int *val)
+{
+	struct regmap *regmap = fuelgauge->regmap;
+	u8 status_data[2];
+	int ret;
+
+	ret = regmap_noinc_read(regmap, STATUS_REG, status_data, sizeof(status_data));
+	if (ret < 0)
+		return ret;
+
+	*val = !(status_data[0] & MAX77705_BAT_ABSENT_MASK);
+
+	return 0;
+}
+
+static int max77705_battery_get_status(struct max77705_fuelgauge_data *fuelgauge,
+					int *val)
+{
+	int current_now;
+	int am_i_supplied;
+	int ret;
+	unsigned int soc_rep;
+
+	am_i_supplied = power_supply_am_i_supplied(fuelgauge->psy_fg);
+	if (am_i_supplied) {
+		if (am_i_supplied == -ENODEV) {
+			dev_err(fuelgauge->dev,
+				"power supply not found, fall back to current-based status checking\n");
+		} else {
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+			return 0;
+		}
+	}
+	ret = max77705_fg_read_reg(fuelgauge, SOCREP_REG, &soc_rep);
+	if (ret)
+		return ret;
+
+	if (soc_rep < 100) {
+		ret = max77705_fg_read_reg(fuelgauge, CURRENT_REG, &current_now);
+		if (ret)
+			return ret;
+
+		if (current_now > 0)
+			*val = POWER_SUPPLY_STATUS_CHARGING;
+		else if (current_now < 0)
+			*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	} else {
+		*val = POWER_SUPPLY_STATUS_FULL;
+	}
+
+	return 0;
+}
+
+static void max77705_unit_adjustment(struct max77705_fuelgauge_data *fuelgauge,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	const unsigned int base_unit_conversion = 1000;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		val->intval = max77705_fg_vs_convert(val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = max77705_fg_cs_convert(val->intval,
+						     fuelgauge->rsense_conductance);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval *= base_unit_conversion;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = min(val->intval, 100);
+		break;
+	default:
+		dev_dbg(fuelgauge->dev,
+			"%s: no need for unit conversion %d\n", __func__, psp);
+	}
+}
+
+static int max77705_fg_get_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    union power_supply_propval *val)
+{
+	struct max77705_fuelgauge_data *fuelgauge =
+	    power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = max77705_battery_get_status(fuelgauge, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = max77705_fg_check_battery_present(fuelgauge, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, VCELL_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		ret = max77705_fg_read_reg(fuelgauge, VFOCV_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		ret = max77705_fg_read_reg(fuelgauge, AVR_VCELL_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, CURRENT_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		ret = max77705_fg_read_reg(fuelgauge, AVG_CURRENT_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, REMCAP_REP_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		ret = max77705_fg_read_reg(fuelgauge, FULLCAP_REP_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		ret = max77705_fg_read_reg(fuelgauge, DESIGNCAP_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = max77705_fg_read_reg(fuelgauge, SOCREP_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = max77705_fg_read_temp(fuelgauge, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, TIME_TO_EMPTY_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
+		ret = max77705_fg_read_reg(fuelgauge, TIME_TO_FULL_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CYCLE_COUNT:
+		ret = max77705_fg_read_reg(fuelgauge, CYCLES_REG, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = max77705_fuelgauge_model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = max77705_fuelgauge_manufacturer;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	max77705_unit_adjustment(fuelgauge, psp, val);
+
+	return 0;
+}
+
+static const struct power_supply_desc max77705_fg_desc = {
+	.name = "max77705-fuel-gauge",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = max77705_fuelgauge_props,
+	.num_properties = ARRAY_SIZE(max77705_fuelgauge_props),
+	.get_property = max77705_fg_get_property,
+};
+
+static int max77705_fg_set_charge_design(struct regmap *regmap, int value)
+{
+	u8 data[2];
+	int value_mah;
+
+	value_mah = value / 1000;
+	data[0] = value_mah & 0xFF;
+	data[1] = (value_mah >> 8) & 0xFF;
+
+	return regmap_noinc_write(regmap, DESIGNCAP_REG, data, sizeof(data));
+}
+
+static int max77705_battery_settings(struct max77705_fuelgauge_data *fuelgauge)
+{
+	struct power_supply_battery_info *info;
+	struct regmap *regmap = fuelgauge->regmap;
+	int ret;
+
+	ret = power_supply_get_battery_info(fuelgauge->psy_fg, &info);
+	if (ret)
+		return ret;
+
+	fuelgauge->bat_info = info;
+
+	if (info->energy_full_design_uwh != info->charge_full_design_uah) {
+		if (info->charge_full_design_uah == -EINVAL)
+			dev_warn(fuelgauge->dev, "missing battery:charge-full-design-microamp-hours\n");
+		ret = max77705_fg_set_charge_design(regmap, info->charge_full_design_uah);
+	}
+
+	return ret;
+}
+
+static int max77705_fuelgauge_parse_dt(struct max77705_fuelgauge_data
+				       *fuelgauge)
+{
+	struct device *dev = fuelgauge->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+	unsigned int rsense;
+
+	if (!np) {
+		dev_err(dev, "no fuelgauge OF node\n");
+		return -EINVAL;
+	}
+	ret = of_property_read_u32(np, "shunt-resistor-micro-ohms",
+				   &rsense);
+	if (ret < 0) {
+		dev_warn(dev, "No shunt-resistor-micro-ohms property, assume default\n");
+		fuelgauge->rsense_conductance = 100;
+	} else
+		fuelgauge->rsense_conductance = 1000000 / rsense; /* rsense conductance in Ohm^-1 */
+
+	return 0;
+}
+
+static int max77705_fuelgauge_probe(struct platform_device *pdev)
+{
+	struct max77693_dev *max77705 = dev_get_drvdata(pdev->dev.parent);
+	struct max77705_fuelgauge_data *fuelgauge;
+	struct power_supply_config fuelgauge_cfg = { };
+	struct device *dev = &pdev->dev;
+	int ret = 0;
+
+	fuelgauge = devm_kzalloc(dev, sizeof(*fuelgauge), GFP_KERNEL);
+	if (!fuelgauge)
+		return -ENOMEM;
+
+	fuelgauge->dev = dev;
+	fuelgauge->regmap = max77705->regmap_fg;
+
+	ret = max77705_fuelgauge_parse_dt(fuelgauge);
+	if (ret < 0)
+		return ret;
+
+	fuelgauge_cfg.drv_data = fuelgauge;
+	fuelgauge_cfg.of_node = fuelgauge->dev->of_node;
+
+	fuelgauge->psy_fg = devm_power_supply_register(&pdev->dev,
+							&max77705_fg_desc,
+							&fuelgauge_cfg);
+
+	if (IS_ERR(fuelgauge->psy_fg))
+		return PTR_ERR(fuelgauge->psy_fg);
+
+	return max77705_battery_settings(fuelgauge);
+}
+
+static const struct of_device_id max77705_fg_of_match[] = {
+	{ .compatible = "maxim,max77705-fuel-gauge" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77705_fg_of_match);
+
+static struct platform_driver max77705_fuelgauge_driver = {
+	.driver = {
+		.name = "max77705-fuel-gauge",
+		.of_match_table = max77705_fg_of_match,
+	},
+	.probe = max77705_fuelgauge_probe,
+};
+module_platform_driver(max77705_fuelgauge_driver);
+
+MODULE_DESCRIPTION("Samsung max77705 Fuel Gauge Driver");
+MODULE_AUTHOR("Samsung Electronics");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/power/max77705_fuelgauge.h b/include/linux/power/max77705_fuelgauge.h
new file mode 100644
index 000000000000..599b3fb5a7e4
--- /dev/null
+++ b/include/linux/power/max77705_fuelgauge.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+//
+// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.org>
+//
+// Fuel gauge driver header for MAXIM 77705 charger/power-supply.
+
+#ifndef __MAX77705_FUELGAUGE_H
+#define __MAX77705_FUELGAUGE_H __FILE__
+
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+
+#define ALERT_EN 0x04
+#define CAPACITY_SCALE_DEFAULT_CURRENT 1000
+#define CAPACITY_SCALE_HV_CURRENT 600
+// Current and capacity values are displayed as a voltage
+// and must be divided by the sense resistor to determine Amps or Amp-hours.
+// This should be applied to all current, charge, energy registers,
+// except ModelGauge m5 Algorithm related ones.
+// current sense resolution
+#define MAX77705_FG_CS_ADC_RESOLUTION	15625 // 1.5625 microvolts
+// voltage sense resolution
+#define MAX77705_FG_VS_ADC_RESOLUTION	78125 // 78.125 microvolts
+// CONFIG_REG register
+#define MAX77705_SOC_ALERT_EN_MASK	BIT(2)
+// When set to 1, external temperature measurements should be written from the host
+#define MAX77705_TEX_MASK		BIT(8)
+// Enable Thermistor
+#define MAX77705_ETHRM_MASK		BIT(5)
+// CONFIG2_REG register
+#define MAX77705_AUTO_DISCHARGE_EN_MASK BIT(9)
+// STATUS_REG register
+#define MAX77705_BAT_ABSENT_MASK	BIT(3)
+
+// @brief Convert voltage register value to micro volts
+// @param reg_val - register value
+// @return voltage in micro Volts
+inline u64 max77705_fg_vs_convert(u16 reg_val)
+{
+	u64 result = (u64)reg_val * MAX77705_FG_VS_ADC_RESOLUTION;
+
+	return result / 1000;
+}
+
+// @brief Convert current register value to micro volts
+// @param reg_val - register value
+// @param rsense_conductance - current sense resistor conductance in Ohm^-1
+// @return voltage in micro Volts
+inline s32 max77705_fg_cs_convert(s16 reg_val, u32 rsense_conductance)
+{
+	s64 result = (s64)reg_val * rsense_conductance * MAX77705_FG_CS_ADC_RESOLUTION;
+
+	return result / 10000;
+}
+
+struct max77705_fuelgauge_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct power_supply *psy_fg;
+	struct power_supply_battery_info *bat_info;
+	u32 rsense_conductance;
+};
+
+#endif // __MAX77705_FUELGAUGE_H

-- 
2.39.2


