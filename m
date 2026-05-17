Return-Path: <linux-pwm+bounces-8919-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LClBrEGCWouFgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8919-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:07:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EC355E8F3
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 235C8301F15E
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5150683A14;
	Sun, 17 May 2026 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCOPG9Uw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E8199D8;
	Sun, 17 May 2026 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976261; cv=none; b=VupNA8JeG1GUuY2WwKJFTfQVOaVxrnN2kk5l4H1qlAJ86MGG9TF15em4ErdHKoowzZnpcC3jFHnPSCbMyci+QL6w2U/zLdZ/3TJcJH8qBMOWO7O14KK6tZQufMZXIltFUx6NH0qFOrM2YKSZj0uD5tpRAcnM7HYgpLINo5gqaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976261; c=relaxed/simple;
	bh=9me7LyGDF1H/NmHy1fACGvVLaM9iJhsqFDFW0u0Hg3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9/tdY4MLDnFa5s2b2QWOqg2g1VGX06EL1oLlAERRuaKTmSI8Fve5fgSm47KSZ1+MfNIVASygzyBb7RnVBd6almphDTJqngYPOUzmFofiAozJF3dBGhVfpPgdB+NHIDel6P8VWOFpwSADXtbKPAMn8atVTmaTZWwECveQSOvVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCOPG9Uw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D6CC2BCC7;
	Sun, 17 May 2026 00:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976260;
	bh=9me7LyGDF1H/NmHy1fACGvVLaM9iJhsqFDFW0u0Hg3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MCOPG9Uw0oyo9f21rTN7DOHSuUUxtI5pz3Qkt3TB6DQMGFBHB5rypBPflqoHA/+mk
	 u4Cahuryzpt2aITL5vybiCC2cnv1Xkh8jLx3IovGSPIIBC3wwSMk0o40VuGi5G98YI
	 o5kAfZhD2COfcb9wxk5xWbRqcawd0U1QmClFeGDY5NFxQgP6C3GZIxt1CT5/DEUkuS
	 DJBUBEkfVlfWPwqqRqWpyTqr6qyAtgqWXRofUhTrXCmGZivwkyhmqn0qzL32+dtApj
	 RnieohlEPEJ11U5C/VLHf7GZFxKVR4zxv2Pnvw6R0CDA9UVnLlhKso1apJS0+eyqhk
	 OhhlaisY9Q0zw==
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
Subject: [PATCH v3 20/27] rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized
Date: Sun, 17 May 2026 02:01:08 +0200
Message-ID: <20260517000149.3226762-21-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 83EC355E8F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8919-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a lifetime parameter to IoMem<'bound, SIZE> and
ExclusiveIoMem<'bound, SIZE>, storing a &'bound Device<Bound> reference
to tie the mapping to the device's lifetime.

This mirrors the pci::Bar<'bound, SIZE> design and enables drivers to
hold I/O memory mappings directly in their HRT private data, tied to the
device lifetime.

IoRequest::iomap_* methods now return the mapping directly instead of
wrapping it in Devres. Callers that need device-managed revocation can
call the new into_devres() method.

Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/tyr/driver.rs |   4 +-
 drivers/pwm/pwm_th1520.rs     |   4 +-
 rust/kernel/io/mem.rs         | 115 +++++++++++++++++-----------------
 3 files changed, 62 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 3ac3b9979264..8c916913e976 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -37,7 +37,7 @@
     regs, //
 };
 
-pub(crate) type IoMem = kernel::io::mem::IoMem<SZ_2M>;
+pub(crate) type IoMem = kernel::io::mem::IoMem<'static, SZ_2M>;
 
 pub(crate) struct TyrDrmDriver;
 
@@ -110,7 +110,7 @@ fn probe<'bound>(
         let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
 
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
-        let iomem = Arc::pin_init(request.iomap_sized::<SZ_2M>(), GFP_KERNEL)?;
+        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?.into_devres()?, GFP_KERNEL)?;
 
         issue_soft_reset(pdev.as_ref(), &iomem)?;
         gpu::l2_power_on(pdev.as_ref(), &iomem)?;
diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 1abf580653fa..c84321a4d94e 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -92,7 +92,7 @@ struct Th1520WfHw {
 #[pin_data(PinnedDrop)]
 struct Th1520PwmDriverData {
     #[pin]
-    iomem: devres::Devres<IoMem<TH1520_PWM_REG_SIZE>>,
+    iomem: devres::Devres<IoMem<'static, TH1520_PWM_REG_SIZE>>,
     clk: Clk,
 }
 
@@ -352,7 +352,7 @@ fn probe<'bound>(
             dev,
             TH1520_MAX_PWM_NUM,
             try_pin_init!(Th1520PwmDriverData {
-                iomem <- request.iomap_sized::<TH1520_PWM_REG_SIZE>(),
+                iomem <- request.iomap_sized::<TH1520_PWM_REG_SIZE>()?.into_devres(),
                 clk <- clk,
             }),
         )?;
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 1b34f7ebd929..b5015d020efa 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -23,19 +23,19 @@
 };
 
 /// An IO request for a specific device and resource.
