Return-Path: <linux-pwm+bounces-9062-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMxTCvmZD2r5NgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9062-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:49:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D0F5AD0B9
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 765513096747
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 23:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104A37F8A1;
	Thu, 21 May 2026 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojRpc083"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C487378D7D;
	Thu, 21 May 2026 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406868; cv=none; b=AfBAsRRJFfifo8CvsTDZCdLReQ0vJtWjjjhzS/dAWq5fNwHnWKsR7o4QLqGNW/EjVwY3an239h2SYxd++JUbt56WFqlA3xHVl70JOmNsLS1SBbtMnBr2N2IhsAoTFTwURiUt3+Kn3PGdw7Xf9Q/4OYlLhybMOj3k6scrx4iLU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406868; c=relaxed/simple;
	bh=hFwq4rxJ4hLU8uep19pm3k2HDHFR/lEj2oP8SSUZwuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rB/AqjabLonqTDuDzTqkRGuoaHI9/fbEYD4iAcHSaojC8Tcw5zLoma+O6yLRg1SXBsy8y8YmP5u+j8aZizwD7tMek60HghcDoaESfD0purzhrcBG0bnFEYRC/qj+cNxiyICvVsC23rCkczQhsxtpNwh3oM+gS0Bkf5Ups/Rzr38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojRpc083; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1741F00A3B;
	Thu, 21 May 2026 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406862;
	bh=BPjizT1U2YETmq9izMu6+7SN+Rex8/U/rfjmjkOVVMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ojRpc083p2phegVaTInxnkgz4BlCGVA+VIvjrWZ0d7o32p7PAYnf7DqeMQfybPamw
	 5qApm4mVs/LbYCxbaksnhoKm+tY+YQaOUE98z6p/G+u/xvAdNfZu0nlLwxjfbZCsXR
	 xqkg1hflRpt90B3XYbPBEluY9TT5k9S36mptpXQ+7SK96xiLDDXMcyAC2gGNtE31cU
	 xFypqny/xCk9hxeWNsS0foBRaO8Deqygt+jA+Ty/KDifW0cRvrFWVjzWTuCT1gyrP6
	 Gce0Wz+tqDRdq0qZIX0zGKvaW2R3N3sxuwYw/O12vnHu4nK7jMQBwW26kqfpRLtJw6
	 dYp1hiNqqGJ7A==
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
Subject: [PATCH v4 15/27] rust: i2c: make Driver trait lifetime-parameterized
Date: Fri, 22 May 2026 01:34:41 +0200
Message-ID: <20260521233501.1191842-16-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9062-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 81D0F5AD0B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a 'bound lifetime to the associated Data, changing type Data to type
Data<'bound>.

This allows the driver's bus device private data to capture the device /
driver bound lifetime; device resources can be stored directly by
reference rather than requiring Devres.

The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
on the methods themselves; avoiding a global lifetime on the trait impl.

Existing drivers set type Data<'bound> = Self, preserving the current
behavior.

Acked-by: Igor Korotin <igor.korotin@linux.dev>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/i2c.rs              | 35 ++++++++++++++++++---------------
 samples/rust/rust_driver_i2c.rs | 14 ++++++-------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 50feade0fb58..13b16afad9f5 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -98,7 +98,7 @@ macro_rules! i2c_device_table {
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::i2c_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -177,7 +177,7 @@ extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `I2cClient::set_drvdata()` has been called
         // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data>() };
+        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(idev, data);
     }
@@ -189,7 +189,7 @@ extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
         // SAFETY: `shutdown_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data>() };
+        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::shutdown(idev, data);
     }
@@ -294,19 +294,22 @@ macro_rules! module_i2c_driver {
 ///
 /// impl i2c::Driver for MyDriver {
 ///     type IdInfo = ();
-///     type Data = Self;
+///     type Data<'bound> = Self;
 ///     const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
-///     fn probe(
-///         _idev: &i2c::I2cClient<Core<'_>>,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self::Data, Error> {
+///     fn probe<'bound>(
+///         _idev: &'bound i2c::I2cClient<Core<'_>>,
+///         _id_info: Option<&'bound Self::IdInfo>,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn shutdown(_idev: &i2c::I2cClient<Core<'_>>, this: Pin<&Self::Data>) {
+///     fn shutdown<'bound>(
+///         _idev: &'bound i2c::I2cClient<Core<'_>>,
+///         this: Pin<&Self::Data<'bound>>,
+///     ) {
 ///     }
 /// }
 ///```
@@ -320,7 +323,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data: Send;
+    type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
     const I2C_ID_TABLE: Option<IdTable<Self::IdInfo>> = None;
@@ -335,10 +338,10 @@ pub trait Driver {
     ///
     /// Called when a new i2c client is added or discovered.
     /// Implementers should attempt to initialize the client here.
-    fn probe(
-        dev: &I2cClient<device::Core<'_>>,
-        id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        dev: &'bound I2cClient<device::Core<'_>>,
+        id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// I2C driver shutdown.
     ///
@@ -351,7 +354,7 @@ fn probe(
     /// This callback is distinct from final resource cleanup, as the driver instance remains valid
     /// after it returns. Any deallocation or teardown of driver-owned resources should instead be
     /// handled in `Drop`.
-    fn shutdown(dev: &I2cClient<device::Core<'_>>, this: Pin<&Self::Data>) {
+    fn shutdown<'bound>(dev: &'bound I2cClient<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 
@@ -365,7 +368,7 @@ fn shutdown(dev: &I2cClient<device::Core<'_>>, this: Pin<&Self::Data>) {
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &I2cClient<device::Core<'_>>, this: Pin<&Self::Data>) {
+    fn unbind<'bound>(dev: &'bound I2cClient<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
index 171550ea0b6f..ead8263a7d48 100644
--- a/samples/rust/rust_driver_i2c.rs
+++ b/samples/rust/rust_driver_i2c.rs
@@ -35,16 +35,16 @@
 
 impl i2c::Driver for SampleDriver {
     type IdInfo = u32;
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
     const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
-    fn probe(
-        idev: &i2c::I2cClient<Core<'_>>,
-        info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        idev: &'bound i2c::I2cClient<Core<'_>>,
+        info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev = idev.as_ref();
 
         dev_info!(dev, "Probe Rust I2C driver sample.\n");
@@ -56,11 +56,11 @@ fn probe(
         Ok(Self)
     }
 
-    fn shutdown(idev: &i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
+    fn shutdown<'bound>(idev: &'bound i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
         dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
     }
 
-    fn unbind(idev: &i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
+    fn unbind<'bound>(idev: &'bound i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
         dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
     }
 }
-- 
2.54.0


