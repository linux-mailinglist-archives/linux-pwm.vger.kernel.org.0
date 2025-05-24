Return-Path: <linux-pwm+bounces-6115-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B99AC3177
	for <lists+linux-pwm@lfdr.de>; Sat, 24 May 2025 23:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C327AF668
	for <lists+linux-pwm@lfdr.de>; Sat, 24 May 2025 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFF827B516;
	Sat, 24 May 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pIMsj4eE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4127EC6F
	for <linux-pwm@vger.kernel.org>; Sat, 24 May 2025 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748121335; cv=none; b=B/QMds6FSJEw4FGfTi/lxBNSK5Z4p2XhlfcRTraiYXB9XyKhOL2m/MhNbog862Ok/VXm5HTjWsnR6zzPz9tEl6RR6eablgRQ+tCC1XyQydoG5xhJDAoKdM3kP4c98jP8zGmgrOBSyXGXrILByH/VrzIHJSjteyVDI+gAlnfzox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748121335; c=relaxed/simple;
	bh=7IaK367yI1lVGZhX1Wip/rOtJrFPP5FbOrwTyXypQOw=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=MIrjLo9BxbzzvaAZ0vyuZxzQMH4v93CplhLeQkZh1IDtgDnAh6Roeqe/mW7JjrwK8xUBRFjbUuFZ9ThlSySzzDkVB7g9slphs6PcFMQb2HAs6emwsEHr9905s5eBF+TyH5XFzNDFLevgJUp6Kfu0EUqQezMOneRXuDfH32+j2mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pIMsj4eE; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250524211523euoutp01ea7c7c831debf4b30e521a0fcb5bdff0~CkxTScMBs2956229562euoutp01G
	for <linux-pwm@vger.kernel.org>; Sat, 24 May 2025 21:15:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250524211523euoutp01ea7c7c831debf4b30e521a0fcb5bdff0~CkxTScMBs2956229562euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748121323;
	bh=mnCVIgqYN4+4I6dWIR4rHEpcqnjqxXuA7wC3g9VEo/U=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=pIMsj4eECGz0kdoZ5WiQFp8VdaU050uquSp6m5VEZr0TC1SQyhP/fw+SRjXdYMbp/
	 s08J1UmUBZRSniBxTZxcXrW2cuUIuwgqSVEwsbQ+Nwp2vN2z8YNHXIfhdtJ6WVoC0M
	 HImFsOv1TA+oMluAuTWRA55L0wR6MGeGBYEd1LIA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0~CkxSJuHyn0444104441eucas1p1P;
	Sat, 24 May 2025 21:15:21 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250524211520eusmtip2b029f711a8bff2e2a1937b3e072fbbdd~CkxRJVqxe0676606766eusmtip2n;
	Sat, 24 May 2025 21:15:20 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 24 May 2025 23:14:56 +0200
Subject: [PATCH RFC 2/6] pwm: Add Rust driver for T-HEAD TH1520 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250524-rust-next-pwm-working-fan-for-sending-v1-2-bdd2d5094ff7@samsung.com>
In-Reply-To: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Benno Lossin
	<benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>, Alice
	Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>, Danilo
	Krummrich <dakr@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>,
	Drew Fustini <drew@pdp7.com>,  Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0
X-EPHeader: CA
X-CMS-RootMailID: 20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211521eucas1p1929a51901c91d1a37e9f4c2da86ff7b0@eucas1p1.samsung.com>

Introduce a PWM driver for the T-HEAD TH1520 SoC written in Rust. It
utilizes the Rust PWM abstractions added in the previous commit.

The driver implements the standard PwmOps for the PWM framework,
supporting configuration of period, duty cycle, and polarity for the
TH1520's PWM channels. It uses devm managed resources for the PWM chip
itself and Rust DevRes for I/O memory. Clock management is handled using
Rust's RAII pattern.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS               |   1 +
 drivers/pwm/Kconfig       |   6 +
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm_th1520.rs | 272 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 280 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b080e8f3d873b1e401b3a2fe1207c224c4591fc..0cfac73aea65076c5ccb50a25ea686fb86b472b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20986,6 +20986,7 @@ F:	drivers/mailbox/mailbox-th1520.c
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
 F:	drivers/pinctrl/pinctrl-th1520.c
 F:	drivers/pmdomain/thead/
