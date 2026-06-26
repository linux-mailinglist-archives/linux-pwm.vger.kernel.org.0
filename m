Return-Path: <linux-pwm+bounces-9429-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lk1FNlPHPmpcLgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9429-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:39:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C96CFBD6
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:39:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NsWIRQpF;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9429-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9429-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AE933026324
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ABD3B7B93;
	Fri, 26 Jun 2026 18:37:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D163B7B71;
	Fri, 26 Jun 2026 18:37:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499023; cv=none; b=eM+pULmno7Mz6vWUjNj7rd9QeM9qzVP4wQeShfcTjPmu/L9+6v2Ognye3DPDiPkjD/l+brzp4OTUAP2k9MgcMLsSm6ivNeuZLfbMUT3GsT3Edzm+rZ0gO5hECTbuTm0a+85qZ5GRknaJIhfFxLw757BC4UkqHWk3+/4kU0UU05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499023; c=relaxed/simple;
	bh=W7anXgt6ShndsS8j9Eatpll4oXN6f9z6XZ2vKuQ3Hfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGAt2HgIxdGkkQ8VGvESOb1cZ+CuMya03Bd1NOES19L53N5Ur/OwvT+ffzyDtYTqVslTVHpHjIH4Ifw8FLedwvHmqrvAw+xz0z7nStt/X7GrKfsy/AjAQi+g9FiE1iv4MeflAlSPtuSDvA3GUowOblsV6hhuWO4lIKIABEB8WF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsWIRQpF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8EC1F000E9;
	Fri, 26 Jun 2026 18:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499021;
	bh=OucBYBkRxDTmORV5wKRKnI3Arj/SWZDC4DcjOFwYK78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NsWIRQpFAtq9jd1nP6FRJPyXaa6z5ho/a5RVcC+fGpZC0NtesuFeajEI4sOLn6x1z
	 Zo8VMH5qXG0trUI7wOX69VP7bJLv/vQntzTS7B1W81rquKREUh011F4tX3l+H8M5bH
	 6qB7ItTL4ikQma2kXmiGi50M/jZOkXnDIFZtnDarKaSTU1Gzmyo0z85cltIWG06UzC
	 Fm8xqI1YwKl0CeO+m62sDo9RAr4XZsGPKKE7QJUoVNjGwZK55Ts3LE1Oj40tn5Lx8p
	 Uld3ZwRCKvr7/WM5DpUoAkBW9+HbURQHP1wDWviXB7C5nrVcfAS3hbhBfsrCg2tu4B
	 xUKZW1OULpGAQ==
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
Subject: [PATCH v4 4/7] rust: auxiliary: sample: demonstrate ForLt with invariant Mutex type
Date: Fri, 26 Jun 2026 20:36:11 +0200
Message-ID: <20260626183630.2585057-5-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626183630.2585057-1-dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9429-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 610C96CFBD6

Extend the auxiliary driver sample to demonstrate both access patterns:

  - registration_data() with CovariantForLt!(Data<'_>) for the covariant
    data type that holds a plain &'bound reference.

  - registration_data_with() with ForLt!(MutexData<'_>) for an invariant
    data type that wraps a Mutex<&'bound Device>. Since Mutex<T> is
    invariant over T, MutexData cannot implement CovariantForLt and must
    use the closure-based accessor.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 94 +++++++++++++++++++--------
 1 file changed, 68 insertions(+), 26 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 92ee6a6d348e..e441ae81fa2c 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -11,14 +11,21 @@
         Core, //
     },
     driver,
+    new_mutex,
     pci,
     prelude::*,
-    types::CovariantForLt,
+    sync::Mutex,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    },
     InPlaceModule, //
 };
 
 const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 const AUXILIARY_NAME: &CStr = c"auxiliary";
+const COVARIANT_DEV_ID: u32 = 0;
+const INVARIANT_DEV_ID: u32 = 1;
 
 struct AuxiliaryDriver;
 
