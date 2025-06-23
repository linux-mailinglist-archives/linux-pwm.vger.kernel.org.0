Return-Path: <linux-pwm+bounces-6485-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A981AE4C6A
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 20:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747E03BBE1A
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795A02D4B53;
	Mon, 23 Jun 2025 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MviDwa3p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942028DF12
	for <linux-pwm@vger.kernel.org>; Mon, 23 Jun 2025 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702146; cv=none; b=ZDjEcpcCyv5KG7tVVVv1UqoK8KfqilQDwBlIbfAJE1SrrL8nC26WZNMN4B6hAHHtMu0k2F/dRWtu7R2n0VmxMxbI5LUWZ1hDNMrXjD7UYnZEOfZEOdVinMHcEdhCYXdNfjU/UyXGZqx4EFT6OSz1CV0ZqcNfAWA6ecODJTbNaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702146; c=relaxed/simple;
	bh=KSOUO8dQWEaYaDhLPjiHFojfmybtJLULr9lDKrlJz6s=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=sxfW/AWSBzYM+kbWemA7iUaHPyIerv9AAYyOsNR2wAIIqZoHf+ut4DM42jGpFv/xONf4ARcZU28xFe9cNg2hpW4SkAYEDexAFn3lXXk1JLy/wEyTg1sIn1LiKiF7ZndS1Infn+Rqgc+g5vgWMGCRMthomhQN4RG6UwWREINImAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MviDwa3p; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250623180901euoutp01f2021eb5d5a0e3c58e5be2d9edfc30c1~LvlKEWWa73140631406euoutp01g
	for <linux-pwm@vger.kernel.org>; Mon, 23 Jun 2025 18:09:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250623180901euoutp01f2021eb5d5a0e3c58e5be2d9edfc30c1~LvlKEWWa73140631406euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750702141;
	bh=iN0qq5V9fYuxdgNB+mZLYEP6BI1dGPpucQhZt1+QoiQ=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=MviDwa3pucoSnx+HC1iFPMxUO/3vfEAg+SyaYYXmK6bBzX+BSn2AdkhJfPclZjIrO
	 ckx2C+B28KmCw9eoBtoVzEGMIERTMDMmgMnFMd09yMuxIBvadkx1eEDW9jwkC18+kE
	 abtrIby9UQoUt2+L+7oW6cN3F1smskHTQGi3GV0M=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250623180900eucas1p2ffbd79e79f690189ae89aefcc3793e50~LvlJNuFkn1026210262eucas1p2A;
	Mon, 23 Jun 2025 18:09:00 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250623180859eusmtip1b7c7acea70254f2d1986f28247af6b73~LvlIFjfIY0518905189eusmtip1U;
	Mon, 23 Jun 2025 18:08:59 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 23 Jun 2025 20:08:51 +0200
Subject: [PATCH v5 3/9] rust: pwm: Add driver operations trait and
 registration support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-rust-next-pwm-working-fan-for-sending-v5-3-0ca23747c23e@samsung.com>
In-Reply-To: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
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
X-CMS-MailID: 20250623180900eucas1p2ffbd79e79f690189ae89aefcc3793e50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623180900eucas1p2ffbd79e79f690189ae89aefcc3793e50
X-EPHeader: CA
X-CMS-RootMailID: 20250623180900eucas1p2ffbd79e79f690189ae89aefcc3793e50
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
	<CGME20250623180900eucas1p2ffbd79e79f690189ae89aefcc3793e50@eucas1p2.samsung.com>

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
 rust/kernel/pwm.rs | 486 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 483 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 3865b43ec47df6cb0c09bc74a228535512b6b1a8..25bc07a3df1d43467a3a6ec8f2362ae8f770360a 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -8,12 +8,13 @@
 
 use crate::{
     bindings,
-    device,
-    error,
+    device::{self, Bound},
+    devres::Devres,
+    error::{self, to_result},
     prelude::*,
     types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
 };
-use core::{convert::TryFrom, ptr::NonNull};
+use core::{convert::TryFrom, marker::PhantomData, ptr::NonNull};
 
 /// Maximum size for the hardware-specific waveform representation buffer.
 ///
@@ -408,3 +409,482 @@ unsafe impl Send for Chip {}
 // kernel locks, which the C core is responsible for. Any interior mutability is
 // handled and synchronized by the C kernel code.
 unsafe impl Sync for Chip {}
