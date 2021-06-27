Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D63B5235
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Jun 2021 07:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhF0F0j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 27 Jun 2021 01:26:39 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:55845 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhF0F0i (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 27 Jun 2021 01:26:38 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 3A75C440432;
        Sun, 27 Jun 2021 08:24:09 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] pwm: driver for qualcomm ipq6018 pwm block
Date:   Sun, 27 Jun 2021 08:24:04 +0300
Message-Id: <305eacc9c57c2404795b6be76a08915808e23108.1624771446.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
driver from downstream Codeaurora kernel tree. Removed support for older
(V1) variants because I have no access to that hardware.

Tested on IPQ6010 based hardware.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v4:

  Use div64_u64() to fix link for 32-bit targets ((kernel test robot
  <lkp@intel.com>, Uwe Kleine-König)

v3:

  s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

  Fix integer overflow on 32-bit targets (kernel test robot <lkp@intel.com>)

v2:

Address Uwe Kleine-König review comments:

  Fix period calculation when out of range

  Don't set period larger than requested

  Remove PWM disable on configuration change

  Implement .apply instead of non-atomic .config/.enable/.disable

  Don't modify PWM on .request/.free

  Check pwm_div underflow

  Fix various code and comment formatting issues

Other changes:

  Use u64 divisor safe division

  Remove now empty .request/.free
---
 drivers/pwm/Kconfig   |  12 +++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-ipq.c | 238 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 drivers/pwm/pwm-ipq.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c76adedd58c9..08add845596f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -260,6 +260,18 @@ config PWM_INTEL_LGM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-intel-lgm.
 
+config PWM_IPQ
+	tristate "IPQ PWM support"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on HAVE_CLK && HAS_IOMEM
+	help
+	  Generic PWM framework driver for IPQ PWM block which supports
+	  4 pwm channels. Each of the these channels can be configured
+	  independent of each other.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-ipq.
+
 config PWM_IQS620A
 	tristate "Azoteq IQS620A PWM support"
 	depends on MFD_IQS62X || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 708840b7fba8..7402feae4b36 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
 obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
+obj-$(CONFIG_PWM_IPQ)		+= pwm-ipq.o
 obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
new file mode 100644
index 000000000000..966b051573c8
--- /dev/null
+++ b/drivers/pwm/pwm-ipq.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/math64.h>
+#include <linux/of_device.h>
+
+#define CLK_SRC_FREQ		(100*1000*1000)
+#define MAX_PWM_DEVICES		4
+
+/*
+ * Enable bit is set to enable output toggling in pwm device.
+ * Update bit is set to reflect the changed divider and high duration
+ * values in register.
+ */
+#define PWM_ENABLE		0x80000000
+#define PWM_UPDATE		0x40000000
+
+/* The frequency range supported is 1Hz to 100MHz */
+#define MIN_PERIOD_NS	10
+#define MAX_PERIOD_NS	1000000000
+
+/*
+ * The max value specified for each field is based on the number of bits
+ * in the pwm control register for that field
+ */
+#define MAX_PWM_CFG		0xFFFF
+
+#define PWM_CTRL_HI_SHIFT	16
+
+#define PWM_CFG_REG0 0 /*PWM_DIV PWM_HI*/
+#define PWM_CFG_REG1 1 /*ENABLE UPDATE PWM_PRE_DIV*/
+
+struct ipq_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *mem;
+};
+
+static struct ipq_pwm_chip *to_ipq_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ipq_pwm_chip, chip);
+}
+
+static unsigned ipq_pwm_reg_offset(struct pwm_device *pwm, unsigned reg)
+{
+	return ((pwm->hwpwm * 2) + reg) * 4;
+}
+
+static void config_div_and_duty(struct pwm_device *pwm, int pre_div,
+			unsigned long long pwm_div, unsigned long period_ns,
+			unsigned long long duty_ns)
+{
+	unsigned long hi_dur;
+	unsigned long long quotient;
+	unsigned long val = 0;
+	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
+
+	/*
+	 * high duration = pwm duty * (pwm div + 1)
+	 * pwm duty = duty_ns / period_ns
+	 */
+	quotient = (pwm_div + 1) * duty_ns;
+	hi_dur = div64_u64(quotient, period_ns);
+
+	val |= ((hi_dur & MAX_PWM_CFG) << PWM_CTRL_HI_SHIFT);
+	val |= (pwm_div & MAX_PWM_CFG);
+	writel(val, ipq_chip->mem + ipq_pwm_reg_offset(pwm, PWM_CFG_REG0));
+	val = pre_div & MAX_PWM_CFG;
+	writel(val, ipq_chip->mem + ipq_pwm_reg_offset(pwm, PWM_CFG_REG1));
+}
+
+static int ipq_pwm_enable(struct pwm_device *pwm)
+{
+	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
+	unsigned offset = ipq_pwm_reg_offset(pwm, PWM_CFG_REG1);
+	unsigned long val;
+
+	val = readl(ipq_chip->mem + offset);
+	val |= PWM_ENABLE | PWM_UPDATE;
+	writel(val, ipq_chip->mem + offset);
+
+	return 0;
+}
+
+static void ipq_pwm_disable(struct pwm_device *pwm)
+{
+	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
+	unsigned offset = ipq_pwm_reg_offset(pwm, PWM_CFG_REG1);
+	unsigned long val;
+
+	val = readl(ipq_chip->mem + offset);
+	val |= PWM_UPDATE;
+	val &= ~PWM_ENABLE;
+	writel(val, ipq_chip->mem + offset);
+}
+
+static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(chip);
+	unsigned long freq;
+	int pre_div, close_pre_div, close_pwm_div;
+	int pwm_div;
+	long long diff;
+	unsigned long rate = clk_get_rate(ipq_chip->clk);
+	unsigned long min_diff = rate;
+	uint64_t fin_ps;
+	u64 period_ns, duty_ns;
+
+	if (state->period < MIN_PERIOD_NS)
+		return -ERANGE;
+
+	period_ns = min_t(u64, state->period, MAX_PERIOD_NS);
+	duty_ns = min_t(u64, state->duty_cycle, period_ns);
+
+	/* freq in Hz for period in nano second*/
+	freq = div64_u64(NSEC_PER_SEC, period_ns);
+	fin_ps = div64_u64(NSEC_PER_SEC * 1000ULL, rate);
+	close_pre_div = MAX_PWM_CFG;
+	close_pwm_div = MAX_PWM_CFG;
+
+	for (pre_div = 0; pre_div <= MAX_PWM_CFG; pre_div++) {
+		pwm_div = DIV64_U64_ROUND_CLOSEST(period_ns * 1000,
+						  fin_ps * (pre_div + 1));
+		pwm_div--;
+		if (pwm_div < 0 || pwm_div > MAX_PWM_CFG)
+			continue;
+
+		diff = ((uint64_t)freq * (pre_div + 1) * (pwm_div + 1))
+			- (uint64_t)rate;
+
+		if (diff < 0) /* period larger than requested */
+			continue;
+		if (diff == 0) { /* bingo */
+			close_pre_div = pre_div;
+			close_pwm_div = pwm_div;
+			break;
+		}
+		if (diff < min_diff) {
+			min_diff = diff;
+			close_pre_div = pre_div;
+			close_pwm_div = pwm_div;
+		}
+	}
+
+	/* config divider values for the closest possible frequency */
+	config_div_and_duty(pwm, close_pre_div, close_pwm_div,
+			    period_ns, duty_ns);
+	if (state->enabled)
+		ipq_pwm_enable(pwm);
+	else
+		ipq_pwm_disable(pwm);
+
+	return 0;
+}
+
+static struct pwm_ops ipq_pwm_ops = {
+	.apply = ipq_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static int ipq_pwm_probe(struct platform_device *pdev)
+{
+	struct ipq_pwm_chip *pwm;
+	struct device *dev;
+	int ret;
+
+	dev = &pdev->dev;
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pwm);
+
+	pwm->mem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pwm->mem))
+		return PTR_ERR(pwm->mem);
+
+	pwm->clk = devm_clk_get(dev, "core");
+	if (IS_ERR(pwm->clk))
+		return PTR_ERR(pwm->clk);
+
+	ret = clk_set_rate(pwm->clk, CLK_SRC_FREQ);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret)
+		return ret;
+
+	pwm->chip.dev = dev;
+	pwm->chip.ops = &ipq_pwm_ops;
+	pwm->chip.npwm = MAX_PWM_DEVICES;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "pwmchip_add() failed\n");
+		clk_disable_unprepare(pwm->clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ipq_pwm_remove(struct platform_device *pdev)
+{
+	struct ipq_pwm_chip *pwm = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&pwm->chip);
+
+	return 0;
+}
+
+static const struct of_device_id pwm_ipq_dt_match[] = {
+	{ .compatible = "qcom,ipq6018-pwm", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pwm_ipq_dt_match);
+
+static struct platform_driver ipq_pwm_driver = {
+	.driver = {
+		.name = "ipq-pwm",
+		.owner = THIS_MODULE,
+		.of_match_table = pwm_ipq_dt_match,
+	},
+	.probe = ipq_pwm_probe,
+	.remove = ipq_pwm_remove,
+};
+
+module_platform_driver(ipq_pwm_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.2

