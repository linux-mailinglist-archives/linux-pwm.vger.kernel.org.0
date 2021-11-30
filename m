Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB09463D24
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Nov 2021 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbhK3RsH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Nov 2021 12:48:07 -0500
Received: from bzq-84-110-109-230.cablep.bezeqint.net ([84.110.109.230]:41411
        "EHLO mx.tkos.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245005AbhK3RsG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Nov 2021 12:48:06 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id B1538440AE8;
        Tue, 30 Nov 2021 19:38:03 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1638293884;
        bh=Prh26ViZ09qZ5cNJmM2I+d7tFqKPScpNQEbA1T/nibE=;
        h=From:To:Cc:Subject:Date:From;
        b=HsoaDC/rgr1Or9wBys/xFsnA8bNTj0mCYPS1POAbunMex0TJ2EU03yP+Xzp+g4LUV
         d85xCvU7AXZn3RI/jxPg7KSRcEzIxilCgUbgK7msOERrtjUriHpDalalhfeOxdetY/
         xsdzZvfXi4NRmT2gwWHPFP3IEnFsUbNXQF6GcsAeW5weds19NucjGdV4Y1lmtfEDp4
         GJF9UwDHzztzY6GBJe9zFlqh3h+cic+GDFYjRpzt/JxOQqm2r1ByUGMwNClunjwHSN
         duKWxe+mpfXbRPf9w4qBKsgzJ9GGhqt9HFLI1KI/xKwPrpYOVBNecWFpM2rdVNrQe0
         vuoI54ja0WxhA==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 1/3] pwm: driver for qualcomm ipq6018 pwm block
Date:   Tue, 30 Nov 2021 19:37:28 +0200
Message-Id: <8137a76d66146dd5c1efa0c46c60de5766b7a349.1638293850.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.33.0
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
v9:

Address comment from Uwe Kleine-König:

  Use period_ns*rate in dividers calculation for better accuracy

  Round down pre_div and pwm_div

  Add a comment explaining why pwm_div can't underflow

  Add a comment explaining why pre_div > pwm_div end the search loop

  Drop 'CFG_' from register macros

  Rename to_ipq_pwm_chip() to ipq_pwm_from_chip()

  Change bare 'unsigned' to 'unsigned int'

  Clarify the comment on separate REG1 write for enable/disable

  Round up the period value in .get_state

  Use direct readl/writel so no need to check for regmap errors

v7:

  Change 'offset' to 'reg' for the tcsr offset (Rob)

  Drop clock name; there is only one clock (Bjorn)

  Simplify probe failure code path (Bjorn)

v6:

Address Uwe Kleine-König review comments:

  Drop IPQ_PWM_MAX_DEVICES

  Rely on assigned-clock-rates; drop IPQ_PWM_CLK_SRC_FREQ

  Simplify register offset calculation

  Calculate duty cycle more precisely

  Refuse to set inverted polarity

  Drop redundant IPQ_PWM_REG1_ENABLE bit clear

  Remove x1000 factor in pwm_div calculation, use rate directly, and round up

  Choose initial pre_div such that pwm_div < IPQ_PWM_MAX_DIV

  Ensure pre_div <= pwm_div

  Rename close_ to best_

  Explain in comment why effective_div doesn't overflow

  Limit pwm_div to IPQ_PWM_MAX_DIV - 1 to allow 100% duty cycle

  Disable clock only after pwmchip_remove()

  const pwm_ops

