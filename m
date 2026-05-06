Return-Path: <linux-pwm+bounces-8816-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBipGAK5+2kiEAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8816-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:56:18 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2994E0E90
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE605302A056
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421123B52E9;
	Wed,  6 May 2026 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccn5zjyH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CE3B3C1D;
	Wed,  6 May 2026 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104430; cv=none; b=H9nsMlScHJOIpAt+fQZAuVJYyyet9kcSjuHpIHVDwO3OwIOr98M+Ohqc7/BXPHvMpYNGgT0xkheMIgZZkzEHLZpTawMvT5xRChf/827321JxMn7XtnVbGnvpZLgxIDmSG6WwI1ZrZm3SaKfUj5BnhrGCGTZbR1nvCanDYVA0/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104430; c=relaxed/simple;
	bh=g2KiL/CMPCnweI4E7xuxmAbnHThqGiuaJZ5Xgj96eoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiQeUpYngl1awoA7nw0+XaPFNjW7vRVZ0noULs9gf++7srvnUZ1FE18Fex3a3xTDdplJmv3W6AdTD8BYaU1XW1AZwjsWUqiqvPirc3CoQZRqmqP7vDt2mAe148a/HrUmDU0FurXc9MfuMpmqeBOeHVZ3+szu3q/2gCqU3VhYokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccn5zjyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CFFC2BCB0;
	Wed,  6 May 2026 21:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104429;
	bh=g2KiL/CMPCnweI4E7xuxmAbnHThqGiuaJZ5Xgj96eoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ccn5zjyHSwiiC5I5sDThi8TB9aiUc88iMMoHEE04BAyedJ0wJ8vo7wBJILTfOkTaW
	 hbq566Ll9IWHtbvBmjHyQ2EM1s57FqAs9pt5KjrPi4AOqKyXyS4Ezswrem+ye+NoUw
	 AC35F9Qigy6HZiOXGpu9zP1vR6FNK0P9MaQ+73wjk9mTONmK28JKU6awmhBZvbM7h5
	 HBxJ/CbCJuy7fiL7BKBIxcYKdaLPz3ekhmKy9AC7TfuBYWjtqDNpLTqkkUNfFpItjZ
	 Ez55jCG215SEPaCplJ6GerZ1A6e05do4aai6jt9Xt0qJQZ6XQc+FjSIyCkDucsPv80
	 afq4HWEkZo80w==
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
	daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 22/25] gpu: nova-core: use HRT lifetime for Bar
Date: Wed,  6 May 2026 23:50:58 +0200
Message-ID: <20260506215113.851360-23-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B2994E0E90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-8816-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,self.bar:url]
X-Rspamd-Action: no action

Take advantage of the lifetime-parameterized pci::Bar<'bound> to hold
the BAR mapping directly in NovaCore<'bound>, and pass a borrowed
reference to Gpu<'bound>.

This eliminates the Arc<Devres<Bar0>> indirection, removes runtime
revocation checks for BAR access, and simplifies Gpu::unbind().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs    | 40 ++++++++++++++----------------
 drivers/gpu/nova-core/gpu.rs       | 27 ++++++++------------
 drivers/gpu/nova-core/nova_core.rs |  2 +-
 3 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 6ee2021ef56e..11b632ae3789 100644
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
 
-impl<'bound> pci::Driver<'bound> for NovaCore {
+impl<'bound> pci::Driver<'bound> for NovaCore<'bound> {
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
+    fn unbind(_pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self>) {
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


