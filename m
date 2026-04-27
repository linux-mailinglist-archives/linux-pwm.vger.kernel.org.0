Return-Path: <linux-pwm+bounces-8716-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CNMBb/f72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8716-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:14:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1E47B3BE
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EE7E300ED95
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A011B3AD53F;
	Mon, 27 Apr 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnO230/X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0413ACEFE;
	Mon, 27 Apr 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328010; cv=none; b=kDyl/CdAkSMwRAcQRtoiBdGCPNCtNyL8Sqx3ZpwDiuJ3cSm6cyPTPPP4ahHngwIxddfF02GfzNXNyyWZsCNO+fRFtymukxK/gQu3chcr1tgXqIo94TqbcZm0jjDp4zAeTFBySjA3pXmMTs8a0YVd8TCLf1zCpNIr96RO20vrp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328010; c=relaxed/simple;
	bh=Ax3xwk04aGwKxPdkslM0oEwfMzNKZapM3aM+lkIWrMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZUVtYHfG9BwKxM9kqYUE7+2mQVpPGwf6oZO1vZjJHkMU2pA5+kq42q+UidFLXlzSZ6/RFSH9Uddm55axq/mV2dJ0CyhX9yPAKkbFZuyYkW+4RS1LeKVIO7Dg/Kq6ERqJBFIQlfO53KzPstHRlWpXmlA7reS3Uq1WKFB1KGmXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnO230/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E832C2BCB5;
	Mon, 27 Apr 2026 22:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328010;
	bh=Ax3xwk04aGwKxPdkslM0oEwfMzNKZapM3aM+lkIWrMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YnO230/XG6ZJElTZX0PkzIyd40DOrsF6s2I8DP2WYVvPn3+hNTYrJmCsXUIP2OhNa
	 z8ESPWFYRBc8Nn698cRa+oeCjeSk3YoVusYQMt9rvQ9RL9yCJENMq0OFuJ1NO030tA
	 XjW7BnEIqXwA9DLqtkuaUSr70K3fHUqVeK4tEa0Y3ROLqspJQfwlKf8ywsCHbC/PwB
	 2pKsVeJx891r/Zo5TmcCNnQ76+8oi0YNx+BOkKYyWGb1+BV3Ej8BcOFNAygrq4DVz1
	 PXGW8J3oB+D2oGPQwK4miDKgfdKqUvSHOw2X+vrCuKo6XLSIxh5gTLh5TMpMw4cxjS
	 Hn8S5l6Bq7qnQ==
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
Subject: [PATCH 13/24] rust: auxiliary: make Driver trait lifetime-parameterized
Date: Tue, 28 Apr 2026 00:11:11 +0200
Message-ID: <20260427221155.2144848-14-dakr@kernel.org>
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
X-Rspamd-Queue-Id: C0B1E47B3BE
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
	TAGGED_FROM(0.00)[bounces-8716-lists,linux-pwm=lfdr.de];
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

