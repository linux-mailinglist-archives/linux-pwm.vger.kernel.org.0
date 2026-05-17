Return-Path: <linux-pwm+bounces-8916-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHPNEUAHCWprFgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8916-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:09:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C14D355E99D
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFCD130305F7
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9871EB5E3;
	Sun, 17 May 2026 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7UF07tk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A8E571;
	Sun, 17 May 2026 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976240; cv=none; b=GtqB6GCfigkp0GuNAuyv+FNm5j/+XmqqE89Dvlizh8C2PH4yvycBImrPy7HDIbu5W8FFYeScSOQfbp8lKBZguJuxVTT+lMtjfJ9/Don2/Clfgt8HatHrrCHiFRWcj12h6wi4+ihBN8WP2IMlZeOnHdqMqVglaRGmfBPLRYXG3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976240; c=relaxed/simple;
	bh=aEJ3m00qPoxQGx8zRsnF8JW3qi65Nt8T0/AEKvPsx5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieRrg5ul+eysOP0RMqcfS5bh4asw0me6YMkrylGFEQJ6rbNnrK24Du165GdR5EOLSo9po0C6/i3VfAygRco1cZ9j/wl/Qyls/zybl3bokeBx83YeMeI/8ygVfUKgI+1UP24v7mCxf19pnOgbTtdwh5GkKh4FJC2Lyw/04E6j7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7UF07tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03543C19425;
	Sun, 17 May 2026 00:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976240;
	bh=aEJ3m00qPoxQGx8zRsnF8JW3qi65Nt8T0/AEKvPsx5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7UF07tkSDnl5/lqg7CXou7KK5I74zsR1pQfyipHQwO6A+hncKBaDZR+pCdOj77SV
	 nEr0M14OMzC6jRYcyy6ViU4WY06Fj6WMjcDQWfx6Bi+FK1MHvwr8yw1gLYmauQBM3p
	 Y/kgdaHHi5VxLE97dDczlo8TojOUObk8ydsUDDtm/gBHuYQbn5okZDTc79ofTNTdlf
	 q8qRP4hQFO2wVCEddwAYtKB0peOmmo+AM9rGD2fk8hwoM+GTI5T/OTCDEOPJZl7aQ0
	 3uiTJdrMqi0JXEjK9n/xbsWmQrZDocaXQYZpZD3F33zgcsvmVw7RXoLjh6OUJ5X7yk
	 /wwhmxhXKErrw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	acourbot@nvidia.com,
	aliceryhl@google.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	viresh.kumar@linaro.org,
	m.wilczynski@samsung.com,
	ukleinek@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	abdiel.janulgue@gmail.com,
	robin.murphy@arm.com,
	markus.probst@posteo.de,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	igor.korotin@linux.dev,
	daniel.almeida@collabora.com,
	pcolberg@redhat.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 17/27] rust: auxiliary: generalize Registration over ForLt
Date: Sun, 17 May 2026 02:01:05 +0200
Message-ID: <20260517000149.3226762-18-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C14D355E99D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-8916-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[forlt:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Generalize Registration<T> to Registration<F: ForLt> and
Device::registration_data<F: ForLt>() to return Pin<&F::Of<'_>>.

The stored 'static lifetime is shortened to the borrow lifetime of &self
via ForLt::cast_ref; ForLt's covariance guarantee makes this sound.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  4 +-
 rust/kernel/auxiliary.rs              | 68 +++++++++++++++++----------
 samples/rust/rust_driver_auxiliary.rs |  8 ++--
 3 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index fe4eafe1ebf0..ab0d7f2b516c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -21,6 +21,7 @@
         },
         Arc,
     },
+    types::ForLt,
 };
 
 use crate::gpu::Gpu;
@@ -32,7 +33,8 @@
 pub(crate) struct NovaCore {
     #[pin]
     pub(crate) gpu: Gpu,
-    _reg: Devres<auxiliary::Registration<()>>,
+    #[allow(clippy::type_complexity)]
+    _reg: Devres<auxiliary::Registration<ForLt!(())>>,
 }
 
 const BAR0_SIZE: usize = SZ_16M;
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 3f1e2966c03a..db3d56106ea2 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -20,6 +20,7 @@
     },
     prelude::*,
     types::{
+        ForLt,
         ForeignOwnable,
         Opaque, //
     },
