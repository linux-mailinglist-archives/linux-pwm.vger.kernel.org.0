Return-Path: <linux-pwm+bounces-8719-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGWkAQTg72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8719-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:15:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A897647B42E
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9AFB301FC2B
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908CB3ACF13;
	Mon, 27 Apr 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFiYEfVB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA43AB262;
	Mon, 27 Apr 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328029; cv=none; b=K7d6IxoE7DrnrwGqc3vVz1T4wCRMxUC33dnm0dVwCwxoZdHqFEpjsdJ0YM96EG2b9b9bcP0/NFA7UpWboycJ5vfJLntUNdiJsqfWOw4ad0jCFJFX+P/iMjtzXH9usXNy5Ll9U6is/2gN5mgLK/Y7KGYRd91Qygzte7qR21FIU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328029; c=relaxed/simple;
	bh=LqoJmyLMcfvlHKDJq6T+tkDE6stHA+a+dnj6GefZ9os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeJvrDbN6o3nxFjS0YwoYqR3LHJKn+NczTQ8ZBnIS9SdK8a7Wuc/sZYhqyKFPN0hpL6RKVwnJ8BPGjUGD0eZPl/gr+6MZmuz1q1MYy4UNTfMNBhYHNYHYTzgHeE4V0qAoJBGQ4Bce9C1wbBa3b/wAkraWhDX/cyEjw+pHx2yRic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFiYEfVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410D6C2BCB6;
	Mon, 27 Apr 2026 22:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328029;
	bh=LqoJmyLMcfvlHKDJq6T+tkDE6stHA+a+dnj6GefZ9os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFiYEfVByRv2PjDa9rjYPjgR9q/fQlaBcDWAP+n9ARzSi35I3fnQBQL4jXkKGDFqb
	 Z+VfYo+FSkRbNwQd6HzuNL2R+VKCaOPP2Vt7a5oRB1f1lN8QHUS7mkwa2kqHPVBPHD
	 l03xRWXLrvCwYveEXJEMCVnnLbogwLsr1wkfNlkwlAmoq9F+HdY8YjBxU3qt84QonQ
	 vdiQnv2fsuVsGsUCmq1lVdBEMwCQFAmiGn60q3rtrxY6WPr2VXXMG+6L4Xh1xwYO4V
	 WJEmvDbKfwovia/wetB+zMtncjlIo7goJfWZX5JKqF73OCnqP5s8BCruWMyK6RvsV7
	 duihnqd6v+KKw==
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
Subject: [PATCH 16/24] rust: usb: make Driver trait lifetime-parameterized
Date: Tue, 28 Apr 2026 00:11:14 +0200
Message-ID: <20260427221155.2144848-17-dakr@kernel.org>
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
X-Rspamd-Queue-Id: A897647B42E
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
	TAGGED_FROM(0.00)[bounces-8719-lists,linux-pwm=lfdr.de];
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

Make usb::Driver take a lifetime parameter 'a that ties device resources
to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a bound
for<'a> F::Of<'a>: Driver<'a>; module_usb_driver! wraps the driver type
in ForLt!() so drivers don't have to.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs              | 84 ++++++++++++++++++++-------------
 samples/rust/rust_driver_usb.rs | 14 +++---
 2 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 442e456fd2d3..f519444cf8d0 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -35,22 +35,34 @@
 };
 
 /// An adapter for the registration of USB drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'a>` is the driver struct parameterized by `'a`. The macro
+/// `module_usb_driver!` generates this automatically via `ForLt!()`.
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
+    for<'a> F::Of<'a>: Driver<'a>,
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
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     unsafe fn register(
         udrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -61,7 +73,7 @@ unsafe fn register(
             (*udrv.get()).name = name.as_char_ptr();
             (*udrv.get()).probe = Some(Self::probe_callback);
             (*udrv.get()).disconnect = Some(Self::disconnect_callback);
-            (*udrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*udrv.get()).id_table = <F::Of<'static> as Driver<'static>>::ID_TABLE.as_ptr();
         }
 
         // SAFETY: `udrv` is guaranteed to be a valid `DriverType`.
@@ -76,7 +88,11 @@ unsafe fn unregister(udrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     extern "C" fn probe_callback(
         intf: *mut bindings::usb_interface,
         id: *const bindings::usb_device_id,
@@ -87,16 +103,16 @@ extern "C" fn probe_callback(
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
@@ -111,11 +127,10 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
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
 
@@ -281,29 +296,29 @@ macro_rules! usb_device_table {
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
+/// impl<'a> usb::Driver<'a> for MyDriver {
 ///     type IdInfo = ();
 ///     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 ///
 ///     fn probe(
-///         _interface: &usb::Interface<Core>,
-///         _id: &usb::DeviceId,
-///         _info: &Self::IdInfo,
-///     ) -> impl PinInit<Self, Error> {
+///         _interface: &'a usb::Interface<Core>,
+///         _id: &'a usb::DeviceId,
+///         _info: &'a Self::IdInfo,
+///     ) -> impl PinInit<Self, Error> + 'a {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Self>) {}
+///     fn disconnect(_interface: &'a usb::Interface<Core>, _data: Pin<&'a Self>) {}
 /// }
 ///```
-pub trait Driver {
+pub trait Driver<'a> {
     /// The type holding information about each one of the device ids supported by the driver.
     type IdInfo: 'static;
 
@@ -315,15 +330,15 @@ pub trait Driver {
     /// Called when a new USB interface is bound to this driver.
     /// Implementers should attempt to initialize the interface here.
     fn probe(
-        interface: &Interface<device::Core>,
-        id: &DeviceId,
-        id_info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error>;
+        interface: &'a Interface<device::Core>,
+        id: &'a DeviceId,
+        id_info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a;
 
     /// USB driver disconnect.
     ///
     /// Called when the USB interface is about to be unbound from this driver.
-    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self>);
+    fn disconnect(interface: &'a Interface<device::Core>, data: Pin<&'a Self>);
 }
 
 /// A USB interface.
@@ -486,7 +501,10 @@ unsafe impl Sync for Device<device::Bound> {}
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
index ab72e99e1274..6f3e5db9f35d 100644
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
+impl<'a> usb::Driver<'a> for SampleDriver {
     type IdInfo = ();
     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 
     fn probe(
-        intf: &usb::Interface<Core>,
-        _id: &usb::DeviceId,
-        _info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error> {
+        intf: &'a usb::Interface<Core>,
+        _id: &'a usb::DeviceId,
+        _info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a {
         let dev: &device::Device<Core> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample probed\n");
 
         Ok(Self { _intf: intf.into() })
     }
 
-    fn disconnect(intf: &usb::Interface<Core>, _data: Pin<&Self>) {
+    fn disconnect(intf: &'a usb::Interface<Core>, _data: Pin<&'a Self>) {
         let dev: &device::Device<Core> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample disconnected\n");
     }
-- 
2.54.0


