Return-Path: <linux-pwm+bounces-9392-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DBpKNWBrPmojFwkAu9opvQ
	(envelope-from <linux-pwm+bounces-9392-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:06:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490B96CCCDB
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:06:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G68sawEu;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9392-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9392-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AAC63053D06
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 11:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7C3E023A;
	Fri, 26 Jun 2026 11:55:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB33F4107;
	Fri, 26 Jun 2026 11:55:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474914; cv=none; b=rUqyiLRdpArCUhsk0wck2rkAeW6v/SzRF+ypOIlRd4X303LqnSJ4UYNqh0ErS8ohWBvBYB6JJeX2xVZFZbByY7krbyVilZ7IAWde7nGBsnLmcUFvLHKGODu/y+XMsS+SUguG8lIQ3eIBHJGsRjOfvmH4y8JG0AZpgzXjZesSKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474914; c=relaxed/simple;
	bh=TzIAIwSsIR9R0rqS8Uk6Of8uwDIlBqJKvjolimTvkP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nRyp5l2TfSQK2JJmnNv/6uSPypEBvt+pyRH+E5gvmprSJknZGknwYRhMDBTcrardLepA6DCQmsUx7qplsAu+GKX+H2m+71KKl8LGSq/QhRZfz0OQyZEXRt2LQO6u+AhbSQ88biVCZBN/84MZRzqHBq8opZddqZ7FpfSgXyGBFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G68sawEu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82911F00A3A;
	Fri, 26 Jun 2026 11:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782474907;
	bh=nW0Gvd41fIKfum8lv47xbr88JVN0R0Y3bAVxdgTJ0C0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G68sawEuw+gEvqSfSgurM7H8cAkWAHHc6igip6wdMvPx6CefxPsB/T2xUn2kCSied
	 ZmSRemfer+uGIJh/z4JgqMrkcwvu0XpteGfHapJw0qfiRwoWvby8q03TQliyFOjjm0
	 ZHancFmG7ACiJdcmiBLfge7bmJnJwUmMQO4yjgS1hea4gA/9HrrCOVeqWhKltu0Gm1
	 TI7xYOuH1sMW55p8gfHH8LO4FKT5m3FO0z9jASrwCtYWJ6nbg6DgnKXRBQHbLhHZIq
	 PLiJSME3FXBcswt7d7RGbWQ331j6AukmnKqhpTLmgq6UY9QpT3kMqTrMRtv3lWM8AD
	 ptkP5B81t14XA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 26 Jun 2026 13:53:59 +0200
Subject: [PATCH v19 2/8] rust: types: Add Ownable/Owned types
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-unique-ref-v19-2-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>, Boqun Feng <boqun@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10621;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=GO++Qeu4a7kF68yEw+Vn2C+P9gU67mXjb8+4Ea2xpsk=;
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPmh1e991thBmNS1larSf58N6lP82euFt+uGl4
 /Nen0uyLP2JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaj5odQAKCRD6UCkIqsW9
 0LtiEACjpG+/YAYTyEyB97MqMW3AK9a/VdW3xvgboml23uZ0sLTW7YL0ZrVRGBTcyEpowCalfk5
 VPA10IRd0mO1LTk7pH7nmC08j8BpjFJAUd+YP0V4G5m4+DIpk2tM8uCGMckFA6zd3EdTL5KG2N1
 VnB++2B7UAYyvoh3d9/7rTsdxgdue/c6KrVy5UmYZQ712dYCnMi101z1Bg5g48EKVDkS9Z3fcQb
 z9+oLWFrFbtfrgNDoACvW+2EbDDdic3ZFC7hfe3F0nbVskO89kqoNP1AE2cnCvF/T0Lx/K4FM9Y
 I/buCan9NnPiN9XpDp2hGfRxcmwkwSxCKh3pKqMd86ijJe+E9RZBvIoiCVasLNAZcOD96+fjv4D
 1+oGBLvncLjDS9u7OcqDmVV+F+Fz6qqiY2ipMFVXtkAz4k1GlqEMxpj1WMZOiWH5xMuzhn22dWd
 bU4zHkW5N2ILFifY6Sxip97LBzXIiTJ9aMtm6pcFlXW9UhjPUIaDPlOpfKaG7s2F921bcuVXXT3
 K0V+F5CDojDbbMAu+f/L9T0Cq+M68EcV/OowMGgQgrdgs9HBKTnPJi6eakLH2TcKtcQSBQQVWQk
 HQHFxG/S+rjupRoK27Li0WMX1JULcawxDUNY5t62O3Z3Vd7EeoD8ZNccEyMV+OQc4sXCn1CW1OA
 YYLmizDpaAmO/SQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.84 / 15.00];
	URIBL_BLACK(7.50)[types.rs:url];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	TAGGED_FROM(0.00)[bounces-9392-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com];
	GREYLIST(0.00)[pass,body];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:liam@infradead.org,m:urezki@gmail.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rafael@kernel.org,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:paul@paul-moore.com,m:sergeh@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:m.wilczynski@samsung.com,m:a.hindborg@kernel.org,m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@k
 vack.org,m:driver-core@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:lina+kernel@asahilina.net,m:oliver.mangold@pm.me,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-pwm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 490B96CCCDB

