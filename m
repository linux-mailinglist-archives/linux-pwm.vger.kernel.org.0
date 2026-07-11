Return-Path: <linux-pwm+bounces-9691-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kq+lHTCjUWr1GwMAu9opvQ
	(envelope-from <linux-pwm+bounces-9691-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 03:58:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809E73FF7E
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 03:58:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=collabora.com header.s=zohomail header.b="k4zEEJ/I";
	dmarc=pass (policy=none) header.from=collabora.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9691-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9691-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CE4F3009F17
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Jul 2026 01:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F9D2DF15C;
	Sat, 11 Jul 2026 01:58:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1D3770B;
	Sat, 11 Jul 2026 01:58:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783735082; cv=pass; b=WX0aKDdE9lvkqb0pf2OS2JbPCdHqYiJEZtYimXZUMQjy/Xtr5Ce4D95UfK5R15FWn9i9z7YHMTs9oRioXQoohxQ/fPDkDfQMvbqolVIEV/Pqq0QGJYSOnpKjcTPWmx6sXb5KQJ/09p3euvobI+8g+CnB0mQR9cCNAlVMvkuGi9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783735082; c=relaxed/simple;
	bh=+fJ3baaZErmKXU1eoaI+9gJvw8WBmeoLVjJqc6R7Bh8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J61gySC8qTDjXTLktoN2MSgamkmAsWBG3vQGO/y/lJ6SrOz92tU0AWknXn+xE4y6FOm+8w6i6mM/86L75vnSJSnNEdVpmWiVV4377NbK5q1kWOIeUxdexcbF1urm0doMLNwqCnkTurWawGj+czBfEcl7rTwOuqyCc1TMLne2GOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=k4zEEJ/I; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal: i=1; a=rsa-sha256; t=1783735041; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YOOXsfWNurUB7U6xaTiLZN2mdbXZ6J7cxNrFmFPPvaQUF5og/+/OxV31HD5GdxpQYvNXBXZx4Efgoyh4D77eX/FOA4ssZUksQTJPPQ52gxJ92lWti691BQ+b96oUBtZBFy8BwK/U5i7EQ/I7PrtSY0KlkSVVlmRUft8BqrjLw50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783735041; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a3swyPTykbuD+CwqZCknMVLw1USPNnXvjXdGLga/u/8=; 
	b=XctaSMeg28CHEj9Me6/xGVG6QXL8T6g+sGyTcdIeWP1hCKwMIKerzdEDoo9kwBIXIYPucDZoIzn0Q4XCrPjT3b80D7F+DdbdFQEn2QHSd1mdXAx7sfl3Sr/4RoIGbjOvuGk+2NIhHHOAGpaazDKkxcJ/0EbuezUZSCqZfjKKqGA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783735041;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=a3swyPTykbuD+CwqZCknMVLw1USPNnXvjXdGLga/u/8=;
	b=k4zEEJ/IwKT0fkBVSqVH69yP5lFTtbQolmmH/7VSP3YcVqYDKv5jFPklMr/jtrko
	C73mXfJJn1tGi4T53bxKbK80MQKBqKm1Grw8qGA+bHWdbPJpzONOT8arCqfOgB9I5c8
	PvLsocRoJB1gRZIhAZoQeSt05nnqBDWnT0br3xfw=
Received: by mx.zohomail.com with SMTPS id 1783735040661684.9698758517445;
	Fri, 10 Jul 2026 18:57:20 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 16/20] rust: io: add `read_val` and `write_val`
 functions on `Io`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-16-72cd5d055d54@garyguo.net>
