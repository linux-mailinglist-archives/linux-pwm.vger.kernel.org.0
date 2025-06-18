Return-Path: <linux-pwm+bounces-6426-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44357ADEC76
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECCF1BC2B0C
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 12:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4312EBDCB;
	Wed, 18 Jun 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PQo2yp+E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4252EA489
	for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249696; cv=none; b=cIag7a6pB74OxpPNRsm7sKoDn5zjoyf7oewxExIi67KY5L4PqoQDVVxh4s+008/QBvRGp8t1+32VNqE+37XlHrMIuYRHwk0MVG6LsB8azCejf7Wsd5QxmybHrimHASvJGHrTZxA90Vi3PO3QbC1JVY7Oe4qmTuoRrWynIIrg/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249696; c=relaxed/simple;
	bh=2J3fdQWRwmrtJXWGIXmqAXAXo4xZNN4zP7Eu8KY4vFU=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=SsJSY+t7EW8wYL9W0JBh9hE+25g/bbAq9AFN0hm+2BJGqiphqQiMPwbBD9hwTCTZS9lRYHfU5JTIjSzN0+gO4q1QD8p6ppNhc1drYIaNBDT1CL9cNA0wPkVWR54BhrndMVgKlW0/c91JXHGkryn/tKpE2gCRF+vikTFhS2suapo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PQo2yp+E; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250618122807euoutp02b8a4dc5144724d84b94f3e6ccf13b6e4~KItFcxl-x0449804498euoutp02a
	for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 12:28:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250618122807euoutp02b8a4dc5144724d84b94f3e6ccf13b6e4~KItFcxl-x0449804498euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750249687;
	bh=PdjK9XKTxqOYAR/gz0lDXuP6C5zGsULYQFzyG5CAR0M=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=PQo2yp+Enk9cj8wWwxs2kHcvO5RtwmPL/WMz66l4hw8BOd83EeNdfFMwp2GuOSdZb
	 2WBelcL7jJpvkex6+r9tMeD3/0dhVeyZKstVmuXTtdScgO46uYutpwARIfOrka/NZX
	 Px3BPm9tod9+DKON5kBaP4RsT0Ee56VOX+2fPNdo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250618122807eucas1p22d41cd6a9ac5131d91d41dfb09b8c92a~KItExCep52282022820eucas1p2P;
	Wed, 18 Jun 2025 12:28:07 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250618122805eusmtip1b2b0b6c214944387b870905796a5d64b~KItDnRM6_2180621806eusmtip1-;
	Wed, 18 Jun 2025 12:28:05 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 18 Jun 2025 14:27:37 +0200
Subject: [PATCH v4 4/9] pwm: Add Rust driver for T-HEAD TH1520 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-rust-next-pwm-working-fan-for-sending-v4-4-a6a28f2b6d8a@samsung.com>
In-Reply-To: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
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
X-CMS-MailID: 20250618122807eucas1p22d41cd6a9ac5131d91d41dfb09b8c92a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250618122807eucas1p22d41cd6a9ac5131d91d41dfb09b8c92a
X-EPHeader: CA
X-CMS-RootMailID: 20250618122807eucas1p22d41cd6a9ac5131d91d41dfb09b8c92a
References: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
	<CGME20250618122807eucas1p22d41cd6a9ac5131d91d41dfb09b8c92a@eucas1p2.samsung.com>

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
 drivers/pwm/Kconfig       |  10 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm_th1520.rs | 320 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 332 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a575622454a2ef57ce055c8a8c4765fa4fddc490..879870471e86dcec4a0e8f5c45d2cc3409411fdd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21402,6 +21402,7 @@ F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
+F:	drivers/pwm/pwm_th1520.rs
 F:	drivers/reset/reset-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index cfddeae0eab3523f04f361fb41ccd1345c0c937b..a675b3bd68392d1b05a47a2a1390c5606647ca15 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -719,6 +719,16 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
