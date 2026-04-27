Return-Path: <linux-pwm+bounces-8715-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPXYOavf72kiHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8715-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:14:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA22A47B393
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32490301653C
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA953AD512;
	Mon, 27 Apr 2026 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtvLu9O5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D1D3ACEE1;
	Mon, 27 Apr 2026 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328004; cv=none; b=SwMo+4GNQfP6fRhRQmOecFMxUnczuiy19eo1wkyTRbu3IRIcDKmOaa79Mpsuj7JbyhBQyfHkSw3jaI7kj5BFKkkTYq4rIStVxpZoQsnL6YQBqSmwr+TE/pYssapuurij+ZKiZS9KGlb0Eag2bbsEK7YPbAcJ2LvpKWbZtrOaAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328004; c=relaxed/simple;
	bh=SbAAS0eADHxx3DW9A0GSuIcQ7Z1EZxALrR6avIv2uEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAW8zJHHtk7Eupa0rrR7Zj9qUHaTXNXS1Ue7vOml+xfkp0f5wg+RkYOgcwMusRpc7rXmKlW/ZXlNOhZbYHxXhMFCd094tRIKS4T9gCQjDMMzNP7JzuLpRD0Esi3U3dmRtX5Heaf3BVPVuUvrb45nS29tF0j0JJToBGYY0sS4l9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtvLu9O5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0439AC2BCB6;
	Mon, 27 Apr 2026 22:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328003;
	bh=SbAAS0eADHxx3DW9A0GSuIcQ7Z1EZxALrR6avIv2uEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XtvLu9O5wx83IVLI0xcCL+XYbcSgk9I7l5pDwudA4ugR8IetY1J7ZP8JkK3RelTx5
	 9wTDlKBWIrCIzCj6fGlPo0d134QQy+1a8G64zqw0nXox7H4WuwbbuHHEtbZb3rUp76
	 S8QO3p/shJ/YSjj/FQadgMGjxkAQnTb5JQnAyRLY/eE0qWrZ2/a6Eby8IUzWQgfUN4
	 tTyMV5R0+Eb8qIRq3NaiIvBBqMnn98jHE8LInbEGqkNa4YKnVchAzZRlHv63azmKQN
	 TMfNpFFYWlfzuY6MVl6jB9vf17xFKY92pFKUuQECSdJP6djwmw/oZ83bYpDKdmB3r5
	 weUJforu5dQ7w==
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
Subject: [PATCH 12/24] rust: platform: make Driver trait lifetime-parameterized
Date: Tue, 28 Apr 2026 00:11:10 +0200
Message-ID: <20260427221155.2144848-13-dakr@kernel.org>
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
X-Rspamd-Queue-Id: AA22A47B393
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
	TAGGED_FROM(0.00)[bounces-8715-lists,linux-pwm=lfdr.de];
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

