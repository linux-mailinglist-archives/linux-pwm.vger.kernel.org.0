Return-Path: <linux-pwm+bounces-6174-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9827BAC7CE4
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C361C008B2
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7EA28EA70;
	Thu, 29 May 2025 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc3It4qA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226A28EA69;
	Thu, 29 May 2025 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517772; cv=none; b=NLZgNTIgO5XRbDIPidrQGzebv+7dii0fPHe4l4g52cuAYyuJuL4RdyWOo/LD3eFleFmn/oLUS4JCCotgjGzSG7A+VBzgKm6IQAiTz/ZJffg+eM46iJsaEBNbsorN9g8TxA31FoqLjY2JRltI5NLy+lPhx8ScKldG1v79B8gfMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517772; c=relaxed/simple;
	bh=dV/0sTKRb/rUIweWWF6haVE0P/cXtjrDmiNmJdFO6YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCyyKtKe6IMOlYQr2IogiX068YbPWq8FOi2bZaHPfGdfwkTXNpdJoD+ykPX7ZWW3ssFuFmoR9D+3E4i+4XymrYRg3egG3Alm2QMbamUtC3i4b+0PvOfhgnAiRdn5DWcCbMg4sp24RA0cL3ciWVy5ySx/Ul+v/1w+M3pvPwQpKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc3It4qA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3EAC4CEE7;
	Thu, 29 May 2025 11:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748517771;
	bh=dV/0sTKRb/rUIweWWF6haVE0P/cXtjrDmiNmJdFO6YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dc3It4qAFErG8zaqtNNMFIyKNhXsHwAGEtvPrUIKhSiDOgXLUTnliqgcIf+ulWeDx
	 FZFPyrxkI/ixqR0nVC1BqdEm0poRWiAA1Ko+LA/E0mrDCcAYORlKhu4/pqX1TYFKgK
	 bIfSqPUKiULm6L5HoWwX7c9YWZW3kibcmaoUq4m2v4xrQfHFqWBVIadj0wuGjDbBpi
	 AtIEE8lhtIDid0oQ/XC+RgmquZcVH6XbOlGFSDPXyH8LjbIaxSUXUOTVdrxLf/y2QY
	 9F2LH+V4GVS5uZFumAEjqNZpgjccCKv31D9X2O2gdwotlffSDz56b3t23vMoedTeCU
	 D3Q5ivPKDqDDA==
Date: Thu, 29 May 2025 13:22:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v15 0/5] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <jfql74ayb42fzmakpz4sfyr2mnv62srpzh3ut4tdmnmipwoboy@uxumfy5kq54j>
References: <20250529035341.51736-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t7jb6esylkpa6lhn"
Content-Disposition: inline
In-Reply-To: <20250529035341.51736-1-nylon.chen@sifive.com>


--t7jb6esylkpa6lhn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v15 0/5] Change PWM-controlled LED pin active mode and
 algorithm
MIME-Version: 1.0

Hello Nylon,

On Thu, May 29, 2025 at 11:53:38AM +0800, Nylon Chen wrote:
> According to the circuit diagram of User LEDs - RGB described in the
> manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf=
[1].
>=20
> The behavior of PWM is acitve-high.
>=20
> According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manual=
[2].
>=20
> The pwm algorithm is (PW) pulse active time  =3D (D) duty * (T) period.
> The `frac` variable is pulse "inactive" time so we need to invert it.
>=20
> So this patchset removes active-low in DTS and adds reverse logic to the =
driver.

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-nexxt

as 6.17-rc1 material. I pondered if this should go in earlier and/or
should get marked for stable. I'm unsure and willing to consider input
here. The problem I see is that while this is a fix, the change is a
breaking one and you need the dts change and the code change applied
either both or none.

Best regards
Uwe

--t7jb6esylkpa6lhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg4Q4QACgkQj4D7WH0S
/k5Lgwf/SP6TM6iinfR+nLxITKK64by0Ws8lMmVkyjSrhRXh82uC0AGWdbgwYdK/
PG/mYXTKZ5HCxZSKN6tLrwBlv7274OvSlMHKm5ECqfx2SfOVVonLNGPFPHqSio5T
fuxD5PyJyJfArppWLvZDc53PZLoXyRWVWMVIQTAz6xsbZSwg46HFKnKKW8gdi+pp
xGf62lktVUk42OfBKcs4naXobSACqiyG1BES/W+s5Z3o1rWghbdNCj3d/zNtLsUu
6kGM/uh5xmcM804K0N44LUGmfBFuVNyGepR75baQxSB//3OCrQ9X24M1QfEH8WC4
swfkxqbXkPf0v5zpt7Rq0afo+gNZ+w==
=nB9p
-----END PGP SIGNATURE-----

--t7jb6esylkpa6lhn--

