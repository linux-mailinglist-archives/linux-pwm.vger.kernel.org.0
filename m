Return-Path: <linux-pwm+bounces-2666-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0629258F8
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B722822B6
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717F157E8B;
	Wed,  3 Jul 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="foJzSM9R"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10182142904;
	Wed,  3 Jul 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003051; cv=none; b=raZXsFvvD4ILQMylTRE6f8waMrU+FPHiYvKlL/HiXfZldruX4VeTZSLAVx+sSwpbLOQ327NmImlcaFxb6xibdMKYjolDgTWqLUSWLNGpz5SIdH+zw2hNRVkIxNr5kdUuENk1N5LjC/+yW6ksrdLzNbQOyN7MjLiNjwKHjLO2kAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003051; c=relaxed/simple;
	bh=9D0oFgRed8MuxGxSMJGRs4O77WGIRnK3b9TAv6iBcRo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dZq1Hb7A7jL/XOKmywazgwWbZu6vQsAOXUz3RMFZZRUIAt7Yb93YqxU85xdTJIHuTKFXPe3jNvZILMU5luatsNcb9gY5zUfvTRA+LDCRcBxlJPI9GaSwiS/0nUflrHr+FPZmvK8uYVGsGLva25RhuvgpW/FQmRmLYWFyDhuaeJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=foJzSM9R; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3ECA340002;
	Wed,  3 Jul 2024 10:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720003045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y9dKIY8UF+nReYR3bpF9Pb7TJp7WLPLWK/B5oYjjbq8=;
	b=foJzSM9RuZQOf/VPApRW0lmUGrQblXobu0gWcMfK3rdR7fFeSllw9HZtvDHamCZSnVeAQd
	xl3StvV0X9RM6zrGGH8rKfTVgGj2rxAQ/FXj4AoPA7jwEAAykHOnYYQdsWoKj0Z5qT9EbI
	NJSgM2y4fGFlocfqLTtmMbWZcFSesBLFVfvUvMOxSvZzRHYiHre2aVkplOJXZ8APv8zjRO
	yRmCwXsRILqubrSOViPCck2qs6VXTOpPU1Zh2pkMz/CDpauRr4KYDvJCL2P3T9WnVnXRPw
	Yp49tSFnocZKud9kw1tjEbXpKeoo3s6qbV/lMc9MWdp1PkDr10Ce8YagcplEvA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 00/20] Simplify of_property_for_each_u32()
Date: Wed, 03 Jul 2024 12:36:44 +0200
Message-Id: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALwphWYC/x3MTQqEMAxA4atI1lOI9Q+8igyltKlmY0uqw4j07
 haX3+K9GzIJU4a5uUHox5njXtF+GnCb3VdS7KtBo+5xwlbFYJLERHJcJkQxZN1mzk6rfsTgUdv
 Bo4OaJ6HA/3e9fEt5ALUFP0BqAAAA
To: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 =?utf-8?q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Cameron <jic23@kernel.org>, 
 Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Richard Leitner <richard.leitner@linux.dev>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Damien Le Moal <dlemoal@kernel.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 llvm@lists.linux.dev, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-usb@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: luca.ceresoli@bootlin.com

[Note: to reduce the noise I have trimmed the get_maintainers list
manually. Should you want to be removed, or someone else added, to future
versions, just tell me. Sorry for the noise.]

This series aims at simplifying of_property_for_each_u32() as well as
making it more difficult to misuse it in the future.

The long-term goal is changing this pattern:

  struct property *prop;
  const __be32 *p;
  u32 val;
 
  of_property_for_each_u32(np, "xyz", prop, p, val) { ... }

to this:

  u32 val;

  of_property_for_each_u32(np, "xyz", val) { ... }

