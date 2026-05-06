Return-Path: <linux-pwm+bounces-8809-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGioCte4+2k0DwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8809-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:55:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F204E0E3A
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9224302BBDD
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77C3B5305;
	Wed,  6 May 2026 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+oqCDre"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D23B47C1;
	Wed,  6 May 2026 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104383; cv=none; b=uJhbQ+Jd6ZVMqniCjtAP6HpL57Hf4BeqAM3LSeN6AuFwqNPYy6oq8FVlBBtyvt2016XMwBQrJuXDbTZUh+lnUJ6hy3tkyGKMCWRKN1n1mdvZI9cT297KYmKGUCBsqaA6mJBoKCEHafYhhkmerdB/e2nvIGHXyOteOVdQY8bBwJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104383; c=relaxed/simple;
	bh=8mVevI3VU2GFyXMCNKv15BqIJsRsEGfi7AurMq0Pxr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcWgGLfD08JsYVb/nOrEWsOAzLHfeGlU2Qtxs1gOPvzMSH5f5TH41UFNXEbWHngKpajxrdYc7djKGPpOtJMb+XZAKEvDTIpxvYFZmnA5wVFI92ZNMCe4pwLABFjwqqUbEZHXEAawhV+ZZo9FMsy/twwEJcaVmjNfLjGLBh4D4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+oqCDre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E64C2BCB2;
	Wed,  6 May 2026 21:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104382;
	bh=8mVevI3VU2GFyXMCNKv15BqIJsRsEGfi7AurMq0Pxr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+oqCDre+Cu2aiESBf7dxd8srf/hKwnBhb8x/s/wEh8NP8dZ4BaRC0dG8IbCwCMDq
	 J/P/UVCB24zOMRTxxxmksShZo2ON84qYUecSU280qKanEf2PJKgjk3ptEKeXfRRLq3
	 lUaPsx2eJRT1QV125gLGiDeE28LE8HtTJ2db1++FRenLULLG4yicOXppqBi2rPGoNA
	 dOj0NewM4+XhAu07xDKtfvZvVUQ0ZqlsBDEjw5iY2jOxv8uUvsABpQNbtLClwcQau0
	 iilhtyKooiFmgF9PSYMi9j2vt2V2o+7TsljfmAjDytkXXVK72Alh7gDv+LCndxUSXx
	 LgnFMEvTLrpXQ==
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
Subject: [PATCH v2 15/25] rust: usb: make Driver trait lifetime-parameterized
Date: Wed,  6 May 2026 23:50:51 +0200
Message-ID: <20260506215113.851360-16-dakr@kernel.org>
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
X-Rspamd-Queue-Id: A9F204E0E3A
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
	TAGGED_FROM(0.00)[bounces-8809-lists,linux-pwm=lfdr.de];
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

Make usb::Driver take a lifetime parameter 'bound that ties device
resources to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a bound
for<'bound> F::Of<'bound>: Driver<'bound>; module_usb_driver! wraps the
driver type in ForLt!() so drivers don't have to.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs              | 85 ++++++++++++++++++++-------------
 samples/rust/rust_driver_usb.rs | 14 +++---
 2 files changed, 59 insertions(+), 40 deletions(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 442e456fd2d3..450be2b7c542 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -35,22 +35,35 @@
 };
 
 /// An adapter for the registration of USB drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'bound>` is the driver struct
+/// parameterized by `'bound`. The macro `module_usb_driver!` generates
+/// this automatically via `ForLt!()`.
+pub struct Adapter<F>(PhantomData<F>);
 
 // SAFETY:
 // - `bindings::usb_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `F::Of<'static>` is the stored type of the driver's device private data.
 // - `struct usb_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<F> driver::DriverLayout for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     type DriverType = bindings::usb_driver;
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
         udrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -61,7 +74,7 @@ unsafe fn register(
             (*udrv.get()).name = name.as_char_ptr();
             (*udrv.get()).probe = Some(Self::probe_callback);
             (*udrv.get()).disconnect = Some(Self::disconnect_callback);
-            (*udrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*udrv.get()).id_table = <F::Of<'static> as Driver<'static>>::ID_TABLE.as_ptr();
         }
 
         // SAFETY: `udrv` is guaranteed to be a valid `DriverType`.
