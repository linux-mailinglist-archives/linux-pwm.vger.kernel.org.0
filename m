Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65F1A225B
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Apr 2020 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgDHMyK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Apr 2020 08:54:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:4470 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgDHMyK (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 8 Apr 2020 08:54:10 -0400
IronPort-SDR: fmgAw5Cu71S5ivSyFE+RzjaY6mrJPfEA+Ph94tAVJCdDCUhXeNNln+7tpsCxJKVE6aDmftAI8Y
 vMPCwRhjMdZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 05:54:09 -0700
IronPort-SDR: BTml3Fdx5z9Ci0KzrA/zgiD0mmUYEzFcFYF9LeR/NeiRyQghZBZXf+8TjwJePVdNx3wkCXErIE
 hi26QaxfvTMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,358,1580803200"; 
   d="scan'208";a="452807408"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.51])
  by fmsmga006.fm.intel.com with ESMTP; 08 Apr 2020 05:54:07 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Raymond Tan <raymond.tan@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] pwm: Add DesignWare PWM Controller Driver
Date:   Wed,  8 Apr 2020 15:54:04 +0300
Message-Id: <20200408125404.527090-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Introduce driver for Synopsys DesignWare PWM Controller used on Intel
Elkhart Lake.

Initial implementation is done by Felipe Balbi while he was working at
Intel with later changes from Raymond Tan and me.

Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/pwm/Kconfig   |   9 ++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-dwc.c | 328 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/pwm/pwm-dwc.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 30190beeb6e9..cfded9efdb17 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -150,6 +150,15 @@ config PWM_CROS_EC
 	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
 	  Controller.
 
