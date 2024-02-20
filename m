Return-Path: <linux-pwm+bounces-1573-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792C85C507
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 20:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66011F24B21
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Feb 2024 19:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172A12B17A;
	Tue, 20 Feb 2024 19:43:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3FC1386B1;
	Tue, 20 Feb 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458212; cv=none; b=LZeGQr/AdLxVsmQnvX68dSwbHNKVGF0hj2W7o/eF/PuXN6gw0GFbOzpL0AiqmlU4TFrdF7CoCPw/0Tk4QzyMc00Cyb4pB0SI0xlmGLfi/K4za5iYGGLtc61vv3ckdFJNEWFkX5+RIwaCw1dkQfGe5Y1do1Pfme87BqI+v8pbsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458212; c=relaxed/simple;
	bh=zU00SR/zGyTHbKXrZCZ7QnpcoRH1irzbvJar+q+dQko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mSWoqLwyRTt5b0MGGoH2WVnkO9lgS+2og+BKW59r3hcqFHcnPsXXp722iPJyQf77T2OrHh4+HkiFnZYCIc11Tt/FIUf9LxojeYqF0cjA9Y9Dm4EBbNjxHWTSxWrKbLTjAhC7bEIer+ppKHau8jh6JWCqEJuU6+usoCPI8ZwS74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,174,1705330800"; 
   d="scan'208";a="198557833"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Feb 2024 04:43:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E7F35400A67A;
	Wed, 21 Feb 2024 04:43:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v18 0/4] Add support for RZ/G2L GPT
Date: Tue, 20 Feb 2024 19:43:14 +0000
Message-Id: <20240220194318.672443-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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
 * 32 bits × 8 channels
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

This patch series aims to add basic pwm support for RZ/G2L GPT driver
by creating separate logical channels for each IOs.

v17->v18:
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
 * Updated copyright from 2023->2024.
 * Moved bitpos near to the user in patch#4.
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
* Updated commit description of patch#4 by replacing "This patch add"->
  "Add".
v13->v14:
* Moved the patch from series[1] to here.
 [1] https://lore.kernel.org/linux-renesas-soc/20221215205843.4074504-1-biju.das.jz@bp.renesas.com/T/#t
 * Add Rb tag from Rob for patch#2
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
 * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
 * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it not only parse
   the properties but also implements the needed register writes.
 * Added acomment here about the purpose of the function rzg2l_gpt_poeg_init()
 * Removed magic numbers from rzg2l_gpt_poeg_init()
 * Fixed resource leak in rzg2l_gpt_poeg_init().
v12->v13:
 * Added test logs in [1] below
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
 * Updated the example gpt4: pwm@10048400-> gpt: pwm@10048000
 * Keep Rb tag from Rob as the above change is trivial one.
 * Updated the error handling in probe(), clk_disable_unprepare called
   on the error path.
 * Removed ch_en array and started using bitmask instead.
v8->v9:
 * Added Rb tag from Rob.
 * deassert after devm_clk_get() to avoid reset stays deasserted,in case
   clk_get() fails.
 * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
 * Updated error handling in probe()
v7->v8:
 * Removed Rb tags from Rob and Geert as it modelled as single GPT
   device handling multiple channels.
 * Updated description
 * Updated interrupts and interrupt-names properties
 * Updated binding example
 * Modelled as single PWM device handling multiple channels
 * Replaced shared reset->devm_reset_control_get_exclusive()
 * Added PM runtime callbacks
 * Updated PM handling and removed "pwm_enabled_by_bootloader" variable
 * Replaced iowrite32->writel and ioread32->readl
 * Updated prescale calculation
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
 * Added a limitation for disabling the channels, when both channels used
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
 * Added dev_err_probe in various probe error path.
 * Added an error message, if devm_pwmchip_add fails.
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
 * Added Rb tag from Rob for the bindings.
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
 * Added '|' after 'description:' to preserve formatting.
 * Removed description for pwm_cells as it is common property.
 * Changed the reg size in example from 0xa4->0x100
 * Added Rb tag from Geert for bindings.
 * Added Limitations section
 * dropped "_MASK" from the define names.
 * used named initializer for struct phase
 * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
 * Revised the logic for prescale
 * Added .get_state callback
 * Improved error handling in rzg2l_gpt_apply
 * Removed .remove callback
 * Tested the driver with PWM_DEBUG enabled.

RFC->v1:
 * Added Description in binding patch
 * Removed comments from reg and clock
 * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
 * Added rzg2l_gpt_read() and updated macros
 * Removed dtsi patches, will send it separately

RFC:
 * https://lore.kernel.org/linux-renesas-soc/20220430075915.5036-1-biju.das.jz@bp.renesas.com/T/#t

Biju Das (4):
  dt-bindings: pwm: Add RZ/G2L GPT binding
  dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
  pwm: Add support for RZ/G2L GPT
  pwm: rzg2l-gpt: Add support for gpt linking with poeg

 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 401 +++++++++++
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rzg2l-gpt.c                   | 641 ++++++++++++++++++
 4 files changed, 1054 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
 create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c


base-commit: a4aebe936554dac6a91e5d091179c934f8325708
-- 
2.25.1


