Return-Path: <linux-pwm+bounces-2984-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3A94BE5B
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2024 15:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4BE1F253F7
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2024 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A018DF74;
	Thu,  8 Aug 2024 13:16:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CFE18B475;
	Thu,  8 Aug 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123008; cv=none; b=qD29WpSKoas/HpO+pudzv5Zk3RjyZajywRjsGfvCfveAtrsiWWO38Po/2gPHEB/WxLsZHxv4ZJ1wya8PPJ+StuqrPkARC7PdHYMt+I847xIN0tUoun2j27I0AL0QFczm5OTP3LDOM7chhvkTOTLYA+DZpzObAe4qQ78v/mBDuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123008; c=relaxed/simple;
	bh=lTLJrWjDdXkk3jLmuXfbHshBrGHGpiHiov9iGwH1S+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT+xYdNh9fhFsfltwG2mtaGQItCdp8Wxsw62BrvdFhP6CtwB/apb3yqo2fVENcsndE97MzF6MeYeS4+rY4CYRwXT5bE86ZDNmHs67aGc9qJptNM+lNmpIvSpqB2m3mpFJbGuQ6PwaEavykxceluAzWJZqPoyiNDMtT0ZiMjhPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.09,273,1716217200"; 
   d="scan'208";a="219094082"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 08 Aug 2024 22:16:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.225])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79ECD427A697;
	Thu,  8 Aug 2024 22:16:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v21 3/4] pwm: Add support for RZ/G2L GPT
Date: Thu,  8 Aug 2024 14:16:19 +0100
Message-ID: <20240808131626.87748-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
References: <20240808131626.87748-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
(GPT32E). It supports the following functions
 * 32 bits x 8 channels
 * Up-counting or down-counting (saw waves) or up/down-counting
   (triangle waves) for each counter.
 * Clock sources independently selectable for each channel
 * Two I/O pins per channel
 * Two output compare/input capture registers per channel
 * For the two output compare/input capture registers of each channel,
   four registers are provided as buffer registers and are capable of
   operating as comparison registers when buffering is not in use.
 * In output compare operation, buffer switching can be at crests or
   troughs, enabling the generation of laterally asymmetric PWM waveforms.
 * Registers for setting up frame cycles in each channel (with capability
   for generating interrupts at overflow or underflow)
 * Generation of dead times in PWM operation
 * Synchronous starting, stopping and clearing counters for arbitrary
   channels
 * Starting, stopping, clearing and up/down counters in response to input
   level comparison
 * Starting, clearing, stopping and up/down counters in response to a
   maximum of four external triggers
 * Output pin disable function by dead time error and detected
   short-circuits between output pins
 * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
 * Enables the noise filter for input capture and external trigger
   operation

Add basic pwm support for RZ/G2L GPT driver by creating separate
logical channels for each IOs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v20->v21:
 * Added documentation about the relation between channels and outputs and
   subchannels.
 * Dropped using the local variable offs for calculating channel regs and
   instead start using macros.
 * Replaced u8->bool for the  bootloader_enabled_channels variable in
   struct rzg2l_gpt_chip
 * Replaced duty_cycles->duty_ticks and period_cycles->period_ticks as it
   represent hw ticks.
 * Introduced RZG2L_MAX_TICKS macro for max hw ticks and dropped the
   variable max_val from struct rzg2l_gpt_chip.
 * Updated comment related to 64-bit overflow calculation in
   calculate_period_or_duty().
 * Simplified handling of bootloader_enabled_channels[pwm->hwpwm] == true
   in a single place in rzg2l_gpt_apply()
 * For config error case, don't call pm_runtime_put_sync() and with
   enable()->acquire pm_runtime reference and disable()-->release the
   pm_runtime reference
 * Split the cleanups into two. One for reset_control_deassert() earlier
   in .probe() and dropped rstc variable from struct rzg2l_gpt_chip.
 * Added warn_once() message in probe() for bootloader setting wrong
   prescale values.
v19->v20:
 * Added locks for rmw operations in rzg2l_gpt_{en,dis}able().
 * Dropped decremeng enable_count based ch_en_bits in rzg2l_gpt_disable().
 * Added a comment in calculate_period_or_duty() related to overflow.
 * Replaced ch_en_bits->bootloader_enabled_channels and used this variable
   in probe(), apply() and remove() for simplification
 * Replaced pm_runtime_enable()->devm_pm_runtime_enable()
