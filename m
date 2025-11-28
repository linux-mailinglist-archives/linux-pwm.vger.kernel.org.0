Return-Path: <linux-pwm+bounces-7732-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F688C91FB4
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 13:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 462014E3878
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F36329374;
	Fri, 28 Nov 2025 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="G3BW2x9R"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582A30DEBC
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332709; cv=none; b=iLg/yOQVGMXF6pw9DYa4EEXBZhJxiFN4yjuvWKwaCV89IrpHSzWbbd9VRtQ3X4L2wwFNW7K45L5Gb9IdVBhX8zDYzRG2L031Fz0Z1/eoZ0ay435/iuNb7kuj5L4tMPVMACo5VTZ9oyl3Og0nrcv3NOFPPNfmyDsCwcOY5I0nrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332709; c=relaxed/simple;
	bh=Uy+CKLSmjfEonlIIdz7ylya5/5TSAc/WK9H2XEkj/dA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SGt1ciA9h+b2ijo6Ai+92KSdArjrQkvuVzSi7XIZr0x91jdlBj94OBvZObit09RaNcEAZhlS5q93gZHYtdOEyKdetzfZwEW2JCUW6trmMfWJhBp/lqAET1JsdE+OaIEQFt44pzEB4L8gOtEw1abHXHq7FLu9wChg0lChMjf415I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=G3BW2x9R; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 27C6F240107
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 13:25:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764332705; bh=ygIWY5afUFzvHpwhYDklQ/i75zkS+Wu119xSFraOeSM=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=G3BW2x9RGG0O1+QELbAPhvd5tLXbzhCMYEk9H90d9IbnKjn5o/spNFfJfJ/TsDGDH
	 jOFHR5UiUzcb28hF/N6YN118SL/+ltyT4Zu67aNMhO7K0ddiaSxGmR6yIf3rKBeXur
	 LrU0sO4NKHdZY9R8qouSdFYd94LMsly3W64uhIQtyBLTIXFjQr+HlFmJQPQ8xwMSYx
	 YpfIpYuJ6JpApbzJpF29pF1pW+A0E8v40jPhzcl3/JX05ZPq+74WDveWHZU6QWzASZ
	 yCUHhWsjCG+JTYYY0w9ccpb2+asUAhmS0YwkJp2F8IOroMqXm/PxIM06m6uNeUE3WM
	 syvRiCaOSgMwQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dHsv16jN3z6tn4;
	Fri, 28 Nov 2025 13:25:01 +0100 (CET)
Message-ID: <8711d40496e0e12e3efcd7fd9e11bdea6de68c6d.camel@posteo.de>
Subject: Re: [PATCH] Move pwm registration into pwm::Chip::new
From: Markus Probst <markus.probst@posteo.de>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei	
 <wefu@redhat.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich	 <dakr@kernel.org>,
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Fri, 28 Nov 2025 12:25:04 +0000
In-Reply-To: <aSlrVLT92kmazgyh@google.com>
References: <20251127-pwm_safe_register-v1-1-d22d0ed068ac@posteo.de>
	 <aSlrVLT92kmazgyh@google.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 66sLA9g==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-OiyZeEsFRz6+aj2Addkj"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-OiyZeEsFRz6+aj2Addkj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-11-28 at 09:28 +0000, Alice Ryhl wrote:
