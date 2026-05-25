Return-Path: <linux-pwm+bounces-9150-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC1yMBu0FGpDPgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9150-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:42:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7695CEAE1
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 22:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44288307EE1D
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 20:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F176E3AE704;
	Mon, 25 May 2026 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5Z15P9j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD2388363;
	Mon, 25 May 2026 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741145; cv=none; b=cNgld8Zjrqv00uy3tbspT9WeUlzO3liyLSo9ihkzcl91sGrKaGRbSOXdu/lPE36zffMeIlh7YKXKlFH9/LUZwqOK19ViPu9Kro542hbCYNlS+arzaSbnQLO/mPHuqyjFmmI4Mj+/XOx/UvSJWssMS5ZD7smiSNdRcj4CQuRFIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741145; c=relaxed/simple;
	bh=n9OSdO3AwMmlBW0KtaOxaurI9/V+4mxLjp0ERUUz9nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGR6gBjiieySNa93kFsAp/QlF3o23HYyHiqscYzw72pVc28tn5N1W16i84hwNZY8ANwsTAt2aVmqwX2Sfp7T2LFzHInxWdcqzz5BQubJBIv1FuscIWNCqPz3lhvRzy1AuasYhVtjihPRkKoCK/LhkzDRz5rKpGQIPsC3cOTcfck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5Z15P9j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F31F000E9;
	Mon, 25 May 2026 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779741144;
	bh=+rPmKZf6uaQzYhVqY2DDZC+3sDd3VtNWS1o0vbSmOWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E5Z15P9jRyUCpIVYHnJfOk9/D8atKgXHRLvLuzY1yly8rDaOEcFJr6aenLpt9wHkp
	 /w1H2/iDK/CnanATE6FZIVUJjMGIiJaMeujyma+KBb5394RaHkIALs2YfTi5S4eZQZ
	 IVmrNIqu0IQYPP5bqkgyH5stRJqYoDMAzQb4A9Jkw2dJoegGPX1CSsF+cCMMZ56PG7
	 QR0c7fRMSXTWyNelz2+V3zbiV6ZLXRloDG7wZ48WsDWNiMGDkVK6VBjERevJDCeaeI
	 GohDsI7+lvwSPSkn9t8Cud0GrpoCkF8iQUbbZLpfaCFu+vtTFo/qYNVAEJKeNpHz2x
	 UHOVDH2VZAwEg==
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
Subject: [PATCH v5 24/24] samples: rust: rust_driver_auxiliary: showcase lifetime-bound registration data
Date: Mon, 25 May 2026 22:21:11 +0200
Message-ID: <20260525202921.124698-25-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9150-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CA7695CEAE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make the Data struct lifetime-parameterized, storing a reference to the
parent pci::Device<Bound>. This demonstrates that registration data can
hold device resources tied to the parent driver's lifetime.

In connect(), retrieve the parent PCI device from the registration data
rather than casting through adev.parent().

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 58 ++++++++++++++++-----------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index e3e811a14110..2c1351040e45 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -51,16 +51,17 @@ fn probe<'bound>(
     }
 }
 
-struct Data {
+struct Data<'bound> {
     index: u32,
+    parent: &'bound pci::Device<Bound>,
 }
 
 struct ParentDriver;
 
 #[allow(clippy::type_complexity)]
 struct ParentData<'bound> {
-    _reg0: auxiliary::Registration<'bound, ForLt!(Data)>,
-    _reg1: auxiliary::Registration<'bound, ForLt!(Data)>,
+    _reg0: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
+    _reg1: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
 }
 
 kernel::pci_device_table!(
@@ -81,33 +82,44 @@ fn probe<'bound>(
         _info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         Ok(ParentData {
-            _reg0: auxiliary::Registration::new(
-                pdev.as_ref(),
-                AUXILIARY_NAME,
-                0,
-                MODULE_NAME,
-                Data { index: 0 },
-            )?,
-            _reg1: auxiliary::Registration::new(
-                pdev.as_ref(),
-                AUXILIARY_NAME,
-                1,
-                MODULE_NAME,
-                Data { index: 1 },
-            )?,
+            // SAFETY: `ParentData` is the driver's private data, which is dropped when the
+            // device is unbound; i.e. `mem::forget()` is never called on it.
+            _reg0: unsafe {
+                auxiliary::Registration::new_with_lt(
+                    pdev.as_ref(),
+                    AUXILIARY_NAME,
+                    0,
+                    MODULE_NAME,
+                    Data {
+                        index: 0,
+                        parent: pdev,
+                    },
+                )?
+            },
+            // SAFETY: See `_reg0` above.
+            _reg1: unsafe {
+                auxiliary::Registration::new_with_lt(
+                    pdev.as_ref(),
+                    AUXILIARY_NAME,
+                    1,
+                    MODULE_NAME,
+                    Data {
+                        index: 1,
+                        parent: pdev,
+                    },
+                )?
+            },
         })
     }
 }
 
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
@@ -115,7 +127,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         );
 
         dev_info!(
-            dev,
+            pdev,
             "Connected to auxiliary device with index {}.\n",
             data.index
         );
-- 
2.54.0


