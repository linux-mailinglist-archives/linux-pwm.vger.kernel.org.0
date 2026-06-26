Return-Path: <linux-pwm+bounces-9395-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wT0uN8xpPmp/FgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9395-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:00:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B46CCB77
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:00:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E1IRl0ei;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9395-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9395-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D25E3028BC3
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295663F411B;
	Fri, 26 Jun 2026 11:55:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABBC373BFE;
	Fri, 26 Jun 2026 11:55:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474950; cv=none; b=WN0dS5jnJuC0NNc37RA6JlEyIMsJCAeZOTChrLTpFldPHQIgS2UF3BKnIQON/o1NlPeuBQfC9pqeBluoNl/sTykDZABVXhJCWfkkox7ZdqclO6iCzbpWw5Xny/VK/13hk3Jpef8DSXSNOCM9orU7VtMdJWxHG9LjhUWHBmUIt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474950; c=relaxed/simple;
	bh=gZ/T5q5RCluLWjyXgEizSiB5SPTYOFJe/V1V5ABMneg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsbYGDz8WFD55A/P1U7TN+UPYFpJ/qCH8TkP8ZRDRId8zOz4vdr42KhPtV62zzVnsblyBYuhjk/S25CEsvopl9gz5dP+li6tqyOGkPcqxfA8wNS/rBLCHhG4mB+/n4i6K/wMZN/Lod3LuIoERSC7yPmfFVK/6RSL3PCfuOOryPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1IRl0ei; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F5A1F00A3D;
	Fri, 26 Jun 2026 11:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782474940;
	bh=IGEKVKFVZNVk1+RmVgzF30xF6YgxgNVpGsqZC2WxOns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E1IRl0eivr6Z99U8il9idrdCDm0NsLRp0CosMU3L7fk3LgRwZ3JzVuVqidxBu4yV4
	 OAaEqkhCrqEvmCnXjArRo+ctF4v3gKk+JfTbAaolbyRv+QAXFOkFS6VPjPs6Ujq8jH
	 lGhrYnaXk7W0l4pBmRczdzNHToh1xy+7obn/6flX2mRTnWlt79ISg09nXsh+whlYKS
	 V6sEVpS0OzIt5Tc5Jx0f7/j4AGYEGmrX5JW5sRqX+vTc7FBLe+1ULn/Drlu+UU/ED3
	 9jKCzFQ25Lot97b9MtcQcy48Told+kZJndiTAvVL282Pe8RI/HbbZClpgsVaQH548D
	 m6qgGce03uGWA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 26 Jun 2026 13:54:02 +0200
Subject: [PATCH v19 5/8] rust: rename `AlwaysRefCounted` to `RefCounted`.
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-unique-ref-v19-5-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Oliver Mangold <oliver.mangold@pm.me>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Igor Korotin <igor.korotin@linux.dev>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=39475;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=KeTm4SeXrKKGxF05HEt1R59iI3+B+CLRZiH9cKzash4=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPmh4tlg1JZ/NaxmbKr0YhqCLET1RMWX/rbcef
 w2uN1rItfGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaj5oeAAKCRD6UCkIqsW9
 0DyID/4oIMtbgYqNNdFVciS+MCcEOfwjv5zLemv8+ZKEzqhihybWEeO7gaX6n0krWj4GYYqjuK8
 mOZQ7TFG3ToQ87Sp78uar4YZLdpJUlYQxBlHulSk4g6P5+dUOlMPA0tiBuiNCKwCL20E+jpiPtF
 PO3fs5vwquAyy3dsCzRlVyiNWSrfphnnkFNFrkVLcCYzx9mDraXEPEll2pPaKynUFGdrvBKennm
 5mbCi2KBd9zNWwPFhizCBhcEtTHU7PYYwHOUMwyvJvh64cQpImch/+7IbPWHwqZzr0Mmc8XvnPF
 qpn6pppo2IvK3A1Y7DAeJMsP0CJR73YDZqUsbR7oSv9AclNlfgMhFTEdmG60QM6Nnk5GErG7Zrc
 guRNgn+3d6axximlOfTlD8Gylh99ewBVAg6iAWvnInxztQTUfQhC+pmCP/Qtih0Offdomrc//YI
 LAPS+z4lt3yzdDI8XBv7LsYmSypBcMQ7HVW04UQqusMW8k26dcGIj8/70Y23jXb7YLbs0klT53p
 /qUPV4YgOCc3QZQ8dzMmDZ8uzLbTYGV0Gf9ZA+9pO5xlvZpotgOe3F23KyIcG86F/ugrKgRxcSB
 qBzO11MiiKekmVJ3Tc1N/ujT7QWW3DI6vyWhTIujuxlCgIzsgc7Dpn0en4upvR5/8E3f7TknjzC
 ZelVd1yUESptyHA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9395-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com];
	FORGED_SENDER(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:liam@infradead.org,m:urezki@gmail.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rafael@kernel.org,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:paul@paul-moore.com,m:sergeh@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:m.wilczynski@samsung.com,m:a.hindborg@kernel.org,m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@k
 vack.org,m:driver-core@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:oliver.mangold@pm.me,m:viresh.kumar@linaro.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,garyguo.net:email,pm.me:email,linaro.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 784B46CCB77

From: Oliver Mangold <oliver.mangold@pm.me>

There are types where it may both be reference counted in some cases and
owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.

Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
would require) and a marker trait to indicate that the type is always
reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
is possible.

