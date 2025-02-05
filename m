Return-Path: <linux-pwm+bounces-4792-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E757A299E9
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 20:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2733416B020
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B796214A8B;
	Wed,  5 Feb 2025 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWLFnhfp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE268214A7F;
	Wed,  5 Feb 2025 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782791; cv=none; b=AijAGfapn4kmWdXp19GHaQviOL6yAKWSpG0fWyp0C3jYsctb0Br122OkdtfDvG47ng9YwdtbJWmFdQIldiwj+saor0dpKjvnLbPIAfJ5kj5bZjamNsZMkGCkGr9IrNve29a8aeqHdKRC/opgKX8FWT6C1IDOPrpsfWpmyneDOrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782791; c=relaxed/simple;
	bh=NghvBE7ABv9eK4/grIgqAbvA6pFodr6ODz6eGUErMIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM9ggvz25fbCPCglLvTDk2Uqwxf/1qT1lS9XQv++H1PfxqXrhPW2DAAbgo7MSrJkBMXuOFbZIyJ83mCNgzQ+rOr7k88Kg8ZmY5jgCBuk8KJQEM+FsvvEh33twDOo2y/7U7lDL9dWvRNEqBGksZqUua+oYD6gFcE+qKD8y8Ia8Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWLFnhfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C381C4CEE4;
	Wed,  5 Feb 2025 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782790;
	bh=NghvBE7ABv9eK4/grIgqAbvA6pFodr6ODz6eGUErMIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWLFnhfpPK00FuS4Ef2ti+604RVGnQK2zoBDXvA9KVaXeszn2pEbzut6+GNGWMBLg
	 CiHCBpU6tcCb6aPEmZKjj+D5bEZR2LfB664ib9s7FK6EVhCOi+uzJnxDu0VcdBCZpp
	 /eFpTVUqYIIk/cLpLxi47weOO7/OHp4AKvNoDb3V5kJZtQ397tlOLD7PW4aQNYADSt
	 2CM2ySrVCilvzG7DoYJCc87401R4LlS9IsI56eC90s3dRzVezOUIjsr/Ap2zwZZexN
	 4LY3aBcMbFurEFAL1YRKHp26aOn2svcr0WUq/W+E6q0tRD+FD2FLuZi6iLQomEMwAf
	 fp+7MSRbngK+Q==
Date: Wed, 5 Feb 2025 19:13:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: pwm: marvell,pxa-pwm: Update to use
 #pwm-cells = <3>
Message-ID: <20250205-strut-atrocious-d7f9d3c42859@spud>
References: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
 <266765abb8251bd60796a3c4270e3809bfff952e.1738777221.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="F9n+89XPUb+wErgK"
Content-Disposition: inline
In-Reply-To: <266765abb8251bd60796a3c4270e3809bfff952e.1738777221.git.u.kleine-koenig@baylibre.com>


--F9n+89XPUb+wErgK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 06:54:01PM +0100, Uwe Kleine-K=F6nig wrote:
> The PXA PWM binding is the only one that doesn't pass the PWM line index
> as first parameter of the parameter cells. However this can be upgraded
> to the mandatory binding for all new PWM drivers without breaking
> compatibility for old device trees using #pwm-cells =3D <1>.
>=20
> So bump #pwm-cells to 3 with the (undocumented) promise to keep the old
> behaviour for #pwm-cells =3D <1>.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--F9n+89XPUb+wErgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6O4QQAKCRB4tDGHoIJi
0msXAPwPsyQP1wjYdX5r8HKv6l4cxZt2BU7EGr18uD79cBCzxgEA+J0fhNFuqaU4
SUmQ6nOgErbv3Ag9MBuUlmq/njrGZA4=
=cJ6U
-----END PGP SIGNATURE-----

--F9n+89XPUb+wErgK--