From: Asahi Lina <lina+kernel@asahilina.net>

By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
(typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
`AlwaysRefCounted`, this mechanism expects the reference to be unique
within Rust, and does not allow cloning.

Conceptually, this is similar to a `KBox<T>`, except that it delegates
resource management to the `T` instead of using a generic allocator.

[ om:
  - Split code into separate file and `pub use` it from types.rs.
  - Make from_raw() and into_raw() public.
  - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
  - Usage example/doctest for Ownable/Owned.
  - Fixes to documentation and commit message.
]

Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
[ Andreas: Updated documentation, examples, and formatting. Change safety
  requirements, safety comments. ]
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/owned.rs     | 188 +++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/aref.rs |   5 ++
 rust/kernel/types.rs     |   5 ++
 4 files changed, 199 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df2..eb5256204a174 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -101,6 +101,7 @@
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
+pub mod owned;
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
new file mode 100644
index 0000000000000..7fe9ec3e55126
--- /dev/null
+++ b/rust/kernel/owned.rs
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Unique owned pointer types for objects with custom drop logic.
+//!
+//! These pointer types are useful for C-allocated objects which by API-contract
+//! are owned by Rust, but need to be freed through the C API.
+
+use core::{
+    mem::ManuallyDrop,
+    ops::{
+        Deref,
+        DerefMut, //
+    },
+    pin::Pin,
+    ptr::NonNull, //
+};
+
+/// Types that specify their own way of performing allocation and destruction. Typically, this trait
+/// is implemented on types from the C side.
+///
+/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type. This
+/// is useful when it is desirable to tie the lifetime of the reference to an owned object, rather
+/// than pass around a bare reference. [`Ownable`] types can define custom drop logic that is
+/// executed when the owned reference [`Owned<Self>`] pointing to the object is dropped.
+///
+/// Note: The underlying object is not required to provide internal reference counting, because it
+/// represents a unique, owned reference. If reference counting (on the Rust side) is required,
+/// [`AlwaysRefCounted`](crate::sync::aref::AlwaysRefCounted) should be implemented.
+///
+/// # Examples
+///
+/// A minimal example implementation of [`Ownable`] and its usage with [`Owned`] looks like
+/// this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// # use core::cell::Cell;
+/// # use core::ptr::NonNull;
+/// # use kernel::sync::global_lock;
+/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// # use kernel::types::{Owned, Ownable};
+///
+/// // Let's count the allocations to see if freeing works.
+/// kernel::sync::global_lock! {
+///     // SAFETY: we call `init()` right below, before doing anything else.
+///     unsafe(uninit) static FOO_ALLOC_COUNT: Mutex<usize> = 0;
+/// }
+/// // SAFETY: We call `init()` only once, here.
+/// unsafe { FOO_ALLOC_COUNT.init() };
+///
+/// struct Foo;
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>> {
+///         // We are just using a `KBox` here to handle the actual allocation, as our `Foo` is
+///         // not actually a C-allocated object.
+///         let result = KBox::new(
+///             Foo {},
+///             flags::GFP_KERNEL,
+///         )?;
+///         let result = KBox::into_non_null(result);
+///         // Count new allocation
+///         *FOO_ALLOC_COUNT.lock() += 1;
+///         // SAFETY:
+///         //  - We just allocated the `Self`, thus it is valid and we own it.
+///         //  - We can transfer this ownership to the `from_raw` method.
+///         Ok(unsafe { Owned::from_raw(result) })
+///     }
+/// }
+///
+/// impl Ownable for Foo {
+///     unsafe fn release(this: NonNull<Self>) {
+///         // SAFETY: The [`KBox<Self>`] is still alive. We can pass ownership to the [`KBox`], as
+///         // by requirement on calling this function.
+///         drop(unsafe { KBox::from_raw(this.as_ptr()) });
+///         // Count released allocation
+///         *FOO_ALLOC_COUNT.lock() -= 1;
+///     }
+/// }
+///
+/// {
+///    let foo = Foo::new()?;
+///    assert!(*FOO_ALLOC_COUNT.lock() == 1);
+/// }
+/// // `foo` is out of scope now, so we expect no live allocations.
+/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
+/// # Ok::<(), Error>(())
+/// ```
+pub trait Ownable {
+    /// Tear down this `Ownable`.
+    ///
+    /// Implementers of `Ownable` can use this function to clean up the use of `Self`. This can
+    /// include freeing the underlying object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that they have exclusive ownership of the `Self` pointed to by `this`,
+    /// and that this ownership is transferred to the `release` method. `this` must not be used
+    /// after calling this method, as the underlying object may have been freed.
+    unsafe fn release(this: NonNull<Self>);
+}
+
+/// A mutable reference to an owned `T`.
+///
+/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
+/// dropped.
+///
+/// # Invariants
+///
+/// - Until `T::release` is called, this `Owned<T>` exclusively owns the underlying `T`.
+/// - The `T` value is pinned.
+pub struct Owned<T: Ownable> {
+    ptr: NonNull<T>,
+}
+
+impl<T: Ownable> Owned<T> {
+    /// Creates a new instance of [`Owned`].
+    ///
+    /// This function takes over ownership of the underlying object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    /// - `ptr` points to a valid instance of `T`.
+    /// - Until `T::release` is called, the returned `Owned<T>` exclusively owns the underlying `T`.
+    #[inline]
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        // INVARIANT: By function safety requirement we satisfy the first invariant of `Self`.
+        // We treat `T` as pinned from now on.
+        Self { ptr }
+    }
+
+    /// Consumes the [`Owned`], returning a raw pointer.
+    ///
+    /// This function does not drop the underlying `T`. When this function returns, ownership of the
+    /// underlying `T` is with the caller.
+    #[inline]
+    pub fn into_raw(me: Self) -> NonNull<T> {
+        ManuallyDrop::new(me).ptr
+    }
+
+    /// Get a pinned mutable reference to the data owned by this `Owned<T>`.
+    #[inline]
+    pub fn as_pin_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
+        // return a mutable reference to it.
+        let unpinned = unsafe { self.ptr.as_mut() };
+
+        // SAFETY: By type invariant `T` is pinned.
+        unsafe { Pin::new_unchecked(unpinned) }
+    }
+}
+
+// SAFETY: It is safe to send an [`Owned<T>`] to another thread when the underlying `T` is [`Send`],
+// because of the ownership invariant. Sending an [`Owned<T>`] is equivalent to sending the `T`.
+unsafe impl<T: Ownable + Send> Send for Owned<T> {}
+
+// SAFETY: It is safe to send [`&Owned<T>`] to another thread when the underlying `T` is [`Sync`],
+// because of the ownership invariant. Sending an [`&Owned<T>`] is equivalent to sending the `&T`.
+unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
+
+impl<T: Ownable> Deref for Owned<T> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: Ownable + Unpin> DerefMut for Owned<T> {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
+        // return a mutable reference to it.
+        unsafe { self.ptr.as_mut() }
+    }
+}
+
+impl<T: Ownable> Drop for Owned<T> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: By existence of `&mut self` we exclusively own `self` and the underlying `T`. As
+        // we are dropping `self`, we can transfer ownership of the `T` to the `release` method.
+        unsafe { T::release(self.ptr) };
+    }
+}
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index b721b2e00b986..3bd5eb8a1a526 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -34,6 +34,11 @@
 /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
 /// instances of a type.
 ///
+/// Note: Implementing this trait allows types to be wrapped in an [`ARef<Self>`]. It requires an
+/// internal reference count and provides only shared references. If unique references are required
+/// [`Ownable`](crate::types::Ownable) should be implemented which allows types to be wrapped in an
+/// [`Owned<Self>`](crate::types::Owned).
+///
 /// # Safety
 ///
 /// Implementers must ensure that increments to the reference count keep the object alive in memory
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index ac316fd7b538f..c41eab0ec983c 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -15,6 +15,11 @@
 pub mod for_lt;
 pub use for_lt::ForLt;
 
+pub use crate::owned::{
+    Ownable,
+    Owned, //
+};
+
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///
 /// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and

-- 
2.51.2



