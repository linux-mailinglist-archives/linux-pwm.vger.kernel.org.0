Return-Path: <linux-pwm+bounces-5891-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E181AB311D
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 10:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6CE3A7D52
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714725743A;
	Mon, 12 May 2025 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LENGoWa8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC8257434;
	Mon, 12 May 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037360; cv=none; b=WBgTYRCZ+O7QQFd1wE+9jnen65RTKhDQqTzNVVG98JR/wIm0bzDjufF5hfEzyimkOeHTa0kTWJjZ1Q/IgF7V5hZJuF5GtYLCcpBB0rP+eLGhvMDV0uMpiMujzYZIMuKQU3DTYQ9X6CzYcfrCOeTbxF12nVFddRQhHzkPHqSPjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037360; c=relaxed/simple;
	bh=1Oe+b/v7tNU/z8lgoaq4olNm8pQf/7W92qcsu/JLZSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxDRE8HXUFRZhkIIVWrcOI5IMTmfhIvxEr0Nqb1wkNR8BbDMgQdgcTxyU2PbIUC7nEFxtsTLdARgWqY3VuJuH23zCcaWdubFi1v3EXaA6TiqspK37zXTx/IFPItM+FJ8mLn12Z6CczwTe3MxScZhpzCSOnEMRPtHz5TU7T+fHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LENGoWa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C355C4CEE7;
	Mon, 12 May 2025 08:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747037359;
	bh=1Oe+b/v7tNU/z8lgoaq4olNm8pQf/7W92qcsu/JLZSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LENGoWa8j54wP9pdunYFyodL0dtKuhpcbAP5JPpjZXt17FcuqbNvJ7NQo5039X6+/
	 wQa3dZ3U4q4+78pFBQH7+cK+iPbAEK3K8C1sE6N+9fjU/5WYM5JG5HWayp0HxTKVl5
	 YRQVpiGE+qIZz54f8GYu2YIrYBf8+ch4KzAhszskpFWPMVSixd9/ll6rHdnrexPkkn
	 xQnFwELc8AsdbPoUNSlCRHZi/Sz+Q+7cD7t2mBtQ0HoASjy3t2JmYza1xK+XIxEsBB
	 gPZnasCBeCHDxInMWvslkJa/Bbc4AKwF8MBSL/HxY/G9LSCx7A+iGCOJRzHLg8mLlr
	 IwbJR41jpUvgg==
Date: Mon, 12 May 2025 10:09:17 +0200
From: =?utf-8?Q?=22Uwe_Kleine-K=C3=B6nig=22?= <ukleinek@kernel.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
Message-ID: <i4b7c3afvksave2uswfnma2d3mhezefec7t5qhxzikfdsey4tx@wmszr4dtqkr7>
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
 <20250512073949.GC2365307@ragnatech.se>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dapdk2s6rsos6lxj"
Content-Disposition: inline
In-Reply-To: <20250512073949.GC2365307@ragnatech.se>


--dapdk2s6rsos6lxj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
MIME-Version: 1.0

On Mon, May 12, 2025 at 09:39:49AM +0200, Niklas S=F6derlund wrote:
> Hi Morimoto-san,
>=20
> I like cleanup patches!
>=20
> On 2025-05-12 06:33:12 +0000, Kuninori Morimoto wrote:
> > Because current PWM Kconfig is sorting by symbol name,
> > it looks strange ordering in menuconfig.
> >=20
> > =3D>	[ ]   Renesas R-Car PWM support
> > =3D>	[ ]   Renesas TPU PWM support
> > 	[ ]   Rockchip PWM support
> > =3D>	[ ]   Renesas RZ/G2L General PWM Timer support
> > =3D>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
> >=20
> > Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas,
> > and sort it.
>=20
> I think you also need to update the symbol names in the various config=20
> files found in tree. A quick look,
>=20
>     $ git grep CONFIG_PWM_RCAR -- arch
>     arch/arm/configs/multi_v7_defconfig:1206:CONFIG_PWM_RCAR=3Dm
>     arch/arm/configs/shmobile_defconfig:220:CONFIG_PWM_RCAR=3Dy
>     arch/arm64/configs/defconfig:1553:CONFIG_PWM_RCAR=3Dm
>=20
>     $ git grep CONFIG_PWM_RZG2L_GPT -- arch
>     arch/arm64/configs/defconfig:1534:CONFIG_PWM_RZG2L_GPT=3Dm
>=20
>     $ git grep CONFIG_PWM_RZ_MTU3 -- arch
>     arch/arm64/configs/defconfig:1556:CONFIG_PWM_RZ_MTU3=3Dm
>=20
> >=20
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > v3 -> v4
> > 	- Based on linux-next/master
> >=20
> >  arch/arm/configs/multi_v7_defconfig |  2 +-
> >  arch/arm/configs/shmobile_defconfig |  2 +-
> >  arch/arm64/configs/defconfig        |  6 ++--

I didn't check in detail, but looking at the diffstat I'd claim that
adapting the defconfigs is coped for?

Best regards
Uwe

--dapdk2s6rsos6lxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmghrKoACgkQj4D7WH0S
/k6VZQgAuyVAuWXB0dkbPFPYH+MyARF/0Jgxavq1t3baJJRrVXxaGsiOfNPg6gc8
h59SJfFNEdS6nNbEzF0ie7X+dwCYHJATFKee557kQD4b62o3NB5qnbBCiAqZwGwQ
Q/wxmqznU/pNyZCOZ4Kk5Edq125tjflgwc/+ExM76VlMiKrLGQyQCgTVguGxXBVj
UQzHbVjZfyZCpfaG5dhRy2OKRysTVegk/yN4OfkqlZd7IWqXQHvdVxX/W0PtPVzz
OnxDk+AvFXQ6x7a6rUBAfPyRDDyvQEOsUC1t/H6Q4SniCrZoVIfJRedB2vLPznNV
Te+iPi6UDR35qR8Cp+qyUBfCSGwGAA==
=1JRO
-----END PGP SIGNATURE-----

--dapdk2s6rsos6lxj--

