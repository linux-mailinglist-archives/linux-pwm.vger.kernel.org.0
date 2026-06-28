Return-Path: <linux-pwm+bounces-9445-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KMZBMEKwQWpQtgkAu9opvQ
	(envelope-from <linux-pwm+bounces-9445-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 01:37:38 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 155216D547A
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 01:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oO3ino49;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9445-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9445-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9620D300A116
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jun 2026 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39676372B4B;
	Sun, 28 Jun 2026 23:37:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12DA3451B3;
	Sun, 28 Jun 2026 23:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782689856; cv=none; b=DJA1YjlIYDEq9ptu+Go8dF4FG1JrrT1j75rGEr8sSR/bMq5fx9FCRwX4MUNP+PJfV+hYOMUZhX6SV4Pez9SJyo9qwevqA3GmXhAZ2IO6aWEGJkkwuKMp4tbA+uzh38V56Q5OW0pELY+/phTO9hHUVd0gfvJ2AF9etwUMTgTKojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782689856; c=relaxed/simple;
	bh=oFEFVBD5fcKXppEp1kF7LsfMNyXXyuvUCfJ3219R1aw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BYF5rxwVmogJDStG2SbI4Mwutt2NkI8L4gjV00kVmED+rECOZcJ/CvEq4vrGD9tDrpLMtR2YN7Ji88N3lpZmHCW57VMlJMDjlX+Um7ILmn2Z2I5CWM11Cev1B3l9lAy/dylsNPWH9MGGTXCXbyQBEFhcLBC+/BmXF7GWRft1ts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO3ino49; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF541F000E9;
	Sun, 28 Jun 2026 23:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782689854;
	bh=AsaiapX2vikYIk/w5nfyMPF/cTpFXSz56W7bWM4Pb2M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=oO3ino49R89n61CsRkBCR9diZ+DKsLiRHMwwMxaYp9HQ173yN75E/utZi7wXI1Zcf
	 Q6bczIwGlyrmxzGJocFWVRoqN7oB17NuaydphaHrEIz+kQ7h97Ju7w3e7jpckDEfhg
	 ktpRG4kICCVC3V0sbHoXH++Dsog9uBdzBqkuzrpAn4Kw913UmAZWd1hwwv83tc0kkz
	 MMTDHUh2jCW9uHlzUzyksf2bAuvZzWfSMSRf58AaaRzD2dtc+qVIPxhR7qgq01N7rJ
	 k96hLOo3hvvJ7p9+lkeC5/B1aO/8vwUEvJRI3Km6w9HQuDe4J8rk5+GF0h6OtoJNEE
	 s5fOAwSZbkgOw==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 01:37:27 +0200
Message-Id: <DJL2T5XDC53F.3C2QC5L1V2H6@kernel.org>
Subject: Re: [PATCH v5 00/20] rust: I/O type generalization and projection
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Michal Wilczynski" <m.wilczynski@samsung.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, "Laura Nao" <laura.nao@collabora.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9445-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 155216D547A

On Fri Jun 26, 2026 at 4:45 PM CEST, Gary Guo wrote:
> This series presents a major rework of I/O types, as a summary:

There are two minor rustdoc warnings:

	warning: unresolved link to `include/linux/iosys-map.h`
	    --> rust/kernel/io.rs:1456:7
	     |
	1456 | /// [`include/linux/iosys-map.h`] in C.
	     |       ^^^^^^^^^^^^^^^^^^^^^^^^^ no item named `include/linux/iosys-=
map.h` in scope
	     |
	     =3D help: to escape `[` and `]` characters, add '\' before them like =
`\[` or `\]`
	     =3D note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default
=09
	warning: unresolved link to `View`
	    --> rust/kernel/io.rs:1620:74
	     |
	1620 | /// In addition to projecting from [`Io`], you may also project fro=
m a [`View`] of an [`Io`].
	     |                                                                    =
      ^^^^ no item named `View` in scope
	     |
	     =3D help: to escape `[` and `]` characters, add '\' before them like =
`\[` or `\]`
=09
	warning: 2 warnings emitted

> Gary Guo (19):
>       rust: io: add dynamically-sized `Region` type
>       rust: io: add missing safety requirement in `IoCapable` methods
>       rust: io: restrict untyped IO access and `register!` to `Region`
>       rust: io: implement `Io` on reference types instead
>       rust: io: generalize `MmioRaw` to pointer to arbitrary type
>       rust: io: rename `Mmio` to `MmioOwned`
>       rust: io: implement `Mmio` as view type
>       rust: pci: io: make `ConfigSpace` a view
>       rust: io: use view types instead of addresses for `Io`
>       pwm: th1520: remove unnecessary `deref`
>       rust: io: remove `MmioOwned`
>       rust: io: move `Io` methods to extension trait
>       rust: io: add projection macro and methods
>       rust: io: implement a view type for `Coherent`
>       rust: io: add `read_val` and `write_val` functions on `Io`
>       gpu: nova-core: use I/O projection for cleaner encapsulation
>       rust: dma: drop `dma_read!` and `dma_write!` API
>       rust: io: add copying methods
>       rust: io: implement `IoSysMap`
>
> Laura Nao (1):
>       rust: io: add I/O backend for system memory with volatile access

For sharing with the drm-rust tree:

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 3ee19ef6264e..6868b5d80ab7 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -29,9 +29,10 @@
         to_result, //
     },
     io::{
-        Io,
-        IoCapable,
-        IoKnownSize, //
+        IoBase,
+        Region,
+        SysMem,
+        SysMemBackend, //
     },
     prelude::*,
     scatterlist,
