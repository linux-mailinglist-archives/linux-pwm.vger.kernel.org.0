Return-Path: <linux-pwm+bounces-8500-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOILJnUX1GkLrAcAu9opvQ
	(envelope-from <linux-pwm+bounces-8500-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 22:28:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392CD3A732E
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 22:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C340E3003EDF
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 20:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA753019BA;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKYd77b2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE32ED843;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507137; cv=none; b=rSg1NjnmsruYmkX3R11W6k4Z8AtS38TZ+TqeYL720Tdv31TMvmKHDhnKxFF3tEIwgHWVheBySdmsHQ+TjnxpU5oSVZHZv22ih+8Aiy54O5TPR5z1YON6AsiVaBCkMkBlJ/jMUaSmVPHvRKFy9ayw1ZRvJkoI6VDG2UJjbwnNxG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507137; c=relaxed/simple;
	bh=//4hFRzRx51KF8dy4TmLZTzuscwSckXo5IqSX/SPqZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ArKzdfp/X7WMN4QtZSZyRhbAQp45YLQl6I5amOM+CrsyZ9gVl6Ig9XllK6FIsPUocURasHGcptv5FS/XwVHiC3l+roWqJXmNVv/U4DRwsgaL3Kc2MJhyHwPIV0yGbI1K/DDtF0ESVy/9H6z+VJfdpkob1whus00BilrEYX2k+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKYd77b2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EF39C19425;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775507137;
	bh=//4hFRzRx51KF8dy4TmLZTzuscwSckXo5IqSX/SPqZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dKYd77b2EVEbYFEoz8GlRUWt4QG2CKaZJdXDAMG7k2AgpxexfBmH0G8LoDmtRFgtY
	 oVgXAZu50MD7faY9SaQ12xL84uf9+kwbnCDQrkjdvTOkopuA5J25KzYmsaKizbqSfm
	 EEsih8WGBU/42qU+ti1nOOkawPiT7SbJD47IMI7a8YS10y+CBZUKQCqw7GOcEF3fW4
	 EaX/Fwko1zH0NhYrlUyJaJNw82U4O1cQfa6aXVlbYE658InbuDfjyY4I6HZek9oMxo
	 O5H++QXbopgbyTj8lEvNg+/vzQZRP8Q6jQVx7AfXjEWdzgNw9WdcbP3vtgeEmd18L1
	 dJ2shBfGt8snQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5343AFB5168;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 06 Apr 2026 22:24:39 +0200
Subject: [PATCH v21 2/6] pwm: driver for qualcomm ipq6018 pwm block
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-ipq-pwm-v21-2-6ed1e868e4c2@outlook.com>
References: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
In-Reply-To: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Baruch Siach <baruch.siach@siklu.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775507135; l=10191;
 i=george.moussalem@outlook.com; s=20260406; h=from:subject:message-id;
 bh=hCPxbSZuZ7s50wScexFoYf75FXO3O4WXi/g+V0VERTQ=;
 b=5g3ijef6uxDRL+31oDDnTpHKv8/sH7xFpw4FOJX8mXgdZCvjdLylG4wYYZQmPv04L5JCHRMUe
 vMVN6yfhxZ6BtrzjTUWbcFrNh+gAkfafTuwLYgBgS1WNbwObzcTF4Xd
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=uqspem3ahtBvPEBuxVbyyXT/0Vp3JNb/mo1EPbmBzWg=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20260406
 with auth_id=722
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8500-lists,linux-pwm=lfdr.de,george.moussalem.outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com,quicinc.com,siklu.com];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[george.moussalem@outlook.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siklu.com:email,quicinc.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,outlook.com:replyto,outlook.com:mid]
X-Rspamd-Queue-Id: 392CD3A732E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Devi Priya <quic_devipriy@quicinc.com>

Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
driver from downstream Codeaurora kernel tree. Removed support for older
(V1) variants because I have no access to that hardware.

Tested on IPQ5018 and IPQ6010 based hardware.

Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/pwm/Kconfig   |  12 +++
 drivers/pwm/Makefile  |   1 +
 drivers/pwm/pwm-ipq.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376..e8886a9b64d9 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -347,6 +347,18 @@ config PWM_INTEL_LGM
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
index 0dc0d2b69025..5630a521a7cf 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
 obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
+obj-$(CONFIG_PWM_IPQ)		+= pwm-ipq.o
 obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
