Return-Path: <linux-pwm+bounces-9349-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9e5kOqkyOmpy3wcAu9opvQ
	(envelope-from <linux-pwm+bounces-9349-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 09:15:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1422E6B4C38
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 09:15:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9349-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9349-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDD58300863A
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DFA30F526;
	Tue, 23 Jun 2026 07:15:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114225B0BD;
	Tue, 23 Jun 2026 07:15:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198931; cv=none; b=daMWTT2J7cGGkLqjKkk1S0lj7UQvsxmoTYcJVoeX4l74amBcbFpSyw6khE5bbD6BUMCotoLJ9xF65n0nzrkGKgBBgLaLVHSPCLMh2nFBFsnWbxo/RKEuagYYo6T8zMoGwx/ZKvwiPQyqVG4Zp7+91zaN8zj5bLjZyLMJHDRLYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198931; c=relaxed/simple;
	bh=G2q5aoQV6D5YHwmShuDNGpcyUJv5lDnehiqg4L/7RL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HJIvmGIjLaJUorvEjQnnOP70LTQrD0ozWCS9HcAZetA8961yBpCin4PpAVyORmvosEKIsM/0e7HvDtha8kMlyKs1zi6oU5vG02xCsrnLOzetRZxPJ8n+WpmiPLCTh01dy0sabEMoWz5hj4C2gjPMmk6JfwcMMMN9aWmG5qaLhls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgA32XKIMjpqG4ctAA--.22627S2;
	Tue, 23 Jun 2026 15:15:21 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ben-linux@fluff.org,
	ben.dooks@codethink.co.uk,
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
Subject: [PATCH v8 3/3] pwm: dwc: add of/platform support
Date: Tue, 23 Jun 2026 15:15:16 +0800
Message-Id: <20260623071516.2251-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20260623071329.2034-1-dongxuyang@eswincomputing.com>
References: <20260623071329.2034-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgA32XKIMjpqG4ctAA--.22627S2
X-Coremail-Antispam: 1UD129KBjvAXoW3ur1rKryfJrW8Zw1DGF43GFg_yoW8AF1xuo
	WSkr1fXw1rK3Z5J397Ca42kayjvw4kt34fur1rWF4DCFn8Zw45AayUK3yY934Iqw1YyFWx
	Ar4xXr1fAF4fJw18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQJ57UUUUU==
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ben-linux@fluff.org,m:ben.dooks@codethink.co.uk,m:p.zabel@pengutronix.de,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:xuxiang@eswincomputing.com,m:wangguosheng@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:dongxuyang@eswincomputing.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9349-lists,linux-pwm=lfdr.de];
	DMARC_NA(0.00)[eswincomputing.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:email,eswincomputing.com:mid,eswincomputing.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,codethink.co.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1422E6B4C38

From: Xuyang Dong <dongxuyang@eswincomputing.com>

The dwc pwm controller can be used in non-PCI systems, so allow
either platform or OF based probing.

The controller is reset only when no PWM channel is enabled.
Otherwise, clocks are enabled and the runtime PM state is updated
to reflect the active hardware configuration.

Co-developed-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Xiang Xu <xuxiang@eswincomputing.com>
Signed-off-by: Guosheng Wang <wangguosheng@eswincomputing.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 drivers/pwm/Kconfig        |  10 ++
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-dwc-core.c | 103 ++++++++---
 drivers/pwm/pwm-dwc-of.c   | 346 +++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-dwc.h      |  25 ++-
 5 files changed, 455 insertions(+), 30 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e8886a9b64d9..fd1d68beab67 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -249,6 +249,16 @@ config PWM_DWC
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc.
 
+config PWM_DWC_OF
+	tristate "DesignWare PWM Controller (OF bus)"
+	depends on HAS_IOMEM && (OF || COMPILE_TEST)
+	select PWM_DWC_CORE
+	help
+	  PWM driver for Synopsys DWC PWM Controller on an OF bus or
+	  a platform bus.
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-dwc-of.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5630a521a7cf..acd7dfe98dff 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
+obj-$(CONFIG_PWM_DWC_OF)	+= pwm-dwc-of.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_GPIO)		+= pwm-gpio.o
diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 6dabec93a3c6..b9a9d6ae0b45 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -12,8 +12,10 @@
 #define DEFAULT_SYMBOL_NAMESPACE "dwc_pwm"
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
@@ -44,21 +46,55 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
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
+	if (dwc->clk)
+		dwc->clk_rate = clk_get_rate(dwc->clk);
+
+	if (dwc->features & DWC_TIM_CTRL_0N100PWM_EN) {
+		/*
+		 * Calculate width of low and high period in terms of input
+		 * clock periods and check are the result within HW limits
+		 * between 0 and 2^32 periods.
+		 * Use mul_u64_u64_div_u64() to avoid overflowing the 64-bit
+		 * intermediate result and to round down to the nearest
+		 * achievable hardware value, as required by the PWM core.
+		 */
+		tmp = mul_u64_u64_div_u64(state->duty_cycle, dwc->clk_rate,
+					  NSEC_PER_SEC);
+		if (tmp >= (1ULL << 32))
+			return -ERANGE;
+
+		if (pwm->args.polarity == PWM_POLARITY_INVERSED)
+			high = tmp;
+		else
+			low = tmp;
+
+		tmp = mul_u64_u64_div_u64(state->period - state->duty_cycle,
+					  dwc->clk_rate, NSEC_PER_SEC);
+		if (tmp >= (1ULL << 32))
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
+		tmp = mul_u64_u64_div_u64(state->duty_cycle, dwc->clk_rate,
+					  NSEC_PER_SEC);
+		if (tmp < 1 || tmp > (1ULL << 32))
+			return -ERANGE;
+		low = tmp - 1;
+
+		tmp = mul_u64_u64_div_u64(state->period - state->duty_cycle,
+					  dwc->clk_rate, NSEC_PER_SEC);
+		if (tmp < 1 || tmp > (1ULL << 32))
+			return -ERANGE;
+		high = tmp - 1;
+	}
 
 	/*
 	 * Specification says timer usage flow is to disable timer, then
@@ -74,6 +110,7 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * width of low period and latter the width of high period in terms
 	 * multiple of input clock periods:
 	 * Width = ((Count + 1) * input clock period).
+	 * Width = (Count * input clock period) : supported 0% and 100%.
 	 */
 	dwc_pwm_writel(dwc, low, DWC_TIM_LD_CNT(pwm->hwpwm));
 	dwc_pwm_writel(dwc, high, DWC_TIM_LD_CNT2(pwm->hwpwm));
