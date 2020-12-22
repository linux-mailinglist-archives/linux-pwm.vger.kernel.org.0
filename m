Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B72D2E0FD8
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 22:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgLVVeb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Dec 2020 16:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgLVVea (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Dec 2020 16:34:30 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666DFC0613D6
        for <linux-pwm@vger.kernel.org>; Tue, 22 Dec 2020 13:33:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so16426130wrb.0
        for <linux-pwm@vger.kernel.org>; Tue, 22 Dec 2020 13:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhfAuCcaH8t3qvUFBUt6Wgbz93/Ey/UD5FYcncqyPE8=;
        b=BaABPFGtEyScZ4tT3JW/CONyjp7Shf0NWhJiFLWNQNMfVb5KD6fmKJkl/lw58b/dfi
         cQebrDsTRNyvC/Hf0iXQO7JMIsJU3JjvasylSQHIBrxgOoHD/dxSC1ReYWDH7CX1dWlD
         a2LZRC/JUPMWMqdJZQykhNb9y6Utq4AbdU6C6OTPF90CJIXRLqA2RMZqQG9Yo2muf2Fi
         HhgWejHEN/cd5vci1hOlPjhwb9YVuOo12C/W4UWn7kZb9RL6NhmRc3l7JUJ1AFiJk/KB
         zEENWD36UwNC1r4GmQVZEjuALSj7FfSb5QkwyhU8Y7ugq4GP0rVX3p70mPnMSKMWfzHm
         tA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hhfAuCcaH8t3qvUFBUt6Wgbz93/Ey/UD5FYcncqyPE8=;
        b=unikMy5+3cyEgKfYorBklsIWu0SucDxxmsxcQbewYGnuI7saVCR9fjJWKVEplA48rv
         7KGOtqnzrHr3CguaPvUDBLXjzIJYIJNX2yu35h9XbGG7qpesBOJQynFNCSFxoYNH9xMr
         lsSOLCrCUfq7Gd0vtWgCofmSX7kVi3jgREAo1yEmLTxXtM5cDdAAJKXCfWBeDFiEUpvi
         VlSrzXkyDLL1gqOIsxIwbRnhXH+rqrVrF4F0+JuLfdoccKW5Le1wt5jeIcXhgzo5fLQb
         dpUS0YjbjOjlWLVKVZf7FjUeFVKcNvow4vzQ6eoSMx/Kl8BspkILoEw38mAXizR752yg
         5RoQ==
X-Gm-Message-State: AOAM531aCg5QTVcLRs3dYjdJPzq7HnS7ZVas1Wjp4EtQOMtnXxNXDL8y
        z/mY3Kr3BjPBTxHZNlZQ0I+LOZCLX4QJnA==
X-Google-Smtp-Source: ABdhPJwoW7pU5kFAKQF4Qbk35mQME61Ee8RxAcbSdcX7gtP+Y+f4vvG5nemsmo/hQ36nZd8idcNYhg==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr25795546wrr.103.1608672828777;
        Tue, 22 Dec 2020 13:33:48 -0800 (PST)
Received: from localhost.localdomain (host185127036111.static.fidoka.tech. [185.127.36.111])
        by smtp.gmail.com with ESMTPSA id c10sm34098254wrb.92.2020.12.22.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 13:33:48 -0800 (PST)
From:   Angelo Compagnucci <angelo.compagnucci@gmail.com>
To:     linux-pwm@vger.kernel.org
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] misc: servo-pwm: driver for controlling servo motors via PWM
Date:   Tue, 22 Dec 2020 22:33:42 +0100
Message-Id: <20201222213342.2657026-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Ts patch adds a simple driver to control servo motor position via PWM
signal.
Driver allows to set the angle, the duty cycle at 0 and 180 degrees and
to set the initial position when the driver loads.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 .../devicetree/bindings/misc/servo-pwm.txt    |  30 +++
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/servo-pwm.c                      | 177 ++++++++++++++++++
 4 files changed, 217 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/servo-pwm.txt
 create mode 100644 drivers/misc/servo-pwm.c

