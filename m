Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D407E2A6228
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Nov 2020 11:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgKDKkF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 05:40:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:58730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgKDKkE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Nov 2020 05:40:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F7C5ABAE;
        Wed,  4 Nov 2020 10:40:02 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
Date:   Wed,  4 Nov 2020 11:39:37 +0100
Message-Id: <20201104103938.1286-12-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104103938.1286-1-nsaenzjulienne@suse.de>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
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

Changes since v2:
 - Use devm_rpi_firmware_get()
 - Rename driver
 - Small cleanups as per Andy Shevchenko's comments

Changes since v1:
 - Use default pwm bindings and get rid of xlate() function
 - Correct spelling errors
 - Correct apply() function
 - Round values
 - Fix divisions in arm32 mode
 - Small cleanups

 drivers/pwm/Kconfig               |   9 ++
 drivers/pwm/Makefile              |   1 +
 drivers/pwm/pwm-raspberrypi-poe.c | 216 ++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 drivers/pwm/pwm-raspberrypi-poe.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 63be5362fd3a..ab31615f07fc 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -379,6 +379,15 @@ config PWM_PXA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-pxa.
 
+config PWM_RASPBERRYPI_POE
+	tristate "Raspberry Pi Firwmware PoE Hat PWM support"
+	# Make sure not 'y' when RASPBERRYPI_FIRMWARE is 'm'. This can only
+	# happen when COMPILE_TEST=y, hence the added !RASPBERRYPI_FIRMWARE.
+	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
+	help
+	  Enable Raspberry Pi firmware controller PWM bus used to control the
+	  official RPI PoE hat
+
 config PWM_RCAR
 	tristate "Renesas R-Car PWM support"
 	depends on ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index cbdcd55d69ee..7ecbbbcb323a 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_OMAP_DMTIMER)	+= pwm-omap-dmtimer.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
+obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
 obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
diff --git a/drivers/pwm/pwm-raspberrypi-poe.c b/drivers/pwm/pwm-raspberrypi-poe.c
new file mode 100644
index 000000000000..91cd826a36f3
--- /dev/null
+++ b/drivers/pwm/pwm-raspberrypi-poe.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ * For more information on Raspberry Pi's PoE hat see:
+ * https://www.raspberrypi.org/products/poe-hat/
+ *
+ * Limitations:
+ *  - No disable bit, so a disabled PWM is simulated by duty_cycle 0
+ *  - Only normal polarity
+ *  - Fixed 12.5 kHz period
+ *
+ * The current period is completed when HW is reconfigured.
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
+#define RPI_PWM_PERIOD_NS		80000 /* 12.5 kHz */
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
+	if (msg.ret)
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
+	if (msg.ret)
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
+	struct raspberrypi_pwm *rpipwm = to_raspberrypi_pwm(chip);
+
+	state->period = RPI_PWM_PERIOD_NS;
+	state->duty_cycle = DIV_ROUND_CLOSEST(rpipwm->duty_cycle * RPI_PWM_PERIOD_NS,
+					      RPI_PWM_MAX_DUTY);
+	state->enabled = !!(rpipwm->duty_cycle);
+	state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static int raspberrypi_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			         const struct pwm_state *state)
+{
+	struct raspberrypi_pwm *rpipwm = to_raspberrypi_pwm(chip);
+	unsigned int duty_cycle;
+	int ret;
+
+        if (state->period < RPI_PWM_PERIOD_NS ||
+            state->polarity != PWM_POLARITY_NORMAL)
+                return -EINVAL;
+
+        if (!state->enabled)
+                duty_cycle = 0;
+        else if (state->duty_cycle < RPI_PWM_PERIOD_NS)
+                duty_cycle = DIV_ROUND_CLOSEST_ULL(state->duty_cycle * RPI_PWM_MAX_DUTY,
+					           RPI_PWM_PERIOD_NS);
+        else
+                duty_cycle = RPI_PWM_MAX_DUTY;
+
+	if (duty_cycle == rpipwm->duty_cycle)
+		return 0;
+
+	ret = raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_CUR_DUTY_REG,
+					   duty_cycle);
+	if (ret) {
+		dev_err(chip->dev, "Failed to set duty cycle: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * This sets the default duty cycle after resetting the board, we
+	 * updated it every time to mimic Raspberry Pi's downstream's driver
+	 * behaviour.
+	 */
+	ret = raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_DEF_DUTY_REG,
+					   duty_cycle);
+	if (ret) {
+		dev_err(chip->dev, "Failed to set default duty cycle: %d\n", ret);
+		return ret;
+	}
+
+        rpipwm->duty_cycle = duty_cycle;
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
+static int raspberrypi_pwm_probe(struct platform_device *pdev)
+{
+	struct device_node *firmware_node;
+	struct device *dev = &pdev->dev;
+	struct rpi_firmware *firmware;
+	struct raspberrypi_pwm *rpipwm;
+	int ret;
+
+	firmware_node = of_get_parent(dev->of_node);
+	if (!firmware_node) {
+		dev_err(dev, "Missing firmware node\n");
+		return -ENOENT;
+	}
+
+	firmware = devm_rpi_firmware_get(&pdev->dev, firmware_node);
+	of_node_put(firmware_node);
+	if (!firmware)
+		return -EPROBE_DEFER;
+
+	rpipwm = devm_kzalloc(&pdev->dev, sizeof(*rpipwm), GFP_KERNEL);
+	if (!rpipwm)
+		return -ENOMEM;
+
+	rpipwm->firmware = firmware;
+	rpipwm->chip.dev = dev;
+	rpipwm->chip.ops = &raspberrypi_pwm_ops;
+	rpipwm->chip.base = -1;
+	rpipwm->chip.npwm = RASPBERRYPI_FIRMWARE_PWM_NUM;
+
+	platform_set_drvdata(pdev, rpipwm);
+
+	ret = raspberrypi_pwm_get_property(rpipwm->firmware, RPI_PWM_CUR_DUTY_REG,
+					   &rpipwm->duty_cycle);
+	if (ret) {
+		dev_err(dev, "Failed to get duty cycle: %d\n", ret);
+		return ret;
+	}
+
+	return pwmchip_add(&rpipwm->chip);
+}
+
+static int raspberrypi_pwm_remove(struct platform_device *pdev)
+{
+	struct raspberrypi_pwm *rpipwm = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&rpipwm->chip);
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
-- 
2.29.1

