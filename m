Return-Path: <linux-pwm+bounces-8707-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEK4Gdvf72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8707-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:14:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE4B47B3F5
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2741A303FDCB
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BC93A7F4B;
	Mon, 27 Apr 2026 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0SXXuMi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280526F2BE;
	Mon, 27 Apr 2026 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327953; cv=none; b=b3vDcDHfpNKg6TllAOYjfiScgeO5bhflkEHJfmTbBlACpZ6QJD73biPTERQUD+8KhAs/WY9K8E1C9iBTn4tbFSNIQtx/51eG2wdbPRa1uc/Sp+sNqJovzLm1erc4qkqTMcmkbUewsQBubkqEZ++HTjaWVMCUpT8bPbT/6gBe8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327953; c=relaxed/simple;
	bh=Ati2vPAhnUy/yRihj18ZVX8vWDPBaY6FgcnT2mNf5VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnWtejeJ+js8lRbDx2YBObtBMhhjxnJ8+Z2c+K+DZ1q97DrOgQrEylWr6sKwPyGIrUt88+1MyXz9DlfwMaenGc7B0yfWjf3gZra2PcFOXgsmh6rU+Gzr51ySeHEEcIFO1fCT0PNejE6rXgx/xr2Anv+6831JR6t/vvGkLFT9fVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0SXXuMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646BCC2BCB5;
	Mon, 27 Apr 2026 22:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327953;
	bh=Ati2vPAhnUy/yRihj18ZVX8vWDPBaY6FgcnT2mNf5VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z0SXXuMi6XVskH6BEWb1d0OgooVVS++6oDw5xpPSYFQG8y73wco9uA3rAsWS5CsYl
	 LzKdIyioztkN3kpNbtfhXZiPbBhlcBc7/AZ7DMY7Gc6EJm2QfzWmuP27e2gg9+AiAE
	 /zBJyNAQyLypvUxBwP5GtJaF3FZPAkFhwbyb8McmCb/3ETP+tcOrGouNmYpYRSaOKb
	 TkdyWExk8Ud8ZlvEK1abmxsnLavKhekYgzkdvlscm7CFcxIMVlhZp3cXZUuiZzuMOn
	 I3bCxXGQfCzfQtenEp05tARDsj/Kj3VF+Z1FBb3gqFrj9ismWV3t+wcGJbkdoXLY5T
	 Pyy/Q8u44I2Kw==
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
Subject: [PATCH 04/24] rust: device: generalize drvdata methods over ForLt
Date: Tue, 28 Apr 2026 00:11:02 +0200
Message-ID: <20260427221155.2144848-5-dakr@kernel.org>
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
X-Rspamd-Queue-Id: BCE4B47B3F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8707-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,forlt:email]

Generalize set_drvdata(), drvdata_obtain() and drvdata_borrow() to take
F: ForLt, enabling Higher-Ranked Lifetime Types (HRT) for device private
data.

The data is initialized as F::Of<'a> and stored as F::Of<'static>; ForLt
guarantees covariance, making it sound to shorten the stored 'static
lifetime to the borrow lifetime of &self.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs |  7 ++--
 rust/kernel/device.rs    | 80 +++++++++++++++++++++++++++++-----------
 rust/kernel/driver.rs    | 15 +++++---
 rust/kernel/i2c.rs       | 13 ++++---
 rust/kernel/pci.rs       | 11 ++++--
 rust/kernel/platform.rs  | 11 ++++--
 rust/kernel/usb.rs       | 11 ++++--
 7 files changed, 101 insertions(+), 47 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 467befea8e44..5cd10b254baf 100644
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
@@ -46,7 +47,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::auxiliary_driver;
-    type DriverData = T;
+    type DriverData = ForLt!(T);
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -97,7 +98,7 @@ extern "C" fn probe_callback(
         from_result(|| {
             let data = T::probe(adev, info);
 
-            adev.as_ref().set_drvdata(data)?;
+            adev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
             Ok(0)
         })
     }
