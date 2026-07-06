Return-Path: <linux-pwm+bounces-9613-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bswuKkHdS2qRbgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9613-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 18:52:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDB3713862
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 18:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=gX61wBBb;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9613-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9613-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9D7F374A85D
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDFF40A94C;
	Mon,  6 Jul 2026 14:38:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B173E3D8B;
	Mon,  6 Jul 2026 14:38:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348730; cv=pass; b=aFxauEZPI41egcgbykB4r5FIbO/wAHH+RDzVpFVTgPjtKCcJGEocqA//aEXVfEQ74XJbVEe1E3HhQStOiuhP3vwrO5xhe8AUCk6nsSuxE/AeyYZg4dDN5P0c8yFnzoa0+zbF0V2QSgv4ARm6oTM/9Efam0bKQpKUqjPfGL8bRok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348730; c=relaxed/simple;
	bh=CvCft2laOjkq0hKCSm4slSQxLApI9/LWwp9wZDc7XgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoLsYEjTfAGeaucSgCO9DpiUJLs1dYwLuNB4wrW3pP2Z4rsocDXChBxAi69vpxvb6LcFIn8DRQZFFdBFD1kpPEnsiduH3ZuysfCcWqbWpt5hIqe0WuykiHzTn0wrsNwW4MO3ModjLUbcR+zhH6QjSV+b608Rislv35jb7FbqvvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=gX61wBBb; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783348666; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fuyyuP1MRySyzsT8Mm+cyQV3QLe5uVRJt7hq71I3JnS0T11Me45vPw9Xtg6hH5QJfbIr2AmEvErqHyXx5BbNXjBpXI8OzHA5RmTRp2p7UTn1mNMl9WOKRhvJJPg43iM84VfCyWiET+lO6qgnRTrObgojQC2QsbUmRwgskkZUvC4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783348666; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T/zgfvNUmDyE3TB4DFfwT++P3v+ov4Zjeb1HOGHJm3w=; 
	b=KoV3ZL9TmM8U0kFvaYVLe/I3PtZkUEdqDg2YdNhRy6x0QK71Oz82i2m6IToBYWjjX9PxQ4VQbviH6KmV7N/tMuRypfurnghzF4QO5cNRJqBDWSmsmrI7Bc2cb0XN5A9PUp7jvQPuO9uPvq1D7PFZLel6Yibz81SBsp7MwXHtKmM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783348666;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=T/zgfvNUmDyE3TB4DFfwT++P3v+ov4Zjeb1HOGHJm3w=;
	b=gX61wBBbgvsbwvYDPsnXWwHnktT0P4/lOgl1yfLPi4c/VXOh5En+XZXryQkR5bbZ
	gOzUG/jYeUkpVmtz6qmpiNdjQmam9fM/NH+W+2bVhk3vy3sQUv4iynCoqY3eGUoM9EE
	MOY7WAqBj6tR1jd3GlSYdLFKcvzp+UNLXqzVKka4=
Received: by mx.zohomail.com with SMTPS id 1783348665694714.7937200385192;
	Mon, 6 Jul 2026 07:37:45 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 06 Jul 2026 11:37:13 -0300
