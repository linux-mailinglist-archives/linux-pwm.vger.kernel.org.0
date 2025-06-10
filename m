Return-Path: <linux-pwm+bounces-6278-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F1CAD3819
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 15:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4586A9E32C2
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BE2DCBEF;
	Tue, 10 Jun 2025 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O7f2QURT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA52D3A63
	for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560021; cv=none; b=LCo1UTtwPvn0yhLgwDIGNr81x3oNaa6vUQ6rP9xDcgNT0ZqOLPKkG+s6TmSEUDmKEhBw6H7O8LZb1F7xYfO4X4oQ36GFZ4v+7ezjspbPFDCQyeXUXpigIyc1U1Wczzp+OR5FFtukdLbZdOo4H7ng9PqTF5cDAvDNymYHDTQt36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560021; c=relaxed/simple;
	bh=VF5q+wBp9kye6JQLhwc0n05CcCw9LlKgrG19B7rxH5Y=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=uJw5LLDUI0nBtqhqqUWKuboI5D8sTt6Tz53SAtdX3F7GJfiIf+23WhBGnGrFMlQS7Mqrk5s00ZAZQjf9bd80tTSwXfliKTH0iT2Su5HvkDQdyQuTFMYajQSjISQlVxDRqQCflqZnmBbuHcvW/WeP+tqMun/irn+3MMZpzBmcOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O7f2QURT; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250610125334euoutp027ebb4eb6dfd083d8d76fd8de4750a1a9~Hr5A3cHY42427924279euoutp02R
	for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 12:53:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250610125334euoutp027ebb4eb6dfd083d8d76fd8de4750a1a9~Hr5A3cHY42427924279euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749560014;
	bh=XnU++sOJANJB3QM+54tjoJboUyue4aR10yImzgN9Ir0=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=O7f2QURTPGaH/+zJRRJBq6EnMgQyJqep+z4jwzQnCufOvHJVCASyfYb7TLCwLAWoP
	 XGLgGNweTFUsG6tF/qM2zGg8kRlfK8Og8Ivl0lc0Pc4zwR9x3NShbd8k6IcRcC3Uzt
	 nAfbMmbmjrJ9co98lXBtDW+FbbatBqnjE5G49xFM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d~Hr5ALMeiU0875208752eucas1p16;
	Tue, 10 Jun 2025 12:53:33 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250610125332eusmtip1870d7d868d8f899ab0bd39780d123beb~Hr4_9rhV10363103631eusmtip1P;
	Tue, 10 Jun 2025 12:53:32 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 10 Jun 2025 14:52:50 +0200
Subject: [PATCH v2 2/7] pwm: Add Rust driver for T-HEAD TH1520 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rust-next-pwm-working-fan-for-sending-v2-2-753e2955f110@samsung.com>
In-Reply-To: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
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
X-CMS-MailID: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
X-EPHeader: CA
X-CMS-RootMailID: 20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
	<CGME20250610125333eucas1p16126b64a0f447a5e9a5ad553d9d7d79d@eucas1p1.samsung.com>

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
 drivers/pwm/pwm_th1520.rs | 287 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 299 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5589c0d2253bcb04e78d7b89ef6ef0ed41121d77..966ce515c8bfefdff1975bb716a267435ec0feae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21319,6 +21319,7 @@ F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
+F:	drivers/pwm/pwm_th1520.rs
 F:	drivers/reset/reset-th1520.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 03c5a100a03e2acdccf8a46b9c70b736b630bd3a..be05658a568cb9156ef623caf54ff1aaba898d01 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -719,6 +719,16 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
+config PWM_TH1520_RUST
+	tristate "TH1520 PWM support (Rust)"
+	depends on RUST_PWM_ABSTRACTIONS
+	help
+	  This option enables the driver for the PWM controller found on the
+	  T-HEAD TH1520 SoC. This driver is written in Rust.
+
+	  To compile this driver as a module, choose M here; the module
+	  will be called pwm-th1520. If you are unsure, say N.
+
 config PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 96160f4257fcb0e0951581af0090615c0edf5260..d41b1940df903ba2036d8e3ed93efcd66834b7ab 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -73,3 +73,4 @@ obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
 obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