@@ -112,7 +113,7 @@ extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { adev.as_ref().drvdata_borrow::<T>() };
+        let data = unsafe { adev.as_ref().drvdata_borrow::<ForLt!(T)>() };
 
         T::unbind(adev, data);
     }
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index fd50399aadea..09cbe8a438a9 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -10,6 +10,7 @@
     prelude::*,
     sync::aref::ARef,
     types::{
+        ForLt,
         ForeignOwnable,
         Opaque, //
     }, //
@@ -202,23 +203,41 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
 }
 
 impl Device<CoreInternal> {
-    /// Store a pointer to the bound driver's private data.
-    pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>) -> Result {
+    /// Store the bound driver's private data.
+    ///
+    /// `F` is the [`ForLt`] encoding of the data type. For types without a lifetime parameter,
+    /// use [`ForLt!(T)`](macro@ForLt). For lifetime-parameterized types, the data is
+    /// initialized as `F::Of<'a>` and stored as `F::Of<'static>`; lifetimes are erased and do not
+    /// affect layout, while [`ForLt`] guarantees covariance for safe lifetime shortening.
+    ///
+    /// [`ForLt`]: trait@ForLt
+    pub fn set_drvdata<'a, F: ForLt>(&self, data: impl PinInit<F::Of<'a>, Error>) -> Result
+    where
+        F::Of<'static>: 'static,
+    {
         let data = KBox::pin_init(data, GFP_KERNEL)?;
 
+        // SAFETY: Lifetimes are erased and do not affect layout, so Of<'a> and Of<'static> have
+        // identical representation. The raw pointer is type-erased through c_void anyway.
+        let ptr = KBox::into_raw(unsafe { Pin::into_inner_unchecked(data) });
+
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
-        unsafe { bindings::dev_set_drvdata(self.as_raw(), data.into_foreign().cast()) };
+        unsafe { bindings::dev_set_drvdata(self.as_raw(), ptr.cast()) };
 
         Ok(())
     }
 
     /// Take ownership of the private data stored in this [`Device`].
     ///
+    /// `F` is the [`ForLt`] encoding of the data type. The returned [`KBox`] has its lifetime
+    /// tied to `&self`, ensuring it is dropped before the device goes away.
+    ///
     /// # Safety
     ///
-    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
-    ///   [`Device::set_drvdata`].
-    pub(crate) unsafe fn drvdata_obtain<T: 'static>(&self) -> Option<Pin<KBox<T>>> {
+    /// - `F` must match the [`ForLt`] type previously stored by [`Device::set_drvdata`].
+    ///
+    /// [`ForLt`]: trait@ForLt
+    pub(crate) unsafe fn drvdata_obtain<F: ForLt>(&self) -> Option<Pin<KBox<F::Of<'_>>>> {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
 
@@ -230,24 +249,34 @@ pub(crate) unsafe fn drvdata_obtain<T: 'static>(&self) -> Option<Pin<KBox<T>>> {
         }
 
         // SAFETY:
-        // - If `ptr` is not NULL, it comes from a previous call to `into_foreign()`.
-        // - `dev_get_drvdata()` guarantees to return the same pointer given to `dev_set_drvdata()`
-        //   in `into_foreign()`.
-        Some(unsafe { Pin::<KBox<T>>::from_foreign(ptr.cast()) })
+        // - If `ptr` is not NULL, it was stored by a previous call to `set_drvdata()`, which
+        //   stores a pointer via `KBox::into_raw()`.
+        // - Lifetimes are erased and do not affect layout, so reconstructing as `F::Of<'_>`
+        //   (tied to `&self`) is sound.
+        // - `dev_get_drvdata()` guarantees to return the same pointer given to
+        //   `dev_set_drvdata()`.
+        Some(unsafe { Pin::new_unchecked(KBox::from_raw(ptr.cast())) })
     }
 
     /// Borrow the driver's private data bound to this [`Device`].
     ///