Date: Fri, 10 Jul 2026 22:56:59 -0300
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
Message-Id: <5D0DCE0B-2F9D-4B12-9C1E-3FB6EC61129A@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-16-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9691-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6809E73FF7E



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Provide `read_val` and `write_val` that allow I/O views to be accessed =
when
> they're narrowed down to just views of primitives.
>=20
> This is used to provide `io_read!` and `io_write!` macros, which are
> generalized version of current `dma_read!` and `dma_write!` macro that =
work
> for all types that implement `Io`.
>=20
> Note though `io_read!` and `io_write!` only works if backend =
implements
> `IoCapable` for the type; which is typically only implemented for
> atomically accessible primitives. `dma_read!` and `dma_write!` =
currently
> supports them via `read_volatile` and `write_volatile`; this can be
> undesirable for aggregates as LLVM may turn them to multiple =
instructions
> to access parts and re-assemble, even if they could be combined to a =
single
> instruction. Thus, `io_read!()` and `io_write!()` does not fully =
replace
> `dma_read!()` and `dma_write!()` in this scenario. The ability to
> read/write aggregates (when atomicity is of no concern) is better =
served
> with copying primitives (e.g. memcpy_{from,to}io).
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> rust/kernel/io.rs | 106 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 106 insertions(+)
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 78c6ae2a0db8..c423125870b7 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -398,6 +398,50 @@ fn try_cast<U>(self) -> Result<<Self::Backend as =
IoBackend>::View<'a, U>>
>         Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
>     }
>=20
> +    /// Read a value from I/O.
> +    ///
> +    /// This only works for primitives supported by the I/O backend.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_read_val(mmio: Mmio<'_, u32>) {
> +    /// // let mmio: Mmio<'_, u32>;
> +    /// let val: u32 =3D mmio.read_val();
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn read_val(self) -> Self::Target
> +    where
> +        Self::Backend: IoCapable<Self::Target>,
> +        Self::Target: Sized,
> +    {
> +        Self::Backend::io_read(self.as_view())
> +    }
> +
> +    /// Write a value to I/O.
> +    ///
> +    /// This only works for primitives supported by the I/O backend.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_write_val(mmio: Mmio<'_, u32>) {
> +    /// // let mmio: Mmio<'_, u32>;
> +    /// mmio.write_val(1u32);
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn write_val(self, value: Self::Target)
> +    where
> +        Self::Backend: IoCapable<Self::Target>,
> +        Self::Target: Sized,
> +    {
> +        Self::Backend::io_write(self.as_view(), value)
> +    }
> +
>     /// Fallible 8-bit read with runtime bounds check.
>     #[inline(always)]
>     fn try_read8(self, offset: usize) -> Result<u8>
> @@ -1229,3 +1273,65 @@ macro_rules! io_project {
> }
> #[doc(inline)]
> pub use crate::io_project;
> +
> +/// Read from I/O memory.
> +///
> +/// The syntax is of form `io_read!(io, proj)` where `io` is an =
expression to a type that
> +/// implements [`Io`] and `proj` is a [projection =
specification](kernel::ptr::project!).
> +///
> +/// # Examples
> +///
> +/// ```
> +/// #[repr(C)]
> +/// struct MyStruct { field: u32, }
> +///
> +/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
> +/// // let mmio: Mmio<'_, [MyStruct]>;
> +/// let field: u32 =3D kernel::io::io_read!(mmio, [try: 2].field);
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +#[macro_export]
> +#[doc(hidden)]
> +macro_rules! io_read {
> +    ($io:expr, $($proj:tt)*) =3D> {
> +        $crate::io::Io::read_val($crate::io_project!($io, $($proj)*))
> +    };
> +}
> +#[doc(inline)]
> +pub use crate::io_read;
> +
> +/// Writes to I/O memory.
> +///
> +/// The syntax is of form `io_write!(io, proj, val)` where `io` is an =
expression to a type that
> +/// implements [`Io`] and `proj` is a [projection =
specification](kernel::ptr::project!),
> +/// and `val` is the value to be written to the projected location.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// #[repr(C)]
> +/// struct MyStruct { field: u32, }
> +///
> +/// # fn test(mmio: kernel::io::Mmio<'_, [MyStruct]>) -> Result {
> +/// // let mmio: Mmio<'_, [MyStruct]>;
> +/// kernel::io::io_write!(mmio, [try: 2].field, 10);
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +#[macro_export]
> +#[doc(hidden)]
> +macro_rules! io_write {
> +    (@parse [$io:expr] [$($proj:tt)*] [, $val:expr]) =3D> {
> +        $crate::io::Io::write_val($crate::io_project!($io, =
$($proj)*), $val)
> +    };
> +    (@parse [$io:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) =3D> =
{
> +        $crate::io_write!(@parse [$io] [$($proj)* .$field] =
[$($rest)*])
> +    };
> +    (@parse [$io:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] =
$($rest:tt)*]) =3D> {
> +        $crate::io_write!(@parse [$io] [$($proj)* [$flavor: $index]] =
[$($rest)*])
> +    };
> +    ($io:expr, $($rest:tt)*) =3D> {
> +        $crate::io_write!(@parse [$io] [] [$($rest)*])
> +    };
> +}
> +#[doc(inline)]
> +pub use crate::io_write;
>=20
> --=20
> 2.54.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


