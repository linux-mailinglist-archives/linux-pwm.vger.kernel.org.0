Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACD5288CB0
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Oct 2020 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbgJIPax (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Oct 2020 11:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389297AbgJIPaw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 9 Oct 2020 11:30:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 767AAAF30;
        Fri,  9 Oct 2020 15:30:50 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        wahrenst@gmx.net,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] pwm: Add Raspberry Pi Firmware based PWM bus
Date:   Fri,  9 Oct 2020 17:30:30 +0200
Message-Id: <20201009153031.986-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009153031.986-1-nsaenzjulienne@suse.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Adds support to control the PWM bus available in official Raspberry Pi
PoE HAT. Only RPi's co-processor has access to it, so commands have to
be sent through RPi's firmware mailbox interface.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/pwm/Kconfig           |   7 ++
 drivers/pwm/Makefile          |   1 +
 drivers/pwm/pwm-raspberrypi.c | 216 ++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
 create mode 100644 drivers/pwm/pwm-raspberrypi.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 63be5362fd3a..a76997ca37d0 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -379,6 +379,13 @@ config PWM_PXA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-pxa.
 
+config PWM_RASPBERRYPI
+	tristate "Raspberry Pi Firwmware PWM support"
+	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
+	help
+	  Enable Raspberry Pi firmware controller PWM bus used to control the
+	  official RPI PoE hat
+
 config PWM_RCAR
 	tristate "Renesas R-Car PWM support"
 	depends on ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index cbdcd55d69ee..b557b549d9f3 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
+obj-$(CONFIG_PWM_RASPBERRYPI)	+= pwm-raspberrypi.o
 obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