@@ -467,6 +468,28 @@ pub fn owner(&self) -> &Object<D, C> {
     }
 }

+impl<'a, D, R, C, const SIZE: usize> IoBase<'a> for &'a VMap<D, R, C, SIZE=
>
+where
+    D: DriverObject,
+    C: DeviceContext,
+    R: Deref<Target =3D Object<D, C>>,
+{
+    type Backend =3D SysMemBackend;
+    type Target =3D Region<SIZE>;
+
+    #[inline]
+    fn as_view(self) -> SysMem<'a, Region<SIZE>> {
+        let ptr =3D Region::ptr_from_raw_parts_mut(self.addr.cast(), self.=
owner.size());
+
+        // SAFETY: Per type invariants of `VMap`:
+        // - `addr .. addr + owner.size()` is a valid kernel accessible me=
mory region.
+        // - `addr` is page-aligned, which satisfies `Region`'s 4-byte ali=
gnment requirement.
+        // - The memory remains valid until this `VMap` is dropped; since =
`self` is `&'a VMap`,
+        //   the borrow prevents the `VMap` from being dropped for the lif=
etime `'a`.
+        unsafe { SysMem::new(ptr) }
+    }
+}
+
 impl<D, R, C, const SIZE: usize> Drop for VMap<D, R, C, SIZE>
 where
     D: DriverObject,
@@ -508,69 +531,6 @@ unsafe impl<D, R, C, const SIZE: usize> Sync for VMap<=
D, R, C, SIZE>
 {
 }

-impl<D, R, C, const SIZE: usize> Io for VMap<D, R, C, SIZE>
-where
-    D: DriverObject,
-    C: DeviceContext,
-    R: Deref<Target =3D Object<D, C>>,
-{
-    #[inline]
-    fn addr(&self) -> usize {
-        self.addr as usize
-    }
-
-    #[inline]
-    fn maxsize(&self) -> usize {
-        self.owner.size()
-    }
-}
-
-impl<D, R, C, const SIZE: usize> IoKnownSize for VMap<D, R, C, SIZE>
-where
-    D: DriverObject,
-    C: DeviceContext,
-    R: Deref<Target =3D Object<D, C>>,
-{
-    const MIN_SIZE: usize =3D SIZE;
-}
-
-macro_rules! impl_vmap_io_capable {
-    ($ty:ty) =3D> {
-        impl<D, R, C, const SIZE: usize> IoCapable<$ty> for VMap<D, R, C, =
SIZE>
-        where
-            D: DriverObject,
-            C: DeviceContext,
-            R: Deref<Target =3D Object<D, C>>,
-        {
-            #[inline]
-            unsafe fn io_read(&self, address: usize) -> $ty {
-                let ptr =3D address as *mut $ty;
-
-                // SAFETY: The safety contract of `io_read` guarantees tha=
t address is a valid
-                // address within the bounds of `Self` of at least the siz=
e of $ty, and is properly
-                // aligned.
-                unsafe { ptr::read_volatile(ptr) }
-            }
-
-            #[inline]
-            unsafe fn io_write(&self, value: $ty, address: usize) {
-                let ptr =3D address as *mut $ty;
-
-                // SAFETY: The safety contract of `io_write` guarantees th=
at address is a valid
-                // address within the bounds of `Self` of at least the siz=
e of $ty, and is properly
-                // aligned.
-                unsafe { ptr::write_volatile(ptr, value) }
-            }
-        }
-    };
-}
-
-impl_vmap_io_capable!(u8);
-impl_vmap_io_capable!(u16);
-impl_vmap_io_capable!(u32);
-#[cfg(CONFIG_64BIT)]
-impl_vmap_io_capable!(u64);
-
 /// A reference to a GEM object that is known to have a mapped [`SGTable`]=
.
 ///
 /// This is used by the Rust bindings with [`Devres`] in order to ensure t=
hat mappings for SGTables
@@ -638,6 +598,7 @@ mod tests {
             UnregisteredDevice, //
         },
         faux,
+        io::Io,
         page::PAGE_SIZE, //
     };

@@ -714,7 +675,7 @@ fn compile_time_vmap_sizes() -> Result {
         assert!(ptr::eq(vmap.owner(), obj.deref()));

         // Verify the max size matches the actual object size
-        assert_eq!(vmap.maxsize(), PAGE_SIZE);
+        assert_eq!(vmap.size(), PAGE_SIZE);

         // Make sure creating a vmap that's too large fails
         assert!(obj.vmap::<{ PAGE_SIZE + 200 }>().is_err());

