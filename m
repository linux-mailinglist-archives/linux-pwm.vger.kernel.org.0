Return-Path: <linux-pwm+bounces-8821-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBjUCnq6+2kxEAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8821-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:02:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3574E10C4
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5398304619D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 22:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99523B5305;
	Wed,  6 May 2026 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7ypO5dF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338B3246E8;
	Wed,  6 May 2026 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104840; cv=none; b=IoU2ZUWt7MNkImAelXx+LjUEdrs2p/sdbo58ChcxFl6pO6NJ3sbdS423A29T63H9OysfS7k/fYha3TTjaGeWpokXnrlCLsIn/EP6qA+YV51IrNmI/VMNVa08TOHkvtmtUXiXtJec2PdOjvJOSIXY9UlOwbcLFyni88/EDwYiTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104840; c=relaxed/simple;
	bh=qO/bJBZKk+2JX7D64j+KbHrwyxEIaJ1JMMkQoGp2JnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwlbKQSuZ6hlxxqDUparSi1iNAnfaY50XUEZAo8c9sXGuys8aaT9089fmP29FLpZ+FiCtmuULildyDaDtbAIf1F6/C7+oF6ZhrUW2aDYB6f+8ysX0Dp9K4ipR4/NM0FYYJyKrIYJVQwwBYCHAtCfHjxWcWoAxci/aQiz9QaVBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7ypO5dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3676C2BCB0;
	Wed,  6 May 2026 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778104840;
	bh=qO/bJBZKk+2JX7D64j+KbHrwyxEIaJ1JMMkQoGp2JnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7ypO5dF3L0fBPUCnrrx6TaZenXdgGdQI7+zaewT/iX4gvhZQjbi/XtNoCeKZGSdp
	 huZTtbG64v0FWXWbZqF45iaz77BzK7ymtNMEbsAam7fMkVTTi590vuR1SYKcr4IZoT
	 LtPXr/16xMMQ6Ee7UQPHF2uxcwm/IMrHSnmz5pA4qJDWbApFw9ebqWXZMFUyqUI1Xy
	 dXpKeIBIuj8GTQTqGl74bxNio3acLhxMfT5MBBtmatHZgJEtibHlvuD5eupsft6FEK
	 wznkGnE7WBuXVotsYr+B5d73GxxhmeSldbnQtSNhWirZhDrHARwyBKrYe3GE5sAkm9
	 PcwXFCeFvZANQ==
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
Subject: [PATCH 1/3] rust: devres: add DevresLt for ForLt-aware device resource access
Date: Wed,  6 May 2026 23:58:33 +0200
Message-ID: <20260506220012.855173-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506220012.855173-1-dakr@kernel.org>
References: <20260506220012.855173-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F3574E10C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-8821-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,forlt:email]
X-Rspamd-Action: no action

Devres<T> stores resources as T and returns &'bound T from access(). For
lifetime-parameterized types like Bar<'bound, SIZE> that are transmuted
to 'static for storage, this exposes the synthetic 'static lifetime to
callers -- any method on the stored type that returns a reference with
its lifetime parameter would yield a &'static reference, which is
unsound.

Add DevresLt<F: ForLt>, a thin wrapper around Devres<F::Of<'static>>
that applies ForLt::cast_ref in all access methods to shorten the stored
'static lifetime to the caller's borrow lifetime.

Devres<T: Send> remains unchanged for static resource types.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 97 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 58efe80474bd..c9c698901871 100644
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
@@ -122,7 +123,7 @@ struct Inner<T> {
 /// # Ok(())
 /// # }
 /// ```
-pub struct Devres<T: Send> {
+pub struct Devres<T: Send + 'static> {
     dev: ARef<Device>,
     inner: Arc<Inner<T>>,
 }
@@ -184,7 +185,7 @@ pub(super) unsafe fn devres_node_remove(
     }
 }
 
-impl<T: Send> Devres<T> {
+impl<T: Send + 'static> Devres<T> {
     /// Creates a new [`Devres`] instance of the given `data`.
     ///
     /// The `data` encapsulated within the returned `Devres` instance' `data` will be
@@ -237,7 +238,7 @@ pub fn new<E>(dev: &Device<Bound>, data: impl PinInit<T, E>) -> Result<Self>
         })
     }
 
