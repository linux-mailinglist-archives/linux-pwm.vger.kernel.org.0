Return-Path: <linux-pwm+bounces-6424-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EBAADEC7E
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F14B3B5121
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D9B2EACFC;
	Wed, 18 Jun 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dLBC3QpB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703EB2EA478
	for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249693; cv=none; b=oDvC29diUqhia/8+qLOrt5OszJLekFqxBNx0FaYtssnK4Pbm+rHmXRJrE2kWBpNgcT3KR7k0cTfAZJ1e4LuWIavnFXiir2DkZuaMv0sAsr3Gk1WoiNfXIhCEdTv3cgRCJzktALZHISJCeB/5dr44eHIgGMBd4ssw0CdDNe4QZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249693; c=relaxed/simple;
	bh=/sPwbKEK+ygDv9Q69HpXTxjfHz5V0uQYCVmzkNzXtnI=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=GuT364zmtUG3Pj17pImYbExLbSoz+8PA/uPY09dl082knrf6oafLtej1XMFjbj55NoGyUviR149AMFUcuLPiyfRxH/hvaD3Jvvp/vQhV49wzrzJJYGXzdiacHpUqEj9XXPycstPqvt/m4KtS/zM5QFBNc9aXza42sPuA0CBtC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dLBC3QpB; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250618122804euoutp02e05984216bf97be6ee8c745b5e353ffc~KItCwo7sG0527705277euoutp02_
	for <linux-pwm@vger.kernel.org>; Wed, 18 Jun 2025 12:28:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250618122804euoutp02e05984216bf97be6ee8c745b5e353ffc~KItCwo7sG0527705277euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750249684;
	bh=ElxNVdvtaZuvZ85Ry8syOZnRPo9ZmtSveCf9JMIJq0A=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=dLBC3QpBoDYcaddy2dPV7ab7qi60+qJmJziaVHeL3Kw0xVWBlvxS/HePodmORZb45
	 1b4iXkSwe6PptRhlxlJsdf2pCruVTksWan1D/OU/bVQn34h8J7Zy8nda0ej+wVb5nr
	 FZfLdZ3Npe4uZIWcyCBKILcMVe/x1y0WtSeEtirY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250618122804eucas1p1e2595c58833698167b7af1ffa8ea243a~KItCMDbPJ3062630626eucas1p1K;
	Wed, 18 Jun 2025 12:28:04 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250618122802eusmtip1f06f914feaad31471c68e3a9365520fd~KItAmyJ4P1948919489eusmtip1W;
	Wed, 18 Jun 2025 12:28:02 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 18 Jun 2025 14:27:35 +0200
Subject: [PATCH v4 2/9] rust: pwm: Add core 'Device' and 'Chip' object
 wrappers
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-rust-next-pwm-working-fan-for-sending-v4-2-a6a28f2b6d8a@samsung.com>
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
X-CMS-MailID: 20250618122804eucas1p1e2595c58833698167b7af1ffa8ea243a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250618122804eucas1p1e2595c58833698167b7af1ffa8ea243a
X-EPHeader: CA
X-CMS-RootMailID: 20250618122804eucas1p1e2595c58833698167b7af1ffa8ea243a
References: <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
	<CGME20250618122804eucas1p1e2595c58833698167b7af1ffa8ea243a@eucas1p1.samsung.com>

Building on the basic data types, this commit introduces the central
object abstractions for the PWM subsystem: Device and Chip. It also
includes the core trait implementations that make the Chip wrapper a
complete, safe, and managed object.

The main components of this change are:
 - Device and Chip Structs: These structs wrap the underlying struct
   pwm_device and struct pwm_chip C objects, providing safe, idiomatic
   methods to access their fields.

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
 rust/kernel/pwm.rs | 210 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index ed681b228c414e7ae8bf80ca649ad497c9dc4ec3..091df42ae10dc01f711c21475a1a317af9fe84bc 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -8,10 +8,12 @@
 
 use crate::{
     bindings,
+    device,
+    error,
     prelude::*,
-    types::Opaque,
+    types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
 };
-use core::convert::TryFrom;
+use core::{convert::TryFrom, ptr::NonNull};
 
 /// Maximum size for the hardware-specific waveform representation buffer.
 ///
@@ -196,3 +198,207 @@ pub fn set_usage_power(&mut self, usage_power: bool) {
         self.0.usage_power = usage_power;
     }
 }
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
+    /// Returns `true` if the PWM signal is currently enabled based on its state.
+    pub fn is_enabled(&self) -> bool {
+        self.state().enabled()
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
+    /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
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

-- 
2.34.1