@@ -271,12 +272,16 @@ pub fn parent(&self) -> &device::Device<device::Bound> {
 
     /// Returns a pinned reference to the registration data set by the registering (parent) driver.
     ///
-    /// Returns [`EINVAL`] if `T` does not match the type used by the parent driver when calling
+    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The returned
+    /// reference has its lifetime shortened from `'static` to `&self`'s borrow lifetime via
+    /// [`ForLt::cast_ref`].
+    ///
+    /// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
     /// [`Registration::new()`].
     ///
     /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
     /// registered by a C driver.
-    pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
+    pub fn registration_data<F: ForLt>(&self) -> Result<Pin<&F::Of<'_>>> {
         // SAFETY: By the type invariant, `self.as_raw()` is a valid `struct auxiliary_device`.
         let ptr = unsafe { (*self.as_raw()).registration_data_rust };
         if ptr.is_null() {
@@ -289,18 +294,23 @@ pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
 
         // SAFETY: `ptr` is non-null and was set via `into_foreign()` in `Registration::new()`;
         // `RegistrationData` is `#[repr(C)]` with `type_id` at offset 0, so reading a `TypeId`
-        // at the start of the allocation is valid regardless of `T`.
+        // at the start of the allocation is valid regardless of `F`.
         let type_id = unsafe { ptr.cast::<TypeId>().read() };
-        if type_id != TypeId::of::<T>() {
+        if type_id != TypeId::of::<F::Of<'static>>() {
             return Err(EINVAL);
         }
 
-        // SAFETY: The `TypeId` check above confirms that the stored type is `T`; `ptr` remains
-        // valid until `Registration::drop()` calls `from_foreign()`.
-        let wrapper = unsafe { Pin::<KBox<RegistrationData<T>>>::borrow(ptr) };
+        // SAFETY: The `TypeId` check above confirms that the stored type matches
+        // `F::Of<'static>`; `ptr` remains valid until `Registration::drop()` calls
+        // `from_foreign()`.
+        let wrapper = unsafe { Pin::<KBox<RegistrationData<F::Of<'static>>>>::borrow(ptr) };
 
         // SAFETY: `data` is a structurally pinned field of `RegistrationData`.
-        Ok(unsafe { wrapper.map_unchecked(|w| &w.data) })
+        let pinned: Pin<&F::Of<'static>> = unsafe { wrapper.map_unchecked(|w| &w.data) };
+
+        // SAFETY: The data was pinned when stored; `cast_ref` only shortens
+        // the lifetime, so the pinning guarantee is preserved.
+        Ok(unsafe { Pin::new_unchecked(F::cast_ref(pinned.get_ref())) })
     }
 }
 
@@ -389,43 +399,51 @@ struct RegistrationData<T> {
 /// This type represents the registration of a [`struct auxiliary_device`]. When its parent device
 /// is unbound, the corresponding auxiliary device will be unregistered from the system.
 ///
-/// The type parameter `T` is the type of the registration data owned by the registering (parent)
-/// driver. It can be accessed by the auxiliary driver through
-/// [`Device::registration_data()`].
+/// The type parameter `F` is a [`ForLt`](trait@ForLt) encoding of the registration
+/// data type. For non-lifetime-parameterized types, use [`ForLt!(T)`](macro@ForLt).
+/// The data can be accessed by the auxiliary driver through [`Device::registration_data()`].
 ///
 /// # Invariants
 ///
 /// `self.adev` always holds a valid pointer to an initialized and registered
 /// [`struct auxiliary_device`] whose `registration_data_rust` field points to a
-/// valid `Pin<KBox<RegistrationData<T>>>`.
-pub struct Registration<T: 'static> {
+/// valid `Pin<KBox<RegistrationData<F::Of<'static>>>>`.
+pub struct Registration<F: ForLt> {
     adev: NonNull<bindings::auxiliary_device>,
-    _data: PhantomData<T>,
+    _data: PhantomData<F>,
 }
 
-impl<T: Send + Sync + 'static> Registration<T> {
+impl<F: ForLt> Registration<F>
+where
+    for<'a> F::Of<'a>: Send + Sync,
+{
     /// Create and register a new auxiliary device with the given registration data.
     ///
     /// The `data` is owned by the registration and can be accessed through the auxiliary device
     /// via [`Device::registration_data()`].
-    pub fn new<E>(
-        parent: &device::Device<device::Bound>,
+    pub fn new<'bound, E>(
+        parent: &'bound device::Device<device::Bound>,
         name: &CStr,
         id: u32,
         modname: &CStr,
-        data: impl PinInit<T, E>,
+        data: impl PinInit<F::Of<'bound>, E>,
     ) -> Result<Devres<Self>>
     where
         Error: From<E>,
     {
         let data = KBox::pin_init::<Error>(
             try_pin_init!(RegistrationData {
-                type_id: TypeId::of::<T>(),
+                type_id: TypeId::of::<F::Of<'static>>(),
                 data <- data,
             }),
             GFP_KERNEL,
         )?;
 
+        // SAFETY: Lifetimes are erased and do not affect layout, so RegistrationData<F::Of<'bound>>
+        // and RegistrationData<F::Of<'static>> have identical representation.
+        let data: Pin<KBox<RegistrationData<F::Of<'static>>>> =
+            unsafe { core::mem::transmute(data) };
+
         let boxed: KBox<Opaque<bindings::auxiliary_device>> = KBox::zeroed(GFP_KERNEL)?;
         let adev = boxed.get();
 
@@ -455,7 +473,9 @@ pub fn new<E>(
         if ret != 0 {
             // SAFETY: `registration_data` was set above via `into_foreign()`.
             drop(unsafe {
-                Pin::<KBox<RegistrationData<T>>>::from_foreign((*adev).registration_data_rust)
+                Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_foreign(
+                    (*adev).registration_data_rust,
+                )
             });
 
             // SAFETY: `adev` is guaranteed to be a valid pointer to a
@@ -478,7 +498,7 @@ pub fn new<E>(
     }
 }
 
-impl<T: 'static> Drop for Registration<T> {
+impl<F: ForLt> Drop for Registration<F> {
     fn drop(&mut self) {
         // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()` is a valid registered
         // `struct auxiliary_device`.
@@ -486,7 +506,7 @@ fn drop(&mut self) {
 
         // SAFETY: `registration_data` was set in `new()` via `into_foreign()`.
         drop(unsafe {
-            Pin::<KBox<RegistrationData<T>>>::from_foreign(
+            Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_foreign(
                 (*self.adev.as_ptr()).registration_data_rust,
             )
         });
@@ -500,7 +520,7 @@ fn drop(&mut self) {
 }
 
 // SAFETY: A `Registration` of a `struct auxiliary_device` can be released from any thread.
-unsafe impl<T: Send + Sync> Send for Registration<T> {}
+unsafe impl<F: ForLt> Send for Registration<F> where for<'a> F::Of<'a>: Send {}
 
 // SAFETY: `Registration` does not expose any methods or fields that need synchronization.
-unsafe impl<T: Send + Sync> Sync for Registration<T> {}
+unsafe impl<F: ForLt> Sync for Registration<F> where for<'a> F::Of<'a>: Send {}
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 972a3d5b25e7..7b15a107fed4 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -14,6 +14,7 @@
     driver,
     pci,
     prelude::*,
+    types::ForLt,
     InPlaceModule, //
 };
 
@@ -55,9 +56,10 @@ struct Data {
     index: u32,
 }
 
+#[allow(clippy::type_complexity)]
 struct ParentDriver {
-    _reg0: Devres<auxiliary::Registration<Data>>,
-    _reg1: Devres<auxiliary::Registration<Data>>,
+    _reg0: Devres<auxiliary::Registration<ForLt!(Data)>>,
+    _reg1: Devres<auxiliary::Registration<ForLt!(Data)>>,
 }
 
 kernel::pci_device_table!(
@@ -101,7 +103,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         let dev = adev.parent();
         let pdev: &pci::Device<Bound> = dev.try_into()?;
 
-        let data = adev.registration_data::<Data>()?;
+        let data = adev.registration_data::<ForLt!(Data)>()?;
 
         dev_info!(
             dev,
-- 
2.54.0


