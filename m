Return-Path: <linux-pwm+bounces-9145-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLi4Jl2zFGo4PgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9145-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:38:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4845CE9DF
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C5CB3053CAE
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8C39E19A;
	Mon, 25 May 2026 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOLuWrRT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D639B49E;
	Mon, 25 May 2026 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741109; cv=none; b=FWz/IUVlMYdTlBizBNISqjYvlcZ36GkR4npGyOHOuh7y7lemVATClY2owgfKz7ZR2C+KunxkPfqNtAQEaEjA/ZV3vshBTFxal0uwQbE1Ipge0iK4lxQP7sWdRBb9rTa5D522Xl6VTvAScpW01Jh2hBl723ZrF3cw1BcbGXcHMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741109; c=relaxed/simple;
	bh=4haRq1vbJd2fRcQo8B9tOKkWxj2WfgnF+h+Lo1XjcEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1CqYgSYb6Py5iI+XkRihLwJtmPjtdfylK1lSKPGtVlYlh2BmfAdmrmLvL+ph2Wu7XO+8jIys72Y2RVXTmvpGPiRhkC7DQ1JXpiCWkxaUZXH7rSXDo9itScFn12VOqms3C6RaIQt91psNFsTX9kiUfoMRZ2CDOHSFJo4egKY5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOLuWrRT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0641F00A3A;
	Mon, 25 May 2026 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741107;
	bh=FAC3DL61CBDdZZhQYeFer0JqaOgTXK5sDK42iWhKYgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOLuWrRTeUs8E/1PYAxtGmQpgPpQKyCJfUlHYnIIsNB4/8DjOAnw/p5xa6kIfN1KV
	 4A7WANBGLmbUKwr2Ia4J7UJ85+/31PD4b0JVNkKQpQxFiTAz0kb+ghHhmFB3clNd6/
	 wDcpB8VuGUv0AYzE+xmz+wQS5zj1L/pcTgVoxfGo+ePYswwZzshJwhp1cS62/2Gu5/
	 aUA+sSLFoFP9iuzJHpwbtoLddA95NrrXESjhiIXP6wWzI6DVj9nkl3vIBhlvdENtYt
	 xh5swJKBDT9O2mKe2TyHnjTbxMxl8vLl+ZI7tddMltHQXpOFhNbX2/7fM+I2p8Gp3X
	 0nL3G1agbrAFA==
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
Subject: [PATCH v5 19/24] rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized
Date: Mon, 25 May 2026 22:21:06 +0200
Message-ID: <20260525202921.124698-20-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9145-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9E4845CE9DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a lifetime parameter to IoMem<'a, SIZE> and ExclusiveIoMem<'a,
SIZE>, storing a &'a Device<Bound> reference to tie the mapping to the
device's lifetime.

This mirrors the pci::Bar<'a, SIZE> design and enables drivers to hold
I/O memory mappings directly in their HRT private data, tied to the
device lifetime.

IoRequest::iomap_* methods now return the mapping directly instead of
wrapping it in Devres. Callers that need device-managed revocation can
call the new into_devres() method.

Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/tyr/driver.rs |   4 +-
 drivers/pwm/pwm_th1520.rs     |   4 +-
 rust/kernel/io/mem.rs         | 103 +++++++++++++++++-----------------
 3 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 797f09e23a4c..04f83fcf0937 100644
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
index 6c5b791f3153..48808cd80737 100644
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
index 51ba347220ee..fc2a3e24f8d5 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
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
+    pub fn iomap_sized<const SIZE: usize>(self) -> Result<IoMem<'a, SIZE>> {
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
+    pub fn iomap_exclusive_sized<const SIZE: usize>(self) -> Result<ExclusiveIoMem<'a, SIZE>> {
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
+    pub fn iomap(self) -> Result<IoMem<'a>> {
+        self.iomap_sized::<0>()
     }
 
     /// Same as [`Self::iomap`] but with exclusive access to the underlying
     /// region.
-    pub fn iomap_exclusive(self) -> impl PinInit<Devres<ExclusiveIoMem<0>>, Error> + 'a {
-        Self::iomap_exclusive_sized::<0>(self)
+    pub fn iomap_exclusive(self) -> Result<ExclusiveIoMem<'a, 0>> {
+        self.iomap_exclusive_sized::<0>()
     }
 }
 
@@ -169,9 +161,9 @@ pub fn iomap_exclusive(self) -> impl PinInit<Devres<ExclusiveIoMem<0>>, Error> +
 /// # Invariants
 ///
 /// - [`ExclusiveIoMem`] has exclusive access to the underlying [`IoMem`].
-pub struct ExclusiveIoMem<const SIZE: usize> {
+pub struct ExclusiveIoMem<'a, const SIZE: usize> {
     /// The underlying `IoMem` instance.
-    iomem: IoMem<SIZE>,
+    iomem: IoMem<'a, SIZE>,
 
     /// The region abstraction. This represents exclusive access to the
     /// range represented by the underlying `iomem`.
@@ -180,9 +172,9 @@ pub struct ExclusiveIoMem<const SIZE: usize> {
     _region: Region,
 }
 
-impl<const SIZE: usize> ExclusiveIoMem<SIZE> {
+impl<'a, const SIZE: usize> ExclusiveIoMem<'a, SIZE> {
     /// Creates a new `ExclusiveIoMem` instance.
-    fn ioremap(resource: &Resource) -> Result<Self> {
+    fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
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
+    /// `'a`. Access to the I/O memory is revoked when the device is unbound.
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
+pub struct IoMem<'a, const SIZE: usize = 0> {
+    dev: &'a Device<Bound>,
     io: MmioRaw<SIZE>,
 }
 
-impl<const SIZE: usize> IoMem<SIZE> {
-    fn ioremap(resource: &Resource) -> Result<Self> {
+impl<'a, const SIZE: usize> IoMem<'a, SIZE> {
+    fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
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
+    /// lifetime `'a`. Access to the I/O memory is revoked when the device
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


