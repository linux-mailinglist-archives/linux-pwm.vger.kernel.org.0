Return-Path: <linux-pwm+bounces-9518-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Klo/DfyBR2o/ZwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9518-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 11:33:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D759700AEF
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 11:33:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9518-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9518-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 244233006B08
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46D3B0AC4;
	Fri,  3 Jul 2026 09:33:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BC5352021;
	Fri,  3 Jul 2026 09:33:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783071223; cv=none; b=nVdWVp01In8cASHntrLx4/0euOkpMen88fN6pWcBf2Yzpd9e4ooejXIakFSZKVUKgEsQf6VkcHOu+vfXjNtHVYUa3zAHvCRbAXI+6AhUhZ5mcZ3d5On4azZqOh3dmwenBe0PWjyzCbTYxfeaHLfC/wgu81dWeTUlMPsUYNflxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783071223; c=relaxed/simple;
	bh=BgAjqUgx3A8HNy0+q6Tlh3iLtLvqMNKdkZzJxZafM3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfDbnyZSDkmKeIC5IESx6Rl5lWR6FbiYFlmYTOEZ1D6Z3bOeqahcV6a9XvHFR1XXehl/20v7JzQ8wJEWmndo38Hx39fkbfumYMHlvwkAyGgzhg+vAwyBGIrgLQOzxMJ/4J0E2efgIPYbzSf5RowIAkxubfdy61V/SgkEi32QzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgA3y2_XgUdq3kgxAA--.57748S2;
	Fri, 03 Jul 2026 17:33:12 +0800 (CST)
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
Subject: [PATCH v10 0/3] Update designware pwm driver
Date: Fri,  3 Jul 2026 17:33:08 +0800
Message-Id: <20260703093308.482-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgA3y2_XgUdq3kgxAA--.57748S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJF1kWryUAw4rXF4kWF1DAwb_yoWkGF4kpF
	4Igr4ayr1kXryxtan7GF1xuFyFg3ZxJFW5Kr1rW3W7Zw1UZayUtrWrKFyYqFyqvr1qga15
	GryfWa1SyFyjyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXJ5wUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ben-linux@fluff.org,m:ben.dooks@codethink.co.uk,m:p.zabel@pengutronix.de,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:xuxiang@eswincomputing.com,m:wangguosheng@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:dongxuyang@eswincomputing.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9518-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,vger.kernel.org:from_smtp,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D759700AEF

From: Xuyang Dong <dongxuyang@eswincomputing.com>

There is already a patch [1] for the DesignWare PWM driver,
which is posted by Ben and still under review.
Based on this patch, this series is a continuation of [1]
to add support for IP versions 2.11a and later, which
includes support for "Pulse Width Modulation with 0%
and 100% Duty Cycle".

Supported chips:
ESWIN EIC7700 series SoC.

Test:
Tested this patch on the Sifive HiFive Premier P550 (which uses the EIC7700
SoC).

[1] https://lore.kernel.org/lkml/20230907161242.67190-1-ben.dooks@codethink.co.uk/

