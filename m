Return-Path: <linux-pwm+bounces-8724-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJmxLhPj72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8724-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:28:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC5B47B711
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAE5130CE321
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FDE3B0AC2;
	Mon, 27 Apr 2026 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W75RH2Y9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDDE3AD528;
	Mon, 27 Apr 2026 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328061; cv=none; b=IJKy0C9T/8i4UCmnXqSbI9bRY27h+WvjHLHgNbnfqDgnRION4TtvW4ztTGzMqKybWaNXnrFjyZ6vxvIs4W+L5FniK+Y23CvF7wrlOuiquB2kQUHXUrnDQPZz+KGiE5ZcPSTj8nixD+AR1g9R2kDQa/nXsF+K6J6O/yJezOg21Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328061; c=relaxed/simple;
	bh=+vCZJoneZObXHz+HrSLsZDDMk+BGXI4VJJ4WNODomsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOLQswjRkWU25KCwDxL1ie0+sm2zcfLl8KVLwV0mAuk7a8dR5LFePXjk4u7niBd/pPw/6RNp5edDnEDbyg+aBIXIv9VBd5fA6x1sobmLqvs4LJ9WmGYFJTfYAXGVoOFKagxTdMAUbq+8yXH0sn1+99FlLA5qudp6pM4J8/PDs10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W75RH2Y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C523EC19425;
	Mon, 27 Apr 2026 22:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328060;
	bh=+vCZJoneZObXHz+HrSLsZDDMk+BGXI4VJJ4WNODomsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W75RH2Y9F/+siwPQ1JHURZcogobZ9/VrlGLtxYgFA1gLCsqjOxrPQg1XKsISLV87C
	 fQsa1U+tA3GM6aDw9oqcXpq5cLE+zLKREDMDG8R4OU9DliimeWPWQlG3kyJA7b5S7z
	 ooGGLlzy1lXyPGwJ5q3stU6oLo6vInOjyWIa6D2C/FoLh6wMzJiRKEiVCBmR3IQgKe
	 K7BFdXEiftt7WobIFyHxAHliiFeowDzCMDGRqPmLbKKR/m4a1yUzwHJVmPydCDKmIG
	 yGznAjvJr6qehxk0Y5WUo7FrhKCcPUS5wIOfw08fSkAlbj9rXqvhoP1GC5FQqwFXIw
	 pUy8/Ka1tYgpA==
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
Subject: [PATCH REF 21/24] gpu: nova-core: use HRT lifetime for Bar
Date: Tue, 28 Apr 2026 00:11:19 +0200
Message-ID: <20260427221155.2144848-22-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 1DC5B47B711
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [10.34 / 15.00];
	URIBL_BLACK(7.50)[self.bar:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8724-lists,linux-pwm=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.668];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[self.bar:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Spam: Yes

Take advantage of the lifetime-parameterized pci::Bar<'a> to hold the
BAR mapping directly in NovaCore<'a>, and pass a borrowed reference to
Gpu<'a>.

This eliminates the Arc<Devres<Bar0>> indirection, removes runtime
revocation checks for BAR access, and simplifies Gpu::unbind().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs    | 40 ++++++++++++++----------------
 drivers/gpu/nova-core/gpu.rs       | 27 ++++++++------------
 drivers/gpu/nova-core/nova_core.rs |  2 +-
 3 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 149a20748e86..ec9cecb30f63 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -14,12 +14,9 @@
     },
     prelude::*,
     sizes::SZ_16M,
-    sync::{
-        atomic::{
-            Atomic,
-            Relaxed, //
-        },
-        Arc,
+    sync::atomic::{
+        Atomic,
+        Relaxed, //
     },
     types::ForLt,
 };
@@ -30,9 +27,10 @@
 static AUXILIARY_ID_COUNTER: Atomic<u32> = Atomic::new(0);
 
 #[pin_data]
-pub(crate) struct NovaCore {
+pub(crate) struct NovaCore<'a> {
     #[pin]
-    pub(crate) gpu: Gpu,
+    pub(crate) gpu: Gpu<'a>,
+    bar: pci::Bar<'a, BAR0_SIZE>,
     #[allow(clippy::type_complexity)]
     _reg: Devres<auxiliary::Registration<ForLt!(())>>,
 }
