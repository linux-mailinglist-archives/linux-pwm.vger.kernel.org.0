Return-Path: <linux-pwm+bounces-9232-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u9PyNjqAH2oamgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9232-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 03:15:38 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E26335C9
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 03:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LgEpdA1y;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9232-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9232-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81CA730EF660
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D057305664;
	Wed,  3 Jun 2026 01:11:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60110305662;
	Wed,  3 Jun 2026 01:11:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449065; cv=none; b=YF9TTNE/qD4Z8Id/fPqyHjdE4vcJEMVhO+fbsxUkK0TNKgm+WyuKBA2zVK/BaexKBwVNZs2BupsTg4+UNqkJ5XtlYovjoWL4xB/2L2gQS7DOlBA1hNbnlioiTSH1Tlki3hQ5hU5k+J/00VDUJLyQy+G3w7A+X1YnG1x7dYlUC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449065; c=relaxed/simple;
	bh=/bCT7cXo08Ww3XUqF/QPMJs5sd3D3wwtWPa/7j4ewPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdtJASaoDdRDnYNCEIzPDcXu+8yTeqMtcB7HB3ocg/9qF/Lk7eID9RUUhVV6H41pU3lkIB8gZrXyh7tNyUE4W49bFRqHD58F5+zcZNwiUyn9GQhTwJoECn8an8ron3Rl6uz5yMFKPqZi7CuQMLEde8tMCBE8GVEdsfMDJbKoWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgEpdA1y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1964E1F00898;
	Wed,  3 Jun 2026 01:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780449063;
	bh=6kwWxpERwhRfbh+IYbhqXFQAvVIriNywyEds62Ao6CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LgEpdA1ysW/6aW4sNfMAY+vmwXWjmraQAX/521n//865SRjUM0K5USCa9W0rmp8mV
	 kJtjn0vbIlFRpLBSMH43IbdFtr5qpA/M8wS61jkuHqzV7pdAmYFVADgmJfM6g4LFbX
	 s5zVBwIWG5EciXEKIUiIL2smDUQttiYVMhQk1/KnPtxfDjZlQ875R9Mz6N7/29y4Gn
	 R+vrN2bF5qjOx7t8sh+3y0GFri5uDP2GcL/qsEaoDAO1YWilBBoD+u+mqmgVufANnA
	 ykfuJna16K/nJ4u36Odn3M0lIuL2fh2YVfrSjmvTdn/r67lelpXpXm1CuGc9lLcdsd
	 mOzs+75PWde7g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	ecourtney@nvidia.com,
	m.wilczynski@samsung.com,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	daniel.almeida@collabora.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 7/7] rust: io: mem: return DevresLt from IoMem/ExclusiveIoMem::into_devres()
Date: Wed,  3 Jun 2026 03:10:18 +0200
Message-ID: <20260603011020.2073650-8-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603011020.2073650-1-dakr@kernel.org>
References: <20260603011020.2073650-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9232-lists,linux-pwm=lfdr.de];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 728E26335C9

Implement ForLt and CovariantForLt for IoMem<'static, SIZE> and
ExclusiveIoMem<'static, SIZE> so that DevresLt can shorten the stored
'static lifetime back to the caller's borrow lifetime.

CovariantForLt is sound because both types only hold &'a Device<Bound>,
which is covariant over 'a.

Since DevresLt::new() handles the lifetime transmutation internally,
into_devres() no longer needs an explicit transmute to 'static.

Add DevresIoMem<SIZE> and DevresExclusiveIoMem<SIZE> type aliases.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/pwm/pwm_th1520.rs |  5 ++-
 rust/kernel/io/mem.rs     | 65 +++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 48808cd80737..7e3a06ed369f 100644
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
index fc2a3e24f8d5..4691a01a3cf7 100644
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
@@ -20,6 +20,10 @@
         MmioRaw, //
     },
     prelude::*,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    },
 };
 
 /// An IO request for a specific device and resource.
@@ -172,6 +176,19 @@ pub struct ExclusiveIoMem<'a, const SIZE: usize> {
     _region: Region,
 }
 