+
+/// A resource guard that ensures `pwmchip_remove` is called on drop.
+///
+/// This struct is intended to be managed by the `devres` framework by transferring its ownership
+/// via [`Devres::new_foreign_owned`]. This ties the lifetime of the PWM chip registration
+/// to the lifetime of the underlying device.
+pub struct Registration {
+    chip: ARef<Chip>,
+}
+
+impl Registration {
+    /// Registers a PWM chip with the PWM subsystem.
+    ///
+    /// Transfers its ownership to the `devres` framework, which ties its lifetime
+    /// to the parent device.
+    /// On unbind of the parent device, the `devres` entry will be dropped, automatically
+    /// calling `pwmchip_remove`. This function should be called from the driver's `probe`.
+    pub fn new_foreign_owned(
+        dev: &device::Device<Bound>,
+        chip: ARef<Chip>,
+        ops_vtable: &'static PwmOpsVTable,
+    ) -> Result {
+        let c_chip_ptr = chip.as_raw();
+
+        // SAFETY: `c_chip_ptr` is valid because the `ARef<Chip>` that owns it exists.
+        // The vtable pointer is also valid. This sets the `.ops` field on the C struct.
+        unsafe {
+            (*c_chip_ptr).ops = ops_vtable.as_raw();
+        }
+
+        // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
+        // `__pwmchip_add` is the C function to register the chip with the PWM core.
+        unsafe {
+            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
+        }
+
+        let registration = Registration { chip };
+
+        Devres::new_foreign_owned(dev, registration, GFP_KERNEL)?;
+
+        Ok(())
+    }
+}
+
+impl Drop for Registration {
+    fn drop(&mut self) {
+        let chip_raw = self.chip.as_raw();
+
+        // SAFETY: `chip_raw` points to a chip that was successfully registered.
+        // `bindings::pwmchip_remove` is the correct C function to unregister it.
+        // This `drop` implementation is called automatically by `devres` on driver unbind.
+        unsafe {
+            bindings::pwmchip_remove(chip_raw);
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
+        _chip: &Chip,
+        _pwm: &Device,
+        _state: &State,
+        _parent_dev: &device::Device<Bound>,
+    ) -> Result {
+        Err(ENOTSUPP)
+    }
+
+    /// Optional hook for when a PWM device is requested.
+    fn request(_chip: &Chip, _pwm: &Device, _parent_dev: &device::Device<Bound>) -> Result {
+        Ok(())
+    }
+
+    /// Optional hook for when a PWM device is freed.
+    fn free(_chip: &Chip, _pwm: &Device, _parent_dev: &device::Device<Bound>) {}
+
+    /// Optional hook for capturing a PWM signal.
+    fn capture(
+        _chip: &Chip,
+        _pwm: &Device,
+        _result: &mut bindings::pwm_capture,
+        _timeout: usize,
+        _parent_dev: &device::Device<Bound>,
+    ) -> Result {
+        Err(ENOTSUPP)
+    }
+
+    /// Optional hook to get the current hardware state.
+    fn get_state(
+        _chip: &Chip,
+        _pwm: &Device,
+        _state: &mut State,
+        _parent_dev: &device::Device<Bound>,
+    ) -> Result {
+        Err(ENOTSUPP)
+    }
+
+    /// Convert a generic waveform to the hardware-specific representation.
+    /// This is typically a pure calculation and does not perform I/O.
+    fn round_waveform_tohw(
+        _chip: &Chip,
+        _pwm: &Device,
+        _wf: &Waveform,
+    ) -> Result<(c_int, Self::WfHw)> {
+        Err(ENOTSUPP)
+    }
+
+    /// Convert a hardware-specific representation back to a generic waveform.
+    /// This is typically a pure calculation and does not perform I/O.
+    fn round_waveform_fromhw(
+        _chip: &Chip,
+        _pwm: &Device,
+        _wfhw: &Self::WfHw,
+        _wf: &mut Waveform,
+    ) -> Result<c_int> {
+        Err(ENOTSUPP)
+    }
+
+    /// Read the current hardware configuration into the hardware-specific representation.
+    fn read_waveform(
+        _chip: &Chip,
+        _pwm: &Device,
+        _parent_dev: &device::Device<Bound>,
+    ) -> Result<Self::WfHw> {
+        Err(ENOTSUPP)
+    }
+
+    /// Write a hardware-specific waveform configuration to the hardware.
+    fn write_waveform(
+        _chip: &Chip,
+        _pwm: &Device,
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
+        // provides valid pointers. `Chip::as_ref` and `Device::as_ref` are `unsafe fn`
+        // whose preconditions are met by this contract.
+        let (chip, pwm) = unsafe { (Chip::as_ref(c), Device::as_ref(p)) };
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
+        let (chip, pwm) = unsafe { (Chip::as_ref(c), Device::as_ref(p)) };
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
+        let (chip, pwm) = unsafe { (Chip::as_ref(c), Device::as_ref(p)) };
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
+        let (chip, pwm, result) = unsafe { (Chip::as_ref(c), Device::as_ref(p), &mut *res) };
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
+        let (chip, pwm) = unsafe { (Chip::as_ref(c), Device::as_ref(p)) };
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
+        let (chip, pwm, wf) = unsafe { (Chip::as_ref(c), Device::as_ref(p), Waveform::from(*w)) };
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
+        let (chip, pwm) = unsafe { (Chip::as_ref(c), Device::as_ref(p)) };
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
+        let (chip, pwm) = unsafe { (Chip::as_ref(c), Device::as_ref(p)) };
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
+        let (chip, pwm) = unsafe { (Chip::as_ref(c), Device::as_ref(p)) };
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


