Return-Path: <linux-pwm+bounces-3246-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCA89783EA
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35B1280D07
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565C145B24;
	Fri, 13 Sep 2024 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR7Yq4Sm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D031448F2;
	Fri, 13 Sep 2024 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240131; cv=none; b=sepzvq6u/T+ZTIbgLNPEeLT/dAePyxVijgtxQPv7j7gy3pHZ+/33xkWx2KvWFjSdRamCXL6x7guPtBDhMlUNYybrp3lF8ihj66jqYSK70UkyvC9TzO2C8hGz7BeQboSiXCPYQbd5CKcXQHdL4ojBf/WTAFquIECheYz0z7d5T38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240131; c=relaxed/simple;
	bh=M+OsxN2/WpgrY2WuTXnjhSOeH+HsWUOEWmKXapd+uZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4PFa0zTEe+Otmy+Bt9cHgrDxBsIsDbr6aoUCwKZEReDVWoIpcgDlNG38pV+C2swgwoV8kFRy0jOMYOAocamM2foxdj06KnaSk+U4746L5MHLKt8ge0dfE1d3n/F0BupJYFj4bYYUPmt/fdjfxQWmGaW9xeWXjDb+gk2K7DbtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR7Yq4Sm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so1163712a12.0;
        Fri, 13 Sep 2024 08:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240127; x=1726844927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahWTGZu8xtSURP9GzlzlPy1xp3tDRlgc6c0AKCVoexk=;
        b=BR7Yq4SmbdXRotfVU041yLt6e0baEWihTblTsUEkoGs00Y/jEd3VuzRL3pIJVJWens
         YkC0vG/Ag6FTHrq175Q6xufyipS4LlXBarN3SoUyCwyWMO5Cg1NZKJYhwg4DTdDG0dtq
         osi0NZWl0o8wtdWfhd/0EPwsOkKGAoCuC9I8sHPn4PO3drR4SMcFcCjKTc69jyRMDULM
         yzTdspE4u8UxrYzaEwETFme6jiPuGmlasKvlFZAbvdhGCP7qtGNsZs3Si3kOFTdbJnGp
         Ggs7HTrQleQ4WXJIIdzkPmpsRvj7XEptAMhH8qjXkkTBE6SomOBfp78tUfKexHgvQtnx
         AHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240127; x=1726844927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahWTGZu8xtSURP9GzlzlPy1xp3tDRlgc6c0AKCVoexk=;
        b=TkTJdnCTtOCBjEw5kSq/eVgQfpu86T+/yjWnrZfR5Rv2J1zkgw9XSNeEo+h5fu1Y/F
         PlMpBJLuu28QF7YxcbEOsXrmeqdX83ViuKj+VQl0lru6syLShyRoqTex1x1oDxPDW3PW
         oP69DSIylLq2kPw/NJ9xN79YMV8MuWUE/c9U/pcLajsMCm3Fpn8mGIfQHvk6pGIl9agu
         mCz/8AyOaHj5L72TB0NzUTramIPG39JGe2dYymaLT1gjp32T+dH/ia9cY201DnNfJ5tg
         CdbvlSap7IdjYiYAFg2qc9KqyvlAZJQJUvKatH1Ei0fQGVbu/G19o73yL9Q1Z3W7ylnh
         BhBw==
X-Forwarded-Encrypted: i=1; AJvYcCUTHTJ1CibVjwisDQuoLOWL/pPzDOVPDIHJscGn4PmHN1My14OVqkTm8weotdPS1+NcwFsPYZWI1L98bA==@vger.kernel.org, AJvYcCVmMEhbPPjs6uUjKkUE4mwAAjxWCSddYd/i+P/af3Bpn1SG3911W4Tq3gOIP46qJpCiE+AQ0nAcnWM4lhY=@vger.kernel.org, AJvYcCWKN1SQEc+AWYVqBP0RtSGj8O9GA4ftMk2QOvTFz+bmfbdYox/DDtaJ1tC2LIxXpPNzSxY6dlHEsEOd@vger.kernel.org, AJvYcCWoMYW1D7bh216hIRRR0gtqqnBJDBUgkNyxtKs1HV0pRQ4jcFa1IdXnC8MPOGtKK+occXZrw932WBnm@vger.kernel.org, AJvYcCWqB/ZFVfzbF8QSvuC1Qb/wL5vI5iVhjiG3q6FwoxrQH93ktLFsxIeQJ2QlTYYi0fRKK37ukrP96rgw7QfG@vger.kernel.org, AJvYcCWqe35wF4uAIRI/crkQIB0mXnSsQo5WCGrhxtDc2yhssULhTV+1GKxzqZfV74uKO7lu8EPcaAW/WyRCn4eqRFXbR24=@vger.kernel.org, AJvYcCWvOk4d7jCyuX37/Tf4Q8OyBgn9lLv/bRE2EuzutpthkRWQJq2B/qs/g+GJmsJEl8eihY3L5boM8YYLl6SLPw==@vger.kernel.org, AJvYcCWyWObt342bdUriv+x7jaT/Mro4GjRtKYr8QtIjb97o2XSTOEsxxza+Y15Tj8zbZDmHCJM9YlTkZLBs@vger.kernel.org
X-Gm-Message-State: AOJu0YykTOw+hLVX1Xsb6GTLwuPSp4gw/puX2wYcJ+FX8oJWZifpDhk1
	a34oYCNusSDmHC8ElwsDn8h+gDbQg+y3BuikoJPnb9H28cVpJl0OxHl0IA==