diff --git a/drivers/pwm/pwm-raspberrypi.c b/drivers/pwm/pwm-raspberrypi.c
new file mode 100644
index 000000000000..1ccff6b1ae34
--- /dev/null
+++ b/drivers/pwm/pwm-raspberrypi.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#include <soc/bcm2835/raspberrypi-firmware.h>
+#include <dt-bindings/pwm/raspberrypi,firmware-pwm.h>
+
+#define RPI_PWM_MAX_DUTY		255
+#define RPI_PWM_PERIOD_NS		80000 /* 12.5KHz */
+
+#define RPI_PWM_CUR_DUTY_REG		0x0
+#define RPI_PWM_DEF_DUTY_REG		0x1
+
+struct raspberrypi_pwm {
+	struct rpi_firmware *firmware;
+	struct pwm_chip chip;
+	unsigned int duty_cycle;
+};
+
+struct raspberrypi_pwm_prop {
+	__le32 reg;
+	__le32 val;
+	__le32 ret;
+} __packed;
+
+static inline struct raspberrypi_pwm *to_raspberrypi_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct raspberrypi_pwm, chip);
+}
+
+static int raspberrypi_pwm_set_property(struct rpi_firmware *firmware,
+					u32 reg, u32 val)
+{
+	struct raspberrypi_pwm_prop msg = {
+		.reg = cpu_to_le32(reg),
+		.val = cpu_to_le32(val),
+	};
+	int ret;
+
+	ret = rpi_firmware_property(firmware, RPI_FIRMWARE_SET_POE_HAT_VAL,
+				    &msg, sizeof(msg));
+	if (ret)
+		return ret;
+	else if (msg.ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int raspberrypi_pwm_get_property(struct rpi_firmware *firmware,
+					u32 reg, u32 *val)
+{
+	struct raspberrypi_pwm_prop msg = {
+		.reg = reg
+	};
+	int ret;
+
+	ret = rpi_firmware_property(firmware, RPI_FIRMWARE_GET_POE_HAT_VAL,
+				    &msg, sizeof(msg));
+	if (ret)
+		return ret;
+	else if (msg.ret)
+		return -EIO;
+
+	*val = le32_to_cpu(msg.val);
+
+	return 0;
+}
+
+static void raspberrypi_pwm_get_state(struct pwm_chip *chip,
+				      struct pwm_device *pwm,
+				      struct pwm_state *state)
+{
+	struct raspberrypi_pwm *pc = to_raspberrypi_pwm(chip);
+
+	state->period = RPI_PWM_PERIOD_NS;
+	state->duty_cycle = pc->duty_cycle * RPI_PWM_PERIOD_NS / RPI_PWM_MAX_DUTY;
+	state->enabled = !!(pc->duty_cycle);
+	state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static int raspberrypi_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			         const struct pwm_state *state)
+{
+	struct raspberrypi_pwm *pc = to_raspberrypi_pwm(chip);
+	unsigned int duty_cycle;
+	int ret;
+
+	if (!state->enabled)
+		duty_cycle = 0;
+	else
+		duty_cycle = state->duty_cycle * RPI_PWM_MAX_DUTY /
+			     RPI_PWM_PERIOD_NS;
+
+	if (duty_cycle == pc->duty_cycle)
+		return 0;
+
+	pc->duty_cycle = duty_cycle;
+	ret = raspberrypi_pwm_set_property(pc->firmware, RPI_PWM_CUR_DUTY_REG,
+					   pc->duty_cycle);
+	if (ret) {
+		dev_err(chip->dev, "Failed to set duty cycle: %d\n", ret);
+		return ret;
+	}
+
+	ret = raspberrypi_pwm_set_property(pc->firmware, RPI_PWM_CUR_DUTY_REG,
+					   pc->duty_cycle);
+	if (ret) {
+		dev_err(chip->dev, "Failed to set default duty cycle: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops raspberrypi_pwm_ops = {
+	.get_state = raspberrypi_pwm_get_state,
+	.apply = raspberrypi_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static struct pwm_device *raspberrypi_pwm_xlate(struct pwm_chip *pc,
+					const struct of_phandle_args *args)
+{
+	struct pwm_device *pwm;
+
+	if (args->args[0] >= pc->npwm)
+		return ERR_PTR(-EINVAL);
+
+	pwm = pwm_request_from_chip(pc, args->args[0], NULL);
+	if (IS_ERR(pwm))
+		return pwm;
+
+	/* Firmwre won't let us change the period */
+	pwm->args.period = RPI_PWM_PERIOD_NS;
+
+	return pwm;
+}
+
+static int raspberrypi_pwm_probe(struct platform_device *pdev)
+{
+	struct device_node *firmware_node;
+	struct device *dev = &pdev->dev;
+	struct rpi_firmware *firmware;
+	struct raspberrypi_pwm *pc;
+	int ret;
+
+	firmware_node = of_get_parent(dev->of_node);
+	if (!firmware_node) {
+		dev_err(dev, "Missing firmware node\n");
+		return -ENOENT;
+	}
+
+	firmware = rpi_firmware_get(firmware_node);
+	of_node_put(firmware_node);
+	if (!firmware)
+		return -EPROBE_DEFER;
+
+	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return -ENOMEM;
+
+	pc->firmware = firmware;
+
+	pc->chip.dev = dev;
+	pc->chip.ops = &raspberrypi_pwm_ops;
+	pc->chip.of_xlate = raspberrypi_pwm_xlate;
+	pc->chip.of_pwm_n_cells = 1;
+	pc->chip.base = -1;
+	pc->chip.npwm = RASPBERRYPI_FIRMWARE_PWM_NUM;
+
+	platform_set_drvdata(pdev, pc);
+
+	ret = raspberrypi_pwm_get_property(pc->firmware, RPI_PWM_CUR_DUTY_REG,
+					   &pc->duty_cycle);
+	if (ret) {
+		dev_err(dev, "Failed to get duty cycle: %d\n", ret);
+		return ret;
+	}
+
+	return pwmchip_add(&pc->chip);
+}
+
+static int raspberrypi_pwm_remove(struct platform_device *pdev)
+{
+	struct raspberrypi_pwm *pc = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&pc->chip);
+}
+
+static const struct of_device_id raspberrypi_pwm_of_match[] = {
+	{ .compatible = "raspberrypi,firmware-pwm", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, raspberrypi_pwm_of_match);
+
+static struct platform_driver raspberrypi_pwm_driver = {
+	.driver = {
+		.name = "raspberrypi-pwm",
+		.of_match_table = raspberrypi_pwm_of_match,
+	},
+	.probe = raspberrypi_pwm_probe,
+	.remove = raspberrypi_pwm_remove,
+};
+module_platform_driver(raspberrypi_pwm_driver);
+
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
+MODULE_DESCRIPTION("Raspberry Pi Firwmare Based PWM Bus Driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.28.0

