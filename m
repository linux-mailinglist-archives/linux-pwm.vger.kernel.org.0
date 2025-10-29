Return-Path: <linux-pwm+bounces-7532-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9A4C1CC3D
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 19:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2101897C61
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A20355046;
	Wed, 29 Oct 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL6pdHvE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE2321448;
	Wed, 29 Oct 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762311; cv=none; b=H2AtLfsYIuPm4+ITJT4qcGUjGWgvdm9A0eQr5P7PS2LN+SG12SFqPkDTG4n/nncPyFw0gxxoT36ruRctG+EzEBB4vpqqJUNyb5vvMEDsrXlIgPXWUz8aqj1WdOiDiuKrbKR3VfjY1Jr/z92Gu8J5/FPNC0TnuUUyKJxaRJcK2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762311; c=relaxed/simple;
	bh=ZDpgqAv5yGg5ct10kxn/9ozpUWLNUyHj0klednkQQDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKvYIQKy/4nzJUG9wj1FZi4BpgjSYi3FvMUY/La6fHoG6nkhBHhQyNbOAKEiBkbGwuTNIC4l4H8f5SmegpQM+LbyRsOwTZwKTjmUCEY5/PfInec+j8knlGo5x1+AOJDxdoDmVjPgIE32hFHjsxQ0elACdNyq4MsfR9eBY+hHUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL6pdHvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DDEC4CEF7;
	Wed, 29 Oct 2025 18:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761762311;
	bh=ZDpgqAv5yGg5ct10kxn/9ozpUWLNUyHj0klednkQQDc=;
	h=From:To:Cc:Subject:Date:From;
	b=IL6pdHvELB/75bqQUu0T53ib9e/PEklT/6IZxrWW0raX4ZmSpdJbC29MCSjLm0pJ+
	 uu3Xk5TTJIeRfEKgz462c6UpWx1+9KZdW4CNzpZ8aamRkFbell2yeWc7SSb/Xo9NFG
	 hqKyQUqaTbnJQGXD4yjoPshktPuLw8eLCwb9bCFoXJgntMkhsX7DYo2Wi+iYVrAXNd
	 4W3X+e813bqTM0kn7Gxeq/IcTC+5+9SL74ry7psikma2iLy07ppPZqxNSEaDgzq7me
	 dfQID+KEt6V6tox5/UEyY+OzpiIxCzT79z/BDAxzjRXr4POrwPDuww3phbOLZNOa34
	 xWx5R5nyxHy2Q==
From: Miguel Ojeda <ojeda@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] pwm: fix Rust formatting
Date: Wed, 29 Oct 2025 19:25:02 +0100
Message-ID: <20251029182502.783392-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do our best to keep the repository `rustfmt`-clean [1], thus run the
tool to fix the formatting issue.

A trailing empty comment [2] is added in order to preserve the wanted
style for imports (otherwise the tool will compact the first two items).

