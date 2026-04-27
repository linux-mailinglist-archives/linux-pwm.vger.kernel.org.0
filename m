Return-Path: <linux-pwm+bounces-8727-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAJNKofh72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8727-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:21:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C905747B5EE
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE87630518BA
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7CA3B27F4;
	Mon, 27 Apr 2026 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6W4oeKO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376BD3ACA51;
	Mon, 27 Apr 2026 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328080; cv=none; b=ZkkbS2KDorAtzqLFmTeutEzLbFAEEmz+xrnmddOMMY7pyc7dJIfcEZ1aKKeISH1vGEipMB3z9OiLGpShe8iibtEYg4NQeFNuan3DCJBrPFhVMn2338Gn//Hi66A0XBysRKyghAiNgLfXoYOoI1O9xHmvpciXSEWVZmoQjGSMT1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328080; c=relaxed/simple;
	bh=E8DtrBLrYNArPpJF86GXwFeCoMuUblCF+p22mHtKF5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVsa/qO2UFvOfc3qJgrxJFAIB46zgcorZu2VqrKD1D72v2vMcWUfn6LmJQO5PdKgCjYpYqT87cLeGTo8Tbn3RMeLloQj6Om3tDL9L6vvFM63ch2T1ejFOJZvw3oJbsVAcGuwAoh7HHExRIi9NPNOdkjGmsrozpQ3Q/1NyJPRmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6W4oeKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB888C2BCB5;
	Mon, 27 Apr 2026 22:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328079;
	bh=E8DtrBLrYNArPpJF86GXwFeCoMuUblCF+p22mHtKF5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6W4oeKOQM7jk9jUoesyFgPltNs3rvUvJ9lYlQcxOYgJ6MKYpnV/2PWjGc4O6Z2eb
	 OR2tKoInE0qj80ZUwdAGFDLG4KTetFGk1Mcf4t5ByMJsB3c1ULTqJ3Usu1SZh1w1TO
	 WxDVArGn6/bxZq0SsSxaYf6HzaY4TXNrLwAMm4lr3cW8GW/thYh6Nz8M8ORmihfJr9
	 OqI6G35dQV1DQq9pVVfRW9IxKUFn7KltdTAEQagbAfhmotKOyNua/Lke93ARGdheGU
	 dC3a4xk7VM5u4w1NFuaIIZSl2DV6pVKkWCaY0owAM0qH7kTKDX66LvYg4HueAW+yn+
	 bT5jiQBXLlbsA==
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
Subject: [PATCH REF 24/24] gpu: drm: tyr: use HRT lifetime for IoMem
Date: Tue, 28 Apr 2026 00:11:22 +0200
Message-ID: <20260427221155.2144848-25-dakr@kernel.org>
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
X-Rspamd-Queue-Id: C905747B5EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8727-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Take advantage of the lifetime-parameterized IoMem<'a> to use the
memory mapping directly during probe, eliminating the Arc<Devres<IoMem>>
indirection.

Since the IoMem is only used during probe, this also simplifies
Register::read/write to be infallible -- the Devres access check is no
longer needed, so reads return u32 directly and writes return ().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Not yet updated to Tyr using the register!() macro, but probably good enough for
reference.
---
 drivers/gpu/drm/tyr/driver.rs | 14 ++++----
 drivers/gpu/drm/tyr/gpu.rs    | 62 +++++++++++++++++------------------
 drivers/gpu/drm/tyr/regs.rs   | 21 +++---------
 3 files changed, 41 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index eaa84efdfdf7..d305ad433e03 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -10,7 +10,6 @@
         Core,
         Device, //
     },
-    devres::Devres,
     drm,
     drm::ioctl,
     io::poll,
@@ -23,7 +22,6 @@
     sizes::SZ_2M,
     sync::{
         aref::ARef,
-        Arc,
         Mutex, //
     },
     time, //
@@ -37,7 +35,7 @@
     regs, //
 };
 
-pub(crate) type IoMem = kernel::io::mem::IoMem<'static, SZ_2M>;
+pub(crate) type IoMem = kernel::io::Mmio<SZ_2M>;
 
 pub(crate) struct TyrDrmDriver;
 
