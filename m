Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB942E0FD7
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 22:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgLVVeL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Dec 2020 16:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgLVVeL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Dec 2020 16:34:11 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2564C0613D3
        for <linux-pwm@vger.kernel.org>; Tue, 22 Dec 2020 13:33:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t16so16408587wra.3
        for <linux-pwm@vger.kernel.org>; Tue, 22 Dec 2020 13:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPlAXrwvCjCr1J4D1FocF0eLUmkGdlrlNutZg6iDtIs=;
        b=T/D0nJsZsDJlRSprntPjSEDJN7Xy3/aBpgKf65b8xt2pxmwF/b2yiXhpvfmHGLYyC2
         hsoWhYj/rzs0sOe796h2cRqtykolMvfl/4D/JW8aKJ2okhh7Ra33XxtySP3ior4bJJG/
         ir7pKYRYgwWxCftUb9XAI/StwrPg9jTvdwjlrMQ+t09QC4sjFZc84Oy41tocHCZ0tkuJ
         5Lb4hP5GBjIoQYmrj0XauFa2kbwGhbwdFMdWUGKxBlhxnL7ZOTacc4YxBDZQEQfR+YCo
         +vSFOLahhol/iTcXi0n5ZLfDkQKQU7IaTGxkDFAXGrWaJimtGHwM7Z6/WAgOZUeiNCBe
         Izzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPlAXrwvCjCr1J4D1FocF0eLUmkGdlrlNutZg6iDtIs=;
        b=AUoL8DuAjbUJP6xCulDXIHYz8FApTkVrNPspJnTx38D7qvnGuCHpobgpeNsxt/iRQy
         /ZicI6PAP6TOKFm7yKvjQFEpqXYI5d/5dBNVP1JYYma0icZVccaqsWNVU1boTEqSKAlF
         m+7LfiFci+1dgy+3J+gDo21gBLha0iy2o7Z56iD6ry+v5NyR/oHDKAv4pCmKrChy8RES
         6jJkJgicAZcIqbTxJj7QFY5nswJGRularBncRQJy08FmvamK+0VL1c8oPWSBtxRC3HLb
         qwROXnNnPx+fkwjj4RBEgNQROfFyYFX4miMoQxraypXIkLtDNridq2dAgenZB6GxQQTj
         hNLQ==
X-Gm-Message-State: AOAM530uXw/+9OluLQ2Lg4WzDK4m/29KDdE49blJDygws5nPE3Bzuxh9
        dM4bN+02hVx/lc0veBRhrYqfBxysifZ2lw==
X-Google-Smtp-Source: ABdhPJyEYiislyuNsPtGpFaxtQgUleKyPwo0od8d9wrPQzckviALLqTA0wy9A6fNLkPI/9Yjbptf0g==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr25809889wrq.47.1608672808559;
        Tue, 22 Dec 2020 13:33:28 -0800 (PST)
Received: from localhost.localdomain (host185127036111.static.fidoka.tech. [185.127.36.111])
        by smtp.gmail.com with ESMTPSA id f9sm36180786wrw.81.2020.12.22.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 13:33:28 -0800 (PST)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
To:     linux-pwm@vger.kernel.org
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] pwm: pwm-gpio: Generic GPIO bit-banged PWM driver
Date:   Tue, 22 Dec 2020 22:33:25 +0100
Message-Id: <20201222213325.2656124-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds a driver to generate a PWM signal on a generic GPIO pin.
Driver can use hrtimers when available to allow nano-second resolution,
the precision of the resulting signal depends on the switching speed of
the gpio pins, timers and the system load.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-gpio.txt      |  14 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-gpio.c                        | 244 ++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.txt
 create mode 100644 drivers/pwm/pwm-gpio.c

diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.txt b/Documentation/devicetree/bindings/pwm/pwm-gpio.txt
new file mode 100644
index 000000000000..fe15569c0332
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.txt
@@ -0,0 +1,14 @@
+Generic GPIO bit-banged PWM driver
+
+Required properties:
+  - compatible: should be "pwm-gpio"
+  - pwm-gpio: gpio describing the used gpio, see the gpio
+    bindings for the used gpio driver.
+
+Example:
+#include <dt-bindings/gpio/gpio.h>
+
+	pwm: pwm@0 {
+		compatible = "pwm-gpio";
+		pwm-gpio = <&pio 7 1 GPIO_ACTIVE_LOW>;
+	};
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0937e1c047ac..47c8b68a5f13 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -195,6 +195,16 @@ config PWM_FSL_FTM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-fsl-ftm.
 
+config PWM_GPIO
+	tristate "Generic GPIO bit-banged PWM support"
+	depends on GPIOLIB
+	depends on PWM
+	help
+	  Driver to generate soft PWM on GPIO pin.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-gpio.
+
 config PWM_HIBVT
 	tristate "HiSilicon BVT PWM support"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 18b89d7fd092..4d2aad6eb3bc 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
+obj-$(CONFIG_PWM_GPIO)		+= pwm-gpio.o
 obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
