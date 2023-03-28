Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841F56CBC0A
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Mar 2023 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjC1KLL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Mar 2023 06:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjC1KK7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Mar 2023 06:10:59 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 048BC35B6;
        Tue, 28 Mar 2023 03:10:34 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,297,1673881200"; 
   d="scan'208";a="154048960"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Mar 2023 19:10:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.2])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 857CB40071F7;
        Tue, 28 Mar 2023 19:10:21 +0900 (JST)
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
Subject: [PATCH v7 02/10] drivers: pinctrl: renesas: Add RZ/G2L POEG driver support
Date:   Tue, 28 Mar 2023 11:10:03 +0100
Message-Id: <20230328101011.185594-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328101011.185594-1-biju.das.jz@bp.renesas.com>
References: <20230328101011.185594-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The output pins of the RZ/G2L general PWM timer (GPT) can be disabled
by using the port output enabling function for the GPT (POEG).

Add basic user control support to enable/disable output from GPT
by using poeg char device.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v6->v7:
 * Used DT to handle the system configuration
 * Added poeg char device for user control support to enable/disable
   output from GPT
 * Replaced iowrite32/ioread32-> writel/readl
 * Dropped of_match_ptr from .of_match_table
v5->v6:
 * Dropped sysfs and is handled in generic driver.
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
 drivers/pinctrl/renesas/Kconfig           |   2 +
 drivers/pinctrl/renesas/Makefile          |   2 +
 drivers/pinctrl/renesas/poeg/Kconfig      |  11 +
 drivers/pinctrl/renesas/poeg/Makefile     |   2 +
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 299 ++++++++++++++++++++++
 include/linux/pinctrl/rzg2l-poeg.h        |  15 ++
 6 files changed, 331 insertions(+)
 create mode 100644 drivers/pinctrl/renesas/poeg/Kconfig
 create mode 100644 drivers/pinctrl/renesas/poeg/Makefile
 create mode 100644 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
 create mode 100644 include/linux/pinctrl/rzg2l-poeg.h

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 77730dc548ed..42e030ae2783 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -303,4 +303,6 @@ config PINCTRL_PFC_SHX3
 	bool "pin control support for SH-X3" if COMPILE_TEST
 	select PINCTRL_SH_FUNC_GPIO
 
+source "drivers/pinctrl/renesas/poeg/Kconfig"
+
 endmenu
