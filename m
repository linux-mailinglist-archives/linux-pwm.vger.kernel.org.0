Return-Path: <linux-pwm+bounces-9067-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Kk+iKriaD2qCNwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9067-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:52:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D165AD16F
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93DA130FA54F
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 23:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C577394E80;
	Thu, 21 May 2026 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHg2jr2c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545F383312;
	Thu, 21 May 2026 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406903; cv=none; b=N0qyvdHgFxRIHLkESQcHAUGGNv8ZTPnWp1t2VubmzjNxwASgpiVmaKzs6IVHOo0EM7XbbzG18n5hZxdSpyyYxnlsKl4x2w9ciOE0J1ZurBPEHfYsnlQkatEELV77sY6oe6J+1x29GdIEsk1SGxti5GBJqkPmB8uSk1rHn72mk0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406903; c=relaxed/simple;
	bh=O/PiN/M13rEh8PebwaJw39IrIuO/6xTAHGvIk/OXc/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUNryd7vHW2dL/CUU1pAYDN+TLGkZOArAHiZoN2TgdaLRt0XvX8hlTapto2SR5maE+Vdr/nIweChe//5i4/Kz1MrWGRtCi3FB6cpki0U2Uq49QtV4s61a0mvt2u2cH2KrVBWxCkvQv4vzNWOqGXHVshj7qv0e7Us0lkfZZTsl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHg2jr2c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6211F000E9;
	Thu, 21 May 2026 23:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406897;
	bh=zQyEv5LctNSyn/SsGR1f7Ge4LhX0SjTKeMVIeRtvjcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bHg2jr2cY1Ob9lxZl3xD91EiFjr5hGao1v6PV+MRSSQHxYN1KT29eQcZ3Y1XqKTUC
	 6vhBcBIBnDXCwJpzw8Aro+raBpSLGHJwP75OYAvxpbjTKPGH+L/pQdyIY1wNhYUHfM
	 NoXBOQPA7AEFL2paB9NMkq8crWHe8DDE119R4PjdTulQSoNu0B0I9/q/Ip96PV/D0Y
	 qen2+hxXbU6rGlPFI2beWYAWK4+BXUlNsgoYAixzEgOoYjpJgkDRsBDBlCJCwTSWve
	 NyCJGTff5873eqak1DoWV8w9SPQd/8OxATqMu30pCH98ii6LL+KRv8vzUQqYo8NpTy
	 72Lvz4qnQG4LA==
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
Subject: [PATCH v4 20/27] gpu: nova-core: separate driver type from driver data
Date: Fri, 22 May 2026 01:34:46 +0200
Message-ID: <20260521233501.1191842-21-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9067-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 93D165AD16F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce NovaCoreDriver as the driver type implementing pci::Driver,
keeping NovaCore as the per-device data type. This prepares for making
NovaCore lifetime-parameterized once auxiliary::Registration requires a
lifetime for the binding scope.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs    | 14 ++++++++------
 drivers/gpu/nova-core/nova_core.rs |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 7dbec0470c26..fa898fe5c893 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -35,6 +35,8 @@ pub(crate) struct NovaCore {
     _reg: Devres<auxiliary::Registration<()>>,
 }
 
+pub(crate) struct NovaCoreDriver;
+
 const BAR0_SIZE: usize = SZ_16M;
 
 // For now we only support Ampere which can use up to 47-bit DMA addresses.
@@ -50,7 +52,7 @@ pub(crate) struct NovaCore {
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <NovaCore as pci::Driver>::IdInfo,
+    <NovaCoreDriver as pci::Driver>::IdInfo,
     [
         // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
         (
@@ -72,15 +74,15 @@ pub(crate) struct NovaCore {
     ]
 );
 
-impl pci::Driver for NovaCore {
+impl pci::Driver for NovaCoreDriver {
     type IdInfo = ();
-    type Data<'bound> = Self;
+    type Data<'bound> = NovaCore;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
-    ) -> impl PinInit<Self, Error> + 'bound {
+    ) -> impl PinInit<NovaCore, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
@@ -98,7 +100,7 @@ fn probe<'bound>(
                 GFP_KERNEL,
             )?;
 
-            Ok(try_pin_init!(Self {
+            Ok(try_pin_init!(NovaCore {
                 gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_ref())?),
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
@@ -113,7 +115,7 @@ fn probe<'bound>(
         })
     }
 
-    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Self>) {
+    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&NovaCore>) {
         this.gpu.unbind(pdev.as_ref());
     }
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 04a1fa6b25f8..073d87714d3a 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -47,7 +47,7 @@ struct NovaCoreModule {
     // Fields are dropped in declaration order, so `_driver` is dropped first,
     // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
     #[pin]
-    _driver: Registration<pci::Adapter<driver::NovaCore>>,
+    _driver: Registration<pci::Adapter<driver::NovaCoreDriver>>,
     _debugfs_guard: DebugfsRootGuard,
 }
 
-- 
2.54.0