v18->v19:
 * Replaced RZG2L_UP_COUNTING->RZG2L_GTUDDTYC_UP_COUNTING macro.
 * Aligned RZG2L_GET_CH and RZG2L_GET_CH_OFFS macro
 * Dropped chip and clk from struct rzg2l_gpt_chip as started using
   devm_pwmchip_alloc() and devm_clk_rate_exclusive_get() to replace it.
 * Replaced rate->rate_khz in struct rzg2l_gpt_chip and added a check in
   probe() to make sure rate is multiple of 1000.
 * Replaced container_of->pwmchip_get_drvdata() to get device data.
 * Added a check in rzg2l_gpt_disable() not to decrement enable_count if
   ch_en_bits is set by the probe.
 * Dropped rzg2l_gpt_mul_u64_u64_div_u64()
 * Simplified calculate_period_or_duty() using rate_khz
 * Simplified rzg2l_gpt_config() using min macro for calculating period
   and duty_cycle.
 * Added checks in rzg2l_gpt_config() to prevent second channel setting
   shared register.
 * Updated error handling rzg2l_gpt_apply()
 * Added local variable dev for &pdev->dev in probe()
 * Added local varibles rate, chip and clk in probe()
 * Dropped err_clk_rate_put label as started using
   devm_clk_rate_exclusive_get()
 * Replaced rzg2l_gpt->chip as data for devm_add_action_or_reset().
 * Added error message for rate > 1GHz in probe.
v17->v18:
 * Updated copyright from 2023->2024.
 * Added units.h for KILO macro.
 * Replaced RZG2L_GTCCR{A,B}->RZG2L_GTCCR(i)
 * Introduced macros RZG2L_GTIOR_{GTIOx,OxE} to handle subchannels.
 * Replaced RZG2L_IS_IOB()->rzg2l_gpt_subchannel()
 * Replaced the cache period->period_cycles.
 * Updated rzg2l_gpt_is_ch_enabled() to return early if counter is not
   running.
 * Updated calculate_period_or_duty() for avoiding overflows.
 * Updated rzg2l_gpt_calculate_pv_or_dc() with simplified calculation for
   DIV64_U64_ROUND_UP() and dropped the cast for U32_MAX in min_t.
 * Replaced mul_u64_u32_div->rzg2l_gpt_mul_u64_u64_div_u64() helper.
 * Dropped pm pointer from struct rzg2l_gpt_driver() and simplified clk
   handling in probe().
v16->v17:
* Added ret = dev_err_probe() to avoid return success in probe().
* Dropped unneeded MODULE_ALIAS().
* Dropped .owner from struct rzg2l_gpt_ops.
* Fixed build issue reported by kernel test robot <lkp@intel.com> by
  replacing DIV_ROUND_UP()->DIV64_U64_ROUND_UP() in
  rzg2l_gpt_calculate_pv_or_dc().
* Added max_val to struct rzg2l_gpt_chip to compute maximum period
  supported by the HW in probe() and limit its value in apply() to
  avoid 64-bit overflow with computation.
* Added helper function calculate_period_or_duty() to avoid losing
  precision for smaller period/duty cycle values
  ((2^32 * 10^9 << 2) < 2^64), by not processing the rounded values.
* Replaced mul_u64_u64_div_u64()->mul_u64_u32_div() as the former is
  giving warnings with CONFIG_PWM_DEBUG enabled for very high values. 
  eg:
	echo "###### Medium setting 11000 sec = 3hours ##"
	echo 11000000000000 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/period
	echo  5500000000000 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/duty_cycle
	dumpgptreg
	
	echo "###### High setting##"
	echo 43980465100800 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/period
	echo 23980465100800 > /sys/class/pwm/$PWMCHIP/pwm${IO_1}/duty_cycle
	dumpgptreg

	with mul_u64_u32_div():
	###### Medium setting 11000 sec = 3hours ##
	Read at address  0x10048464 (0xffffb9426464): 0x400746FE
	Read at address  0x1004844C (0xffff8fdfb44c): 0x2003A37F
	Read at address  0x1004842C (0xffff9855b42c): 0x05000001
	###### High setting##
	Read at address  0x10048464 (0xffff9101b464): 0xFFFFFFFF
	Read at address  0x1004844C (0xffffaee0544c): 0x8B95AD77
	Read at address  0x1004842C (0xffffbbc8a42c): 0x05000001

	with mul_u64_u64_div_u64():
	###### Medium setting 11000 sec = 3hours ##
	Read at address  0x10048464 (0xffffb3185464): 0x400746FE
	Read at address  0x1004844C (0xffff81ebb44c): 0x2003A37F
	Read at address  0x1004842C (0xffff904fd42c): 0x05000001
	######[  304.213944] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent (ena=1 pol=0 5500000000000/43980352512000) -> (ena=1 pol=0 5500000000000/43980239923200)
	 High setting##
	[  304.230854] pwm-rzg2l-gpt 10048000.pwm: .apply is not idempotent (ena=1 pol=0 23980465100800/43980352512000) -> (ena=1 pol=0 23980465100800/43980239923200)
	Read at address  0x10048464 (0xffffb5bb3464): 0xFFFFAA19
	Read at address  0x1004844C (0xffff99b8c44c): 0x8B95AD77
	Read at address  0x1004842C (0xffffbba2342c): 0x05000001
