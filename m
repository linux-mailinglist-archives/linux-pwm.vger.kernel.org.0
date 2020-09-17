Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113D326E937
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Sep 2020 01:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgIQXAJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Sep 2020 19:00:09 -0400
Received: from mo-csw-fb1116.securemx.jp ([210.130.202.175]:49400 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIQXAI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Sep 2020 19:00:08 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1116) id 08HMWFxr010884; Fri, 18 Sep 2020 07:32:15 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 08HMVrUZ028547; Fri, 18 Sep 2020 07:31:53 +0900
X-Iguazu-Qid: 2wHHQUhUGtwWoYzwwK
X-Iguazu-QSIG: v=2; s=0; t=1600381912; q=2wHHQUhUGtwWoYzwwK; m=34Ey3eTpq6hehLDZahwnAo6GyQxFbsIBnpA5/hux5FQ=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1111) id 08HMVpas022819;
        Fri, 18 Sep 2020 07:31:51 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 08HMVpsi025788;
        Fri, 18 Sep 2020 07:31:51 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 08HMVp9s000934;
        Fri, 18 Sep 2020 07:31:51 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM support
Date:   Fri, 18 Sep 2020 07:31:40 +0900
X-TSB-HOP: ON
Message-Id: <20200917223140.227542-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Add a driver for the PWM controller on Toshiba Visconti ARM SoC.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/pwm/Kconfig        |   9 +++
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-visconti.c | 141 +++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 drivers/pwm/pwm-visconti.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index cb8d739067d2..f99d48f74c76 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -533,6 +533,15 @@ config PWM_TIEHRPWM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tiehrpwm.
 
+config PWM_VISCONTI
+	tristate "Toshiba Visconti PWM support"
+	depends on ARCH_VISCONTI || COMPILE_TEST
+	help
+	  PWM Subsystem driver support for Toshiba Visconti SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-visconti.
+
 config PWM_TWL
 	tristate "TWL4030/6030 PWM support"
 	depends on TWL4030_CORE
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a59c710e98c7..ef6dc1af7c17 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
+obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
new file mode 100644
index 000000000000..601450111166
--- /dev/null
+++ b/drivers/pwm/pwm-visconti.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Toshiba Visconti pulse-width-modulation controller driver
+ *
+ * Copyright (c) 2020 TOSHIBA CORPORATION
+ * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
+ * Copyright (c) 2020 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pwm.h>
+#include <linux/platform_device.h>
+
+#define PWMC0_PWMACT BIT(5)
+
+#define REG_PCSR(ch) (0x400 + 4 * (ch))
+#define REG_PDUT(ch) (0x420 + 4 * (ch))
+#define REG_PWM0(ch) (0x440 + 4 * (ch))
+
+struct visconti_pwm_chip {
+	struct pwm_chip chip;
+	struct device *dev;
+	void __iomem *base;
+};
+
+#define to_visconti_chip(chip) \
+	container_of(chip, struct visconti_pwm_chip, chip)
+
+static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct visconti_pwm_chip *priv = to_visconti_chip(chip);
+	u32 period, duty, pwmc0;
+
+	dev_dbg(priv->dev, "%s: ch = %d en = %d p = 0x%llx d = 0x%llx\n", __func__,
+		pwm->hwpwm, state->enabled, state->period, state->duty_cycle);
+	if (state->enabled) {
+		period = state->period / 1000;
+		duty = state->duty_cycle / 1000;
+		if (period < 0x10000)
+			pwmc0 = 0;
+		else if (period < 0x20000)
+			pwmc0 = 1;
+		else if (period < 0x40000)
+			pwmc0 = 2;
+		else if (period < 0x80000)
+			pwmc0 = 3;
+		else
+			return -EINVAL;
+
+		if (pwmc0) {
+			period /= BIT(pwmc0);
+			duty /= BIT(pwmc0);
+		}
+
+		if (state->polarity == PWM_POLARITY_INVERSED)
+			pwmc0 |= PWMC0_PWMACT;
+
+		writel(pwmc0, priv->base + REG_PWM0(pwm->hwpwm));
+		writel(duty, priv->base + REG_PDUT(pwm->hwpwm));
+		writel(period, priv->base + REG_PCSR(pwm->hwpwm));
+	} else {
+		writel(0, priv->base + REG_PCSR(pwm->hwpwm));
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops visconti_pwm_ops = {
+	.apply = visconti_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static int visconti_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct visconti_pwm_chip *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base)) {
+		dev_err(dev, "unable to map I/O space\n");
+		return PTR_ERR(priv->base);
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->chip.dev = dev;
+	priv->chip.ops = &visconti_pwm_ops;
+	priv->chip.base = -1;
+	priv->chip.npwm = 4;
+
+	ret = pwmchip_add(&priv->chip);
+	if (ret < 0) {
+		dev_err(dev, "Cannot register visconti PWM: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "visconti PWM registered\n");
+
+	return 0;
+}
+
+static int visconti_pwm_remove(struct platform_device *pdev)
+{
+	struct visconti_pwm_chip *priv = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&priv->chip);
+}
+
+static const struct of_device_id visconti_pwm_of_match[] = {
+	{ .compatible = "toshiba,pwm-visconti", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, visconti_pwm_of_match);
+
+static struct platform_driver visconti_pwm_driver = {
+	.driver = {
+		.name = "pwm-visconti",
+		.of_match_table = visconti_pwm_of_match,
+	},
+	.probe = visconti_pwm_probe,
+	.remove = visconti_pwm_remove,
+};
+
+module_platform_driver(visconti_pwm_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Toshiba");
+MODULE_ALIAS("platform:visconti-pwm");
-- 
2.27.0