-pub struct IoRequest<'a> {
-    device: &'a Device<Bound>,
-    resource: &'a Resource,
+pub struct IoRequest<'bound> {
+    device: &'bound Device<Bound>,
+    resource: &'bound Resource,
 }
 
-impl<'a> IoRequest<'a> {
+impl<'bound> IoRequest<'bound> {
     /// Creates a new [`IoRequest`] instance.
     ///
     /// # Safety
     ///
     /// Callers must ensure that `resource` is valid for `device` during the
-    /// lifetime `'a`.
-    pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> Self {
+    /// lifetime `'bound`.
+    pub(crate) unsafe fn new(device: &'bound Device<Bound>, resource: &'bound Resource) -> Self {
         IoRequest { device, resource }
     }
 
@@ -74,22 +74,19 @@ pub(crate) unsafe fn new(device: &'a Device<Bound>, resource: &'a Resource) -> S
     ///       //
     ///       // No runtime checks will apply when reading and writing.
     ///       let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
-    ///       let iomem = request.iomap_sized::<42>();
-    ///       let iomem = KBox::pin_init(iomem, GFP_KERNEL)?;
-    ///
-    ///       let io = iomem.access(pdev.as_ref())?;
+    ///       let iomem = request.iomap_sized::<42>()?;
     ///
     ///       // Read and write a 32-bit value at `offset`.
-    ///       let data = io.read32(offset);
+    ///       let data = iomem.read32(offset);
     ///
-    ///       io.write32(data, offset);
+    ///       iomem.write32(data, offset);
     ///
     ///       # Ok(SampleDriver)
     ///     }
     /// }
     /// ```
-    pub fn iomap_sized<const SIZE: usize>(self) -> impl PinInit<Devres<IoMem<SIZE>>, Error> + 'a {
-        IoMem::new(self)
+    pub fn iomap_sized<const SIZE: usize>(self) -> Result<IoMem<'bound, SIZE>> {
+        IoMem::ioremap(self.device, self.resource)
     }
 
     /// Same as [`Self::iomap_sized`] but with exclusive access to the
@@ -98,10 +95,8 @@ pub fn iomap_sized<const SIZE: usize>(self) -> impl PinInit<Devres<IoMem<SIZE>>,
     /// This uses the [`ioremap()`] C API.
     ///
     /// [`ioremap()`]: https://docs.kernel.org/driver-api/device-io.html#getting-access-to-the-device
-    pub fn iomap_exclusive_sized<const SIZE: usize>(
-        self,
-    ) -> impl PinInit<Devres<ExclusiveIoMem<SIZE>>, Error> + 'a {
-        ExclusiveIoMem::new(self)
+    pub fn iomap_exclusive_sized<const SIZE: usize>(self) -> Result<ExclusiveIoMem<'bound, SIZE>> {
+        ExclusiveIoMem::ioremap(self.device, self.resource)
     }
 
     /// Maps an [`IoRequest`] where the size is not known at compile time,
@@ -140,27 +135,24 @@ pub fn iomap_exclusive_sized<const SIZE: usize>(
     ///       // family of functions should be used, leading to runtime checks on every
     ///       // access.
     ///       let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
-    ///       let iomem = request.iomap();
-    ///       let iomem = KBox::pin_init(iomem, GFP_KERNEL)?;
-    ///
-    ///       let io = iomem.access(pdev.as_ref())?;
+    ///       let iomem = request.iomap()?;
     ///
-    ///       let data = io.try_read32(offset)?;
+    ///       let data = iomem.try_read32(offset)?;
     ///
-    ///       io.try_write32(data, offset)?;
+    ///       iomem.try_write32(data, offset)?;
     ///
     ///       # Ok(SampleDriver)
     ///     }
     /// }
     /// ```
-    pub fn iomap(self) -> impl PinInit<Devres<IoMem<0>>, Error> + 'a {
-        Self::iomap_sized::<0>(self)
+    pub fn iomap(self) -> Result<IoMem<'bound>> {
+        self.iomap_sized::<0>()
     }
 
     /// Same as [`Self::iomap`] but with exclusive access to the underlying
     /// region.
-    pub fn iomap_exclusive(self) -> impl PinInit<Devres<ExclusiveIoMem<0>>, Error> + 'a {
-        Self::iomap_exclusive_sized::<0>(self)
+    pub fn iomap_exclusive(self) -> Result<ExclusiveIoMem<'bound, 0>> {
+        self.iomap_exclusive_sized::<0>()
     }
 }
 
@@ -169,9 +161,9 @@ pub fn iomap_exclusive(self) -> impl PinInit<Devres<ExclusiveIoMem<0>>, Error> +
 /// # Invariants
 ///
 /// - [`ExclusiveIoMem`] has exclusive access to the underlying [`IoMem`].