v15->v16:
* Replaced the macro DIV_ROUND_UP_ULL->DIV64_U64_ROUND_UP
* Added DIV_ROUND_UP in rzg2l_gpt_calculate_pv_or_dc() to avoid loss of
  precision.
* Replaced min->min_t() in rzg2l_gpt_calculate_pv_or_dc().
* Added a comment for rzg2l_gpt_config()
* Replaced mul_u64_u32_div()->mul_u64_u64_div_u64() in rzg2l_gpt_config()
* Fixed the logical condition related to counter stop in
  rzg2l_gpt_config().
* Dropped pm_runtime_resume_*() from rzg2l_gpt_config() as it is managed
  by rzg2l_gpt_apply().
* Moved pm_runtime_resume_*() from rzg2l_gpt_{en,dis}able() to
  rzg2l_gpt_apply().
v14->v15:
* Added enable_count and ch_en_bits variables to struct rzg2l_gpt_chip
  based on feedback for pwm_mtu3 driver.
* Updated copyright header and commit description by replacing "This patch
  adds"-> "Add"
* Replaced macro RZG2L_GET_CH_INDEX->RZG2L_GET_CH and replaced ch_index->ch
  throughout
* rzg2l_gpt_{enable,disable}() enables/disables PWM based on the
  enable_count.
* Replaced pm_runtime_get_sync->pm_runtime_resume_and_get and propogated
  the error in rzg2l_gpt_get_state() and rzg2l_gpt_config()
* Reduced variable scope in rzg2l_gpt_get_state() by moving most of variables
  inside the if statement.
* Updated rzg2l_gpt_get_state() by moving duty > period check
  inside the top if block.
* Added helper functions rzg2l_gpt_calculate_pv_or_dc()to simplify config. 
  Also Improved the logic in rzg2l_gpt_calculate_pv_or_dc() by using
  min(period_or_duty_cycle >> (2 * prescale), (u64)U32_MAX);
* Updated rzg2l_gpt_get_state() by moving duty > period check
  inside the top if block.
* Simplified rzg2l_gpt_config() for updating registers
* Dropped pm_runtime_get_sync() and used bitmap variable "ch_en_bits"
  to make balanced PM usage count in rzg2l_gpt_reset_assert_pm_disable()
  For case were unbind is called before apply where pwm is enabled by
  bootloader.
* Added error check for clk_rate_exclusive_get() and clk_get_rate() in
  probe().
* Dropped prescale from struct rzg2l_gpt_chip.
* Replaced of_match_ptr(rzg2l_gpt_of_table)->rzg2l_gpt_of_table in struct
  rzg2l_gpt_driver
v13->v14:
 * Removed parenthesis for RZG2L_MAX_HW_CHANNELS and RZG2L_CHANNELS_PER_IO
 * Removed duty_cycle variable from struct rzg2l_gpt_chip and added comment
   for cache for prescale variable.
 * Fixed a bug in rzg2l_gpt_cntr_need_stop().
 * Reordered rzg2l_gpt_config() just above apply()
 * Replaced pwm_is_enabled()->pwm->state.enabled in config
 * Replaced pm_runtime_resume_and_get with unconditional pm_runtime_get_sync()
   in config().
 * Restored duty_cycle > period check in rzg2l_gpt_get_state().
 * Added error check for clk_prepare_enable() in probe() and propagating error
   to the caller for pm_runtime_resume()
 * clk_get_rate() is called after enabling the clock and clk_rate_exclusive_get()
 * Simplified rzg2l_gpt_probe() by removing bitmap variables.
 * Added pm_runtime_idle() to suspend the device during probe.
 * Moved overflow condition check from config->probe().
 * Simplified rzg2l_gpt_reset_assert_pm_disable().
