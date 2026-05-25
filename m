Return-Path: <linux-pwm+bounces-9149-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJZRDrmyFGoHPgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9149-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:36:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF93F5CE8FE
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E581301256A
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA03ACF1F;
	Mon, 25 May 2026 20:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMWblnp9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED03AD52E;
	Mon, 25 May 2026 20:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741139; cv=none; b=Tv8NXe/y0gAPwBOzdij1Yhk3JEDArXL4nJsyV5I73SKluEGMvMN61Wd6UasEzs+oa7yFNtkxwqCSgRE8RR01AY2s/thy0cv6ge0kJdBJFdDn4B4NBrKVDS3N+2PMpp985ZS+GCW5t4TWy0l773PfiMPukaL2S/BhpdrxvYfER0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741139; c=relaxed/simple;
	bh=4DHQw9eKOJiPSF0yo6o6S+FEkFSRtACLgacvFmGr/OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL+vzjnza5AwYgtIXcSNWMjdoc/k8FmSzkeoShcuVylVzeITYScO2q9OP9pmgT/dNuN3jLalpcrKBW0nXNbTMzGjkBF6uhYxFKghq6kOkQFtKcUZjRsv/k3HuCBPlDkOahUU6kJphOTcnXI9docqClLXkdaKvJDDPTVqXUFReHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMWblnp9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3731F00A3C;
	Mon, 25 May 2026 20:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741136;
	bh=VlEFGAzw+HUYppR1B8Mu1locJbyWufzNCgGKfk+h2vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YMWblnp9Hf07OuhKdAsN4znef0aXSHAyDlnUxBDP4HyFIoim2Xep6kUHK9w9BlE9v
	 cCgo1RKqi+dY0zW+s2PzVY00LtG2lqeUQrUMgimS2ebIbQz74KI8bfoXRY1Qbw9qWx
	 7x9r8lQJkfu1CMpa/rsCrjkmbasbjWXqRg2md3Ur7M3f7VGo90flssuxW1kc4MACjP
	 63hJidMnB9rQBjykWkvqR/wDrSQkcnKJRzFGiHm238fZicQGlKWf1CS8+nRo/hcbvd
	 lzYiYOsiGJja7dGd/+WWahJU+0c1nC1eBjXq9oJvCqTIfFQb/lkZSi387r96a3vcyv
	 iPSnvdWT7cNKQ==
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
	Danilo Krummrich <dakr@kernel.org>,
	Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v5 23/24] rust: auxiliary: generalize Registration over ForLt
Date: Mon, 25 May 2026 22:21:10 +0200
Message-ID: <20260525202921.124698-24-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9149-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,forlt:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: EF93F5CE8FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Generalize Registration<T> to Registration<F: ForLt> and
Device::registration_data<F: ForLt>() to return Pin<&F::Of<'_>>.

The stored 'static lifetime is shortened to the borrow lifetime of &self
via ForLt::cast_ref; ForLt's covariance guarantee makes this sound.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  13 ++--
 rust/kernel/auxiliary.rs              | 108 +++++++++++++++++++-------
 samples/rust/rust_driver_auxiliary.rs |  19 +++--
 3 files changed, 96 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index fa898fe5c893..d3f2245ba2e0 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -3,7 +3,6 @@
 use kernel::{
     auxiliary,
     device::Core,
-    devres::Devres,
     dma::Device,
     dma::DmaMask,
     pci,
@@ -21,6 +20,7 @@
         },
         Arc,
     },
+    types::ForLt,
 };
 
 use crate::gpu::Gpu;
@@ -29,10 +29,11 @@
 static AUXILIARY_ID_COUNTER: Atomic<u32> = Atomic::new(0);
 
 #[pin_data]
-pub(crate) struct NovaCore {
+pub(crate) struct NovaCore<'bound> {
     #[pin]
     pub(crate) gpu: Gpu,
-    _reg: Devres<auxiliary::Registration<()>>,
+    #[allow(clippy::type_complexity)]
+    _reg: auxiliary::Registration<'bound, ForLt!(())>,
 }
 
 pub(crate) struct NovaCoreDriver;
