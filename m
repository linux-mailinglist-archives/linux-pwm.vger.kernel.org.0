Return-Path: <linux-pwm+bounces-9427-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /oFnDBvHPmpCLgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9427-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:38:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 813CD6CFB91
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:38:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cjIz799V;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9427-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9427-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74553080E67
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0C73B8128;
	Fri, 26 Jun 2026 18:36:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A40D3B7B97;
	Fri, 26 Jun 2026 18:36:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499012; cv=none; b=Oa54Cj6CWY7+Pg4ZzAQQWgsF82cb12TUem92e/IOPBYlF6HSOxM3qLq74HAqFn6u0CEygVqYtSjnNQ3UBIHtrB4z05CRay3FJmfsVxRzB+8Y2wVB10zjNoIyF2XYguxLPHX5DKXYNhQ0VeaqY3bB6DWGb9XXHdW2O3hrNtxveT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499012; c=relaxed/simple;
	bh=9GgR1/hIKkksIYnnv1Pz+uUGtFQDLVeUsCbfHAdLX7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcQ/l38pFstg8KGwc7NnGvWkf00COBh4/TFXNk1ToJfTFFFtUceotenvi7ZQxjVN9t9sdITUhuyxghV6RAhAMK9Wyhe8O6XECOzDoamBVZ8PbV+ugiF/R4PM1RW/lkLweLCf+UObwd3wnDrECYYfgOn6f3icqQ/YXlDbhka3mVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjIz799V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C156E1F000E9;
	Fri, 26 Jun 2026 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499010;
	bh=dbjWsB/o9pmwUbOFSwNyjzxufXt+7eum/gZ3ROFEAbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjIz799VCamTx6CPXw4p7ESPMBy7RQQJ+ut1LcPDef7tsXbJWHOTaPrvB00bTzlva
	 Wjm/Sw1ydZUr3tlEQiynkHLuU6uT24lPDHfmOBK6ZLOZ59z0T7gjqavptWYyRfKcn3
	 nk6OQu/qleYX31kuWVZM2Isz3URtcyCaEMCDQmlCR+M23U0j7RMA4IDDJHw4h/41Qb
	 Ruf0gjcWc7kmWJY3BsV6FJMmBJ/RYMnu4QnM775YAUMrH3uCcD52kxp9hAUQdB4ijd
	 fGAPhgfowct8iETpzbGYaxOw/iyW8ukR50KrVC+NWoUSXIj2b5cQHbIHIwpBeBoclX
	 x1Ptb5Tkn8rrQ==
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
Subject: [PATCH v4 2/7] rust: types: introduce ForLt base trait for CovariantForLt
Date: Fri, 26 Jun 2026 20:36:09 +0200
Message-ID: <20260626183630.2585057-3-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9427-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 813CD6CFB91

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
 rust/macros/for_lt.rs       | 68 ++++++++++++++++++++++++-----------
 rust/macros/lib.rs          | 19 +++++++++-
 4 files changed, 123 insertions(+), 37 deletions(-)

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
index 9487a9352f1c..9270a069cd3a 100644
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
@@ -188,14 +190,33 @@ pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
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
+/// Shared implementation for both `ForLt!` and `CovariantForLt!`.
+///
+/// Both macros run the prover and emit `ProveWf` structs to check well-formedness for all lifetime
+/// instances (workaround for <https://github.com/rust-lang/rust/issues/152489>). `CovariantForLt!`
+/// additionally emits covariance proof functions and sets `N = 1`.
+fn for_lt_inner(input: HigherRankedType, prove_covariance: bool) -> TokenStream {
+    let (ty, lifetime) = resolve_hrt(input);
 
     let mut prover = Prover(&lifetime, Vec::new());
     prover.prove(&ty);
 
     let mut proof = Vec::new();
 
-    // Emit proofs for every type that requires additional compiler help in proving covariance.
     for (idx, required_proof) in prover.1.into_iter().enumerate() {
         // Insert a proof that the type is well-formed.
         //
@@ -210,15 +231,16 @@ struct #wf_proof_name<#lifetime>(
             );
         ));
 
-        // Insert a proof that the type is covariant.
-        let cov_proof_name = format_ident!("prove_covariant_{idx}");
-        proof.push(quote!(
-            fn #cov_proof_name<'__short, '__long: '__short>(
-                long: #wf_proof_name<'__long>
-            ) -> #wf_proof_name<'__short> {
-                long
-            }
-        ));
+        if prove_covariance {
+            let cov_proof_name = format_ident!("prove_covariant_{idx}");
+            proof.push(quote!(
+                fn #cov_proof_name<'__short, '__long: '__short>(
+                    long: #wf_proof_name<'__long>
+                ) -> #wf_proof_name<'__short> {
+                    long
+                }
+            ));
+        }
     }
 
     // Make sure that the type is wellformed when substituting lifetime with `'static`.
@@ -226,13 +248,9 @@ fn #cov_proof_name<'__short, '__long: '__short>(
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
+
+    let n: usize = prove_covariance.into();
 
     quote!(
         ::kernel::types::for_lt::UnsafeForLtImpl::<
@@ -241,8 +259,16 @@ fn #cov_proof_name<'__short, '__long: '__short>(
             {
                 #(#proof)*
 
-                0
+                #n
             }
         >
     )
 }
+
+pub(crate) fn for_lt(input: HigherRankedType) -> TokenStream {
+    for_lt_inner(input, false)
+}
+
+pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
+    for_lt_inner(input, true)
+}
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


