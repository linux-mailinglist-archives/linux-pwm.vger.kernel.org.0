Return-Path: <linux-pwm+bounces-8923-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFgcFF0HCWprFgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8923-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:10:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9B55E9AC
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8763038F6C
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B215687D;
	Sun, 17 May 2026 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCfR4BaQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E9154425;
	Sun, 17 May 2026 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976288; cv=none; b=LWTtlgElonTmm/ucfWglNy6tlao5foCMv0RNQm8ZNvvWY7NWuUWPDOUUtk0AT1VAeZscNU8wBV9MnGEzduISsAD4p2CeASFoo16kFAWPGwbB03xwwNw50ZdAbUKy8yR9pEnRDrPAdWeNYk3h3vNPJZt6jj9W36S+h9va2faSPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976288; c=relaxed/simple;
	bh=VzhZN2bLBZmjc+UBgjV2Jy3Issf2Ch22S+Nhyhuudf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tv8GqYJ/PaiC2JSx90jfA1J3NT23tu9TcgWEcdSDHBcNkJnk1pitomwbTf0uTesgksyp1E/yl6X9Lr4L/w7uphqijYR3b0QZ3JnrXsv/mJmagOmzgRd0NfSLZ3sf1k5vyLEQe7Xv5RpcgawolrCbfG0XVEewkCNLs/CcnBks9pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCfR4BaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9610CC2BCB7;
	Sun, 17 May 2026 00:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976288;
	bh=VzhZN2bLBZmjc+UBgjV2Jy3Issf2Ch22S+Nhyhuudf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCfR4BaQBAxYF9hZUkQRGPxokfCRPhA4LZwa/IJLFrzzQllB5rdRH9zgjuRnAcJBj
	 PIaLc5ECKQJl0xnGEcHmSXBTNVZU2MgGIWFN1C1iYRujH4BydpYZigQBXXygbwo1gj
	 y0raYZJm9y+snMpZ+yJGQyJWX6G70XRhT73ez4O0AQxsQB35nikPqMxWwDO7MpcR7S
	 Y2cy46hNf21LJ5TdcJPm+AOZSt7bUBPefikTRlFgY2+vpIF3T6m81JvmV+mskgPpGe
	 LWp542JP/X0JE5WRuf/GHyKCkGx8+llHESG/8AIKH0XQyFqn30GXMS+eqr/DzPwngU
	 VTYU1rCBEZalw==
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
Subject: [PATCH REF v3 24/27] gpu: nova-core: use lifetime for Bar
Date: Sun, 17 May 2026 02:01:12 +0200
Message-ID: <20260517000149.3226762-25-dakr@kernel.org>
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
X-Rspamd-Queue-Id: B6E9B55E9AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-8923-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[self.bar:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Take advantage of the lifetime-parameterized pci::Bar<'bound> to hold
the BAR mapping directly in NovaCore<'bound>, and pass a borrowed
reference to Gpu<'bound>.

This eliminates the Arc<Devres<Bar0>> indirection, removes runtime
revocation checks for BAR access, and simplifies Gpu::unbind().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs    | 46 +++++++++++++++---------------
 drivers/gpu/nova-core/gpu.rs       | 27 +++++++-----------
 drivers/gpu/nova-core/nova_core.rs |  2 +-
 3 files changed, 34 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 3f6d8cedf5ab..fb52d21a7d92 100644
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
+pub(crate) struct NovaCore<'bound> {
     #[pin]
-    pub(crate) gpu: Gpu,
+    pub(crate) gpu: Gpu<'bound>,
+    bar: pci::Bar<'bound, BAR0_SIZE>,
     #[allow(clippy::type_complexity)]
     _reg: Devres<auxiliary::Registration<ForLt!(())>>,
 }
@@ -47,12 +45,14 @@ pub(crate) struct NovaCore {
 // DMA addresses. These systems should be quite rare.
 const GPU_DMA_BITS: u32 = 47;
 
-pub(crate) type Bar0 = pci::Bar<'static, BAR0_SIZE>;
+pub(crate) type Bar0 = kernel::io::Mmio<BAR0_SIZE>;
+
+pub(crate) struct NovaCoreDriver;
 
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <NovaCore as pci::Driver>::IdInfo,
+    <NovaCoreDriver as pci::Driver>::IdInfo,
     [
         // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
         (
@@ -74,15 +74,15 @@ pub(crate) struct NovaCore {
     ]
 );
 
-impl pci::Driver for NovaCore {
+impl pci::Driver for NovaCoreDriver {
     type IdInfo = ();
-    type Data<'bound> = Self;
+    type Data<'bound> = NovaCore<'bound>;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core>,
         _info: &'bound Self::IdInfo,
-    ) -> impl PinInit<Self, Error> + 'bound {
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
@@ -94,14 +94,14 @@ fn probe<'bound>(
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
@@ -115,7 +115,7 @@ fn probe<'bound>(
         })
     }
 
-    fn unbind<'bound>(pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self>) {
-        this.gpu.unbind(pdev.as_ref());
+    fn unbind<'bound>(_pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self::Data<'bound>>) {
+        this.gpu.unbind();
     }
 }
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 9288b30fe4c3..03295fa6fb32 100644
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
+pub(crate) struct Gpu<'bound> {
     spec: Spec,
-    /// MMIO mapping of PCI BAR 0
-    bar: Arc<Devres<Bar0>>,
+    /// MMIO mapping of PCI BAR 0.
+    bar: &'bound Bar0,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
     sysmem_flush: SysmemFlush,
@@ -240,10 +238,9 @@ pub(crate) struct Gpu {
     gsp: Gsp,
 }
 
-impl Gpu {
-    pub(crate) fn new<'bound>(
+impl<'bound> Gpu<'bound> {
+    pub(crate) fn new(
         pdev: &'bound pci::Device<device::Bound>,
-        devres_bar: Arc<Devres<Bar0>>,
         bar: &'bound Bar0,
     ) -> impl PinInit<Self, Error> + 'bound {
         try_pin_init!(Self {
@@ -257,6 +254,8 @@ pub(crate) fn new<'bound>(
                     .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
             },
 
+            bar,
+
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
             gsp_falcon: Falcon::new(
@@ -270,19 +269,13 @@ pub(crate) fn new<'bound>(
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
index 04a1fa6b25f8..073d87714d3a 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -47,7 +47,7 @@ struct NovaCoreModule {
     // Fields are dropped in declaration order, so `_driver` is dropped first,
     // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
     #[pin]
-    _driver: Registration<pci::Adapter<driver::NovaCore>>,
+    _driver: Registration<pci::Adapter<driver::NovaCoreDriver>>,
     _debugfs_guard: DebugfsRootGuard,
 }
 
-- 
2.54.0


