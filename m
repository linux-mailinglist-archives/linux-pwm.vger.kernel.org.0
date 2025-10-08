Return-Path: <linux-pwm+bounces-7411-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0108CBC5CBB
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD70942587C
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D02F9C2D;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEDiKr/E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC752F6169;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937627; cv=none; b=nnB5JJOlXok5yEeptldylujxxxhGlYK2yT/06VTUBKBfSRrLIW3ild9XODv3rfrXBrvkZ//i85CMnE3dojF0K2Qd+I+k5wKRPou9Vqh0an8Y9ywIsZomxpnXwKlMRUCfefgZrIV5m74+j+Q1RmuBxF0u4PRFjI0QOV3f3g73t0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937627; c=relaxed/simple;
	bh=s2llcLUI1qnY0o3dLcMwEv1pSMRV1To4R+Ze+EHdylc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyO6Jx/KuVcuCgPXmQvEs+o0F9zzx02Fe6dEVzhEIpMKG3+AW62Of8STbDQqH7ZcUt7cWR3VietPqDF6PE0Gvk73vwbeu9grwsPXInsAwcL710pRLFimn1ZTFCnkoD9GYZh0T6s+O4St3xm5MbgOdKpy1VELKgjicsJfWK3xc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEDiKr/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C38E9C113D0;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759937626;
	bh=s2llcLUI1qnY0o3dLcMwEv1pSMRV1To4R+Ze+EHdylc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WEDiKr/EcO54pg6FgfYr/lkVuxIieI3snhcx7cpXkIr7FsEJ4Bi/fYP5g/l5ZmCTA
	 rkvOXSgyfSipFulXuofWGu6NO/1ahFk7lBFaofS/AYwNcddqqcIuNJFyzxO2ucPguS
	 0ZlFlGDDlla7rSHuQGMVRRkFNEw+oE2An4KsCLEbkTdYQ+awOjAwRVEAkgTyzzTHWL
	 2ESxIclT4TWzIWmsi5AsJCC9Z8C+GLi2JB1itbNH2Vdj7KKcPG7W8P6BhGpm+3Owws
	 qqZGoTC+GQpb4bh84CNyxc5PXQul+CnnN2BCcHsD/MgwuMrxUjZ59F15j4eGL/a5/K
	 C6F2CVtmw6lVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A61CCD183;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 08 Oct 2025 19:32:54 +0400
Subject: [PATCH v17 2/9] pwm: driver for qualcomm ipq6018 pwm block
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251008-ipq-pwm-v17-2-9bd43edfc7f7@outlook.com>
References: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
In-Reply-To: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Baruch Siach <baruch.siach@siklu.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759937622; l=9936;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=Roow9Rqqb2wHqPZaEC93x3A3cup5+su0zvJQmUIvI7I=;
 b=f1tUSjr77+qYPuQv0JFI+MT8m7W1O9RGHzuaRzkylVdkzMDDRUpW4PZvKDYLbiEh0BPMGWWZA
 JlRd5qLxr9PARbdBDZyBlb7ziD515YUdAZtdKwWwlS8iXKafQgb1swu
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Devi Priya <quic_devipriy@quicinc.com>

Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
driver from downstream Codeaurora kernel tree. Removed support for older
(V1) variants because I have no access to that hardware.

Tested on IPQ5018 and IPQ6010 based hardware.

Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
v17:

  Removed unnecessary code comments

v16:

  Simplified code to calculate divs and duty cycle as per Uwe's comments

  Removed unused pwm_chip struct from ipq_pwm_chip struct

  Removed unnecessary cast as per Uwe's comment

  Replaced devm_clk_get & clk_prepare_enable by devm_clk_get_enabled

  Replaced pwmchip_add by devm_pwmchip_add and removed .remove function

  Removed .owner from driver struct

v15:

  No change

v14:

  Picked up the R-b tag

v13:

  Updated the file name to match the compatible

  Sorted the properties and updated the order in the required field

  Dropped the syscon node from examples

v12:

  Picked up the R-b tag

v11:

  No change

v10:

  No change

v9:

  Add 'ranges' property to example (Rob)

  Drop label in example (Rob)

v8:

  Add size cell to 'reg' (Rob)

v7:

  Use 'reg' instead of 'offset' (Rob)

  Drop 'clock-names' and 'assigned-clock*' (Bjorn)

  Use single cell address/size in example node (Bjorn)

  Move '#pwm-cells' lower in example node (Bjorn)

  List 'reg' as required

