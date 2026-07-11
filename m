Return-Path: <linux-pwm+bounces-9690-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RP+6D22dUWokGwMAu9opvQ
	(envelope-from <linux-pwm+bounces-9690-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 03:33:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698373FF1E
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 03:33:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=Lk3Gm7qQ;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9690-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9690-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB51C300A38A
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 01:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C02E36F8;
	Sat, 11 Jul 2026 01:33:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375992DEA8F;
	Sat, 11 Jul 2026 01:33:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783733608; cv=pass; b=S8OIA/5VKmmqiqtLe91xfKPqZdMgDLfapNPT49nz+re+8tcT+WeDDWwB5N/R9MVmPq70sMI1aPGp5oF+2bOPRZSWE562MAuVJaEQ70jm6XfKjOdqUQ0ySl1oTxyw5vxfnrnfXeGcItDQRnUqa7lcYyeKuFXB2v1myjPkJJGVseg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783733608; c=relaxed/simple;
	bh=gsEBn5BVLhSEw5ug7SJs/gukax1NOc7EBju/0jnVA5g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=De3e5oWIYWAtSrgTWcfiaterCsdCBF//MFSON7/1GaNPNyFTrin9lGSo34hPH94gyuSVfvGDeCXRdzGdywxPix5gHJ/XQJJtD/MgkRH8ZGTEylqX7Ba1JuJQXvzguwh3wIpn+twxPYcnHweadpnLckkoBVGwm9GaDuoaVGOR8y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Lk3Gm7qQ; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783733568; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P+rA1fb/Bq9WYuI5gaQivLqn86Tb+lS7bz93XnHLR7dnhtHikoHyBwjdxTsMJWTK7VSpVv+U3Vq3QxbtmC9X7utgq5vHrMs/TQsE4kyD2MlYi2Ww8/cq34E6Jj4bEzJEv/D0q9T6C/n6IyC3MG7q2Sbvd/uLUbG+KEMb26EAcP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783733568; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8gMf0nxC2d5C8ZjOmix2w/Kv6DOVRcZKwqCijuR/pd0=; 
	b=CvuhtN1aIE4EaGwS/5xxIifC4zTYSTVITmkCp2u+NnlYDYf7kp77nMWzux+1ZDsKQzVtLnUeAnLK85o7AVt8IXT2HJbpDc5e7tZXlN41L7loQmnqxFCNxWct3+mDyYbZdKelHN1+2efeZs1I/lxaYzRlWp09+CRTolUiof/Vwlk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783733568;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=8gMf0nxC2d5C8ZjOmix2w/Kv6DOVRcZKwqCijuR/pd0=;
	b=Lk3Gm7qQdkD35x+m0iZkvf6kdo8NS2R4Am8Xbeo8E2/wQmnYYDW2bxj4EUa+x0H8
	DZsOPVSrWVCjmUBdSmcrXFqSc24vMcAP0JABBvPzX+djPl4a70Uc0g8P+g3b8d+FTIe
	q7KevwQ6mji2Xa05+WlOW39cuB6OCWkCJ+MHHVU8=
Received: by mx.zohomail.com with SMTPS id 178373356638357.65623280407033;
	Fri, 10 Jul 2026 18:32:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 15/20] rust: io: implement a view type for `Coherent`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-15-72cd5d055d54@garyguo.net>