Link: https://rust-for-linux.com/contributing#submit-checklist-addendum [1]
Link: https://docs.kernel.org/rust/coding-guidelines.html#style-formatting [2]
Fixes: a3d5a2b8da94 ("rust: pwm: Add complete abstraction layer")
Fixes: 121931a7b4dc ("rust: pwm: Add Kconfig and basic data structures")
Fixes: fb3957af9ec6 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
If you usually rebase your tree, please feel free to do so instead. Thanks!

 drivers/pwm/pwm_th1520.rs | 15 ++++++++++---
 rust/kernel/lib.rs        |  4 ++--
 rust/kernel/pwm.rs        | 46 +++++++++++++++++++++------------------
 3 files changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 0ad38b78be85..ee2a6d573bc2 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -200,7 +200,10 @@ fn round_waveform_fromhw(
         let rate_hz = data.clk.rate().as_hz() as u64;

         if wfhw.period_cycles == 0 {
-            dev_dbg!(chip.device(), "HW state has zero period, reporting as disabled.\n");
+            dev_dbg!(
+                chip.device(),
+                "HW state has zero period, reporting as disabled.\n"
+            );
             *wf = pwm::Waveform::default();
             return Ok(());
         }
@@ -277,7 +280,10 @@ fn write_waveform(
             if was_enabled {
                 iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
                 iomap.try_write32(0, th1520_pwm_fp(hwpwm))?;
-                iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
+                iomap.try_write32(
+                    wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE,
+                    th1520_pwm_ctrl(hwpwm),
+                )?;
             }
             return Ok(());
         }
@@ -285,7 +291,10 @@ fn write_waveform(
         iomap.try_write32(wfhw.ctrl_val, th1520_pwm_ctrl(hwpwm))?;
         iomap.try_write32(wfhw.period_cycles, th1520_pwm_per(hwpwm))?;
         iomap.try_write32(wfhw.duty_cycles, th1520_pwm_fp(hwpwm))?;
-        iomap.try_write32(wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE, th1520_pwm_ctrl(hwpwm))?;
+        iomap.try_write32(
+            wfhw.ctrl_val | TH1520_PWM_CFG_UPDATE,
+            th1520_pwm_ctrl(hwpwm),
+        )?;

         // The `TH1520_PWM_START` bit must be written in a separate, final transaction, and
         // only when enabling the channel from a disabled state.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 68c71d888fdb..584aa3282029 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -121,6 +121,8 @@
 pub mod print;
 pub mod processor;
 pub mod ptr;
+#[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
+pub mod pwm;
 pub mod rbtree;
 pub mod regulator;
 pub mod revocable;
@@ -129,8 +131,6 @@
 pub mod seq_file;
 pub mod sizes;
 mod static_assert;
-#[cfg(CONFIG_RUST_PWM_ABSTRACTIONS)]
-pub mod pwm;
 #[doc(hidden)]
 pub mod std_vendor;
 pub mod str;
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 79fbb13cd47f..9149161e6253 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -13,7 +13,7 @@
     devres,
     error::{self, to_result},
     prelude::*,
-    types::{ARef, AlwaysRefCounted, Opaque},
+    types::{ARef, AlwaysRefCounted, Opaque}, //
 };
 use core::{convert::TryFrom, marker::PhantomData, ptr::NonNull};

@@ -156,7 +156,7 @@ pub fn label(&self) -> Option<&CStr> {
         // SAFETY: self.as_raw() provides a valid pointer.
         let label_ptr = unsafe { (*self.as_raw()).label };
         if label_ptr.is_null() {
-            return None
+            return None;
         }

         // SAFETY: label_ptr is non-null and points to a C string
@@ -234,11 +234,7 @@ pub trait PwmOps: 'static + Sized {
     type WfHw: Copy + Default;

     /// Optional hook for when a PWM device is requested.
-    fn request(
-        _chip: &Chip<Self>,
-        _pwm: &Device,
-        _parent_dev: &device::Device<Bound>,
-    ) -> Result {
+    fn request(_chip: &Chip<Self>, _pwm: &Device, _parent_dev: &device::Device<Bound>) -> Result {
         Ok(())
     }

@@ -364,7 +360,9 @@ unsafe fn deserialize_wfhw(wfhw_ptr: *const c_void) -> Result<T::WfHw> {
         // Now, call the original release function to free the `pwm_chip` itself.
         // SAFETY: `dev` is the valid pointer passed into this callback, which is
         // the expected argument for `pwmchip_release`.
-        unsafe { bindings::pwmchip_release(dev); }
+        unsafe {
+            bindings::pwmchip_release(dev);
+        }
     }

     /// # Safety
@@ -647,9 +645,8 @@ pub fn new(
     ) -> Result<ARef<Self>> {
         let sizeof_priv = core::mem::size_of::<T>();
         // SAFETY: `pwmchip_alloc` allocates memory for the C struct and our private data.
-        let c_chip_ptr_raw = unsafe {
-            bindings::pwmchip_alloc(parent_dev.as_raw(), num_channels, sizeof_priv)
-        };
+        let c_chip_ptr_raw =
+            unsafe { bindings::pwmchip_alloc(parent_dev.as_raw(), num_channels, sizeof_priv) };

         let c_chip_ptr: *mut bindings::pwm_chip = error::from_err_ptr(c_chip_ptr_raw)?;

@@ -661,12 +658,16 @@ pub fn new(
         unsafe { data.__pinned_init(drvdata_ptr.cast())? };

         // SAFETY: `c_chip_ptr` points to a valid chip.
-        unsafe { (*c_chip_ptr).dev.release = Some(Adapter::<T>::release_callback); }
+        unsafe {
+            (*c_chip_ptr).dev.release = Some(Adapter::<T>::release_callback);
+        }

         // SAFETY: `c_chip_ptr` points to a valid chip.
         // The `Adapter`'s `VTABLE` has a 'static lifetime, so the pointer
         // returned by `as_raw()` is always valid.
-        unsafe { (*c_chip_ptr).ops = Adapter::<T>::VTABLE.as_raw(); }
+        unsafe {
+            (*c_chip_ptr).ops = Adapter::<T>::VTABLE.as_raw();
+        }

         // Cast the `*mut bindings::pwm_chip` to `*mut Chip`. This is valid because
         // `Chip` is `repr(transparent)` over `Opaque<bindings::pwm_chip>`, and
@@ -686,7 +687,9 @@ unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
     fn inc_ref(&self) {
         // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `self` exists.
         // The embedded `dev` is valid. `get_device` increments its refcount.
-        unsafe { bindings::get_device(&raw mut (*self.0.get()).dev); }
+        unsafe {
+            bindings::get_device(&raw mut (*self.0.get()).dev);
+        }
     }

     #[inline]
@@ -695,7 +698,9 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {

         // SAFETY: `obj` is a valid pointer to a `Chip` (and thus `bindings::pwm_chip`)
         // with a non-zero refcount. `put_device` handles decrement and final release.
-        unsafe { bindings::put_device(&raw mut (*c_chip_ptr).dev); }
+        unsafe {
+            bindings::put_device(&raw mut (*c_chip_ptr).dev);
+        }
     }
 }

@@ -727,11 +732,8 @@ impl<T: 'static + PwmOps + Send + Sync> Registration<T> {
     /// to the parent device.
     /// On unbind of the parent device, the `devres` entry will be dropped, automatically
     /// calling `pwmchip_remove`. This function should be called from the driver's `probe`.
-    pub fn register(
-        dev: &device::Device<Bound>,
-        chip: ARef<Chip<T>>,
-    ) -> Result {
-	let chip_parent = chip.device().parent().ok_or(EINVAL)?;
+    pub fn register(dev: &device::Device<Bound>, chip: ARef<Chip<T>>) -> Result {
+        let chip_parent = chip.device().parent().ok_or(EINVAL)?;
         if dev.as_raw() != chip_parent.as_raw() {
             return Err(EINVAL);
         }
@@ -757,6 +759,8 @@ fn drop(&mut self) {
         // SAFETY: `chip_raw` points to a chip that was successfully registered.
         // `bindings::pwmchip_remove` is the correct C function to unregister it.
         // This `drop` implementation is called automatically by `devres` on driver unbind.
-        unsafe { bindings::pwmchip_remove(chip_raw); }
+        unsafe {
+            bindings::pwmchip_remove(chip_raw);
+        }
     }
 }

base-commit: 04a698c800c25149f9aa379250e78f737adeb3f1
--
2.51.2

