Return-Path: <linux-pwm+bounces-6280-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABC4AD3833
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF339E525F
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371332DFA26;
	Tue, 10 Jun 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BYdBzJls"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E52D4B72
	for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560023; cv=none; b=G7Z/Ib9fKdFBfMcj6NfO1HP0nzY1SkDeB/iZdaeD4Z+mojB8DpUGmnRDukjoVzZssh3iqL5KPuoZajLfkuzLBNtd5YCBnrDaq5zuryagpvRuAe5fFU74/veXVAPeCt+OnC52c2yZ+OgCcByvZpmkoGDCl9+K21uhbQwkMgPDQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560023; c=relaxed/simple;
	bh=uu1ICBCvjDVZqf0CSaxS0dFjXYTB7w47PthcJ/AVjh0=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=A4Imnq5py/0yAhNKQmbazqnof5TkgdQmIFwE55W7juvKqtETUZKRFLRe9ZBvPXXN0tkfl+aAFLwX27ZvxWHPtZc3P0m9BL2DDtaWaB5I9CwLhr4iZDWZCZLJFeY79af27Ku+XYd2k3jsaRbgbqD+10zxb57QeyG9m7aUEMGUKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BYdBzJls; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250610125332euoutp018255711d0c5af7b4da61bc3ff8f3dc4e~Hr4-nTA_20939609396euoutp01a
	for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 12:53:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250610125332euoutp018255711d0c5af7b4da61bc3ff8f3dc4e~Hr4-nTA_20939609396euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1749560012;
	bh=SlvixoLgo7166EMoVtRGLcHTj2lOCLeU5xYXQU6Q38Y=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=BYdBzJlsPRs4bO4dkMhixuhjWkWEl6dsIi8QsANLaUb512pJykL/EDr9qDmoCEXZz
	 RlBVzygWMgo1zsIV6J/HmO08/hjMGK2ipWzUw85p5sDKc/tlZ9BjwRjAO3KKaeHOAM
	 Yzn0Y3Gl1scTed0/FnYhZPBMQ9+23D1UXTut5u/8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250610125332eucas1p2da441aa44760236527afc82495af95d1~Hr4_5eA5w1177811778eucas1p2z;
	Tue, 10 Jun 2025 12:53:32 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250610125330eusmtip1020b3091342afe55161202b2809bcb66~Hr49rpmA_0451804518eusmtip1C;
	Tue, 10 Jun 2025 12:53:30 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 10 Jun 2025 14:52:49 +0200
Subject: [PATCH v2 1/7] rust: Add basic PWM abstractions
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-rust-next-pwm-working-fan-for-sending-v2-1-753e2955f110@samsung.com>
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
X-CMS-MailID: 20250610125332eucas1p2da441aa44760236527afc82495af95d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250610125332eucas1p2da441aa44760236527afc82495af95d1
X-EPHeader: CA
X-CMS-RootMailID: 20250610125332eucas1p2da441aa44760236527afc82495af95d1
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
	<CGME20250610125332eucas1p2da441aa44760236527afc82495af95d1@eucas1p2.samsung.com>

Introduce safe Rust abstractions for the Linux PWM subsystem. These
abstractions provide ergonomic, lifetime managed wrappers around the
core C data structures and functions, enabling the development of PWM
chip drivers in safe Rust.

This initial version provides the core building blocks for writing a PWM
chip provider driver, with a focus on safety, resource management, and
idiomatic Rust patterns.

The main components are:

Ownership and Lifetime Management:
 - The pwm::Chip type, an ARef managed wrapper for struct pwm_chip,
   correctly handles the object's lifetime by using the embedded struct
   device's reference counter.
 - A pwm::Registration RAII guard ensures that a call to register a
   chip (pwmchip_add) is always paired with a call to unregister it
   (pwmchip_remove), preventing resource leaks.

Safe Type Wrappers:
 - Safe, idiomatic Rust types (Polarity, Waveform, State, Args,
   Device) are provided to abstract away the raw C structs and enums.
   The State wrapper holds its data by value, avoiding unnecessary
   heap allocations.

Driver Operations (PwmOps):
 - A generic PwmOps trait allows drivers to implement the standard
   PWM operations. It uses an associated type (WfHw) for the driver's
   hardware specific waveform data, moving unsafe serialization logic into
   the abstraction layer.
   The trait exposes the modern waveform API (round_waveform_tohw,
   write_waveform, etc.) as well as the other standard kernel callbacks
   (get_state, request, apply).
 - A create_pwm_ops function generates a C-compatible vtable from a
   PwmOps implementor.

