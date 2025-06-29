Return-Path: <linux-pwm+bounces-6568-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CF5AECBE3
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Jun 2025 11:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65283A8438
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Jun 2025 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48425204096;
	Sun, 29 Jun 2025 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4kbqwkD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8327263B;
	Sun, 29 Jun 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751188127; cv=none; b=ditRX+a+FyaQ/RQkAKdtxSZm5ezh5Bi4Ap5Aa7G5MCxpVDLz2Z8zDSX2nPYKsICl2laDTIlPXub7FrkTYSrgSECs/BmjWJZpIVd/T/ynMSMQ1GMU9YAixgIXGor15rNt92GWqJmWrSJwtucKBVWyWmILno73ILXrnlyWo4zmhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751188127; c=relaxed/simple;
	bh=VsqYT+LBwb0rmI3PvXGZAQQ4CA/ISgMwiSBJCr3gTBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es4oLwWqPisXp5S2La5zOb1lOaqv6s4SABAYcNQZoRBd1xKTdMXl8yZjzqaAcek8YQk3GKdUBm8AWXr22HWebJ0rtl8GFf3IEICtceL+xsoVrxgPfbkwjuvkNw61Bns6O8D0Y0jf2qvLoturSVkekgQk6ChzZPQKgNPaEe4tCk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4kbqwkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88ECC4CEEB;
	Sun, 29 Jun 2025 09:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751188126;
	bh=VsqYT+LBwb0rmI3PvXGZAQQ4CA/ISgMwiSBJCr3gTBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F4kbqwkDpirVxTs2vJKh7WffFed9zOrqDh/dd/X5i1R+ZCMGb9MR8LGW/80IW0nLj
	 +74Xv8WP3OpJw88MWD6NmyLNF93uK6MiZB2ICEgxNYlhsolHdDQpGRUfaw2HhLNv+t
	 7G1PD3GULd4JPKGWxlG0rqv36AwuZSeIebLKJBAbmRP+tcE85NWrErsKlkQvzlZeua
	 X7FJx8xEZmIyQVILp1R4kTeTCSO7GDpJI7a+Cf3+hnpedfIAP9gmSY6789kn2c0BKP
	 arAsdoFnmpBMNkOB5b53JFUTd2taMidyak8Cr5mOALJMszzO5H/dLLObjGUHgf75e5
	 x/ITWYCvgeOXw==
Date: Sun, 29 Jun 2025 11:08:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 4/9] pwm: Add Rust driver for T-HEAD TH1520 SoC
Message-ID: <i2rewsouxhtbomkfd7gyxpvrxi4f6tu26visny25qilhhttcft@ufqv4p3bwcjv>
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
 <CGME20250623180902eucas1p2960477c0a44f05e991747312b0ae0ff0@eucas1p2.samsung.com>
 <20250623-rust-next-pwm-working-fan-for-sending-v5-4-0ca23747c23e@samsung.com>
 <aot4ow37qsrehgce6vpc5m7ha5w6h4jvj7k7bokn4eo63sjk5x@iyp5ir234kx5>
 <21504282-18d1-4165-a1bc-ec4cbbb19c2b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zne6uyqf6w4firk4"
Content-Disposition: inline
In-Reply-To: <21504282-18d1-4165-a1bc-ec4cbbb19c2b@samsung.com>


--zne6uyqf6w4firk4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 4/9] pwm: Add Rust driver for T-HEAD TH1520 SoC
MIME-Version: 1.0

Hello Michal,

On Sat, Jun 28, 2025 at 08:14:59PM +0200, Michal Wilczynski wrote:
> On 6/27/25 17:28, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jun 23, 2025 at 08:08:52PM +0200, Michal Wilczynski wrote:
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index cfddeae0eab3523f04f361fb41ccd1345c0c937b..a675b3bd68392d1b05a47a=
2a1390c5606647ca15 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -719,6 +719,16 @@ config PWM_TEGRA
> >>  	  To compile this driver as a module, choose M here: the module
> >>  	  will be called pwm-tegra.
> >> =20
> >> +config PWM_TH1520
> >> +	tristate "TH1520 PWM support"
> >> +	depends on RUST_PWM_ABSTRACTIONS
> >=20
> > RUST_PWM_ABSTRACTIONS is user selectable. Is that sensible. From a
> > user's POV it shouldn't matter if the driver is written in Rust or not.
>=20
> You make an excellent point about user experience. My initial thought
> was to follow the depends on pattern that I saw in other Rust drivers.
>=20
> I can see how using select would be cleaner for the end user. My only
> hesitation was that it differs from the current convention for Rust
> drivers, and I wanted to be careful about changing an established
> pattern.
>=20
> If you are comfortable with setting this direction for the PWM
> subsystem, I am happy to make the change to use select
> RUST_PWM_ABSTRACTIONS (gated by depends on RUST). Please let me know.