+    /// `F` is the [`ForLt`] encoding of the data type. The returned reference has its lifetime
+    /// shortened from `'static` to `&self`'s borrow lifetime via [`ForLt::cast_ref`].
+    ///
     /// # Safety
     ///
     /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before the
     ///   device is fully unbound.
-    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
-    ///   [`Device::set_drvdata`].
-    pub unsafe fn drvdata_borrow<T: 'static>(&self) -> Pin<&T> {
+    /// - `F` must match the [`ForLt`] type previously stored by [`Device::set_drvdata`].
+    ///
+    /// [`ForLt`]: trait@ForLt
+    pub unsafe fn drvdata_borrow<F: ForLt>(&self) -> Pin<&F::Of<'_>>
+    where
+        F::Of<'static>: 'static,
+    {
         // SAFETY: `drvdata_unchecked()` has the exact same safety requirements as the ones
         // required by this method.
-        unsafe { self.drvdata_unchecked() }
+        unsafe { self.drvdata_unchecked::<F>() }
     }
 }
 
@@ -258,18 +287,25 @@ impl Device<Bound> {
     ///
     /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before
     ///   the device is fully unbound.
-    /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
-    ///   [`Device::set_drvdata`].
-    unsafe fn drvdata_unchecked<T: 'static>(&self) -> Pin<&T> {
+    /// - `F` must match the [`ForLt`] type previously stored by [`Device::set_drvdata`].
+    unsafe fn drvdata_unchecked<F: ForLt>(&self) -> Pin<&F::Of<'_>>
+    where
+        F::Of<'static>: 'static,
+    {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
 
         // SAFETY:
-        // - By the safety requirements of this function, `ptr` comes from a previous call to
-        //   `into_foreign()`.
-        // - `dev_get_drvdata()` guarantees to return the same pointer given to `dev_set_drvdata()`
-        //   in `into_foreign()`.
-        unsafe { Pin::<KBox<T>>::borrow(ptr.cast()) }
+        // - By the safety requirements of this function, `ptr` was stored by a previous call to
+        //   `set_drvdata()` via `KBox::into_raw()`.
+        // - `dev_get_drvdata()` guarantees to return the same pointer given to
+        //   `dev_set_drvdata()`.
+        let pinned: Pin<&F::Of<'static>> =
+            unsafe { Pin::<KBox<F::Of<'static>>>::borrow(ptr.cast()) };
+
+        // SAFETY: `ForLt` guarantees covariance, making it sound to shorten 'static to &self's
+        // lifetime via cast_ref().
+        unsafe { Pin::new_unchecked(F::cast_ref(pinned.get_ref())) }
     }
 }
 
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 8f0e50729215..29a67b12c872 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -99,7 +99,10 @@
     device,
     of,
     prelude::*,
-    types::Opaque,
+    types::{
+        ForLt,
+        Opaque, //
+    },
     ThisModule, //
 };
 
@@ -112,14 +115,16 @@
 ///
 /// Implementors must guarantee that:
 /// - `DriverType` is `repr(C)`,
-/// - `DriverData` is the type of the driver's device private data.
+/// - `DriverData` is the [`ForLt`] encoding of the driver's device private data type.
 /// - `DriverType` embeds a valid `struct device_driver` at byte offset `DEVICE_DRIVER_OFFSET`.
+///
+/// [`ForLt`]: trait@ForLt
 pub unsafe trait DriverLayout {
     /// The specific driver type embedding a `struct device_driver`.
     type DriverType: Default;
 
-    /// The type of the driver's device private data.
-    type DriverData;
+    /// The [`ForLt`](trait@ForLt) encoding of the driver's device private data type.
+    type DriverData: ForLt;
 
     /// Byte offset of the embedded `struct device_driver` within `DriverType`.
     ///
@@ -193,7 +198,7 @@ extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // be released after the driver's bus device private data is dropped.
         //
         // SAFETY: By the safety requirements of the `Driver` trait, `T::DriverData` is the
-        // driver's device private data type.
+        // ForLt encoding of the driver's device private data type.
         drop(unsafe { dev.drvdata_obtain::<T::DriverData>() });
     }
 
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 7b908f0c5a58..cde3dd7a6cc7 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -20,7 +20,10 @@
         ARef,
         AlwaysRefCounted, //
     },
