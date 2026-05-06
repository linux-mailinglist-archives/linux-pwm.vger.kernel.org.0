Return-Path: <linux-pwm+bounces-8823-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJjdAjO6+2lrEAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8823-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:01:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B39A4E106A
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BD59300B58E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E524F3B636B;
	Wed,  6 May 2026 22:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwmnhyPM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD8F3B6BE5;
	Wed,  6 May 2026 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104854; cv=none; b=eKTYdZyge98GNG/qP1o4Gjp2AhTSdTGqvWGHuzMQA8af21zbyyyQhRkSaqUveXG3Q6BvXRnvbRGRJ7lnkt4RQvJmyKyivUnMNW5cw8Pxl1Xl07/hhdPCMvPgEKGC8eVvuFWWFDhY7V7SgYXBpjqpqH863iDI3Ia67XpxUuZ/W8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104854; c=relaxed/simple;
	bh=on0f2dzM4OyBJJ/2FK/55nr+4xNDyqrNSyiwAHUz4Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRCbHt/65ClkKK2ML1VCkfJGk9b8SNm9LN3T9c8YNfx71Uy7ygWNOKlbD6Vyhi0meEkAcLADi1Mx4vO8wD2aXdyIhJ/UYpcaDccgIFleYBQYXJK+r6MHHFAngxuXqBfDqKUrkHZSGR3xIfFMwyBJNiy4zAUxPZ19dYzTSv/fvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwmnhyPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B396C2BCB0;
	Wed,  6 May 2026 22:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104853;
	bh=on0f2dzM4OyBJJ/2FK/55nr+4xNDyqrNSyiwAHUz4Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwmnhyPMk0cS4CjrFv8Om71Z3XOiTp3862EkfaXMedsCh+8jyu8hE4M/tU8GHHdxV
	 HgJLiMwSPSWzYUFik535ujPWCYhJSRLH68+Rekwy4p78bip0BYP2TDl2Ega1sllgcv
	 +c6Co0jTLuy2Dgl9GlweTdV6Qdy20SHQlHjx1L4Bu+kTsXe5CgH9nZdc1MqgyaazWq
	 gcBbZgcpxvHIrpg1pRKvXi9k9LOVY/bdA6RGDNwv3wY5V3ZSRPz20IzTZktGiQuYXo
	 rCrF3vwqhaYVeErHSgO76MkiynGqsXsAWDIE39M1ToJ9Ve2+q69ranrJFXU0TvVziO
	 NNLBOQGA9I1ag==
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
Subject: [PATCH 3/3] rust: io: mem: return DevresLt from IoMem/ExclusiveIoMem::into_devres()
Date: Wed,  6 May 2026 23:58:35 +0200
Message-ID: <20260506220012.855173-4-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506220012.855173-1-dakr@kernel.org>
References: <20260506220012.855173-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B39A4E106A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-8823-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Implement ForLt for IoMem<'static, SIZE> and ExclusiveIoMem<'static,
SIZE> so that DevresLt can shorten the stored 'static lifetime back to
the caller's borrow lifetime via ForLt::cast_ref.

Change into_devres() to return DevresLt instead of Devres; add
DevresIoMem<SIZE> and DevresExclusiveIoMem<SIZE> type aliases.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/pwm/pwm_th1520.rs |  5 ++--
 rust/kernel/io/mem.rs     | 55 ++++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 3deb39d8e0fc..6b094be35310 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -24,9 +24,8 @@
 use kernel::{
     clk::Clk,
     device::{Bound, Core, Device},
-    devres,
     io::{
-        mem::IoMem,
+        mem::DevresIoMem,
         Io, //
     },
     of, platform,
@@ -92,7 +91,7 @@ struct Th1520WfHw {
 #[pin_data(PinnedDrop)]
 struct Th1520PwmDriverData {
     #[pin]
-    iomem: devres::Devres<IoMem<'static, TH1520_PWM_REG_SIZE>>,
+    iomem: DevresIoMem<TH1520_PWM_REG_SIZE>,
     clk: Clk,
 }
 
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index a4cb12ee70d3..928aa7742490 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -9,7 +9,7 @@
         Bound,
         Device, //
     },
-    devres::Devres,
+    devres::DevresLt,
     io::{
         self,
         resource::{
@@ -20,6 +20,7 @@
         MmioRaw, //
     },
     prelude::*,
+    types::ForLt, //
 };
 
 /// An IO request for a specific device and resource.
@@ -170,6 +171,18 @@ pub struct ExclusiveIoMem<'bound, const SIZE: usize> {
     _region: Region,
 }
 
