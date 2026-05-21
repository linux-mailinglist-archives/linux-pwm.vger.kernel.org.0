Return-Path: <linux-pwm+bounces-9057-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEFnIQyZD2r5NgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9057-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:45:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4BA5ACFF4
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC514308ED95
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 23:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFDE37B03E;
	Thu, 21 May 2026 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUxDcnWG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C930377EA7;
	Thu, 21 May 2026 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406839; cv=none; b=DcmOdHj5qlJx6zHn2XdvahlOmsjf/lia613e2TlT5ONBd8cn3evtg2lkXCmQeoW6WagFX86Lrfh1y9iPcVblbUp2OejaQRsYiJnmc4+rZCc5uNT2IBrWYCh4/z24qX7VaLb02368V59RaAxun4NHVeQz57v7rQOe7EpwAM0Fd1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406839; c=relaxed/simple;
	bh=UiJJ6mQIBh+sAqk0757+2eLSw/MIliQ0m7az4GFQkXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVsThdgF6XdqgDfrwHH9wbXIXZNIkvZTbs5fE++kmUFXtXoeMa78GFf99PzsV/TdxeyRFHuPZIhd+Kev0vRQ8mbeqJG3lzzM+A8IF0qP5PDTFiRaa25gXuE7xl+yDBPHPFm4t3okzp4KqgCxq5TUH7x7ZWbq3DjNeVbGUrFnku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUxDcnWG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA81D1F000E9;
	Thu, 21 May 2026 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406828;
	bh=yDTki7mhoHnfOTmNT9Z44hX4pbRe9V9Ogl/CrdRLtBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUxDcnWGfXjak6po/wydbNZYr/+banL7zy73LAs9J0Z5RbytovmKARfM1iKEa7VSL
	 QGVArQxSLiV1zIuUe8QzPriRU0n0gNCbFUuwePJNhgaooEtWxdXvlFJJz7RvNHXQwT
	 jfzHWcLk3giTKaDG5ZF4mKsm32Py6qR5NzNVIJJtVlmLGYpTzhrZPFuAWzQIykz8Sl
	 VRd52iGft4OD2XyxkBKfeChtoLC1ZnlULVKGRRqIYlVx3D1wwCEvKZuoWQ5oAtAQTF
	 z3fM8Vd9/UAbUNig9jcyBzSzKLnhlyYl/fzmqqBWXAdh2qr9KdzIYfxaKIcft539+r
	 WHTI0kJt0KFRw==
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
Subject: [PATCH v4 10/27] rust: device: make Core and CoreInternal lifetime-parameterized
Date: Fri, 22 May 2026 01:34:36 +0200
Message-ID: <20260521233501.1191842-11-dakr@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9057-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1E4BA5ACFF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Device<Core> references in probe callbacks are scoped to the callback,
not the full binding duration. Add a lifetime parameter to Core and
CoreInternal to accurately represent this in the type system.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/cpufreq/rcpufreq_dt.rs        |  2 +-
 drivers/gpu/drm/nova/driver.rs        |  5 ++-
 drivers/gpu/drm/tyr/driver.rs         |  2 +-
 drivers/gpu/nova-core/driver.rs       |  4 +--
 drivers/gpu/nova-core/gpu.rs          |  2 +-
 drivers/pwm/pwm_th1520.rs             |  2 +-
 rust/kernel/auxiliary.rs              | 12 ++++---
 rust/kernel/cpufreq.rs                |  2 +-
 rust/kernel/device.rs                 | 49 +++++++++++++++++++++------
 rust/kernel/devres.rs                 |  2 +-
 rust/kernel/dma.rs                    |  2 +-
 rust/kernel/driver.rs                 |  6 ++--
 rust/kernel/i2c.rs                    | 16 ++++-----
 rust/kernel/io/mem.rs                 |  4 +--
 rust/kernel/pci.rs                    | 20 ++++++-----
 rust/kernel/pci/id.rs                 |  2 +-
 rust/kernel/platform.rs               | 12 +++----
 rust/kernel/usb.rs                    | 16 ++++-----
 samples/rust/rust_debugfs.rs          |  4 +--
 samples/rust/rust_dma.rs              |  2 +-
 samples/rust/rust_driver_auxiliary.rs |  7 ++--
 samples/rust/rust_driver_i2c.rs       |  6 ++--
 samples/rust/rust_driver_pci.rs       |  4 +--
 samples/rust/rust_driver_platform.rs  |  2 +-
 samples/rust/rust_driver_usb.rs       |  8 ++---
 samples/rust/rust_i2c_client.rs       |  4 +--
 samples/rust/rust_soc.rs              |  2 +-
 27 files changed, 118 insertions(+), 81 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index b7eeb2730eb0..5e0b224f6699 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -205,7 +205,7 @@ impl platform::Driver for CPUFreqDTDriver {
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
+        pdev: &platform::Device<Core<'_>>,
         _id_info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
         cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(pdev.as_ref())?;
diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 08136ec0bccb..7605348af994 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -54,7 +54,10 @@ impl auxiliary::Driver for NovaDriver {
     type Data = Self;
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        adev: &auxiliary::Device<Core<'_>>,
+        _info: &Self::IdInfo,
+    ) -> impl PinInit<Self, Error> {
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
         let drm = drm::Device::<Self>::new(adev.as_ref(), data)?;
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c81bf217743d..001727f44fc8 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -95,7 +95,7 @@ impl platform::Driver for TyrPlatformDriverData {
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
+        pdev: &platform::Device<Core<'_>>,
         _info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
         let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 699e27046c93..13c5ff15e87f 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -77,7 +77,7 @@ impl pci::Driver for NovaCore {
     type Data = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
@@ -109,7 +109,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
         })
     }
 
-    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
+    fn unbind(pdev: &pci::Device<Core<'_>>, this: Pin<&Self>) {
         this.gpu.unbind(pdev.as_ref());
     }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0f6fe9a1b955..4ffb506342a9 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -278,7 +278,7 @@ pub(crate) fn new<'a>(
     /// Called when the corresponding [`Device`](device::Device) is unbound.
     ///
     /// Note: This method must only be called from `Driver::unbind`.
-    pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
+    pub(crate) fn unbind(&self, dev: &device::Device<device::Core<'_>>) {
         kernel::warn_on!(self
             .bar
             .access(dev)
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 07795910a0b5..df83a4a9a507 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -320,7 +320,7 @@ impl platform::Driver for Th1520PwmPlatformDriver {
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
+        pdev: &platform::Device<Core<'_>>,
         _id_info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
         let dev = pdev.as_ref();
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index df2c97423dcc..6d504b0933d5 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -87,7 +87,7 @@ extern "C" fn probe_callback(
         // `struct auxiliary_device`.
         //
         // INVARIANT: `adev` is valid for the duration of `probe_callback()`.
-        let adev = unsafe { &*adev.cast::<Device<device::CoreInternal>>() };
+        let adev = unsafe { &*adev.cast::<Device<device::CoreInternal<'_>>>() };
 
         // SAFETY: `DeviceId` is a `#[repr(transparent)`] wrapper of `struct auxiliary_device_id`
         // and does not add additional invariants, so it's safe to transmute.
@@ -107,7 +107,7 @@ extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
         // `struct auxiliary_device`.
         //
         // INVARIANT: `adev` is valid for the duration of `remove_callback()`.
-        let adev = unsafe { &*adev.cast::<Device<device::CoreInternal>>() };
+        let adev = unsafe { &*adev.cast::<Device<device::CoreInternal<'_>>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
@@ -211,8 +211,10 @@ pub trait Driver {
     /// Auxiliary driver probe.
     ///
     /// Called when an auxiliary device is matches a corresponding driver.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
-        -> impl PinInit<Self::Data, Error>;
+    fn probe(
+        dev: &Device<device::Core<'_>>,
+        id_info: &Self::IdInfo,
+    ) -> impl PinInit<Self::Data, Error>;
 
     /// Auxiliary driver unbind.
     ///
@@ -224,7 +226,7 @@ fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
+    fn unbind(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 }
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 50dd2a2c3e81..0df518fa1d77 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -892,7 +892,7 @@ fn register_em(_policy: &mut Policy) {
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 ///
 ///     fn probe(
-///         pdev: &platform::Device<Core>,
+///         pdev: &platform::Device<Core<'_>>,
 ///         _id_info: Option<&Self::IdInfo>,
 ///     ) -> impl PinInit<Self, Error> {
 ///         cpufreq::Registration::<SampleDriver>::new_foreign_owned(pdev.as_ref())?;
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index c4486f4b8c40..645afc49a27d 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -201,7 +201,7 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
     }
 }
 
-impl Device<CoreInternal> {
+impl<'a> Device<CoreInternal<'a>> {
     /// Store a pointer to the bound driver's private data.
     pub fn set_drvdata<T>(&self, data: impl PinInit<T, Error>) -> Result {
         let data = KBox::pin_init(data, GFP_KERNEL)?;
@@ -511,7 +511,7 @@ pub trait DeviceContext: private::Sealed {}
 /// callback it appears in. It is intended to be used for synchronization purposes. Bus device
 /// implementations can implement methods for [`Device<Core>`], such that they can only be called
 /// from bus callbacks.
-pub struct Core;
+pub struct Core<'a>(PhantomData<&'a ()>);
 
 /// Semantically the same as [`Core`], but reserved for internal usage of the corresponding bus
 /// abstraction.
@@ -522,7 +522,7 @@ pub trait DeviceContext: private::Sealed {}
 ///
 /// This context mainly exists to share generic [`Device`] infrastructure that should only be called
 /// from bus callbacks with bus abstractions, but without making them accessible for drivers.
-pub struct CoreInternal;
+pub struct CoreInternal<'a>(PhantomData<&'a ()>);
 
 /// The [`Bound`] context is the [`DeviceContext`] of a bus specific device when it is guaranteed to
 /// be bound to a driver.
@@ -546,14 +546,14 @@ mod private {
     pub trait Sealed {}
 
     impl Sealed for super::Bound {}
-    impl Sealed for super::Core {}
-    impl Sealed for super::CoreInternal {}
+    impl<'a> Sealed for super::Core<'a> {}
+    impl<'a> Sealed for super::CoreInternal<'a> {}
     impl Sealed for super::Normal {}
 }
 
 impl DeviceContext for Bound {}
-impl DeviceContext for Core {}
-impl DeviceContext for CoreInternal {}
+impl<'a> DeviceContext for Core<'a> {}
+impl<'a> DeviceContext for CoreInternal<'a> {}
 impl DeviceContext for Normal {}
 
 impl<Ctx: DeviceContext> AsRef<Device<Ctx>> for Device<Ctx> {
@@ -603,6 +603,22 @@ unsafe fn from_device(dev: &Device<Ctx>) -> &Self
 #[doc(hidden)]
 #[macro_export]
 macro_rules! __impl_device_context_deref {
+    (unsafe { $device:ident, <$lt:lifetime> $src:ty => $dst:ty }) => {
+        impl<$lt> ::core::ops::Deref for $device<$src> {
+            type Target = $device<$dst>;
+
+            fn deref(&self) -> &Self::Target {
+                let ptr: *const Self = self;
+
+                // CAST: `$device<$src>` and `$device<$dst>` transparently wrap the same type by the
+                // safety requirement of the macro.
+                let ptr = ptr.cast::<Self::Target>();
+
+                // SAFETY: `ptr` was derived from `&self`.
+                unsafe { &*ptr }
+            }
+        }
+    };
     (unsafe { $device:ident, $src:ty => $dst:ty }) => {
         impl ::core::ops::Deref for $device<$src> {
             type Target = $device<$dst>;
@@ -635,14 +651,14 @@ macro_rules! impl_device_context_deref {
         // `__impl_device_context_deref!`.
         ::kernel::__impl_device_context_deref!(unsafe {
             $device,
-            $crate::device::CoreInternal => $crate::device::Core
+            <'a> $crate::device::CoreInternal<'a> => $crate::device::Core<'a>
         });
 
         // SAFETY: This macro has the exact same safety requirement as
         // `__impl_device_context_deref!`.
         ::kernel::__impl_device_context_deref!(unsafe {
             $device,
-            $crate::device::Core => $crate::device::Bound
+            <'a> $crate::device::Core<'a> => $crate::device::Bound
         });
 
         // SAFETY: This macro has the exact same safety requirement as
@@ -657,6 +673,13 @@ macro_rules! impl_device_context_deref {
 #[doc(hidden)]
 #[macro_export]
 macro_rules! __impl_device_context_into_aref {
+    (<$lt:lifetime> $src:ty, $device:tt) => {
+        impl<$lt> ::core::convert::From<&$device<$src>> for $crate::sync::aref::ARef<$device> {
+            fn from(dev: &$device<$src>) -> Self {
+                (&**dev).into()
+            }
+        }
+    };
     ($src:ty, $device:tt) => {
         impl ::core::convert::From<&$device<$src>> for $crate::sync::aref::ARef<$device> {
             fn from(dev: &$device<$src>) -> Self {
@@ -671,8 +694,12 @@ fn from(dev: &$device<$src>) -> Self {
 #[macro_export]
 macro_rules! impl_device_context_into_aref {
     ($device:tt) => {
-        ::kernel::__impl_device_context_into_aref!($crate::device::CoreInternal, $device);
-        ::kernel::__impl_device_context_into_aref!($crate::device::Core, $device);
+        ::kernel::__impl_device_context_into_aref!(
+            <'a> $crate::device::CoreInternal<'a>, $device
+        );
+        ::kernel::__impl_device_context_into_aref!(
+            <'a> $crate::device::Core<'a>, $device
+        );
         ::kernel::__impl_device_context_into_aref!($crate::device::Bound, $device);
     };
 }
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e5f93aed20c..fd4633f977f6 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -304,7 +304,7 @@ pub fn device(&self) -> &Device {
     ///     pci, //
     /// };
     ///
-    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
+    /// fn from_core(dev: &pci::Device<Core<'_>>, devres: Devres<pci::Bar<0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
     ///
     ///     let _ = bar.read32(0x0);
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 4995ee5dc689..8f97916e0688 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -47,7 +47,7 @@
 /// where the underlying bus is DMA capable, such as:
 #[cfg_attr(CONFIG_PCI, doc = "* [`pci::Device`](kernel::pci::Device)")]
 /// * [`platform::Device`](::kernel::platform::Device)
-pub trait Device: AsRef<device::Device<Core>> {
+pub trait Device<'a>: AsRef<device::Device<Core<'a>>> {
     /// Set up the device's DMA streaming addressing capabilities.
     ///
     /// This method is usually called once from `probe()` as soon as the device capabilities are
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index f47814b1401c..93df26ec7caf 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -27,11 +27,11 @@
 //!     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 //!
 //!     /// Driver probe.
-//!     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
+//!     fn probe(dev: &Device<device::Core<'_>>, id_info: &Self::IdInfo)
 //!         -> impl PinInit<Self::Data, Error>;
 //!
 //!     /// Driver unbind (optional).
-//!     fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
+//!     fn unbind(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data>) {
 //!         let _ = (dev, this);
 //!     }
 //! }
@@ -191,7 +191,7 @@ extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // a `struct device`.
         //
         // INVARIANT: `dev` is valid for the duration of the `post_unbind_callback()`.
-        let dev = unsafe { &*dev.cast::<device::Device<device::CoreInternal>>() };
+        let dev = unsafe { &*dev.cast::<device::Device<device::CoreInternal<'_>>>() };
 
         // `remove()` has been completed at this point; devres resources are still valid and will
         // be released after the driver's bus device private data is dropped.
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index bfd081518615..50feade0fb58 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -157,7 +157,7 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_
         // `struct i2c_client`.
         //
         // INVARIANT: `idev` is valid for the duration of `probe_callback()`.
-        let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
+        let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal<'_>>>() };
 
         let info =
             Self::i2c_id_info(idev).or_else(|| <Self as driver::Adapter>::id_info(idev.as_ref()));
@@ -172,7 +172,7 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_
 
     extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
         // SAFETY: `idev` is a valid pointer to a `struct i2c_client`.
-        let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
+        let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal<'_>>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `I2cClient::set_drvdata()` has been called
@@ -184,7 +184,7 @@ extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
 
     extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
         // SAFETY: `shutdown_callback` is only ever called for a valid `idev`
-        let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal>>() };
+        let idev = unsafe { &*idev.cast::<I2cClient<device::CoreInternal<'_>>>() };
 
         // SAFETY: `shutdown_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
@@ -300,13 +300,13 @@ macro_rules! module_i2c_driver {
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
 ///     fn probe(
-///         _idev: &i2c::I2cClient<Core>,
+///         _idev: &i2c::I2cClient<Core<'_>>,
 ///         _id_info: Option<&Self::IdInfo>,
 ///     ) -> impl PinInit<Self::Data, Error> {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn shutdown(_idev: &i2c::I2cClient<Core>, this: Pin<&Self::Data>) {
+///     fn shutdown(_idev: &i2c::I2cClient<Core<'_>>, this: Pin<&Self::Data>) {
 ///     }
 /// }
 ///```
@@ -336,7 +336,7 @@ pub trait Driver {
     /// Called when a new i2c client is added or discovered.
     /// Implementers should attempt to initialize the client here.
     fn probe(
-        dev: &I2cClient<device::Core>,
+        dev: &I2cClient<device::Core<'_>>,
         id_info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self::Data, Error>;
 
@@ -351,7 +351,7 @@ fn probe(
     /// This callback is distinct from final resource cleanup, as the driver instance remains valid
     /// after it returns. Any deallocation or teardown of driver-owned resources should instead be
     /// handled in `Drop`.
-    fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self::Data>) {
+    fn shutdown(dev: &I2cClient<device::Core<'_>>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 
@@ -365,7 +365,7 @@ fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self::Data>) {
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &I2cClient<device::Core>, this: Pin<&Self::Data>) {
+    fn unbind(dev: &I2cClient<device::Core<'_>>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index e136b676d372..03d8745b5e1d 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -65,7 +65,7 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     ///    # type Data = Self;
     ///
     ///    fn probe(
-    ///       pdev: &platform::Device<Core>,
+    ///       pdev: &platform::Device<Core<'_>>,
     ///       info: Option<&Self::IdInfo>,
     ///    ) -> impl PinInit<Self, Error> {
     ///       let offset = 0; // Some offset.
@@ -130,7 +130,7 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     ///    # type Data = Self;
     ///
     ///    fn probe(
-    ///       pdev: &platform::Device<Core>,
+    ///       pdev: &platform::Device<Core<'_>>,
     ///       info: Option<&Self::IdInfo>,
     ///    ) -> impl PinInit<Self, Error> {
     ///       let offset = 0; // Some offset.
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index d214a861375d..314ad9fefdb0 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -105,7 +105,7 @@ extern "C" fn probe_callback(
         // `struct pci_dev`.
         //
         // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
-        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
 
         // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct pci_device_id` and
         // does not add additional invariants, so it's safe to transmute.
@@ -125,7 +125,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // `struct pci_dev`.
         //
         // INVARIANT: `pdev` is valid for the duration of `remove_callback()`.
-        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
@@ -283,7 +283,7 @@ macro_rules! pci_device_table {
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 ///
 ///     fn probe(
-///         _pdev: &pci::Device<Core>,
+///         _pdev: &pci::Device<Core<'_>>,
 ///         _id_info: &Self::IdInfo,
 ///     ) -> impl PinInit<Self, Error> {
 ///         Err(ENODEV)
@@ -311,8 +311,10 @@ pub trait Driver {
     ///
     /// Called when a new pci device is added or discovered. Implementers should
     /// attempt to initialize the device here.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
-        -> impl PinInit<Self::Data, Error>;
+    fn probe(
+        dev: &Device<device::Core<'_>>,
+        id_info: &Self::IdInfo,
+    ) -> impl PinInit<Self::Data, Error>;
 
     /// PCI driver unbind.
     ///
@@ -324,7 +326,7 @@ fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
+    fn unbind(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 }
@@ -359,7 +361,7 @@ impl Device {
     ///
     /// ```
     /// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
-    /// fn log_device_info(pdev: &pci::Device<Core>) -> Result {
+    /// fn log_device_info(pdev: &pci::Device<Core<'_>>) -> Result {
     ///     // Get an instance of `Vendor`.
     ///     let vendor = pdev.vendor_id();
     ///     dev_info!(
@@ -450,7 +452,7 @@ pub fn pci_class(&self) -> Class {
     }
 }
 
-impl Device<device::Core> {
+impl<'a> Device<device::Core<'a>> {
     /// Enable memory resources for this device.
     pub fn enable_device_mem(&self) -> Result {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
@@ -476,7 +478,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
 kernel::impl_device_context_deref!(unsafe { Device });
 kernel::impl_device_context_into_aref!(Device);
 
-impl crate::dma::Device for Device<device::Core> {}
+impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 50005d176561..dbaf301666e7 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -19,7 +19,7 @@
 ///
 /// ```
 /// # use kernel::{device::Core, pci::{self, Class}, prelude::*};
-/// fn probe_device(pdev: &pci::Device<Core>) -> Result {
+/// fn probe_device(pdev: &pci::Device<Core<'_>>) -> Result {
 ///     let pci_class = pdev.pci_class();
 ///     dev_info!(
 ///         pdev,
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 106a5ed57ea6..257b7084338c 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -97,7 +97,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
         // `struct platform_device`.
         //
         // INVARIANT: `pdev` is valid for the duration of `probe_callback()`.
-        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
         let info = <Self as driver::Adapter>::id_info(pdev.as_ref());
 
         from_result(|| {
@@ -113,7 +113,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
         // `struct platform_device`.
         //
         // INVARIANT: `pdev` is valid for the duration of `remove_callback()`.
-        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal>>() };
+        let pdev = unsafe { &*pdev.cast::<Device<device::CoreInternal<'_>>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
@@ -197,7 +197,7 @@ macro_rules! module_platform_driver {
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
 ///     fn probe(
-///         _pdev: &platform::Device<Core>,
+///         _pdev: &platform::Device<Core<'_>>,
 ///         _id_info: Option<&Self::IdInfo>,
 ///     ) -> impl PinInit<Self, Error> {
 ///         Err(ENODEV)
@@ -227,7 +227,7 @@ pub trait Driver {
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
     fn probe(
-        dev: &Device<device::Core>,
+        dev: &Device<device::Core<'_>>,
         id_info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self::Data, Error>;
 
@@ -241,7 +241,7 @@ fn probe(
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
+    fn unbind(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data>) {
         let _ = (dev, this);
     }
 }
@@ -513,7 +513,7 @@ pub fn optional_irq_by_name(&self, name: &CStr) -> Result<IrqRequest<'_>> {
 kernel::impl_device_context_deref!(unsafe { Device });
 kernel::impl_device_context_into_aref!(Device);
 
-impl crate::dma::Device for Device<device::Core> {}
+impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 6c917d8fa883..1dbb8387b463 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -82,7 +82,7 @@ extern "C" fn probe_callback(
         // `struct usb_interface` and `struct usb_device_id`.
         //
         // INVARIANT: `intf` is valid for the duration of `probe_callback()`.
-        let intf = unsafe { &*intf.cast::<Interface<device::CoreInternal>>() };
+        let intf = unsafe { &*intf.cast::<Interface<device::CoreInternal<'_>>>() };
 
         from_result(|| {
             // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct usb_device_id` and
@@ -92,7 +92,7 @@ extern "C" fn probe_callback(
             let info = T::ID_TABLE.info(id.index());
             let data = T::probe(intf, id, info);
 
-            let dev: &device::Device<device::CoreInternal> = intf.as_ref();
+            let dev: &device::Device<device::CoreInternal<'_>> = intf.as_ref();
             dev.set_drvdata(data)?;
             Ok(0)
         })
@@ -103,9 +103,9 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
         // `struct usb_interface`.
         //
         // INVARIANT: `intf` is valid for the duration of `disconnect_callback()`.
-        let intf = unsafe { &*intf.cast::<Interface<device::CoreInternal>>() };
+        let intf = unsafe { &*intf.cast::<Interface<device::CoreInternal<'_>>>() };
 
-        let dev: &device::Device<device::CoreInternal> = intf.as_ref();
+        let dev: &device::Device<device::CoreInternal<'_>> = intf.as_ref();
 
         // SAFETY: `disconnect_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
@@ -291,14 +291,14 @@ macro_rules! usb_device_table {
 ///     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 ///
 ///     fn probe(
-///         _interface: &usb::Interface<Core>,
+///         _interface: &usb::Interface<Core<'_>>,
 ///         _id: &usb::DeviceId,
 ///         _info: &Self::IdInfo,
 ///     ) -> impl PinInit<Self::Data, Error> {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Self::Data>) {}
+///     fn disconnect(_interface: &usb::Interface<Core<'_>>, _data: Pin<&Self::Data>) {}
 /// }
 ///```
 pub trait Driver {
@@ -316,7 +316,7 @@ pub trait Driver {
     /// Called when a new USB interface is bound to this driver.
     /// Implementers should attempt to initialize the interface here.
     fn probe(
-        interface: &Interface<device::Core>,
+        interface: &Interface<device::Core<'_>>,
         id: &DeviceId,
         id_info: &Self::IdInfo,
     ) -> impl PinInit<Self::Data, Error>;
@@ -324,7 +324,7 @@ fn probe(
     /// USB driver disconnect.
     ///
     /// Called when the USB interface is about to be unbound from this driver.
-    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self::Data>);
+    fn disconnect(interface: &Interface<device::Core<'_>>, data: Pin<&Self::Data>);
 }
 
 /// A USB interface.
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 478c4f693deb..37640ed33642 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -122,7 +122,7 @@ impl platform::Driver for RustDebugFs {
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
+        pdev: &platform::Device<Core<'_>>,
         _info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
         RustDebugFs::new(pdev).pin_chain(|this| {
@@ -147,7 +147,7 @@ fn build_inner(dir: &Dir) -> impl PinInit<File<Mutex<Inner>>> + '_ {
         dir.read_write_file(c"pair", new_mutex!(Inner { x: 3, y: 10 }))
     }
 
-    fn new(pdev: &platform::Device<Core>) -> impl PinInit<Self, Error> + '_ {
+    fn new<'a>(pdev: &'a platform::Device<Core<'_>>) -> impl PinInit<Self, Error> + 'a {
         let debugfs = Dir::new(c"sample_debugfs");
         let dev = pdev.as_ref();
 
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index e583c6b8390a..9a243e7c7298 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -61,7 +61,7 @@ impl pci::Driver for DmaSampleDriver {
     type Data = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         pin_init::pin_init_scope(move || {
             dev_info!(pdev, "Probe DMA test driver.\n");
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 61d5bf2e8c0d..f0d419823f9a 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -35,7 +35,10 @@ impl auxiliary::Driver for AuxiliaryDriver {
 
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        adev: &auxiliary::Device<Core<'_>>,
+        _info: &Self::IdInfo,
+    ) -> impl PinInit<Self, Error> {
         dev_info!(
             adev,
             "Probing auxiliary driver for auxiliary device with id={}\n",
@@ -70,7 +73,7 @@ impl pci::Driver for ParentDriver {
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         Ok(Self {
             _reg0: auxiliary::Registration::new(
                 pdev.as_ref(),
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
index 8269f1798611..171550ea0b6f 100644
--- a/samples/rust/rust_driver_i2c.rs
+++ b/samples/rust/rust_driver_i2c.rs
@@ -42,7 +42,7 @@ impl i2c::Driver for SampleDriver {
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe(
-        idev: &i2c::I2cClient<Core>,
+        idev: &i2c::I2cClient<Core<'_>>,
         info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
         let dev = idev.as_ref();
@@ -56,11 +56,11 @@ fn probe(
         Ok(Self)
     }
 
-    fn shutdown(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
+    fn shutdown(idev: &i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
         dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
     }
 
-    fn unbind(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
+    fn unbind(idev: &i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
         dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
     }
 }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index f43c6a660b39..3106f766fd93 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -144,7 +144,7 @@ impl pci::Driver for SampleDriver {
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(pdev: &pci::Device<Core<'_>>, info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         pin_init::pin_init_scope(move || {
             let vendor = pdev.vendor_id();
             dev_dbg!(
@@ -175,7 +175,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
         })
     }
 
-    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
+    fn unbind(pdev: &pci::Device<Core<'_>>, this: Pin<&Self>) {
         if let Ok(bar) = this.bar.access(pdev.as_ref()) {
             // Reset pci-testdev by writing a new test index.
             bar.write_reg(regs::TEST::zeroed().with_index(this.index));
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 6505902f8200..04d40f836275 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -106,7 +106,7 @@ impl platform::Driver for SampleDriver {
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
+        pdev: &platform::Device<Core<'_>>,
         info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
         let dev = pdev.as_ref();
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
index 5942e4b01fd8..e900993335e9 100644
--- a/samples/rust/rust_driver_usb.rs
+++ b/samples/rust/rust_driver_usb.rs
@@ -30,18 +30,18 @@ impl usb::Driver for SampleDriver {
     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 
     fn probe(
-        intf: &usb::Interface<Core>,
+        intf: &usb::Interface<Core<'_>>,
         _id: &usb::DeviceId,
         _info: &Self::IdInfo,
     ) -> impl PinInit<Self, Error> {
-        let dev: &device::Device<Core> = intf.as_ref();
+        let dev: &device::Device<Core<'_>> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample probed\n");
 
         Ok(Self { _intf: intf.into() })
     }
 
-    fn disconnect(intf: &usb::Interface<Core>, _data: Pin<&Self>) {
-        let dev: &device::Device<Core> = intf.as_ref();
+    fn disconnect(intf: &usb::Interface<Core<'_>>, _data: Pin<&Self>) {
+        let dev: &device::Device<Core<'_>> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample disconnected\n");
     }
 }
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
index 5956b647294d..3f273c754f86 100644
--- a/samples/rust/rust_i2c_client.rs
+++ b/samples/rust/rust_i2c_client.rs
@@ -111,7 +111,7 @@ impl platform::Driver for SampleDriver {
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<device::Core>,
+        pdev: &platform::Device<device::Core<'_>>,
         _info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
         dev_info!(
@@ -130,7 +130,7 @@ fn probe(
         })
     }
 
-    fn unbind(pdev: &platform::Device<device::Core>, _this: Pin<&Self>) {
+    fn unbind(pdev: &platform::Device<device::Core<'_>>, _this: Pin<&Self>) {
         dev_info!(
             pdev.as_ref(),
             "Unbind Rust I2C Client registration sample.\n"
diff --git a/samples/rust/rust_soc.rs b/samples/rust/rust_soc.rs
index a5e72582f4a2..c466653491d2 100644
--- a/samples/rust/rust_soc.rs
+++ b/samples/rust/rust_soc.rs
@@ -42,7 +42,7 @@ impl platform::Driver for SampleSocDriver {
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
     fn probe(
-        pdev: &platform::Device<Core>,
+        pdev: &platform::Device<Core<'_>>,
         _info: Option<&Self::IdInfo>,
     ) -> impl PinInit<Self, Error> {
         dev_dbg!(pdev, "Probe Rust SoC driver sample.\n");
-- 
2.54.0