+config PWM_DWC
+	tristate "DesignWare PWM Controller"
+	depends on PCI
+	help
+	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-dwc.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9a475073dafc..eb52012f0e79 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PWM_BRCMSTB)	+= pwm-brcmstb.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
+obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
new file mode 100644
index 000000000000..962d504c1281
--- /dev/null
+++ b/drivers/pwm/pwm-dwc.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DesignWare PWM Controller driver
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ *
+ * Author: Felipe Balbi
+ */
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+
+#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
+#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
+#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
+#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
+#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
+#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
+
+#define DWC_TIMERS_INT_STS	0xa0
+#define DWC_TIMERS_EOI		0xa4
+#define DWC_TIMERS_RAW_INT_STS	0xa8
+#define DWC_TIMERS_COMP_VERSION	0xac
+
+#define DWC_TIMERS_TOTAL	8
+
+/* Timer Control Register */
+#define DWC_TIM_CTRL_EN		BIT(0)
+#define DWC_TIM_CTRL_MODE	BIT(1)
+#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
+#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
+#define DWC_TIM_CTRL_INT_MASK	BIT(2)
+#define DWC_TIM_CTRL_PWM	BIT(3)
+
+struct dwc_pwm_driver_data {
+	unsigned long clk_period_ns;
+	int npwm;
+};
+
+struct dwc_pwm {
+	struct pwm_chip chip;
+	struct device *dev;
+	struct mutex lock;
+
+	unsigned long clk_period_ns;
+	unsigned int version;
+
+	void __iomem *base;
+
+	u32 saved_registers[24];
+};
+#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
+
+static inline u32 dwc_pwm_readl(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static inline void dwc_pwm_writel(void __iomem *base, u32 offset, u32 value)
+{
+	writel(value, base + offset);
+}
+
+static void __dwc_pwm_configure(struct dwc_pwm *dwc, int pwm,
+				unsigned int duty_ns,
+				unsigned int period_ns)
+{
+	u32 ctrl;
+	u32 high;
+	u32 low;
+
+	high = DIV_ROUND_CLOSEST(duty_ns, dwc->clk_period_ns) - 1;
+	low = DIV_ROUND_CLOSEST(period_ns - duty_ns, dwc->clk_period_ns) - 1;
+
+	dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT(pwm), low);
+	dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT2(pwm), high);
+
+	ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
+	dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(pwm), ctrl);
+}
+
+static u32 __dwc_pwm_duty_ns(struct dwc_pwm *dwc, int pwm)
+{
+	u32 duty;
+
+	duty = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(pwm));
+	duty += 1;
+	duty *= dwc->clk_period_ns;
+
+	return duty;
+}
+
+static u32 __dwc_pwm_period_ns(struct dwc_pwm *dwc, int pwm, u32 duty)
+{
+	u32 period;
+
+	period = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT(pwm));
+	period += 1;
+	period *= dwc->clk_period_ns;
+	period += duty;
+
+	return period;
+}
+
+static bool __dwc_pwm_is_enabled(struct dwc_pwm *dwc, int pwm)
+{
+	return !!(dwc_pwm_readl(dwc->base,
+				DWC_TIM_CTRL(pwm)) & DWC_TIM_CTRL_EN);
+}
+
+static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int enabled)
+{
+	u32 reg;
+
+	reg = dwc_pwm_readl(dwc->base, DWC_TIM_CTRL(pwm));
+
+	if (enabled)
+		reg |= DWC_TIM_CTRL_EN;
+	else
+		reg &= ~DWC_TIM_CTRL_EN;
+
+	dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(pwm), reg);
+}
+
+static void __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
+				      struct pwm_device *pwm,
+				      const struct pwm_state *state)
+{
+	__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
+	__dwc_pwm_configure(dwc, pwm->hwpwm, state->duty_cycle,
+			    state->period);
+	__dwc_pwm_set_enable(dwc, pwm->hwpwm, state->enabled);
+}
+
+static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+
+	mutex_lock(&dwc->lock);
+
+	if (state->enabled) {
+		if (!pwm_is_enabled(pwm))
+			pm_runtime_get_sync(dwc->dev);
+		__dwc_pwm_configure_timer(dwc, pwm, state);
+	} else {
+		if (pwm_is_enabled(pwm)) {
+			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
+			pm_runtime_put_sync(dwc->dev);
+		}
+	}
+
+	mutex_unlock(&dwc->lock);
+
+	return 0;
+}
+
+static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+
+	pm_runtime_get_sync(dwc->dev);
+
+	mutex_lock(&dwc->lock);
+	state->enabled = __dwc_pwm_is_enabled(dwc, pwm->hwpwm);
+	state->duty_cycle = __dwc_pwm_duty_ns(dwc, pwm->hwpwm);
+	state->period = __dwc_pwm_period_ns(dwc, pwm->hwpwm,
+					    state->duty_cycle);
+	mutex_unlock(&dwc->lock);
+
+	pm_runtime_put_sync(dwc->dev);
+}
+
+static const struct pwm_ops dwc_pwm_ops = {
+	.apply		= dwc_pwm_apply,
+	.get_state	= dwc_pwm_get_state,
+	.owner		= THIS_MODULE,
+};
+
+static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	struct dwc_pwm_driver_data *data;
+	struct dwc_pwm *dwc;
+	struct device *dev;
+	int ret;
+	int i;
+
+	data = (struct dwc_pwm_driver_data *) id->driver_data;
+	dev = &pci->dev;
+
+	dwc = devm_kzalloc(&pci->dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return -ENOMEM;
+
+	dwc->dev = dev;
+	dwc->clk_period_ns = data->clk_period_ns;
+
+	ret = pcim_enable_device(pci);
+	if (ret)
+		return ret;
+
+	pci_set_master(pci);
+
+	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
+	if (ret)
+		return ret;
+
+	dwc->base = pcim_iomap_table(pci)[0];
+	if (!dwc->base)
+		return -ENOMEM;
+
+	dwc->version = dwc_pwm_readl(dwc->base, DWC_TIMERS_COMP_VERSION);
+
+	/* mask all interrupts and disable all timers */
+	for (i = 0; i < data->npwm; i++) {
+		dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(i), 0);
+		dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT(i), 0);
+		dwc_pwm_writel(dwc->base, DWC_TIM_CUR_VAL(i), 0);
+	}
+
+	mutex_init(&dwc->lock);
+	pci_set_drvdata(pci, dwc);
+
+	dwc->chip.dev = dev;
+	dwc->chip.ops = &dwc_pwm_ops;
+	dwc->chip.npwm = data->npwm;
+	dwc->chip.base = -1;
+
+	ret = pwmchip_add(&dwc->chip);
+	if (ret)
+		return ret;
+
+	pm_runtime_put(dev);
+	pm_runtime_allow(dev);
+
+	return 0;
+}
+
+static void dwc_pwm_remove(struct pci_dev *pci)
+{
+	struct dwc_pwm *dwc = pci_get_drvdata(pci);
+	int i;
+
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
+
+	for (i = 0; i < dwc->chip.npwm; i++)
+		pwm_disable(&dwc->chip.pwms[i]);
+
+	pwmchip_remove(&dwc->chip);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int dwc_pwm_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	int i, index_base;
+
+	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
+		index_base = i * 3;
+		dwc->saved_registers[index_base] =
+			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT(i));
+		dwc->saved_registers[index_base+1] =
+			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(i));
+		dwc->saved_registers[index_base+2] =
+			dwc_pwm_readl(dwc->base, DWC_TIM_CTRL(i));
+	}
+
+	return 0;
+}
+
+static int dwc_pwm_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	int i, index_base;
+
+	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
+		index_base = i * 3;
+		dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT(i),
+			       dwc->saved_registers[index_base]);
+		dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT2(i),
+			       dwc->saved_registers[index_base+1]);
+		dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(i),
+			       dwc->saved_registers[index_base+2]);
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
+
+static const struct dwc_pwm_driver_data ehl_driver_data = {
+	.npwm = 8,
+	.clk_period_ns = 10,
+};
+
+static const struct pci_device_id dwc_pwm_id_table[] = {
+	{ PCI_VDEVICE(INTEL, 0x4bb7), (kernel_ulong_t) &ehl_driver_data },
+	{  }	/* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
+
+static struct pci_driver dwc_pwm_driver = {
+	.name		= "pwm-dwc",
+	.probe		= dwc_pwm_probe,
+	.remove		= dwc_pwm_remove,
+	.id_table	= dwc_pwm_id_table,
+	.driver = {
+		.pm = &dwc_pwm_pm_ops,
+	},
+};
+
+module_pci_driver(dwc_pwm_driver);
+
+MODULE_AUTHOR("Felipe Balbi>");
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