Updates:
  Changes in v10:
  - Driver:
    - Do not add a dependency on PM. Additionally, the issues below will
      be fixed to ensure compatibility with and without PM support
      (Sashiko review of v9).
    - Note that writes to dwc->clk_rate in apply()/get_state() cannot race
      due to PWM core's chip->nonatomic_lock (Sashiko review of v9).
    - Fix __dwc_pwm_configure_timer() precision loss from dual rounding
      (compute period_cyc once); reject sub-clock-cycle periods in 0N100
      mode (add !period_cyc check to avoid writing 0 to LD_CNT/LD_CNT2).
    - dwc_pwm_get_state():
      Fix pm_runtime_resume_and_get() error check to use 'if (ret < 0)' to
      allow stub return value 1 when CONFIG_PM=n.
    - Deassert reset before reading MMIO in probe() to avoid bus stalls on
      SoCs that leave the block in reset (Sashiko review of v9).
    - Keep clocks enabled when CONFIG_PM=n.
      Condition the clock gating on IS_ENABLED(CONFIG_PM)
      (Sashiko review of v9).
    - Move register save/restore into runtime PM callbacks.
      Replace legacy suspend/resume with pm_runtime_force_suspend()/resume()
      to properly manage the generic power domain.

    - Link to v9: https://lore.kernel.org/all/20260701004139.347-1-dongxuyang@eswincomputing.com/

  Changes in v9:
  - YAML:
    - Add 'Acked-by: Conor Dooley <conor.dooley@microchip.com>' for
      patch 1 and 2.
  - Driver:
    - __dwc_pwm_configure_timer():
      reads state->polarity and swaps registers:
      NORMAL (active-high): duty_cycle to DWC_TIM_LD_CNT2 (HIGH),
      remainder to DWC_TIM_LD_CNT (LOW)
      INVERSED (active-low): duty_cycle to DWC_TIM_LD_CNT (LOW),
      remainder to DWC_TIM_LD_CNT2 (HIGH)
      Applies to both 0N100 and classic paths.
      dwc_pwm_apply():
      removed -EINVAL polarity guard; both polarities accepted.
      dwc_pwm_get_state():
      reconstructs polarity from pwm->state.polarity (last apply() value);
      initial read zero-initialized to PWM_POLARITY_NORMAL; decode mirrors
      apply() swap logic for consistent round-trip (Sashiko review of v8).
    - Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
      dwc_pwm_apply() and add error checking (Sashiko review of v8).
    - Add a non-zero check for clk_rate in dwc_pwm_get_state().
      Add a non-zero check for dwc->clk_rate in probe (Sashiko review of v8).
    - When pwm_en is true, adding 'goto disable_clk;'. When pwm_en is false,
      return early from pm_disable without falling through to disable_clk.
      (Sashiko review of v8).
    - Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
      dwc_pwm_plat_remove() and add error checking.
      On failure, skip register reads and pm_runtime_put_sync()
      (Sashiko review of v8).
    - Remove the -EBUSY check in dwc_pwm_suspend() and save all contexts
      (Sashiko review of v8).
    - Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() in
      dwc_pwm_resume() (Sashiko review of v8).

  - Link to v8: https://lore.kernel.org/all/20260623071329.2034-1-dongxuyang@eswincomputing.com/

  Changes in v8:
  - YAML:
    - Split the v7 binding into two patches.
      Patch 1 explains why to add the resets property.
      Patch 2 adds the eswin compatible string and specified reset.
  - Driver:
    - Use mul_u64_u64_div_u64() to safely scale the values and avoid
      64-bit multiplication overflow in __dwc_pwm_configure_timer()
      and dwc_pwm_get_state().
      Add the include for linux/math64.h (Sashiko review of v7).
    - Keep the current usage of pwm->args.polarity until a better solution
      is available.
    - Use pm_runtime_resume_and_get() in dwc_pwm_get_state() instead of
      pm_runtime_get_sync(), so that register access is skipped if the
      device fails to resume (Sashiko review of v7).
    - Replace devm_pwmchip_add() with pwmchip_add() and move it after
      pm_runtime_enable(), so that the PWM chip is registered only after
      runtime PM has been fully initialized (Sashiko review of v7).
    - Remove the reset_assert label and reset_control_assert()
      (Sashiko review of v7).
    - Remove the pm_runtime_status_suspended() check and unconditionally
      use pm_runtime_get_sync() instead (Sashiko review of v7).
    - Remove  the pwm_en flag, but keep the pm_runtime_put_noidle() call
      (Sashiko review of v7; see email for explanation)
    - Use pm_runtime_status_suspended() to check the runtime PM status.
      If the device is not suspended (i.e., active), call
      clk_disable_unprepare(). If it is suspended, skip this block
      (Sashiko review of v7).
    - Use an explicit pwmchip_remove() as the first step of .remove(),
      instead of relying on devm_pwmchip_add() to unregister the chip
      after .remove() returns. This prevents the hardware teardown that
      follows from racing against a still-registered chip
      (Sashiko review of v7).
    - Add a check for dwc->rst before asserting reset in the remove path
      (Sashiko review of v7).
    - Drop the return value check from pm_runtime_put_sync()
      (Sashiko review of v7).

  - Link to v7: https://lore.kernel.org/all/20260605082242.1541-1-dongxuyang@eswincomputing.com/

  Changes in v7:
  - YAML:
    - Dropped Conor's Acked-by due to significant schema changes.
    - Rename patch 1 from "dt-bindings: pwm: dwc: add optional reset" to
      "dt-bindings: pwm: dwc: Add eswin compatible and resets property".
    - Update the commit message to explain why the EIC7700 supports only
      one reset.
    - Add constraints 'minItems: 1' and 'maxItems: 1' for the 'resets'
      property of eswin,eic7700-pwm.
    - Add an example for eswin,eic7700-pwm.

  - Link to v6: https://lore.kernel.org/all/20260424094529.1691-1-dongxuyang@eswincomputing.com/

  Changes in v6:
  - YAML:
    - Drop properties resets and its items description for eswin,eic7700-pwm.

  - Link to v5: https://lore.kernel.org/all/20260423083644.1168-1-dongxuyang@eswincomputing.com/

  Changes in v5:
  - YAML:
    - Add 'eswin,eic7700-pwm' compatible string.
    - Add the items description for the resets property and set minItems to 1.
    - Require resets property with exactly 1 reset for eswin,eic7700-pwm compatible.
  - Driver:
    - Add support for 'eswin,eic7700-pwm' compatible.
    - Add structure dwc_pwm_plat_data to manage the API for obtaining resets.

  - Link to v4: https://lore.kernel.org/all/20260415094908.1539-1-dongxuyang@eswincomputing.com/

  Changes in v4:
  - YAML:
    - Change maxItems from 1 to 2. As there is a corresponding reset signal
      for each clock domain, the effective maxItems of the resets property
      is set to 2.
    - Update the YAML commit message to describe the hardware.
  - Driver:
    - Replace devm_reset_control_get_optional_exclusive() with
      devm_reset_control_array_get_optional_exclusive(). Since the number
      of reset signals has increased from one to two, we need to use the
      array API to acquire them.

  - Link to v3: https://lore.kernel.org/all/20260402091718.1608-1-dongxuyang@eswincomputing.com/

  Changes in v3:
  - YAML:
    - Added a clear justification for the optional resets property. It is
      required to support proper controller initialization when no PWM
      channel is active at boot time, while allowing the driver to skip
      reset deassertion if any channel is already enabled.
  - Driver:
    - Update the boundary value check of tmp in __dwc_pwm_configure_timer()
      for DWC_TIM_CTRL_0N100PWM_EN.
    - Replace 'sizeof(struct dwc_pwm_drvdata)' with
      'struct_size(data, chips, 1)'.
    - Drop devm_clk_get_enabled() in favor of devm_clk_get() with explicit
      clk_prepare_enable() and clk_disable_unprepare() allowing runtime PM
      to manage clock state.
    - Replace devm_reset_control_get_optional_exclusive_deasserted() with
      devm_reset_control_get_optional_exclusive() and issue a full reset via
      reset_control_reset() only when no PWM channel is active at probe time.
    - Detect bootloader-enabled PWM channels by reading the enable bit, and
      initialize runtime PM as active for those channels by calling
      pm_runtime_set_active() and pm_runtime_get_noresume().
    - Remove autosuspend as it is not required for this driver.
    - Use explicit pm_runtime_enable() and pm_runtime_disable() instead of
      the managed devm_pm_runtime_enable() variant to ensure correct cleanup.
    - On device removal, recheck the channel enable status. If any channel
      remains active, call pm_runtime_put_noidle() before disabling clocks
      via clk_disable_unprepare().
      Resume device before register access during removal if it is runtime
      suspended, and re-suspend it afterward.
    - If device is suspended, resume it before register access during system
      resume/suspend.
    - Use pm_ptr() instead of pm_sleep_ptr() for correct PM operation.

  - Link to v2: https://lore.kernel.org/all/20260306093000.2065-1-dongxuyang@eswincomputing.com/

  Changes in v2:
  - YAML:
    - Remove eswin,eic7700-pwm.yaml. Use snps,dw-apb-timers-pwm2.yaml.
      The description in snps,dw-apb-timers-pwm2.yaml is better.
    - Add the resets property as optional, as defined in the databook.
    - Remove snps,pwm-full-range-enable as no additional property is needed.
  - Driver:
    - Change the file from pwm-dwc-eic7700.c to pwm-dwc-of.c from [1].
    - Define DWC_TIM_VERSION_ID_2_11A 2.11a as the baseline version.
    - Enable the 0% and 100% duty cycle mode by setting dwc->feature if
      the version read from the TIMERS_COMP_VERSION register is later
      than or equal to DWC_TIM_VERSION_ID_2_11A.
    - Use the DIV_ROUND_UP_ULL() to calculate width in the .apply and
      .get_state.
    - Additionally, Power Management (PM) support has been added to the
      pwm-dwc-of.c driver.
    - Drop the headers that are not used.
    - Use devm_clk_get_enabled() instead of devm_clk_get().
    - Drop of_match_ptr.
    - Fix build error with 1ULL << 32.
      Reported-by: kernel test robot <lkp@intel.com>
      Closes: https://lore.kernel.org/oe-kbuild-all/202512061720.j31AsgM7-lkp@intel.com/

  - Link to v1: https://lore.kernel.org/all/20251205090411.1388-1-dongxuyang@eswincomputing.com/
  - Link to v9: https://lore.kernel.org/lkml/20230907161242.67190-1-ben.dooks@codethink.co.uk/

Xuyang Dong (3):
  dt-bindings: pwm: dwc: Document optional resets property
  dt-bindings: pwm: dwc: Add eswin compatible
  pwm: dwc: add of/platform support

 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml |  37 +-
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-dwc-core.c                    | 161 +++++++--
 drivers/pwm/pwm-dwc-of.c                      | 316 ++++++++++++++++++
 drivers/pwm/pwm-dwc.h                         |  25 +-
 6 files changed, 507 insertions(+), 43 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

--
2.34.1


