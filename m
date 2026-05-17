Return-Path: <linux-pwm+bounces-8918-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFuwGJ8GCWouFgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8918-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:06:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B5455E8E9
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B98093059F88
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C431DED42;
	Sun, 17 May 2026 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu1KYDzk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F01AF4E9;
	Sun, 17 May 2026 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976254; cv=none; b=AGCSJmYt72VWGgOnS3/kUHpPtFoqO6uPLU5HBgAFxgIzjhm+FAwsi9DGt14p2bhimfQRmzcGba2ZMo2fuUBQU9qA8bfDm0U1UYHB8vo4mYSkxDyqkHqY+tEAmAaXNqhNrp6wu5x2WNR+RaLlw7cS7iZavo3BcZfugZyu5AUZJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976254; c=relaxed/simple;
	bh=V4ysUwXqYUUQahvzl2kBIE68tvSoqAZ4h4kj1Ub53Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdzbPXRq+rKPXswORMpxncSxiEAvHBgapZBJG3TC6SdvqojRzPBc2QrP6sR/RNqOYwkAqV/Cmo57Oz3HMoSi0kAUmZ658XLQr2zjjhUKsXBOMCB/1ZzMYEYJOnnsuKoW0o/dHmxXwB+27E2eGQc2btXqKwIOSQLrpXvWpX/IUVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu1KYDzk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FA5C2BCFB;
	Sun, 17 May 2026 00:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976254;
	bh=V4ysUwXqYUUQahvzl2kBIE68tvSoqAZ4h4kj1Ub53Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mu1KYDzky9E695nAl2nWxPbImGq3//80quu9/4IvlrCQn87wwIjH9vFDNIcT+70t+
	 0+fd45w50OWV1Im9oewctp1AbnpkOFRWBi2JN4TrvFyI11PBMHpcp7K3wndwDygQJ2
	 Ts9j9xBhmqf8hd1/mmtJezDQ6GQTFxBBHeiVJG1isA7ZdXe4MYqv4scyWtNdW9T9KT
	 NX0PnDD0s2kWJT3VVsxA5DpCd+SfRYcPnCtW25ZbXuD5ru4Jxvai+80Ej1hl5EQDqs
	 RGsaBhLjyxbdFMNZcQ9WL1leAwE5MINz92mAvhrwbdFBLWqZ5iAQEXmkQMyTqUkgTp
	 GvuKocvNTr29Q==
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
Subject: [PATCH v3 19/27] rust: pci: make Bar lifetime-parameterized
Date: Sun, 17 May 2026 02:01:07 +0200
Message-ID: <20260517000149.3226762-20-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 16B5455E8E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-8918-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert pci::Bar<SIZE> to pci::Bar<'bound, SIZE>, storing &'bound
Device<Bound> to tie the BAR mapping lifetime to the device.

iomap_region_sized() now returns Result<Bar<'bound, SIZE>> directly instead
of impl PinInit<Devres<Bar<SIZE>>, Error>.

Add Bar::into_devres() to consume the bar and register it as a
device-managed resource, returning Devres<Bar<'static, SIZE>>. The
lifetime is erased to 'static because Devres guarantees the bar does not
actually outlive the device -- access is revoked on unbind.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs |  7 ++--
 rust/kernel/devres.rs           |  2 +-
 rust/kernel/pci/io.rs           | 68 +++++++++++++++++----------------
 samples/rust/rust_driver_pci.rs |  5 ++-
 4 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index ab0d7f2b516c..3f6d8cedf5ab 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -47,7 +47,7 @@ pub(crate) struct NovaCore {
 // DMA addresses. These systems should be quite rare.
 const GPU_DMA_BITS: u32 = 47;
 
-pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
+pub(crate) type Bar0 = pci::Bar<'static, BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
@@ -94,8 +94,9 @@ fn probe<'bound>(
             // other threads of execution.
             unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<GPU_DMA_BITS>())? };
 