diff --git a/Documentation/devicetree/bindings/misc/servo-pwm.txt b/Documentation/devicetree/bindings/misc/servo-pwm.txt
new file mode 100644
index 000000000000..dd3df38bbd7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/servo-pwm.txt
@@ -0,0 +1,30 @@
+Servo motor connected to PWM
+
+Required properties:
+- compatible : should be "servo-pwm".
+
+Each servo is represented as a servo-pwm device.
+
+Servo properties:
+- pwms : PWM property to point to the PWM device (phandle)/port (id) and to
+  specify the period time to be used: <&phandle id period_ns>;
+- duty-0 : (optional) [default 500000] duty cycle to set the servo motor at
+  0 degrees, useful to compensate for devices drift.
+- duty-180 : (optional) [default 2500000] duty cycle to set the servo motor at
+  180 degrees, useful to compensate for devices drift.
+- angle : (optional) [defaul 0] set the starting angle at driver loading.
+
+Example:
+
+pwm: pwm@0 {
+	compatible = "pwm-gpio";
+	pwm-gpio = <&pio 6 3 GPIO_ACTIVE_LOW>;
+};
+
+servo: servo@0 {
+	compatible = "servo-pwm";
+	pwms = <&pwm 0 2000000>;
+	duty-0 = <60000>;
+	duty-180 = <260000>;
+	angle = <90>;
+};
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0d8099..921f179b0fc4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -466,6 +466,15 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config SERVO_PWM
+	tristate "Servo motor positioning"
+	depends on PWM
+	help
+	  Driver to change servo motor angle.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called servo-pwm.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e73330..47796b56d7d7 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_SERVO_PWM)	+= servo-pwm.o
diff --git a/drivers/misc/servo-pwm.c b/drivers/misc/servo-pwm.c
new file mode 100644
index 000000000000..781ef5d79c10
--- /dev/null
+++ b/drivers/misc/servo-pwm.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Angelo Compagnucci <angelo.compagnucci@gmail.com>
+ *
+ * servo-pwm.c - driver for controlling servo motors via pwm.
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/err.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+#define DEFAULT_PERIOD		2000000
+#define DEFAULT_DUTY_0		50000
+#define DEFAULT_DUTY_180	250000
+#define DEFAULT_ANGLE		0
+
+struct servo_pwm_data {
+	u32 duty_0;
+	u32 duty_180;
+	u32 period;
+	u32 angle;
+	struct mutex lock;
+	struct pwm_device *pwm;
+};
+
+static int servo_pwm_set(struct servo_pwm_data *servo_data)
+{
+	u32 new_duty = (servo_data->duty_180 - servo_data->duty_0) /
+			180 * servo_data->angle + servo_data->duty_0;
+	int ret;
+
+	ret = pwm_config(servo_data->pwm, new_duty, servo_data->period);
+
+	return ret;
+}
+
+static ssize_t angle_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct servo_pwm_data *servo_data = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", servo_data->angle);
+}
+
+static ssize_t angle_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct servo_pwm_data *servo_data = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret < 0)
+		return -EINVAL;
+
+	if (val > 180)
+		return -EINVAL;
+
+	mutex_lock(&servo_data->lock);
+
+	servo_data->angle = val;
+
+	ret = servo_pwm_set(servo_data);
+	if (ret) {
+		mutex_unlock(&servo_data->lock);
+		return ret;
+	}
+
+	mutex_unlock(&servo_data->lock);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(angle);
+
+static struct attribute *servo_pwm_attrs[] = {
+	&dev_attr_angle.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(servo_pwm);
+
+static int servo_pwm_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct servo_pwm_data *servo_data;
+	struct pwm_args pargs;
+	int ret = 0;
+
+	servo_data = devm_kzalloc(&pdev->dev, sizeof(*servo_data), GFP_KERNEL);
+	if (!servo_data)
+		return -ENOMEM;
+
+	if (!of_property_read_u32(node, "duty-0", &servo_data->duty_0) == 0)
+		servo_data->duty_0 = DEFAULT_DUTY_0;
+
+	if (!of_property_read_u32(node, "duty-180", &servo_data->duty_180) == 0)
+		servo_data->duty_180 = DEFAULT_DUTY_180;
+
+	if (!of_property_read_u32(node, "angle", &servo_data->angle) == 0)
+		servo_data->angle = DEFAULT_ANGLE;
+
+	servo_data->pwm = devm_of_pwm_get(&pdev->dev, node, NULL);
+	if (IS_ERR(servo_data->pwm)) {
+		ret = PTR_ERR(servo_data->pwm);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "unable to request pwm\n");
+		return ret;
+	}
+
+	pwm_apply_args(servo_data->pwm);
+
+	pwm_get_args(servo_data->pwm, &pargs);
+
+	servo_data->period = pargs.period;
+
+	if (!servo_data->period)
+		servo_data->period = DEFAULT_PERIOD;
+
+	ret = servo_pwm_set(servo_data);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot configure servo: %d\n", ret);
+		return ret;
+	}
+
+	ret = pwm_enable(servo_data->pwm);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot enable servo: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, servo_data);
+
+	ret = devm_device_add_groups(&pdev->dev, servo_pwm_groups);
+	if (ret) {
+		dev_err(&pdev->dev, "error creating sysfs groups: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_servo_pwm_match[] = {
+	{ .compatible = "servo-pwm", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_servo_pwm_match);
+
+static struct platform_driver servo_pwm_driver = {
+	.probe		= servo_pwm_probe,
+	.driver		= {
+		.name	= "servo-pwm",
+		.of_match_table = of_servo_pwm_match,
+	},
+};
+
+module_platform_driver(servo_pwm_driver);
+
+MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
+MODULE_DESCRIPTION("generic PWM servo motor driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

