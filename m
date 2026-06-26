Return-Path: <linux-pwm+bounces-9426-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x+cYIubGPmovLgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9426-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:37:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D630D6CFB61
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 20:37:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h5gaLVu2;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9426-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9426-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F84301573F
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 18:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379E63B7B76;
	Fri, 26 Jun 2026 18:36:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22B3B6C19;
	Fri, 26 Jun 2026 18:36:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782499007; cv=none; b=SewTOIlIJchx1v7HbBQ90/DxYmHB2dtu/s7xqJc4tWEd0bnxzLRZfbCfWBsB0IUPOWkJfWzBRcUgT/3ZMvWWfMl4td8QsDs4JyMuuzdN0m7Z1ymXfyDkx3TZ5gEixPnZW3Tnw0jFb0W1drR4+2KrRQ6UsEjZnmyuKFE0GWhZrzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782499007; c=relaxed/simple;
	bh=1tGYYeZ590NMdM1P4fQl1ij7u3dA1w1wZNTISQADfsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxImUrmd8Gsw/znVy1hdCPdpQYqy6AodHzeGonSSC/t7Urabkcs53eyW+331U5ghN9uuTLBeZ9LUyNl6960IxO/bppqHXZERkR3HVLzcyPQBfBPDOTwbmLjCWULnTbjAOhSdvEySoNcIWbbZ+V9B0WFioCZyywh7TAWpf2Fv/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5gaLVu2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591471F00A3E;
	Fri, 26 Jun 2026 18:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782499005;
	bh=e4Afr2GMxqC4Da9aQYcUp5t7a8QkTtefS6XbQ4C5IAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h5gaLVu2KiZ5Q+EyCr2zkPF1MJw92kQDBNlbZiHNebu18gDZR5AtDZLvLsk6FVWtL
	 2nC4vlnnK1fLPIy1peGg+H7ZSpGLWGzwR6Hy8jbpOFeigaoWMWY9/SD5e3Zyp4OglD
	 Y4OFdhUfp552UkaCcIxzMqBzF0JqTIHkBexR8AVGMKLCEKpPw+SW0gOecZ2S7NF2rf
	 +iu4jsaLmtSA1kGBxszGS5m9768UjiiVgR6vvFeDIDXmQFrY5G/p5ZOYal+QwAT9Sa
	 KapTjfhfM2rVJ/pu640IZStGP4u3IFJ/+JyzJoCz++MB5M5iYD881mLeP8S68AREBb
	 PDJLtsEXjbRWw==
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
Subject: [PATCH v4 1/7] rust: types: rename ForLt to CovariantForLt
Date: Fri, 26 Jun 2026 20:36:08 +0200
Message-ID: <20260626183630.2585057-2-dakr@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-9426-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,vger.kernel.org:from_smtp,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D630D6CFB61

Rename ForLt to CovariantForLt to prepare for the introduction of a new
ForLt base trait that does not require covariance.

The existing ForLt trait requires covariance, which enables the safe
cast_ref() method. This rename preserves the same semantics under a more
precise name, making room for a weaker ForLt trait in a subsequent
commit.

No functional change.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  4 +-
 rust/kernel/auxiliary.rs              | 23 +++++------
 rust/kernel/types.rs                  |  2 +-
 rust/kernel/types/for_lt.rs           | 57 ++++++++++++++-------------
 rust/macros/for_lt.rs                 |  6 +--
 rust/macros/lib.rs                    | 11 +++---
 samples/rust/rust_driver_auxiliary.rs |  8 ++--
 7 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5738d4ac521b..48380ac15f68 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -15,7 +15,7 @@
         Atomic,
         Relaxed, //
     },
-    types::ForLt,
+    types::CovariantForLt,
 };
 
 use crate::gpu::Gpu;
@@ -29,7 +29,7 @@ pub(crate) struct NovaCore<'bound> {
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
     #[allow(clippy::type_complexity)]
-    _reg: auxiliary::Registration<'bound, ForLt!(())>,
+    _reg: auxiliary::Registration<'bound, CovariantForLt!(())>,
 }
 
 pub(crate) struct NovaCoreDriver;
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index c42928d5a239..40a0af74a8e5 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -20,7 +20,7 @@
     },
     prelude::*,
     types::{
-        ForLt,
+        CovariantForLt,
         ForeignOwnable,
         Opaque, //
     },