+config PWM_TH1520
+	tristate "TH1520 PWM support"
+	depends on RUST_PWM_ABSTRACTIONS
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
index 96160f4257fcb0e0951581af0090615c0edf5260..a410747095327a315a6bcd24ae343ce7857fe323 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
+obj-$(CONFIG_PWM_TH1520)	+= pwm_th1520.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
new file mode 100644
index 0000000000000000000000000000000000000000..18cd0d2230739e1de785231ac426adacedf0fe00
--- /dev/null
+++ b/drivers/pwm/pwm_th1520.rs
@@ -0,0 +1,320 @@
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
+const MAX_PWM_NUM: u32 = 6;
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
+const PWM_START: u32 = 1 << 0;
+const PWM_CFG_UPDATE: u32 = 1 << 2;
+const PWM_CONTINUOUS_MODE: u32 = 1 << 5;
+const PWM_FPOUT: u32 = 1 << 8;
+
+const TH1520_PWM_REG_SIZE: usize = 0xB0;
+
+fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
+    const NSEC_PER_SEC_U64: u64 = time::NSEC_PER_SEC as u64;
+
+    match ns.checked_mul(rate_hz) {
+        Some(product) => product / NSEC_PER_SEC_U64,
+        None => u64::MAX,
+    }
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
+struct Th1520PwmDriverData {
+    iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
+    clk: Clk,
+}
+
+impl pwm::PwmOps for Th1520PwmDriverData {
+    type WfHw = Th1520WfHw;
+
+    fn round_waveform_tohw(
+        chip: &pwm::Chip,
+        _pwm: &pwm::Device,
+        wf: &pwm::Waveform,
+    ) -> Result<(c_int, Self::WfHw)> {
+        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
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
+        let period_cycles = ns_to_cycles(wf.period_length_ns, rate_hz).min(u32::MAX as u64);
+        let mut duty_cycles = ns_to_cycles(wf.duty_length_ns, rate_hz).min(u32::MAX as u64);
+
+        let mut ctrl_val = PWM_CONTINUOUS_MODE;
+
+        if wf.duty_offset_ns == 0 {
+            ctrl_val |= PWM_FPOUT;
+        } else {
+            duty_cycles = period_cycles - duty_cycles;
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
+            "Requested: period {}ns, duty {}ns, offset {}ns -> HW: period {} cyc, duty {} cyc, ctrl 0x{:x}\n",
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
+        chip: &pwm::Chip,
+        _pwm: &pwm::Device,
+        wfhw: &Self::WfHw,
+        wf: &mut pwm::Waveform,
+    ) -> Result<c_int> {
+        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
+        let rate_hz = data.clk.rate().as_hz() as u64;
+
+        wf.period_length_ns = cycles_to_ns(wfhw.period_cycles as u64, rate_hz);
+
+        let duty_cycles = wfhw.duty_cycles as u64;
+
+        if (wfhw.ctrl_val & PWM_FPOUT) != 0 {
+            wf.duty_length_ns = cycles_to_ns(duty_cycles, rate_hz);
+            wf.duty_offset_ns = 0;
+        } else {
+            let period_cycles = wfhw.period_cycles as u64;
+            let original_duty_cycles = period_cycles.saturating_sub(duty_cycles);
+
+            wf.duty_length_ns = cycles_to_ns(original_duty_cycles, rate_hz);
+            // We can't recover the original non-zero offset, so we just set it
+            // to a representative non-zero value.
+            wf.duty_offset_ns = 1;
+        }
+
+        Ok(0)
+    }
+
+    fn read_waveform(
+        chip: &pwm::Chip,
+        pwm: &pwm::Device,
+        parent_dev: &Device<Bound>,
+    ) -> Result<Self::WfHw> {
+        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
+        let hwpwm = pwm.hwpwm();
+        let iomem_guard = data.iomem.access(parent_dev)?;
+        let iomap = iomem_guard.deref();
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
+        chip: &pwm::Chip,
+        pwm: &pwm::Device,
+        wfhw: &Self::WfHw,
+        parent_dev: &Device<Bound>,
+    ) -> Result {
+        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
+        let hwpwm = pwm.hwpwm();
+        let iomem_accessor = data.iomem.access(parent_dev)?;
+        let iomap = iomem_accessor.deref();
+        let was_enabled = pwm.state().enabled();
+
+        if !wfhw.enabled {
+            if was_enabled {
+                iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
+                iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
+                iomap.try_write32(wfhw.ctrl_val | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
+            }
+            return Ok(());
+        }
+
+        iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
+        iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
+        iomap.try_write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm))?;
+        iomap.try_write32(wfhw.ctrl_val | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
+
+        // The `PWM_START` bit must be written in a separate, final transaction, and
+        // only when enabling the channel from a disabled state.
+        if !was_enabled {
+            iomap.try_write32(wfhw.ctrl_val | PWM_START, th1520_pwm_ctrl(hwpwm))?;
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
+impl Drop for Th1520PwmDriverData {
+    fn drop(&mut self) {
+        self.clk.disable_unprepare();
+    }
+}
+
+static TH1520_PWM_OPS: pwm::PwmOpsVTable = pwm::create_pwm_ops::<Th1520PwmDriverData>();
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
+        let iomem = pdev.ioremap_resource_sized::<TH1520_PWM_REG_SIZE>(resource)?;
+        let clk = Clk::get(pdev.as_ref(), None)?;
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
+            return Err(ERANGE);
+        }
+
+        let chip = pwm::Chip::new(dev, MAX_PWM_NUM, 0)?;
+
+        let drvdata = KBox::new(Th1520PwmDriverData { iomem, clk }, GFP_KERNEL)?;
+        chip.set_drvdata(drvdata);
+
+        pwm::Registration::new_foreign_owned(dev, chip, &TH1520_PWM_OPS)?;
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


