Return-Path: <linux-pwm+bounces-9642-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F4ggEoRiTmrRLgIAu9opvQ
	(envelope-from <linux-pwm+bounces-9642-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 16:45:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9DA72789A
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 16:45:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=doaOutWo;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9642-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9642-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D95143031023
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812BF31326F;
	Wed,  8 Jul 2026 14:37:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F330C285CB4;
	Wed,  8 Jul 2026 14:37:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521435; cv=pass; b=TjDVkptd6wVqOQUdFwOZduPc8gjfUgH9tjbTSpiIsNkfrINNUDSHyOuAb33FUPy9wzx6twQrycqSU4yHk04DC2jnDjBEGtTkXt4wMWA37LAxbKWHKUVAkrn6O77n9tbUk01u2CyfXm7l+tGstoUo7v8h9ybFhmc8crnNxJ08p6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521435; c=relaxed/simple;
	bh=eW/2a8kRRje6g4JnlkzLwoRsxSDg1U7mKgRsIMsKD0Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UyR/dJ+9B2FdeJyngUVE+pQ8upHgJZ9pl5JndKHP5373OzO+mHNMTUgOv2cdehifV9sTtZWLZRCKwgTodNkH4Djda8FR7m4CD/0CAFjPb0+pnX2wM8tDiQw6nDCkx5nXgjDkdmqimAtoOqOTpEGz+rVMWrjchQCVr9bkefcteq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=doaOutWo; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783521396; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kw+dvyVA0iiQAi3zk34UF9k7alqg7UPYlQNHUTnVMZkV1eQf9Qzl+bBxbr+ZTAMxOzbVpZhh8LbEv6mZJ/gM5MlWhil2re9CvMt9QNakzDXaY6r+j+DSBi03rUz8GTPqifwphcjALGE2RLuSZ3JsVQXAd1wDWO1dkmi8UHlfTzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783521396; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WCji8WOCyIh9bOISUIWwUcfPFBdDSMNl8HAD8QCggWs=; 
	b=eIPwHDEzR5I15aFCIOnTrlQs6kT1UOaRbelyLoVKLj5c6ahpYay1BkaofHmdQmJuF1SlqwbgO5eNmwFEysgYEz1Rij2ZhyRyWhpeD2oMJkLDewuzQI+n5wl15Tyz+xsTmWwsOlQ8c5PwSkTD6RV+HtjAIYDRRBvRYXEnepSCxpw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783521395;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=WCji8WOCyIh9bOISUIWwUcfPFBdDSMNl8HAD8QCggWs=;
	b=doaOutWoMEKdWlNED8s1shxTsF/LzNMfyEUy/Rz0sDI21ci8+ooNW2mUATMVB9FR
	VfyZlhOTToelx7TSS1vGTTsxH21gxdL8qb3PQhGBO5imooq41Ao1x0PlOKbW7G9hg68
	ObXmwg0kaqYfDNNs/0f9eLYNSZmo5CHxTsQozn5o=
Received: by mx.zohomail.com with SMTPS id 1783521392580665.2855646143323;
	Wed, 8 Jul 2026 07:36:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 09/20] rust: io: use view types instead of addresses
 for `Io`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-9-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 11:36:12 -0300
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
Message-Id: <280FBE45-5653-499B-9BB0-A2C77030A826@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-9-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9642-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,nvidia.com:email,io.rs:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D9DA72789A



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Currently, `io_read` and `io_write` methods require the exact type of =
`Io`
> plus an address. This means that they need to be monomorphized for =
each
> different `Io` instance. This also means that multiple I/O =
implementors for
> the same I/O kind needs to duplicate implementation (e.g. `Mmio` and
> `MmioOwned`).
>=20
> Create a new `IoBackend` trait and define these operations on it =
instead.
> The operations are just going to receive a view type and operate on =
them.
> This has the additional advantage that the invariants can be moved =
from the
> trait (and guaranteed via `unsafe`) to type invariants on the =
canonical
> view types of the backends, so `io_read` and `io_write` can be safe.
>=20
> Note that view type is needed; addresses are insufficient in this

nit: missing article: =E2=80=9Ca view type is needed=E2=80=9D or =E2=80=9C=
view types are needed=E2=80=9D.

> design, as they do not carry sufficient information. For example,
> `ConfigSpace` needs `&pci::Device` in addition to the address.
>=20
> `io_addr_assert` and `io_addr` are renamed to `io_view*` to reflect
> that they operate on views now, and make them standalone functions so
> they cannot be used by users to cast types outside io.rs.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/io.rs     | 382 =
++++++++++++++++++++++++++------------------------
> rust/kernel/pci/io.rs |  70 +++++----
> 2 files changed, 246 insertions(+), 206 deletions(-)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 8110b49aa430..89039b3defd5 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -243,6 +243,81 @@ const fn offset_valid<U>(base: usize, offset: =
usize, size: usize) -> bool {
>     }
> }
>=20
> +/// Returns a view for a given `offset`, performing compile-time =
bound checks.
> +// Always inline to optimize out error path of `build_assert`.

