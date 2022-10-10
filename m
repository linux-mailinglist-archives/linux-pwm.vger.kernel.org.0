Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849455FA085
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Oct 2022 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJJOwr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Oct 2022 10:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJJOwr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Oct 2022 10:52:47 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C77742AE5;
        Mon, 10 Oct 2022 07:52:45 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.95,173,1661785200"; 
   d="scan'208";a="136028508"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Oct 2022 23:52:45 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 93F9042F5166;
        Mon, 10 Oct 2022 23:52:41 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 4/4] mfd: Add RZ/G2L MTU3 PWM driver
Date:   Mon, 10 Oct 2022 15:52:22 +0100
Message-Id: <20221010145222.1047748-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for RZ/G2L MTU3 PWM driver. The IP supports
following PWM modes

1) PWM mode{1,2}
2) Reset-synchronized PWM mode
3) Complementary PWM mode{1,2,3}

This patch adds basic pwm mode 1 support for RZ/G2L MTU3 driver
by creating separate logical channels for each IOs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * There is no resource associated with "rz-mtu3-pwm" compatible
   and moved the code to mfd subsystem as it binds against "rz-mtu".
 * Removed struct platform_driver rz_mtu3_pwm_driver.
v2->v3:
 * No change.
v1->v2:
 * Modelled as a single PWM device handling multiple channles.
 * Used PM framework to manage the clocks.
---
 drivers/mfd/Kconfig       |   6 +
 drivers/mfd/Makefile      |   2 +
 drivers/mfd/rz-mtu3-pwm.c | 405 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 413 insertions(+)
 create mode 100644 drivers/mfd/rz-mtu3-pwm.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index fa88056224c9..1a0208236adc 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1994,6 +1994,12 @@ config MFD_RZ_MTU3_CNT
 	  SoCs. This IP supports both 16-bit and 32-bit phase counting mode
 	  support.
 
+config MFD_RZ_MTU3_PWM
+	tristate "Renesas RZ/G2L MTU3 PWM Timer support"
+	depends on MFD_RZ_MTU3
+	help
+	  Enable support for RZ/G2L MTU3 PWM Timer controller.
+
 config MFD_STM32_LPTIMER
 	tristate "Support for STM32 Low-Power Timer"
 	depends on (ARCH_STM32 && OF) || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9d0d1fd22f99..50c7467f7c79 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -253,7 +253,9 @@ obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
 rz-mtu3-objs			:= rz-mtu3-core.o
 rz-mtu3-$(CONFIG_MFD_RZ_MTU3_CNT)	+= rz-mtu3-cnt.o
+rz-mtu3-$(CONFIG_MFD_RZ_MTU3_PWM)	+= rz-mtu3-pwm.o
 obj-$(CONFIG_MFD_RZ_MTU3) 	+= rz-mtu3.o
+
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
 obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
