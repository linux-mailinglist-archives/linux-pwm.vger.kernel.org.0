Return-Path: <linux-pwm+bounces-9070-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MytMqqbD2qCNwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9070-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:56:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3C5AD24F
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 01:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46346309F65C
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B58E3A48C8;
	Thu, 21 May 2026 23:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/AMtvU7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318B383312;
	Thu, 21 May 2026 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779406924; cv=none; b=IVYKnCPyIIbHvHkk1cD4bpBGCsJUubDKxxXYOA88aZqh2cqx1rSGRCb1a9yZmTAxlA164KUsgPgxLtY6EmIfmtRWyN1FDsCxG4zwhI0GH9Ej0/NASm2VxyzQQnF+XL8m5LUrI4kVpFGqpvSPWpL3m5mft1LbKwe0cz8PLArsRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779406924; c=relaxed/simple;
	bh=URv7kDky/fzF48yyZX8bZFxKK2Zco6+d0cntaCwf/Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFM6zFeb9+u0jBAeMmssBGRpwB9s6etv/24JJscDfqsNwI/6YfmUeA1ZaUC0yIAaPIfGDBdf67izimZNCdO2f69WuI0E9qBsYFOqoSGDN29VklWGFM2eAW2XreIstW3wH7DGLskgY3yzsXG1D91wruer9Jl3lTI/ybGKAXJbo6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/AMtvU7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C47D1F00A3F;
	Thu, 21 May 2026 23:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779406917;
	bh=K3j4lL+2mHxp0flNXouCMSDh28DfNlEwKKwd9IHTneY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T/AMtvU7TEIn4q026laXEglQYz0gh9HbSnPY1WlGi9txqlikR/jJq2HXA+5B6etyf
	 u02+XzLy7UXY8wvyvVLeBLsbBi4cxT29Ss4BpqDELTg4njoJ9JHLxACVxjDXMeCNuu
	 Svqoi/LLDWurkwVK2Phtk6a1BzMTZi76s4c7diSvir0cIt57y7d3vn6VinK9FBwUqa
	 vwowsKkh+vCk4WDgPKxmxeknikdunoxvNOdJBIRFmWAzZDjqyPCmbdLCnixiXJwVuO
	 8hWF/p2OPBlmAkllu3+zdLoPHcIuOL4NQLELdKf/ENX4GpSQAfu7/I+j2HSPxpcnoG
	 LRalpVdJJ4VEQ==
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
Subject: [PATCH v4 23/27] samples: rust: rust_driver_auxiliary: showcase lifetime-bound registration data
Date: Fri, 22 May 2026 01:34:49 +0200
Message-ID: <20260521233501.1191842-24-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-9070-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: 63B3C5AD24F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make the Data struct lifetime-parameterized, storing a reference to the
parent pci::Device<Bound>. This demonstrates that registration data can
hold device resources tied to the parent driver's lifetime.

In connect(), retrieve the parent PCI device from the registration data
rather than casting through adev.parent().

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
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


