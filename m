Return-Path: <linux-pwm+bounces-4251-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5889E5252
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 11:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6D216278B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C518FC83;
	Thu,  5 Dec 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg1O9eM7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D6612E5D;
	Thu,  5 Dec 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394696; cv=none; b=Gf2i5nuSfT/6aXhFJITRmlARtPekLpFtJU0XWM9q8Dj7CqFD4hvPEdf02OGfBtjSdMoqSjB8kZ+XSqFTfHMuKPo2RZRF3ANXUje4pf8IRl80bA3FVJYW6Z0UdpEggBCrc2Kj708327HAhztGtoDltTEw8GpRrFfhnmonpSE4bUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394696; c=relaxed/simple;
	bh=oq9RpKVHYl0Ys8ZMKbBQXEZ39gpBOwFiQ92DPNgNC00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw2B4EIqWeDMh8vuEXaHqQOmYSfP6B57xLiE4e+yA1ZvbBt1Q3jUgwsULNt18KIpzj1fxCyokrsanRI3KoAwT/L7XfYI2J5TgqZ8NRn3HTSLEpxcuBzahEyZSVlzrPWAIm/9/ckK8nW/cM29DFVm4fd6FKhelRP76CmW2aD+deA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg1O9eM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94CAC4CED1;
	Thu,  5 Dec 2024 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733394696;
	bh=oq9RpKVHYl0Ys8ZMKbBQXEZ39gpBOwFiQ92DPNgNC00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eg1O9eM7QFsR117u5MHHg3dyNdQV0sFe2NUqnL4OzROv6DaSlteMWvbiXwuIz70pl
	 sc/UQyaSstJdaewUXMb0GNJ2yZJan0M8Ai3JDmJQ4ahj0+9MIKGdHG/Sx986iHlcvQ
	 TCP6rqTH1Y5ssxvKgTVLI7XdBuU2F5lyWcuXxWNeNZrPMkASRDWmj+uWV2yotB+lqS
	 9P310tV/P2mUc+HARW/H79K9y7ifAJrvAXGdZDAJ8R24y4woLykedCdlDWkUiZHiGO
	 paawuBbHPXNnrbwjydBVoYUa9D1Nca3GDPBHsFM1XCvMKDt4rOzW2YpbGGaQtphp8F
	 CFfvzBkq/CVXg==
Date: Thu, 5 Dec 2024 11:31:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>
Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <d6k2hggqqorw7n4ifwkquit6nyciqdweq2npznqvu2tla3ey5s@byag7bscba5c>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-4-biju.das.jz@bp.renesas.com>
 <slgs56imb3u6fv35bo2hl4moa77nnhrtcygi4womtuzs2mcipt@ylcvacvhsgcl>
 <TY3PR01MB11346421B5C0C4A193F70C3A586372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <phr4mtucfmyuhaywspzpxwqvwmklwcgsljcc5dvzbft44kengw@65axncbiotf7>
 <CAMuHMdWBb2-GGhyhubibbuSea9xVZBear3FXb11EO6gYn8r2Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mwfhr7imz36je5i5"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWBb2-GGhyhubibbuSea9xVZBear3FXb11EO6gYn8r2Dw@mail.gmail.com>


--mwfhr7imz36je5i5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
MIME-Version: 1.0

Hello Geert,

On Thu, Dec 05, 2024 at 09:52:28AM +0100, Geert Uytterhoeven wrote:
> On Thu, Dec 5, 2024 at 9:28=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
> > Well, the policy is to pick the highest possible period not bigger than
> > the requested period. So if B is asked to be set to 5ms and 5ns is the
> > highest currently possible value, that's it.
>=20
> Really? So overclocking is preferred over underclocking?

It really depends on your use case if 8ms or 10 ms is better in a
situation where 9 ms is the optimal value.

Note that with the new waveform abstraction there is also a way to round
a waveform W to the waveform W' that would actually be configured if W
was passed to the apply function. That allows a consumer (in the future
probably with the help of some functions provided by the pwm framework)
to determine a request to get the smallest period >=3D 9 ms.

Best regards
Uwe

--mwfhr7imz36je5i5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdRgQMACgkQj4D7WH0S
/k7E/Qf/QmfmrzooamMx6YI8aR38pnm8jiJfNEZhHdWrASvLOQyZ3jcdwjtVBy/B
FpdqRSITIIkXf/drVGgvrtrdB/e0zTUqv1R8yRbQrQK33+PX7o6wI8HoxHIa0m/Z
2dpGjNAthUDsxcNUoges0ZD+LIYvjCECWF6duCLz4/x2CsV+r2jmpolHC6stYwo+
I5d0gqVp+ima8dvEn6O82XQo7Mt3K3GiNwT19JgeNNjjsNgF5d8u0rJxTYNAtXXS
9gjYXlQEaql2Bz+lDSi6ZG5++9WPpWkDnAjg78jZt/LFYy/6p85fpye9S8vfEtGS
+js+oDFN1WiMzZ2E+ABOJsRjnfR9Kg==
=OCME
-----END PGP SIGNATURE-----

--mwfhr7imz36je5i5--