-    types::Opaque, //
+    types::{
+        ForLt,
+        Opaque, //
+    }, //
 };
 
 use core::{
@@ -98,7 +101,7 @@ macro_rules! i2c_device_table {
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::i2c_driver;
-    type DriverData = T;
+    type DriverData = ForLt!(T);
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -165,7 +168,7 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_
         from_result(|| {
             let data = T::probe(idev, info);
 
-            idev.as_ref().set_drvdata(data)?;
+            idev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
             Ok(0)
         })
     }
@@ -177,7 +180,7 @@ extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `I2cClient::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<T>() };
+        let data = unsafe { idev.as_ref().drvdata_borrow::<ForLt!(T)>() };
 
         T::unbind(idev, data);
     }
@@ -189,7 +192,7 @@ extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
         // SAFETY: `shutdown_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<T>() };
+        let data = unsafe { idev.as_ref().drvdata_borrow::<ForLt!(T)>() };
 
         T::shutdown(idev, data);
     }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114..fe5148f41d8b 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -19,7 +19,10 @@
     },
     prelude::*,
     str::CStr,
-    types::Opaque,
+    types::{
+        ForLt,
+        Opaque, //
+    },
     ThisModule, //
 };
 use core::{
@@ -64,7 +67,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::pci_driver;
-    type DriverData = T;
+    type DriverData = ForLt!(T);
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -115,7 +118,7 @@ extern "C" fn probe_callback(
         from_result(|| {
             let data = T::probe(pdev, info);
 
-            pdev.as_ref().set_drvdata(data)?;
+            pdev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
             Ok(0)
         })
     }
@@ -130,7 +133,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<T>() };
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<ForLt!(T)>() };
 
         T::unbind(pdev, data);
     }
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8917d4ee499f..7ff69e3eea90 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -27,7 +27,10 @@
     },
     of,
     prelude::*,
-    types::Opaque,
+    types::{
+        ForLt,
+        Opaque, //
+    },
     ThisModule, //
 };
 
@@ -50,7 +53,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::platform_driver;
-    type DriverData = T;
+    type DriverData = ForLt!(T);
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -103,7 +106,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
         from_result(|| {
             let data = T::probe(pdev, info);
 
-            pdev.as_ref().set_drvdata(data)?;
+            pdev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
             Ok(0)
         })
     }
@@ -118,7 +121,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<T>() };
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<ForLt!(T)>() };
 
         T::unbind(pdev, data);
     }
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 9c17a672cd27..9b9d3ae41087 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -19,7 +19,10 @@
     },
     prelude::*,
     sync::aref::AlwaysRefCounted,
-    types::Opaque,
+    types::{
+        ForLt,
+        Opaque, //
+    },
     ThisModule, //
 };
 use core::{
@@ -41,7 +44,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::usb_driver;
-    type DriverData = T;
+    type DriverData = ForLt!(T);
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -93,7 +96,7 @@ extern "C" fn probe_callback(
             let data = T::probe(intf, id, info);
 
             let dev: &device::Device<device::CoreInternal> = intf.as_ref();
-            dev.set_drvdata(data)?;
+            dev.set_drvdata::<ForLt!(T)>(data)?;
             Ok(0)
         })
     }
@@ -110,7 +113,7 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
         // SAFETY: `disconnect_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { dev.drvdata_borrow::<T>() };
+        let data = unsafe { dev.drvdata_borrow::<ForLt!(T)>() };
 
         T::disconnect(intf, data);
     }
-- 
2.54.0