-pub struct ExclusiveIoMem<const SIZE: usize> {
+pub struct ExclusiveIoMem<'bound, const SIZE: usize> {
     /// The underlying `IoMem` instance.
-    iomem: IoMem<SIZE>,
+    iomem: IoMem<'bound, SIZE>,
 
     /// The region abstraction. This represents exclusive access to the
     /// range represented by the underlying `iomem`.
@@ -180,9 +172,9 @@ pub struct ExclusiveIoMem<const SIZE: usize> {
     _region: Region,
 }
 
-impl<const SIZE: usize> ExclusiveIoMem<SIZE> {
+impl<'bound, const SIZE: usize> ExclusiveIoMem<'bound, SIZE> {
     /// Creates a new `ExclusiveIoMem` instance.
-    fn ioremap(resource: &Resource) -> Result<Self> {
+    fn ioremap(dev: &'bound Device<Bound>, resource: &Resource) -> Result<Self> {
         let start = resource.start();
         let size = resource.size();
         let name = resource.name().unwrap_or_default();
@@ -196,26 +188,29 @@ fn ioremap(resource: &Resource) -> Result<Self> {
             )
             .ok_or(EBUSY)?;
 
-        let iomem = IoMem::ioremap(resource)?;
+        let iomem = IoMem::ioremap(dev, resource)?;
 
-        let iomem = ExclusiveIoMem {
+        Ok(ExclusiveIoMem {
             iomem,
             _region: region,
-        };
-
-        Ok(iomem)
+        })
     }
 
-    /// Creates a new `ExclusiveIoMem` instance from a previously acquired [`IoRequest`].
-    pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> + 'a {
-        let dev = io_request.device;
-        let res = io_request.resource;
-
-        Devres::new(dev, Self::ioremap(res))
+    /// Consume the `ExclusiveIoMem` and register it as a device-managed resource.
+    ///
+    /// The returned `Devres<ExclusiveIoMem<'static, SIZE>>` can outlive the original lifetime
+    /// `'bound`. Access to the I/O memory is revoked when the device is unbound.
+    pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
+        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the
+        // `ExclusiveIoMem` does not actually outlive the device -- access is revoked and the
+        // resource is released when the device is unbound.
+        let iomem: ExclusiveIoMem<'static, SIZE> = unsafe { core::mem::transmute(self) };
+        let dev = iomem.iomem.dev;
+        Devres::new(dev, iomem)
     }
 }
 
-impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
+impl<const SIZE: usize> Deref for ExclusiveIoMem<'_, SIZE> {
     type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
@@ -232,12 +227,13 @@ fn deref(&self) -> &Self::Target {
 ///
 /// [`IoMem`] always holds an [`MmioRaw`] instance that holds a valid pointer to the
 /// start of the I/O memory mapped region.
-pub struct IoMem<const SIZE: usize = 0> {
+pub struct IoMem<'bound, const SIZE: usize = 0> {
+    dev: &'bound Device<Bound>,
     io: MmioRaw<SIZE>,
 }
 
-impl<const SIZE: usize> IoMem<SIZE> {
-    fn ioremap(resource: &Resource) -> Result<Self> {
+impl<'bound, const SIZE: usize> IoMem<'bound, SIZE> {
+    fn ioremap(dev: &'bound Device<Bound>, resource: &Resource) -> Result<Self> {
         // Note: Some ioremap() implementations use types that depend on the CPU
         // word width rather than the bus address width.
         //
@@ -269,28 +265,33 @@ fn ioremap(resource: &Resource) -> Result<Self> {
         }
 
         let io = MmioRaw::new(addr as usize, size)?;
-        let io = IoMem { io };
 
-        Ok(io)
+        Ok(IoMem { dev, io })
     }
 
-    /// Creates a new `IoMem` instance from a previously acquired [`IoRequest`].
-    pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> + 'a {
-        let dev = io_request.device;
-        let res = io_request.resource;
-
-        Devres::new(dev, Self::ioremap(res))
+    /// Consume the `IoMem` and register it as a device-managed resource.
+    ///
+    /// The returned `Devres<IoMem<'static, SIZE>>` can outlive the original
+    /// lifetime `'bound`. Access to the I/O memory is revoked when the device
+    /// is unbound.
+    pub fn into_devres(self) -> Result<Devres<IoMem<'static, SIZE>>> {
+        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the `IoMem` does not
+        // actually outlive the device -- access is revoked and the resource is released when the
+        // device is unbound.
+        let iomem: IoMem<'static, SIZE> = unsafe { core::mem::transmute(self) };
+        let dev = iomem.dev;
+        Devres::new(dev, iomem)
     }
 }
 
-impl<const SIZE: usize> Drop for IoMem<SIZE> {
+impl<const SIZE: usize> Drop for IoMem<'_, SIZE> {
     fn drop(&mut self) {
         // SAFETY: Safe as by the invariant of `Io`.
         unsafe { bindings::iounmap(self.io.addr() as *mut c_void) }
     }
 }
 
-impl<const SIZE: usize> Deref for IoMem<SIZE> {
+impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
     type Target = Mmio<SIZE>;
 
     fn deref(&self) -> &Self::Target {
-- 
2.54.0


