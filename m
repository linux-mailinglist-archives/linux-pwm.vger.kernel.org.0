Return-Path: <linux-pwm+bounces-5377-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E375FA807C0
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7507A2204
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B36626F445;
	Tue,  8 Apr 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="WTSx/mxD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E8268FDE;
	Tue,  8 Apr 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115654; cv=pass; b=edj2N8Z0Z/kSj0hNmBK/PahW8f+/nQ1kQyXn28yIZMh12NP3v/g8DkmZcauPLuIYKkKtHqtBW/5UeWsl4leHgLCEWgLST9k63b+GqZbP72Kr+k/m6sY4H37jlZEgCh+gOMfSd9V/s9ScelSWVOqllSFq4Onlq3PGO0jbppgXktI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115654; c=relaxed/simple;
	bh=q1Al9rQVpqoNho62plFMYD1zrmfFSwYxE4HnzVpOK4k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J7j+U1VRqDurUoFsSulel0aNwEgENIYa2auwkw/zQslctNboIvFCFasrkqfgyBN73C2x4Tee+oo5jZkUoZVJDz/b13nkI0UMtb/gv4TN0Z9HffMn2ZGDV5DAWUxh9ZiYD6E6WcyyF1prPj0oFPDUnwU269eizYro2XLy8Y+x110=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=WTSx/mxD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744115617; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZYdZHsQWauVJFkK7qg6+RgBlLgyiABGPxVdHm555/dNCpsiQuHDmtJS0PGlBfLMVG+Z1toIMKsLzcFE0QVKSLOIYxN8MHEPen9GG0Wojzdv9zphwkNLliR9xBIDpZ3CU2EbnsBSYTKHeY08Fvj5O8LuFAT9KHIxnUf2ACNlOrVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744115617; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GyJGnAiLJATURszHLyZHKp4AdvagGFsBzE31iQawxg8=; 
	b=BrCl2g2+yDARhyVbUAkXOeI01yjdLv6BCvyjgfIfqbhsS75bWwWcpQPxaT6aUYZxQUssYUxlKqkmeEDtDSmAuchh45jKNOWJNmZa8KU7+6fv5h7sADigfkthL57ulQtaGUvV/dpEWli/efk9cp5jKeOjaCDrYcMZ+srpQo73pNY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744115617;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=GyJGnAiLJATURszHLyZHKp4AdvagGFsBzE31iQawxg8=;
	b=WTSx/mxDxaSj28VfD1S4FZM5AAxWO0sKE81fXFn1RNC6YLlZaLLFPXVtbdesZtRP
	NAveoxtpcFCGgRZTx9y8oqhIIUYFNJqxhVr9YmMpvsZ33voaskcUlGD8voaOPT5NJc3
	EQwQcevK4jKtqSYd1prTmBkRkntDScUWemxipBfY=
Received: by mx.zohomail.com with SMTPS id 17441156160471018.3332658311127;
	Tue, 8 Apr 2025 05:33:36 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/7] Add Rockchip RK3576 PWM Support Through MFPWM
Date: Tue, 08 Apr 2025 14:32:12 +0200
Message-Id: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEwX9WcC/yXMQQrCMBCF4auEWTuS1CaBXkW6SJNRB0lbJ7UKp
 Xc32OX34P0bFBKmAp3aQGjlwtNYYU4K4iOMd0JO1dDoxupWe5TnxXqH8ydj67wzQ9KJQoB6mIV
 u/P3Hrv1hode7NpdjhCEUwjjlzEunVnc2FiUa6Pf9BzpTEBeJAAAA
X-Change-ID: 20250407-rk3576-pwm-46761bd0deaa
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-iio@vger.kernel.org, kernel@collabora.com, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

This series introduces support for some of the functions of the new PWM
silicon found on Rockchip's RK3576 SoC. Due to the wide range of
functionalities offered by it, including many parts which this series'
first iteration does not attempt to implement for now, it uses multiple
drivers hanging on a platform bus on which the parent "mfpwm" driver
registers them.

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
tablets based on the RK3576 may need to do the power key stuff at some
stage, but I'm still not entirely clear on what that'd look like in a
schematic. The IR transmission stuff may be a funny weekend project for
someone at some point; I assume it's there so TV boxes can turn on and
off TVs without needing the HDMI control stuff.

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

Some instances of the PWM silicon allow switching between a fixed
crystal oscillator as the PWM clock, and the default PLL clock, which is
just a mux between that very same crystal oscillator and two other fixed
oscillators on RK3576. The downstream vendor driver does not implement
this feature, but I did because it seemed funny, so now there's a sysfs
interface to switch between them and it makes sure you don't
accidentally ruin any PWM user's day while switching. The potential
benefit is that this switching is per-PWM-channel, but aside from that
it doesn't seem super useful and should've probably just been some
per-channel clock muxes in the hardware's CRU instead.

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
Nicolas Frattaroli (7):
      dt-bindings: pinctrl: rockchip: increase max amount of device functions
      dt-bindings: pwm: Add a new binding for rockchip,rk3576-pwm
      soc: rockchip: add utils header for things shared across drivers
      soc: rockchip: add mfpwm driver
      pwm: Add rockchip PWMv4 driver
      counter: Add rockchip-pwm-capture driver
      arm64: dts: rockchip: add PWM nodes to RK3576 SoC dtsi

 .../bindings/pinctrl/rockchip,pinctrl.yaml         |   2 +-
 .../bindings/pwm/rockchip,rk3576-pwm.yaml          |  94 ++++
 MAINTAINERS                                        |  11 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           | 192 +++++++
 drivers/counter/Kconfig                            |  13 +
 drivers/counter/Makefile                           |   1 +
 drivers/counter/rockchip-pwm-capture.c             | 341 ++++++++++++
 drivers/pwm/Kconfig                                |  13 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-rockchip-v4.c                      | 336 ++++++++++++
 drivers/soc/rockchip/Kconfig                       |  13 +
 drivers/soc/rockchip/Makefile                      |   1 +
 drivers/soc/rockchip/mfpwm.c                       | 608 +++++++++++++++++++++
 include/soc/rockchip/mfpwm.h                       | 505 +++++++++++++++++
 include/soc/rockchip/utils.h                       |  76 +++
 15 files changed, 2206 insertions(+), 1 deletion(-)
---
base-commit: 64e9fdfc89a76fed38d8ddeed72d42ec71957ed9
change-id: 20250407-rk3576-pwm-46761bd0deaa

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