- Rename `AlwaysRefCounted` to `RefCounted`.
- Add a new unsafe trait `AlwaysRefCounted`.
- Implement the new trait `AlwaysRefCounted` for the newly renamed
  `RefCounted` implementations. This leaves functionality of existing
  implementers of `AlwaysRefCounted` intact.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
[ Andreas: Updated commit message and rebase on rust-next (7.2) ]
Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/auxiliary.rs        | 10 ++++++-
 rust/kernel/block/mq/request.rs | 19 ++++++++-----
 rust/kernel/cred.rs             | 16 +++++++++--
 rust/kernel/device.rs           | 12 +++++++--
 rust/kernel/device/property.rs  | 11 ++++++--
 rust/kernel/drm/device.rs       |  9 +++++--
 rust/kernel/drm/gem/mod.rs      | 16 ++++++++---
 rust/kernel/fs/file.rs          | 23 +++++++++++++---
 rust/kernel/i2c.rs              | 13 ++++++---
 rust/kernel/mm.rs               | 22 ++++++++++++---
 rust/kernel/mm/mmput_async.rs   | 12 +++++++--
 rust/kernel/opp.rs              | 16 ++++++++---
 rust/kernel/owned.rs            |  2 +-
 rust/kernel/pci.rs              | 10 ++++++-
 rust/kernel/pid_namespace.rs    | 15 +++++++++--
 rust/kernel/platform.rs         | 10 ++++++-
 rust/kernel/pwm.rs              | 12 +++++++--
 rust/kernel/sync/aref.rs        | 59 +++++++++++++++++++++++++----------------
 rust/kernel/task.rs             | 13 +++++++--
 rust/kernel/types.rs            | 12 ++++++---
 rust/kernel/usb.rs              | 17 +++++++++---
 rust/kernel/workqueue.rs        |  8 +++---
 22 files changed, 260 insertions(+), 77 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index c42928d5a2393..854525289c8b4 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -19,6 +19,10 @@
         to_result, //
     },
     prelude::*,
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::{
         ForLt,
         ForeignOwnable,
@@ -344,7 +348,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -363,6 +367,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index ce3e30c81cb5e..8dad15ae4cfb0 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -9,7 +9,11 @@
     block::mq::Operations,
     error::Result,
     sync::{
-        aref::{ARef, AlwaysRefCounted},
+        aref::{
+            ARef,
+            AlwaysRefCounted,
+            RefCounted, //
+        },
         atomic::Relaxed,
         Refcount,
     },
@@ -229,11 +233,10 @@ unsafe impl<T: Operations> Send for Request<T> {}
 // mutate `self` are internally synchronized`
 unsafe impl<T: Operations> Sync for Request<T> {}
 
-// SAFETY: All instances of `Request<T>` are reference counted. This
-// implementation of `AlwaysRefCounted` ensure that increments to the ref count
-// keeps the object alive in memory at least until a matching reference count
-// decrement is executed.
-unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
+// SAFETY: All instances of `Request<T>` are reference counted. This implementation of `RefCounted`
+// ensure that increments to the ref count keeps the object alive in memory at least until a
+// matching reference count decrement is executed.
+unsafe impl<T: Operations> RefCounted for Request<T> {
     fn inc_ref(&self) {
         self.wrapper_ref().refcount().inc();
     }
@@ -255,3 +258,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
         }
     }
 }