-            let bar = Arc::pin_init(
-                pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0"),
+            let bar = Arc::new(
+                pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?
+                    .into_devres()?,
                 GFP_KERNEL,
             )?;
 
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e5f93aed20c..ec63317665f4 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -304,7 +304,7 @@ pub fn device(&self) -> &Device {
     ///     pci, //
     /// };
     ///
-    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
+    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<'_, 0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
     ///
     ///     let _ = bar.read32(0x0);
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index ae78676c927f..5668394a155b 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -14,8 +14,7 @@
         Mmio,
         MmioRaw, //
     },
-    prelude::*,
-    sync::aref::ARef, //
+    prelude::*, //
 };
 use core::{
     marker::PhantomData,
@@ -78,15 +77,15 @@ impl ConfigSpaceKind for Extended {
 /// The generic parameter `S` indicates the maximum size of the configuration space.
 /// Use [`Normal`] for 256-byte legacy configuration space or [`Extended`] for
 /// 4096-byte PCIe extended configuration space (default).
-pub struct ConfigSpace<'a, S: ConfigSpaceKind = Extended> {
-    pub(crate) pdev: &'a Device<device::Bound>,
+pub struct ConfigSpace<'bound, S: ConfigSpaceKind = Extended> {
+    pub(crate) pdev: &'bound Device<device::Bound>,
     _marker: PhantomData<S>,
 }
 
 /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_config_space_io_capable {
     ($ty:ty, $read_fn:ident, $write_fn:ident) => {
-        impl<'a, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'a, S> {
+        impl<'bound, S: ConfigSpaceKind> IoCapable<$ty> for ConfigSpace<'bound, S> {
             unsafe fn io_read(&self, address: usize) -> $ty {
                 let mut val: $ty = 0;
 
@@ -119,7 +118,7 @@ unsafe fn io_write(&self, value: $ty, address: usize) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
+impl<'bound, S: ConfigSpaceKind> Io for ConfigSpace<'bound, S> {
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(&self) -> usize {
@@ -133,7 +132,7 @@ fn maxsize(&self) -> usize {
     }
 }
 
-impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
+impl<'bound, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'bound, S> {
     const MIN_SIZE: usize = S::SIZE;
 }
 
@@ -146,14 +145,14 @@ impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
 ///
 /// `Bar` always holds an `IoRaw` instance that holds a valid pointer to the start of the I/O
 /// memory mapped PCI BAR and its size.
-pub struct Bar<const SIZE: usize = 0> {
-    pdev: ARef<Device>,
+pub struct Bar<'bound, const SIZE: usize = 0> {
+    pdev: &'bound Device<device::Bound>,
     io: MmioRaw<SIZE>,
     num: i32,
 }
 
-impl<const SIZE: usize> Bar<SIZE> {
-    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
+impl<'bound, const SIZE: usize> Bar<'bound, SIZE> {
+    pub(super) fn new(pdev: &'bound Device<device::Bound>, num: u32, name: &CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
         if len == 0 {
             return Err(ENOMEM);
@@ -196,11 +195,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
             }
         };
 
-        Ok(Bar {
-            pdev: pdev.into(),
-            io,
-            num,
-        })
+        Ok(Bar { pdev, io, num })
     }
 
     /// # Safety
@@ -219,11 +214,24 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
 
     fn release(&self) {
         // SAFETY: The safety requirements are guaranteed by the type invariant of `self.pdev`.
-        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) };
+        unsafe { Self::do_release(self.pdev, self.io.addr(), self.num) };
+    }
+
+    /// Consume the `Bar` and register it as a device-managed resource.
+    ///
+    /// The returned `Devres<Bar<'static, SIZE>>` can outlive the original lifetime `'bound`. Access
+    /// to the BAR is revoked when the device is unbound.
+    pub fn into_devres(self) -> Result<Devres<Bar<'static, SIZE>>> {
+        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the `Bar` does not
+        // actually outlive the device -- access is revoked and the resource is released when the
+        // device is unbound.
+        let bar: Bar<'static, SIZE> = unsafe { core::mem::transmute(self) };
+        let pdev = bar.pdev;
+        Devres::new(pdev.as_ref(), bar)
     }
 }
 
-impl Bar {
+impl Bar<'_> {
     #[inline]
     pub(super) fn index_is_valid(index: u32) -> bool {
         // A `struct pci_dev` owns an array of resources with at most `PCI_NUM_RESOURCES` entries.
@@ -231,13 +239,13 @@ pub(super) fn index_is_valid(index: u32) -> bool {
     }
 }
 
-impl<const SIZE: usize> Drop for Bar<SIZE> {
+impl<const SIZE: usize> Drop for Bar<'_, SIZE> {
     fn drop(&mut self) {
         self.release();
     }
 }
 
-impl<const SIZE: usize> Deref for Bar<SIZE> {
+impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
     type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
@@ -249,20 +257,16 @@ fn deref(&self) -> &Self::Target {
 impl Device<device::Bound> {
     /// Maps an entire PCI BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
-    pub fn iomap_region_sized<'a, const SIZE: usize>(
-        &'a self,
+    pub fn iomap_region_sized<'bound, const SIZE: usize>(
+        &'bound self,
         bar: u32,
-        name: &'a CStr,
-    ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
-        Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
+        name: &CStr,
+    ) -> Result<Bar<'bound, SIZE>> {
+        Bar::new(self, bar, name)
     }
 
     /// Maps an entire PCI BAR after performing a region-request on it.
-    pub fn iomap_region<'a>(
-        &'a self,
-        bar: u32,
-        name: &'a CStr,
-    ) -> impl PinInit<Devres<Bar>, Error> + 'a {
+    pub fn iomap_region<'bound>(&'bound self, bar: u32, name: &CStr) -> Result<Bar<'bound>> {
         self.iomap_region_sized::<0>(bar, name)
     }
 
@@ -282,7 +286,7 @@ pub fn cfg_size(&self) -> ConfigSpaceSize {
     }
 
     /// Return an initialized normal (256-byte) config space object.
-    pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
+    pub fn config_space<'bound>(&'bound self) -> ConfigSpace<'bound, Normal> {
         ConfigSpace {
             pdev: self,
             _marker: PhantomData,
@@ -290,7 +294,7 @@ pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
     }
 
     /// Return an initialized extended (4096-byte) config space object.
-    pub fn config_space_extended<'a>(&'a self) -> Result<ConfigSpace<'a, Extended>> {
+    pub fn config_space_extended<'bound>(&'bound self) -> Result<ConfigSpace<'bound, Extended>> {
         if self.cfg_size() != ConfigSpaceSize::Extended {
             return Err(EINVAL);
         }
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 30b9311812f3..7791363df0a0 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -45,7 +45,7 @@ mod regs {
     pub(super) const END: usize = 0x10;
 }
 
-type Bar0 = pci::Bar<{ regs::END }>;
+type Bar0 = pci::Bar<'static, { regs::END }>;
 
 #[derive(Copy, Clone, Debug)]
 struct TestIndex(u8);
@@ -161,7 +161,8 @@ fn probe<'bound>(
             pdev.set_master();
 
             Ok(try_pin_init!(Self {
-                bar <- pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_pci"),
+                bar: pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_pci")?
+                    .into_devres()?,
                 index: *info,
                 _: {
                     let bar = bar.access(pdev.as_ref())?;
-- 
2.54.0