@@ -85,6 +122,9 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * periods are set by Load Count registers.
 	 */
 	ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
+	if (dwc->features & DWC_TIM_CTRL_0N100PWM_EN)
+		ctrl |= DWC_TIM_CTRL_0N100PWM_EN;
+
 	dwc_pwm_writel(dwc, ctrl, DWC_TIM_CTRL(pwm->hwpwm));
 
 	/*
@@ -121,10 +161,19 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			     struct pwm_state *state)
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	unsigned long clk_rate;
 	u64 duty, period;
 	u32 ctrl, ld, ld2;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
+	if (ret)
+		return ret;
 
-	pm_runtime_get_sync(pwmchip_parent(chip));
+	if (dwc->clk)
+		dwc->clk_rate = clk_get_rate(dwc->clk);
+
+	clk_rate = dwc->clk_rate;
 
 	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
 	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
@@ -137,17 +186,25 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * based on the timer load-count only.
 	 */
 	if (ctrl & DWC_TIM_CTRL_PWM) {
-		duty = (ld + 1) * dwc->clk_ns;
-		period = (ld2 + 1)  * dwc->clk_ns;
-		period += duty;
+		if (dwc->features & DWC_TIM_CTRL_0N100PWM_EN) {
+			if (pwm->args.polarity == PWM_POLARITY_INVERSED)
+				duty = ld2;
+			else
+				duty = ld;
+			period = (u64)ld + ld2;
+		} else {
+			duty = ld + 1;
+			period = ld2 + 1;
+			period += duty;
+		}
 	} else {
-		duty = (ld + 1) * dwc->clk_ns;
+		duty = ld + 1;
 		period = duty * 2;
 	}
 
 	state->polarity = PWM_POLARITY_INVERSED;
