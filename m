Return-Path: <linux-pwm+bounces-5749-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25139A9F5DF
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 18:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9E23A9CB3
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F327A10D;
	Mon, 28 Apr 2025 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ4sApbP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26B199E9A;
	Mon, 28 Apr 2025 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857961; cv=none; b=S3Kzs5Seu7AMAoCKxAx3qz+UquyM1qgyK/AnYgte79V62woUW2wgQE8WlAUx7N9xL9Jahb9BLDQHPrZ4gH0MV+3scdAG58Wc6LrIvhkCDXuYsNHDZoNeZmKdxietCAZuZG/znNYXDgxiZetx2MDovkGZaS6xeCQ/j+SSsick1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857961; c=relaxed/simple;
	bh=rF0xSYpUAFZ4WX0DlNZ8bwKocybp6SgvR0ow4RtJX8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv16jouz6JAn7QqsU2liNdP32YveJ0RIpiRA0SvG0lXw1dATHEB4Og2pBW0aWoutSuNCDjluSmT5R8heu+8iNr7gFXytibFYbHSV9nJKVLpaiPnH3+/NgGu5laaoKBRrkexmUPMmtyoaIkeJhQSK8+idDdPvU6sOO+70qy9YHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ4sApbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2425C4CEEC;
	Mon, 28 Apr 2025 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745857960;
	bh=rF0xSYpUAFZ4WX0DlNZ8bwKocybp6SgvR0ow4RtJX8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJ4sApbPs8cZAPRs6riv1ljCbcQ7CiZzy28hxBSkKktiy9U+LpvzS9AREKfMyb9yD
	 p6QeLWon7wtV6m9KS93qC9mlhAbJUX2ZA0DqCQn/I84FQAogyi2jkOoEwsJyONzuEs
	 QrNIQFNkLO4RpCFe1g8To5VoTRdMaDp1NqisJz4Dn74nEwsjvdtAtkV7Cze3IexatV
	 IdL9aCQYFIrViVXwpkNFusEeupVAIpQoHToWqI04iEEKj374MALpPEcWJUzueqOFA1
	 o1ZIHPUV1IsZKV/B+HQQb27iQP5dgA2LPQU3IYmAffGsCs4OjvTCF/N4RcjrqK+zN8
	 ERVr7qwiBhMlg==
Date: Mon, 28 Apr 2025 18:32:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr, elder@riscstar.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v2 3/6] riscv: dts: spacemit: add PWM support for K1 SoC
Message-ID: <t4tnrsyl7t7hwfm752eapz3ajxkkl23nrfemw4jy6a7khi7a7u@gow3c2ba56ib>
References: <20250420070251.378950-1-guodong@riscstar.com>
 <20250420070251.378950-4-guodong@riscstar.com>
 <kftfye2zn2ogyvuv7diuyrv5qkp43csbpkcqfcms2xp5lsuubm@z2kocdzkb7qk>
 <CAH1PCMZC5xrX07rd5bo+06zJoJDiAH3UNHqH5catwEALNJL2dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7d2sgdyj5xap5wjq"
Content-Disposition: inline
In-Reply-To: <CAH1PCMZC5xrX07rd5bo+06zJoJDiAH3UNHqH5catwEALNJL2dQ@mail.gmail.com>


--7d2sgdyj5xap5wjq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/6] riscv: dts: spacemit: add PWM support for K1 SoC
MIME-Version: 1.0

Hello,

On Mon, Apr 28, 2025 at 08:46:50PM +0800, Guodong Xu wrote:
> On Thu, Apr 24, 2025 at 4:18=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@k=
ernel.org> wrote:
> > I want to make all pwms use #pwm-cells =3D <3> in the long run. Can you
>=20
> Sure. I can do this.
>=20
> > please use that for the new binding? (Of course this needs adaption in
> > the binding doc, the code should already be prepared for that.)
> >
>=20
> I got what you mean. The code change for that is already integrated into
> v6.15-rc1.
> Commit 895fe4537cc8 ("pwm: Add upgrade path to #pwm-cells =3D <3> for use=
rs of
> of_pwm_single_xlate()")
>=20
> Now, if I change this #pwm-cells from <1> to <3>, without the dt-binding =
doc
> changes, I would expect to see warnings (" #pwm-cells: 1 was expected") d=
uring
>   make dtbs_check W=3D3
>=20
> Any suggestions when the dt-binding changes will be merged?
> or I can add your patch as a dependency.
> https://lore.kernel.org/all/cb799d8a5bb284cd861785a691b8d5e329300d99.1738=
842938.git.u.kleine-koenig@baylibre.com/

I don't want to merge this very soon given that 895fe4537cc8 isn't that
old yet. But I suggest you adapt patch #1 to require #pwm-cells =3D <3>
for the newly added compatible.

Best regards
Uwe

--7d2sgdyj5xap5wjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgPraMACgkQj4D7WH0S
/k4dZgf/b8mf9YA0V9HfCWmvx/ccVO/gZNXUxBOUpcUeheEOR03RQ7Ha/Iixpel2
Jn1AqkzVcS60PqfpZvSgsUPaJrkRJuWnL6nFV1Pi0U8Kal89jC1sxcUTE84I5yon
hzWokjzGoXi6BPxWGVdKpNkrDF4qn3HXEDDyOX7hAb0kuSsdxFC6owK+MMNoKAGm
ptA44qdpUR9A7Qko2TB97gaMIqtPGE9qxHvsaCTyi3lMtkoKIGbue3mWqM86nBeQ
uScZ5heYBT8ix1p1z3nQpKG9XuhPltKPEsMEvUMIMN/F1M0rC1COcD5jl2wwvbBm
B7MeqakfcpoT/I5Vv5a8ttdORNz/TQ==
=x5Qe
-----END PGP SIGNATURE-----

--7d2sgdyj5xap5wjq--

