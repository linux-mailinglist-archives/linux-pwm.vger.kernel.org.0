Return-Path: <linux-pwm+bounces-8094-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FPsDvUtg2kwjAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8094-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:31:01 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF01E5253
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F02343013680
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E323ECBC6;
	Wed,  4 Feb 2026 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSC3beWJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968336C0DF;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204642; cv=none; b=Wjyn2KG4Syj51HBqaGL7x4xfxfdkNp5pN3nKBXbeglhGSvS7wmJfrPUpPwcG1Ap1ZxT0+Yy8dxeTvp4TLGdEKBgO1ivFbqmCLGQjRCH2i4oDgprf5ZRbTNnbR92alp71Q+j1wmNOE2sMgYmPXsJy2ni+smS53IFTlRUbISd8atU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204642; c=relaxed/simple;
	bh=zkNZgqriee8oDE85/0hw9dbAFsHYZugU0z6sxnVbyhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OAXXvZhqvhPH5iWCiaD/7p3QN+u4D7DCmQ/wW9CKszBbPhnDjU8l+WvtF8Lp36vrG2xFhSh8H0f5cF18oU1BZhay7J3IxHEDVa+kJ2b/roBY8v5Tc/ASxm4Mjiu0/710s92vFKsdLMhSO0+ihJUAs/PQ++sFxY8toP5pDdN/1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSC3beWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91FFBC2BC9E;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770204642;
	bh=zkNZgqriee8oDE85/0hw9dbAFsHYZugU0z6sxnVbyhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oSC3beWJhVmjH6YN8s2XCLrYjYW+lkl3y/DQPZwCskUi+By6cQkzgmqy5YFKDuIuf
	 XIE6g8Yy2vSF/auvmffAlKDRB/ik3ZKhf8ra5HXGl+Z0pBgUlR0EyzH8jjKNK0uryY
	 t98k0mq4f/YJc5Jm542X1kMiEZWUGrbuNrzktd5FyHUYIER5YkPog1GzX1lcboOkyH
	 Iwmr4Waz7RgDc0X76WJ+zL919+ReDSglCI55GZfg1AryL5RcMjkZHE5MCtVOZHdBW3
	 n4x2/t/6aB2X1mxD+fb2fVwOUJ1jKorSk+8Zpflb0rgq8qABkjZvKms8pEqYzspNM5
	 0fYt7mQKuG0Gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8418CE9538C;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Wed, 04 Feb 2026 19:30:42 +0800