@@ -47,12 +45,12 @@ pub(crate) struct NovaCore {
 // DMA addresses. These systems should be quite rare.
 const GPU_DMA_BITS: u32 = 47;
 
-pub(crate) type Bar0 = pci::Bar<'static, BAR0_SIZE>;
+pub(crate) type Bar0 = kernel::io::Mmio<BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <NovaCore as pci::Driver<'_>>::IdInfo,
+    <NovaCore<'_> as pci::Driver<'_>>::IdInfo,
     [
         // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
         (
@@ -74,7 +72,7 @@ pub(crate) struct NovaCore {
     ]
 );
 
-impl<'a> pci::Driver<'a> for NovaCore {
+impl<'a> pci::Driver<'a> for NovaCore<'a> {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
@@ -93,14 +91,14 @@ fn probe(
             // other threads of execution.
             unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<GPU_DMA_BITS>())? };
 
-            let bar = Arc::new(
-                pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?
-                    .into_devres()?,
-                GFP_KERNEL,
-            )?;
-
-            Ok(try_pin_init!(Self {
-                gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_ref())?),
+            Ok(try_pin_init!(NovaCore {
+                bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?,
+                // TODO: Use `&bar` self-referential pin-init syntax once available.
+                //
+                // SAFETY: `bar` is initialized before this expression is evaluated
+                // (`try_pin_init!()` initializes fields in declaration order), lives at a pinned
+                // stable address, and is dropped after `gpu` (struct field drop order).
+                gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar) }),
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
@@ -114,7 +112,7 @@ fn probe(
         })
     }
 
-    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
-        this.gpu.unbind(pdev.as_ref());
+    fn unbind(_pdev: &'a pci::Device<Core>, this: Pin<&'a Self>) {
+        this.gpu.unbind();
     }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 0f6fe9a1b955..922197f2aeef 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -2,13 +2,11 @@
 
 use kernel::{
     device,
-    devres::Devres,
     fmt,
     io::Io,
     num::Bounded,
     pci,
-    prelude::*,
-    sync::Arc, //
+    prelude::*, //
 };
 
 use crate::{
@@ -224,10 +222,10 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 
 /// Structure holding the resources required to operate the GPU.
 #[pin_data]
-pub(crate) struct Gpu {
+pub(crate) struct Gpu<'a> {
     spec: Spec,
-    /// MMIO mapping of PCI BAR 0
-    bar: Arc<Devres<Bar0>>,
+    /// MMIO mapping of PCI BAR 0.
+    bar: &'a Bar0,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
     sysmem_flush: SysmemFlush,
@@ -240,10 +238,9 @@ pub(crate) struct Gpu {
     gsp: Gsp,
 }
 
-impl Gpu {
-    pub(crate) fn new<'a>(
+impl<'a> Gpu<'a> {
+    pub(crate) fn new(
         pdev: &'a pci::Device<device::Bound>,
-        devres_bar: Arc<Devres<Bar0>>,
         bar: &'a Bar0,
     ) -> impl PinInit<Self, Error> + 'a {
         try_pin_init!(Self {
@@ -257,6 +254,8 @@ pub(crate) fn new<'a>(
                     .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
             },
 
+            bar,
+
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
             gsp_falcon: Falcon::new(
@@ -270,19 +269,13 @@ pub(crate) fn new<'a>(
             gsp <- Gsp::new(pdev),
 
             _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
-
-            bar: devres_bar,
         })
     }
 
     /// Called when the corresponding [`Device`](device::Device) is unbound.
     ///
     /// Note: This method must only be called from `Driver::unbind`.
-    pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
-        kernel::warn_on!(self
-            .bar
-            .access(dev)
-            .inspect(|bar| self.sysmem_flush.unregister(bar))
-            .is_err());
+    pub(crate) fn unbind(&self) {
+        self.sysmem_flush.unregister(self.bar);
     }
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 49c093a0cb42..ed5eb39c8201 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -49,7 +49,7 @@ struct NovaCoreModule {
     // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
     #[allow(clippy::type_complexity)]
     #[pin]
-    _driver: Registration<pci::Adapter<ForLt!(driver::NovaCore)>>,
+    _driver: Registration<pci::Adapter<ForLt!(driver::NovaCore<'_>)>>,
     _debugfs_guard: DebugfsRootGuard,
 }
 
-- 
2.54.0


