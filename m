Return-Path: <linux-pwm+bounces-8714-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFshIJjf72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8714-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:13:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4898447B355
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66CD030132AF
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074803ACA5F;
	Mon, 27 Apr 2026 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REQ5Dyjo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673E3A9DA5;
	Mon, 27 Apr 2026 22:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327997; cv=none; b=W1hfcM8BwQN+I4FQLrKjbyxxMU1TqFI77Qi+UBbsGyPi+gkJivRtgHgC4g0nKjhJ3jc9jBvFqKNGv8RFcQgp8p+szuisQ/lhbF7tYwXTzVvEGOmZEuXMeMUsTiZX8HrGIefv+wSiI0QkQatO3lz3U0o8Q0KyOKl3RTd0kd6J+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327997; c=relaxed/simple;
	bh=mdjo1NZwY5GoH4ibGKBJ7f7j6FWnfOwIVwRbt0mj7p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGsp8DwGUUkUk2GRoukghpy70J56fcHiOrzd4NneFTF4ZwcPum26j91Zw7npr+FUIspl3e1rt1Gc0yDzfM3jUt//c41ph0TbPCVFR8q+O2Yh7wiCDX5XDHHSNgQ2UX4XNxGZTx6g8b8i26MOPqj6qBywqeHbiMO9QqMkdWLD5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REQ5Dyjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD84AC19425;
	Mon, 27 Apr 2026 22:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327997;
	bh=mdjo1NZwY5GoH4ibGKBJ7f7j6FWnfOwIVwRbt0mj7p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REQ5Dyjo/Xb+75phlrQLoIxvYM5LR5mtCtMVWPLh5geplHJXnuSyrsql6WyyEP4/V
	 aKFZmr1SXxWKEVFBHAdtlwHRkAOUq+Qv/khAGsMUe0O27l+vzFObYPs8zhpRZyQ5jy
	 E+siO0xo9hYb0KfxOKUMC5+bkWOvUlNUS7Es7Nq+Xi/SDEmFGaqMnq1QjzGyWfU7R+
	 DlrGZeV7heLceZgTuCZvAydC5X6MsmudvKfpacI9F9WJKXtXQ1zbZvhaqPinLG0sgB
	 Y48nbOux0IhkvOcXcCWT9f0dyXlN00y27+YqDB79n3DBFKgdg1Xo/tboW7gwSl2kLr
	 +UeJ6mGlwoBGw==
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
	tmgross@umich.edu
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 11/24] rust: pci: make Driver trait lifetime-parameterized
Date: Tue, 28 Apr 2026 00:11:09 +0200
Message-ID: <20260427221155.2144848-12-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4898447B355
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8714-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,forlt:email]

