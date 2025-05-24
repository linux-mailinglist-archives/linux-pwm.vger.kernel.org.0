Return-Path: <linux-pwm+bounces-6113-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4137AC3174
	for <lists+linux-pwm@lfdr.de>; Sat, 24 May 2025 23:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7E37AF585
	for <lists+linux-pwm@lfdr.de>; Sat, 24 May 2025 21:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326927EC7D;
	Sat, 24 May 2025 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rWgmd3bg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BF327C15B
	for <linux-pwm@vger.kernel.org>; Sat, 24 May 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748121333; cv=none; b=fEiEwRTFIUZnss5+EcHWSuUoubq9uXoCf+a+0gxNBaSBv6Zmgx0vI1vEFk5dlXuAlh7QtLElCDmvqD6N5GsLN+OIBGueWF0xMK/0afXWQqtqm9ZexR0FWnEzLcRQMaz609N+wrusPmd4Ey+y+OXeMEXGoXnYGaJiqXj1ZxvA1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748121333; c=relaxed/simple;
	bh=IJ+s5N9hqAIymbUhq8tlqql6sfROOUyoW5+/fjBacEE=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=UsuUlsawbklpLTt/UdOO/b1KdTuQbC30ROBm0TyBMzoYo2k0UC/3cw0xZ50evqrZ54W4Or9CcIFPgqZWp4hugIYV5KJj+sXE7xY2wVFDhlJFPo3ugqw/g/J5y6Nuivz4+R9Csd4QCoq2TF9Zmnib6kvb5vRSltOXlbD2znLhwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rWgmd3bg; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250524211522euoutp012dc78092c04c971cc4853a2af039966c~CkxSh3zcK2955029550euoutp01E
	for <linux-pwm@vger.kernel.org>; Sat, 24 May 2025 21:15:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250524211522euoutp012dc78092c04c971cc4853a2af039966c~CkxSh3zcK2955029550euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748121322;
	bh=Ae98N3tSGBe/h/f96a5r9JmrlJMUez7PRPitsnGiQz8=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=rWgmd3bgWpNYobN0S4SvDtY6THgMGNr7Y/oW4jUFn/ms9eGm81puzqyLl6BBxZk8l
	 LuSVcGSQkpwnmI/GAlymBzUWtAEBy8fqknAMdbRLWRxwA6ZYr2uAABlUvgqzcka+oh
	 OG4WHRsINXe143dqT3SzLx5CekyFapVbKCxaKpoc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c~CkxRGXwhV0341603416eucas1p16;
	Sat, 24 May 2025 21:15:20 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250524211519eusmtip2c1bebceb9d217c8f6b37932636320e1a~CkxQEOTFj0676606766eusmtip2m;
	Sat, 24 May 2025 21:15:19 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 24 May 2025 23:14:55 +0200
Subject: [PATCH RFC 1/6] rust: Add basic PWM abstractions
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250524-rust-next-pwm-working-fan-for-sending-v1-1-bdd2d5094ff7@samsung.com>
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
X-CMS-MailID: 20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c
X-EPHeader: CA
X-CMS-RootMailID: 20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c
References: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
	<CGME20250524211520eucas1p1378fbab27f4b1ae8808706c074fa217c@eucas1p1.samsung.com>

Introduce initial Rust abstractions for the Linux PWM subsystem. These
abstractions provide safe wrappers around the core C data structures and
functions, enabling the development of PWM chip drivers in Rust.

The main components added are:
- A Kconfig option RUST_PWM_ABSTRACTIONS
- C helper functions in rust/helpers/pwm.c to provide stable callable
  interfaces for Rust, for pwmchip_parent, pwmchip_get_drvdata, and
  pwmchip_set_drvdata
- A new Rust module rust/kernel/pwm.rs containing:
    - Safe wrappers for struct pwm_chip, struct pwm_device,
      struct pwm_state, and struct pwm_args
    - An enum Polarity for type safe polarity handling
    - Functions devm_chip_alloc and devm_chip_add which wrap the
      kernel's device-managed APIs for PWM chip allocation and
      registration.
    - A PwmOps trait and create_pwm_ops function to allow Rust
      drivers to define their PWM operations, initially supporting the
      .apply callback.

