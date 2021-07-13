Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF73C6FD0
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhGMLiq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 07:38:46 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:52451 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235623AbhGMLip (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Jul 2021 07:38:45 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 3D079440510;
        Tue, 13 Jul 2021 14:35:48 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/4] pwm: driver for qualcomm ipq6018 pwm block
Date:   Tue, 13 Jul 2021 14:35:43 +0300
Message-Id: <1173e7b0b58730fd187871d9e14a02cab85158cc.1626176145.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <f79128fa287e37ee59cb03ae04b319ecb3d68c29.1626176145.git.baruch@tkos.co.il>
References: <f79128fa287e37ee59cb03ae04b319ecb3d68c29.1626176145.git.baruch@tkos.co.il>
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
v5:

Use &tcsr_q6 syscon to access registers (Bjorn Andersson)

Address Uwe Kleine-König review comments:

  Implement .get_state()

  Add IPQ_PWM_ prefix to local macros

  Use GENMASK/BIT/FIELD_PREP for register fields access

  Make type of config_div_and_duty() parameters consistent

  Derive IPQ_PWM_MIN_PERIOD_NS from IPQ_PWM_CLK_SRC_FREQ

  Integrate enable/disable into config_div_and_duty() to save register read,
  and reduce frequency glitch on update

  Use min() instead of min_t()

  Fix comment format

  Use dev_err_probe() to indicate probe step failure

  Add missing clk_disable_unprepare() in .remove

  Don't set .owner

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
 drivers/pwm/Kconfig   |  12 ++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-ipq.c | 278 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+)
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
index 000000000000..ddfbe95816a4
--- /dev/null
+++ b/drivers/pwm/pwm-ipq.c
@@ -0,0 +1,278 @@
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
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#define IPQ_PWM_MAX_DEVICES	4
+
+/* The frequency range supported is 1Hz to 100MHz */
+#define IPQ_PWM_CLK_SRC_FREQ	(100*1000*1000)
+#define IPQ_PWM_MIN_PERIOD_NS	(NSEC_PER_SEC / IPQ_PWM_CLK_SRC_FREQ)
+#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
+
+/*
+ * The max value specified for each field is based on the number of bits
+ * in the pwm control register for that field
+ */
+#define IPQ_PWM_MAX_DIV		0xFFFF
+
+#define IPQ_PWM_CFG_REG0 0 /*PWM_DIV PWM_HI*/
+#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
+#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
+
+#define IPQ_PWM_CFG_REG1 1 /*ENABLE UPDATE PWM_PRE_DIV*/
+#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
+/*
+ * Enable bit is set to enable output toggling in pwm device.
+ * Update bit is set to reflect the changed divider and high duration
+ * values in register.
+ */
+#define IPQ_PWM_REG1_UPDATE		BIT(30)
+#define IPQ_PWM_REG1_ENABLE		BIT(31)
+
+
+struct ipq_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct regmap *regmap;
+	u32 regmap_off;
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
+static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned reg)
+{
+	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
+	unsigned int off = ipq_chip->regmap_off + ipq_pwm_reg_offset(pwm, reg);
+	unsigned int val;
+
+	regmap_read(ipq_chip->regmap, off, &val);
+
+	return val;
+}
+
+static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned reg,
+		unsigned val)
+{
+	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
+	unsigned int off = ipq_chip->regmap_off + ipq_pwm_reg_offset(pwm, reg);
+
+	regmap_write(ipq_chip->regmap, off, val);
+}
+
+static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre_div,
+			unsigned int pwm_div, u64 period_ns, u64 duty_ns,
+			bool enable)
+{
+	unsigned long hi_dur;
+	unsigned long long quotient;
+	unsigned long val = 0;
+
+	/*
+	 * high duration = pwm duty * (pwm div + 1)
+	 * pwm duty = duty_ns / period_ns
+	 */
+	quotient = (pwm_div + 1) * duty_ns;
+	hi_dur = div64_u64(quotient, period_ns);
+
+	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
+		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
+	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG0, val);
+
+	val = FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
+	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
+
+	/* Enable needs a separate write to REG1 */
+	val |= IPQ_PWM_REG1_UPDATE;
+	if (enable)
+		val |= IPQ_PWM_REG1_ENABLE;
+	else
+		val &= ~IPQ_PWM_REG1_ENABLE;
+	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
+}
+
+static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(chip);
+	unsigned long freq;
+	unsigned int pre_div, pwm_div, close_pre_div, close_pwm_div;
+	long long diff;
+	unsigned long rate = clk_get_rate(ipq_chip->clk);
+	unsigned long min_diff = rate;
+	uint64_t fin_ps;
+	u64 period_ns, duty_ns;
+
+	if (state->period < IPQ_PWM_MIN_PERIOD_NS)
+		return -ERANGE;
+
+	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
+	duty_ns = min(state->duty_cycle, period_ns);
+
+	/* freq in Hz for period in nano second */
+	freq = div64_u64(NSEC_PER_SEC, period_ns);
+	fin_ps = div64_u64(NSEC_PER_SEC * 1000ULL, rate);
+	close_pre_div = IPQ_PWM_MAX_DIV;
+	close_pwm_div = IPQ_PWM_MAX_DIV;
+
+	for (pre_div = 0; pre_div <= IPQ_PWM_MAX_DIV; pre_div++) {
+		pwm_div = DIV64_U64_ROUND_CLOSEST(period_ns * 1000,
+						  fin_ps * (pre_div + 1));
+		pwm_div--;
+		if (pwm_div > IPQ_PWM_MAX_DIV)
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
+			    period_ns, duty_ns, state->enabled);
+
+	return 0;
+}
+
+static void ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(chip);
+	unsigned long rate = clk_get_rate(ipq_chip->clk);
+	unsigned int pre_div, pwm_div, hi_dur;
+	u64 effective_div, hi_div;
+	u32 reg0, reg1;
+
+	reg0 = ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG0);
+	reg1 = ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG1);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->enabled = reg1 & IPQ_PWM_REG1_ENABLE;
+
+	pwm_div = FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
+	hi_dur = FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
+	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
+
+	effective_div = (pre_div + 1) * (pwm_div + 1);
+	state->period = div64_u64(effective_div * NSEC_PER_SEC, rate);
+
+	hi_div = hi_dur * (pre_div + 1);
+	state->duty_cycle = div64_u64(hi_div * NSEC_PER_SEC, rate);
+}
+
+static struct pwm_ops ipq_pwm_ops = {
+	.apply = ipq_pwm_apply,
+	.get_state = ipq_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int ipq_pwm_probe(struct platform_device *pdev)
+{
+	struct ipq_pwm_chip *pwm;
+	struct device *dev = &pdev->dev;
+	struct of_phandle_args args;
+	int ret;
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pwm);
+
+	ret = of_parse_phandle_with_fixed_args(dev->of_node, "qcom,pwm-regs",
+			1, 0, &args);
+	if (ret)
+		return dev_err_probe(dev, ret, "regs parse failed");
+
+	pwm->regmap = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	if (IS_ERR(pwm->regmap))
+		return dev_err_probe(dev, PTR_ERR(pwm->regmap),
+				"regs map failed");
+	pwm->regmap_off = args.args[0];
+
+	pwm->clk = devm_clk_get(dev, "core");
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(dev, PTR_ERR(pwm->clk),
+				"failed to get core clock");
+
+	ret = clk_set_rate(pwm->clk, IPQ_PWM_CLK_SRC_FREQ);
+	if (ret)
+		return dev_err_probe(dev, ret, "clock rate set failed");
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "clock enable failed");
+
+	pwm->chip.dev = dev;
+	pwm->chip.ops = &ipq_pwm_ops;
+	pwm->chip.npwm = IPQ_PWM_MAX_DEVICES;
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
+	clk_disable_unprepare(pwm->clk);
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