v12->v13:
 * Replaced Kconfig dependency from ARCH_RENESAS->ARCH_RZG2L
 * Sorted #include <linux/limits.h> alphabetically
 * Added a comment for mutex_lock to fix check patch warning
 * Replaced data type of duty_cycle from unsigned int->u32 as
   the maximum value stored is U32_MAX.
 * Improved rzg2l_gpt_config() by removing unwanted duty_cycle related code.
 * Improved rzg2l_gpt_get_state() by setting "val = rzg2l_gpt->duty_cycle[pwm->hwpwm];", 
   and factor "tmp = NSEC_PER_SEC * (u64)val;" out of the if-statement.
 * Started using DEFINE_RUNTIME_DEV_PM_OPS(), and dropped __maybe_unused
   from the callbacks.
v11->v12:
 * Added return code for get_state()
 * Cache duty cycle/prescale as the driver cannot read the current duty
   cycle/prescale from the hardware if the hardware is disabled. Cache the
   last programmed duty cycle/prescale value to return in that case.
 * Updated rzg2l_gpt_enable to enable the clocks.
 * Updated rzg2l_gpt_disable to disable the clocks.
 * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
 * Updated rzg2l_gpt_get_state to use cached value of duty cycle/prescale,If the PWM
   is disabled.
 * Simplified rzg2l_gpt_apply()
 * Added comments in rzg2l_gpt_reset_assert_pm_disable()
v10->v11:
 * Used bitmap_zero for initializing bitmap varable.
 * Fixed clock imbalance during remove for the case bootloader turning
   on PWM and module unload is called just after the boot.
 * Fixed over flow condition in get_state() for a prescale value of 2 & more.
 * Improved rzg2l_gpt_cntr_need_stop() based on prescale as it is the
   only runtime variable.
 * Added array for Cache variables state_period and prescale
 * Probe caches the prescale value set by the bootloader.
 * Updated rzg2l_gpt_config() to make use of array variables.
v9->v10:
 * Updated the error handling in probe(), clk_disable_unprepare called
   on the error path.
 * Removed ch_en array and started using bitmask instead.
v8->v9:
 * deassert after devm_clk_get() to avoid reset stays deasserted,in case
   clk_get() fails.
 * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
 * Updated error handling in probe()
v7->v8:
 * Modelled as single PWM device handling multiple channels
 * Replaced shared reset->devm_reset_control_get_exclusive()
 * Replaced iowrite32->writel and ioread32->readl
 * Updated prescale calculation
 * Added PM runtime callbacks
 * Updated PM handling and removed "pwm_enabled_by_bootloader" variable
 * Introduced rzg2l_gpt_is_ch_enabled for checking enable status on both
   IO's
 * Moved enable/disable output pins from config->enable/disable.
 * Added rzg2l_gpt_cntr_need_stop() for caching prescalar/mode values.
v6->v7:
 * Added the comment for cacheing rzg2l_gpt->state_period.
 * Fixed boundary values for pv and dc.
 * Added comment for modifying mode, prescaler, timer counter and buffer enable
   registers.
 * Fixed buffer overflow in get_state()
 * Removed unnecessary assignment of state->period value in get_state().
 * Fixed state->duty_cycle value in get_state().
 * Added a limitation for disabling the channels.
v5->v6:
 * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
   RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
   involving FIELD_PREP macro.
 * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR macro
   for duty_offset.
 * replaced misnomer real_period->state_period.
 * Added handling for values >= (1024 << 32) for both period
   and duty cycle.
 * Added comments for pwm {en,dis}abled by bootloader during probe.
v4->v5:
 * Added Hardware manual details
 * Replaced the comment GTCNT->Counter
 * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm directly
   used in probe.
 * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
 * Added driver prefix for the type name and the variable.
 * Initialization of per_channel data moved from request->probe.
 * Updated clr parameter for rzg2l_gpt_modify for Start count.
 * Started using mutex and usage_count for handling shared
   period and prescalar for the 2 channels.
 * Updated the comment cycle->period.
 * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
 * Replaced pc->rzg2l_gpt.
 * Updated prescale calculation.
 * Moved pm_runtime_{get_sync,put} from {request,free}->{enable,disable}
 * Removed platform_set_drvdata as it is unused
 * Removed the variable pwm_enabled_by_bootloader 
 * Added dev_err_probe in various error paths in probe.
 * Added an error message, if devm_pwmchip_add() fails.
