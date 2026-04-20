Return-Path: <linux-pwm+bounces-8646-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN28ECxU5mkDuwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8646-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 18:28:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D309042F83A
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 18:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F94E319FAAD
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59223B5851;
	Mon, 20 Apr 2026 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="DB4kL23K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD83B47D5;
	Mon, 20 Apr 2026 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692203; cv=pass; b=QNwubj/CzuP7k9dPcqJOpb+BTgiqFX1TuulxIO6zUBikmI4rDU1Wab8KOhe+3J8F3ssDrSUZzY2/7bvD951LzVqkbW9ymdnU5SYxPGWEcKHdvd7Cd5pn7s52rc/4mWSIJMuUjhy8sixWUGumkqd0hZ6N2oFuLnDbisQTvGypG88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692203; c=relaxed/simple;
	bh=KFumLSOaHpSenecvrbbACUEdI+0vNQq1Syc+iq6KAgc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RqBWCvp5RPX09FVqwAt8XziAIGfWIEnuiHdzB4GvFL1luegopG22hzfWa8LVS4RWoFDoFZdbYWz8EUANUffPPNjDnkv9NlD3ApXeRcCda5BvuodKlmR2gBEr0mv/0Q5ELEYobn3dSJUDMFchnu4exlgYl5vJdby47Q85VlUQZOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=DB4kL23K; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776692162; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c9zZFaXzcvREJwz0wSqQ9pRnTiWhjOvVPVDLirkf/i82Spe+e9VG1/vmMIt09CPGNs3ozySbTwVmC9afiVyXtSpY+XYU+EN2EHTrIwQQffLP3jDSayNOARU1oV5BBa9WwN9Ea5y4kbMM5vjVeOvr2tJTxonEjETSZsT4RrQ6ynI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776692162; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o/hAKPfN8TMW+uD8YQyiZTajFu7O0Cud/JgnJ6Wj6Tg=; 
	b=FoQ4Mzz0yS+pRNZyLKMrQewXUDbpMkzd7pPQgs+x7G2/Zy5VyWPzxRs1Xf7a3LxYlP5LSHsuC6SlsITO1/jV15T9wm2tWI6B5UqSAfqqkzCRFOiMRdQDO/xUxhXvQGAt457k0wCZdFCdHKTcgYokYXmUMoT01qiUoYPTpOkNYW4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776692162;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=o/hAKPfN8TMW+uD8YQyiZTajFu7O0Cud/JgnJ6Wj6Tg=;
	b=DB4kL23K8D1cf/ohw6LzSMl0Msm95Cokhwu7FmT70WAT7bdnTQzcghRn8jfyQGS6
	dWMwVB9G6jSJn4pvhIVLSNG7QMkjOkDwXt2JZj+pkDl5Yff4lFZ5QGCcqryDSaPgyP7
	6oDOeObrTtCuE4ZxqFpFEqw99E9OUlSjyk1CBONY=
Received: by mx.zohomail.com with SMTPS id 1776692160029395.011572346355;
	Mon, 20 Apr 2026 06:36:00 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v4 0/5] Add Rockchip RK3576 PWM Support Through MFPWM
Date: Mon, 20 Apr 2026 15:35:18 +0200
Message-Id: <20260420-rk3576-pwm-v4-0-421738c7bf28@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23PwU7DMAwG4FepcibIcVK37MR7IA5J6rGItdmSE
 oamvjtZh4Ahjr+l77d9FplT4Cw2zVkkLiGHONVg7hrhd3Z6YRmGmgUCtmCgk+lVtx3Jw/soDXW
 k3AADWysqOCTehtNa9vR8zYmPb7Vzvg6Fs5mlj+MY5k0z8WmWtZfAIIgL2IU8x/SxHlPUKr729
 r/3FiVBWvOAPXn0tudHH/d762Ky97V8rSr4wwnwhuOFk9HGgWcC/x/X31wB3nxddOXUGtt6p1h
 v+798WZZP2SK4BVcBAAA=
X-Change-ID: 20250407-rk3576-pwm-46761bd0deaa
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>, 
 Damon Ding <damon.ding@rock-chips.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8646-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org,microchip.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sntech.de:email,collabora.com:email,collabora.com:dkim,collabora.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D309042F83A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces support for some of the functions of the new PWM
silicon found on Rockchip's RK3576 SoC. Due to the wide range of
functionalities offered by it, including many parts which this series'
first iteration does not attempt to implement for now. The drivers are
modelled as an MFD, with no leakage of the MFD-ness into the binding, as
it's a Linux implementation detail.

Here's some of the features of the hardware:
- Continuous PWM output (implemented in this series)
- One-shot/Finite repetition PWM output
- PWM capture by counting high/low cycles (implemented in this series)
- Sending IR transmissions in several TV remote protocols
- Generating an interrupt based on the input being one of 16
  user-specified values ("Power key capture")
- Biphasic counter support
- Using the hardware to measure a clock signal's frequency
- Using the hardware to count a clock signal's pulses
- Generating PWM output waveforms through a user-specified lookup table

