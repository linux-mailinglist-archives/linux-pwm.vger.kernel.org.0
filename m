Return-Path: <linux-pwm+bounces-9228-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LV5RGXV/H2r3mQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9228-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 03:12:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCB5633580
	for <lists+linux-pwm@lfdr.de>; Wed, 03 Jun 2026 03:12:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nXjN3Ebs;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9228-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9228-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33E2B3027398
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2026 01:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF63306775;
	Wed,  3 Jun 2026 01:10:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA2306744;
	Wed,  3 Jun 2026 01:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449044; cv=none; b=gV8tWMUU0vIIOH3JXXvgreE1YrH6dUEzXKaDOsVIZWJ6j8HEeG/AJkXP5aIEWw5J8f0sjvxoOx5P3VNr2jvBXPI1PQX6W9nB1gVpry+eMzTMPTVCrK+nqN7AjuV9X3YNhIEolBSIVnHF9+3u8geRkTsT4f2/+N63RarFjZTJo20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449044; c=relaxed/simple;
	bh=SUON8+Pxy3vTFTdFwSWkETOPYj9qvIfQ6ZVJE6WrdlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwdTzLDntZDCmGZSMktuspYnknnI1K6GIuGkOh48RAszCktFXzpPY3UCWIKzcDNCf5yxgr/OkcOmKDohhqnMTFox/eGTV3VoalBKEf9d7M/sNEykjnuaEkZr5F179D/zuMqo7QzcK6rlbGhpXNMwJcVkiZrHXVDRzYwPE9qOgDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXjN3Ebs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC6B1F0089C;
	Wed,  3 Jun 2026 01:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780449043;
	bh=TNOt0mG9O+FR4MiS/k0pP+w4HT8cI6FiYjIUvgu1jSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nXjN3Ebs1FIyqTUIp+PWz6wIT1ygi1m6ca7FqnI8qvcTOU76EepelD8okDl1cLdqj
	 VAY9TWHWV0XNgFftl8TGOmTlxtWNcwI3Il54yJmyi8c8wK3WvmtC9I3XttlvttECk8
	 deq/cjt2qJvAyWE0dy5b9zbWk2fGlmjPNIhxX+0Z6Aieb8IriTw1V6seGr0FGLuQND
	 4+9Pk0C/yepqSuhG2z3gPPgSbzPXpfkRm68E/KHX4BXIqRADPe5SCgdUTVfIxja+N/
	 pxknkf2W6c8UvYuIGeXNnHXEWl0C0Q+JdBdQzW7kBGqRRb4QVfFlUofPr+8oZ/v1eD
	 5VfNkFdRJ3Vuw==
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
Subject: [PATCH v2 3/7] rust: auxiliary: add registration_data_with() for ForLt types
Date: Wed,  3 Jun 2026 03:10:14 +0200
Message-ID: <20260603011020.2073650-4-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9228-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FCB5633580

Add registration_data_with() taking a for<'a> closure that receives
Pin<&'a F::Of<'a>>, which works with any ForLt type. Taking a for<'a>
closure rather than returning a direct reference prevents callers from
choosing a concrete lifetime for the data, which is required for
soundness with non-covariant ForLt types.

Extract the common null-check, TypeId-check and KBox-borrow logic into a
private registration_data_pinned() helper shared by both
registration_data_with() and the existing registration_data().

Relax Registration's bound from CovariantForLt to ForLt so that
non-covariant types can be registered.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 89 ++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 40a0af74a8e5..81549a3e347e 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -21,6 +21,7 @@
     prelude::*,
     types::{
         CovariantForLt,
+        ForLt,
         ForeignOwnable,
         Opaque, //
     },
@@ -270,18 +271,15 @@ pub fn parent(&self) -> &device::Device<device::Bound> {
         unsafe { parent.as_bound() }
     }
 
-    /// Returns a pinned reference to the registration data set by the registering (parent) driver.
+    /// Returns the stored registration data as a pinned `'static` reference.
     ///
-    /// `F` is the [`CovariantForLt`](trait@CovariantForLt) encoding of the data type. The returned
-    /// reference has its lifetime shortened from `'static` to `&self`'s borrow lifetime via
-    /// [`CovariantForLt::cast_ref`].
+    /// Performs null and [`TypeId`] checks, then borrows the stored [`KBox`].
     ///
-    /// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
-    /// [`Registration::new()`].
+    /// # Safety
     ///
