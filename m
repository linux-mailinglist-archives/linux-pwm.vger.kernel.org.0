Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC7DE309
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 06:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfJUETU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 00:19:20 -0400
Received: from p3plsmtpa06-04.prod.phx3.secureserver.net ([173.201.192.105]:46807
        "EHLO p3plsmtpa06-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbfJUETU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 00:19:20 -0400
Received: from localhost.localdomain ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id MP2oifB4Hr3FgMP31iDyZZ; Sun, 20 Oct 2019 21:12:01 -0700
From:   Jeff LaBundy <jeff@labundy.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Jeff LaBundy <jeff@labundy.com>
Subject: [PATCH 5/8] pwm: Add support for Azoteq IQS620A PWM generator
Date:   Sun, 20 Oct 2019 23:11:20 -0500
Message-Id: <1571631083-4962-6-git-send-email-jeff@labundy.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571631083-4962-1-git-send-email-jeff@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
X-CMAE-Envelope: MS4wfGPUAnpyF199msi0obUD/Jk/09GyevQCOvn6Cx2BDnanBTgXPTJTeVLyFoYEnqpzsyFDMDhjwUA3PzDLvNg1ydU8y8zgJN8RNgMLGZm1OO/eVoePP9wE
 XT18nXQyAULKNyqeyvft2ORSsflpjdUNTF1PGV8gooM6bZbLMHs10pxqnR47vHri0evjQtVFDfNjnFsW5iP4kGkfczCui6OeGTWCO9MmBzaonxGjv+1Psrjg
 b3reozalY8VrtXHc8iArd4uAxcZY+I4V7jSaN9eKOi/1NNClk4VJbpjeXXp9bqscdGQSDmRfZsSocySPLNUu/v4R2zB8hZkXodvz/AjucHhxxsYp0y+v0Asd
 9g64AX8BggwnMJKxHeawqStlOsgK75cgnUOwRsW/SzJxwffdnexAJIGtb7nMkAq6dONB5W5RojAYuuF2fkQMtOzJsLwEa5ZGQ7uHB+eGT3gTcrwupQ2tJODm
 jdK8IoJ+8+fdJXR9WQuaJDeF74qv4Yv1mnjN4Uc9lsj4zoJ7YeI8Ua3n6kM6cEYEUkblR57vomNQxQ+VWIDwDSYgw8DjdLrQ61bhL5MxbF+wMoJl40FVyOy9
 /eiHUna7RDss7Ve8a0ghBh7bHo6yYZz4bSEI0T9D40AKEZLbpKwR6p+do4UJnEEUNYNNap13TkfdgtcZdG0zUcpY0gSOMuxcy5U/gyMFaBJRPGwqTDRDE0KY
 uxQDuRBzRWii0z7zGvjld8aRvdiF/YDm4qpj+6cJvx+olyhyV8FANg==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds support for the Azoteq IQS620A, capable of generating
a 1-kHz PWM output with duty cycle between 0.4% and 100% (inclusive).

Signed-off-by: Jeff LaBundy <jeff@labundy.com>
---
 drivers/pwm/Kconfig       |  10 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-iqs620a.c | 167 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 drivers/pwm/pwm-iqs620a.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e3a2518..712445e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -222,6 +222,16 @@ config PWM_IMX_TPM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx-tpm.
 
+config PWM_IQS620A
+	tristate "Azoteq IQS620A PWM support"
+	depends on MFD_IQS62X
+	help
+	  Generic PWM framework driver for the Azoteq IQS620A multi-function
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called pwm-iqs620a.
+
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 26326ad..27c9bfa 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
+obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
new file mode 100644
index 0000000..6451eb1
--- /dev/null
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Azoteq IQS620A PWM Generator
+ *
+ * Copyright (C) 2019
+ * Author: Jeff LaBundy <jeff@labundy.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/iqs62x.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define IQS620_PWR_SETTINGS			0xD2
+#define IQS620_PWR_SETTINGS_PWM_OUT		BIT(7)
+
+#define IQS620_PWM_DUTY_CYCLE			0xD8
+
+#define IQS620_PWM_PERIOD_NS			1000000
+
+struct iqs620_pwm_private {
+	struct iqs62x_core *iqs62x;
+	struct pwm_chip chip;
+	struct notifier_block notifier;
+	bool ready;
+};
+
+static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    struct pwm_state *state)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct iqs62x_core *iqs62x;
+	int error;
+	int duty_calc = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - 1;
+	u8 duty_clamp = clamp(duty_calc, 0, 0xFF);
+
+	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
+	iqs62x = iqs620_pwm->iqs62x;
+
+	error = regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE, duty_clamp);
+	if (error)
+		return error;
+
+	state->period = IQS620_PWM_PERIOD_NS;
+	state->duty_cycle = (duty_clamp + 1) * IQS620_PWM_PERIOD_NS / 256;
+
+	return regmap_update_bits(iqs62x->map, IQS620_PWR_SETTINGS,
+				  IQS620_PWR_SETTINGS_PWM_OUT,
+				  state->enabled ? 0xFF : 0);
+}
+
+static int iqs620_pwm_notifier(struct notifier_block *notifier,
+			       unsigned long event_flags, void *context)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	struct pwm_state state;
+	int error;
+
+	iqs620_pwm = container_of(notifier, struct iqs620_pwm_private,
+				  notifier);
+
+	if (!iqs620_pwm->ready || !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
+		return NOTIFY_DONE;
+
+	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
+
+	error = iqs620_pwm_apply(&iqs620_pwm->chip,
+				 &iqs620_pwm->chip.pwms[0], &state);
+	if (error) {
+		dev_err(iqs620_pwm->chip.dev,
+			"Failed to re-initialize device: %d\n", error);
+		return NOTIFY_BAD;
+	}
+
+	return NOTIFY_OK;
+}
+
+static void iqs620_pwm_notifier_unregister(void *context)
+{
+	struct iqs620_pwm_private *iqs620_pwm = context;
+	int error;
+
+	error = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
+						   &iqs620_pwm->notifier);
+	if (error)
+		dev_err(iqs620_pwm->chip.dev,
+			"Failed to unregister notifier: %d\n", error);
+}
+
+static const struct pwm_ops iqs620_pwm_ops = {
+	.apply	= iqs620_pwm_apply,
+	.owner	= THIS_MODULE,
+};
+
+static int iqs620_pwm_probe(struct platform_device *pdev)
+{
+	struct iqs620_pwm_private *iqs620_pwm;
+	int error;
+
+	iqs620_pwm = devm_kzalloc(&pdev->dev, sizeof(*iqs620_pwm), GFP_KERNEL);
+	if (!iqs620_pwm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, iqs620_pwm);
+	iqs620_pwm->iqs62x = dev_get_drvdata(pdev->dev.parent);
+
+	iqs620_pwm->chip.dev = &pdev->dev;
+	iqs620_pwm->chip.ops = &iqs620_pwm_ops;
+	iqs620_pwm->chip.base = -1;
+	iqs620_pwm->chip.npwm = 1;
+
+	iqs620_pwm->notifier.notifier_call = iqs620_pwm_notifier;
+	error = blocking_notifier_chain_register(&iqs620_pwm->iqs62x->nh,
+						 &iqs620_pwm->notifier);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to register notifier: %d\n", error);
+		return error;
+	}
+
+	error = devm_add_action_or_reset(&pdev->dev,
+					 iqs620_pwm_notifier_unregister,
+					 iqs620_pwm);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to add action: %d\n", error);
+		return error;
+	}
+
+	error = pwmchip_add(&iqs620_pwm->chip);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to add device: %d\n", error);
+		return error;
+	}
+
+	iqs620_pwm->ready = true;
+
+	return 0;
+}
+
+static int iqs620_pwm_remove(struct platform_device *pdev)
+{
+	struct iqs620_pwm_private *iqs620_pwm = platform_get_drvdata(pdev);
+	int error;
+
+	error = pwmchip_remove(&iqs620_pwm->chip);
+	if (error)
+		dev_err(&pdev->dev, "Failed to remove device: %d\n", error);
+
+	return error;
+}
+
+static struct platform_driver iqs620_pwm_platform_driver = {
+	.driver = {
+		.name	= IQS620_DRV_NAME_PWM,
+	},
+	.probe		= iqs620_pwm_probe,
+	.remove		= iqs620_pwm_remove,
+};
+module_platform_driver(iqs620_pwm_platform_driver);
+
+MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
+MODULE_DESCRIPTION("Azoteq IQS620A PWM Generator");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" IQS620_DRV_NAME_PWM);
-- 
2.7.4

