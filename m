Return-Path: <linux-pwm+bounces-6748-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94BAFAC43
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 08:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86105189C839
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jul 2025 06:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8607E27AC44;
	Mon,  7 Jul 2025 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1w+w4uu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48918FC80;
	Mon,  7 Jul 2025 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751871447; cv=none; b=X14T3TLIA/Blcv0ZTzVAocbYeC4NMLSX0oOPqrNAEj1MspSlJBBXNUwRTULlW7kYNNex6Q7MzZKqbOk0kelLSxRKpsgBkTpFaXF7PCjASxNSGdSwFkNj0l3kltvKciEIgraqzQuTH53Bi6fpjLZtygQURkZOwC/qI21cZXFmRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751871447; c=relaxed/simple;
	bh=ZMFouIdoe+6RcOPHeEsSglmRRWZz5oi5nySTLlOt42c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uI3Xag+ZNZZyFS0H7h4ZK8rIaxGUlUrxEuYiaOU1VObgO9DJ205PkJwdfVVop2knANnLSdXx4zHtBmOKx2A3elWgHpiukSkQeyUs+g9m3815IKWasPDyZX5/kAZ/ZBhP6s3Qx17xsXKawTLflJDShIdq+vA5wj7ZVEi5M9SaR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1w+w4uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD05C4CEF5;
	Mon,  7 Jul 2025 06:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751871446;
	bh=ZMFouIdoe+6RcOPHeEsSglmRRWZz5oi5nySTLlOt42c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1w+w4uutQXOcN/7UKG46xcY0YEwfYJm5FRZDBeIhqH4cgcku5auLJYBiXF4TVHlp
	 jN/2XezsjyK3QJUzG47US7YzVEQh14BvazekCPd1AI4Wh0VfdrWuGIDZV+kECJ3BoT
	 z4cSISkynAqXgk4atyTOnFvBd/a4lwXeZMwZaZ4xNg/TOnZUjYhF2D+l7rh2zlbIwc
	 PRyoq2s5GrCJ9W/g9tqjdq2AyRuJzHraaLfAvAWEaGzslRlbUsobpmy6RoyfRM66o7
	 hsZJ7oMJBVR6xQQdUpWVJHqK9oZ+EuT4W2l956kIIruAL0McFd6AWJWKkRUwc8Elyr
	 QST5GpsMWFw+w==
Date: Mon, 7 Jul 2025 08:57:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v9 2/6] rust: pwm: Add complete abstraction layer
Message-ID: <yxtnwax73wkliqkbq5736tswbxrblpwx4bn6z257tyd2xu23jx@y6k6iwdhmsgy>
References: <20250706-rust-next-pwm-working-fan-for-sending-v9-0-42b5ac2101c7@samsung.com>
 <CGME20250706114605eucas1p17d1cbd035d14d95f4ad0588c2572b3e2@eucas1p1.samsung.com>
 <20250706-rust-next-pwm-working-fan-for-sending-v9-2-42b5ac2101c7@samsung.com>
 <aGpqqGMTU3a3O8cn@pollux>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="il3m5sp7a2busx2h"
Content-Disposition: inline
In-Reply-To: <aGpqqGMTU3a3O8cn@pollux>


--il3m5sp7a2busx2h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 2/6] rust: pwm: Add complete abstraction layer
MIME-Version: 1.0

Hello Danilo,

On Sun, Jul 06, 2025 at 02:23:04PM +0200, Danilo Krummrich wrote:
> On Sun, Jul 06, 2025 at 01:45:13PM +0200, Michal Wilczynski wrote:
> > +    /// # Safety
> > +    ///
> > +    /// `dev` must be a valid pointer to a `bindings::device` embedded=
 within a
> > +    /// `bindings::pwm_chip`. This function is called by the device co=
re when the
> > +    /// last reference to the device is dropped.
> > +    unsafe extern "C" fn release_callback(dev: *mut bindings::device) {
> > +        // SAFETY: The function's contract guarantees that `dev` point=
s to a `device`
> > +        // field embedded within a valid `pwm_chip`. `container_of!` c=
an therefore
> > +        // safely calculate the address of the containing struct.
> > +        let c_chip_ptr =3D unsafe { container_of!(dev, bindings::pwm_c=
hip, dev) };
> > +
> > +        // SAFETY: `c_chip_ptr` is a valid pointer to a `pwm_chip` as =
established
> > +        // above. Calling this FFI function is safe.
> > +        let drvdata_ptr =3D unsafe { bindings::pwmchip_get_drvdata(c_c=
hip_ptr) };
> > +
> > +        if !drvdata_ptr.is_null() {
>=20
> Is this check needed? I think one can't create a pwm::Chip instance witho=
ut
> providing a T, so this pointer can't be NULL I think.

There are currently a few C drivers, that don't use a private data
struct that is managed by the pwmchip. One of them doesn't make use of
the pwmchip's drvdata at all. The latter is drivers/pwm/pwm-twl-led.c.

Best regards
Uwe

--il3m5sp7a2busx2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhrb9EACgkQj4D7WH0S
/k73WQgAtGaf05GK6mp6VId6WGdPMpI5HvMe59Y9FzSAgjuK2ocbufXwhIeC4B2Z
iKbYy6iSEiKnvxwgtSZBx4g7t9ple3Tn36phcBKy+dJ0RwpiIVXydM5F8LqT0wwG
FLSCJ70vlb2c6Ot2qkfNHRxG8UcHmx/Jj4irYFivjUc2tify4Y+k4L9eZXR6JPXs
rEIhqFdncvPn86sx0voin34rS+UwAilvxxLgxB1zLgxjlzdbUB0Ggfng+4PcQVHf
6FX8qctUfqKFio4Zq6EkTEMNhc91Gx5VENyuzRzhuOYYM2huuOn71N+TdxiUPc7q
nG3/xHL2aZvxO+P+HHLYxapSy+M34w==
=lM1B
-----END PGP SIGNATURE-----

--il3m5sp7a2busx2h--

