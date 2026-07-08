Return-Path: <linux-pwm+bounces-9640-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CvYeDMpRTmq6KgIAu9opvQ
	(envelope-from <linux-pwm+bounces-9640-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 15:34:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D4726D5D
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 15:34:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=LJa8K7tM;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9640-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9640-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3A4330376B6
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 13:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423F34575D;
	Wed,  8 Jul 2026 13:29:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3D3451AF;
	Wed,  8 Jul 2026 13:29:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517365; cv=pass; b=lhVCcB0CAatZUQggwLw4ML1R5Quw2tY2sNieC3jgSWEXk1cGE7jhVjrN1Jm7gN4UlsFd68nSV5IAJk2Erz3jG7si1JSztJfaduoRKKfukZfBvHPKxIp339QlgTLIDbt3gKpVUmNum6RKq2i7BOs6knK56BAseF06T8kxYuDOj9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517365; c=relaxed/simple;
	bh=ETQdonLxG6BeOHA2ebnsm6g2M7LbKtjJ01Uu/UKKt3o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lgsXmVIvONk6AUwSUexCRGDV+vgutfPHXyTrth/Dd0h3xRJhchBrp8bdP4utN6pTVxRT/4oICkr1OY1huW4kLkbbD6J4Pitt1yGtaT7HTVstelXrIhcV003uGi4LQVaMZCAXtjtWLvY+GWinzVvEx3jh9ZRRSyEb2v0FfJdjg38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LJa8K7tM; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783517327; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B+Egv0Lv2asl5B+0Cz16zaqh+07u7bw/Z4PcDRUSCEp+Vg0J9eIaBCfrOLLfDFWE8vXa2bW5PqcCvTPlKLnNTQpeQf8YCfh2DuLflyV4Dj6xkS77wQJRi8voG+J1D8vqdtwkwE3arZhieL/72+4/eUB+P3QT+EPtoo4NZGDkszc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783517327; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZHKUpaaxOG3TiKrgenFjszrnO2+S4PB/WTF9AEj1jxc=; 
	b=iYVogWpR7vcbX78qbgwKLENddeH4eO5kNoh+cYZIf8Vem02s+hnpZU8qmcF2taAYOM1r/36v+qFP6hFHPtj1DXrhz2pWho42ppgyMLMn/hKdYAFu5o7p/hXpocaYdjqm6hquwe4NcxaKoar+uQ4LUkOWZUUnp2GuZvTmFeNWROs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783517327;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ZHKUpaaxOG3TiKrgenFjszrnO2+S4PB/WTF9AEj1jxc=;
	b=LJa8K7tMVVJNWGHpCGK3WFWR/3cneDzKZ6v8lQFSFL4wI9kDLA1FI7GN2sC2i0Zk
	ZLdi1xXwKIG4LkYS9sPFvUKEoeev27ZUbx+zCoR5v0mx3cxcfM2l2GPOEZesq/9lkDL
	RwNV2BHrJ/zIMx058CSwVWtL1nA/JH0DBB1NSufI=
Received: by mx.zohomail.com with SMTPS id 1783517324399189.77230306485933;
	Wed, 8 Jul 2026 06:28:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 08/20] rust: pci: io: make `ConfigSpace` a view
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-8-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 10:28:23 -0300
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
Message-Id: <043E32BB-789D-4ABA-9491-185108A19EAE@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-8-72cd5d055d54@garyguo.net>
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
	TAGGED_FROM(0.00)[bounces-9640-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 857D4726D5D



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> In order to support I/O projection, we are splitting I/O types into =
two
> categories: owned objects and views. Owned objects have a specific =
type
> that is related to setting up and tearing down, while views can have =
their
> type changed with I/O projection.
>=20
> Things like `IoMem` or `Bar` are owned objects, which requires setting =
up
> mapping and cleaning up on drop. On the other side, `ConfigSpace` is =
really
> just a view, as the resource is associated with the `pci::Device`.
>=20
> Remove the `ConfigSpaceKind` bound on `ConfigSpace` and make it a =
generic
> view. This means that `ConfigSpace` object now represents a subregion =
and
> therefore encodes offset (as address of pointers) and size (as =
metadata of
> pointers) itself. The full region case is still supported with offset =
0 and
> size of `cfg_size`.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/pci/io.rs | 64 =
+++++++++++++++++++++++++++++----------------------
> 1 file changed, 36 insertions(+), 28 deletions(-)
>=20
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index e0acb62f58a2..89f4bb483a7f 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -18,7 +18,6 @@
>     ptr::KnownSize, //
> };
> use core::{
> -    marker::PhantomData,
>     ops::Deref, //
> };
>=20
> @@ -53,33 +52,42 @@ pub const fn into_raw(self) -> usize {
> /// Alias for extended (4096-byte) PCIe configuration space.
> pub type Extended =3D Region<4096>;
>=20
> -/// Trait for PCI configuration space size markers.
> -///
> -/// This trait is implemented by [`Normal`] and [`Extended`] to =
provide
> -/// compile-time knowledge of the configuration space size.
> -pub trait ConfigSpaceKind: KnownSize {}
> -
> -impl ConfigSpaceKind for Normal {}
> -
> -impl ConfigSpaceKind for Extended {}
> -
> -/// The PCI configuration space of a device.
> +/// A view of PCI configuration space of a device.
> ///
> /// Provides typed read and write accessors for configuration =
registers
> /// using the standard `pci_read_config_*` and `pci_write_config_*` =
helpers.
> ///
> -/// The generic parameter `S` indicates the maximum size of the =
configuration space.
> -/// Use [`Normal`] for 256-byte legacy configuration space or =
[`Extended`] for
> -/// 4096-byte PCIe extended configuration space (default).
> -pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind =3D Extended> =
{
> +/// The generic parameter `T` is the type of the view. The full =
configuration space is also a
> +/// special type of view; in such cases, `T` can be [`Normal`] for =
256-byte legacy configuration
> +/// space or [`Extended`] for 4096-byte PCIe extended configuration =
space (default).
> +///
> +/// # Invariants
> +///
> +/// `ptr` is aligned and range `ptr..ptr + KnownSize::size(ptr)` is =
within
> +/// `0..pdev.cfg_size().into_raw()`.
> +pub struct ConfigSpace<'a, T: ?Sized =3D Extended> {
>     pub(crate) pdev: &'a Device<device::Bound>,
> -    _marker: PhantomData<S>,
> +    ptr: *mut T,
> }
>=20
> +impl<T: ?Sized> Copy for ConfigSpace<'_, T> {}
> +impl<T: ?Sized> Clone for ConfigSpace<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +// SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O =
memory.
> +unsafe impl<T: ?Sized + Sync> Send for ConfigSpace<'_, T> {}
> +
> +// SAFETY: `ConfigSpace<'_, T>` is conceptually `&T` but in I/O =
memory.
> +unsafe impl<T: ?Sized + Sync> Sync for ConfigSpace<'_, T> {}
> +
> /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using =
`$read_fn` and `$write_fn`.
> macro_rules! impl_config_space_io_capable {
>     ($ty:ty, $read_fn:ident, $write_fn:ident) =3D> {
> -        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for =
&ConfigSpace<'a, S> {
> +        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
>             unsafe fn io_read(self, address: usize) -> $ty {
>                 let mut val: $ty =3D 0;
>=20
> @@ -112,19 +120,17 @@ unsafe fn io_write(self, value: $ty, address: =
usize) {
> impl_config_space_io_capable!(u16, pci_read_config_word, =
pci_write_config_word);
> impl_config_space_io_capable!(u32, pci_read_config_dword, =
pci_write_config_dword);
>=20
> -impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
> -    type Target =3D S;
> +impl<'a, T: ?Sized + KnownSize> Io for ConfigSpace<'a, T> {
> +    type Target =3D T;
>=20
> -    /// Returns the base address of the I/O region. It is always 0 =
for configuration space.
>     #[inline]
>     fn addr(self) -> usize {
> -        0
> +        self.ptr.addr()
>     }
>=20
> -    /// Returns the maximum size of the configuration space.
>     #[inline]
>     fn maxsize(self) -> usize {
> -        self.pdev.cfg_size().into_raw()
> +        KnownSize::size(self.ptr)
>     }
> }
>=20
> @@ -281,23 +287,25 @@ pub fn cfg_size(&self) -> ConfigSpaceSize {
>         }
>     }
>=20
> -    /// Return an initialized normal (256-byte) config space object.
> +    /// Return a view of the normal (256-byte) config space.
>     pub fn config_space<'a>(&'a self) -> ConfigSpace<'a, Normal> {
> +        // INVARIANT: null is aligned and the range is within config =
space.
>         ConfigSpace {
>             pdev: self,
> -            _marker: PhantomData,
> +            ptr: =
Normal::ptr_from_raw_parts_mut(core::ptr::null_mut(), =
self.cfg_size().into_raw()),
>         }
>     }
>=20
> -    /// Return an initialized extended (4096-byte) config space =
object.
> +    /// Return a view of the extended (4096-byte) config space.
>     pub fn config_space_extended<'a>(&'a self) -> =
Result<ConfigSpace<'a, Extended>> {
>         if self.cfg_size() !=3D ConfigSpaceSize::Extended {
>             return Err(EINVAL);
>         }
>=20
> +        // INVARIANT: null is aligned and we just checked the =
`cfg_size`.
>         Ok(ConfigSpace {
>             pdev: self,
> -            _marker: PhantomData,
> +            ptr: =
Extended::ptr_from_raw_parts_mut(core::ptr::null_mut(), 4096),
>         })
>     }
> }
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


