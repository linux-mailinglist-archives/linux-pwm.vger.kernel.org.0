Return-Path: <linux-pwm+bounces-9377-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dcCYCtIEPWppvwgAu9opvQ
	(envelope-from <linux-pwm+bounces-9377-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:37:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4FA6C4B38
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:37:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=GqqgRWca;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9377-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9377-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FDC730393BF
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E210C3D3480;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEAD373BE7;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383761; cv=none; b=N8koAOG9bknzuImwRaLrfixeThlIwmLmZyOvuhQnwRikASyP5BoBAFlPzWoObhhwjSgYHBmivoeLLkcVHr/R01aufhgWvPskrPL7P/Bg1qlTLpKBkmQehSuLuO1HALaki2IM6+zHigiS2xrBCVxRw3zMLCJ1LxJEcbubvFSS8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383761; c=relaxed/simple;
	bh=V/xpxofHZMmMUQDTiMKgFy9hguNnHuliNlESozlfCmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qayRCzn87fGYFxjwLPnv73iB5cuEYWZDsJ5imsczTmruZUoHhT4jocXPa/TRFVKRf070/k4Ogbf3Dk07+Nls7jpvDoDt2t+feR27dVcQpkZHcvZfw1GKT+8oZwAGrH7m13EHLABe/bOCP/O6Tdd4uPCklh/uWHettXdmxyRishQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqqgRWca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87FB5C2BCF5;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782383761;
	bh=V/xpxofHZMmMUQDTiMKgFy9hguNnHuliNlESozlfCmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GqqgRWcadcO1cH+eYzWNIRS0NgCoHTy7qfaLx0gbI+jB4zDMqwAYLXk83OJrMN3ME
	 CwwQZFXlEzIU+3NilraXaJvRuXDpCnk4qSIzSF66MdUL9kUda8kjeWBQYGYBVysAF/
	 7d7gUqWKO2bmxvxXap6j80pPW+fwB3HkEPViZgV6khuNWUecLEkw75r0EFSjjHhGwm
	 3l0p4R9dvJ1qAd6LcNfB+aB3mYL7szKvfq2u2zIKGG14ZT8nIEIMIxmWpLt4Q0257U
	 Gok4FL/DaovCM4I+3XTA/O5yCia2FLh/oocizwKhYGJu4aICYsY4p8J/SH5IBD2wIu
	 ws80FzcTopFzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9A0CDE008;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Date: Thu, 25 Jun 2026 18:36:00 +0800
Subject: [PATCH v6 2/3] pwm: add Andes PWM driver support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-andes-pwm-v6-2-3aef11711017@andestech.com>
References: <20260625-andes-pwm-v6-0-3aef11711017@andestech.com>
In-Reply-To: <20260625-andes-pwm-v6-0-3aef11711017@andestech.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782383760; l=13980;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=AeNAEuqKCu4wIQadkRX6O5xxlYmreFQAyeoXC5E/v0s=;
 b=kjoDeoZ5u/vsxKTE97hCJloymKEVWRcwJEyk1Z4fIaxlm6ia+NNfc6E9OlQ0o0WWUCodwjzyl
 sy3l4L0Jw6vA1DT7l9JbRCFk7haVa/Vay2EnW1joVqHEc4bvimoBzVh
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9377-lists,linux-pwm=lfdr.de,ben717.andestech.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ben717@andestech.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[ben717@andestech.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,andestech.com:replyto,andestech.com:email,andestech.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D4FA6C4B38

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
 drivers/pwm/pwm-andes.c | 343 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 354 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e8886a9b64d9..52dee4b7f081 100644
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
index 5630a521a7cf..c92369ee251d 100644
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
index 000000000000..580e673d2cff
--- /dev/null
+++ b/drivers/pwm/pwm-andes.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Andes PWM, used in Andes AE350 platform and QiLai SoC
+ *
+ * Copyright (C) 2026 Andes Technology Corporation.
+ *
+ * Limitations:
+ * - When disabling a channel, the current period is not completed and the
+ *   output is driven to the PARK level (low when ANDES_PWM_CH_CTRL_PARK is
+ *   clear, high when it is set).
+ * - The current period will be completed first if reconfiguring.
+ * - Further, if the reconfiguration changes the clock source, the output will
+ *   not be the old one nor the new one. And the output will be the new one
+ *   after writing to the reload register.
+ * - The hardware cannot run a 0% or 100% relative duty cycle; the driver
+ *   emulates these by disabling the channel and parking the output at the
+ *   constant level.
+ * - A period or duty cycle larger than the selected clock can represent is
+ *   rounded down to the largest achievable value rather than rejected.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
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
+static inline struct andes_pwm *andes_pwm_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int andes_pwm_enable(struct pwm_chip *chip, unsigned int channel,
+			    bool enable)
+{
+	struct andes_pwm *ap = andes_pwm_from_chip(chip);
+
+	return regmap_assign_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
+				  ANDES_PWM_CH_ENABLE_PWM(channel), enable);
+}
+
+/*
+ * Hold the output at a constant level by parking the disabled channel. A
+ * disabled channel drives its output to the PARK level (low when @high is
+ * false, high when @high is true), which is used to emulate a 0% or 100%
+ * relative duty cycle.
+ */
+static int andes_pwm_park(struct pwm_chip *chip, unsigned int channel,
+			  bool high)
+{
+	struct andes_pwm *ap = andes_pwm_from_chip(chip);
+
+	regmap_assign_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
+			   ANDES_PWM_CH_CTRL_PARK, high);
+
+	return andes_pwm_enable(chip, channel, false);
+}
+
+static int andes_pwm_config(struct pwm_chip *chip, unsigned int channel,
+			    const struct pwm_state *state)
+{
+	struct andes_pwm *ap = andes_pwm_from_chip(chip);
+	unsigned int clk_rate = ap->extclk_rate;
+	unsigned int ctrl = ANDES_PWM_CH_CTRL_MODE_PWM;
+	bool use_pclk = false;
+	u64 high_cycles;
+	u64 low_cycles;
+	u64 period_cycles;
+	u64 duty_cycles;
+	u32 reload;
+
+	/*
+	 * Reload register for PWM mode:
+	 *
+	 *		31 : 16    15 : 0
+	 *		PWM16_Hi | PWM16_Lo
+	 *
+	 * The high duration is (PWM16_Hi + 1) cycles and the low duration is
+	 * (PWM16_Lo + 1) cycles, so each phase spans ANDES_PWM_CYCLE_MIN to
+	 * ANDES_PWM_CYCLE_MAX cycles. The hardware period (their sum) can reach
+	 * 2 * ANDES_PWM_CYCLE_MAX cycles, but the PWM core requires the period
+	 * to be chosen from the requested period alone, independent of the duty
+	 * cycle. That holds only while both phases stay within
+	 * ANDES_PWM_CYCLE_MAX for every duty split, so the usable period is
+	 * capped at ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN cycles.
+	 *
+	 * The controller has two clock sources, the APB clock and an external
+	 * clock. Since the external clock frequency must be slower than the APB
+	 * clock, it is tried first for its wider period range; the APB clock is
+	 * used only when the external clock is too fast to represent the period
+	 * (it resolves fewer than two cycles) or is absent.
+	 */
+	period_cycles = mul_u64_u64_div_u64(clk_rate, state->period,
+					    NSEC_PER_SEC);
+	if (period_cycles < 2 * ANDES_PWM_CYCLE_MIN) {
+		use_pclk = true;
+		clk_rate = ap->pclk_rate;
+		period_cycles = mul_u64_u64_div_u64(clk_rate, state->period,
+						    NSEC_PER_SEC);
+		if (period_cycles < 2 * ANDES_PWM_CYCLE_MIN)
+			return -EINVAL;
+	}
+
+	/*
+	 * Round the period down to the largest value representable for every
+	 * duty cycle, so the chosen period depends on the requested period
+	 * alone. With both phases capped at ANDES_PWM_CYCLE_MAX, that bound is
+	 * ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN cycles.
+	 */
+	period_cycles = min_t(u64, period_cycles,
+			      ANDES_PWM_CYCLE_MAX + ANDES_PWM_CYCLE_MIN);
+
+	/* The duty cycle cannot exceed the (possibly clamped) period. */
+	duty_cycles = mul_u64_u64_div_u64(clk_rate, state->duty_cycle,
+					  NSEC_PER_SEC);
+	duty_cycles = min_t(u64, duty_cycles, period_cycles);
+	if (state->polarity == PWM_POLARITY_INVERSED) {
+		low_cycles = duty_cycles;
+		high_cycles = period_cycles - low_cycles;
+	} else {
+		high_cycles = duty_cycles;
+		low_cycles = period_cycles - high_cycles;
+	}
+
+	/*
+	 * A zero-length phase means a 0% or 100% relative duty cycle, which the
+	 * hardware cannot run. Emit the matching constant level by parking the
+	 * channel: high_cycles == 0 stays low, low_cycles == 0 stays high.
+	 */
+	if (!high_cycles)
+		return andes_pwm_park(chip, channel, false);
+	if (!low_cycles)
+		return andes_pwm_park(chip, channel, true);
+
+	/*
+	 * If changing the clock source here, the output will not be the old one
+	 * nor the new one. And the output will be the new one after writing to
+	 * the reload register.
+	 */
+	ctrl |= use_pclk ? ANDES_PWM_CH_CTRL_CLK : 0;
+	ctrl |= (state->polarity == PWM_POLARITY_INVERSED) ?
+		ANDES_PWM_CH_CTRL_PARK : 0;
+	regmap_update_bits(ap->regmap, ANDES_PWM_CH_CTRL(channel),
+			   ANDES_PWM_CH_CTRL_MASK, ctrl);
+	reload = FIELD_PREP(ANDES_PWM_CH_RELOAD_HIGH, high_cycles - 1) |
+		 FIELD_PREP(ANDES_PWM_CH_RELOAD_LOW, low_cycles - 1);
+	regmap_write(ap->regmap, ANDES_PWM_CH_RELOAD(channel), reload);
+	return andes_pwm_enable(chip, channel, true);
+}
+
+static int andes_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	unsigned int channel = pwm->hwpwm;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			andes_pwm_enable(chip, channel, false);
+
+		return 0;
+	}
+
+	return andes_pwm_config(chip, channel, state);
+}
+
+static int andes_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct andes_pwm *ap = andes_pwm_from_chip(chip);
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
+	if (!clk_rate) {
+		/*
+		 * The selected clock source is unavailable, so the channel
+		 * cannot be running; report it as disabled and avoid the
+		 * division by zero below.
+		 */
+		state->enabled = false;
+		state->period = 0;
+		state->duty_cycle = 0;
+		return 0;
+	}
+
+	state->enabled = regmap_test_bits(ap->regmap, ANDES_PWM_CH_ENABLE,
+					  ANDES_PWM_CH_ENABLE_PWM(channel)) > 0;
+	state->polarity = FIELD_GET(ANDES_PWM_CH_CTRL_PARK, ctrl) ?
+			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+	regmap_read(ap->regmap, ANDES_PWM_CH_RELOAD(channel), &reload);
+	high_cycles = FIELD_GET(ANDES_PWM_CH_RELOAD_HIGH, reload) + 1;
+	low_cycles = FIELD_GET(ANDES_PWM_CH_RELOAD_LOW, reload) + 1;
+
+	/*
+	 * high_cycles and low_cycles are each at most ANDES_PWM_CYCLE_MAX
+	 * (0x10000, 17 bits) and NSEC_PER_SEC is below 2^30, so the products
+	 * below are safe from 64-bit overflow.
+	 */
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		state->duty_cycle = DIV_ROUND_UP_ULL(low_cycles * NSEC_PER_SEC,
+						     clk_rate);
+	else
+		state->duty_cycle = DIV_ROUND_UP_ULL(high_cycles * NSEC_PER_SEC,
+						     clk_rate);
+
+	state->period = DIV_ROUND_UP_ULL((high_cycles + low_cycles) *
+					 NSEC_PER_SEC, clk_rate);
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
+	unsigned long pclk_rate;
+	unsigned long extclk_rate;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, ANDES_PWM_CH_MAX, sizeof(*ap));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	ap = andes_pwm_from_chip(chip);
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg_base))
+		return dev_err_probe(dev, PTR_ERR(reg_base),
+				     "Failed to map I/O space\n");
+
+	ap->pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(ap->pclk))
+		return dev_err_probe(dev, PTR_ERR(ap->pclk),
+				     "Failed to get APB clock\n");
+
+	ap->extclk = devm_clk_get_optional_enabled(dev, "extclk");
+	if (IS_ERR(ap->extclk))
+		return dev_err_probe(dev, PTR_ERR(ap->extclk),
+				     "Failed to get external clock\n");
+
+	/*
+	 * If the clock rate is greater than 10^9, there may be an overflow when
+	 * calculating the cycles in andes_pwm_config()
+	 */
+	pclk_rate = clk_get_rate(ap->pclk);
+	extclk_rate = clk_get_rate(ap->extclk);
+
+	ap->pclk_rate = pclk_rate > NSEC_PER_SEC ? 0 : pclk_rate;
+	ap->extclk_rate = extclk_rate > NSEC_PER_SEC ? 0 : extclk_rate;
+
+	if (!ap->pclk_rate && !ap->extclk_rate)
+		return dev_err_probe(dev, -EINVAL,
+				     "No usable clock: pclk %lu Hz, extclk %lu Hz\n",
+				     pclk_rate, extclk_rate);
+
+	ap->regmap = devm_regmap_init_mmio(dev, reg_base,
+					   &andes_pwm_regmap_config);
+	if (IS_ERR(ap->regmap))
+		return dev_err_probe(dev, PTR_ERR(ap->regmap),
+				     "Failed to initialize regmap\n");
+
+	chip->ops = &andes_pwm_ops;
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
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



