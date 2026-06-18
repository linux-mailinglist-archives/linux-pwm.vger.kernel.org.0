Return-Path: <linux-pwm+bounces-9333-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mqmwJ7F6NGrjZAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9333-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2026 01:09:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD26A307F
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jun 2026 01:09:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jyUkcbmC;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9333-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9333-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9C13305DAD3
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9662B347514;
	Thu, 18 Jun 2026 23:09:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419B352007;
	Thu, 18 Jun 2026 23:09:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781824143; cv=none; b=LK3Rdsi19VQrfJY6JxYgY8QWqFDu2O4oUfv5VtjfahBlsXBu1+0IfxptTey6hE41Iu4a0s/yc1ED+/MsrrNyHD9teftJkeMHeJaMYjRR0qew5FwIxaL4ne0fP/M61Gy5KB2FqGMkzwv8HKWYRBUJtO0tg4eqnQsFmcSNfRBp3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781824143; c=relaxed/simple;
	bh=etUqCkoMe2OyA+VBQ2mcovhDGnUUpHiWY6qnMnGt/Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=im9wlzyVfLsiQdvp23Q0hnrZ5dmqGncqorf/Ep3Ngg2jp9df5l7xLcL7w4Cq5d7bp6zPYvi+KhiKAaLxZBoF01UMKEp93M7lKz4FHmZHvhULLPcE/oG2MFCqp2cYr3XtzDYi8BK1Xvy4MOSQCQh8qj5LVWEXWldKpCwGdKZzjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyUkcbmC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DCC1F00A3D;
	Thu, 18 Jun 2026 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781824141;
	bh=Xu2eAjUi5ThfCRMk75KJ/3zMFKeFVRrG94KE4Gdkui0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyUkcbmCfzJG+HPZk7DdPqsWVEKBoiAFDu0IF1VpZnfGuZW/u25hjphjQLBJGeS7x
	 Ps7ufff21ruGI8eQrJ0kwfRkewAvscF4MWzlUXzQdWc4oyK+Dq0dRpoqKPtYFf0hbe
	 Q65UBiHHw80pcIm/PbBF7mrn2cYYZywxrjUWk0Wg839Fm0shzJO6e6v8qH8vJCyoIP
	 LaWsiurKdCGJr60AxeFgHXzsP02S5yJ11nmbI6Ouoq5FLHcgxp6rWt4iG2aZT817Lq
	 jVLjHBJLHZx2YUL9+lg4nxpwTrK9DtjsSZqo4XQpwwZicHmcKOVmN1EeQcS+od01kP
	 8tCM53gOaK0Qg==
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
Subject: [PATCH v3 2/7] rust: types: introduce ForLt base trait for CovariantForLt
Date: Fri, 19 Jun 2026 01:08:28 +0200
Message-ID: <20260618230834.812007-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618230834.812007-1-dakr@kernel.org>
References: <20260618230834.812007-1-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9333-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BBD26A307F

Add a new ForLt trait as a base for CovariantForLt:

  - ForLt (non-unsafe): represents a type generic over a lifetime, with
    no covariance guarantee.

  - CovariantForLt (unsafe): becomes a subtrait of ForLt that
    additionally proves the type is covariant over its lifetime
    parameter, providing a safe cast_ref() method.

This split allows non-covariant types (e.g. types behind a Mutex) to
implement ForLt and participate in DevresLt / registration data patterns
that use HRTB closures for sound access, without requiring a covariance
proof that would fail to compile.

Both macros share the UnsafeForLtImpl helper type, distinguished by
a const generic N: ForLt! emits N = 0 (no covariance proof),
CovariantForLt! emits N = 1 (with compile-time covariance proof).

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/types.rs        |  1 +
 rust/kernel/types/for_lt.rs | 72 +++++++++++++++++++++++++++++--------
 rust/macros/for_lt.rs       | 53 +++++++++++++++++++++------
 rust/macros/lib.rs          | 19 +++++++++-
 4 files changed, 118 insertions(+), 27 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index cbe6907042d3..c1ed05d1046c 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -14,6 +14,7 @@
 #[doc(hidden)]
 pub mod for_lt;
 pub use for_lt::CovariantForLt;
+pub use for_lt::ForLt;
 
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
index a11f7509633c..0b53494080b7 100644
--- a/rust/kernel/types/for_lt.rs
+++ b/rust/kernel/types/for_lt.rs
@@ -1,17 +1,59 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
-//! Provide implementation and test of the `CovariantForLt` trait and macro.
+//! Provide implementation and test of the `ForLt` and `CovariantForLt` traits and macros.
 //!
