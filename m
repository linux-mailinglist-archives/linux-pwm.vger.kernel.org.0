Return-Path: <linux-pwm+bounces-7707-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F775C8F9F2
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Nov 2025 18:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D303A3C1A
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Nov 2025 17:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A0035979;
	Thu, 27 Nov 2025 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="ih8ufMES"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915C2E0410
	for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263716; cv=none; b=Q5kyWBfKv79XQ4+bFMqn9oLEvym336BWMzyn07XevCaozJSXJRl02BD6QbPS7Qw5sbWWVxivOeX5p7Yn/azoDVl7MaBsgdjpq/RuPpIjMLCEuQMWP6/kWk5hAddL3oZkc5jnF5JExnt0avYAJzfRQg1wQfrcSTXn7hiEJQ1RkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263716; c=relaxed/simple;
	bh=sjCGpsFWtUuaf2ehQRqAWM1hmZoxe+jPZ9b+8Ms+qys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f0xUWEiKgnbXeuiEGpjw0FCkgKy0nhuEUZx3ruhtEI2A1H00Xz9IzdDf13v9FJHZjJnUgm4t3Bi/iKzNWAc/q+95kHuh9aM3TMw+AQiTMN6EoFxrhTSRX/0yMr6bRVX0JBYO1/3vqlFvdUDo+hVCXklBRDl4qIYzBm5USADeVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=ih8ufMES; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 22112240027
	for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 18:15:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764263707; bh=1JYlqOooCL8ydN0owtkf6sjw7iJYZv7Bd4tNLpKEf0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=ih8ufMESgkTJ3xr44g+7OheAZ5RRNI8pIxmZtRYTtnfwzWw9yVvMYOQk+jGGECJUY
	 UFhfrY3/aufQRNrO3cqPmO0ptC78xE1aJomCrdsvnVdBvmNFcxfxuJX6OQ5cXcMqWQ
	 vmf0/n/ZEuIth3iOc5TVdzB/2QQWjlrCzWilFP/ofru4J512t/Q/sbI26ER1t04JXW
	 ZA5/ud7Sk27DFrRqftT2L5mc+Zn3hY+zg7tQrDgqIGgIg9uuMI6PTBLPDioyQYK8xo
	 kcCQzf3WnNvD7yWCOM2/vk0BEsxO0OFaWnQ0JYlzVtdQ1bB2hqEvZHO+o3C2aKHsrB
	 CLhHVZfVESOvg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dHNN754sqz6txn;
	Thu, 27 Nov 2025 18:15:03 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Thu, 27 Nov 2025 17:15:06 +0000
Subject: [PATCH] Move pwm registration into pwm::Chip::new
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-pwm_safe_register-v1-1-d22d0ed068ac@posteo.de>
X-B4-Tracking: v=1; b=H4sIAAeHKGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyNz3YLy3PjixLTU+KLU9MziktQi3VQTyySDRCMzQ0MDQyWgvoKi1LT
 MCrCZ0bG1tQDN9qaZYwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6164;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=sjCGpsFWtUuaf2ehQRqAWM1hmZoxe+jPZ9b+8Ms+qys=;
 b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBpKIcXMTC2YLm6RK3psqVT9D3FPeDNbIUVS0/Z6
 uVDeu2svLuJAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaSiHFwAKCRA0dh/4561D
 0jYBD/9fj59gj2a/JoETjtKfRkc64iwDSeuNsxcK2D0MSGELYtluS88sGMMupAjqa+6mc1q0KVX
 N4xQmfuyhi75IpHLRAwGIsANci6mcrsO9m/p3grvVNZB6YnAdP6iI3YAqGVU3X9faFEyEyutoRB
 cUb+P3WT2gPP1Kk8VdfFuiHYPDGDrwuHhgyrcwbIBv/wC9HXGLH95mSvs7olmIvqnJ4fFFJWJQn
 HRhm7q2XIuQVN6cU5vJlWoKfYr/UhpDPgBNLgYg2+eJIkND4MJllLhejczm2Bip36oALvQczMV7
 zjlFgFv11e5wvMRa5bp2WPHtw/jaCwhRRkvkcSUz3MQ/8Zb3g+tgAgsS7LsxGIisys00PhVO179
 tio8zi9FAs++vzPfA+vJsSrVUDXBIkPXIz/UT0FWDvNaruANzUxmgS8KZ1PTGZk5KmNG7u/dEd0
 wDBPeYN6sK7w6eS1NjOzR5Ff7gvnZuNl5PrUYFH7wyulGterDjMEcyVilJ25/CCY/5WJmbf3Pe3
 QRZBpdzJQmMeC2/wc2vOQxSP0hxuBXZVEPOnQAz5eZ7bfFP4YviDq5I+pqMF4ovVeFoayRMwDQB
 Ne/R0M0Oco0loG42NCzX2ThvPi8X+WFOumb7CtXgaCAvldzeYdZ02/yJauCMABINa2frTJLAklg
 uJgsBPRgtv0SO4Q==
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

The `pwm::Registration::register` function provides no guarantee that the
function isn't called twice with the same pwm chip, which is considered
unsafe.