Subject: [PATCH v5 2/4] rust: clk: implement Clone for Clk<T>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-clk-type-state-v5-2-67c5f326a16c@collabora.com>
References: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
In-Reply-To: <20260706-clk-type-state-v5-0-67c5f326a16c@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Boqun Feng <boqun@kernel.org>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, Maurice <mhi@mailbox.org>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:dakr@kernel.org,m:aliceryhl@google.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:m.wilczynski@samsung.com,m:boqun@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:boris.brezillon@collabora.com,m:work@onurozkan.dev,m:mhi@mailbox.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,google.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,collabora.com,samsung.com];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9613-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[collabora.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BDB3713862

The type-state pattern makes state transitions consume the Clk value,
which means a single Clk cannot be shared between users that need to
hold the clock in different states, nor can a driver keep a long-lived
Clk<Prepared> around while temporarily enabling it for scoped sections.

Implement Clone for Clk<T>: each clone is an independent view of the
same underlying clock, in the same state, owning its own
clk_prepare()/clk_enable() counts, e.g.:

	let enabled_clk = prepared_clk.clone().enable()?;

	// Do stuff that requires the clock to be enabled.

	// enabled_clk goes out of scope and releases the counts it
	// owns; the clock remains prepared through prepared_clk.

Since struct clk is not refcounted on the C side, share it between
clones by wrapping the pointer in an Arc'd RawClk, whose drop
implementation calls clk_put() exactly once, when the last clone goes
out of scope. This costs one small allocation per clk_get(), which was
deemed negligible when compared against the pre-existing indirections
in the clk framework.

Cloning a prepared (or enabled) Clk calls clk_prepare() (and
clk_enable()) on the underlying clock. These calls cannot fail here:
the value being cloned already holds a count of each, so the C side
only increments the respective counts. This is what makes an infallible
Clone implementation possible.

The DISABLE_ON_DROP and UNPREPARE_ON_DROP constants are renamed to
ENABLED and PREPARED respectively, since they now describe the state
for both Drop and Clone. #[repr(transparent)] is removed from Clk<T>,
as the layout is no longer transparent over the raw clk pointer.

This was proposed and discussed on the list in response to v3 [1], with
a prototype by Boris Brezillon [2].

Link: https://lore.kernel.org/r/20260203113902.501e5803@fedora [1]
Link: https://gitlab.freedesktop.org/bbrezillon/linux/-/commit/d5d04da4f4f6192b6e6760d5f861c69596c7d837 [2]
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 181 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 139 insertions(+), 42 deletions(-)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index a9edfdf9db68..dd5fd656271e 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -83,6 +83,7 @@ mod common_clk {
         device::{Bound, Device},
         error::{from_err_ptr, to_result, Result},
         prelude::*,
+        sync::Arc,
     };
 
     use core::{marker::PhantomData, mem::ManuallyDrop, ptr};
@@ -97,11 +98,11 @@ impl Sealed for super::Enabled {}
 
     /// A trait representing the different states that a [`Clk`] can be in.
     pub trait ClkState: private::Sealed {
-        /// Whether the clock should be disabled when dropped.
-        const DISABLE_ON_DROP: bool;
+        /// Whether the clock is enabled in this state.
+        const ENABLED: bool;
 
-        /// Whether the clock should be unprepared when dropped.
-        const UNPREPARE_ON_DROP: bool;
+        /// Whether the clock is prepared in this state.
+        const PREPARED: bool;
     }
 
     /// A state where the [`Clk`] is not prepared and not enabled.
@@ -114,18 +115,18 @@ pub trait ClkState: private::Sealed {
     pub struct Enabled;
 
     impl ClkState for Unprepared {
-        const DISABLE_ON_DROP: bool = false;
-        const UNPREPARE_ON_DROP: bool = false;
+        const ENABLED: bool = false;
+        const PREPARED: bool = false;
     }
 
     impl ClkState for Prepared {
-        const DISABLE_ON_DROP: bool = false;
-        const UNPREPARE_ON_DROP: bool = true;
+        const ENABLED: bool = false;
+        const PREPARED: bool = true;
     }
 
     impl ClkState for Enabled {
-        const DISABLE_ON_DROP: bool = true;
-        const UNPREPARE_ON_DROP: bool = true;
+        const ENABLED: bool = true;
+        const PREPARED: bool = true;
     }
 
     /// An error that can occur when trying to convert a [`Clk`] between states.
@@ -183,13 +184,15 @@ fn from(err: Error<State>) -> Self {
     /// portion of the kernel or a `NULL` pointer.
     ///
     /// Instances of this type are reference-counted. Calling [`Clk::get`] ensures that the
-    /// allocation remains valid for the lifetime of the [`Clk`].
+    /// allocation remains valid for the lifetime of the [`Clk`] and of all its clones: the
+    /// underlying [`struct clk`] is obtained through a single call to `clk_get()`, which is
+    /// balanced by a single call to `clk_put()` when the last clone is dropped.
     ///
-    /// The [`Prepared`] state is associated with a single count of
-    /// `clk_prepare()`, and the [`Enabled`] state is associated with a single
-    /// count of both `clk_prepare()` and `clk_enable()`.
-    ///
-    /// All states are associated with a single count of `clk_get()`.
+    /// Each [`Clk`] value owns its own state counts: the [`Prepared`] state is
+    /// associated with a single count of `clk_prepare()`, and the [`Enabled`]
+    /// state is associated with a single count of both `clk_prepare()` and
+    /// `clk_enable()`. These counts are released when the value transitions to
+    /// a lower state or is dropped.
     ///
     /// # Examples
     ///
@@ -268,13 +271,57 @@ fn from(err: Error<State>) -> Self {
     /// }
     /// ```
     ///
+    /// Cloning a [`Clk`] yields an independent view of the same underlying
+    /// clock, in the same state, owning its own state counts. This lets a
+    /// driver keep e.g. a long-lived [`Clk<Prepared>`] around and temporarily
+    /// enable a clone of it:
+    ///
+    /// ```
+    /// use kernel::clk::{Clk, Enabled, Prepared};
+    /// use kernel::error::Result;
+    ///
+    /// fn use_clk(prepared_clk: &Clk<Prepared>) -> Result {
+    ///     let enabled_clk: Clk<Enabled> = prepared_clk.clone().enable()?;
+    ///
+    ///     // Do something that requires the clock to be enabled.
+    ///
+    ///     // `enabled_clk` is dropped here and releases its own counts; the
+    ///     // clock remains prepared through `prepared_clk`.
+    ///     Ok(())
+    /// }
+    /// ```
+    ///
+    /// Note that cloning a [`Clk<Prepared>`] or a [`Clk<Enabled>`] may sleep.
+    ///
     /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
-    #[repr(transparent)]
     pub struct Clk<T: ClkState> {
-        inner: *mut bindings::clk,
+        inner: Arc<RawClk>,
         _phantom: core::marker::PhantomData<T>,
     }
 
+    /// Owns a single `clk_get()` reference to a [`struct clk`].
+    ///
+    /// This is shared by every clone of a [`Clk`], so that `clk_put()` is
+    /// called exactly once, when the last clone is dropped.
+    ///
+    /// # Invariants
+    ///
+    /// The wrapped pointer is either a pointer to a valid [`struct clk`]
+    /// obtained through `clk_get()` or one of its variants, or `NULL`.
+    ///
+    /// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+    #[repr(transparent)]
+    struct RawClk(*mut bindings::clk);
+
+    impl Drop for RawClk {
+        #[inline]
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, `self.0` is a valid argument for
+            // [`clk_put`], which also accepts a `NULL` pointer.
+            unsafe { bindings::clk_put(self.0) };
+        }
+    }
+
     // SAFETY: It is safe to call `clk_put` on another thread than where `clk_get` was called.
     unsafe impl<T: ClkState> Send for Clk<T> {}
 
@@ -311,11 +358,14 @@ pub(crate) fn get_unbound(dev: &Device, name: Option<&CStr>) -> Result<Clk<Unpre
 
             // SAFETY: It is safe to call [`clk_get`] for a valid device pointer
             // and any `con_id`, including NULL.
-            let inner = from_err_ptr(unsafe { bindings::clk_get(dev.as_raw(), con_id) })?;
+            let clk = from_err_ptr(unsafe { bindings::clk_get(dev.as_raw(), con_id) })?;
 
-            // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
+            // INVARIANT: The single `clk_get()` reference is owned by `RawClk`,
+            // which releases it when the last clone of this [`Clk`] goes out of
+            // scope. If the allocation fails, `Arc::new` drops the `RawClk`,
+            // releasing the reference.
             Ok(Self {
-                inner,
+                inner: Arc::new(RawClk(clk), GFP_KERNEL)?,
                 _phantom: PhantomData,
             })
         }
@@ -329,11 +379,14 @@ pub fn get_optional(dev: &Device<Bound>, name: Option<&CStr>) -> Result<Clk<Unpr
 
             // SAFETY: It is safe to call [`clk_get`] for a valid device pointer
             // and any `con_id`, including NULL.
-            let inner = from_err_ptr(unsafe { bindings::clk_get_optional(dev.as_raw(), con_id) })?;
+            let clk = from_err_ptr(unsafe { bindings::clk_get_optional(dev.as_raw(), con_id) })?;
 
-            // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
+            // INVARIANT: The single `clk_get()` reference is owned by `RawClk`,
+            // which releases it when the last clone of this [`Clk`] goes out of
+            // scope. If the allocation fails, `Arc::new` drops the `RawClk`,
+            // releasing the reference.
             Ok(Self {
-                inner,
+                inner: Arc::new(RawClk(clk), GFP_KERNEL)?,
                 _phantom: PhantomData,
             })
         }
@@ -356,7 +409,10 @@ pub fn prepare(self) -> Result<Clk<Prepared>, Error<Unprepared>> {
                 // `Clk<Prepared>` owns a single count of it, which is released
                 // when it leaves the [`Prepared`] state.
                 .map(|()| Clk {
-                    inner: clk.inner,
+                    // SAFETY: `clk` is wrapped in `ManuallyDrop`, so its `Arc`
+                    // reference is never released; moving it out here keeps the
+                    // reference count balanced.
+                    inner: unsafe { ptr::read(&clk.inner) },
                     _phantom: PhantomData,
                 })
                 .map_err(|error| Error {
@@ -404,9 +460,12 @@ pub fn unprepare(self) -> Clk<Unprepared> {
             unsafe { bindings::clk_unprepare(clk.as_raw()) }
 
             // INVARIANT: The `clk_prepare()` count was released above, so the
-            // returned `Clk<Unprepared>` owns only the `clk_get()` count.
+            // returned `Clk<Unprepared>` owns only the `clk_get()` reference.
             Clk {
-                inner: clk.inner,
+                // SAFETY: `clk` is wrapped in `ManuallyDrop`, so its `Arc`
+                // reference is never released; moving it out here keeps the
+                // reference count balanced.
+                inner: unsafe { ptr::read(&clk.inner) },
                 _phantom: PhantomData,
             }
         }
@@ -429,7 +488,10 @@ pub fn enable(self) -> Result<Clk<Enabled>, Error<Prepared>> {
                 // `Clk<Enabled>` owns a single count of it, which is released
                 // when it leaves the [`Enabled`] state.
                 .map(|()| Clk {
-                    inner: clk.inner,
+                    // SAFETY: `clk` is wrapped in `ManuallyDrop`, so its `Arc`
+                    // reference is never released; moving it out here keeps the
+                    // reference count balanced.
+                    inner: unsafe { ptr::read(&clk.inner) },
                     _phantom: PhantomData,
                 })
                 .map_err(|error| Error {
@@ -474,7 +536,10 @@ pub fn with_enabled<R>(&self, cb: impl FnOnce(&Clk<Enabled>) -> R) -> Result<R>
             //
             // INVARIANT: The clock is enabled for the lifetime of `enabled`.
             let enabled = ManuallyDrop::new(Clk::<Enabled> {
-                inner: self.inner,
+                // SAFETY: The duplicate `Arc` reference is wrapped in
+                // `ManuallyDrop` and thus never released, keeping the reference
+                // count balanced.
+                inner: unsafe { ptr::read(&self.inner) },
                 _phantom: PhantomData,
             });
 
@@ -527,10 +592,13 @@ pub fn disable(self) -> Clk<Prepared> {
             unsafe { bindings::clk_disable(clk.as_raw()) };
 
             // INVARIANT: The `clk_enable()` count was released above, so the
-            // returned `Clk<Prepared>` owns the `clk_get()` and `clk_prepare()`
-            // counts.
+            // returned `Clk<Prepared>` owns the `clk_get()` reference and the
+            // `clk_prepare()` count.
             Clk {
-                inner: clk.inner,
+                // SAFETY: `clk` is wrapped in `ManuallyDrop`, so its `Arc`
+                // reference is never released; moving it out here keeps the
+                // reference count balanced.
+                inner: unsafe { ptr::read(&clk.inner) },
                 _phantom: PhantomData,
             }
         }
@@ -540,7 +608,7 @@ impl<T: ClkState> Clk<T> {
         /// Obtain the raw [`struct clk`] pointer.
         #[inline]
         pub fn as_raw(&self) -> *mut bindings::clk {
-            self.inner
+            self.inner.0
         }
 
         /// Get clock's rate.
@@ -573,21 +641,50 @@ pub fn set_rate(&self, rate: Hertz) -> Result {
 
     impl<T: ClkState> Drop for Clk<T> {
         fn drop(&mut self) {
-            if T::DISABLE_ON_DROP {
-                // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-                // [`clk_disable`].
+            if T::ENABLED {
+                // SAFETY: By the type invariants, `self.as_raw()` is a valid
+                // argument for [`clk_disable`].
                 unsafe { bindings::clk_disable(self.as_raw()) };
             }
 
-            if T::UNPREPARE_ON_DROP {
-                // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-                // [`clk_unprepare`].
+            if T::PREPARED {
+                // SAFETY: By the type invariants, `self.as_raw()` is a valid
+                // argument for [`clk_unprepare`].
                 unsafe { bindings::clk_unprepare(self.as_raw()) };
             }
 
-            // SAFETY: By the type invariants, self.as_raw() is a valid argument for
-            // [`clk_put`].
-            unsafe { bindings::clk_put(self.as_raw()) };
+            // The `clk_get()` reference is owned by `RawClk`: it is released
+            // by its drop implementation when the last clone goes out of scope.
+        }
+    }
+
+    impl<T: ClkState> Clone for Clk<T> {
+        #[inline]
+        fn clone(&self) -> Self {
+            if T::PREPARED {
+                // SAFETY: By the type invariants, `self.as_raw()` is a valid
+                // argument for [`clk_prepare`]. `self` already holds a
+                // `clk_prepare()` count, so the underlying clock is already
+                // prepared and this call only increments the prepare count:
+                // it cannot fail.
+                unsafe { bindings::clk_prepare(self.as_raw()) };
+            }
+
+            if T::ENABLED {
+                // SAFETY: By the type invariants, `self.as_raw()` is a valid
+                // argument for [`clk_enable`]. `self` already holds a
+                // `clk_enable()` count, so the underlying clock is already
+                // enabled and this call only increments the enable count: it
+                // cannot fail.
+                unsafe { bindings::clk_enable(self.as_raw()) };
+            }
+
+            // INVARIANT: The new value owns the state counts acquired above
+            // and shares the `clk_get()` reference through the `Arc`.
+            Self {
+                inner: self.inner.clone(),
+                _phantom: PhantomData,
+            }
         }
     }
 }

-- 
2.54.0


