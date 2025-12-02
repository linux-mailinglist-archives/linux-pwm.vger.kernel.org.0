Return-Path: <linux-pwm+bounces-7754-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04786C9C962
	for <lists+linux-pwm@lfdr.de>; Tue, 02 Dec 2025 19:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1B6634505C
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Dec 2025 18:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9862D0C85;
	Tue,  2 Dec 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="kD1mn6Pt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D592C11FA
	for <linux-pwm@vger.kernel.org>; Tue,  2 Dec 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699484; cv=none; b=dzjUcUShsPslbbn/u1YECKWEtZsyRb5D6v7aNJIcNbn3510XsLKoyRL02KUZzGNoD1dtdz6U7JOS0udQNV3lKaiC5s73CUb7JfrPryq3IDYDRsegcq9P8nJVrHEY1SdpxeqBn+GPRwqLf/hNSXeMmoEkbZk6WaBxV/0k2GEMFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699484; c=relaxed/simple;
	bh=3lzG2YBF6gCwvm0GKJ0zdou1peFUrELTgnosqhb3t0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VG9RPEVVZ0zkcyrw3sShxO0Ki1SSAFY71p+rqmVypCQkohWF/yrkWowJ2io3uSev88TKGkwCmJ3wM3ZNJTcFOQtoJ5R9qY3oZBy27jk7itMyRdlF2MyqZV5q6fQI8ZI1ENq/luPwl7ok9ruznObGzKUi+upoXQuZqFolslTUdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=kD1mn6Pt; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 757AC240103
	for <linux-pwm@vger.kernel.org>; Tue,  2 Dec 2025 19:17:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764699473; bh=Pu0+u562w2Z1QakDHh9EJgqlDt80PY/8xKNxC2S7QTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=kD1mn6PtVZRzlQ5kzXL4pwKiEt83C45zbwm6lurhE+tlQcP5wrRPNeG/QcsL5R1Vy
	 gGoDuGhszTA/zAKkW1c67KfmkEnI3muQkDGP5+01WKDDWIj4hVYWtGZYPD/2N07X9W
	 zJOPU88bKnDMBToP3MV19Mwuq9c8fJhsLRdWb7r81UKPaECGvaT0TNMXD9WjmnNt5M
	 aEsLtDL4Yt5C5chUy0sw8r2v9U7COOj49/jJQuNu1UZRLzAhU0XEDCmFeqYxIXAWVT
	 Ez1kZupcxdSbolT3hpgksuX7N8pf5cAIc5M0AMJ/pj+7VeIYitUbbdtGMRqXphNhCF
	 0eAM9wc73iXAg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dLTXG2ZG8z9rxF;
	Tue,  2 Dec 2025 19:17:50 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Tue, 02 Dec 2025 18:17:52 +0000
Subject: [PATCH v2] rust: pwm: Add UnregisteredChip wrapper around Chip
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-pwm_safe_register-v2-1-7a2e0d1e287f@posteo.de>
X-B4-Tracking: v=1; b=H4sIACEtL2kC/32NSw6CMBCGr0JmbU1novhYcQ9DSKUDzELaTA1qS
 O9u5QAuv/+5QmIVTnCtVlBeJEmYC9Cugn5y88hGfGEgS0dEOpn4enTJDdwpj5KerIYPl7t1VCN
 ahNKLyoO8t81bW3gqsaCf7WLBn/pvbUGDxhN5y97WZ9c3MRQj7D1Dm3P+AuuCXZGyAAAA
