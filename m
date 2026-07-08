Return-Path: <linux-pwm+bounces-9644-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PgKZHQ1rTmpMMQIAu9opvQ
	(envelope-from <linux-pwm+bounces-9644-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 17:21:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC782727EDB
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 17:21:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=BqgX68aZ;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9644-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9644-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F05F319811B
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629204D8D84;
	Wed,  8 Jul 2026 14:49:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F0380FFB;
	Wed,  8 Jul 2026 14:49:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522180; cv=pass; b=LE3sYy5IP1PgRj2KiSf8//rtXXqovNp9XJ8YIaQV+WGoFHRjJ3YXT9ANIc0BG2rCMfmg3dDnL9ui8SszjpZLLXa6VJtOb9weQ1PZAkIt+vtzjOf5ck7bLwl6sPgeoBDQze0XLXwpp52AJ7WizovnILbYgo1KUoGKIZwajPOFFlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522180; c=relaxed/simple;
	bh=p9UVZdQviaIM7RRmMiAoAltcfQyAv+LLnchHDDFUqR8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nP6ANwFNooje+yHVm1tGc1piaD2eIVMCt2zlQ6Yj0TA6dv9MTY2ToXy/YX4dtlAxKYaoby8LzFscF81LV9xnPpSgzOGCOZKMoEZuL0XYX93n48uHtBmIox9W30ZQDy6p15FHO8EjDU9UrYZmXI5dbH7AW2nPeijpgrmO+2uS/t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=BqgX68aZ; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783522135; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bpdfpAPoLcSj38gcmEk2W/IMuf6DLCeA1M8IV40jkNqT5xVAIxBmWxuxqB7ExufSghrKFbSVfQcs5J27DAy2Ut8z+NZbwCCnr8FUYKxZ9o1xQ2idOIp/hlNVhyywtN6G9wYvS2eVzalpAgO2OV8UYnxgPIqZIidkV+dzJd9igX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783522135; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4szMuqOI9JIjS8/kOAhVMC5VSKoQ9b+UCMsEA4pJKao=; 
	b=Q9Q2usmguFIY0JgQ8ctP2lfmqHIvDkwdj5XxEO0ghHgtG1xSNAeu3lzU70jxmsPU0lL3ept8wRTIbfssk0ZyqguMLJyijIna5ZOYLyzNsEOXMc1olPEt1MfHPNuMebvHmVGrdVBL8YhjBFlrsMdAEDnlKAH7iWIeyMcaonpBc54=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783522135;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=4szMuqOI9JIjS8/kOAhVMC5VSKoQ9b+UCMsEA4pJKao=;
	b=BqgX68aZ2rJ5M0QZeOx8Q+mChiooQJyvC8he/hgev0iHS+XBMjSR779q2FrhT3W7
	l8lWrFxj4G9ICt6BRakEGDBlQBJitE8uoetb4bKLUc7muIoR6m/XnuWdmXU51Zlm4zp
	IbKX1oM2tbfP+poX6TmhAwenoHQCtzdU7wMUZKks=
Received: by mx.zohomail.com with SMTPS id 1783522133821946.0992772309626;
	Wed, 8 Jul 2026 07:48:53 -0700 (PDT)
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9644-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,self.io:url,nvidia.com:email,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC782727EDB



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

