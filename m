Return-Path: <linux-pwm+bounces-2480-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9860909CA5
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Jun 2024 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E421F211F4
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Jun 2024 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5246B16D4FB;
	Sun, 16 Jun 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2OHdvVK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23466944F;
	Sun, 16 Jun 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718527612; cv=none; b=ulL9vymqshYN199fGXyt/AXE2LbjRvQ1FEVfnDytIUyEPyhNl+X5Kf7JlJoCxt7MrbuzKYF5v2/tP8E+4eF90Yj0hr+7Nbsj2RouRQegUWGpGHl4YcIpVw2u+QdGm6NwR9YEpQpEYNG0VlsE0/cMc51Ki+Q5AGRPyXKliH0XKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718527612; c=relaxed/simple;
	bh=nQ/vCqxQ64G/dU866VmZFNtnjndHdvzguYFblH2UCDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0yl6qwyvSD3A+dIaB7mlcmmwUL7wKpeuY37sodX38HhQn0KCCKdSp9M/QRKU7GCI+MD1gHFFldTmVwNzftUvLhX/+APx9WC/nuKow0PX9bc/24kY7KeRIAIjIV0Rt5tp7rCWHVtZ0s5MLO84gjWINofBOgRC3A5AM+08/PF5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2OHdvVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B01C2BBFC;
	Sun, 16 Jun 2024 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718527611;
	bh=nQ/vCqxQ64G/dU866VmZFNtnjndHdvzguYFblH2UCDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2OHdvVKgDV+k8tBQb+6fbyD7clBj1Ae+BaJCTTdzJQNSHTbIIYCAmvRZnVnpuMUQ
	 0S04uOl50zNEJJV8ztTxdj1bG/H9Z2GJDy4jm71ycJ7t2pwMCiXtH6MlepC8uFGxhI
	 y1+hq6cpVQ4Xs/SONuFzbQRyx9v7P4nHz+F2+BR92quaY1ANm+vlOBMZBjdqcj4rvN
	 B9MAsRbOoevugcbQlQ3NRrg/S1BbLm29qkIOdxzXKMW3gSolOFTsYK7BkiTW/iadfp
	 L1mAbgaHwc/LdwyEjUw+ojql6oqoXtzAWCAV66s1MbPjE3dn4GGeYq50Fz7kHFL4+j
	 OIWYMuetZQcVQ==
Date: Sun, 16 Jun 2024 17:46:45 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mfd: stm32-timers: Drop TIM_DIER_CC_IE(x) in favour
 of TIM_DIER_CCxIE(x)
Message-ID: <Zm6mdYBhP1dAMthI@ishi>
References: <cover.1718352022.git.u.kleine-koenig@baylibre.com>
 <0735860960b1b38570bffa5b0de81a97f6e3230e.1718352022.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dCl7/OXUWXzDpqmf"
Content-Disposition: inline
In-Reply-To: <0735860960b1b38570bffa5b0de81a97f6e3230e.1718352022.git.u.kleine-koenig@baylibre.com>


--dCl7/OXUWXzDpqmf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:10:13AM +0200, Uwe Kleine-K=F6nig wrote:
> These two defines have the same purpose and this change doesn't
> introduce any differences in drivers/counter/stm32-timer-cnt.o.
>=20
> The only difference between the two is that
>=20
> 	TIM_DIER_CC_IE(1) =3D=3D TIM_DIER_CC2IE
>=20
> while
>=20
> 	TIM_DIER_CCxIE(1) =3D=3D TIM_DIER_CC1IE
>=20
> . That makes it necessary to have an explicit "+ 1" in the user code,
> but IMHO this is a good thing as this is the code locatation that
> "knows" that for software channel 1 you have to use TIM_DIER_CC2IE
> (because software guys start counting at 0, while the relevant hardware
> designer started at 1).
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

I concur with Lee Jones that the subject should be renamed. Regardless,
here's my ack for the code changes.

Acked-by: William Breathitt Gray <wbg@kernel.org>

--dCl7/OXUWXzDpqmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZm6mdQAKCRC1SFbKvhIj
K30lAQDsaSV5Lc4QTe+SNucCUL6Fa1IDxYIgK4zoGmqxb9xPwwD9F2jDmowZBtn1
G4nggdLs3gGlZTYbXuMu9YnjuVjaTgk=
=v9Mi
-----END PGP SIGNATURE-----

--dCl7/OXUWXzDpqmf--

