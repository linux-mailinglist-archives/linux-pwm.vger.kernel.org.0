Return-Path: <linux-pwm+bounces-6219-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BC4ACB970
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 18:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47DE3B521D
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF1224B07;
	Mon,  2 Jun 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YJHwBFwM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3121B9C7;
	Mon,  2 Jun 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881214; cv=pass; b=MT3foRZWONLrj46Y+zXqtVBojcMqL+P965CdJqcmLw/TaE2G9VzwyJaaCzVyXILZuDg4uYLMockIGbkLdc6HKYpfezG2Q/p68st74XfSjctym2tdVFaZUUtexOC+hFMFs8bDlVxvlzkHV1pf3Q4ZVuuSA0rYgTm3Qd3q8dzYBrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881214; c=relaxed/simple;
	bh=Gx9u1OaBa0YswmsedAMKnIm5kXBTYm/ji2Z8GNtflRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q6rBIpHvgWU38PyCamWUM2r2/psOZbcLOBQ5RQpV8jlrWAZafcAJxlUX2v/orBnV3O/q6+ULghPYUGX7TR1J/1LEifUjxGK/QHR4FdQduzbZx0xwGed6hDKfA6m7LIbPOvRxKBGya+UNbhg1Qto9GR4HfJyOBBvaG+orRkpqqb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=YJHwBFwM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748881178; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EfYrjNRxPweosxh29/g6GIr6q6+9NzM8DbVrBhOC550hENN42nT2mbN+DhC0S1nGZ+sTDAPTeS6Ok6z+O+WeVJkX/IXaZxBQ3NXEdOoI3/5jTXTDmO6TLwfnux5sT2P3DZBu3kOaSeQ+O27C99jaz3FMHGr4k8gkKFjOkdIg730=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748881178; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hx/HldExY4GTOZSh1i+YCNyPSP1ozFzxarOi6vvHmCQ=; 
	b=OTBFKHxlIHj0FSVsOOJqmhPPqlWthptIFvl1+vEC93NSjN6D9YdtYKf7zYU9Cur0J/GGzWETriegLrviREgIE4LGmYB5VLIBrXy00t3X6mrLWbm2Z8usJE1T0y0LQ/Chkk3BraISHamVaARsyjs4T5fPHO5m4/XVXMbzFarTYrg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748881178;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=hx/HldExY4GTOZSh1i+YCNyPSP1ozFzxarOi6vvHmCQ=;
	b=YJHwBFwMai1DWr7G16b959fu92/g+71oiyQiWJGTFGq+mPAIG0BdU1+ZUs7A27vi
	dB42yIiCxVRx3Mv1cxsoWyJguewJdLsL08B0NubQyKlMsqVOrmjnH1FFDukKWrXL94+
	5pfW76PoRBeOVOxGl2RmbaD5aNPj9NsSU/lhVH5s=
Received: by mx.zohomail.com with SMTPS id 1748881176633199.43684770113896;
	Mon, 2 Jun 2025 09:19:36 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/7] Add Rockchip RK3576 PWM Support Through MFPWM
Date: Mon, 02 Jun 2025 18:19:11 +0200
Message-Id: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/OPWgC/02OQQ6CMBBFr0Jm7ZhSoCAr72FYlDJKI1BsK2IId
 7eCC5dvkvf+LODIanJQRgtYmrTTZgjADxGoVg43Qt0EBs54xlKWo70nWS5wfPWYilzEdcMakhK
 CMFq66nmLXaqdLT2eoen3I9TSESrT99qX0UCzx62bJQy+QqudN/a9PTPFm/HbLf53pxgZyvTEC
 6G4kgWdlek6WRsrjyEO1bquHwa5ZD7ZAAAA
X-Change-ID: 20250407-rk3576-pwm-46761bd0deaa
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-iio@vger.kernel.org, kernel@collabora.com, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2

This series introduces support for some of the functions of the new PWM
silicon found on Rockchip's RK3576 SoC. Due to the wide range of
functionalities offered by it, including many parts which this series'
first iteration does not attempt to implement for now, it uses multiple
drivers hanging on a platform bus on which the parent "mfpwm" driver
registers them.