Date: Fri, 10 Jul 2026 22:32:27 -0300
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
Message-Id: <C8CF4F99-0E14-464D-B78A-83D9F0431024@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-15-72cd5d055d54@garyguo.net>
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
	TAGGED_FROM(0.00)[bounces-9690-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,nvidia.com:email,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8698373FF1E



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Implement a `CoherentView` type which is a view of `Coherent`. To be =
able
> to give out DMA handles, the view type contains both CPU and DMA =
pointers,
> and the projection method projects both at once.
>=20
> Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
> method to erase the DMA handle and give out a `SysMem` view, if the =
user
> does not need the `dma_handle`.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/dma.rs | 138 =
++++++++++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 136 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 200def84fb69..1535bc6eec64 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -14,14 +14,21 @@
>     },
>     error::to_result,
>     fs::file,
> +    io::{
> +        IoBackend,
> +        IoBase,
> +        IoCapable,
> +        SysMem,
> +        SysMemBackend, //
> +    },
>     prelude::*,
>     ptr::KnownSize,
>     sync::aref::ARef,
>     transmute::{
>         AsBytes,
>         FromBytes, //
> -    }, //
> -    uaccess::UserSliceWriter,
> +    },
> +    uaccess::UserSliceWriter, //
> };
> use core::{
>     ops::{
> @@ -1133,6 +1140,133 @@ unsafe impl Send for CoherentHandle {}
> // plain `Copy` values.
> unsafe impl Sync for CoherentHandle {}
>=20
> +/// View type for `Coherent`.
> +///
> +/// This is same as [`SysMem`] but with additional information that =
allows handing out a DMA handle.
> +pub struct CoherentView<'a, T: ?Sized> {
> +    cpu_addr: SysMem<'a, T>,
> +    dma_handle: DmaAddress,
> +}
> +
> +impl<T: ?Sized> Copy for CoherentView<'_, T> {}
> +impl<T: ?Sized> Clone for CoherentView<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<'a, T: ?Sized> CoherentView<'a, T> {
> +    /// Erase the DMA handle information and obtain a [`SysMem`] view =
of the same memory region.
> +    #[inline]
> +    pub fn as_sys_mem(self) -> SysMem<'a, T> {
> +        self.cpu_addr
> +    }
> +
> +    /// Returns a DMA handle which may be given to the device as the =
DMA address base of the region.
> +    #[inline]
> +    pub fn dma_handle(self) -> DmaAddress {
> +        self.dma_handle
> +    }
> +
> +    /// Returns a reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write =
to/from memory while the returned
> +    ///   reference is live.
> +    /// * Callers must ensure that this call does not race with a =
write (including call to `as_mut`)
> +    ///   to the same region while the returned reference is live.
> +    #[inline]
> +    pub unsafe fn as_ref(self) -> &'a T {
> +        // SAFETY: pointer is aligned and valid per type invariant. =
Aliasing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &*self.cpu_addr.as_ptr() }
> +    }
> +
> +    /// Returns a mutable reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write =
to/from memory while the returned
> +    ///   reference is live.
> +    /// * Callers must ensure that this call does not race with a =
read (including call to `as_ref`)
> +    ///   or write (including call to `as_mut`) to the same region =
while the returned reference is
> +    ///   live.
> +    #[inline]
> +    pub unsafe fn as_mut(self) -> &'a mut T {
> +        // SAFETY: pointer is aligned and valid per type invariant. =
Aliasing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &mut *self.cpu_addr.as_ptr() }
> +    }
> +}
> +
> +/// `IoBackend` implementation for `Coherent`.
> +pub struct CoherentIoBackend;
> +
> +impl IoBackend for CoherentIoBackend {
> +    type View<'a, T: ?Sized + KnownSize> =3D CoherentView<'a, T>;
> +
> +    #[inline]
> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> =
*mut T {
> +        SysMemBackend::as_ptr(view.cpu_addr)
> +    }
> +
> +    #[inline]
> +    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + =
KnownSize>(
> +        view: Self::View<'a, T>,
> +        ptr: *mut U,
> +    ) -> Self::View<'a, U> {
> +        let offset =3D ptr.addr() - view.cpu_addr.as_ptr().addr();
> +        // CAST: The offset DMA address can never overflow.
> +        let dma_handle =3D view.dma_handle + offset as DmaAddress;
> +        CoherentView {
> +            dma_handle,
> +            // SAFETY: Per safety requirement.
> +            cpu_addr: unsafe { =
SysMemBackend::project_view(view.cpu_addr, ptr) },
> +        }
> +    }
> +}
> +
> +impl<T> IoCapable<T> for CoherentIoBackend
> +where
> +    SysMemBackend: IoCapable<T>,
> +{
> +    #[inline]
> +    fn io_read<'a>(view: Self::View<'a, T>) -> T {
> +        SysMemBackend::io_read(view.cpu_addr)
> +    }
> +
> +    #[inline]
> +    fn io_write<'a>(view: Self::View<'a, T>, value: T) {
> +        SysMemBackend::io_write(view.cpu_addr, value)
> +    }
> +}
> +
> +impl<'a, T: ?Sized + KnownSize> IoBase<'a> for CoherentView<'a, T> {
> +    type Backend =3D CoherentIoBackend;
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn as_view(self) -> CoherentView<'a, Self::Target> {
> +        self
> +    }
> +}
> +
> +impl<'a, T: ?Sized + KnownSize> IoBase<'a> for &'a Coherent<T> {
> +    type Backend =3D CoherentIoBackend;
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn as_view(self) -> CoherentView<'a, Self::Target> {
> +        CoherentView {
> +            // SAFETY: `cpu_addr` is valid and aligned kernel =
accessible memory.
> +            cpu_addr: unsafe { SysMem::new(self.cpu_addr.as_ptr()) },
> +            dma_handle: self.dma_handle,
> +        }
> +    }
> +}
> +
> /// Reads a field of an item from an allocated region of structs.
> ///
> /// The syntax is of the form `kernel::dma_read!(dma, proj)` where =
`dma` is an expression evaluating
>=20
> --=20
> 2.54.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