As you can tell, there's a lot. I've focused on continuous PWM output
for now as the most important one for things like controlling fans. The
PWM capture driver is an added bonus, because I needed at least two
drivers to test things. Anyone doing consumer electronic devices like
TVs based on the RK3576 may need to do the power key stuff at some
stage, as it can be used to wake up the SoC with an IR remote. The IR
transmission stuff in general may be a funny weekend project for someone
at some point; I assume it's there so TV boxes can turn on and off TVs
without needing the HDMI control stuff.

At first, I considered simply integrating support for this new IP into
the old pwm-rockchip driver, as the downstream vendor kernel did.
However, the IP is significantly different from previous iterations.
Especially if the goal is to support some of the additional
functionality that the new silicon brings, doing it all in a single pwm
driver would be untenable. Especially one that already supports other
hardware with a way different set of registers.

Hence, the mfpwm pattern: each device functionality is its own driver,
and they all get registered as MFD cells by the parent mfpwm MFD driver,
which is the one that binds to the DT compatible. Each device function
driver then has to _acquire and _release the hardware when it needs
control of it. If some other device function is using the device
already, -EBUSY is returned, which the device function driver can then
forward to the user and everyone is happy.

The PWM output driver, pwm-rockchip-v4, uses the new waveform APIs. I
thought while writing a new driver that I might as well use the new
APIs.

The PWM capture driver, implemented as a counter driver, is somewhat
primitive, in that it doesn't make use of things like the biphasic
counter support or clock measuring, but it serves as a good way to
showcase and test the mutual exclusion that the mfpwm framework tries to
achieve. It directly exposes the HPC/LPC counts as counters. Shoutouts
to the counter subsystem's documentation by the way, it is some of the
best subsystem documentation I've come across so far, and was a great
help.

All instances of the PWM controller have three clocks that they can pick
and choose to derive the PWM signal from. One is the default PLL from
the CRU, one is the 24 MHz crystal oscillator (gated by the CRU), and
one is an RC oscillator (also gated by the CRU). Each PWM channel can
switch between these with a clock selection register in the PWM register
range, hence this is implemented as a clock mux.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v4:
- Fix MAINTAINERS entry for mfpwm
- Make mfpwm core driver depend on ARCH_ROCKCHIP || COMPILE_TEST
- Remove redundant Kconfig deps from pwm output and counter
- mfpwm core: Introduce mfpwm_get_mode
- mfpwm core: Rename pwm out to rockchip-pwm-v4
- mfpwm core: Remove leftover commented out code
- pwm output: Rename to rockchip-pwm-v4
- pwm output: Rework round_wf_tohw:
  - Pass wf/wfhw into round_params
  - If wfhw->period is 0, don't do the offset clamping calculation to
    avoid underflow
  - Return -ERANGE in a theoretical future where the clock is that high
  - Change debug print
- pwm output: Change fromhw debug print to conform to other PWM drivers
- pwm output: Adjust comments at the start of the file
- pwm output: Store rate in wfhw struct
- pwm output: Get rid of unnecessary initialization of locals
- pwm output: Round up in fromhw
- pwm output: Use common is_enabled helper in read_wf
- pwm output: put exclusive rate and clk_disable on unlikely error path
- pwm output: Set of_node_reused on this device, rather than the parent,
  and set its device node to the parent node
- pwm output: Make failure to acquire PWM in probe an error rather than
  a warning
- pwm output: Re-do error handling in probe function to drop clock and
  mfpwm on failure
- counter: Get rid of enable_lock and is_enabled, read this from hw regs
- counter: Request IRQ after setting up the counter device
- counter: Acquire mfpwm if counter hardware is enabled at module probe
  time
- counter: Rework signals, synapses and counts
- Add patch to describe the Radxa ROCK 4D's PWM-controlled fan in DT
- Link to v3: https://lore.kernel.org/r/20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com

Changes in v3:
- Move drivers to using MFD; MFPWM now lives in the mfd tree as
  requested by Lee Jones
- Use the new FIELD_PREP_WM16 macros, and rebase onto next-20251027
- Get rid of some unused hardware version accessor inline functions
- pwm-rockchip-v4 pwm output: use devm_pwmchip_add and get rid of the
  driver remove callback that's no longer needed
- pwm-rockchip-v4 pwm output: use the parent MFD device's OF node, so
  that referencing the pwm node in DT works correctly (ty Heiko)
- pwm-rockchip-v4 pwm output: add link to public TRM for the hardware in
  comment at the start of the file
- pwm-rockchip-v4 pwm output: Capitalise first letter in kernel messages
- pwm-rockchip-v4 pwm output: get rid of unnecessary mul_u64_u64_div_u64
  calls where the operands cannot produce an overflow, turning it into a
  regular u64 division
- pwm-rockchip-v4 pwm output: simplify round_rate functions
- pwm-rockchip-v4 pwm output: remove redundant duty <= period check
- pwm-rockchip-v4 pwm output: print input parameters in tohw/fromhw in
  debug statement
- pwm-rockchip-v4 pwm output: clarify the offset < (period - duty) thing
  being dictated by hardware with a comment in the limitations list and
  near where the check is
