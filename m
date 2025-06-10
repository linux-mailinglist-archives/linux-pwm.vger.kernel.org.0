Return-Path: <linux-pwm+bounces-6276-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194EEAD37E7
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 15:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7351883C1D
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A12C2ABF;
	Tue, 10 Jun 2025 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SxCZlUF6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9772C178D
	for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560016; cv=none; b=gC0qXXg8ewOk4pQgAVX7O78oxMPII1o71UyGdNLefyGQjLLDgMSlOxBFahu5Y9LHVDooXTJWYvZQQW2kcZqpUByvqRnWDxYbeg3/m4cn2g+1yUtV4lE/IBtZvmuy+nSfd533CSIu3V5KMnDtzvmSueYRIrjn2Az9ZS5Ti0iWsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560016; c=relaxed/simple;
	bh=z3tFrj8Is0tlWbTaR1dFYf5Wzkb8JI4zk00/9zhEqyw=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type:
	 References; b=LTs232vdDjgpsFbHmnCrIFiioteWJpz3JtG0K4qB6BRnpMax3LWsVqN+Y0sb1Xiyacs8Kz7HuD/mtTnWYIOqP6i/vbjkMvl+2QydEIqK1Qb3QiGjULw52+050qOhPUTc+ngEd6K5WvDAzDB28Dba8vfbVhsAnuX0Ec06dY+USfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SxCZlUF6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250610125331euoutp015f0f4559646c84079ec71e3ea681ca5e~Hr4_L79wF1190611906euoutp01P
	for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 12:53:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250610125331euoutp015f0f4559646c84079ec71e3ea681ca5e~Hr4_L79wF1190611906euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749560011;
	bh=5jkDNM40mTwv8+zOl9nXA5sZSf4SwXnlr2AR06+Yrkk=;
	h=From:Subject:Date:To:Cc:References:From;
	b=SxCZlUF6Pus0tzUWSzcbnLT6zzJs4rPkcbAyXs5fM+I+6JgLyVEBi5jcBzXxRG5v7
	 LlaGrZCuYh6sdHntHf5TVNQDDc+dtJ5Ag1UUEFU8dPkPYMp7BsnThM8mQkwsCGjA34
	 +z5CYiwfBZHbxh6qB3wgifAa2CbJq3z0hBcSKgI4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9~Hr49nKOym1183211832eucas1p24;
	Tue, 10 Jun 2025 12:53:30 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250610125329eusmtip1ff1aeefd8b667cc1406dd4f764a5c237~Hr48aYX0q0363103631eusmtip1N;
	Tue, 10 Jun 2025 12:53:29 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v2 0/7] Rust Abstractions for PWM subsystem with TH1520 PWM
 driver
Date: Tue, 10 Jun 2025 14:52:48 +0200
Message-Id: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKAqSGgC/5XNTQ6CMBCG4auQWTumrTQGV97DsCi0hcbQmhn+D
	OHuFm7g8v0W37MBOwqO4VFsQG4OHFLMoS4FtL2JncNgc4MSSgutSqSJR4xuHfGzDLgkeofYoTc
	RfSJkF+3RWitjlZWNrG6Qvz7kfFhP51Xn7gOPib4nO8tj/VeYJQpsbEa0qErv7082A0+xu7Zpg
	Hrf9x+Baqxm3AAAAA==
X-Change-ID: 20250524-rust-next-pwm-working-fan-for-sending-552ad2d1b193
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>,  Guo
	Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Paul Walmsley <paul.walmsley@sifive.com>,  Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,  Alexandre
	Ghiti <alex@ghiti.fr>,  Marek Szyprowski <m.szyprowski@samsung.com>,  Benno
	Lossin <lossin@kernel.org>,  Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9
X-EPHeader: CA
X-CMS-RootMailID: 20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9
References: <CGME20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9@eucas1p2.samsung.com>

This patch series introduces Rust support for the T-HEAD TH1520 PWM
controller and demonstrates its use for fan control on the Sipeed Lichee
Pi 4A board.

The primary goal of this patch series is to introduce a basic set of
Rust abstractions for the Linux PWM subsystem. As a first user and
practical demonstration of these abstractions, the series also provides
a functional PWM driver for the T-HEAD TH1520 SoC. This allows control
of its PWM channels and ultimately enables temperature controlled fan
support for the Lichee Pi 4A board. This work aims to explore the use of
Rust for PWM drivers and lay a foundation for potential future
Rust based PWM drivers.