Sounds good.

> >> +const TH1520_PWM_REG_SIZE: usize =3D 0xB0;
> >> +
> >> +fn ns_to_cycles(ns: u64, rate_hz: u64) -> u64 {
> >> +    const NSEC_PER_SEC_U64: u64 =3D time::NSEC_PER_SEC as u64;
> >> +
> >> +    match ns.checked_mul(rate_hz) {
> >> +        Some(product) =3D> product / NSEC_PER_SEC_U64,
> >> +        None =3D> u64::MAX,
> >> +    }
> >=20
> > The semantic here is: If ns * rate_hz overflows, return U64_MAX, else ns
> > * rate_hz / NSEC_PER_SEC, right?
> >=20
> > If you cannot easily reproduce what mul_u64_u64_div_u64() does, I think
> > it would be more prudent do make this:
> >=20
> > 	match ns.checked_mul(rate_hz) {
> > 	    Some(product) =3D> product,
> > 	    None =3D> u64::MAX,
> > 	} / NSEC_PER_SEC_U64
>=20
> Thank you for the feedback on the calculation. I analyzed the two
> approaches and found that on overflow, my version saturates to u64::MAX,
> while the suggested version would result in u64::MAX / NSEC_PER_SEC. I
> believe my original implementation's saturation behavior is more
> predictable. With this in mind, would you be comfortable with me
> retaining the original implementation?

I'm convinced that my alternative is better. Consider the implemented
mapping: Assuming rate_hz =3D 160000000 you have:

	      ns     |       cycles
	-------------+---------------------
	 ...         |
	115292150452 |          18446744072
	115292150453 |          18446744072
	115292150454 |          18446744072
	115292150455 |          18446744072
	115292150456 |          18446744072
	115292150457 |          18446744073
	115292150458 |          18446744073
	115292150459 |          18446744073
	115292150460 |          18446744073
	115292150461 | 18446744073709551615
	115292150462 | 18446744073709551615
	 ...

that's strange, isn't it?

> >> +            wf.duty_length_ns =3D cycles_to_ns(original_duty_cycles, =
rate_hz);
> >> +            // We can't recover the original non-zero offset, so we j=
ust set it
> >> +            // to a representative non-zero value.
> >> +            wf.duty_offset_ns =3D 1;
> >=20
> > For an inversed polarity signal the duty_offset is polarity - duty_cycl=
e.
>=20
> I believe there was a typo in your suggestion and you meant period
> instead of polarity.

ack.

> Based on that, my understanding is that for an
> inverted signal, the generic pwm_waveform struct expects duty_offset_ns
> to represent the duration of the initial low time, while duty_length_ns
> represents the high time.

right.

> so the code would look like this:
> // For an inverted signal, `duty_length_ns` is the high time (period - lo=
w_time).
> wf.duty_length_ns =3D cycles_to_ns(original_duty_cycles, rate_hz);
> // The offset is the initial low time, which is what the hardware registe=
r provides.
> wf.duty_offset_ns =3D cycles_to_ns(duty_cycles, rate_hz);

Looks correct

Best regards
Uwe

--zne6uyqf6w4firk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhhApYACgkQj4D7WH0S
/k5+Egf9EOzTF4z/r/D9Hyp//XvOQjamYBI1WYsS7Fdu17jstTst7ySTReSmPC4n
RgHIFJ2E9iyVCQg9zJYhjoQwiymMY+aWvFC4ETRl8+Ym89QF6Nj939dCqTlT2eki
YGedvygxJRkwGjjlDOdnRVzn7UwUqSDRG9xJ7fAmW1tEdwFtCzAmTuNDSYoKeFMK
C1coZH5dOQUeYdQcs+7auFpyKgMNPhauFQj/Wg22ccLXXabvJk+uw4HoqE4wJaf8
MF2p05YYQyV6J9VugpvU8Mg81lhH206bW+qn8ElE5Jh7/VWvAUHziIn+cFLGyoJz
hfD+nuoobHVKZfk+YsSla6wrKJ7qjw==
=XfKM
-----END PGP SIGNATURE-----

--zne6uyqf6w4firk4--

