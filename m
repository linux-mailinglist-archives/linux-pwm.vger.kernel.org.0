Return-Path: <linux-pwm+bounces-9430-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DzIqGAPHPmo7LgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9430-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:37:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE7A6CFB82
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:37:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kyKfO1Q+;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9430-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9430-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB4FF30102D9
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4943B7B98;
	Fri, 26 Jun 2026 18:37:13 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F33B8127;
	Fri, 26 Jun 2026 18:37:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499033; cv=none; b=jWwJlMgewk5kbnl8/pGUOb2aE1blQLIGx0lCpAvl/5BaBbY2RqNBjlYGADypk03q7LgYlbiq1p5pdjKdHBmuuYL9eepXTF5iguPXt7CWH0Tl2q9/F21OcPRamfJgRE6s7Kfxy6qAuzF9x48ld6UAfyWNPdjBxWEtkFOQC/Mhbok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499033; c=relaxed/simple;
	bh=9sj/cRMpLt+TlJNhxcoV/gazrjzc/lNtCfkjjafqrUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEuxmLYITNK22XKZ/mDC9gOrc9LcR+/vmFmyQ2FCRIYl96giaCo9/hjQQ/YsfocjG2BjawQTAZhriIzXq5FdI4A2Z/uan2ITQHJvDvrMaFn4wp1xmm9kfeyptFZ7TyoimulPg/oVDvUz608B8Qy5ytAg5Ntv92qVtXfvcY2tm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyKfO1Q+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380691F00A3D;
	Fri, 26 Jun 2026 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499027;
	bh=vZGB6qCrIRYgQIhUbEYjio6sdJ2mRmJy/xD6B/oeiaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kyKfO1Q+cbSv8VF0wxi+etrSA+L1wjWySaWAIb2gxgxeJsaGfkq/jvW3T1PXU08Pt
	 gJSwxxIh/mdfXuDwGUMCcKmWyhBzWJ+pfA9wUn2WFklNYslO01YaSYjNeFG+zzqRGQ
	 YftdKaAg25F0q3rzRbk3bHqFHQhtd67EjcTkjjosgXP9yowFjFR4GmezxV4fglyna1
	 Gh5PGFipjgc7F6BvqGLymvIyGGD4dQCbH/XyFwpVGlWbPWqwUyNXfXHrt5h1lds15o
	 2kGgc3W1QdqpzwewObnWCFpjy0NvfwaD45mhJh48XWc/86wdcHmsus0YkmxHhwT0MY
	 ghYNmyGvbiDtA==
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
Subject: [PATCH v4 5/7] rust: devres: add DevresLt for ForLt-aware device resource access
Date: Fri, 26 Jun 2026 20:36:12 +0200
Message-ID: <20260626183630.2585057-6-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9430-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FE7A6CFB82

Devres<T> stores resources as T and returns &'a T from access(). For
lifetime-parameterized types like Bar<'a, SIZE> that are transmuted to
'static for storage, this exposes the synthetic 'static lifetime to
callers -- any method on the stored type that returns a reference with
its lifetime parameter would yield a &'static reference, which is
unsound.

Add DevresLt<F: ForLt>, a thin wrapper around Devres<F::Of<'static>>
that shortens the stored 'static lifetime to the caller's borrow
lifetime in all access methods.

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

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 106 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 11ce500e9b76..b7c075a39ba4 100644
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
@@ -365,6 +367,110 @@ fn drop(&mut self) {
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
+    #[inline]
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
+    for<'a> F::Of<'a>: Send;
+
+impl<F: ForLt> DevresLt<F>
+where
+    for<'a> F::Of<'a>: Send,
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
+    #[inline]
+    pub fn device(&self) -> &Device {
+        self.0.device()
+    }
+
+    /// Obtain `&F::Of<'_>`, bypassing the [`Revocable`], through a closure.
+    ///
+    /// This method works like [`DevresLt::access`](DevresLt::access) but accepts any
+    /// [`trait@ForLt`] type, not just [`trait@CovariantForLt`].
+    #[inline]
+    pub fn access_with<R, G>(&self, dev: &Device<Bound>, f: G) -> Result<R>
+    where
+        G: for<'a> FnOnce(&F::Of<'a>) -> R,
+    {
+        self.0.access(dev).map(f)
+    }
+
+    /// [`DevresLt`] accessor for [`Revocable::try_access_with`].
+    #[inline]
+    pub fn try_access_with<R, G>(&self, f: G) -> Option<R>
+    where
+        G: for<'a> FnOnce(&F::Of<'a>) -> R,
+    {
+        self.0.data().try_access_with(f)
+    }
+}
+
+impl<F: CovariantForLt> DevresLt<F>
+where
+    for<'a> F::Of<'a>: Send,
+{
+    /// Obtain `&'a F::Of<'a>`, bypassing the [`Revocable`].
+    ///
+    /// This method works like [`Devres::access`], but shortens the returned reference's lifetime
+    /// from `'static` to `'a` via [`CovariantForLt::cast_ref`].
+    #[inline]
+    pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a F::Of<'a>> {
+        self.0.access(dev).map(F::cast_ref)
+    }
+
+    /// [`DevresLt`] accessor for [`Revocable::try_access`].
+    #[inline]
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


