Return-Path: <linux-pwm+bounces-8920-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ISkOEQGCWouFgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8920-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:05:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51455E82A
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 02:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DB8B3019E41
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 00:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF041EBFE0;
	Sun, 17 May 2026 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjOj+CBh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9013D503;
	Sun, 17 May 2026 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778976267; cv=none; b=MbBttkoE+Ksi/SlP2kAbQzZ8MA9LQPZYNbYadxx3csL+TJwS9MJ2jDI3rA1jUvr3bO5ZoBUf2Y6iUIK/Vdo+VdQTqPuF6j9+GyqNOJnzyqWXaVpWPCldL+CDKQjMokJ4PfGjehWMDfequ8ph4jNtjpUNedihVTxsVmIwk2q9ryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778976267; c=relaxed/simple;
	bh=ImWkKMr51jdThWXlq5K+NSQ1sHsG37HbZQ3ZA/JKR6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3ily8xfZuHPPmBLgyCHWVcoWDdcab1a2nFSS3WuGKDkPfzP8vPGdGhHv+5CO11Vhd24iv9ygcRvKTRa4Qhnd2qwrwidryv24siCnofp7aMjyY0pCJ2lglTA+UrEFKsnJadvNNewDjJA00v3qR/DDEGWHngPyNWrNm5R8TqzgWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjOj+CBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CE9C2BCC9;
	Sun, 17 May 2026 00:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778976267;
	bh=ImWkKMr51jdThWXlq5K+NSQ1sHsG37HbZQ3ZA/JKR6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjOj+CBhIn+xHK9SsjdaWTDQqix/ibcFUqWq4UvsbtH1A0U2hA+HjEvjYhrMhiTt3
	 VMlesQmFcZyo0ibmh1nJBKC+VrwAIqnte2mB9uLgJdkIYACi8PlX8EAnk9KuBw3EBW
	 M3DV96/IL8+/wuDanAy+L43E6tsH1P2v4EdQOw2BdTfyk4lSFCYAEjh44XVw/oTJUY
	 AYJ8uWc9rUeimcnO34BI7izfofs8Rp4s32IqIAORlaBtqbsLd1qpgo6xDtiUn0qgdm
	 ojPJypIthIdS5b0NGbnN9EOOWt1NfQBpTXO8L2Crh/EBGpSGeW3Gp5l1UmMfLdzct4
	 b20jlS3NKeEyg==
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
Subject: [PATCH v3 21/27] samples: rust: rust_driver_pci: use HRT lifetime for Bar
Date: Sun, 17 May 2026 02:01:09 +0200
Message-ID: <20260517000149.3226762-22-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E51455E82A
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
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-8920-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,this.bar:url]
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
 1 file changed, 40 insertions(+), 49 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 7791363df0a0..f7240025bb0c 100644
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
@@ -66,14 +64,14 @@ impl TestIndex {
     const NO_EVENTFD: Self = Self(0);
 }
 
-#[pin_data(PinnedDrop)]
-struct SampleDriver {
-    pdev: ARef<pci::Device>,
-    #[pin]
-    bar: Devres<Bar0>,
+struct SampleDriverData<'bound> {
+    pdev: &'bound pci::Device,
+    bar: Bar0<'bound>,
     index: TestIndex,
 }
 
+struct SampleDriver;
+
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
@@ -84,8 +82,8 @@ struct SampleDriver {
     )]
 );
 
-impl SampleDriver {
-    fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
+impl SampleDriverData<'_> {
+    fn testdev(index: &TestIndex, bar: &Bar0<'_>) -> Result<u32> {
         // Select the test.
         bar.write_reg(regs::TEST::zeroed().with_index(*index));
 
@@ -140,56 +138,49 @@ fn config_space(pdev: &pci::Device<Bound>) {
 
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
-    type Data<'bound> = Self;
+    type Data<'bound> = SampleDriverData<'bound>;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core>,
         info: &'bound Self::IdInfo,
-    ) -> impl PinInit<Self, Error> + 'bound {
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
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
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
+            SampleDriverData::testdev(info, &bar)?
+        );
+        SampleDriverData::config_space(pdev);
+
+        Ok(SampleDriverData {
+            pdev,
+            bar,
+            index: *info,
         })
     }
 
-    fn unbind(pdev: &pci::Device<Core>, this: Pin<&Self>) {
-        if let Ok(bar) = this.bar.access(pdev.as_ref()) {
-            // Reset pci-testdev by writing a new test index.
-            bar.write_reg(regs::TEST::zeroed().with_index(this.index));
-        }
+    fn unbind<'bound>(_pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self::Data<'bound>>) {
+        this.bar
+            .write_reg(regs::TEST::zeroed().with_index(this.index));
     }
 }
 
-#[pinned_drop]
-impl PinnedDrop for SampleDriver {
-    fn drop(self: Pin<&mut Self>) {
+impl Drop for SampleDriverData<'_> {
+    fn drop(&mut self) {
         dev_dbg!(self.pdev, "Remove Rust PCI driver sample.\n");
     }
 }
-- 
2.54.0


