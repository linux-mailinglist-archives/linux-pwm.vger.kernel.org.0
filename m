Return-Path: <linux-pwm+bounces-8725-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPxqNj3k72kFHgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8725-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:33:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D91747B84A
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2BCE319B1B9
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA6401A09;
	Mon, 27 Apr 2026 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqDRm9LT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901EB3B19D4;
	Mon, 27 Apr 2026 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328067; cv=none; b=hmLKQhSJNr5U/BBAmd4pt6SHrXqIpbXz/j2+cA7Ep1hXbM7clvXTH9GvKqWnbFBSS5NSFM9v2/+V3mGwz2dnCocU4ijXdaXHKMs5ByEygFay/b5GhEfVe2UBV0hj7+E9O0w3GSv6pmS8NzBim001G6lMv2rBVZAMB9TUnRF44jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328067; c=relaxed/simple;
	bh=hYy8LQDnO+hisbOptHtgqKp36k1YyJTGix7eeoo2qKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7auGlE90LnSGD3byLYli0X76YCfzM3JWJzQXPVV4kDrOMfb++w2Ikzj1EQqRn2AhNPCBzhPDFErpZBFykm/hf+k9PMgyCNb/+GK7TviJQL8/myRmYs+vzycU3k/DSWs7aYzew4qmzj3jDzxynj18laNfhCI+HVEnE/LZ1xsVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqDRm9LT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFB6C2BCB5;
	Mon, 27 Apr 2026 22:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328067;
	bh=hYy8LQDnO+hisbOptHtgqKp36k1YyJTGix7eeoo2qKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BqDRm9LTAxT+LFyHHIuPW75dzJcoI9Ybx7Pav2R3kJM6ezZK8ghNMm+Vgu0kZDyZK
	 1LudCaJgONM+Un6S/kbl7SB8Mcga8LywZ7inQvNuX1KcK7KaSNDiyXC7DBPDVdTKor
	 0q2svsR7Us01zcKWz6u/qqn6vkMogrDSopGHpgCW5TGai40EemoNAzP0c0nAQAfQN4
	 l2N+0gniTfMs4GFNXBcrNGkoZtep7KOXCrc+BN9b5PlcSlhqV7AuaookXi4u61d0b9
	 TflB5dPw/5CUgL0yAScR61V23nWsROYxBmcBHmPPDz34QgZrIkEkjFfH5hf1xXxnE3
	 DpmWxroqy3GiQ==
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
	Danilo Krummrich <dakr@kernel.org>,
	Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH REF 22/24] gpu: nova-core: unregister sysmem flush page from Drop
Date: Tue, 28 Apr 2026 00:11:20 +0200
Message-ID: <20260427221155.2144848-23-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 3D91747B84A
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
	TAGGED_FROM(0.00)[bounces-8725-lists,linux-pwm=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	NEURAL_SPAM(0.00)[0.568];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,self.bar:url]
X-Spam: Yes

Now that SysmemFlush can borrow the Bar via HRT lifetime, store a &'a
Bar0 reference and implement Drop to automatically unregister the
sysmem flush page. This removes the need for manual unregister() calls
and the Gpu::unbind() method.

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
index ec9cecb30f63..401ae213991f 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -111,8 +111,4 @@ fn probe(
             }))
         })
     }
-
-    fn unbind(_pdev: &'a pci::Device<Core>, this: Pin<&'a Self>) {
-        this.gpu.unbind();
-    }
 }
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index bdd5eed760e1..cbc42e98afca 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -46,21 +46,20 @@
 /// Because of this, the sysmem flush memory page must be registered as early as possible during
 /// driver initialization, and before any falcon is reset.
 ///
-/// Users are responsible for manually calling [`Self::unregister`] before dropping this object,
-/// otherwise the GPU might still use it even after it has been freed.
-pub(crate) struct SysmemFlush {
+pub(crate) struct SysmemFlush<'a> {
     /// Chipset we are operating on.
     chipset: Chipset,
     device: ARef<device::Device>,
+    bar: &'a Bar0,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
 }
 
-impl SysmemFlush {
+impl<'a> SysmemFlush<'a> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: &'a Bar0,
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
index 922197f2aeef..ff9a90a46609 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -228,7 +228,7 @@ pub(crate) struct Gpu<'a> {
     bar: &'a Bar0,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
-    sysmem_flush: SysmemFlush,
+    sysmem_flush: SysmemFlush<'a>,
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