X-Change-ID: 20251127-pwm_safe_register-e49b0a261101
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8114;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=3lzG2YBF6gCwvm0GKJ0zdou1peFUrELTgnosqhb3t0g=;
 b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBpLy1Oi+HpXdo7gjLCcBJJAuYa6s07qCyQ4MrLK
 gm8xZxO/C+JAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaS8tTgAKCRA0dh/4561D
 0u3bEACv2cm0GNB7emdHp3o3Q5aWVh+mxcgotRfK/QYw4288EuNsRRsis7qgcl4+jYdrII1dQkY
 efbcm55NXj/JvCi/ZgLa6kTucFaB6ltYWzuO9zUqjO3VwutnpfS8zGmb0QbGmvT7DqYp8vrbRGy
 NxXxPjsP4ybj09wjNeNksZSDcYSoqI8KSo2EBlu1LpjnDta8jvT6xbVVcl98ZrcIGiYBSDUUyww
 pAGgKhJmF4vVHcanAOrEuzA3YWe97Ofdq3NklPSBST9sHlD/8hqHqJlMsRCJcCK6fmpKHV9kS44
 pIKmXUAKuYSXQkRfU9fRw+Ev/NpA+OMZi3rooyE6O1UE6H913xeMVhkMCRApYGOkyFtAMTBpICB
 UI3cE2UP7FBypzw+qrWUKh+yzXfdn337NQvmOyJKx1/7TXI+xCdfsJuKEHIj0C/E82S7cAMyIx3
 Z8Jlk8weTqx58sFZzO+sMRO2YxIXxX05vOQ85Z/wknPStr9C0W+f2jJKRgtiRZkicbK0a6edf9L
 IJj4POR+szKW80fP2rkvyHynIxMjHKoyqo/to6ygoz6zdt/VPsn4f0QgqNfoYMSdnT2Fkl/EVPk
 vS0/SKtzIrZ+DZrkwQYFuC8aNkvqcceFAhNp5tqCQGJohfneF3tCrcG9W6/DSb7G2nWmllUmHvq
 HPKfZsCDJNx+OxQ==
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

The `pwm::Registration::register` function provides no guarantee that the
function isn't called twice with the same pwm chip, which is considered
unsafe.

Add `pwm::UnregisteredChip` as wrapper around `pwm::Chip`.
Implement `pwm::UnregisteredChip::register` for the registration. This
function takes ownership of `pwm::UnregisteredChip` and therefore
guarantees that the registration can't be called twice on the same pwm
chip.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
This patch provides the additional guarantee that the pwm chip doesn't
get registered twice.

The following changes were made:
- change the visibility of `pwm::Registration` to private
- remove the `pwm::Registration::register` function
- add `pwm::UnregisteredChip` - a wrapper around `pwm::Chip`
- return `pwm::UnregisteredChip` in `pwm::Chip::new`
- add `pwm::UnregisteredChip::register` for registering the pwm chip
  once
- add Send + Sync bounds to `PwmOps`

Note that I wasn't able to test this patch, due to the lack of hardware.

Also I was not able to successfully compile drivers/pwm/pwm_th1520.rs,
as `clk::Clk` seems to be missing. I haven't found the missing patch
in linux-next nor in

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/log/?h=pwm/for-next

(the tree in which the th1520 pwm driver was merged).
So please verify yourself that the driver compiles and throws no errors.
---
Changes in v2:
- use the `pwm::UnregisteredChip` wrapper instead of moving the
  registration into `pwm::Chip::new` to allow access to the chip prior
  to the registration
- Link to v1: https://lore.kernel.org/r/20251127-pwm_safe_register-v1-1-d22d0ed068ac@posteo.de
---
 drivers/pwm/pwm_th1520.rs |  2 +-
 rust/kernel/pwm.rs        | 68 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 955c359b07fb..65a52b6620ab 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -372,7 +372,7 @@ fn probe(
             }),
         )?;
 
-        pwm::Registration::register(dev, chip)?;
+        chip.register()?;
 
         Ok(KBox::new(Th1520PwmPlatformDriver, GFP_KERNEL)?.into())
     }
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index cb00f8a8765c..bf7515d04d8a 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -15,7 +15,11 @@
     prelude::*,
     types::{ARef, AlwaysRefCounted, Opaque}, //
 };
-use core::{marker::PhantomData, ptr::NonNull};
+use core::{
+    marker::PhantomData,
+    ops::Deref,
+    ptr::NonNull, //
+};
 
 /// Represents a PWM waveform configuration.
 /// Mirrors struct [`struct pwm_waveform`](srctree/include/linux/pwm.h).
@@ -173,7 +177,7 @@ pub struct RoundedWaveform<WfHw> {
 }
 
 /// Trait defining the operations for a PWM driver.