Other changes:

  Add missing linux/bitfield.h header include (kernel test robot)

  Adjust code for PWM device node under TCSR (Rob Herring)

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
 drivers/pwm/pwm-ipq.c | 274 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/pwm/pwm-ipq.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 21e3b05a5153..e39718137ecd 100644
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
index 000000000000..1b6983fabafe
--- /dev/null
+++ b/drivers/pwm/pwm-ipq.c
@@ -0,0 +1,274 @@
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
+#include <linux/of.h>
+#include <linux/math64.h>
+#include <linux/of_device.h>
+#include <linux/bitfield.h>
+
+/* The frequency range supported is 1 Hz to clock rate */
+#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
+
+/*
+ * The max value specified for each field is based on the number of bits
+ * in the pwm control register for that field
+ */
+#define IPQ_PWM_MAX_DIV		0xFFFF
+
+/*
+ * Two 32-bit registers for each PWM: REG0, and REG1.
+ * Base offset for PWM #i is at 8 * #i.
+ */
+#define IPQ_PWM_REG0			0 /*PWM_DIV PWM_HI*/
+#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
+#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
+
+#define IPQ_PWM_REG1			4 /*ENABLE UPDATE PWM_PRE_DIV*/
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
+	void __iomem *mem;
+};
+
+static struct ipq_pwm_chip *ipq_pwm_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ipq_pwm_chip, chip);
+}
+
+static unsigned int ipq_pwm_reg_read(struct pwm_device *pwm, unsigned int reg)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
+	unsigned int off = 8 * pwm->hwpwm + reg;
+
+	return readl(ipq_chip->mem + off);
+}
+
+static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned int reg,
+			      unsigned int val)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(pwm->chip);
+	unsigned int off = 8 * pwm->hwpwm + reg;
+
+	writel(val, ipq_chip->mem + off);
+}
+
+static void config_div_and_duty(struct pwm_device *pwm, unsigned int pre_div,
+			unsigned int pwm_div, unsigned long rate, u64 duty_ns,
+			bool enable)
+{
+	unsigned long hi_dur;
+	unsigned long val = 0;
+
+	/*
+	 * high duration = pwm duty * (pwm div + 1)
+	 * pwm duty = duty_ns / period_ns
+	 */
+	hi_dur = div64_u64(duty_ns * rate, (pre_div + 1) * NSEC_PER_SEC);
+
+	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
+		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
+	ipq_pwm_reg_write(pwm, IPQ_PWM_REG0, val);
+
+	val = FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
+	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
+
+	/* PWM enable toggle needs a separate write to REG1 */
+	val |= IPQ_PWM_REG1_UPDATE;
+	if (enable)
+		val |= IPQ_PWM_REG1_ENABLE;
+	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
+}
+
+static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
+	unsigned int pre_div, pwm_div, best_pre_div, best_pwm_div;
+	unsigned long rate = clk_get_rate(ipq_chip->clk);
+	u64 period_ns, duty_ns, period_rate;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (state->period < div64_u64(NSEC_PER_SEC, rate))
+		return -ERANGE;
+
+	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
+	duty_ns = min(state->duty_cycle, period_ns);
+
+	/*
+	 * period_ns is 1G or less. As long as rate is less than 16 GHz this
+	 * does not overflow.
+	 */
+	period_rate = period_ns * rate;
+	best_pre_div = IPQ_PWM_MAX_DIV;
+	best_pwm_div = IPQ_PWM_MAX_DIV;
+	/* Initial pre_div value such that pwm_div < IPQ_PWM_MAX_DIV */
+	pre_div = div64_u64(period_rate,
+			(u64)NSEC_PER_SEC * (IPQ_PWM_MAX_DIV + 1));
+
+	for (; pre_div <= IPQ_PWM_MAX_DIV; pre_div++) {
+		long long diff;
+		u64 min_diff = period_rate;
+
+		pwm_div = div64_u64(period_rate,
+				(u64)NSEC_PER_SEC * (pre_div + 1));
+		/* pwm_div is unsigned; the check below catches underflow */
+		pwm_div--;
+
+		/*
+		 * pre_div and pwm_div values swap produces the same
+		 * result. This loop goes over all pre_div <= pwm_div
+		 * combinations. The rest are equivalent.
+		 */
+		if (pre_div > pwm_div)
+			break;
+
+		/*
+		 * Make sure we can do 100% duty cycle where
+		 * hi_dur == pwm_div + 1
+		 */
+		if (pwm_div > IPQ_PWM_MAX_DIV - 1)
+			continue;
+
+		diff = ((uint64_t)NSEC_PER_SEC * (pre_div + 1) * (pwm_div + 1))
+			- period_rate;
+
+		if (diff < 0) /* period larger than requested */
+			continue;
+		if (diff == 0) { /* bingo */
+			best_pre_div = pre_div;
+			best_pwm_div = pwm_div;
+			break;
+		}
+		if (diff < min_diff) {
+			min_diff = diff;
+			best_pre_div = pre_div;
+			best_pwm_div = pwm_div;
+		}
+	}
+
+	/* config divider values for the closest possible frequency */
+	config_div_and_duty(pwm, best_pre_div, best_pwm_div,
+			    rate, duty_ns, state->enabled);
+
+	return 0;
+}
+
+static void ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
+	unsigned long rate = clk_get_rate(ipq_chip->clk);
+	unsigned int pre_div, pwm_div, hi_dur;
+	u64 effective_div, hi_div;
+	u32 reg0, reg1;
+
+	reg0 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG0);
+	reg1 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG1);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->enabled = reg1 & IPQ_PWM_REG1_ENABLE;
+
+	pwm_div = FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
+	hi_dur = FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
+	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
+
+	/* No overflow here, both pre_div and pwm_div <= 0xffff */
+	effective_div = (u64)(pre_div + 1) * (pwm_div + 1);
+	state->period = DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC, rate);
+
+	hi_div = hi_dur * (pre_div + 1);
+	state->duty_cycle = div64_u64(hi_div * NSEC_PER_SEC, rate);
+}
+
+static const struct pwm_ops ipq_pwm_ops = {
+	.apply = ipq_pwm_apply,
+	.get_state = ipq_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int ipq_pwm_probe(struct platform_device *pdev)
+{
+	struct ipq_pwm_chip *pwm;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pwm);
+
+	pwm->mem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pwm->mem))
+		return dev_err_probe(dev, PTR_ERR(pwm->mem),
+				"regs map failed");
+
+	pwm->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(dev, PTR_ERR(pwm->clk),
+				"failed to get clock");
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "clock enable failed");
+
+	pwm->chip.dev = dev;
+	pwm->chip.ops = &ipq_pwm_ops;
+	pwm->chip.npwm = 4;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "pwmchip_add() failed\n");
+		clk_disable_unprepare(pwm->clk);
+	}
+
+	return ret;
+}
+
+static int ipq_pwm_remove(struct platform_device *pdev)
+{
+	struct ipq_pwm_chip *pwm = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&pwm->chip);
+	clk_disable_unprepare(pwm->clk);
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
2.33.0

