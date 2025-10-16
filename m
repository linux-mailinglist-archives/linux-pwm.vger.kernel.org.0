Return-Path: <linux-pwm+bounces-7461-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFEABE3C05
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Oct 2025 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1471A65E64
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Oct 2025 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4E433EB13;
	Thu, 16 Oct 2025 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LxSc2W2J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15433CE9B
	for <linux-pwm@vger.kernel.org>; Thu, 16 Oct 2025 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621907; cv=none; b=CTUbQB7dK/zEPiyyWZcnhQltLwKbRIdUBaXVADUvZi5ls+pL1PWE0VjtDhE0oxuDbQNkKDg4lphxqMNPINOosCxVHMPqhx+2kT/cBoXbqlwV/FV1ItimVa4OeXipXJGwQjqHGEkn9GDVhEn96sBiaEiu10GCr26+6S5sOyRw02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621907; c=relaxed/simple;
	bh=DaaSNdZBssdNlvpEnGioDq2MRwVUQuawmXKiJ6tpHRs=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=Tzmxk9yRSoovdLRMqCGmws1C5eneEv/MWw1qkC/MiUYkCwCOKWLvp/GFtVLjbfkqdsnKF2le0g7zvkgFUe5KaxktRq9u8an2LuKXftn9YTxGounP1wTT7KXhSJY7Wcp+Wg3PszYtmY16Swj1ojJplFz85FjqcvsA8pNRbnwN4wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LxSc2W2J; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251016133821euoutp0231e4f6604003c167d60cc54b5b0cea22~u-Ep-BMke2421324213euoutp02J
	for <linux-pwm@vger.kernel.org>; Thu, 16 Oct 2025 13:38:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251016133821euoutp0231e4f6604003c167d60cc54b5b0cea22~u-Ep-BMke2421324213euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760621901;
	bh=DFcfKx6LySy0A3CKtvTtD6mL3nEVKq4pg5VQREl8CRg=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=LxSc2W2JiKHK3CaeD2UaaWxiCJwwIReoUcMlG/Q2Gg+P9AxEAN38nZjIMGhRbzuAc
	 mXEwvxSMVjhtBQh+jxOqpmuhf0FgD7yCa/gZhgtMKdafBqSkx6X5h2ZC7r2vcUGsG8
	 2ObMvRAHIzZDECq3o6X4wnFVFcHvEsEzVk9+1ZiA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251016133820eucas1p22e2bdea1b06f92978be453fb64475f84~u-EpJP8M32786527865eucas1p2i;
	Thu, 16 Oct 2025 13:38:20 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251016133819eusmtip245a9cbb952d45a738d348ccb819abbb2~u-EoCg71O1688716887eusmtip2Q;
	Thu, 16 Oct 2025 13:38:19 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 16 Oct 2025 15:38:04 +0200
