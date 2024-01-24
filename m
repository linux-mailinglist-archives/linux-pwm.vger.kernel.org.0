Return-Path: <linux-pwm+bounces-912-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8F983A5C3
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 10:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2126B2FCA3
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jan 2024 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107718057;
	Wed, 24 Jan 2024 09:42:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750618032
	for <linux-pwm@vger.kernel.org>; Wed, 24 Jan 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089378; cv=none; b=EDor7dKQO8R7f8A4d3ouhdNiOlz95s7bVynumSxFbtHjTl3AmNtbNLVnmTH/j0Do7/pWibc8unjh2NK73tYOCpPwpxS+T23iC7lO+PF2FZdr+e2IdW0iT7dOiMfDSzWdxPdFiDOjhM7iVPR17GURAr5M9camxRD8lWPKJmqOIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089378; c=relaxed/simple;
	bh=c7AtDwtfUT29Girxwftwf36NoI+3PFJkKiX9LOmNFk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTb1nyMaXq0V0iQtWtxh5O+7b7Bru8Xr8+qDWxjKlkpkL1VDJ/Yi8uCH31aB/yfG3FfIPjk2YbgBUJ0tV4euoiaKYJjZrIUPa3I7jd683fGcWHUyYte4eDDSa2wQyXkthlgigA9R74QZDC5AQxmhr0HgiFc8r8S9XNfJBXqKYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSZmM-0003ht-Lz; Wed, 24 Jan 2024 10:42:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSZmL-0021gA-J6; Wed, 24 Jan 2024 10:42:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSZmL-0071nX-1a;
	Wed, 24 Jan 2024 10:42:41 +0100
Date: Wed, 24 Jan 2024 10:42:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 3/6] pwm: meson: generalize 4 inputs clock on meson8
 pwm type
Message-ID: <oyayapgrwaetyhuu6ua2nejcpgydmkijqdgtdlfqvq5jvc6nzp@xgvnwvjja3im>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-4-jbrunet@baylibre.com>
 <4kcbh4dezgpic2dpgdi2swtx2puqiq74w2tungmxipf4nznpn7@u4g4f3cimps4>
 <1jy1cfw0qa.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a3xdp7xgdzkgzofk"
Content-Disposition: inline
In-Reply-To: <1jy1cfw0qa.fsf@starbuckisacylon.baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--a3xdp7xgdzkgzofk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:11:59AM +0100, Jerome Brunet wrote:
> On Wed 24 Jan 2024 at 10:08, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutro=
nix.de> wrote:
> > I suggest to make this
> >
> > 	const char *parent_names[MESON_NUM_MUX_PARENTS];
>=20
> Ok.
>=20
> >
> > to make it more explicit that really four entries are needed here. This
> > also makes is unnecessary to add the additional NULL entries to
> > pwm_gxbb_ao_parent_names and the other arrays.
>=20
> I would normally agree but I'd prefer to be explicit.
>=20
> There are some instance where the NULL is in the middle, this can't go
> away. I think it looks if some inputs are explicitly NULL while the
> other are implicit.

Adding soem NULLs explicitly is fine for me. Using an array of fixed length
still (somewhat) ensures that later no shorter arrays are added which
result in surprises.

Best reagrds
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--a3xdp7xgdzkgzofk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWw25AACgkQj4D7WH0S
/k5e0wf7BlbmFsY4+YWO4iLdNo0BVoOnMnfSSNw2yPZA+YdUvXeulZDQTshMRkgQ
xNmIvXbYDeBBIUFQ64FzQQ89VyKcwTX459zycaNAg06N51FSdCM1EQO1F/Y6fqy1
g4+9fH3mHi+UJkcekm0st27G0uTvfiJ7RtkyQYK2KMD1OBmYr2ADURGmMppLzvLX
6XMsShbScQdqNKMGa2MGjB4plt3IzjyX5ZMRYaMdZABnZJsKJGXWfcr9p3fLZ3I+
Dvkti+CdMw7zHXAelVFD2EMKCMbV33PjedcIzBe9TTOQM5SPtoZHy3QIbQ+WdqNK
sbr4C8C10SJBSSUbB1NJfIJfQUTNhw==
=ENZk
-----END PGP SIGNATURE-----

--a3xdp7xgdzkgzofk--

