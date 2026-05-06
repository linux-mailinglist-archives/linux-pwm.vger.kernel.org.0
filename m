Return-Path: <linux-pwm+bounces-8808-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOZeGsK4+2k0DwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8808-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:55:14 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE25F4E0E24
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 23:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6588A3082E83
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D32B3B4E94;
	Wed,  6 May 2026 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkqig5py"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170553B47E6;
	Wed,  6 May 2026 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104376; cv=none; b=pjJ9CpbK1kZcU5EQxba0zbmIaG8MmyPtQ5AR7X7lowGe4cFphyvo8wKzMB/HUM9CqTZmMeLWQEWwpe7FuTd1x9aRrY4pJ2K/RDv0ObRO5Nt9ttAaw6pSAVrODMjiqv19YMJMo9VOvzendT/oiNa1v/efKKM/sR4LJ1d6Hh5G3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104376; c=relaxed/simple;
	bh=B41qhnlWkuJRcEF+9/CBmB57mbW1o1f5mPWmr/KvZ70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOsfJz/ySz8G0fHxfFpebZBdwq74S5sPDwlQPZKK0RF4G4Rnx/vEJr1+k1ytoPhWyNClOKx7pRziG/bj2OnCgVtn1jqugoK5nY8LMB/yBVzYYbjvC//kwD/jM3WiDmowMPIIOQcvR1eF1U91R0tKQAJLcGKf9KmBC2SJedGwpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkqig5py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCD3C2BCB0;
	Wed,  6 May 2026 21:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104376;
	bh=B41qhnlWkuJRcEF+9/CBmB57mbW1o1f5mPWmr/KvZ70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkqig5pyQxtuaOepYFe1QL+l62PRar/O4TMqB/FY0i5jpOQ+iEKmnJ5xa7UZcZvzb
	 MG7m/A6tvszZR8PzmaaCl0aq+g4Q/pjbqZRs7TLphD8jsuZAOgwrKxy8Gx+us694Ay
	 sS6FJljHKJjzTXJQzwKU4NXdXz8FlcLWC72HzgPZNHL2VNL+52mbVUcCO84MmM3zUR
	 XkQCK1wdyqO8o+HYrD+3cuOYeMSeZwlP1zvLuw0oSnzFTNf5FHGf5XEH2Sm4SJ6Neb
	 fEHjIUVuHp60RdeRKAaJSR2cjPaKSuGgyJtJ/b3LEpqHbTuhT8Bd2nKpSxn6Qwbn1x
	 wZz+IZpjVd8ow==
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
Subject: [PATCH v2 14/25] samples: rust: rust_driver_auxiliary: showcase lifetime-bound registration data
Date: Wed,  6 May 2026 23:50:50 +0200
Message-ID: <20260506215113.851360-15-dakr@kernel.org>
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
X-Rspamd-Queue-Id: DE25F4E0E24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8808-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Make the Data struct lifetime-parameterized, storing a reference to the
parent pci::Device<Bound>. This demonstrates that registration data can
hold device resources tied to the parent driver's lifetime.

In connect(), retrieve the parent PCI device from the registration data
rather than casting through adev.parent().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index de44ba901967..da445c4cc910 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -51,14 +51,15 @@ fn probe(
     }
 }
 
-struct Data {
+struct Data<'bound> {
     index: u32,
+    parent: &'bound pci::Device<Bound>,
 }
 
 #[allow(clippy::type_complexity)]
 struct ParentDriver {
-    _reg0: Devres<auxiliary::Registration<ForLt!(Data)>>,
-    _reg1: Devres<auxiliary::Registration<ForLt!(Data)>>,
+    _reg0: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
+    _reg1: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
 }
 
 kernel::pci_device_table!(
@@ -83,14 +84,20 @@ fn probe(
                 AUXILIARY_NAME,
                 0,
                 MODULE_NAME,
-                Data { index: 0 },
+                Data {
+                    index: 0,
+                    parent: pdev,
+                },
             )?,
             _reg1: auxiliary::Registration::new(
                 pdev.as_ref(),
                 AUXILIARY_NAME,
                 1,
                 MODULE_NAME,
-                Data { index: 1 },
+                Data {
+                    index: 1,
+                    parent: pdev,
+                },
             )?,
         })
     }
@@ -98,13 +105,11 @@ fn probe(
 
 impl ParentDriver {
     fn connect(adev: &auxiliary::Device<Bound>) -> Result {
-        let dev = adev.parent();
-        let pdev: &pci::Device<Bound> = dev.try_into()?;
-
-        let data = adev.registration_data::<ForLt!(Data)>()?;
+        let data = adev.registration_data::<ForLt!(Data<'_>)>()?;
+        let pdev = data.parent;
 
         dev_info!(
-            dev,
+            pdev,
             "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
             adev.id(),
             pdev.vendor_id(),
@@ -112,7 +117,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         );
 
         dev_info!(
-            dev,
+            pdev,
             "Connected to auxiliary device with index {}.\n",
             data.index
         );
-- 
2.54.0