So, removing the 3rd and 4th arguments which are typically meant to be
internal. Those two parameters used to be unavoidable until the kernel
moved to building with the C11 standard unconditionally. Since then, it is
now possible to get rid of them. However a few users of
of_property_for_each_u32() do actually use those arguments, which
complicates the transition. For this reason this series does the following:

 * Add of_property_for_each_u32_new(), which does not have those two
   arguments (patch 1)
 * Convert _almost_ every usage to of_property_for_each_u32_new()
 * Rename of_property_for_each_u32() to of_property_for_each_u32_old() and
   deprecate it, as a incentive to code not (yet) in mainline to upgrade
   to the *_new() version (last patch)

The plan for the next series is to additionally:

 * Convert the few remaining of_property_for_each_u32_old() instantes to
   of_property_for_each_u32_new()
 * Remove of_property_for_each_u32_old()
 * Rename of_property_for_each_u32_new() to of_property_for_each_u32()

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (20):
      of: add of_property_for_each_u32_new()
      clk: convert to of_property_for_each_u32_new()
      clk: qcom: convert to of_property_for_each_u32_new()
      clk: sunxi: clk-simple-gates: convert to of_property_for_each_u32_new()
      clk: sunxi:  clk-sun8i-bus-gates: convert to of_property_for_each_u32_new()
      clocksource/drivers/samsung_pwm: convert to of_property_for_each_u32_new()
      bus: ti-sysc: convert to of_property_for_each_u32_new()
      lk: clk-conf: convert to of_property_for_each_u32_new()
      gpio: brcmstb: convert to of_property_for_each_u32_new()
      pinctrl: s32cc: convert to of_property_for_each_u32_new()
      irqchip/atmel-aic: convert to of_property_for_each_u32_new()
      iio: adc: ti_am335x_adc: convert to of_property_for_each_u32_new()
      pwm: samsung: convert to of_property_for_each_u32_new()
      tty: sysrq: convert to of_property_for_each_u32_new()
      usb: usb251xb: convert to of_property_for_each_u32_new()
      mfd: ti_am335x_tscadc: convert to of_property_for_each_u32_new()
      ASoC: arizona: convert to of_property_for_each_u32_new()
      powerpc/xive: convert to of_property_for_each_u32_new()
      powerpc/xive: convert to of_property_for_each_u32_new()
      of: deprecate and rename of_property_for_each_u32()

 .clang-format                           |  3 ++-
 arch/powerpc/sysdev/xive/native.c       |  4 +---
 arch/powerpc/sysdev/xive/spapr.c        |  3 +--
 drivers/bus/ti-sysc.c                   |  4 +---
 drivers/clk/clk-conf.c                  |  4 +---
 drivers/clk/clk-si5351.c                |  4 ++--
 drivers/clk/clk.c                       |  6 ++----
 drivers/clk/qcom/common.c               |  4 +---
 drivers/clk/sunxi/clk-simple-gates.c    |  4 +---
 drivers/clk/sunxi/clk-sun8i-bus-gates.c |  4 +---
 drivers/clocksource/samsung_pwm_timer.c |  4 +---
 drivers/gpio/gpio-brcmstb.c             |  5 +----
 drivers/iio/adc/ti_am335x_adc.c         |  4 +---
 drivers/irqchip/irq-atmel-aic-common.c  |  4 +---
 drivers/irqchip/irq-pic32-evic.c        |  2 +-
 drivers/mfd/ti_am335x_tscadc.c          |  4 +---
 drivers/pinctrl/nxp/pinctrl-s32cc.c     |  4 +---
 drivers/pinctrl/pinctrl-k210.c          |  2 +-
 drivers/pwm/pwm-samsung.c               |  4 +---
 drivers/tty/sysrq.c                     |  4 +---
 drivers/usb/misc/usb251xb.c             |  4 +---
 include/linux/of.h                      | 14 ++++++++++----
 sound/soc/codecs/arizona.c              | 12 +++++-------
 23 files changed, 39 insertions(+), 68 deletions(-)
---
base-commit: e937d48ed96381e9620d9c81fbc1ce666f5b7358
change-id: 20240701-of_property_for_each_u32-460fd02a5d0c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


