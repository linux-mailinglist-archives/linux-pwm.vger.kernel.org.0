Return-Path: <linux-pwm+bounces-6809-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5105CB002F1
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 15:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5991E1C409C6
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 13:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D77428725D;
	Thu, 10 Jul 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkJqyRRG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6291DC9A3;
	Thu, 10 Jul 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153022; cv=none; b=Lozv5VMh4ZblN/qwWb+3DO6ED8wvvMiqZUKUjbZCdNpL5zAX5PgdxBwtP4X/QNQho0NQ4gjnwNqyp5pQXzjXIjTJYXeDYkYJUUVqS3sbYdhv9XHUkl6jl6r8ESe++8KoYObYkR6S+jFxGZySNOlaQQ90ffad8+hG1oMsL6eEfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153022; c=relaxed/simple;
	bh=T1QGcJNxK8BZy6hZ2D7Y/4Oab0tcD0n7rSuwkJBzXAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jR8JghonA9s8m0TktoZfcSrOOGzehGP3pS4T34Hmtdzr1hz+dzlnP1s1gRAvEz1f1VlUPgrwXvaYo+m2Z8rknZ64wFBTDpJjbLltlIesCy63UV1sdXyLthu4TZh9i4jv6NiLrwD3Z5rfmjUnNImJybtAAf385Wqaqb2a20cH6+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkJqyRRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD26C4CEE3;
	Thu, 10 Jul 2025 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752153022;
	bh=T1QGcJNxK8BZy6hZ2D7Y/4Oab0tcD0n7rSuwkJBzXAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FkJqyRRGBxuQi3JPKE7F07FeaVGgq/Qr4W2vFhQRw++dMOWbvgCEpS9ha9+oW4L1/
	 fqKoPBhLJIir6y9N14kKMzNcoZjFxCXHcjv1hAYl3NG/WC8D2cyRVrkFOM8+Bv/Uvy
	 r5I916QCGEOtXBhXnkBn1trmBAdJVvxI2lSReffjcjnSya4COhwK12gngoG3/zzwtH
	 ddszCdQGYibdS0CnOdT9i2eRNFU3ZLCmCC2I1vSVMtHQgTKFGdaT+etu+ZXG7Ll4RW
	 0dyA8HCuPH2bvKvvOhm4745UaM7qmI//Z7MSYc8OeGbNI18ayQeJU0aC8wR96rfAmE
	 emVc/E9zVMfsQ==
Date: Thu, 10 Jul 2025 15:10:19 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Benno Lossin <lossin@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <ipvaegqlkco5qinhvn33mqvg7ev2walvs74xtzvhimxsfsfzhv@gcmpxcdtetdn>
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com>
 <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
 <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kx6t7rsvihyfkddm"
Content-Disposition: inline
In-Reply-To: <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>


--kx6t7rsvihyfkddm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
MIME-Version: 1.0

Hello,

On Thu, Jul 10, 2025 at 10:42:07AM +0200, Michal Wilczynski wrote:
> On 7/7/25 11:48, Michal Wilczynski wrote:
> > This patch series introduces Rust support for the T-HEAD TH1520 PWM
> > controller and demonstrates its use for fan control on the Sipeed Lichee
> > Pi 4A board.
> >=20
> > The primary goal of this patch series is to introduce a basic set of
> > Rust abstractions for the Linux PWM subsystem. As a first user and
> > practical demonstration of these abstractions, the series also provides
> > a functional PWM driver for the T-HEAD TH1520 SoC. This allows control
> > of its PWM channels and ultimately enables temperature controlled fan
> > support for the Lichee Pi 4A board. This work aims to explore the use of
> > Rust for PWM drivers and lay a foundation for potential future
> > Rust based PWM drivers.
> >=20
> > The core of this series is a new rust/kernel/pwm.rs module that provides
> > abstractions for writing PWM chip provider drivers in Rust. This has
> > been significantly reworked from v1 based on extensive feedback. The key
> > features of the new abstraction layer include:
> >=20
> >  - Ownership and Lifetime Management: The pwm::Chip wrapper is managed
> >    by ARef, correctly tying its lifetime to its embedded struct device
> >    reference counter. Chip registration is handled by a pwm::Registrati=
on
> >    RAII guard, which guarantees that pwmchip_add is always paired with
> >    pwmchip_remove, preventing resource leaks.
> >=20
> >  - Modern and Safe API: The PwmOps trait is now based on the modern
> >    waveform API (round_waveform_tohw, write_waveform, etc.) as recommen=
ded
> >    by the subsystem maintainer. It is generic over a driver's
> >    hardware specific data structure, moving all unsafe serialization lo=
gic
> >    into the abstraction layer and allowing drivers to be written in 100%
> >    safe Rust.
> >=20
> >  - Ergonomics: The API provides safe, idiomatic wrappers for other PWM
> >    types (State, Args, Device, etc.) and uses standard kernel error
> >    handling patterns.
> >=20
> > The series is structured as follows:
> >  - Expose static function pwmchip_release.

Is this really necessary? I didn't try to understand the requirements
yet, but I wonder about that. If you get the pwmchip from
__pwmchip_add() the right thing to do to release it is to call
pwmchip_remove(). Feels like a layer violation.

> [...]
> > ---
> > base-commit: 47753b5a1696283930a78aae79b29371f96f5bca

I have problems applying this series and don't have this base commit in
my repo.

Best regards
Uwe

--kx6t7rsvihyfkddm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhvu7gACgkQj4D7WH0S
/k6idAf7BH2gWVLF3hF8BnmdLYBZ0+8XBxqy4lGLYsGxaqfaca8W4jQVBO9vRFvr
Gyd4nJKC4VbtGYMMl643mIztR/mZg8848mNa9W1JoRdr188lvhES1WaDf8etUqgZ
+b4rnTHlafykGwVNr8tmC/OAA+TenvcE+mEw1fHvLVhRG13MEYzzj/+hHGud3sYO
D360+gcZxxWnPiKIU8xZV+NafY9H0iZfDqpq2ejV+qL5oCrDomxA3D658TyhZM0e
+w3pnzIFFw0r7JBKPEAbj5tf38KFITQmARETPEaqBuztkqUy29aNCGUr1cvF0qob
YxK1jPaHLcpSpzHpMwRdPK72MxyrOw==
=OJd8
-----END PGP SIGNATURE-----

--kx6t7rsvihyfkddm--

