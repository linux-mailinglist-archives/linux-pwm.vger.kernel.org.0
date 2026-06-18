Return-Path: <linux-pwm+bounces-9337-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Br6YE8B6NGrpZAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9337-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2026 01:09:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1FD6A308A
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2026 01:09:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X819JO3I;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9337-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9337-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AA5C303B6F0
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 23:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667B351C2E;
	Thu, 18 Jun 2026 23:09:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AED347514;
	Thu, 18 Jun 2026 23:09:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824164; cv=none; b=XbGLz1pX9TuWlLMkdBDCpfpRKh/tO8TwxNjLYf6bLrzmjFQ6mEWz0m7dUrJFnNoImG6Gl3jUJfUpzz88c94A7fkiyWaU5IKnd7UPMjc0Ex80hcZ3MOKUSjIxmsbdkxU0UjZ39Pm18hxUEs2bTe4eOJtd3x1pjSBdPGqE4AqDJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824164; c=relaxed/simple;
	bh=TURasSuevhvFKc+WXuz6qvRLMMGZvPymK0qyzJQs2xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDva9uGulIdnDy7mrFZL1qCkcFIZVgLsu0eRULUvqhf0dAFmlb98VHHnvnb64CsmR8Q7PRjCHVco6kjveUUtfaMhKNiy0fu74TjLn0TvXd2uH7GJHwoUq5kkelZIgKkDkM70KUzQnTuDVpDh+X9bk9lGByo2rbQumscC8IBvcOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X819JO3I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA4A1F000E9;
	Thu, 18 Jun 2026 23:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781824163;
	bh=jFXBZlmIt6khk0+6CdihUMf27NKcoYEyolnsYS/5aD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X819JO3IAK4jIkeqmgnKAyht47R3LHlJjzCgukO+hm0wqSQdQOwEMEuhodoGFW1RC
	 BIx21AZ9emvWS0v9PcR8TRrnfpTcTMZ9e/RfOO2vq1F8cysVAsypvKS3IXFN6Y7LNA
	 pY6EXS5Rj5SPv6/aZ742xiFmd+zn5hZmaL4aq2kQtfJ7b9mhlG2Gqe/CX4/8fGMm/y
	 i8h5yiZ/sSDIGYlJ1qeBvIgYi+8yghkfB6uMUVoGXKyydaY9963K3Gabpzhbx6ORIL
	 YcVDi6LjhMjdIc/Y0Rln5M4VyYE451pkPIgppRQNFfDN2Z3OpONbIR4/ESQ7oPtDLc
	 qXj0EcgaB2wkA==
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
Subject: [PATCH v3 6/7] rust: pci: return DevresLt from Bar::into_devres()
Date: Fri, 19 Jun 2026 01:08:32 +0200
Message-ID: <20260618230834.812007-7-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618230834.812007-1-dakr@kernel.org>
References: <20260618230834.812007-1-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9337-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED1FD6A308A

Implement ForLt and CovariantForLt for Bar<'static, SIZE> so that
DevresLt can shorten the stored 'static lifetime back to the caller's
borrow lifetime.

CovariantForLt is sound because Bar<'a, SIZE> only holds &'a
Device<Bound>, which is covariant over 'a.

Since DevresLt::new() handles the lifetime transmutation internally,
into_devres() no longer needs an explicit transmute to Bar<'static>.

Add a DevresBar<SIZE> type alias for convenience.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs    |  1 +
 rust/kernel/pci/io.rs | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..f783b9d9fa26 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -45,6 +45,7 @@
     ConfigSpace,
     ConfigSpaceKind,
     ConfigSpaceSize,
+    DevresBar,
     Extended,
     Normal, //
 };
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 0461e01aaa20..7a0d2d74129d 100644
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
@@ -14,7 +14,11 @@
         Mmio,
         MmioRaw, //
     },
-    prelude::*, //
+    prelude::*,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    }, //
 };
 use core::{
     marker::PhantomData,
@@ -151,6 +155,19 @@ pub struct Bar<'a, const SIZE: usize = 0> {
     num: i32,
 }
 
+impl<const SIZE: usize> ForLt for Bar<'static, SIZE> {
+    type Of<'a> = Bar<'a, SIZE>;
+}
+
+// SAFETY: `Bar<'a, SIZE>` is covariant over `'a`; it holds `&'a Device<Bound>`,
+// which is covariant.
+unsafe impl<const SIZE: usize> CovariantForLt for Bar<'static, SIZE> {}
+
+/// A device-managed PCI BAR mapping.
+///
+/// See [`Bar::into_devres`].
+pub type DevresBar<const SIZE: usize> = DevresLt<Bar<'static, SIZE>>;
+
 impl<'a, const SIZE: usize> Bar<'a, SIZE> {
     pub(super) fn new(
         pdev: &'a Device<device::Bound>,
@@ -223,15 +240,13 @@ fn release(&self) {
 
     /// Consume the `Bar` and register it as a device-managed resource.
     ///
-    /// The returned `Devres<Bar<'static, SIZE>>` can outlive the original lifetime `'a`. Access
-    /// to the BAR is revoked when the device is unbound.
-    pub fn into_devres(self) -> Result<Devres<Bar<'static, SIZE>>> {
-        // SAFETY: Casting to `'static` is sound because `Devres` guarantees the `Bar` does not
-        // actually outlive the device -- access is revoked and the resource is released when the
-        // device is unbound.
-        let bar: Bar<'static, SIZE> = unsafe { core::mem::transmute(self) };
-        let pdev = bar.pdev;
-        Devres::new(pdev.as_ref(), bar)
+    /// The returned [`DevresBar`] can outlive the original borrow and be stored in driver data.
+    /// Access to the BAR is revoked automatically when the device is unbound.
+    pub fn into_devres(self) -> Result<DevresBar<SIZE>> {
+        let pdev = self.pdev;
+        // SAFETY: `Bar` only holds a reference to the device and an I/O mapping, both of which
+        // remain valid for the device's full bound scope, not just for `'a`.
+        unsafe { DevresLt::new(pdev.as_ref(), self) }
     }
 }
 
-- 
2.54.0


