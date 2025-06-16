Return-Path: <linux-pwm+bounces-6377-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7690ADB10C
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6711C168427
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9337029B78F;
	Mon, 16 Jun 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/1VsAXr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F22E427E;
	Mon, 16 Jun 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079110; cv=none; b=oNUxwvS21ooAv7KQDGTtr+E6a3XjQVVFPrVo54lN0GVOKFVW2TCI8LaXEwE/rWfdnk0+gKVtE2xanfJMaSDGxebjaP3V/jhhUCDpN478J1ZCylXgqehoC3bdeT4+NAIvwJYnV35uzqaQFiWLabyTAemQS91VWo44RXtU3nYQgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079110; c=relaxed/simple;
	bh=p9UNTMaBmHcquvnIIemy7Zc3tStstt+Pet1h/xmyfCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAOP5QaSnpiU/3mz2kPaHmEsEDogOJO9wEYBZrsRT4EFoctNmJqaPkMck+OTDxbaOQjdt36/FSOHeXl56gD3Lv7zDzKPKcxlL7uxNhMQ3Tzv0MtjSoSDcnzvj9GOJu0xuO5TCorvrcaTvTzCFVBi4hbqpHNoKFriySYije1MWRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/1VsAXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96899C4CEEA;
	Mon, 16 Jun 2025 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750079110;
	bh=p9UNTMaBmHcquvnIIemy7Zc3tStstt+Pet1h/xmyfCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/1VsAXrUHpFrGw7C3tjH2DZILOL5PVMsfkPIiv45tcChmIlNdlARfdPUD1KizYI9
	 HC9zwlFSM5BZ682p1oJo/WHQuoh4/7rgJ5SoVwiaJp4Erl61Lzg6wgn95q20+lBhZj
	 7snyGHqLtHMsn1V4D7xX0KeXWsYsqWUueg4CcTx3qKsbEf9yv+S2jH75Z+RSdT/BxS
	 L4yYRRZjZTXv8yP4+A4xfH56ikHJctme+PSGBNYUQbh2A/fbOPQhfTzvT0o7IsqgDM
	 gf9xz8rWcDnmokzwJnUsS/QC+741Nyi7nv2MI8g1iANUi67wkIFEl0VDMsnaihVQLi
	 R2vwNnvIIqlmg==
Date: Mon, 16 Jun 2025 15:05:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v8 0/2] riscv: pwm: sophgo: add pwm support for CV1800
Message-ID: <cr6gtizsg5qk5ggpnlbjxon4rph4c2g6wboem4e7bbjhmxxifm@v5kqrwr4i76a>
References: <20250509-pwm_sophgo-v8-0-cfaebeb8ee17@bootlin.com>
 <sfqdke7xkxg3sr2acber6kjzbcnoay6bnu3enda2xe5wzdi6id@eqiqmkdeovlb>
 <uy4idpkmmyswci3o5dul3xwees7azrs2dhorjgb5lxipi4bllb@7lbldfrwdsj7>
 <r65g6xww45zdnsuusobnzfg4pszjzkscg7t464e5eas2ycikzx@xed62astc3az>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="unotalrfmjcf6gmo"
Content-Disposition: inline
In-Reply-To: <r65g6xww45zdnsuusobnzfg4pszjzkscg7t464e5eas2ycikzx@xed62astc3az>


--unotalrfmjcf6gmo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 0/2] riscv: pwm: sophgo: add pwm support for CV1800
MIME-Version: 1.0

Hello,

On Tue, May 27, 2025 at 06:43:06AM +0800, Inochi Amaoto wrote:
> On Mon, May 26, 2025 at 06:31:42PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, May 09, 2025 at 08:14:57PM +0800, Inochi Amaoto wrote:
> > > On Fri, May 09, 2025 at 11:45:42AM +0200, Thomas Bonnefille wrote:
> > > > The Sophgo CV1800 chip provides a set of four independent
> > > > PWM channel outputs.
> > > > This series adds PWM controller support for Sophgo cv1800.
> > > >=20
> > > > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > > > [Thomas since v8]
> > > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > > ---
> > >=20
> > > As now we have pwm support for SG2042, I suggest sharing driver code =
and
> > > binding file with SG2042.
> >=20
> > How does the two relate? Is CV1800 the same as SG2042? I'd like to know
> > before I spend time reviewing a driver that is better spent elsewhere.
> >=20
>=20
> IIRC the pwm SG2044 is based on it on CV1800. And they both share some
> common logic with SG2042, like setting PERIOD register. So I request a
> merge for it.

To make this explict: Without having looked into the details, I agree
and so will discard this patch set from the set of waiting patches in
patchwork.

Best regards
Uwe

--unotalrfmjcf6gmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhQFoAACgkQj4D7WH0S
/k7yjwf/Zo2r6RNQmdAcJ6yRylPUmBOTp0jeMCrB2Snmibeqi6ksw/xe7nn1M+Ry
NFveA+kGgf4KgkgqMmsFbz6rujAsGxO21yCccYnl7VEZdeDseumfpBXLhg0AcZaU
FXjX2eSq4a40pprupD/mVGuaJXIfv/AoLheL9ZNKNTL2wh96L1M77so4lj4EdMRH
nPmbe6uIWlJSs7nJf6JoQBQYiWkHjwnwoL6XOkVHSVtpnKaT5hJawAM8x+Cr0sLa
wpY2gRdu60WMkvcZiq0xmFqxHPSzGCGnY6fMjTFlk+7Yy0MjIo/Zryu9aZZDJBau
GmzJHvPv6T+KeYygk0M5jcNirLQ4xg==
=HFc4
-----END PGP SIGNATURE-----

--unotalrfmjcf6gmo--