-    fn data(&self) -> &Revocable<T> {
+    pub(crate) fn data(&self) -> &Revocable<T> {
         &self.inner.data
     }
 
@@ -297,15 +298,19 @@ pub fn device(&self) -> &Device {
     /// #![cfg(CONFIG_PCI)]
     /// use kernel::{
     ///     device::Core,
-    ///     devres::Devres,
+    ///     devres::DevresLt,
     ///     io::{
     ///         Io,
     ///         IoKnownSize, //
     ///     },
-    ///     pci, //
+    ///     pci,
+    ///     types::ForLt, //
     /// };
     ///
-    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<'_, 0x4>>) -> Result {
+    /// fn from_core(
+    ///     dev: &pci::Device<Core>,
+    ///     devres: DevresLt<ForLt!(pci::Bar<'_, 0x4>)>,
+    /// ) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
     ///
     ///     let _ = bar.read32(0x0);
@@ -353,7 +358,7 @@ unsafe impl<T: Send> Send for Devres<T> {}
 // SAFETY: `Devres` can be shared with any task, if `T: Sync`.
 unsafe impl<T: Send + Sync> Sync for Devres<T> {}
 
-impl<T: Send> Drop for Devres<T> {
+impl<T: Send + 'static> Drop for Devres<T> {
     fn drop(&mut self) {
         // SAFETY: When `drop` runs, it is guaranteed that nobody is accessing the revocable data
         // anymore, hence it is safe not to wait for the grace period to finish.
@@ -369,6 +374,84 @@ fn drop(&mut self) {
     }
 }
 
+/// Guard returned by [`DevresLt::try_access`].
+///
+/// Dereferences to `F::Of<'bound>`, applying [`ForLt::cast_ref`] to shorten the lifetime of the
+/// stored data to the guard's borrow lifetime.
+pub struct DevresGuard<'bound, F: ForLt>(RevocableGuard<'bound, F::Of<'static>>);
+
+impl<'bound, F: ForLt> core::ops::Deref for DevresGuard<'bound, F> {
+    type Target = F::Of<'bound>;
+
+    fn deref(&self) -> &Self::Target {
+        F::cast_ref(&*self.0)
+    }
+}
+
+/// Device-managed resource with [`ForLt`](trait@ForLt)-aware access.
+///
+/// `DevresLt` wraps [`Devres`] and applies [`ForLt::cast_ref`] in its access methods to shorten
+/// the stored `'static` lifetime to the caller's borrow lifetime. This prevents transmuted
+/// `'static` lifetimes from leaking to users.
+///
+/// Use this for resource types that implement [`ForLt`](trait@ForLt) and are stored with a
+/// transmuted `'static` lifetime (e.g. [`pci::Bar`]).
+///
+/// [`pci::Bar`]: crate::pci::Bar
+pub struct DevresLt<F: ForLt>(Devres<F::Of<'static>>)
+where
+    F::Of<'static>: Send;
+
+impl<F: ForLt> DevresLt<F>
+where
+    F::Of<'static>: Send,
+{
+    /// Creates a new [`DevresLt`] instance of the given `data`.
+    pub fn new<E>(dev: &Device<Bound>, data: impl PinInit<F::Of<'static>, E>) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        Ok(Self(Devres::new(dev, data)?))
+    }
+
+    /// Return a reference of the [`Device`] this [`DevresLt`] instance has been created with.
+    pub fn device(&self) -> &Device {
+        self.0.device()
+    }
+
+    /// Obtain `&'bound F::Of<'bound>`, bypassing the [`Revocable`].
+    ///
+    /// This method works like [`Devres::access`], but shortens the returned reference's lifetime
+    /// from `'static` to `'bound` via [`ForLt::cast_ref`].
+    pub fn access<'bound>(
+        &'bound self,
+        dev: &'bound Device<Bound>,
+    ) -> Result<&'bound F::Of<'bound>> {
+        self.0.access(dev).map(F::cast_ref)
+    }
+
+    /// [`DevresLt`] accessor for [`Revocable::try_access`].
+    pub fn try_access(&self) -> Option<DevresGuard<'_, F>> {
+        self.0.data().try_access().map(DevresGuard)
+    }
+
+    /// [`DevresLt`] accessor for [`Revocable::try_access_with`].
+    pub fn try_access_with<R, G>(&self, f: G) -> Option<R>
+    where
+        G: for<'bound> FnOnce(&'bound F::Of<'bound>) -> R,
+    {
+        self.0.data().try_access_with(|data| f(F::cast_ref(data)))
+    }
+
+    /// [`DevresLt`] accessor for [`Revocable::try_access_with_guard`].
+    pub fn try_access_with_guard<'bound>(
+        &'bound self,
+        guard: &'bound rcu::Guard,
+    ) -> Option<&'bound F::Of<'bound>> {
+        self.0.data().try_access_with_guard(guard).map(F::cast_ref)
+    }
+}
+
 /// Consume `data` and [`Drop::drop`] `data` once `dev` is unbound.
 fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 where
-- 
2.54.0


