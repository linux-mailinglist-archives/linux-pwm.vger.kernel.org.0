Return-Path: <linux-pwm+bounces-8813-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA3SM/C5+2kxEAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8813-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:00:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE1D4E0FF8
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97E530B1102
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA43B7774;
	Wed,  6 May 2026 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNmvh8hJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AAB3B47F1;
	Wed,  6 May 2026 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104410; cv=none; b=taDG0Hvthb1p4+HX0YNtAVLUV8eCw+CAR4hr9whFzg8RNb4W9cJfThQYpwkCwRoKzDfBu8+UVFVKSOogoWmoWBgf5P95+q6/y3HHGcpXsoEca9G/Cm7N8syNgocjvZYdw/JXxLHUUqhfHQw9z+z5fHuSdgqZohZbAefvMrxQyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104410; c=relaxed/simple;
	bh=eNzpTvhmzibrNZ7+pOvewsfEGIExrdgY3tVgUF7aVt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0ZMaPZbR/AVJteWclKBbpirQeLO8YygIN/K+hNuvtH1j5hYiYonNSRFTo3aT77pcfP4p8XvQJKYu4agYbb2NzA6Rv7btujH4O6JhC7rcEBkb0mawQvh4sUW+8brGymiuDbLLLKtUvPMhshwd+guXKtmr8vK8FCTzqAHhx9h9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNmvh8hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651ECC2BCF5;
	Wed,  6 May 2026 21:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104409;
	bh=eNzpTvhmzibrNZ7+pOvewsfEGIExrdgY3tVgUF7aVt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNmvh8hJd5VlZAfnTNiW15wW4oU4VlOju5HNc1H30/6+ngs78wFHVCXuvg0uftl3Q
	 tWv9P70WoJ4VPB4OPRe0KOjdk3mkzHbLkYnsF+ML3cpz7T79ZMQVl/3oYHPJ9sYh/c
	 //mrsPGVehfUfqB7Z4eAejw1IvzY0nkA84AeHj0gSk46PdtaycobJUoBq9B8jSNOhN
	 ainGZY8s0C9ZcVOm95b0SDMchtikZMoGrM4w3i9WFPnlSjFf9gOJdKd3AzjO3B81wp
	 G6GFUXQSBlICG4nPULdgnvtBFTurNO3YrpTtyf5PvolaLZeDyuRVR9zw9j313quem3
	 Nq87CLxxFtp2A==
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
Subject: [PATCH v2 19/25] samples: rust: rust_driver_pci: use HRT lifetime for Bar
Date: Wed,  6 May 2026 23:50:55 +0200
Message-ID: <20260506215113.851360-20-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AE1D4E0FF8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-8813-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[this.bar:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert the sample driver to SampleDriver<'bound>, taking advantage of
the lifetime-parameterized Driver trait.

The driver struct holds &'bound pci::Device directly instead of
ARef<pci::Device>, and pci::Bar<'bound> directly instead of
Devres<pci::Bar>. This removes PinnedDrop, pin_init_scope, and runtime
revocation checks on BAR access.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_pci.rs | 89 +++++++++++++++------------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index bbcb816456e0..a7b7e580685c 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -9,7 +9,6 @@
         Bound,
         Core, //
     },
-    devres::Devres,
     io::{
         register,
         register::Array,
@@ -17,8 +16,7 @@
     },
     num::Bounded,
     pci,
-    prelude::*,
-    sync::aref::ARef, //
+    prelude::*, //
 };
 
 mod regs {
@@ -45,7 +43,7 @@ mod regs {
     pub(super) const END: usize = 0x10;
 }
 
-type Bar0 = pci::Bar<'static, { regs::END }>;
+type Bar0<'bound> = pci::Bar<'bound, { regs::END }>;
 
 #[derive(Copy, Clone, Debug)]
 struct TestIndex(u8);
@@ -66,26 +64,24 @@ impl TestIndex {
     const NO_EVENTFD: Self = Self(0);
 }
 
-#[pin_data(PinnedDrop)]
-struct SampleDriver {
-    pdev: ARef<pci::Device>,
-    #[pin]
-    bar: Devres<Bar0>,
+struct SampleDriver<'bound> {
+    pdev: &'bound pci::Device,
+    bar: Bar0<'bound>,
     index: TestIndex,
 }
 
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <SampleDriver as pci::Driver<'_>>::IdInfo,
+    <SampleDriver<'_> as pci::Driver<'_>>::IdInfo,
     [(
         pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
         TestIndex::NO_EVENTFD
     )]
 );
 
-impl SampleDriver {
-    fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
+impl SampleDriver<'_> {
+    fn testdev(index: &TestIndex, bar: &Bar0<'_>) -> Result<u32> {
         // Select the test.
         bar.write_reg(regs::TEST::zeroed().with_index(*index));
 
@@ -138,7 +134,7 @@ fn config_space(pdev: &pci::Device<Bound>) {
     }
 }
 
-impl<'bound> pci::Driver<'bound> for SampleDriver {
+impl<'bound> pci::Driver<'bound> for SampleDriver<'bound> {
     type IdInfo = TestIndex;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
@@ -147,54 +143,47 @@ fn probe(
         pdev: &'bound pci::Device<Core>,
         info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self, Error> + 'bound {
-        pin_init::pin_init_scope(move || {
-            let vendor = pdev.vendor_id();
-            dev_dbg!(
-                pdev,
-                "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
-                vendor,
-                pdev.device_id()
-            );
-
-            pdev.enable_device_mem()?;
-            pdev.set_master();
-
-            Ok(try_pin_init!(Self {
-                bar: pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_pci")?
-                    .into_devres()?,
-                index: *info,
-                _: {
-                    let bar = bar.access(pdev.as_ref())?;
-
-                    dev_info!(
-                        pdev,
-                        "pci-testdev data-match count: {}\n",
-                        Self::testdev(info, bar)?
-                    );
-                    Self::config_space(pdev);
-                },
-                pdev: pdev.into(),
-            }))
+        let vendor = pdev.vendor_id();
+        dev_dbg!(
+            pdev,
+            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
+            vendor,
+            pdev.device_id()
+        );
+
+        pdev.enable_device_mem()?;
+        pdev.set_master();
+
+        let bar = pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_pci")?;
+
+        dev_info!(
+            pdev,
+            "pci-testdev data-match count: {}\n",
+            Self::testdev(info, &bar)?
+        );
+        Self::config_space(pdev);
+
+        Ok(Self {
+            pdev,
+            bar,
+            index: *info,
         })
     }
 
-    fn unbind(pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self>) {
-        if let Ok(bar) = this.bar.access(pdev.as_ref()) {
-            // Reset pci-testdev by writing a new test index.
-            bar.write_reg(regs::TEST::zeroed().with_index(this.index));
-        }
+    fn unbind(_pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self>) {
+        this.bar
+            .write_reg(regs::TEST::zeroed().with_index(this.index));
     }
 }
 
-#[pinned_drop]
-impl PinnedDrop for SampleDriver {
-    fn drop(self: Pin<&mut Self>) {
+impl Drop for SampleDriver<'_> {
+    fn drop(&mut self) {
         dev_dbg!(self.pdev, "Remove Rust PCI driver sample.\n");
     }
 }
 
 kernel::module_pci_driver! {
-    type: SampleDriver,
+    type: SampleDriver<'_>,
     name: "rust_driver_pci",
     authors: ["Danilo Krummrich"],
     description: "Rust PCI driver",
-- 
2.54.0


