Return-Path: <linux-pwm+bounces-7758-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14007CA6D04
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Dec 2025 10:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEBA1300A217
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Dec 2025 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EB33164D8;
	Fri,  5 Dec 2025 09:05:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B422A3164BA;
	Fri,  5 Dec 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925530; cv=none; b=rwNalLNddpV9Pd4u1HzfEPzYUh6srfdOHdnD6Uvk7UVdz22c9cv3jngEdAHPtQjghCQcEz/HA+lis4Miu7jsUf9hoCHCoXZIiMLBovo7SXRiE5ER4D1ToQVvqmsC2veCdLayRIRdqM2nxCHo9OBfKrXIcKC/rxger2e7D3mljlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925530; c=relaxed/simple;
	bh=kFJWgizR8VgCmy+2b8tT1EoUHbtRuPRCnCXFV97/WLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piKoyLRyBLQdbhRLBfrP6ZO8jFwvirOk3QiA7Pm+t/1jt2uwf55/03tGhCjIJNIqoNrmkbXjuk+GZpi2/fDvZeZlpJXtD/r7ndiX29czGThAL31Ut11qDNzqBYw3zgMWwZeTn4epaHzYITl9zGBNvaWxBZezA2QxzT40JtHXsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgAHD2xHoDJpc9mBAA--.54444S2;
	Fri, 05 Dec 2025 17:05:12 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH 2/2] pwm: eswin: Add EIC7700 pwm driver
Date: Fri,  5 Dec 2025 17:05:09 +0800
Message-Id: <20251205090509.1501-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20251205090411.1388-1-dongxuyang@eswincomputing.com>
References: <20251205090411.1388-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAHD2xHoDJpc9mBAA--.54444S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kw1DAry5XF4xZr1xur13XFb_yoW8JFyUAo
	WIkr1fXw1rKr4rC393ua429ayjv3yvkw1fuw1rWr4DuFn8Aw15JFWDK34ag34aqF1ayrWr
	Ar4xXr1fAF4fJ3W8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOEfODUUUU
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Introduce driver for PWM module available on EIC7700 SoC.
Add snps,pwm-0-n-100-percent flag to support for both
0% and 100% duty cycles. And remove this flag to support
the duty cycle range from 0% to 100%.

Signed-off-by: Xiang Xu <xuxiang@eswincomputing.com>
Signed-off-by: Guosheng Wang <wangguosheng@eswincomputing.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 drivers/pwm/Kconfig           |  12 ++
 drivers/pwm/Makefile          |   1 +
 drivers/pwm/pwm-dwc-core.c    |  76 ++++++++---
 drivers/pwm/pwm-dwc-eic7700.c | 231 ++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-dwc.h         |  16 ++-
 5 files changed, 311 insertions(+), 25 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-eic7700.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index bf2d101f67a1..c2cf0d9c9854 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -249,6 +249,18 @@ config PWM_DWC
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc.
 
+config PWM_EIC7700
+	tristate "EIC7700 PWM Controller"
+	depends on ARCH_ESWIN || COMPILE_TEST
+	depends on HAS_IOMEM
+	select PWM_DWC_CORE
+	help
+	  PWM driver for Synopsys DWC PWM Controller on a platform for EIC7700
+	  SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-dwc-eic7700.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0dc0d2b69025..2b4b7a5c5b15 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
+obj-$(CONFIG_PWM_EIC7700)	+= pwm-dwc-eic7700.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_GPIO)		+= pwm-gpio.o
diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 6dabec93a3c6..ec90f75c840e 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -44,21 +44,47 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	u32 high;
 	u32 low;
 
-	/*
-	 * Calculate width of low and high period in terms of input clock
-	 * periods and check are the result within HW limits between 1 and
-	 * 2^32 periods.
-	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
-	if (tmp < 1 || tmp > (1ULL << 32))
-		return -ERANGE;
-	low = tmp - 1;
-
-	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    dwc->clk_ns);
-	if (tmp < 1 || tmp > (1ULL << 32))
-		return -ERANGE;
-	high = tmp - 1;
+	if (dwc->pwm_0n100_enable) {
+		/*
+		 * Calculate width of low and high period in terms of input
+		 * clock periods and check are the result within HW limits
+		 * between 0 and 2^32 periods.
+		 */
+		tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
+		if (tmp < 0 || tmp > (1UL << 32))
+			return -ERANGE;
+
+		if (pwm->args.polarity == PWM_POLARITY_INVERSED)
+			high = tmp;
+		else
+			low = tmp;
+
+		tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
+					    dwc->clk_ns);
+		if (tmp < 0 || tmp > (1UL << 32))
+			return -ERANGE;
+
+		if (pwm->args.polarity == PWM_POLARITY_INVERSED)
+			low = tmp;
+		else
+			high = tmp;
+	} else {
+		/*
+		 * Calculate width of low and high period in terms of input
+		 * clock periods and check are the result within HW limits
+		 * between 1 and 2^32 periods.
+		 */
+		tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
+		if (tmp < 1 || tmp > (1ULL << 32))
+			return -ERANGE;
+		low = tmp - 1;
+
+		tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
+					    dwc->clk_ns);
+		if (tmp < 1 || tmp > (1ULL << 32))
+			return -ERANGE;
+		high = tmp - 1;
+	}
 
 	/*
 	 * Specification says timer usage flow is to disable timer, then
@@ -73,7 +99,8 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * Write Load Count and Load Count 2 registers. Former defines the
 	 * width of low period and latter the width of high period in terms
 	 * multiple of input clock periods:
-	 * Width = ((Count + 1) * input clock period).
+	 * Width = ((Count + 1) * input clock period) or
+	 * Width = (Count * input clock period) : supported 0% and 100%).
 	 */
 	dwc_pwm_writel(dwc, low, DWC_TIM_LD_CNT(pwm->hwpwm));
 	dwc_pwm_writel(dwc, high, DWC_TIM_LD_CNT2(pwm->hwpwm));
