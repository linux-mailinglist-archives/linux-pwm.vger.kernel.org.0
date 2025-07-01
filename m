Return-Path: <linux-pwm+bounces-6666-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47221AEFEE0
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365D218868E9
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 16:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD427EFE7;
	Tue,  1 Jul 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sFLQpUrE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C627E042
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385728; cv=none; b=SFiESHN2tbZIJNNFD0CWdhs3e5OjmxT4rJCndhtsWEHvu8fEJxVAV15J0HyAgqs/GzXA6evsGnHEaazgek3JTGXSqAzWVxjNFdDkKDjIB5tt0uayJf4S3gFZgckbt+7sLfpxY5m9j6ss0WHt/4nux6h8hQevKgEkfsQkkgXnnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385728; c=relaxed/simple;
	bh=nE61Uw/qTZmpc/kn0nklyAcOdMiEotFRbm3pCw2gIKk=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=bcPy9hNsyUgiuzi38iOwPNnWLPV2aqHbOA1rWfHiKJ9wTlM7Pp94k8YtKBYPyLh9epp1lf4+WnclwFnIjMZsiI2dPuNf42Wf/pXO8Lc0CXShRm7GX8r3u3NGLEub7kY5gbD3UvPXPUp2xeANiv2uim5i11yy5IQ1Jru+ExS4V3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sFLQpUrE; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250701160202euoutp029a130d6c3534e14e93cd97329c9e791c~OLAj7UDGt3181331813euoutp02K
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 16:02:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250701160202euoutp029a130d6c3534e14e93cd97329c9e791c~OLAj7UDGt3181331813euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751385722;
	bh=LHJg7ZQs8tMUCQhQbLIi/7KGtk7RrMfqcwEOOjEX5Ek=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=sFLQpUrET7HmpWkpVClAh2526FpbU+3gNc4sD3ToYSTBpcsIzjpuRyqIAlJLmDymf
	 bh3L3GVgPJBeZaVbiy0zlTEvUwTNg10B4/kaBbVs6h//z2JAkSGIX6pJHjV8tl6zz8
	 tXyM205s3lHIjQpdbTG3uF6Qs1PH6JrYB/VSYR7g=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250701160201eucas1p14d4182ecd8d6b2034f55ed5262bac646~OLAjSnMcA2257022570eucas1p1v;
	Tue,  1 Jul 2025 16:02:01 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250701160200eusmtip1f45de6d955f1c8f4a46577a3741a17d1~OLAiFODUz2322723227eusmtip1I;
	Tue,  1 Jul 2025 16:02:00 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 01 Jul 2025 18:01:40 +0200
Subject: [PATCH v6 3/8] rust: pwm: Add core 'Device' and 'Chip' object
 wrappers
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-rust-next-pwm-working-fan-for-sending-v6-3-2710932f6f6b@samsung.com>
In-Reply-To: <20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com>
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
	Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Benno
	Lossin <lossin@kernel.org>,  Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250701160201eucas1p14d4182ecd8d6b2034f55ed5262bac646
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250701160201eucas1p14d4182ecd8d6b2034f55ed5262bac646
X-EPHeader: CA
X-CMS-RootMailID: 20250701160201eucas1p14d4182ecd8d6b2034f55ed5262bac646
References: <20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com>
	<CGME20250701160201eucas1p14d4182ecd8d6b2034f55ed5262bac646@eucas1p1.samsung.com>

Building on the basic data types, this commit introduces the central
object abstractions for the PWM subsystem: Device and Chip. It also
includes the core trait implementations that make the Chip wrapper a
complete, safe, and managed object.

The main components of this change are:
 - Device and Chip Structs: These structs wrap the underlying struct
   pwm_device and struct pwm_chip C objects, providing safe, idiomatic
   methods to access their fields.

 - High-Level `Device` API: Exposes safe wrappers for the modern
   `waveform` API, allowing consumers to apply, read, and pre-validate
   hardware configurations.

 - Core Trait Implementations for Chip:
    - AlwaysRefCounted: Links the Chip's lifetime to its embedded
      struct device reference counter. This enables automatic lifetime
      management via ARef.
    - Send and Sync: Marks the Chip wrapper as safe for use across
      threads. This is sound because the C core handles all necessary
      locking for the underlying object's state.

These wrappers and traits form a robust foundation for building PWM
drivers in Rust.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 rust/kernel/pwm.rs | 261 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 3fad101406eac728d9b12083fad7abf7b7f89b25..2c3b6edd8ded8dadaad003b63d38973e04b99379 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -7,11 +7,12 @@
 //! C header: [`include/linux/pwm.h`](srctree/include/linux/pwm.h).
 
 use crate::{
-    bindings,
+    bindings, device,
+    error::{self, to_result},
     prelude::*,
-    types::Opaque,
+    types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
 };
-use core::convert::TryFrom;
+use core::{convert::TryFrom, ptr::NonNull};
 
 /// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pwm.h).
 #[derive(Copy, Clone, Debug, PartialEq, Eq)]
