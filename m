Return-Path: <linux-pwm+bounces-6698-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC863AF5A34
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D557B8A15
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD4286408;
	Wed,  2 Jul 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="owPD17Gy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3B28505C
	for <linux-pwm@vger.kernel.org>; Wed,  2 Jul 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751464204; cv=none; b=BVRNB/argd8ytOi7Ud2A7eEbziH3GELC1Toa8N1rLZhQ2L1mkQtpjvT3/379oU3b8tZZ9aN0pudXx7guxhBB679BSmxvP0NuFSb+gea/3e7OGdPPkPsaF3bwYwHr2AB1rVG/MmCxU0hvkTy3axQdikBShrXnypKrxZkMkaThWJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751464204; c=relaxed/simple;
	bh=QV/aDJ0u1ttJWZYxE7X1Y5ZAjQHgDX0lXTY93PdSuuY=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=nRTB8xqc9jcNBdjED7n2X6YRVbBIqPa34jti2Lly4IXxPKKJ6ddLeVotmFtJD1mf97XlkL+Vj05M9E+njg6gtjghzCg00ueGNuZeCjIum0lLFKZkXQyEVaj/RDwab9IhoNncVLpEqyKcVePoZ3hy5PxhLu8Sp9r+A60pJm7Hojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=owPD17Gy; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250702134959euoutp02214d72bf1805dd4701dc05ef64908caf~Oc2ju3Pev2698626986euoutp02a
	for <linux-pwm@vger.kernel.org>; Wed,  2 Jul 2025 13:49:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250702134959euoutp02214d72bf1805dd4701dc05ef64908caf~Oc2ju3Pev2698626986euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751464199;
	bh=1U9KKfn/Ox0ytMzsl8iLL7+cEcZIv+JzvlH5Bzw0Njc=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=owPD17Gyg7bCcsq8H618LizIz9hifJgCiZIT4wEXOKJoS7ijm/Lky9FFuuLshxsno
	 uhY5Wq7+ruUUi9v4YjkVLJR0Y0k9sBh5/Bo5NtuqjZzTMN9uY29nFowe2wHeQXwxNi
	 CTTLPXW+fMOQv7VHZLPakdiOdODTJv2Def+kx5vw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250702134958eucas1p26baf0f661006f5b79c31b2afa683baee~Oc2jCGpvK1291312913eucas1p2l;
	Wed,  2 Jul 2025 13:49:58 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250702134957eusmtip24d86171eda28014afe6e34a2df913865~Oc2h93BsO0829808298eusmtip2d;
	Wed,  2 Jul 2025 13:49:57 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 02 Jul 2025 15:45:32 +0200
Subject: [PATCH v7 4/8] rust: pwm: Add driver operations trait and
 registration support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-rust-next-pwm-working-fan-for-sending-v7-4-67ef39ff1d29@samsung.com>
In-Reply-To: <20250702-rust-next-pwm-working-fan-for-sending-v7-0-67ef39ff1d29@samsung.com>
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
	Turquette <mturquette@baylibre.com>,  Drew Fustini <fustini@kernel.org>,
	Benno Lossin <lossin@kernel.org>,  Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250702134958eucas1p26baf0f661006f5b79c31b2afa683baee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250702134958eucas1p26baf0f661006f5b79c31b2afa683baee
X-EPHeader: CA
X-CMS-RootMailID: 20250702134958eucas1p26baf0f661006f5b79c31b2afa683baee
References: <20250702-rust-next-pwm-working-fan-for-sending-v7-0-67ef39ff1d29@samsung.com>
	<CGME20250702134958eucas1p26baf0f661006f5b79c31b2afa683baee@eucas1p2.samsung.com>

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

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 rust/kernel/pwm.rs | 372 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 370 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 3b383b66c241ac68213924c3aa7bc933a817bc46..e13312a16b2eff3f5171cb24c3082ad06f708ccc 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -7,12 +7,14 @@
 //! C header: [`include/linux/pwm.h`](srctree/include/linux/pwm.h).
 
 use crate::{
-    bindings, device,
+    bindings,
+    device::{self, Bound},
+    devres,
     error::{self, to_result},
     prelude::*,
     types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
 };
-use core::{convert::TryFrom, ptr::NonNull};
+use core::{convert::TryFrom, marker::PhantomData, ptr::NonNull};
 
 /// PWM polarity. Mirrors [`enum pwm_polarity`](srctree/include/linux/pwm.h).
 #[derive(Copy, Clone, Debug, PartialEq, Eq)]
@@ -400,3 +402,369 @@ unsafe impl Send for Chip {}
 // kernel locks, which the C core is responsible for. Any interior mutability is
 // handled and synchronized by the C kernel code.
 unsafe impl Sync for Chip {}
+
+/// A resource guard that ensures `pwmchip_remove` is called on drop.
+///
+/// This struct is intended to be managed by the `devres` framework by transferring its ownership
+/// via [`Devres::register`]. This ties the lifetime of the PWM chip registration
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
+    pub fn register(
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
+        devres::register(dev, registration, GFP_KERNEL)
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
+    /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFHWSIZE`.
+    type WfHw: Copy + Default;
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
+        if size > bindings::PWM_WFHWSIZE as usize {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The caller ensures `wfhw_ptr` is valid for `size` bytes.
+        unsafe {
+            core::ptr::copy_nonoverlapping(
+                core::ptr::from_ref::<T::WfHw>(wfhw).cast::<u8>(),
+                wfhw_ptr.cast::<u8>(),
+                size,
+            );
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
+        if size > bindings::PWM_WFHWSIZE as usize {
+            return Err(EINVAL);
+        }
+
+        let mut wfhw = T::WfHw::default();
+        // SAFETY: The caller ensures `wfhw_ptr` is valid for `size` bytes.
+        unsafe {
+            core::ptr::copy_nonoverlapping(
+                wfhw_ptr.cast::<u8>(),
+                core::ptr::from_mut::<T::WfHw>(&mut wfhw).cast::<u8>(),
+                size,
+            );
+        }
+
+        Ok(wfhw)
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
+
+        // SAFETY: The PWM core guarantees the parent device exists and is bound during callbacks.
+        let bound_parent = unsafe { chip.bound_parent_device() };
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
+
+        // SAFETY: The PWM core guarantees the parent device exists and is bound during callbacks.
+        let bound_parent = unsafe { chip.bound_parent_device() };
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
+
+        // SAFETY: The PWM core guarantees the parent device exists and is bound during callbacks.
+        let bound_parent = unsafe { chip.bound_parent_device() };
+        match T::capture(chip, pwm, result, timeout, bound_parent) {
+            Ok(()) => 0,
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
+
+        // SAFETY: The PWM core guarantees the parent device exists and is bound during callbacks.
+        let bound_parent = unsafe { chip.bound_parent_device() };
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
+
+        // SAFETY: The PWM core guarantees the parent device exists and is bound during callbacks.
+        let bound_parent = unsafe { chip.bound_parent_device() };
+
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
+    ops.request = Some(Adapter::<T>::request_callback);
+    ops.free = Some(Adapter::<T>::free_callback);
+    ops.capture = Some(Adapter::<T>::capture_callback);
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