Make auxiliary::Driver take a lifetime parameter 'a that ties device
resources to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a bound
for<'a> F::Of<'a>: Driver<'a>; module_auxiliary_driver! wraps the driver
type in ForLt!() so drivers don't have to.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs        |  9 ++--
 rust/kernel/auxiliary.rs              | 59 ++++++++++++++++++---------
 samples/rust/rust_driver_auxiliary.rs | 12 ++++--
 3 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b1af0a099551..183d0e679a0b 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -42,18 +42,21 @@ pub(crate) struct NovaData {
 kernel::auxiliary_device_table!(
     AUX_TABLE,
     MODULE_AUX_TABLE,
-    <NovaDriver as auxiliary::Driver>::IdInfo,
+    <NovaDriver as auxiliary::Driver<'_>>::IdInfo,
     [(
         auxiliary::DeviceId::new(NOVA_CORE_MODULE_NAME, AUXILIARY_NAME),
         ()
     )]
 );
 
-impl auxiliary::Driver for NovaDriver {
+impl<'a> auxiliary::Driver<'a> for NovaDriver {
     type IdInfo = ();
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        adev: &'a auxiliary::Device<Core>,
+        _info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a {
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
         let drm = drm::Device::<Self>::new(adev.as_ref(), data)?;
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 8a278ddb5b95..f593a21a16be 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -38,22 +38,34 @@
 };
 
 /// An adapter for the registration of auxiliary drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'a>` is the driver struct parameterized by `'a`. The macro
+/// `module_auxiliary_driver!` generates this automatically via `ForLt!()`.
+pub struct Adapter<F>(PhantomData<F>);
 
 // SAFETY:
 // - `bindings::auxiliary_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `F::Of<'static>` is the stored type of the driver's device private data.
 // - `struct auxiliary_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<F> driver::DriverLayout for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     type DriverType = bindings::auxiliary_driver;
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
         adrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -64,7 +76,7 @@ unsafe fn register(
             (*adrv.get()).name = name.as_char_ptr();
             (*adrv.get()).probe = Some(Self::probe_callback);
             (*adrv.get()).remove = Some(Self::remove_callback);
-            (*adrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*adrv.get()).id_table = <F::Of<'static> as Driver<'static>>::ID_TABLE.as_ptr();
         }
 
         // SAFETY: `adrv` is guaranteed to be a valid `DriverType`.
@@ -79,7 +91,11 @@ unsafe fn unregister(adrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     extern "C" fn probe_callback(
         adev: *mut bindings::auxiliary_device,
         id: *const bindings::auxiliary_device_id,
@@ -93,12 +109,12 @@ extern "C" fn probe_callback(
         // SAFETY: `DeviceId` is a `#[repr(transparent)`] wrapper of `struct auxiliary_device_id`
         // and does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
-        let info = T::ID_TABLE.info(id.index());
 
         from_result(|| {
-            let data = T::probe(adev, info);
+            let info = <F::Of<'_> as Driver<'_>>::ID_TABLE.info(id.index());
+            let data = <F::Of<'_> as Driver<'_>>::probe(adev, info);
 
-            adev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
+            adev.as_ref().set_drvdata::<F>(data)?;
             Ok(0)
         })
     }
@@ -111,19 +127,21 @@ extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
         let adev = unsafe { &*adev.cast::<Device<device::CoreInternal>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { adev.as_ref().drvdata_borrow::<ForLt!(T)>() };
+        // `probe_callback`, hence it's guaranteed that drvdata has been set.
+        let data = unsafe { adev.as_ref().drvdata_borrow::<F>() };
 
-        T::unbind(adev, data);
+        <F::Of<'_> as Driver<'_>>::unbind(adev, data);
     }
 }
 
 /// Declares a kernel module that exposes a single auxiliary driver.
 #[macro_export]
 macro_rules! module_auxiliary_driver {
-    ($($f:tt)*) => {
-        $crate::module_driver!(<T>, $crate::auxiliary::Adapter<T>, { $($f)* });
+    (type: $type:ty, $($rest:tt)*) => {
+        $crate::module_driver!(<T>, $crate::auxiliary::Adapter<T>, {
+            type: $crate::types::ForLt!($type),
+            $($rest)*
+        });
     };
 }
 
@@ -195,7 +213,7 @@ macro_rules! auxiliary_device_table {
 /// The auxiliary driver trait.
 ///
 /// Drivers must implement this trait in order to get an auxiliary driver registered.
-pub trait Driver {
+pub trait Driver<'a>: Send {
     /// The type holding information about each device id supported by the driver.
     ///
     /// TODO: Use associated_type_defaults once stabilized:
@@ -209,7 +227,10 @@ pub trait Driver {
     /// Auxiliary driver probe.
     ///
     /// Called when an auxiliary device is matches a corresponding driver.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+    fn probe(
+        dev: &'a Device<device::Core>,
+        id_info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a;
 
     /// Auxiliary driver unbind.
     ///
@@ -221,7 +242,7 @@ pub trait Driver {
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+    fn unbind(dev: &'a Device<device::Core>, this: Pin<&'a Self>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f57b2b03adb6..d35963ac7fa4 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -26,16 +26,19 @@
 kernel::auxiliary_device_table!(
     AUX_TABLE,
     MODULE_AUX_TABLE,
-    <AuxiliaryDriver as auxiliary::Driver>::IdInfo,
+    <AuxiliaryDriver as auxiliary::Driver<'_>>::IdInfo,
     [(auxiliary::DeviceId::new(MODULE_NAME, AUXILIARY_NAME), ())]
 );
 
-impl auxiliary::Driver for AuxiliaryDriver {
+impl<'a> auxiliary::Driver<'a> for AuxiliaryDriver {
     type IdInfo = ();
 
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        adev: &'a auxiliary::Device<Core>,
+        _info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a {
         dev_info!(
             adev,
             "Probing auxiliary driver for auxiliary device with id={}\n",
@@ -123,7 +126,8 @@ struct SampleModule {
     #[allow(clippy::type_complexity)]
     _pci_driver: driver::Registration<pci::Adapter<ForLt!(ParentDriver)>>,
     #[pin]
-    _aux_driver: driver::Registration<auxiliary::Adapter<AuxiliaryDriver>>,
+    #[allow(clippy::type_complexity)]
+    _aux_driver: driver::Registration<auxiliary::Adapter<ForLt!(AuxiliaryDriver)>>,
 }
 
 impl InPlaceModule for SampleModule {
-- 
2.54.0