-//! This module is hidden and user should just use `CovariantForLt!` directly.
+//! This module is hidden and users should just use `ForLt!` / `CovariantForLt!` directly.
 
 use core::marker::PhantomData;
 
 /// Representation of types generic over a lifetime.
 ///
-/// The type must be covariant over the generic lifetime, i.e. the lifetime parameter
-/// can be soundly shortened.
+/// # Macro
+///
+/// It is not recommended to implement this trait directly. `ForLt!` macro is provided to obtain a
+/// type that implements this trait.
 ///
-/// The lifetime involved must be covariant.
+/// The full syntax is
+///
+/// ```
+/// # use kernel::types::ForLt;
+/// # fn expect_lt<F: ForLt>() {}
+/// # struct TypeThatUse<'a>(&'a ());
+/// # expect_lt::<
+/// ForLt!(for<'a> TypeThatUse<'a>)
+/// # >();
+/// ```
+///
+/// which gives a type so that `<ForLt!(for<'a> TypeThatUse<'a>) as ForLt>::Of<'b>`
+/// is `TypeThatUse<'b>`.
+///
+/// You may also use a short-hand syntax which works similar to lifetime elision.
+/// The macro also accepts types that do not involve a lifetime at all.
+///
+/// ```
+/// # use kernel::types::ForLt;
+/// # fn expect_lt<F: ForLt>() {}
+/// # struct TypeThatUse<'a>(&'a ());
+/// # expect_lt::<
+/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse<'a>)`.
+/// # >();
+/// # expect_lt::<
+/// ForLt!(&u32) // Equivalent to `ForLt!(for<'a> &'a u32)`.
+/// # >();
+/// # expect_lt::<
+/// ForLt!(u32) // Equivalent to `ForLt!(for<'a> u32)`.
+/// # >();
+/// ```
+pub trait ForLt {
+    /// The type parameterized by the lifetime.
+    type Of<'a>: 'a;
+}
+pub use macros::ForLt;
+
+/// [`trait@ForLt`] subtrait for types that are covariant over their lifetime parameter.
+///
+/// Provides a safe [`cast_ref`](CovariantForLt::cast_ref) method for types that are proven to be
+/// covariant. The `CovariantForLt!` macro syntax is the same as `ForLt!`.
 ///
 /// # Macro
 ///
@@ -84,10 +126,7 @@
 /// # Safety
 ///
 /// `Self::Of<'a>` must be covariant over the lifetime `'a`.
-pub unsafe trait CovariantForLt {
-    /// The type parameterized by the lifetime.
-    type Of<'a>: 'a;
-
+pub unsafe trait CovariantForLt: ForLt {
     /// Cast a reference to a shorter lifetime.
     #[inline(always)]
     fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>) -> &'r Self::Of<'short> {
@@ -99,25 +138,28 @@ fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>) -> &'r Sel
 
 /// This is intended to be an "unsafe-to-refer-to" type.
 ///
-/// Must only be used by the `CovariantForLt!` macro.
+/// Must only be used by the `ForLt!` / `CovariantForLt!` macros.
 ///
 /// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generated by macro.
 ///
 /// `WF` is a type that the macro can use to assert some specific type is well-formed.
 ///
 /// `N` is to provide the macro a place to emit arbitrary items, in case it needs to prove
-/// additional properties.
+/// additional properties. `ForLt!` emits `N = 0`; `CovariantForLt!` emits `N = 1` after a
+/// covariance proof.
 #[doc(hidden)]
 pub struct UnsafeForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData<(WF, T)>);
 
-// This is a helper trait for implementation `CovariantForLt` to be able to use HRTB.
+// This is a helper trait for implementation of `ForLt` / `CovariantForLt` to be able to use HRTB.
 #[doc(hidden)]
 pub trait WithLt<'a> {
     type Of: 'a;
 }
 
-// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated when naming
-// `UnsafeForLtImpl` and it will fail to evaluate if the type is not covariant.
-unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> CovariantForLt for UnsafeForLtImpl<T, WF, 0> {
+impl<T: ?Sized + for<'a> WithLt<'a>, WF, const N: usize> ForLt for UnsafeForLtImpl<T, WF, N> {
     type Of<'a> = <T as WithLt<'a>>::Of;
 }
+
+// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated in the `N` const generic
+// and it will fail to evaluate if the type is not covariant. Only `N = 1` gets this impl.
+unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> CovariantForLt for UnsafeForLtImpl<T, WF, 1> {}
diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
index e1233701d6cc..d5f728a464ca 100644
--- a/rust/macros/for_lt.rs
+++ b/rust/macros/for_lt.rs
@@ -176,8 +176,10 @@ fn prove(&mut self, ty: &'a Type) {
     }
 }
 
-pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
-    let (ty, lifetime) = match input {
+/// Resolve the higher-ranked type into a concrete `(ty, lifetime)` pair, expanding elided
+/// lifetimes as needed. Shared by both `for_lt` and `covariant_for_lt`.
+fn resolve_hrt(input: HigherRankedType) -> (Type, Lifetime) {
+    match input {
         HigherRankedType::Explicit { lifetime, ty, .. } => (ty, lifetime),
         HigherRankedType::Implicit { ty } => {
             // If there's no explicit `for<'a>` binder, inject a synthetic `'__elided` lifetime
@@ -188,7 +190,42 @@ pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
             };
             (ty.expand_elided_lifetime(&lifetime), lifetime)
         }
-    };
+    }
+}
+
+/// Produce the `'static`-substituted type for the WF check. Shared by both macros.
+fn ty_static(ty: &Type, lifetime: &Lifetime) -> Type {
+    ty.replace_lifetime(
+        lifetime,
+        &Lifetime {
+            apostrophe: Span::mixed_site(),
+            ident: format_ident!("static"),
+        },
+    )
+}
+
+pub(crate) fn for_lt(input: HigherRankedType) -> TokenStream {
+    let (ty, lifetime) = resolve_hrt(input);
+
+    // Make sure that the type is wellformed when substituting lifetime with `'static`.
+    //
+    // Currently the Rust compiler doesn't check this, see the `ProveWf` documentation in
+    // `covariant_for_lt` below.
+    //
+    // We prefer to use this way of proving WF-ness as it can work when generics are involved.
+    let ty_static = ty_static(&ty, &lifetime);
+
+    quote!(
+        ::kernel::types::for_lt::UnsafeForLtImpl::<
+            dyn for<#lifetime> ::kernel::types::for_lt::WithLt<#lifetime, Of = #ty>,
+            #ty_static,
+            0,
+        >
+    )
+}
+
+pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
+    let (ty, lifetime) = resolve_hrt(input);
 
     let mut prover = Prover(&lifetime, Vec::new());
     prover.prove(&ty);
@@ -226,13 +263,7 @@ fn #cov_proof_name<'__short, '__long: '__short>(
     // Currently the Rust compiler doesn't check this, see the above `ProveWf` documentation.
     //
     // We prefer to use this way of proving WF-ness as it can work when generics are involved.
-    let ty_static = ty.replace_lifetime(
-        &lifetime,
-        &Lifetime {
-            apostrophe: Span::mixed_site(),
-            ident: format_ident!("static"),
-        },
-    );
+    let ty_static = ty_static(&ty, &lifetime);
 
     quote!(
         ::kernel::types::for_lt::UnsafeForLtImpl::<
@@ -241,7 +272,7 @@ fn #cov_proof_name<'__short, '__long: '__short>(
             {
                 #(#proof)*
 
-                0
+                1
             }
         >
     )
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 2167cb270928..e970769609f3 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -491,11 +491,28 @@ pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream {
         .into()
 }
 
-/// Obtain a type that implements [`CovariantForLt`] for the given higher-ranked type.
+/// Obtain a type that implements [`ForLt`] for the given higher-ranked type.
+///
+/// Please refer to the documentation of the [`ForLt`] trait.
+///
+/// [`ForLt`]: trait.ForLt.html
+#[proc_macro]
+#[allow(non_snake_case)]
+pub fn ForLt(input: TokenStream) -> TokenStream {
+    for_lt::for_lt(parse_macro_input!(input)).into()
+}
+
+/// Obtain a type that implements [`CovariantForLt`] (and [`ForLt`]) for the given higher-ranked
+/// type.
+///
+/// Unlike [`ForLt!`], this macro additionally proves that the type is covariant over the lifetime,
+/// providing a safe [`CovariantForLt::cast_ref`] method.
 ///
 /// Please refer to the documentation of the [`CovariantForLt`] trait.
 ///
 /// [`CovariantForLt`]: trait.CovariantForLt.html
+/// [`CovariantForLt::cast_ref`]: trait.CovariantForLt.html#method.cast_ref
+/// [`ForLt`]: trait.ForLt.html
 #[proc_macro]
 #[allow(non_snake_case)]
 pub fn CovariantForLt(input: TokenStream) -> TokenStream {
-- 
2.54.0


