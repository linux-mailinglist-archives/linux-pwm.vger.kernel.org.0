Return-Path: <linux-pwm+bounces-9130-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDQ2H2exFGrRPQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9130-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:30:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A235CE6A5
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50E6A30069BB
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBC1388363;
	Mon, 25 May 2026 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnPwiRC3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E83955F4;
	Mon, 25 May 2026 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741002; cv=none; b=nAJbQDqUk1Agtm/OCaA79xooWnkKzlJAAdXFSQ07po1SxXwaeNfJ3wdh+0ejEYkwcDzkVfOIbbHUZ058dceGaml6OUwvNeePgH8Lp0SEu2qc8dS8TqiyY55uBCiTZDc9n6NrtkaSk2GP/ftzoZIrjlnYmyhJ9syRfVl4ygTEd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741002; c=relaxed/simple;
	bh=jsxWW33MlkwtfKju181aNOljKAsUse2QnDaSAaJDcxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNtNYML71Gxgd6obO4+FMWzN0UstbbvC96qx7fTD3pL2rPB4Kb2z7ds+x6cGICOMtOzMv1xyrzo3w28/sjsoqfk7rCjNi7LRxGDwPuxmj+JXaccfhHg26im9pDGn6V3VgzfgYjmkLnlD//IrleRpZ/aGub8i6v6BwctMx5vV3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnPwiRC3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CEB1F000E9;
	Mon, 25 May 2026 20:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779740999;
	bh=0iP7sZBb9E3qme6lvOuUvj+4Ge60LO6CjY0iXVsayTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnPwiRC3VhnkYbmCyxSNqxITPLRYMJg6ARNiA5Mu1Csy+7gL49EVAMdfm1L9I2iCx
	 SPF7p/Tz354db6t7yTyCP9px92hYwavYPkbWgESUrBESucS103D2QtDAiOQBtGfIHB
	 iyASSyRaUn0Q2r2teGtPPHnBPzspy7LozKSFnFaNTOXtQjKXi99pck+0xwH81sSF7e
	 Ce2ONE94Xh4zLGQyXZL+AdqK0uiO/air8u2Y883Ce8ZbdxzXHS3EfNuQy06boftZct
	 Lj4DopGMEV8hVvdcA5W9lJ1OVVQpsNJ30w8ieEWC6v9vCRcJFCDyz3C0BMJtEusu5N
	 ++P/j+/rFtWvw==
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
Subject: [PATCH v5 04/24] rust: driver: decouple driver private data from driver type
Date: Mon, 25 May 2026 22:20:51 +0200
Message-ID: <20260525202921.124698-5-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9130-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,nvidia.com:email,garyguo.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B2A235CE6A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a type Data<'bound> associated type to all bus driver traits,
decoupling the driver's bus device private data type from the driver
struct itself.

In the context of adding a 'bound lifetime, making this an associated
type has the advantage that it allows us to avoid a driver trait global
lifetime and it avoids the need for ForLt for bus device private data;
both of which make the subsequent implementation by buses much simpler.

