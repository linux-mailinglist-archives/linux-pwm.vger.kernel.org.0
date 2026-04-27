Return-Path: <linux-pwm+bounces-8721-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFZmDxXh72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8721-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:20:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F09247B56F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F6BF303AAAD
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FDF3B2FEF;
	Mon, 27 Apr 2026 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHfZXwja"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD143ACA6A;
	Mon, 27 Apr 2026 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328042; cv=none; b=S7rMJuuRzhyF6A/ovokfYjEw7HxZ/a7LgsV9+LmV7X2x7ztDfEHNyoK4QT4i0UXJCw1RGf2d5rbdLUsyX/DqFftNyeeIOFWp9k3d2PgdYioPr5NMhhYpRT8WjwpW2BNgLHeki/IboJ68GrhbPZ+RJjpM8AnHu3c4lHSSBRVdji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328042; c=relaxed/simple;
	bh=XnijSudcWQAapd0374W3K9ATDhBTvKUTXq++FwUr1Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1+JxrpBhvI5BazYFjTcJaUd7H0dqJATfvP8vbjMqDJ07geADW4/1fxuNi6mx+yvt3f8o1KdK3C4VYAqmFjiHxw3zdvSBM9Ss1q52X9SHmwjiyXs5eQZzePqfoBjHtqk+07jKwuwuQyGSdPC21RaIsJoELEs3rQVrzD//2Uh80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHfZXwja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A5EC2BCC9;
	Mon, 27 Apr 2026 22:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328041;
	bh=XnijSudcWQAapd0374W3K9ATDhBTvKUTXq++FwUr1Nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHfZXwjaO1uc4MUkUeMV1jC4RFzG8CO7MSDtbI1XtbRHQrf06dyzI0i05F6kijAZq
	 Is+160jlrXVeC/mWC4Y6ZmqzWDAJ7e/tSLcZNCg20z7491thkAWCdmh4UlxA7vF9aq
	 MR3yyVEGFP+pZqJgdMWtzEffcZ5TXD0/U2jO+ytVuL4VjVkLhrZxwL2ZKzQaK1+neq
	 n97TzPwandrCKrfWwFh7oRuGcF1UCsZ/eG953w28akmWlSKWtppXh9y6m1f2pPSONB
	 FzcwKUdAUTTy+NK3WfknNrz7+rY1MvYYs8kKqL6Lck1QSy1//BSPuMPCGZ32ET2yQq
	 znbizWisG8B2w==
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
Subject: [PATCH 18/24] rust: pci: make Bar lifetime-parameterized
Date: Tue, 28 Apr 2026 00:11:16 +0200
Message-ID: <20260427221155.2144848-19-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 9F09247B56F
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8721-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Convert pci::Bar<SIZE> to pci::Bar<'a, SIZE>, storing &'a Device<Bound>
to tie the BAR mapping lifetime to the device.

iomap_region_sized() now returns Result<Bar<'a, SIZE>> directly instead
of impl PinInit<Devres<Bar<SIZE>>, Error>.

Add Bar::into_devres() to consume the bar and register it as a
device-managed resource, returning Devres<Bar<'static, SIZE>>. The
lifetime is erased to 'static because Devres guarantees the bar does not
actually outlive the device -- access is revoked on unbind.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs |  7 +++--
 rust/kernel/devres.rs           |  2 +-
 rust/kernel/pci/io.rs           | 50 ++++++++++++++++++---------------
 samples/rust/rust_driver_pci.rs |  5 ++--
 4 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 2a17fc99d9b6..149a20748e86 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -47,7 +47,7 @@ pub(crate) struct NovaCore {
 // DMA addresses. These systems should be quite rare.
 const GPU_DMA_BITS: u32 = 47;
 
-pub(crate) type Bar0 = pci::Bar<BAR0_SIZE>;
+pub(crate) type Bar0 = pci::Bar<'static, BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
@@ -93,8 +93,9 @@ fn probe(
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
index 7baabcdb1ad3..6f3c58355d10 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -305,7 +305,7 @@ pub fn device(&self) -> &Device {
     ///     pci, //
     /// };
     ///
-    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
+    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<'_, 0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
     ///
     ///     let _ = bar.read32(0x0);
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index ae78676c927f..6116c55412bc 100644
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
@@ -146,14 +145,14 @@ impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
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
-    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
+impl<'a, const SIZE: usize> Bar<'a, SIZE> {
+    pub(super) fn new(pdev: &'a Device<device::Bound>, num: u32, name: &CStr) -> Result<Self> {
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
@@ -252,17 +260,13 @@ impl Device<device::Bound> {
     pub fn iomap_region_sized<'a, const SIZE: usize>(
         &'a self,
         bar: u32,
-        name: &'a CStr,
-    ) -> impl PinInit<Devres<Bar<SIZE>>, Error> + 'a {
-        Devres::new(self.as_ref(), Bar::<SIZE>::new(self, bar, name))
+        name: &CStr,
+    ) -> Result<Bar<'a, SIZE>> {
+        Bar::new(self, bar, name)
     }
 
     /// Maps an entire PCI BAR after performing a region-request on it.
-    pub fn iomap_region<'a>(
-        &'a self,
-        bar: u32,
-        name: &'a CStr,
-    ) -> impl PinInit<Devres<Bar>, Error> + 'a {
+    pub fn iomap_region<'a>(&'a self, bar: u32, name: &CStr) -> Result<Bar<'a>> {
         self.iomap_region_sized::<0>(bar, name)
     }
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 2747beecb5fd..38d639731229 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -45,7 +45,7 @@ mod regs {
     pub(super) const END: usize = 0x10;
 }
 
-type Bar0 = pci::Bar<{ regs::END }>;
+type Bar0 = pci::Bar<'static, { regs::END }>;
 
 #[derive(Copy, Clone, Debug)]
 struct TestIndex(u8);
@@ -160,7 +160,8 @@ fn probe(
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


