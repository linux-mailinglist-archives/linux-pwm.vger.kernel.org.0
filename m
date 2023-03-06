Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087556AB913
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 10:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFJAv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 04:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCFJAt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 04:00:49 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D1B659E6;
        Mon,  6 Mar 2023 01:00:45 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.98,236,1673881200"; 
   d="scan'208";a="154992587"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Mar 2023 18:00:43 +0900
Received: from localhost.localdomain (unknown [10.226.93.39])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A175341C869B;
        Mon,  6 Mar 2023 18:00:39 +0900 (JST)
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
Subject: [PATCH v6 06/13] drivers: pinctrl: renesas: Add RZ/G2L POEG driver support
Date:   Mon,  6 Mar 2023 09:00:07 +0000
Message-Id: <20230306090014.128732-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
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

Add basic support using s/w control through generic pincontrol sysfs to
enable/disable output from GPT by registering with RZ/G2L pincontrol
driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c | 254 ++++++++++++++++++++++
 5 files changed, 271 insertions(+)
 create mode 100644 drivers/pinctrl/renesas/poeg/Kconfig
 create mode 100644 drivers/pinctrl/renesas/poeg/Makefile
 create mode 100644 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c

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
index 000000000000..30f4352e257d
--- /dev/null
+++ b/drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L Port Output Enable for GPT (POEG) driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/pinctrl-rzg2l.h>
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
+struct rzg2l_poeg_chip {
+	struct device *gpt_dev;
+	struct reset_control *rstc;
+	void __iomem *mmio;
+	u8 index;
+	u8 gpt_channels[RZG2L_GPT_MAX_HW_CHANNELS];
+};
+
+static const char * const rzg2l_gpt_pins[] = {
+	"gpt0-pins",
+	"gpt1-pins",
+	"gpt2-pins",
+	"gpt3-pins",
+	"gpt4-pins",
+	"gpt5-pins",
+	"gpt6-pins",
+	"gpt7-pins",
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
+static int rzg2l_poeg_cb(void *context, const char *fname, const char *gname,
+			 enum pin_output_disable_conf conf,
+			 unsigned int conf_val)
+{
+	bool pin_match = false;
+	int ret, i;
+
+	for (i = 0; i < RZG2L_GPT_MAX_HW_CHANNELS; i++) {
+		if ((!strcmp(rzg2l_gpt_pins[i], fname)) &&
+		    (!strcmp(rzg2l_gpt_pins[i], gname))) {
+			pin_match = true;
+			break;
+		}
+	}
+
+	if (!pin_match)
+		return -EINVAL;
+
+	switch (conf) {
+	case PINCTRL_OUTPUT_DISABLE_BY_USER:
+		ret = rzg2l_poeg_output_disable_user(context, !!conf_val);
+		break;
+	case PINCTRL_OUTPUT_DISABLE_BY_SOC_ON_PIN_OUTPUT_HIGH:
+	case PINCTRL_OUTPUT_DISABLE_BY_SOC_ON_PIN_OUTPUT_LOW:
+	case PINCTRL_OUTPUT_DISABLE_BY_SOC_ON_DEAD_TIME_ERROR:
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static bool rzg2l_poeg_get_linked_gpt_channels(struct platform_device *pdev,
+					       struct rzg2l_poeg_chip *chip,
+					       struct device_node *gpt_np,
+					       u8 poeg_id)
+{
+	struct of_phandle_args of_args;
+	bool ret = false;
+	unsigned int i;
+	u32 poeg_grp;
+	int cells;
+	int err;
+
+	cells = of_property_count_u32_elems(gpt_np, "renesas,poegs");
+	if (cells == -EINVAL)
+		return ret;
+
+	for (i = 0 ; i < RZG2L_GPT_MAX_HW_CHANNELS; i++)
+		chip->gpt_channels[i] = RZG2L_GPT_INVALID_CHANNEL;
+
+	cells >>= 1;
+	for (i = 0; i < cells; i++) {
+		err = of_parse_phandle_with_fixed_args(gpt_np,
+						       "renesas,poegs", 1, i,
+						       &of_args);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to parse 'renesas,poegs' property\n");
+			break;
+		}
+
+		if (of_args.args[0] >= RZG2L_GPT_MAX_HW_CHANNELS) {
+			dev_err(&pdev->dev, "Invalid channel %d >= %d\n",
+				of_args.args[0], RZG2L_GPT_MAX_HW_CHANNELS);
+			of_node_put(of_args.np);
+			break;
+		}
+
+		if (!of_property_read_u32(of_args.np, "renesas,poeg-id", &poeg_grp)) {
+			if (poeg_grp == poeg_id) {
+				chip->gpt_channels[poeg_grp] = poeg_id;
+				ret = true;
+			}
+		}
+
+		of_node_put(of_args.np);
+	}
+
+	return ret;
+}
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
+	bool gpt_linked = false;
+	struct device_node *np;
+	u32 val;
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
+	gpt_linked = rzg2l_poeg_get_linked_gpt_channels(pdev, chip, np,
+							chip->index);
+	of_node_put(np);
+	if (!gpt_pdev)
+		return -ENODEV;
+
+	chip->gpt_dev = &gpt_pdev->dev;
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rzg2l_poeg_cleanup, chip);
+	if (ret < 0)
+		return ret;
+
+	chip->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(chip->mmio))
+		return PTR_ERR(chip->mmio);
+
+	if (gpt_linked)
+		rzg2l_output_disable_cb_register(chip->gpt_dev,
+						 rzg2l_poeg_cb, chip);
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
+	return 0;
+
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

