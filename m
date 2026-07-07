Return-Path: <linux-pwm+bounces-9624-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YVUtGWhITWqtxgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9624-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 20:41:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ED971EADA
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 20:41:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=M9oei2BL;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9624-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9624-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64879301F66A
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2026 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D61743F4B1;
	Tue,  7 Jul 2026 18:41:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C831E492D;
	Tue,  7 Jul 2026 18:41:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449689; cv=pass; b=Z5TgJARRGzy1rwo6wdkv/Oz4xhpcN3LuJ6DuhyHPJGfBxta9vndLDtNHB2f2ov184LmXnoJYOZJMSvKBX7hLGIfB/qJxmwd2vgmid5s6PBOcnP4aJWB/XJn/UXgKsxevINfjvjaOu2UnEku+OS9hFz5VzWgqVJAiT/DEZmqnMHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449689; c=relaxed/simple;
	bh=xTdEZPpx+cPYau6P/oapdph062qqJWYr/H3uSN27G/Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CjZ6aoI7B+wOJ8uZtcGq+GdXYZifRyeUaObS/zRtXNPn5j0+1Y9op9gqO/H9TUAkDRwj006YB8XqqbH+5/aqLi/7R/HGXS+K8821fX5lfqTOc3XxwPr3nuhb3yereEf++3Ov4s6JONb0WEJCdFFc8wzn6pAQv690w99jGHTQVoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=M9oei2BL; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783449658; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cdp4bG/XEl8J+bSYrJEMFweg2cZt6HBV2/55PeAKnvuxERQYQtMBdtS/kZH9HDq3nDad8j1/vAGViubPGZWnlQOBfueZLaGr1Z0oeXU5DnE+g3r2Jrbp+lcm7zdPuJ791tuc8M2p8+0P16J+7tZ9SRZm862eWg6INjk80hLwpiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783449658; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EDwlnOs4YCj2t7wvoltJ8iZPFDsHdK8fCnqAW/cA7WU=; 
	b=cc8yUUsX/6Q4GKfSl6KX1RsrLQv2wthHwFoD/i65KU0YuAPSNoV+3e2Loach0y6TZUKh4OjZwyBzUHqlbsvAbzACpyBMnoktqaieJwCBL0RXYCsaZYSlUbhper3toYuJ/zsjdj4scXuaSrQRfDUBNoH9AqVnFYoHgndZGeyeyxM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783449658;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=EDwlnOs4YCj2t7wvoltJ8iZPFDsHdK8fCnqAW/cA7WU=;
	b=M9oei2BLcjSRlwwu9LV2XG59pBQwPM1FvrsBjc4V+DCYAVZh+22SCt6I4FXxVpYH
	m3jYja78NKSBtMrqu8CaIjPr0T1h1mafD5fc3kQwvY/CmXpjyAmBEgPyfG19FUSDpFA
	Y8Bzm7lW5xBIav5I4ilNBOwr863p1D2CayxmLgv4=
Received: by mx.zohomail.com with SMTPS id 1783449656904757.8597891704945;
	Tue, 7 Jul 2026 11:40:56 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-2-72cd5d055d54@garyguo.net>
Date: Tue, 7 Jul 2026 15:40:36 -0300
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
Message-Id: <20770F1B-133E-42B1-A204-BF3CB70758BA@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-2-72cd5d055d54@garyguo.net>
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
	TAGGED_FROM(0.00)[bounces-9624-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,vger.kernel.org:from_smtp,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9ED971EADA



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> The current safety comment on `io_read`/`io_write` does not cover the =
topic
> about alignment. Add it so it can be relied on by implementor of
> `IoCapable`.
>=20
> Expand the check performed by `Io` by taking `self.addr()` into
> consideration when checking if `offset` is aligned. For the =
compile-time
> `io_addr_assert` check, check using the known minimum alignment of
> `Io::Target` and the accessed type.
>=20
> While at it, fix the alignment check to use `align_of` instead of
> `size_of`. The values match for all primitives (including u64, given =
that
> we do not provide u64 accessor on 32-bit platforms), but are not
> necessarily true for custom types.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/io.rs | 25 ++++++++++++++++---------
> 1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d1c5f0121994..d821ee48ed31 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -195,13 +195,14 @@ pub fn maxsize(&self) -> usize {
> #[repr(transparent)]
> pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
>=20
> -/// Checks whether an access of type `U` at the given `offset`
> +/// Checks whether an access of type `U` at the given `base` and the =
given `offset`
> /// is valid within this region.
> +///
> +/// The `base` is used for alignment checking only. This can be set =
to 0 to skip the check.
> #[inline]
> -const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> -    let type_size =3D core::mem::size_of::<U>();
> -    if let Some(end) =3D offset.checked_add(type_size) {
> -        end <=3D size && offset % type_size =3D=3D 0
> +const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> =
bool {
> +    if let Some(end) =3D offset.checked_add(size_of::<U>()) {
> +        end <=3D size && (base.wrapping_add(offset) % align_of::<U>() =
=3D=3D 0)
>     } else {
>         false
>     }
> @@ -220,14 +221,16 @@ pub trait IoCapable<T> {
>     ///
>     /// # Safety
>     ///
> -    /// The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> +    /// - The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> +    /// - `address` must be aligned.
>     unsafe fn io_read(&self, address: usize) -> T;
>=20
>     /// Performs an I/O write of `value` at `address`.
>     ///
>     /// # Safety
>     ///
> -    /// The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> +    /// - The range `[address..address + size_of::<T>()]` must be =
within the bounds of `Self`.
> +    /// - `address` must be aligned.
>     unsafe fn io_write(&self, value: T, address: usize);
> }
>=20
> @@ -309,7 +312,11 @@ pub trait Io {
>     // Always inline to optimize out error path of `build_assert`.
>     #[inline(always)]
>     fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(offset_valid::<U>(offset, =
Self::Target::MIN_SIZE));
> +        // We cannot check alignment with `offset_valid` using =
`self.addr()`. So set 0 for it and
> +        // ensure alignment by checking that the alignment of `U` is =
smaller or equal to the
> +        // alignment of `Self::Target`.
> +        const_assert!(Alignment::of::<U>().as_usize() <=3D =
Self::Target::MIN_ALIGN.as_usize());
> +        build_assert!(offset_valid::<U>(0, offset, =
Self::Target::MIN_SIZE));
>=20
>         self.addr() + offset
>     }
> @@ -318,7 +325,7 @@ fn io_addr_assert<U>(&self, offset: usize) -> =
usize {
>     /// performing runtime bound checks.
>     #[inline]
>     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> -        if !offset_valid::<U>(offset, self.maxsize()) {
> +        if !offset_valid::<U>(self.addr(), offset, self.maxsize()) {
>             return Err(EINVAL);
>         }
>=20
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


