Return-Path: <linux-pwm+bounces-6425-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CA7ADEC85
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 14:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E2C3B63EC
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AA02EBBAC;
	Wed, 18 Jun 2025 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lL1q+WJi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5B2EA746
	for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249695; cv=none; b=rxnSsIKIuWzpJH1n3+JVfqqbyNCLx4ZQvIQ96ALCPUgl+NHDf40oeax+S9/ifsNmFTWpK5u0VR+JhDFYWbFMXAxU6GrfgYQL7oc+3Zs0PlVv+oBqxNA84whrEMtTlRwFUYiJe2V0zoUwG1sCxeYgDQWI3SGHzrRCBmqBV73GRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249695; c=relaxed/simple;
	bh=3x4XA8rVGvcqRMp60zC+GETWnoMG7/3bwXr/LsWy2A0=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=M1YVZqMDlIgYuaL7rm8tjCZt+kyRdR+hO89JJICWnuMWH8ZwACjOlCgef6JChasgXyDj+o2JSHhugkbzAR5PZVddBTb+zBjVAO4pUhyAD2Lt+Ei6sg8o5i16RP7Hu9G4uqbWgyupCxg/Lgv4RotK9ro8Jxx77GP++ZKfiVaMjJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lL1q+WJi; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250618122803euoutp017f37ce9b56f463491444693cbaaf7e36~KItBRruYK3005230052euoutp01Y
	for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 12:28:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250618122803euoutp017f37ce9b56f463491444693cbaaf7e36~KItBRruYK3005230052euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750249683;
	bh=J65JaRuGLW1MK7iS3wcUH4sUEKCN5P+oJvskSjmp6ks=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=lL1q+WJiqA/4uhx1Xc+rnjc8Huxfu1cTzHb3aKC2uqwFjxoRJGzb4PkUIwrdDs3VR
	 ztUJCCSKcqKiaCfuYXmujHDfv1rC3E41QJu+n4FcCZSIhd802FGJQ6SilLQhDllF/o
	 uzwWRqOu43QE+ki6La8o0PRivMprnMNnesHDC6bA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250618122802eucas1p2fb77369f40f70f67ac02658064b4a3ac~KItAip4Gn2280822808eucas1p2P;
	Wed, 18 Jun 2025 12:28:02 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250618122801eusmtip137970edaf4ab4b09acdca0b16d0e2f18~KIs-X_kYO1801818018eusmtip1k;
	Wed, 18 Jun 2025 12:28:01 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 18 Jun 2025 14:27:34 +0200
Subject: [PATCH v4 1/9] rust: pwm: Add Kconfig and basic data structures
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20250618-rust-next-pwm-working-fan-for-sending-v4-1-a6a28f2b6d8a@samsung.com>
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
X-CMS-MailID: 20250618122802eucas1p2fb77369f40f70f67ac02658064b4a3ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250618122802eucas1p2fb77369f40f70f67ac02658064b4a3ac
X-EPHeader: CA
X-CMS-RootMailID: 20250618122802eucas1p2fb77369f40f70f67ac02658064b4a3ac
References: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
	<CGME20250618122802eucas1p2fb77369f40f70f67ac02658064b4a3ac@eucas1p2.samsung.com>

Introduce the foundational support for PWM abstractions in Rust.

This commit adds the `RUST_PWM_ABSTRACTIONS` Kconfig option to enable
the feature, along with the necessary build-system support and C
helpers.

It also introduces the first set of safe wrappers for the PWM
subsystem, covering the basic data carrying C structs and enums:
- `Polarity`: A safe wrapper for `enum pwm_polarity`.
- `Waveform`: A wrapper for `struct pwm_waveform`.
- `Args`: A wrapper for `struct pwm_args`.
- `State`: A wrapper for `struct pwm_state`.

These types provide memory safe, idiomatic Rust representations of the
core PWM data structures and form the building blocks for the
abstractions that will follow.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                     |   6 ++
 drivers/pwm/Kconfig             |  13 +++
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/pwm.rs              | 198 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 221 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..a575622454a2ef57ce055c8a8c4765fa4fddc490 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20073,6 +20073,12 @@ F:	include/linux/pwm.h
 F:	include/linux/pwm_backlight.h
 K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
 