You mean to avoid that cryptic =E2=80=9Crust_build_error=E2=80=9D when =
the assertion fails?

> +#[inline(always)]
> +fn io_view_assert<'a, IO: Io<'a>, U>(
> +    this: IO,
> +    offset: usize,
> +) -> <IO::Backend as IoBackend>::View<'a, U> {
> +    // We cannot check alignment with `offset_valid` using =
`ptr.addr()`. So set 0 for it and
> +    // ensure alignment by checking that the alignment of `U` is =
smaller or equal to the
> +    // alignment of `IO::Target`.
> +    const_assert!(Alignment::of::<U>().as_usize() <=3D =
IO::Target::MIN_ALIGN.as_usize());
> +    build_assert!(offset_valid::<U>(0, offset, =
IO::Target::MIN_SIZE));
> +
> +    let view =3D this.as_view();
> +    let ptr =3D IO::Backend::as_ptr(view);
> +    let projected_ptr =3D ptr.cast::<U>().wrapping_byte_add(offset);
> +    // SAFETY: `offset_valid` checks for size and alignment and =
therefore `projected_ptr` is a
> +    // valid projection.
> +    unsafe { IO::Backend::project_view(view, projected_ptr) }
> +}
> +
> +/// Returns a view for a given `offset`, performing runtime bound =
checks.
> +#[inline]
> +fn io_view<'a, IO: Io<'a>, U>(
> +    this: IO,
> +    offset: usize,
> +) -> Result<<IO::Backend as IoBackend>::View<'a, U>> {
> +    let view =3D this.as_view();
> +    let ptr =3D IO::Backend::as_ptr(view);
> +
> +    if !offset_valid::<U>(ptr.addr(), offset, KnownSize::size(ptr)) {
> +        return Err(EINVAL);
> +    }
> +
> +    let projected_ptr =3D ptr.cast::<U>().wrapping_byte_add(offset);
> +    // SAFETY: `offset_valid` checks for size and alignment and =
therefore `projected_ptr` is a
> +    // valid projection.
> +    Ok(unsafe { IO::Backend::project_view(view, projected_ptr) })
> +}
> +
> +/// I/O backends.
> +///
> +/// This is an abstract representation to be implemented by arbitrary =
I/O
> +/// backends (e.g. MMIO, PCI config space, etc.).
> +///
> +/// The base trait only defines the projection operations; which I/O =
methods are available depends
> +/// on which [`IoCapable<T>`] traits are implemented for the type. =
For example, for MMIO regions,
> +/// all widths (u8, u16, u32, and u64 on 64-bit systems) are =
typically supported. For PCI
> +/// configuration space, u8, u16, and u32 are supported but u64 is =
not.
> +///
> +/// This trait is separate from the `Io` trait as multiple different =
I/O types may share the same
> +/// operation.
> +pub trait IoBackend {
> +    /// View type for this I/O backend.
> +    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend =3D Self, =
Target =3D T>;
> +
> +    /// Convert a `view` to a raw pointer for projection.
> +    ///
> +    /// The returned pointer is private implementation detail of the =
backend; it is likely not
> +    /// valid. It should not be dereferenced.
> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> =
*mut T;
> +
> +    /// Project `view` to its subregion indicated by `ptr`.
> +    ///
> +    /// If input `view` is valid, returned view must also be valid.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be a projection of `Self::as_ptr(view)`.
> +    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + =
KnownSize>(
> +        view: Self::View<'a, T>,
> +        ptr: *mut U,
> +    ) -> Self::View<'a, U>;
> +}
> +
> /// Trait indicating that an I/O backend supports operations of a =
certain type and providing an
> /// implementation for these operations.
> ///
> @@ -251,22 +326,12 @@ const fn offset_valid<U>(base: usize, offset: =
usize, size: usize) -> bool {
> /// For example, a PCI configuration space may implement =
`IoCapable<u8>`, `IoCapable<u16>`,
> /// and `IoCapable<u32>`, but not `IoCapable<u64>`, while an MMIO =
region on a 64-bit
> /// system might implement all four.
> -pub trait IoCapable<T> {
> -    /// Performs an I/O read of type `T` at `address` and returns the =
result.
> -    ///
> -    /// # Safety
> -    ///
> -    /// - The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> -    /// - `address` must be aligned.
> -    unsafe fn io_read(self, address: usize) -> T;
> +pub trait IoCapable<T>: IoBackend {
> +    /// Performs an I/O read of type `T` at `view` and returns the =
result.
> +    fn io_read<'a>(view: Self::View<'a, T>) -> T;
>=20
> -    /// Performs an I/O write of `value` at `address`.
> -    ///
> -    /// # Safety
> -    ///
> -    /// - The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> -    /// - `address` must be aligned.
> -    unsafe fn io_write(self, value: T, address: usize);
> +    /// Performs an I/O write of `value` at `view`.
> +    fn io_write<'a>(view: Self::View<'a, T>, value: T);
> }
>=20
> /// Describes a given I/O location: its offset, width, and type to =
convert the raw value from and
> @@ -318,66 +383,30 @@ fn offset(self) -> usize {
> /// Types implementing this trait (e.g. MMIO BARs or PCI config =
regions)
> /// can perform I/O operations on regions of memory.
> ///
> -/// This is an abstract representation to be implemented by arbitrary =
I/O
> -/// backends (e.g. MMIO, PCI config space, etc.).
> -///
> /// The [`Io`] trait provides:
> -/// - Base address and size information
> +/// - Method to convert into [`IoBackend::View`].
> /// - Helper methods for offset validation and address calculation
> /// - Fallible (runtime checked) accessors for different data widths
> ///
> -/// Which I/O methods are available depends on which [`IoCapable<T>`] =
traits
> -/// are implemented for the type.
> +/// Which I/O methods are available depends on the associated =
[`IoBackend`] implementation.
> ///
> /// This should be implemented on cheaply copyable handles, such as =
references or view types.
> -///
> -/// # Examples
> -///
> -/// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit =
systems) are typically
> -/// supported. For PCI configuration space, u8, u16, and u32 are =
supported but u64 is not.
> -pub trait Io: Copy {
> +pub trait Io<'a>: Copy {
> +    /// Type that defines all I/O operations.
> +    type Backend: IoBackend;
> +
>     /// Type of this I/O region. For untyped regions, [`Region`] can =
be used.
>     type Target: ?Sized + KnownSize;
>=20
> -    /// Returns the base address of this mapping.
> -    fn addr(self) -> usize;
> -
> -    /// Returns the maximum size of this mapping.
> -    fn maxsize(self) -> usize;
> -
> -    /// Returns the absolute I/O address for a given `offset`,
> -    /// performing compile-time bound checks.
> -    // Always inline to optimize out error path of `build_assert`.
> -    #[inline(always)]
> -    fn io_addr_assert<U>(self, offset: usize) -> usize {
> -        // We cannot check alignment with `offset_valid` using =
`self.addr()`. So set 0 for it and
> -        // ensure alignment by checking that the alignment of `U` is =
smaller or equal to the
> -        // alignment of `Self::Target`.
> -        const_assert!(Alignment::of::<U>().as_usize() <=3D =
Self::Target::MIN_ALIGN.as_usize());
> -        build_assert!(offset_valid::<U>(0, offset, =
Self::Target::MIN_SIZE));
> -
> -        self.addr() + offset
> -    }
> -
> -    /// Returns the absolute I/O address for a given `offset`,
> -    /// performing runtime bound checks.
> -    #[inline]
> -    fn io_addr<U>(self, offset: usize) -> Result<usize> {
> -        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
> -            return Err(EINVAL);
> -        }
> -
> -        // Probably no need to check, since the safety requirements =
of `Self::new` guarantee that
> -        // this can't overflow.
> -        self.addr().checked_add(offset).ok_or(EINVAL)
> -    }
> +    /// Return a view that covers the full region.
> +    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, =
Self::Target>;
>=20
>     /// Fallible 8-bit read with runtime bounds check.
>     #[inline(always)]
>     fn try_read8(self, offset: usize) -> Result<u8>
>     where
>         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
> -        Self: IoCapable<u8>,
> +        Self::Backend: IoCapable<u8>,
>     {
>         self.try_read(offset)
>     }
> @@ -387,7 +416,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
>     fn try_read16(self, offset: usize) -> Result<u16>
>     where
>         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
> -        Self: IoCapable<u16>,
> +        Self::Backend: IoCapable<u16>,
>     {
>         self.try_read(offset)
>     }
> @@ -397,7 +426,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
>     fn try_read32(self, offset: usize) -> Result<u32>
>     where
>         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
> -        Self: IoCapable<u32>,
> +        Self::Backend: IoCapable<u32>,
>     {
>         self.try_read(offset)
>     }
> @@ -407,7 +436,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
>     fn try_read64(self, offset: usize) -> Result<u64>
>     where
>         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
> -        Self: IoCapable<u64>,
> +        Self::Backend: IoCapable<u64>,
>     {
>         self.try_read(offset)
>     }
> @@ -417,7 +446,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
>     fn try_write8(self, value: u8, offset: usize) -> Result
>     where
>         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
> -        Self: IoCapable<u8>,
> +        Self::Backend: IoCapable<u8>,
>     {
>         self.try_write(offset, value)
>     }
> @@ -427,7 +456,7 @@ fn try_write8(self, value: u8, offset: usize) -> =
Result
>     fn try_write16(self, value: u16, offset: usize) -> Result
>     where
>         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
> -        Self: IoCapable<u16>,
> +        Self::Backend: IoCapable<u16>,
>     {
>         self.try_write(offset, value)
>     }
> @@ -437,7 +466,7 @@ fn try_write16(self, value: u16, offset: usize) -> =
Result
>     fn try_write32(self, value: u32, offset: usize) -> Result
>     where
>         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
> -        Self: IoCapable<u32>,
> +        Self::Backend: IoCapable<u32>,
>     {
>         self.try_write(offset, value)
>     }
> @@ -447,7 +476,7 @@ fn try_write32(self, value: u32, offset: usize) -> =
Result
>     fn try_write64(self, value: u64, offset: usize) -> Result
>     where
>         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
> -        Self: IoCapable<u64>,
> +        Self::Backend: IoCapable<u64>,
>     {
>         self.try_write(offset, value)
>     }
> @@ -457,7 +486,7 @@ fn try_write64(self, value: u64, offset: usize) -> =
Result
>     fn read8(self, offset: usize) -> u8
>     where
>         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
> -        Self: IoCapable<u8>,
> +        Self::Backend: IoCapable<u8>,
>     {
>         self.read(offset)
>     }
> @@ -467,7 +496,7 @@ fn read8(self, offset: usize) -> u8
>     fn read16(self, offset: usize) -> u16
>     where
>         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
> -        Self: IoCapable<u16>,
> +        Self::Backend: IoCapable<u16>,
>     {
>         self.read(offset)
>     }
> @@ -477,7 +506,7 @@ fn read16(self, offset: usize) -> u16
>     fn read32(self, offset: usize) -> u32
>     where
>         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
> -        Self: IoCapable<u32>,
> +        Self::Backend: IoCapable<u32>,
>     {
>         self.read(offset)
>     }
> @@ -487,7 +516,7 @@ fn read32(self, offset: usize) -> u32
>     fn read64(self, offset: usize) -> u64
>     where
>         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
> -        Self: IoCapable<u64>,
> +        Self::Backend: IoCapable<u64>,
>     {
>         self.read(offset)
>     }
> @@ -497,7 +526,7 @@ fn read64(self, offset: usize) -> u64
>     fn write8(self, value: u8, offset: usize)
>     where
>         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
> -        Self: IoCapable<u8>,
> +        Self::Backend: IoCapable<u8>,
>     {
>         self.write(offset, value)
>     }
> @@ -507,7 +536,7 @@ fn write8(self, value: u8, offset: usize)
>     fn write16(self, value: u16, offset: usize)
>     where
>         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
> -        Self: IoCapable<u16>,
> +        Self::Backend: IoCapable<u16>,
>     {
>         self.write(offset, value)
>     }
> @@ -517,7 +546,7 @@ fn write16(self, value: u16, offset: usize)
>     fn write32(self, value: u32, offset: usize)
>     where
>         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
> -        Self: IoCapable<u32>,
> +        Self::Backend: IoCapable<u32>,
>     {
>         self.write(offset, value)
>     }
> @@ -527,7 +556,7 @@ fn write32(self, value: u32, offset: usize)
>     fn write64(self, value: u64, offset: usize)
>     where
>         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
> -        Self: IoCapable<u64>,
> +        Self::Backend: IoCapable<u64>,
>     {
>         self.write(offset, value)
>     }
> @@ -559,12 +588,10 @@ fn write64(self, value: u64, offset: usize)
>     fn try_read<T, L>(self, location: L) -> Result<T>
>     where
>         L: IoLoc<Self::Target, T>,
> -        Self: IoCapable<L::IoType>,
> +        Self::Backend: IoCapable<L::IoType>,
>     {
> -        let address =3D =
self.io_addr::<L::IoType>(location.offset())?;
> -
> -        // SAFETY: `address` has been validated by `io_addr`.
> -        Ok(unsafe { self.io_read(address) }.into())
> +        let view =3D io_view::<Self, L::IoType>(self, =
location.offset())?;
> +        Ok(Self::Backend::io_read(view).into())
>     }
>=20
>     /// Generic fallible write with runtime bounds check.
> @@ -594,14 +621,11 @@ fn try_read<T, L>(self, location: L) -> =
Result<T>
>     fn try_write<T, L>(self, location: L, value: T) -> Result
>     where
>         L: IoLoc<Self::Target, T>,
> -        Self: IoCapable<L::IoType>,
> +        Self::Backend: IoCapable<L::IoType>,
>     {
> -        let address =3D =
self.io_addr::<L::IoType>(location.offset())?;
> +        let view =3D io_view::<Self, L::IoType>(self, =
location.offset())?;
>         let io_value =3D value.into();
> -
> -        // SAFETY: `address` has been validated by `io_addr`.
> -        unsafe { self.io_write(io_value, address) }
> -
> +        Self::Backend::io_write(view, io_value);
>         Ok(())
>     }
>=20
> @@ -642,7 +666,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> =
Result
>     where
>         L: IoLoc<Self::Target, T>,
>         V: LocatedRegister<Self::Target, Location =3D L, Value =3D T>,
> -        Self: IoCapable<L::IoType>,
> +        Self::Backend: IoCapable<L::IoType>,
>     {
>         let (location, value) =3D value.into_io_op();
>=20
> @@ -675,17 +699,14 @@ fn try_write_reg<T, L, V>(self, value: V) -> =
Result
>     fn try_update<T, L, F>(self, location: L, f: F) -> Result
>     where
>         L: IoLoc<Self::Target, T>,
> -        Self: IoCapable<L::IoType>,
> +        Self::Backend: IoCapable<L::IoType>,
>         F: FnOnce(T) -> T,
>     {
> -        let address =3D =
self.io_addr::<L::IoType>(location.offset())?;
> +        let view =3D io_view::<Self, L::IoType>(self, =
location.offset())?;
>=20
> -        // SAFETY: `address` has been validated by `io_addr`.
> -        let value: T =3D unsafe { self.io_read(address) }.into();
> +        let value: T =3D Self::Backend::io_read(view).into();
>         let io_value =3D f(value).into();
> -
> -        // SAFETY: `address` has been validated by `io_addr`.
> -        unsafe { self.io_write(io_value, address) }
> +        Self::Backend::io_write(view, io_value);
>=20
>         Ok(())
>     }
> @@ -715,12 +736,10 @@ fn try_update<T, L, F>(self, location: L, f: F) =
-> Result
>     fn read<T, L>(self, location: L) -> T
>     where
>         L: IoLoc<Self::Target, T>,
> -        Self: IoCapable<L::IoType>,
> +        Self::Backend: IoCapable<L::IoType>,
>     {
> -        let address =3D =
self.io_addr_assert::<L::IoType>(location.offset());
> -
> -        // SAFETY: `address` has been validated by `io_addr_assert`.
> -        unsafe { self.io_read(address) }.into()
> +        let view =3D io_view_assert::<Self, L::IoType>(self, =
location.offset());
> +        Self::Backend::io_read(view).into()
>     }
>=20
>     /// Generic infallible write with compile-time bounds check.
> @@ -748,13 +767,11 @@ fn read<T, L>(self, location: L) -> T
>     fn write<T, L>(self, location: L, value: T)
>     where
>         L: IoLoc<Self::Target, T>,
> -        Self: IoCapable<L::IoType>,
> +        Self::Backend: IoCapable<L::IoType>,
>     {
> -        let address =3D =
self.io_addr_assert::<L::IoType>(location.offset());
> +        let view =3D io_view_assert::<Self, L::IoType>(self, =
location.offset());
>         let io_value =3D value.into();
> -
> -        // SAFETY: `address` has been validated by `io_addr_assert`.
> -        unsafe { self.io_write(io_value, address) }
> +        Self::Backend::io_write(view, io_value);
>     }
>=20
>     /// Generic infallible write of a fully-located register value.
> @@ -793,7 +810,7 @@ fn write_reg<T, L, V>(self, value: V)
>     where
>         L: IoLoc<Self::Target, T>,
>         V: LocatedRegister<Self::Target, Location =3D L, Value =3D T>,
> -        Self: IoCapable<L::IoType>,
> +        Self::Backend: IoCapable<L::IoType>,
>     {
>         let (location, value) =3D value.into_io_op();
>=20
> @@ -826,17 +843,13 @@ fn write_reg<T, L, V>(self, value: V)
>     fn update<T, L, F>(self, location: L, f: F)
>     where
>         L: IoLoc<Self::Target, T>,
> -        Self: IoCapable<L::IoType>,
> +        Self::Backend: IoCapable<L::IoType>,
>         F: FnOnce(T) -> T,
>     {
> -        let address =3D =
self.io_addr_assert::<L::IoType>(location.offset());
> -
> -        // SAFETY: `address` has been validated by `io_addr_assert`.
> -        let value: T =3D unsafe { self.io_read(address) }.into();
> +        let view =3D io_view_assert::<Self, L::IoType>(self, =
location.offset());
> +        let value: T =3D Self::Backend::io_read(view).into();
>         let io_value =3D f(value).into();
> -
> -        // SAFETY: `address` has been validated by `io_addr_assert`.
> -        unsafe { self.io_write(io_value, address) }
> +        Self::Backend::io_write(view, io_value);
>     }
> }
>=20
> @@ -880,78 +893,78 @@ unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, =
T> {}
> // SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
> unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
>=20
> -impl<T: ?Sized + KnownSize> Io for Mmio<'_, T> {
> +impl<'a, T: ?Sized + KnownSize> Io<'a> for Mmio<'a, T> {
> +    type Backend =3D MmioBackend;
>     type Target =3D T;
>=20
>     #[inline]
> -    fn addr(self) -> usize {
> -        self.ptr.addr()
> +    fn as_view(self) -> Mmio<'a, T> {
> +        self
>     }
> +}
> +
> +/// I/O Backend for memory-mapped I/O.
> +pub struct MmioBackend;
> +
> +impl IoBackend for MmioBackend {
> +    type View<'a, T: ?Sized + KnownSize> =3D Mmio<'a, T>;
>=20
>     #[inline]
> -    fn maxsize(self) -> usize {
> -        KnownSize::size(self.ptr)
> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> =
*mut T {
> +        view.ptr
> +    }
> +
> +    #[inline]
> +    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + =
KnownSize>(
> +        _view: Self::View<'a, T>,
> +        ptr: *mut U,
> +    ) -> Self::View<'a, U> {
> +        // INVARIANT: Per safety requirement, `ptr` is projection =
from `view`, so it is also a valid
> +        // memory-mapped I/O region.
> +        Mmio {
> +            ptr,
> +            phantom: PhantomData,
> +        }
>     }
> }
>=20
> -/// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` =
and `$write_fn`.
> +/// Implements [`IoCapable`] on `$backend` for `$ty` using `$read_fn` =
and `$write_fn`.
> macro_rules! impl_mmio_io_capable {
> -    ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, =
$write_fn:ident) =3D> {
> -        $(#[$attr])*
> -        impl<T: ?Sized> IoCapable<$ty> for $mmio<'_, T> {
> +    ($backend: ident, $ty:ty, $read_fn:ident, $write_fn:ident) =3D> {
> +        impl IoCapable<$ty> for $backend {
>             #[inline]
> -            unsafe fn io_read(self, address: usize) -> $ty {
> -                // SAFETY: By the trait invariant `address` is a =
valid address for MMIO operations.
> -                unsafe { bindings::$read_fn(address as *const c_void) =
}
> +            fn io_read(view: <$backend as IoBackend>::View<'_, $ty>) =
-> $ty {
> +                // SAFETY: `$backend::as_ptr(view)` is a valid =
pointer for MMIO operations for both
> +                // `MmioBackend` and `RelaxedMmioBackend`.
> +                unsafe { =
bindings::$read_fn($backend::as_ptr(view).cast_const().cast()) }
>             }
>=20
>             #[inline]
> -            unsafe fn io_write(self, value: $ty, address: usize) {
> -                // SAFETY: By the trait invariant `address` is a =
valid address for MMIO operations.
> -                unsafe { bindings::$write_fn(value, address as *mut =
c_void) }
> +            fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, =
value: $ty) {
> +                // SAFETY: `$backend::as_ptr(view)` is a valid =
pointer for MMIO operations for both
> +                // `MmioBackend` and `RelaxedMmioBackend`.
> +                unsafe { bindings::$write_fn(value, =
$backend::as_ptr(view).cast()) }
>             }
>         }
>     };
> }
>=20
> // MMIO regions support 8, 16, and 32-bit accesses.
> -impl_mmio_io_capable!(Mmio, u8, readb, writeb);
> -impl_mmio_io_capable!(Mmio, u16, readw, writew);
> -impl_mmio_io_capable!(Mmio, u32, readl, writel);
> +impl_mmio_io_capable!(MmioBackend, u8, readb, writeb);
> +impl_mmio_io_capable!(MmioBackend, u16, readw, writew);
> +impl_mmio_io_capable!(MmioBackend, u32, readl, writel);
> // MMIO regions on 64-bit systems also support 64-bit accesses.
> #[cfg(CONFIG_64BIT)]
> -impl_mmio_io_capable!(Mmio, u64, readq, writeq);
> +impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
>=20
> -impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
> +impl<'a, const SIZE: usize> Io<'a> for &'a MmioOwned<SIZE> {
> +    type Backend =3D MmioBackend;
>     type Target =3D Region<SIZE>;
>=20
> -    /// Returns the base address of this mapping.
>     #[inline]
> -    fn addr(self) -> usize {
> -        self.0.addr()
> -    }
> -
> -    /// Returns the maximum size of this mapping.
> -    #[inline]
> -    fn maxsize(self) -> usize {
> -        self.0.size()
> -    }
> -}
> -
> -impl<'a, const SIZE: usize, T> IoCapable<T> for &'a MmioOwned<SIZE>
> -where
> -    Mmio<'a, Region<SIZE>>: IoCapable<T>,
> -{
> -    #[inline]
> -    unsafe fn io_read(self, address: usize) -> T {
> -        // SAFETY: Per safety requirement.
> -        unsafe { self.as_view().io_read(address) }
> -    }
> -
> -    #[inline]
> -    unsafe fn io_write(self, value: T, address: usize) {
> -        // SAFETY: Per safety requirement.
> -        unsafe { self.as_view().io_write(value, address) }
> +    fn as_view(self) -> Mmio<'a, Self::Target> {
> +        // SAFETY: `Mmio` has same invariant as `MmioOwned`
> +        unsafe { Mmio::from_raw(self.0) }
>     }
> }
>=20
> @@ -967,13 +980,6 @@ pub unsafe fn from_raw(raw: =
&MmioRaw<Region<SIZE>>) -> &Self {
>         // SAFETY: `MmioOwned` is a transparent wrapper around =
`MmioRaw`.
>         unsafe { &*core::ptr::from_ref(raw).cast() }
>     }
> -
> -    /// Return a view that covers the full region.
> -    #[inline]
> -    pub fn as_view(&self) -> Mmio<'_, Region<SIZE>> {
> -        // SAFETY: `Mmio` has same invariant as `MmioOwned`.
> -        unsafe { Mmio::from_raw(self.0) }
> -    }
> }
>=20
> /// [`Mmio`] but using relaxed accessors.
> @@ -992,17 +998,34 @@ fn clone(&self) -> Self {
>     }
> }
>=20
> -impl<T: ?Sized + KnownSize> Io for RelaxedMmio<'_, T> {
> -    type Target =3D T;
> +/// I/O Backend for memory-mapped I/O, with relaxed access semantics.
> +pub struct RelaxedMmioBackend;
> +
> +impl IoBackend for RelaxedMmioBackend {
> +    type View<'a, T: ?Sized + KnownSize> =3D RelaxedMmio<'a, T>;
>=20
>     #[inline]
> -    fn addr(self) -> usize {
> -        self.0.addr()
> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> =
*mut T {
> +        MmioBackend::as_ptr(view.0)
>     }
>=20
>     #[inline]
> -    fn maxsize(self) -> usize {
> -        self.0.maxsize()
> +    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + =
KnownSize>(
> +        view: Self::View<'a, T>,
> +        ptr: *mut U,
> +    ) -> Self::View<'a, U> {
> +        // SAFETY: Per safety requirement.
> +        RelaxedMmio(unsafe { MmioBackend::project_view(view.0, ptr) =
})
> +    }
> +}
> +
> +impl<'a, T: ?Sized + KnownSize> Io<'a> for RelaxedMmio<'a, T> {
> +    type Backend =3D RelaxedMmioBackend;
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn as_view(self) -> RelaxedMmio<'a, T> {
> +        self
>     }
> }
>=20
> @@ -1035,14 +1058,9 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
> }
>=20
> // MMIO regions support 8, 16, and 32-bit accesses.
> -impl_mmio_io_capable!(RelaxedMmio, u8, readb_relaxed, =
writeb_relaxed);
> -impl_mmio_io_capable!(RelaxedMmio, u16, readw_relaxed, =
writew_relaxed);
> -impl_mmio_io_capable!(RelaxedMmio, u32, readl_relaxed, =
writel_relaxed);
> +impl_mmio_io_capable!(RelaxedMmioBackend, u8, readb_relaxed, =
writeb_relaxed);
> +impl_mmio_io_capable!(RelaxedMmioBackend, u16, readw_relaxed, =
writew_relaxed);
> +impl_mmio_io_capable!(RelaxedMmioBackend, u32, readl_relaxed, =
writel_relaxed);
> // MMIO regions on 64-bit systems also support 64-bit accesses.
> -impl_mmio_io_capable!(
> -    RelaxedMmio,
> -    #[cfg(CONFIG_64BIT)]
> -    u64,
> -    readq_relaxed,
> -    writeq_relaxed
> -);
> +#[cfg(CONFIG_64BIT)]
> +impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, =
writeq_relaxed);
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 89f4bb483a7f..e67c1e3694fb 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -9,6 +9,7 @@
>     devres::Devres,
>     io::{
>         Io,
> +        IoBackend,
>         IoCapable,
>         MmioOwned,
>         MmioRaw,
> @@ -84,32 +85,57 @@ unsafe impl<T: ?Sized + Sync> Send for =
ConfigSpace<'_, T> {}
> // SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O =
memory.
> unsafe impl<T: ?Sized + Sync> Sync for ConfigSpace<'_, T> {}
>=20
> +/// I/O Backend for PCI configuration space.
> +pub struct ConfigSpaceBackend;
> +
> +impl IoBackend for ConfigSpaceBackend {
> +    type View<'a, T: ?Sized + KnownSize> =3D ConfigSpace<'a, T>;
> +
> +    #[inline]
> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: ConfigSpace<'a, T>) -> =
*mut T {
> +        view.ptr
> +    }
> +
> +    #[inline]
> +    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + =
KnownSize>(
> +        view: Self::View<'a, T>,
> +        ptr: *mut U,
> +    ) -> Self::View<'a, U> {
> +        // INVARIANT: Per safety requirement.
> +        ConfigSpace {
> +            pdev: view.pdev,
> +            ptr,
> +        }
> +    }
> +}
> +
> /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using =
`$read_fn` and `$write_fn`.
> macro_rules! impl_config_space_io_capable {
>     ($ty:ty, $read_fn:ident, $write_fn:ident) =3D> {
> -        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
> -            unsafe fn io_read(self, address: usize) -> $ty {
> +        impl IoCapable<$ty> for ConfigSpaceBackend {
> +            fn io_read(view: ConfigSpace<'_, $ty>) -> $ty {
> +                // CAST: The offset is cast to `i32` because the C =
functions expect a 32-bit
> +                // signed offset parameter. PCI configuration space =
size is at most 4096 bytes,
> +                // so the value always fits within `i32` without =
truncation or sign change.
> +                let addr =3D view.ptr.addr() as i32;
> +
>                 let mut val: $ty =3D 0;
>=20
>                 // Return value from C function is ignored in =
infallible accessors.
> -                let _ret =3D
> -                    // SAFETY: By the type invariant `self.pdev` is a =
valid address.
> -                    // CAST: The offset is cast to `i32` because the =
C functions expect a 32-bit
> -                    // signed offset parameter. PCI configuration =
space size is at most 4096 bytes,
> -                    // so the value always fits within `i32` without =
truncation or sign change.
> -                    unsafe { bindings::$read_fn(self.pdev.as_raw(), =
address as i32, &mut val) };
> -
> +                // SAFETY: By the type invariant `pdev` is a valid =
address.
> +                let _ =3D unsafe { =
bindings::$read_fn(view.pdev.as_raw(), addr, &mut val) };
>                 val
>             }
>=20
> -            unsafe fn io_write(self, value: $ty, address: usize) {
> +            fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {
> +                // CAST: The offset is cast to `i32` because the C =
functions expect a 32-bit
> +                // signed offset parameter. PCI configuration space =
size is at most 4096 bytes,
> +                // so the value always fits within `i32` without =
truncation or sign change.
> +                let addr =3D view.ptr.addr() as i32;
> +
>                 // Return value from C function is ignored in =
infallible accessors.
> -                let _ret =3D
> -                    // SAFETY: By the type invariant `self.pdev` is a =
valid address.
> -                    // CAST: The offset is cast to `i32` because the =
C functions expect a 32-bit
> -                    // signed offset parameter. PCI configuration =
space size is at most 4096 bytes,
> -                    // so the value always fits within `i32` without =
truncation or sign change.
> -                    unsafe { bindings::$write_fn(self.pdev.as_raw(), =
address as i32, value) };
> +                // SAFETY: By the type invariant `pdev` is a valid =
address.
> +                let _ =3D unsafe { =
bindings::$write_fn(view.pdev.as_raw(), addr, value) };
>             }
>         }
>     };
> @@ -120,17 +146,13 @@ unsafe fn io_write(self, value: $ty, address: =
usize) {
> impl_config_space_io_capable!(u16, pci_read_config_word, =
pci_write_config_word);
> impl_config_space_io_capable!(u32, pci_read_config_dword, =
pci_write_config_dword);
>=20
> -impl<'a, T: ?Sized + KnownSize> Io for ConfigSpace<'a, T> {
> +impl<'a, T: ?Sized + KnownSize> Io<'a> for ConfigSpace<'a, T> {
> +    type Backend =3D ConfigSpaceBackend;
>     type Target =3D T;
>=20
>     #[inline]
> -    fn addr(self) -> usize {
> -        self.ptr.addr()
> -    }
> -
> -    #[inline]
> -    fn maxsize(self) -> usize {
> -        KnownSize::size(self.ptr)
> +    fn as_view(self) -> ConfigSpace<'a, T> {
> +        self
>     }
> }
>=20
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


