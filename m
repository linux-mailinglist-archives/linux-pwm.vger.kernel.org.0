Return-Path: <linux-pwm+bounces-9147-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCATB1izFGoHPgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9147-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:38:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 847AF5CE9D8
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C6D2304E40C
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79A03A8FE8;
	Mon, 25 May 2026 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB36nmiP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79E3A2E12;
	Mon, 25 May 2026 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741123; cv=none; b=CHjglhpwlQMIqQOEIoB1b0xFhxbZa8fStf4wiJfQXkPyBY/0kah6qot2wbLb1Mkka+pqGvOzIoNZ47KwHJnZNkCzZU05LR4M651+u8562PBbPR+7bFsMsjDBIq8/3mVTrljqdBacinhjmQZ0pSyXO+tEosFq7evtfcJZsmzdnQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741123; c=relaxed/simple;
	bh=eMZYEAwO/dcQVCHMuVBPQlQnic9bmNikibb0MAHefbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrZZ982uq5UP5usjSpghmg+FsuEgMDAsL1vLbzjUcxOVOGrF9EtuQ7noe58sY9uTlQz68GdABKZxZiJHLY8QTyJYtGXBINI0T/yaoPm9SpWIMIrz2/W1MDsuVFCr2mycbMTQ8U9JSYfS5bVvu8rO/Jbabnl1YsB+rKqEa6ltaxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB36nmiP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313461F00A3A;
	Mon, 25 May 2026 20:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741122;
	bh=cz4y8M1GiwY6FWOeDCyuhnlKEpB7EMBObHZNfzMoKFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kB36nmiPeLWjK9MuZYO1n2hhOVi1mahYYeE42W+5vQvO7zNrGoUHFZhxd1AxFPRTY
	 yEthQETelTJ/OzNxVRaJ7e80BFACQSImycJoXQYlsHtRqcBu5KAMw+9ufCabc3f7+b
	 AlwV97p4vX4lsdIf7ZFlrexP1rr0h2n9SRMrUOKcdAlz8iK9ErbmXmx9yrTUGyJz3C
	 6YlR3TxSSuY2TeK7eaQVHo2FA2G+yvbMo+qR3+Y4HGs3PdvEin70Ik/V7Kv008hN0K
	 /sxxVcq6Kj2l5RlAedLUjwOaFi1/yHxhUitBTK+P3f796Pjvf5TUYwa0weV6m7BepT
	 ifCWNxla4rVNQ==
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
Subject: [PATCH v5 21/24] gpu: nova-core: separate driver type from driver data
Date: Mon, 25 May 2026 22:21:08 +0200
Message-ID: <20260525202921.124698-22-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9147-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 847AF5CE9D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce NovaCoreDriver as the driver type implementing pci::Driver,
keeping NovaCore as the per-device data type. This prepares for making
NovaCore lifetime-parameterized once auxiliary::Registration requires a
lifetime for the binding scope.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
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


