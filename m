Return-Path: <linux-pwm+bounces-9692-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HaEtM+SkUWo0HAMAu9opvQ
	(envelope-from <linux-pwm+bounces-9692-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 04:05:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8173FFB2
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 04:05:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b="Hhf/cKNh";
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9692-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9692-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 315C9301CC73
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 02:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B831A8F84;
	Sat, 11 Jul 2026 02:05:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAABD286A7;
	Sat, 11 Jul 2026 02:05:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783735522; cv=pass; b=o91l2s15eC6nADwS0AraapA55sTm+QO8nK5slcxWVb3HGJP3LH90NzOjYDY+JuwNskRz2fHU2y4xSaImYMibQi5LVZWUUGa1jDiOCbaidYqUSYGKYVydCBl630PE/TaZjCJdLveUz+AeDprRSxfT4kJcU9SL2BgeImyLughW15s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783735522; c=relaxed/simple;
	bh=in/+ZBP/VNtN9DiFiv6zUBxrlTruZ58XjuqQXGDk4xw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BfdpUMCB7QUimsBaMng7JNqKSkfdgDVvoNcn1tXdgdO4Q/w3hQrknsb2QKH7qhlehecamFCP31BzVwWkpcjInq0EayFMpF52XxgIj9u5zj+WC05xe8HsQ9DFRDFZBEJ2UKEeR6bDWc5hYW8y4PoE+mOs+LMeZPKE+ArpwuqO/gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Hhf/cKNh; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783735493; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DFt5XI/uVIlPrhi6BtcY2PK8BsEqMJOrtwekYuk6TL6sy07VTBlZx1Tr+hAOkCbOyMI4B/bvU56tDDdNUDfqgZuD2hItRKzjFLrUtDzzWR3JGrBhCDNNffIwmL/0Y9uBdpWrB+S4xNfMiKrTxXNWKoeVKWIoFrlLo/3RR+mK4no=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783735493; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GheCYDBFLZZB5JG+aBFxTpvjzySJCMbAaM1ydg78v1c=; 
	b=H2N5ciVYyEmPE9quuYsVvUMqGWK3erEmjVvVcyKnBhxeYkaaAFhoLqeGF5/ECWW9kEZgQN2Vx36hOoYv0Wd3YUHKXcSIFNxhfSZ/bDvXkzhJXDdKEmTbmcF1TtWI4t5Y8PMsgud2jcUSdvoRWbuuBnc+lAcxWRzibKedAqLzKGI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783735493;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=GheCYDBFLZZB5JG+aBFxTpvjzySJCMbAaM1ydg78v1c=;
	b=Hhf/cKNhwLOFWPO5pkhC2vRYS4duMk+TKKkU5qgJwH+JNY802v8BRlYuQpY88TLb
	/Uc1sEkVnwvk2P4c8um7DvuDUYPD0ukW85yRP+uCfqWxmlqq4zGXRjllXYO2jBWg6XC
	yPixNXDbcxX2j6q8iHLqMoJpjrBtmCRJwOo0wfFk=
Received: by mx.zohomail.com with SMTPS id 1783735492286730.8704422431059;
	Fri, 10 Jul 2026 19:04:52 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 18/20] rust: dma: drop `dma_read!` and `dma_write!` API
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-18-72cd5d055d54@garyguo.net>
Date: Fri, 10 Jul 2026 23:04:32 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4990B3CF-C19E-4282-B749-D02ABECD59DC@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-18-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9692-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	APPLE_MAILER_COMMON(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FF8173FFB2



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> The primitive read/write use case is covered by the `io_read!` and
> `io_write!` macro. The non-primitive use case was finicky; they should
> either be achieved using `CoherentBox` or `as_ref()/as_mut()` to =
assert the
> lack of concurrent access, or should be using memcpy-like APIs to =
express
> the non-atomic and tearable nature.
>=20
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/dma.rs       | 128 =
-----------------------------------------------
> samples/rust/rust_dma.rs |  11 ++--
> 2 files changed, 8 insertions(+), 131 deletions(-)
>=20
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 1535bc6eec64..6e7ea3b72f2f 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -661,52 +661,6 @@ pub unsafe fn as_mut(&self) -> &mut T {
>         // SAFETY: per safety requirement.
>         unsafe { &mut *self.as_mut_ptr() }
>     }
> -
> -    /// Reads the value of `field` and ensures that its type is =
[`FromBytes`].
> -    ///
> -    /// # Safety
> -    ///
> -    /// This must be called from the [`dma_read`] macro which ensures =
that the `field` pointer is
> -    /// validated beforehand.
> -    ///
> -    /// Public but hidden since it should only be used from =
[`dma_read`] macro.
> -    #[doc(hidden)]
> -    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> =
F {
> -        // SAFETY:
> -        // - By the safety requirements field is valid.
> -        // - Using read_volatile() here is not sound as per the usual =
rules, the usage here is
> -        // a special exception with the following notes in place. =
When dealing with a potential
> -        // race from a hardware or code outside kernel (e.g. =
user-space program), we need that
> -        // read on a valid memory is not UB. Currently =
read_volatile() is used for this, and the
> -        // rationale behind is that it should generate the same code =
as READ_ONCE() which the
> -        // kernel already relies on to avoid UB on data races. Note =
that the usage of
> -        // read_volatile() is limited to this particular case, it =
cannot be used to prevent
> -        // the UB caused by racing between two kernel functions nor =
do they provide atomicity.
> -        unsafe { field.read_volatile() }
> -    }
> -
> -    /// Writes a value to `field` and ensures that its type is =
[`AsBytes`].
> -    ///
> -    /// # Safety
> -    ///
> -    /// This must be called from the [`dma_write`] macro which =
ensures that the `field` pointer is
> -    /// validated beforehand.
> -    ///
> -    /// Public but hidden since it should only be used from =
[`dma_write`] macro.
> -    #[doc(hidden)]
> -    pub unsafe fn field_write<F: AsBytes>(&self, field: *mut F, val: =
F) {
> -        // SAFETY:
> -        // - By the safety requirements field is valid.
> -        // - Using write_volatile() here is not sound as per the =
usual rules, the usage here is
> -        // a special exception with the following notes in place. =
When dealing with a potential
> -        // race from a hardware or code outside kernel (e.g. =
user-space program), we need that
> -        // write on a valid memory is not UB. Currently =
write_volatile() is used for this, and the
> -        // rationale behind is that it should generate the same code =
as WRITE_ONCE() which the
> -        // kernel already relies on to avoid UB on data races. Note =
that the usage of
> -        // write_volatile() is limited to this particular case, it =
cannot be used to prevent
> -        // the UB caused by racing between two kernel functions nor =
do they provide atomicity.
> -        unsafe { field.write_volatile(val) }
> -    }
> }
>=20
> impl<T: AsBytes + FromBytes> Coherent<T> {
> @@ -1266,85 +1220,3 @@ fn as_view(self) -> CoherentView<'a, =
Self::Target> {
>         }
>     }
> }
> -
> -/// Reads a field of an item from an allocated region of structs.
> -///
> -/// The syntax is of the form `kernel::dma_read!(dma, proj)` where =
`dma` is an expression evaluating
> -/// to a [`Coherent`] and `proj` is a [projection =
specification](kernel::ptr::project!).
> -///
> -/// # Examples
> -///
> -/// ```
> -/// use kernel::device::Device;
> -/// use kernel::dma::{attrs::*, Coherent};
> -///
> -/// struct MyStruct { field: u32, }
> -///
> -/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
> -/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
> -/// // SAFETY: Instances of `MyStruct` have no uninitialized =
portions.
> -/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
> -///
> -/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
> -/// let whole =3D kernel::dma_read!(alloc, [try: 2]);
> -/// let field =3D kernel::dma_read!(alloc, [panic: 1].field);
> -/// # Ok::<(), Error>(()) }
> -/// ```
> -#[macro_export]
> -macro_rules! dma_read {
> -    ($dma:expr, $($proj:tt)*) =3D> {{
> -        let dma =3D &$dma;
> -        let ptr =3D $crate::ptr::project!(
> -            $crate::dma::Coherent::as_ptr(dma), $($proj)*
> -        );
> -        // SAFETY: The pointer created by the projection is within =
the DMA region.
> -        unsafe { $crate::dma::Coherent::field_read(dma, ptr) }
> -    }};
> -}
> -
> -/// Writes to a field of an item from an allocated region of structs.
> -///
> -/// The syntax is of the form `kernel::dma_write!(dma, proj, val)` =
where `dma` is an expression
> -/// evaluating to a [`Coherent`], `proj` is a
> -/// [projection specification](kernel::ptr::project!), and `val` is =
the value to be written to the
> -/// projected location.
> -///
> -/// # Examples
> -///
> -/// ```
> -/// use kernel::device::Device;
> -/// use kernel::dma::{attrs::*, Coherent};
> -///
> -/// struct MyStruct { member: u32, }
> -///
> -/// // SAFETY: All bit patterns are acceptable values for `MyStruct`.
> -/// unsafe impl kernel::transmute::FromBytes for MyStruct{};
> -/// // SAFETY: Instances of `MyStruct` have no uninitialized =
portions.
> -/// unsafe impl kernel::transmute::AsBytes for MyStruct{};
> -///
> -/// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
> -/// kernel::dma_write!(alloc, [try: 2].member, 0xf);
> -/// kernel::dma_write!(alloc, [panic: 1], MyStruct { member: 0xf });
> -/// # Ok::<(), Error>(()) }
> -/// ```
> -#[macro_export]
> -macro_rules! dma_write {
> -    (@parse [$dma:expr] [$($proj:tt)*] [, $val:expr]) =3D> {{
> -        let dma =3D &$dma;
> -        let ptr =3D $crate::ptr::project!(
> -            mut $crate::dma::Coherent::as_mut_ptr(dma), $($proj)*
> -        );
> -        let val =3D $val;
> -        // SAFETY: The pointer created by the projection is within =
the DMA region.
> -        unsafe { $crate::dma::Coherent::field_write(dma, ptr, val) }
> -    }};
> -    (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) =3D> =
{
> -        $crate::dma_write!(@parse [$dma] [$($proj)* .$field] =
[$($rest)*])
> -    };
> -    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] =
$($rest:tt)*]) =3D> {
> -        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: =
$index]] [$($rest)*])
> -    };
> -    ($dma:expr, $($rest:tt)*) =3D> {
> -        $crate::dma_write!(@parse [$dma] [] [$($rest)*])
> -    };
> -}
> diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
> index 5046b4628d0e..4af46e99d2dd 100644
> --- a/samples/rust/rust_dma.rs
> +++ b/samples/rust/rust_dma.rs
> @@ -12,6 +12,10 @@
>         Device,
>         DmaMask, //
>     },
> +    io::{
> +        io_project,
> +        io_read, //
> +    },
>     page, pci,
>     prelude::*,
>     scatterlist::{Owned, SGTable},
> @@ -77,7 +81,8 @@ fn probe<'bound>(
>                 Coherent::zeroed_slice(pdev.as_ref(), =
TEST_VALUES.len(), GFP_KERNEL)?;
>=20
>             for (i, value) in TEST_VALUES.into_iter().enumerate() {
> -                kernel::dma_write!(ca, [try: i], =
MyStruct::new(value.0, value.1));
> +                // SAFETY: `ca` is not yet shared with device or =
other threads.
> +                unsafe { *io_project!(ca, [panic: i]).as_mut() =3D =
MyStruct::new(value.0, value.1) };
>             }
>=20
>             let size =3D 4 * page::PAGE_SIZE;
> @@ -97,8 +102,8 @@ fn probe<'bound>(
> impl DmaSampleDriver {
>     fn check_dma(&self) {
>         for (i, value) in TEST_VALUES.into_iter().enumerate() {
> -            let val0 =3D kernel::dma_read!(self.ca, [panic: i].h);
> -            let val1 =3D kernel::dma_read!(self.ca, [panic: i].b);
> +            let val0 =3D io_read!(self.ca, [panic: i].h);
> +            let val1 =3D io_read!(self.ca, [panic: i].b);
>=20
>             assert_eq!(val0, value.0);
>             assert_eq!(val1, value.1);
>=20
> --=20
> 2.54.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