All existing drivers and doc examples set type Data = Self to preserve
the current behavior.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/cpufreq/rcpufreq_dt.rs        |  1 +
 drivers/gpu/drm/nova/driver.rs        |  1 +
 drivers/gpu/drm/tyr/driver.rs         |  1 +
 drivers/gpu/nova-core/driver.rs       |  1 +
 drivers/pwm/pwm_th1520.rs             |  1 +
 rust/kernel/auxiliary.rs              | 18 +++++++++------
 rust/kernel/cpufreq.rs                |  1 +
 rust/kernel/driver.rs                 | 24 +++++++++++---------
 rust/kernel/i2c.rs                    | 32 +++++++++++++++------------
 rust/kernel/io/mem.rs                 |  2 ++
 rust/kernel/pci.rs                    | 21 +++++++++++-------
 rust/kernel/platform.rs               | 20 ++++++++++-------
 rust/kernel/usb.rs                    | 20 ++++++++++-------
 samples/rust/rust_debugfs.rs          |  1 +
 samples/rust/rust_dma.rs              |  1 +
 samples/rust/rust_driver_auxiliary.rs |  2 ++
 samples/rust/rust_driver_i2c.rs       |  1 +
 samples/rust/rust_driver_pci.rs       |  1 +
 samples/rust/rust_driver_platform.rs  |  1 +
 samples/rust/rust_driver_usb.rs       |  1 +
 samples/rust/rust_i2c_client.rs       |  1 +
 samples/rust/rust_soc.rs              |  1 +
 22 files changed, 98 insertions(+), 55 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index f17bf64c22e2..b7eeb2730eb0 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -201,6 +201,7 @@ fn register_em(policy: &mut cpufreq::Policy) {
 
 impl platform::Driver for CPUFreqDTDriver {
     type IdInfo = ();
+    type Data = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b1af0a099551..08136ec0bccb 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -51,6 +51,7 @@ pub(crate) struct NovaData {
 
 impl auxiliary::Driver for NovaDriver {
     type IdInfo = ();
+    type Data = Self;
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
     fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 279710b36a10..c81bf217743d 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -91,6 +91,7 @@ fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
 
 impl platform::Driver for TyrPlatformDriverData {
     type IdInfo = ();
+    type Data = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 8fe484d357f6..699e27046c93 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -74,6 +74,7 @@ pub(crate) struct NovaCore {
 
 impl pci::Driver for NovaCore {
     type IdInfo = ();
+    type Data = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index ddd44a5ce497..07795910a0b5 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -316,6 +316,7 @@ fn drop(self: Pin<&mut Self>) {
 
 impl platform::Driver for Th1520PwmPlatformDriver {
     type IdInfo = ();
+    type Data = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 35b44d194f67..4e83f9e27d78 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -41,12 +41,12 @@
 
 // SAFETY:
 // - `bindings::auxiliary_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `T::Data` is the type of the driver's device private data.
 // - `struct auxiliary_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::auxiliary_driver;
-    type DriverData = T;
+    type DriverData<'bound> = T::Data;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -111,8 +111,8 @@ extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { adev.as_ref().drvdata_borrow::<T>() };
+        // and stored a `Pin<KBox<T::Data>>`.
+        let data = unsafe { adev.as_ref().drvdata_borrow::<T::Data>() };
 
         T::unbind(adev, data);
     }
@@ -202,13 +202,17 @@ pub trait Driver {
     /// type IdInfo: 'static = ();
     type IdInfo: 'static;
 
+    /// The type of the driver's bus device private data.
+    type Data: Send;
+
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
 
     /// Auxiliary driver probe.
     ///
     /// Called when an auxiliary device is matches a corresponding driver.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
+        -> impl PinInit<Self::Data, Error>;
 
     /// Auxiliary driver unbind.
     ///
@@ -219,8 +223,8 @@ pub trait Driver {
     /// `&Device<Core>` or `&Device<Bound>` reference. For instance, drivers may try to perform I/O
     /// operations to gracefully tear down the device.
     ///
-    /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+    /// Otherwise, release operations for driver resources should be performed in `Drop`.
+    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 }
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index d8d26870bea2..50dd2a2c3e81 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -888,6 +888,7 @@ fn register_em(_policy: &mut Policy) {
 ///
 /// impl platform::Driver for SampleDriver {
 ///     type IdInfo = ();
+///     type Data = Self;
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 ///
 ///     fn probe(
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index c8406dc4da60..5fd1cfd64e93 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -13,10 +13,13 @@
 //! The main driver interface is defined by a bus specific driver trait. For instance:
 //!
 //! ```ignore
-//! pub trait Driver: Send {
+//! pub trait Driver {
 //!     /// The type holding information about each device ID supported by the driver.
 //!     type IdInfo: 'static;
 //!
+//!     /// The type of the driver's bus device private data.
+//!     type Data: Send;
+//!
 //!     /// The table of OF device ids supported by the driver.
 //!     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 //!
@@ -24,10 +27,11 @@
 //!     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 //!
 //!     /// Driver probe.
-//!     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+//!     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
+//!         -> impl PinInit<Self::Data, Error>;
 //!
 //!     /// Driver unbind (optional).
-//!     fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+//!     fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
 //!         let _ = (dev, this);
 //!     }
 //! }
@@ -42,9 +46,9 @@
 )]
 #![cfg_attr(CONFIG_PCI, doc = "* [`pci::Driver`](kernel::pci::Driver)")]
 //!
-//! The `probe()` callback should return a `impl PinInit<Self, Error>`, i.e. the driver's private
-//! data. The bus abstraction should store the pointer in the corresponding bus device. The generic
-//! [`Device`] infrastructure provides common helpers for this purpose on its
+//! The `probe()` callback should return a `impl PinInit<Self::Data, Error>`, i.e. the driver's
+//! private data. The bus abstraction should store the pointer in the corresponding bus device. The
+//! generic [`Device`] infrastructure provides common helpers for this purpose on its
 //! [`Device<CoreInternal>`] implementation.
 //!
 //! All driver callbacks should provide a reference to the driver's private data. Once the driver
@@ -118,8 +122,8 @@ pub unsafe trait DriverLayout {
     /// The specific driver type embedding a `struct device_driver`.
     type DriverType: Default;
 
-    /// The type of the driver's device private data.
-    type DriverData;
+    /// The type of the driver's bus device private data.
+    type DriverData<'bound>;
 
     /// Byte offset of the embedded `struct device_driver` within `DriverType`.
     ///
@@ -193,8 +197,8 @@ extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // driver's device private data.
         //
         // SAFETY: By the safety requirements of the `Driver` trait, `T::DriverData` is the
-        // driver's device private data type.
-        drop(unsafe { dev.drvdata_obtain::<T::DriverData>() });
+        // driver's bus device private data type.
+        drop(unsafe { dev.drvdata_obtain::<T::DriverData<'_>>() });
     }
 
     /// Attach generic `struct device_driver` callbacks.
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 4ccee4ba4f23..bfd081518615 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -93,12 +93,12 @@ macro_rules! i2c_device_table {
 
 // SAFETY:
 // - `bindings::i2c_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `T::Data` is the type of the driver's device private data.
 // - `struct i2c_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::i2c_driver;
-    type DriverData = T;
+    type DriverData<'bound> = T::Data;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -176,8 +176,8 @@ extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `I2cClient::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<T>() };
+        // and stored a `Pin<KBox<T::Data>>`.
+        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data>() };
 
         T::unbind(idev, data);
     }
@@ -188,8 +188,8 @@ extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
 
         // SAFETY: `shutdown_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<T>() };
+        // and stored a `Pin<KBox<T::Data>>`.
+        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data>() };
 
         T::shutdown(idev, data);
     }
@@ -294,6 +294,7 @@ macro_rules! module_i2c_driver {
 ///
 /// impl i2c::Driver for MyDriver {
 ///     type IdInfo = ();
+///     type Data = Self;
 ///     const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
@@ -301,15 +302,15 @@ macro_rules! module_i2c_driver {
 ///     fn probe(
 ///         _idev: &i2c::I2cClient<Core>,
 ///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self, Error> {
+///     ) -> impl PinInit<Self::Data, Error> {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn shutdown(_idev: &i2c::I2cClient<Core>, this: Pin<&Self>) {
+///     fn shutdown(_idev: &i2c::I2cClient<Core>, this: Pin<&Self::Data>) {
 ///     }
 /// }
 ///```
-pub trait Driver: Send {
+pub trait Driver {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
     //
@@ -318,6 +319,9 @@ pub trait Driver: Send {
     // ```
     type IdInfo: 'static;
 
+    /// The type of the driver's bus device private data.
+    type Data: Send;
+
     /// The table of device ids supported by the driver.
     const I2C_ID_TABLE: Option<IdTable<Self::IdInfo>> = None;
 
@@ -334,7 +338,7 @@ pub trait Driver: Send {
     fn probe(
         dev: &I2cClient<device::Core>,
         id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error>;
+    ) -> impl PinInit<Self::Data, Error>;
 
     /// I2C driver shutdown.
     ///
@@ -346,8 +350,8 @@ fn probe(
     ///
     /// This callback is distinct from final resource cleanup, as the driver instance remains valid
     /// after it returns. Any deallocation or teardown of driver-owned resources should instead be
-    /// handled in `Self::drop`.
-    fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self>) {
+    /// handled in `Drop`.
+    fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 
@@ -360,8 +364,8 @@ fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self>) {
     /// `&Device<Core>` or `&Device<Bound>` reference. For instance, drivers may try to perform I/O
     /// operations to gracefully tear down the device.
     ///
-    /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &I2cClient<device::Core>, this: Pin<&Self>) {
+    /// Otherwise, release operations for driver resources should be performed in `Drop`.
+    fn unbind(dev: &I2cClient<device::Core>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 7dc78d547f7a..e136b676d372 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -62,6 +62,7 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     ///
     /// impl platform::Driver for SampleDriver {
     ///    # type IdInfo = ();
+    ///    # type Data = Self;
     ///
     ///    fn probe(
     ///       pdev: &platform::Device<Core>,
@@ -126,6 +127,7 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     ///
     /// impl platform::Driver for SampleDriver {
     ///    # type IdInfo = ();
+    ///    # type Data = Self;
     ///
     ///    fn probe(
     ///       pdev: &platform::Device<Core>,
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 17a33819dc0a..c743f2abb62f 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -59,12 +59,12 @@
 
 // SAFETY:
 // - `bindings::pci_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `T::Data` is the type of the driver's device private data.
 // - `struct pci_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::pci_driver;
-    type DriverData = T;
+    type DriverData<'bound> = T::Data;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -129,8 +129,8 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<T>() };
+        // and stored a `Pin<KBox<T::Data>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data>() };
 
         T::unbind(pdev, data);
     }
@@ -279,6 +279,7 @@ macro_rules! pci_device_table {
 ///
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
+///     type Data = Self;
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 ///
 ///     fn probe(
@@ -291,7 +292,7 @@ macro_rules! pci_device_table {
 ///```
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
-pub trait Driver: Send {
+pub trait Driver {
     /// The type holding information about each device id supported by the driver.
     // TODO: Use `associated_type_defaults` once stabilized:
     //
@@ -300,6 +301,9 @@ pub trait Driver: Send {
     // ```
     type IdInfo: 'static;
 
+    /// The type of the driver's bus device private data.
+    type Data: Send;
+
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
 
@@ -307,7 +311,8 @@ pub trait Driver: Send {
     ///
     /// Called when a new pci device is added or discovered. Implementers should
     /// attempt to initialize the device here.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
+        -> impl PinInit<Self::Data, Error>;
 
     /// PCI driver unbind.
     ///
@@ -318,8 +323,8 @@ pub trait Driver: Send {
     /// `&Device<Core>` or `&Device<Bound>` reference. For instance, drivers may try to perform I/O
     /// operations to gracefully tear down the device.
     ///
-    /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+    /// Otherwise, release operations for driver resources should be performed in `Drop`.
+    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 }
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index c7a3dcdde3b1..975b22ffe5db 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -45,12 +45,12 @@
 
 // SAFETY:
 // - `bindings::platform_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `T::Data` is the type of the driver's device private data.
 // - `struct platform_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::platform_driver;
-    type DriverData = T;
+    type DriverData<'bound> = T::Data;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -117,8 +117,8 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<T>() };
+        // and stored a `Pin<KBox<T::Data>>`.
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data>() };
 
         T::unbind(pdev, data);
     }
@@ -192,6 +192,7 @@ macro_rules! module_platform_driver {
 ///
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
+///     type Data = Self;
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
@@ -203,7 +204,7 @@ macro_rules! module_platform_driver {
 ///     }
 /// }
 ///```
-pub trait Driver: Send {
+pub trait Driver {
     /// The type holding driver private data about each device id supported by the driver.
     // TODO: Use associated_type_defaults once stabilized:
     //
@@ -212,6 +213,9 @@ pub trait Driver: Send {
     // ```
     type IdInfo: 'static;
 
+    /// The type of the driver's bus device private data.
+    type Data: Send;
+
     /// The table of OF device ids supported by the driver.
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 
@@ -225,7 +229,7 @@ pub trait Driver: Send {
     fn probe(
         dev: &Device<device::Core>,
         id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error>;
+    ) -> impl PinInit<Self::Data, Error>;
 
     /// Platform driver unbind.
     ///
@@ -236,8 +240,8 @@ fn probe(
     /// `&Device<Core>` or `&Device<Bound>` reference. For instance, drivers may try to perform I/O
     /// operations to gracefully tear down the device.
     ///
-    /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+    /// Otherwise, release operations for driver resources should be performed in `Drop`.
+    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 }
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 3f62da585281..88721970afcb 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -36,12 +36,12 @@
 
 // SAFETY:
 // - `bindings::usb_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `T::Data` is the type of the driver's device private data.
 // - `struct usb_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::usb_driver;
-    type DriverData = T;
+    type DriverData<'bound> = T::Data;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -109,8 +109,8 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
 
         // SAFETY: `disconnect_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { dev.drvdata_borrow::<T>() };
+        // and stored a `Pin<KBox<T::Data>>`.
+        let data = unsafe { dev.drvdata_borrow::<T::Data>() };
 
         T::disconnect(intf, data);
     }
@@ -287,23 +287,27 @@ macro_rules! usb_device_table {
 ///
 /// impl usb::Driver for MyDriver {
 ///     type IdInfo = ();
+///     type Data = Self;
 ///     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 ///
 ///     fn probe(
 ///         _interface: &usb::Interface<Core>,
 ///         _id: &usb::DeviceId,
 ///         _info: &Self::IdInfo,
-///     ) -> impl PinInit<Self, Error> {
+///     ) -> impl PinInit<Self::Data, Error> {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Self>) {}
+///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Self::Data>) {}
 /// }
 ///```
 pub trait Driver {
     /// The type holding information about each one of the device ids supported by the driver.
     type IdInfo: 'static;
 
+    /// The type of the driver's bus device private data.
+    type Data: Send;
+
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
 
@@ -315,12 +319,12 @@ fn probe(
         interface: &Interface<device::Core>,
         id: &DeviceId,
         id_info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error>;
+    ) -> impl PinInit<Self::Data, Error>;
 
     /// USB driver disconnect.
     ///
     /// Called when the USB interface is about to be unbound from this driver.
-    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self>);
+    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self::Data>);
 }
 
 /// A USB interface.
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 0963efe19f93..478c4f693deb 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -117,6 +117,7 @@ fn from_str(s: &str) -> Result<Self> {
 
 impl platform::Driver for RustDebugFs {
     type IdInfo = ();
+    type Data = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 129bb4b39c04..e583c6b8390a 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -58,6 +58,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
 
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
+    type Data = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 319ef734c02b..61d5bf2e8c0d 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -31,6 +31,7 @@
 
 impl auxiliary::Driver for AuxiliaryDriver {
     type IdInfo = ();
+    type Data = Self;
 
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
@@ -65,6 +66,7 @@ struct ParentDriver {
 
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
+    type Data = Self;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
index 6be79f9e9fb5..8269f1798611 100644
--- a/samples/rust/rust_driver_i2c.rs
+++ b/samples/rust/rust_driver_i2c.rs
@@ -35,6 +35,7 @@
 
 impl i2c::Driver for SampleDriver {
     type IdInfo = u32;
+    type Data = Self;
 
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
     const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 47d3e84fab63..f43c6a660b39 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -140,6 +140,7 @@ fn config_space(pdev: &pci::Device<Bound>) {
 
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
+    type Data = Self;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index f2229d176fb9..6505902f8200 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -101,6 +101,7 @@ struct SampleDriver {
 
 impl platform::Driver for SampleDriver {
     type IdInfo = Info;
+    type Data = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
index ab72e99e1274..5942e4b01fd8 100644
--- a/samples/rust/rust_driver_usb.rs
+++ b/samples/rust/rust_driver_usb.rs
@@ -26,6 +26,7 @@ struct SampleDriver {
 
 impl usb::Driver for SampleDriver {
     type IdInfo = ();
+    type Data = Self;
     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 
     fn probe(
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
index 8d2c12e535b0..5956b647294d 100644
--- a/samples/rust/rust_i2c_client.rs
+++ b/samples/rust/rust_i2c_client.rs
@@ -106,6 +106,7 @@ struct SampleDriver {
 
 impl platform::Driver for SampleDriver {
     type IdInfo = ();
+    type Data = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
diff --git a/samples/rust/rust_soc.rs b/samples/rust/rust_soc.rs
index 8079c1c48416..a5e72582f4a2 100644
--- a/samples/rust/rust_soc.rs
+++ b/samples/rust/rust_soc.rs
@@ -37,6 +37,7 @@ struct SampleSocDriver {
 
 impl platform::Driver for SampleSocDriver {
     type IdInfo = ();
+    type Data = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
-- 
2.54.0


