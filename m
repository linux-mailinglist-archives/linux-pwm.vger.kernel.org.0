Return-Path: <linux-pwm+bounces-8822-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBoZBGy6+2kxEAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8822-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:02:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 424BB4E10BA
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EB37301F357
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC83B4EBF;
	Wed,  6 May 2026 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A14q5gM6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640DC3B5305;
	Wed,  6 May 2026 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104847; cv=none; b=Lqlw33IGRK1+YnXaFjAHoF3stUK0KO+b9/WlBiwqY1f80jv8Er8q4xP+v9R+QCyCSS58dK+ADJefilbu2g3+mADNS89vDL67LxAJC2APx30bYsvsK7MNnp/nSftAYl0Pm2LCV3HshERi/QK/rizEiguieV4+ZOphaclbjpNNO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104847; c=relaxed/simple;
	bh=g+VFtZvKf6WOxAsZvmu6omoAgBIUzl+XzC7tNpmWzIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV1EFlVJNwnsZCwBHTnL8AS/5lyBJrAxlC+vZ3Gx02VfK7nB1x+i+sDo84vmfG5CayzMBQ1LVQwPWZ46EdqOKbjcr7zvG/xwuXaKm5xIl/JtZuFXDFLNRKONX8siBhVwaK3eAN1e+7H2KNDG4k4vafCeA9O5fhSda7kPHIdSL24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A14q5gM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A96EC2BCB2;
	Wed,  6 May 2026 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104846;
	bh=g+VFtZvKf6WOxAsZvmu6omoAgBIUzl+XzC7tNpmWzIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A14q5gM6aGbC2I6AMqUEeS3HHs2BKtkXPO3aDMJZy593n38fIbQNFfr2z32OJ2HZg
	 8kko1Oawj/aju7hvKtu0fmNMthou/yrcayyzJ945It9C/z/BMrxEUdynLDFbbXxVcX
	 m8tC66F9Zu2FImco+oDcVfRNZKsisY86Wm5kB05eeMRj6FQ45zxOCWhAACOudXNlch
	 HIiAE9+Hrcr3Drfyq+8nG1GJztuNUrK3POEpgoIL13tKe2jH0uQwzabKg+bEaKO2XD
	 WP+o9jGDTy2is5XI45w+xrDflxgjIafKI8mJSeJct/fgho30d2BEIgv3oA71aQjoMB
	 f/+yV0jMgwwwA==
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
Subject: [PATCH 2/3] rust: pci: return DevresLt from Bar::into_devres()
Date: Wed,  6 May 2026 23:58:34 +0200
Message-ID: <20260506220012.855173-3-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 424BB4E10BA
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
	TAGGED_FROM(0.00)[bounces-8822-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Implement ForLt for Bar<'static, SIZE> so that DevresLt can shorten the
stored 'static lifetime back to the caller's borrow lifetime via
ForLt::cast_ref. Without this, Devres<Bar<'static, SIZE>>::access()
would return &'bound Bar<'static, SIZE>, allowing the inner 'static to
leak through methods like pdev().

Add a DevresBar<SIZE> type alias for convenience.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs    |  1 +
 rust/kernel/pci/io.rs | 30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 1335857cae94..265d06b18e42 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -48,6 +48,7 @@
     ConfigSpace,
     ConfigSpaceKind,
     ConfigSpaceSize,
+    DevresBar,
     Extended,
     Normal, //
 };
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 5668394a155b..7a5b5210cf66 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -6,7 +6,7 @@
 use crate::{
     bindings,
     device,
-    devres::Devres,
+    devres::DevresLt,
     io::{
         Io,
         IoCapable,
@@ -14,7 +14,8 @@
         Mmio,
         MmioRaw, //
     },
-    prelude::*, //
+    prelude::*,
+    types::ForLt, //
 };
 use core::{
     marker::PhantomData,
@@ -151,6 +152,18 @@ pub struct Bar<'bound, const SIZE: usize = 0> {
     num: i32,
 }
 
+// SAFETY: `Bar<'bound, SIZE>` is covariant over `'bound` -- it holds
+// `&'bound Device<Bound>`, which is covariant. Shortening the lifetime
+// is therefore sound.
+unsafe impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
+    type Of<'bound> = Bar<'bound, SIZE>;
+}
+
+/// A device-managed PCI BAR mapping.
+///
+/// See [`Bar::into_devres`].
+pub type DevresBar<const SIZE: usize> = DevresLt<Bar<'static, SIZE>>;
+
 impl<'bound, const SIZE: usize> Bar<'bound, SIZE> {
     pub(super) fn new(pdev: &'bound Device<device::Bound>, num: u32, name: &CStr) -> Result<Self> {
         let len = pdev.resource_len(num)?;
@@ -219,15 +232,16 @@ fn release(&self) {
 
     /// Consume the `Bar` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<Bar<'static, SIZE>>` can outlive the original lifetime `'bound`. Access
-    /// to the BAR is revoked when the device is unbound.
-    pub fn into_devres(self) -> Result<Devres<Bar<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the `Bar` does not
+    /// Access methods on the returned [`DevresLt`] shorten the inner lifetime via
+    /// [`ForLt::cast_ref`], so the transmuted `'static` is never exposed to callers.
+    pub fn into_devres(self) -> Result<DevresLt<Bar<'static, SIZE>>> {
+        // SAFETY: Casting to `'static` is sound because `DevresLt` guarantees the `Bar` does not
         // actually outlive the device -- access is revoked and the resource is released when the
-        // device is unbound.
+        // device is unbound. The `ForLt` encoding ensures `access()` shortens the lifetime back
+        // to the caller's borrow, preventing `'static` from leaking.
         let bar: Bar<'static, SIZE> = unsafe { core::mem::transmute(self) };
         let pdev = bar.pdev;
-        Devres::new(pdev.as_ref(), bar)
+        DevresLt::new(pdev.as_ref(), bar)
     }
 }
 
-- 
2.54.0