+
+// SAFETY: We currently do not implement `Ownable`, thus it is okay to obtain an `ARef<Request>`
+// from a `&Request` (but this will change in the future).
+unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {}
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index ffa156b9df377..b17736a9adcd5 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,7 +8,15 @@
 //!
 //! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
 
-use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::Opaque};
+use crate::{
+    bindings,
+    sync::aref::RefCounted,
+    task::Kuid,
+    types::{
+        AlwaysRefCounted,
+        Opaque, //
+    }, //
+};
 
 /// Wraps the kernel's `struct cred`.
 ///
@@ -76,7 +84,7 @@ pub fn euid(&self) -> Kuid {
 }
 
 // SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
-unsafe impl AlwaysRefCounted for Credential {
+unsafe impl RefCounted for Credential {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -90,3 +98,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
         unsafe { bindings::put_cred(obj.cast().as_ptr()) };
     }
 }
+
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Credential>` from a
+// `&Credential`.
+unsafe impl AlwaysRefCounted for Credential {}
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 645afc49a27d6..2e90f6a06fd05 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -8,8 +8,12 @@
     bindings,
     fmt,
     prelude::*,
-    sync::aref::ARef,
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
     types::{
+        AlwaysRefCounted,
         ForeignOwnable,
         Opaque, //
     }, //
@@ -448,7 +452,7 @@ pub fn name(&self) -> &CStr {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_raw()) };
@@ -460,6 +464,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 // SAFETY: As by the type invariant `Device` can be sent to any thread.
 unsafe impl Send for Device {}
 
diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/property.rs
index 5aead835fbbc0..cee7e25013689 100644
--- a/rust/kernel/device/property.rs
+++ b/rust/kernel/device/property.rs
@@ -14,7 +14,10 @@
     fmt,
     prelude::*,
     str::{CStr, CString},
-    sync::aref::ARef,
+    sync::aref::{
+        ARef,
+        AlwaysRefCounted, //
+    },
     types::Opaque,
 };
 
@@ -360,7 +363,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 // SAFETY: Instances of `FwNode` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for FwNode {
+unsafe impl crate::sync::aref::RefCounted for FwNode {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the
         // refcount is non-zero.
@@ -374,6 +377,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<FwNode>` from a
+// `&FwNode`.
+unsafe impl AlwaysRefCounted for FwNode {}
+
 enum Node<'a> {
     Borrowed(&'a FwNode),
     Owned(ARef<FwNode>),
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 403fc35353c74..368742a258376 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -15,7 +15,8 @@
     prelude::*,
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        AlwaysRefCounted,
+        RefCounted, //
     },
     types::Opaque,
     workqueue::{
@@ -227,7 +228,7 @@ fn deref(&self) -> &Self::Target {
 
 // SAFETY: DRM device objects are always reference counted and the get/put functions
 // satisfy the requirements.
-unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
+unsafe impl<T: drm::Driver> RefCounted for Device<T> {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::drm_dev_get(self.as_raw()) };
@@ -242,6 +243,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {}
+
 impl<T: drm::Driver> AsRef<device::Device> for Device<T> {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: `bindings::drm_device::dev` is valid as long as the DRM device itself is valid,
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 01b5bd47a3332..30d3718578fe8 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -17,7 +17,7 @@
     prelude::*,
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        RefCounted, //
     },
     types::Opaque,
 };
@@ -29,7 +29,7 @@
 #[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
 pub mod shmem;
 
-/// A macro for implementing [`AlwaysRefCounted`] for any GEM object type.
+/// A macro for implementing [`RefCounted`] for any GEM object type.
 ///
 /// Since all GEM objects use the same refcounting scheme.
 #[macro_export]
@@ -42,7 +42,7 @@ impl $( <$( $tparam_id:ident ),+> )? for $type:ty
         )?
     ) => {
         // SAFETY: All GEM objects are refcounted.
-        unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::AlwaysRefCounted for $type
+        unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::RefCounted for $type
         where
             Self: IntoGEMObject,
             $( $( $bind_param : $bind_trait ),+ )?
@@ -61,6 +61,14 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
                 unsafe { bindings::drm_gem_object_put(obj) };
             }
         }
+
+        // SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<$type>` from a
+        // `&$type`.
+        unsafe impl $( <$( $tparam_id ),+> )? $crate::sync::aref::AlwaysRefCounted for $type
+        where
+            Self: IntoGEMObject,
+            $( $( $bind_param : $bind_trait ),+ )?
+        {}
     };
 }
 #[cfg_attr(not(CONFIG_RUST_DRM_GEM_SHMEM_HELPER), allow(unused))]
