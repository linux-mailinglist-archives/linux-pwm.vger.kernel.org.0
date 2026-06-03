Return-Path: <linux-pwm+bounces-9230-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id faScLQKAH2oHmgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9230-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 03:14:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2A06335B1
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 03:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WZEuJ5C3;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9230-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9230-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA0F230CCF3E
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CCD30B509;
	Wed,  3 Jun 2026 01:10:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99FB2F39C7;
	Wed,  3 Jun 2026 01:10:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449055; cv=none; b=RksbzQrbLVOkSL0rlWCpmJrejKT9FhHwlhKoxQmJX2LPYjQfjeYxjgUwKVbPdFCelV2UOGwK54tB/5Y53QWvYYGE7LMzCgeWJvg6YelTJgYBhS3UirBozTznWo1rUrda6X8OMNFsdMnJllbuiFJOGbRBSnDlLqOkQ/x+SuTPdHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449055; c=relaxed/simple;
	bh=fioutdCOCELpXFXFvL3bombMQpXlSnLljw3Dm6YDmbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xcmxu7FeoXH0W8HcAiGZVIYB4JstTgvauX7FvCyenpqwAJ9I1MrffFvfnBo9AsDFMysH9hqczwYkiOViaM1J9BjdhmpZRiK6hlagOrG+KkotFclOZnaEpQvUmh+jj2Fv08CjhhcQAhZuEp3HpNbGo+knhbHaDdSCTUtqCeB6jcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZEuJ5C3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D92F1F00898;
	Wed,  3 Jun 2026 01:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780449053;
	bh=5u6SKAfOQENdvm9cJV5fTBpN3ZssvduKcZ4mI7udZDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WZEuJ5C3uR808zrPCLf2pFl3JhLLGmxCrxORyVMHaFAvtUeZPYyUVIThwwUMPHnOq
	 XWMFFqe1mRfZ0t93nTXFrYMJX4OF12xSjJ9IW/+CfxIImiYeQMn6qF/ynOR63Tc1DE
	 /nDYS0MD9/LxDOcfQDy1W7rQ8JNIRuN2bB2eehi5MRDYAF3lSrKA1NepQIy9YLdeVo
	 iraHgEvbp3aoHt9YqOXZCa4ulwpbySKlJplI1ISLbiXOMMwbwW73biwMhu/TXYRHdK
	 49f4BK0x5DW08xyHNddohUHRwChImQkv7ssy9sDYaDWnpXmPOo///BUXmImLoxPz+E
	 xNeZ2g6hFE7fg==
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
Subject: [PATCH v2 5/7] rust: devres: add DevresLt for ForLt-aware device resource access
Date: Wed,  3 Jun 2026 03:10:16 +0200
Message-ID: <20260603011020.2073650-6-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603011020.2073650-1-dakr@kernel.org>
References: <20260603011020.2073650-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9230-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E2A06335B1

Devres<T> stores resources as T and returns &'a T from access(). For
lifetime-parameterized types like Bar<'a, SIZE> that are transmuted to
'static for storage, this exposes the synthetic 'static lifetime to
callers -- any method on the stored type that returns a reference with
its lifetime parameter would yield a &'static reference, which is
unsound.

Add DevresLt<F: ForLt>, a thin wrapper around Devres<F::Of<'static>>
that applies ForLt's lifetime-shortening operations in all access
methods to shorten the stored 'static lifetime to the caller's borrow
lifetime.

DevresLt::new() is unsafe because the caller must guarantee that the
data remains valid for the device's full bound scope; the internal
transmute from F::Of<'a> to F::Of<'static> would otherwise allow
use-after-free.

Two access patterns are provided:

- CovariantForLt types get direct-reference accessors (access,
  try_access) that return shortened references via
  CovariantForLt::cast_ref.

- Plain ForLt types use closure-based accessors (access_with,
  try_access_with) whose universally quantified lifetime prevents
  callers from smuggling in concrete short-lived references.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 110 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 82cbd8b969fb..23db91377f5e 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -24,6 +24,8 @@
         Arc, //
     },
     types::{
+        CovariantForLt,
+        ForLt,
         ForeignOwnable,
         Opaque, //
     },
@@ -365,6 +367,114 @@ fn drop(&mut self) {
     }
 }
 