diff --git a/drivers/mfd/rz-mtu3-pwm.c b/drivers/mfd/rz-mtu3-pwm.c
new file mode 100644
index 000000000000..8aa67577e022
--- /dev/null
+++ b/drivers/mfd/rz-mtu3-pwm.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L MTU3 PWM Timer driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * Hardware manual for this IP can be found here
+ * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ *
+ * Limitations:
+ * - When PWM is disabled, the output is driven to Hi-Z.
+ * - While the hardware supports both polarities, the driver (for now)
+ *   only handles normal polarity.
+ * - While the hardware supports pwm mode{1,2}, reset-synchronized pwm and
+ *   complementary pwm modes, the driver (for now) only handles pwm mode1.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/limits.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/time.h>
+
+#include "rz-mtu3.h"
+
+#define RZ_MTU3_TMDR1_MD_NORMAL		(0)
+#define RZ_MTU3_TMDR1_MD_PWM_MODE_1	(2)
+
+#define RZ_MTU3_TIOR_OC_RETAIN		(0)
+#define RZ_MTU3_TIOR_OC_0_H_COMP_MATCH	(2)
+#define RZ_MTU3_TIOR_OC_1_TOGGLE	(7)
+#define RZ_MTU3_TIOR_OC_IOA		GENMASK(3, 0)
+
+#define RZ_MTU3_TCR_CCLR_TGRC		(5 << 5)
+#define RZ_MTU3_TCR_CKEG_RISING		(0 << 3)
+
+#define RZ_MTU3_TCR_TPCS		GENMASK(2, 0)
+
+#define RZ_MTU3_MAX_PWM_MODE1_CHANNELS	(12)
+
+#define RZ_MTU3_MAX_HW_PWM_CHANNELS	(7)
+
+static const u8 rz_mtu3_pwm_mode1_num_ios[] = { 2, 1, 1, 2, 2, 2, 2 };
+
+/**
+ * struct rz_mtu3_pwm_chip - MTU3 pwm private data
+ *
+ * @chip: MTU3 pwm chip data
+ * @lock: Lock to prevent concurrent access for usage count
+ * @rate: MTU3 clock rate
+ * @user_count: MTU3 usage count
+ * @rz_mtu3_channel: HW channels for the PWM
+ */
+
+struct rz_mtu3_pwm_chip {
+	struct pwm_chip chip;
+	struct mutex lock;
+	unsigned long rate;
+	u32 user_count[RZ_MTU3_MAX_HW_PWM_CHANNELS];
+	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_PWM_CHANNELS];
+};
+
+static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct rz_mtu3_pwm_chip, chip);
+}
+
+static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip *rz_mtu3,
+					 u64 period_cycles)
+{
+	u32 prescaled_period_cycles;
+	u8 prescale;
+
+	prescaled_period_cycles = period_cycles >> 16;
+	if (prescaled_period_cycles >= 16)
+		prescale = 3;
+	else
+		prescale = (fls(prescaled_period_cycles) + 1) / 2;
+
+	return prescale;
+}
+
+static struct rz_mtu3_channel *
+rz_mtu3_get_hw_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 channel)
+{
+	unsigned int i, ch_index = 0;
+
+	for (i = 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
+		ch_index += rz_mtu3_pwm_mode1_num_ios[i];
+
+		if (ch_index > channel)
+			break;
+	}
+
+	return rz_mtu3_pwm->ch[i];
+}
+
+static u32 rz_mtu3_get_hw_channel_index(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+					struct rz_mtu3_channel *ch)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
+		if (ch == rz_mtu3_pwm->ch[i])
+			break;
+	}
+
+	return i;
+}
+
+static bool rz_mtu3_pwm_is_second_channel(u32 ch_index, u32 hwpwm)
+{
+	u32 i, pwm_ch_index = 0;
+
+	for (i = 0; i < ch_index; i++)
+		pwm_ch_index += rz_mtu3_pwm_mode1_num_ios[i];
+
+	return pwm_ch_index != hwpwm;
+}
+
+static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+				      u32 hwpwm)
+{
+	struct rz_mtu3_channel *ch;
+	bool is_channel_en;
+	u32 ch_index;
+	u8 val;
+
+	ch = rz_mtu3_get_hw_channel(rz_mtu3_pwm, hwpwm);
+	ch_index = rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
+	is_channel_en = rz_mtu3_is_enabled(ch);
+
+	if (rz_mtu3_pwm_is_second_channel(ch_index, hwpwm))
+		val = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORL);
+	else
+		val = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORH);
+
+	return (is_channel_en && (val & RZ_MTU3_TIOR_OC_IOA));
+}
+
+static int rz_mtu3_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	struct rz_mtu3_channel *ch;
+	u32 ch_index;
+
+	ch = rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch_index = rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
+
+	mutex_lock(&rz_mtu3_pwm->lock);
+	rz_mtu3_pwm->user_count[ch_index]++;
+	mutex_unlock(&rz_mtu3_pwm->lock);
+
+	ch->function = RZ_MTU3_PWM_MODE_1;
+
+	return 0;
+}
+
+static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	struct rz_mtu3_channel *ch;
+	u32 ch_index;
+
+	ch = rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch_index = rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
+
+	mutex_lock(&rz_mtu3_pwm->lock);
+	rz_mtu3_pwm->user_count[ch_index]--;
+	mutex_unlock(&rz_mtu3_pwm->lock);
+
+	if (!rz_mtu3_pwm->user_count[ch_index])
+		ch->function = RZ_MTU3_NORMAL;
+}
+
+static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+			      struct pwm_device *pwm)
+{
+	struct rz_mtu3_channel *ch;
+	u32 ch_index;
+	u8 val;
+
+	ch = rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch_index = rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
+	val = (RZ_MTU3_TIOR_OC_1_TOGGLE << 4) | RZ_MTU3_TIOR_OC_0_H_COMP_MATCH;
+
+	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_PWM_MODE_1);
+	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
+		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL, val);
+	else
+		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH, val);
+
+	if (rz_mtu3_pwm->user_count[ch_index] <= 1)
+		rz_mtu3_enable(ch);
+
+	return 0;
+}
+
+static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+				struct pwm_device *pwm)
+{
+	struct rz_mtu3_channel *ch;
+	u32 ch_index;
+
+	ch = rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch_index = rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
+
+	/* Return to normal mode and disable output pins of MTU3 channel */
+	if (rz_mtu3_pwm->user_count[ch_index] <= 1)
+		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_NORMAL);
+
+	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
+		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL, RZ_MTU3_TIOR_OC_RETAIN);
+	else
+		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH, RZ_MTU3_TIOR_OC_RETAIN);
+
+	if (rz_mtu3_pwm->user_count[ch_index] <= 1)
+		rz_mtu3_disable(ch);
+}
+
+static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	struct rz_mtu3_channel *ch;
+	unsigned long pv, dc;
+	u64 period_cycles;
+	u64 duty_cycles;
+	u32 ch_index;
+	u8 prescale;
+	u8 val;
+
+	/*
+	 * Refuse clk rates > 1 GHz to prevent overflowing the following
+	 * calculation.
+	 */
+	if (rz_mtu3_pwm->rate > NSEC_PER_SEC)
+		return -EINVAL;
+
+	ch = rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch_index = rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
+	duty_cycles = state->duty_cycle;
+	if (!state->enabled)
+		duty_cycles = 0;
+
+	period_cycles = mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
+					NSEC_PER_SEC);
+	prescale = rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);
+
+	if (period_cycles >> (2 * prescale) <= U16_MAX)
+		pv = period_cycles >> (2 * prescale);
+	else
+		pv = U16_MAX;
+
+	duty_cycles = mul_u64_u32_div(duty_cycles, rz_mtu3_pwm->rate,
+				      NSEC_PER_SEC);
+	if (duty_cycles >> (2 * prescale) <= U16_MAX)
+		dc = duty_cycles >> (2 * prescale);
+	else
+		dc = U16_MAX;
+
+	val = RZ_MTU3_TCR_CKEG_RISING | prescale;
+	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
+		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
+				      RZ_MTU3_TCR_CCLR_TGRC | val);
+		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRD, dc);
+		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRC, pv);
+	} else {
+		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
+				      RZ_MTU3_TCR_CCLR_TGRA | val);
+		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRB, dc);
+		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, pv);
+	}
+
+	return 0;
+}
+
+static void rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	struct rz_mtu3_channel *ch;
+	u8 prescale, val;
+	u32 ch_index;
+	u16 dc, pv;
+	u64 tmp;
+
+	ch = rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch_index = rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
+	pm_runtime_get_sync(chip->dev);
+	state->enabled = rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm->hwpwm);
+	if (state->enabled) {
+		val = rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TCR);
+		prescale = FIELD_GET(RZ_MTU3_TCR_TPCS, val);
+
+		if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
+			dc = rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRD);
+			pv = rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRC);
+		} else {
+			dc = rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRB);
+			pv = rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRA);
+		}
+
+		tmp = NSEC_PER_SEC * (u64)pv << (2 * prescale);
+		state->period = DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
+
+		tmp = NSEC_PER_SEC * (u64)dc << (2 * prescale);
+		state->duty_cycle = DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
+	}
+
+	state->polarity = PWM_POLARITY_NORMAL;
+	pm_runtime_put(chip->dev);
+}
+
+static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	struct pwm_state cur_state;
+	bool enabled;
+	int ret;
+
+	cur_state = pwm->state;
+	enabled = cur_state.enabled;
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!enabled && state->enabled)
+		pm_runtime_get_sync(chip->dev);
+
+	ret = rz_mtu3_pwm_config(chip, pwm, state);
+	if (ret && state->enabled)
+		goto done;
+
+	if (!state->enabled) {
+		if (enabled)
+			rz_mtu3_pwm_disable(rz_mtu3_pwm, pwm);
+		ret = 0;
+		goto done;
+	}
+
+	return rz_mtu3_pwm_enable(rz_mtu3_pwm, pwm);
+done:
+	if (enabled && !state->enabled)
+		pm_runtime_put(chip->dev);
+
+	return ret;
+}
+
+static const struct pwm_ops rz_mtu3_pwm_ops = {
+	.request = rz_mtu3_pwm_request,
+	.free = rz_mtu3_pwm_free,
+	.get_state = rz_mtu3_pwm_get_state,
+	.apply = rz_mtu3_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+int rz_mtu3_pwm_probe(struct platform_device *pdev)
+{
+	struct rz_mtu3 *ddata = dev_get_drvdata(&pdev->dev);
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
+	struct device *dev = &pdev->dev;
+	int num_pwm_hw_ch;
+	unsigned int i;
+	int ret;
+
+	rz_mtu3_pwm = devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm), GFP_KERNEL);
+	if (!rz_mtu3_pwm)
+		return -ENOMEM;
+
+	ddata->pwm_priv = rz_mtu3_pwm;
+	num_pwm_hw_ch = 0;
+	for (i = 0; i < RZ_MTU_NUM_CHANNELS; i++) {
+		if (i == RZ_MTU5 || i == RZ_MTU8)
+			continue;
+
+		rz_mtu3_pwm->ch[num_pwm_hw_ch] = &ddata->channels[i];
+		rz_mtu3_pwm->ch[num_pwm_hw_ch]->dev = dev;
+		num_pwm_hw_ch++;
+	}
+
+	rz_mtu3_pwm->rate = clk_get_rate(ddata->clk);
+
+	mutex_init(&rz_mtu3_pwm->lock);
+
+	rz_mtu3_pwm->chip.dev = &pdev->dev;
+	rz_mtu3_pwm->chip.ops = &rz_mtu3_pwm_ops;
+	rz_mtu3_pwm->chip.npwm = RZ_MTU3_MAX_PWM_MODE1_CHANNELS;
+
+	ret = devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rz_mtu3_pwm_probe);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L MTU3 PWM Timer Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