This foundational layer will be used by subsequent patches to implement
a specific PWM chip driver in Rust. It focuses on the pwm_chip provider
APIs necessary for such a driver.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                     |   6 +
 drivers/pwm/Kconfig             |   8 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/pwm.c              |  20 +++
 rust/kernel/lib.rs              |   2 +
 rust/kernel/pwm.rs              | 376 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 414 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6126bccf17c899cbbf5b729e1f426ff38d04a8e..2b080e8f3d873b1e401b3a2fe1207c224c4591fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19678,6 +19678,12 @@ F:	include/linux/pwm.h
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
index 4731d5b90d7edcc61138e4a5bf7e98906953ece4..b5bd5c13b3a5e5a575a0fbfb2e285f5665b7a671 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -755,4 +755,12 @@ config PWM_XILINX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-xilinx.
 
+ config RUST_PWM_ABSTRACTIONS
+	bool "Rust PWM abstractions support"
+	depends on RUST
+	depends on PWM=y
+	help
+	  Adds support needed for PWM drivers written in Rust. It provides a
+          wrapper around the C pwm core.
+
 endif
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 43aabecc1d6161398acf3bb402d1f67b48bfcd6f..24a2498f17a2fc56f5dc012a20d621007be28b5e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -32,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 34f040e5f260b892fc421a6e55de32cbf90c8c22..7dda45d1794c957d83227362d9483eb90543f053 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -26,6 +26,7 @@
 #include "platform.c"
 #include "pci.c"
 #include "pid_namespace.c"
+#include "pwm.c"
 #include "rbtree.c"
 #include "rcu.c"
 #include "refcount.c"