The core of this series is a new rust/kernel/pwm.rs module that provides
abstractions for writing PWM chip provider drivers in Rust. This has
been significantly reworked from v1 based on extensive feedback. The key
features of the new abstraction layer include:

 - Ownership and Lifetime Management: The pwm::Chip wrapper is managed
   by ARef, correctly tying its lifetime to its embedded struct device
   reference counter. Chip registration is handled by a pwm::Registration
   RAII guard, which guarantees that pwmchip_add is always paired with
   pwmchip_remove, preventing resource leaks.

 - Modern and Safe API: The PwmOps trait is now based on the modern
   waveform API (round_waveform_tohw, write_waveform, etc.) as recommended
   by the subsystem maintainer. It is generic over a driver's
   hardware specific data structure, moving all unsafe serialization logic
   into the abstraction layer and allowing drivers to be written in 100%
   safe Rust.

 - Ergonomics: The API provides safe, idiomatic wrappers for other PWM
   types (State, Args, Device, etc.) and uses standard kernel error
   handling patterns.

The series is structured as follows:
 - Rust PWM Abstractions: The new safe abstraction layer.
 - TH1520 PWM Driver: A new Rust driver for the TH1520 SoC, built on
   top of the new abstractions.
 - Clock Fix: A necessary fix to the TH1520 clock driver to ensure bus
   clocks remain enabled.
 - Device Tree Bindings & Nodes: The remaining patches add the necessary
   DT bindings and nodes for the TH1520 PWM controller, a thermal
   sensor, and the PWM fan configuration for the Lichee Pi 4A board.

Testing:
Tested on the TH1520 SoC. The fan works correctly. The duty/period
calculaties are correct. Fan starts slow when the chip is not hot and
gradually increases the speed when PVT reports higher temperatures.

The patches are based on mainline, with some dependencies which are not
merged yet - platform Io support [1] and math wrapper [2].

Reference repository with all the patches together can be found on
github [3].

[1] - https://lore.kernel.org/rust-for-linux/20250509-topics-tyr-platform_iomem-v8-0-e9f1725a40da@collabora.com/
[2] - https://lore.kernel.org/all/20250609-math-rust-v1-v1-1-285fac00031f@samsung.com/
[3] - https://github.com/mwilczy/linux/commits/rust-next-pwm-working-fan-for-sending-v4

---
Changes in v2:
 - Reworked the PWM abstraction layer based on extensive feedback.
 - Replaced initial devm allocation with a proper ARef<Chip> lifetime model
   using AlwaysRefCounted.
 - Implemented a Registration RAII guard to ensure safe chip add/remove.
 - Migrated the PwmOps trait from the legacy .apply callback to the modern
   waveform API.
 - Refactored the TH1520 driver to use the new, safer abstractions.
 - Added a patch to mark essential bus clocks as CLK_IGNORE_UNUSED to fix
   boot hangs when the PWM and thermal sensors are enabled.
- Link to v1: https://lore.kernel.org/r/20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com

---
Michal Wilczynski (7):
      rust: Add basic PWM abstractions
      pwm: Add Rust driver for T-HEAD TH1520 SoC
      clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED
      dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM controller
      riscv: dts: thead: Add PWM controller node
      riscv: dts: thead: Add PVT node
      riscv: dts: thead: Add PWM fan and thermal control

 .../devicetree/bindings/pwm/thead,th1520-pwm.yaml  |  48 ++
 MAINTAINERS                                        |   8 +
 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts  |  67 ++
 arch/riscv/boot/dts/thead/th1520.dtsi              |  18 +
 drivers/clk/thead/clk-th1520-ap.c                  |   5 +-
 drivers/pwm/Kconfig                                |  23 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm_th1520.rs                          | 287 +++++++
 rust/bindings/bindings_helper.h                    |   1 +
 rust/helpers/helpers.c                             |   1 +
 rust/helpers/pwm.c                                 |  20 +
 rust/kernel/lib.rs                                 |   2 +
 rust/kernel/pwm.rs                                 | 864 +++++++++++++++++++++
 13 files changed, 1343 insertions(+), 2 deletions(-)
---
base-commit: f153d0d0221f9d3d31872c934800d271ae8a3767
change-id: 20250524-rust-next-pwm-working-fan-for-sending-552ad2d1b193

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>