@@ -56,12 +63,26 @@ struct Data<'bound> {
     parent: &'bound pci::Device<Bound>,
 }
 
+/// Registration data with interior mutability.
+///
+/// `Mutex<&'bound T>` is invariant over `'bound`, so this type cannot implement
+/// [`CovariantForLt`](trait@CovariantForLt). Access must go through the closure-based
+/// [`auxiliary::Device::registration_data_with()`].
+#[pin_data]
+struct MutexData<'bound> {
+    #[pin]
+    parent: Mutex<&'bound pci::Device<Bound>>,
+    index: u32,
+}
+
 struct ParentDriver;
 
 #[allow(clippy::type_complexity)]
+#[pin_data]
 struct ParentData<'bound> {
     _reg0: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
-    _reg1: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
+    #[pin]
+    _reg1: auxiliary::Registration<'bound, ForLt!(MutexData<'_>)>,
 }
 
 kernel::pci_device_table!(
@@ -81,17 +102,17 @@ fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        Ok(ParentData {
+        try_pin_init!(ParentData {
             // SAFETY: `ParentData` is the driver's private data, which is dropped when the
             // device is unbound; i.e. `mem::forget()` is never called on it.
             _reg0: unsafe {
                 auxiliary::Registration::new_with_lt(
                     pdev.as_ref(),
                     AUXILIARY_NAME,
-                    0,
+                    COVARIANT_DEV_ID,
                     MODULE_NAME,
                     Data {
-                        index: 0,
+                        index: COVARIANT_DEV_ID,
                         parent: pdev,
                     },
                 )?
@@ -101,12 +122,16 @@ fn probe<'bound>(
                 auxiliary::Registration::new_with_lt(
                     pdev.as_ref(),
                     AUXILIARY_NAME,
-                    1,
+                    INVARIANT_DEV_ID,
                     MODULE_NAME,
-                    Data {
-                        index: 1,
-                        parent: pdev,
-                    },
+                    pin_init!(MutexData {
+                        parent <- {
+                            let pdev: &pci::Device<Bound> = pdev;
+
+                            new_mutex!(pdev)
+                        },
+                        index: INVARIANT_DEV_ID,
+                    }),
                 )?
             },
         })
@@ -115,22 +140,39 @@ fn probe<'bound>(
 
 impl ParentDriver {
     fn connect(adev: &auxiliary::Device<Bound>) -> Result {
-        let data = adev.registration_data::<CovariantForLt!(Data<'_>)>()?;
-        let pdev = data.parent;
-
-        dev_info!(
-            pdev,
-            "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
-            adev.id(),
-            pdev.vendor_id(),
-            pdev.device_id()
-        );
-
-        dev_info!(
-            pdev,
-            "Connected to auxiliary device with index {}.\n",
-            data.index
-        );
+        match adev.id() {
+            // CovariantForLt types can use the direct-reference accessor.
+            COVARIANT_DEV_ID => {
+                let data = adev.registration_data::<CovariantForLt!(Data<'_>)>()?;
+                let pdev = data.parent;
+
+                dev_info!(
+                    pdev,
+                    "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
+                    adev.id(),
+                    pdev.vendor_id(),
+                    pdev.device_id()
+                );
+
+                dev_info!(
+                    pdev,
+                    "Connected to auxiliary device with index {}.\n",
+                    data.index
+                );
+            }
+            // Invariant ForLt types (e.g. containing a Mutex) require the closure-based accessor.
+            INVARIANT_DEV_ID => {
+                adev.registration_data_with::<ForLt!(MutexData<'_>), _>(|data| {
+                    let pdev = *data.parent.lock();
+                    dev_info!(
+                        pdev,
+                        "Connected to auxiliary device with index {} (via Mutex).\n",
+                        data.index
+                    );
+                })?;
+            }
+            _ => return Err(EINVAL),
+        }
 
         Ok(())
     }
-- 
2.54.0