+// SAFETY: `ExclusiveIoMem<'bound, SIZE>` is covariant over `'bound` --
+// it holds an `IoMem<'bound, SIZE>`, which holds
+// `&'bound Device<Bound>`, which is covariant.
+unsafe impl<const SIZE: usize> ForLt for ExclusiveIoMem<'static, SIZE> {
+    type Of<'bound> = ExclusiveIoMem<'bound, SIZE>;
+}
+
+/// A device-managed exclusive I/O memory region.
+///
+/// See [`ExclusiveIoMem::into_devres`].
+pub type DevresExclusiveIoMem<const SIZE: usize> = DevresLt<ExclusiveIoMem<'static, SIZE>>;
+
 impl<'bound, const SIZE: usize> ExclusiveIoMem<'bound, SIZE> {
     /// Creates a new `ExclusiveIoMem` instance.
     fn ioremap(dev: &'bound Device<Bound>, resource: &Resource) -> Result<Self> {
@@ -196,15 +209,16 @@ fn ioremap(dev: &'bound Device<Bound>, resource: &Resource) -> Result<Self> {
 
     /// Consume the `ExclusiveIoMem` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<ExclusiveIoMem<'static, SIZE>>` can outlive the original lifetime
-    /// `'bound`. Access to the I/O memory is revoked when the device is unbound.
-    pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the
+    /// Access methods on the returned [`DevresLt`] shorten the inner lifetime via
+    /// [`ForLt::cast_ref`], so the transmuted `'static` is never exposed to callers.
+    pub fn into_devres(self) -> Result<DevresLt<ExclusiveIoMem<'static, SIZE>>> {
+        // SAFETY: Casting to `'static` is sound because `DevresLt` guarantees the
         // `ExclusiveIoMem` does not actually outlive the device -- access is revoked and the
-        // resource is released when the device is unbound.
+        // resource is released when the device is unbound. The `ForLt` encoding ensures
+        // `access()` shortens the lifetime back to the caller's borrow.
         let iomem: ExclusiveIoMem<'static, SIZE> = unsafe { core::mem::transmute(self) };
         let dev = iomem.iomem.dev;
-        Devres::new(dev, iomem)
+        DevresLt::new(dev, iomem)
     }
 }
 
@@ -230,6 +244,17 @@ pub struct IoMem<'bound, const SIZE: usize = 0> {
     io: MmioRaw<SIZE>,
 }
 
+// SAFETY: `IoMem<'bound, SIZE>` is covariant over `'bound` -- it holds
+// `&'bound Device<Bound>`, which is covariant.
+unsafe impl<const SIZE: usize> ForLt for IoMem<'static, SIZE> {
+    type Of<'bound> = IoMem<'bound, SIZE>;
+}
+
+/// A device-managed I/O memory region.
+///
+/// See [`IoMem::into_devres`].
+pub type DevresIoMem<const SIZE: usize> = DevresLt<IoMem<'static, SIZE>>;
+
 impl<'bound, const SIZE: usize> IoMem<'bound, SIZE> {
     fn ioremap(dev: &'bound Device<Bound>, resource: &Resource) -> Result<Self> {
         // Note: Some ioremap() implementations use types that depend on the CPU
@@ -269,16 +294,16 @@ fn ioremap(dev: &'bound Device<Bound>, resource: &Resource) -> Result<Self> {
 
     /// Consume the `IoMem` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<IoMem<'static, SIZE>>` can outlive the original
-    /// lifetime `'bound`. Access to the I/O memory is revoked when the device
-    /// is unbound.
-    pub fn into_devres(self) -> Result<Devres<IoMem<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the `IoMem` does not
-        // actually outlive the device -- access is revoked and the resource is released when the
-        // device is unbound.
+    /// Access methods on the returned [`DevresLt`] shorten the inner lifetime via
+    /// [`ForLt::cast_ref`], so the transmuted `'static` is never exposed to callers.
+    pub fn into_devres(self) -> Result<DevresLt<IoMem<'static, SIZE>>> {
+        // SAFETY: Casting to `'static` is sound because `DevresLt` guarantees the `IoMem` does
+        // not actually outlive the device -- access is revoked and the resource is released when
+        // the device is unbound. The `ForLt` encoding ensures `access()` shortens the lifetime
+        // back to the caller's borrow.
         let iomem: IoMem<'static, SIZE> = unsafe { core::mem::transmute(self) };
         let dev = iomem.dev;
-        Devres::new(dev, iomem)
+        DevresLt::new(dev, iomem)
     }
 }
 
-- 
2.54.0


