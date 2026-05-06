Return-Path: <linux-pwm+bounces-8810-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFHdLe24+2k0DwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8810-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:55:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB294E0E6B
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF563305EA14
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244793B6BFD;
	Wed,  6 May 2026 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/U0zFjp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DD364052;
	Wed,  6 May 2026 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104389; cv=none; b=OWb2l9LV+wUNkMRC+DpXf80Mg0zckAo5oKMudxXjOjrQr5WUf0dKrH4M0u9XcNzaZI5vMyRkBM+N4UkVGryVW2xH7U2hk7YNzv1bmRNQyWMofdopSlbAsADNAeUiXDC+CYWDbzegIYIIcrnGWDHuSqtP16UipagxPEwlnrTkpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104389; c=relaxed/simple;
	bh=2Eca7fHkT4mXNq9mfuLx9YKSfzIqR9YZSmP1nxSgjdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjBHawDZZXAl9khGWcPIJ+zoJff6yUo6+nMzMwxlnUiCXTqk21F55wyVo0wb8GYXphWITMpfA1S7fIAofGzub/+WDeGqB0PcO9MZ3LKNFlyTfpj3eswyGCLcH2JWe0r+zzXpvOXCMpdx7ZBDWLqFiMSOzZXfl61hb3e4+tyqH6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/U0zFjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462D1C2BCB0;
	Wed,  6 May 2026 21:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104389;
	bh=2Eca7fHkT4mXNq9mfuLx9YKSfzIqR9YZSmP1nxSgjdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/U0zFjpQuVvANkGXt+f7jg269KYBiY/xfHKHTIewM7mkDjGNYR3IHIr4rK4JcYi8
	 zVWWsBoXPmH6Lm+sam+HZXdXYsv9bDX1c7dMP95A7/WZJn/MtzR40bHlvRnRM32pZZ
	 yQFLWMlEp246a65CHpumtLy9U5mtImpj/BfrwCRueOWsnjzJgcS2agZp7ZgaWriWGx
	 gb6Szlz7fl/zK9cwm9BqM6vs6xlSg1AcyFgXtfH8UAVp/mbcEktj+opfrbP9AlUM5k
	 oKMVXXlywUGXhD9EhWb5qOYqGiAz+XuCl4j59eTU+PdUyfkWz1phKDyIRxou/UJCe/
	 qeyj4Hw8Xo3HQ==
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
Subject: [PATCH v2 16/25] rust: i2c: make Driver trait lifetime-parameterized
Date: Wed,  6 May 2026 23:50:52 +0200
Message-ID: <20260506215113.851360-17-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 3EB294E0E6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-8810-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[forlt:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Action: no action

Make i2c::Driver take a lifetime parameter 'bound that ties device
resources to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a bound
for<'bound> F::Of<'bound>: Driver<'bound>; module_i2c_driver! wraps the
driver type in ForLt!() so drivers don't have to.

Acked-by: Igor Korotin <igor.korotin@linux.dev>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/i2c.rs              | 119 +++++++++++++++++++-------------
 samples/rust/rust_driver_i2c.rs |  18 ++---
 2 files changed, 81 insertions(+), 56 deletions(-)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 208c73aa3ce3..2216b49604b2 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -92,43 +92,58 @@ macro_rules! i2c_device_table {
 }
 
 /// An adapter for the registration of I2C drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'bound>` is the driver struct
+/// parameterized by `'bound`. The macro `module_i2c_driver!` generates
+/// this automatically via `ForLt!()`.
+pub struct Adapter<F>(PhantomData<F>);
 
 // SAFETY:
 // - `bindings::i2c_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `F::Of<'static>` is the stored type of the driver's device private data.
 // - `struct i2c_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<F> driver::DriverLayout for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     type DriverType = bindings::i2c_driver;
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
         idrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
         module: &'static ThisModule,
     ) -> Result {
         build_assert!(
-            T::ACPI_ID_TABLE.is_some() || T::OF_ID_TABLE.is_some() || T::I2C_ID_TABLE.is_some(),
+            <F::Of<'static> as Driver<'static>>::ACPI_ID_TABLE.is_some()
+                || <F::Of<'static> as Driver<'static>>::OF_ID_TABLE.is_some()
+                || <F::Of<'static> as Driver<'static>>::I2C_ID_TABLE.is_some(),
             "At least one of ACPI/OF/Legacy tables must be present when registering an i2c driver"
         );
 
-        let i2c_table = match T::I2C_ID_TABLE {
+        let i2c_table = match <F::Of<'static> as Driver<'static>>::I2C_ID_TABLE {
             Some(table) => table.as_ptr(),
             None => core::ptr::null(),
         };
 
-        let of_table = match T::OF_ID_TABLE {
+        let of_table = match <F::Of<'static> as Driver<'static>>::OF_ID_TABLE {
             Some(table) => table.as_ptr(),
             None => core::ptr::null(),
         };
 
-        let acpi_table = match T::ACPI_ID_TABLE {
+        let acpi_table = match <F::Of<'static> as Driver<'static>>::ACPI_ID_TABLE {
             Some(table) => table.as_ptr(),
             None => core::ptr::null(),
         };
@@ -154,7 +169,11 @@ unsafe fn unregister(idrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_int {
         // SAFETY: The I2C bus only ever calls the probe callback with a valid pointer to a
         // `struct i2c_client`.
@@ -162,13 +181,12 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_
         // INVARIANT: `idev` is valid for the duration of `probe_callback()`.
         let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
 
-        let info = Self::i2c_id_info(idev)
-            .or_else(|| <Self as driver::Adapter<'_>>::id_info(idev.as_ref()));
-
         from_result(|| {
-            let data = T::probe(idev, info);
+            let info = Self::i2c_id_info(idev)
+                .or_else(|| <Self as driver::Adapter<'_>>::id_info(idev.as_ref()));
+            let data = <F::Of<'_> as Driver<'_>>::probe(idev, info);
 
-            idev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
+            idev.as_ref().set_drvdata::<F>(data)?;
             Ok(0)
         })
     }
@@ -178,11 +196,10 @@ extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
         let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `I2cClient::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<ForLt!(T)>() };
+        // `probe_callback`, hence it's guaranteed that drvdata has been set.
+        let data = unsafe { idev.as_ref().drvdata_borrow::<F>() };
 
-        T::unbind(idev, data);
+        <F::Of<'_> as Driver<'_>>::unbind(idev, data);
     }
 
     extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
@@ -190,23 +207,24 @@ extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
         let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
 
         // SAFETY: `shutdown_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<ForLt!(T)>() };
+        // `probe_callback`, hence it's guaranteed that drvdata has been set.
+        let data = unsafe { idev.as_ref().drvdata_borrow::<F>() };
 
-        T::shutdown(idev, data);
+        <F::Of<'_> as Driver<'_>>::shutdown(idev, data);
     }
 
     /// The [`i2c::IdTable`] of the corresponding driver.
-    fn i2c_id_table() -> Option<IdTable<<Self as driver::Adapter<'static>>::IdInfo>> {
-        T::I2C_ID_TABLE
+    fn i2c_id_table<'bound>() -> Option<IdTable<<F::Of<'bound> as Driver<'bound>>::IdInfo>> {
+        <F::Of<'bound> as Driver<'bound>>::I2C_ID_TABLE
     }
 
     /// Returns the driver's private data from the matching entry in the [`i2c::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`i2c::IdTable`].
-    fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter<'static>>::IdInfo> {
-        let table = Self::i2c_id_table()?;
+    fn i2c_id_info<'bound>(
+        dev: &I2cClient,
+    ) -> Option<&'bound <F::Of<'bound> as Driver<'bound>>::IdInfo> {
+        let table = Self::i2c_id_table::<'bound>()?;
 
         // SAFETY:
         // - `table` has static lifetime, hence it's valid for reads
@@ -225,15 +243,19 @@ fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter<'sta
     }
 }
 
-impl<'bound, T: Driver + 'static> driver::Adapter<'bound> for Adapter<T> {
-    type IdInfo = T::IdInfo;
+impl<'bound, F> driver::Adapter<'bound> for Adapter<F>
+where
+    F: ForLt + 'static,
+    F::Of<'bound>: Driver<'bound>,
+{
+    type IdInfo = <F::Of<'bound> as Driver<'bound>>::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
-        T::OF_ID_TABLE
+        <F::Of<'bound> as Driver<'bound>>::OF_ID_TABLE
     }
 
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
-        T::ACPI_ID_TABLE
+        <F::Of<'bound> as Driver<'bound>>::ACPI_ID_TABLE
     }
 }
 