v3->v4:
 * Changed the local variable type i from u16->u8 and prescaled_period_
   cycles from u64->u32 in calculate_prescale().
 * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
 * Dropped the comma after the sentinel.
 * Add a variable to track pwm enabled by bootloader and added comments
   in probe().
 * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe.
 * Replaced devm_clk_get()->devm_clk_get_prepared()
 * Removed devm_clk_get_optional_enabled()
v2->v3:
 * Updated limitation section
 * Added prefix "RZG2L_" for all macros
 * Modified prescale calculation
 * Removed pwm_set_chip_data
 * Updated comment related to modifying Mode and Prescaler
 * Updated setting of prescale value in rzg2l_gpt_config()
 * Removed else branch from rzg2l_gpt_get_state()
 * removed the err label from rzg2l_gpt_apply()
 * Added devm_clk_get_optional_enabled() to retain clk on status,
   in case bootloader turns on the clk of pwm.
 * Replaced devm_reset_control_get_exclusive->devm_reset_control_get_shared
   as single reset shared between 8 channels.
v1->v2:
 * Added Limitations section
 * dropped "_MASK" from the define names.
 * used named initializer for struct phase
 * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
 * Revised the logic for prescale
 * Added .get_state callback
 * Improved error handling in rzg2l_gpt_apply
 * Removed .remove callback
 * Tested driver with PWM_DEBUG enabled
RFC->V1:
 * Updated macros
 * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
 * Added rzg2l_gpt_read()
---
 drivers/pwm/Kconfig         |  11 +
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-rzg2l-gpt.c | 546 ++++++++++++++++++++++++++++++++++++
 3 files changed, 558 insertions(+)
 create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 3e53838990f5..460fa0fc7f52 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -533,6 +533,17 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
+config PWM_RZG2L_GPT
+	tristate "Renesas RZ/G2L General PWM Timer support"
+	depends on ARCH_RZG2L || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the General PWM Timer controller found in Renesas
+	  RZ/G2L like chips through the PWM API.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-rzg2l-gpt.
+
 config PWM_RZ_MTU3
 	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
 	depends on RZ_MTU3
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 0be4f3e6dd43..aa3f039e4005 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
 obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
 obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
