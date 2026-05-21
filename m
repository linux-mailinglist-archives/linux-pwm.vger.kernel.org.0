Return-Path: <linux-pwm+bounces-9072-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHzjI9ubD2qCNwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9072-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:57:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F15AD267
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9F163045CA7
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B9A3A71BC;
	Thu, 21 May 2026 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISmCq4b9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAF37DEB9;
	Thu, 21 May 2026 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406939; cv=none; b=jp8zpjU/gFMpIaGv1mj6n429F91qwtI5lm3UU3ipJOcZZlHM/b4eCPp9NEut947+Ka1XaYsDZ8httVT71nUt5Gz6PqfR1w4d/fMawZRTTHB9BrNycgaRZi3Nd5U/A6N+TihDI9Gn5lv5hl9vEgaTGywDkzY76w+511kzPRCj+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406939; c=relaxed/simple;
	bh=9TiMPMFi9DqkpvtnjcM0UBtE0MRykgEWhUsOuQopYuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAA1bkD0vKIM29bWta9Hcbi2KxcnL1MuOKgBOKwgVxZsQWoXDzTu4NtDH7JPHWrMPUJw4E5odO0rdbUYIYvUHyPI83dha7VXdxDwm8jJktp3/3HVYLxQ8xQ+KPz25NuH7g9153jHZB8Ss1mjz0DZ4mLpoOubXwWDV66MNsBhLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISmCq4b9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130BE1F00A3C;
	Thu, 21 May 2026 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406931;
	bh=dt2mnOGqU/dqsuuyNJuAquOOYfNTnXCcO5ozbuHU/2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ISmCq4b9VzLkR0djpnh6Fmawpyk8xNpakXw7NeNDJ3TJiol7XZ+aYh+98jtzXjO2q
	 I1Oov7EHyhGVxh4FLSoCSKVIJfeahDEzWHwDVPFbJsyPJoqhZtxHKHDOdx/SmBmk1M
	 J42rYG2jP0CuWMAYvafiLcgmtgCfuGY1IpTEbZByMszZsJU5IKJjiJ4UQlZMRLu5p7
	 ul0pD7/uQ6nkHYmzOZQPyqx1lraJRzqisbTV7XXezAhPAxMGjMXSu4QzdaoY5/U+Z4
	 XmM5/L10wpsekjXKskd3l0MqKITM+V8EsoryqS93IZ28xeMPDonHdPqUjB7BucVHpe
	 Vzs7p6ZwRu7jg==
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
Subject: [PATCH REF v4 25/27] gpu: nova-core: unregister sysmem flush page from Drop
Date: Fri, 22 May 2026 01:34:51 +0200
Message-ID: <20260521233501.1191842-26-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521233501.1191842-1-dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9072-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,self.bar:url]
X-Rspamd-Queue-Id: 2A7F15AD267
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that SysmemFlush can borrow the Bar via HRT lifetime, store a
&'bound Bar0 reference and implement Drop to automatically unregister
the sysmem flush page. This removes the need for manual unregister()
calls and the Gpu::unbind() method.

Reported-by: Eliot Courtney <ecourtney@nvidia.com>
Closes: https://lore.kernel.org/all/20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com/
Fixes: 6554ad65b589 ("gpu: nova-core: register sysmem flush page")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs |  4 ----
 drivers/gpu/nova-core/fb.rs     | 22 ++++++++++------------
 drivers/gpu/nova-core/gpu.rs    |  9 +--------
 3 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index d4cf4379ee87..cff5034c2dcd 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -113,8 +113,4 @@ fn probe<'bound>(
             }))
         })
     }
-
-    fn unbind<'bound>(_pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Self::Data<'bound>>) {
-        this.gpu.unbind();
-    }
 }
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index bdd5eed760e1..64fe5f27f41e 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -46,21 +46,20 @@
 /// Because of this, the sysmem flush memory page must be registered as early as possible during
 /// driver initialization, and before any falcon is reset.
 ///
-/// Users are responsible for manually calling [`Self::unregister`] before dropping this object,
-/// otherwise the GPU might still use it even after it has been freed.
-pub(crate) struct SysmemFlush {
+pub(crate) struct SysmemFlush<'sys> {
     /// Chipset we are operating on.
     chipset: Chipset,
     device: ARef<device::Device>,
+    bar: &'sys Bar0,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
 }
 
-impl SysmemFlush {
+impl<'sys> SysmemFlush<'sys> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: &'sys Bar0,
         chipset: Chipset,
     ) -> Result<Self> {
         let page = CoherentHandle::alloc(dev, kernel::page::PAGE_SIZE, GFP_KERNEL)?;
@@ -70,19 +69,18 @@ pub(crate) fn register(
         Ok(Self {
             chipset,
             device: dev.into(),
+            bar,
             page,
         })
     }
+}
 
-    /// Unregister the managed sysmem flush page.
-    ///
-    /// In order to gracefully tear down the GPU, users must make sure to call this method before
-    /// dropping the object.
-    pub(crate) fn unregister(&self, bar: &Bar0) {
+impl Drop for SysmemFlush<'_> {
+    fn drop(&mut self) {
         let hal = hal::fb_hal(self.chipset);
 
-        if hal.read_sysmem_flush_page(bar) == self.page.dma_handle() {
-            let _ = hal.write_sysmem_flush_page(bar, 0).inspect_err(|e| {
+        if hal.read_sysmem_flush_page(self.bar) == self.page.dma_handle() {
+            let _ = hal.write_sysmem_flush_page(self.bar, 0).inspect_err(|e| {
                 dev_warn!(
                     &self.device,
                     "failed to unregister sysmem flush page: {:?}\n",
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8d2d6b0a917b..c907d11580d6 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -228,7 +228,7 @@ pub(crate) struct Gpu<'gpu> {
     bar: &'gpu Bar0,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
-    sysmem_flush: SysmemFlush,
+    sysmem_flush: SysmemFlush<'gpu>,
     /// GSP falcon instance, used for GSP boot up and cleanup.
     gsp_falcon: Falcon<GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
@@ -271,11 +271,4 @@ pub(crate) fn new(
             _: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
         })
     }
-
-    /// Called when the corresponding [`Device`](device::Device) is unbound.
-    ///
-    /// Note: This method must only be called from `Driver::unbind`.
-    pub(crate) fn unbind(&self) {
-        self.sysmem_flush.unregister(self.bar);
-    }
 }
-- 
2.54.0


