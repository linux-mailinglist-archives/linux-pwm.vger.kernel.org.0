Return-Path: <linux-pwm+bounces-8804-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLwMAmm4+2k0DwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8804-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:53:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B41B4E0D6C
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15338301947D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744403B47EC;
	Wed,  6 May 2026 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/kTinFp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A23B3C19;
	Wed,  6 May 2026 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104349; cv=none; b=Bu/AQGEBYLU552AROig+5Eds8FJ0W5JAondUUXn7i/5pyNTD75r8N55rtoPnXyOrFsQ58Gnvo1WagbKOvcsh8pFtlzOsjmRqrTmGf/MdAbSMDJAa3B+/q60w2uDRJ9uJfpEyyROP/ON6exJCAVIkR0l9ubkjO+Ikqtw1zsoxa6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104349; c=relaxed/simple;
	bh=ig5DV0Sc4uVWVdLoZr3ZmpFzcTtS822JAW+IY4+QRxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvZW9hRVuh/gNLdtsxQ8nV6CVKAm30WgiD5IJ7+1cap9Ql6N4aGn1H4bpZ/ik2rBLepoy35yMkns61nYoxCq8W/0u4f0P0FUcz3lEwSNV1F31cbjLqUn0KxgM6vVCvr5XdjKBj2XfGURab8rXul39DrSf3W/2iDcIhHuaKnQCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/kTinFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7111C2BCC4;
	Wed,  6 May 2026 21:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104349;
	bh=ig5DV0Sc4uVWVdLoZr3ZmpFzcTtS822JAW+IY4+QRxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/kTinFpYiLdcgsk9g/ipcufmJ28uyG5/TtU456pVzuI2LTwykr3G+FevCNrd3vOg
	 nkBXwjxjoLzHEwAuusi7/YSalnUrIx4Rq71ix5vF7xCm3dq0c6+3YLfdAbLMP7xpCL
	 ikGPvnUdEztaO99lvtasnh63Z9QSNUjy/NV+2BANeL8hzrSiDcNckXU0bPf1AGj6Pr
	 l9XQmxZEij7lLji3u2dqmAdhO/P6bh5JWewcwZ1Lt+vXepe1Ksa5svXoKyTGGI/vm4
	 T9enMIfsFlQjK6JXfXZRKLat0C6GNgvwmZRPCthfTB5hNm96JW1vVc5WCy/pqs81sy
	 BDPMHSa0cOAIA==
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
Subject: [PATCH v2 10/25] rust: pci: make Driver trait lifetime-parameterized
Date: Wed,  6 May 2026 23:50:46 +0200
Message-ID: <20260506215113.851360-11-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 8B41B4E0D6C
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
	TAGGED_FROM(0.00)[bounces-8804-lists,linux-pwm=lfdr.de];
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

Make pci::Driver take a lifetime parameter 'bound that ties device
resources to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a HRTB
bound for<'bound> F::Of<'bound>: Driver<'bound>; module_pci_driver!
wraps the driver type in ForLt!() so drivers don't have to.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  9 ++-
 drivers/gpu/nova-core/nova_core.rs    |  4 +-
 rust/kernel/pci.rs                    | 80 +++++++++++++++++++--------
 samples/rust/rust_dma.rs              |  9 ++-
 samples/rust/rust_driver_auxiliary.rs | 13 +++--
 samples/rust/rust_driver_pci.rs       | 11 ++--
 6 files changed, 87 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 8fe484d357f6..d0ccfbc8d0ea 100644
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
+impl<'bound> pci::Driver<'bound> for NovaCore {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        pdev: &'bound pci::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
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
index 6f82f2e6c74f..1335857cae94 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -58,22 +58,35 @@
 };
 
 /// An adapter for the registration of PCI drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'bound>` is the driver struct
+/// parameterized by `'bound`. The macro `module_pci_driver!` generates
+/// this automatically via `ForLt!()`.
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
+    for<'bound> F::Of<'bound>: Driver<'bound>,
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
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     unsafe fn register(
         pdrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -84,7 +97,7 @@ unsafe fn register(
             (*pdrv.get()).name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
-            (*pdrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*pdrv.get()).id_table = <F::Of<'static> as Driver<'static>>::ID_TABLE.as_ptr();
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
@@ -99,7 +112,11 @@ unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     extern "C" fn probe_callback(
         pdev: *mut bindings::pci_dev,
         id: *const bindings::pci_device_id,
@@ -113,12 +130,12 @@ extern "C" fn probe_callback(
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
@@ -131,16 +148,18 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
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
@@ -152,10 +171,16 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
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
 
@@ -261,6 +286,9 @@ macro_rules! pci_device_table {
 
 /// The PCI driver trait.
 ///
+/// Drivers implement this trait with a lifetime parameter `'bound` that ties
+/// device resources to the device scope.
+///
 /// # Examples
 ///
 ///```
@@ -271,7 +299,7 @@ macro_rules! pci_device_table {
 /// kernel::pci_device_table!(
 ///     PCI_TABLE,
 ///     MODULE_PCI_TABLE,
-///     <MyDriver as pci::Driver>::IdInfo,
+///     <MyDriver as pci::Driver<'_>>::IdInfo,
 ///     [
 ///         (
 ///             pci::DeviceId::from_id(pci::Vendor::REDHAT, bindings::PCI_ANY_ID as u32),
@@ -280,21 +308,22 @@ macro_rules! pci_device_table {
 ///     ]
 /// );
 ///
-/// impl pci::Driver for MyDriver {
+/// impl<'bound> pci::Driver<'bound> for MyDriver {
 ///     type IdInfo = ();
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 ///
 ///     fn probe(
-///         _pdev: &pci::Device<Core>,
-///         _id_info: &Self::IdInfo,
-///     ) -> impl PinInit<Self, Error> {
+///         _pdev: &'bound pci::Device<Core>,
+///         _id_info: &'bound Self::IdInfo,
+///     ) -> impl PinInit<Self, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 /// }
 ///```
+///
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
-pub trait Driver: Send {
+pub trait Driver<'bound>: Send {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
     //
@@ -310,7 +339,10 @@ pub trait Driver: Send {
     ///
     /// Called when a new pci device is added or discovered. Implementers should
     /// attempt to initialize the device here.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+    fn probe(
+        dev: &'bound Device<device::Core>,
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound;
 
     /// PCI driver unbind.
     ///
@@ -322,7 +354,7 @@ pub trait Driver: Send {
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+    fn unbind(dev: &'bound Device<device::Core>, this: Pin<&'bound Self>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 129bb4b39c04..e8b3e2e799f3 100644
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
+impl<'bound> pci::Driver<'bound> for DmaSampleDriver {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        pdev: &'bound pci::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_info!(pdev, "Probe DMA test driver.\n");
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 319ef734c02b..a1b42d30580e 100644
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
+impl<'bound> pci::Driver<'bound> for ParentDriver {
     type IdInfo = ();
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        pdev: &'bound pci::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
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
index 47d3e84fab63..794311691d1e 100644
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
+impl<'bound> pci::Driver<'bound> for SampleDriver {
     type IdInfo = TestIndex;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        pdev: &'bound pci::Device<Core>,
+        info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             let vendor = pdev.vendor_id();
             dev_dbg!(
@@ -174,7 +177,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
         })
     }
 
-    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
+    fn unbind(pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self>) {
         if let Ok(bar) = this.bar.access(pdev.as_ref()) {
             // Reset pci-testdev by writing a new test index.
             bar.write_reg(regs::TEST::zeroed().with_index(this.index));
-- 
2.54.0


