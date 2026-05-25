Return-Path: <linux-pwm+bounces-9129-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLWpDmSxFGrRPQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9129-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:30:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B54F5CE68E
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1499B3029631
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF839399023;
	Mon, 25 May 2026 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQgWIuLc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12B3955F4;
	Mon, 25 May 2026 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740994; cv=none; b=SO8wuX79oV6/IAnZrisggGRFiOD7NzvCCNoZZXHkaUaIqHfHNKTFApVVe9C6eANgdGqW8MU0kE6DINs6IaO3GxlbWCtwxl3XicjPy2wnmR5iwgdw2m8hPnwNS9oPxsZVzbBXmKoq6PmIpUblN3BK1bX5cgMWJbDmKsFVKAPB8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740994; c=relaxed/simple;
	bh=rwZCAFhELeLtNLK+r5w4aR9OO0te4hTnjkDHRM+FM+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKPn7EyOAo0V2aW9jS0JEBQxHR19oDzwjAMlc5XjEn8m7C8ptDeaGR/mtgChuYRzw3pAEqSiYtAO2+vCHemRXukq6WEF1C6iDKLmogsTxO1p/dxofFS0QPDNNpw5RHmBVKqs3Jmp7o+gwXO0xBq0XFbOX8BBqCYnT/o5DisGv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQgWIuLc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8861E1F00A3A;
	Mon, 25 May 2026 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779740992;
	bh=lvGrU2igniPCHmh11/tYEXfXrdYrMryxZKMyGL+/290=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FQgWIuLcqzfeCCHmIIWiu4svdtEx6DRpx8wc/PAzclgcYHSPoA3CW1KcEfwiUS8qF
	 MFDlh+iDHbL0We6CJvw7I2uJiJkyNDsV1ZozSSVDWTv5kjY3TOYCXC6I9b4aH2XB10
	 2ha24xUL8YEMoj0wF0KmZD85J02SB3MfHRvS0n8qAiNRdTV100GFngVjL5gPQ6T33S
	 UIplVxrFk8EciZVch2zFuv1Ftr5thahR5ijddUNZBXF9pK+jmAtG8Okw3D2/NS7tUS
	 W51+b155b8K3MV6yVqxdNOB8xOXVEcBmO4RRghzqq8bGtR85e0/VF+fBa3SUmjvvH3
	 hGZeB39papaKA==
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
Subject: [PATCH v5 03/24] rust: driver: move 'static bounds to constructor
Date: Mon, 25 May 2026 22:20:50 +0200
Message-ID: <20260525202921.124698-4-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9129-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,garyguo.net:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 5B54F5CE68E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gary Guo <gary@garyguo.net>

With the ForeignOwnable lifetime change, the 'static bound is no longer
necessary on the drvdata methods or bus adapter impls. Move it to the
Registration constructor instead.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
index 36de8098754d..c8406dc4da60 100644
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