new file mode 100644
index 000000000000..6d38a47f82fb
--- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Angelo Compagnucci <angelo.compagnucci@gmail.com>
+ *
+ * pwm-gpio.c - driver for pwm output on gpio via high resolution timers.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/hrtimer.h>
+#include <linux/ktime.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+struct gpio_pwm_chip {
+	struct pwm_chip chip;
+};
+
+struct gpio_pwm_data {
+
+	bool is_running;
+	bool polarity;
+	bool pin_on;
+	unsigned int on_time;
+	unsigned int off_time;
+	struct mutex lock;
+	struct hrtimer timer;
+	struct gpio_desc *gpio_pwm;
+};
+
+static void gpio_pwm_off(struct gpio_pwm_data *gpio_data)
+{
+	gpiod_set_value_cansleep(gpio_data->gpio_pwm,
+		gpio_data->polarity ? 1 : 0);
+	gpio_data->pin_on = false;
+}
+
+static void gpio_pwm_on(struct gpio_pwm_data *gpio_data)
+{
+	gpiod_set_value_cansleep(gpio_data->gpio_pwm,
+		gpio_data->polarity ? 0 : 1);
+	gpio_data->pin_on = true;
+}
+
+enum hrtimer_restart gpio_pwm_timer(struct hrtimer *timer)
+{
+	struct gpio_pwm_data *gpio_data = container_of(timer,
+						  struct gpio_pwm_data,
+						  timer);
+
+	if (!gpio_data->pin_on) {
+		gpio_pwm_on(gpio_data);
+		hrtimer_forward_now(&gpio_data->timer,
+				    ns_to_ktime(gpio_data->on_time));
+	} else {
+		gpio_pwm_off(gpio_data);
+		hrtimer_forward_now(&gpio_data->timer,
+				    ns_to_ktime(gpio_data->off_time));
+	}
+
+	return HRTIMER_RESTART;
+}
+
+static int gpio_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    int duty_ns, int period_ns)
+{
+	struct gpio_pwm_data *gpio_data = pwm_get_chip_data(pwm);
+
+	mutex_lock(&gpio_data->lock);
+	gpio_data->on_time = duty_ns;
+	gpio_data->off_time = period_ns - duty_ns;
+	mutex_unlock(&gpio_data->lock);
+
+	return 0;
+}
+
+static int gpio_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+				 enum pwm_polarity polarity)
+{
+	struct gpio_pwm_data *gpio_data = pwm_get_chip_data(pwm);
+
+	mutex_lock(&gpio_data->lock);
+	gpio_data->polarity = (polarity != PWM_POLARITY_NORMAL) ? true : false;
+	mutex_unlock(&gpio_data->lock);
+
+	return 0;
+}
+
+static int gpio_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct gpio_pwm_data *gpio_data = pwm_get_chip_data(pwm);
+
+	mutex_lock(&gpio_data->lock);
+
+	if (gpio_data->is_running) {
+		mutex_unlock(&gpio_data->lock);
+		return -EBUSY;
+	}
+
+	gpio_data->is_running = true;
+	hrtimer_start(&gpio_data->timer, ktime_set(0, 0),
+			HRTIMER_MODE_REL);
+
+	mutex_unlock(&gpio_data->lock);
+
+	return 0;
+}
+
+static void gpio_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct gpio_pwm_data *gpio_data = pwm_get_chip_data(pwm);
+
+	mutex_lock(&gpio_data->lock);
+
+	if (!gpio_data->is_running) {
+		mutex_unlock(&gpio_data->lock);
+		return;
+	}
+
+	hrtimer_cancel(&gpio_data->timer);
+	gpio_pwm_off(gpio_data);
+	gpio_data->is_running = false;
+
+	mutex_unlock(&gpio_data->lock);
+}
+
+static int gpio_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct gpio_pwm_data *gpio_data;
+	struct gpio_desc *gpio_pwm;
+
+	gpio_data = kzalloc(sizeof(*gpio_data), GFP_KERNEL);
+	if (!gpio_data)
+		return -ENOMEM;
+
+	gpio_pwm = gpiod_get(chip->dev, "pwm", GPIOD_OUT_LOW);
+	if (IS_ERR(gpio_pwm)) {
+		dev_err(chip->dev, "failed to retrieve pwm from dts\n");
+		return PTR_ERR(gpio_pwm);
+	}
+
+	hrtimer_init(&gpio_data->timer,
+		     CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	if (!hrtimer_is_hres_active(&gpio_data->timer))
+		dev_warn(chip->dev, "HR timer unavailable, restricting to, low resolution\n");
+
+	gpio_data->timer.function = &gpio_pwm_timer;
+	gpio_data->gpio_pwm = gpio_pwm;
+	gpio_data->pin_on = false;
+	gpio_data->is_running = false;
+
+	return pwm_set_chip_data(pwm, gpio_data);
+}
+
+static void gpio_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct gpio_pwm_data *gpio_data = pwm_get_chip_data(pwm);
+
+	gpio_pwm_disable(chip, pwm);
+	gpiod_put(gpio_data->gpio_pwm);
+	kfree(gpio_data);
+}
+
+static const struct pwm_ops gpio_pwm_ops = {
+	.config         = gpio_pwm_config,
+	.set_polarity   = gpio_pwm_set_polarity,
+	.enable         = gpio_pwm_enable,
+	.disable        = gpio_pwm_disable,
+	.request        = gpio_pwm_request,
+	.free           = gpio_pwm_free,
+	.owner          = THIS_MODULE,
+};
+
+static int gpio_pwm_probe(struct platform_device *pdev)
+{
+	struct gpio_pwm_chip *gpio_chip;
+	int ret;
+
+	gpio_chip = devm_kzalloc(&pdev->dev, sizeof(*gpio_chip), GFP_KERNEL);
+	if (!gpio_chip)
+		return -ENOMEM;
+
+	gpio_chip->chip.dev = &pdev->dev;
+	gpio_chip->chip.ops = &gpio_pwm_ops;
+	gpio_chip->chip.base = -1;
+	gpio_chip->chip.npwm = 1;
+
+	ret = pwmchip_add(&gpio_chip->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add pwm gpio chip %d\n", ret);
+		return -ENODEV;
+	}
+
+	platform_set_drvdata(pdev, gpio_chip);
+
+	return 0;
+}
+
+static int gpio_pwm_remove(struct platform_device *pdev)
+{
+	struct gpio_pwm_chip *gpio_chip = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&gpio_chip->chip);
+}
+
+static const struct of_device_id gpio_pwm_of_match[] = {
+	{ .compatible = "pwm-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gpio_pwm_of_match);
+
+static struct platform_driver gpio_pwm_driver = {
+	.probe = gpio_pwm_probe,
+	.remove = gpio_pwm_remove,
+	.driver = {
+		.name = "pwm-gpio",
+		.of_match_table = of_match_ptr(gpio_pwm_of_match),
+	},
+};
+module_platform_driver(gpio_pwm_driver);
+
+MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
+MODULE_DESCRIPTION("Generic GPIO bit-banged PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

