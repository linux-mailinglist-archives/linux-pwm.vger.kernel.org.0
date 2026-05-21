Return-Path: <linux-pwm+bounces-9049-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIIAFfCXD2rVNgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9049-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:40:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AE65ACE6D
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1575D304D718
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C63735F8D1;
	Thu, 21 May 2026 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeXhqMf3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A94365A13;
	Thu, 21 May 2026 23:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406775; cv=none; b=Ay0oescWgcLhYj/QDTTvibxCiqUq2eX+uDA/zecQLm6DIYtfi9dn+t4b+EROxhRn1sBzuzHm3nhRw0gok5PUxh/hVHCWuE11uqBy3FYczIREJpqJCnLY3kIskG34sTkbD1n6vSzDs0V1cWlghbvkcxFm16Dz9iKNPE4z0TBEVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406775; c=relaxed/simple;
	bh=bt3SId9ZCYtgEGXJDVZR+Nta3u//CSeobMyGWFsPtWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2HyU6YIwTIxrLe5vopyKRMfL5Mdo4P56O6mluZYowSlsR3NTB5IdOMjErmA8jEvh1GWIg9rsxdPfbwqv0W0tmPLQwoUclT9Kt1u35khwIE3vhwYJPiNNbvz5sTSjQx+Tfi3ORt1WpcbI3rdouxsPXixn4A6MM2JpVsJg/F7ELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeXhqMf3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C381F000E9;
	Thu, 21 May 2026 23:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406773;
	bh=oAC+oYVs4iVm2wJeSIDjCP5mSv0R6QMsV4IYq1BN6aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QeXhqMf3FETATNckDpEiMHVSUfQgJTxpgJuzaNiTsLPFfyP5PxKAZcaPkunSGCOOo
	 pQZTRyXQGSUPCIlJKvRPq/hQgzE7wa1LOTVOkRDM/Tv6jb06g7qJeMOkiK9SBiSSYv
	 mT+nxlGrSUSKBbcYwkRfiI3BUU+MfMP359BG0O390xXvTPIm7jl3wBSW15uE9f7Kfn
	 nm4LAJTqGwDmEIzRkr64bKcEJGf98iOnFSOK2PjWaQM23rjYh65P1+u2OCKp2H8XDh
	 zGcaoU3dOlzoQVyU+mjV4a+di2JvW11NtlL8SLG7KYfbVDnPclrXwEVuBgaD4n7fzp
	 r45bD5TGt55BA==
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
Subject: [PATCH v4 02/27] rust: driver: move 'static bounds to constructor
Date: Fri, 22 May 2026 01:34:28 +0200
Message-ID: <20260521233501.1191842-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521233501.1191842-1-dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9049-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 04AE65ACE6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gary Guo <gary@garyguo.net>

