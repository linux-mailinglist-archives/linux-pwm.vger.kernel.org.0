Return-Path: <linux-pwm+bounces-9141-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLoDEWWzFGoHPgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9141-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:39:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F5A5CE9EF
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795EA30448A7
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514703A7F5F;
	Mon, 25 May 2026 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOPTHp7v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F03A5445;
	Mon, 25 May 2026 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741080; cv=none; b=X3hfROM2h4ljCgJP5UrJXHS8ALw3Qij/QQmLu/dieh4CbqV6xDVJ/ozjq6hEWLMo0PigetVBVyBNfBlow2al6COxKmKlT+45LvBMFUvseAehNMGsfphcF79OUWaH0d7eIy1XUpOSn8oSfW3uFXgctBPu/ioflHZJZDqy7/ie0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741080; c=relaxed/simple;
	bh=UGUo7ln++sMgeCMPj/bJISQXaob/SZ3WKNOovtSb5EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXiAXgA5KWB0LOv+Atu1wUqhDdm73szF92Q/KFRoXP0Uow50V4O/3BYMVraJNpI9xUvCUzAU3rmV52H1CZdsPIkVQfW5+z3v0FGozddHQ8YgbW5/1OG84WK32kUZQ8fvfNtHeuX6DbKwgKMnzE3JRA9IITWuUCVxmP0ytnXdsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOPTHp7v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05BC1F000E9;
	Mon, 25 May 2026 20:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741078;
	bh=a2o69Vls+2LExzNW7VJcfY7abYptUomgAsmgqcBlrbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LOPTHp7v+ngjAkvkvlxodPVMlfS+Eqr5rEOAn5nOIKXIXw/EJJ0zz6nRj7EIGQFeN
	 jvAgCx4crC+w9fS0vXxTeXghGpv2pc0435QskiYySHPGxGhFngCRbxq7I4OQ6qVFnK
	 21ot788FG39stifcpWBzlF5ZG7AWeAmh4B1ye2/uY5sxz5xqdIBulLJWP36pvDjIlj
	 IFmQGfXRcrYRCHAwkf6882HSNfDFFJ9k3iLS+ybvX6tzsQ4I7F56jQ8ufe0HZ+fsBo
	 NlkKOzL8+YC8SN9qnhoKNJlh6bPV3DpotRTyIVUrvQajDMVLoIEqlVaGasZzlM6ren
	 y5ruk0HbPtiFg==
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
	Danilo Krummrich <dakr@kernel.org>,
	Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v5 15/24] rust: usb: make Driver trait lifetime-parameterized
Date: Mon, 25 May 2026 22:21:02 +0200
Message-ID: <20260525202921.124698-16-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9141-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B4F5A5CE9EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a 'bound lifetime to the associated Data, changing type Data to type
Data<'bound>.

This allows the driver's bus device private data to capture the device /
driver bound lifetime; device resources can be stored directly by
reference rather than requiring Devres.

The probe() and disconnect() callbacks thus gain a 'bound lifetime
parameter on the methods themselves; avoiding a global lifetime on the
trait impl.

Existing drivers set type Data<'bound> = Self, preserving the current
behavior.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs              | 37 ++++++++++++++++++++-------------
 samples/rust/rust_driver_usb.rs | 12 +++++------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 1dbb8387b463..7aff0c82d0af 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -41,7 +41,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::usb_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -109,8 +109,8 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
 
         // SAFETY: `disconnect_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { dev.drvdata_borrow::<T::Data>() };
+        // and stored a `Pin<KBox<T::Data<'_>>>`.
+        let data = unsafe { dev.drvdata_borrow::<T::Data<'_>>() };
 
         T::disconnect(intf, data);
     }
@@ -287,18 +287,22 @@ macro_rules! usb_device_table {
 ///
 /// impl usb::Driver for MyDriver {
 ///     type IdInfo = ();
-///     type Data = Self;
+///     type Data<'bound> = Self;
 ///     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 ///
-///     fn probe(
-///         _interface: &usb::Interface<Core<'_>>,
+///     fn probe<'bound>(
+///         _interface: &'bound usb::Interface<Core<'_>>,
 ///         _id: &usb::DeviceId,
-///         _info: &Self::IdInfo,
-///     ) -> impl PinInit<Self::Data, Error> {
+///         _info: &'bound Self::IdInfo,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn disconnect(_interface: &usb::Interface<Core<'_>>, _data: Pin<&Self::Data>) {}
+///     fn disconnect<'bound>(
+///         _interface: &'bound usb::Interface<Core<'_>>,
+///         _data: Pin<&Self::Data<'bound>>,
+///     ) {
+///     }
 /// }
 ///```
 pub trait Driver {
@@ -306,7 +310,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data: Send;
+    type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
@@ -315,16 +319,19 @@ pub trait Driver {
     ///
     /// Called when a new USB interface is bound to this driver.
     /// Implementers should attempt to initialize the interface here.
-    fn probe(
-        interface: &Interface<device::Core<'_>>,
+    fn probe<'bound>(
+        interface: &'bound Interface<device::Core<'_>>,
         id: &DeviceId,
-        id_info: &Self::IdInfo,
-    ) -> impl PinInit<Self::Data, Error>;
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// USB driver disconnect.
     ///
     /// Called when the USB interface is about to be unbound from this driver.
-    fn disconnect(interface: &Interface<device::Core<'_>>, data: Pin<&Self::Data>);
+    fn disconnect<'bound>(
+        interface: &'bound Interface<device::Core<'_>>,
+        data: Pin<&Self::Data<'bound>>,
+    );
 }
 
 /// A USB interface.
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
index e900993335e9..02bd5085f9bc 100644
--- a/samples/rust/rust_driver_usb.rs
+++ b/samples/rust/rust_driver_usb.rs
@@ -26,21 +26,21 @@ struct SampleDriver {
 
 impl usb::Driver for SampleDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 
-    fn probe(
-        intf: &usb::Interface<Core<'_>>,
+    fn probe<'bound>(
+        intf: &'bound usb::Interface<Core<'_>>,
         _id: &usb::DeviceId,
-        _info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error> {
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev: &device::Device<Core<'_>> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample probed\n");
 
         Ok(Self { _intf: intf.into() })
     }
 
-    fn disconnect(intf: &usb::Interface<Core<'_>>, _data: Pin<&Self>) {
+    fn disconnect<'bound>(intf: &'bound usb::Interface<Core<'_>>, _data: Pin<&Self>) {
         let dev: &device::Device<Core<'_>> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample disconnected\n");
     }
-- 
2.54.0


