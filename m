Return-Path: <linux-pwm+bounces-8807-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBiQNqy4+2k0DwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8807-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:54:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 592614E0DFF
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FA34301D94D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CF33B47FD;
	Wed,  6 May 2026 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPSEuIOI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6173B3C13;
	Wed,  6 May 2026 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104369; cv=none; b=WJ+AeuN9M85cpk1Tzex496795iKTzgz9jqIF1iDE4B5r7MOm+uG0V57I6pNHNlz6JSxLcA94YUuC0/195r80OGFtJX9+YpIGDVKCcRSj86wj/XLHvEO5mgXqP6USdHcnAw3mWaF7DjIzmIqdcZpXTL1hx0vdOb1heukJwrhrlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104369; c=relaxed/simple;
	bh=/QsI18VRrkWM/0er0Ht6IXGPiMe3T+8m/tPEwZGU5xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrP1pJ0iSOE94u2Md/kMkGtqOADZeFEjGpt2xBKXYc0UQbjkIhbjzKOswPSy8C363iWG78vpUG9SeTY2bqVf5h4mBQR08VQ/utp85pxQvBxlhMX0gveYQMtHyFol8oPcNrkZmWFmBYtPKI/vxm8/zBw1HuN49uRfwyERuvL8qCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPSEuIOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02114C2BCC9;
	Wed,  6 May 2026 21:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104369;
	bh=/QsI18VRrkWM/0er0Ht6IXGPiMe3T+8m/tPEwZGU5xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPSEuIOIw5Yoi9UWFFIZ8cjMb6orSavyW4gfg3wKuUCRAGMGsmFoaXb3fTZAzW+jt
	 3lsol0H2mVDhm2Eu4TX214XN01cx4ec4PrmqKA/RinxBUibjudM3Y0T9i+n3kjWWLt
	 mmR897JQkVb/hf3b33Ykuuf0NBUnfWko3v88bten+kfMjb1JjPgq39Kd73xPhQAfXs
	 oHNTWxKJ7f3c2JkSthm9iW6H1nExAKzEfg6lvhr6U/g5CNBbq9Cx1dBF2vds2q3dVD
	 qSfvaApH80HYC3QwZ4QjlkOEOXhu09g1OKTr/aCY2muXEDvPfHVrGixG1hUBEZlFlV
	 u5AkHb5FrFfBw==
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
	daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 13/25] rust: auxiliary: generalize Registration over ForLt
Date: Wed,  6 May 2026 23:50:49 +0200
Message-ID: <20260506215113.851360-14-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 592614E0DFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8807-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Generalize Registration<T> to Registration<F: ForLt> and
Device::registration_data<F: ForLt>() to return Pin<&F::Of<'_>>.

The stored 'static lifetime is shortened to the borrow lifetime of &self
via ForLt::cast_ref; ForLt's covariance guarantee makes this sound.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  4 +-
 rust/kernel/auxiliary.rs              | 67 +++++++++++++++++----------
 samples/rust/rust_driver_auxiliary.rs |  7 +--
 3 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index d0ccfbc8d0ea..ed154cd93fa8 100644
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
index d2785a841380..cbfb32298fde 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -288,12 +288,16 @@ pub fn parent(&self) -> &device::Device<device::Bound> {
 
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
@@ -306,18 +310,23 @@ pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
 
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
 
@@ -406,43 +415,51 @@ struct RegistrationData<T> {
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
+    for<'a> F::Of<'a>: Send,
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
 
@@ -472,7 +489,9 @@ pub fn new<E>(
         if ret != 0 {
             // SAFETY: `registration_data` was set above via `into_foreign()`.
             drop(unsafe {
-                Pin::<KBox<RegistrationData<T>>>::from_foreign((*adev).registration_data_rust)
+                Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_foreign(
+                    (*adev).registration_data_rust,
+                )
             });
 
             // SAFETY: `adev` is guaranteed to be a valid pointer to a
@@ -495,7 +514,7 @@ pub fn new<E>(
     }
 }
 
-impl<T: 'static> Drop for Registration<T> {
+impl<F: ForLt> Drop for Registration<F> {
     fn drop(&mut self) {
         // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()` is a valid registered
         // `struct auxiliary_device`.
@@ -503,7 +522,7 @@ fn drop(&mut self) {
 
         // SAFETY: `registration_data` was set in `new()` via `into_foreign()`.
         drop(unsafe {
-            Pin::<KBox<RegistrationData<T>>>::from_foreign(
+            Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_foreign(
                 (*self.adev.as_ptr()).registration_data_rust,
             )
         });
@@ -517,7 +536,7 @@ fn drop(&mut self) {
 }
 
 // SAFETY: A `Registration` of a `struct auxiliary_device` can be released from any thread.
-unsafe impl<T: Send + Sync> Send for Registration<T> {}
+unsafe impl<F: ForLt> Send for Registration<F> where for<'a> F::Of<'a>: Send {}
 
 // SAFETY: `Registration` does not expose any methods or fields that need synchronization.
-unsafe impl<T: Send + Sync> Sync for Registration<T> {}
+unsafe impl<F: ForLt> Sync for Registration<F> where for<'a> F::Of<'a>: Send {}
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 6baeb1dde5da..de44ba901967 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -55,9 +55,10 @@ struct Data {
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
@@ -100,7 +101,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         let dev = adev.parent();
         let pdev: &pci::Device<Bound> = dev.try_into()?;
 
-        let data = adev.registration_data::<Data>()?;
+        let data = adev.registration_data::<ForLt!(Data)>()?;
 
         dev_info!(
             dev,
-- 
2.54.0


