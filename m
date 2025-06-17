Return-Path: <linux-pwm+bounces-6409-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD6ADCF43
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 16:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12F816ED87
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4942EACE5;
	Tue, 17 Jun 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="buWb5B0X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5E2E92D1
	for <linux-pwm@vger.kernel.org>; Tue, 17 Jun 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169326; cv=none; b=m9iRHgIVI7dsKUj+mf/3Viehrfn3Q0Mm0JgfF+tMSFm9QSDqIC7SpdPyAqnuFeRlSximnKXrCMlWQkufje5OlVuee3PCbm5LggyR6KncRUdg+tOJsuVqTH6NsfqYtL0IS1jyIUOf1zjvOPzw0ECHoYSlp+Aw4H6FcYVX0oS0lno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169326; c=relaxed/simple;
	bh=PqPmG7LLWKvnVKOK34Udaecl39RMqDb2VheKIq5I+RM=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=sAi68lgT+WNcsk9Z71EaAlQw31ilLVBlgtbXAaEp8U+QpzO2UMkGW8OvxSnGGVxorVAG1evpyXlUWPIEiJEYYu/zfJ5rRnL3iaCxyZutohzud0FvQCinyZBjlAFzQ96LZeEQp5fKm6fS+HY9n935bbiM+0V0KH9HVAfIxQVfNfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=buWb5B0X; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250617140839euoutp01fa54aca9768c9fab04af822120ae9b20~J2bkXXh9O2970029700euoutp01T
	for <linux-pwm@vger.kernel.org>; Tue, 17 Jun 2025 14:08:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250617140839euoutp01fa54aca9768c9fab04af822120ae9b20~J2bkXXh9O2970029700euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750169319;
	bh=HLGeBBxVh4s0amVT/Rdjdx5pFJtAmPQ9fVS1AXrdlMc=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=buWb5B0X4ad8hr+YSOoN9fzlMT8HpgN/2lGeLJoP9LCa3XLVlaIMjWABW8MRZIN7t
	 TWgeG+/B0m/fOPNFTqGrB7iifdOJoEIfwGbOTzc4SdKGEzN3SauEjQX7erTSv3aTth
	 SJwY2p9aOVnuAu6q0AT14DAW6mnwZwacfXJ4z8Tw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250617140838eucas1p2a31af5a73297580c2421263c1c6ba700~J2bjpps3Z1901919019eucas1p28;
	Tue, 17 Jun 2025 14:08:38 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250617140837eusmtip19080d4986e3ed16c4afcd038c58f6574~J2biW8HbF2540625406eusmtip1J;
	Tue, 17 Jun 2025 14:08:37 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 17 Jun 2025 16:07:26 +0200
Subject: [PATCH v3 3/9] rust: pwm: Add driver operations trait and
 registration support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-rust-next-pwm-working-fan-for-sending-v3-3-1cca847c6f9f@samsung.com>
In-Reply-To: <20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com>
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
X-CMS-MailID: 20250617140838eucas1p2a31af5a73297580c2421263c1c6ba700
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250617140838eucas1p2a31af5a73297580c2421263c1c6ba700
X-EPHeader: CA
X-CMS-RootMailID: 20250617140838eucas1p2a31af5a73297580c2421263c1c6ba700
References: <20250617-rust-next-pwm-working-fan-for-sending-v3-0-1cca847c6f9f@samsung.com>
	<CGME20250617140838eucas1p2a31af5a73297580c2421263c1c6ba700@eucas1p2.samsung.com>

Complete the PWM abstraction layer by adding the final components
required to implement and register a driver.

The main additions are:

 - PwmOps Trait: An interface that drivers can implement to provide
   their hardware specific logic. It mirrors the C pwm_ops interface,
   providing hooks for standard PWM operations like apply, request, and
   waveform handling.

 - FFI VTable and Adapter: The Adapter struct, PwmOpsVTable wrapper, and
   create_pwm_ops function are introduced. This scaffolding handles the
   unsafe FFI translation, bridging the gap between the idiomatic PwmOps
   trait and the C kernel's function-pointer-based vtable.

 - Registration Guard: A final RAII guard that uses the vtable to safely
   register a Chip with the PWM core via pwmchip_add. Its Drop
   implementation guarantees that pwmchip_remove is always called,
   preventing resource leaks.