X-Google-Smtp-Source: AGHT+IGRt5AFeS3wRtD8rPkJeKt6sAW3sCB0CjqoyYMhFWR7JyO6UcA2Os0fgdDTdR2POOYyiFyO9w==
X-Received: by 2002:a05:6402:909:b0:5c0:ac1d:b970 with SMTP id 4fb4d7f45d1cf-5c41e1b52f7mr2990485a12.32.1726240126941;
        Fri, 13 Sep 2024 08:08:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:46 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:56 +0300
Subject: [PATCH v4 13/27] leds: max77705: Add LEDs support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-13-2d2efd5c5877@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=6747;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=M+OsxN2/WpgrY2WuTXnjhSOeH+HsWUOEWmKXapd+uZI=;
 b=+XwhRo/u1iXBMs1CErWIPnhwhGTnk/d3aSSfPiOQyIYSkQLPEB5gIILypvPWqnaNXnD/p5ESj
 M6dLBFDJFlJAcCJjrrEFO3ntk+QAydPTF7qib1WS1mtz6+olo/E6rCE
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

This adds basic support for LEDs for the max77705 PMIC.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v4:
- inline BLINK_(ON|OFF) macro
- remove camel case
- drop backwards compatibility(new driver)
- drop module alias
---
 MAINTAINERS                  |   1 +
 drivers/leds/Kconfig         |   6 ++
 drivers/leds/Makefile        |   1 +
 drivers/leds/leds-max77705.c | 158 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 166 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 716e66bb7982..444cc855a01e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14073,6 +14073,7 @@ F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
 F:	drivers/*/max77693*.c
 F:	drivers/*/max77705*.c
+F:	drivers/leds/leds-max77705.c
 F:	drivers/clk/clk-max77686.c
 F:	drivers/extcon/extcon-max14577.c
 F:	drivers/extcon/extcon-max77693.c
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b784bb74a837..292f9f1a237e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -753,6 +753,12 @@ config LEDS_MAX77650
 	help
 	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated.
 
+config LEDS_MAX77705
+	tristate "LED support for Maxim MAX77705 RGB"
+	depends on MFD_MAX77705 && LEDS_CLASS && I2C
+	help
+	  LED driver for MAX77705 MFD chip from Maxim Integrated.
+
 config LEDS_MAX8997
 	tristate "LED support for MAX8997 PMIC"
 	depends on LEDS_CLASS && MFD_MAX8997
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 18afbb5a23ee..096bf244527d 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
 obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
 obj-$(CONFIG_LEDS_MAX5970)		+= leds-max5970.o
 obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
+obj-$(CONFIG_LEDS_MAX77705)		+= leds-max77705.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
 obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
