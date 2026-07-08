Return-Path: <linux-pwm+bounces-9648-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LkMwFYaQTmohPgIAu9opvQ
	(envelope-from <linux-pwm+bounces-9648-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 20:01:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EABE729632
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 20:01:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b=Jc94RES9;
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9648-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9648-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B48C630A8895
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A8E4343F5;
	Wed,  8 Jul 2026 17:59:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC593BB109;
	Wed,  8 Jul 2026 17:59:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533572; cv=pass; b=GZBslb7M2ORWBP5TJtNkhUh/diJfkJPHuyRlO6UkJayTTZe2XRnDWEWrhDF2x2BXTbz97OSa2FcCc1IQvdD0Mn5uZO8Ag79pjVHoJlFK3ZIa3kq8UuvoCmyN9PXcBb4buLKQs6nOg3wbnWDoluNwnrFhEMh+15GqImS6b/NOozM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533572; c=relaxed/simple;
	bh=AgUlkat6v++jVhHY171oF8yEKncS8iy0eZpk/jsPyWQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mTMqu8KQguX3B9SSymL4mdmZeVIbFMscXC+N+Gtag02AAllFJKEAAucuJ9QdpeotOMWpy4TUxIoSwBa14RdPirvWXBdsZ1trkFc7twhdjEYr483/g2qKnKpoEJxseHF4JJPEFMim+7CpapLGg6tniMR985FIGUEWQpOQMoYXBWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Jc94RES9; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783533531; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TQK+/eWYh4wKZqQ5mETovYgMNQ1ABCn8d5EewDQU407/AZMaueTjb+jp9GCEK4iXNVYNWL9oMrkYBUdzy0msABzx+QFgWWhLYt1/OzTLFtpdi/JkYhW4PTxz8xjNaAEZIDJQN0ePy2GgTJvhmLhzdoLNOGXnyVSvMgAqtB/AJyU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783533531; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d2f5HzFH5tz9OWlHkS3xHKePdxFund2k2SALT7+iDuY=; 
	b=IOxlvGZIU/zpU39EZo7uHZ3fzIq8nL4pJUshe3oSuMuh+PQKNK38KpmqR8IYC6F/VDLdMWgeNqdrcPvIR5QGRUmc3CK5JRxbISfxFaIqhrD0q+x5vREdQ3yuHJZK0a8wjIYsFKMjTotNXCufdAWYaGEOE8EBoPj5XMNgYkH5qQc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783533531;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=d2f5HzFH5tz9OWlHkS3xHKePdxFund2k2SALT7+iDuY=;
	b=Jc94RES9ph213bpRia+uTLhf4a8zqS/jir3Ilrqseh7isW3J29bViRgnzXaezNhZ
	b4y7z4ySFtPSU0cxm+CGSP8WnjKKD6SrbuJMKKgaMYms5Db8zJLF/UtlfRYWvNRyIBt
	Ot28BbBcAYB8NaLoC2XKc6lB9t7TKQUcMv6W4pIg=
Received: by mx.zohomail.com with SMTPS id 1783533529735356.06010086134756;
	Wed, 8 Jul 2026 10:58:49 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 13/20] rust: io: add projection macro and methods
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-13-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 14:58:29 -0300
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
Message-Id: <CAF04CB6-4B09-47E1-9F9B-5D55E49A2737@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-13-72cd5d055d54@garyguo.net>
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
	TAGGED_FROM(0.00)[bounces-9648-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:from_mime,collabora.com:email,collabora.com:mid,collabora.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EABE729632



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Add an `io_project!()` macro to allow projection from `Io` to a =
subview of
> it, using the pointer projection mechanism to perform compile-time =
checks.
>=20
> For cases where type-casting is required, the `try_cast()` function =
may be
> used where the size and alignment checks are performed at runtime.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/io.rs | 128 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 128 insertions(+)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index ab970e8b2e78..62643b23e904 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -49,6 +49,7 @@
> /// - Size of the region is at least as large as the `SIZE` generic =
parameter.
> /// - Size of the region is multiple of 4.
> #[repr(C, align(4))]
> +#[derive(FromBytes)]
> pub struct Region<const SIZE: usize =3D 0> {
>     inner: [u8],
> }
> @@ -90,6 +91,19 @@ fn size(p: *const Self) -> usize {
>     }
> }
>=20
> +// SAFETY:
> +// - Values read from I/O are always treated as initialized.
> +// - Per type invariant the size is multiple of 4 and the type is =
4-byte aligned, so it is padding
> +//   free.
> +//
> +// This cannot be derived as `derive(IntoBytes)` as the padding free =
property comes from type
> +// invariant which the macro does not know.
> +unsafe impl<const SIZE: usize> IntoBytes for Region<SIZE> {
> +    #[inline]
> +    #[allow(unused)] // Rust 1.87+ stops requiring this and will emit =
unused warnings.
> +    fn only_derive_is_allowed_to_implement_this_trait() {}
> +}
> +
> /// Raw representation of an MMIO region.
> ///
> /// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
> @@ -339,6 +353,51 @@ fn size(self) -> usize {
>         KnownSize::size(Self::Backend::as_ptr(self.as_view()))
>     }
>=20
> +    /// Try to convert into a different typed I/O view.
> +    ///
> +    /// A runtime check is performed to ensure that the target type =
is of same or smaller size to
> +    /// current type, and the current view is properly aligned for =
the target type. Returns
> +    /// `Err(EINVAL)` if the runtime check fails.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::io::{
> +    ///     io_project,
> +    ///     Mmio,
> +    ///     Io,
> +    ///     Region,
> +    /// };
> +    /// #[derive(FromBytes, IntoBytes)]
> +    /// #[repr(C)]
> +    /// struct MyStruct { field: u32, }
> +    ///
> +    /// # fn test(mmio: &Mmio<'_, Region>) -> Result {
> +    /// // let mmio: Mmio<'_, Region>;
> +    /// let whole: Mmio<'_, MyStruct> =3D mmio.try_cast()?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    #[inline]
> +    fn try_cast<U>(self) -> Result<<Self::Backend as =
IoBackend>::View<'a, U>>
> +    where
> +        Self::Target: FromBytes + IntoBytes,
> +        U: FromBytes + IntoBytes,
> +    {
> +        let view =3D self.as_view();
> +        let ptr =3D Self::Backend::as_ptr(view);
> +
> +        if size_of::<U>() > KnownSize::size(ptr) {
> +            return Err(EINVAL);
> +        }
> +
> +        if ptr.addr() % align_of::<U>() !=3D 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: We have checked bounds and alignment, so this is a =
valid projection.
> +        Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
> +    }
> +
>     /// Fallible 8-bit read with runtime bounds check.
>     #[inline(always)]
>     fn try_read8(self, offset: usize) -> Result<u8>
> @@ -979,3 +1038,72 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
> // MMIO regions on 64-bit systems also support 64-bit accesses.
> #[cfg(CONFIG_64BIT)]
> impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, =
writeq_relaxed);
> +
> +// This helper turns associated functions to methods so it can be =
invoked in macro.
> +// Used by `io_project!()` only.
> +#[doc(hidden)]
> +#[derive(Clone, Copy)]
> +pub struct ProjectHelper<T>(pub T);
> +
> +impl<'a, T> ProjectHelper<T>
> +where
> +    T: Io<'a, Backend: IoBackend<View<'a, T::Target> =3D T>>,
> +{
> +    // These helper methods must not have symbols present in the =
binary to avoid confusion.
> +    #[inline(always)]
> +    pub fn as_ptr(self) -> *mut T::Target {
> +        T::Backend::as_ptr(self.0)
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Same as `IoBackend::project_view`
> +    #[inline(always)]
> +    pub unsafe fn project_view<U: ?Sized + KnownSize>(
> +        self,
> +        ptr: *mut U,
> +    ) -> <T::Backend as IoBackend>::View<'a, U> {
> +        // SAFETY: Per safety requirement.
> +        unsafe { T::Backend::project_view::<T::Target, _>(self.0, =
ptr) }
> +    }
> +}
> +
> +/// Project an I/O type to a subview of it.
> +///
> +/// The syntax is of form `io_project!(io, proj)` where `io` is an =
expression to a type that
> +/// implements [`Io`] and `proj` is a [projection =
specification](kernel::ptr::project!).
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::io::{
> +///     io_project,
> +///     Mmio,
> +/// };
> +/// #[repr(C)]
> +/// struct MyStruct { field: u32, }
> +///
> +/// # fn test(mmio: Mmio<'_, [MyStruct]>) -> Result {
> +/// // let mmio: Mmio<[MyStruct]>;
> +/// let field: Mmio<'_, u32> =3D io_project!(mmio, [try: 1].field);
> +/// let whole: Mmio<'_, MyStruct> =3D io_project!(mmio, [try: 2]);
> +/// let nested: Mmio<'_, u32> =3D io_project!(whole, .field);
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +#[macro_export]
> +#[doc(hidden)]
> +macro_rules! io_project {
> +    ($io:expr, $($proj:tt)*) =3D> {{
> +        #[allow(unused)]
> +        use $crate::io::IoBase as _;
> +        let view =3D $crate::io::ProjectHelper($io.as_view());
> +        let ptr =3D $crate::ptr::project!(
> +            mut view.as_ptr(), $($proj)*
> +        );
> +        #[allow(unused_unsafe)]
> +        // SAFETY: `ptr` is a projection.
> +        unsafe { view.project_view(ptr) }
> +    }};
> +}
> +#[doc(inline)]
> +pub use crate::io_project;
>=20
> --=20
> 2.54.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

