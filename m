Return-Path: <linux-pwm+bounces-8805-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHEmH4O5+2kiEAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8805-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:58:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 019674E0F7C
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED933094070
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFD3B47F7;
	Wed,  6 May 2026 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gC5RhkgC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0053B3C08;
	Wed,  6 May 2026 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104356; cv=none; b=Qx+FsIRRSKWGfN2cpminAi/ETJjQRQajwf6DBgiQiHUkqqIwT4hxbitjL7frmDmr6he19l+qa/VdsjJNHyJA1hPTUTaCmRMSSMuKID693w5/aUcCVVarPucWLR9/Pd2Xf2KAnf5SWreyxqCKxcwZ1pErMayZKaZzix2AHfYQGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104356; c=relaxed/simple;
	bh=m18eL326a7UxUeaBlXTJIluWa9nCNdGX1vUvh9wtta0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJSEsVD5HC2hDChjFrk7Wdk6uyc9snKEaUVDfXVF+HuOuUgdYJfQr0wBplsH3zCTWbl0Ww1Vx2OeDqGYYP8/HXFe6e6mGD8xQoAHRbsMFwqH10ei6Gdl5dYlWQO/ZCG9kTbqsljbeDyqURAnIAJDSh5O39QWSjmB70M4bq6P7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gC5RhkgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F895C2BCC4;
	Wed,  6 May 2026 21:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104355;
	bh=m18eL326a7UxUeaBlXTJIluWa9nCNdGX1vUvh9wtta0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gC5RhkgCZ4uSciap4Gdmes8vQkh6xOPhU3t/32U8eLWQV0RGuOamnXUIktg8PowjD
	 Q5oqLDR5MoYtPGb6p5PjE+QQ9Xf1BT2se5I6G5X3cebQ3XJO5E6xqWGaN+DpVnY5PZ
	 b8hIMezDszOO51yDROv1JwrY5jkEsuXNxIWBun/22m2CmbBRhNpU5UuMABVvRXb9x2
	 ggAbH+zey0RsUnuB04/VeO7nch0UcmmkztzlhLqksJRBhAwT2LfbQb8pXR8k3SWJlG
	 lLOPIU9LA0e0cUQpi4muYxy4pEP9LGw5JgxDmn/in9FV9Dt13coh+PFIqidriBGxpp
	 fWcAtJKX2rybA==
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
Subject: [PATCH v2 11/25] rust: platform: make Driver trait lifetime-parameterized
Date: Wed,  6 May 2026 23:50:47 +0200
Message-ID: <20260506215113.851360-12-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 019674E0F7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8805-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[forlt:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Make platform::Driver take a lifetime parameter 'bound that ties device
resources to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a bound
for<'bound> F::Of<'bound>: Driver<'bound>; module_platform_driver! wraps
the driver type in ForLt!() so drivers don't have to.

Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/cpufreq/rcpufreq_dt.rs       | 10 +--
 drivers/gpu/drm/tyr/driver.rs        | 10 +--
 drivers/pwm/pwm_th1520.rs            | 10 +--
 rust/kernel/cpufreq.rs               |  8 +--
 rust/kernel/driver.rs                |  9 ++-
 rust/kernel/io/mem.rs                | 16 ++---
 rust/kernel/platform.rs              | 93 ++++++++++++++++++----------
 samples/rust/rust_debugfs.rs         | 10 +--
 samples/rust/rust_driver_platform.rs | 12 ++--
 samples/rust/rust_i2c_client.rs      | 12 ++--
 samples/rust/rust_soc.rs             | 12 ++--
 11 files changed, 117 insertions(+), 85 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index f17bf64c22e2..f0ad2d115cf3 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -195,18 +195,18 @@ fn register_em(policy: &mut cpufreq::Policy) {
 kernel::of_device_table!(
     OF_TABLE,
     MODULE_OF_TABLE,
-    <CPUFreqDTDriver as platform::Driver>::IdInfo,
+    <CPUFreqDTDriver as platform::Driver<'_>>::IdInfo,
     [(of::DeviceId::new(c"operating-points-v2"), ())]
 );
 
-impl platform::Driver for CPUFreqDTDriver {
+impl<'bound> platform::Driver<'bound> for CPUFreqDTDriver {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'bound platform::Device<Core>,
+        _id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(pdev.as_ref())?;
         Ok(Self {})
     }
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 279710b36a10..96d83605e4b9 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -82,21 +82,21 @@ fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
 kernel::of_device_table!(
     OF_TABLE,
     MODULE_OF_TABLE,
-    <TyrPlatformDriverData as platform::Driver>::IdInfo,
+    <TyrPlatformDriverData as platform::Driver<'_>>::IdInfo,
     [
         (of::DeviceId::new(c"rockchip,rk3588-mali"), ()),
         (of::DeviceId::new(c"arm,mali-valhall-csf"), ())
     ]
 );
 
-impl platform::Driver for TyrPlatformDriverData {
+impl<'bound> platform::Driver<'bound> for TyrPlatformDriverData {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'bound platform::Device<Core>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
         let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c"stacks"))?;
         let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c"coregroup"))?;
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index ddd44a5ce497..a7831b4ebe00 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -310,18 +310,18 @@ fn drop(self: Pin<&mut Self>) {
 kernel::of_device_table!(
     OF_TABLE,
     MODULE_OF_TABLE,
-    <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
+    <Th1520PwmPlatformDriver as platform::Driver<'_>>::IdInfo,
     [(of::DeviceId::new(c"thead,th1520-pwm"), ())]
 );
 
-impl platform::Driver for Th1520PwmPlatformDriver {
+impl<'bound> platform::Driver<'bound> for Th1520PwmPlatformDriver {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'bound platform::Device<Core>,
+        _id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev = pdev.as_ref();
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index d8d26870bea2..ac59cdfd633c 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -886,14 +886,14 @@ fn register_em(_policy: &mut Policy) {
 ///     }
 /// }
 ///
-/// impl platform::Driver for SampleDriver {
+/// impl<'a> platform::Driver<'a> for SampleDriver {
 ///     type IdInfo = ();
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 ///
 ///     fn probe(
-///         pdev: &platform::Device<Core>,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self, Error> {
+///         pdev: &'a platform::Device<Core>,
+///         _id_info: Option<&'a Self::IdInfo>,
+///     ) -> impl PinInit<Self, Error> + 'a {
 ///         cpufreq::Registration::<SampleDriver>::new_foreign_owned(pdev.as_ref())?;
 ///         Ok(Self {})
 ///     }
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index e462535f545d..7c5148772697 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -13,7 +13,7 @@
 //! The main driver interface is defined by a bus specific driver trait. For instance:
 //!
 //! ```ignore
-//! pub trait Driver: Send {
+//! pub trait Driver<'bound>: Send {
 //!     /// The type holding information about each device ID supported by the driver.
 //!     type IdInfo: 'static;
 //!
@@ -24,10 +24,13 @@
 //!     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 //!
 //!     /// Driver probe.
-//!     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+//!     fn probe(
+//!         dev: &'bound Device<device::Core>,
+//!         id_info: &'bound Self::IdInfo,
+//!     ) -> impl PinInit<Self, Error> + 'bound;
 //!
 //!     /// Driver unbind (optional).
-//!     fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+//!     fn unbind(dev: &'bound Device<device::Core>, this: Pin<&'bound Self>) {
 //!         let _ = (dev, this);
 //!     }
 //! }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 7dc78d547f7a..fd5292df5870 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -60,13 +60,13 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     /// };
     /// struct SampleDriver;
     ///
-    /// impl platform::Driver for SampleDriver {
+    /// impl<'bound> platform::Driver<'bound> for SampleDriver {
     ///    # type IdInfo = ();
     ///
     ///    fn probe(
-    ///       pdev: &platform::Device<Core>,
-    ///       info: Option<&Self::IdInfo>,
-    ///    ) -> impl PinInit<Self, Error> {
+    ///       pdev: &'bound platform::Device<Core>,
+    ///       info: Option<&'bound Self::IdInfo>,
+    ///    ) -> impl PinInit<Self, Error> + 'bound {
     ///       let offset = 0; // Some offset.
     ///
     ///       // If the size is known at compile time, use [`Self::iomap_sized`].
@@ -124,13 +124,13 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     /// };
     /// struct SampleDriver;
     ///
-    /// impl platform::Driver for SampleDriver {
+    /// impl<'bound> platform::Driver<'bound> for SampleDriver {
     ///    # type IdInfo = ();
     ///
     ///    fn probe(
-    ///       pdev: &platform::Device<Core>,
-    ///       info: Option<&Self::IdInfo>,
-    ///    ) -> impl PinInit<Self, Error> {
+    ///       pdev: &'bound platform::Device<Core>,
+    ///       info: Option<&'bound Self::IdInfo>,
+    ///    ) -> impl PinInit<Self, Error> + 'bound {
     ///       let offset = 0; // Some offset.
     ///
     ///       // Unlike [`Self::iomap_sized`], here the size of the memory region
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index aec26307ae68..9959364429b5 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -44,33 +44,46 @@
 };
 
 /// An adapter for the registration of platform drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'bound>` is the driver struct
+/// parameterized by `'bound`. The macro `module_platform_driver!`
+/// generates this automatically via `ForLt!()`.
+pub struct Adapter<F>(PhantomData<F>);
 
 // SAFETY:
 // - `bindings::platform_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `F::Of<'static>` is the stored type of the driver's device private data.
 // - `struct platform_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<F> driver::DriverLayout for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     type DriverType = bindings::platform_driver;
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
         module: &'static ThisModule,
     ) -> Result {
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
@@ -94,19 +107,23 @@ unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ffi::c_int {
         // SAFETY: The platform bus only ever calls the probe callback with a valid pointer to a
         // `struct platform_device`.
         //
         // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
         let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
-        let info = <Self as driver::Adapter<'_>>::id_info(pdev.as_ref());
 
         from_result(|| {
-            let data = T::probe(pdev, info);
+            let info = <Self as driver::Adapter<'_>>::id_info(pdev.as_ref());
+            let data = <F::Of<'_> as Driver<'_>>::probe(pdev, info);
 
-            pdev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
+            pdev.as_ref().set_drvdata::<F>(data)?;
             Ok(0)
         })
     }
@@ -119,28 +136,34 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
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
 
-impl<'bound, T: Driver + 'static> driver::Adapter<'bound> for Adapter<T> {
-    type IdInfo = T::IdInfo;
+impl<'bound, F> driver::Adapter<'bound> for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'b> F::Of<'b>: Driver<'b>,
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
 
 /// Declares a kernel module that exposes a single platform driver.
 ///
+/// The `type` field accepts a driver type, optionally with a lifetime placeholder `'_` for
+/// lifetime-parameterized drivers. The macro wraps it in [`ForLt!`] automatically.
+///
 /// # Examples
 ///
 /// ```ignore
@@ -152,10 +175,16 @@ fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
 ///     license: "GPL v2",
 /// }
 /// ```
+///
+/// [`ForLt!`]: macro@ForLt
+/// [`ForLt`]: trait@ForLt
 #[macro_export]
 macro_rules! module_platform_driver {
-    ($($f:tt)*) => {
-        $crate::module_driver!(<T>, $crate::platform::Adapter<T>, { $($f)* });
+    (type: $type:ty, $($rest:tt)*) => {
+        $crate::module_driver!(<T>, $crate::platform::Adapter<T>, {
+            type: $crate::types::ForLt!($type),
+            $($rest)*
+        });
     };
 }
 
@@ -178,7 +207,7 @@ macro_rules! module_platform_driver {
 /// kernel::of_device_table!(
 ///     OF_TABLE,
 ///     MODULE_OF_TABLE,
-///     <MyDriver as platform::Driver>::IdInfo,
+///     <MyDriver as platform::Driver<'_>>::IdInfo,
 ///     [
 ///         (of::DeviceId::new(c"test,device"), ())
 ///     ]
@@ -187,26 +216,26 @@ macro_rules! module_platform_driver {
 /// kernel::acpi_device_table!(
 ///     ACPI_TABLE,
 ///     MODULE_ACPI_TABLE,
-///     <MyDriver as platform::Driver>::IdInfo,
+///     <MyDriver as platform::Driver<'_>>::IdInfo,
 ///     [
 ///         (acpi::DeviceId::new(c"LNUXBEEF"), ())
 ///     ]
 /// );
 ///
-/// impl platform::Driver for MyDriver {
+/// impl<'bound> platform::Driver<'bound> for MyDriver {
 ///     type IdInfo = ();
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
 ///     fn probe(
-///         _pdev: &platform::Device<Core>,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self, Error> {
+///         _pdev: &'bound platform::Device<Core>,
+///         _id_info: Option<&'bound Self::IdInfo>,
+///     ) -> impl PinInit<Self, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 /// }
 ///```
-pub trait Driver: Send {
+pub trait Driver<'bound>: Send {
     /// The type holding driver private data about each device id supported by the driver.
     // TODO: Use associated_type_defaults once stabilized:
     //
@@ -226,9 +255,9 @@ pub trait Driver: Send {
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
     fn probe(
-        dev: &Device<device::Core>,
-        id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error>;
+        dev: &'bound Device<device::Core>,
+        id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound;
 
     /// Platform driver unbind.
     ///
@@ -240,7 +269,7 @@ fn probe(
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+    fn unbind(dev: &'bound Device<device::Core>, this: Pin<&'bound Self>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 0963efe19f93..ca73c0ef4a79 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -111,19 +111,19 @@ fn from_str(s: &str) -> Result<Self> {
 kernel::acpi_device_table!(
     ACPI_TABLE,
     MODULE_ACPI_TABLE,
-    <RustDebugFs as platform::Driver>::IdInfo,
+    <RustDebugFs as platform::Driver<'_>>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
 );
 
-impl platform::Driver for RustDebugFs {
+impl<'bound> platform::Driver<'bound> for RustDebugFs {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'bound platform::Device<Core>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         RustDebugFs::new(pdev).pin_chain(|this| {
             this.counter.store(91, Relaxed);
             {
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index f2229d176fb9..5b7037eb4b3f 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -88,26 +88,26 @@ struct SampleDriver {
 kernel::of_device_table!(
     OF_TABLE,
     MODULE_OF_TABLE,
-    <SampleDriver as platform::Driver>::IdInfo,
+    <SampleDriver as platform::Driver<'_>>::IdInfo,
     [(of::DeviceId::new(c"test,rust-device"), Info(42))]
 );
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
     MODULE_ACPI_TABLE,
-    <SampleDriver as platform::Driver>::IdInfo,
+    <SampleDriver as platform::Driver<'_>>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), Info(0))]
 );
 
-impl platform::Driver for SampleDriver {
+impl<'bound> platform::Driver<'bound> for SampleDriver {
     type IdInfo = Info;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'bound platform::Device<Core>,
+        info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev = pdev.as_ref();
 
         dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
index 8d2c12e535b0..e21595a4376e 100644
--- a/samples/rust/rust_i2c_client.rs
+++ b/samples/rust/rust_i2c_client.rs
@@ -88,14 +88,14 @@ struct SampleDriver {
 kernel::of_device_table!(
     OF_TABLE,
     MODULE_OF_TABLE,
-    <SampleDriver as platform::Driver>::IdInfo,
+    <SampleDriver as platform::Driver<'_>>::IdInfo,
     [(of::DeviceId::new(c"test,rust-device"), ())]
 );
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
     MODULE_ACPI_TABLE,
-    <SampleDriver as platform::Driver>::IdInfo,
+    <SampleDriver as platform::Driver<'_>>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
 );
 
@@ -104,15 +104,15 @@ struct SampleDriver {
 const BOARD_INFO: i2c::I2cBoardInfo =
     i2c::I2cBoardInfo::new(c"rust_driver_i2c", SAMPLE_I2C_CLIENT_ADDR);
 
-impl platform::Driver for SampleDriver {
+impl<'bound> platform::Driver<'bound> for SampleDriver {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<device::Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'bound platform::Device<device::Core>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         dev_info!(
             pdev.as_ref(),
             "Probe Rust I2C Client registration sample.\n"
diff --git a/samples/rust/rust_soc.rs b/samples/rust/rust_soc.rs
index 8079c1c48416..356d093bc8dd 100644
--- a/samples/rust/rust_soc.rs
+++ b/samples/rust/rust_soc.rs
@@ -24,26 +24,26 @@ struct SampleSocDriver {
 kernel::of_device_table!(
     OF_TABLE,
     MODULE_OF_TABLE,
-    <SampleSocDriver as platform::Driver>::IdInfo,
+    <SampleSocDriver as platform::Driver<'_>>::IdInfo,
     [(of::DeviceId::new(c"test,rust-device"), ())]
 );
 
 kernel::acpi_device_table!(
     ACPI_TABLE,
     MODULE_ACPI_TABLE,
-    <SampleSocDriver as platform::Driver>::IdInfo,
+    <SampleSocDriver as platform::Driver<'_>>::IdInfo,
     [(acpi::DeviceId::new(c"LNUXBEEF"), ())]
 );
 
-impl platform::Driver for SampleSocDriver {
+impl<'bound> platform::Driver<'bound> for SampleSocDriver {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'bound platform::Device<Core>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         dev_dbg!(pdev, "Probe Rust SoC driver sample.\n");
 
         let pdev = pdev.into();
-- 
2.54.0


