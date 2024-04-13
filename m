Return-Path: <linux-pwm+bounces-1927-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA38A3BA2
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 10:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11CE1C20B53
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 08:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38A120B28;
	Sat, 13 Apr 2024 08:29:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00B1D55D
	for <linux-pwm@vger.kernel.org>; Sat, 13 Apr 2024 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712996989; cv=none; b=AI0lJ5ECT3zlt9aeqUi1+V5jhSVe5jqhE+IztU2jZOAdPkrilWQzjiCh3OcIq8joSEF3xTRVNbOBRdvpzbQxHKEUxKRKwdvOhuCyvPPPJLJLURWDAmUkJslF3YEHUVJ1ZnGxlib0BEk+dxB3fPbz22ZxNsaK27gD95waM1Uj4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712996989; c=relaxed/simple;
	bh=3+Xqeq3Fna/xrv/7lflqNm690NSwN9tpw5KiCw9rxck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtEnLmynqweGEfx8JWq2lJMg9Y+BrhzOjT4/LidZ/kCkZcuGT5bV7LZvhu9EJx8/4RNnkXJuNaDPq8qX/g7IQQMdj/WjHREguNTSiw7N7wmBojDigy6QnpUdBX8ujN699f1P4kzm+ZPMJZgdvvHhAyYKRr2D+S+zjun96Ndn6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvYlb-0001SG-Cs; Sat, 13 Apr 2024 10:29:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvYla-00C1vo-D8; Sat, 13 Apr 2024 10:29:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvYla-000fir-11;
	Sat, 13 Apr 2024 10:29:42 +0200
Date: Sat, 13 Apr 2024 10:29:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@pengutronix.de, linux-pwm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] pwm: stm32: Some improvements
Message-ID: <zhxpjbwubpai4wxjtu43gvjwoc5s7zmxkn4aakdp7rmskpbear@cm3yv7t5r425>
References: <cover.1710711976.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xv2jnzdhqwxr4cnw"
Content-Disposition: inline
In-Reply-To: <cover.1710711976.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--xv2jnzdhqwxr4cnw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Mar 17, 2024 at 10:52:13PM +0100, Uwe Kleine-K=F6nig wrote:
> while working on the character device support on an stm32mp157 I
> identified a few bugs / shortcomings in the stm32 pwm driver. These are
> fixed here.
>=20
> I based this series on top of pwm/for-next
> + https://lore.kernel.org/linux-pwm/20240315145443.982807-2-u.kleine-koen=
ig@pengutronix.de
> + a cherry-pick of commit b0cde62e4c54 ("clk: Add a devm variant of clk_r=
ate_exclusive_get()")

I applied this series to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E The dependencies are in there, too: My pwm-stm32 is in my
pwm/for-next, too, the clk patch is in v6.9-rc1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xv2jnzdhqwxr4cnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYaQnUACgkQj4D7WH0S
/k6y6gf/VKf1zsCq3LHoeeIb/DTeTVGwy6u9mMCgs0Fb4PzUkN3VZi8i9mMWncU7
kBMxmRh7zCDnUhZqUBXOFQVLqirVcjQ0uUQ+mY+lBu2PxRO0x/dX2aLlxUlZAnSF
mdcKGzKdY2fNPkYOELbPtmAnBEcYpeMelmgCChHnxG+IdpuQrh06by0vGwZeIzO5
f/U66Kf//gwSIGw0+CPHIbdeu0lIJBupa5ZGKQmGkyoBu86Kh8jN1r/McnZyzS6J
gkxGdI6ny+e6R0CP4/RisZZ85Gfde+V2zRJSUhuHjvFTUhnwJ+W0sm76C+eCsYnP
FOwbyk3BfkVPWlD3VDXjwnWcVW2VDQ==
=xwr+
-----END PGP SIGNATURE-----

--xv2jnzdhqwxr4cnw--