@@ -98,7 +106,7 @@ fn close(_obj: &<Self::Driver as drm::Driver>::Object, _file: &DriverFile<Self>)
 }
 
 /// Trait that represents a GEM object subtype
-pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
+pub trait IntoGEMObject: Sized + super::private::Sealed + RefCounted {
     /// Returns a reference to the raw `drm_gem_object` structure, which must be valid as long as
     /// this owning object is valid.
     fn as_raw(&self) -> *mut bindings::drm_gem_object;
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 23ee689bd2400..720e57418358d 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -12,8 +12,15 @@
     cred::Credential,
     error::{code::*, to_result, Error, Result},
     fmt,
-    sync::aref::{ARef, AlwaysRefCounted},
-    types::{NotThreadSafe, Opaque},
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
+    types::{
+        AlwaysRefCounted,
+        NotThreadSafe,
+        Opaque, //
+    }, //
 };
 use core::ptr;
 
@@ -197,7 +204,7 @@ unsafe impl Sync for File {}
 
 // SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
 // makes `ARef<File>` own a normal refcount.
-unsafe impl AlwaysRefCounted for File {
+unsafe impl RefCounted for File {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -212,6 +219,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<File>` from a
+// `&File`.
+unsafe impl AlwaysRefCounted for File {}
+
 /// Wraps the kernel's `struct file`. Not thread safe.
 ///
 /// This type represents a file that is not known to be safe to transfer across thread boundaries.
@@ -233,7 +244,7 @@ pub struct LocalFile {
 
 // SAFETY: The type invariants guarantee that `LocalFile` is always ref-counted. This implementation
 // makes `ARef<LocalFile>` own a normal refcount.
-unsafe impl AlwaysRefCounted for LocalFile {
+unsafe impl RefCounted for LocalFile {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -249,6 +260,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<LocalFile>` from a
+// `&LocalFile`.
+unsafe impl AlwaysRefCounted for LocalFile {}
+
 impl LocalFile {
     /// Constructs a new `struct file` wrapper from a file descriptor.
     ///
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 624b971ca8b0b..02b2c9220eb11 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -18,7 +18,8 @@
     prelude::*,
     sync::aref::{
         ARef,
-        AlwaysRefCounted, //
+        AlwaysRefCounted,
+        RefCounted, //
     },
     types::Opaque, //
 };
@@ -424,7 +425,7 @@ pub fn get(index: i32) -> Result<ARef<Self>> {
 kernel::impl_device_context_into_aref!(I2cAdapter);
 
 // SAFETY: Instances of `I2cAdapter` are always reference-counted.
-unsafe impl AlwaysRefCounted for I2cAdapter {
+unsafe impl RefCounted for I2cAdapter {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::i2c_get_adapter(self.index()) };
@@ -435,6 +436,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
         unsafe { bindings::i2c_put_adapter(obj.as_ref().as_raw()) }
     }
 }
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from an
+// `&I2cAdapter`.
+unsafe impl AlwaysRefCounted for I2cAdapter {}
 
 /// The i2c board info representation
 ///
@@ -500,7 +504,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for I2cClient<C
 kernel::impl_device_context_into_aref!(I2cClient);
 
 // SAFETY: Instances of `I2cClient` are always reference-counted.
-unsafe impl AlwaysRefCounted for I2cClient {
+unsafe impl RefCounted for I2cClient {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -511,6 +515,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
         unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).dev) }
     }
 }
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from an
+// `&I2cClient`.
+unsafe impl AlwaysRefCounted for I2cClient {}
 
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for I2cClient<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 4764d7b68f2a7..83ed94fca14ca 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -13,8 +13,15 @@
 
 use crate::{
     bindings,
-    sync::aref::{ARef, AlwaysRefCounted},
-    types::{NotThreadSafe, Opaque},
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
+    types::{
+        AlwaysRefCounted,
+        NotThreadSafe,
+        Opaque, //
+    }, //
 };
 use core::{ops::Deref, ptr::NonNull};
 
