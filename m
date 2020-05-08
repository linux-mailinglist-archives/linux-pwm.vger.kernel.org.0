Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C35D1CAAA8
	for <lists+linux-pwm@lfdr.de>; Fri,  8 May 2020 14:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgEHMci (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 May 2020 08:32:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:46189 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgEHMci (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 8 May 2020 08:32:38 -0400
IronPort-SDR: fhQqgsn1ufwczvUeDcv4oW9XwtgvbMPr65YErQACMHII/w0YnROXY/xvixSnoeYJh2Z6jAczUf
 Wpz5Fk1o9PBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 05:32:37 -0700
IronPort-SDR: gm0WPc8R2lcwSXsZV5XjqvWJNPF3IK2oBgT2e3m+9/IbLZFceDIgYzAI2CGuX8tLeK4IMGQDEM
 07QjVdx4oojA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,367,1583222400"; 
   d="scan'208";a="462241215"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.167])
  by fmsmga005.fm.intel.com with ESMTP; 08 May 2020 05:32:35 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Raymond Tan <raymond.tan@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v2] pwm: Add DesignWare PWM Controller Driver
Date:   Fri,  8 May 2020 15:32:33 +0300
Message-Id: <20200508123233.712610-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Introduce driver for Synopsys DesignWare PWM Controller used on Intel
Elkhart Lake.

Initial implementation is done by Felipe Balbi while he was working at
Intel with later changes from Raymond Tan and me.

Co-developed-by: Felipe Balbi (Intel) <balbi@kernel.org>
Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
Co-developed-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
v2. First version here https://www.spinics.net/lists/linux-pwm/msg12122.html
Thanks to Uwe Kleine-König for good review comments, hopefully I captured
them all.
Changes:
- Added Felipe's Signed-of-by. I added (Intel) to his kernel.org address
  to highlight contribution was done while working at Intel
- Version register read removed as result was unused
- Order of dwc_pwm_writel() arguments changed to match with writel()
- Structure initializers use one space instead of tab alignment
- Error messages added to dwc_pwm_probe()
- MODULE_LICENSE() Updated based on a review comment and commit bf7fbeeae6db
  ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
- Polarity handled. HW supports only normal polarity and driver errors
  out in case of wrong polarity in dwc_pwm_apply() and returns fixed
  normal polarity in dwc_pwm_get_state()
- Running timers are not stopped on probe and remove. Those may be set
  running by a bootloader and driver should leave them runnning
- pwm_is_enabled() call changed to pwm->state.enabled in wc_pwm_apply()
- Co-authors added to MODULE_AUTHOR() and comment
- mutex removed
- Add struct dwc_pwm_ctx for register save/restore instead of word array
- suspend prevented in case of active PWM consumers. Please note this
  checks only PWMs enabled by Linux consumers and not the ones enabled
  by bootloader
- Duplicate linux/pm_runtime.h include removed
- Only once used trivial functions moved to dwc_pwm_get_state()
- struct dwc_pwm_driver_data removed and used hard coded properties
  instead since currently driver supports single device type
- Driver uses internally 64-bit duty and period calculation and caps
  them to 32-bit ns max value for PWM core. HW supports 32-bit high and
  low period counters with 10 ns resolution so HW can do ~42,9 s duty and
  ~85.9 s period at maximum