+impl<const SIZE: usize> ForLt for ExclusiveIoMem<'static, SIZE> {
+    type Of<'a> = ExclusiveIoMem<'a, SIZE>;
+}
+
+// SAFETY: `ExclusiveIoMem<'a, SIZE>` is covariant over `'a`; it holds an `IoMem<'a, SIZE>`,
+// which holds `&'a Device<Bound>`, which is covariant.
+unsafe impl<const SIZE: usize> CovariantForLt for ExclusiveIoMem<'static, SIZE> {}
+
+/// A device-managed exclusive I/O memory region.
+///
+/// See [`ExclusiveIoMem::into_devres`].
+pub type DevresExclusiveIoMem<const SIZE: usize> = DevresLt<ExclusiveIoMem<'static, SIZE>>;
+
 impl<'a, const SIZE: usize> ExclusiveIoMem<'a, SIZE> {
     /// Creates a new `ExclusiveIoMem` instance.
     fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
@@ -198,15 +215,13 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
 
     /// Consume the `ExclusiveIoMem` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<ExclusiveIoMem<'static, SIZE>>` can outlive the original lifetime
-    /// `'a`. Access to the I/O memory is revoked when the device is unbound.
-    pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the
-        // `ExclusiveIoMem` does not actually outlive the device -- access is revoked and the
-        // resource is released when the device is unbound.
-        let iomem: ExclusiveIoMem<'static, SIZE> = unsafe { core::mem::transmute(self) };
-        let dev = iomem.iomem.dev;
-        Devres::new(dev, iomem)
+    /// The returned [`DevresExclusiveIoMem`] can outlive the original borrow and be stored in
+    /// driver data. Access to the I/O memory is revoked automatically when the device is unbound.
+    pub fn into_devres(self) -> Result<DevresExclusiveIoMem<SIZE>> {
+        let dev = self.iomem.dev;
+        // SAFETY: `ExclusiveIoMem` only holds a device reference and an I/O mapping, both of
+        // which remain valid for the device's full bound scope, not just for `'a`.
+        unsafe { DevresLt::new(dev, self) }
     }
 }
 
@@ -232,6 +247,19 @@ pub struct IoMem<'a, const SIZE: usize = 0> {
     io: MmioRaw<SIZE>,
 }
 
+impl<const SIZE: usize> ForLt for IoMem<'static, SIZE> {
+    type Of<'a> = IoMem<'a, SIZE>;
+}
+
+// SAFETY: `IoMem<'a, SIZE>` is covariant over `'a`; it holds `&'a Device<Bound>`,
+// which is covariant.
+unsafe impl<const SIZE: usize> CovariantForLt for IoMem<'static, SIZE> {}
+
+/// A device-managed I/O memory region.
+///
+/// See [`IoMem::into_devres`].
+pub type DevresIoMem<const SIZE: usize> = DevresLt<IoMem<'static, SIZE>>;
+
 impl<'a, const SIZE: usize> IoMem<'a, SIZE> {
     fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
         // Note: Some ioremap() implementations use types that depend on the CPU
@@ -271,16 +299,13 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
 
     /// Consume the `IoMem` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<IoMem<'static, SIZE>>` can outlive the original
-    /// lifetime `'a`. Access to the I/O memory is revoked when the device
-    /// is unbound.
-    pub fn into_devres(self) -> Result<Devres<IoMem<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the `IoMem` does not
-        // actually outlive the device -- access is revoked and the resource is released when the
-        // device is unbound.
-        let iomem: IoMem<'static, SIZE> = unsafe { core::mem::transmute(self) };
-        let dev = iomem.dev;
-        Devres::new(dev, iomem)
+    /// The returned [`DevresIoMem`] can outlive the original borrow and be stored in driver data.
+    /// Access to the I/O memory is revoked automatically when the device is unbound.
+    pub fn into_devres(self) -> Result<DevresIoMem<SIZE>> {
+        let dev = self.dev;
+        // SAFETY: `IoMem` only holds a device reference and an I/O mapping, both of which
+        // remain valid for the device's full bound scope, not just for `'a`.
+        unsafe { DevresLt::new(dev, self) }
     }
 }
 
-- 
2.54.0