+PWM SUBSYSTEM BINDINGS [RUST]
+M:	Michal Wilczynski <m.wilczynski@samsung.com>
+S:	Maintained
+F:	rust/helpers/pwm.c
+F:	rust/kernel/pwm.rs
+
 PXA GPIO DRIVER
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index d9bcd1e8413eaed1602d6686873e263767c58f5f..cfddeae0eab3523f04f361fb41ccd1345c0c937b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -790,4 +790,17 @@ config PWM_XILINX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-xilinx.
 
+ config RUST_PWM_ABSTRACTIONS
+	bool "Rust PWM abstractions support"
+	depends on RUST
+	depends on PWM=y
+	help
+	  This option enables the safe Rust abstraction layer for the PWM
+	  subsystem. It provides idiomatic wrappers and traits necessary for
+	  writing PWM controller drivers in Rust.
+
+	  The abstractions handle resource management (like memory and reference
+	  counting) and provide safe interfaces to the underlying C core,
+	  allowing driver logic to be written in safe Rust.
+
 endif
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 693cdd01f9290fa01375cf78cac0e5a90df74c6c..6fe7dd529577952bf7adb4fe0526b0d5fbd6f3bd 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -64,6 +64,7 @@
 #include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 16fa9bca5949b85e8d4cdcfe8e6886124f72d8d8..60879e6d794ce0f87e39caafc5495bf5e8acf8f0 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -31,6 +31,7 @@
 #include "platform.c"
 #include "pci.c"
 #include "pid_namespace.c"
+#include "pwm.c"
 #include "rbtree.c"
 #include "rcu.c"
 #include "refcount.c"
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b2b1c37f4da1866e993be6230bc6715841..ce1d08b14e456905dbe7b625bbb8ca8b08deae2a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -105,6 +105,8 @@
 pub mod seq_file;
 pub mod sizes;
 mod static_assert;