---
 drivers/pwm/Kconfig   |   9 ++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-dwc.c | 300 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+)
 create mode 100644 drivers/pwm/pwm-dwc.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c13d146cdde5..3a8fdba9b680 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -160,6 +160,15 @@ config PWM_CROS_EC
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
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a59c710e98c7..da5d9fefd183 100644
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
index 000000000000..21740273e7a3
--- /dev/null
+++ b/drivers/pwm/pwm-dwc.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * DesignWare PWM Controller driver
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ *
+ * Author: Felipe Balbi (Intel)
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Author: Raymond Tan <raymond.tan@intel.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
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
+#define DWC_CLK_PERIOD_NS	10
+
+/* Timer Control Register */
+#define DWC_TIM_CTRL_EN		BIT(0)
+#define DWC_TIM_CTRL_MODE	BIT(1)
+#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
+#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
+#define DWC_TIM_CTRL_INT_MASK	BIT(2)
+#define DWC_TIM_CTRL_PWM	BIT(3)
+
+struct dwc_pwm_ctx {
+	u32 cnt;
+	u32 cnt2;
+	u32 ctrl;
+};
+
+struct dwc_pwm {
+	struct pwm_chip chip;
+	struct device *dev;
+
+	unsigned long clk_period_ns;
+
+	void __iomem *base;
+
+	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
+};
+#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
+
+static inline u32 dwc_pwm_readl(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static inline void dwc_pwm_writel(u32 value, void __iomem *base, u32 offset)
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
+	dwc_pwm_writel(low, dwc->base, DWC_TIM_LD_CNT(pwm));
+	dwc_pwm_writel(high, dwc->base, DWC_TIM_LD_CNT2(pwm));
+
+	ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
+	dwc_pwm_writel(ctrl, dwc->base, DWC_TIM_CTRL(pwm));
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
+	dwc_pwm_writel(reg, dwc->base, DWC_TIM_CTRL(pwm));
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
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (state->enabled) {
+		if (!pwm->state.enabled)
+			pm_runtime_get_sync(dwc->dev);
+		__dwc_pwm_configure_timer(dwc, pwm, state);
+	} else {
+		if (pwm->state.enabled) {
+			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
+			pm_runtime_put_sync(dwc->dev);
+		}
+	}
+
+	return 0;
+}
+
+static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	u64 duty, period;
+
+	pm_runtime_get_sync(dwc->dev);
+
+	state->enabled = !!(dwc_pwm_readl(dwc->base,
+				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
+
+	duty = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(pwm->hwpwm));
+	duty += 1;
+	duty *= dwc->clk_period_ns;
+	/* Cap the value to 2^32-1 ns */
+	state->duty_cycle = min(duty, (u64)(u32)-1);
+
+	period = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT(pwm->hwpwm));
+	period += 1;
+	period *= dwc->clk_period_ns;
+	period += duty;
+	/* Cap the value to 2^32-1 ns */
+	state->period = min(period, (u64)(u32)-1);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	pm_runtime_put_sync(dwc->dev);
+}
+
+static const struct pwm_ops dwc_pwm_ops = {
+	.apply = dwc_pwm_apply,
+	.get_state = dwc_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
+{
+	struct dwc_pwm *dwc;
+	struct device *dev;
+	int ret;
+
+	dev = &pci->dev;
+
+	dwc = devm_kzalloc(&pci->dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return -ENOMEM;
+
+	dwc->dev = dev;
+	dwc->clk_period_ns = DWC_CLK_PERIOD_NS;
+
+	ret = pcim_enable_device(pci);
+	if (ret) {
+		dev_err(&pci->dev, "Failed to enable device (%d)\n", ret);
+		return ret;
+	}
+
+	pci_set_master(pci);
+
+	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
+	if (ret) {
+		dev_err(&pci->dev, "Failed to iomap PCI BAR (%d)\n", ret);
+		return ret;
+	}
+
+	dwc->base = pcim_iomap_table(pci)[0];
+	if (!dwc->base) {
+		dev_err(&pci->dev, "Base address missing\n");
+		return -ENOMEM;
+	}
+
+	pci_set_drvdata(pci, dwc);
+
+	dwc->chip.dev = dev;
+	dwc->chip.ops = &dwc_pwm_ops;
+	dwc->chip.npwm = DWC_TIMERS_TOTAL;
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
+
+	pm_runtime_forbid(&pci->dev);
+	pm_runtime_get_noresume(&pci->dev);
+
+	pwmchip_remove(&dwc->chip);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int dwc_pwm_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
+		if (dwc->chip.pwms[i].state.enabled) {
+			dev_err(dev, "PWM %u in use by consumer (%s)\n",
+				i, dwc->chip.pwms[i].label);
+			return -EBUSY;
+		}
+		dwc->ctx[i].cnt =
+			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT(i));
+		dwc->ctx[i].cnt2 =
+			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(i));
+		dwc->ctx[i].ctrl =
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
+	int i;
+
+	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
+		dwc_pwm_writel(dwc->ctx[i].cnt,
+			       dwc->base, DWC_TIM_LD_CNT(i));
+		dwc_pwm_writel(dwc->ctx[i].cnt2,
+			       dwc->base, DWC_TIM_LD_CNT2(i));
+		dwc_pwm_writel(dwc->ctx[i].ctrl,
+			       dwc->base, DWC_TIM_CTRL(i));
+	}
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(dwc_pwm_pm_ops, dwc_pwm_suspend, dwc_pwm_resume);
+
+static const struct pci_device_id dwc_pwm_id_table[] = {
+	{ PCI_VDEVICE(INTEL, 0x4bb7) }, /* Elkhart Lake */
+	{  }	/* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(pci, dwc_pwm_id_table);
+
+static struct pci_driver dwc_pwm_driver = {
+	.name = "pwm-dwc",
+	.probe = dwc_pwm_probe,
+	.remove = dwc_pwm_remove,
+	.id_table = dwc_pwm_id_table,
+	.driver = {
+		.pm = &dwc_pwm_pm_ops,
+	},
+};
+
+module_pci_driver(dwc_pwm_driver);
+
+MODULE_AUTHOR("Felipe Balbi (Intel)");
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
+MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
+
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL");
-- 
2.26.2

