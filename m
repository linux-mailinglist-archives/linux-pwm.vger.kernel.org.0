Return-Path: <linux-pwm+bounces-9491-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MboSLGdiRGrTtwoAu9opvQ
	(envelope-from <linux-pwm+bounces-9491-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 02:42:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C786E8F16
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Jul 2026 02:42:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9491-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9491-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 290A130233C5
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Jul 2026 00:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8DD20E334;
	Wed,  1 Jul 2026 00:42:13 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3611CA9;
	Wed,  1 Jul 2026 00:42:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782866533; cv=none; b=ec6rPllRGJ0SU0S1cDt/j9DC28GSdLs63ky3Qch4waLM2Hz0t7A46U+chEZ1tGF5zRj6/FUdTTNxFJDBRfCh3MDplbrMG8FtbdD6dczfKCjBLpKdq2uxqQuqZ9PLBkRVE7VMUoFlde5AWCyWYW+oe83Or5OCvsD98pFnNJ1M7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782866533; c=relaxed/simple;
	bh=+Vk2KJJU+e6niFHzOZwRY9ZJVITjUv4FsmqPrHDpjZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3V+WivCSTVJWbxhZzQqMXrjzKf6RGHMuBdZVmNIk6Syv+me6tXZG03r1Rvpu+BNkbAYm6lAVmWBYGBVJ3qNguDPQGkLKQN/Ie/VU0u6YAmbe9lE72ON76/X9j+TyGufLjmKSzWf6+8I+SxEqH56dynO9xDt8YwNNWOIY0JXJ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.168.213
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgC3y55SYkRqqVgwAA--.53514S2;
	Wed, 01 Jul 2026 08:41:55 +0800 (CST)
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
Subject: [PATCH v9 0/3] Update designware pwm driver
Date: Wed,  1 Jul 2026 08:41:39 +0800
Message-Id: <20260701004139.347-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgC3y55SYkRqqVgwAA--.53514S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuw17WF45XF1DWF4rJFWxXrb_yoWDGw1xpF
	4xWrW3tr1kXryxtan7GF18uFyFg3Z8JFW5Kr1rW3W7Zw15ZayjqrWrKFyYva4qvr1qga45
	GFyfWa1Sya4jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
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
	TAGGED_FROM(0.00)[bounces-9491-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:email,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22C786E8F16

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
      apply() swap logic for consistent round-trip.
      Update this in the commit message (Sashiko review of v8).
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
 drivers/pwm/pwm-dwc-core.c                    | 161 ++++++--
 drivers/pwm/pwm-dwc-of.c                      | 356 ++++++++++++++++++
 drivers/pwm/pwm-dwc.h                         |  25 +-
 6 files changed, 548 insertions(+), 42 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

--
2.34.1