diff --git a/drivers/pinctrl/renesas/Makefile b/drivers/pinctrl/renesas/Makefile
index 3e776955bd4b..03338920725e 100644
--- a/drivers/pinctrl/renesas/Makefile
+++ b/drivers/pinctrl/renesas/Makefile
@@ -51,6 +51,8 @@ obj-$(CONFIG_PINCTRL_RZG2L)	+= pinctrl-rzg2l.o
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
index 000000000000..30e75954af76
--- /dev/null
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L Port Output Enable for GPT (POEG) driver
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ */
+#include <linux/cdev.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/rzg2l-poeg.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+
+#define POEGG_SSF	BIT(3)
+
+#define RZG2L_POEG_MAX_INDEX		3
+
+#define RZG2L_GPT_MAX_HW_CHANNELS	8
+#define RZG2L_GPT_INVALID_CHANNEL	0xff
+
+enum poeg_conf {
+	POEG_USER_CTRL = BIT(0),
+	POEG_GPT_BOTH_HIGH = BIT(1),
+	POEG_GPT_BOTH_LOW = BIT(2),
+	POEG_GPT_DEAD_TIME = BIT(3),
+	POEG_EXT_PIN_CTRL = BIT(4),
+	POEG_GPT_BOTH_HIGH_LOW = BIT(1) | BIT(2),
+	POEG_GPT_BOTH_HIGH_DEAD_TIME = BIT(1) | BIT(3),
+	POEG_GPT_BOTH_LOW_DEAD_TIME = BIT(2) | BIT(3),
+	POEG_GPT_ALL = BIT(1) | BIT(2) | BIT(3)
+};
+
+static struct class *poeg_class;
+static dev_t g_poeg_dev;
+static int minor_n;
+
+struct rzg2l_poeg_chip {
+	struct device *gpt_dev;
+	struct reset_control *rstc;
+	void __iomem *mmio;
+	struct cdev poeg_cdev;
+	u8 gpt_channels[RZG2L_GPT_MAX_HW_CHANNELS];
+	u8 index;
+	u32 cfg;
+	int minor_n;
+};
+
+static void rzg2l_poeg_write(struct rzg2l_poeg_chip *chip, u32 data)
+{
+	writel(data, chip->mmio);
+}
+
+static u32 rzg2l_poeg_read(struct rzg2l_poeg_chip *chip)
+{
+	return readl(chip->mmio);
+}
+
+static int rzg2l_poeg_output_disable_user(struct rzg2l_poeg_chip *chip,
+					  bool enable)
+{
+	u32 reg_val;
+
+	reg_val = rzg2l_poeg_read(chip);
+	if (enable)
+		reg_val |= POEGG_SSF;
+	else
+		reg_val &= ~POEGG_SSF;
+
+	rzg2l_poeg_write(chip, reg_val);
+
+	return 0;
+}
+
+static ssize_t rzg2l_poeg_chrdev_write(struct file *filp,
+				       const char __user *buf,
+				       size_t len, loff_t *f_ps)
+{
+	struct rzg2l_poeg_chip *const chip = filp->private_data;
+	struct poeg_cmd cmd;
+
+	if (copy_from_user(&cmd, buf, sizeof(cmd)))
+		return -EFAULT;
+
+	switch (cmd.val) {
+	case RZG2L_POEG_USR_CTRL_ENABLE_CMD:
+		rzg2l_poeg_output_disable_user(chip, true);
+		break;
+	case RZG2L_POEG_USR_CTRL_DISABLE_CMD:
+		rzg2l_poeg_output_disable_user(chip, false);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return len;
+}
+
+static int rzg2l_poeg_chrdev_open(struct inode *inode, struct file *filp)
+{
+	struct rzg2l_poeg_chip *const chip = container_of(inode->i_cdev,
+							  typeof(*chip),
+							  poeg_cdev);
+
+	filp->private_data = chip;
+
+	return nonseekable_open(inode, filp);
+}
+
+static int rzg2l_poeg_chrdev_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+
+	return 0;
+}
+
+static const struct file_operations poeg_fops = {
+	.owner = THIS_MODULE,
+	.write = rzg2l_poeg_chrdev_write,
+	.open = rzg2l_poeg_chrdev_open,
+	.release = rzg2l_poeg_chrdev_release,
+};
+
+static const struct of_device_id rzg2l_poeg_of_table[] = {
+	{ .compatible = "renesas,rzg2l-poeg", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg2l_poeg_of_table);
+
+static void rzg2l_poeg_cleanup(void *data)
+{
+	struct rzg2l_poeg_chip *chip = data;
+
+	put_device(chip->gpt_dev);
+}
+
+static int rzg2l_poeg_probe(struct platform_device *pdev)
+{
+	struct platform_device *gpt_pdev = NULL;
+	struct rzg2l_poeg_chip *chip;
+	struct device_node *np;
+	struct device *cdev;
+	u32 cfg, val;
+	int ret;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	if (!of_property_read_u32(pdev->dev.of_node, "renesas,poeg-id", &val))
+		chip->index = val;
+
+	if (chip->index > RZG2L_POEG_MAX_INDEX)
+		return -EINVAL;
+
+	np = of_parse_phandle(pdev->dev.of_node, "renesas,gpt", 0);
+	if (np)
+		gpt_pdev = of_find_device_by_node(np);
+
+	of_node_put(np);
+	if (!gpt_pdev)
+		return -ENODEV;
+
+	chip->gpt_dev = &gpt_pdev->dev;
+	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_poeg_cleanup, chip);
+	if (ret < 0)
+		return ret;
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
+		dev_err(&pdev->dev, "pm_runtime_resume_get failed: %d\n", ret);
+		goto err_pm_disable;
+	}
+
+	if (!of_property_read_u32(pdev->dev.of_node, "renesas,poeg-config", &cfg)) {
+		switch (cfg) {
+		case POEG_USER_CTRL:
+			rzg2l_poeg_write(chip, POEGG_SSF);
+			break;
+		default:
+			ret = -EINVAL;
+			goto err_pm;
+		}
+
+		chip->cfg = cfg;
+
+		cdev_init(&chip->poeg_cdev, &poeg_fops);
+		chip->poeg_cdev.owner = THIS_MODULE;
+		ret = cdev_add(&chip->poeg_cdev, MKDEV(MAJOR(g_poeg_dev), minor_n), 1);
+		if (ret)
+			goto err_pm;
+
+		cdev = device_create(poeg_class, NULL,
+				     MKDEV(MAJOR(g_poeg_dev), minor_n), NULL,
+				     "poeg%d", minor_n);
+		if (IS_ERR(cdev)) {
+			ret = PTR_ERR(cdev);
+			dev_err(&pdev->dev,
+				"Error %d creating device for port %u\n",
+				ret, minor_n);
+			goto free_cdev;
+		}
+		chip->minor_n = minor_n;
+	}
+
+	minor_n++;
+
+	return ret;
+
+free_cdev:
+	cdev_del(&chip->poeg_cdev);
+err_pm:
+	pm_runtime_put(&pdev->dev);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(chip->rstc);
+	return ret;
+}
+
+static int rzg2l_poeg_remove(struct platform_device *pdev)
+{
+	struct rzg2l_poeg_chip *chip = platform_get_drvdata(pdev);
+
+	device_destroy(poeg_class, MKDEV(MAJOR(g_poeg_dev), chip->minor_n));
+	cdev_del(&chip->poeg_cdev);
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
+		.of_match_table = rzg2l_poeg_of_table
+	},
+	.probe = rzg2l_poeg_probe,
+	.remove = rzg2l_poeg_remove
+};
+
+static int rzg2l_poeg_device_init(void)
+{
+	int err;
+
+	err = alloc_chrdev_region(&g_poeg_dev, 0, 1, "poeg");
+	if (err)
+		goto out;
+
+	poeg_class = class_create("poeg");
+	if (IS_ERR(poeg_class)) {
+		err = PTR_ERR(poeg_class);
+		goto err_free_chrdev;
+	}
+
+	err = platform_driver_register(&rzg2l_poeg_driver);
+	if (err)
+		goto err_class_destroy;
+
+	return 0;
+
+err_class_destroy:
+	class_destroy(poeg_class);
+err_free_chrdev:
+	unregister_chrdev_region(g_poeg_dev, 1);
+out:
+	return err;
+}
+
+static void rzg2l_poeg_device_exit(void)
+{
+	platform_driver_unregister(&rzg2l_poeg_driver);
+	class_destroy(poeg_class);
+	unregister_chrdev_region(g_poeg_dev, 1);
+}
+
+module_init(rzg2l_poeg_device_init);
+module_exit(rzg2l_poeg_device_exit);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L POEG Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/pinctrl/rzg2l-poeg.h b/include/linux/pinctrl/rzg2l-poeg.h
new file mode 100644
index 000000000000..32e7d07fc00e
--- /dev/null
+++ b/include/linux/pinctrl/rzg2l-poeg.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_POEG_RZG2L_H__
+#define __LINUX_POEG_RZG2L_H__
+
+#include <linux/types.h>
+
+#define RZG2L_POEG_USR_CTRL_ENABLE_CMD	0
+#define RZG2L_POEG_USR_CTRL_DISABLE_CMD	1
+
+struct poeg_cmd {
+	__u32 val;
+	__u8 channel;
+};
+
+#endif /* __LINUX_POEG_RZG2L_H__ */
-- 
2.25.1