v6:

  Device node is child of TCSR; remove phandle (Rob Herring)

  Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)

v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
    Andersson, Kathiravan T)

v4: Update the binding example node as well (Rob Herring's bot)

v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

v2: Make #pwm-cells const (Rob Herring)
---
 drivers/pwm/Kconfig   |  12 +++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-ipq.c | 212 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c2fd3f4b62d9ea422a51a73fa87dc7a73703ebaf..33ac49251b3cc957bc356aa39199b748577d295f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -337,6 +337,18 @@ config PWM_INTEL_LGM
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
index dfa8b4966ee19af18ea47080db4adf96c326f3d7..74e07f654d43dfee83e7bb3a49e41acf8ae011fc 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
 obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
+obj-$(CONFIG_PWM_IPQ)		+= pwm-ipq.o
 obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
new file mode 100644
index 0000000000000000000000000000000000000000..bd6b3ad86596e3c5b19f80f97fe7913a8ce2d940
--- /dev/null
+++ b/drivers/pwm/pwm-ipq.c
@@ -0,0 +1,212 @@
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
+#include <linux/units.h>
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
+#define IPQ_PWM_REG0			0
+#define IPQ_PWM_REG0_PWM_DIV		GENMASK(15, 0)
+#define IPQ_PWM_REG0_HI_DURATION	GENMASK(31, 16)
+
+#define IPQ_PWM_REG1			4
+#define IPQ_PWM_REG1_PRE_DIV		GENMASK(15, 0)
+/*
+ * Enable bit is set to enable output toggling in pwm device.
+ * Update bit is set to reflect the changed divider and high duration
+ * values in register.
+ */
+#define IPQ_PWM_REG1_UPDATE		BIT(30)
+#define IPQ_PWM_REG1_ENABLE		BIT(31)
+
+struct ipq_pwm_chip {
+	struct clk *clk;
+	void __iomem *mem;
+};
+
+static struct ipq_pwm_chip *ipq_pwm_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
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
+				unsigned int pwm_div, unsigned long rate, u64 duty_ns,
+				bool enable)
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
+	unsigned long rate = clk_get_rate(ipq_chip->clk);
+	unsigned int pre_div, pwm_div;
+	u64 period_ns, duty_ns;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (state->period < DIV64_U64_ROUND_UP(NSEC_PER_SEC, rate))
+		return -ERANGE;
+
+	if ((unsigned long long)rate > 16ULL * GIGA)
+		return -EINVAL;
+
+	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
+	duty_ns = min(state->duty_cycle, period_ns);
+
+	/* Restrict pwm_div to 0xfffe */
+	pwm_div = IPQ_PWM_MAX_DIV - 1;
+	pre_div = DIV64_U64_ROUND_UP(period_ns * rate, (u64)NSEC_PER_SEC * (pwm_div + 1));
+
+	if (pre_div > IPQ_PWM_MAX_DIV)
+		return -ERANGE;
+
+	config_div_and_duty(pwm, pre_div, pwm_div, rate, duty_ns, state->enabled);
+
+	return 0;
+}
+
+static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_state *state)
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
+	effective_div = (pre_div + 1) * (pwm_div + 1);
+	state->period = DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC, rate);
+
+	hi_div = hi_dur * (pre_div + 1);
+	state->duty_cycle = DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC, rate);
+
+	return 0;
+}
+
+static const struct pwm_ops ipq_pwm_ops = {
+	.apply = ipq_pwm_apply,
+	.get_state = ipq_pwm_get_state,
+};
+
+static int ipq_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ipq_pwm_chip *pwm;
+	struct pwm_chip *chip;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pwm = ipq_pwm_from_chip(chip);
+
+	pwm->mem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pwm->mem))
+		return dev_err_probe(dev, PTR_ERR(pwm->mem),
+				"regs map failed");
+
+	pwm->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(dev, PTR_ERR(pwm->clk),
+				"failed to get clock");
+
+	chip->ops = &ipq_pwm_ops;
+	chip->npwm = 4;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to add pwm chip\n");
+
+	return ret;
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
+};
+
+module_platform_driver(ipq_pwm_driver);
+
+MODULE_LICENSE("GPL");

-- 
2.51.0