Subject: [PATCH v4 2/3] pwm: add Andes PWM driver support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-andes-pwm-v4-2-67016bb13555@andestech.com>
References: <20260204-andes-pwm-v4-0-67016bb13555@andestech.com>
In-Reply-To: <20260204-andes-pwm-v4-0-67016bb13555@andestech.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770204641; l=11929;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=GtWrGCOpQ0ivIMuJElmmZKWT7fHnuOYXiBw7/f54Xuo=;
 b=y42ZT1axy8q0U1GQXBPehnnEFbJleCnH5W3OZxuJtZq+mBvCPkEaASxJV97yqGmTnRDBjwRMf
 JcOSvhKu9u4AITfkk8sAEXxJzKyiA+hp/ScCWfy6Jta429O6NczRRiX
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8094-lists,linux-pwm=lfdr.de,ben717.andestech.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	HAS_REPLYTO(0.00)[ben717@andestech.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEF01E5253
X-Rspamd-Action: no action

From: Ben Zong-You Xie <ben717@andestech.com>

Add a driver for the PWM controller found in Andes AE350 platforms and
QiLai SoCs.

The Andes PWM controller features:
- 4 independent channels.
- Dual clock source support (APB clock and external clock) to provide
  a flexible range of frequencies.
- Support for normal and inversed polarity.

The driver implements the .apply() and .get_state() callbacks. Since the
clock source of each channel can be selected by programming the
register, clock selection logic is implemented to prioritize the
external clock to maximize the supported period range, falling back to
the APB clock for higher frequency requirements.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 drivers/pwm/Kconfig     |  10 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-andes.c | 306 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 317 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6f3147518376..b82f2c857ada 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -73,6 +73,16 @@ config PWM_AIROHA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-airoha.
 
+config PWM_ANDES
+	tristate "Andes PWM support"
+	depends on ARCH_ANDES || COMPILE_TEST
+	help
+	  Generic PWM framework driver for Andes platform, such as QiLai SoC
+	  and AE350 platform.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-andes.
+
 config PWM_APPLE
 	tristate "Apple SoC PWM support"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0dc0d2b69025..858f225289cc 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
 obj-$(CONFIG_PWM_AIROHA)	+= pwm-airoha.o
+obj-$(CONFIG_PWM_ANDES)		+= pwm-andes.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ARGON_FAN_HAT)	+= pwm-argon-fan-hat.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
diff --git a/drivers/pwm/pwm-andes.c b/drivers/pwm/pwm-andes.c
new file mode 100644
index 000000000000..835c8db55987
--- /dev/null
+++ b/drivers/pwm/pwm-andes.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Andes PWM, used in Andes AE350 platform and QiLai SoC
+ *
+ * Copyright (C) 2026 Andes Technology Corporation.
+ *
+ * Limitations:
+ * - When disabling a channel, the current period will not be completed, and the
+ *   output will be constant zero.
+ * - The current period will be completed first if reconfiguring.
+ * - Further, if the reconfiguration changes the clock source, the output will
+ *   not be the old one nor the new one. And the output will be the new one
+ *   until writing to the reload register.
+ * - The hardware can neither do a 0% nor a 100% relative duty cycle.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define ANDES_PWM_CH_ENABLE		0x1C
+#define ANDES_PWM_CH_ENABLE_PWM(ch)	BIT(3 + (4 * (ch)))
+
+#define ANDES_PWM_CH_CTRL(ch)		(0x20 + (0x10 * (ch)))
+#define ANDES_PWM_CH_CTRL_MODE_PWM	BIT(2)
+#define ANDES_PWM_CH_CTRL_CLK		BIT(3)
+#define ANDES_PWM_CH_CTRL_PARK		BIT(4)
+#define ANDES_PWM_CH_CTRL_MASK		GENMASK(4, 0)
+
+#define ANDES_PWM_CH_RELOAD(ch)		(0x24 + (0x10 * (ch)))
+#define ANDES_PWM_CH_RELOAD_HIGH	GENMASK(31, 16)
+#define ANDES_PWM_CH_RELOAD_LOW		GENMASK(15, 0)
+
+#define ANDES_PWM_CH_COUNTER(ch)	(0x28 + (0x10 * (ch)))
+
+#define ANDES_PWM_CH_MAX		4
+#define ANDES_PWM_CYCLE_MIN		1
+#define ANDES_PWM_CYCLE_MAX		0x10000
+
+struct andes_pwm {
+	struct regmap *regmap;
+	struct clk *pclk;
+	struct clk *extclk;
+	unsigned int pclk_rate;
+	unsigned int extclk_rate;
+};
+
+static const struct regmap_config andes_pwm_regmap_config = {
+	.name = "andes_pwm",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.pad_bits = 0,
+	.max_register = ANDES_PWM_CH_COUNTER(ANDES_PWM_CH_MAX - 1),
+	.cache_type = REGCACHE_NONE,
+};
+
+static inline struct andes_pwm *to_andes_pwm(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int andes_pwm_enable(struct pwm_chip *chip, unsigned int channel,
+			    bool enable)
+{
+	struct andes_pwm *ap = to_andes_pwm(chip);
+
+	return regmap_assign_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
+				  ANDES_PWM_CH_ENABLE_PWM(channel), enable);
+}
+
+static int andes_pwm_config(struct pwm_chip *chip, unsigned int channel,
+			    const struct pwm_state *state)
+{
+	struct andes_pwm *ap = to_andes_pwm(chip);
+	unsigned int clk_rate = ap->extclk_rate;
+	unsigned int try = 2;
+	u64 high_ns = state->duty_cycle;
+	u64 low_ns = state->period - high_ns;
+	unsigned int ctrl = ANDES_PWM_CH_CTRL_MODE_PWM;
+	u64 high_cycles;
+	u64 low_cycles;
+	u32 reload;
+
+	/*
+	 * Reload register for PWM mode:
+	 *
+	 *		31 : 16    15 : 0
+	 *		PWM16_Hi | PWM16_Lo
+	 *
+	 * The high duration is (PWM16_Hi + 1) cycles and the low duration is
+	 * (PWM16_Lo + 1) cycles. For a duty cycle of 10 cycles and a total
+	 * period of 30 cycles in normal polarity, PWM16_Hi is set to
+	 * 9 (10 - 1) and PWM16_Lo to 19 (30 - 10 - 1). Also, PWM16_Hi is set to
+	 * 19 and PWM16_Lo is set to 9 in inversed polarity.
+	 *
+	 * Because the register stores "cycles - 1", the valid range for
+	 * each phase is 1 to 65536 (0x10000) cycles. This implies the hardware
+	 * cannot achieve a true 0% or 100% duty cycle.
+	 *
+	 * The controller supports two clock sources: the APB clock and an
+	 * external clock. The driver first attempts to use the external clock
+	 * to widest possible range of supported periods. If the requests
+	 * exceeds the valid range of the register, it falls back to the APB
+	 * clock. The request is rejected if the timing cannot be met by either
+	 * source.
+	 */
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		swap(high_ns, low_ns);
+
+	while (try) {
+		high_cycles = mul_u64_u64_div_u64(clk_rate, high_ns,
+						  NSEC_PER_SEC);
+		low_cycles = mul_u64_u64_div_u64(clk_rate, low_ns,
+						 NSEC_PER_SEC);
+		if (high_cycles > ANDES_PWM_CYCLE_MAX)
+			high_cycles = ANDES_PWM_CYCLE_MAX;
+
+		if (low_cycles > ANDES_PWM_CYCLE_MAX)
+			low_cycles = ANDES_PWM_CYCLE_MAX;
+
+		if (high_cycles >= ANDES_PWM_CYCLE_MIN &&
+		    low_cycles >= ANDES_PWM_CYCLE_MIN)
+			break;
+
+		try--;
+		clk_rate = ap->pclk_rate;
+	}
+
+	/*
+	 * try == 0 : no clock is valid
+	 * try == 1 : use APB clock
+	 * try == 2 : use external clock
+	 */
+	if (!try)
+		return -EINVAL;
+
+	/*
+	 * If changing the clock source here, the output will not be the old one
+	 * nor the new one. And the output will be the new one until writing to
+	 * the reload register.
+	 */
+	ctrl |= (try == 1) ? ANDES_PWM_CH_CTRL_CLK : 0;
+	ctrl |= (state->polarity == PWM_POLARITY_INVERSED) ?
+		ANDES_PWM_CH_CTRL_PARK : 0;
+	regmap_update_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
+			   ANDES_PWM_CH_CTRL_MASK, ctrl);
+	reload = FIELD_PREP(ANDES_PWM_CH_RELOAD_HIGH, high_cycles - 1) |
+		 FIELD_PREP(ANDES_PWM_CH_RELOAD_LOW, low_cycles - 1);
+
+	return regmap_write(ap->regmap, ANDES_PWM_CH_RELOAD(channel), reload);
+}
+
+static int andes_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	unsigned int channel = pwm->hwpwm;
+	int ret;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			andes_pwm_enable(chip, channel, false);
+
+		return 0;
+	}
+
+	ret = andes_pwm_config(chip, channel, state);
+	if (ret)
+		return ret;
+
+	return andes_pwm_enable(chip, channel, true);
+}
+
+static int andes_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct andes_pwm *ap = to_andes_pwm(chip);
+	unsigned int channel = pwm->hwpwm;
+	unsigned int ctrl;
+	unsigned int clk_rate;
+	unsigned int reload;
+	u64 high_cycles;
+	u64 low_cycles;
+
+	regmap_read(ap->regmap, ANDES_PWM_CH_CTRL(channel), &ctrl);
+	clk_rate = FIELD_GET(ANDES_PWM_CH_CTRL_CLK, ctrl) ? ap->pclk_rate
+							  : ap->extclk_rate;
+	state->enabled = regmap_test_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
+					  ANDES_PWM_CH_ENABLE_PWM(channel));
+	state->polarity = regmap_test_bits(ap->regmap,
+					   ANDES_PWM_CH_CTRL(channel),
+					   ANDES_PWM_CH_CTRL_PARK);
+	regmap_read(ap->regmap, ANDES_PWM_CH_RELOAD(channel), &reload);
+	high_cycles = FIELD_GET(ANDES_PWM_CH_RELOAD_HIGH, reload) + 1;
+	low_cycles = FIELD_GET(ANDES_PWM_CH_RELOAD_LOW, reload) + 1;
+
+	/*
+	 * high_cycles and low_cycles are both 16 bits, and NSEC_PER_SEC is 30
+	 * bits. Thus, the multiplication is safe from overflow
+	 */
+	if (state->polarity == PWM_POLARITY_NORMAL) {
+		state->duty_cycle = DIV_ROUND_UP_ULL(high_cycles * NSEC_PER_SEC,
+						     clk_rate);
+		state->period = state->duty_cycle +
+				DIV_ROUND_UP_ULL(low_cycles * NSEC_PER_SEC,
+						 clk_rate);
+	} else {
+		state->duty_cycle = DIV_ROUND_UP_ULL(low_cycles * NSEC_PER_SEC,
+						     clk_rate);
+		state->period = state->duty_cycle +
+				DIV_ROUND_UP_ULL(high_cycles * NSEC_PER_SEC,
+						 clk_rate);
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops andes_pwm_ops = {
+	.apply = andes_pwm_apply,
+	.get_state = andes_pwm_get_state,
+};
+
+static int andes_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
+	struct andes_pwm *ap;
+	void __iomem *reg_base;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, ANDES_PWM_CH_MAX, sizeof(*ap));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	ap = to_andes_pwm(chip);
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg_base))
+		return dev_err_probe(dev, PTR_ERR(reg_base),
+				     "failed to map I/O space\n");
+
+	ap->pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(ap->pclk))
+		return dev_err_probe(dev, PTR_ERR(ap->pclk),
+				     "failed to get APB clock\n");
+
+	ap->extclk = devm_clk_get_optional_enabled(dev, "extclk");
+	if (IS_ERR(ap->extclk))
+		return dev_err_probe(dev, PTR_ERR(ap->extclk),
+				     "failed to get external clock\n");
+
+	/*
+	 * If the clock rate is greater than 10^9, there may be an overflow when
+	 * calculating the cycles in andes_pwm_config()
+	 */
+	ap->pclk_rate = clk_get_rate(ap->pclk);
+	if (ap->pclk_rate > NSEC_PER_SEC)
+		ap->pclk = NULL;
+
+	ap->extclk_rate = ap->extclk ? clk_get_rate(ap->extclk) : 0;
+	if (ap->extclk_rate > NSEC_PER_SEC)
+		ap->extclk = NULL;
+
+	if (!ap->pclk && !ap->extclk)
+		return dev_err_probe(dev, -EINVAL, "clocks are out of range\n");
+
+	ap->regmap = devm_regmap_init_mmio(dev, reg_base,
+					   &andes_pwm_regmap_config);
+	if (IS_ERR(ap->regmap)) {
+		return dev_err_probe(dev, PTR_ERR(ap->regmap),
+				     "failed to initialize regmap\n");
+	}
+
+	chip->ops = &andes_pwm_ops;
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add pwm chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id andes_pwm_of_match[] = {
+	{ .compatible = "andestech,ae350-pwm" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, andes_pwm_of_match);
+
+static struct platform_driver andes_pwm_driver = {
+	.driver = {
+		.name = "andes_pwm",
+		.of_match_table = andes_pwm_of_match,
+	},
+	.probe = andes_pwm_probe,
+};
+module_platform_driver(andes_pwm_driver);
+
+MODULE_AUTHOR("Ben Zong-You Xie <ben717@andestech.com>");
+MODULE_DESCRIPTION("Andes PWM driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1



