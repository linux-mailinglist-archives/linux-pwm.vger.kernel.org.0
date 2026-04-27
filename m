Return-Path: <linux-pwm+bounces-8706-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL7/FbHf72kiHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8706-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:14:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6D947B3A1
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB2D30ADAAC
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FCC3A9630;
	Mon, 27 Apr 2026 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJLRKLjR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521123793BB;
	Mon, 27 Apr 2026 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327947; cv=none; b=NqmsxIXdEaMWKEx/IR6Y4qX0tZaMbQfh12F6J5+s9wx+0n9gMM/McARG8qsYwGiVUcovK62v+exCD9Y92YnAJXYPcBfY6UjJ59TT55UD3eGk2GCnTX0kA33GP6Pz71HW5rclNwYxD4c+adFFo1GHDUY3Ask93nFL3JzHA8PeEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327947; c=relaxed/simple;
	bh=bM12jT1hv0K0oENDCBepC4nrrQUDFCBN7Pb+KzPNmtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7Njre9t3l84FCi5jlTIN+64UsEDKaVVvdLoS1Tz/jD/N5mS8d4F6Px2RFTRTYdiSrW/q8h2h0POWBPwlCsoBIq246AV04hIbxoKWYU+it8oYPBK862Og7vO6WkoVsqnkq4cIa+Pw1p4z7+jA37LcHGODxJ35xJ6Pk5yqOjwuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJLRKLjR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B69C19425;
	Mon, 27 Apr 2026 22:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327947;
	bh=bM12jT1hv0K0oENDCBepC4nrrQUDFCBN7Pb+KzPNmtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJLRKLjRm9qlfsoANY2fNN4UtrsSDSd7D+xH5aB4COfjRw7n/QHDm96SJn7XnB4PX
	 J9hzk1e+EKPC4SU2TmXraGD3g7QAFijLpGK7VwvpCZY4ESZ/f0uFK0aJDyqpijdU40
	 SX7nSiNxoSYnjx5aLu0tPAJ7i2IVobXsM5ozDYjWyezcCSt8Yx+nuchuAw/SN/bOCi
	 Y8/H55/J5Ws2Do3nbhGYPCG+GMSMnQ2UYLlpLrDyMgZj4hfcdtx6j4m41uyUnJqB27
	 SueqprNZm0gboHo8WVABYI87am+945g0j3AP+XWmIuTrWVTVs7osXRTUz+fN57rzFs
	 qaCQ2uP3eegzw==
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
Subject: [PATCH 03/24] rust: devres: add ForLt support to Devres
Date: Tue, 28 Apr 2026 00:11:01 +0200
Message-ID: <20260427221155.2144848-4-dakr@kernel.org>
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
X-Rspamd-Queue-Id: EA6D947B3A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8706-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Use ForLt::cast_ref() in Devres access methods, enabling lifetime
shortening for types that are covariant over their lifetime parameter.

This is a no-op for 'static types, but prepares Devres for use with
lifetime-parameterized types such as pci::Bar<'_, SIZE>.

Add DevresGuard as a wrapper around RevocableGuard that applies
ForLt::cast_ref() on deref().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e5f93aed20c..7baabcdb1ad3 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -24,6 +24,7 @@
         Arc, //
     },
     types::{
+        ForLt,
         ForeignOwnable,
         Opaque, //
     },
@@ -324,22 +325,26 @@ pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T> {
         // SAFETY: `dev` being the same device as the device this `Devres` has been created for
         // proves that `self.data` hasn't been revoked and is guaranteed to not be revoked as long
         // as `dev` lives; `dev` lives at least as long as `self`.
-        Ok(unsafe { self.data().access() })
+        Ok(<ForLt!(T)>::cast_ref(unsafe { self.data().access() }))
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access`].
-    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
-        self.data().try_access()
+    #[allow(clippy::type_complexity)]
+    pub fn try_access(&self) -> Option<DevresGuard<'_, ForLt!(T)>> {
+        self.data().try_access().map(DevresGuard)
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access_with`].
     pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
-        self.data().try_access_with(f)
+        self.data()
+            .try_access_with(|data| f(<ForLt!(T)>::cast_ref(data)))
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access_with_guard`].
     pub fn try_access_with_guard<'a>(&'a self, guard: &'a rcu::Guard) -> Option<&'a T> {
-        self.data().try_access_with_guard(guard)
+        self.data()
+            .try_access_with_guard(guard)
+            .map(<ForLt!(T)>::cast_ref)
     }
 }
 
@@ -365,6 +370,20 @@ fn drop(&mut self) {
     }
 }
 
+/// Guard returned by [`Devres::try_access`].
+///
+/// Dereferences to `F::Of<'a>`, applying [`ForLt::cast_ref`] to shorten the lifetime of the
+/// stored data to the guard's borrow lifetime.
+pub struct DevresGuard<'a, F: ForLt>(RevocableGuard<'a, F::Of<'static>>);
+
+impl<'a, F: ForLt> core::ops::Deref for DevresGuard<'a, F> {
+    type Target = F::Of<'a>;
+
+    fn deref(&self) -> &Self::Target {
+        F::cast_ref(&*self.0)
+    }
+}
+
 /// Consume `data` and [`Drop::drop`] `data` once `dev` is unbound.
 fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 where
-- 
2.54.0


