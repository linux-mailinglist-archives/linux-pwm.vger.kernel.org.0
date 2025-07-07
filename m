Return-Path: <linux-pwm+bounces-6755-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F2AFB03A
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D681AA3ADD
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 09:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF7293C4B;
	Mon,  7 Jul 2025 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RJGbFE3a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A139293C59
	for <linux-pwm@vger.kernel.org>; Mon,  7 Jul 2025 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881777; cv=none; b=bGLnZLb6Ay7p8BibRKYIi20vxOCy2SR1fpWUjCNzVF5Oin+o//9H8pfl1z2Hrufmbektcqh2MmgBwX16YJmm399etBnT1S5Q6q/T+VjGJzOr2kPs5cCphUnlZKRpY8FveWTrjmw1GySEdfLjshtOMEiMandPLm/LA39wTJRXD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881777; c=relaxed/simple;
	bh=Tv6Cbn/FbKwxobWwkBd/VWp5StuK5NT8N3mYJIebp7I=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=rShfVap6P3XnI32Bo5wpRjSnFPcmU1/29hJlOAeI/EX0FtGCpJJBzc/GykDtNBKi8Ur8RmjZHt6n712R0niogq2LtOcRdfX2FxN0cKkVTGfa0oPJpxOoRgsbUge0osrwhXmYyvh2Qce0YX1xV0xMN9SNDnUHLxHcsajVt/4E/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RJGbFE3a; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250707094932euoutp023273afb7006adb44535c496d51cec0ac~P7zDCZYcd1590715907euoutp02O
	for <linux-pwm@vger.kernel.org>; Mon,  7 Jul 2025 09:49:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250707094932euoutp023273afb7006adb44535c496d51cec0ac~P7zDCZYcd1590715907euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751881772;
	bh=AwH+R4J2WpPQ4XtK7U2jFB042x9gyyoJ+e/JJPuFswo=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=RJGbFE3auyUXf+HemWvxAsPkod1QTSZ9YvrXWrhSY7yieOpveammTviNsH/ZAzy4k
	 h2iuRBiVD36yljTYBm4rO0hA/CakeCStUI+JBO5OF8PseYPpQlRJfPmhBHITTsMUTm
	 3hBZiSVUKpmLCJbeM6wHeOVQZ8M7RRq4gTaWEHyc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250707094932eucas1p13a9a26fd50a868c3212802a9bf8cb585~P7zCaTkfx0971309713eucas1p1a;
	Mon,  7 Jul 2025 09:49:32 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250707094930eusmtip1e7d27c3051f75c0f74b80fe993796f39~P7zBWjbNU0726807268eusmtip1U;
	Mon,  7 Jul 2025 09:49:30 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 07 Jul 2025 11:48:32 +0200