-pub trait PwmOps: 'static + Sized {
+pub trait PwmOps: 'static + Send + Sync + Sized {
     /// The driver-specific hardware representation of a waveform.
     ///
     /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFHWSIZE`.
@@ -584,11 +588,12 @@ unsafe fn bound_parent_device(&self) -> &device::Device<Bound> {
     ///
     /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
     /// on its embedded `struct device`.
-    pub fn new(
-        parent_dev: &device::Device,
+    #[allow(clippy::new_ret_no_self)]
+    pub fn new<'a>(
+        parent_dev: &'a device::Device<Bound>,
         num_channels: u32,
         data: impl pin_init::PinInit<T, Error>,
-    ) -> Result<ARef<Self>> {
+    ) -> Result<UnregisteredChip<'a, T>> {
         let sizeof_priv = core::mem::size_of::<T>();
         // SAFETY: `pwmchip_alloc` allocates memory for the C struct and our private data.
         let c_chip_ptr_raw =
@@ -623,7 +628,9 @@ pub fn new(
         // SAFETY: `chip_ptr_as_self` points to a valid `Chip` (layout-compatible with
         // `bindings::pwm_chip`) whose embedded device has refcount 1.
         // `ARef::from_raw` takes this pointer and manages it via `AlwaysRefCounted`.
-        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) })
+        let chip = unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) };
+
+        Ok(UnregisteredChip { chip, parent_dev })
     }
 }
 
@@ -654,37 +661,29 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
 // structure's state is managed and synchronized by the kernel's device model
 // and PWM core locking mechanisms. Therefore, it is safe to move the `Chip`
 // wrapper (and the pointer it contains) across threads.
-unsafe impl<T: PwmOps + Send> Send for Chip<T> {}
+unsafe impl<T: PwmOps> Send for Chip<T> {}
 
 // SAFETY: It is safe for multiple threads to have shared access (`&Chip`) because
 // the `Chip` data is immutable from the Rust side without holding the appropriate
 // kernel locks, which the C core is responsible for. Any interior mutability is
 // handled and synchronized by the C kernel code.
-unsafe impl<T: PwmOps + Sync> Sync for Chip<T> {}
+unsafe impl<T: PwmOps> Sync for Chip<T> {}
 
-/// A resource guard that ensures `pwmchip_remove` is called on drop.
-///
-/// This struct is intended to be managed by the `devres` framework by transferring its ownership
-/// via [`devres::register`]. This ties the lifetime of the PWM chip registration
-/// to the lifetime of the underlying device.
-pub struct Registration<T: PwmOps> {
+/// A wrapper arround `ARef<Chip<T>>` that ensures that `register` can only be called once.
+pub struct UnregisteredChip<'a, T: PwmOps> {
     chip: ARef<Chip<T>>,
+    parent_dev: &'a device::Device<Bound>,
 }
 
-impl<T: 'static + PwmOps + Send + Sync> Registration<T> {
+impl<T: PwmOps> UnregisteredChip<'_, T> {
     /// Registers a PWM chip with the PWM subsystem.
     ///
     /// Transfers its ownership to the `devres` framework, which ties its lifetime
     /// to the parent device.
     /// On unbind of the parent device, the `devres` entry will be dropped, automatically
     /// calling `pwmchip_remove`. This function should be called from the driver's `probe`.
-    pub fn register(dev: &device::Device<Bound>, chip: ARef<Chip<T>>) -> Result {
-        let chip_parent = chip.device().parent().ok_or(EINVAL)?;
-        if dev.as_raw() != chip_parent.as_raw() {
-            return Err(EINVAL);
-        }
-
-        let c_chip_ptr = chip.as_raw();
+    pub fn register(self) -> Result<ARef<Chip<T>>> {
+        let c_chip_ptr = self.chip.as_raw();
 
         // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
         // `__pwmchip_add` is the C function to register the chip with the PWM core.
@@ -692,12 +691,33 @@ pub fn register(dev: &device::Device<Bound>, chip: ARef<Chip<T>>) -> Result {
             to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
         }
 
-        let registration = Registration { chip };
+        let registration = Registration {
+            chip: ARef::clone(&self.chip),
+        };
+
+        devres::register(self.parent_dev, registration, GFP_KERNEL)?;
 
-        devres::register(dev, registration, GFP_KERNEL)
+        Ok(self.chip)
     }
 }
 
+impl<T: PwmOps> Deref for UnregisteredChip<'_, T> {
+    type Target = Chip<T>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.chip
+    }
+}
+
+/// A resource guard that ensures `pwmchip_remove` is called on drop.
+///
+/// This struct is intended to be managed by the `devres` framework by transferring its ownership
+/// via [`devres::register`]. This ties the lifetime of the PWM chip registration
+/// to the lifetime of the underlying device.
+struct Registration<T: PwmOps> {
+    chip: ARef<Chip<T>>,
+}
+
 impl<T: PwmOps> Drop for Registration<T> {
     fn drop(&mut self) {
         let chip_raw = self.chip.as_raw();

---
base-commit: fae00ea9f00367771003ace78f29549dead58fc7
change-id: 20251127-pwm_safe_register-e49b0a261101


