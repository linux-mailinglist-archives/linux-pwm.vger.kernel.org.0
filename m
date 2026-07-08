Return-Path: <linux-pwm+bounces-9634-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hmInETQ8TmriJQIAu9opvQ
	(envelope-from <linux-pwm+bounces-9634-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 14:01:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C837261AE
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 14:01:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=TjtfzDXG;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9634-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9634-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD66330137B6
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A5435AB9;
	Wed,  8 Jul 2026 11:59:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD393BE161;
	Wed,  8 Jul 2026 11:59:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511955; cv=pass; b=OoIMsk4o+Il24gtnt/6B9/kdIiWbPOfZdJjeZ6UfMbfTbSWgrtwjfZc30idTp5hXNtPqL/QnrjxVqE+oq5GpPc9bWpBpo5PytnzR79YZqsz+j+E5wHvzmNo1/vFz6sdXCeeigrS4zR22yyUIJRFJ0rx9k5jTqNh+TtgyCeuLwDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511955; c=relaxed/simple;
	bh=pmu0IU49odUB3SnA+99gvm1V/28YuAVo9gSdLtzGCFc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KuZre+EgijkQQl7poV/Mzc951U7IV8nJZBUjxXU1uooksvigIdZf4OqNTH+dFa8BLZIJ+C6m4H7l3nLN8nhohIPzcNyda15Z25i7aU1srAVp8TwM2jwX0z/u6zCsA0lIKumC62zwHX6m9/71fW6HFrCkWyRmCnzDi2z2Qw+hlec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=TjtfzDXG; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783511924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Isr+7iqECTIhjqzfdavdO/aJjDjBPAO+eTyd8DfG3ik/JQZB/NzmHoo9k89YiBRFL4QzpsXly0u4gGKZymw8J2u9b1ovLOc5pzf1HLs1B8QMionsTrbaG9H0SRk5PgW8w+IVX9Cli5eBmOoly5Jb+qhXSwdFD7HyywAXIuGXQWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783511924; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DbGKIVPfPPT8Aj7brJgocrtAF1bRFi+RRGEvVzM985w=; 
	b=WgmcHK8rHcLx3+3tCBkB6GFDEXhg1QgkOXg7uk86iPUHGdHQQ2gSqyTU1wv1tMYiqcx8/0r+09wkBte8neH3b7bfDfQjzIJiIUEqlXrhOnSUOk+/XkTVpk4Wxt0fTN8OqrQ3evpFgytH5bBoDF2NCXnh63Vf/946Ltlac6PGtgA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783511924;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=DbGKIVPfPPT8Aj7brJgocrtAF1bRFi+RRGEvVzM985w=;
	b=TjtfzDXGkAZ8rnD30aWcRl1VmjIjLSt7ZPnYYt5UXknecAmwEvKz4EReH37EtdYg
	NK4HduiWxXm9YE2sMeBtPplGuQvDAOxOTRlxg1XcyfnBuwVOFdJMBrCWediYssYyKQ3
	kNsFnAheXoAvZVALv40DbuboOXx1myicmTuxLUVU=
Received: by mx.zohomail.com with SMTPS id 1783511922397500.97047209613584;
	Wed, 8 Jul 2026 04:58:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 04/20] rust: io: implement `Io` on reference types
 instead
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-4-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 08:58:23 -0300
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
Message-Id: <88183651-927C-4A64-A3C9-BC5C4FE6C831@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-4-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[collabora.com:query timed out];
	TAGGED_FROM(0.00)[bounces-9634-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-pwm@vger.kernel.org:server fail,daniel.almeida.collabora.com:query timed out,acourbot.nvidia.com:query timed out];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6C837261AE



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This =
is
> going to change with I/O projections, as then `Io` needs to work both =
for
> owned objects and views of them. Views are themselves reference-like
> (however they obviously cannot be references, because they belong to a
> different address space).
>=20
> To facilitate the change, change `Io` to be implemented on reference =
types
> for the owned I/O objects, and make methods take `self` instead of =
`&self`.
> When I/O views are implemented, we can then naturally implement `Io` =
for
> these objects.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/io.rs     | 82 =
++++++++++++++++++++++++++-------------------------
> rust/kernel/pci/io.rs | 12 ++++----
> 2 files changed, 48 insertions(+), 46 deletions(-)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 87141eb07056..9f060dd29182 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -223,7 +223,7 @@ pub trait IoCapable<T> {
>     ///
>     /// - The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
>     /// - `address` must be aligned.
> -    unsafe fn io_read(&self, address: usize) -> T;
> +    unsafe fn io_read(self, address: usize) -> T;
>=20
>     /// Performs an I/O write of `value` at `address`.
>     ///
> @@ -231,7 +231,7 @@ pub trait IoCapable<T> {
>     ///
>     /// - The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
>     /// - `address` must be aligned.
> -    unsafe fn io_write(&self, value: T, address: usize);
> +    unsafe fn io_write(self, value: T, address: usize);
> }
>=20
> /// Describes a given I/O location: its offset, width, and type to =
convert the raw value from and
> @@ -294,25 +294,27 @@ fn offset(self) -> usize {
> /// Which I/O methods are available depends on which [`IoCapable<T>`] =
traits
> /// are implemented for the type.
> ///
> +/// This should be implemented on cheaply copyable handles, such as =
references or view types.
> +///
> /// # Examples
> ///
> /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit =
systems) are typically
> /// supported. For PCI configuration space, u8, u16, and u32 are =
supported but u64 is not.
> -pub trait Io {
> +pub trait Io: Copy {
>     /// Type of this I/O region. For untyped regions, [`Region`] can =
be used.
>     type Target: ?Sized + KnownSize;
>=20
>     /// Returns the base address of this mapping.
> -    fn addr(&self) -> usize;
> +    fn addr(self) -> usize;
>=20
>     /// Returns the maximum size of this mapping.
> -    fn maxsize(&self) -> usize;
> +    fn maxsize(self) -> usize;
>=20
>     /// Returns the absolute I/O address for a given `offset`,
>     /// performing compile-time bound checks.
>     // Always inline to optimize out error path of `build_assert`.
>     #[inline(always)]
> -    fn io_addr_assert<U>(&self, offset: usize) -> usize {
> +    fn io_addr_assert<U>(self, offset: usize) -> usize {
>         // We cannot check alignment with `offset_valid` using =
`self.addr()`. So set 0 for it and
>         // ensure alignment by checking that the alignment of `U` is =
smaller or equal to the
>         // alignment of `Self::Target`.
> @@ -325,7 +327,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> =
usize {
>     /// Returns the absolute I/O address for a given `offset`,
>     /// performing runtime bound checks.
>     #[inline]
> -    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> +    fn io_addr<U>(self, offset: usize) -> Result<usize> {
>         if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
>             return Err(EINVAL);
>         }
> @@ -337,7 +339,7 @@ fn io_addr<U>(&self, offset: usize) -> =
Result<usize> {
>=20
>     /// Fallible 8-bit read with runtime bounds check.
>     #[inline(always)]
> -    fn try_read8(&self, offset: usize) -> Result<u8>
> +    fn try_read8(self, offset: usize) -> Result<u8>
>     where
>         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
>         Self: IoCapable<u8>,
> @@ -347,7 +349,7 @@ fn try_read8(&self, offset: usize) -> Result<u8>
>=20
>     /// Fallible 16-bit read with runtime bounds check.
>     #[inline(always)]
> -    fn try_read16(&self, offset: usize) -> Result<u16>
> +    fn try_read16(self, offset: usize) -> Result<u16>
>     where
>         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
>         Self: IoCapable<u16>,
> @@ -357,7 +359,7 @@ fn try_read16(&self, offset: usize) -> Result<u16>
>=20
>     /// Fallible 32-bit read with runtime bounds check.
>     #[inline(always)]
> -    fn try_read32(&self, offset: usize) -> Result<u32>
> +    fn try_read32(self, offset: usize) -> Result<u32>
>     where
>         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
>         Self: IoCapable<u32>,
> @@ -367,7 +369,7 @@ fn try_read32(&self, offset: usize) -> Result<u32>
>=20
>     /// Fallible 64-bit read with runtime bounds check.
>     #[inline(always)]
> -    fn try_read64(&self, offset: usize) -> Result<u64>
> +    fn try_read64(self, offset: usize) -> Result<u64>
>     where
>         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
>         Self: IoCapable<u64>,
> @@ -377,7 +379,7 @@ fn try_read64(&self, offset: usize) -> Result<u64>
>=20
>     /// Fallible 8-bit write with runtime bounds check.
>     #[inline(always)]
> -    fn try_write8(&self, value: u8, offset: usize) -> Result
> +    fn try_write8(self, value: u8, offset: usize) -> Result
>     where
>         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
>         Self: IoCapable<u8>,
> @@ -387,7 +389,7 @@ fn try_write8(&self, value: u8, offset: usize) -> =
Result
>=20
>     /// Fallible 16-bit write with runtime bounds check.
>     #[inline(always)]
> -    fn try_write16(&self, value: u16, offset: usize) -> Result
> +    fn try_write16(self, value: u16, offset: usize) -> Result
>     where
>         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
>         Self: IoCapable<u16>,
> @@ -397,7 +399,7 @@ fn try_write16(&self, value: u16, offset: usize) =
-> Result
>=20
>     /// Fallible 32-bit write with runtime bounds check.
>     #[inline(always)]
> -    fn try_write32(&self, value: u32, offset: usize) -> Result
> +    fn try_write32(self, value: u32, offset: usize) -> Result
>     where
>         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
>         Self: IoCapable<u32>,
> @@ -407,7 +409,7 @@ fn try_write32(&self, value: u32, offset: usize) =
-> Result
>=20
>     /// Fallible 64-bit write with runtime bounds check.
>     #[inline(always)]
> -    fn try_write64(&self, value: u64, offset: usize) -> Result
> +    fn try_write64(self, value: u64, offset: usize) -> Result
>     where
>         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
>         Self: IoCapable<u64>,
> @@ -417,7 +419,7 @@ fn try_write64(&self, value: u64, offset: usize) =
-> Result
>=20
>     /// Infallible 8-bit read with compile-time bounds check.
>     #[inline(always)]
> -    fn read8(&self, offset: usize) -> u8
> +    fn read8(self, offset: usize) -> u8
>     where
>         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
>         Self: IoCapable<u8>,
> @@ -427,7 +429,7 @@ fn read8(&self, offset: usize) -> u8
>=20
>     /// Infallible 16-bit read with compile-time bounds check.
>     #[inline(always)]
> -    fn read16(&self, offset: usize) -> u16
> +    fn read16(self, offset: usize) -> u16
>     where
>         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
>         Self: IoCapable<u16>,
> @@ -437,7 +439,7 @@ fn read16(&self, offset: usize) -> u16
>=20
>     /// Infallible 32-bit read with compile-time bounds check.
>     #[inline(always)]
> -    fn read32(&self, offset: usize) -> u32
> +    fn read32(self, offset: usize) -> u32
>     where
>         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
>         Self: IoCapable<u32>,
> @@ -447,7 +449,7 @@ fn read32(&self, offset: usize) -> u32
>=20
>     /// Infallible 64-bit read with compile-time bounds check.
>     #[inline(always)]
> -    fn read64(&self, offset: usize) -> u64
> +    fn read64(self, offset: usize) -> u64
>     where
>         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
>         Self: IoCapable<u64>,
> @@ -457,7 +459,7 @@ fn read64(&self, offset: usize) -> u64
>=20
>     /// Infallible 8-bit write with compile-time bounds check.
>     #[inline(always)]
> -    fn write8(&self, value: u8, offset: usize)
> +    fn write8(self, value: u8, offset: usize)
>     where
>         usize: IoLoc<Self::Target, u8, IoType =3D u8>,
>         Self: IoCapable<u8>,
> @@ -467,7 +469,7 @@ fn write8(&self, value: u8, offset: usize)
>=20
>     /// Infallible 16-bit write with compile-time bounds check.
>     #[inline(always)]
> -    fn write16(&self, value: u16, offset: usize)
> +    fn write16(self, value: u16, offset: usize)
>     where
>         usize: IoLoc<Self::Target, u16, IoType =3D u16>,
>         Self: IoCapable<u16>,
> @@ -477,7 +479,7 @@ fn write16(&self, value: u16, offset: usize)
>=20
>     /// Infallible 32-bit write with compile-time bounds check.
>     #[inline(always)]
> -    fn write32(&self, value: u32, offset: usize)
> +    fn write32(self, value: u32, offset: usize)
>     where
>         usize: IoLoc<Self::Target, u32, IoType =3D u32>,
>         Self: IoCapable<u32>,
> @@ -487,7 +489,7 @@ fn write32(&self, value: u32, offset: usize)
>=20
>     /// Infallible 64-bit write with compile-time bounds check.
>     #[inline(always)]
> -    fn write64(&self, value: u64, offset: usize)
> +    fn write64(self, value: u64, offset: usize)
>     where
>         usize: IoLoc<Self::Target, u64, IoType =3D u64>,
>         Self: IoCapable<u64>,
> @@ -518,7 +520,7 @@ fn write64(&self, value: u64, offset: usize)
>     /// }
>     /// ```
>     #[inline(always)]
> -    fn try_read<T, L>(&self, location: L) -> Result<T>
> +    fn try_read<T, L>(self, location: L) -> Result<T>
>     where
>         L: IoLoc<Self::Target, T>,
>         Self: IoCapable<L::IoType>,
> @@ -552,7 +554,7 @@ fn try_read<T, L>(&self, location: L) -> Result<T>
>     /// }
>     /// ```
>     #[inline(always)]
> -    fn try_write<T, L>(&self, location: L, value: T) -> Result
> +    fn try_write<T, L>(self, location: L, value: T) -> Result
>     where
>         L: IoLoc<Self::Target, T>,
>         Self: IoCapable<L::IoType>,
> @@ -598,7 +600,7 @@ fn try_write<T, L>(&self, location: L, value: T) =
-> Result
>     /// }
>     /// ```
>     #[inline(always)]
> -    fn try_write_reg<T, L, V>(&self, value: V) -> Result
> +    fn try_write_reg<T, L, V>(self, value: V) -> Result
>     where
>         L: IoLoc<Self::Target, T>,
>         V: LocatedRegister<Self::Target, Location =3D L, Value =3D T>,
> @@ -631,7 +633,7 @@ fn try_write_reg<T, L, V>(&self, value: V) -> =
Result
>     /// }
>     /// ```
>     #[inline(always)]
> -    fn try_update<T, L, F>(&self, location: L, f: F) -> Result
> +    fn try_update<T, L, F>(self, location: L, f: F) -> Result
>     where
>         L: IoLoc<Self::Target, T>,
>         Self: IoCapable<L::IoType>,
> @@ -670,7 +672,7 @@ fn try_update<T, L, F>(&self, location: L, f: F) =
-> Result
>     /// }
>     /// ```
>     #[inline(always)]
> -    fn read<T, L>(&self, location: L) -> T
> +    fn read<T, L>(self, location: L) -> T
>     where
>         L: IoLoc<Self::Target, T>,
>         Self: IoCapable<L::IoType>,
> @@ -702,7 +704,7 @@ fn read<T, L>(&self, location: L) -> T
>     /// }
>     /// ```
>     #[inline(always)]
> -    fn write<T, L>(&self, location: L, value: T)
> +    fn write<T, L>(self, location: L, value: T)
>     where
>         L: IoLoc<Self::Target, T>,
>         Self: IoCapable<L::IoType>,
> @@ -745,7 +747,7 @@ fn write<T, L>(&self, location: L, value: T)
>     /// }
>     /// ```
>     #[inline(always)]
> -    fn write_reg<T, L, V>(&self, value: V)
> +    fn write_reg<T, L, V>(self, value: V)
>     where
>         L: IoLoc<Self::Target, T>,
>         V: LocatedRegister<Self::Target, Location =3D L, Value =3D T>,
> @@ -778,7 +780,7 @@ fn write_reg<T, L, V>(&self, value: V)
>     /// }
>     /// ```
>     #[inline(always)]
> -    fn update<T, L, F>(&self, location: L, f: F)
> +    fn update<T, L, F>(self, location: L, f: F)
>     where
>         L: IoLoc<Self::Target, T>,
>         Self: IoCapable<L::IoType>,
> @@ -799,13 +801,13 @@ fn update<T, L, F>(&self, location: L, f: F)
> macro_rules! impl_mmio_io_capable {
>     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, =
$write_fn:ident) =3D> {
>         $(#[$attr])*
> -        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
> -            unsafe fn io_read(&self, address: usize) -> $ty {
> +        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {
> +            unsafe fn io_read(self, address: usize) -> $ty {
>                 // SAFETY: By the trait invariant `address` is a valid =
address for MMIO operations.
>                 unsafe { bindings::$read_fn(address as *const c_void) =
}
>             }
>=20
> -            unsafe fn io_write(&self, value: $ty, address: usize) {
> +            unsafe fn io_write(self, value: $ty, address: usize) {
>                 // SAFETY: By the trait invariant `address` is a valid =
address for MMIO operations.
>                 unsafe { bindings::$write_fn(value, address as *mut =
c_void) }
>             }
> @@ -826,18 +828,18 @@ unsafe fn io_write(&self, value: $ty, address: =
usize) {
>     writeq
> );
>=20
> -impl<const SIZE: usize> Io for Mmio<SIZE> {
> +impl<'a, const SIZE: usize> Io for &'a Mmio<SIZE> {
>     type Target =3D Region<SIZE>;
>=20
>     /// Returns the base address of this mapping.
>     #[inline]
> -    fn addr(&self) -> usize {
> +    fn addr(self) -> usize {
>         self.0.addr()
>     }
>=20
>     /// Returns the maximum size of this mapping.
>     #[inline]
> -    fn maxsize(&self) -> usize {
> +    fn maxsize(self) -> usize {
>         self.0.maxsize()
>     }
> }
> @@ -864,16 +866,16 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> =
&Self {
> #[repr(transparent)]
> pub struct RelaxedMmio<const SIZE: usize =3D 0>(Mmio<SIZE>);
>=20
> -impl<const SIZE: usize> Io for RelaxedMmio<SIZE> {
> +impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
>     type Target =3D Region<SIZE>;
>=20
>     #[inline]
> -    fn addr(&self) -> usize {
> +    fn addr(self) -> usize {
>         self.0.addr()
>     }
>=20
>     #[inline]
> -    fn maxsize(&self) -> usize {
> +    fn maxsize(self) -> usize {
>         self.0.maxsize()
>     }
> }
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index b4996aa059d8..505305cd9b86 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -79,8 +79,8 @@ pub struct ConfigSpace<'a, S: ?Sized + =
ConfigSpaceKind =3D Extended> {
> /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using =
`$read_fn` and `$write_fn`.
> macro_rules! impl_config_space_io_capable {
>     ($ty:ty, $read_fn:ident, $write_fn:ident) =3D> {
> -        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for =
ConfigSpace<'a, S> {
> -            unsafe fn io_read(&self, address: usize) -> $ty {
> +        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for =
&ConfigSpace<'a, S> {
> +            unsafe fn io_read(self, address: usize) -> $ty {
>                 let mut val: $ty =3D 0;
>=20
>                 // Return value from C function is ignored in =
infallible accessors.
> @@ -94,7 +94,7 @@ unsafe fn io_read(&self, address: usize) -> $ty {
>                 val
>             }
>=20
> -            unsafe fn io_write(&self, value: $ty, address: usize) {
> +            unsafe fn io_write(self, value: $ty, address: usize) {
>                 // Return value from C function is ignored in =
infallible accessors.
>                 let _ret =3D
>                     // SAFETY: By the type invariant `self.pdev` is a =
valid address.
> @@ -112,18 +112,18 @@ unsafe fn io_write(&self, value: $ty, address: =
usize) {
> impl_config_space_io_capable!(u16, pci_read_config_word, =
pci_write_config_word);
> impl_config_space_io_capable!(u32, pci_read_config_dword, =
pci_write_config_dword);
>=20
> -impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
> +impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {
>     type Target =3D S;
>=20
>     /// Returns the base address of the I/O region. It is always 0 for =
configuration space.
>     #[inline]
> -    fn addr(&self) -> usize {
> +    fn addr(self) -> usize {
>         0
>     }
>=20
>     /// Returns the maximum size of the configuration space.
>     #[inline]
> -    fn maxsize(&self) -> usize {
> +    fn maxsize(self) -> usize {
>         self.pdev.cfg_size().into_raw()
>     }
> }
>=20
> --=20
> 2.54.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