-    /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
-    /// registered by a C driver.
-    pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+    /// The returned `'static` lifetime was transmuted from the device's bound lifetime during
+    /// registration. Callers must shorten it before exposing it.
+    unsafe fn registration_data_pinned<F: ForLt + 'static>(&self) -> Result<Pin<&F::Of<'static>>> {
         // SAFETY: By the type invariant, `self.as_raw()` is a valid `struct auxiliary_device`.
         let ptr = unsafe { (*self.as_raw()).registration_data_rust };
         if ptr.is_null() {
@@ -306,10 +304,58 @@ pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::O
         let wrapper = unsafe { Pin::<KBox<RegistrationData<F::Of<'static>>>>::borrow(ptr) };
 
         // SAFETY: `data` is a structurally pinned field of `RegistrationData`.
-        let pinned: Pin<&F::Of<'_>> = unsafe { wrapper.map_unchecked(|w| &w.data) };
+        Ok(unsafe { wrapper.map_unchecked(|w| &w.data) })
+    }
+
+    /// Access the registration data set by the registering (parent) driver through a closure.
+    ///
+    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The closure receives a pinned
+    /// reference to the registration data.
+    ///
+    /// For covariant types that implement [`trait@CovariantForLt`], prefer
+    /// [`registration_data`](Self::registration_data) which returns a direct reference.
+    ///
+    /// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
+    /// [`Registration::new()`].
+    ///
+    /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
+    /// registered by a C driver.
+    pub fn registration_data_with<F: ForLt + 'static, R>(
+        &self,
+        f: impl for<'a> FnOnce(Pin<&'a F::Of<'a>>) -> R,
+    ) -> Result<R> {
+        // SAFETY: The HRTB closure prevents the caller from smuggling in references with a
+        // concrete short lifetime, making the round-trip from `'static` sound regardless of
+        // variance.
+        let pinned = unsafe { self.registration_data_pinned::<F>()? };
+
+        // SAFETY: See above; the closure's HRTB makes the round-trip sound.
+        let short = unsafe { F::cast_ref_unchecked(pinned.get_ref()) };
+
+        // SAFETY: The data was pinned before the lifetime was shortened; pinning is
+        // orthogonal to lifetimes.
+        Ok(f(unsafe { Pin::new_unchecked(short) }))
+    }
 
-        // SAFETY: The data was pinned when stored; `cast_ref` only shortens
-        // the lifetime, so the pinning guarantee is preserved.
+    /// Returns a pinned reference to the registration data set by the registering (parent) driver.
+    ///
+    /// This method is only available when `F` implements [`trait@CovariantForLt`], which guarantees
+    /// safe lifetime shortening via [`CovariantForLt::cast_ref`].
+    ///
+    /// For non-covariant types, use the closure-based [`Self::registration_data_with`].
+    ///
+    /// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
+    /// [`Registration::new()`].
+    ///
+    /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
+    /// registered by a C driver.
+    pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+        // SAFETY: CovariantForLt guarantees covariance, so cast_ref safely shortens the
+        // `'static` lifetime.
+        let pinned = unsafe { self.registration_data_pinned::<F>()? };
+
+        // SAFETY: The data was pinned before the lifetime was shortened; pinning is orthogonal
+        // to lifetimes.
         Ok(unsafe { Pin::new_unchecked(F::cast_ref(pinned.get_ref())) })
     }
 }
@@ -399,22 +445,23 @@ struct RegistrationData<T> {
 /// This type represents the registration of a [`struct auxiliary_device`]. When its parent device
 /// is unbound, the corresponding auxiliary device will be unregistered from the system.
 ///
-/// The type parameter `F` is a [`CovariantForLt`](trait@CovariantForLt) encoding of the
-/// registration data type. For non-lifetime-parameterized types, use
-/// [`CovariantForLt!(T)`](macro@CovariantForLt).
-/// The data can be accessed by the auxiliary driver through [`Device::registration_data()`].
+/// The type parameter `F` is a [`ForLt`](trait@ForLt) encoding of the registration
+/// data type. For non-lifetime-parameterized types, use [`ForLt!(T)`](macro@ForLt).
+///
+/// The data can be accessed by the auxiliary driver through [`Device::registration_data()`] and
+/// [`Device::registration_data_with()`].
 ///
 /// # Invariants
 ///
 /// `self.adev` always holds a valid pointer to an initialized and registered
 /// [`struct auxiliary_device`] whose `registration_data_rust` field points to a
 /// valid `Pin<KBox<RegistrationData<F::Of<'static>>>>`.
-pub struct Registration<'a, F: CovariantForLt + 'static> {
+pub struct Registration<'a, F: ForLt + 'static> {
     adev: NonNull<bindings::auxiliary_device>,
     _phantom: PhantomData<F::Of<'a>>,
 }
 
-impl<'a, F: CovariantForLt> Registration<'a, F>
+impl<'a, F: ForLt> Registration<'a, F>
 where
     for<'b> F::Of<'b>: Send + Sync,
 {
@@ -526,7 +573,7 @@ pub fn new<E>(
     }
 }
 
-impl<F: CovariantForLt> Drop for Registration<'_, F> {
+impl<F: ForLt> Drop for Registration<'_, F> {
     fn drop(&mut self) {
         // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()` is a valid registered
         // `struct auxiliary_device`.
@@ -548,7 +595,7 @@ fn drop(&mut self) {
 }
 
 // SAFETY: A `Registration` of a `struct auxiliary_device` can be released from any thread.
-unsafe impl<F: CovariantForLt> Send for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
+unsafe impl<F: ForLt> Send for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
 
 // SAFETY: `Registration` does not expose any methods or fields that need synchronization.
-unsafe impl<F: CovariantForLt> Sync for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
+unsafe impl<F: ForLt> Sync for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
-- 
2.54.0


