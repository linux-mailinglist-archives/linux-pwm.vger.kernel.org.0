Return-Path: <linux-pwm+bounces-9689-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UsT/NO+bUWrmGgMAu9opvQ
	(envelope-from <linux-pwm+bounces-9689-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 03:27:11 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2E873FEEE
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 03:27:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=WjJzkoEo;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9689-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9689-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D44BC3006B57
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 01:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2F1DD525;
	Sat, 11 Jul 2026 01:27:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFF28F5;
	Sat, 11 Jul 2026 01:27:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783733229; cv=pass; b=F2k1xP6rPqVtCaBZncYZQWhk/nMTSC/nJIMPaG29e094HEPhG0AdyrPjO6V1sVQELyVGBDpf9J9d4oegGYkUb5IUep9SYWvNcRh85cn+QkdJOrc3f7rOOB5RqCOVMWKp1qMkvdM05sdB01NRdqZx2GwjToum5/y9mMTyWvLDCB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783733229; c=relaxed/simple;
	bh=XatPcgaBayRgywKUDu6SUeeMeB8y2HW7cvkwmV/GjR0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=baKIq6tVoOOKvtjIi0dd+tAkK8CbGmvUSuN+agUeKPQ/PsxY7OxEWhLBFo/YMTTkKSVLKJLL5opid9yiHg+8DNgel7q2htqGYkT3xDwzZfDblBCmt/LmUC4JqRKIgJV6hA0LyRO0NHeKEaG1UOxLg3SJmSQr63Na9C9wVRsYnCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=WjJzkoEo; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783733197; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RYw/ccei8GfX2ZZYi5r7tnJpr9sLHJfVlXIfaYz6xZDpSAiaTQu3ouXyU1/NM0I+K+fIrjZbPGqChW360+2dPur+0MYqE3MqDBgf9ZrGxl4PLJlpbl2oxjWJ8IQ1Gi7ne1e9zke6/gQx5PNP6C/ngrxk5aqV/m5Oo0mG7SMtq78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783733197; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NdyoGdZ9jTNEWZfdQkrxE0H2N74xEabOBVRJ0yaV9C4=; 
	b=XgeW3bYosXFnYvL8k6DprxzOzjOeMRRc5q8wXX0fmNu1J6GE32zwaNigLYbqYTqsFFJJDrRIrq2MpyW+VlZ/rOMcCE8TrQFPEKi/Xhvb9bUn+W6DlSJ3wS82Qhwb5qihD+XCYC3CNSzaJikvoyTjM1nDI3JMtROT2D9Hvgv1KIM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783733197;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=NdyoGdZ9jTNEWZfdQkrxE0H2N74xEabOBVRJ0yaV9C4=;
	b=WjJzkoEo1YrCsUfjHkpDs2EXhf3fABLES5atC/TwYWQDR935XA5wRg6Lku1BcIb2
	rZS7XoaDHB/H+glh+j+18u3elU7PyJxwqtQbwzjgiTcKo9qT2+k14vzfyFrwBvIwyF0
	smSD55wEbPye66OlSdu3dQYOJV8aD2IabDA8ELr4=
Received: by mx.zohomail.com with SMTPS id 1783733193918344.7896144010489;
	Fri, 10 Jul 2026 18:26:33 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 14/20] rust: io: add I/O backend for system memory with
 volatile access
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-14-72cd5d055d54@garyguo.net>
Date: Fri, 10 Jul 2026 22:26:12 -0300
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
 linux-pwm@vger.kernel.org,
 Laura Nao <laura.nao@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <926125C1-22E2-47BC-AFD4-788BA300601C@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-14-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9689-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel.almeida@collabora.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,collabora.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,garyguo.net:email,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C2E873FEEE



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> From: Laura Nao <laura.nao@collabora.com>
>=20
> Add `SysMem`, an `Io` trait implementation for kernel virtual address
> ranges. It uses volatile accessors to provide safe access to shared
> memory that may be concurrently accessed by external hardware. =
Implement
> `IoCapable` for `u8`, `u16`, `u32`, and `u64` (for 64-bit system).
>=20
> This can be used instead of `Coherent` for cases where a different =
layer
> takes care of mapping the system memory to the device (e.g. dma-buf or
> GPUVM).
>=20
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> [ Rebased and adapted on top of I/O rework. - Gary ]
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> rust/kernel/io.rs | 122 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 122 insertions(+)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 62643b23e904..78c6ae2a0db8 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -1039,6 +1039,128 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
> #[cfg(CONFIG_64BIT)]
> impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, =
writeq_relaxed);
>=20
> +/// I/O Backend for system memory.
> +pub struct SysMemBackend;
> +
> +impl IoBackend for SysMemBackend {
> +    type View<'a, T: ?Sized + KnownSize> =3D SysMem<'a, T>;
> +
> +    #[inline]
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
> +        // kernel accessible memory region.
> +        SysMem {
> +            ptr,
> +            phantom: PhantomData,
> +        }
> +    }
> +}
> +
> +/// Implements [`IoCapable`] on `SysMemBackend` for `$ty` using =
`read_volatile` and
> +/// `write_volatile`.
> +macro_rules! impl_sysmem_io_capable {
> +    ($ty:ty) =3D> {
> +        impl IoCapable<$ty> for SysMemBackend {
> +            #[inline]
> +            fn io_read(view: SysMem<'_, $ty>) -> $ty {
> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using read_volatile() here so that race with =
hardware is well-defined.
> +                // - Using read_volatile() here is not sound if it =
races with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                // - The macro is only used on primitives so all bit =
patterns are valid.
> +                unsafe { view.ptr.read_volatile() }
> +            }
> +
> +            #[inline]
> +            fn io_write(view: SysMem<'_, $ty>, value: $ty) {
> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using write_volatile() here so that race with =
hardware is well-defined.
> +                // - Using write_volatile() here is not sound if it =
races with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                unsafe { view.ptr.write_volatile(value) }
> +            }
> +        }
> +    };
> +}
> +
> +impl_sysmem_io_capable!(u8);
> +impl_sysmem_io_capable!(u16);
> +impl_sysmem_io_capable!(u32);
> +#[cfg(CONFIG_64BIT)]
> +impl_sysmem_io_capable!(u64);
> +
> +/// A view of a system memory region.
> +///
> +/// Provides `Io` trait implementation for kernel virtual address =
ranges,
> +/// using volatile read/write to safely access shared memory that may =
be
> +/// concurrently accessed by external hardware.
> +///
> +/// # Invariants
> +///
> +/// `self.ptr.addr() .. self.ptr.addr() + KnownSize::size(self.ptr)` =
is valid and aligned kernel
> +/// accessible memory region for the lifetime `'a`.
> +pub struct SysMem<'a, T: ?Sized> {
> +    ptr: *mut T,
> +    phantom: PhantomData<&'a ()>,
> +}
> +
> +impl<T: ?Sized> Copy for SysMem<'_, T> {}
> +impl<T: ?Sized> Clone for SysMem<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +// SAFETY: `SysMem<'_, T>` is conceptually `&T`.
> +unsafe impl<T: ?Sized + Sync> Send for SysMem<'_, T> {}
> +
> +// SAFETY: `SysMem<'_, T>` is conceptually `&T`.
> +unsafe impl<T: ?Sized + Sync> Sync for SysMem<'_, T> {}
> +
> +impl<'a, T: ?Sized> SysMem<'a, T> {
> +    /// Create a `SysMem` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr.addr() .. ptr.addr() + KnownSize::size(ptr)` must be =
valid and aligned kernel
> +    /// accessible memory region for the lifetime `'a`.
> +    #[inline]
> +    pub unsafe fn new(ptr: *mut T) -> Self {
> +        // INVARIANT: Per safety requirement.
> +        Self {
> +            ptr,
> +            phantom: PhantomData,
> +        }
> +    }
> +
> +    /// Obtain the raw pointer to the memory.
> +    #[inline]
> +    pub fn as_ptr(self) -> *mut T {
> +        self.ptr
> +    }
> +}
> +
> +impl<'a, T: ?Sized + KnownSize> IoBase<'a> for SysMem<'a, T> {
> +    type Backend =3D SysMemBackend;
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, =
Self::Target> {
> +        self
> +    }
> +}
> +
> // This helper turns associated functions to methods so it can be =
invoked in macro.
> // Used by `io_project!()` only.
> #[doc(hidden)]
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


