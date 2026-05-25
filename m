Return-Path: <linux-pwm+bounces-9144-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNSABY6zFGoHPgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9144-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:39:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 848275CEA1D
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 674353049E11
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1C239A4B9;
	Mon, 25 May 2026 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2wxHi3t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E921346781;
	Mon, 25 May 2026 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741101; cv=none; b=fa73tLHSHR8ocGlPejHB2QEbvKDOJP6e+p87jW9qQWLi4m3wcSVzZrq9zNglG3nP6u5ImCMqLoOjqp/OYocKvxL0qdsVj339jiYW22tN3V+HELhNjzoqgfiV+5gAkID1c7gHjgP7kAgSUXK3Doe7w3nqK2qHxM50QP/7dint3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741101; c=relaxed/simple;
	bh=YgjMVlOnOEnOgJfSzyZZhjx0/WQEcOL7rF0Q96bVxhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/D7gPNMJPb8EvWZSAeAai54se3jSER3bxwZhJ/QcxjVnpzLOm5fG1ggMp6yv2VuE1paeatYanUFLpCLZ3eD5BqiWULaDFN5+/qkzla/7WRVAE2Do4rDHgNWtAOlvrn3eRCYOJIJO+M8FENsaMRF6FYso7K5XQi0gCBs0NaXrWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2wxHi3t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0A81F000E9;
	Mon, 25 May 2026 20:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741100;
	bh=pYMsChqTO3W2bfJZCzKzWuNhJ1vdYr5kTucdQkADqYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h2wxHi3tukLONpF+s+2OoV+pnqU1G1hB6dQ3C+rU/zsZL3MzhaSOVz8Sb6t60Vk0h
	 CaoAFPGpeA3h254wEBydvZnrkgINEoOXNeaNa4vxRnTnqtGOCFCwnbXB/cfIxhKd6j
	 hLoUnCWUjfN1Re3fRJfIiRTaz/+BrHV4/a/FBcVwAYseWRhCR39iq9Vb1t3tcl1qow
	 WDBTO1j48ySGQi81ejGW0XLzqaNCY1ZSgQKU9j3DvfP01O1fvUvYAPlNzT6RjZOvNs
	 bD9vkFDF3Uc7Jx9RhZ8a0rWguuNDkNWwFlhL0Rsr/7xuKWUkEGJXQmfHGgDGltGrzi
	 +asZ9+R3Iyn2Q==
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
Subject: [PATCH v5 18/24] rust: pci: make Bar lifetime-parameterized
Date: Mon, 25 May 2026 22:21:05 +0200
Message-ID: <20260525202921.124698-19-dakr@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9144-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 848275CEA1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert pci::Bar<SIZE> to pci::Bar<'a, SIZE>, storing &'a Device<Bound>
to tie the BAR mapping lifetime to the device.

iomap_region_sized() now returns Result<Bar<'a, SIZE>> directly instead
of impl PinInit<Devres<Bar<SIZE>>, Error>.

Since the lifetime ties the mapping to the device's bound state, callers
no longer need Devres for the common case where the Bar lives in the
driver's private data.

Add Bar::into_devres() to consume the bar and register it as a
device-managed resource, returning Devres<Bar<'static, SIZE>>. The
lifetime is erased to 'static because Devres guarantees the bar does not
actually outlive the device -- access is revoked on unbind.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs |  7 +++--
 rust/kernel/devres.rs           |  2 +-
 rust/kernel/pci/io.rs           | 52 +++++++++++++++++++--------------
 samples/rust/rust_driver_pci.rs |  5 ++--
 4 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 6ad1a856694c..7dbec0470c26 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -45,7 +45,7 @@ pub(crate) struct NovaCore {
 // DMA addresses. These systems should be quite rare.
 const GPU_DMA_BITS: u32 = 47;
 
-pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
+pub(crate) type Bar0 = pci::Bar<'static, BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
@@ -92,8 +92,9 @@ fn probe<'bound>(
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
index fd4633f977f6..82cbd8b969fb 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -304,7 +304,7 @@ pub fn device(&self) -> &Device {
     ///     pci, //
     /// };
     ///
-    /// fn from_core(dev: &pci::Device<Core<'_>>, devres: Devres<pci::Bar<0x4>>) -> Result {
+    /// fn from_core(dev: &pci::Device<Core<'_>>, devres: Devres<pci::Bar<'_, 0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
     ///
     ///     let _ = bar.read32(0x0);
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 3ce21482b079..0461e01aaa20 100644
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
@@ -146,14 +145,18 @@ impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
 ///
 /// `Bar` always holds an `IoRaw` instance that holds a valid pointer to the start of the I/O
 /// memory mapped PCI BAR and its size.
-pub struct Bar<const SIZE: usize = 0> {
-    pdev: ARef<Device>,
+pub struct Bar<'a, const SIZE: usize = 0> {
+    pdev: &'a Device<device::Bound>,
     io: MmioRaw<SIZE>,
     num: i32,
 }
 
-impl<const SIZE: usize> Bar<SIZE> {
-    pub(super) fn new(pdev: &Device, num: u32, name: &'static CStr) -> Result<Self> {
+impl<'a, const SIZE: usize> Bar<'a, SIZE> {
+    pub(super) fn new(
+        pdev: &'a Device<device::Bound>,
+        num: u32,
+        name: &'static CStr,
+    ) -> Result<Self> {
         let len = pdev.resource_len(num)?;
         if len == 0 {
             return Err(ENOMEM);
@@ -196,11 +199,7 @@ pub(super) fn new(pdev: &Device, num: u32, name: &'static CStr) -> Result<Self>
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
@@ -219,11 +218,24 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num: i32) {
 
     fn release(&self) {
         // SAFETY: The safety requirements are guaranteed by the type invariant of `self.pdev`.
-        unsafe { Self::do_release(&self.pdev, self.io.addr(), self.num) };
+        unsafe { Self::do_release(self.pdev, self.io.addr(), self.num) };
+    }
+
+    /// Consume the `Bar` and register it as a device-managed resource.
+    ///
+    /// The returned `Devres<Bar<'static, SIZE>>` can outlive the original lifetime `'a`. Access
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
@@ -231,13 +243,13 @@ pub(super) fn index_is_valid(index: u32) -> bool {
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
@@ -253,16 +265,12 @@ pub fn iomap_region_sized<'a, const SIZE: usize>(
         &'a self,
         bar: u32,
         name: &'static CStr,
-    ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
-        Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
+    ) -> Result<Bar<'a, SIZE>> {
+        Bar::new(self, bar, name)
     }
 
     /// Maps an entire PCI BAR after performing a region-request on it.
-    pub fn iomap_region<'a>(
-        &'a self,
-        bar: u32,
-        name: &'static CStr,
-    ) -> impl PinInit<Devres<Bar>, Error> + 'a {
+    pub fn iomap_region<'a>(&'a self, bar: u32, name: &'static CStr) -> Result<Bar<'a>> {
         self.iomap_region_sized::<0>(bar, name)
     }
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 6791d98e1c79..0353481b0690 100644
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