diff --git a/rust/helpers/pwm.c b/rust/helpers/pwm.c
new file mode 100644
index 0000000000000000000000000000000000000000..d75c588863685d3990b525bb1b84aa4bc35ac397
--- /dev/null
+++ b/rust/helpers/pwm.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Samsung Electronics Co., Ltd.
+// Author: Michal Wilczynski <m.wilczynski@samsung.com>
+
+#include <linux/pwm.h>
+
+struct device *rust_helper_pwmchip_parent(const struct pwm_chip *chip)
+{
+	return pwmchip_parent(chip);
+}
+
+void *rust_helper_pwmchip_get_drvdata(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+void rust_helper_pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
+{
+	pwmchip_set_drvdata(chip, data);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 1b0b6790a7f33c30af16a056d6afcca3d15a2a0d..72b60afe5f51d8a62b3c95b1b320a48386d14e61 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -92,6 +92,8 @@
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
index 0000000000000000000000000000000000000000..357fda46faa99c4462149658951ec53bf9cc2d1e
--- /dev/null
+++ b/rust/kernel/pwm.rs
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Samsung Electronics Co., Ltd.
+// Author: Michal Wilczynski <m.wilczynski@samsung.com>
+
+//! PWM (Pulse Width Modulator) abstractions.
+//!
+//! This module provides safe Rust abstractions for working with the Linux
+//! kernel's PWM subsystem, leveraging types generated by `bindgen`
+//! from `<linux/pwm.h>` and `drivers/pwm/core.c`.
+
+use crate::{
+    bindings,
+    device::Device as CoreDevice,
+    error::*,
+    prelude::*,
+    str::CStr,
+    types::{ForeignOwnable, Opaque},
+};
+use core::marker::PhantomData;
+
+/// PWM polarity. Mirrors `enum pwm_polarity`.
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+pub enum Polarity {
+    /// Normal polarity (duty cycle defines the high period of the signal)
+    Normal,
+    /// Inversed polarity (duty cycle defines the low period of the signal)
+    Inversed,
+}
+
+impl From<bindings::pwm_polarity> for Polarity {
+    fn from(polarity: bindings::pwm_polarity) -> Self {
+        match polarity {
+            bindings::pwm_polarity_PWM_POLARITY_NORMAL => Polarity::Normal,
+            bindings::pwm_polarity_PWM_POLARITY_INVERSED => Polarity::Inversed,
+            _ => {
+                pr_warn!(
+                    "Unknown pwm_polarity value {}, defaulting to Normal\n",
+                    polarity
+                );
+                Polarity::Normal
+            }
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
+/// Wrapper for board-dependent PWM arguments (`struct pwm_args`).
+#[repr(transparent)]
+pub struct Args(Opaque<bindings::pwm_args>);
+
+impl Args {
+    /// Creates an `Args` wrapper from the C struct reference.
+    fn from_c_ref(c_args: &bindings::pwm_args) -> Self {
+        // SAFETY: Pointer is valid, construct Opaque wrapper. We copy the data.
+        Args(Opaque::new(*c_args))
+    }
+
+    /// Returns the period of the PWM signal in nanoseconds.
+    pub fn period(&self) -> u64 {
+        // SAFETY: Reading from the valid pointer obtained by `get()`.
+        unsafe { (*self.0.get()).period }
+    }
+
+    /// Returns the polarity of the PWM signal.
+    pub fn polarity(&self) -> Polarity {
+        // SAFETY: Reading from the valid pointer obtained by `get()`.
+        Polarity::from(unsafe { (*self.0.get()).polarity })
+    }
+}
+
+/// Wrapper for PWM state (`struct pwm_state`).
+#[repr(transparent)]
+pub struct State(Opaque<bindings::pwm_state>);
+
+impl State {
+    /// Creates a new zeroed `State`.
+    pub fn new() -> Self {
+        State(Opaque::new(bindings::pwm_state::default()))
+    }
+
+    /// Creates a `State` wrapper around a copy of a C `pwm_state`.
+    pub(crate) fn from_c(c_state: bindings::pwm_state) -> Self {
+        State(Opaque::new(c_state))
+    }
+
+    /// Creates a `State` wrapper around a reference to a C `pwm_state`.
+    fn from_c_ref(c_state: &bindings::pwm_state) -> &Self {
+        // SAFETY: Pointer is valid, lifetime tied to input ref. Cast pointer type.
+        unsafe { &*(c_state as *const bindings::pwm_state as *const Self) }
+    }
+
+    /// Gets the period of the PWM signal in nanoseconds.
+    pub fn period(&self) -> u64 {
+        unsafe { (*self.0.get()).period }
+    }
+
+    /// Sets the period of the PWM signal in nanoseconds.
+    pub fn set_period(&mut self, period_ns: u64) {
+        unsafe {
+            (*self.0.get()).period = period_ns;
+        }
+    }
+
+    /// Gets the duty cycle of the PWM signal in nanoseconds.
+    pub fn duty_cycle(&self) -> u64 {
+        unsafe { (*self.0.get()).duty_cycle }
+    }
+
+    /// Sets the duty cycle of the PWM signal in nanoseconds.
+    pub fn set_duty_cycle(&mut self, duty_ns: u64) {
+        unsafe {
+            (*self.0.get()).duty_cycle = duty_ns;
+        }
+    }
+
+    /// Returns `true` if the PWM signal is enabled.
+    pub fn enabled(&self) -> bool {
+        unsafe { (*self.0.get()).enabled }
+    }
+
+    /// Sets the enabled state of the PWM signal.
+    pub fn set_enabled(&mut self, enabled: bool) {
+        unsafe {
+            (*self.0.get()).enabled = enabled;
+        }
+    }
+
+    /// Gets the polarity of the PWM signal.
+    pub fn polarity(&self) -> Polarity {
+        Polarity::from(unsafe { (*self.0.get()).polarity })
+    }
+
+    /// Sets the polarity of the PWM signal.
+    pub fn set_polarity(&mut self, polarity: Polarity) {
+        unsafe {
+            (*self.0.get()).polarity = polarity.into();
+        }
+    }
+
+    /// Returns `true` if the PWM signal is configured for power usage hint.
+    pub fn usage_power(&self) -> bool {
+        unsafe { (*self.0.get()).usage_power }
+    }
+
+    /// Sets the power usage hint for the PWM signal.
+    pub fn set_usage_power(&mut self, usage_power: bool) {
+        unsafe {
+            (*self.0.get()).usage_power = usage_power;
+        }
+    }
+}
+
+/// Wrapper for a PWM device/channel (`struct pwm_device`).
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::pwm_device>);
+
+impl Device {
+    pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::pwm_device) -> &'a mut Self {
+        unsafe { &mut *ptr.cast::<Self>() }
+    }
+
+    fn as_ptr(&self) -> *mut bindings::pwm_device {
+        self.0.get()
+    }
+
+    /// Gets the hardware PWM index for this device within its chip.
+    pub fn hwpwm(&self) -> u32 {
+        unsafe { (*self.as_ptr()).hwpwm }
+    }
+
+    /// Gets a reference to the parent `Chip` that this device belongs to.
+    pub fn chip(&self) -> &Chip {
+        unsafe { Chip::from_ptr((*self.as_ptr()).chip) }
+    }
+
+    /// Gets the label for this PWM device, if any.
+    pub fn label(&self) -> Option<&CStr> {
+        let label_ptr = unsafe { (*self.as_ptr()).label };
+        if label_ptr.is_null() {
+            None
+        } else {
+            Some(unsafe { CStr::from_char_ptr(label_ptr) })
+        }
+    }
+
+    /// Gets a copy of the board-dependent arguments for this PWM device.
+    pub fn args(&self) -> Args {
+        Args::from_c_ref(unsafe { &(*self.as_ptr()).args })
+    }
+
+    /// Gets a copy of the current state of this PWM device.
+    pub fn state(&self) -> State {
+        State::from_c(unsafe { (*self.as_ptr()).state })
+    }
+
+    /// Returns `true` if the PWM signal is currently enabled based on its state.
+    pub fn is_enabled(&self) -> bool {
+        self.state().enabled()
+    }
+}
+
+/// Wrapper for a PWM chip/controller (`struct pwm_chip`).
+#[repr(transparent)]
+pub struct Chip(Opaque<bindings::pwm_chip>);
+
+impl Chip {
+    /// Creates a `Chip` reference from a raw pointer. (Safety notes apply)
+    pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::pwm_chip) -> &'a mut Self {
+        unsafe { &mut *ptr.cast::<Self>() }
+    }
+
+    /// Returns a raw pointer to the underlying `pwm_chip`.
+    pub(crate) fn as_ptr(&self) -> *mut bindings::pwm_chip {
+        self.0.get()
+    }
+
+    /// Gets the number of PWM channels (hardware PWMs) on this chip.
+    pub fn npwm(&self) -> u32 {
+        unsafe { (*self.as_ptr()).npwm }
+    }
+
+    /// Returns `true` if the chip supports atomic operations for configuration.
+    pub fn is_atomic(&self) -> bool {
+        unsafe { (*self.as_ptr()).atomic }
+    }
+
+    /// Returns a reference to the embedded `struct device` abstraction (`CoreDevice`).
+    pub fn device(&self) -> &CoreDevice {
+        // SAFETY: `dev` field exists and points to the embedded device.
+        let dev_ptr = unsafe { &(*self.as_ptr()).dev as *const _ as *mut bindings::device };
+        unsafe { &*(dev_ptr as *mut CoreDevice) }
+    }
+
+    /// Returns a reference to the parent device (`struct device`) of this PWM chip's device.
+    pub fn parent_device(&self) -> Option<&CoreDevice> {
+        // SAFETY: Accessing fields via assumed-valid pointer and bindgen layout.
+        let parent_ptr = unsafe { bindings::pwmchip_parent(self.as_ptr()) };
+        if parent_ptr.is_null() {
+            None
+        } else {
+            // SAFETY: Pointer is non-null, assume valid device managed by kernel.
+            Some(unsafe { &*(parent_ptr as *mut CoreDevice) })
+        }
+    }
+
+    /// Gets the *typed* driver-specific data associated with this chip's embedded device.
+    pub fn get_drvdata<T: 'static>(&self) -> Option<&T> {
+        let ptr = unsafe { bindings::pwmchip_get_drvdata(self.as_ptr()) };
+        if ptr.is_null() {
+            None
+        } else {
+            unsafe { Some(&*(ptr as *const T)) }
+        }
+    }
+
+    /// Sets the *typed* driver-specific data associated with this chip's embedded device.
+    pub fn set_drvdata<T: 'static + ForeignOwnable>(&mut self, data: T) {
+        unsafe { bindings::pwmchip_set_drvdata(self.as_ptr(), data.into_foreign() as _) }
+    }
+}
+
+/// Allocates a PWM chip structure using device resource management. Mirrors `devm_pwmchip_alloc`.
+pub fn devm_chip_alloc<'a>(
+    parent: &'a CoreDevice,
+    npwm: u32,
+    sizeof_priv: usize,
+) -> Result<&'a mut Chip> {
+    // SAFETY: `devm_pwmchip_alloc` called with valid args. Returns valid ptr or ERR_PTR.
+    let parent_ptr = parent as *const CoreDevice as *mut bindings::device;
+    let chip_ptr = unsafe { bindings::devm_pwmchip_alloc(parent_ptr, npwm, sizeof_priv) };
+    if unsafe { bindings::IS_ERR(chip_ptr as *const core::ffi::c_void) } {
+        let err = unsafe { bindings::PTR_ERR(chip_ptr as *const core::ffi::c_void) };
+        pr_err!("devm_pwmchip_alloc failed: {}\n", err);
+        Err(Error::from_errno(err as i32))
+    } else {
+        // SAFETY: `chip_ptr` valid, lifetime managed by `devm` tied to `parent`.
+        Ok(unsafe { &mut *(chip_ptr as *mut Chip) })
+    }
+}
+
+/// Registers a PWM chip with the PWM subsystem. Mirrors `__pwmchip_add`.
+pub fn chip_add(chip: &mut Chip, ops: &'static PwmOpsVTable) -> Result {
+    // SAFETY: Pointers are valid. `__pwmchip_add` requires ops to be set.
+    unsafe {
+        let chip_ptr = chip.as_ptr();
+        // Assign the ops pointer directly to the C struct field
+        (*chip_ptr).ops = ops.as_ptr();
+        to_result(bindings::__pwmchip_add(
+            chip_ptr,
+            core::ptr::null_mut()
+        ))
+    }
+}
+
+/// Registers a PWM chip using device resource management. Mirrors `__devm_pwmchip_add`.
+pub fn devm_chip_add(parent: &CoreDevice, chip: &mut Chip, ops: &'static PwmOpsVTable) -> Result {
+    // SAFETY: Pointers are valid. `__devm_pwmchip_add` requires ops to be set.
+    unsafe {
+        let chip_ptr = chip.as_ptr();
+        // Assign the ops pointer directly to the C struct field
+        (*chip_ptr).ops = ops.as_ptr();
+        let parent_ptr = parent as *const CoreDevice as *mut bindings::device;
+        to_result(bindings::__devm_pwmchip_add(
+            parent_ptr,
+            chip_ptr,
+            core::ptr::null_mut()
+        ))
+    }
+}
+
+/// Trait defining the operations for a PWM driver. Mirrors relevant parts of `struct pwm_ops`.
+pub trait PwmOps: 'static {
+    /// Atomically apply a new state to the PWM device. Mirrors `pwm_ops->apply`.
+    fn apply(chip: &mut Chip, pwm: &mut Device, state: &State) -> Result;
+
+    // TODO: Add other ops like request, free, capture, waveform ops if needed.
+}
+
+/// Holds the vtable for PwmOps implementations.
+struct Adapter<T: PwmOps> {
+    _p: PhantomData<T>,
+}
+
+impl<T: PwmOps> Adapter<T> {
+    // Trampoline for `apply`.
+    unsafe extern "C" fn apply_callback(
+        chip: *mut bindings::pwm_chip,
+        pwm: *mut bindings::pwm_device,
+        state: *const bindings::pwm_state, // Input state is const
+    ) -> core::ffi::c_int {
+        // SAFETY: Pointers from core are valid. Create temporary wrappers.
+        let chip_ref = unsafe { Chip::from_ptr(chip) };
+        let pwm_ref = unsafe { Device::from_ptr(pwm) };
+        // Use the reference wrapper for the const C state
+        let state_ref = State::from_c_ref(unsafe { &*state });
+
+        match T::apply(chip_ref, pwm_ref, state_ref) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+}
+
+/// VTable structure wrapper for PWM operations. Mirrors `struct pwm_ops`.
+#[repr(transparent)]
+pub struct PwmOpsVTable(Opaque<bindings::pwm_ops>);
+
+// SAFETY: Holds function pointers, no accessible mutable state via &self.
+unsafe impl Sync for PwmOpsVTable {}
+
+impl PwmOpsVTable {
+    /// Returns a raw pointer to the underlying `pwm_ops` struct.
+    pub(crate) fn as_ptr(&self) -> *const bindings::pwm_ops {
+        self.0.get()
+    }
+}
+
+/// Creates a PWM operations vtable for a type `T` that implements `PwmOps`.
+///
+/// This is used to bridge Rust trait implementations to the C `struct pwm_ops`
+/// expected by the kernel.
+pub const fn create_pwm_ops<T: PwmOps>() -> PwmOpsVTable {
+    let mut ops: bindings::pwm_ops = unsafe { core::mem::zeroed() };
+
+    ops.apply = Some(Adapter::<T>::apply_callback);
+
+    PwmOpsVTable(Opaque::new(ops))
+}

-- 
2.34.1


