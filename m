Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B77A6E5E97
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Apr 2023 12:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjDRKWQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Apr 2023 06:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDRKVs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Apr 2023 06:21:48 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AB9B6E9E;
        Tue, 18 Apr 2023 03:20:43 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,206,1677510000"; 
   d="scan'208";a="156394551"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Apr 2023 19:20:42 +0900
Received: from localhost.localdomain (unknown [10.226.92.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id C849E400A653;
        Tue, 18 Apr 2023 19:20:39 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Date:   Tue, 18 Apr 2023 11:20:37 +0100
Message-Id: <20230418102037.346405-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The RZ/G2L Multi-Function Timer Pulse Unit 3 (a.k.a MTU3a) uses
one counter and two match components to configure duty_cycle
and period to generate PWM output waveform.

Add basic support for RZ/G2L MTU3a PWM driver by creating separate
PWM channels for each IOs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
This patch series depend upon linux-next [1]
[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230417&id=bbd4013b44e6c21b997c1fa18ee635a9f3b1c4cc

v15->v16:
 * Fixed extra space around hwpwm check on rz_mtu3_get_channel().
 * Dropped redundant is_channel_en check on rz_mtu3_pwm_is_ch_enabled().
 * Replaced channel->base_pwm_number in struct rz_mtu3_channel_io_map.
 * Added comment for channel_map.
 * Dropped setting normal mode in rz_mtu3_pwm_disable().
 * Replaced ddata->parent_ddata in probe()
 * Added support for modifying prescalar, if other PWM is off or handle
   it, if current prescale value is less than the one we want to set.
 * Added below helper functions rz_mtu3_pwm_calculate_pv_or_dc() and 
   rz_mtu3_pwm_{read,write}_tgr_registers to simplify the code.
v14->v15:
 * Updated copyright header and Limitations section
 * Moved register definitions to <linux/mfd/rz-mtu3.h>
 * Introduced new mapping table struct rz_mtu3_channel_io_map to hold the
   index of the lowest PWM and the number of PWMs handled by the HW channel.
 * Introduced struct rz_mtu3_pwm_channel to hold mtu3 channel data and
   mapping table.
 * Replaced rz_mtu3_get_hw_channel->rz_mtu3_get_channel and channel->hwpwm.
   The rz_mtu3_get_channel() returns struct rz_mtu3_pwm_channel*
 * Dropped rz_mtu3_pwm_is_second_channel() as same can be obtained directly
   with new mapping (ie, priv->map->channel == pwm->hwpwm)
 * Replaced ch_index->ch throughout and used "priv - rz_mtu3_pwm->channel_data"
   to find ch and dropped rz_mtu3_get_hw_channel_index().
 * Optimized rz_mtu3_pwm_is_ch_enabled() by exit early, if is_channel_en is false.
 * Updated rz_mtu3_pwm_request() and added comments.
 * Introduced a bug in the driver by introducing enable_count, which increment/
   decrement during enable()/disable().
 * Reduced variable scope in rz_mtu3_pwm_get_state() by moving most of variables
   inside the if statement.
 * Updated probe() to assign the struct rz_mtu3_pwm_channel values.
v13->v14:
 * Updated commit description
 * Updated Limitations section.
 * Replaced the macros RZ_MTU*->RZ_MTU3_CHAN_* in probe()
 * Fixed a kernel crash in error path by moving rz_mtu3_pwm->chip.dev before
   devm_add_action_or_reset()
 * Added pm_runtime_idle() and simplified error paths for devm_add_action_or_reset()
   and devm_pwmchip_add().
v12->v13:
 * Updated commit description
 * Moved RZ_MTU3_TMDR1_MD_* macros to rz_mtu3.h
 * Updated Limitations section.
 * Removed PWM mode1 references from the driver.
 * Dropped prescale and duty_cycle from struct rz_mtu3_pwm_chip.
 * Replaced rz_mtu3_pwm_mode1_num_ios->rz_mtu3_hw_channel_ios.
 * Avoided race condition in rz_mtu3_pwm_request()/rz_mtu3_pwm_free().
 * Updated get_state() by adding dc > pv check and added a comment about
   overflow condition.
 * Moved overflow condition check from config->probe()
 * Replaced pm_runtime_resume_and_get with unconditional pm_runtime_get_sync()
   in config()
 * Added error check for clk_prepare_enable() in probe() and propagating error
   to the caller for pm_runtime_resume()
 * clk_get_rate() is called after enabling the clock and clk_rate_exclusive_put()
v11->v12:
 * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is in MFD.
 * Reordered get_state()
v10->v11:
 * No change.
v9->v10:
 * No change.
v8->v9:
 * Added prescale/duty_cycle variables to struct rz_mtu3_pwm_chip and
   cached this values in rz_mtu3_pwm_config and used this cached values
   in get_state(), if PWM is disabled.
 * Added return code for get_state()
v7->v8:
 * Simplified rz_mtu3_pwm_request by calling rz_mtu3_request_channel()
 * Simplified rz_mtu3_pwm_free by calling rz_mtu3_release_channel()
v6->v7:
 * Added channel specific mutex lock to avoid race between counter
   device and rz_mtu3_pwm_{request,free}
 * Added pm_runtime_resume_and_get in rz_mtu3_pwm_enable()
 * Added pm_runtime_put_sync in rz_mtu3_pwm_disable()
 * Updated rz_mtu3_pwm_config()
 * Updated rz_mtu3_pwm_apply()
v5->v6:
 * Updated commit and Kconfig description
 * Sorted the header
 * Replaced dev_get_drvdata from rz_mtu3_pwm_pm_disable()
 * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
   __maybe_unused from suspend/resume()
v4->v5:
 * pwm device is instantiated by mtu3a core driver.
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
 drivers/pwm/Kconfig       |  11 +
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-rz-mtu3.c | 539 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 551 insertions(+)
 create mode 100644 drivers/pwm/pwm-rz-mtu3.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8df861b1f4a3..ac0517b51540 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -493,6 +493,17 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
+config PWM_RZ_MTU3
+	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
+	depends on RZ_MTU3 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the MTU3a PWM Timer controller found in Renesas
+	  RZ/G2L like chips through the PWM API.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-rz-mtu3.
+
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 19899b912e00..68b7a15c2ca5 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
 obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
new file mode 100644
index 000000000000..4e63c20e3198
--- /dev/null
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L MTU3a PWM Timer driver
+ *
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ *
+ * Hardware manual for this IP can be found here
+ * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ *
+ * Limitations:
+ * - When PWM is disabled, the output is driven to Hi-Z.
+ * - While the hardware supports both polarities, the driver (for now)
+ *   only handles normal polarity.
+ * - HW uses one counter and two match components to configure duty_cycle
+ *   and period.
+ * - Multi-Function Timer Pulse Unit (a.k.a MTU) has 7 HW channels for PWM
+ *   operations. (The channels are MTU{0..4, 6, 7}.)
+ * - MTU{1, 2} channels have a single IO, whereas all other HW channels have
+ *   2 IOs.
+ * - Each IO is modelled as an independent PWM channel.
+ * - rz_mtu3_channel_io_map table is used to map the PWM channel to the
+ *   corresponding HW channel as there are difference in number of IOs
+ *   between HW channels.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/limits.h>
+#include <linux/mfd/rz-mtu3.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/time.h>
+
+#define RZ_MTU3_MAX_PWM_CHANNELS	12
+#define RZ_MTU3_MAX_HW_CHANNELS		7
+
+/**
+ * struct rz_mtu3_channel_io_map - MTU3 pwm channel map
+ *
+ * @base_pwm_number: First PWM of a channel
+ * @num: number of IOs on the HW channel.
+ */
+struct rz_mtu3_channel_io_map {
+	u8 base_pwm_number;
+	u8 num_channel_ios;
+};
+
+/**
+ * struct rz_mtu3_pwm_channel - MTU3 pwm channel data
+ *
+ * @mtu: MTU3 channel data
+ * @map: MTU3 pwm channel map
+ */
+struct rz_mtu3_pwm_channel {
+	struct rz_mtu3_channel *mtu;
+	const struct rz_mtu3_channel_io_map *map;
+};
+
+/**
+ * struct rz_mtu3_pwm_chip - MTU3 pwm private data
+ *
+ * @chip: MTU3 pwm chip data
+ * @clk: MTU3 module clock
+ * @lock: Lock to prevent concurrent access for usage count
+ * @rate: MTU3 clock rate
+ * @user_count: MTU3 usage count
+ * @enable_count: MTU3 enable count
+ * @prescale: MTU3 prescale
+ * @channel_data: MTU3 pwm channel data
+ */
+
+struct rz_mtu3_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct mutex lock;
+	unsigned long rate;
+	u32 user_count[RZ_MTU3_MAX_HW_CHANNELS];
+	u32 enable_count[RZ_MTU3_MAX_HW_CHANNELS];
+	u8 prescale[RZ_MTU3_MAX_HW_CHANNELS];
+	struct rz_mtu3_pwm_channel channel_data[RZ_MTU3_MAX_HW_CHANNELS];
+};
+
+/*
+ * The MTU channels are {0..4, 6, 7} and the number of IO on MTU1
+ * and MTU2 channel is 1 compared to 2 on others.
+ */
+static const struct rz_mtu3_channel_io_map channel_map[] = {
+	{ 0, 2 }, { 2, 1 }, { 3, 1 }, { 4, 2 }, { 6, 2 }, { 8, 2 }, { 10, 2 }
+};
+
+static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct rz_mtu3_pwm_chip, chip);
+}
+
+static void rz_mtu3_pwm_read_tgr_registers(struct rz_mtu3_pwm_channel *priv,
+					   u16 reg_pv_offset, u16 *pv_val,
+					   u16 reg_dc_offset, u16 *dc_val)
+{
+	*pv_val = rz_mtu3_16bit_ch_read(priv->mtu, reg_pv_offset);
+	*dc_val = rz_mtu3_16bit_ch_read(priv->mtu, reg_dc_offset);
+}
+
+static void rz_mtu3_pwm_write_tgr_registers(struct rz_mtu3_pwm_channel *priv,
+					    u16 reg_pv_offset, u16 pv_val,
+					    u16 reg_dc_offset, u16 dc_val)
+{
+	rz_mtu3_16bit_ch_write(priv->mtu, reg_pv_offset, pv_val);
+	rz_mtu3_16bit_ch_write(priv->mtu, reg_dc_offset, dc_val);
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
+static struct rz_mtu3_pwm_channel *
+rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 hwpwm)
+{
+	struct rz_mtu3_pwm_channel *priv = rz_mtu3_pwm->channel_data;
+	unsigned int ch;
+
+	for (ch = 0; ch < RZ_MTU3_MAX_HW_CHANNELS; ch++, priv++) {
+		if (priv->map->base_pwm_number + priv->map->num_channel_ios > hwpwm)
+			break;
+	}
+
+	return priv;
+}
+
+static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+				      u32 hwpwm)
+{
+	struct rz_mtu3_pwm_channel *priv;
+	bool is_channel_en;
+	u8 val;
+
+	priv = rz_mtu3_get_channel(rz_mtu3_pwm, hwpwm);
+	is_channel_en = rz_mtu3_is_enabled(priv->mtu);
+	if (!is_channel_en)
+		return false;
+
+	if (priv->map->base_pwm_number == hwpwm)
+		val = rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TIORH);
+	else
+		val = rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TIORL);
+
+	return val & RZ_MTU3_TIOR_IOA;
+}
+
+static int rz_mtu3_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	struct rz_mtu3_pwm_channel *priv;
+	bool is_mtu3_channel_available;
+	u32 ch;
+
+	priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch = priv - rz_mtu3_pwm->channel_data;
+
+	mutex_lock(&rz_mtu3_pwm->lock);
+	/*
+	 * Each channel must be requested only once, so if the channel
+	 * serves two PWMs and the other is already requested, skip over
+	 * rz_mtu3_request_channel()
+	 */
+	if (!rz_mtu3_pwm->user_count[ch]) {
+		is_mtu3_channel_available = rz_mtu3_request_channel(priv->mtu);
+		if (!is_mtu3_channel_available) {
+			mutex_unlock(&rz_mtu3_pwm->lock);
+			return -EBUSY;
+		}
+	}
+
+	rz_mtu3_pwm->user_count[ch]++;
+	mutex_unlock(&rz_mtu3_pwm->lock);
+
+	return 0;
+}
+
+static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	struct rz_mtu3_pwm_channel *priv;
+	u32 ch;
+
+	priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch = priv - rz_mtu3_pwm->channel_data;
+
+	mutex_lock(&rz_mtu3_pwm->lock);
+	rz_mtu3_pwm->user_count[ch]--;
+	if (!rz_mtu3_pwm->user_count[ch])
+		rz_mtu3_release_channel(priv->mtu);
+
+	mutex_unlock(&rz_mtu3_pwm->lock);
+}
+
+static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+			      struct pwm_device *pwm)
+{
+	struct rz_mtu3_pwm_channel *priv;
+	u32 ch;
+	u8 val;
+	int rc;
+
+	rc = pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
+	if (rc)
+		return rc;
+
+	priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch = priv - rz_mtu3_pwm->channel_data;
+	val = RZ_MTU3_TIOR_OC_IOB_TOGGLE | RZ_MTU3_TIOR_OC_IOA_H_COMP_MATCH;
+
+	rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_PWMMODE1);
+	if (priv->map->base_pwm_number == pwm->hwpwm)
+		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH, val);
+	else
+		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL, val);
+
+	mutex_lock(&rz_mtu3_pwm->lock);
+	if (!rz_mtu3_pwm->enable_count[ch])
+		rz_mtu3_enable(priv->mtu);
+
+	rz_mtu3_pwm->enable_count[ch]++;
+	mutex_unlock(&rz_mtu3_pwm->lock);
+
+	return 0;
+}
+
+static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+				struct pwm_device *pwm)
+{
+	struct rz_mtu3_pwm_channel *priv;
+	u32 ch;
+
+	priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch = priv - rz_mtu3_pwm->channel_data;
+
+	/* Disable output pins of MTU3 channel */
+	if (priv->map->base_pwm_number == pwm->hwpwm)
+		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORH, RZ_MTU3_TIOR_OC_RETAIN);
+	else
+		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TIORL, RZ_MTU3_TIOR_OC_RETAIN);
+
+	mutex_lock(&rz_mtu3_pwm->lock);
+	rz_mtu3_pwm->enable_count[ch]--;
+	if (!rz_mtu3_pwm->enable_count[ch])
+		rz_mtu3_disable(priv->mtu);
+
+	mutex_unlock(&rz_mtu3_pwm->lock);
+
+	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
+}
+
+static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+
+	pm_runtime_get_sync(chip->dev);
+	state->enabled = rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm->hwpwm);
+	if (state->enabled) {
+		struct rz_mtu3_pwm_channel *priv;
+		u8 prescale, val;
+		u16 dc, pv;
+		u64 tmp;
+
+		priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
+		if (priv->map->base_pwm_number == pwm->hwpwm)
+			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRA, &pv,
+						       RZ_MTU3_TGRB, &dc);
+		else
+			rz_mtu3_pwm_read_tgr_registers(priv, RZ_MTU3_TGRC, &pv,
+						       RZ_MTU3_TGRD, &dc);
+
+		val = rz_mtu3_8bit_ch_read(priv->mtu, RZ_MTU3_TCR);
+		prescale = FIELD_GET(RZ_MTU3_TCR_TPCS, val);
+
+		/* With prescale <= 7 and pv <= 0xffff this doesn't overflow. */
+		tmp = NSEC_PER_SEC * (u64)pv << (2 * prescale);
+		state->period = DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
+		tmp = NSEC_PER_SEC * (u64)dc << (2 * prescale);
+		state->duty_cycle = DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
+	}
+
+	if (state->duty_cycle > state->period)
+		state->duty_cycle = state->period;
+
+	state->polarity = PWM_POLARITY_NORMAL;
+	pm_runtime_put(chip->dev);
+
+	return 0;
+}
+
+static u16 rz_mtu3_pwm_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 prescale)
+{
+	return (period_or_duty_cycle >> (2 * prescale)) <= U16_MAX ?
+		period_or_duty_cycle >> (2 * prescale) : U16_MAX;
+}
+
+static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	struct rz_mtu3_pwm_channel *priv;
+	u64 period_cycles;
+	u64 duty_cycles;
+	u8 prescale;
+	u16 pv, dc;
+	u8 val;
+	u32 ch;
+
+	priv = rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
+	ch = priv - rz_mtu3_pwm->channel_data;
+
+	period_cycles = mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
+					NSEC_PER_SEC);
+	prescale = rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);
+
+	/*
+	 * Prescalar is shared by multiple channels, so prescale can
+	 * NOT be modified when there are multiple channels in use with
+	 * different settings. Modify prescalar if other PWM is off or handle
+	 * it, if current prescale value is less than the one we want to set.
+	 */
+	if (rz_mtu3_pwm->enable_count[ch] > 1) {
+		if (rz_mtu3_pwm->prescale[ch] > prescale)
+			return -EBUSY;
+
+		prescale = rz_mtu3_pwm->prescale[ch];
+	}
+
+	pv = rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);
+
+	duty_cycles = mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
+				      NSEC_PER_SEC);
+	dc = rz_mtu3_pwm_calculate_pv_or_dc(duty_cycles, prescale);
+
+	/*
+	 * If the PWM channel is disabled, make sure to turn on the clock
+	 * before writing the register.
+	 */
+	if (!pwm->state.enabled)
+		pm_runtime_get_sync(chip->dev);
+
+	val = RZ_MTU3_TCR_CKEG_RISING | prescale;
+
+	/* Counter must be stopped while updating TCR register */
+	if (rz_mtu3_pwm->prescale[ch] != prescale && rz_mtu3_pwm->enable_count[ch])
+		rz_mtu3_disable(priv->mtu);
+
+	if (priv->map->base_pwm_number == pwm->hwpwm) {
+		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
+				      RZ_MTU3_TCR_CCLR_TGRA | val);
+		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,
+						RZ_MTU3_TGRB, dc);
+	} else {
+		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
+				      RZ_MTU3_TCR_CCLR_TGRC | val);
+		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRC, pv,
+						RZ_MTU3_TGRD, dc);
+	}
+
+	if (rz_mtu3_pwm->prescale[ch] != prescale) {
+		/*
+		 * Prescalar is shared by multiple channels, we cache the
+		 * prescalar value from first enabled channel and use the same
+		 * value for both channels.
+		 */
+		rz_mtu3_pwm->prescale[ch] = prescale;
+
+		if (rz_mtu3_pwm->enable_count[ch])
+			rz_mtu3_enable(priv->mtu);
+	}
+
+	/* If the PWM is not enabled, turn the clock off again to save power. */
+	if (!pwm->state.enabled)
+		pm_runtime_put(chip->dev);
+
+	return 0;
+}
+
+static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	bool enabled = pwm->state.enabled;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (enabled)
+			rz_mtu3_pwm_disable(rz_mtu3_pwm, pwm);
+
+		return 0;
+	}
+
+	mutex_lock(&rz_mtu3_pwm->lock);
+	ret = rz_mtu3_pwm_config(chip, pwm, state);
+	mutex_unlock(&rz_mtu3_pwm->lock);
+	if (ret)
+		return ret;
+
+	if (!enabled)
+		ret = rz_mtu3_pwm_enable(rz_mtu3_pwm, pwm);
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
+static int rz_mtu3_pwm_pm_runtime_suspend(struct device *dev)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(rz_mtu3_pwm->clk);
+
+	return 0;
+}
+
+static int rz_mtu3_pwm_pm_runtime_resume(struct device *dev)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(rz_mtu3_pwm->clk);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
+				 rz_mtu3_pwm_pm_runtime_suspend,
+				 rz_mtu3_pwm_pm_runtime_resume, NULL);
+
+static void rz_mtu3_pwm_pm_disable(void *data)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = data;
+
+	clk_rate_exclusive_put(rz_mtu3_pwm->clk);
+	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
+	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
+}
+
+static int rz_mtu3_pwm_probe(struct platform_device *pdev)
+{
+	struct rz_mtu3 *parent_ddata = dev_get_drvdata(pdev->dev.parent);
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
+	struct device *dev = &pdev->dev;
+	unsigned int i, j = 0;
+	int ret;
+
+	rz_mtu3_pwm = devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm), GFP_KERNEL);
+	if (!rz_mtu3_pwm)
+		return -ENOMEM;
+
+	rz_mtu3_pwm->clk = parent_ddata->clk;
+
+	for (i = 0; i < RZ_MTU_NUM_CHANNELS; i++) {
+		if (i == RZ_MTU3_CHAN_5 || i == RZ_MTU3_CHAN_8)
+			continue;
+
+		rz_mtu3_pwm->channel_data[j].mtu = &parent_ddata->channels[i];
+		rz_mtu3_pwm->channel_data[j].mtu->dev = dev;
+		rz_mtu3_pwm->channel_data[j].map = &channel_map[j];
+		j++;
+	}
+
+	mutex_init(&rz_mtu3_pwm->lock);
+	platform_set_drvdata(pdev, rz_mtu3_pwm);
+	ret = clk_prepare_enable(rz_mtu3_pwm->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Clock enable failed\n");
+
+	clk_rate_exclusive_get(rz_mtu3_pwm->clk);
+
+	rz_mtu3_pwm->rate = clk_get_rate(rz_mtu3_pwm->clk);
+	/*
+	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
+	 * period and duty cycle.
+	 */
+	if (rz_mtu3_pwm->rate > NSEC_PER_SEC) {
+		ret = -EINVAL;
+		clk_rate_exclusive_put(rz_mtu3_pwm->clk);
+		goto disable_clock;
+	}
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	rz_mtu3_pwm->chip.dev = &pdev->dev;
+	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_pwm_pm_disable,
+				       rz_mtu3_pwm);
+	if (ret < 0)
+		return ret;
+
+	rz_mtu3_pwm->chip.ops = &rz_mtu3_pwm_ops;
+	rz_mtu3_pwm->chip.npwm = RZ_MTU3_MAX_PWM_CHANNELS;
+	ret = devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+
+	pm_runtime_idle(&pdev->dev);
+
+	return 0;
+
+disable_clock:
+	clk_disable_unprepare(rz_mtu3_pwm->clk);
+	return ret;
+}
+
+static struct platform_driver rz_mtu3_pwm_driver = {
+	.driver = {
+		.name = "pwm-rz-mtu3",
+		.pm = pm_ptr(&rz_mtu3_pwm_pm_ops),
+	},
+	.probe = rz_mtu3_pwm_probe,
+};
+module_platform_driver(rz_mtu3_pwm_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_ALIAS("platform:pwm-rz-mtu3");
+MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a PWM Timer Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

