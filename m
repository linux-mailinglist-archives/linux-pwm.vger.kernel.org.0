Return-Path: <linux-pwm+bounces-8705-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJEjOIXf72kiHQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8705-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:13:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B39047B318
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 00:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAA94302BA42
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7D23A7F57;
	Mon, 27 Apr 2026 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQAgRJnW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA43A7F4B;
	Mon, 27 Apr 2026 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327941; cv=none; b=DpqVAgAC8p95Udu+L1X7+urblH1t167TVxRmWSiBFdwvsiww6opaUIsMHHSHOfJH+bgVpdGEuMHaz3UPMKD6NeaDxHWgQfCbtQHB4znbqYynPkx4Yeif6ApAEEhiQDxgIf9RkxhtAMMpaMlozw6ABJXozqFKrjJUWK1nJb7Dz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327941; c=relaxed/simple;
	bh=pZq55eZRbTUZKxw9zFnJXT0p6kpbJ6klMByaUzBGqrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF1Z4bypCXA/TalF3GOwvobnvUoLs2G3XgW/na5MaRhlJa0WYLRiTsdk7Yc4yrC9AoadGpwcl2o2dSzISOX0adV76/x2oj1pMu+ikpswBlsmwCz5BpPhT4yYMQQ0cw8pxagt1duhiqjxHACMcnaXsSS6+UT+g5EMf2eU+3K1KW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQAgRJnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1B3C2BCB7;
	Mon, 27 Apr 2026 22:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327940;
	bh=pZq55eZRbTUZKxw9zFnJXT0p6kpbJ6klMByaUzBGqrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQAgRJnWO09slwMNvi5KoH/ECuE3dX56H3NTQmoRISAJfYPKST2BKY3GQmasQK/+o
	 tzRIVCG2DjKfdAZWGiNdZwQo5XxG05X4hQ/zsLS1bHhcUsIT5XR1x5ktYAQBxr1EcZ
	 +Xkgmfv/aaByw/8SIwwTWRCrRyfuZFPuGq+HaU8/N3LVK4/vvT0SauQpeF4lJv11CY
	 JUZdqTiCxRvxljRH4cDnmC6+40QCyzckAYdfYFGGavK1PK/341c4Ifjqqwhz1BbICq
	 S1Zw+qc6td7rvxj+9So05Taxbb68hKXQYeigw0ZysZh2zdiEYtoMkNLFGgZOxngig/
	 AMaqjN8lMppjw==
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
	rust-for-linux@vger.kernel.org
Subject: [PATCH 02/24] rust: types: add `ForLt` trait for higher-ranked lifetime support
Date: Tue, 28 Apr 2026 00:11:00 +0200
Message-ID: <20260427221155.2144848-3-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 3B39047B318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-8705-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,garyguo.net:email,docs.rs:url]

From: Gary Guo <gary@garyguo.net>

There are a few cases, e.g. when dealing with data referencing each other,
one might want to write code that are generic over lifetimes. For example,
if you want take a function that takes `&'a Foo` and gives `Bar<'a>`, you
can write:

    f: impl for<'a> FnOnce(&'a Foo) -> Bar<'a>,

However, it becomes tricky when you want that function to not have a fixed
`Bar`, but have it be generic again. In this case, one needs something that
is generic over types that are themselves generic over lifetimes.

`ForLt` provides such support. It provides a trait `ForLt` which describes
a type generic over lifetime. One may use `ForLt::Of<'a>` to get an
instance of a type for a specific lifetime.

For the case of cross referencing, one would almost always want the
lifetime to be covariant. Therefore this is also made a requirement for the
`ForLt` trait, so functions with `ForLt` trait bound can assume covariance.

A macro `ForLt!()` is provided to be able to obtain a type that implements
`ForLt`. For example, `ForLt!(for<'a> Bar<'a>)` would yield a type that
`<TheType as ForLt>::Of<'a>` is `Bar<'a>`. This also works with lifetime
elision, e.g. `ForLt!(Bar<'_>)` or for types without lifetime at all, e.g.
`ForLt!(u32)`.

