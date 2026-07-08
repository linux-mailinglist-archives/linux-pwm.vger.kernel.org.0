Return-Path: <linux-pwm+bounces-9646-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n1/MGHhwTmoQMwIAu9opvQ
	(envelope-from <linux-pwm+bounces-9646-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 17:44:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C732772834C
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 17:44:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=kEQVPxM2;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9646-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9646-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2541325A031
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30B3F12CF;
	Wed,  8 Jul 2026 15:16:18 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719E83F12C0;
	Wed,  8 Jul 2026 15:16:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523777; cv=pass; b=MjXVhSAqkxAR1KuEefAgrJp5hTZSAD67AXOs37Xnd66zx3CJct9pW7m2o8BakL1ThAAF5PB8iMXLmfAm/PmOo30kaOLNo/JTK9szQzCsJrYuK4KwS8w9fAIRpeVVIWE1eWqlYKo7xU/5oDe0ESN/fcQLu0Q8LdJPTCoh6ypj7Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523777; c=relaxed/simple;
	bh=Iqkz9HZz7KsJqF6xvtRqT8xxwG+y4KVbP4uJohB9BWs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QatHFlcHTBOo7htkq15b5L5WJ+neDFPSUK6GCRE7kMmcwxUiq8JM5VWAmOxdK7IQ0twYa8r26cOu96Qm3aWjK2MmoOxB8dTUOATVZSVsBdRlBDRP9E9FICVusyi0j9qr4RpRsMkQ6255q/Lu7VOFRLgqqOUS5HWL+WWjoq6gO2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=kEQVPxM2; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783523745; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Igr8wTpfjpo1ZHqfHQn/lVnKM79U43R4E1eSVy71wQBDvHXW+bF2eW4ui7Wlm05zH+F72ZB1/Z8/x/j2BjCf6ilcdsUjooa7PMNX2Itz8G6jjHMaqhORMJ57RCIwSpetHbyI/YisCdVWgJJ+Jkg9KMKGe9UypP5HMpFPa+hUgoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783523745; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X1plbi+Oxfx02jtUPa4CfsK/IllRKlSLbG1pvpCqSpQ=; 
	b=ktkjpgWkVW6XS4KQ16E5h2wy3zjPg33F3Disl5c7Xbo6Ak/eJHWeP+MTTNCv/kUnYxsakGAJc4kX9AIFBxOw9FF7H72JZo1sGw/y8N5mUnV7WnyroupyOdtSyfuOrKdMIplwZp2uY3xAbF+J1yhiZ/KCEPV37ZCNJg+jiZbtOe4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783523745;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=X1plbi+Oxfx02jtUPa4CfsK/IllRKlSLbG1pvpCqSpQ=;
	b=kEQVPxM223LBIzrF2IQm1wNUlGBrh7MiW/mQZVoJUUrpCmGJaJANC3xJZOK2YDrv
	xnEBPy87uWH2C/WN4gbtJqhZyHIrU5COGHHkBOurTwH2t2OlYhQJka3vJWns6loEqZg
	9HOXk3Qw8egDZvS6KrbvTfVp3KU8Ghu9DBnuGY74=
Received: by mx.zohomail.com with SMTPS id 1783523742904701.646089296638;
	Wed, 8 Jul 2026 08:15:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 12/20] rust: io: move `Io` methods to extension trait
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-12-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 12:15:23 -0300
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
Message-Id: <CDAB04DF-F46F-4E78-A981-E6B171FAE606@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-12-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9646-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	APPLE_MAILER_COMMON(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C732772834C



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> `Io` trait now has a single required method with many more provided
> methods. Provided methods may want to rely on their implementations to =
not
> be arbitrarily overridden by implementers for correctness or =
soundness.
> A good example is the `size` method, it may be relied by unsafe code =
and
> thus must be consistent with the metadata obtained from `as_ptr`.
>=20
> Thus, create a new trait to host `size` method, extract existing =
provided
> methods to the new trait, and provide a blanket implementation. This
> pattern is used extensively in userspace Rust libraries e.g. `tokio` =
where
> `AsyncRead` has minimum methods and `AsyncReadExt` is what users =
mostly
> interact with.
>=20
> To avoid changing all user imports, the base trait is renamed to =
`IoBase`
> and the newly added trait takes the existing `Io` name.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/devres.rs |  3 ++-
> rust/kernel/io.rs     | 34 ++++++++++++++++++++++++----------
> rust/kernel/io/mem.rs |  6 +++---
> rust/kernel/pci/io.rs |  6 +++---
> 4 files changed, 32 insertions(+), 17 deletions(-)
>=20
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 3545ffc5345d..6e0b845b229b 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -68,6 +68,7 @@ struct Inner<T> {
> ///     devres::Devres,
> ///     io::{
> ///         Io,
> +///         IoBase,
> ///         Mmio,
> ///         MmioRaw,
> ///         MmioBackend,
> @@ -105,7 +106,7 @@ struct Inner<T> {
> ///     }
> /// }
> ///
> -/// impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<SIZE> {
> +/// impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<SIZE> {
> ///    type Backend =3D MmioBackend;
> ///    type Target =3D Region<SIZE>;
> ///
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index c7533d605678..ab970e8b2e78 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -223,7 +223,7 @@ fn io_view<'a, IO: Io<'a>, U>(
> /// operation.
> pub trait IoBackend {
>     /// View type for this I/O backend.
> -    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend =3D Self, =
Target =3D T>;
> +    type View<'a, T: ?Sized + KnownSize>: IoBase<'a, Backend =3D =
Self, Target =3D T>;
>=20
>     /// Convert a `view` to a raw pointer for projection.
>     ///
> @@ -309,15 +309,12 @@ fn offset(self) -> usize {
> /// Types implementing this trait (e.g. MMIO BARs or PCI config =
regions)
> /// can perform I/O operations on regions of memory.
> ///
> -/// The [`Io`] trait provides:
> -/// - Method to convert into [`IoBackend::View`].
> -/// - Helper methods for offset validation and address calculation
> -/// - Fallible (runtime checked) accessors for different data widths
> -///
> -/// Which I/O methods are available depends on the associated =
[`IoBackend`] implementation.
> +/// This trait defines which backend shall be used for I/O operations =
and provides a method to
> +/// convert into [`IoBackend::View`]. Users should use the [`Io`] =
trait which provides the actual
> +/// methods to perform I/O operations.
> ///
> /// This should be implemented on cheaply copyable handles, such as =
references or view types.
> -pub trait Io<'a>: Copy {
> +pub trait IoBase<'a>: Copy {
>     /// Type that defines all I/O operations.
>     type Backend: IoBackend;
>=20
> @@ -326,6 +323,21 @@ pub trait Io<'a>: Copy {
>=20
>     /// Return a view that covers the full region.
>     fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, =
Self::Target>;
> +}
> +
> +/// Extension trait to provide I/O operation methods to types that =
implement [`IoBase`].
> +///
> +/// This trait provides:
> +/// - Helper methods for offset validation and address calculation
> +/// - Fallible (runtime checked) accessors for different data widths
> +///
> +/// Which I/O methods are available depends on the associated =
[`IoBackend`] implementation.
> +pub trait Io<'a>: IoBase<'a> {
> +    /// Returns the size of this I/O region.
> +    #[inline]
> +    fn size(self) -> usize {
> +        KnownSize::size(Self::Backend::as_ptr(self.as_view()))
> +    }
>=20
>     /// Fallible 8-bit read with runtime bounds check.
>     #[inline(always)]
> @@ -779,6 +791,8 @@ fn update<T, L, F>(self, location: L, f: F)
>     }
> }
>=20

IIUC this is what makes the methods non-overridable?

If so, consider leaving a comment? i.e.:

// Provided methods may want to rely on their implementations to not be
// arbitrarily overridden by implementers for correctness or soundness, =
thus,
// enforce it through this blanket implementation

Makes it easier to maintain later IMHO.

> +impl<'a, T: IoBase<'a>> Io<'a> for T {}
> +
> /// A view of memory-mapped I/O region.
> ///
> /// # Invariant
> @@ -819,7 +833,7 @@ unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> =
{}
> // SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
> unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
>=20
> -impl<'a, T: ?Sized + KnownSize> Io<'a> for Mmio<'a, T> {
> +impl<'a, T: ?Sized + KnownSize> IoBase<'a> for Mmio<'a, T> {
>     type Backend =3D MmioBackend;
>     type Target =3D T;
>=20
> @@ -920,7 +934,7 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, =
U: ?Sized + KnownSize>(
>     }
> }
>=20
> -impl<'a, T: ?Sized + KnownSize> Io<'a> for RelaxedMmio<'a, T> {
> +impl<'a, T: ?Sized + KnownSize> IoBase<'a> for RelaxedMmio<'a, T> {
>     type Backend =3D RelaxedMmioBackend;
>     type Target =3D T;
>=20
> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index d9b3189d09b4..e95b769ebe47 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
> @@ -14,7 +14,7 @@
>             Region,
>             Resource, //
>         },
> -        Io,
> +        IoBase,
>         Mmio,
>         MmioBackend,
>         MmioRaw, //
> @@ -210,7 +210,7 @@ pub fn into_devres(self) -> =
Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
>     }
> }
>=20
> -impl<'a, const SIZE: usize> Io<'a> for &'a ExclusiveIoMem<'_, SIZE> {
> +impl<'a, const SIZE: usize> IoBase<'a> for &'a ExclusiveIoMem<'_, =
SIZE> {
>     type Backend =3D MmioBackend;
>     type Target =3D super::Region<SIZE>;
>=20
> @@ -292,7 +292,7 @@ fn drop(&mut self) {
>     }
> }
>=20
> -impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
> +impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<'_, SIZE> {
>     type Backend =3D MmioBackend;
>     type Target =3D super::Region<SIZE>;
>=20
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 4be33ecb4192..4d1d0afdc491 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -8,8 +8,8 @@
>     device,
>     devres::Devres,
>     io::{
> -        Io,
>         IoBackend,
> +        IoBase,
>         IoCapable,
>         Mmio,
>         MmioBackend,
> @@ -144,7 +144,7 @@ fn io_write(view: ConfigSpace<'_, $ty>, value: =
$ty) {
> impl_config_space_io_capable!(u16, pci_read_config_word, =
pci_write_config_word);
> impl_config_space_io_capable!(u32, pci_read_config_dword, =
pci_write_config_dword);
>=20
> -impl<'a, T: ?Sized + KnownSize> Io<'a> for ConfigSpace<'a, T> {
> +impl<'a, T: ?Sized + KnownSize> IoBase<'a> for ConfigSpace<'a, T> {
>     type Backend =3D ConfigSpaceBackend;
>     type Target =3D T;
>=20
> @@ -267,7 +267,7 @@ fn drop(&mut self) {
>     }
> }
>=20
> -impl<'a, const SIZE: usize> Io<'a> for &'a Bar<'_, SIZE> {
> +impl<'a, const SIZE: usize> IoBase<'a> for &'a Bar<'_, SIZE> {
>     type Backend =3D MmioBackend;
>     type Target =3D crate::io::Region<SIZE>;
>=20
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


