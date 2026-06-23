Return-Path: <linux-pwm+bounces-9346-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yfyeH0oyOmpQ3wcAu9opvQ
	(envelope-from <linux-pwm+bounces-9346-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 09:14:18 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D716B4BF3
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 09:14:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9346-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9346-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EA89304DEAA
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jun 2026 07:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C583C5849;
	Tue, 23 Jun 2026 07:14:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79C3C4B6A;
	Tue, 23 Jun 2026 07:13:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198842; cv=none; b=pKVETvcRM9RFKMorE3oKD0iS9jxn3J8Cyi1JOjPr1G9fxRjNLoB2TcOO+93aJgKfzJYGpquEW/kuAGFacmbKI1cx2me+yfCdvVbAN+Z5usDrFbIPo2Oq1w0iFO3k+xGsXyzabwCyhrnN8/JIeBh4nufqzHgeCtkK+0vZ9wUnPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198842; c=relaxed/simple;
	bh=Pg4RawGJjtjFM0wmcYvitHCRS6ojfZSRrV1kfcdMl8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oey/GqmEb56E1zfiOUNFUffKFMB95tKEb0lN5XC0l9vkV0NKmIF/DppUqYOCtrXHK47yA0UhmTZbB6ibsXfUDr6KNFHRAJC5KppM9d77ctt6540i9l1JE5O8z4y1yW0CN7vHVdDHLCMcCWcafDZHq9omSgibw5x3rmsxaNogfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgBXa54fMjpqNHotAA--.46367S2;
	Tue, 23 Jun 2026 15:13:36 +0800 (CST)
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
Subject: [PATCH v8 0/3] Update designware pwm driver
Date: Tue, 23 Jun 2026 15:13:29 +0800
Message-Id: <20260623071329.2034-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgBXa54fMjpqNHotAA--.46367S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry8Gr4rJrWfKr15AF48Xrb_yoW3ur45pF
	4xGrW5tr1kXryIqan7W3W8uFyFgayrJFWUKr1rW3W7Zw1YvayUtrWF9F1YvFyqvr1vga45
	tFyfW3Wava4jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUUUU=
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
	TAGGED_FROM(0.00)[bounces-9346-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:email,eswincomputing.com:mid,eswincomputing.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8D716B4BF3

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
 drivers/pwm/pwm-dwc-core.c                    | 103 ++++--
 drivers/pwm/pwm-dwc-of.c                      | 346 ++++++++++++++++++
 drivers/pwm/pwm-dwc.h                         |  25 +-
 6 files changed, 488 insertions(+), 34 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

--
2.34.1