@@ -252,8 +274,11 @@ fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
 /// ```
 #[macro_export]
 macro_rules! module_i2c_driver {
-    ($($f:tt)*) => {
-        $crate::module_driver!(<T>, $crate::i2c::Adapter<T>, { $($f)* });
+    (type: $type:ty, $($rest:tt)*) => {
+        $crate::module_driver!(<T>, $crate::i2c::Adapter<T>, {
+            type: $crate::types::ForLt!($type),
+            $($rest)*
+        });
     };
 }
 
@@ -271,7 +296,7 @@ macro_rules! module_i2c_driver {
 /// kernel::acpi_device_table!(
 ///     ACPI_TABLE,
 ///     MODULE_ACPI_TABLE,
-///     <MyDriver as i2c::Driver>::IdInfo,
+///     <MyDriver as i2c::Driver<'_>>::IdInfo,
 ///     [
 ///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
 ///     ]
@@ -280,7 +305,7 @@ macro_rules! module_i2c_driver {
 /// kernel::i2c_device_table!(
 ///     I2C_TABLE,
 ///     MODULE_I2C_TABLE,
-///     <MyDriver as i2c::Driver>::IdInfo,
+///     <MyDriver as i2c::Driver<'_>>::IdInfo,
 ///     [
 ///          (i2c::DeviceId::new(c"rust_driver_i2c"), ())
 ///     ]
@@ -289,30 +314,30 @@ macro_rules! module_i2c_driver {
 /// kernel::of_device_table!(
 ///     OF_TABLE,
 ///     MODULE_OF_TABLE,
-///     <MyDriver as i2c::Driver>::IdInfo,
+///     <MyDriver as i2c::Driver<'_>>::IdInfo,
 ///     [
 ///         (of::DeviceId::new(c"test,device"), ())
 ///     ]
 /// );
 ///
-/// impl i2c::Driver for MyDriver {
+/// impl<'bound> i2c::Driver<'bound> for MyDriver {
 ///     type IdInfo = ();
 ///     const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
 ///     fn probe(
-///         _idev: &i2c::I2cClient<Core>,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self, Error> {
+///         _idev: &'bound i2c::I2cClient<Core>,
+///         _id_info: Option<&'bound Self::IdInfo>,
+///     ) -> impl PinInit<Self, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn shutdown(_idev: &i2c::I2cClient<Core>, this: Pin<&Self>) {
+///     fn shutdown(_idev: &'bound i2c::I2cClient<Core>, _this: Pin<&'bound Self>) {
 ///     }
 /// }
 ///```
-pub trait Driver: Send {
+pub trait Driver<'bound>: Send {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
     //
@@ -335,9 +360,9 @@ pub trait Driver: Send {
     /// Called when a new i2c client is added or discovered.
     /// Implementers should attempt to initialize the client here.
     fn probe(
-        dev: &I2cClient<device::Core>,
-        id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error>;
+        dev: &'bound I2cClient<device::Core>,
+        id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound;
 
     /// I2C driver shutdown.
     ///
@@ -350,7 +375,7 @@ fn probe(
     /// This callback is distinct from final resource cleanup, as the driver instance remains valid
     /// after it returns. Any deallocation or teardown of driver-owned resources should instead be
     /// handled in `Self::drop`.
-    fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self>) {
+    fn shutdown(dev: &'bound I2cClient<device::Core>, this: Pin<&'bound Self>) {
         let _ = (dev, this);
     }
 
@@ -364,7 +389,7 @@ fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self>) {
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &I2cClient<device::Core>, this: Pin<&Self>) {
+    fn unbind(dev: &'bound I2cClient<device::Core>, this: Pin<&'bound Self>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
index 6be79f9e9fb5..042a18305817 100644
--- a/samples/rust/rust_driver_i2c.rs
+++ b/samples/rust/rust_driver_i2c.rs
@@ -15,25 +15,25 @@
 kernel::acpi_device_table! {
     ACPI_TABLE,
     MODULE_ACPI_TABLE,
-    <SampleDriver as i2c::Driver>::IdInfo,
+    <SampleDriver as i2c::Driver<'_>>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), 0)]
 }
 
 kernel::i2c_device_table! {
     I2C_TABLE,
     MODULE_I2C_TABLE,
-    <SampleDriver as i2c::Driver>::IdInfo,
+    <SampleDriver as i2c::Driver<'_>>::IdInfo,
     [(i2c::DeviceId::new(c"rust_driver_i2c"), 0)]
 }
 
 kernel::of_device_table! {
     OF_TABLE,
     MODULE_OF_TABLE,
-    <SampleDriver as i2c::Driver>::IdInfo,
+    <SampleDriver as i2c::Driver<'_>>::IdInfo,
     [(of::DeviceId::new(c"test,rust_driver_i2c"), 0)]
 }
 
-impl i2c::Driver for SampleDriver {
+impl<'bound> i2c::Driver<'bound> for SampleDriver {
     type IdInfo = u32;
 
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
@@ -41,9 +41,9 @@ impl i2c::Driver for SampleDriver {
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        idev: &i2c::I2cClient<Core>,
-        info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        idev: &'bound i2c::I2cClient<Core>,
+        info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev = idev.as_ref();
 
         dev_info!(dev, "Probe Rust I2C driver sample.\n");
@@ -55,11 +55,11 @@ fn probe(
         Ok(Self)
     }
 
-    fn shutdown(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
+    fn shutdown(idev: &'bound i2c::I2cClient<Core>, _this: Pin<&'bound Self>) {
         dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
     }
 
-    fn unbind(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
+    fn unbind(idev: &'bound i2c::I2cClient<Core>, _this: Pin<&'bound Self>) {
         dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
     }
 }
-- 
2.54.0


