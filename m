Return-Path: <linux-pwm+bounces-8718-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EUwC2Dg72kHHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8718-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:17:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4000547B4A4
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9101030147B9
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B533AD52A;
	Mon, 27 Apr 2026 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQGkmtrf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58853AC0FB;
	Mon, 27 Apr 2026 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328023; cv=none; b=fJ8fw+/C34HBqOmBFpYleI6RD1nNzE6uElZDsKBwKgCxlJS9EM+UEUsZIiTzXmJDpX32MbRiuxpQMN+BfwQRM3zKPQCB6np5iPEIWxUdIQEE1E0AR7tYxrFrOB+UrUGTXCZRa0MxMx0ZBtaQejw4SA0vw/Ji64xA4ILNkV+VB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328023; c=relaxed/simple;
	bh=2wRXyoiGYh3N2MxiZpU0KF0q9rWzHw+tYKK7qMjArxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUtQ/LpuHQDpAulOw0wjA6UL49pDxH8dTTEWrxc+ILv1DWyG+di8EMRy52My61fI9Ns1N8Oo4iCwNUsaBfaqYtf0aS3wTpSGpu/wQm/UOh1zdH88IUm5s7u3UeuE6+8Amh+HWpbk83rCFF+wRtXkfFuAHZa/7uhOsXJTGVO0KJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQGkmtrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA442C19425;
	Mon, 27 Apr 2026 22:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328022;
	bh=2wRXyoiGYh3N2MxiZpU0KF0q9rWzHw+tYKK7qMjArxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQGkmtrfaOtuV8b1phg4BUOsZwWTo2RGRcZLJkJvxY84H0cAgrv0s1WFxR7FvnQPj
	 ZyV6+O/clFd90kJOW/a6ltyel9t5FglZoFE7lOoOvdCaPUhymgXpKBERhilzisUgqC
	 q9PSC0MCU0EbI2JsqE/QK8UpsIl6OsePWv8QIPYrjpQH3CnHf/CqbVmSR62Y8L7paX
	 ikOJQb763jtz56W4bgS+DdXbeJSEIgbEf6wkWgGB1AiVQvPgusJYtdMLrk/X6at2sT
	 DhlAAhBweOysTvimZ87GnzvOYsJzx5XiFgU+j03r4Jcmf2ueM6wTgzwbUFClsoJp/C
	 nz1bJk/e+RWJQ==
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
	tmgross@umich.edu
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 15/24] samples: rust: rust_driver_auxiliary: showcase lifetime-bound registration data
Date: Tue, 28 Apr 2026 00:11:13 +0200
Message-ID: <20260427221155.2144848-16-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4000547B4A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8718-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
index 4ad619c5731e..010ec2201a69 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -51,14 +51,15 @@ fn probe(
     }
 }
 
-struct Data {
+struct Data<'a> {
     index: u32,
+    parent: &'a pci::Device<Bound>,
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