Add the code responsible for the registration into `pwm::Chip::new`. The
registration will happen before the driver gets access to the refcounted
pwm chip and can therefore guarantee that the registration isn't called
twice on the same pwm chip.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
This patch provides the additional guarantee that the pwm chip doesn't
get registered twice.

The following changes were made:
- change the visibility of `pwm::Registration` to private
- remove the `pwm::Registration::register` function
- add code for registering the pwm chip in `pwm::Chip::new`
- add Send + Sync bounds to `PwmOps`

Note that I wasn't able to test this patch, due to the lack of hardware.
---
 drivers/pwm/pwm_th1520.rs |  4 +---
 rust/kernel/pwm.rs        | 53 ++++++++++++++++++-----------------------------
 2 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 955c359b07fb..1919b5a1f69e 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -363,7 +363,7 @@ fn probe(
             return Err(EINVAL);
         }
 
-        let chip = pwm::Chip::new(
+        pwm::Chip::new(
             dev,
             TH1520_MAX_PWM_NUM,
             try_pin_init!(Th1520PwmDriverData {
@@ -372,8 +372,6 @@ fn probe(
             }),
         )?;
 
-        pwm::Registration::register(dev, chip)?;
-
         Ok(KBox::new(Th1520PwmPlatformDriver, GFP_KERNEL)?.into())
     }
 }
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index cb00f8a8765c..c5d03ee8bc95 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -173,7 +173,7 @@ pub struct RoundedWaveform<WfHw> {
 }
 
 /// Trait defining the operations for a PWM driver.
-pub trait PwmOps: 'static + Sized {
+pub trait PwmOps: 'static + Send + Sync + Sized {
     /// The driver-specific hardware representation of a waveform.
     ///
     /// This type must be [`Copy`], [`Default`], and fit within `PWM_WFHWSIZE`.
@@ -585,7 +585,7 @@ unsafe fn bound_parent_device(&self) -> &device::Device<Bound> {
     /// Returns an [`ARef<Chip>`] managing the chip's lifetime via refcounting
     /// on its embedded `struct device`.
     pub fn new(
-        parent_dev: &device::Device,
+        parent_dev: &device::Device<Bound>,
         num_channels: u32,
         data: impl pin_init::PinInit<T, Error>,
     ) -> Result<ARef<Self>> {
@@ -623,7 +623,21 @@ pub fn new(
         // SAFETY: `chip_ptr_as_self` points to a valid `Chip` (layout-compatible with
         // `bindings::pwm_chip`) whose embedded device has refcount 1.
         // `ARef::from_raw` takes this pointer and manages it via `AlwaysRefCounted`.
-        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) })
+        let chip = unsafe { ARef::from_raw(NonNull::new_unchecked(chip_ptr_as_self)) };
+
+        // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
+        // `__pwmchip_add` is the C function to register the chip with the PWM core.
+        unsafe {
+            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
+        }
+
+        let registration = Registration {
+            chip: ARef::clone(&chip),
+        };
+
+        devres::register(parent_dev, registration, GFP_KERNEL)?;
+
+        Ok(chip)
     }
 }
 
@@ -654,50 +668,23 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
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
 
 /// A resource guard that ensures `pwmchip_remove` is called on drop.
 ///
 /// This struct is intended to be managed by the `devres` framework by transferring its ownership
 /// via [`devres::register`]. This ties the lifetime of the PWM chip registration
 /// to the lifetime of the underlying device.
-pub struct Registration<T: PwmOps> {
+struct Registration<T: PwmOps> {
     chip: ARef<Chip<T>>,
 }
 
-impl<T: 'static + PwmOps + Send + Sync> Registration<T> {
-    /// Registers a PWM chip with the PWM subsystem.
-    ///
-    /// Transfers its ownership to the `devres` framework, which ties its lifetime
-    /// to the parent device.
-    /// On unbind of the parent device, the `devres` entry will be dropped, automatically
-    /// calling `pwmchip_remove`. This function should be called from the driver's `probe`.
-    pub fn register(dev: &device::Device<Bound>, chip: ARef<Chip<T>>) -> Result {
-        let chip_parent = chip.device().parent().ok_or(EINVAL)?;
-        if dev.as_raw() != chip_parent.as_raw() {
-            return Err(EINVAL);
-        }
-
-        let c_chip_ptr = chip.as_raw();
-
-        // SAFETY: `c_chip_ptr` points to a valid chip with its ops initialized.
-        // `__pwmchip_add` is the C function to register the chip with the PWM core.
-        unsafe {
-            to_result(bindings::__pwmchip_add(c_chip_ptr, core::ptr::null_mut()))?;
-        }
-
-        let registration = Registration { chip };
-
-        devres::register(dev, registration, GFP_KERNEL)
-    }
-}
-
 impl<T: PwmOps> Drop for Registration<T> {
     fn drop(&mut self) {
         let chip_raw = self.chip.as_raw();

---
base-commit: fae00ea9f00367771003ace78f29549dead58fc7
change-id: 20251127-pwm_safe_register-e49b0a261101