@@ -135,3 +136,257 @@ pub fn enabled(&self) -> bool {
         self.0.enabled
     }
 }
+
+/// Describes the outcome of a `round_waveform` operation.
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum RoundingOutcome {
+    /// The requested waveform was achievable exactly or by rounding values down.
+    ExactOrRoundedDown,
+
+    /// The requested waveform could only be achieved by rounding up.
+    RoundedUp,
+}
+
+/// Wrapper for a PWM device [`struct pwm_device`](srctree/include/linux/pwm.h).
+#[repr(transparent)]
+pub struct Device(Opaque<bindings::pwm_device>);
+
+impl Device {
+    /// Creates a reference to a [`Device`] from a valid C pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`Device`] reference.
+    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::pwm_device) -> &'a Self {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `Device` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast::<Self>() }
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
+        // Chip::as_ref's safety conditions must be met.
+        unsafe { Chip::as_ref((*self.as_raw()).chip) }
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
+    /// Sets the PWM waveform configuration and enables the PWM signal.
+    pub fn set_waveform(&self, wf: &Waveform, exact: bool) -> Result {
+        let c_wf = bindings::pwm_waveform::from(*wf);
+
+        // SAFETY: `self.as_raw()` provides a valid `*mut pwm_device` pointer.
+        // `&c_wf` is a valid pointer to a `pwm_waveform` struct. The C function
+        // handles all necessary internal locking.
+        let ret = unsafe { bindings::pwm_set_waveform_might_sleep(self.as_raw(), &c_wf, exact) };
+        to_result(ret)
+    }
+
+    /// Queries the hardware for the configuration it would apply for a given
+    /// request.
+    pub fn round_waveform(&self, wf: &mut Waveform) -> Result<RoundingOutcome> {
+        let mut c_wf = bindings::pwm_waveform::from(*wf);
+
+        // SAFETY: `self.as_raw()` provides a valid `*mut pwm_device` pointer.
+        // `&mut c_wf` is a valid pointer to a mutable `pwm_waveform` struct that
+        // the C function will update.
+        let ret = unsafe { bindings::pwm_round_waveform_might_sleep(self.as_raw(), &mut c_wf) };
+
+        to_result(ret)?;
+
+        *wf = Waveform::from(c_wf);
+
+        if ret == 1 {
+            Ok(RoundingOutcome::RoundedUp)
+        } else {
+            Ok(RoundingOutcome::ExactOrRoundedDown)
+        }
+    }
+
+    /// Reads the current waveform configuration directly from the hardware.
+    pub fn get_waveform(&self) -> Result<Waveform> {
+        let mut c_wf = bindings::pwm_waveform::default();
+
+        // SAFETY: `self.as_raw()` is a valid pointer. We provide a valid pointer
+        // to a stack-allocated `pwm_waveform` struct for the kernel to fill.
+        let ret = unsafe { bindings::pwm_get_waveform_might_sleep(self.as_raw(), &mut c_wf) };
+
+        to_result(ret)?;
+
+        Ok(Waveform::from(c_wf))
+    }
+}
+
+/// Wrapper for a PWM chip/controller ([`struct pwm_chip`](srctree/include/linux/pwm.h)).
+#[repr(transparent)]
+pub struct Chip(Opaque<bindings::pwm_chip>);
+
+impl Chip {
+    /// Creates a reference to a [`Chip`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`Chip`] reference.
+    pub(crate) unsafe fn as_ref<'a>(ptr: *mut bindings::pwm_chip) -> &'a Self {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `Chip` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast::<Self>() }
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
+    pub fn drvdata<T: 'static>(&self) -> &T {
+        // SAFETY: `self.as_raw()` gives a valid pwm_chip pointer.
+        // `bindings::pwmchip_get_drvdata` is the C function to retrieve driver data.
+        let ptr = unsafe { bindings::pwmchip_get_drvdata(self.as_raw()) };
+
+        // SAFETY: The only way to create a chip is through Chip::new, which initializes
+        // this pointer.
+        unsafe { &*ptr.cast::<T>() }
+    }
+
+    /// Allocates and wraps a PWM chip using `bindings::pwmchip_alloc`.
+    ///
+    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
+    /// on its embedded `struct device`.
+    pub fn new<T: 'static + ForeignOwnable>(
+        parent_dev: &device::Device,
+        npwm: u32,
+        sizeof_priv: usize,
+        drvdata: T,
+    ) -> Result<ARef<Self>> {
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
+        // SAFETY: The pointer is valid, so we can create a temporary ref to set data.
+        let chip_ref = unsafe { &*chip_ptr_as_self };
+        // SAFETY: `chip_ref` points to a valid chip from `pwmchip_alloc` and `drvdata` is a valid,
+        // owned pointer from `ForeignOwnable` to be stored in the chip's private data.
+        unsafe { bindings::pwmchip_set_drvdata(chip_ref.as_raw(), drvdata.into_foreign().cast()) }
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

-- 
2.34.1


