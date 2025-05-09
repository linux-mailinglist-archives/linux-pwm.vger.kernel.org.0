Return-Path: <linux-pwm+bounces-5874-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2EAB0F8F
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88251BA6AA9
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93E28DEF8;
	Fri,  9 May 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H2vOUS0u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB028D840;
	Fri,  9 May 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784101; cv=none; b=awdgjRCRsUbpSSehDb/nts5Hd9pi+PGm/RNp3rStwG4fJ/RTtDWgBR4cBSJFERdpjxj3O0Bs6q9FL9+9zsyQRByM8sDRhcirMzvwqjVLkFEcL0zGRwh4sxORkpHyeAKl2VAUTemPAG7P8ghC5V+d8tqs0Xqd1yzX8MdXtmN4FFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784101; c=relaxed/simple;
	bh=XRzZnkx/rCvLH5gjjBlFfgJ1Y4g/7gPdDVjJMpFxq84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2PN4/HSCUSgO5ucLvzpuaGDAeVlRFkze+p0nAIirAdzYEWZFOnaxQCale4rAbsJyD6ChTD9YzaypQ2LrS8HCgZByLFuta8Zdw1/6Ihx1kJVCRHMuOUM54Tbh6bwzNHREzR3Gn6PPMzDk9FGVxjyFUqt0hVVjCLm2NngZMXROcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H2vOUS0u; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19B7943AEF;
	Fri,  9 May 2025 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746784090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XO5jmDfTQYOtrhnjFDYRyo0QIM7Jb/EP6v2mQntXvlE=;
	b=H2vOUS0u6y8QzUUcxUh1MHsuIldx5h01+PChLWPErrZ/HImhI1ppOKKfV1Wek8TzyecGvD
	dgxKViNGdzIpnmUzHB3YA9O5nejy2fOErEYo8JeLjS50kX2Ku+RtqbOXM3Y93fmEviU3t2
	jtLM8YC4oPyAOex56G5AjkTq9j+6ZE5qCofeypmcVDAttEJ0t+sU2y/V7Uq1RWfWpQXoiV
	2guPj5cGtooBuzYH2PMyT4TN1BuC79vWkINsm5QXBkbnpR2lUwYk2PYF0eQkxW8RSjlzmI
	Ijh+pu4QhachqURAufiFp6Jzl6lVsZGVVBderIYCS+TpwflpyXqBq5Zo4v6gRQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Fri, 09 May 2025 11:45:44 +0200