@@ -65,11 +63,11 @@ pub(crate) struct TyrDrmDeviceData {
     pub(crate) gpu_info: GpuInfo,
 }
 
-fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
-    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
+fn issue_soft_reset(dev: &Device<Bound>, iomem: &IoMem) -> Result {
+    regs::GPU_CMD.write(iomem, regs::GPU_CMD_SOFT_RESET);
 
     poll::read_poll_timeout(
-        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
+        || Ok(regs::GPU_IRQ_RAWSTAT.read(iomem)),
         |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED != 0,
         time::Delta::from_millis(1),
         time::Delta::from_millis(100),
@@ -109,12 +107,12 @@ fn probe(
         let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
 
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
-        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?.into_devres()?, GFP_KERNEL)?;
+        let iomem = request.iomap_sized::<SZ_2M>()?;
 
         issue_soft_reset(pdev.as_ref(), &iomem)?;
         gpu::l2_power_on(pdev.as_ref(), &iomem)?;
 
-        let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
+        let gpu_info = GpuInfo::new(&iomem);
         gpu_info.log(pdev);
 
         let platform: ARef<platform::Device> = pdev.into();
diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
index a88775160f98..bb0473c85bf7 100644
--- a/drivers/gpu/drm/tyr/gpu.rs
+++ b/drivers/gpu/drm/tyr/gpu.rs
@@ -10,7 +10,6 @@
         Bound,
         Device, //
     },
-    devres::Devres,
     io::poll,
     platform,
     prelude::*,
@@ -35,37 +34,36 @@
 pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
 
 impl GpuInfo {
-    pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
-        let gpu_id = regs::GPU_ID.read(dev, iomem)?;
-        let csf_id = regs::GPU_CSF_ID.read(dev, iomem)?;
-        let gpu_rev = regs::GPU_REVID.read(dev, iomem)?;
-        let core_features = regs::GPU_CORE_FEATURES.read(dev, iomem)?;
-        let l2_features = regs::GPU_L2_FEATURES.read(dev, iomem)?;
-        let tiler_features = regs::GPU_TILER_FEATURES.read(dev, iomem)?;
-        let mem_features = regs::GPU_MEM_FEATURES.read(dev, iomem)?;
-        let mmu_features = regs::GPU_MMU_FEATURES.read(dev, iomem)?;
-        let thread_features = regs::GPU_THREAD_FEATURES.read(dev, iomem)?;
-        let max_threads = regs::GPU_THREAD_MAX_THREADS.read(dev, iomem)?;
-        let thread_max_workgroup_size = regs::GPU_THREAD_MAX_WORKGROUP_SIZE.read(dev, iomem)?;
-        let thread_max_barrier_size = regs::GPU_THREAD_MAX_BARRIER_SIZE.read(dev, iomem)?;
-        let coherency_features = regs::GPU_COHERENCY_FEATURES.read(dev, iomem)?;
-
-        let texture_features = regs::GPU_TEXTURE_FEATURES0.read(dev, iomem)?;
-
-        let as_present = regs::GPU_AS_PRESENT.read(dev, iomem)?;
-
-        let shader_present = u64::from(regs::GPU_SHADER_PRESENT_LO.read(dev, iomem)?);
+    pub(crate) fn new(iomem: &IoMem) -> Self {
+        let gpu_id = regs::GPU_ID.read(iomem);
+        let csf_id = regs::GPU_CSF_ID.read(iomem);
+        let gpu_rev = regs::GPU_REVID.read(iomem);
+        let core_features = regs::GPU_CORE_FEATURES.read(iomem);
+        let l2_features = regs::GPU_L2_FEATURES.read(iomem);
+        let tiler_features = regs::GPU_TILER_FEATURES.read(iomem);
+        let mem_features = regs::GPU_MEM_FEATURES.read(iomem);
+        let mmu_features = regs::GPU_MMU_FEATURES.read(iomem);
+        let thread_features = regs::GPU_THREAD_FEATURES.read(iomem);
+        let max_threads = regs::GPU_THREAD_MAX_THREADS.read(iomem);
+        let thread_max_workgroup_size = regs::GPU_THREAD_MAX_WORKGROUP_SIZE.read(iomem);
+        let thread_max_barrier_size = regs::GPU_THREAD_MAX_BARRIER_SIZE.read(iomem);
+        let coherency_features = regs::GPU_COHERENCY_FEATURES.read(iomem);
+
+        let texture_features = regs::GPU_TEXTURE_FEATURES0.read(iomem);
+
+        let as_present = regs::GPU_AS_PRESENT.read(iomem);
+
+        let shader_present = u64::from(regs::GPU_SHADER_PRESENT_LO.read(iomem));
         let shader_present =
-            shader_present | u64::from(regs::GPU_SHADER_PRESENT_HI.read(dev, iomem)?) << 32;
+            shader_present | u64::from(regs::GPU_SHADER_PRESENT_HI.read(iomem)) << 32;
 
-        let tiler_present = u64::from(regs::GPU_TILER_PRESENT_LO.read(dev, iomem)?);
-        let tiler_present =
-            tiler_present | u64::from(regs::GPU_TILER_PRESENT_HI.read(dev, iomem)?) << 32;
+        let tiler_present = u64::from(regs::GPU_TILER_PRESENT_LO.read(iomem));
+        let tiler_present = tiler_present | u64::from(regs::GPU_TILER_PRESENT_HI.read(iomem)) << 32;
 
-        let l2_present = u64::from(regs::GPU_L2_PRESENT_LO.read(dev, iomem)?);
-        let l2_present = l2_present | u64::from(regs::GPU_L2_PRESENT_HI.read(dev, iomem)?) << 32;
+        let l2_present = u64::from(regs::GPU_L2_PRESENT_LO.read(iomem));
+        let l2_present = l2_present | u64::from(regs::GPU_L2_PRESENT_HI.read(iomem)) << 32;
 
-        Ok(Self(uapi::drm_panthor_gpu_info {
+        Self(uapi::drm_panthor_gpu_info {
             gpu_id,
             gpu_rev,
             csf_id,
@@ -88,7 +86,7 @@ pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<Self> {
             core_features,
             pad: 0,
             gpu_features: 0,
-        }))
+        })
     }
 
     pub(crate) fn log(&self, pdev: &platform::Device) {
@@ -208,11 +206,11 @@ fn from(value: u32) -> Self {
 }
 
 /// Powers on the l2 block.
-pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
-    regs::L2_PWRON_LO.write(dev, iomem, 1)?;
+pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &IoMem) -> Result {
+    regs::L2_PWRON_LO.write(iomem, 1);
 
     poll::read_poll_timeout(
-        || regs::L2_READY_LO.read(dev, iomem),
+        || Ok(regs::L2_READY_LO.read(iomem)),
         |status| *status == 1,
         Delta::from_millis(1),
         Delta::from_millis(100),
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 611870c2e6af..0881b3812afd 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -7,16 +7,7 @@
 // does.
 #![allow(dead_code)]
 
-use kernel::{
-    bits::bit_u32,
-    device::{
-        Bound,
-        Device, //
-    },
-    devres::Devres,
-    io::Io,
-    prelude::*, //
-};
+use kernel::{bits::bit_u32, io::Io};
 
 use crate::driver::IoMem;
 
@@ -29,15 +20,13 @@
 
 impl<const OFFSET: usize> Register<OFFSET> {
     #[inline]
-    pub(crate) fn read(&self, dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result<u32> {
-        let value = (*iomem).access(dev)?.read32(OFFSET);
-        Ok(value)
+    pub(crate) fn read(&self, iomem: &IoMem) -> u32 {
+        iomem.read32(OFFSET)
     }
 
     #[inline]
-    pub(crate) fn write(&self, dev: &Device<Bound>, iomem: &Devres<IoMem>, value: u32) -> Result {
-        (*iomem).access(dev)?.write32(value, OFFSET);
-        Ok(())
+    pub(crate) fn write(&self, iomem: &IoMem, value: u32) {
+        iomem.write32(value, OFFSET);
     }
 }
 
-- 
2.54.0