diff --git a/drivers/leds/leds-max77705.c b/drivers/leds/leds-max77705.c
new file mode 100644
index 000000000000..6190c010b039
--- /dev/null
+++ b/drivers/leds/leds-max77705.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Based on leds-max77650 driver:
+//		Copyright (C) 2018 BayLibre SAS
+//		Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
+//
+// LED driver for MAXIM 77705 MFD.
+// Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.org>
+
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/mfd/max77705-private.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MAX77705_LED_NUM_LEDS		4
+#define MAX77705_LED_EN_MASK		GENMASK(1, 0)
+#define MAX77705_LED_MAX_BRIGHTNESS	0xff
+
+struct max77705_led {
+	struct led_classdev cdev;
+	struct regmap *regmap;
+	unsigned int en_shift;
+	unsigned int reg_brightness;
+};
+
+static struct max77705_led *max77705_to_led(struct led_classdev *cdev)
+{
+	return container_of(cdev, struct max77705_led, cdev);
+}
+
+static int max77705_rgb_blink(struct led_classdev *cdev,
+				unsigned long *delay_on,
+				unsigned long *delay_off)
+{
+	struct max77705_led *led = max77705_to_led(cdev);
+	int value, on_value, off_value;
+
+	on_value = (((*delay_on < 100) ? 0 :
+			(*delay_on < 500) ? *delay_on/100 - 1 :
+			(*delay_on < 3250) ? (*delay_on - 500) / 250 + 4 : 15) << 4);
+	off_value = ((*delay_off < 1) ? 0x00 :
+			(*delay_off < 500) ? 0x01 :
+			(*delay_off < 5000) ? *delay_off / 500 :
+			(*delay_off < 8000) ? (*delay_off - 5000) / 1000 + 10 :
+			(*delay_off < 12000) ? (*delay_off - 8000) / 2000 + 13 : 15);
+	value = on_value | off_value;
+	return regmap_write(led->regmap, MAX77705_RGBLED_REG_LEDBLNK, value);
+}
+
+static int max77705_led_brightness_set(struct led_classdev *cdev,
+					enum led_brightness brightness)
+{
+	struct max77705_led *led = max77705_to_led(cdev);
+	int ret;
+	unsigned long blink_default = 0;
+
+	if (brightness == LED_OFF) {
+		// Flash OFF
+		ret = regmap_update_bits(led->regmap,
+					MAX77705_RGBLED_REG_LEDEN,
+					MAX77705_LED_EN_MASK << led->en_shift, 0);
+		max77705_rgb_blink(cdev, &blink_default, &blink_default);
+	} else {
+		// Set current
+		ret = regmap_write(led->regmap,
+				   led->reg_brightness, brightness);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_update_bits(led->regmap,
+					MAX77705_RGBLED_REG_LEDEN, LED_ON << led->en_shift,
+					MAX77705_LED_EN_MASK << led->en_shift);
+	}
+
+	return ret;
+}
+
+static int max77705_led_probe(struct platform_device *pdev)
+{
+	struct fwnode_handle *child;
+	struct max77705_led *leds, *led;
+	struct device *dev;
+	struct regmap *map;
+	int rv, num_leds;
+	u32 reg;
+
+	dev = &pdev->dev;
+
+	leds = devm_kcalloc(dev, sizeof(*leds),
+				MAX77705_LED_NUM_LEDS, GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	map = dev_get_regmap(dev->parent, NULL);
+	if (!map)
+		return -ENODEV;
+
+	num_leds = device_get_child_node_count(dev);
+	if (!num_leds || num_leds > MAX77705_LED_NUM_LEDS)
+		return -ENODEV;
+
+	device_for_each_child_node(dev, child) {
+		struct led_init_data init_data = {};
+
+		rv = fwnode_property_read_u32(child, "reg", &reg);
+		if (rv || reg >= MAX77705_LED_NUM_LEDS) {
+			rv = -EINVAL;
+			goto err_node_put;
+		}
+
+		led = &leds[reg];
+		led->regmap = map;
+		led->reg_brightness = MAX77705_RGBLED_REG_LED0BRT + reg;
+		led->en_shift = 2 * reg;
+		led->cdev.brightness_set_blocking = max77705_led_brightness_set;
+		led->cdev.blink_set = max77705_rgb_blink;
+		led->cdev.max_brightness = MAX77705_LED_MAX_BRIGHTNESS;
+
+		init_data.fwnode = child;
+		init_data.devicename = "max77705";
+
+		rv = devm_led_classdev_register_ext(dev, &led->cdev,
+							&init_data);
+		if (rv)
+			goto err_node_put;
+
+		rv = max77705_led_brightness_set(&led->cdev, LED_OFF);
+		if (rv)
+			goto err_node_put;
+	}
+
+	return 0;
+err_node_put:
+	fwnode_handle_put(child);
+	return rv;
+}
+
+static const struct of_device_id max77705_led_of_match[] = {
+	{ .compatible = "maxim,max77705-led" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77705_led_of_match);
+
+static struct platform_driver max77705_led_driver = {
+	.driver = {
+		.name = "max77705-led",
+		.of_match_table = max77705_led_of_match,
+	},
+	.probe = max77705_led_probe,
+};
+module_platform_driver(max77705_led_driver);
+
+MODULE_DESCRIPTION("MAXIM 77705 LED driver");
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.2


