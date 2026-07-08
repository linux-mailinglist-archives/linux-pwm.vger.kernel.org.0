Return-Path: <linux-pwm+bounces-9637-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dLncCCNDTmptJwIAu9opvQ
	(envelope-from <linux-pwm+bounces-9637-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 14:31:31 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C1372652B
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 14:31:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=Vn1QUp7y;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9637-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9637-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61C4530056F3
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 12:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1997143C7BC;
	Wed,  8 Jul 2026 12:27:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB314438FFE;
	Wed,  8 Jul 2026 12:27:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513663; cv=pass; b=UH6Nqn7Bk13K0PKAx+JjN5R4Gx9LTUFKwsQZK4fUocnDd0An+IZCDPkaPWhcN5RALMvoWVbuDOoUK37FjniklYpFq+nEKYiRb9mujRI+sP2A9Rx++6M4jeNnkGdTutVgwF9po/3YUFDuxAfoFSqVLaADNi0U5cdLYIEQUjEDUGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513663; c=relaxed/simple;
	bh=RLF5mtQlzCltzbcjNa8n8tdtB6iyh2Wg5ST1znLtNLs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OGsC8wENbqCXW26llyFe3OB+aZMl+Bt222m63DAOE3NIC/3klmMkzXc2vCCo+li9WIYpf5XlMtHoS2JrEcmWfAlVGgqz7AIwlejVeJfxQtAgVD6R98w4FtHhuhmsc1irgC2lrojZ8WY3zclsKr3uZyxAccM57OpSoXEzLtjEpz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Vn1QUp7y; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783513623; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=heIK1TqoYMcnkWdCrd3Bt0Lg2OtdrZ/MaCQJRT89d/fDc8qtOpoHhj6i9AuqWnDvQPEBZx+6wAexxWoNKp4d2IWDvw0DzMu+J9Vwn3sc7GgI5XDFPv9nh2guyFOYJ6nar3RIvrAckHcSKO/c9mFq/ryR8BkbMOoSW0Kc7Qoroe0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783513623; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BzK12XhwyvTazS15kDm921f4zaJmoWphadGPDvrZ2CY=; 
	b=KIv3kcyw+GDNVX3SvLJsly+ZV/aXO5IqfeSyaRQbZvVccEixljFwPi1OGKNIcXa8JHf/YUFT6M4WHIEWkeoVzwFAffS2usAWedjH5I/xiNMikGjP3YTlA6RlHZ6zX9N+RpmB3SLENRUm/fYloaHqpuw1/f+NM2C3ffrTXz7pj38=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783513623;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=BzK12XhwyvTazS15kDm921f4zaJmoWphadGPDvrZ2CY=;
	b=Vn1QUp7yHfaOblyOYujBIYk5uWHWiMGS7it66CHfPfgX1zPl+UkcIxSA5MBdagJj
	/taP3zKmCrEULv2Fdb8A1DnAV0or0B9eFN2dQvtZfAIQ1f++u+t0UU6dzw8tjYxWpPC
	8rll26ruvEorWUHUOfTG7StD9u/KhZsjkL1ia+Nk=
Received: by mx.zohomail.com with SMTPS id 1783513622252929.1223916827764;
	Wed, 8 Jul 2026 05:27:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 06/20] rust: io: rename `Mmio` to `MmioOwned`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-6-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 09:26:40 -0300
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
Message-Id: <644A861E-0438-4622-9C7C-625B86ADF996@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-6-72cd5d055d54@garyguo.net>
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
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,sea.lore.kernel.org:server fail,nvidia.com:server fail,collabora.com:server fail,garyguo.net:server fail];
	TAGGED_FROM(0.00)[bounces-9637-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96C1372652B



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Most users would more commonly reach out to a view of `Mmio` rather =
than an
> owned instance of `Mmio`. Only implementor of `Io` like `Bar` or =
`IoMem`

implementor -> implementors

> would need the owned version. Thus, rename `Mmio` to `MmioOwned` so =
that
> the name `Mmio` can be used for the view type instead.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/devres.rs      |  6 ++--
> rust/kernel/io.rs          | 77 =
+++++++++++++++++++++++-----------------------
> rust/kernel/io/mem.rs      |  8 ++---
> rust/kernel/io/poll.rs     |  8 ++---
> rust/kernel/io/register.rs | 24 +++++++--------
> rust/kernel/pci/io.rs      |  6 ++--
> 6 files changed, 65 insertions(+), 64 deletions(-)
>=20
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index d0c677fd7932..aed0c994fd30 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -68,7 +68,7 @@ struct Inner<T> {
> ///     devres::Devres,
> ///     io::{
> ///         Io,
> -///         Mmio,
> +///         MmioOwned,
> ///         MmioRaw,
> ///         PhysAddr,
> ///         Region, //
> @@ -105,11 +105,11 @@ struct Inner<T> {
> /// }
> ///
> /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target =3D Mmio<SIZE>;
> +///    type Target =3D MmioOwned<SIZE>;
> ///
> ///    fn deref(&self) -> &Self::Target {
> ///         // SAFETY: The memory range stored in `self` has been =
properly mapped in `Self::new`.
> -///         unsafe { Mmio::from_raw(&self.0) }
> +///         unsafe { MmioOwned::from_raw(&self.0) }
> ///    }
> /// }
> /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 12be266d7ed7..f93be7f78069 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -94,8 +94,8 @@ fn size(p: *const Self) -> usize {
> /// the represented MMIO region does exist or is properly mapped.
> ///
> /// Instead, the bus specific MMIO implementation must convert this =
raw representation into an
> -/// `Mmio` instance providing the actual memory accessors. Only by =
the conversion into an `Mmio`
> -/// structure any guarantees are given.
> +/// `MmioOwned` instance providing the actual memory accessors. Only =
by the conversion into an
> +/// `MmioOwned` structure any guarantees are given.
> pub struct MmioRaw<T: ?Sized> {
>     /// Pointer is in I/O address space.
>     ///
> @@ -170,7 +170,7 @@ pub fn size(&self) -> usize {
> ///     ffi::c_void,
> ///     io::{
> ///         Io,
> -///         Mmio,
> +///         MmioOwned,
> ///         MmioRaw,
> ///         PhysAddr,
> ///         Region,
> @@ -206,11 +206,11 @@ pub fn size(&self) -> usize {
> /// }
> ///
> /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target =3D Mmio<SIZE>;
> +///    type Target =3D MmioOwned<SIZE>;
> ///
> ///    fn deref(&self) -> &Self::Target {
> ///         // SAFETY: The memory range stored in `self` has been =
properly mapped in `Self::new`.
> -///         unsafe { Mmio::from_raw(&self.0) }
> +///         unsafe { MmioOwned::from_raw(&self.0) }
> ///    }
> /// }
> ///
> @@ -224,7 +224,7 @@ pub fn size(&self) -> usize {
> /// # }
> /// ```
> #[repr(transparent)]
> -pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<Region<SIZE>>);
> +pub struct MmioOwned<const SIZE: usize =3D 0>(MmioRaw<Region<SIZE>>);
>=20
> /// Checks whether an access of type `U` at the given `base` and the =
given `offset`
> /// is valid within this region.
> @@ -537,10 +537,10 @@ fn write64(self, value: u64, offset: usize)
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     Mmio,
> +    ///     MmioOwned,
>     /// };
>     ///
> -    /// fn do_reads(io: &Mmio) -> Result {
> +    /// fn do_reads(io: &MmioOwned) -> Result {
>     ///     // 32-bit read from address `0x10`.
>     ///     let v: u32 =3D io.try_read(0x10)?;
>     ///
> @@ -571,10 +571,10 @@ fn try_read<T, L>(self, location: L) -> =
Result<T>
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     Mmio,
> +    ///     MmioOwned,
>     /// };
>     ///
> -    /// fn do_writes(io: &Mmio) -> Result {
> +    /// fn do_writes(io: &MmioOwned) -> Result {
>     ///     // 32-bit write of value `1` at address `0x10`.
>     ///     io.try_write(0x10, 1u32)?;
>     ///
> @@ -609,7 +609,7 @@ fn try_write<T, L>(self, location: L, value: T) -> =
Result
>     /// use kernel::io::{
>     ///     register,
>     ///     Io,
> -    ///     Mmio,
> +    ///     MmioOwned,
>     /// };
>     ///
>     /// register! {
> @@ -625,7 +625,7 @@ fn try_write<T, L>(self, location: L, value: T) -> =
Result
>     ///     }
>     /// }
>     ///
> -    /// fn do_write_reg(io: &Mmio) -> Result {
> +    /// fn do_write_reg(io: &MmioOwned) -> Result {
>     ///
>     ///     io.try_write_reg(VERSION::new(1, 0))
>     /// }
> @@ -654,10 +654,10 @@ fn try_write_reg<T, L, V>(self, value: V) -> =
Result
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     Mmio,
> +    ///     MmioOwned,
>     /// };
>     ///
> -    /// fn do_update(io: &Mmio<0x1000>) -> Result {
> +    /// fn do_update(io: &MmioOwned<0x1000>) -> Result {
>     ///     io.try_update(0x10, |v: u32| {
>     ///         v + 1
>     ///     })
> @@ -691,10 +691,10 @@ fn try_update<T, L, F>(self, location: L, f: F) =
-> Result
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     Mmio,
> +    ///     MmioOwned,
>     /// };
>     ///
> -    /// fn do_reads(io: &Mmio<0x1000>) {
> +    /// fn do_reads(io: &MmioOwned<0x1000>) {
>     ///     // 32-bit read from address `0x10`.
>     ///     let v: u32 =3D io.read(0x10);
>     ///
> @@ -723,10 +723,10 @@ fn read<T, L>(self, location: L) -> T
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     Mmio,
> +    ///     MmioOwned,
>     /// };
>     ///
> -    /// fn do_writes(io: &Mmio<0x1000>) {
> +    /// fn do_writes(io: &MmioOwned<0x1000>) {
>     ///     // 32-bit write of value `1` at address `0x10`.
>     ///     io.write(0x10, 1u32);
>     ///
> @@ -757,7 +757,7 @@ fn write<T, L>(self, location: L, value: T)
>     /// use kernel::io::{
>     ///     register,
>     ///     Io,
> -    ///     Mmio,
> +    ///     MmioOwned,
>     /// };
>     ///
>     /// register! {
> @@ -773,7 +773,7 @@ fn write<T, L>(self, location: L, value: T)
>     ///     }
>     /// }
>     ///
> -    /// fn do_write_reg(io: &Mmio<0x1000>) {
> +    /// fn do_write_reg(io: &MmioOwned<0x1000>) {
>     ///     io.write_reg(VERSION::new(1, 0));
>     /// }
>     /// ```
> @@ -801,10 +801,10 @@ fn write_reg<T, L, V>(self, value: V)
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     Mmio,
> +    ///     MmioOwned,
>     /// };
>     ///
> -    /// fn do_update(io: &Mmio<0x1000>) {
> +    /// fn do_update(io: &MmioOwned<0x1000>) {
>     ///     io.update(0x10, |v: u32| {
>     ///         v + 1
>     ///     })
> @@ -847,19 +847,19 @@ unsafe fn io_write(self, value: $ty, address: =
usize) {
> }
>=20
> // MMIO regions support 8, 16, and 32-bit accesses.
> -impl_mmio_io_capable!(Mmio, u8, readb, writeb);
> -impl_mmio_io_capable!(Mmio, u16, readw, writew);
> -impl_mmio_io_capable!(Mmio, u32, readl, writel);
> +impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
> +impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
> +impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
> // MMIO regions on 64-bit systems also support 64-bit accesses.
> impl_mmio_io_capable!(
> -    Mmio,
> +    MmioOwned,
>     #[cfg(CONFIG_64BIT)]
>     u64,
>     readq,
>     writeq
> );
>=20
> -impl<'a, const SIZE: usize> Io for &'a Mmio<SIZE> {
> +impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
>     type Target =3D Region<SIZE>;
>=20
>     /// Returns the base address of this mapping.
> @@ -875,27 +875,28 @@ fn maxsize(self) -> usize {
>     }
> }
>=20
> -impl<const SIZE: usize> Mmio<SIZE> {
> -    /// Converts an `MmioRaw` into an `Mmio` instance, providing the =
accessors to the MMIO mapping.
> +impl<const SIZE: usize> MmioOwned<SIZE> {
> +    /// Converts an `MmioRaw` into an `MmioOwned` instance, providing =
the accessors to the MMIO
> +    /// mapping.
>     ///
>     /// # Safety
>     ///
>     /// Callers must ensure that `addr` is the start of a valid I/O =
mapped memory region of size
>     /// `maxsize`.
>     pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
> -        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
> +        // SAFETY: `MmioOwned` is a transparent wrapper around =
`MmioRaw`.
>         unsafe { &*core::ptr::from_ref(raw).cast() }
>     }
> }
>=20
> -/// [`Mmio`] wrapper using relaxed accessors.
> +/// [`MmioOwned`] wrapper using relaxed accessors.
> ///
> /// This type provides an implementation of [`Io`] that uses relaxed =
I/O MMIO operands instead of
> /// the regular ones.
> ///
> -/// See [`Mmio::relaxed`] for a usage example.
> +/// See [`MmioOwned::relaxed`] for a usage example.
> #[repr(transparent)]
> -pub struct RelaxedMmio<const SIZE: usize =3D 0>(Mmio<SIZE>);
> +pub struct RelaxedMmio<const SIZE: usize =3D 0>(MmioOwned<SIZE>);
>=20
> impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
>     type Target =3D Region<SIZE>;
> @@ -911,7 +912,7 @@ fn maxsize(self) -> usize {
>     }
> }
>=20
> -impl<const SIZE: usize> Mmio<SIZE> {
> +impl<const SIZE: usize> MmioOwned<SIZE> {
>     /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O =
operations.
>     ///
>     /// Relaxed accessors do not provide ordering guarantees with =
respect to DMA or memory accesses
> @@ -922,19 +923,19 @@ impl<const SIZE: usize> Mmio<SIZE> {
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     Mmio,
> +    ///     MmioOwned,
>     ///     RelaxedMmio,
>     /// };
>     ///
> -    /// fn do_io(io: &Mmio<0x100>) {
> +    /// fn do_io(io: &MmioOwned<0x100>) {
>     ///     // The access is performed using `readl_relaxed` instead =
of `readl`.
>     ///     let v =3D io.relaxed().read32(0x10);
>     /// }
>     ///
>     /// ```
>     pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
> -        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over =
`Mmio`, so `Mmio<SIZE>` and
> -        // `RelaxedMmio<SIZE>` have identical layout.
> +        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over =
`MmioOwned`, so `MmioOwned<SIZE>`
> +        // and `RelaxedMmio<SIZE>` have identical layout.
>         unsafe { core::mem::transmute(self) }
>     }
> }
> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index 9e15bc8fde78..8f6c257c5b8e 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
> @@ -16,7 +16,7 @@
>             Region,
>             Resource, //
>         },
> -        Mmio,
> +        MmioOwned,
>         MmioRaw, //
>     },
>     prelude::*,
> @@ -211,7 +211,7 @@ pub fn into_devres(self) -> =
Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
> }
>=20
> impl<const SIZE: usize> Deref for ExclusiveIoMem<'_, SIZE> {
> -    type Target =3D Mmio<SIZE>;
> +    type Target =3D MmioOwned<SIZE>;
>=20
>     fn deref(&self) -> &Self::Target {
>         &self.iomem
> @@ -291,10 +291,10 @@ fn drop(&mut self) {
> }
>=20
> impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
> -    type Target =3D Mmio<SIZE>;
> +    type Target =3D MmioOwned<SIZE>;
>=20
>     fn deref(&self) -> &Self::Target {
>         // SAFETY: Safe as by the invariant of `IoMem`.
> -        unsafe { Mmio::from_raw(&self.io) }
> +        unsafe { MmioOwned::from_raw(&self.io) }
>     }
> }
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> index 75d1b3e8596c..79828a8006b5 100644
> --- a/rust/kernel/io/poll.rs
> +++ b/rust/kernel/io/poll.rs
> @@ -47,14 +47,14 @@
> /// ```no_run
> /// use kernel::io::{
> ///     Io,
> -///     Mmio,
> +///     MmioOwned,
> ///     poll::read_poll_timeout, //
> /// };
> /// use kernel::time::Delta;
> ///
> /// const HW_READY: u16 =3D 0x01;
> ///
> -/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> =
Result {
> +/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> =
Result {
> ///     read_poll_timeout(
> ///         // The `op` closure reads the value of a specific status =
register.
> ///         || io.try_read16(0x1000),
> @@ -134,14 +134,14 @@ pub fn read_poll_timeout<Op, Cond, T>(
> /// ```no_run
> /// use kernel::io::{
> ///     Io,
> -///     Mmio,
> +///     MmioOwned,
> ///     poll::read_poll_timeout_atomic, //
> /// };
> /// use kernel::time::Delta;
> ///
> /// const HW_READY: u16 =3D 0x01;
> ///
> -/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> =
Result {
> +/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> =
Result {
> ///     read_poll_timeout_atomic(
> ///         // The `op` closure reads the value of a specific status =
register.
> ///         || io.try_read16(0x1000),
> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index 1159e5168ef9..fd3bf6220f95 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -58,7 +58,7 @@
> //!     },
> //!     num::Bounded,
> //! };
> -//! # use kernel::io::Mmio;
> +//! # use kernel::io::MmioOwned;
> //! # register! {
> //! #     pub BOOT_0(u32) @ 0x00000100 {
> //! #         15:8 vendor_id;
> @@ -66,7 +66,7 @@
> //! #         3:0 minor_revision;
> //! #     }
> //! # }
> -//! # fn test(io: &Mmio<0x1000>) {
> +//! # fn test(io: &MmioOwned<0x1000>) {
> //! # fn obtain_vendor_id() -> u8 { 0xff }
> //!
> //! // Read from the register's defined offset (0x100).
> @@ -446,7 +446,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///         Io,
> ///     },
> /// };
> -/// # use kernel::io::Mmio;
> +/// # use kernel::io::MmioOwned;
> ///
> /// register! {
> ///     FIXED_REG(u32) @ 0x100 {
> @@ -455,7 +455,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test(io: &Mmio<0x1000>) {
> +/// # fn test(io: &MmioOwned<0x1000>) {
> /// let val =3D io.read(FIXED_REG);
> ///
> /// // Write from an already-existing value.
> @@ -559,7 +559,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///         Io,
> ///     },
> /// };
> -/// # use kernel::io::Mmio;
> +/// # use kernel::io::MmioOwned;
> ///
> /// // Type used to identify the base.
> /// pub struct CpuCtlBase;
> @@ -584,7 +584,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test(io: Mmio<0x1000>) {
> +/// # fn test(io: MmioOwned<0x1000>) {
> /// // Read the status of `Cpu0`.
> /// let cpu0_started =3D io.read(CPU_CTL::of::<Cpu0>());
> ///
> @@ -601,7 +601,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test2(io: Mmio<0x1000>) {
> +/// # fn test2(io: MmioOwned<0x1000>) {
> /// // Start the aliased `CPU0`, leaving its other fields untouched.
> /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| =
r.with_alias_start(true));
> /// # }
> @@ -638,7 +638,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///         Io,
> ///     },
> /// };
> -/// # use kernel::io::Mmio;
> +/// # use kernel::io::MmioOwned;
> /// # fn get_scratch_idx() -> usize {
> /// #   0x15
> /// # }
> @@ -651,7 +651,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test(io: &Mmio<0x1000>)
> +/// # fn test(io: &MmioOwned<0x1000>)
> /// #     -> Result<(), Error>{
> /// // Read scratch register 0, i.e. I/O address `0x80`.
> /// let scratch_0 =3D io.read(SCRATCH::at(0)).value();
> @@ -724,7 +724,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///         Io,
> ///     },
> /// };
> -/// # use kernel::io::Mmio;
> +/// # use kernel::io::MmioOwned;
> /// # fn get_scratch_idx() -> usize {
> /// #   0x15
> /// # }
> @@ -752,7 +752,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test(io: &Mmio<0x1000>) -> Result<(), Error> {
> +/// # fn test(io: &MmioOwned<0x1000>) -> Result<(), Error> {
> /// // Read scratch register 0 of CPU0.
> /// let scratch =3D io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
> ///
> @@ -794,7 +794,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test2(io: &Mmio<0x1000>) -> Result<(), Error> {
> +/// # fn test2(io: &MmioOwned<0x1000>) -> Result<(), Error> {
> /// let cpu0_status =3D =
io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
> /// # Ok(())
> /// # }
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 42f840d64a6f..e0acb62f58a2 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -10,7 +10,7 @@
>     io::{
>         Io,
>         IoCapable,
> -        Mmio,
> +        MmioOwned,
>         MmioRaw,
>         Region, //
>     },
> @@ -242,11 +242,11 @@ fn drop(&mut self) {
> }
>=20
> impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
> -    type Target =3D Mmio<SIZE>;
> +    type Target =3D MmioOwned<SIZE>;
>=20
>     fn deref(&self) -> &Self::Target {
>         // SAFETY: By the type invariant of `Self`, the MMIO range in =
`self.io` is properly mapped.
> -        unsafe { Mmio::from_raw(&self.io) }
> +        unsafe { MmioOwned::from_raw(&self.io) }
>     }
> }
>=20
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

