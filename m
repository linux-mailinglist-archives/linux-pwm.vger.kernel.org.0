Return-Path: <linux-pwm+bounces-4523-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAC19FD1FC
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 09:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531F43A06A4
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE671552E4;
	Fri, 27 Dec 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1l+gTFH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE16154C07;
	Fri, 27 Dec 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735288282; cv=none; b=K6Q9Rd9v0o3LlBOZPBUHIxLMFQ09HLtlzqvE4+tdWNPSnonkhLV7oFYAOblwhFCbmrYNvFey7ZWgUdEPIwAbI9+q9l+Kozh6H/ZzHF8zOYnsd2qMCw9d9lJybsWRVO89S6X/w+4oy2T8EfWaoQ6gpUcLoqY1h6nIp2uqz9mq2a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735288282; c=relaxed/simple;
	bh=t6i9LsXrCNZdkn0JqXrHROkhocyHz9nVVmksqSxkRyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr37m2Q/CpBT2VkR/cHht4wxtFo6AgCLPdRwVYlMHE0r/RvcPPYCZE569ACtGASuK57b09N/CCae8pAMHVBDiMZ/xH8Iwo94Vgtvsqm5Q0VbmuN2CrHWTpufXM7sfO3XEeIdDZHfFXliJDrz6VHrdm66udrNxpoyww9p5Fu6KDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1l+gTFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4864DC4AF09;
	Fri, 27 Dec 2024 08:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735288279;
	bh=t6i9LsXrCNZdkn0JqXrHROkhocyHz9nVVmksqSxkRyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1l+gTFHXyfRw1KcF/IE90IITO7MP6jj95xejl/xLPEOq1Tpo0EAfBZkB7TI0xNYJ
	 9ZiFCnw+WAddEuErtdO0NqeMZFwYtUKKb7yz/oq6zDISGchbVdYP1sqKCAip2CWSIu
	 0fNVJemOxubW9sK0y3ZaQWx86mo6IASZ0cT/gwrdg1p2wYS6n6tniKkkqrWmIwRkNa
	 GpH27sgdIF7taEP3+ZmNQgrFkxeM+DI7dwW3OIwaIe92/1L+dP/xrUVVe3CjMeuA/o
	 c3X9ach43dVXAZdqfeT/LhJDP8cbK0O/ezlX2XCOW68QhWNJvAWzZcngclN+9wXmrE
	 Js3TwfnWnokrA==
Date: Fri, 27 Dec 2024 09:31:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kever Yang <kever.yang@rock-chips.com>, heiko@sntech.de, 
	linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
Message-ID: <jjz7dk3rr3sruyks6yduwo37fcxqcut3vuqax2m43nvipnqdsu@zxzbddrlzk6j>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-12-kever.yang@rock-chips.com>
 <c3r3ezqr6sg7vtvomngjchzlk6btyzrjtukezjvuqxesqbtrh5@cmlu3bw7dyzl>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lmyousutwch2mlvv"
Content-Disposition: inline
In-Reply-To: <c3r3ezqr6sg7vtvomngjchzlk6btyzrjtukezjvuqxesqbtrh5@cmlu3bw7dyzl>


--lmyousutwch2mlvv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
MIME-Version: 1.0

On Fri, Dec 27, 2024 at 08:42:30AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 24, 2024 at 05:49:14PM +0800, Kever Yang wrote:
> > Add rockchip,rk3562-pwm compatible string.
>=20
> This we see from the diff. Say something not obvious. Where is the
> driver change? Why devices are or are not compatible?

There is no driver change necessary because the newly supported
compatible is

	compatible =3D "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";

Indeed this could be made more obvious in the commit log, something
like:

	The PWM core on Rockchip's RK3562 is the same as the one already
	included in RK3328. Extend the binding accordingly to allow

		compatible =3D "rockchip,rk3562-pwm", "rockchip,rk3328-pwm";

Best regards
Uwe

--lmyousutwch2mlvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmduZdIACgkQj4D7WH0S
/k6bHQgAmJuXIe1VQFxkvHw5JKicPt+23knzVTUjC6wiRnM5+QOPyr9dr67rhTBp
nwb9oaMsP5hVO7uudNyixkCGVq8E3OTacwrEoDISRRWNY3KxtRpVrckq3YKK+XLt
/l8KIHJJmtbuH/++BSN24uwF00Q9wJwK+zlywac/eCEsHaa49D/HLx8fiuCxP6VE
KqMngyX5pwLRSMVjT6pdcoyQJnLW6kQkXhI2phvaY8bKiuPNkx2mbJ6tRGi+Xuez
XGIv4vo7WZQLRFn2+yMpIKlvFUnIDSZ43Mru1MRmLUi+1kvXpWyjDYOHmqbEkBM4
NgnN3wwTA85srqToKTxT3JMRCDAu8Q==
=7X1D
-----END PGP SIGNATURE-----

--lmyousutwch2mlvv--