Subject: [PATCH v8 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pwm_sophgo-v8-2-cfaebeb8ee17@bootlin.com>
References: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
In-Reply-To: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepvfhhohhmrghsuceuohhnnhgvfhhilhhlvgcuoehthhhomhgrshdrsghonhhnvghfihhllhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekfffhteefueeutdekieelueeuvdeuvdejgedtveefffdvvdffgfeufffguddvhfenucfkphepvdgrtddumegtsgdugeemkeeflegtmeejtgdttdemrgegugejmeefvgelvgemvgekfedtmegsfegvtgenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeekfeeltgemjegttddtmegrgegujeemfegvlegvmegvkeeftdemsgefvggtpdhhvghloheplgduledvrdduieekrddurddufegnpdhmrghilhhfrhhomhepthhhohhmrghsrdgsohhnnhgvfhhilhhlvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhnohgthhhirghmrgesghhmrghilhdrtghom
 hdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrsghonhhnvghfihhllhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehqihhujhhinhhgsggrohdrughlmhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: thomas.bonnefille@bootlin.com

From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>

Implement the PWM driver for CV1800.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 drivers/pwm/Kconfig      |  10 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-cv1800.c | 294 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4731d5b90d7edcc61138e4a5bf7e98906953ece4..d0a3d9c4f625820ac2e6cf81bae11527124c68a2 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -202,6 +202,16 @@ config PWM_CROS_EC
 	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
 	  Controller.
 
+config PWM_CV1800
+	tristate "Sophgo CV1800 PWM driver"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	help
+	  Generic PWM framework driver for the Sophgo CV1800 series
+	  SoCs.
+
+	  To compile this driver as a module, build the dependencies
+	  as modules, this will be called pwm-cv1800.
+
 config PWM_DWC_CORE
 	tristate
 	depends on HAS_IOMEM
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 539e0def3f82fcb866ab83a0346a15f7efdd7127..20c49abde6082dc9b0dc0fa3eb68a0b57bceeeb1 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
+obj-$(CONFIG_PWM_CV1800)	+= pwm-cv1800.o
 obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
diff --git a/drivers/pwm/pwm-cv1800.c b/drivers/pwm/pwm-cv1800.c
new file mode 100644
index 0000000000000000000000000000000000000000..d5ba6f6e7e167789d1b3785ae3d262d954e2295d
--- /dev/null
+++ b/drivers/pwm/pwm-cv1800.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sophgo CV1800 PWM driver
+ * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
+ *
+ * Limitations:
+ * - The hardware emits the inactive level when disabled.
+ * - This pwm device supports dynamic loading of PWM parameters. When PWMSTART
+ *   is written from 0 to 1, the register value (HLPERIODn, PERIODn) will be
+ *   temporarily stored inside the PWM. If you want to dynamically change the
+ *   waveform during PWM output, after writing the new value to HLPERIODn and
+ *   PERIODn, write 1 and then 0 to PWMUPDATE[n] to make the new value effective.
+ * - Supports output frequency ranging from input_clock_rate/(2^30-1) to input_clock_rate/2.
+ * - By setting HLPERIODn to 0, can produce 100% duty cycle.
+ * - This hardware could support inverted polarity. By default, the value of the
+ *   POLARITY register is 0x0. This means that HLPERIOD represents the number
+ *   of low level beats.
+ * - This hardware supports input mode and output mode, implemented through the
+ *   Output-Enable/OE register. However, this driver has not yet implemented
+ *   capture callback.
+ */
+
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+#define PWM_CV1800_POLARITY         0x40
+#define PWM_CV1800_START            0x44
+#define PWM_CV1800_DONE             0x48
+#define PWM_CV1800_UPDATE           0x4c
+#define PWM_CV1800_OE               0xd0
+
+#define PWM_CV1800_HLPERIOD(n)      (0x00 + ((n) * 0x08))
+#define PWM_CV1800_PERIOD(n)        (0x04 + ((n) * 0x08))
+
+#define PWM_CV1800_UPDATE_MASK(n)   BIT(n)
+#define PWM_CV1800_OE_MASK(n)       BIT(n)
+#define PWM_CV1800_START_MASK(n)    BIT(n)
+#define PWM_CV1800_POLARITY_MASK(n) BIT(n)
+
+#define PWM_CV1800_MAXPERIOD        0x3fffffff
+#define PWM_CV1800_MINPERIOD        2
+#define PWM_CV1800_CHANNELS         4
+#define PWM_CV1800_PERIOD_RESET     BIT(1)
+#define PWM_CV1800_HLPERIOD_RESET   BIT(0)
+#define PWM_CV1800_REG_ENABLE(n)    BIT(n)
+
+struct cv1800_pwm {
+	struct regmap *map;
+	struct clk *clk;
+	unsigned long clk_rate;
+};
+
+static inline struct cv1800_pwm *to_cv1800_pwm_dev(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static const struct regmap_config cv1800_pwm_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.cache_type = REGCACHE_RBTREE,
+	.reg_stride = 4,
+};
+
+static int cv1800_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+			     bool enable)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 pwm_enabled;
+
+	regmap_read(priv->map, PWM_CV1800_START, &pwm_enabled);
+	pwm_enabled &= PWM_CV1800_START_MASK(pwm->hwpwm);
+
+	/*
+	 * If the parameters are changed during runtime, Register needs
+	 * to be updated to take effect.
+	 */
+
+	if (!enable) {
+		if (pwm_enabled)
+			regmap_clear_bits(priv->map, PWM_CV1800_START, BIT(pwm->hwpwm));
+		return 0;
+	} else if (pwm_enabled) {
+		/*
+		 * Updating the PWM parameters dynamically requires to send a pulse on the
+		 * PWMUPDATE register's nth bit, the value is updated only once a zero has been
+		 * written back to this nth bit
+		 */
+		regmap_set_bits(priv->map, PWM_CV1800_UPDATE, BIT(pwm->hwpwm));
+		regmap_clear_bits(priv->map, PWM_CV1800_UPDATE, BIT(pwm->hwpwm));
+	} else {
+		regmap_set_bits(priv->map, PWM_CV1800_START, BIT(pwm->hwpwm));
+	}
+
+	/* check and set OE/Output-Enable mode */
+	regmap_set_bits(priv->map, PWM_CV1800_OE, BIT(pwm->hwpwm));
+
+	return 0;
+}
+
+static void cv1800_pwm_set_polarity(struct pwm_chip *chip,
+				    struct pwm_device *pwm,
+				    enum pwm_polarity polarity)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 config_polarity = 0;
+
+	if (pwm->state.enabled)
+		cv1800_pwm_enable(chip, pwm, false);
+
+	if (polarity == PWM_POLARITY_NORMAL)
+		config_polarity = PWM_CV1800_POLARITY_MASK(pwm->hwpwm);
+
+	regmap_update_bits(priv->map, PWM_CV1800_POLARITY,
+			   PWM_CV1800_POLARITY_MASK(pwm->hwpwm),
+			   config_polarity);
+}
+
+static int cv1800_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 period_ticks, hlperiod_ticks;
+	u64 ticks;
+
+	/*
+	 * This hardware use PERIOD and HLPERIOD registers to represent PWM waves.
+	 *
+	 * The meaning of PERIOD is how many clock cycles (from the clock source)
+	 * are used to represent PWM waves.
+	 * PERIOD = rate(MHz) / target(MHz)
+	 * PERIOD = period(ns) * rate(Hz) / NSEC_PER_SEC
+	 */
+	ticks = mul_u64_u64_div_u64(state->period, priv->clk_rate,
+				    NSEC_PER_SEC);
+	if (ticks < PWM_CV1800_MINPERIOD)
+		return -EINVAL;
+
+	if (ticks > PWM_CV1800_MAXPERIOD)
+		ticks = PWM_CV1800_MAXPERIOD;
+	period_ticks = (u32)ticks;
+
+	/*
+	 * The HLPERIOD register value represents the duration of the active portion
+	 * of the PWM signal, which matches the polarity of the duty cycle.
+	 * HLPERIOD = rate(MHz) / duty(MHz)
+	 * HLPERIOD = duty(ns) * rate(Hz) / NSEC_PER_SEC
+	 */
+	ticks = mul_u64_u64_div_u64(state->duty_cycle, priv->clk_rate,
+				    NSEC_PER_SEC);
+	if (ticks > period_ticks)
+		ticks = period_ticks;
+	hlperiod_ticks = (u32)ticks;
+
+	if (state->polarity != pwm->state.polarity)
+		cv1800_pwm_set_polarity(chip, pwm, state->polarity);
+
+	regmap_write(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), period_ticks);
+	regmap_write(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), hlperiod_ticks);
+
+	cv1800_pwm_enable(chip, pwm, state->enabled);
+
+	return 0;
+}
+
+static int cv1800_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
+	u32 period_val, hlperiod_val;
+	u64 period_ns = 0, duty_ns = 0;
+	u32 enable = 0, polarity = 0;
+
+	regmap_read(priv->map, PWM_CV1800_PERIOD(pwm->hwpwm), &period_val);
+	regmap_read(priv->map, PWM_CV1800_HLPERIOD(pwm->hwpwm), &hlperiod_val);
+
+	if (period_val != PWM_CV1800_PERIOD_RESET ||
+	    hlperiod_val != PWM_CV1800_HLPERIOD_RESET) {
+		period_ns = DIV_ROUND_UP_ULL(period_val * NSEC_PER_SEC,
+					     priv->clk_rate);
+		duty_ns = DIV_ROUND_UP_ULL(hlperiod_val * NSEC_PER_SEC,
+					   priv->clk_rate);
+
+		regmap_read(priv->map, PWM_CV1800_START, &enable);
+		enable &= PWM_CV1800_START_MASK(pwm->hwpwm);
+
+		regmap_read(priv->map, PWM_CV1800_POLARITY, &polarity);
+		polarity &= PWM_CV1800_POLARITY_MASK(pwm->hwpwm);
+	}
+
+	state->period = period_ns;
+	state->duty_cycle = duty_ns;
+	state->enabled = enable;
+
+	/*
+	 * To ensure that duty and hlperiod represent the same polarity
+	 * the following mapping needs to be completed.
+	 *
+	 * |----------|------------|------------|-----------|
+	 * |  Linux   |  register  |    duty    | register  |
+	 * | polarity |  polarity  |            | hlperiod  |
+	 * |----------|------------|------------|-----------|
+	 * |    1     |      0     | low level  | low level |
+	 * |----------|------------|------------|-----------|
+	 * |    0     |      1     | high level | high level|
+	 * |----------|------------|------------|-----------|
+	 */
+	state->polarity = polarity ? PWM_POLARITY_NORMAL :
+					   PWM_POLARITY_INVERSED;
+
+	return 0;
+}
+
+static const struct pwm_ops cv1800_pwm_ops = {
+	.apply = cv1800_pwm_apply,
+	.get_state = cv1800_pwm_get_state,
+};
+
+static int cv1800_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cv1800_pwm *priv;
+	struct pwm_chip *chip;
+	void __iomem *base;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*priv));
+	if (!chip)
+		return PTR_ERR(chip);
+	priv = to_cv1800_pwm_dev(chip);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->map = devm_regmap_init_mmio(&pdev->dev, base,
+					  &cv1800_pwm_regmap_config);
+	if (IS_ERR(priv->map))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->map),
+				     "Couldn't create PWM regmap\n");
+
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk),
+				     "clk not found\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to get exclusive rate\n");
+
+	priv->clk_rate = clk_get_rate(priv->clk);
+	if (!priv->clk_rate)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Invalid clock rate: %lu\n",
+				     priv->clk_rate);
+	else if (priv->clk_rate > NSEC_PER_SEC)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Clock rate too high: %lu\n",
+				     priv->clk_rate);
+	 ;
+
+	chip->ops = &cv1800_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id cv1800_pwm_dt_ids[] = {
+	{ .compatible = "sophgo,cv1800-pwm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cv1800_pwm_dt_ids);
+
+static struct platform_driver cv1800_pwm_driver = {
+	.probe = cv1800_pwm_probe,
+	.driver	= {
+		.name = "cv1800-pwm",
+		.of_match_table = cv1800_pwm_dt_ids,
+	},
+};
+module_platform_driver(cv1800_pwm_driver);
+
+MODULE_AUTHOR("Jingbao Qiu");
+MODULE_DESCRIPTION("Sophgo cv1800 PWM Driver");
+MODULE_LICENSE("GPL");

-- 
2.49.0