+obj-$(CONFIG_PWM_TH1520_RUST)	+= pwm_th1520.o
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
new file mode 100644
index 0000000000000000000000000000000000000000..9e43474f5123b51c49035d71219303a606c20a5a
--- /dev/null
+++ b/drivers/pwm/pwm_th1520.rs
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Samsung Electronics Co., Ltd.
+// Author: Michal Wilczynski <m.wilczynski@samsung.com>
+
+//! Rust T-HEAD TH1520 PWM driver
+
+use core::ops::Deref;
+use kernel::{
+    c_str,
+    clk::Clk,
+    device::{Bound, Core, Device},
+    devres,
+    error::{code::*, Result},
+    io::mem::IoMem,
+    math::KernelMathExt,
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
+const fn th1520_pwm_ctrl(n: u32) -> usize {
+    th1520_pwm_chn_base(n)
+}
+const fn th1520_pwm_per(n: u32) -> usize {
+    th1520_pwm_chn_base(n) + 0x08
+}
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
+/// Hardware-specific waveform representation for TH1520.
+#[derive(Copy, Clone, Debug, Default)]
+struct Th1520WfHw {
+    period_cycles: u32,
+    duty_cycles: u32,
+    ctrl_val: u32,
+    enabled: bool,
+}
+
+/// The driver's private data struct. It holds all necessary devres-managed resources.
+struct Th1520PwmDriverData {
+    iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
+    clk: Clk,
+}
+
+impl pwm::PwmOps for Th1520PwmDriverData {
+    type WfHw = Th1520WfHw;
+
+    fn get_state(
+        chip: &mut pwm::Chip,
+        pwm: &mut pwm::Device,
+        state: &mut pwm::State,
+        parent_dev: &Device<Bound>,
+    ) -> Result {
+        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
+        let hwpwm = pwm.hwpwm();
+        let iomem_guard = data.iomem.access(parent_dev)?;
+        let iomap = iomem_guard.deref();
+        let ctrl = iomap.read32(th1520_pwm_ctrl(hwpwm));
+        let period_cycles = iomap.read32(th1520_pwm_per(hwpwm));
+        let duty_cycles = iomap.read32(th1520_pwm_fp(hwpwm));
+
+        state.set_enabled(duty_cycles != 0);
+
+        let rate_hz = data.clk.rate().as_hz();
+        let period_ns = (period_cycles as u64)
+            .mul_div(time::NSEC_PER_SEC as u64, rate_hz as u64)
+            .unwrap_or(0);
+        state.set_period(period_ns);
+
+        let duty_ns = (duty_cycles as u64)
+            .mul_div(time::NSEC_PER_SEC as u64, rate_hz as u64)
+            .unwrap_or(0);
+        state.set_duty_cycle(duty_ns);
+
+        if (ctrl & PWM_FPOUT) != 0 {
+            state.set_polarity(pwm::Polarity::Normal);
+        } else {
+            state.set_polarity(pwm::Polarity::Inversed);
+        }
+
+        Ok(())
+    }
+
+    fn round_waveform_tohw(
+        chip: &mut pwm::Chip,
+        pwm: &mut pwm::Device,
+        wf: &pwm::Waveform,
+    ) -> Result<(i32, Self::WfHw)> {
+        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
+        let hwpwm = pwm.hwpwm();
+
+        if wf.duty_offset_ns != 0 {
+            dev_err!(chip.device(), "PWM-{}: Duty offset not supported\n", hwpwm);
+            return Err(ENOTSUPP);
+        }
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
+        let rate_hz = data.clk.rate().as_hz();
+
+        let period_cycles = wf
+            .period_length_ns
+            .mul_div(rate_hz as u64, time::NSEC_PER_SEC as u64)
+            .ok_or(EINVAL)?;
+        if period_cycles > u32::MAX as u64 {
+            dev_err!(
+                chip.device(),
+                "PWM-{}: Calculated period {} cycles is out of range\n",
+                hwpwm,
+                period_cycles
+            );
+            return Err(EINVAL);
+        }
+
+        let duty_cycles = wf
+            .duty_length_ns
+            .mul_div(rate_hz as u64, time::NSEC_PER_SEC as u64)
+            .ok_or(EINVAL)?;
+        if duty_cycles > period_cycles {
+            dev_err!(
+                chip.device(),
+                "PWM-{}: Duty {}ns > period {}ns\n",
+                hwpwm,
+                wf.duty_length_ns,
+                wf.period_length_ns
+            );
+            return Err(EINVAL);
+        }
+
+        let mut ctrl_val = PWM_CONTINUOUS_MODE;
+        if pwm.state().polarity() == pwm::Polarity::Normal {
+            ctrl_val |= PWM_FPOUT;
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
+            "wfhw -- Period: {}, Duty: {}, Ctrl: 0x{:x}\n",
+            wfhw.period_cycles,
+            wfhw.duty_cycles,
+            wfhw.ctrl_val
+        );
+        Ok((0, wfhw))
+    }
+
+    fn write_waveform(
+        chip: &mut pwm::Chip,
+        pwm: &mut pwm::Device,
+        wfhw: &Self::WfHw,
+        parent_dev: &Device<Bound>,
+    ) -> Result {
+        let data: &Self = chip.drvdata().ok_or(EINVAL)?;
+        let hwpwm = pwm.hwpwm();
+        let iomem_guard = data.iomem.access(parent_dev)?;
+        let iomap = iomem_guard.deref();
+        let was_enabled = pwm.state().enabled();
+
+        if !wfhw.enabled {
+            if was_enabled {
+                let mut ctrl = iomap.read32(th1520_pwm_ctrl(hwpwm));
+
+                ctrl &= !PWM_CFG_UPDATE;
+
+                iomap.write32(ctrl, th1520_pwm_ctrl(hwpwm));
+                iomap.write32(0, th1520_pwm_fp(hwpwm));
+                iomap.write32(ctrl | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm));
+            }
+            return Ok(());
+        }
+
+        let ctrl = wfhw.ctrl_val & !PWM_CFG_UPDATE;
+
+        iomap.write32(ctrl, th1520_pwm_ctrl(hwpwm));
+        iomap.write32(wfhw.period_cycles, th1520_pwm_per(hwpwm));
+        iomap.write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm));
+        iomap.write32(wfhw.ctrl_val | PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm));
+
+        if !was_enabled {
+            iomap.write32(wfhw.ctrl_val | PWM_START, th1520_pwm_ctrl(hwpwm));
+        }
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
+struct Th1520PwmPlatformDriver {
+    _registration: pwm::Registration,
+}
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
+        let registration = pwm::Registration::new(chip, &TH1520_PWM_OPS)?;
+
+        Ok(KBox::new(
+            Th1520PwmPlatformDriver {
+                _registration: registration,
+            },
+            GFP_KERNEL,
+        )?
+        .into())
+    }
+}
+
+kernel::module_platform_driver! {
+    type: Th1520PwmPlatformDriver,
+    name: "pwm-th1520",
+    author: "Michal Wilczynski <m.wilczynski@samsung.com>",
+    description: "T-HEAD TH1520 PWM driver",
+    license: "GPL v2",
+}

-- 
2.34.1


