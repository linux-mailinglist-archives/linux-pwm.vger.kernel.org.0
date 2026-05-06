Return-Path: <linux-pwm+bounces-8819-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOcdGEm6+2lrEAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8819-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:01:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 014744E1088
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2078E30C9DF4
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5AF3B774F;
	Wed,  6 May 2026 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvVRRka0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789F3B4EAD;
	Wed,  6 May 2026 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104450; cv=none; b=VWKp1XCccwGNa4F0cNm8+V6QhoW+SEr2/ORZl48lJxFPjXpjZpGnfrWAff4ShVnYufWBR5y5Pa+EDWyUdHkukpxl/A5qVmvcASgFEYxaOvgQJRxHQQ5Sy6iA9JinHC8vNggGOBYbWAFVZ0neHynyvO97JwdyLMX6/1S88Y75Jnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104450; c=relaxed/simple;
	bh=VG30qVsb6RRcXgQELJg9Ca7p/xOe3vGfkPeGGTG4/LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKp2ZvnFC9rWEBSxFvUjJ4UEwhFp4Bc2qR5y/mWCywwAerCmiFRn4dtCwrYfj5jbm0uOO4T0z9wlge7gxn0uLWJXb0L5k08I7qHWzQSToNMzm1ZcJWxP9NClGR6mtRDjJN+3KsirymMQ9bfr7XCOODoSw1/O2scUl6HMZ639tmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvVRRka0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026B0C2BCB2;
	Wed,  6 May 2026 21:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104450;
	bh=VG30qVsb6RRcXgQELJg9Ca7p/xOe3vGfkPeGGTG4/LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvVRRka0UdUyjqUuewxIjDCozRr885C1yZbQ+nXEiERgeUq1lsuxNFGejbsaYbLJH
	 4LxLI/7Cdsp1MpFN38v72WYXJfYCo1ChgNVnLfvqg7CvEQDsHMJ2eV9lsMyMyIYaUx
	 h2mAzjKKXKk7qMZ977jmCpLjn8VzWwhbgVeA9FH+HUDrAO7s/rD5ieU4EwxY5OfnGY
	 s8rthYTks/vHKDvqyOuaX1BmJJ6fp1fHLwqHQDVzJt8XKSdaF4EXwDIAiuxPbdzJi4
	 1fx1z1SILndIPvYx+KeUpOR+ITHFzFxq37YOQHk+SeC87j/bDWMW7t0tuBZav3kjVg
	 Nm9CXtW4ZkspA==
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
Subject: [PATCH v2 25/25] gpu: drm: tyr: use HRT lifetime for IoMem
Date: Wed,  6 May 2026 23:51:01 +0200
Message-ID: <20260506215113.851360-26-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 014744E1088
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
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-8819-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Take advantage of the lifetime-parameterized IoMem<'bound> to use the
memory mapping directly during probe, eliminating the Arc<Devres<IoMem>>
indirection.

Since the IoMem is only used during probe, this also simplifies
Register::read/write to be infallible -- the Devres access check is no
longer needed, so reads return u32 directly and writes return ().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/tyr/driver.rs | 14 ++++----
 drivers/gpu/drm/tyr/gpu.rs    | 62 +++++++++++++++++------------------
 drivers/gpu/drm/tyr/regs.rs   | 21 +++---------
 3 files changed, 41 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 295a627de2b2..e6c84a1433d2 100644
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