@@ -272,16 +272,16 @@ pub fn parent(&self) -> &device::Device<device::Bound> {
 
     /// Returns a pinned reference to the registration data set by the registering (parent) driver.
     ///
-    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The returned
+    /// `F` is the [`CovariantForLt`](trait@CovariantForLt) encoding of the data type. The returned
     /// reference has its lifetime shortened from `'static` to `&self`'s borrow lifetime via
-    /// [`ForLt::cast_ref`].
+    /// [`CovariantForLt::cast_ref`].
     ///
     /// Returns [`EINVAL`] if `F` does not match the type used by the parent driver when calling
     /// [`Registration::new()`].
     ///
     /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
     /// registered by a C driver.
-    pub fn registration_data<F: ForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
+    pub fn registration_data<F: CovariantForLt + 'static>(&self) -> Result<Pin<&F::Of<'_>>> {
         // SAFETY: By the type invariant, `self.as_raw()` is a valid `struct auxiliary_device`.
         let ptr = unsafe { (*self.as_raw()).registration_data_rust };
         if ptr.is_null() {
@@ -399,8 +399,9 @@ struct RegistrationData<T> {
 /// This type represents the registration of a [`struct auxiliary_device`]. When its parent device
 /// is unbound, the corresponding auxiliary device will be unregistered from the system.
 ///
-/// The type parameter `F` is a [`ForLt`](trait@ForLt) encoding of the registration
-/// data type. For non-lifetime-parameterized types, use [`ForLt!(T)`](macro@ForLt).
+/// The type parameter `F` is a [`CovariantForLt`](trait@CovariantForLt) encoding of the
+/// registration data type. For non-lifetime-parameterized types, use
+/// [`CovariantForLt!(T)`](macro@CovariantForLt).
 /// The data can be accessed by the auxiliary driver through [`Device::registration_data()`].
 ///
 /// # Invariants
@@ -408,12 +409,12 @@ struct RegistrationData<T> {
 /// `self.adev` always holds a valid pointer to an initialized and registered
 /// [`struct auxiliary_device`] whose `registration_data_rust` field points to a
 /// valid `Pin<KBox<RegistrationData<F::Of<'static>>>>`.
-pub struct Registration<'a, F: ForLt + 'static> {
+pub struct Registration<'a, F: CovariantForLt + 'static> {
     adev: NonNull<bindings::auxiliary_device>,
     _phantom: PhantomData<F::Of<'a>>,
 }
 
-impl<'a, F: ForLt> Registration<'a, F>
+impl<'a, F: CovariantForLt> Registration<'a, F>
 where
     for<'b> F::Of<'b>: Send + Sync,
 {
@@ -525,7 +526,7 @@ pub fn new<E>(
     }
 }
 
-impl<F: ForLt> Drop for Registration<'_, F> {
+impl<F: CovariantForLt> Drop for Registration<'_, F> {
     fn drop(&mut self) {
         // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()` is a valid registered
         // `struct auxiliary_device`.
@@ -547,7 +548,7 @@ fn drop(&mut self) {
 }
 
 // SAFETY: A `Registration` of a `struct auxiliary_device` can be released from any thread.
-unsafe impl<F: ForLt> Send for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
+unsafe impl<F: CovariantForLt> Send for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
 
 // SAFETY: `Registration` does not expose any methods or fields that need synchronization.
-unsafe impl<F: ForLt> Sync for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
+unsafe impl<F: CovariantForLt> Sync for Registration<'_, F> where for<'a> F::Of<'a>: Send {}
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index ac316fd7b538..cbe6907042d3 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -13,7 +13,7 @@
 
 #[doc(hidden)]
 pub mod for_lt;
-pub use for_lt::ForLt;
+pub use for_lt::CovariantForLt;
 
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
diff --git a/rust/kernel/types/for_lt.rs b/rust/kernel/types/for_lt.rs
index d44323c28e8d..a11f7509633c 100644
--- a/rust/kernel/types/for_lt.rs
+++ b/rust/kernel/types/for_lt.rs
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
-//! Provide implementation and test of the `ForLt` trait and macro.
+//! Provide implementation and test of the `CovariantForLt` trait and macro.
 //!
-//! This module is hidden and user should just use `ForLt!` directly.
+//! This module is hidden and user should just use `CovariantForLt!` directly.
 
 use core::marker::PhantomData;
 
@@ -15,38 +15,39 @@
 ///
 /// # Macro
 ///
-/// It is not recommended to implement this trait directly. `ForLt!` macro is provided to obtain a
-/// type that implements this trait.
+/// It is not recommended to implement this trait directly. `CovariantForLt!` macro is provided to
+/// obtain a type that implements this trait.
 ///
 /// The full syntax is
 ///
 /// ```
-/// # use kernel::types::ForLt;
-/// # fn expect_lt<F: ForLt>() {}
+/// # use kernel::types::CovariantForLt;
+/// # fn expect_lt<F: CovariantForLt>() {}
 /// # struct TypeThatUse<'a>(&'a ());
 /// # expect_lt::<
-/// ForLt!(for<'a> TypeThatUse<'a>)
+/// CovariantForLt!(for<'a> TypeThatUse<'a>)
 /// # >();
 /// ```
 ///
-/// which gives a type so that `<ForLt!(for<'a> TypeThatUse<'a>) as ForLt>::Of<'b>`
+/// which gives a type so that
+/// `<CovariantForLt!(for<'a> TypeThatUse<'a>) as CovariantForLt>::Of<'b>`
 /// is `TypeThatUse<'b>`.
 ///
 /// You may also use a short-hand syntax which works similar to lifetime elision.
 /// The macro also accepts types that do not involve a lifetime at all.
 ///
 /// ```
-/// # use kernel::types::ForLt;
-/// # fn expect_lt<F: ForLt>() {}
+/// # use kernel::types::CovariantForLt;
+/// # fn expect_lt<F: CovariantForLt>() {}
 /// # struct TypeThatUse<'a>(&'a ());
 /// # expect_lt::<
-/// ForLt!(TypeThatUse<'_>) // Equivalent to `ForLt!(for<'a> TypeThatUse<'a>)`.
+/// CovariantForLt!(TypeThatUse<'_>) // Equivalent to `CovariantForLt!(for<'a> TypeThatUse<'a>)`.
 /// # >();
 /// # expect_lt::<
-/// ForLt!(&u32) // Equivalent to `ForLt!(for<'a> &'a u32)`.
+/// CovariantForLt!(&u32) // Equivalent to `CovariantForLt!(for<'a> &'a u32)`.
 /// # >();
 /// # expect_lt::<
-/// ForLt!(u32) // Equivalent to `ForLt!(for<'a> u32)`.
+/// CovariantForLt!(u32) // Equivalent to `CovariantForLt!(for<'a> u32)`.
 /// # >();
 /// ```
 ///
@@ -55,10 +56,10 @@
 /// it.
 ///
 /// ```ignore,compile_fail
-/// # use kernel::types::ForLt;
-/// # fn expect_lt<F: ForLt>() {}
+/// # use kernel::types::CovariantForLt;
+/// # fn expect_lt<F: CovariantForLt>() {}
 /// # expect_lt::<
-/// ForLt!(fn(&u32)) // Contravariant, will fail compilation.
+/// CovariantForLt!(fn(&u32)) // Contravariant, will fail compilation.
 /// # >();
 /// ```
 ///
@@ -67,23 +68,23 @@
 /// the generic parameter but is in a separate item.
 ///
 /// ```
-/// # use kernel::types::ForLt;
-/// fn expect_lt<F: ForLt>() {}
+/// # use kernel::types::CovariantForLt;
+/// fn expect_lt<F: CovariantForLt>() {}
 /// # #[allow(clippy::unnecessary_safety_comment, reason = "false positive")]
 /// fn generic_fn<T: 'static>() {
 ///     // Syntactically proven by the macro
-///     expect_lt::<ForLt!(&T)>();
+///     expect_lt::<CovariantForLt!(&T)>();
 ///     // Syntactically proven by the macro
-///     expect_lt::<ForLt!(&KBox<T>)>();
+///     expect_lt::<CovariantForLt!(&KBox<T>)>();
 ///     // Cannot be syntactically proven, need to check covariance of `KBox`
-///     // expect_lt::<ForLt!(&KBox<&T>)>();
+///     // expect_lt::<CovariantForLt!(&KBox<&T>)>();
 /// }
 /// ```
 ///
 /// # Safety
 ///
 /// `Self::Of<'a>` must be covariant over the lifetime `'a`.
-pub unsafe trait ForLt {
+pub unsafe trait CovariantForLt {
     /// The type parameterized by the lifetime.
     type Of<'a>: 'a;
 
@@ -94,11 +95,11 @@ fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>) -> &'r Sel
         unsafe { core::mem::transmute(long) }
     }
 }
-pub use macros::ForLt;
+pub use macros::CovariantForLt;
 
 /// This is intended to be an "unsafe-to-refer-to" type.
 ///
-/// Must only be used by the `ForLt!` macro.
+/// Must only be used by the `CovariantForLt!` macro.
 ///
 /// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generated by macro.
 ///
@@ -109,14 +110,14 @@ fn cast_ref<'r, 'short: 'r, 'long: 'short>(long: &'r Self::Of<'long>) -> &'r Sel
 #[doc(hidden)]
 pub struct UnsafeForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData<(WF, T)>);
 
-// This is a helper trait for implementation `ForLt` to be able to use HRTB.
+// This is a helper trait for implementation `CovariantForLt` to be able to use HRTB.
 #[doc(hidden)]
 pub trait WithLt<'a> {
     type Of: 'a;
 }
 
-// SAFETY: In `ForLt!` macro, a covariance proof is generated when naming `UnsafeForLtImpl`
-// and it will fail to evaluate if the type is not covariant.
-unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> ForLt for UnsafeForLtImpl<T, WF, 0> {
+// SAFETY: In `CovariantForLt!` macro, a covariance proof is generated when naming
+// `UnsafeForLtImpl` and it will fail to evaluate if the type is not covariant.
+unsafe impl<T: ?Sized + for<'a> WithLt<'a>, WF> CovariantForLt for UnsafeForLtImpl<T, WF, 0> {
     type Of<'a> = <T as WithLt<'a>>::Of;
 }
diff --git a/rust/macros/for_lt.rs b/rust/macros/for_lt.rs
index 364d4113cd10..9487a9352f1c 100644
--- a/rust/macros/for_lt.rs
+++ b/rust/macros/for_lt.rs
@@ -154,8 +154,8 @@ fn prove(&mut self, ty: &'a Type) {
             // Note that if we encounter `&'other_lt T`, then we still need to make sure the type
             // is wellformed if `T` involves `&'lt`, so we defer to the compiler.
             //
-            // This is to block cases like `ForLt!(for<'a> &'static &'a u32)`, as the presence of
-            // the type implies `'a: 'static` but this is unsound.
+            // This is to block cases like `CovariantForLt!(for<'a> &'static &'a u32)`, as the
+            // presence of the type implies `'a: 'static` but this is unsound.
             Type::Reference(ty)
                 if ty.mutability.is_none() && ty.lifetime.as_ref() == Some(self.0) =>
             {
@@ -176,7 +176,7 @@ fn prove(&mut self, ty: &'a Type) {
     }
 }
 
-pub(crate) fn for_lt(input: HigherRankedType) -> TokenStream {
+pub(crate) fn covariant_for_lt(input: HigherRankedType) -> TokenStream {
     let (ty, lifetime) = match input {
         HigherRankedType::Explicit { lifetime, ty, .. } => (ty, lifetime),
         HigherRankedType::Implicit { ty } => {
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 4a48fabbc268..2167cb270928 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -491,14 +491,13 @@ pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream {
         .into()
 }
 
-/// Obtain a type that implements [`ForLt`] for the given higher-ranked type.
+/// Obtain a type that implements [`CovariantForLt`] for the given higher-ranked type.
 ///
-/// Please refer to the documentation of the [`ForLt`] trait.
+/// Please refer to the documentation of the [`CovariantForLt`] trait.
 ///
-/// [`ForLt`]: trait.ForLt.html
+/// [`CovariantForLt`]: trait.CovariantForLt.html
 #[proc_macro]
-// The macro shares the name with the trait.
 #[allow(non_snake_case)]
-pub fn ForLt(input: TokenStream) -> TokenStream {
-    for_lt::for_lt(parse_macro_input!(input)).into()
+pub fn CovariantForLt(input: TokenStream) -> TokenStream {
+    for_lt::covariant_for_lt(parse_macro_input!(input)).into()
 }
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 2c1351040e45..92ee6a6d348e 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -13,7 +13,7 @@
     driver,
     pci,
     prelude::*,
-    types::ForLt,
+    types::CovariantForLt,
     InPlaceModule, //
 };
 
@@ -60,8 +60,8 @@ struct Data<'bound> {
 
 #[allow(clippy::type_complexity)]
 struct ParentData<'bound> {
-    _reg0: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
-    _reg1: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
+    _reg0: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
+    _reg1: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
 }
 
 kernel::pci_device_table!(
@@ -115,7 +115,7 @@ fn probe<'bound>(
 
 impl ParentDriver {
     fn connect(adev: &auxiliary::Device<Bound>) -> Result {
-        let data = adev.registration_data::<ForLt!(Data<'_>)>()?;
+        let data = adev.registration_data::<CovariantForLt!(Data<'_>)>()?;
         let pdev = data.parent;
 
         dev_info!(
-- 
2.54.0


