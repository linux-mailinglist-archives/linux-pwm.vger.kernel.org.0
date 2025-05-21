Return-Path: <linux-pwm+bounces-6069-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E25AABF6A8
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 244497A7823
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C61553A3;
	Wed, 21 May 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsGaU33z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB4B1514F6;
	Wed, 21 May 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835660; cv=none; b=rRBDFjvOikcC+X8f6zhmWfY1/8JiQvLOvwPkaMBGRxWwLo6xxyQzGuJ//8EzrCraI4Jz/9r8V//QL7EwOGeJ05EfhFJ4QG70D41Xo8S0nlRItt2QOorDIyXdVF3tyl6lj45daZto41L7ap10p/JnqOlHEBz5hQ+xn2SDbeYH7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835660; c=relaxed/simple;
	bh=okDVjojjPqsLyoEABNLJClwj8Etm1bdOm5dnm3xMjiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glHvrPFV6YpQeOCTy2qqQvjJM754pcz0cZb+d+bmrc/XxZhHuwzWJHiwHS/j8Bwd50NSrhtVBLGleqILysedG6F+2asJgnbjNTJLvYeWWXCSn4Gl80aeN7mo6fB/iDBMpMdo30FuRd1nw3TffOE0txNQq5KJJVJHTq4mtjHqgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsGaU33z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547BDC4CEE4;
	Wed, 21 May 2025 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747835659;
	bh=okDVjojjPqsLyoEABNLJClwj8Etm1bdOm5dnm3xMjiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsGaU33z3NyW9lztcCDNL4fOy/wCh4is8pIPUsILhF3iJYzXemmp7ZrPa6k0lB9fr
	 0K37Z9PQpCkeQRJnD2xgVJixXT3ee4IGNYoAtLbBJ9q5Vfe6N1Kio2Qew2IW/YxdBa
	 OT+2v5cQBzUtWUm8mCBqjEs4G/N3E4h8iCxjjuWfaY5HRLYroPQ6TOT8FFOe9/qkow
	 +tjfoUtfu9Ebm6ZL6ZzuUvnO1PWaTc4jLeDVrSs6fZWPavkV4uTQuVVaGQCY09PNbx
	 kai85vTEtJXkLGI+dN36rstYa1i0cHX3ITdPO9pYE/mDHunHLanla2/y3ZB6uvSW4i
	 NhUq82xMT2sqQ==
Date: Wed, 21 May 2025 15:54:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
Message-ID: <p3ejuwktdxcjwv43nnap5tin33ziimgxfan2xoghtaaubsxgy7@tjmwjpwy6yy5>
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
 <zdltaexty6pzbqesoluuyluygyt6w7nq7r2wccmtfktppwuw3e@qb36fsu3jq4k>
 <0dd1a97e-ff7c-4d09-b18e-5df9944488c6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oqoyjimbp3642yyg"
Content-Disposition: inline
In-Reply-To: <0dd1a97e-ff7c-4d09-b18e-5df9944488c6@baylibre.com>


--oqoyjimbp3642yyg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
MIME-Version: 1.0

Hello David,

On Wed, May 21, 2025 at 08:19:51AM -0500, David Lechner wrote:
> On 5/21/25 4:22 AM, Uwe Kleine-K=F6nig wrote:
> > Can you achieve the same effect with the (IMHO slightly nicer but
> > hand-crafted) following patch:
> >=20
> >  	ddata =3D pwmchip_get_drvdata(chip);
> >  	ddata->regmap =3D regmap;
> > =20
> > -	clk =3D devm_clk_get_enabled(dev, NULL);
> > -	if (IS_ERR(clk))
> > -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> > +	axi_clk =3D devm_clk_get_enabled(dev, "axi");
> > +	if (IS_ERR(axi_clk))
> > +		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get axi clock=
\n");
> >=20
> > +	clk =3D devm_clk_get_enabled_optional(dev, "ext");
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext clock\n");
> > +	}
>=20
> The trouble with this is that it would not work with existing .dtbs
> that don't have clock-names set. I think it would need to be more like th=
is:
>=20
>=20
> 	axi_clk =3D devm_clk_get_enabled(dev, NULL);
> 	if (IS_ERR(axi_clk))
> 		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get axi clock\n"=
);
>=20
> 	clk =3D devm_clk_get_enabled_optional(dev, "ext");
> 	if (IS_ERR(clk))
> 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext clock\n");
>=20
> 	if (!clk)
> 		clk =3D axi_clk
>=20

If there are no clock-names, the parameter is ignored. (I didn't test,
only quickly checked the code.) So passing "axi" instead of NULL should
work and yield a more robust solution.

Best regards
Uwe

--oqoyjimbp3642yyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgt2wYACgkQj4D7WH0S
/k4A2Qf/az6Xu3EQfPsAUim3t9XhkAXZq3qitZg/zlbVExJeA96ff9AHOyV9YEvT
4rLsdVA7aSxN3fNTwiKGBEz91tYkLQMq7BmBeREv41cQzMISyTR8DnzDSg0hiiuo
L20kk5dYb0rQsFLx6LiYdO6Yytc0Tr2WatudXp0CkdEwuW+HTTdyzlTIUTGURT+x
OySNvPYXQhjdU9o93u8aLaxbpE5ESJ0yNsJXLvki7z8+oRvUZixyRZxFxBhGbJxC
DwCI5JMVOUlqxPnwu5SMwUQ6zyg665FPafOSP6wp3R3+dctcTTaFjV6unXoK17XQ
G9cteIdpWnbYuLVMOrDlOQ6VFIvpVw==
=/EgW
-----END PGP SIGNATURE-----

--oqoyjimbp3642yyg--