+#[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
+pub mod pwm;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
new file mode 100644
index 0000000000000000000000000000000000000000..ed681b228c414e7ae8bf80ca649ad497c9dc4ec3
--- /dev/null
+++ b/rust/kernel/pwm.rs
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Samsung Electronics Co., Ltd.
+// Author: Michal Wilczynski <m.wilczynski@samsung.com>
+
+//! PWM subsystem abstractions.
+//!
+//! C header: [`include/linux/pwm.h`](srctree/include/linux/pwm.h).
+
+use crate::{
+    bindings,
+    prelude::*,
+    types::Opaque,
+};
+use core::convert::TryFrom;
+
+/// Maximum size for the hardware-specific waveform representation buffer.
+///
+/// From C: `#define WFHWSIZE 20`
+pub const WFHW_MAX_SIZE: usize = 20;
+
+/// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pwm.h).
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+pub enum Polarity {
+    /// Normal polarity (duty cycle defines the high period of the signal).
+    Normal,
+
+    /// Inversed polarity (duty cycle defines the low period of the signal).
+    Inversed,
+}
+
+impl TryFrom<bindings::pwm_polarity> for Polarity {
+    type Error = Error;
+
+    fn try_from(polarity: bindings::pwm_polarity) -> Result<Self, Error> {
+        match polarity {
+            bindings::pwm_polarity_PWM_POLARITY_NORMAL => Ok(Polarity::Normal),
+            bindings::pwm_polarity_PWM_POLARITY_INVERSED => Ok(Polarity::Inversed),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+impl From<Polarity> for bindings::pwm_polarity {
+    fn from(polarity: Polarity) -> Self {
+        match polarity {
+            Polarity::Normal => bindings::pwm_polarity_PWM_POLARITY_NORMAL,
+            Polarity::Inversed => bindings::pwm_polarity_PWM_POLARITY_INVERSED,
+        }
+    }
+}
+
+/// Represents a PWM waveform configuration.
+/// Mirrors struct [`struct pwm_waveform`](srctree/include/linux/pwm.h).
+#[derive(Copy, Clone, Debug, Default, PartialEq, Eq)]
+pub struct Waveform {
+    /// Total duration of one complete PWM cycle, in nanoseconds.
+    pub period_length_ns: u64,
+
+    /// Duty-cycle active time, in nanoseconds.
+    ///
+    /// For a typical normal polarity configuration (active-high) this is the
+    /// high time of the signal.
+    pub duty_length_ns: u64,
+
+    /// Duty-cycle start offset, in nanoseconds.
+    ///
+    /// Delay from the beginning of the period to the first active edge.
+    /// In most simple PWM setups this is `0`, so the duty cycle starts
+    /// immediately at each period’s start.
+    pub duty_offset_ns: u64,
+}
+
+impl From<bindings::pwm_waveform> for Waveform {
+    fn from(wf: bindings::pwm_waveform) -> Self {
+        Waveform {
+            period_length_ns: wf.period_length_ns,
+            duty_length_ns: wf.duty_length_ns,
+            duty_offset_ns: wf.duty_offset_ns,
+        }
+    }
+}
+
+impl From<Waveform> for bindings::pwm_waveform {
+    fn from(wf: Waveform) -> Self {
+        bindings::pwm_waveform {
+            period_length_ns: wf.period_length_ns,
+            duty_length_ns: wf.duty_length_ns,
+            duty_offset_ns: wf.duty_offset_ns,
+        }
+    }
+}
+
+/// Wrapper for board-dependent PWM arguments [`struct pwm_args`](srctree/include/linux/pwm.h).
+#[repr(transparent)]
+pub struct Args(Opaque<bindings::pwm_args>);
+
+impl Args {
+    /// Creates an `Args` wrapper from a C struct pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `c_args_ptr` is a valid, non-null pointer
+    /// to `bindings::pwm_args` and that the pointed-to data is valid
+    /// for the duration of this function call (as data is copied).
+    unsafe fn from_c_ptr(c_args_ptr: *const bindings::pwm_args) -> Self {
+        // SAFETY: Caller guarantees `c_args_ptr` is valid. We dereference it to copy.
+        Args(Opaque::new(unsafe { *c_args_ptr }))
+    }
+
+    /// Returns the period of the PWM signal in nanoseconds.
+    pub fn period(&self) -> u64 {
+        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pwm_args`
+        // managed by the `Opaque` wrapper. This pointer is guaranteed to be
+        // valid and aligned for the lifetime of `self` because `Opaque` owns a copy.
+        unsafe { (*self.0.get()).period }
+    }
+
+    /// Returns the polarity of the PWM signal.
+    pub fn polarity(&self) -> Result<Polarity, Error> {
+        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pwm_args`
+        // managed by the `Opaque` wrapper. This pointer is guaranteed to be
+        // valid and aligned for the lifetime of `self`.
+        let raw_polarity = unsafe { (*self.0.get()).polarity };
+        Polarity::try_from(raw_polarity)
+    }
+}
+
+/// Wrapper for PWM state [`struct pwm_state`](srctree/include/linux/pwm.h).
+#[repr(transparent)]
+pub struct State(bindings::pwm_state);
+
+impl Default for State {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl State {
+    /// Creates a new zeroed `State`.
+    pub fn new() -> Self {
+        State(bindings::pwm_state::default())
+    }
+
+    /// Creates a `State` wrapper by taking ownership of a C `pwm_state` value.
+    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
+        State(c_state)
+    }
+
+    /// Gets the period of the PWM signal in nanoseconds.
+    pub fn period(&self) -> u64 {
+        self.0.period
+    }
+
+    /// Sets the period of the PWM signal in nanoseconds.
+    pub fn set_period(&mut self, period_ns: u64) {
+        self.0.period = period_ns;
+    }
+
+    /// Gets the duty cycle of the PWM signal in nanoseconds.
+    pub fn duty_cycle(&self) -> u64 {
+        self.0.duty_cycle
+    }
+
+    /// Sets the duty cycle of the PWM signal in nanoseconds.
+    pub fn set_duty_cycle(&mut self, duty_ns: u64) {
+        self.0.duty_cycle = duty_ns;
+    }
+
+    /// Returns `true` if the PWM signal is enabled.
+    pub fn enabled(&self) -> bool {
+        self.0.enabled
+    }
+
+    /// Sets the enabled state of the PWM signal.
+    pub fn set_enabled(&mut self, enabled: bool) {
+        self.0.enabled = enabled;
+    }
+
+    /// Gets the polarity of the PWM signal.
+    pub fn polarity(&self) -> Result<Polarity, Error> {
+        Polarity::try_from(self.0.polarity)
+    }
+
+    /// Sets the polarity of the PWM signal.
+    pub fn set_polarity(&mut self, polarity: Polarity) {
+        self.0.polarity = polarity.into();
+    }
+
+    /// Returns `true` if the PWM signal is configured for power usage hint.
+    pub fn usage_power(&self) -> bool {
+        self.0.usage_power
+    }
+
+    /// Sets the power usage hint for the PWM signal.
+    pub fn set_usage_power(&mut self, usage_power: bool) {
+        self.0.usage_power = usage_power;
+    }
+}

-- 
2.34.1