@@ -55,7 +62,7 @@ unsafe impl Send for Mm {}
 unsafe impl Sync for Mm {}
 
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for Mm {
+unsafe impl RefCounted for Mm {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -69,6 +76,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Mm>` from a `&Mm`.
+unsafe impl AlwaysRefCounted for Mm {}
+
 /// A wrapper for the kernel's `struct mm_struct`.
 ///
 /// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
@@ -91,7 +101,7 @@ unsafe impl Send for MmWithUser {}
 unsafe impl Sync for MmWithUser {}
 
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for MmWithUser {
+unsafe impl RefCounted for MmWithUser {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -105,6 +115,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<MmWithUser>` from a
+// `&MmWithUser`.
+unsafe impl AlwaysRefCounted for MmWithUser {}
+
 // Make all `Mm` methods available on `MmWithUser`.
 impl Deref for MmWithUser {
     type Target = Mm;
diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.rs
index b8d2f051225c7..8fbc396e46028 100644
--- a/rust/kernel/mm/mmput_async.rs
+++ b/rust/kernel/mm/mmput_async.rs
@@ -10,7 +10,11 @@
 use crate::{
     bindings,
     mm::MmWithUser,
-    sync::aref::{ARef, AlwaysRefCounted},
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
+    types::AlwaysRefCounted,
 };
 use core::{ops::Deref, ptr::NonNull};
 
@@ -34,7 +38,7 @@ unsafe impl Send for MmWithUserAsync {}
 unsafe impl Sync for MmWithUserAsync {}
 
 // SAFETY: By the type invariants, this type is always refcounted.
-unsafe impl AlwaysRefCounted for MmWithUserAsync {
+unsafe impl RefCounted for MmWithUserAsync {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The pointer is valid since self is a reference.
@@ -48,6 +52,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<MmWithUserAsync>`
+// from a `&MmWithUserAsync`.
+unsafe impl AlwaysRefCounted for MmWithUserAsync {}
+
 // Make all `MmWithUser` methods available on `MmWithUserAsync`.
 impl Deref for MmWithUserAsync {
     type Target = MmWithUser;
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 62e44676125d1..b8db6bdefd077 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -16,8 +16,14 @@
     ffi::{c_char, c_ulong},
     prelude::*,
     str::CString,
-    sync::aref::{ARef, AlwaysRefCounted},
-    types::Opaque,
+    sync::aref::{
+        ARef,
+        RefCounted, //
+    },
+    types::{
+        AlwaysRefCounted,
+        Opaque, //
+    }, //
 };
 
 #[cfg(CONFIG_CPU_FREQ)]
@@ -1041,7 +1047,7 @@ unsafe impl Send for OPP {}
 unsafe impl Sync for OPP {}
 
 /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
-unsafe impl AlwaysRefCounted for OPP {
+unsafe impl RefCounted for OPP {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -1055,6 +1061,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<OPP>` from an
+// `&OPP`.
+unsafe impl AlwaysRefCounted for OPP {}
+
 impl OPP {
     /// Creates an owned reference to a [`OPP`] from a valid pointer.
     ///
diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index 93a5dfcc1e6f5..a156267bf8bb1 100644
--- a/rust/kernel/owned.rs
+++ b/rust/kernel/owned.rs
@@ -27,7 +27,7 @@
 ///
 /// Note: The underlying object is not required to provide internal reference counting, because it
 /// represents a unique, owned reference. If reference counting (on the Rust side) is required,
-/// [`AlwaysRefCounted`](crate::sync::aref::AlwaysRefCounted) should be implemented.
+/// [`RefCounted`](crate::types::RefCounted) should be implemented.
 ///
 /// # Examples
 ///
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543fd..ea9ef99cecb07 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -19,6 +19,10 @@
     },
     prelude::*,
     str::CStr,
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::Opaque,
     ThisModule, //
 };
@@ -481,7 +485,7 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
 impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::pci_dev_get(self.as_raw()) };
@@ -493,6 +497,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
index 979a9718f153d..067f68b99e8c5 100644
--- a/rust/kernel/pid_namespace.rs
+++ b/rust/kernel/pid_namespace.rs
@@ -7,7 +7,14 @@
 //! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pid_namespace.h) and
 //! [`include/linux/pid.h`](srctree/include/linux/pid.h)
 
-use crate::{bindings, sync::aref::AlwaysRefCounted, types::Opaque};
+use crate::{
+    bindings,
+    sync::aref::RefCounted,
+    types::{
+        AlwaysRefCounted,
+        Opaque, //
+    }, //
+};
 use core::ptr;
 
 /// Wraps the kernel's `struct pid_namespace`. Thread safe.
@@ -41,7 +48,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_namespace) -> &'a Self {
 }
 
 // SAFETY: Instances of `PidNamespace` are always reference-counted.
-unsafe impl AlwaysRefCounted for PidNamespace {
+unsafe impl RefCounted for PidNamespace {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -55,6 +62,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<PidNamespace>` from
+// a `&PidNamespace`.
+unsafe impl AlwaysRefCounted for PidNamespace {}
+
 // SAFETY:
 // - `PidNamespace::dec_ref` can be called from any thread.
 // - It is okay to send ownership of `PidNamespace` across thread boundaries.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9b362e0495d32..0ba676445b06d 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -27,6 +27,10 @@
     },
     of,
     prelude::*,
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::Opaque,
     ThisModule, //
 };
@@ -518,7 +522,7 @@ pub fn optional_irq_by_name(&self, name: &CStr) -> Result<IrqRequest<'_>> {
 impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::get_device(self.as_ref().as_raw()) };
@@ -530,6 +534,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
index 6c9d667009ef7..2d1cd74dd98e1 100644
--- a/rust/kernel/pwm.rs
+++ b/rust/kernel/pwm.rs
@@ -13,7 +13,11 @@
     devres,
     error::{self, to_result},
     prelude::*,
-    sync::aref::{ARef, AlwaysRefCounted},
+    sync::aref::{
+        ARef,
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::Opaque, //
 };
 use core::{
@@ -629,7 +633,7 @@ pub fn new<'a>(
 }
 
 // SAFETY: Implements refcounting for `Chip` using the embedded `struct device`.
-unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
+unsafe impl<T: PwmOps> RefCounted for Chip<T> {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `self` exists.
@@ -647,6 +651,10 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Chip<T>>` from a
+// `&Chip<T>`.
+unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {}
+
 // SAFETY: `Chip` is a wrapper around `*mut bindings::pwm_chip`. The underlying C
 // structure's state is managed and synchronized by the kernel's device model
 // and PWM core locking mechanisms. Therefore, it is safe to move the `Chip`
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 3bd5eb8a1a526..ea5a16b8163a6 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -11,7 +11,7 @@
 //! underlying object, but this refcount is internal to the object. It essentially is a Rust
 //! implementation of the `get_` and `put_` pattern used in C for reference counting.
 //!
-//! To make use of [`ARef<MyType>`], `MyType` needs to implement [`AlwaysRefCounted`]. It is a trait
+//! To make use of [`ARef<MyType>`], `MyType` needs to implement [`RefCounted`]. It is a trait
 //! for accessing the internal reference count of an object of the `MyType` type.
 //!
 //! [`Arc`]: crate::sync::Arc
@@ -24,11 +24,9 @@
     ptr::NonNull, //
 };
 
-/// Types that are _always_ reference counted.
+/// Types that are internally reference counted.
 ///
 /// It allows such types to define their own custom ref increment and decrement functions.
-/// Additionally, it allows users to convert from a shared reference `&T` to an owned reference
-/// [`ARef<T>`].
 ///
 /// This is usually implemented by wrappers to existing structures on the C side of the code. For
 /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
@@ -45,9 +43,8 @@
 /// at least until matching decrements are performed.
 ///
 /// Implementers must also ensure that all instances are reference-counted. (Otherwise they
-/// won't be able to honour the requirement that [`AlwaysRefCounted::inc_ref`] keep the object
-/// alive.)
-pub unsafe trait AlwaysRefCounted {
+/// won't be able to honour the requirement that [`RefCounted::inc_ref`] keep the object alive.)
+pub unsafe trait RefCounted {
     /// Increments the reference count on the object.
     fn inc_ref(&self);
 
@@ -60,11 +57,27 @@ pub unsafe trait AlwaysRefCounted {
     /// Callers must ensure that there was a previous matching increment to the reference count,
     /// and that the object is no longer used after its reference count is decremented (as it may
     /// result in the object being freed), unless the caller owns another increment on the refcount
-    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
-    /// [`AlwaysRefCounted::dec_ref`] once).
+    /// (e.g., it calls [`RefCounted::inc_ref`] twice, then calls [`RefCounted::dec_ref`] once).
     unsafe fn dec_ref(obj: NonNull<Self>);
 }
 
+/// Always reference-counted type.
+///
+/// It allows deriving a counted reference [`ARef<T>`] from a `&T`.
+///
+/// This provides some convenience, but it allows "escaping" borrow checks on `&T`. As it
+/// complicates attempts to ensure that a reference to T is unique, it is optional to provide for
+/// [`RefCounted`] types. See *Safety* below.
+///
+/// # Safety
+///
+/// Implementers must ensure that no safety invariants are violated by upgrading an `&T` to an
+/// [`ARef<T>`]. In particular that implies [`AlwaysRefCounted`] and [`crate::types::Ownable`]
+/// cannot be implemented for the same type, as this would allow violating the uniqueness guarantee
+/// of [`crate::types::Owned<T>`] by dereferencing it into an `&T` and obtaining an [`ARef`] from
+/// that.
+pub unsafe trait AlwaysRefCounted: RefCounted {}
+
 /// An owned reference to an always-reference-counted object.
 ///
 /// The object's reference count is automatically decremented when an instance of [`ARef`] is
@@ -75,7 +88,7 @@ pub unsafe trait AlwaysRefCounted {
 ///
 /// The pointer stored in `ptr` is non-null and valid for the lifetime of the [`ARef`] instance. In
 /// particular, the [`ARef`] instance owns an increment on the underlying object's reference count.
-pub struct ARef<T: AlwaysRefCounted> {
+pub struct ARef<T: RefCounted> {
     ptr: NonNull<T>,
     _p: PhantomData<T>,
 }
@@ -84,19 +97,19 @@ pub struct ARef<T: AlwaysRefCounted> {
 // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
 // `T` to be `Send` because any thread that has an `ARef<T>` may ultimately access `T` using a
 // mutable reference, for example, when the reference count reaches zero and `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
+unsafe impl<T: RefCounted + Sync + Send> Send for ARef<T> {}
 
 // SAFETY: It is safe to send `&ARef<T>` to another thread when the underlying `T` is `Sync`
 // because it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally,
 // it needs `T` to be `Send` because any thread that has a `&ARef<T>` may clone it and get an
 // `ARef<T>` on that thread, so the thread may ultimately access `T` using a mutable reference, for
 // example, when the reference count reaches zero and `T` is dropped.
-unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
+unsafe impl<T: RefCounted + Sync + Send> Sync for ARef<T> {}
 
 // Even if `T` is pinned, pointers to `T` can still move.
-impl<T: AlwaysRefCounted> Unpin for ARef<T> {}
+impl<T: RefCounted> Unpin for ARef<T> {}
 
-impl<T: AlwaysRefCounted> ARef<T> {
+impl<T: RefCounted> ARef<T> {
     /// Creates a new instance of [`ARef`].
     ///
     /// It takes over an increment of the reference count on the underlying object.
@@ -125,12 +138,12 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// ```
     /// use core::ptr::NonNull;
-    /// use kernel::sync::aref::{ARef, AlwaysRefCounted};
+    /// use kernel::sync::aref::{ARef, RefCounted};
     ///
     /// struct Empty {}
     ///
     /// # // SAFETY: TODO.
-    /// unsafe impl AlwaysRefCounted for Empty {
+    /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
     /// }
@@ -148,7 +161,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
     }
 }
 
-impl<T: AlwaysRefCounted> Clone for ARef<T> {
+impl<T: RefCounted> Clone for ARef<T> {
     fn clone(&self) -> Self {
         self.inc_ref();
         // SAFETY: We just incremented the refcount above.
@@ -156,7 +169,7 @@ fn clone(&self) -> Self {
     }
 }
 
-impl<T: AlwaysRefCounted> Deref for ARef<T> {
+impl<T: RefCounted> Deref for ARef<T> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -173,7 +186,7 @@ fn from(b: &T) -> Self {
     }
 }
 
-impl<T: AlwaysRefCounted> Drop for ARef<T> {
+impl<T: RefCounted> Drop for ARef<T> {
     fn drop(&mut self) {
         // SAFETY: The type invariants guarantee that the `ARef` owns the reference we're about to
         // decrement.
@@ -183,19 +196,19 @@ fn drop(&mut self) {
 
 impl<T, U> PartialEq<ARef<U>> for ARef<T>
 where
-    T: AlwaysRefCounted + PartialEq<U>,
-    U: AlwaysRefCounted,
+    T: RefCounted + PartialEq<U>,
+    U: RefCounted,
 {
     #[inline]
     fn eq(&self, other: &ARef<U>) -> bool {
         T::eq(&**self, &**other)
     }
 }
-impl<T: AlwaysRefCounted + Eq> Eq for ARef<T> {}
+impl<T: RefCounted + Eq> Eq for ARef<T> {}
 
 impl<T, U> PartialEq<&'_ U> for ARef<T>
 where
-    T: AlwaysRefCounted + PartialEq<U>,
+    T: RefCounted + PartialEq<U>,
 {
     #[inline]
     fn eq(&self, other: &&U) -> bool {
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 38273f4eedb51..6259430b0ca31 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -10,7 +10,12 @@
     pid_namespace::PidNamespace,
     prelude::*,
     sync::aref::ARef,
-    types::{NotThreadSafe, Opaque},
+    types::{
+        AlwaysRefCounted,
+        NotThreadSafe,
+        Opaque,
+        RefCounted, //
+    },
 };
 use core::{
     ops::Deref,
@@ -347,7 +352,7 @@ pub fn group_leader(&self) -> &Task {
 }
 
 // SAFETY: The type invariants guarantee that `Task` is always refcounted.
-unsafe impl crate::sync::aref::AlwaysRefCounted for Task {
+unsafe impl RefCounted for Task {
     #[inline]
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
@@ -361,6 +366,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Task>` from a
+// `&Task`.
+unsafe impl AlwaysRefCounted for Task {}
+
 impl PartialEq for Task {
     #[inline]
     fn eq(&self, other: &Self) -> bool {
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index c41eab0ec983c..5ef763717e59a 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -15,9 +15,15 @@
 pub mod for_lt;
 pub use for_lt::ForLt;
 
-pub use crate::owned::{
-    Ownable,
-    Owned, //
+pub use crate::{
+    owned::{
+        Ownable,
+        Owned, //
+    },
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    }, //
 };
 
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 7aff0c82d0afc..59350c6b0df2a 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -18,7 +18,10 @@
         to_result, //
     },
     prelude::*,
-    sync::aref::AlwaysRefCounted,
+    sync::aref::{
+        AlwaysRefCounted,
+        RefCounted, //
+    },
     types::Opaque,
     ThisModule, //
 };
@@ -392,7 +395,7 @@ fn as_ref(&self) -> &Device {
 }
 
 // SAFETY: Instances of `Interface` are always reference-counted.
-unsafe impl AlwaysRefCounted for Interface {
+unsafe impl RefCounted for Interface {
     fn inc_ref(&self) {
         // SAFETY: The invariants of `Interface` guarantee that `self.as_raw()`
         // returns a valid `struct usb_interface` pointer, for which we will
@@ -406,6 +409,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Interface>` from a
+// `&Interface`.
+unsafe impl AlwaysRefCounted for Interface {}
+
 // SAFETY: A `Interface` is always reference-counted and can be released from any thread.
 unsafe impl Send for Interface {}
 
@@ -443,7 +450,7 @@ fn as_raw(&self) -> *mut bindings::usb_device {
 kernel::impl_device_context_into_aref!(Device);
 
 // SAFETY: Instances of `Device` are always reference-counted.
-unsafe impl AlwaysRefCounted for Device {
+unsafe impl RefCounted for Device {
     fn inc_ref(&self) {
         // SAFETY: The invariants of `Device` guarantee that `self.as_raw()`
         // returns a valid `struct usb_device` pointer, for which we will
@@ -457,6 +464,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
+// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an `ARef<Device>` from a
+// `&Device`.
+unsafe impl AlwaysRefCounted for Device {}
+
 impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
     fn as_ref(&self) -> &device::Device<Ctx> {
         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 7e253b6f299ce..77673b8ea45fb 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -192,7 +192,7 @@
     sync::{
         aref::{
             ARef,
-            AlwaysRefCounted, //
+            RefCounted, //
         },
         Arc,
         LockClassKey, //
@@ -954,7 +954,7 @@ unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for Pin<KBox<T>>
 //     implementation of `WorkItemPointer` for `ARef<T>`.
 unsafe impl<T, const ID: u64> WorkItemPointer<ID> for ARef<T>
 where
-    T: AlwaysRefCounted,
+    T: RefCounted,
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
 {
@@ -987,7 +987,7 @@ unsafe impl<T, const ID: u64> WorkItemPointer<ID> for ARef<T>
 // requirements of `WorkItemPointer`.
 unsafe impl<T, const ID: u64> RawWorkItem<ID> for ARef<T>
 where
-    T: AlwaysRefCounted,
+    T: RefCounted,
     T: WorkItem<ID, Pointer = Self>,
     T: HasWork<T, ID>,
 {
@@ -1020,7 +1020,7 @@ unsafe impl<T, const ID: u64> RawDelayedWorkItem<ID> for ARef<T>
 where
     T: WorkItem<ID, Pointer = Self>,
     T: HasDelayedWork<T, ID>,
-    T: AlwaysRefCounted,
+    T: RefCounted,
 {
 }
 

-- 
2.51.2