Subject: [PATCH v10 4/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-rust-next-pwm-working-fan-for-sending-v10-4-d0c5cf342004@samsung.com>
In-Reply-To: <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>,  Benno Lossin <lossin@kernel.org>,  Michael
	Turquette <mturquette@baylibre.com>,  Drew Fustini <fustini@kernel.org>,
	Benno Lossin <lossin@kernel.org>,  Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250707094932eucas1p13a9a26fd50a868c3212802a9bf8cb585
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250707094932eucas1p13a9a26fd50a868c3212802a9bf8cb585
X-EPHeader: CA
X-CMS-RootMailID: 20250707094932eucas1p13a9a26fd50a868c3212802a9bf8cb585
References: <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
	<CGME20250707094932eucas1p13a9a26fd50a868c3212802a9bf8cb585@eucas1p1.samsung.com>

Introduce a PWM driver for the T-HEAD TH1520 SoC, written in Rust and
utilizing the safe PWM abstractions from the preceding commit.

The driver implements the pwm::PwmOps trait using the modern waveform
API (round_waveform_tohw, write_waveform, etc.) to support configuration
of period, duty cycle, and polarity for the TH1520's PWM channels.

Resource management is handled using idiomatic Rust patterns. The PWM
chip object is allocated via pwm::Chip::new and its registration with
the PWM core is managed by the pwm::Registration RAII guard. This
ensures pwmchip_remove is always called when the driver unbinds,
preventing resource leaks. Device managed resources are used for the
MMIO region, and the clock lifecycle is correctly managed in the
driver's private data Drop implementation.

The driver's core logic is written entirely in safe Rust, with no unsafe
blocks.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS               |   1 +
 drivers/pwm/Kconfig       |  11 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm_th1520.rs | 352 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 365 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 494de42ca8c36b30d80e14b03d3c9e0e054fb267..2449178a6d7b83b5202f8209c0b38e8302bc6b15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21531,6 +21531,7 @@ F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
 F:	drivers/power/sequencing/pwrseq-thead-gpu.c
+F:	drivers/pwm/pwm_th1520.rs
 F:	drivers/reset/reset-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index c32655566d6ab9eff9d10f29e469f9aef89cecfa..02faf93600b6464d3c02495eeb5824ea541cff35 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -728,6 +728,17 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
+config PWM_TH1520
+	tristate "TH1520 PWM support"
+	depends on RUST
+	select RUST_PWM_ABSTRACTIONS
+	help
+	  This option enables the driver for the PWM controller found on the
+	  T-HEAD TH1520 SoC.
+
+	  To compile this driver as a module, choose M here; the module
+	  will be called pwm-th1520. If you are unsure, say N.
+
 config PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index ff4f47e5fb7a0dbac72c12de82c3773e5582db6d..5c15c95c6e49143969389198657eed0ecf4086b2 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
+obj-$(CONFIG_PWM_TH1520)	+= pwm_th1520.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
new file mode 100644
index 0000000000000000000000000000000000000000..c6cd90552cc57219cd393e1c867dfbf5587cee00
--- /dev/null
+++ b/drivers/pwm/pwm_th1520.rs
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Samsung Electronics Co., Ltd.
+// Author: Michal Wilczynski <m.wilczynski@samsung.com>
+
+//! Rust T-HEAD TH1520 PWM driver
+//!
+//! Limitations:
+//! - The period and duty cycle are controlled by 32-bit hardware registers,
+//!   limiting the maximum resolution.
+//! - The driver supports continuous output mode only; one-shot mode is not
+//!   implemented.
+//! - The controller hardware provides up to 6 PWM channels.
+//! - Reconfiguration is glitch free - new period and duty cycle values are
+//!   latched and take effect at the start of the next period.
+//! - Polarity is handled via a simple hardware inversion bit; arbitrary
+//!   duty cycle offsets are not supported.
+//! - Disabling a channel is achieved by configuring its duty cycle to zero to
+//!   produce a static low output. Clearing the `start` does not reliably
+//!   force the static inactive level defined by the `INACTOUT` bit. Hence
+//!   this method is not used in this driver.
+//!
+
+use core::ops::Deref;
+use kernel::{
+    c_str,
+    clk::Clk,
+    device::{Bound, Core, Device},
+    devres,
+    io::mem::IoMem,
+    of, platform,
+    prelude::*,
+    pwm, time,
+};
+
+const TH1520_MAX_PWM_NUM: u32 = 6;
+
+// Register offsets
+const fn th1520_pwm_chn_base(n: u32) -> usize {
+    (n * 0x20) as usize
+}
+
+const fn th1520_pwm_ctrl(n: u32) -> usize {
+    th1520_pwm_chn_base(n)
+}
+
+const fn th1520_pwm_per(n: u32) -> usize {
+    th1520_pwm_chn_base(n) + 0x08
+}
+
+const fn th1520_pwm_fp(n: u32) -> usize {
+    th1520_pwm_chn_base(n) + 0x0c
+}
+
+// Control register bits
+const TH1520_PWM_START: u32 = 1 << 0;
+const TH1520_PWM_CFG_UPDATE: u32 = 1 << 2;
+const TH1520_PWM_CONTINUOUS_MODE: u32 = 1 << 5;
+const TH1520_PWM_FPOUT: u32 = 1 << 8;
+
+const TH1520_PWM_REG_SIZE: usize = 0xB0;
+
+fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
+    const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
+
+    (match ns.checked_mul(rate_hz) {
+        Some(product) => product,
+        None => u64::MAX,
+    }) / NSEC_PER_SEC_U64
+}
+
+fn cycles_to_ns(cycles: u64, rate_hz: u64) -> u64 {
+    const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
+
+    // Round up
+    let Some(numerator) = cycles
+        .checked_mul(NSEC_PER_SEC_U64)
+        .and_then(|p| p.checked_add(rate_hz - 1))
+    else {
+        return u64::MAX;
+    };
+
+    numerator / rate_hz
+}
+
+/// Hardware-specific waveform representation for TH1520.
+#[derive(Copy, Clone, Debug, Default)]
+struct Th1520WfHw {
+    period_cycles: u32,
+    duty_cycles: u32,
+    ctrl_val: u32,
+    enabled: bool,
+}
+
+/// The driver's private data struct. It holds all necessary devres managed resources.
+#[pin_data(PinnedDrop)]
+struct Th1520PwmDriverData {
+    #[pin]
+    iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
+    clk: Clk,
+}
+
+// This `unsafe` implementation is a temporary necessity because the underlying `kernel::clk::Clk`
+// type does not yet expose `Send` and `Sync` implementations. This block should be removed
+// as soon as the clock abstraction provides these guarantees directly.
+// TODO: Remove those unsafe impl's when Clk will support them itself.
+
+// SAFETY: The `devres` framework requires the driver's private data to be `Send` and `Sync`.
+// We can guarantee this because the PWM core synchronizes all callbacks, preventing concurrent
+// access to the contained `iomem` and `clk` resources.
+unsafe impl Send for Th1520PwmDriverData {}
+
+// SAFETY: The same reasoning applies as for `Send`. The PWM core's synchronization
+// guarantees that it is safe for multiple threads to have shared access (`&self`)
+// to the driver data during callbacks.
+unsafe impl Sync for Th1520PwmDriverData {}
+
+impl pwm::PwmOps for Th1520PwmDriverData {
+    type DrvData = Pin<KBox<Th1520PwmDriverData>>;
+    type WfHw = Th1520WfHw;
+
+    fn round_waveform_tohw(
+        chip: &pwm::Chip<Self::DrvData>,
+        _pwm: &pwm::Device,
+        wf: &pwm::Waveform,
+    ) -> Result<(c_int, Self::WfHw)> {
+        let data = chip.drvdata();
+
+        if wf.period_length_ns == 0 {
+            return Ok((
+                0,
+                Th1520WfHw {
+                    enabled: false,
+                    ..Default::default()
+                },
+            ));
+        }
+
+        let rate_hz = data.clk.rate().as_hz() as u64;
+
+        let period_cycles = ns_to_cycles(wf.period_length_ns, rate_hz).min(u64::from(u32::MAX));
+        let mut duty_cycles = ns_to_cycles(wf.duty_length_ns, rate_hz).min(u64::from(u32::MAX));
+
+        let mut ctrl_val = TH1520_PWM_CONTINUOUS_MODE;
+
+        let is_inversed = wf.duty_length_ns > 0
+            && wf.duty_offset_ns > 0
+            && wf.duty_length_ns + wf.duty_offset_ns >= wf.period_length_ns;
+        if is_inversed {
+            duty_cycles = period_cycles - duty_cycles;
+        } else {
+            ctrl_val |= TH1520_PWM_FPOUT;
+        }
+
+        let wfhw = Th1520WfHw {
+            period_cycles: period_cycles as u32,
+            duty_cycles: duty_cycles as u32,
+            ctrl_val,
+            enabled: true,
+        };
+
+        dev_dbg!(
+            chip.device(),
+            "clk_rate: {}Hz Requested: period {}ns, duty {}ns, offset {}ns -> HW: period {} cyc, duty {} cyc, ctrl 0x{:x}\n",
+            rate_hz,
+            wf.period_length_ns,
+            wf.duty_length_ns,
+            wf.duty_offset_ns,
+            wfhw.period_cycles,
+            wfhw.duty_cycles,
+            wfhw.ctrl_val
+        );
+
+        Ok((0, wfhw))
+    }
+
+    fn round_waveform_fromhw(
+        chip: &pwm::Chip<Self::DrvData>,
+        _pwm: &pwm::Device,
+        wfhw: &Self::WfHw,
+        wf: &mut pwm::Waveform,
+    ) -> Result<c_int> {
+        let data = chip.drvdata();
+        let rate_hz = data.clk.rate().as_hz() as u64;
+
+        wf.period_length_ns = cycles_to_ns(u64::from(wfhw.period_cycles), rate_hz);
+
+        let duty_cycles = u64::from(wfhw.duty_cycles);
+
+        if (wfhw.ctrl_val & TH1520_PWM_FPOUT) != 0 {
+            wf.duty_length_ns = cycles_to_ns(duty_cycles, rate_hz);
+            wf.duty_offset_ns = 0;
+        } else {
+            let period_cycles = u64::from(wfhw.period_cycles);
+            let original_duty_cycles = period_cycles.saturating_sub(duty_cycles);
+
+            // For an inverted signal, `duty_length_ns` is the high time (period - low_time).
+            wf.duty_length_ns = cycles_to_ns(original_duty_cycles, rate_hz);
+            // The offset is the initial low time, which is what the hardware register provides.
+            wf.duty_offset_ns = cycles_to_ns(duty_cycles, rate_hz);
+        }
+
+        Ok(0)
+    }
+
+    fn read_waveform(
+        chip: &pwm::Chip<Self::DrvData>,
+        pwm: &pwm::Device,
+        parent_dev: &Device<Bound>,
+    ) -> Result<Self::WfHw> {
+        let data = chip.drvdata();
+        let hwpwm = pwm.hwpwm();
+        let iomem_accessor = data.iomem.access(parent_dev)?;
+        let iomap = iomem_accessor.deref();
+
+        let ctrl = iomap.try_read32(th1520_pwm_ctrl(hwpwm))?;
+        let period_cycles = iomap.try_read32(th1520_pwm_per(hwpwm))?;
+        let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
+
+        let wfhw = Th1520WfHw {
+            period_cycles,
+            duty_cycles,
+            ctrl_val: ctrl,
+            enabled: duty_cycles != 0,
+        };
+
+        dev_dbg!(
+            chip.device(),
+            "PWM-{}: read_waveform: Read hw state - period: {}, duty: {}, ctrl: 0x{:x}, enabled: {}",
+            hwpwm,
+            wfhw.period_cycles,
+            wfhw.duty_cycles,
+            wfhw.ctrl_val,
+            wfhw.enabled
+        );
+
+        Ok(wfhw)
+    }
+
+    fn write_waveform(
+        chip: &pwm::Chip<Self::DrvData>,
+        pwm: &pwm::Device,
+        wfhw: &Self::WfHw,
+        parent_dev: &Device<Bound>,
+    ) -> Result {
+        let data = chip.drvdata();
+        let hwpwm = pwm.hwpwm();
+        let iomem_accessor = data.iomem.access(parent_dev)?;
+        let iomap = iomem_accessor.deref();
+        let was_enabled = pwm.state().enabled();
+
+        if !wfhw.enabled {
+            if was_enabled {
+                iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
+                iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
+                iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
+            }
+            return Ok(());
+        }
+
+        iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
+        iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
+        iomap.try_write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm))?;
+        iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
+
+        // The `TH1520_PWM_START` bit must be written in a separate, final transaction, and
+        // only when enabling the channel from a disabled state.
+        if !was_enabled {
+            iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_START, th1520_pwm_ctrl(hwpwm))?;
+        }
+
+        dev_dbg!(
+            chip.device(),
+            "PWM-{}: Wrote (per: {}, duty: {})",
+            hwpwm,
+            wfhw.period_cycles,
+            wfhw.duty_cycles,
+        );
+
+        Ok(())
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for Th1520PwmDriverData {
+    fn drop(self: Pin<&mut Self>) {
+        self.clk.disable_unprepare();
+    }
+}
+
+struct Th1520PwmPlatformDriver;
+
+kernel::of_device_table!(
+    OF_TABLE,
+    MODULE_OF_TABLE,
+    <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
+    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
+);
+
+impl platform::Driver for Th1520PwmPlatformDriver {
+    type IdInfo = ();
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe(
+        pdev: &platform::Device<Core>,
+        _id_info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
+        let dev = pdev.as_ref();
+        let resource = pdev.resource(0).ok_or(ENODEV)?;
+
+        let drvdata = KBox::pin_init(
+            try_pin_init!(Th1520PwmDriverData {
+                iomem <- pdev.ioremap_resource_sized::<TH1520_PWM_REG_SIZE>(resource),
+                clk <- Clk::get(dev, None),
+            }),
+            GFP_KERNEL,
+        )?;
+
+        drvdata.clk.prepare_enable()?;
+
+        // TODO: Get exclusive ownership of the clock to prevent rate changes.
+        // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
+        // This should be updated once it is implemented.
+        let rate_hz = drvdata.clk.rate().as_hz();
+        if rate_hz == 0 {
+            dev_err!(dev, "Clock rate is zero\n");
+            return Err(EINVAL);
+        }
+
+        if rate_hz > time::NSEC_PER_SEC as usize {
+            dev_err!(
+                dev,
+                "Clock rate {} Hz is too high, not supported.\n",
+                rate_hz
+            );
+            return Err(ERANGE);
+        }
+
+        let chip = pwm::Chip::new::<Th1520PwmDriverData>(dev, TH1520_MAX_PWM_NUM, 0, drvdata)?;
+
+        pwm::Registration::register(dev, chip)?;
+
+        Ok(KBox::new(Th1520PwmPlatformDriver, GFP_KERNEL)?.into())
+    }
+}
+
+kernel::module_platform_driver! {
+    type: Th1520PwmPlatformDriver,
+    name: "pwm-th1520",
+    authors: ["Michal Wilczynski <m.wilczynski@samsung.com>"],
+    description: "T-HEAD TH1520 PWM driver",
+    license: "GPL v2",
+}

-- 
2.34.1