@@ -76,13 +77,13 @@ pub(crate) struct NovaCore {
 
 impl pci::Driver for NovaCoreDriver {
     type IdInfo = ();
-    type Data<'bound> = NovaCore;
+    type Data<'bound> = NovaCore<'bound>;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
-    ) -> impl PinInit<NovaCore, Error> + 'bound {
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
@@ -115,7 +116,7 @@ fn probe<'bound>(
         })
     }
 
-    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&NovaCore>) {
+    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         this.gpu.unbind(pdev.as_ref());
     }
 }
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 7a1b1a7b7ca6..75ddb0220748 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -12,7 +12,7 @@
         RawDeviceId,
         RawDeviceIdIndex, //
     },
-    devres::Devres,
+
     driver,
     error::{
         from_result,
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
+    pub fn registration_data<F: ForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
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
+        if type_id != TypeId::of::<F>() {
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
 
@@ -389,43 +399,61 @@ struct RegistrationData<T> {
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
+pub struct Registration<'a, F: ForLt + 'static> {
     adev: NonNull<bindings::auxiliary_device>,
-    _data: PhantomData<T>,
+    #[allow(clippy::type_complexity)]
+    _phantom: PhantomData<(fn(&'a ()) -> &'a (), F)>,
 }
 
-impl<T: Send + Sync + 'static> Registration<T> {
+impl<'a, F: ForLt> Registration<'a, F>
+where
+    for<'b> F::Of<'b>: Send + Sync,
+{
     /// Create and register a new auxiliary device with the given registration data.
     ///
     /// The `data` is owned by the registration and can be accessed through the auxiliary device
     /// via [`Device::registration_data()`].
-    pub fn new<E>(
-        parent: &device::Device<device::Bound>,
+    ///
+    /// # Safety
+    ///
+    /// The caller must not `mem::forget()` the returned [`Registration`] or otherwise prevent its
+    /// [`Drop`] implementation from running, since the registration data may contain borrowed
+    /// references that become invalid after `'a` ends.
+    ///
+    /// If the registration data is `'static`, use the safe [`Registration::new()`] instead.
+    pub unsafe fn new_with_lt<E>(
+        parent: &'a device::Device<device::Bound>,
         name: &CStr,
         id: u32,
         modname: &CStr,
-        data: impl PinInit<T, E>,
-    ) -> Result<Devres<Self>>
+        data: impl PinInit<F::Of<'a>, E>,
+    ) -> Result<Self>
     where
         Error: From<E>,
     {
         let data = KBox::pin_init::<Error>(
             try_pin_init!(RegistrationData {
-                type_id: TypeId::of::<T>(),
+                type_id: TypeId::of::<F>(),
                 data <- data,
             }),
             GFP_KERNEL,
         )?;
 
+        // SAFETY: `'a` is invariant (via `Registration`'s `PhantomData`). Lifetimes do not
+        // affect layout, so RegistrationData<F::Of<'a>> and RegistrationData<F::Of<'static>>
+        // have identical representation.
+        let data: Pin<KBox<RegistrationData<F::Of<'static>>>> =
+            unsafe { core::mem::transmute(data) };
+
         let boxed: KBox<Opaque<bindings::auxiliary_device>> = KBox::zeroed(GFP_KERNEL)?;
         let adev = boxed.get();
 
@@ -455,7 +483,9 @@ pub fn new<E>(
         if ret != 0 {
             // SAFETY: `registration_data` was set above via `into_foreign()`.
             drop(unsafe {
-                Pin::<KBox<RegistrationData<T>>>::from_foreign((*adev).registration_data_rust)
+                Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_foreign(
+                    (*adev).registration_data_rust,
+                )
             });
 
             // SAFETY: `adev` is guaranteed to be a valid pointer to a
@@ -467,18 +497,36 @@ pub fn new<E>(
 
         // INVARIANT: The device will remain registered until `auxiliary_device_delete()` is
         // called, which happens in `Self::drop()`.
-        let reg = Self {
+        Ok(Self {
             // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated
             // successfully.
             adev: unsafe { NonNull::new_unchecked(adev) },
-            _data: PhantomData,
-        };
+            _phantom: PhantomData,
+        })
+    }
 
-        Devres::new::<core::convert::Infallible>(parent, reg)
+    /// Create and register a new auxiliary device with `'static` registration data.
+    ///
+    /// Safe variant of [`Registration::new_with_lt()`] for registration data that does not contain
+    /// borrowed references.
+    pub fn new<E>(
+        parent: &'a device::Device<device::Bound>,
+        name: &CStr,
+        id: u32,
+        modname: &CStr,
+        data: impl PinInit<F::Of<'a>, E>,
+    ) -> Result<Self>
+    where
+        F::Of<'a>: 'static,
+        Error: From<E>,
+    {
+        // SAFETY: `F::Of<'a>: 'static` guarantees the data contains no borrowed references,
+        // so forgetting the `Registration` cannot cause use-after-free.
+        unsafe { Self::new_with_lt(parent, name, id, modname, data) }
     }
 }
 
-impl<T: 'static> Drop for Registration<T> {
+impl<F: ForLt> Drop for Registration<'_, F> {
     fn drop(&mut self) {
         // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()` is a valid registered
         // `struct auxiliary_device`.
@@ -486,7 +534,7 @@ fn drop(&mut self) {
 
         // SAFETY: `registration_data` was set in `new()` via `into_foreign()`.
         drop(unsafe {
-            Pin::<KBox<RegistrationData<T>>>::from_foreign(
+            Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_foreign(
                 (*self.adev.as_ptr()).registration_data_rust,
             )
         });
@@ -500,7 +548,7 @@ fn drop(&mut self) {
 }
 
 // SAFETY: A `Registration` of a `struct auxiliary_device` can be released from any thread.
-unsafe impl<T: Send + Sync> Send for Registration<T> {}
+unsafe impl<F: ForLt> Send for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
 
 // SAFETY: `Registration` does not expose any methods or fields that need synchronization.
-unsafe impl<T: Send + Sync> Sync for Registration<T> {}
+unsafe impl<F: ForLt> Sync for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index b30a4d5cdf8a..e3e811a14110 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -10,10 +10,10 @@
         Bound,
         Core, //
     },
-    devres::Devres,
     driver,
     pci,
     prelude::*,
+    types::ForLt,
     InPlaceModule, //
 };
 
@@ -55,9 +55,12 @@ struct Data {
     index: u32,
 }
 
-struct ParentDriver {
-    _reg0: Devres<auxiliary::Registration<Data>>,
-    _reg1: Devres<auxiliary::Registration<Data>>,
+struct ParentDriver;
+
+#[allow(clippy::type_complexity)]
+struct ParentData<'bound> {
+    _reg0: auxiliary::Registration<'bound, ForLt!(Data)>,
+    _reg1: auxiliary::Registration<'bound, ForLt!(Data)>,
 }
 
 kernel::pci_device_table!(
@@ -69,15 +72,15 @@ struct ParentDriver {
 
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
-    type Data<'bound> = Self;
+    type Data<'bound> = ParentData<'bound>;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
-    ) -> impl PinInit<Self, Error> + 'bound {
-        Ok(Self {
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        Ok(ParentData {
             _reg0: auxiliary::Registration::new(
                 pdev.as_ref(),
                 AUXILIARY_NAME,
@@ -101,7 +104,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         let dev = adev.parent();
         let pdev: &pci::Device<Bound> = dev.try_into()?;
 
-        let data = adev.registration_data::<Data>()?;
+        let data = adev.registration_data::<ForLt!(Data)>()?;
 
         dev_info!(
             dev,
-- 
2.54.0


