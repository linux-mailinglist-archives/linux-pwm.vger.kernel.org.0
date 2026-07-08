Return-Path: <linux-pwm+bounces-9645-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CkbSEbdnTmpBMAIAu9opvQ
	(envelope-from <linux-pwm+bounces-9645-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 17:07:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3A8727C05
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 17:07:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=GKhYUiCc;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9645-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9645-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D42430C0D18
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 14:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A283B8BA4;
	Wed,  8 Jul 2026 14:49:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFA4D2EF1;
	Wed,  8 Jul 2026 14:49:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522188; cv=pass; b=Z+kLb7yaIWTo4aQPOngdsvASvBWKUjqdlp4gPPLdB2pLbZKKSZRgl7N5Uw6McCPeCgdFd7mLOtj7e6n6XYCklaAdsjHhrQBi5JMjKbZAD6GEyPHFvG9tRbgDseLIY0XxcWILr5NvPo+Lsa+rkui34IB4wwzOv0iRNNwlJsc40NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522188; c=relaxed/simple;
	bh=p9UVZdQviaIM7RRmMiAoAltcfQyAv+LLnchHDDFUqR8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q84ADda2/EJUjF5TLvTCf74DZRGKB25Kq2Vet08GEKDPo34lJ3gYZCNlRfkFOFhqYoqkM+suoZezPTXYAA0zkuQtcPiG53XeJ8FyHaa19gAlJO422nk6ntFnJAgqCoqxgI0X4lN2xZTBGHS8I0rxDUnKNBRHXnpud7ll/0Z67Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GKhYUiCc; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783522141; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hV/rQjFKRB/eifJBDi2O9xtS6/9UmEAvxFqdXof/YfPVrP7+E3EDjZkYUFa3y+GOB7gcqMcA6G52NvKxBvilR9UjnWLwfzOk5JqKUGgIM+9GZY/YLKrWEBhYkmwqrKYColx/Z2rIiR1+3ol1qbYTzt9NNHNez57KXiHkvqLDCuU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783522141; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4szMuqOI9JIjS8/kOAhVMC5VSKoQ9b+UCMsEA4pJKao=; 
	b=ljs9zaXD4/bDEiQd9U+oF3S1vteOIRgQhh8Ngq7zagmd3R0+XLor+4iI/3HMtmkmM4GGzGJDzokMTz8LsM2QBfcDXxAFqcNFfsrQPB9JFzGNGl69iA944IHeAohS7Ey7k/A6qqPT2IX6QVI3n08c9IZE51PgLMNvjYf3Sikin50=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783522140;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=4szMuqOI9JIjS8/kOAhVMC5VSKoQ9b+UCMsEA4pJKao=;
	b=GKhYUiCc2/tIHPPHslkhGCy9+HNmby01z5e1+ojOAYnoReuGlgwKBr2LF3FASY/1
	bFL43YA8IUhnlvVxOYQjoF/fwvc/gyXKg9IqLQimHZVE59t8jcrtKjTHOc4N4T0Mgsp
	CY6sMuNVIIa7XVP1Hxyv+bM4tlX1JMYlucHoUSbA=
Received: by mx.zohomail.com with SMTPS id 1783522139037419.44265589536326;
	Wed, 8 Jul 2026 07:48:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 11/20] rust: io: remove `MmioOwned`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-11-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 11:48:33 -0300
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
Message-Id: <BB56CB09-819F-48D3-8C71-B85C33E03065@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-11-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9645-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,vger.kernel.org:from_smtp,self.io:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD3A8727C05



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> `Io` trait is now very easy to implement. Thus, implement it on `Bar` =
and
> `IoMem` directly and remove the `MmioOwned` struct.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/devres.rs |  12 +++---
> rust/kernel/io.rs     | 103 =
+-------------------------------------------------
> rust/kernel/io/mem.rs |  26 +++++++------
> rust/kernel/pci/io.rs |  16 ++++----
> 4 files changed, 32 insertions(+), 125 deletions(-)
>=20
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index aed0c994fd30..3545ffc5345d 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -68,8 +68,9 @@ struct Inner<T> {
> ///     devres::Devres,
> ///     io::{
> ///         Io,
> -///         MmioOwned,
> +///         Mmio,
> ///         MmioRaw,
> +///         MmioBackend,
> ///         PhysAddr,
> ///         Region, //
> ///     },
> @@ -104,12 +105,13 @@ struct Inner<T> {
> ///     }
> /// }
> ///
> -/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target =3D MmioOwned<SIZE>;
> +/// impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<SIZE> {
> +///    type Backend =3D MmioBackend;
> +///    type Target =3D Region<SIZE>;
> ///
> -///    fn deref(&self) -> &Self::Target {
> +///    fn as_view(self) -> Mmio<'a, Region<SIZE>> {
> ///         // SAFETY: The memory range stored in `self` has been =
properly mapped in `Self::new`.
> -///         unsafe { MmioOwned::from_raw(&self.0) }
> +///         unsafe { Mmio::from_raw(self.0) }
> ///    }
> /// }
> /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 89039b3defd5..c7533d605678 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -98,8 +98,8 @@ fn size(p: *const Self) -> usize {
> /// the represented MMIO region does exist or is properly mapped.
> ///
> /// Instead, the bus specific MMIO implementation must convert this =
raw representation into an
> -/// `MmioOwned` instance providing the actual memory accessors. Only =
by the conversion into an
> -/// `MmioOwned` structure any guarantees are given.
> +/// `Mmio` instance providing the actual memory accessors. Only by =
the conversion into an `Mmio`
> +/// structure any guarantees are given.
> pub struct MmioRaw<T: ?Sized> {
>     /// Pointer is in I/O address space.
>     ///
> @@ -156,80 +156,6 @@ pub fn size(&self) -> usize {
>     }
> }
>=20
> -/// IO-mapped memory region.
> -///
> -/// The creator (usually a subsystem / bus such as PCI) is =
responsible for creating the
> -/// mapping, performing an additional region request etc.
> -///
> -/// # Invariant
> -///
> -/// `addr` is the start and `maxsize` the length of valid I/O mapped =
memory region of size
> -/// `maxsize`.
> -///
> -/// # Examples
> -///
> -/// ```no_run
> -/// use kernel::{
> -///     bindings,
> -///     ffi::c_void,
> -///     io::{
> -///         Io,
> -///         MmioOwned,
> -///         MmioRaw,
> -///         PhysAddr,
> -///         Region,
> -///     },
> -/// };
> -/// use core::ops::Deref;
> -///
> -/// // See also `pci::Bar` for a real example.
> -/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
> -///
> -/// impl<const SIZE: usize> IoMem<SIZE> {
> -///     /// # Safety
> -///     ///
> -///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region =
that is mappable into the CPUs
> -///     /// virtual address space.
> -///     unsafe fn new(paddr: usize) -> Result<Self>{
> -///         // SAFETY: By the safety requirements of this function =
[`paddr`, `paddr` + `SIZE`) is
> -///         // valid for `ioremap`.
> -///         let addr =3D unsafe { bindings::ioremap(paddr as =
PhysAddr, SIZE) };
> -///         if addr.is_null() {
> -///             return Err(ENOMEM);
> -///         }
> -///
> -///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
> -///     }
> -/// }
> -///
> -/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> -///     fn drop(&mut self) {
> -///         // SAFETY: `self.0.addr()` is guaranteed to be properly =
mapped by `Self::new`.
> -///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); =
};
> -///     }
> -/// }
> -///
> -/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target =3D MmioOwned<SIZE>;
> -///
> -///    fn deref(&self) -> &Self::Target {
> -///         // SAFETY: The memory range stored in `self` has been =
properly mapped in `Self::new`.
> -///         unsafe { MmioOwned::from_raw(&self.0) }
> -///    }
> -/// }
> -///
> -///# fn no_run() -> Result<(), Error> {
> -/// // SAFETY: Invalid usage for example purposes.
> -/// let iomem =3D unsafe { IoMem::<{ core::mem::size_of::<u32>() =
}>::new(0xBAAAAAAD)? };
> -/// iomem.write32(0x42, 0x0);
> -/// assert!(iomem.try_write32(0x42, 0x0).is_ok());
> -/// assert!(iomem.try_write32(0x42, 0x4).is_err());
> -/// # Ok(())
> -/// # }
> -/// ```
> -#[repr(transparent)]
> -pub struct MmioOwned<const SIZE: usize =3D 0>(MmioRaw<Region<SIZE>>);
> -
> /// Checks whether an access of type `U` at the given `base` and the =
given `offset`
> /// is valid within this region.
> ///
> @@ -957,31 +883,6 @@ fn io_write(view: <$backend as =
IoBackend>::View<'_, $ty>, value: $ty) {
> #[cfg(CONFIG_64BIT)]
> impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
>=20
> -impl<'a, const SIZE: usize> Io<'a> for &'a MmioOwned<SIZE> {
> -    type Backend =3D MmioBackend;
> -    type Target =3D Region<SIZE>;
> -
> -    #[inline]
> -    fn as_view(self) -> Mmio<'a, Self::Target> {
> -        // SAFETY: `Mmio` has same invariant as `MmioOwned`
> -        unsafe { Mmio::from_raw(self.0) }
> -    }
> -}
> -
> -impl<const SIZE: usize> MmioOwned<SIZE> {
> -    /// Converts an `MmioRaw` into an `MmioOwned` instance, providing =
the accessors to the MMIO
> -    /// mapping.
> -    ///
> -    /// # Safety
> -    ///
> -    /// Callers must ensure that `addr` is the start of a valid I/O =
mapped memory region of size
> -    /// `maxsize`.
> -    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
> -        // SAFETY: `MmioOwned` is a transparent wrapper around =
`MmioRaw`.
> -        unsafe { &*core::ptr::from_ref(raw).cast() }
> -    }
> -}
> -
> /// [`Mmio`] but using relaxed accessors.
> ///
> /// This type provides an implementation of [`Io`] that uses relaxed =
I/O MMIO operands instead of
> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index 8f6c257c5b8e..d9b3189d09b4 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
> @@ -2,8 +2,6 @@
>=20
> //! Generic memory-mapped IO.
>=20
> -use core::ops::Deref;
> -
> use crate::{
>     device::{
>         Bound,
> @@ -16,7 +14,9 @@
>             Region,
>             Resource, //
>         },
> -        MmioOwned,
> +        Io,
> +        Mmio,
> +        MmioBackend,
>         MmioRaw, //
>     },
>     prelude::*,
> @@ -210,11 +210,13 @@ pub fn into_devres(self) -> =
Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
>     }
> }
>=20
> -impl<const SIZE: usize> Deref for ExclusiveIoMem<'_, SIZE> {
> -    type Target =3D MmioOwned<SIZE>;
> +impl<'a, const SIZE: usize> Io<'a> for &'a ExclusiveIoMem<'_, SIZE> {
> +    type Backend =3D MmioBackend;
> +    type Target =3D super::Region<SIZE>;
>=20
> -    fn deref(&self) -> &Self::Target {
> -        &self.iomem
> +    #[inline]
> +    fn as_view(self) -> Mmio<'a, Self::Target> {
> +        self.iomem.as_view()
>     }
> }
>=20
> @@ -290,11 +292,13 @@ fn drop(&mut self) {
>     }
> }
>=20
> -impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
> -    type Target =3D MmioOwned<SIZE>;
> +impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
> +    type Backend =3D MmioBackend;
> +    type Target =3D super::Region<SIZE>;
>=20
> -    fn deref(&self) -> &Self::Target {
> +    #[inline]
> +    fn as_view(self) -> Mmio<'a, Self::Target> {
>         // SAFETY: Safe as by the invariant of `IoMem`.
> -        unsafe { MmioOwned::from_raw(&self.io) }
> +        unsafe { Mmio::from_raw(self.io) }
>     }
> }
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index e67c1e3694fb..4be33ecb4192 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -11,16 +11,14 @@
>         Io,
>         IoBackend,
>         IoCapable,
> -        MmioOwned,
> +        Mmio,
> +        MmioBackend,
>         MmioRaw,
>         Region, //
>     },
>     prelude::*,
>     ptr::KnownSize, //
> };
> -use core::{
> -    ops::Deref, //
> -};
>=20
> /// Represents the size of a PCI configuration space.
> ///
> @@ -269,12 +267,14 @@ fn drop(&mut self) {
>     }
> }
>=20
> -impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
> -    type Target =3D MmioOwned<SIZE>;
> +impl<'a, const SIZE: usize> Io<'a> for &'a Bar<'_, SIZE> {
> +    type Backend =3D MmioBackend;
> +    type Target =3D crate::io::Region<SIZE>;
>=20
> -    fn deref(&self) -> &Self::Target {
> +    #[inline]
> +    fn as_view(self) -> Mmio<'a, Self::Target> {
>         // SAFETY: By the type invariant of `Self`, the MMIO range in =
`self.io` is properly mapped.
> -        unsafe { MmioOwned::from_raw(&self.io) }
> +        unsafe { Mmio::from_raw(self.io) }
>     }
> }
>=20
>=20
> --=20
> 2.54.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