> On Thu, Nov 27, 2025 at 05:15:06PM +0000, Markus Probst wrote:
> > The `pwm::Registration::register` function provides no guarantee that t=
he
> > function isn't called twice with the same pwm chip, which is considered
> > unsafe.
> >=20
> > Add the code responsible for the registration into `pwm::Chip::new`. Th=
e
> > registration will happen before the driver gets access to the refcounte=
d
> > pwm chip and can therefore guarantee that the registration isn't called
> > twice on the same pwm chip.
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > ---
> > This patch provides the additional guarantee that the pwm chip doesn't
> > get registered twice.
> >=20
> > The following changes were made:
> > - change the visibility of `pwm::Registration` to private
> > - remove the `pwm::Registration::register` function
> > - add code for registering the pwm chip in `pwm::Chip::new`
> > - add Send + Sync bounds to `PwmOps`
> >=20
> > Note that I wasn't able to test this patch, due to the lack of hardware=
.
>=20
> Overall looks reasonable, but I have one question:
>=20
> > @@ -654,50 +668,23 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
> >  // structure's state is managed and synchronized by the kernel's devic=
e model
> >  // and PWM core locking mechanisms. Therefore, it is safe to move the =
`Chip`
> >  // wrapper (and the pointer it contains) across threads.
> > -unsafe impl<T: PwmOps + Send> Send for Chip<T> {}
> > +unsafe impl<T: PwmOps> Send for Chip<T> {}
> > =20
> >  // SAFETY: It is safe for multiple threads to have shared access (`&Ch=
ip`) because
> >  // the `Chip` data is immutable from the Rust side without holding the=
 appropriate
> >  // kernel locks, which the C core is responsible for. Any interior mut=
ability is
> >  // handled and synchronized by the C kernel code.
> > -unsafe impl<T: PwmOps + Sync> Sync for Chip<T> {}
> > +unsafe impl<T: PwmOps> Sync for Chip<T> {}
>=20
> Why was this changed?

Registration::register required PwmOps to be Send + Sync.
Prior to this change, Chip::new didn't require it for PwmOps. Meaning
it was possible to allocate a new Chip with a PwmOps that is not Send +
Sync. As there was no use for it and it isn't possible anymore to
allocate a new Chip without registering it, I added Send + Sync as
trait dependency (see 1. hunk of rust/kernel/pwm.rs in the patch).

Because PwmOps now implied Send + Sync, it wasn't necessary anymore to
have the additional bounds there.

Thanks
- Markus Probst

>=20
> Alice

--=-OiyZeEsFRz6+aj2Addkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmkplJkACgkQNHYf+Oet
Q9KJhQ//clYqiwDcWI4RaF0O+C3T96TqVmJsruXKfEMATKWDSFg5P8EJecH/Vgd8
Jdk5FN8xjMy/+ZCP7rW8AZCUOi5vrL8d8EJQNTS0EXuG04UUUIgUPwqNXX9LxdG4
2m4ZUqXN34HCxs2ojwN0irOogL9Bt0JlWwWDOm0fzvSEe1NCrtx4A7LOOUgdqplg
vjQbxdR5qJ+/0bgGFk42h+nstvz1s05vOHJrMFcPSlvapzCL72jhnR2f/a6/1rSd
VEZPuxp+K6VZ72YpFgG6SZDeRKgtKz8LSuKTSr11qXAL4UkKZXGpU9KSuD3eBLBD
ERYNZ0ovq/m7JSv8q7tBSzgX5bGyw0FHnLmuar2CmYh/WNZ5FqagfF75sLgYnoVU
+DFo3d26+O4V5QYGyu32iPEhpnoKMHvbm8EcLdjzepZ8tAgxX7f4daEPYJz1qyA0
wxTrNY2qE6DHJfDe9pBXqj2giLjCyEKjY1cLbM8gV9k4aDEHxFTvufclosRuptWN
n/IITBOMrdzD7cMnaZcs/6OBk+pQa1QDyqYMy4fqBVX3ZdhnkbzkDM6Owhd4oMuI
MQJE3IPzullpRwAr+/8rtuSqikDuEMgXdCHrjv8kD2qeeAkgoodkwV1tpG+bs6Qi
0vfjW+HbeawQw9wpFpiBb74tSzRpcf31cmi5ScevMCGHrQ6QYAw=
=oy2y
-----END PGP SIGNATURE-----

--=-OiyZeEsFRz6+aj2Addkj--

