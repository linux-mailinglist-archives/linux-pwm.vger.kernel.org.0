Return-Path: <linux-pwm+bounces-9432-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PWoIINPHPmqNLgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9432-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:41:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D20C26CFC37
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:41:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Pjv0/M6B";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9432-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9432-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE9F3303740B
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAE3B83E3;
	Fri, 26 Jun 2026 18:37:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22B3B8111;
	Fri, 26 Jun 2026 18:37:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499040; cv=none; b=h20FWLXUyY89qqNIxPa5cAWDfxmLjh9rsVlJ2M+o1rvkcOa75zTe+yxO3iqLcGRhkrOBDKnDAvW6KUn9zDA0yoMDDTcxzWcevL5XUwo+x4MkJI/6DKMgPeu/p4LdMRCkwYDp3C4UQ8NXzfIwTBZtCv2ncheOeitgNeTzBeTJf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499040; c=relaxed/simple;
	bh=3vq6P1Iw4sXv6SGnFg+bbfLw4+Lb6O7oa2Gy0xr+WUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skztqXmdepYju6xIzqTW+g75B1Lz6AjIDfZ8H86bKiVY3sc8Yi71Z5OoyR7IXEovBgqFdKJ2dRGN+PXmfeSyeEQ7adRi5TvwQjVIFm51P8v5B2TI5vO7kOrOsbUPM63ARgtcMTpuzer3i9VhLBus0aNGbYsqgVuj5Gbv+bVWZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjv0/M6B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DAE1F000E9;
	Fri, 26 Jun 2026 18:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499038;
	bh=6+T5BgRhhhJbLfHU3dWuWHcFHzu9JMvhs9bH+sGOzcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pjv0/M6BH1x/qeOi+9+m9NhNlLI7UO8quiwwWdGBBrUTndUHXbs1IByZ61m65CDig
	 4oo2Klw+IJUWAVXBrCwg+/FLlcQEwjW1ZRiLAbjSZmytMME/6ymQwP3meiUQyUkmt/
	 8Z8i0iz6QzWeZwppzrlA5dKKxJYZ0TNpYJ1prNC4ZnpwBI1prw42WPRpdPf0pq5ZBi
	 2c/R46UcwDIFu0Jff0150P//Sfwkk2CE2MwABxsFw+b4oUWycczdR0zVD7jmSKaCX2
	 8cNSHv/PrmAtgfZodt20iSd5Zs+15a6abPVR6EVtOsvqdgXyLnKPHLdC0M6hiUnxU8
	 HdrrE5vy4Wufw==
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
Subject: [PATCH v4 7/7] rust: io: mem: return DevresLt from IoMem/ExclusiveIoMem::into_devres()
Date: Fri, 26 Jun 2026 20:36:14 +0200
Message-ID: <20260626183630.2585057-8-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626183630.2585057-1-dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9432-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D20C26CFC37

Implement ForLt and CovariantForLt for IoMem<'static, SIZE> and
ExclusiveIoMem<'static, SIZE> so that DevresLt can shorten the stored
'static lifetime back to the caller's borrow lifetime.

CovariantForLt is sound because both types only hold &'a Device<Bound>,
which is covariant over 'a.

Since DevresLt::new() handles the lifetime transmutation internally,
into_devres() no longer needs an explicit transmute to 'static.

Add DevresIoMem<SIZE> and DevresExclusiveIoMem<SIZE> type aliases.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/pwm/pwm_th1520.rs |  5 ++-
 rust/kernel/io/mem.rs     | 65 +++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 3e3fa51ccef9..7102c60fd14b 100644
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
@@ -86,7 +85,7 @@ struct Th1520WfHw {
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


