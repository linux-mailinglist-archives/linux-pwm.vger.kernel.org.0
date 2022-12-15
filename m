Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F238064E323
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Dec 2022 22:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiLOVc2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Dec 2022 16:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiLOVcX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Dec 2022 16:32:23 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A270F1C437;
        Thu, 15 Dec 2022 13:32:21 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,248,1665414000"; 
   d="scan'208";a="146337516"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Dec 2022 06:32:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.26])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7021E40071FC;
        Fri, 16 Dec 2022 06:32:17 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 2/9] drivers: pinctrl: renesas: Add RZ/G2L POEG driver support
Date:   Thu, 15 Dec 2022 21:31:59 +0000
Message-Id: <20221215213206.56666-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215213206.56666-1-biju.das.jz@bp.renesas.com>
References: <20221215213206.56666-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The output pins of the RZ/G2L general PWM timer (GPT) can be disabled
by using the port output enabling function for the GPT (POEG).

This patch adds basic support using s/w control through sysfs
to enable/disable output from GPT.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Updated kernel version in sysfs doc.
v3->v4:
 * Updated commit description.
v2->v3:
 * Added sysfs documentation for output_disable
 * PWM_RZG2L_GPT implies ARCH_RZG2L. So removed ARCH_RZG2L dependency
 * Used dev_get_drvdata to get device data
 * Replaced sprintf->sysfs_emit in show().
v1->v2:
 * Renamed the file poeg-rzg2l->rzg2l-poeg
 * Removed the macro POEGG as there is only single register and
   updated rzg2l_poeg_write() and rzg2l_poeg_read()
 * Updated error handling in probe()
Ref->v1:
 * Moved driver files from soc to pincontrol directory
 * Updated KConfig
---
 .../ABI/testing/sysfs-platform-rzg2l-poeg     |  18 ++
 drivers/pinctrl/renesas/Kconfig               |   2 +
 drivers/pinctrl/renesas/Makefile              |   2 +
 drivers/pinctrl/renesas/poeg/Kconfig          |  11 ++
 drivers/pinctrl/renesas/poeg/Makefile         |   2 +
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c     | 157 ++++++++++++++++++
 6 files changed, 192 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-rzg2l-poeg
 create mode 100644 drivers/pinctrl/renesas/poeg/Kconfig
 create mode 100644 drivers/pinctrl/renesas/poeg/Makefile
 create mode 100644 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c

diff --git a/Documentation/ABI/testing/sysfs-platform-rzg2l-poeg b/Documentation/ABI/testing/sysfs-platform-rzg2l-poeg
new file mode 100644
index 000000000000..157c98c49940
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-rzg2l-poeg
@@ -0,0 +1,18 @@
+What:		/sys/devices/platform/<rzg2l-poeg's name>/output_disable
+Date:		November 2022
+KernelVersion:	6.3
+Contact:	Biju Das <biju.das.jz@bp.renesas.com>
+Description:
+		This file can be read and write.
+		The file used to control the output disable using
+		register settings.
+
+		Write the following string to control the output disable:
+
+		- "1" - request output-disable from software.
+		- "0" - request no output-disable from software.
+
+		Read the file, then it shows the following strings:
+
+		- "1" - Output-disable request from software occurred.
+		- "0" - No output-disable request from software occurred.
diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 0903a0a41831..92bdc2e1e125 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -308,4 +308,6 @@ config PINCTRL_PFC_SHX3
 	bool "pin control support for SH-X3" if COMPILE_TEST
 	select PINCTRL_SH_FUNC_GPIO
 
+source "drivers/pinctrl/renesas/poeg/Kconfig"
+
 endmenu
diff --git a/drivers/pinctrl/renesas/Makefile b/drivers/pinctrl/renesas/Makefile
index 558b30ce0dec..de1bb592fbf3 100644
--- a/drivers/pinctrl/renesas/Makefile
+++ b/drivers/pinctrl/renesas/Makefile
@@ -52,6 +52,8 @@ obj-$(CONFIG_PINCTRL_RZG2L)	+= pinctrl-rzg2l.o
 obj-$(CONFIG_PINCTRL_RZN1)	+= pinctrl-rzn1.o
 obj-$(CONFIG_PINCTRL_RZV2M)	+= pinctrl-rzv2m.o
 