new file mode 100644
index 000000000000..b79e5e457d1a
--- /dev/null
+++ b/drivers/pwm/pwm-ipq.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2016-2017, 2020 The Linux Foundation. All rights reserved.
+ *
+ * Hardware notes / Limitations:
+ * - The PWM controller has no publicly available datasheet.
+ * - Each of the four channels is programmed via two 32-bit registers
+ *   (REG0 and REG1 at 8-byte stride).
+ * - Period and duty-cycle reconfiguration is fully atomic: new divider,
+ *   pre-divider, and high-duration values are latched by setting the
+ *   UPDATE bit (bit 30 in REG1). The hardware applies the new settings
+ *   at the beginning of the next period without disabling the output,
+ *   so the currently running period is always completed.
+ * - On disable (clearing the ENABLE bit 31 in REG1), the hardware
+ *   finishes the current period before stopping the output. The pin
+ *   is then driven to the inactive (low) level.
+ * - Upon disabling, the hardware resets the pre-divider (PRE_DIV) and divider
+ *   fields (PWM_DIV) in REG0 and REG1 to 0x0000 and 0x0001 respectively.
+ * - Only normal polarity is supported.
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
+/* The frequency range supported is 1 Hz to 100 Mhz (clock rate) */
+#define IPQ_PWM_MAX_PERIOD_NS	((u64)NSEC_PER_SEC)
+#define IPQ_PWM_MIN_PERIOD_NS	10
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
+
+/*
+ * The max value specified for each field is based on the number of bits
+ * in the pwm control register for that field (16-bit)
+ */
+#define IPQ_PWM_MAX_DIV			FIELD_MAX(IPQ_PWM_REG0_PWM_DIV)
+
+/*
+ * Enable bit is set to enable output toggling in pwm device.
+ * Update bit is set to trigger the change and is unset automatically
+ * to reflect the changed divider and high duration values in register.
+ */
+#define IPQ_PWM_REG1_UPDATE		BIT(30)
+#define IPQ_PWM_REG1_ENABLE		BIT(31)
+
+struct ipq_pwm_chip {
+	void __iomem *mem;
+	unsigned long clk_rate;
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
+static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
+	unsigned int pre_div, pwm_div;
+	u64 period_ns, duty_ns;
+	unsigned long val = 0;
+	unsigned long hi_dur;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * Check the upper and lower bounds for the period as per
+	 * hardware limits
+	 */
+	period_ns = max(state->period, IPQ_PWM_MIN_PERIOD_NS);
+	period_ns = min(state->period, IPQ_PWM_MAX_PERIOD_NS);
+	duty_ns = min(state->duty_cycle, period_ns);
+
+	/*
+	 * Pick the maximal value for PWM_DIV that still allows a
+	 * 100% relative duty cycle. This allows a fine grained
+	 * selection of duty cycles.
+	 */
+	pwm_div = IPQ_PWM_MAX_DIV - 1;
+
+	/*
+	 * although mul_u64_u64_div_u64 returns a u64, in practice it
+	 * won't overflow due to above constraints. Take the max period
+	 * of 10^9 (NSEC_PER_SEC) and the pwm_div + 1 (IPQ_PWM_MAX_DIV)
+	 *  10^9 * 10^8
+	 * ------------- => which fits well into a 32-bit unsigned int.
+	 * 10^9 * 65,535
+	 */
+	pre_div = mul_u64_u64_div_u64(period_ns, ipq_chip->clk_rate,
+				      (u64)NSEC_PER_SEC * (pwm_div + 1));
+
+	if (!pre_div)
+		return -ERANGE;
+
+	pre_div -= 1;
+
+	if (pre_div > IPQ_PWM_MAX_DIV)
+		pre_div = IPQ_PWM_MAX_DIV;
+
+	/* pwm duty = HI_DUR * (PRE_DIV + 1) / clk_rate */
+	hi_dur = mul_u64_u64_div_u64(duty_ns, ipq_chip->clk_rate,
+				     (u64)(pre_div + 1) * NSEC_PER_SEC);
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
+	if (state->enabled)
+		val |= IPQ_PWM_REG1_ENABLE;
+	ipq_pwm_reg_write(pwm, IPQ_PWM_REG1, val);
+
+	return 0;
+}
+
+static int ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct ipq_pwm_chip *ipq_chip = ipq_pwm_from_chip(chip);
+	unsigned int pre_div, pwm_div, hi_dur;
+	u64 effective_div, hi_div;
+	u32 reg0, reg1;
+
+	reg1 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG1);
+	state->enabled = reg1 & IPQ_PWM_REG1_ENABLE;
+
+	if (!state->enabled)
+		return 0;
+
+	reg0 = ipq_pwm_reg_read(pwm, IPQ_PWM_REG0);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	pwm_div = FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
+	hi_dur = FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
+	pre_div = FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
+
+	effective_div = (u64)(pre_div + 1) * (pwm_div + 1);
+
+	/*
+	 * effective_div <= 0x100000000, so the multiplication doesn't overflow.
+	 */
+	state->period = DIV64_U64_ROUND_UP(effective_div * NSEC_PER_SEC,
+					   ipq_chip->clk_rate);
+
+	hi_div = hi_dur * (pre_div + 1);
+	state->duty_cycle = DIV64_U64_ROUND_UP(hi_div * NSEC_PER_SEC,
+					       ipq_chip->clk_rate);
+
+	/*
+	 * ensure a valid config is passed back to PWM core in case duty_cycle
+	 * is > period (>100%)
+	 */
+	state->duty_cycle = min(state->duty_cycle, state->period);
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
+	struct clk *clk;
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
+				     "Failed to acquire resource\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Failed to get clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to lock clock rate\n");
+
+	pwm->clk_rate = clk_get_rate(clk);
+	if (!pwm->clk_rate)
+		return dev_err_probe(dev, -EINVAL, "Failed due to clock rate being zero\n");
+
+	chip->ops = &ipq_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
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
+};
+
+module_platform_driver(ipq_pwm_driver);
+
+MODULE_LICENSE("GPL");

-- 
2.39.5