+/// Guard returned by [`DevresLt::try_access`].
+///
+/// Dereferences to `F::Of<'a>`, shortening the lifetime of the stored data to the guard's borrow
+/// lifetime.
+pub struct DevresGuard<'a, F: CovariantForLt>(RevocableGuard<'a, F::Of<'static>>);
+
+impl<'a, F: CovariantForLt> core::ops::Deref for DevresGuard<'a, F> {
+    type Target = F::Of<'a>;
+
+    fn deref(&self) -> &Self::Target {
+        F::cast_ref(&*self.0)
+    }
+}
+
+/// Device-managed resource with [`ForLt`](trait@ForLt)-aware access.
+///
+/// `DevresLt` wraps [`Devres`] and shortens the stored `'static` lifetime to the caller's borrow
+/// lifetime in all access methods.
+///
+/// Types that implement [`trait@CovariantForLt`] get direct-reference accessors ([`Self::access`],
+/// [`Self::try_access`]). Plain [`ForLt`](trait@ForLt) types use closure-based accessors
+/// ([`Self::access_with`], [`Self::try_access_with`]).
+pub struct DevresLt<F: ForLt>(Devres<F::Of<'static>>)
+where
+    F::Of<'static>: Send;
+
+impl<F: ForLt> DevresLt<F>
+where
+    F::Of<'static>: Send,
+{
+    /// Creates a new [`DevresLt`] instance of the given `data`.
+    ///
+    /// # Safety
+    ///
+    /// The data must remain valid for the device's full bound scope. [`DevresLt`] allows
+    /// access until the device is unbound, which may outlast `'a`.
+    pub unsafe fn new<'a, E>(
+        dev: &'a Device<Bound>,
+        data: impl PinInit<F::Of<'a>, E>,
+    ) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        // SAFETY: The caller guarantees the data is valid for the device's full bound scope.
+        // Lifetimes do not affect layout, so F::Of<'a> and F::Of<'static> have identical
+        // representation; casting the slot pointer is sound.
+        let data = unsafe {
+            pin_init::pin_init_from_closure::<F::Of<'static>, E>(move |slot| {
+                data.__pinned_init(slot.cast())
+            })
+        };
+
+        Ok(Self(Devres::new(dev, data)?))
+    }
+
+    /// Return a reference of the [`Device`] this [`DevresLt`] instance has been created with.
+    pub fn device(&self) -> &Device {
+        self.0.device()
+    }
+
+    /// Obtain `&F::Of<'_>`, bypassing the [`Revocable`], through a closure.
+    ///
+    /// This method works like [`DevresLt::access`](DevresLt::access) but accepts any
+    /// [`trait@ForLt`] type, not just [`trait@CovariantForLt`].
+    pub fn access_with<R, G>(&self, dev: &Device<Bound>, f: G) -> Result<R>
+    where
+        G: for<'a> FnOnce(&'a F::Of<'a>) -> R,
+    {
+        self.0.access(dev).map(|data| {
+            // SAFETY: The closure's HRTB `for<'a>` prevents the caller from smuggling in
+            // references with a concrete short lifetime, making the round-trip from `'static`
+            // sound regardless of variance.
+            f(unsafe { F::cast_ref_unchecked(data) })
+        })
+    }
+
+    /// [`DevresLt`] accessor for [`Revocable::try_access_with`].
+    pub fn try_access_with<R, G>(&self, f: G) -> Option<R>
+    where
+        G: for<'a> FnOnce(&'a F::Of<'a>) -> R,
+    {
+        self.0.data().try_access_with(|data| {
+            // SAFETY: The closure's HRTB `for<'a>` prevents the caller from smuggling in
+            // references with a concrete short lifetime, making the round-trip from `'static`
+            // sound regardless of variance.
+            f(unsafe { F::cast_ref_unchecked(data) })
+        })
+    }
+}
+
+impl<F: CovariantForLt> DevresLt<F>
+where
+    F::Of<'static>: Send,
+{
+    /// Obtain `&'a F::Of<'a>`, bypassing the [`Revocable`].
+    ///
+    /// This method works like [`Devres::access`], but shortens the returned reference's lifetime
+    /// from `'static` to `'a` via [`CovariantForLt::cast_ref`].
+    pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a F::Of<'a>> {
+        self.0.access(dev).map(F::cast_ref)
+    }
+
+    /// [`DevresLt`] accessor for [`Revocable::try_access`].
+    pub fn try_access(&self) -> Option<DevresGuard<'_, F>> {
+        self.0.data().try_access().map(DevresGuard)
+    }
+}
+
 /// Consume `data` and [`Drop::drop`] `data` once `dev` is unbound.
 fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 where
-- 
2.54.0