new file mode 100644
index 000000000000..b4fc6a44d869
--- /dev/null
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -0,0 +1,546 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L General PWM Timer (GPT) driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corporation
+ *
+ * Hardware manual for this IP can be found here
+ * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ *
+ * Limitations:
+ * - Counter must be stopped before modifying Mode and Prescaler.
+ * - When PWM is disabled, the output is driven to inactive.
+ * - While the hardware supports both polarities, the driver (for now)
+ *   only handles normal polarity.
+ * - General PWM Timer (GPT) has 8 HW channels for PWM operations and
+ *   each HW channel have 2 IOs.
+ * - Each IO is modelled as an independent PWM channel.
+ * - When both channels are used, disabling the channel on one stops the
+ *   other.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/time.h>
+#include <linux/units.h>
+
+#define RZG2L_GET_CH(a)		((a) / 2)
+#define RZG2L_GET_CH_OFFS(i)	(0x100 * (i))
+
+#define RZG2L_GTCR(ch)		(0x2c + RZG2L_GET_CH_OFFS(ch))
+#define RZG2L_GTUDDTYC(ch)	(0x30 + RZG2L_GET_CH_OFFS(ch))
+#define RZG2L_GTIOR(ch)		(0x34 + RZG2L_GET_CH_OFFS(ch))
+#define RZG2L_GTBER(ch)		(0x40 + RZG2L_GET_CH_OFFS(ch))
+#define RZG2L_GTCNT(ch)		(0x48 + RZG2L_GET_CH_OFFS(ch))
+#define RZG2L_GTCCR(ch, sub_ch)	(0x4c + RZG2L_GET_CH_OFFS(ch) + 4 * (sub_ch))
+#define RZG2L_GTPR(ch)		(0x64 + RZG2L_GET_CH_OFFS(ch))
+
+#define RZG2L_GTCR_CST		BIT(0)
+#define RZG2L_GTCR_MD		GENMASK(18, 16)
+#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
+
+#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
+
+#define RZG2L_GTUDDTYC_UP	BIT(0)
+#define RZG2L_GTUDDTYC_UDF	BIT(1)
+#define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
+
+#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
+#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
+#define RZG2L_GTIOR_GTIOx(a)	((a) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GTIOA)
+#define RZG2L_GTIOR_OAE		BIT(8)
+#define RZG2L_GTIOR_OBE		BIT(24)
+#define RZG2L_GTIOR_OxE(a)	((a) ? RZG2L_GTIOR_OBE : RZG2L_GTIOR_OAE)
+
+#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
+#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
+	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
+#define RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
+	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE) | RZG2L_GTIOR_OBE)
+
+#define RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(a) \
+	((a) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
+	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
+
+#define RZG2L_MAX_HW_CHANNELS	8
+#define RZG2L_CHANNELS_PER_IO	2
+#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_PER_IO)
+#define RZG2L_MAX_SCALE_FACTOR	1024
+#define RZG2L_MAX_TICKS ((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
+
+struct rzg2l_gpt_chip {
+	void __iomem *mmio;
+	struct mutex lock; /* lock to protect shared channel resources */
+	unsigned long rate_khz;
+	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
+	u32 user_count[RZG2L_MAX_HW_CHANNELS];
+	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
+	bool bootloader_enabled_channels[RZG2L_MAX_PWM_CHANNELS];
+};
+
+static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static inline unsigned int rzg2l_gpt_subchannel(unsigned int hwpwm)
+{
+	return hwpwm & 0x1;
+}
+
+static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 data)
+{
+	writel(data, rzg2l_gpt->mmio + reg);
+}
+
+static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg)
+{
+	return readl(rzg2l_gpt->mmio + reg);
+}
+
+static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 clr,
+			     u32 set)
+{
+	rzg2l_gpt_write(rzg2l_gpt, reg,
+			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
+}
+
+static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
+				       u64 period_ticks)
+{
+	u32 prescaled_period_ticks;
+	u8 prescale;
+
+	prescaled_period_ticks = period_ticks >> 32;
+	if (prescaled_period_ticks >= 256)
+		prescale = 5;
+	else
+		prescale = (fls(prescaled_period_ticks) + 1) / 2;
+
+	return prescale;
+}
+
+static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	u32 ch = RZG2L_GET_CH(pwm->hwpwm);
+
+	mutex_lock(&rzg2l_gpt->lock);
+	rzg2l_gpt->user_count[ch]++;
+	mutex_unlock(&rzg2l_gpt->lock);
+
+	return 0;
+}
+
+static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	u32 ch = RZG2L_GET_CH(pwm->hwpwm);
+
+	mutex_lock(&rzg2l_gpt->lock);
+	rzg2l_gpt->user_count[ch]--;
+	mutex_unlock(&rzg2l_gpt->lock);
+}
+
+static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8 hwpwm)
+{
+	u8 ch = RZG2L_GET_CH(hwpwm);
+	u32 val;
+
+	val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
+	if (!(val & RZG2L_GTCR_CST))
+		return false;
+
+	val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTIOR(ch));
+
+	return val & RZG2L_GTIOR_OxE(rzg2l_gpt_subchannel(hwpwm));
+}
+
+static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
+			    struct pwm_device *pwm)
+{
+	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+	u32 val = RZG2L_GTIOR_GTIOx(sub_ch) | RZG2L_GTIOR_OxE(sub_ch);
+	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
+
+	mutex_lock(&rzg2l_gpt->lock);
+	/* Enable pin output */
+	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), val,
+			 RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(sub_ch));
+
+	if (!rzg2l_gpt->enable_count[ch])
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), 0, RZG2L_GTCR_CST);
+
+	rzg2l_gpt->enable_count[ch]++;
+	mutex_unlock(&rzg2l_gpt->lock);
+
+	return 0;
+}
+
+static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
+			      struct pwm_device *pwm)
+{
+	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
+
+	/* Stop count, Output low on GTIOCx pin when counting stops */
+	mutex_lock(&rzg2l_gpt->lock);
+	rzg2l_gpt->enable_count[ch]--;
+
+	if (!rzg2l_gpt->enable_count[ch])
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
+
+	/* Disable pin output */
+	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0);
+	mutex_unlock(&rzg2l_gpt->lock);
+}
+
+static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt, u32 val, u8 prescale)
+{
+	u64 tmp;
+
+	/*
+	 * The calculation doesn't overflow an u64 because prescale ≤ 5 and so
+	 * tmp = val << (2 * prescale) * USEC_PER_SEC
+	 *     < 2^32 * 2^10 * 10^6
+	 *     < 2^32 * 2^10 * 2^20
+	 *     = 2^62
+	 */
+	tmp = (u64)val << (2 * prescale);
+	tmp *= USEC_PER_SEC;
+
+	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
+}
+
+static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	int rc;
+
+	rc = pm_runtime_resume_and_get(pwmchip_parent(chip));
+	if (rc)
+		return rc;
+
+	state->enabled = rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
+	if (state->enabled) {
+		u32 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+		u32 ch = RZG2L_GET_CH(pwm->hwpwm);
+		u8 prescale;
+		u32 val;
+
+		val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
+		prescale = FIELD_GET(RZG2L_GTCR_TPCS, val);
+
+		val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(ch));
+		state->period = calculate_period_or_duty(rzg2l_gpt, val, prescale);
+
+		val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch));
+		state->duty_cycle = calculate_period_or_duty(rzg2l_gpt, val, prescale);
+		if (state->duty_cycle > state->period)
+			state->duty_cycle = state->period;
+	}
+
+	state->polarity = PWM_POLARITY_NORMAL;
+	pm_runtime_put(pwmchip_parent(chip));
+
+	return 0;
+}
+
+static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 prescale)
+{
+	return min_t(u64, (period_or_duty_cycle + (1 << (2 * prescale)) - 1) >> (2 * prescale),
+		     U32_MAX);
+}
+
+/* Caller holds the lock while calling rzg2l_gpt_config() */
+static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	u8 sub_ch = rzg2l_gpt_subchannel(pwm->hwpwm);
+	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
+	u64 period_ticks, duty_ticks;
+	unsigned long pv, dc;
+	u8 prescale;
+
+	/* Limit period/duty cycle to max value supported by the HW */
+	period_ticks = mul_u64_u64_div_u64(state->period, rzg2l_gpt->rate_khz, USEC_PER_SEC);
+	if (period_ticks > RZG2L_MAX_TICKS)
+		period_ticks = RZG2L_MAX_TICKS;
+	/*
+	 * GPT counter is shared by multiple channels, so prescale and period
+	 * can NOT be modified when there are multiple channels in use with
+	 * different settings.
+	 */
+	if (rzg2l_gpt->user_count[ch] > 1 && period_ticks < rzg2l_gpt->period_ticks[ch])
+		return -EBUSY;
+
+	prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
+	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, prescale);
+
+	duty_ticks = mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_khz, USEC_PER_SEC);
+	if (duty_ticks > RZG2L_MAX_TICKS)
+		duty_ticks = RZG2L_MAX_TICKS;
+	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, prescale);
+
+	/*
+	 * GPT counter is shared by multiple channels, we cache the period ticks
+	 * from the first enabled channel and use the same value for both
+	 * channels.
+	 */
+	rzg2l_gpt->period_ticks[ch] = period_ticks;
+
+	/*
+	 * Counter must be stopped before modifying mode, prescaler, timer
+	 * counter and buffer enable registers. These registers are shared
+	 * between both channels. So allow updating these registers only for the
+	 * first enabled channel.
+	 */
+	if (rzg2l_gpt->enable_count[ch] <= 1) {
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
+
+		/* GPT set operating mode (saw-wave up-counting) */
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_MD,
+				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
+
+		/* Set count direction */
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC(ch), RZG2L_GTUDDTYC_UP_COUNTING);
+
+		/* Select count clock */
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_TPCS,
+				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
+
+		/* Set period */
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(ch), pv);
+	}
+
+	/* Set duty cycle */
+	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(ch, sub_ch), dc);
+
+	if (rzg2l_gpt->enable_count[ch] <= 1) {
+		/* Set initial value for counter */
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT(ch), 0);
+
+		/* Set no buffer operation */
+		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER(ch), 0);
+
+		/* Restart the counter after updating the registers */
+		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch),
+				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
+	}
+
+	return 0;
+}
+
+static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	bool enabled = pwm->state.enabled;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * Probe() sets bootloader_enabled_channels. In such case,
+	 * clearing the flag will avoid errors during unbind.
+	 */
+	if (enabled && rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm])
+		rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] = false;
+
+	if (!state->enabled) {
+		if (enabled) {
+			rzg2l_gpt_disable(rzg2l_gpt, pwm);
+			pm_runtime_put_sync(pwmchip_parent(chip));
+		}
+
+		return 0;
+	}
+
+	if (!enabled) {
+		ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
+		if (ret)
+			return ret;
+	}
+
+	mutex_lock(&rzg2l_gpt->lock);
+	ret = rzg2l_gpt_config(chip, pwm, state);
+	mutex_unlock(&rzg2l_gpt->lock);
+	if (!ret && !enabled)
+		ret = rzg2l_gpt_enable(rzg2l_gpt, pwm);
+
+	return ret;
+}
+
+static const struct pwm_ops rzg2l_gpt_ops = {
+	.request = rzg2l_gpt_request,
+	.free = rzg2l_gpt_free,
+	.get_state = rzg2l_gpt_get_state,
+	.apply = rzg2l_gpt_apply,
+};
+
+static void rzg2l_gpt_reset_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
+static void rzg2l_gpt_rpm_put(void *data)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(data);
+	struct pwm_chip *chip = data;
+	u32 i;
+
+	/*
+	 * The below check is for making balanced PM usage count
+	 * eg: boot loader is turning on PWM and probe increments the PM usage
+	 * count. Before apply, if there is unbind/remove callback we need to
+	 * decrement the PM usage count.
+	 */
+	for (i = 0; i < chip->npwm; i++) {
+		if (rzg2l_gpt->bootloader_enabled_channels[i])
+			pm_runtime_put(pwmchip_parent(chip));
+	}
+}
+
+static int rzg2l_gpt_probe(struct platform_device *pdev)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt;
+	struct device *dev = &pdev->dev;
+	struct reset_control *rstc;
+	struct pwm_chip *chip;
+	unsigned long rate;
+	struct clk *clk;
+	int ret;
+	u32 i;
+
+	chip = devm_pwmchip_alloc(dev, RZG2L_MAX_PWM_CHANNELS, sizeof(*rzg2l_gpt));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+
+	rzg2l_gpt->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rzg2l_gpt->mmio))
+		return PTR_ERR(rzg2l_gpt->mmio);
+
+	rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "get reset failed\n");
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "cannot get clock\n");
+
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
+
+	ret = devm_add_action_or_reset(dev, rzg2l_gpt_reset_assert, rstc);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		goto err_pm_put;
+
+	rate = clk_get_rate(clk);
+	if (!rate) {
+		ret = dev_err_probe(dev, -EINVAL, "gpt clk rate is 0");
+		goto err_pm_put;
+	}
+
+	/*
+	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
+	 * period and duty cycle.
+	 */
+	if (rate > NSEC_PER_SEC) {
+		ret = dev_err_probe(dev, -EINVAL, "gpt clk rate is > 1GHz");
+		goto err_pm_put;
+	}
+
+	/*
+	 * Rate is in MHz and is always integer for peripheral clk
+	 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64
+	 * So make sure rate is multiple of 1000.
+	 */
+	rzg2l_gpt->rate_khz = rate / KILO;
+	if (rzg2l_gpt->rate_khz * KILO != rate) {
+		ret = dev_err_probe(dev, -EINVAL, "rate is not multiple of 1000");
+		goto err_pm_put;
+	}
+
+	/*
+	 * We need to keep the clock on, in case the bootloader has enabled the
+	 * PWM and is running during probe().
+	 */
+	for (i = 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
+		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
+			u8 ch = RZG2L_GET_CH(i);
+			u8 prescale;
+			u32 val;
+
+			rzg2l_gpt->bootloader_enabled_channels[i] = true;
+			val = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(ch));
+			prescale = FIELD_GET(RZG2L_GTCR_TPCS, val);
+			if (prescale > 5)
+				dev_warn_once(dev, "Invalid prescale set %d > 5", prescale);
+
+			rzg2l_gpt->enable_count[ch]++;
+			pm_runtime_get_sync(dev);
+		}
+	}
+
+	pm_runtime_put(dev);
+
+	mutex_init(&rzg2l_gpt->lock);
+	ret = devm_add_action_or_reset(dev, rzg2l_gpt_rpm_put, chip);
+	if (ret < 0)
+		return ret;
+
+	chip->ops = &rzg2l_gpt_ops;
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
+
+	return 0;
+
+err_pm_put:
+	pm_runtime_put(dev);
+	return ret;
+}
+
+static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,rzg2l-gpt", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
+
+static struct platform_driver rzg2l_gpt_driver = {
+	.driver = {
+		.name = "pwm-rzg2l-gpt",
+		.of_match_table = rzg2l_gpt_of_table,
+	},
+	.probe = rzg2l_gpt_probe,
+};
+module_platform_driver(rzg2l_gpt_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