Make pci::Driver take a lifetime parameter 'a that ties device resources
to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a HRTB
bound for<'a> F::Of<'a>: Driver<'a>; module_pci_driver! wraps the driver
type in ForLt!() so drivers don't have to.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  9 ++-
 drivers/gpu/nova-core/nova_core.rs    |  4 +-
 rust/kernel/pci.rs                    | 79 +++++++++++++++++++--------
 samples/rust/rust_dma.rs              |  9 ++-
 samples/rust/rust_driver_auxiliary.rs | 13 +++--
 samples/rust/rust_driver_pci.rs       | 11 ++--
 6 files changed, 86 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 8fe484d357f6..815489dd92d0 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -50,7 +50,7 @@ pub(crate) struct NovaCore {
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <NovaCore as pci::Driver>::IdInfo,
+    <NovaCore as pci::Driver<'_>>::IdInfo,
     [
         // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
         (
@@ -72,11 +72,14 @@ pub(crate) struct NovaCore {
     ]
 );
 
-impl pci::Driver for NovaCore {
+impl<'a> pci::Driver<'a> for NovaCore {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        pdev: &'a pci::Device<Core>,
+        _info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 04a1fa6b25f8..49c093a0cb42 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -7,6 +7,7 @@
     driver::Registration,
     pci,
     prelude::*,
+    types::ForLt,
     InPlaceModule, //
 };
 
@@ -46,8 +47,9 @@ fn drop(&mut self) {
 struct NovaCoreModule {
     // Fields are dropped in declaration order, so `_driver` is dropped first,
     // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
+    #[allow(clippy::type_complexity)]
     #[pin]
-    _driver: Registration<pci::Adapter<driver::NovaCore>>,
+    _driver: Registration<pci::Adapter<ForLt!(driver::NovaCore)>>,
     _debugfs_guard: DebugfsRootGuard,
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 6f82f2e6c74f..73d9fcff99c4 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -58,22 +58,34 @@
 };
 
 /// An adapter for the registration of PCI drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'a>` is the driver struct parameterized by `'a`. The macro
+/// `module_pci_driver!` generates this automatically via `ForLt!()`.
+pub struct Adapter<F>(PhantomData<F>);
 
 // SAFETY:
 // - `bindings::pci_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `F::Of<'static>` is the stored type of the driver's device private data.
 // - `struct pci_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<F> driver::DriverLayout for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     type DriverType = bindings::pci_driver;
-    type DriverData = ForLt!(T);
+    type DriverData = F;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<F> driver::RegistrationOps for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     unsafe fn register(
         pdrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -84,7 +96,7 @@ unsafe fn register(
             (*pdrv.get()).name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
-            (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*pdrv.get()).id_table = <F::Of<'static> as Driver<'static>>::ID_TABLE.as_ptr();
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -99,7 +111,11 @@ unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     extern "C" fn probe_callback(
         pdev: *mut bindings::pci_dev,
         id: *const bindings::pci_device_id,
@@ -113,12 +129,12 @@ extern "C" fn probe_callback(
         // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct pci_device_id` and
         // does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
-        let info = T::ID_TABLE.info(id.index());
 
         from_result(|| {
-            let data = T::probe(pdev, info);
+            let info = <F::Of<'_> as Driver<'_>>::ID_TABLE.info(id.index());
+            let data = <F::Of<'_> as Driver<'_>>::probe(pdev, info);
 
-            pdev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
+            pdev.as_ref().set_drvdata::<F>(data)?;
             Ok(0)
         })
     }
@@ -131,16 +147,18 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<ForLt!(T)>() };
+        // `probe_callback`, hence it's guaranteed that drvdata has been set.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<F>() };
 
-        T::unbind(pdev, data);
+        <F::Of<'_> as Driver<'_>>::unbind(pdev, data);
     }
 }
 
 /// Declares a kernel module that exposes a single PCI driver.
 ///
+/// The `type` field accepts a driver type, optionally with a lifetime placeholder `'_` for
+/// lifetime-parameterized drivers. The macro wraps it in [`ForLt!`] automatically.
+///
 /// # Examples
 ///
 ///```ignore
@@ -152,10 +170,16 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 ///     license: "GPL v2",
 /// }
 ///```
+///
+/// [`ForLt!`]: macro@ForLt
+/// [`ForLt`]: trait@ForLt
 #[macro_export]
 macro_rules! module_pci_driver {
-($($f:tt)*) => {
-    $crate::module_driver!(<T>, $crate::pci::Adapter<T>, { $($f)* });
+(type: $type:ty, $($rest:tt)*) => {
+    $crate::module_driver!(<T>, $crate::pci::Adapter<T>, {
+        type: $crate::types::ForLt!($type),
+        $($rest)*
+    });
 };
 }
 
@@ -261,6 +285,9 @@ macro_rules! pci_device_table {
 
 /// The PCI driver trait.
 ///
+/// Drivers implement this trait with a lifetime parameter `'a` that ties device resources to the
+/// device scope.
+///
 /// # Examples
 ///
 ///```
@@ -271,7 +298,7 @@ macro_rules! pci_device_table {
 /// kernel::pci_device_table!(
 ///     PCI_TABLE,
 ///     MODULE_PCI_TABLE,
-///     <MyDriver as pci::Driver>::IdInfo,
+///     <MyDriver as pci::Driver<'_>>::IdInfo,
 ///     [
 ///         (
 ///             pci::DeviceId::from_id(pci::Vendor::REDHAT, bindings::PCI_ANY_ID as u32),
@@ -280,21 +307,22 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
-/// impl pci::Driver for MyDriver {
+/// impl<'a> pci::Driver<'a> for MyDriver {
 ///     type IdInfo = ();
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 ///
 ///     fn probe(
-///         _pdev: &pci::Device<Core>,
-///         _id_info: &Self::IdInfo,
-///     ) -> impl PinInit<Self, Error> {
+///         _pdev: &'a pci::Device<Core>,
+///         _id_info: &'a Self::IdInfo,
+///     ) -> impl PinInit<Self, Error> + 'a {
 ///         Err(ENODEV)
 ///     }
 /// }
 ///```
+///
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
-pub trait Driver: Send {
+pub trait Driver<'a>: Send {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
     //
@@ -310,7 +338,10 @@ pub trait Driver: Send {
     ///
     /// Called when a new pci device is added or discovered. Implementers should
     /// attempt to initialize the device here.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+    fn probe(
+        dev: &'a Device<device::Core>,
+        id_info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a;
 
     /// PCI driver unbind.
     ///
@@ -322,7 +353,7 @@ pub trait Driver: Send {
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+    fn unbind(dev: &'a Device<device::Core>, this: Pin<&'a Self>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 129bb4b39c04..8b6f8c923049 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -52,15 +52,18 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <DmaSampleDriver as pci::Driver>::IdInfo,
+    <DmaSampleDriver as pci::Driver<'_>>::IdInfo,
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
-impl pci::Driver for DmaSampleDriver {
+impl<'a> pci::Driver<'a> for DmaSampleDriver {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        pdev: &'a pci::Device<Core>,
+        _info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a {
         pin_init::pin_init_scope(move || {
             dev_info!(pdev, "Probe DMA test driver.\n");
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 319ef734c02b..f57b2b03adb6 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -14,6 +14,7 @@
     driver,
     pci,
     prelude::*,
+    types::ForLt,
     InPlaceModule, //
 };
 
@@ -59,16 +60,19 @@ struct ParentDriver {
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <ParentDriver as pci::Driver>::IdInfo,
+    <ParentDriver as pci::Driver<'_>>::IdInfo,
     [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
-impl pci::Driver for ParentDriver {
+impl<'a> pci::Driver<'a> for ParentDriver {
     type IdInfo = ();
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        pdev: &'a pci::Device<Core>,
+        _info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a {
         Ok(Self {
             _reg0: auxiliary::Registration::new(
                 pdev.as_ref(),
@@ -116,7 +120,8 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
 #[pin_data]
 struct SampleModule {
     #[pin]
-    _pci_driver: driver::Registration<pci::Adapter<ParentDriver>>,
+    #[allow(clippy::type_complexity)]
+    _pci_driver: driver::Registration<pci::Adapter<ForLt!(ParentDriver)>>,
     #[pin]
     _aux_driver: driver::Registration<auxiliary::Adapter<AuxiliaryDriver>>,
 }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 47d3e84fab63..2747beecb5fd 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -77,7 +77,7 @@ struct SampleDriver {
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <SampleDriver as pci::Driver>::IdInfo,
+    <SampleDriver as pci::Driver<'_>>::IdInfo,
     [(
         pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
         TestIndex::NO_EVENTFD
@@ -138,12 +138,15 @@ fn config_space(pdev: &pci::Device<Bound>) {
     }
 }
 
-impl pci::Driver for SampleDriver {
+impl<'a> pci::Driver<'a> for SampleDriver {
     type IdInfo = TestIndex;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        pdev: &'a pci::Device<Core>,
+        info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a {
         pin_init::pin_init_scope(move || {
             let vendor = pdev.vendor_id();
             dev_dbg!(
@@ -174,7 +177,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
         })
     }
 
-    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
+    fn unbind(pdev: &'a pci::Device<Core>, this: Pin<&'a Self>) {
         if let Ok(bar) = this.bar.access(pdev.as_ref()) {
             // Reset pci-testdev by writing a new test index.
             bar.write_reg(regs::TEST::zeroed().with_index(this.index));
-- 
2.54.0


