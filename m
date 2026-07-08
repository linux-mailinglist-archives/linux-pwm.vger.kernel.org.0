Return-Path: <linux-pwm+bounces-9639-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r+niKChPTmo5KgIAu9opvQ
	(envelope-from <linux-pwm+bounces-9639-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 15:22:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29F726C31
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 15:22:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=FuKr9Dvo;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9639-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9639-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD8A30D7453
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9D280CD2;
	Wed,  8 Jul 2026 13:11:18 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F6281369;
	Wed,  8 Jul 2026 13:11:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516278; cv=pass; b=MeIRVMHePEWcthOYd2Y/Qan5hFLXM5twlEoZOdlKxpdAas6Gqg7hZjpLIjbAE+w8f0F/3i+eGZ1oNC8nKK4mwubnH/+UbizrAyBNLtzICF4Sp9R7idWQRjrgWyEUtv1pGMhFeC7PYrqBKUOQ8FkAWIs9DRFrzwsTi04xDAPS9lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516278; c=relaxed/simple;
	bh=LyMPmHxHOQ6eDXl4I4BLy2jd4ntW8YQp39+vDKoIf2w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=b2kF7T/HYeqbR6jkULZKbojxh6K5JCmkdJLWw1Jn+jBRxCNfQIMrKaxynPjvyZNbuneggC0cspxNZG7hAbO+dCX460H84Hu6ujvna6VwkBC4vBk5FzW4G9FDGvboON6kywwZmb+b8SGN8ArJKJPrmzBvslN+wjdIs7VNaRnsz4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=FuKr9Dvo; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783516233; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VxX87XaouBpnkXiVPtN4DYtw84IPZKmh6CVC2DtX3diBxlXmZHje2ZVDWjxuSFvAAhmN5+MwGwhvMHtpqpcLbIraZqRFN6VxTlTpmu0/NB6njVEdRT48cYgJbe75Te1zKeG9biYPsExKDYBeyQ8HGDzfYIyWIEmujqhHsEjS6KY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783516233; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UTlHlLqqFS+y76nWC5IWjsnNvvO8MsWQtswtgtQQ5Lo=; 
	b=B1sE7d12IxQ4VSn4c5YuIkDmg9atx1HFinoLE3UbWbA1o3JYltHkV5rdohlHQRaDFaOhvFOXqcGmCt+lWextVpWZE1EiP7GHeMUpEmkWQHUvapSlutFz0mBpPQ7+D5NQ6Dt9lNT9JdN667y268G9rbNGieHKqZKfKRGNRUCJ8lM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783516233;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=UTlHlLqqFS+y76nWC5IWjsnNvvO8MsWQtswtgtQQ5Lo=;
	b=FuKr9DvoZJOO5I/8wQz+d6ZM/Yd5LVyRU22wvKkBq0BpX2kLPn8wh9ZFYdsWTU1M
	zaWAvy5RmBiNhsk82fqYDZGOO3FUhMHFJT+2IOegrY26trlNSoZ11BVjiAQ3o74AZEP
	8nXTEzktJwPgim7ErlhNqIQ1DJl9vWS1wmXn7Cvw=
Received: by mx.zohomail.com with SMTPS id 1783516231275340.7934923442349;
	Wed, 8 Jul 2026 06:10:31 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 07/20] rust: io: implement `Mmio` as view type
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-7-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 10:10:10 -0300
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
Message-Id: <7CE0D9BF-E945-44A3-AAC6-C230B67EA335@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-7-72cd5d055d54@garyguo.net>
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
	TAGGED_FROM(0.00)[bounces-9639-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A29F726C31



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Implement `Mmio` as view type and convert `RelaxedMmio` to view type =
as
> well. I/O implementations of `MmioOwned` are changed to delegate to =
the
> `Mmio` view type.
>=20
> All existing users of `MmioOwned` in the documentation which do not
> actually reflect the owning semantics is converted.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/io.rs          | 176 =
++++++++++++++++++++++++++++++++++-----------
> rust/kernel/io/poll.rs     |  10 +--
> rust/kernel/io/register.rs |  24 +++----
> 3 files changed, 153 insertions(+), 57 deletions(-)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index f93be7f78069..8110b49aa430 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -4,6 +4,10 @@
> //!
> //! C header: =
[`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
>=20
> +use core::{
> +    marker::PhantomData, //
> +};
> +
> use crate::{
>     bindings,
>     prelude::*,
> @@ -537,10 +541,11 @@ fn write64(self, value: u64, offset: usize)
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     MmioOwned,
> +    ///     Mmio,
> +    ///     Region,
>     /// };
>     ///
> -    /// fn do_reads(io: &MmioOwned) -> Result {
> +    /// fn do_reads(io: Mmio<'_, Region>) -> Result {
>     ///     // 32-bit read from address `0x10`.
>     ///     let v: u32 =3D io.try_read(0x10)?;
>     ///
> @@ -571,10 +576,11 @@ fn try_read<T, L>(self, location: L) -> =
Result<T>
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     MmioOwned,
> +    ///     Mmio,
> +    ///     Region,
>     /// };
>     ///
> -    /// fn do_writes(io: &MmioOwned) -> Result {
> +    /// fn do_writes(io: Mmio<'_, Region>) -> Result {
>     ///     // 32-bit write of value `1` at address `0x10`.
>     ///     io.try_write(0x10, 1u32)?;
>     ///
> @@ -609,7 +615,8 @@ fn try_write<T, L>(self, location: L, value: T) -> =
Result
>     /// use kernel::io::{
>     ///     register,
>     ///     Io,
> -    ///     MmioOwned,
> +    ///     Mmio,
> +    ///     Region,
>     /// };
>     ///
>     /// register! {
> @@ -625,7 +632,7 @@ fn try_write<T, L>(self, location: L, value: T) -> =
Result
>     ///     }
>     /// }
>     ///
> -    /// fn do_write_reg(io: &MmioOwned) -> Result {
> +    /// fn do_write_reg(io: Mmio<'_, Region>) -> Result {
>     ///
>     ///     io.try_write_reg(VERSION::new(1, 0))
>     /// }
> @@ -654,10 +661,11 @@ fn try_write_reg<T, L, V>(self, value: V) -> =
Result
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     MmioOwned,
> +    ///     Mmio,
> +    ///     Region,
>     /// };
>     ///
> -    /// fn do_update(io: &MmioOwned<0x1000>) -> Result {
> +    /// fn do_update(io: Mmio<'_, Region<0x1000>>) -> Result {
>     ///     io.try_update(0x10, |v: u32| {
>     ///         v + 1
>     ///     })
> @@ -691,10 +699,11 @@ fn try_update<T, L, F>(self, location: L, f: F) =
-> Result
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     MmioOwned,
> +    ///     Mmio,
> +    ///     Region,
>     /// };
>     ///
> -    /// fn do_reads(io: &MmioOwned<0x1000>) {
> +    /// fn do_reads(io: Mmio<'_, Region<0x1000>>) {
>     ///     // 32-bit read from address `0x10`.
>     ///     let v: u32 =3D io.read(0x10);
>     ///
> @@ -723,10 +732,11 @@ fn read<T, L>(self, location: L) -> T
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     MmioOwned,
> +    ///     Mmio,
> +    ///     Region,
>     /// };
>     ///
> -    /// fn do_writes(io: &MmioOwned<0x1000>) {
> +    /// fn do_writes(io: Mmio<'_, Region<0x1000>>) {
>     ///     // 32-bit write of value `1` at address `0x10`.
>     ///     io.write(0x10, 1u32);
>     ///
> @@ -757,7 +767,8 @@ fn write<T, L>(self, location: L, value: T)
>     /// use kernel::io::{
>     ///     register,
>     ///     Io,
> -    ///     MmioOwned,
> +    ///     Mmio,
> +    ///     Region,
>     /// };
>     ///
>     /// register! {
> @@ -773,7 +784,7 @@ fn write<T, L>(self, location: L, value: T)
>     ///     }
>     /// }
>     ///
> -    /// fn do_write_reg(io: &MmioOwned<0x1000>) {
> +    /// fn do_write_reg(io: Mmio<'_, Region<0x1000>>) {
>     ///     io.write_reg(VERSION::new(1, 0));
>     /// }
>     /// ```
> @@ -801,10 +812,11 @@ fn write_reg<T, L, V>(self, value: V)
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     MmioOwned,
> +    ///     Mmio,
> +    ///     Region,
>     /// };
>     ///
> -    /// fn do_update(io: &MmioOwned<0x1000>) {
> +    /// fn do_update(io: Mmio<'_, Region<0x1000>>) {
>     ///     io.update(0x10, |v: u32| {
>     ///         v + 1
>     ///     })
> @@ -828,16 +840,72 @@ fn update<T, L, F>(self, location: L, f: F)
>     }
> }
>=20
> +/// A view of memory-mapped I/O region.
> +///
> +/// # Invariant
> +///
> +/// `ptr` points to a valid and aligned memory-mapped I/O region for =
the duration lifetime `'a`.
> +pub struct Mmio<'a, T: ?Sized> {
> +    ptr: *mut T,
> +    phantom: PhantomData<&'a ()>,
> +}
> +
> +impl<T: ?Sized> Copy for Mmio<'_, T> {}
> +impl<T: ?Sized> Clone for Mmio<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<'a, T: ?Sized> Mmio<'a, T> {
> +    /// Create a `Mmio`, providing the accessors to the MMIO mapping.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `raw` represents a valid and aligned memory-mapped I/O region =
while `'a` is alive.
> +    #[inline]
> +    pub unsafe fn from_raw(raw: MmioRaw<T>) -> Self {
> +        // INVARIANT: Per safety requirement.
> +        Self {
> +            ptr: raw.ptr,
> +            phantom: PhantomData,
> +        }
> +    }
> +}
> +
> +// SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
> +unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
> +
> +// SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
> +unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
> +
> +impl<T: ?Sized + KnownSize> Io for Mmio<'_, T> {
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn addr(self) -> usize {
> +        self.ptr.addr()
> +    }
> +
> +    #[inline]
> +    fn maxsize(self) -> usize {
> +        KnownSize::size(self.ptr)
> +    }
> +}
> +
> /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and =
`$write_fn`.
> macro_rules! impl_mmio_io_capable {
>     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, =
$write_fn:ident) =3D> {
>         $(#[$attr])*
> -        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {
> +        impl<T: ?Sized> IoCapable<$ty> for $mmio<'_, T> {
> +            #[inline]
>             unsafe fn io_read(self, address: usize) -> $ty {
>                 // SAFETY: By the trait invariant `address` is a valid =
address for MMIO operations.
>                 unsafe { bindings::$read_fn(address as *const c_void) =
}
>             }
>=20
> +            #[inline]
>             unsafe fn io_write(self, value: $ty, address: usize) {
>                 // SAFETY: By the trait invariant `address` is a valid =
address for MMIO operations.
>                 unsafe { bindings::$write_fn(value, address as *mut =
c_void) }
> @@ -847,17 +915,12 @@ unsafe fn io_write(self, value: $ty, address: =
usize) {
> }
>=20
> // MMIO regions support 8, 16, and 32-bit accesses.
> -impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
> -impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
> -impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
> +impl_mmio_io_capable!(Mmio, u8, readb, writeb);
> +impl_mmio_io_capable!(Mmio, u16, readw, writew);
> +impl_mmio_io_capable!(Mmio, u32, readl, writel);
> // MMIO regions on 64-bit systems also support 64-bit accesses.
> -impl_mmio_io_capable!(
> -    MmioOwned,
> -    #[cfg(CONFIG_64BIT)]
> -    u64,
> -    readq,
> -    writeq
> -);
> +#[cfg(CONFIG_64BIT)]
> +impl_mmio_io_capable!(Mmio, u64, readq, writeq);
>=20
> impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
>     type Target =3D Region<SIZE>;
> @@ -875,6 +938,23 @@ fn maxsize(self) -> usize {
>     }
> }
>=20
> +impl<'a, const SIZE: usize, T> IoCapable<T> for &'a MmioOwned<SIZE>
> +where
> +    Mmio<'a, Region<SIZE>>: IoCapable<T>,
> +{
> +    #[inline]
> +    unsafe fn io_read(self, address: usize) -> T {
> +        // SAFETY: Per safety requirement.
> +        unsafe { self.as_view().io_read(address) }
> +    }
> +
> +    #[inline]
> +    unsafe fn io_write(self, value: T, address: usize) {
> +        // SAFETY: Per safety requirement.
> +        unsafe { self.as_view().io_write(value, address) }
> +    }
> +}
> +
> impl<const SIZE: usize> MmioOwned<SIZE> {
>     /// Converts an `MmioRaw` into an `MmioOwned` instance, providing =
the accessors to the MMIO
>     /// mapping.
> @@ -887,19 +967,33 @@ pub unsafe fn from_raw(raw: =
&MmioRaw<Region<SIZE>>) -> &Self {
>         // SAFETY: `MmioOwned` is a transparent wrapper around =
`MmioRaw`.
>         unsafe { &*core::ptr::from_ref(raw).cast() }
>     }
> +
> +    /// Return a view that covers the full region.
> +    #[inline]
> +    pub fn as_view(&self) -> Mmio<'_, Region<SIZE>> {
> +        // SAFETY: `Mmio` has same invariant as `MmioOwned`.
> +        unsafe { Mmio::from_raw(self.0) }
> +    }
> }
>=20
> -/// [`MmioOwned`] wrapper using relaxed accessors.
> +/// [`Mmio`] but using relaxed accessors.
> ///
> /// This type provides an implementation of [`Io`] that uses relaxed =
I/O MMIO operands instead of
> /// the regular ones.
> ///
> -/// See [`MmioOwned::relaxed`] for a usage example.
> -#[repr(transparent)]
> -pub struct RelaxedMmio<const SIZE: usize =3D 0>(MmioOwned<SIZE>);
> +/// See [`Mmio::relaxed`] for a usage example.
> +pub struct RelaxedMmio<'a, T: ?Sized>(Mmio<'a, T>);
>=20
> -impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
> -    type Target =3D Region<SIZE>;
> +impl<T: ?Sized> Copy for RelaxedMmio<'_, T> {}
> +impl<T: ?Sized> Clone for RelaxedMmio<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: ?Sized + KnownSize> Io for RelaxedMmio<'_, T> {
> +    type Target =3D T;
>=20
>     #[inline]
>     fn addr(self) -> usize {
> @@ -912,8 +1006,8 @@ fn maxsize(self) -> usize {
>     }
> }
>=20
> -impl<const SIZE: usize> MmioOwned<SIZE> {
> -    /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O =
operations.
> +impl<'a, T: ?Sized> Mmio<'a, T> {
> +    /// Returns a [`RelaxedMmio`] that performs relaxed I/O =
operations.
>     ///
>     /// Relaxed accessors do not provide ordering guarantees with =
respect to DMA or memory accesses
>     /// and can be used when such ordering is not required.
> @@ -923,20 +1017,20 @@ impl<const SIZE: usize> MmioOwned<SIZE> {
>     /// ```no_run
>     /// use kernel::io::{
>     ///     Io,
> -    ///     MmioOwned,
> +    ///     Mmio,
> +    ///     Region,
>     ///     RelaxedMmio,
>     /// };
>     ///
> -    /// fn do_io(io: &MmioOwned<0x100>) {
> +    /// fn do_io(io: Mmio<'_, Region<0x100>>) {
>     ///     // The access is performed using `readl_relaxed` instead =
of `readl`.
>     ///     let v =3D io.relaxed().read32(0x10);
>     /// }
>     ///
>     /// ```
> -    pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
> -        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over =
`MmioOwned`, so `MmioOwned<SIZE>`
> -        // and `RelaxedMmio<SIZE>` have identical layout.
> -        unsafe { core::mem::transmute(self) }
> +    #[inline]
> +    pub fn relaxed(self) -> RelaxedMmio<'a, T> {
> +        RelaxedMmio(self)
>     }
> }
>=20
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> index 79828a8006b5..d75f2fcf46f2 100644
> --- a/rust/kernel/io/poll.rs
> +++ b/rust/kernel/io/poll.rs
> @@ -47,14 +47,15 @@
> /// ```no_run
> /// use kernel::io::{
> ///     Io,
> -///     MmioOwned,
> +///     Mmio,
> +///     Region,
> ///     poll::read_poll_timeout, //
> /// };
> /// use kernel::time::Delta;
> ///
> /// const HW_READY: u16 =3D 0x01;
> ///
> -/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> =
Result {
> +/// fn wait_for_hardware<const SIZE: usize>(io: Mmio<'_, =
Region<SIZE>>) -> Result {
> ///     read_poll_timeout(
> ///         // The `op` closure reads the value of a specific status =
register.
> ///         || io.try_read16(0x1000),
> @@ -134,14 +135,15 @@ pub fn read_poll_timeout<Op, Cond, T>(
> /// ```no_run
> /// use kernel::io::{
> ///     Io,
> -///     MmioOwned,
> +///     Mmio,
> +///     Region,
> ///     poll::read_poll_timeout_atomic, //
> /// };
> /// use kernel::time::Delta;
> ///
> /// const HW_READY: u16 =3D 0x01;
> ///
> -/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> =
Result {
> +/// fn wait_for_hardware<const SIZE: usize>(io: Mmio<'_, =
Region<SIZE>>) -> Result {
> ///     read_poll_timeout_atomic(
> ///         // The `op` closure reads the value of a specific status =
register.
> ///         || io.try_read16(0x1000),
> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index fd3bf6220f95..6cb07fc92cc3 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -58,7 +58,7 @@
> //!     },
> //!     num::Bounded,
> //! };
> -//! # use kernel::io::MmioOwned;
> +//! # use kernel::io::{Mmio, Region};
> //! # register! {
> //! #     pub BOOT_0(u32) @ 0x00000100 {
> //! #         15:8 vendor_id;
> @@ -66,7 +66,7 @@
> //! #         3:0 minor_revision;
> //! #     }
> //! # }
> -//! # fn test(io: &MmioOwned<0x1000>) {
> +//! # fn test(io: Mmio<'_, Region<0x1000>>) {
> //! # fn obtain_vendor_id() -> u8 { 0xff }
> //!
> //! // Read from the register's defined offset (0x100).
> @@ -446,7 +446,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///         Io,
> ///     },
> /// };
> -/// # use kernel::io::MmioOwned;
> +/// # use kernel::io::{Mmio, Region};
> ///
> /// register! {
> ///     FIXED_REG(u32) @ 0x100 {
> @@ -455,7 +455,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test(io: &MmioOwned<0x1000>) {
> +/// # fn test(io: Mmio<'_, Region<0x1000>>) {
> /// let val =3D io.read(FIXED_REG);
> ///
> /// // Write from an already-existing value.
> @@ -559,7 +559,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///         Io,
> ///     },
> /// };
> -/// # use kernel::io::MmioOwned;
> +/// # use kernel::io::{Mmio, Region};
> ///
> /// // Type used to identify the base.
> /// pub struct CpuCtlBase;
> @@ -584,7 +584,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test(io: MmioOwned<0x1000>) {
> +/// # fn test(io: Mmio<'_, Region<0x1000>>) {
> /// // Read the status of `Cpu0`.
> /// let cpu0_started =3D io.read(CPU_CTL::of::<Cpu0>());
> ///
> @@ -601,7 +601,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test2(io: MmioOwned<0x1000>) {
> +/// # fn test2(io: Mmio<'_, Region<0x1000>>) {
> /// // Start the aliased `CPU0`, leaving its other fields untouched.
> /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| =
r.with_alias_start(true));
> /// # }
> @@ -638,7 +638,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///         Io,
> ///     },
> /// };
> -/// # use kernel::io::MmioOwned;
> +/// # use kernel::io::{Mmio, Region};
> /// # fn get_scratch_idx() -> usize {
> /// #   0x15
> /// # }
> @@ -651,7 +651,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test(io: &MmioOwned<0x1000>)
> +/// # fn test(io: Mmio<'_, Region<0x1000>>)
> /// #     -> Result<(), Error>{
> /// // Read scratch register 0, i.e. I/O address `0x80`.
> /// let scratch_0 =3D io.read(SCRATCH::at(0)).value();
> @@ -724,7 +724,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///         Io,
> ///     },
> /// };
> -/// # use kernel::io::MmioOwned;
> +/// # use kernel::io::{Mmio, Region};
> /// # fn get_scratch_idx() -> usize {
> /// #   0x15
> /// # }
> @@ -752,7 +752,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test(io: &MmioOwned<0x1000>) -> Result<(), Error> {
> +/// # fn test(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
> /// // Read scratch register 0 of CPU0.
> /// let scratch =3D io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
> ///
> @@ -794,7 +794,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
> ///     }
> /// }
> ///
> -/// # fn test2(io: &MmioOwned<0x1000>) -> Result<(), Error> {
> +/// # fn test2(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
> /// let cpu0_status =3D =
io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
> /// # Ok(())
> /// # }
>=20
> --=20
> 2.54.0
>=20


Ran the tests again, they=E2=80=99re passing.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