With the ForeignOwnable lifetime change, the 'static bound is no longer
necessary on the drvdata methods or bus adapter impls. Move it to the
Registration constructor instead.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 6 +++---
 rust/kernel/device.rs    | 8 ++++----
 rust/kernel/driver.rs    | 7 +++++--
 rust/kernel/i2c.rs       | 8 ++++----
 rust/kernel/pci.rs       | 6 +++---
 rust/kernel/platform.rs  | 8 ++++----
 rust/kernel/usb.rs       | 6 +++---
 7 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 19aec94aa95b..35b44d194f67 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -44,7 +44,7 @@
 // - `T` is the type of the driver's device private data.
 // - `struct auxiliary_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::auxiliary_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -52,7 +52,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         adrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -78,7 +78,7 @@ unsafe fn unregister(adrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(
         adev: *mut bindings::auxiliary_device,
         id: *const bindings::auxiliary_device_id,
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index fd50399aadea..5df8fa108a52 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -203,7 +203,7 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
 
 impl Device<CoreInternal> {
     /// Store a pointer to the bound driver's private data.
-    pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>) -> Result {
+    pub fn set_drvdata<T>(&self, data: impl PinInit<T, Error>) -> Result {
         let data = KBox::pin_init(data, GFP_KERNEL)?;
 
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
@@ -218,7 +218,7 @@ pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>) -> Result {
     ///
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
-    pub(crate) unsafe fn drvdata_obtain<T: 'static>(&self) -> Option<Pin<KBox<T>>> {
+    pub(crate) unsafe fn drvdata_obtain<T>(&self) -> Option<Pin<KBox<T>>> {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
 
@@ -244,7 +244,7 @@ pub(crate) unsafe fn drvdata_obtain<T: 'static>(&self) -> Option<Pin<KBox<T>>> {
     ///   device is fully unbound.
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
-    pub unsafe fn drvdata_borrow<T: 'static>(&self) -> Pin<&T> {
+    pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
         // SAFETY: `drvdata_unchecked()` has the exact same safety requirements as the ones
         // required by this method.
         unsafe { self.drvdata_unchecked() }
@@ -260,7 +260,7 @@ impl Device<Bound> {
     ///   the device is fully unbound.
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
-    unsafe fn drvdata_unchecked<T: 'static>(&self) -> Pin<&T> {
+    unsafe fn drvdata_unchecked<T>(&self) -> Pin<&T> {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
 
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 93e5dd6ae371..586091cfa45c 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -181,7 +181,7 @@ unsafe impl<T: RegistrationOps> Sync for Registration<T> {}
 // any thread, so `Registration` is `Send`.
 unsafe impl<T: RegistrationOps> Send for Registration<T> {}
 
-impl<T: RegistrationOps + 'static> Registration<T> {
+impl<T: RegistrationOps> Registration<T> {
     extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // SAFETY: The driver core only ever calls the post unbind callback with a valid pointer to
         // a `struct device`.
@@ -215,7 +215,10 @@ fn callbacks_attach(drv: &Opaque<T::DriverType>) {
     }
 
     /// Creates a new instance of the registration object.
-    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error>
+    where
+        T: 'static,
+    {
         try_pin_init!(Self {
             reg <- Opaque::try_ffi_init(|ptr: *mut T::DriverType| {
                 // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 7b908f0c5a58..4ccee4ba4f23 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -96,7 +96,7 @@ macro_rules! i2c_device_table {
 // - `T` is the type of the driver's device private data.
 // - `struct i2c_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::i2c_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -104,7 +104,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         idrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -151,7 +151,7 @@ unsafe fn unregister(idrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_int {
         // SAFETY: The I2C bus only ever calls the probe callback with a valid pointer to a
         // `struct i2c_client`.
@@ -222,7 +222,7 @@ fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter>::Id
     }
 }
 
-impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
+impl<T: Driver> driver::Adapter for Adapter<T> {
     type IdInfo = T::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114..17a33819dc0a 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -62,7 +62,7 @@
 // - `T` is the type of the driver's device private data.
 // - `struct pci_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::pci_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -70,7 +70,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         pdrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -96,7 +96,7 @@ unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(
         pdev: *mut bindings::pci_dev,
         id: *const bindings::pci_device_id,
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8917d4ee499f..c7a3dcdde3b1 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -48,7 +48,7 @@
 // - `T` is the type of the driver's device private data.
 // - `struct platform_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::platform_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -56,7 +56,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         pdrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -91,7 +91,7 @@ unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ffi::c_int {
         // SAFETY: The platform bus only ever calls the probe callback with a valid pointer to a
         // `struct platform_device`.
@@ -124,7 +124,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
     }
 }
 
-impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
+impl<T: Driver> driver::Adapter for Adapter<T> {
     type IdInfo = T::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 9c17a672cd27..3f62da585281 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -39,7 +39,7 @@
 // - `T` is the type of the driver's device private data.
 // - `struct usb_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::usb_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -47,7 +47,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         udrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -73,7 +73,7 @@ unsafe fn unregister(udrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(
         intf: *mut bindings::usb_interface,
         id: *const bindings::usb_device_id,
-- 
2.54.0