The API design draws inspiration from the higher-kinded-types [1] crate,
however different design decision has been taken (e.g. covariance
requirement) and the implementation is independent.

License headers use "Apache-2.0 OR MIT" because I anticipate this to be
used in pin-init crate too which is licensed as such.

Link: https://docs.rs/higher-kinded-types/ [1]

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/Makefile               |   1 +
 rust/kernel/types.rs        |   4 +
 rust/kernel/types/for_lt.rs | 117 +++++++++++++++++
 rust/macros/for_lt.rs       | 242 ++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs          |  12 ++
 5 files changed, 376 insertions(+)
 create mode 100644 rust/kernel/types/for_lt.rs
 create mode 100644 rust/macros/for_lt.rs

diff --git a/rust/Makefile b/rust/Makefile
index b361bfedfdf0..c5a9a3339416 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -110,6 +110,7 @@ syn-cfgs := \
     feature="parsing" \
     feature="printing" \
     feature="proc-macro" \
+    feature="visit" \
     feature="visit-mut"
 
 syn-flags := \
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 4329d3c2c2e5..3119401dcb9f 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -11,6 +11,10 @@
 };
 use pin_init::{PinInit, Wrapper, Zeroable};
 
+#[doc(hidden)]
+pub mod for_lt;
+pub use for_lt::ForLt;
+
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
 /// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