This foundational layer is designed to be used by subsequent patches to
implement specific PWM chip drivers in Rust.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 MAINTAINERS                     |   6 +
 drivers/pwm/Kconfig             |  13 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/pwm.c              |  20 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/pwm.rs              | 864 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 907 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2668b81115cb85bc94275e9554330969989fabf..5589c0d2253bcb04e78d7b89ef6ef0ed41121d77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19990,6 +19990,12 @@ F:	include/linux/pwm.h
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
index d9bcd1e8413eaed1602d6686873e263767c58f5f..03c5a100a03e2acdccf8a46b9c70b736b630bd3a 100644
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
+          subsystem. It provides idiomatic wrappers and traits necessary for
+          writing PWM controller drivers in Rust.
+
+          The abstractions handle resource management (like memory and reference
+          counting) and provide safe interfaces to the underlying C core,
+          allowing driver logic to be written in safe Rust.
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
index 0f1b5d11598591bc62bb6439747211af164b76d6..73902d8bd87e93cb3bc3c501360c37e29e8dde19 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -30,6 +30,7 @@
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
index d652c92633b82525f37e5cd8a040d268e0c191d1..d634593d5e8084049cc22daadb5019de139599fe 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -106,6 +106,8 @@
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
index 0000000000000000000000000000000000000000..b5839703c49ed7b9aa61723a7e506f5cb4dd665d
--- /dev/null
+++ b/rust/kernel/pwm.rs
@@ -0,0 +1,864 @@
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
+    device::{self, Bound},
+    error::{self, to_result, Result},
+    prelude::*,
+    str::CStr,
+    types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
+};
+use core::{marker::PhantomData, mem::ManuallyDrop, ptr::NonNull};
+
+/// Maximum size for the hardware-specific waveform representation buffer.
+/// From C: #define WFHWSIZE 20
+pub const WFHW_MAX_SIZE: usize = 20;
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
+            _ => Polarity::Normal,
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
+/// Represents a PWM waveform configuration. Mirrors struct pwm_waveform.
+#[derive(Copy, Clone, Debug, Default, PartialEq, Eq)]
+pub struct Waveform {
+    /// Total duration of one complete PWM cycle, in nanoseconds.
+    pub period_length_ns: u64,
+
+    /// Duration the PWM signal is in its "active" state during one period,
+    /// in nanoseconds. For a typical "normal" polarity configuration where active is high,
+    /// this represents the high time of the signal.
+    pub duty_length_ns: u64,
+
+    /// Time delay from the start of the period to the first active edge
+    /// of the duty cycle, in nanoseconds. For many simpler PWM configurations,
+    /// this is 0, meaning the duty cycle's active phase starts at the beginning
+    /// of the period.
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
+/// Wrapper for board-dependent PWM arguments (`struct pwm_args`).
+#[repr(transparent)]
+pub struct Args(Opaque<bindings::pwm_args>);
+
+impl Args {
+    /// Creates an `Args` wrapper from a C struct pointer.
+    ///
+    /// # Safety
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
+    pub fn polarity(&self) -> Polarity {
+        // SAFETY: `self.0.get()` returns a pointer to the `bindings::pwm_args`
+        // managed by the `Opaque` wrapper. This pointer is guaranteed to be
+        // valid and aligned for the lifetime of `self`.
+        let raw_polarity = unsafe { (*self.0.get()).polarity };
+        Polarity::from(raw_polarity)
+    }
+}
+
+/// Wrapper for PWM state (`struct pwm_state`).
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
+    pub fn polarity(&self) -> Polarity {
+        Polarity::from(self.0.polarity)
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
+
+/// Wrapper for a PWM device/channel (`struct pwm_device`).
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::pwm_device>);
+
+impl Device {
+    /// Creates a temporary `&mut Device` from a raw C pointer for use in callbacks.
+    ///
+    /// It returns a mutable reference (`&mut Self`) because the underlying C APIs
+    /// for PWM operations use non-const pointers (`struct pwm_device *`). This
+    /// signals that the functions in the vtable are permitted to mutate the
+    /// device's state (e.g., by writing to hardware registers). Using `&mut`
+    /// allows the `PwmOps` trait to accurately model this behavior and leverage
+    /// Rust's aliasing rules for greater safety.
+    ///
+    /// # Safety
+    /// The caller must ensure that `ptr` is a valid, non-null pointer to
+    /// `bindings::pwm_device` that is properly initialized.
+    /// The `pwm_device` must remain valid for the lifetime `'a`.
+    /// The caller must also ensure that Rust's aliasing rules are upheld.
+    pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::pwm_device) -> &'a mut Self {
+        // SAFETY: Caller guarantees `ptr` is valid and meets lifetime/aliasing.
+        // `Self` is `#[repr(transparent)]`, so casting is valid.
+        unsafe { &mut *ptr.cast::<Self>() }
+    }
+
+    /// Returns a raw pointer to the underlying `pwm_device`.
+    fn as_raw(&self) -> *mut bindings::pwm_device {
+        self.0.get()
+    }
+
+    /// Gets the hardware PWM index for this device within its chip.
+    pub fn hwpwm(&self) -> u32 {
+        // SAFETY: `self.as_raw()` provides a valid pointer for `self`'s lifetime.
+        unsafe { (*self.as_raw()).hwpwm }
+    }
+
+    /// Gets a reference to the parent `Chip` that this device belongs to.
+    pub fn chip(&self) -> &Chip {
+        // SAFETY: `self.as_raw()` provides a valid pointer. (*self.as_raw()).chip
+        // is assumed to be a valid pointer to `pwm_chip` managed by the kernel.
+        // Chip::from_ptr's safety conditions must be met.
+        unsafe { Chip::from_ptr((*self.as_raw()).chip) }
+    }
+
+    /// Gets the label for this PWM device, if any.
+    pub fn label(&self) -> Option<&CStr> {
+        // SAFETY: self.as_raw() provides a valid pointer.
+        let label_ptr = unsafe { (*self.as_raw()).label };
+        if label_ptr.is_null() {
+            None
+        } else {
+            // SAFETY: label_ptr is non-null and points to a C string
+            // managed by the kernel, valid for the lifetime of the PWM device.
+            Some(unsafe { CStr::from_char_ptr(label_ptr) })
+        }
+    }
+
+    /// Gets a copy of the board-dependent arguments for this PWM device.
+    pub fn args(&self) -> Args {
+        // SAFETY: self.as_raw() gives a valid pointer to `pwm_device`.
+        // The `args` field is a valid `pwm_args` struct embedded within `pwm_device`.
+        // `Args::from_c_ptr`'s safety conditions are met by providing this pointer.
+        unsafe { Args::from_c_ptr(&(*self.as_raw()).args) }
+    }
+
+    /// Gets a copy of the current state of this PWM device.
+    pub fn state(&self) -> State {
+        // SAFETY: `self.as_raw()` gives a valid pointer. `(*self.as_raw()).state`
+        // is a valid `pwm_state` struct. `State::from_c` copies this data.
+        State::from_c(unsafe { (*self.as_raw()).state })
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
+    /// Creates a temporary `&mut Chip` from a raw C pointer for use in callbacks.
+    ///
+    /// It returns a mutable reference (`&mut Self`) because the underlying C APIs
+    /// for PWM operations use non-const pointers (`struct pwm_chip *`). This
+    /// signals that the functions in the vtable are permitted to mutate the
+    /// chip's state (e.g., by calling `set_drvdata` or through operations that
+    /// modify hardware registers). Using `&mut` is essential for these cases.
+    ///
+    /// # Safety
+    /// The caller must ensure that `ptr` is a valid, non-null pointer to
+    /// `bindings::pwm_chip` that is properly initialized.
+    /// The `pwm_chip` must remain valid for the lifetime `'a`.
+    /// The caller must also ensure that Rust's aliasing rules are upheld.
+    pub(crate) unsafe fn from_ptr<'a>(ptr: *mut bindings::pwm_chip) -> &'a mut Self {
+        // SAFETY: Caller guarantees `ptr` is valid and meets lifetime/aliasing.
+        // `Self` is `#[repr(transparent)]`, so casting is valid.
+        unsafe { &mut *ptr.cast::<Self>() }
+    }
+
+    /// Returns a raw pointer to the underlying `pwm_chip`.
+    pub(crate) fn as_raw(&self) -> *mut bindings::pwm_chip {
+        self.0.get()
+    }
+
+    /// Gets the number of PWM channels (hardware PWMs) on this chip.
+    pub fn npwm(&self) -> u32 {
+        // SAFETY: `self.as_raw()` provides a valid pointer for `self`'s lifetime.
+        unsafe { (*self.as_raw()).npwm }
+    }
+
+    /// Returns `true` if the chip supports atomic operations for configuration.
+    pub fn is_atomic(&self) -> bool {
+        // SAFETY: `self.as_raw()` provides a valid pointer for `self`'s lifetime.
+        unsafe { (*self.as_raw()).atomic }
+    }
+
+    /// Returns a reference to the embedded `struct device` abstraction.
+    pub fn device(&self) -> &device::Device {
+        // SAFETY: `self.as_raw()` provides a valid pointer to `bindings::pwm_chip`.
+        // The `dev` field is an instance of `bindings::device` embedded within `pwm_chip`.
+        // Taking a pointer to this embedded field is valid.
+        // `device::Device` is `#[repr(transparent)]`.
+        // The lifetime of the returned reference is tied to `self`.
+        let dev_field_ptr = unsafe { core::ptr::addr_of!((*self.as_raw()).dev) };
+        // SAFETY: `dev_field_ptr` is a valid pointer to `bindings::device`.
+        // Casting and dereferencing is safe due to `repr(transparent)` and lifetime.
+        unsafe { &*(dev_field_ptr.cast::<device::Device>()) }
+    }
+
+    /// Returns a reference to the parent device of this PWM chip's device.
+    pub fn parent_device(&self) -> Option<&device::Device> {
+        self.device().parent()
+    }
+
+    /// Gets the *typed* driver-specific data associated with this chip's embedded device.
+    pub fn drvdata<T: 'static>(&self) -> Option<&T> {
+        // SAFETY: `self.as_raw()` gives a valid pwm_chip pointer.
+        // `bindings::pwmchip_get_drvdata` is the C function to retrieve driver data.
+        let ptr = unsafe { bindings::pwmchip_get_drvdata(self.as_raw()) };
+        if ptr.is_null() {
+            None
+        } else {
+            // SAFETY: `ptr` is non-null. Caller ensures `T` is the correct type.
+            // Lifetime of data is managed by the driver that set it.
+            unsafe { Some(&*(ptr.cast::<T>())) }
+        }
+    }
+
+    /// Sets the *typed* driver-specific data associated with this chip's embedded device.
+    pub fn set_drvdata<T: 'static + ForeignOwnable>(&self, data: T) {
+        // SAFETY: `self.as_raw()` gives a valid pwm_chip pointer.
+        // `bindings::pwmchip_set_drvdata` is the C function to set driver data.
+        // `data.into_foreign()` provides a valid `*mut c_void`.
+        unsafe { bindings::pwmchip_set_drvdata(self.as_raw(), data.into_foreign().cast()) }
+    }
+
+    /// Allocates and wraps a PWM chip using `bindings::pwmchip_alloc`.
+    ///
+    /// Returns an `ARef<Chip>` managing the chip's lifetime via refcounting
+    /// on its embedded `struct device`.
+    pub fn new(parent_dev: &device::Device, npwm: u32, sizeof_priv: usize) -> Result<ARef<Self>> {
+        // SAFETY: `parent_device_for_dev_field.as_raw()` is valid.
+        // `bindings::pwmchip_alloc` returns a valid `*mut bindings::pwm_chip` (refcount 1)
+        // or an ERR_PTR.
+        let c_chip_ptr_raw =
+            unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), npwm, sizeof_priv) };
+
+        let c_chip_ptr: *mut bindings::pwm_chip = error::from_err_ptr(c_chip_ptr_raw)?;
+
+        // Cast the `*mut bindings::pwm_chip` to `*mut Chip`. This is valid because
+        // `Chip` is `repr(transparent)` over `Opaque<bindings::pwm_chip>`, and
+        // `Opaque<T>` is `repr(transparent)` over `T`.
+        let chip_ptr_as_self = c_chip_ptr.cast::<Self>();
+
+        // SAFETY: `chip_ptr_as_self` points to a valid `Chip` (layout-compatible with
+        // `bindings::pwm_chip`) whose embedded device has refcount 1.
+        // `ARef::from_raw` takes this pointer and manages it via `AlwaysRefCounted`.
+        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) })
+    }
+}
+
+// SAFETY: Implements refcounting for `Chip` using the embedded `struct device`.
+unsafe impl AlwaysRefCounted for Chip {
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `self` exists.
+        // The embedded `dev` is valid. `get_device` increments its refcount.
+        unsafe {
+            bindings::get_device(core::ptr::addr_of_mut!((*self.0.get()).dev));
+        }
+    }
+
+    #[inline]
+    unsafe fn dec_ref(obj: NonNull<Chip>) {
+        let c_chip_ptr = obj.cast::<bindings::pwm_chip>().as_ptr();
+
+        // SAFETY: `obj` is a valid pointer to a `Chip` (and thus `bindings::pwm_chip`)
+        // with a non-zero refcount. `put_device` handles decrement and final release.
+        unsafe {
+            bindings::put_device(core::ptr::addr_of_mut!((*c_chip_ptr).dev));
+        }
+    }
+}
+
+// SAFETY: `Chip` is a wrapper around `*mut bindings::pwm_chip`. The underlying C
+// structure's state is managed and synchronized by the kernel's device model
+// and PWM core locking mechanisms. Therefore, it is safe to move the `Chip`
+// wrapper (and the pointer it contains) across threads.
+unsafe impl Send for Chip {}
+
+// SAFETY: It is safe for multiple threads to have shared access (`&Chip`) because
+// the `Chip` data is immutable from the Rust side without holding the appropriate
+// kernel locks, which the C core is responsible for. Any interior mutability is
+// handled and synchronized by the C kernel code.
+unsafe impl Sync for Chip {}
+
+/// Manages the registration of a PWM chip, ensuring `pwmchip_remove` is called on drop.
+pub struct Registration {
+    chip: ManuallyDrop<ARef<Chip>>,
+}
+
+impl Registration {
+    /// Registers a PWM chip (obtained via `Chip::new`) with the PWM subsystem.
+    ///
+    /// Takes an `ARef<Chip>`. On `Drop` of the returned `Registration` object,
+    /// `pwmchip_remove` is called for the chip.
+    pub fn new(chip: ARef<Chip>, ops_vtable: &'static PwmOpsVTable) -> Result<Self> {
+        // Get the raw C pointer from ARef<Chip>.
+        let c_chip_ptr = chip.as_raw().cast::<bindings::pwm_chip>();
+
+        // SAFETY: `c_chip_ptr` is valid (guaranteed by ARef existing).
+        // `ops_vtable.as_raw()` provides a valid `*const bindings::pwm_ops`.
+        // `bindings::__pwmchip_add` preconditions (valid pointers, ops set on chip) are met.
+        unsafe {
+            (*c_chip_ptr).ops = ops_vtable.as_raw();
+            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
+        }
+        Ok(Registration {
+            chip: ManuallyDrop::new(chip),
+        })
+    }
+}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        let chip = &**self.chip;
+        let chip_raw: *mut bindings::pwm_chip = chip.as_raw();
+
+        // SAFETY: `chip_raw` points to a chip that was successfully registered via `Self::new`.
+        // `bindings::pwmchip_remove` is the correct C function to unregister it.
+        unsafe {
+            bindings::pwmchip_remove(chip_raw);
+            ManuallyDrop::drop(&mut self.chip); // Drops the ARef<Chip>
+        }
+    }
+}
+
+/// Trait defining the operations for a PWM driver.
+pub trait PwmOps: 'static + Sized {
+    /// The driver-specific hardware representation of a waveform.
+    /// This type must be `Copy`, `Default`, and fit within `WFHW_MAX_SIZE`.
+    type WfHw: Copy + Default;
+
+    /// Optional hook to atomically apply a new PWM config.
+    fn apply(
+        _chip: &mut Chip,
+        _pwm: &mut Device,
+        _state: &State,
+        _parent_dev: &device::Device<Bound>,
+    ) -> Result {
+        Err(ENOTSUPP)
+    }
+
+    /// Optional hook for when a PWM device is requested.
+    fn request(_chip: &mut Chip, _pwm: &mut Device, _parent_dev: &device::Device<Bound>) -> Result {
+        Ok(())
+    }
+
+    /// Optional hook for when a PWM device is freed.
+    fn free(_chip: &mut Chip, _pwm: &mut Device, _parent_dev: &device::Device<Bound>) {}
+
+    /// Optional hook for capturing a PWM signal.
+    fn capture(
+        _chip: &mut Chip,
+        _pwm: &mut Device,
+        _result: &mut bindings::pwm_capture,
+        _timeout: usize,
+        _parent_dev: &device::Device<Bound>,
+    ) -> Result {
+        Err(ENOTSUPP)
+    }
+
+    /// Optional hook to get the current hardware state.
+    fn get_state(
+        _chip: &mut Chip,
+        _pwm: &mut Device,
+        _state: &mut State,
+        _parent_dev: &device::Device<Bound>,
+    ) -> Result {
+        Err(ENOTSUPP)
+    }
+
+    /// Convert a generic waveform to the hardware-specific representation.
+    /// This is typically a pure calculation and does not perform I/O.
+    fn round_waveform_tohw(
+        _chip: &mut Chip,
+        _pwm: &mut Device,
+        _wf: &Waveform,
+    ) -> Result<(i32, Self::WfHw)> {
+        Err(ENOTSUPP)
+    }
+
+    /// Convert a hardware-specific representation back to a generic waveform.
+    /// This is typically a pure calculation and does not perform I/O.
+    fn round_waveform_fromhw(
+        _chip: &mut Chip,
+        _pwm: &Device,
+        _wfhw: &Self::WfHw,
+        _wf: &mut Waveform,
+    ) -> Result<i32> {
+        Err(ENOTSUPP)
+    }
+
+    /// Read the current hardware configuration into the hardware-specific representation.
+    fn read_waveform(
+        _chip: &mut Chip,
+        _pwm: &mut Device,
+        _parent_dev: &device::Device<Bound>,
+    ) -> Result<Self::WfHw> {
+        Err(ENOTSUPP)
+    }
+
+    /// Write a hardware-specific waveform configuration to the hardware.
+    fn write_waveform(
+        _chip: &mut Chip,
+        _pwm: &mut Device,
+        _wfhw: &Self::WfHw,
+        _parent_dev: &device::Device<Bound>,
+    ) -> Result {
+        Err(ENOTSUPP)
+    }
+}
+/// Bridges Rust `PwmOps` to the C `pwm_ops` vtable.
+struct Adapter<T: PwmOps> {
+    _p: PhantomData<T>,
+}
+
+impl<T: PwmOps> Adapter<T> {
+    /// # Safety
+    /// `wfhw_ptr` must be valid for writes of `size_of::<T::WfHw>()` bytes.
+    unsafe fn serialize_wfhw(wfhw: &T::WfHw, wfhw_ptr: *mut core::ffi::c_void) -> Result {
+        let size = core::mem::size_of::<T::WfHw>();
+        if size > WFHW_MAX_SIZE {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The caller ensures `wfhw_ptr` is valid for `size` bytes.
+        unsafe {
+            core::ptr::copy_nonoverlapping(wfhw as *const _ as *const u8, wfhw_ptr.cast(), size);
+        }
+
+        Ok(())
+    }
+
+    /// # Safety
+    /// `wfhw_ptr` must be valid for reads of `size_of::<T::WfHw>()` bytes.
+    unsafe fn deserialize_wfhw(wfhw_ptr: *const core::ffi::c_void) -> Result<T::WfHw> {
+        let size = core::mem::size_of::<T::WfHw>();
+        if size > WFHW_MAX_SIZE {
+            return Err(EINVAL);
+        }
+
+        let mut wfhw = T::WfHw::default();
+        // SAFETY: The caller ensures `wfhw_ptr` is valid for `size` bytes.
+        unsafe {
+            core::ptr::copy_nonoverlapping(wfhw_ptr.cast(), &mut wfhw as *mut _ as *mut u8, size);
+        }
+
+        Ok(wfhw)
+    }
+
+    /// # Safety
+    /// C-callback. Pointers from C must be valid.
+    unsafe extern "C" fn apply_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        s: *const bindings::pwm_state,
+    ) -> i32 {
+        // SAFETY: This block relies on the function's safety contract: the C caller
+        // provides valid pointers. `Chip::from_ptr` and `Device::from_ptr` are `unsafe fn`
+        // whose preconditions are met by this contract.
+        let (chip, pwm) = unsafe { (Chip::from_ptr(c), Device::from_ptr(p)) };
+        let parent_dev = match chip.parent_device() {
+            Some(dev) => dev,
+            None => {
+                return EINVAL.to_errno();
+            }
+        };
+
+        // SAFETY: The PWM core guarantees callbacks only happen on a live, bound device.
+        let bound_parent =
+            unsafe { &*(parent_dev as *const device::Device as *const device::Device<Bound>) };
+
+        // SAFETY: The state provided by the callback is guaranteed to be valid
+        let state = State::from_c(unsafe { *s });
+        match T::apply(chip, pwm, &state, bound_parent) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// C-callback. Pointers from C must be valid.
+    unsafe extern "C" fn request_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+    ) -> i32 {
+        // SAFETY: PWM core guarentees `c` and `p` are valid pointers.
+        let (chip, pwm) = unsafe { (Chip::from_ptr(c), Device::from_ptr(p)) };
+        let parent_dev = match chip.parent_device() {
+            Some(dev) => dev,
+            None => {
+                return EINVAL.to_errno();
+            }
+        };
+
+        let bound_parent =
+	// SAFETY: The PWM core guarantees the device is bound during callbacks.
+            unsafe { &*(parent_dev as *const device::Device as *const device::Device<Bound>) };
+        match T::request(chip, pwm, bound_parent) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// C-callback. Pointers from C must be valid.
+    unsafe extern "C" fn free_callback(c: *mut bindings::pwm_chip, p: *mut bindings::pwm_device) {
+        // SAFETY: Relies on the function's contract that `c` and `p` are valid pointers.
+        let (chip, pwm) = unsafe { (Chip::from_ptr(c), Device::from_ptr(p)) };
+        let parent_dev = match chip.parent_device() {
+            Some(dev) => dev,
+            None => {
+                return;
+            }
+        };
+
+        let bound_parent =
+	// SAFETY: The PWM core guarantees the device is bound during callbacks.
+            unsafe { &*(parent_dev as *const device::Device as *const device::Device<Bound>) };
+        T::free(chip, pwm, bound_parent);
+    }
+
+    /// # Safety
+    /// C-callback. Pointers from C must be valid.
+    unsafe extern "C" fn capture_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        res: *mut bindings::pwm_capture,
+        timeout: usize,
+    ) -> i32 {
+        // SAFETY: Relies on the function's contract that `c` and `p` are valid pointers.
+        let (chip, pwm, result) = unsafe { (Chip::from_ptr(c), Device::from_ptr(p), &mut *res) };
+        let parent_dev = match chip.parent_device() {
+            Some(dev) => dev,
+            None => {
+                return EINVAL.to_errno();
+            }
+        };
+
+        let bound_parent =
+	        // SAFETY: The PWM core guarantees the device is bound during callbacks.
+            unsafe { &*(parent_dev as *const device::Device as *const device::Device<Bound>) };
+        match T::capture(chip, pwm, result, timeout, bound_parent) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// C-callback. Pointers from C must be valid.
+    unsafe extern "C" fn get_state_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        s: *mut bindings::pwm_state,
+    ) -> i32 {
+        // SAFETY: Relies on the function's contract that `c` and `p` are valid pointers.
+        let (chip, pwm) = unsafe { (Chip::from_ptr(c), Device::from_ptr(p)) };
+        let parent_dev = match chip.parent_device() {
+            Some(dev) => dev,
+            None => {
+                return EINVAL.to_errno();
+            }
+        };
+        let bound_parent =
+	// SAFETY: The PWM core guarantees the device is bound during callbacks.
+            unsafe { &*(parent_dev as *const device::Device as *const device::Device<Bound>) };
+        let mut rust_state = State::new();
+        match T::get_state(chip, pwm, &mut rust_state, bound_parent) {
+            Ok(()) => {
+                // SAFETY: `s` is guaranteed valid by the C caller.
+                unsafe {
+                    *s = rust_state.0;
+                };
+                0
+            }
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// C-callback. Pointers from C must be valid.
+    unsafe extern "C" fn round_waveform_tohw_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        w: *const bindings::pwm_waveform,
+        wh: *mut core::ffi::c_void,
+    ) -> i32 {
+        // SAFETY: Relies on the function's contract that `c` and `p` are valid pointers.
+        let (chip, pwm, wf) =
+            unsafe { (Chip::from_ptr(c), Device::from_ptr(p), Waveform::from(*w)) };
+        match T::round_waveform_tohw(chip, pwm, &wf) {
+            Ok((status, wfhw)) => {
+                // SAFETY: `wh` is valid per this function's safety contract.
+                if unsafe { Self::serialize_wfhw(&wfhw, wh) }.is_err() {
+                    return EINVAL.to_errno();
+                }
+                status
+            }
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// C-callback. Pointers from C must be valid.
+    unsafe extern "C" fn round_waveform_fromhw_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        wh: *const core::ffi::c_void,
+        w: *mut bindings::pwm_waveform,
+    ) -> i32 {
+        // SAFETY: Relies on the function's contract that `c` and `p` are valid pointers.
+        let (chip, pwm) = unsafe { (Chip::from_ptr(c), Device::from_ptr(p)) };
+        // SAFETY: `deserialize_wfhw`'s safety contract is met by this function's contract.
+        let wfhw = match unsafe { Self::deserialize_wfhw(wh) } {
+            Ok(v) => v,
+            Err(e) => return e.to_errno(),
+        };
+
+        let mut rust_wf = Waveform::default();
+        match T::round_waveform_fromhw(chip, pwm, &wfhw, &mut rust_wf) {
+            Ok(ret) => {
+                // SAFETY: `w` is guaranteed valid by the C caller.
+                unsafe {
+                    *w = rust_wf.into();
+                };
+                ret
+            }
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// C-callback. Pointers from C must be valid.
+    unsafe extern "C" fn read_waveform_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        wh: *mut core::ffi::c_void,
+    ) -> i32 {
+        // SAFETY: Relies on the function's contract that `c` and `p` are valid pointers.
+        let (chip, pwm) = unsafe { (Chip::from_ptr(c), Device::from_ptr(p)) };
+        let parent_dev = match chip.parent_device() {
+            Some(dev) => dev,
+            None => {
+                return EINVAL.to_errno();
+            }
+        };
+
+        let bound_parent =
+	// SAFETY: The PWM core guarantees the device is bound during callbacks.
+            unsafe { &*(parent_dev as *const device::Device as *const device::Device<Bound>) };
+        match T::read_waveform(chip, pwm, bound_parent) {
+            // SAFETY: `wh` is valid per this function's safety contract.
+            Ok(wfhw) => match unsafe { Self::serialize_wfhw(&wfhw, wh) } {
+                Ok(()) => 0,
+                Err(e) => e.to_errno(),
+            },
+            Err(e) => e.to_errno(),
+        }
+    }
+
+    /// # Safety
+    /// C-callback. Pointers from C must be valid.
+    unsafe extern "C" fn write_waveform_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        wh: *const core::ffi::c_void,
+    ) -> i32 {
+        // SAFETY: Relies on the function's contract that `c` and `p` are valid pointers.
+        let (chip, pwm) = unsafe { (Chip::from_ptr(c), Device::from_ptr(p)) };
+        let parent_dev = match chip.parent_device() {
+            Some(dev) => dev,
+            None => {
+                return EINVAL.to_errno();
+            }
+        };
+
+        let bound_parent =
+	        // SAFETY: The PWM core guarantees the device is bound during callbacks.
+            unsafe { &*(parent_dev as *const device::Device as *const device::Device<Bound>) };
+        // SAFETY: `wh` is valid per this function's safety contract.
+        let wfhw = match unsafe { Self::deserialize_wfhw(wh) } {
+            Ok(v) => v,
+            Err(e) => return e.to_errno(),
+        };
+        match T::write_waveform(chip, pwm, &wfhw, bound_parent) {
+            Ok(()) => 0,
+            Err(e) => e.to_errno(),
+        }
+    }
+}
+/// VTable structure wrapper for PWM operations. Mirrors `struct pwm_ops`.
+#[repr(transparent)]
+pub struct PwmOpsVTable(Opaque<bindings::pwm_ops>);
+
+// SAFETY: PwmOpsVTable is Send. The vtable contains only function pointers
+// and a size, which are simple data types that can be safely moved across
+// threads. The thread-safety of calling these functions is handled by the
+// kernel's locking mechanisms.
+unsafe impl Send for PwmOpsVTable {}
+// SAFETY: PwmOpsVTable is Sync. The vtable is immutable after it is created,
+// so it can be safely referenced and accessed concurrently by multiple threads
+// e.g. to read the function pointers.
+unsafe impl Sync for PwmOpsVTable {}
+
+impl PwmOpsVTable {
+    /// Returns a raw pointer to the underlying `pwm_ops` struct.
+    pub(crate) fn as_raw(&self) -> *const bindings::pwm_ops {
+        self.0.get()
+    }
+}
+
+/// Creates a PWM operations vtable for a type `T` that implements `PwmOps`.
+///
+/// This is used to bridge Rust trait implementations to the C `struct pwm_ops`
+/// expected by the kernel.
+pub const fn create_pwm_ops<T: PwmOps>() -> PwmOpsVTable {
+    // SAFETY: `core::mem::zeroed()` is unsafe. For `pwm_ops`, all fields are
+    // `Option<extern "C" fn(...)>` or data, so a zeroed pattern (None/0) is valid initially.
+    let mut ops: bindings::pwm_ops = unsafe { core::mem::zeroed() };
+
+    ops.apply = Some(Adapter::<T>::apply_callback);
+    ops.request = Some(Adapter::<T>::request_callback);
+    ops.free = Some(Adapter::<T>::free_callback);
+    ops.capture = Some(Adapter::<T>::capture_callback);
+    ops.get_state = Some(Adapter::<T>::get_state_callback);
+
+    ops.round_waveform_tohw = Some(Adapter::<T>::round_waveform_tohw_callback);
+    ops.round_waveform_fromhw = Some(Adapter::<T>::round_waveform_fromhw_callback);
+    ops.read_waveform = Some(Adapter::<T>::read_waveform_callback);
+    ops.write_waveform = Some(Adapter::<T>::write_waveform_callback);
+    ops.sizeof_wfhw = core::mem::size_of::<T::WfHw>();
+
+    PwmOpsVTable(Opaque::new(ops))
+}

-- 
2.34.1