+F:	drivers/pwm/pwm_th1520.rs
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
 F:	include/dt-bindings/power/thead,th1520-power.h
 F:	include/linux/firmware/thead/thead,th1520-aon.h
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index b5bd5c13b3a5e5a575a0fbfb2e285f5665b7a671..796fcd8343b7c8e30f62edc2e0fecf0e9b1ae20e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -684,6 +684,12 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
+config PWM_TH1520_RUST
+	tristate "TH1520 PWM support (Rust)"
+	depends on RUST_PWM_ABSTRACTIONS
+	help
+	  Generic PWM framework driver for TH1520 SoC.
+
 config PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 539e0def3f82fcb866ab83a0346a15f7efdd7127..6890f860ada6f1a6ed43dd3a3a9584cd2fa877f3 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -70,3 +70,4 @@ obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
 obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
+obj-$(CONFIG_PWM_TH1520_RUST)	+= pwm_th1520.o
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
new file mode 100644
index 0000000000000000000000000000000000000000..4665e293e8d0bdc1a62a4e295cdaf4d47b3dd134
--- /dev/null
+++ b/drivers/pwm/pwm_th1520.rs
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Samsung Electronics Co., Ltd.
+// Author: Michal Wilczynski <m.wilczynski@samsung.com>
+
+//! Rust T-HEAD TH1520 PWM driver
+use kernel::{c_str, clk::Clk, device, io::mem::IoMem, of, platform, prelude::*, pwm, time};
+
+const MAX_PWM_NUM: u32 = 6;
+
+const fn th1520_pwm_chn_base(n: u32) -> u32 {
+    n * 0x20
+}
+const fn th1520_pwm_ctrl(n: u32) -> u32 {
+    th1520_pwm_chn_base(n) + 0x00
+}
+const fn th1520_pwm_per(n: u32) -> u32 {
+    th1520_pwm_chn_base(n) + 0x08
+}
+const fn th1520_pwm_fp(n: u32) -> u32 {
+    th1520_pwm_chn_base(n) + 0x0c
+}
+
+const PWM_START: u32 = 1 << 0;
+const PWM_CFG_UPDATE: u32 = 1 << 2;
+const PWM_CONTINUOUS_MODE: u32 = 1 << 5;
+const PWM_FPOUT: u32 = 1 << 8;
+const PWM_INFACTOUT: u32 = 1 << 9;
+
+struct Th1520PwmChipData {
+    clk: Clk,
+    iomem: kernel::devres::Devres<IoMem<0>>,
+}
+
+impl Th1520PwmChipData {
+    fn _config(
+        &self,
+        hwpwm: u32,
+        duty_ns: u64,
+        period_ns: u64,
+        target_polarity: pwm::Polarity,
+    ) -> Result<u32> {
+        let regs = self.iomem.try_access().ok_or_else(|| {
+            pr_err!("PWM-{}: Failed to access I/O memory in _config\n", hwpwm);
+            EBUSY
+        })?;
+
+        // Calculate cycle values
+        let rate_hz_u64 = self.clk.rate().as_hz() as u64;
+
+        if duty_ns > period_ns {
+            pr_err!(
+                "PWM-{}: Duty {}ns > period {}ns\n",
+                hwpwm,
+                duty_ns,
+                period_ns
+            );
+            return Err(EINVAL);
+        }
+        if period_ns == 0 {
+            pr_err!("PWM-{}: Period is zero\n", hwpwm);
+            return Err(EINVAL);
+        }
+
+        let mut period_cycle = mul_div_u64(period_ns, rate_hz_u64, time::NSEC_PER_SEC as u64);
+        if period_cycle > u32::MAX as u64 {
+            period_cycle = u32::MAX as u64;
+        }
+        if period_cycle == 0 {
+            pr_err!(
+                "PWM-{}: Calculated period_cycle is zero, not allowed by HW\n",
+                hwpwm
+            );
+            return Err(EINVAL);
+        }
+
+        let mut duty_cycle = mul_div_u64(duty_ns, rate_hz_u64, time::NSEC_PER_SEC as u64);
+        if duty_cycle > u32::MAX as u64 {
+            duty_cycle = u32::MAX as u64;
+        }
+
+        let mut base_ctrl_val = PWM_INFACTOUT | PWM_CONTINUOUS_MODE;
+        if target_polarity == pwm::Polarity::Normal {
+            // FPOUT=1 for Normal
+            base_ctrl_val |= PWM_FPOUT;
+        } else {
+            // Inversed, FPOUT=0
+            base_ctrl_val &= !PWM_FPOUT;
+        }
+        regs.try_write32(base_ctrl_val, th1520_pwm_ctrl(hwpwm) as usize)?;
+        pr_debug!(
+            "PWM-{}: _config: Initial CTRL write (polarity, mode): 0x{:x}\n",
+            hwpwm,
+            base_ctrl_val
+        );
+
+        // Write period and duty registers
+        regs.try_write32(period_cycle as u32, th1520_pwm_per(hwpwm) as usize)?;
+        regs.try_write32(duty_cycle as u32, th1520_pwm_fp(hwpwm) as usize)?;
+        pr_debug!(
+            "PWM-{}: _config: Period_cyc={}, Duty_cyc={}\n",
+            hwpwm,
+            period_cycle,
+            duty_cycle
+        );
+
+        // Apply period/duty by toggling CFG_UPDATE from 0 to 1.
+        // The `base_ctrl_val` (just written to HW) has CFG_UPDATE=0. Now set it.
+        let ctrl_val_for_update = base_ctrl_val | PWM_CFG_UPDATE;
+        regs.try_write32(ctrl_val_for_update, th1520_pwm_ctrl(hwpwm) as usize)?;
+        pr_debug!(
+            "PWM-{}: _config: CTRL write with CFG_UPDATE: 0x{:x}\n",
+            hwpwm,
+            ctrl_val_for_update
+        );
+
+        Ok(ctrl_val_for_update)
+    }
+
+    fn _enable(&self, hwpwm: u32, ctrl_val_after_config: u32) -> Result {
+        let regs = self.iomem.try_access().ok_or_else(|| {
+            pr_err!("PWM-{}: Failed to access I/O memory in _enable\n", hwpwm);
+            EBUSY
+        })?;
+
+        // ctrl_val_after_config already has mode, polarity, and CFG_UPDATE correctly set.
+        // Now add the START bit. START bit auto-clears.
+        let ctrl_to_start = ctrl_val_after_config | PWM_START;
+        regs.try_write32(ctrl_to_start, th1520_pwm_ctrl(hwpwm) as usize)?;
+        pr_debug!(
+            "PWM-{}: _enable: CTRL write with START: 0x{:x}\n",
+            hwpwm,
+            ctrl_to_start
+        );
+        Ok(())
+    }
+
+    fn _disable(&self, hwpwm: u32) -> Result<()> {
+        let regs = self.iomem.try_access().ok_or_else(|| {
+            pr_err!("PWM-{}: Failed to access I/O memory in _disable\n", hwpwm);
+            EINVAL
+        })?;
+
+        let mut ctrl_val = regs.try_read32(th1520_pwm_ctrl(hwpwm) as usize)?;
+        pr_debug!("PWM-{}: _disable: Read CTRL: 0x{:x}\n", hwpwm, ctrl_val);
+
+        // Ensure CFG_UPDATE is 0 before updating duty (Limitation #4)
+        if (ctrl_val & PWM_CFG_UPDATE) != 0 {
+            ctrl_val &= !PWM_CFG_UPDATE;
+            regs.try_write32(ctrl_val, th1520_pwm_ctrl(hwpwm) as usize)?;
+            pr_debug!(
+                "PWM-{}: _disable: Cleared CFG_UPDATE, wrote CTRL: 0x{:x}\n",
+                hwpwm,
+                ctrl_val
+            );
+        }
+
+        // Set duty cycle to 0
+        regs.try_write32(0, th1520_pwm_fp(hwpwm) as usize)?;
+        pr_debug!("PWM-{}: _disable: Wrote 0 to DUTY (FP) register\n", hwpwm);
+
+        // Apply the 0% duty by toggling CFG_UPDATE from 0 to 1
+        // Use the ctrl_val that has CFG_UPDATE cleared (or was already clear)
+        ctrl_val |= PWM_CFG_UPDATE;
+        regs.try_write32(ctrl_val, th1520_pwm_ctrl(hwpwm) as usize)?;
+        pr_debug!(
+            "PWM-{}: _disable: Set CFG_UPDATE, wrote CTRL: 0x{:x}\n",
+            hwpwm,
+            ctrl_val
+        );
+
+        Ok(())
+    }
+}
+
+impl pwm::PwmOps for Th1520PwmChipData {
+    // This driver implements get_state
+    fn apply(
+        pwm_chip_ref: &mut pwm::Chip,
+        pwm_dev: &mut pwm::Device,
+        target_state: &pwm::State,
+    ) -> Result {
+        let data: &Th1520PwmChipData = pwm_chip_ref.get_drvdata().ok_or(EINVAL)?;
+        let hwpwm = pwm_dev.hwpwm();
+
+        if !target_state.enabled() {
+            if pwm_dev.state().enabled() {
+                data._disable(hwpwm)?;
+            }
+
+            return Ok(());
+        }
+
+        // Configure period, duty, and polarity.
+        // This function also latches period/duty with CFG_UPDATE.
+        // It returns the control value that was written with CFG_UPDATE set.
+        let ctrl_val_after_config = data._config(
+            hwpwm,
+            target_state.duty_cycle(),
+            target_state.period(),
+            target_state.polarity(),
+        )?;
+
+        // Enable by setting START bit if it wasn't enabled before this apply call
+        if !pwm_dev.state().enabled() {
+            data._enable(hwpwm, ctrl_val_after_config)?;
+        }
+
+        Ok(())
+    }
+}
+
+impl Drop for Th1520PwmChipData {
+    fn drop(&mut self) {
+        self.clk.disable_unprepare();
+    }
+}
+
+fn mul_div_u64(a: u64, b: u64, c: u64) -> u64 {
+    if c == 0 {
+        return 0;
+    }
+    a.wrapping_mul(b) / c
+}
+
+static TH1520_PWM_OPS: pwm::PwmOpsVTable = pwm::create_pwm_ops::<Th1520PwmChipData>();
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
+        pdev: &platform::Device<device::Core>,
+        _id_info: Option<&Self::IdInfo>,
+    ) -> Result<Pin<KBox<Self>>> {
+        let resource = pdev.resource(0).ok_or(ENODEV)?;
+        let iomem = pdev.ioremap_resource(&resource)?;
+
+        let clk = Clk::get(pdev.as_ref(), None)?;
+
+        clk.prepare_enable()?;
+        let driver_data = KBox::new(Th1520PwmChipData { clk, iomem }, GFP_KERNEL)?;
+        let pwm_chip = pwm::devm_chip_alloc(pdev.as_ref(), MAX_PWM_NUM, 0)?;
+
+        let result = pwm::devm_chip_add(pdev.as_ref(), pwm_chip, &TH1520_PWM_OPS);
+        if result.is_err() {
+            pr_err!("Failed to add PWM chip: {:?}\n", result);
+            return Err(EIO);
+        }
+
+        pwm_chip.set_drvdata(driver_data);
+        pr_info!("T-HEAD TH1520 PWM probed correctly\n");
+
+        Ok(KBox::new(Self, GFP_KERNEL)?.into())
+    }
+}
+
+kernel::module_platform_driver! {
+    type: Th1520PwmPlatformDriver,
+    name: "pwm_th1520",
+    author: "Michal Wilczynski",
+    description: "T-HEAD TH1520 PWM driver",
+    license: "GPL v2",
+}

-- 
2.34.1


