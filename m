Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F9A521E2B
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbiEJP1T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345764AbiEJP0C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 11:26:02 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3B7D11C355;
        Tue, 10 May 2022 08:11:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,214,1647270000"; 
   d="scan'208";a="120533853"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 May 2022 00:11:29 +0900
Received: from localhost.localdomain (unknown [10.226.92.112])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B679A400A0E7;
        Wed, 11 May 2022 00:11:24 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC 2/8] drivers: soc: renesas: Add POEG driver support
Date:   Tue, 10 May 2022 16:11:06 +0100
Message-Id: <20220510151112.16249-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The output pins of the general PWM timer (GPT) can be disabled by
using the port output enabling function for the GPT (POEG).

This patch series add basic support using s/w control through
sysfs to enable/disable output from GPT.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig           |   2 +
 drivers/soc/renesas/Makefile          |   2 +
 drivers/soc/renesas/poeg/Kconfig      |  12 +++
 drivers/soc/renesas/poeg/Makefile     |   2 +
 drivers/soc/renesas/poeg/poeg-rzg2l.c | 148 ++++++++++++++++++++++++++
 5 files changed, 166 insertions(+)
 create mode 100644 drivers/soc/renesas/poeg/Kconfig
 create mode 100644 drivers/soc/renesas/poeg/Makefile
 create mode 100644 drivers/soc/renesas/poeg/poeg-rzg2l.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index c50a6ce1b99d..363bfe3340fa 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -330,6 +330,8 @@ config ARCH_R9A09G011
 	help
 	  This enables support for the Renesas RZ/V2M SoC.
 
+source "drivers/soc/renesas/poeg/Kconfig"
+
 endif # ARM64
 
 config RST_RCAR
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 535868c9c7e4..935bf2cbf31e 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -36,3 +36,5 @@ obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
 obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
 obj-$(CONFIG_SYSC_RCAR_GEN4)	+= rcar-gen4-sysc.o
 obj-$(CONFIG_SYSC_RMOBILE)	+= rmobile-sysc.o
+
+obj-$(CONFIG_POEG_RZG2L)	+= poeg/
diff --git a/drivers/soc/renesas/poeg/Kconfig b/drivers/soc/renesas/poeg/Kconfig
new file mode 100644
index 000000000000..d0f123adb8da
--- /dev/null
+++ b/drivers/soc/renesas/poeg/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+config POEG_RZG2L
+	tristate "RZ/G2L poeg support"
+	depends on ARCH_R9A07G044
+	depends on PWM_RZG2L_GPT
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the General Port Output Enable for PWM found
+	  in RZ/G2L.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called poeg-rzg2l.
diff --git a/drivers/soc/renesas/poeg/Makefile b/drivers/soc/renesas/poeg/Makefile
new file mode 100644
index 000000000000..cc1ec08d2021
--- /dev/null
+++ b/drivers/soc/renesas/poeg/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_POEG_RZG2L)	+= poeg-rzg2l.o
diff --git a/drivers/soc/renesas/poeg/poeg-rzg2l.c b/drivers/soc/renesas/poeg/poeg-rzg2l.c
new file mode 100644
index 000000000000..34f638dc45a6
--- /dev/null
+++ b/drivers/soc/renesas/poeg/poeg-rzg2l.c
@@ -0,0 +1,148 @@
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
+#define POEGG		0
+#define POEGG_SSF	BIT(3)
+
+struct rzg2l_poeg_chip {
+	struct reset_control *rstc;
+	void __iomem *mmio;
+};
+
+static void rzg2l_poeg_write(struct rzg2l_poeg_chip *chip, u32 reg, u32 data)
+{
+	iowrite32(data, chip->mmio + reg);
+}
+
+static u32 rzg2l_poeg_read(struct rzg2l_poeg_chip *chip, u32 reg)
+{
+	return ioread32(chip->mmio + reg);
+}
+
+static ssize_t output_disable_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rzg2l_poeg_chip *chip = platform_get_drvdata(pdev);
+	unsigned int val;
+	u32 reg;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	reg = rzg2l_poeg_read(chip, POEGG);
+	if (val)
+		reg |= POEGG_SSF;
+	else
+		reg &= ~POEGG_SSF;
+
+	rzg2l_poeg_write(chip, POEGG, reg);
+
+	return ret ? : count;
+}
+
+static ssize_t output_disable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rzg2l_poeg_chip *chip = platform_get_drvdata(pdev);
+	u32 reg;
+
+	reg = rzg2l_poeg_read(chip, POEGG);
+
+	return sprintf(buf, "%u\n", (reg & POEGG_SSF) ? 1 : 0);
+}
+static DEVICE_ATTR_RW(output_disable);
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
+	pm_runtime_enable(&pdev->dev);
+	platform_set_drvdata(pdev, chip);
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		goto err;
+	}
+
+	ret = device_create_file(&pdev->dev, &dev_attr_output_disable);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to create poeg sysfs: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
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
+	device_remove_file(&pdev->dev, &dev_attr_output_disable);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(chip->rstc);
+
+	return 0;
+}
+
+static struct platform_driver rzg2l_poeg_driver = {
+	.driver = {
+		.name = "poeg-rzg2l",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(rzg2l_poeg_of_table),
+	},
+	.probe = rzg2l_poeg_probe,
+	.remove = rzg2l_poeg_remove,
+};
+module_platform_driver(rzg2l_poeg_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L POEG Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