new file mode 100644
index 000000000000..4983cc761f80
--- /dev/null
+++ b/rust/kernel/types/for_lt.rs
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+//! Provide implementation and test of the `ForLt` trait and macro.
+//!
+//! This module is hidden and user should just use `ForLt!` directly.
+
+use core::marker::PhantomData;
+
+/// Representation of types generic over a lifetime.
+///
+/// The type must be covariant over the generic lifetime, i.e. the lifetime parameter
+/// can be soundly shorterned.
+///
+/// The lifetime involved must be covariant.
+///
+/// # Macro
+///
+/// It is not recommended to implement this trait directly. `ForLt!` macro is provided to obtain a
+/// type that implements this trait.
+///
+/// The full syntax is
+/// ```
+/// # use kernel::types::ForLt;
+/// # fn expect_lt<F: ForLt>() {}
+/// # struct TypeThatUse<'a>(&'a ());
+/// # expect_lt::<
+/// ForLt!(for<'a> TypeThatUse<'a>)
+/// # >();
+/// ```
+/// which gives a type so that `<ForLt!(for<'a> TypeThatUse<'a>) as ForLt>::Of<'b>`
+/// is `TypeThatUse<'b>`.
+///
+/// You may also use a short-hand syntax which works similar to lifetime elision.
+/// The macro also accepts types that does not involved lifetime at all.
+/// ```
+/// # use kernel::types::ForLt;
+/// # fn expect_lt<F: ForLt>() {}
+/// # struct TypeThatUse<'a>(&'a ());
+/// # expect_lt::<
+/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse<'a>)`
+/// # >();
+/// # expect_lt::<
+/// ForLt!(&u32) // Equivalent to `ForLt!(for<'a> &'a u32)`
+/// # >();
+/// # expect_lt::<
+/// ForLt!(u32) // Equivalent to `ForLt!(for<'a> u32)`
+/// # >();
+/// ```
+///
+/// The macro will attempt to prove that the type is indeed covariant over the lifetime supplied.
+/// When it cannot be syntactically proven, it will emit checks to ask the Rust compiler to prove
+/// it.
+/// ```ignore,compile_fail
+/// # use kernel::types::ForLt;
+/// # fn expect_lt<F: ForLt>() {}
+/// # expect_lt::<
+/// ForLt!(fn(&u32)) // Contravariant, will fail compilation.
+/// # >();
+/// ```
+///
+/// There is a limitation if the type refer to generic parameters; if the macro cannot prove the
+/// covariance syntactically, the emitted checks will fail the compilation as it needs to refer to
+/// the generic parameter but is in a separate item.
+/// ```
+/// # use kernel::types::ForLt;
+/// fn expect_lt<F: ForLt>() {}
+/// # #[allow(clippy::unnecessary_safety_comment, reason = "false positive")]
+/// fn generic_fn<T: 'static>() {
+///     // Syntactically proven by the macro
+///     expect_lt::<ForLt!(&T)>();
+///     // Syntactically proven by the macro
+///     expect_lt::<ForLt!(&KBox<T>)>();
+///     // Cannot be syntactically proven, need to check covariance of `KBox`
+///     // expect_lt::<ForLt!(&KBox<&T>)>();
+/// }
+/// ```
+///
+/// # Safety
+///
+/// `Self::Of<'a>` must be covariant over the lifetime `'a`.
+pub unsafe trait ForLt {
+    /// The type parameterized by the lifetime.
+    type Of<'a>;
+
+    /// Cast a reference to a shorter lifetime.
+    #[inline(always)]
+    fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>) -> &'r Self::Of<'short> {
+        // SAFETY: This is sound as this trait guarantees covariance.
+        unsafe { core::mem::transmute(long) }
+    }
+}
+pub use macros::ForLt;
+
+/// This is intended to be an "unsafe-to-refer-to" type.
+///
+/// Must only be used by the `ForLt!` macro.
+///
+/// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generated by macro.
+///
+/// `WF` is a type that the macro can use to assert some specific type is well-formed.
+///
+/// `N` is to provide the macro a place to emit arbitrary items, in case it needs to prove
+/// additional properties.
+#[doc(hidden)]
+pub struct UnsafeForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData<(WF, T)>);
+
+// This is a helper trait for implementation `ForLt` to be able to use HRTB.
+#[doc(hidden)]
+pub trait WithLt<'a> {
+    type Of;
+}
+
+// SAFETY: In `ForLt!` macro, a covariance proof is generated when naming `UnsafeForLtImpl`
+// and it will fail to evaluate if the type is not covariant.
+unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> ForLt for UnsafeForLtImpl<T, WF, 0> {
+    type Of<'a> = <T as WithLt<'a>>::Of;
+}
diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
new file mode 100644
index 000000000000..df2027789713
--- /dev/null
+++ b/rust/macros/for_lt.rs
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use proc_macro2::{
+    Span,
+    TokenStream, //
+};
+use quote::{
+    format_ident,
+    quote, //
+};
+use syn::{
+    parse::{
+        Parse,
+        ParseStream, //
+    },
+    visit::Visit,
+    visit_mut::VisitMut,
+    Lifetime,
+    Result,
+    Token,
+    Type, //
+};
+
+pub(crate) enum HigherRankedType {
+    Explicit {
+        _for_token: Token![for],
+        _lt_token: Token![<],
+        lifetime: Lifetime,
+        _gt_token: Token![>],
+        ty: Type,
+    },
+    Implicit {
+        ty: Type,
+    },
+}
+
+impl Parse for HigherRankedType {
+    fn parse(input: ParseStream<'_>) -> Result<Self> {
+        if input.peek(Token![for]) {
+            Ok(Self::Explicit {
+                _for_token: input.parse()?,
+                _lt_token: input.parse()?,
+                lifetime: input.parse()?,
+                _gt_token: input.parse()?,
+                ty: input.parse()?,
+            })
+        } else {
+            Ok(Self::Implicit { ty: input.parse()? })
+        }
+    }
+}
+
+trait TypeExt {
+    fn expand_elided_lifetime(&self, explicit_lt: &Lifetime) -> Type;
+    fn replace_lifetime(&self, src: &Lifetime, dst: &Lifetime) -> Type;
+    fn has_lifetime(&self, lt: &Lifetime) -> bool;
+}
+
+impl TypeExt for Type {
+    fn expand_elided_lifetime(&self, explicit_lt: &Lifetime) -> Type {
+        struct ElidedLifetimeExpander<'a>(&'a Lifetime);
+
+        impl VisitMut for ElidedLifetimeExpander<'_> {
+            fn visit_lifetime_mut(&mut self, lifetime: &mut Lifetime) {
+                // Expand explicit `'_`
+                if lifetime.ident == "_" {
+                    *lifetime = self.0.clone();
+                }
+            }
+
+            fn visit_type_reference_mut(&mut self, reference: &mut syn::TypeReference) {
+                syn::visit_mut::visit_type_reference_mut(self, reference);
+
+                if reference.lifetime.is_none() {
+                    reference.lifetime = Some(self.0.clone());
+                }
+            }
+        }
+
+        let mut ret = self.clone();
+        ElidedLifetimeExpander(explicit_lt).visit_type_mut(&mut ret);
+        ret
+    }
+
+    fn replace_lifetime(&self, src: &Lifetime, dst: &Lifetime) -> Type {
+        struct LifetimeReplacer<'a>(&'a Lifetime, &'a Lifetime);
+
+        impl VisitMut for LifetimeReplacer<'_> {
+            fn visit_lifetime_mut(&mut self, lifetime: &mut Lifetime) {
+                if lifetime.ident == self.0.ident {
+                    *lifetime = self.1.clone();
+                }
+            }
+        }
+
+        let mut ret = self.clone();
+        LifetimeReplacer(src, dst).visit_type_mut(&mut ret);
+        ret
+    }
+
+    fn has_lifetime(&self, lt: &Lifetime) -> bool {
+        struct HasLifetime<'a>(&'a Lifetime, bool);
+
+        impl Visit<'_> for HasLifetime<'_> {
+            fn visit_lifetime(&mut self, lifetime: &Lifetime) {
+                if lifetime.ident == self.0.ident {
+                    self.1 = true;
+                }
+            }
+        }
+
+        let mut visitor = HasLifetime(lt, false);
+        visitor.visit_type(self);
+        visitor.1
+    }
+}
+
+struct Prover<'a>(&'a Lifetime, Vec<&'a Type>);
+
+impl<'a> Prover<'a> {
+    /// Prove that `ty` is covariant over `'lt`.
+    ///
+    /// This also needs to prove that it'll be wellformed for any instance of `'lt`.
+    /// It can be assumed that `ty` will be wellformed if `'lt` is substituted to `'static`.
+    fn prove(&mut self, ty: &'a Type) {
+        match ty {
+            Type::Paren(ty) => self.prove(&ty.elem),
+            Type::Group(ty) => self.prove(&ty.elem),
+
+            // No lifetime involved
+            Type::Never(_) => {}
+
+            // `[T; N]` and `[T]` is covariant over `T`.
+            Type::Array(ty) => self.prove(&ty.elem),
+            Type::Slice(ty) => self.prove(&ty.elem),
+
+            Type::Tuple(ty) => {
+                for elem in &ty.elems {
+                    self.prove(elem);
+                }
+            }
+
+            // `*const T` is covariant over `T`
+            Type::Ptr(ty) if ty.const_token.is_some() => self.prove(&ty.elem),
+
+            // `&T` is covariant over `T` and lifetime.
+            //
+            // Note that if we encounter `&'other_lt T`, then we still need to make sure the type
+            // is wellformed if `T` involves `&'lt`, so we defer to the compiler.
+            //
+            // This is to block cases like `ForLt!(for<'a> &'static &'a u32)`, as the presence of
+            // the type implies `'a: 'static` but this is unsound.
+            Type::Reference(ty)
+                if ty.mutability.is_none() && ty.lifetime.as_ref() == Some(self.0) =>
+            {
+                self.prove(&ty.elem)
+            }
+
+            // `&[mut] T` is covariant over lifetime.
+            // In case we have `&[mut] NoLifetime`, we don't need to do additional checks.
+            Type::Reference(ty) if !ty.elem.has_lifetime(self.0) => (),
+
+            // No mention of lifetime at all, no need to perform compiler check.
+            ty if !ty.has_lifetime(self.0) => (),
+
+            // Otherwise, we need to emit checks so that compiler can determine if the types are
+            // actually covariant.
+            ty => self.1.push(ty),
+        }
+    }
+}
+
+pub(crate) fn for_lt(input: HigherRankedType) -> TokenStream {
+    let (ty, lifetime) = match input {
+        HigherRankedType::Explicit { lifetime, ty, .. } => (ty, lifetime),
+        HigherRankedType::Implicit { ty } => {
+            // If there's no explicit `for<'a>` binder, inject a synthetic `'__elided` lifetime
+            // and expand elided sites.
+            let lifetime = Lifetime {
+                apostrophe: Span::mixed_site(),
+                ident: format_ident!("__elided", span = Span::mixed_site()),
+            };
+            (ty.expand_elided_lifetime(&lifetime), lifetime)
+        }
+    };
+
+    let mut prover = Prover(&lifetime, Vec::new());
+    prover.prove(&ty);
+
+    let mut proof = Vec::new();
+
+    // Emit proofs for every type that requires additional compiler help in proving covariance.
+    for (idx, required_proof) in prover.1.into_iter().enumerate() {
+        // Insert a proof that the type is well-formed.
+        //
+        // This is intended to workaround a Rust compiler soundness bug related to HRTB.
+        // https://github.com/rust-lang/rust/issues/152489
+        //
+        // This needs to be a struct instead of fn to avoid the implied WF bounds.
+        let wf_proof_name = format_ident!("ProveWf{idx}");
+        proof.push(quote!(
+            struct #wf_proof_name<#lifetime>(
+                ::core::marker::PhantomData<&#lifetime ()>, #required_proof
+            );
+        ));
+
+        // Insert a proof that the type is covariant.
+        let cov_proof_name = format_ident!("prove_covariant_{idx}");
+        proof.push(quote!(
+            fn #cov_proof_name<'__short, '__long: '__short>(
+                long: #wf_proof_name<'__long>
+            ) -> #wf_proof_name<'__short> {
+                long
+            }
+        ));
+    }
+
+    // Make sure that the type is wellformed when substituting lifetime with `'static`.
+    //
+    // Currently the Rust compiler doesn't check this, see the above ProveWf documentation.
+    //
+    // We prefer to use this way of proving WF-ness as it can work when generics are involved.
+    let ty_static = ty.replace_lifetime(
+        &lifetime,
+        &Lifetime {
+            apostrophe: Span::mixed_site(),
+            ident: format_ident!("static"),
+        },
+    );
+
+    quote!(
+        ::kernel::types::for_lt::UnsafeForLtImpl::<
+            dyn for<#lifetime> ::kernel::types::for_lt::WithLt<#lifetime, Of = #ty>,
+            #ty_static,
+            {
+                #(#proof)*
+
+                0
+            }
+        >
+    )
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 2cfd59e0f9e7..e5f6f8318112 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -17,6 +17,7 @@
 mod concat_idents;
 mod export;
 mod fmt;
+mod for_lt;
 mod helpers;
 mod kunit;
 mod module;
@@ -489,3 +490,14 @@ pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream {
         .unwrap_or_else(|e| e.into_compile_error())
         .into()
 }
+
+/// Obtain a type that implements `ForLt` for the given higher-ranked type.
+///
+/// Please refer to the documentation of [`ForLt`] trait.
+///
+/// [`ForLt`]: trait.ForLt.html
+#[proc_macro]
+#[allow(non_snake_case)] // The macro shares the name with the trait.
+pub fn ForLt(input: TokenStream) -> TokenStream {
+    for_lt::for_lt(parse_macro_input!(input)).into()
+}
-- 
2.54.0


