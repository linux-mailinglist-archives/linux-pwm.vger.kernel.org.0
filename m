Return-Path: <linux-pwm+bounces-6813-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D216B00694
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 17:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F7E3AB692
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E50C274670;
	Thu, 10 Jul 2025 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbNzlHFk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9062741A4;
	Thu, 10 Jul 2025 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161138; cv=none; b=lJyM1L7x5kqByMD5+dgTysGfA7KBQNIx70afqyb1nJw8m+kN00h+d8uU61lEon+naBxV2DEfY3Jx/QpU+Bd4ZD2gmS3JH9wHImkQw0HVyCBw3y9Kth/rmotJxw7C2IBTdqvVbjBP/YEWa4O5LOZHPAbINP8R7F1zAQ7vlXOHkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161138; c=relaxed/simple;
	bh=D08Lkk2/aUoWyaOxgce4WKYWUMnpW+kGZF62H6dE1og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrRGVMfmQvtBYLU9laVjWedpwFOxRu3A95esBd+KyInBHD2IoJkbTGB1e/dr8xa5kc8jq46cZUgjeqprFqbX4fgd1lncfBTh1pKt8OXm3/vUWSM+HsMQKd/mvGWz5JvRCK/e3+eUjAQY3GCuoPQjvOikluWfbuCdxIoxzKBzQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbNzlHFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E056C4CEE3;
	Thu, 10 Jul 2025 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752161135;
	bh=D08Lkk2/aUoWyaOxgce4WKYWUMnpW+kGZF62H6dE1og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbNzlHFkSHr2wwFrXT/oCFx04FFufvhMd+QHP2p9Tx88ZCipeqOLTY2JWx5SfjmF3
	 MAbaQK3u8fOzh5ZP6zT7KW8kjYadwCBNwALnVO/sN9ogjx74dqO4K5W+TOckaIOpB+
	 gXyJUfoDLh9OeDZnIKiDYZXaI6uH85CQlP2kDUcpg6OIijpWE4+QS++x2pJRb3SzrK
	 lG92meFv/whim9PpfXhf5IvlGcaSHDGi6c7j2IfOkK+Gq+9OZdrUS8X0+1/ueXRSof
	 fsaEghgHMNELqGuwl6KfTWW+9lsKBXHKvuq/VaqMdadl+LoH74u8cV7q3QxXmrJl0z
	 LF5h4KD7AbImw==
Date: Thu, 10 Jul 2025 17:25:33 +0200
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
Message-ID: <4hmb3di5x2iei43nmrykrj5wzlltrf3vrnqvexiablonbscn57@4bbsz5c76t63>
References: <CGME20250707094926eucas1p155bd967b6986c4a999776839b1aa1fc6@eucas1p1.samsung.com>
 <20250707-rust-next-pwm-working-fan-for-sending-v10-0-d0c5cf342004@samsung.com>
 <e8a4a821-e7e4-4bcd-a2ac-f6b684b6ceea@samsung.com>
 <ipvaegqlkco5qinhvn33mqvg7ev2walvs74xtzvhimxsfsfzhv@gcmpxcdtetdn>
 <e77eab1c-446f-4620-95be-d343684d1e95@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vsmmyrmvbcyclmm4"
Content-Disposition: inline
In-Reply-To: <e77eab1c-446f-4620-95be-d343684d1e95@samsung.com>


--vsmmyrmvbcyclmm4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
MIME-Version: 1.0

Hello Michal,

On Thu, Jul 10, 2025 at 03:48:08PM +0200, Michal Wilczynski wrote:
> On 7/10/25 15:10, Uwe Kleine-K=F6nig wrote:
> > On Thu, Jul 10, 2025 at 10:42:07AM +0200, Michal Wilczynski wrote:
> >> On 7/7/25 11:48, Michal Wilczynski wrote:
> >>> The series is structured as follows:
> >>>  - Expose static function pwmchip_release.
> >=20
> > Is this really necessary? I didn't try to understand the requirements
> > yet, but I wonder about that. If you get the pwmchip from
> > __pwmchip_add() the right thing to do to release it is to call
> > pwmchip_remove(). Feels like a layer violation.
>=20
> It's required to prevent a memory leak in a specific, critical failure
> scenario. The sequence of events is as follows:
>=20
>     pwm::Chip::new() succeeds, allocating both the C struct pwm_chip and
>     the Rust drvdata.
>=20
>     pwm::Registration::register() (which calls pwmchip_add()) fails for
>     some reason.

If you called pwmchip_alloc() but not yet pwmchip_add(), the right
function to call for cleanup is pwmchip_put().

>     The ARef<Chip> returned by new() is dropped, its reference count
>     goes to zero, and our custom release_callback is called.
>=20
> [...]
> >>> ---
> >>> base-commit: 47753b5a1696283930a78aae79b29371f96f5bca
> >=20
> > I have problems applying this series and don't have this base commit in
> > my repo.
>=20
> Sorry for the confusion. Base commit doesn't exist in the mainline
> kernel or linux-next, cause I've added some dependecies for compilation,
> like IoMem for the driver (uploaded full branch on github [1]). The
> bindings however doesn't depend on anything that's not in linux-next.

The series didn't apply to my pwm/for-next branch.

Note that the base-commit should always be a publically known commit.
See the chapter about "Base Tree Information" in git-format-patch(1).

Best regards
Uwe

--vsmmyrmvbcyclmm4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhv22oACgkQj4D7WH0S
/k7FGwf/cqRWrlLanx6ioFRjOHNq0dg1uOzf9q5rmP+qdZZDUVpurU+JPbrTIyng
NkftG4puPCrcs4b7Xkn7KS1bA302jmVka4SChzfg17kxpi/b5EofhGVr/ugZawtg
bKQGDuRQTkzwXfaqAa178a7PccvyzXUL40H7MREmLIjeeo2Qvh5lMUj7NcHWjfkJ
JtfCpq5VKkYyyxgD/M7n/0210G3ukwej2RhdWjkAwW1u09RCYBg13oy8fmtTAJkO
+/T/7BXuRxhQDBXKM7SwRySTqcH/CkvS6xXVBT5QZya3KSNbfQM9OV3moE0GzB2u
OabPXlh8CQ3Pwo1DFGc6g/7ZY9+Iag==
=KUxs
-----END PGP SIGNATURE-----

--vsmmyrmvbcyclmm4--

