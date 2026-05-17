Return-Path: <linux-pwm+bounces-8911-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPvZGSYGCWq6FQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8911-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:04:54 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D661C55E7AF
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFB21303B4D2
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074B31A6800;
	Sun, 17 May 2026 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoPVBIzP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DC3194AE6;
	Sun, 17 May 2026 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976206; cv=none; b=b6bNpK+HxzLg+KR8IbI7AFHH6E3Y0cC0VXjdDH3JSyMLcNrUzONzKklmpvmkm+VzRVCudE38F7MAmWkc7uE39v1+lRyCs2o1ZwUB9wA67HJtqxKclrgGFn95D55ts2ksFLoVz0XRI3veEyhf1prW0GjKr9UQvrkkS2KPOpQvWlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976206; c=relaxed/simple;
	bh=avrhsflP+Zp0J2Q2FrOowrwuKNUrLPH/AYRqanHkf2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDsj2yZCe9h6H8tX/3Dm/Ggrl0RV7S6t8lKU+vi+B7MCe/1Fcht/3tdTT+ld9dEAR0k1/T7ugy3cs73N2zANDfXuxBy7Tmzw/FfZKEb9fWMSaT5fpgRGPFeD90iYwkAEIBUwM2B52NkPUHpqjiUjphD8d+a+zw5YhxxVuzVJB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoPVBIzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043BEC2BCC7;
	Sun, 17 May 2026 00:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976206;
	bh=avrhsflP+Zp0J2Q2FrOowrwuKNUrLPH/AYRqanHkf2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IoPVBIzPQrPw3//jYeUZUdeRMbyQ/J5Dw9JpDDFf6xBKAe8HtUHlZ7V26Tkq0hhJJ
	 5iRLFwbCaR0fIP3Pfx9RU8MUMVbabn3CcxZY0Ebly0AgyIsHA3tt2Swg+0zEibuz41
	 5dj0B1SPUf4Zu9LGsLklnabM6CjSTLg73Phm3Keu+e7M8jawW4KbJQIeO2Mi9meRHf
	 4eHLMiY+q/RybsvOSsjOfsuK+EHWfZzWmoNhNHKdU9vLDE+ancpL3cVLGcE6AMSgNT
	 P/T7w9Oc1r4sM92nK/WIFhJe8XZ7Aiv3litDJBb1rRpZ6Hcez9cK5rFNMycrC1guUH
	 lBm4eE+QMh3WA==
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
Subject: [PATCH v3 12/27] rust: auxiliary: make Driver trait lifetime-parameterized
Date: Sun, 17 May 2026 02:01:00 +0200
Message-ID: <20260517000149.3226762-13-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D661C55E7AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-8911-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a 'bound lifetime to the associated Data, changing type Data to type
Data<'bound>.

This allows the driver's bus device private data to capture the device /
driver bound lifetime; device resources can be stored directly by
reference rather than requiring Devres.

The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
on the methods themselves; avoiding a global lifetime on the trait impl.

Existing drivers set type Data<'bound> = Self, preserving the current
behavior.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs        |  7 +++++--
 rust/kernel/auxiliary.rs              | 14 ++++++++------
 samples/rust/rust_driver_auxiliary.rs |  7 +++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 08136ec0bccb..1d73c595dda4 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -51,10 +51,13 @@ pub(crate) struct NovaData {
 
 impl auxiliary::Driver for NovaDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        adev: &'bound auxiliary::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
         let drm = drm::Device::<Self>::new(adev.as_ref(), data)?;
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index c6d97c95c3e7..3f1e2966c03a 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -46,7 +46,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::auxiliary_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -112,7 +112,7 @@ extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { adev.as_ref().drvdata_borrow::<T::Data>() };
+        let data = unsafe { adev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(adev, data);
     }
@@ -203,7 +203,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data;
+    type Data<'bound>: 'bound;
 
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
@@ -211,8 +211,10 @@ pub trait Driver {
     /// Auxiliary driver probe.
     ///
     /// Called when an auxiliary device is matches a corresponding driver.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
-        -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        dev: &'bound Device<device::Core>,
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// Auxiliary driver unbind.
     ///
@@ -224,7 +226,7 @@ fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
+    fn unbind<'bound>(dev: &'bound Device<device::Core>, this: Pin<&'bound Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 2f57912fe87f..972a3d5b25e7 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -31,11 +31,14 @@
 
 impl auxiliary::Driver for AuxiliaryDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        adev: &'bound auxiliary::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         dev_info!(
             adev,
             "Probing auxiliary driver for auxiliary device with id={}\n",
-- 
2.54.0


