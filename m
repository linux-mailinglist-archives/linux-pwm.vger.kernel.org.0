Return-Path: <linux-pwm+bounces-8910-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN/SAfkGCWprFgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8910-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:08:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8460055E958
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25475305A26E
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7E819D07A;
	Sun, 17 May 2026 00:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw9kff+I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0278315B135;
	Sun, 17 May 2026 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976200; cv=none; b=F0RKtvI4axvQW3/1nnGurAkhElZfkCVy7fS3eUBTFKhUIofB8ogjl+16rR7Da0ONHERyeLOh/1pdxSATCPZE0cweYl+HeD/MUh3ShM2hEeKH1AwuDz1S3paPfudm6Suy2SsEnbUxQLFmL5UYAl3oY1LK7AvXMyUJywOQtOHi+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976200; c=relaxed/simple;
	bh=p3bMFRLG/WXBDNRXPNCA/gK8l38P0CUm/6IBzdkkBqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyp9BMOywSHynwJA8TH3FEdI/OX7ouRllxe6JCFeoHo1XC6ZrPq0ludBMUnqg+aaUhpz+FlcPdbqWeJkgE/yv9wwT2zK6u4xcM/eFY+6yZeGgw0v8T+5Ix8htxQOOobi7w2XGMtL3EA1BSe66YZM6Dvx8flN+aptuB4TQ6g6Ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw9kff+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B08C19425;
	Sun, 17 May 2026 00:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976199;
	bh=p3bMFRLG/WXBDNRXPNCA/gK8l38P0CUm/6IBzdkkBqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aw9kff+IU/QEv7BALextbViIFqFp6F7EC0DYnzNvBo3KUGA0m9s3fnajKkS6DkFrY
	 UExWd/s/JSS/1eNylybxCSDYAEt4w+hvFqbfu6TKe/v+AscsS7m81JMjMU4XPRJs48
	 wLcVEQ5mFXvTqsJ2e8BN/rLE1b/kBAQ4kzO06GBANeEdDfXGoAoPxZ9Si8M0QJUBri
	 0Bw4h5mmAeDLwHZQrpAwL8u3XgxGx3Q796FesTxUn/1/iRVMMfd51hz7wZVNGh0E0C
	 YSp4QBbAQw0PdYBQGui9bXmEul7QfQ0MqTPuKX8GAZsIDikFOsHi8NBBIgoVE6V0dk
	 Oj/huYWgKl9gQ==
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
Subject: [PATCH v3 11/27] rust: platform: make Driver trait lifetime-parameterized
Date: Sun, 17 May 2026 02:00:59 +0200
Message-ID: <20260517000149.3226762-12-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8460055E958
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8910-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/cpufreq/rcpufreq_dt.rs       | 10 +++++-----
 drivers/gpu/drm/tyr/driver.rs        | 10 +++++-----
 drivers/pwm/pwm_th1520.rs            | 10 +++++-----
 rust/kernel/cpufreq.rs               | 10 +++++-----
 rust/kernel/io/mem.rs                | 20 ++++++++++----------
 rust/kernel/platform.rs              | 26 +++++++++++++-------------
 samples/rust/rust_debugfs.rs         | 10 +++++-----
 samples/rust/rust_driver_platform.rs | 10 +++++-----
 samples/rust/rust_i2c_client.rs      | 15 +++++++++------
 samples/rust/rust_soc.rs             | 10 +++++-----
 10 files changed, 67 insertions(+), 64 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index b7eeb2730eb0..bd64586ceb06 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -201,13 +201,13 @@ fn register_em(policy: &mut cpufreq::Policy) {
 
 impl platform::Driver for CPUFreqDTDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
-    fn probe(
-        pdev: &platform::Device<Core>,
-        _id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound platform::Device<Core>,
+        _id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(pdev.as_ref())?;
         Ok(Self {})
     }
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c81bf217743d..3ac3b9979264 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -91,13 +91,13 @@ fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
 
 impl platform::Driver for TyrPlatformDriverData {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
-    fn probe(
-        pdev: &platform::Device<Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound platform::Device<Core>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
         let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c"stacks"))?;
         let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c"coregroup"))?;
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 07795910a0b5..1abf580653fa 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -316,13 +316,13 @@ fn drop(self: Pin<&mut Self>) {
 
 impl platform::Driver for Th1520PwmPlatformDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
-    fn probe(
-        pdev: &platform::Device<Core>,
-        _id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound platform::Device<Core>,
+        _id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev = pdev.as_ref();
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 50dd2a2c3e81..208c055a39f3 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -888,13 +888,13 @@ fn register_em(_policy: &mut Policy) {
 ///
 /// impl platform::Driver for SampleDriver {
 ///     type IdInfo = ();
-///     type Data = Self;
+///     type Data<'bound> = Self;
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
 ///
-///     fn probe(
-///         pdev: &platform::Device<Core>,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self, Error> {
+///     fn probe<'bound>(
+///         pdev: &'bound platform::Device<Core>,
+///         _id_info: Option<&'bound Self::IdInfo>,
+///     ) -> impl PinInit<Self, Error> + 'bound {
 ///         cpufreq::Registration::<SampleDriver>::new_foreign_owned(pdev.as_ref())?;
 ///         Ok(Self {})
 ///     }
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index e136b676d372..1b34f7ebd929 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -62,12 +62,12 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     ///
     /// impl platform::Driver for SampleDriver {
     ///    # type IdInfo = ();
-    ///    # type Data = Self;
+    ///    # type Data<'bound> = Self;
     ///
-    ///    fn probe(
-    ///       pdev: &platform::Device<Core>,
-    ///       info: Option<&Self::IdInfo>,
-    ///    ) -> impl PinInit<Self, Error> {
+    ///    fn probe<'bound>(
+    ///       pdev: &'bound platform::Device<Core>,
+    ///       info: Option<&'bound Self::IdInfo>,
+    ///    ) -> impl PinInit<Self, Error> + 'bound {
     ///       let offset = 0; // Some offset.
     ///
     ///       // If the size is known at compile time, use [`Self::iomap_sized`].
@@ -127,12 +127,12 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     ///
     /// impl platform::Driver for SampleDriver {
     ///    # type IdInfo = ();
-    ///    # type Data = Self;
+    ///    # type Data<'bound> = Self;
     ///
-    ///    fn probe(
-    ///       pdev: &platform::Device<Core>,
-    ///       info: Option<&Self::IdInfo>,
-    ///    ) -> impl PinInit<Self, Error> {
+    ///    fn probe<'bound>(
+    ///       pdev: &'bound platform::Device<Core>,
+    ///       info: Option<&'bound Self::IdInfo>,
+    ///    ) -> impl PinInit<Self, Error> + 'bound {
     ///       let offset = 0; // Some offset.
     ///
     ///       // Unlike [`Self::iomap_sized`], here the size of the memory region
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index a72ad5366931..6e4437866c30 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -50,7 +50,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::platform_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -118,7 +118,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data>() };
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(pdev, data);
     }
@@ -192,14 +192,14 @@ macro_rules! module_platform_driver {
 ///
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
-///     type Data = Self;
+///     type Data<'bound> = Self;
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
-///     fn probe(
-///         _pdev: &platform::Device<Core>,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self, Error> {
+///     fn probe<'bound>(
+///         _pdev: &'bound platform::Device<Core>,
+///         _id_info: Option<&'bound Self::IdInfo>,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 /// }
@@ -214,7 +214,7 @@ pub trait Driver: Send {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data;
+    type Data<'bound>: 'bound;
 
     /// The table of OF device ids supported by the driver.
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
@@ -226,10 +226,10 @@ pub trait Driver: Send {
     ///
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
-    fn probe(
-        dev: &Device<device::Core>,
-        id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        dev: &'bound Device<device::Core>,
+        id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// Platform driver unbind.
     ///
@@ -241,7 +241,7 @@ fn probe(
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self::Data>) {
+    fn unbind<'bound>(dev: &'bound Device<device::Core>, this: Pin<&'bound Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 478c4f693deb..5f02f2ad88b6 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -117,14 +117,14 @@ fn from_str(s: &str) -> Result<Self> {
 
 impl platform::Driver for RustDebugFs {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = None;
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
-    fn probe(
-        pdev: &platform::Device<Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound platform::Device<Core>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         RustDebugFs::new(pdev).pin_chain(|this| {
             this.counter.store(91, Relaxed);
             {
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 6505902f8200..0760d60b7737 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -101,14 +101,14 @@ struct SampleDriver {
 
 impl platform::Driver for SampleDriver {
     type IdInfo = Info;
-    type Data = Self;
+    type Data<'bound> = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
-    fn probe(
-        pdev: &platform::Device<Core>,
-        info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound platform::Device<Core>,
+        info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev = pdev.as_ref();
 
         dev_dbg!(dev, "Probe Rust Platform driver sample.\n");
diff --git a/samples/rust/rust_i2c_client.rs b/samples/rust/rust_i2c_client.rs
index 5956b647294d..3ac4008a2eaa 100644
--- a/samples/rust/rust_i2c_client.rs
+++ b/samples/rust/rust_i2c_client.rs
@@ -106,14 +106,14 @@ struct SampleDriver {
 
 impl platform::Driver for SampleDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
-    fn probe(
-        pdev: &platform::Device<device::Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound platform::Device<device::Core>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         dev_info!(
             pdev.as_ref(),
             "Probe Rust I2C Client registration sample.\n"
@@ -130,7 +130,10 @@ fn probe(
         })
     }
 
-    fn unbind(pdev: &platform::Device<device::Core>, _this: Pin<&Self>) {
+    fn unbind<'bound>(
+        pdev: &'bound platform::Device<device::Core>,
+        _this: Pin<&'bound Self::Data<'bound>>,
+    ) {
         dev_info!(
             pdev.as_ref(),
             "Unbind Rust I2C Client registration sample.\n"
diff --git a/samples/rust/rust_soc.rs b/samples/rust/rust_soc.rs
index a5e72582f4a2..2dfcb2131e25 100644
--- a/samples/rust/rust_soc.rs
+++ b/samples/rust/rust_soc.rs
@@ -37,14 +37,14 @@ struct SampleSocDriver {
 
 impl platform::Driver for SampleSocDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 
-    fn probe(
-        pdev: &platform::Device<Core>,
-        _info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound platform::Device<Core>,
+        _info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         dev_dbg!(pdev, "Probe Rust SoC driver sample.\n");
 
         let pdev = pdev.into();
-- 
2.54.0