@@ -76,7 +89,11 @@ unsafe fn unregister(udrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     extern "C" fn probe_callback(
         intf: *mut bindings::usb_interface,
         id: *const bindings::usb_device_id,
@@ -87,16 +104,16 @@ extern "C" fn probe_callback(
         // INVARIANT: `intf` is valid for the duration of `probe_callback()`.
         let intf = unsafe { &*intf.cast::<Interface<device::CoreInternal>>() };
 
-        from_result(|| {
-            // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct usb_device_id` and
-            // does not add additional invariants, so it's safe to transmute.
-            let id = unsafe { &*id.cast::<DeviceId>() };
+        // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct usb_device_id` and
+        // does not add additional invariants, so it's safe to transmute.
+        let id = unsafe { &*id.cast::<DeviceId>() };
 
-            let info = T::ID_TABLE.info(id.index());
-            let data = T::probe(intf, id, info);
+        from_result(|| {
+            let info = <F::Of<'_> as Driver<'_>>::ID_TABLE.info(id.index());
+            let data = <F::Of<'_> as Driver<'_>>::probe(intf, id, info);
 
             let dev: &device::Device<device::CoreInternal> = intf.as_ref();
-            dev.set_drvdata::<ForLt!(T)>(data)?;
+            dev.set_drvdata::<F>(data)?;
             Ok(0)
         })
     }
@@ -111,11 +128,10 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
         let dev: &device::Device<device::CoreInternal> = intf.as_ref();
 
         // SAFETY: `disconnect_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { dev.drvdata_borrow::<ForLt!(T)>() };
+        // `probe_callback`, hence it's guaranteed that drvdata has been set.
+        let data = unsafe { dev.drvdata_borrow::<F>() };
 
-        T::disconnect(intf, data);
+        <F::Of<'_> as Driver<'_>>::disconnect(intf, data);
     }
 }
 
@@ -281,29 +297,29 @@ macro_rules! usb_device_table {
 /// kernel::usb_device_table!(
 ///     USB_TABLE,
 ///     MODULE_USB_TABLE,
-///     <MyDriver as usb::Driver>::IdInfo,
+///     <MyDriver as usb::Driver<'_>>::IdInfo,
 ///     [
 ///         (usb::DeviceId::from_id(0x1234, 0x5678), ()),
 ///         (usb::DeviceId::from_id(0xabcd, 0xef01), ()),
 ///     ]
 /// );
 ///
-/// impl usb::Driver for MyDriver {
+/// impl<'bound> usb::Driver<'bound> for MyDriver {
 ///     type IdInfo = ();
 ///     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 ///
 ///     fn probe(
-///         _interface: &usb::Interface<Core>,
-///         _id: &usb::DeviceId,
-///         _info: &Self::IdInfo,
-///     ) -> impl PinInit<Self, Error> {
+///         _interface: &'bound usb::Interface<Core>,
+///         _id: &'bound usb::DeviceId,
+///         _info: &'bound Self::IdInfo,
+///     ) -> impl PinInit<Self, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Self>) {}
+///     fn disconnect(_interface: &'bound usb::Interface<Core>, _data: Pin<&'bound Self>) {}
 /// }
 ///```
-pub trait Driver {
+pub trait Driver<'bound> {
     /// The type holding information about each one of the device ids supported by the driver.
     type IdInfo: 'static;
 
@@ -315,15 +331,15 @@ pub trait Driver {
     /// Called when a new USB interface is bound to this driver.
     /// Implementers should attempt to initialize the interface here.
     fn probe(
-        interface: &Interface<device::Core>,
-        id: &DeviceId,
-        id_info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error>;
+        interface: &'bound Interface<device::Core>,
+        id: &'bound DeviceId,
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound;
 
     /// USB driver disconnect.
     ///
     /// Called when the USB interface is about to be unbound from this driver.
-    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self>);
+    fn disconnect(interface: &'bound Interface<device::Core>, data: Pin<&'bound Self>);
 }
 
 /// A USB interface.
@@ -486,7 +502,10 @@ unsafe impl Sync for Device<device::Bound> {}
 /// ```
 #[macro_export]
 macro_rules! module_usb_driver {
-    ($($f:tt)*) => {
-        $crate::module_driver!(<T>, $crate::usb::Adapter<T>, { $($f)* });
+    (type: $type:ty, $($rest:tt)*) => {
+        $crate::module_driver!(<T>, $crate::usb::Adapter<T>, {
+            type: $crate::types::ForLt!($type),
+            $($rest)*
+        });
     }
 }
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
index ab72e99e1274..271aaf415795 100644
--- a/samples/rust/rust_driver_usb.rs
+++ b/samples/rust/rust_driver_usb.rs
@@ -20,26 +20,26 @@ struct SampleDriver {
 kernel::usb_device_table!(
     USB_TABLE,
     MODULE_USB_TABLE,
-    <SampleDriver as usb::Driver>::IdInfo,
+    <SampleDriver as usb::Driver<'_>>::IdInfo,
     [(usb::DeviceId::from_id(0x1234, 0x5678), ()),]
 );
 
-impl usb::Driver for SampleDriver {
+impl<'bound> usb::Driver<'bound> for SampleDriver {
     type IdInfo = ();
     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 
     fn probe(
-        intf: &usb::Interface<Core>,
-        _id: &usb::DeviceId,
-        _info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error> {
+        intf: &'bound usb::Interface<Core>,
+        _id: &'bound usb::DeviceId,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev: &device::Device<Core> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample probed\n");
 
         Ok(Self { _intf: intf.into() })
     }
 
-    fn disconnect(intf: &usb::Interface<Core>, _data: Pin<&Self>) {
+    fn disconnect(intf: &'bound usb::Interface<Core>, _data: Pin<&'bound Self>) {
         let dev: &device::Device<Core> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample disconnected\n");
     }
-- 
2.54.0