+obj-$(CONFIG_POEG_RZG2L)	+= poeg/
+
 ifeq ($(CONFIG_COMPILE_TEST),y)
 CFLAGS_pfc-sh7203.o	+= -I$(srctree)/arch/sh/include/cpu-sh2a
 CFLAGS_pfc-sh7264.o	+= -I$(srctree)/arch/sh/include/cpu-sh2a
diff --git a/drivers/pinctrl/renesas/poeg/Kconfig b/drivers/pinctrl/renesas/poeg/Kconfig
new file mode 100644
index 000000000000..306e8ae81cb2
--- /dev/null
+++ b/drivers/pinctrl/renesas/poeg/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+config POEG_RZG2L
+	tristate "Renesas RZ/G2L poeg support"
+	depends on PWM_RZG2L_GPT || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the Port Output Enable for GPT(POEG) found
+	  in Renesas RZ/G2L alike SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called rzg2l-poeg.
diff --git a/drivers/pinctrl/renesas/poeg/Makefile b/drivers/pinctrl/renesas/poeg/Makefile
new file mode 100644
index 000000000000..610bdd6182be
--- /dev/null
+++ b/drivers/pinctrl/renesas/poeg/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_POEG_RZG2L)	+= rzg2l-poeg.o
diff --git a/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
new file mode 100644
index 000000000000..3788191bc2f1
--- /dev/null
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L Port Output Enable for GPT (POEG) driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#define POEGG_SSF	BIT(3)
+
+struct rzg2l_poeg_chip {
+	struct reset_control *rstc;
+	void __iomem *mmio;
+};
+
+static void rzg2l_poeg_write(struct rzg2l_poeg_chip *chip, u32 data)
+{
+	iowrite32(data, chip->mmio);
+}
+
+static u32 rzg2l_poeg_read(struct rzg2l_poeg_chip *chip)
+{
+	return ioread32(chip->mmio);
+}
+
+static ssize_t output_disable_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct rzg2l_poeg_chip *chip;
+	unsigned int val;
+	u32 reg_val;
+	int ret;
+
+	chip = dev_get_drvdata(dev);
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	reg_val = rzg2l_poeg_read(chip);
+	if (val)
+		reg_val |= POEGG_SSF;
+	else
+		reg_val &= ~POEGG_SSF;
+
+	rzg2l_poeg_write(chip, reg_val);
+
+	return count;
+}
+
+static ssize_t output_disable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct rzg2l_poeg_chip *chip;
+	u32 reg;
+
+	chip = dev_get_drvdata(dev);
+	reg = rzg2l_poeg_read(chip);
+
+	return sysfs_emit(buf, "%u\n", (reg & POEGG_SSF) ? 1 : 0);
+}
+
+static DEVICE_ATTR_RW(output_disable);
+
+static struct attribute *poeg_attrs[] = {
+	&dev_attr_output_disable.attr,
+	NULL,
+};
+
+static const struct attribute_group poeg_groups = {
+	.attrs = poeg_attrs,
+};
+
+static const struct of_device_id rzg2l_poeg_of_table[] = {
+	{ .compatible = "renesas,rzg2l-poeg", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg2l_poeg_of_table);
+
+static int rzg2l_poeg_probe(struct platform_device *pdev)
+{
+	struct rzg2l_poeg_chip *chip;
+	int ret;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(chip->mmio))
+		return PTR_ERR(chip->mmio);
+
+	chip->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(chip->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chip->rstc),
+				     "get reset failed\n");
+
+	ret = reset_control_deassert(chip->rstc);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, chip);
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		goto err_pm_disable;
+	}
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &poeg_groups);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to create sysfs: %d\n", ret);
+		goto err_pm;
+	}
+
+	return 0;
+
+err_pm:
+	pm_runtime_put(&pdev->dev);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(chip->rstc);
+
+	return ret;
+}
+
+static int rzg2l_poeg_remove(struct platform_device *pdev)
+{
+	struct rzg2l_poeg_chip *chip = platform_get_drvdata(pdev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &poeg_groups);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(chip->rstc);
+
+	return 0;
+}
+
+static struct platform_driver rzg2l_poeg_driver = {
+	.driver = {
+		.name = "rzg2l-poeg",
+		.of_match_table = of_match_ptr(rzg2l_poeg_of_table),
+	},
+	.probe = rzg2l_poeg_probe,
+	.remove = rzg2l_poeg_remove,
+};
+module_platform_driver(rzg2l_poeg_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L POEG Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

