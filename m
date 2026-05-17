Return-Path: <linux-pwm+bounces-8909-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFEgHPUGCWouFgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8909-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:08:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD0155E943
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66ACF302617E
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1921922FD;
	Sun, 17 May 2026 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDs53Kno"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE38F7D;
	Sun, 17 May 2026 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976192; cv=none; b=DxLV33lOaDWOCYI4P96H6s0tNLwAxO23S113BJwto7scv++sRz0udF8yAfI7ABGPv3pPbu8LwMbORk4TmYdxkGekycKQlGQOjdqt4t2zrrxK1ovdYQY0oI8OMM376cLZ2tdc9Ow3+YHHrwRwkANy+/pAOLP6ibEF4NPHClvaoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976192; c=relaxed/simple;
	bh=n+WnYgY5mFfRCQlkmWsELxd/5dFRFZ1BO6cq0dizv8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/kf3/VACS7jBEZp4QgYOSjG+0VJsUrUN66ExtddHr5no1z7vJRG7gccslvTPUpAESuS0nWPGKJ0DmSE7Gyd23jKKuSQzSNDkNyH0j7GpvfkZ1ddDZrSHGOmGUQhRfku4VZgEU9XTIXGqYQbT7b/I01po8h1BEeZ6kP8BHTMWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDs53Kno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A06C19425;
	Sun, 17 May 2026 00:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976192;
	bh=n+WnYgY5mFfRCQlkmWsELxd/5dFRFZ1BO6cq0dizv8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDs53KnojRujvVOFr52+PT7renaUzuKsk4vqzrM0J6xvFBMN6DAxOkHco5XNLDl5C
	 tUN5mb5tVmFNUIqsH9Cmmx2zQkwNJuio3Sn27YAZMzplRW0BefKyswLhCupRSDUjtX
	 iApIfaDfcxN8Pl8nrfjtfUzFHC5JNUvrbTlfK6XI/tNWJy96L4U1NG0nNj6t/sWdEQ
	 /QbTtXl1IQp2iGTq9nvnWe7cfTJa5dodSMKwKiArtZcs6wP6anGsEZi/uYhdPDcr30
	 Zsqapl3XANoRDUEGlrrc4GiFhS3Fkppnv1MmJwwR4oEjGwcWPBxCcH84Ioq9BZbgC2
	 Zizcu9Aln5ZKw==
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
Subject: [PATCH v3 10/27] rust: pci: make Driver trait lifetime-parameterized
Date: Sun, 17 May 2026 02:00:58 +0200
Message-ID: <20260517000149.3226762-11-dakr@kernel.org>
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
X-Rspamd-Queue-Id: CFD0155E943
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
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-8909-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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
 drivers/gpu/nova-core/driver.rs       |  9 ++++++---
 rust/kernel/pci.rs                    | 24 +++++++++++++-----------
 samples/rust/rust_dma.rs              |  7 +++++--
 samples/rust/rust_driver_auxiliary.rs |  7 +++++--
 samples/rust/rust_driver_pci.rs       |  7 +++++--
 5 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 699e27046c93..fe4eafe1ebf0 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -74,10 +74,13 @@ pub(crate) struct NovaCore {
 
 impl pci::Driver for NovaCore {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
@@ -109,7 +112,7 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
         })
     }
 
-    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
+    fn unbind<'bound>(pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self>) {
         this.gpu.unbind(pdev.as_ref());
     }
 }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index c06ac3fb2a64..8060861199d4 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -64,7 +64,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::pci_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -130,7 +130,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data>() };
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(pdev, data);
     }
@@ -279,13 +279,13 @@ macro_rules! pci_device_table {
 ///
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
-///     type Data = Self;
+///     type Data<'bound> = Self;
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 ///
-///     fn probe(
-///         _pdev: &pci::Device<Core>,
-///         _id_info: &Self::IdInfo,
-///     ) -> impl PinInit<Self, Error> {
+///     fn probe<'bound>(
+///         _pdev: &'bound pci::Device<Core>,
+///         _id_info: &'bound Self::IdInfo,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 /// }
@@ -302,7 +302,7 @@ pub trait Driver: Send {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data;
+    type Data<'bound>: 'bound;
 
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
@@ -311,8 +311,10 @@ pub trait Driver: Send {
     ///
     /// Called when a new pci device is added or discovered. Implementers should
     /// attempt to initialize the device here.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
-        -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        dev: &'bound Device<device::Core>,
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// PCI driver unbind.
     ///
@@ -324,7 +326,7 @@ fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo)
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
+    fn unbind<'bound>(dev: &'bound Device<device::Core>, this: Pin<&'bound Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index e583c6b8390a..943655a85ec6 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -58,10 +58,13 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
 
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_info!(pdev, "Probe DMA test driver.\n");
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 61d5bf2e8c0d..2f57912fe87f 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -66,11 +66,14 @@ struct ParentDriver {
 
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         Ok(Self {
             _reg0: auxiliary::Registration::new(
                 pdev.as_ref(),
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index f43c6a660b39..30b9311812f3 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -140,11 +140,14 @@ fn config_space(pdev: &pci::Device<Bound>) {
 
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core>,
+        info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             let vendor = pdev.vendor_id();
             dev_dbg!(
-- 
2.54.0