Subject: [PATCH v16 4/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rust-next-pwm-working-fan-for-sending-v16-4-a5df2405d2bd@samsung.com>
In-Reply-To: <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
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
	Daniel Almeida <daniel.almeida@collabora.com>,  Benno Lossin
	<lossin@kernel.org>, Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Elle Rhumsaa <elle@weathered-steel.dev>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20251016133820eucas1p22e2bdea1b06f92978be453fb64475f84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251016133820eucas1p22e2bdea1b06f92978be453fb64475f84
X-EPHeader: CA
X-CMS-RootMailID: 20251016133820eucas1p22e2bdea1b06f92978be453fb64475f84
References: <20251016-rust-next-pwm-working-fan-for-sending-v16-0-a5df2405d2bd@samsung.com>
	<CGME20251016133820eucas1p22e2bdea1b06f92978be453fb64475f84@eucas1p2.samsung.com>

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
blocks, except for the Send and Sync implementations for the driver
data, which are explained in the comments.

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS               |   1 +
 drivers/pwm/Kconfig       |  11 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm_th1520.rs | 378 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 391 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b01a016373c85fb1879e8948cedfc4e2ebc3915f..b4ca6192091bd31573c391b9b5dc29b74c9a684c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22189,6 +22189,7 @@ F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
 F:	drivers/power/reset/th1520-aon-reboot.c
 F:	drivers/power/sequencing/pwrseq-thead-gpu.c
+F:	drivers/pwm/pwm_th1520.rs
 F:	drivers/reset/reset-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index d87c4521268c18e1d11ced8c8c72ec79abc67b22..0b47456e2d57bbdda54b1318911994812e315612 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -748,6 +748,17 @@ config PWM_TEGRA
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
index dfa8b4966ee19af18ea47080db4adf96c326f3d7..aed403f0a42b339778c37150007635d7efccfd51 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
+obj-$(CONFIG_PWM_TH1520)	+= pwm_th1520.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
new file mode 100644
index 0000000000000000000000000000000000000000..0ad38b78be854ab3c10268fb20763d9962f59c0f
--- /dev/null
+++ b/drivers/pwm/pwm_th1520.rs
@@ -0,0 +1,378 @@
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
+    // TODO: Replace with a kernel helper like `mul_u64_u64_div_u64_roundup`
+    // once available in Rust.
+    let numerator = cycles
+        .saturating_mul(NSEC_PER_SEC_U64)
+        .saturating_add(rate_hz - 1);
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
+    type WfHw = Th1520WfHw;
+
+    fn round_waveform_tohw(
+        chip: &pwm::Chip<Self>,
+        _pwm: &pwm::Device,
+        wf: &pwm::Waveform,
+    ) -> Result<pwm::RoundedWaveform<Self::WfHw>> {
+        let data = chip.drvdata();
+        let mut status = 0;
+
+        if wf.period_length_ns == 0 {
+            dev_dbg!(chip.device(), "Requested period is 0, disabling PWM.\n");
+
+            return Ok(pwm::RoundedWaveform {
+                status: 0,
+                hardware_waveform: Th1520WfHw {
+                    enabled: false,
+                    ..Default::default()
+                },
+            });
+        }
+
+        let rate_hz = data.clk.rate().as_hz() as u64;
+
+        let mut period_cycles = ns_to_cycles(wf.period_length_ns, rate_hz).min(u64::from(u32::MAX));
+
+        if period_cycles == 0 {
+            dev_dbg!(
+                chip.device(),
+                "Requested period {} ns is too small for clock rate {} Hz, rounding up.\n",
+                wf.period_length_ns,
+                rate_hz
+            );
+
+            period_cycles = 1;
+            status = 1;
+        }
+
+        let mut duty_cycles = ns_to_cycles(wf.duty_length_ns, rate_hz).min(u64::from(u32::MAX));
+
+        let mut ctrl_val = TH1520_PWM_CONTINUOUS_MODE;
+
+        let is_inversed = wf.duty_length_ns > 0
+            && wf.duty_offset_ns > 0
+            && wf.duty_offset_ns >= wf.period_length_ns.saturating_sub(wf.duty_length_ns);
+        if is_inversed {
+            duty_cycles = period_cycles - duty_cycles;
+        } else {
+            ctrl_val |= TH1520_PWM_FPOUT;
+        }
+
+        let wfhw = Th1520WfHw {
+            // The cast is safe because the value was clamped with `.min(u64::from(u32::MAX))`.
+            period_cycles: period_cycles as u32,
+            duty_cycles: duty_cycles as u32,
+            ctrl_val,
+            enabled: true,
+        };
+
+        dev_dbg!(
+            chip.device(),
+            "Requested: {}/{} ns [+{} ns] -> HW: {}/{} cycles, ctrl 0x{:x}, rate {} Hz\n",
+            wf.duty_length_ns,
+            wf.period_length_ns,
+            wf.duty_offset_ns,
+            wfhw.duty_cycles,
+            wfhw.period_cycles,
+            wfhw.ctrl_val,
+            rate_hz
+        );
+
+        Ok(pwm::RoundedWaveform {
+            status: status,
+            hardware_waveform: wfhw,
+        })
+    }
+
+    fn round_waveform_fromhw(
+        chip: &pwm::Chip<Self>,
+        _pwm: &pwm::Device,
+        wfhw: &Self::WfHw,
+        wf: &mut pwm::Waveform,
+    ) -> Result {
+        let data = chip.drvdata();
+        let rate_hz = data.clk.rate().as_hz() as u64;
+
+        if wfhw.period_cycles == 0 {
+            dev_dbg!(chip.device(), "HW state has zero period, reporting as disabled.\n");
+            *wf = pwm::Waveform::default();
+            return Ok(());
+        }
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
+        Ok(())
+    }
+
+    fn read_waveform(
+        chip: &pwm::Chip<Self>,
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
+        chip: &pwm::Chip<Self>,
+        pwm: &pwm::Device,
+        wfhw: &Self::WfHw,
+        parent_dev: &Device<Bound>,
+    ) -> Result {
+        let data = chip.drvdata();
+        let hwpwm = pwm.hwpwm();
+        let iomem_accessor = data.iomem.access(parent_dev)?;
+        let iomap = iomem_accessor.deref();
+        let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
+        let was_enabled = duty_cycles != 0;
+
+        if !wfhw.enabled {
+            dev_dbg!(chip.device(), "PWM-{}: Disabling channel.\n", hwpwm);
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
+            "PWM-{}: Wrote {}/{} cycles",
+            hwpwm,
+            wfhw.duty_cycles,
+            wfhw.period_cycles,
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
+        let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
+
+        let clk = Clk::get(dev, None)?;
+
+        clk.prepare_enable()?;
+
+        // TODO: Get exclusive ownership of the clock to prevent rate changes.
+        // The Rust equivalent of `clk_rate_exclusive_get()` is not yet available.
+        // This should be updated once it is implemented.
+        let rate_hz = clk.rate().as_hz();
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
+            return Err(EINVAL);
+        }
+
+        let chip = pwm::Chip::new(
+            dev,
+            TH1520_MAX_PWM_NUM,
+            try_pin_init!(Th1520PwmDriverData {
+                iomem <- request.iomap_sized::<TH1520_PWM_REG_SIZE>(),
+                clk <- clk,
+            }),
+        )?;
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