-	state->period = period;
-	state->duty_cycle = duty;
+	state->period = mul_u64_u64_div_u64(period, NSEC_PER_SEC, clk_rate);
+	state->duty_cycle = mul_u64_u64_div_u64(duty, NSEC_PER_SEC, clk_rate);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 
@@ -169,7 +226,7 @@ struct pwm_chip *dwc_pwm_alloc(struct device *dev)
 		return chip;
 	dwc = to_dwc_pwm(chip);
 
-	dwc->clk_ns = 10;
+	dwc->clk_rate = NSEC_PER_SEC / 10;
 	chip->ops = &dwc_pwm_ops;
 
 	return chip;
diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
new file mode 100644
index 000000000000..34713cb7299e
--- /dev/null
+++ b/drivers/pwm/pwm-dwc-of.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver OF
+ *
+ * Copyright (C) 2026 SiFive, Inc.
+ */
+
+#define DEFAULT_SYMBOL_NAMESPACE "dwc_pwm_of"
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+
+#include "pwm-dwc.h"
+
+struct dwc_pwm_plat_data {
+	bool reset_required;
+};
+
+static int dwc_pwm_plat_probe(struct platform_device *pdev)
+{
+	const struct dwc_pwm_plat_data *pdata;
+	struct device *dev = &pdev->dev;
+	struct dwc_pwm_drvdata *data;
+	u32 ctrl[DWC_TIMERS_TOTAL];
+	struct pwm_chip *chip;
+	struct dwc_pwm *dwc;
+	bool pwm_en = false;
+	u32 nr_pwm, tim_id;
+	unsigned int i;
+	int ret;
+
+	data = devm_kzalloc(dev, struct_size(data, chips, 1), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	chip = dwc_pwm_alloc(dev);
+	if (IS_ERR(chip))
+		return dev_err_probe(dev, PTR_ERR(chip),
+				     "failed to alloc pwm\n");
+
+	dwc = to_dwc_pwm(chip);
+
+	dwc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dwc->base))
+		return PTR_ERR(dwc->base);
+
+	if (!device_property_read_u32(dev, "snps,pwm-number", &nr_pwm)) {
+		if (nr_pwm > DWC_TIMERS_TOTAL)
+			dev_warn(dev, "too many PWMs (%d), capping at %d\n",
+				 nr_pwm, chip->npwm);
+		else
+			chip->npwm = nr_pwm;
+	}
+
+	dwc->bus_clk = devm_clk_get(dev, "bus");
+	if (IS_ERR(dwc->bus_clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+				     "failed to get bus clock\n");
+
+	dwc->clk = devm_clk_get(dev, "timer");
+	if (IS_ERR(dwc->clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->clk),
+				     "failed to get timer clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, dwc->clk);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get exclusive rate\n");
+
+	dwc->clk_rate = clk_get_rate(dwc->clk);
+
+	pdata = device_get_match_data(dev);
+	if (pdata && pdata->reset_required)
+		dwc->rst = devm_reset_control_get_exclusive(dev, NULL);
+	else
+		dwc->rst = devm_reset_control_array_get_optional_exclusive(dev);
+
+	if (IS_ERR(dwc->rst))
+		return dev_err_probe(dev, PTR_ERR(dwc->rst),
+				     "failed to get reset control\n");
+
+	ret = clk_prepare_enable(dwc->bus_clk);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable bus clock\n");
+
+	ret = clk_prepare_enable(dwc->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable timer clock\n");
+		goto disable_busclk;
+	}
+
+	/*
+	 * Check all channels to see if any channel is enabled.
+	 * Read the control register of each channel and extract the enable bit
+	 */
+	for (i = 0; i < chip->npwm; i++) {
+		ctrl[i] = dwc_pwm_readl(dwc, DWC_TIM_CTRL(i)) & DWC_TIM_CTRL_EN;
+		if (ctrl[i])
+			pwm_en = true;
+	}
+
+	/*
+	 * Only issue a reset pulse when all channels are disabled, so a PWM
+	 * channel already running (e.g. configured by firmware before Linux
+	 * took over) is left undisturbed.
+	 */
+	if (!pwm_en) {
+		ret = reset_control_reset(dwc->rst);
+		if (ret) {
+			dev_err(dev, "failed to reset\n");
+			goto disable_clk;
+		}
+	}
+
+	/* init PWM feature */
+	dwc->features = 0;
+	/*
+	 * Support for 0% and 100% duty cycle mode was added in version 2.11a
+	 * and later.
+	 */
+	tim_id = dwc_pwm_readl(dwc, DWC_TIMERS_COMP_VERSION);
+	if (tim_id >= DWC_TIM_VERSION_ID_2_11A)
+		dwc->features |= DWC_TIM_CTRL_0N100PWM_EN;
+
+	data->chips[0] = chip;
+	dev_set_drvdata(dev, data);
+
+	/*
+	 * If any PWM channel is enabled, mark device active and hold runtime PM
+	 * references for each enabled channel. Otherwise, gate the clocks.
+	 */
+	if (pwm_en) {
+		pm_runtime_set_active(dev);
+		for (i = 0; i < chip->npwm; i++) {
+			if (ctrl[i])
+				pm_runtime_get_noresume(dev);
+		}
+	} else {
+		clk_disable_unprepare(dwc->clk);
+		clk_disable_unprepare(dwc->bus_clk);
+	}
+
+	pm_runtime_enable(dev);
+
+	ret = pwmchip_add(chip);
+	if (ret) {
+		dev_err(dev, "failed to add pwm chip\n");
+		goto pm_disable;
+	}
+
+	return 0;
+
+pm_disable:
+	pm_runtime_disable(dev);
+	if (pwm_en) {
+		for (i = 0; i < chip->npwm; i++) {
+			if (ctrl[i])
+				pm_runtime_put_noidle(dev);
+		}
+	}
+disable_clk:
+	clk_disable_unprepare(dwc->clk);
+disable_busclk:
+	clk_disable_unprepare(dwc->bus_clk);
+
+	return ret;
+}
+
+static void dwc_pwm_plat_remove(struct platform_device *pdev)
+{
+	struct dwc_pwm_drvdata *data = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = data->chips[0];
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	unsigned int idx;
+	int ret;
+
+	pm_runtime_get_sync(&pdev->dev);
+	pwmchip_remove(chip);
+
+	for (idx = 0; idx < chip->npwm; idx++) {
+		if (dwc_pwm_readl(dwc, DWC_TIM_CTRL(idx)) & DWC_TIM_CTRL_EN)
+			pm_runtime_put_noidle(&pdev->dev);
+	}
+	pm_runtime_put_sync(&pdev->dev);
+
+	if (!pm_runtime_status_suspended(&pdev->dev)) {
+		clk_disable_unprepare(dwc->clk);
+		clk_disable_unprepare(dwc->bus_clk);
+	}
+	pm_runtime_disable(&pdev->dev);
+
+	if (dwc->rst) {
+		ret = reset_control_assert(dwc->rst);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to assert reset: %d\n",
+				 ret);
+	}
+}
+
+static int dwc_pwm_runtime_suspend(struct device *dev)
+{
+	struct dwc_pwm_drvdata *data = dev_get_drvdata(dev);
+	struct pwm_chip *chip = data->chips[0];
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+
+	clk_disable_unprepare(dwc->clk);
+	clk_disable_unprepare(dwc->bus_clk);
+
+	return 0;
+}
+
+static int dwc_pwm_runtime_resume(struct device *dev)
+{
+	struct dwc_pwm_drvdata *data = dev_get_drvdata(dev);
+	struct pwm_chip *chip = data->chips[0];
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	int ret;
+
+	ret = clk_prepare_enable(dwc->bus_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable bus clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(dwc->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable timer clock: %d\n", ret);
+		clk_disable_unprepare(dwc->bus_clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dwc_pwm_suspend(struct device *dev)
+{
+	struct dwc_pwm_drvdata *data = dev_get_drvdata(dev);
+	struct pwm_chip *chip = data->chips[0];
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	unsigned int idx;
+	int ret;
+
+	if (pm_runtime_status_suspended(dev)) {
+		ret = dwc_pwm_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	for (idx = 0; idx < chip->npwm; idx++) {
+		if (chip->pwms[idx].state.enabled)
+			return -EBUSY;
+
+		dwc->ctx[idx].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(idx));
+		dwc->ctx[idx].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(idx));
+		dwc->ctx[idx].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(idx));
+	}
+
+	ret = dwc_pwm_runtime_suspend(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int dwc_pwm_resume(struct device *dev)
+{
+	struct dwc_pwm_drvdata *data = dev_get_drvdata(dev);
+	struct pwm_chip *chip = data->chips[0];
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	unsigned int idx;
+	bool pm_flags;
+	int ret;
+
+	/* Check if device was runtime suspended before system resume */
+	pm_flags = pm_runtime_status_suspended(dev);
+	if (pm_flags) {
+		/*
+		 * Use PM framework to resume device
+		 * (calls dwc_pwm_runtime_resume)
+		 */
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0)
+			return ret;
+	} else {
+		/*
+		 * Device was active, but clocks might be off after system sleep
+		 * Call runtime_resume directly to restore hardware state
+		 */
+		ret = dwc_pwm_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	for (idx = 0; idx < chip->npwm; idx++) {
+		dwc_pwm_writel(dwc, dwc->ctx[idx].cnt, DWC_TIM_LD_CNT(idx));
+		dwc_pwm_writel(dwc, dwc->ctx[idx].cnt2, DWC_TIM_LD_CNT2(idx));
+		dwc_pwm_writel(dwc, dwc->ctx[idx].ctrl, DWC_TIM_CTRL(idx));
+	}
+
+	if (pm_flags) {
+		/*
+		 * Balance the refcount taken by pm_runtime_get_sync
+		 * if it was used
+		 */
+		pm_runtime_put_sync(dev);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops dwc_pwm_pm_ops = {
+	RUNTIME_PM_OPS(dwc_pwm_runtime_suspend, dwc_pwm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(dwc_pwm_suspend, dwc_pwm_resume)
+};
+
+static const struct dwc_pwm_plat_data pwm_eic7700_pdata = {
+	.reset_required = true,
+};
+
+static const struct of_device_id dwc_pwm_dt_ids[] = {
+	{ .compatible = "snps,dw-apb-timers-pwm2" },
+	{ .compatible = "eswin,eic7700-pwm", .data = &pwm_eic7700_pdata },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
+
+static struct platform_driver dwc_pwm_plat_driver = {
+	.driver = {
+		.name = "dwc-pwm",
+		.pm = pm_ptr(&dwc_pwm_pm_ops),
+		.of_match_table = dwc_pwm_dt_ids,
+	},
+	.probe = dwc_pwm_plat_probe,
+	.remove = dwc_pwm_plat_remove,
+};
+
+module_platform_driver(dwc_pwm_plat_driver);
+
+MODULE_ALIAS("platform:dwc-pwm-of");
+MODULE_AUTHOR("Ben Dooks <ben.dooks@codethink.co.uk>");
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 1562594e7f85..75f7c2d031c4 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -26,12 +26,19 @@ MODULE_IMPORT_NS("dwc_pwm");
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
+
+/*
+ * The version 2.11a and later add "Pulse Width Modulation with
+ * 0% and 100% Duty Cycle".
+ */
+#define DWC_TIM_VERSION_ID_2_11A	0x3231312a
 
 struct dwc_pwm_info {
 	unsigned int nr;
@@ -52,8 +59,12 @@ struct dwc_pwm_ctx {
 
 struct dwc_pwm {
 	void __iomem *base;
-	unsigned int clk_ns;
+	struct clk *bus_clk;
+	struct clk *clk;
+	unsigned long clk_rate;
+	struct reset_control *rst;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
+	u32 features;
 };
 
 static inline struct dwc_pwm *to_dwc_pwm(struct pwm_chip *chip)
-- 
2.34.1


