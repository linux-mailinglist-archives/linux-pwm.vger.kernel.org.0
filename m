Return-Path: <linux-pwm+bounces-8913-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQxGUoGCWq6FQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8913-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:05:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F655E842
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7229F30433D4
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8143F1990C7;
	Sun, 17 May 2026 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB+5ABQt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5E150997;
	Sun, 17 May 2026 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976220; cv=none; b=rm9LY0vQKZUTqF1mfGYaLMSVW1t0pzXQ2SlrmPlHgsn5eGuIbXTa7a1N2jIWkx+AJ2thhRdzSvDJdTV2VRDsr8iGsT/N10ZLUmEs8tdnxiGctHg65Pvmb/zRZcjH6fz9iCdWUZA9o1Wre5VLYdI9MkOsX1JuYZZ8h15DF2x/arI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976220; c=relaxed/simple;
	bh=Zo6WE+DRYsAkoDwkuP/dDu+ogxcsNbqn59fzAOqKPF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg4aIkPVaY0jsL1FBSa0PYAC6H1Zfu6xBNH7jNu+tpdmpk87fAP+OAKkf9+qdPv/ZLRn6nRxml7sEcPs9HEVHw6ZDb7FnsIJLYCc/9e1Scc9ho2yp5CJ95KmMvdyy6fMbwmMZ/S9PpZXWDVgeVDRvzCUWpe2gnVMzPkp9y5hRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB+5ABQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9697AC2BCC7;
	Sun, 17 May 2026 00:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976220;
	bh=Zo6WE+DRYsAkoDwkuP/dDu+ogxcsNbqn59fzAOqKPF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QB+5ABQtSyihh2Oqc5dx/d10Lxx8hzFyOj8XI5lpgDPCdDGwzZ5r9kkW794hE9WAk
	 Av1ClfGNIOsn1co358RWpVd4/DIwMeDgWVFCZwXrzk0QLDJ+qG9OpnFH0dIwiotqmM
	 AyVWnwZk3HvpSoOREMpkVD+ZfjNT4eiedtNHafuiUH7GHlfhs55JgBSXzcf1VMwaZD
	 6/HvI5C86HFvNSSayrV1vKqWTcPmorugnHhOPggnpkhGevGjuKbeB3mhD+07rA77yf
	 HTsNPXMbqYpgSaAJNIWvNh1AGzL2om6PYX0hM3VcJUrkHNX1eVt9DE0V/bwWlWTdCJ
	 kWSpZLvmX+iUQ==
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
Subject: [PATCH v3 14/27] rust: i2c: make Driver trait lifetime-parameterized
Date: Sun, 17 May 2026 02:01:02 +0200
Message-ID: <20260517000149.3226762-15-dakr@kernel.org>
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
X-Rspamd-Queue-Id: D78F655E842
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
	TAGGED_FROM(0.00)[bounces-8913-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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

Acked-by: Igor Korotin <igor.korotin@linux.dev>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/i2c.rs              | 38 +++++++++++++++++++--------------
 samples/rust/rust_driver_i2c.rs | 14 ++++++------
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 5a4014f379d5..7b92d42a2b98 100644
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
-///         _idev: &i2c::I2cClient<Core>,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self::Data, Error> {
+///     fn probe<'bound>(
+///         _idev: &'bound i2c::I2cClient<Core>,
+///         _id_info: Option<&'bound Self::IdInfo>,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn shutdown(_idev: &i2c::I2cClient<Core>, this: Pin<&Self::Data>) {
+///     fn shutdown<'bound>(
+///         _idev: &'bound i2c::I2cClient<Core>,
+///         this: Pin<&'bound Self::Data<'bound>>,
+///     ) {
 ///     }
 /// }
 ///```
@@ -320,7 +323,7 @@ pub trait Driver: Send {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data;
+    type Data<'bound>: 'bound;
 
     /// The table of device ids supported by the driver.
     const I2C_ID_TABLE: Option<IdTable<Self::IdInfo>> = None;
@@ -335,10 +338,10 @@ pub trait Driver: Send {
     ///
     /// Called when a new i2c client is added or discovered.
     /// Implementers should attempt to initialize the client here.
-    fn probe(
-        dev: &I2cClient<device::Core>,
-        id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        dev: &'bound I2cClient<device::Core>,
+        id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// I2C driver shutdown.
     ///
@@ -351,7 +354,10 @@ fn probe(
     /// This callback is distinct from final resource cleanup, as the driver instance remains valid
     /// after it returns. Any deallocation or teardown of driver-owned resources should instead be
     /// handled in `Drop`.
-    fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self::Data>) {
+    fn shutdown<'bound>(
+        dev: &'bound I2cClient<device::Core>,
+        this: Pin<&'bound Self::Data<'bound>>,
+    ) {
         let _ = (dev, this);
     }
 
@@ -365,7 +371,7 @@ fn shutdown(dev: &I2cClient<device::Core>, this: Pin<&Self::Data>) {
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &I2cClient<device::Core>, this: Pin<&Self::Data>) {
+    fn unbind<'bound>(dev: &'bound I2cClient<device::Core>, this: Pin<&'bound Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
index 8269f1798611..6fa3b786d652 100644
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
-        idev: &i2c::I2cClient<Core>,
-        info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        idev: &'bound i2c::I2cClient<Core>,
+        info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev = idev.as_ref();
 
         dev_info!(dev, "Probe Rust I2C driver sample.\n");
@@ -56,11 +56,11 @@ fn probe(
         Ok(Self)
     }
 
-    fn shutdown(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
+    fn shutdown<'bound>(idev: &'bound i2c::I2cClient<Core>, _this: Pin<&'bound Self>) {
         dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
     }
 
-    fn unbind(idev: &i2c::I2cClient<Core>, _this: Pin<&Self>) {
+    fn unbind<'bound>(idev: &'bound i2c::I2cClient<Core>, _this: Pin<&'bound Self>) {
         dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
     }
 }
-- 
2.54.0