- pwm-rockchip-v4 pwm output: remove pointless mfpwm_acquire/release
  calls in the fromhw/tohw functions, as they don't actually protect
  against anything
- pwm-rockchip-capture counter: expose HPC and LPC directly, and fire a
  change-of-state event on the appropriate channel on interrupt
- pwm-rockchip-capture counter: remove all the captures_left and delayed
  worker cruft
- pwm-rockchip-capture counter: use MFD parent's OF node
- pwm-rockchip-capture counter: change intsts ^ clr to != and add a
  comment explaining why there's no mask here
- Link to v2: https://lore.kernel.org/r/20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com

Changes in v2:
- bindings: make osc required (as it's present in all instances of the
  hardware I'm aware of) and add the rc clock as well. I thought it
  wasn't present on some instances of the PWM IP due to the vendor SoC
  dtsi, but checking the CRU made me realise those clocks do exist for
  all instances. Did not include Conor's R-b as this constitutes a
  substantial enough change to necessitate a re-review
- move bitfield write-enable mask macros into bitfield.h by replacing
  the original rockchip-specific utils header patch with a bitfield.h
  patch.
- mfpwm: change all instances of WARN to be dev_warn instead, as we have
  a device pointer.
- mfpwm: replace the ad-hoc clock mux implementation that used a sysfs
  interface with a generic clk-mux.
- mfpwm: add the rc clock
- mfpwm: rename all the pwmv4_ prefixed functions to have the
  rockchip_pwm_v4_ prefix instead
- mfpwm: remove the pwmclk indirection, hand chosen_clk to pwmf
- mfpwm: move to use the new bitfield macros for the WE mask
- mfpwm: mark reg access inline functions as static to fix build errors
- pwm-rockchip-v4 pwm output: replace mult_frac with mul_u64_u64_div_u64
- pwm-rockchip-v4 pwm output: don't return error if parameters are out
  of range, just set them to the maximum
- pwm-rockchip-v4 pwm output: add rate to debug message
- pwm-rockchip-v4 pwm output: if rate is 0 and pwm is disabled, set
  waveform parameters to 0. The clock is expected to not have a rate in
  this case.
- pwm-rockchip-v4 pwm output: add pwmchip_remove in remove callback,
  which also necessitated using chip as the platdata instead of the
  driver private struct
- pwm-rockchip-v4 pwm output: rework PWMV4_CTRL_UPDATE_EN since it never
  needs to be set to 0 by the driver
- pwm-rockchip-v4 pwm output: add a limitations list
- pwm-rockchip-v4 pwm output: handle initial hardware state during
  probe, enabling the pwm clock if the PWM is on and in continuous mode
- pwm-rockchip-v4 pwm output: rename pwmv4_is_enabled to use the
  rockchip_pwm_v4_ prefix instead
- pwm-rockchip-v4 pwm output: remove pwmclk indirection, use clk API
  directly
- pwm-rockchip-v4 pwm output: no longer claim the chip as being atomic,
  as the clk_rate_exclusive_get calls may sleep.
- rockchip-pwm-capture counter: remove pwmclk indirection, use clk API
  directly
- rockchip-pwm-capture counter: replace mult_frac with
  mul_u64_u64_div_u64
- rockchip-pwm-capture counter: don't output periods/duty cycles if the
  period is longer than the chosen timeout; this works around the
  hardware cycle counter seemingly being impossible to clear
- dts: added osc and rc to every pwm node
- dts: reordered properties in pwm0 to be sorted
- Link to v1: https://lore.kernel.org/r/20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com

To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Uwe Kleine-König <ukleinek@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
To: Lee Jones <lee@kernel.org>
To: William Breathitt Gray <wbg@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: kernel@collabora.com
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Alexey Charkov <alchark@gmail.com>
Cc: linux-rockchip@lists.infradead.org
Cc: linux-pwm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org

---
Nicolas Frattaroli (5):
      dt-bindings: pwm: Add a new binding for rockchip,rk3576-pwm
      mfd: Add Rockchip mfpwm driver
      pwm: Add rockchip PWMv4 driver
      arm64: dts: rockchip: add PWM nodes to RK3576 SoC dtsi
      arm64: dts: rockchip: Add cooling fan to ROCK 4D

 .../bindings/pwm/rockchip,rk3576-pwm.yaml          |  77 ++++
 MAINTAINERS                                        |  11 +
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts    |  50 +++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 208 +++++++++
 drivers/counter/Kconfig                            |  11 +
 drivers/counter/Makefile                           |   1 +
 drivers/counter/rockchip-pwm-capture.c             | 307 ++++++++++++++
 drivers/mfd/Kconfig                                |  16 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rockchip-mfpwm.c                       | 357 ++++++++++++++++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-rockchip-v4.c                      | 383 +++++++++++++++++
 include/linux/mfd/rockchip-mfpwm.h                 | 470 +++++++++++++++++++++
 14 files changed, 1904 insertions(+)
---
base-commit: 77a9bb0193d790fb71c0edfc567bddc1b56fb3ff
change-id: 20250407-rk3576-pwm-46761bd0deaa

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


