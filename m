Return-Path: <linux-pwm+bounces-7495-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F858C0F91F
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB7494E8B08
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEFE312815;
	Mon, 27 Oct 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ep/DhsUp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1634630C35E;
	Mon, 27 Oct 2025 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585267; cv=pass; b=AA3Jg1K5t0y04qtJ5II56QLQNkx7W13H6qaNbYtA8EDRRhyv4/+b02d/ojJe1CYgogWpD/KOjpa/TzxGGv4qqoKrYL1X+CzX4bPU9l7oGDBhg0O99glTlQeDyMdHEcATujH3Vw2eHBz7P0dgqftUAUyDXQ0VY2JoHIIq3s3bVy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585267; c=relaxed/simple;
	bh=/QQA0EhRwYCXtYHiHZ5B625HbeGGI+fHNs4nAG/khUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rPA2RiKsouvwZ8dsvlh4MhttldOUGyfXCZX0mDMvEO3O74ZYrqKrdc4XgaOfF/YHYWvqC2cXUVX5Aik0J7HYZYRerb/VNZpGy+7y6oj0L7V70VL+j94vn3V4wmVHsMGs4Ri1pPq/9S1EfVCqURbi0R9IkGI3ezxTd1MXD2NdstE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ep/DhsUp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761585241; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NzisYXrfrpOPTdNvvUa950eiGFKRNF7tGi03D1s5z9f9R67kyF7OI6DaBOnogcouxU9c8oYlK7Ivd+Bb73HPbZPg4/kfJuAlUpiYv/c3h2B2UPC66l80Gto9lY4dTOG0OiovNmwR3ihgOL8EetqM8+F5a/R1DPsNQKSThF8gy18=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761585241; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bj3/rh+yOn0l5NFxLvcoO980agEhHlkxaJXKa+Ao+YY=; 
	b=Kdylrp7cHbQQg82fEN+Cl0g5IHzS1ovrDchtYJUN69kAftLKSHl0MzBl3mAlT752WXUvUVIlD8LHeVr4I7IyB4pHIrkSPazaANBvYXeqHkrS4KCsyAXuugGgzuWww08arzpYfvXcaoDap7MQU1p1LY0JvrtHfBP6ujGxSv7Is04=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761585241;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=bj3/rh+yOn0l5NFxLvcoO980agEhHlkxaJXKa+Ao+YY=;
	b=ep/DhsUp9bbnztuxSbqb5s7HmAZnjcszXOlRzGnitAWOs5qhQuzCEuhABoE8r+ky
	CzhKC5qSdk0TymUnU2BKmCSehPiPwlFaeWv8y9RvbUJyWMj3VPOmrm84XMpTbSDuhK2
	wiipi59YDUufISUt0je0Y5UEwrw5RaeF46gqgF0Y=
Received: by mx.zohomail.com with SMTPS id 176158523750232.35853937361014;
	Mon, 27 Oct 2025 10:13:57 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 0/5] Add Rockchip RK3576 PWM Support Through MFPWM
Date: Mon, 27 Oct 2025 18:11:55 +0100
Message-Id: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANun/2gC/12OzQ6CMBAGX4X0bM1SSkFOvofxUMoqjUKxRcQQ3
 t1STPw5ziYz307EodXoSBFNxOKgnTath2QTEVXL9oxUV54JA5YCh4zaS5JmgnaPhnKRibisoEI
 piRc6iyc9htjhuLLF2903+/VISumQKtM0ui+iFseeLt0YWEYWodauN/YZnhniYLx38+/dIaZAJ
 d+xXCimZI57Za5XWRortz4eUgP76ALYj84WXfCEl6BQgPrX53l+AQmKIh4YAQAA
X-Change-ID: 20250407-rk3576-pwm-46761bd0deaa
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

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

---
Nicolas Frattaroli (5):
      dt-bindings: pwm: Add a new binding for rockchip,rk3576-pwm
      mfd: Add Rockchip mfpwm driver
      pwm: Add rockchip PWMv4 driver
      counter: Add rockchip-pwm-capture driver
      arm64: dts: rockchip: add PWM nodes to RK3576 SoC dtsi

 .../bindings/pwm/rockchip,rk3576-pwm.yaml          |  77 ++++
 MAINTAINERS                                        |  11 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 208 ++++++++++
 drivers/counter/Kconfig                            |  13 +
 drivers/counter/Makefile                           |   1 +
 drivers/counter/rockchip-pwm-capture.c             | 306 ++++++++++++++
 drivers/mfd/Kconfig                                |  15 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rockchip-mfpwm.c                       | 340 +++++++++++++++
 drivers/pwm/Kconfig                                |  13 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-rockchip-v4.c                      | 353 ++++++++++++++++
 include/linux/mfd/rockchip-mfpwm.h                 | 454 +++++++++++++++++++++
 13 files changed, 1793 insertions(+)
---
base-commit: bcc13b1a26aa2747dd08b87b7c349b3d05889618
change-id: 20250407-rk3576-pwm-46761bd0deaa

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