Make platform::Driver take a lifetime parameter 'a that ties device
resources to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a bound
for<'a> F::Of<'a>: Driver<'a>; module_platform_driver! wraps the driver
type in ForLt!() so drivers don't have to.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/cpufreq/rcpufreq_dt.rs       | 10 +--
 drivers/gpu/drm/tyr/driver.rs        | 10 +--
 drivers/pwm/pwm_th1520.rs            | 10 +--
 rust/kernel/cpufreq.rs               |  8 +--
 rust/kernel/driver.rs                |  9 ++-
 rust/kernel/io/mem.rs                | 16 ++---
 rust/kernel/platform.rs              | 92 ++++++++++++++++++----------
 samples/rust/rust_debugfs.rs         | 10 +--
 samples/rust/rust_driver_platform.rs | 12 ++--
 samples/rust/rust_i2c_client.rs      | 12 ++--
 samples/rust/rust_soc.rs             | 12 ++--
 11 files changed, 116 insertions(+), 85 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index f17bf64c22e2..06c05f946829 100644
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
+impl<'a> platform::Driver<'a> for CPUFreqDTDriver {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'a platform::Device<Core>,
+        _id_info: Option<&'a Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'a {
         cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(pdev.as_ref())?;
         Ok(Self {})
     }
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 279710b36a10..7cc47ec76863 100644
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
+impl<'a> platform::Driver<'a> for TyrPlatformDriverData {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'a platform::Device<Core>,
+        _info: Option<&'a Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'a {
         let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
         let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c"stacks"))?;
         let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c"coregroup"))?;
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index ddd44a5ce497..7139f3f4373d 100644
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
+impl<'a> platform::Driver<'a> for Th1520PwmPlatformDriver {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'a platform::Device<Core>,
+        _id_info: Option<&'a Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'a {
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
index 91490040d77e..03974690406b 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -13,7 +13,7 @@
 //! The main driver interface is defined by a bus specific driver trait. For instance:
 //!
 //! ```ignore
-//! pub trait Driver: Send {
+//! pub trait Driver<'a>: Send {
 //!     /// The type holding information about each device ID supported by the driver.
 //!     type IdInfo: 'static;
 //!
@@ -24,10 +24,13 @@
 //!     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 //!
 //!     /// Driver probe.
-//!     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+//!     fn probe(
+//!         dev: &'a Device<device::Core>,
+//!         id_info: &'a Self::IdInfo,
+//!     ) -> impl PinInit<Self, Error> + 'a;
 //!
 //!     /// Driver unbind (optional).
-//!     fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+//!     fn unbind(dev: &'a Device<device::Core>, this: Pin<&'a Self>) {
 //!         let _ = (dev, this);
 //!     }
 //! }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 7dc78d547f7a..a483e59054e8 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -60,13 +60,13 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     /// };
     /// struct SampleDriver;
     ///
-    /// impl platform::Driver for SampleDriver {
+    /// impl<'a> platform::Driver<'a> for SampleDriver {
     ///    # type IdInfo = ();
     ///
     ///    fn probe(
-    ///       pdev: &platform::Device<Core>,
-    ///       info: Option<&Self::IdInfo>,
-    ///    ) -> impl PinInit<Self, Error> {
+    ///       pdev: &'a platform::Device<Core>,
+    ///       info: Option<&'a Self::IdInfo>,
+    ///    ) -> impl PinInit<Self, Error> + 'a {
     ///       let offset = 0; // Some offset.
     ///
     ///       // If the size is known at compile time, use [`Self::iomap_sized`].
@@ -124,13 +124,13 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     /// };
     /// struct SampleDriver;
     ///
-    /// impl platform::Driver for SampleDriver {
+    /// impl<'a> platform::Driver<'a> for SampleDriver {
     ///    # type IdInfo = ();
     ///
     ///    fn probe(
-    ///       pdev: &platform::Device<Core>,
-    ///       info: Option<&Self::IdInfo>,
-    ///    ) -> impl PinInit<Self, Error> {
+    ///       pdev: &'a platform::Device<Core>,
+    ///       info: Option<&'a Self::IdInfo>,
+    ///    ) -> impl PinInit<Self, Error> + 'a {
     ///       let offset = 0; // Some offset.
     ///
     ///       // Unlike [`Self::iomap_sized`], here the size of the memory region
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index ae648304eb5b..ec41886b0ba3 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -44,33 +44,45 @@
 };
 
 /// An adapter for the registration of platform drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'a>` is the driver struct parameterized by `'a`. The macro
+/// `module_platform_driver!` generates this automatically via `ForLt!()`.
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
+    for<'a> F::Of<'a>: Driver<'a>,
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
+    for<'a> F::Of<'a>: Driver<'a>,
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
@@ -94,19 +106,23 @@ unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
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
@@ -119,28 +135,34 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
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
 
-impl<'a, T: Driver + 'static> driver::Adapter<'a> for Adapter<T> {
-    type IdInfo = T::IdInfo;
+impl<'a, F> driver::Adapter<'a> for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'b> F::Of<'b>: Driver<'b>,
+{
+    type IdInfo = <F::Of<'a> as Driver<'a>>::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
-        T::OF_ID_TABLE
+        <F::Of<'a> as Driver<'a>>::OF_ID_TABLE
     }
 
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
-        T::ACPI_ID_TABLE
+        <F::Of<'a> as Driver<'a>>::ACPI_ID_TABLE
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
@@ -152,10 +174,16 @@ fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
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
 
@@ -178,7 +206,7 @@ macro_rules! module_platform_driver {
 /// kernel::of_device_table!(
 ///     OF_TABLE,
 ///     MODULE_OF_TABLE,
-///     <MyDriver as platform::Driver>::IdInfo,
+///     <MyDriver as platform::Driver<'_>>::IdInfo,
 ///     [
 ///         (of::DeviceId::new(c"test,device"), ())
 ///     ]
@@ -187,26 +215,26 @@ macro_rules! module_platform_driver {
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
+/// impl<'a> platform::Driver<'a> for MyDriver {
 ///     type IdInfo = ();
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
 ///     fn probe(
-///         _pdev: &platform::Device<Core>,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self, Error> {
+///         _pdev: &'a platform::Device<Core>,
+///         _id_info: Option<&'a Self::IdInfo>,
+///     ) -> impl PinInit<Self, Error> + 'a {
 ///         Err(ENODEV)
 ///     }
 /// }
 ///```
-pub trait Driver: Send {
+pub trait Driver<'a>: Send {
     /// The type holding driver private data about each device id supported by the driver.
     // TODO: Use associated_type_defaults once stabilized:
     //
@@ -226,9 +254,9 @@ pub trait Driver: Send {
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
     fn probe(
-        dev: &Device<device::Core>,
-        id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error>;
+        dev: &'a Device<device::Core>,
+        id_info: Option<&'a Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'a;
 
     /// Platform driver unbind.
     ///
@@ -240,7 +268,7 @@ fn probe(
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+    fn unbind(dev: &'a Device<device::Core>, this: Pin<&'a Self>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 0963efe19f93..0d88a9aaa957 100644
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
+impl<'a> platform::Driver<'a> for RustDebugFs {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'a platform::Device<Core>,
+        _info: Option<&'a Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'a {
         RustDebugFs::new(pdev).pin_chain(|this| {
             this.counter.store(91, Relaxed);
             {
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index f2229d176fb9..cf9177bf3202 100644
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
+impl<'a> platform::Driver<'a> for SampleDriver {
     type IdInfo = Info;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'a platform::Device<Core>,
+        info: Option<&'a Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'a {
         let dev = pdev.as_ref();
 
         dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
index 8d2c12e535b0..342755df8b95 100644
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
+impl<'a> platform::Driver<'a> for SampleDriver {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<device::Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'a platform::Device<device::Core>,
+        _info: Option<&'a Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'a {
         dev_info!(
             pdev.as_ref(),
             "Probe Rust I2C Client registration sample.\n"
diff --git a/samples/rust/rust_soc.rs b/samples/rust/rust_soc.rs
index 8079c1c48416..16f1e4bcfa36 100644
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
+impl<'a> platform::Driver<'a> for SampleSocDriver {
     type IdInfo = ();
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+        pdev: &'a platform::Device<Core>,
+        _info: Option<&'a Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'a {
         dev_dbg!(pdev, "Probe Rust SoC driver sample.\n");
 
         let pdev = pdev.into();
-- 
2.54.0