AUXBUS/MFD/PLATFORM BUS DISCUSSION: if you are currently wondering why
you were Cc'd and are about to move onto the next e-mail, it may be
because we're currently trying to figure out whether this smorgasbord of
drivers should be a MFD driver, a platform bus driver, or an auxbus
driver. It is currently implemented as a platform bus driver. Any
additional insight from people who know the conceptual place that MFD
has would be appreciated.

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
and they all get registered as platform drivers by the parent mfpwm
driver, which is the one that binds to the DT compatible. Each device
function driver then has to _acquire and _release the hardware when it
needs control of it. If some other device function is using the device
already, -EBUSY is returned, which the device function driver can then
forward to the user and everyone is happy.

The PWM output driver, pwm-rockchip-v4, uses the new waveform APIs. I
thought while writing a new driver that I might as well use the new
APIs.

The PWM capture driver, implemented as a counter driver, is somewhat
primitive, in that it doesn't make use of things like the biphasic
counter support or clock measuring, but it serves as a good way to
showcase and test the mutual exclusion that the mfpwm framework tries to
achieve. It also goes one step beyond just exposing the raw LPC/HPC
counts and actually makes them usable in a non-theoretically-racey way
by turning them into nanosecond period/duty cycle values based on the
clock's rate. Shoutouts to the counter subsystem's documentation by the
way, it is some of the best subsystem documentation I've come across so
far, and was a great help.

All instances of the PWM controller have three clocks that they can pick
and choose to derive the PWM signal from. One is the default PLL from
the CRU, one is the 24 MHz crystal oscillator (gated by the CRU), and
one is an RC oscillator (also gated by the CRU). Each PWM channel can
switch between these with a clock selection register in the PWM register
range, hence this is implemented as a clock mux.

Along the way, I also finally took the time to give us The One True
HIWORD_UPDATE macro, which aims to replace all other copies of the
HIWORD_UPDATE macro, except it's not called HIWORD_UPDATE because all of
them have slightly different semantics and I don't want to introduce
even more confusion. It does, however, do some compile-time checking of
the function-like macro parameters.

This series went through two substantial rewrites, because after I
realised it needed to be multiple drivers (first rewrite) I then first
wrote it as a couple of auxiliary bus drivers, until I became unsure
about whether this should be auxiliary bus drivers at all, so it became
a bunch of platform bus drivers instead. If anything looks like a weird
vestigial leftover in the code, then that's probably why, but I made
sure to get rid of all the ones I could find before submitting this.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
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
Nicolas Frattaroli (7):
      dt-bindings: pinctrl: rockchip: increase max amount of device functions
      dt-bindings: pwm: Add a new binding for rockchip,rk3576-pwm
      bitfield: introduce HI16_WE bitfield prep macros
      soc: rockchip: add mfpwm driver
      pwm: Add rockchip PWMv4 driver
      counter: Add rockchip-pwm-capture driver
      arm64: dts: rockchip: add PWM nodes to RK3576 SoC dtsi

 .../bindings/pinctrl/rockchip,pinctrl.yaml         |   2 +-
 .../bindings/pwm/rockchip,rk3576-pwm.yaml          |  77 ++++
 MAINTAINERS                                        |  11 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 208 +++++++++
 drivers/counter/Kconfig                            |  13 +
 drivers/counter/Makefile                           |   1 +
 drivers/counter/rockchip-pwm-capture.c             | 352 +++++++++++++++
 drivers/pwm/Kconfig                                |  13 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-rockchip-v4.c                      | 372 ++++++++++++++++
 drivers/soc/rockchip/Kconfig                       |  13 +
 drivers/soc/rockchip/Makefile                      |   1 +
 drivers/soc/rockchip/mfpwm.c                       | 398 +++++++++++++++++
 include/linux/bitfield.h                           |  47 ++
 include/soc/rockchip/mfpwm.h                       | 484 +++++++++++++++++++++
 15 files changed, 1992 insertions(+), 1 deletion(-)
---
base-commit: ba2b2250bbaf005016ba85e345add6e19116a1ea
change-id: 20250407-rk3576-pwm-46761bd0deaa

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