With this patch, the PWM abstraction layer is now complete and ready to
be used for writing PWM chip drivers in Rust.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 rust/kernel/pwm.rs | 471 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 468 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 8c4c27a4e4fc9da2fc8ea5015df2a315cfc6b932..64210411450cd3d964d21f1e712fcfd4d8aed988 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -8,12 +8,12 @@
 
 use crate::{
     bindings,
-    device,
-    error,
+    device::{self, Bound},
+    error::{self, to_result},
     prelude::*,
     types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
 };
-use core::{convert::TryFrom, ptr::NonNull};
+use core::{convert::TryFrom, marker::PhantomData, mem::ManuallyDrop, ptr::NonNull};
 
 /// Maximum size for the hardware-specific waveform representation buffer.
 ///
@@ -419,3 +419,468 @@ unsafe impl Send for Chip {}
 // kernel locks, which the C core is responsible for. Any interior mutability is
 // handled and synchronized by the C kernel code.
 unsafe impl Sync for Chip {}
+
+/// Manages the registration of a PWM chip, ensuring `pwmchip_remove` is called on drop.
+pub struct Registration {
+    chip: ManuallyDrop<ARef<Chip>>,
+}
+
+impl Registration {
+    /// Registers a PWM chip (obtained via `Chip::new`) with the PWM subsystem.
+    ///
+    /// Takes an [`ARef<Chip>`]. On `Drop` of the returned `Registration` object,
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
+    ///
+    /// This type must be [`Copy`], [`Default`], and fit within [`WFHW_MAX_SIZE`].
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
+    ) -> Result<(c_int, Self::WfHw)> {
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
+    ) -> Result<c_int> {
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
+    ///
+    /// `wfhw_ptr` must be valid for writes of `size_of::<T::WfHw>()` bytes.
+    unsafe fn serialize_wfhw(wfhw: &T::WfHw, wfhw_ptr: *mut c_void) -> Result {
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
+    ///
+    /// `wfhw_ptr` must be valid for reads of `size_of::<T::WfHw>()` bytes.
+    unsafe fn deserialize_wfhw(wfhw_ptr: *const c_void) -> Result<T::WfHw> {
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
+    ///
+    /// Pointers from C must be valid.
+    unsafe extern "C" fn apply_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        s: *const bindings::pwm_state,
+    ) -> c_int {
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
+    ///
+    /// Pointers from C must be valid.
+    unsafe extern "C" fn request_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+    ) -> c_int {
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
+    ///
+    /// Pointers from C must be valid.
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
+    ///
+    /// Pointers from C must be valid.
+    unsafe extern "C" fn capture_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        res: *mut bindings::pwm_capture,
+        timeout: usize,
+    ) -> c_int {
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
+    ///
+    /// Pointers from C must be valid.
+    unsafe extern "C" fn get_state_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        s: *mut bindings::pwm_state,
+    ) -> c_int {
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
+    ///
+    /// Pointers from C must be valid.
+    unsafe extern "C" fn round_waveform_tohw_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        w: *const bindings::pwm_waveform,
+        wh: *mut c_void,
+    ) -> c_int {
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
+    ///
+    /// Pointers from C must be valid.
+    unsafe extern "C" fn round_waveform_fromhw_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        wh: *const c_void,
+        w: *mut bindings::pwm_waveform,
+    ) -> c_int {
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
+    ///
+    /// Pointers from C must be valid.
+    unsafe extern "C" fn read_waveform_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        wh: *mut c_void,
+    ) -> c_int {
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
+    ///
+    /// Pointers from C must be valid.
+    unsafe extern "C" fn write_waveform_callback(
+        c: *mut bindings::pwm_chip,
+        p: *mut bindings::pwm_device,
+        wh: *const c_void,
+    ) -> c_int {
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
+
+/// VTable structure wrapper for PWM operations.
+/// Mirrors [`struct pwm_ops`](srctree/include/linux/pwm.h).
+#[repr(transparent)]
+pub struct PwmOpsVTable(Opaque<bindings::pwm_ops>);
+
+// SAFETY: PwmOpsVTable is Send. The vtable contains only function pointers
+// and a size, which are simple data types that can be safely moved across
+// threads. The thread-safety of calling these functions is handled by the
+// kernel's locking mechanisms.
+unsafe impl Send for PwmOpsVTable {}
+
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


