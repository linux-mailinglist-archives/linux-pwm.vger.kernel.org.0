Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1CA2579AF
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHaMuQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 08:50:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:57782 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgHaMuL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 Aug 2020 08:50:11 -0400
IronPort-SDR: RFCV1XGonwqFuA6R8Rb5VkUkyCGQTGzfUc9Ijd5hnEJQ6dVXBaWutdPn+5jrUAfnpiBgaMRsyp
 6+cdO04jjT8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="136490184"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="136490184"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 05:50:11 -0700
IronPort-SDR: XAP9e9ZCGj3NDFRpoclYmtIALrsnho/qsgTX/CIkMBeaObmR5xb95cIYltajj7tE90jJw6gSrY
 0eQMDXi4smhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="340640966"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.94])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2020 05:50:08 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH] pwm: Add DesignWare PWM Controller Driver
Date:   Mon, 31 Aug 2020 15:50:01 +0300
Message-Id: <20200831125001.1309453-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.28.0
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
v3. Previous version: https://www.spinics.net/lists/linux-pwm/msg12363.html
Changes:
- I got confirmation specification is not publicly available
- HW is actually fixed inversed polarity by the PWM framework
  conventions: HW cycle begins with a low period. Fixed polarity and
  low/high period calculation accordingly
- Added range check to period and duty_cycle
- Bogus '*' removed from head of the file comment
- struct dwc_pwm * passed to readl/writel wrappers instead of __iomem *
- %pe for error code prints
- clk_period_ns removed from struct dwc_pwm and use DWC_CLK_PERIOD_NS instead
- Device pointer removed from struct dwc_pwm, it's already carried in
  struct pwm_chip
- Added Limitations paragraph and commenting timer usage flow in code
- duty_cycle and period capping to 32-bit removed from
  dwc_pwm_get_state() since PWM core has been converted to 64-bit
- s/DIV_ROUND_CLOSEST/DIV_ROUND_CLOSEST_ULL/ to fix a link error on
  32-bit ARM and older GCC-9 build. Reported by kernel test robot
  <lkp@intel.com> on an internal tree
- Random cleanups, empty line removals etc
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
 drivers/pwm/pwm-dwc.c | 321 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 331 insertions(+)
 create mode 100644 drivers/pwm/pwm-dwc.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 9448e4ca8c73..ab79cb4734f1 100644
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
index 2c2ba0a03557..a1b7098fc4b8 100644
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
index 000000000000..e9cc57fc58d6
--- /dev/null
+++ b/drivers/pwm/pwm-dwc.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ *
+ * Author: Felipe Balbi (Intel)
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Author: Raymond Tan <raymond.tan@intel.com>
+ *
+ * Limitations:
+ * - The hardware cannot generate a 0 % or 100 % duty cycle. Both high and low
+ *   periods are one or more input clock periods long.
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
+	void __iomem *base;
+	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
+};
+#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
+
+static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
+{
+	return readl(dwc->base + offset);
+}
+
+static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
+{
+	writel(value, dwc->base + offset);
+}
+
+static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int enabled)
+{
+	u32 reg;
+
+	reg = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm));
+
+	if (enabled)
+		reg |= DWC_TIM_CTRL_EN;
+	else
+		reg &= ~DWC_TIM_CTRL_EN;
+
+	dwc_pwm_writel(dwc, reg, DWC_TIM_CTRL(pwm));
+}
+
+static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
+				     struct pwm_device *pwm,
+				     const struct pwm_state *state)
+{
+	u64 tmp;
+	u32 ctrl;
+	u32 high;
+	u32 low;
+
+	/*
+	 * Calculate width of low and high period in terms of input clock
+	 * periods and check are the result within HW limits between 1 and
+	 * 2^32 periods.
+	 */
+	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
+	if (tmp < 1 || tmp > (1ULL << 32))
+		return -ERANGE;
+	low = tmp - 1;
+
+	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
+				    DWC_CLK_PERIOD_NS);
+	if (tmp < 1 || tmp > (1ULL << 32))
+		return -ERANGE;
+	high = tmp - 1;
+
+	/*
+	 * Specification says timer usage flow is to disable timer, then
+	 * program it followed by enable. It also says Load Count is loaded
+	 * into timer after it is enabled - either after a disable or
+	 * a reset. Based on measurements it happens also without disable
+	 * whenever Load Count is updated. But follow the specification.
+	 */
+	__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
+
+	/*
+	 * Write Load Count and Load Count 2 registers. Former defines the
+	 * width of low period and latter the width of high period in terms
+	 * multiple of input clock periods:
+	 * Width = ((Count + 1) * input clock period).
+	 */
+	dwc_pwm_writel(dwc, low, DWC_TIM_LD_CNT(pwm->hwpwm));
+	dwc_pwm_writel(dwc, high, DWC_TIM_LD_CNT2(pwm->hwpwm));
+
+	/*
+	 * Set user-defined mode, timer reloads from Load Count registers
+	 * when it counts down to 0.
+	 * Set PWM mode, it makes output to toggle and width of low and high
+	 * periods are set by Load Count registers.
+	 */
+	ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
+	dwc_pwm_writel(dwc, ctrl, DWC_TIM_CTRL(pwm->hwpwm));
+
+	/*
+	 * Enable timer. Output starts from low period.
+	 */
+	__dwc_pwm_set_enable(dwc, pwm->hwpwm, state->enabled);
+
+	return 0;
+}
+
+static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (state->enabled) {
+		if (!pwm->state.enabled)
+			pm_runtime_get_sync(chip->dev);
+		return __dwc_pwm_configure_timer(dwc, pwm, state);
+	} else {
+		if (pwm->state.enabled) {
+			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
+			pm_runtime_put_sync(chip->dev);
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
+	pm_runtime_get_sync(chip->dev);
+
+	state->enabled = !!(dwc_pwm_readl(dwc,
+				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
+
+	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
+	duty += 1;
+	duty *= DWC_CLK_PERIOD_NS;
+	state->duty_cycle = duty;
+
+	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
+	period += 1;
+	period *= DWC_CLK_PERIOD_NS;
+	period += duty;
+	state->period = period;
+
+	state->polarity = PWM_POLARITY_INVERSED;
+
+	pm_runtime_put_sync(chip->dev);
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
+	ret = pcim_enable_device(pci);
+	if (ret) {
+		dev_err(&pci->dev,
+			"Failed to enable device (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	pci_set_master(pci);
+
+	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
+	if (ret) {
+		dev_err(&pci->dev,
+			"Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
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
+		dwc->ctx[i].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
+		dwc->ctx[i].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(i));
+		dwc->ctx[i].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(i));
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
+		dwc_pwm_writel(dwc, dwc->ctx[i].cnt, DWC_TIM_LD_CNT(i));
+		dwc_pwm_writel(dwc, dwc->ctx[i].cnt2, DWC_TIM_LD_CNT2(i));
+		dwc_pwm_writel(dwc, dwc->ctx[i].ctrl, DWC_TIM_CTRL(i));
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
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL");
-- 
2.28.0