@@ -85,6 +112,9 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * periods are set by Load Count registers.
 	 */
 	ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
+	if (dwc->pwm_0n100_enable)
+		ctrl |= DWC_TIM_CTRL_0N100PWM_EN;
+
 	dwc_pwm_writel(dwc, ctrl, DWC_TIM_CTRL(pwm->hwpwm));
 
 	/*
@@ -137,9 +167,17 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * based on the timer load-count only.
 	 */
 	if (ctrl & DWC_TIM_CTRL_PWM) {
-		duty = (ld + 1) * dwc->clk_ns;
-		period = (ld2 + 1)  * dwc->clk_ns;
-		period += duty;
+		if (dwc->pwm_0n100_enable) {
+			if (pwm->args.polarity == PWM_POLARITY_INVERSED)
+				duty = ld2 * dwc->clk_ns;
+			else
+				duty = ld * dwc->clk_ns;
+			period = (ld + ld2) * dwc->clk_ns;
+		} else {
+			duty = (ld + 1) * dwc->clk_ns;
+			period = (ld2 + 1)  * dwc->clk_ns;
+			period += duty;
+		}
 	} else {
 		duty = (ld + 1) * dwc->clk_ns;
 		period = duty * 2;
diff --git a/drivers/pwm/pwm-dwc-eic7700.c b/drivers/pwm/pwm-dwc-eic7700.c
new file mode 100644
index 000000000000..1bbe5593934b
--- /dev/null
+++ b/drivers/pwm/pwm-dwc-eic7700.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ESWIN PWM driver (Based on DesignWare PWM Controller driver)
+ *
+ * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
+ * All rights reserved.
+ *
+ * Authors:
+ *	Xiang Xu <xuxiang@eswincomputing.com>
+ *	Guosheng Wang <wangguosheng@eswincomputing.com>
+ *	Xuyang Dong <dongxuyang@eswincomputing.com>
+ *
+ * Characteristics:
+ * - The hardware can generate 0% and 100% duty cycle.
+ *   - 0% duty cycle (fully off)
+ *   - 100% duty cycle (fully on)
+ *
+ * Limitations:
+ * - The duty cycle and period cannot both be set to 0.
+ * - The controller hardware provides up to 3 PWM channels.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+#include "pwm-dwc.h"
+
+#define DW_PWMS_TOTAL	3
+
+static int eic7700_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc_pwm_drvdata *data;
+	struct pwm_chip *chip = NULL;
+	struct dwc_pwm *dwc = NULL;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	chip = dwc_pwm_alloc(dev);
+	if (IS_ERR(chip))
+		return dev_err_probe(dev, -ENOMEM, "failed to alloc pwm\n");
+
+	dwc = to_dwc_pwm(chip);
+
+	if (of_property_read_bool(dev->of_node, "snps,pwm-full-range-enable"))
+		dwc->pwm_0n100_enable = true;
+
+	dwc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dwc->base))
+		return dev_err_probe(dev, PTR_ERR(dwc->base),
+				     "failed to get base\n");
+
+	dwc->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(dwc->clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->clk),
+				     "failed to get clock\n");
+
+	ret = clk_prepare_enable(dwc->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clock\n");
+
+	dwc->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(dwc->rst)) {
+		dev_err(dev, "failed to get reset control\n");
+		ret = PTR_ERR(dwc->rst);
+		goto err_clk_disable;
+	}
+
+	ret = reset_control_deassert(dwc->rst);
+	if (ret) {
+		dev_err(dev, "failed to deassert reset: %d\n", ret);
+		goto err_clk_disable;
+	}
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret) {
+		dev_err(dev, "failed to add pwmchip: %d\n", ret);
+		goto err_reset_assert;
+	}
+
+	data->chips[0] = chip;
+	dev_set_drvdata(dev, data);
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_noresume(dev);
+
+	return 0;
+
+err_reset_assert:
+	reset_control_assert(dwc->rst);
+err_clk_disable:
+	clk_disable_unprepare(dwc->clk);
+
+	return ret;
+}
+
+static void eic7700_pwm_remove(struct platform_device *pdev)
+{
+	struct dwc_pwm_drvdata *data = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = data->chips[0];
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	struct device *dev = &pdev->dev;
+
+	clk_disable_unprepare(dwc->clk);
+	reset_control_assert(dwc->rst);
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+}
+
+static int eic7700_pwm_runtime_suspend(struct device *dev)
+{
+	struct dwc_pwm_drvdata *data = dev_get_drvdata(dev);
+	struct pwm_chip *chip = data->chips[0];
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	int idx, ret;
+
+	for (idx = 0; idx < DW_PWMS_TOTAL; idx++) {
+		if (chip->pwms[idx].state.enabled)
+			return -EBUSY;
+
+		dwc->ctx[idx].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(idx));
+		dwc->ctx[idx].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(idx));
+		dwc->ctx[idx].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(idx));
+	}
+
+	clk_disable_unprepare(dwc->clk);
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret) {
+		dev_err(dev, "failed to select sleep state: %d\n", ret);
+		clk_prepare_enable(dwc->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int eic7700_pwm_runtime_resume(struct device *dev)
+{
+	struct dwc_pwm_drvdata *data = dev_get_drvdata(dev);
+	struct pwm_chip *chip = data->chips[0];
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	int idx, ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret) {
+		dev_err(dev, "failed to select default state: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(dwc->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	for (idx = 0; idx < DW_PWMS_TOTAL; idx++) {
+		dwc_pwm_writel(dwc, dwc->ctx[idx].cnt, DWC_TIM_LD_CNT(idx));
+		dwc_pwm_writel(dwc, dwc->ctx[idx].cnt2, DWC_TIM_LD_CNT2(idx));
+		dwc_pwm_writel(dwc, dwc->ctx[idx].ctrl, DWC_TIM_CTRL(idx));
+	}
+
+	return 0;
+}
+
+static int eic7700_pwm_suspend(struct device *dev)
+{
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
+		ret = eic7700_pwm_runtime_suspend(dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int eic7700_pwm_resume(struct device *dev)
+{
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
+		ret = eic7700_pwm_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops eic7700_pwm_pm_ops = {
+	RUNTIME_PM_OPS(eic7700_pwm_runtime_suspend, eic7700_pwm_runtime_resume,
+		       NULL)
+	SYSTEM_SLEEP_PM_OPS(eic7700_pwm_suspend, eic7700_pwm_resume)
+};
+
+static const struct of_device_id eic7700_pwm_id_table[] = {
+	{ .compatible = "eswin,eic7700-pwm", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, eic7700_pwm_id_table);
+
+static struct platform_driver eic7700_pwm_driver = {
+	.probe = eic7700_pwm_probe,
+	.remove = eic7700_pwm_remove,
+	.driver = {
+		.name	= "eic7700-pwm",
+		.pm = pm_sleep_ptr(&eic7700_pwm_pm_ops),
+		.of_match_table = of_match_ptr(eic7700_pwm_id_table),
+	},
+};
+
+module_platform_driver(eic7700_pwm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Xiang Xu <xuxiang@eswincomputing.com>");
+MODULE_AUTHOR("Guosheng Wang <wangguosheng@eswincomputing.com>");
+MODULE_AUTHOR("Xuyang Dong <dongxuyang@eswincomputing.com>");
+MODULE_DESCRIPTION("ESWIN EIC7700 PWM Controller");
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 1562594e7f85..27d567e82ac0 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -26,12 +26,13 @@ MODULE_IMPORT_NS("dwc_pwm");
 #define DWC_TIMERS_TOTAL	8
 
 /* Timer Control Register */
-#define DWC_TIM_CTRL_EN		BIT(0)
-#define DWC_TIM_CTRL_MODE	BIT(1)
-#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
-#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
-#define DWC_TIM_CTRL_INT_MASK	BIT(2)
-#define DWC_TIM_CTRL_PWM	BIT(3)
+#define DWC_TIM_CTRL_EN			BIT(0)
+#define DWC_TIM_CTRL_MODE		BIT(1)
+#define DWC_TIM_CTRL_MODE_FREE		(0 << 1)
+#define DWC_TIM_CTRL_MODE_USER		BIT(1)
+#define DWC_TIM_CTRL_INT_MASK		BIT(2)
+#define DWC_TIM_CTRL_PWM		BIT(3)
+#define DWC_TIM_CTRL_0N100PWM_EN	BIT(4)
 
 struct dwc_pwm_info {
 	unsigned int nr;
@@ -53,6 +54,9 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	void __iomem *base;
 	unsigned int clk_ns;
+	struct clk *clk;
+	struct reset_control *rst;
+	bool pwm_0n100_enable;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 
-- 
2.34.1


