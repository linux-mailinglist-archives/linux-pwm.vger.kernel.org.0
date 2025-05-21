Return-Path: <linux-pwm+bounces-6037-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003DABEF87
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 11:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8BC3B555C
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE7B23C8A2;
	Wed, 21 May 2025 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJAKZ5gz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326F23C4F1;
	Wed, 21 May 2025 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819330; cv=none; b=QhhWfKDJyx9jioVy2Ft9wLE2RkZ3oOLwcN6MutoX7e+Uf1S+KV4jSFoTow48gRvQhWuyUyWXNAMicTTvqyS5BkxQA1PG/KY09JdUcKbc62xmldcV8QKbOIhh6lLRfpc5Wzhfsl8MIP7vIazftZC1DaVR5CnzSO9BpT1FeCAXW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819330; c=relaxed/simple;
	bh=raz7RiesiuNkadk6ewHUZtY7WbCAP8YqWgiA2FXatXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ25Y1FyYy4AuDLcfpTVrml0ZGFCnWznpa3xDZ95uSz3lOxlBT1Wqo9LhsYjoEy3AlfUWO3+PVQGqQMPflKZuRbgBIB9wuZZeOQP3h5GHvRbo26xfOSyvImx4gK9Zi8o97QBaridD2yMdLsm3XsW05kCz3t7Mhs6znj2wDcuA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJAKZ5gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96024C4CEE4;
	Wed, 21 May 2025 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747819330;
	bh=raz7RiesiuNkadk6ewHUZtY7WbCAP8YqWgiA2FXatXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJAKZ5gzdPYCJrFLBqjV30+qu8TR8JooV4vCY3H3uuJHHBCZm7wWSYbeinUKpobSQ
	 9wybrqqmEKghJI9bmXOuUaKVAAtOtLCMRHnXq2wSWpfxeQdX9sAWKjPRqeYlcvMmdk
	 t4obDeSHHAjIoXSvg5pBqdDuaVUnbEn27zbrr4AutsgMZmyc9dfP9YdjuhNiLKorY5
	 zcqzYUhJZa9zPn/BWtLMW9AL98EcGXTGehqz2CfaKVx5kUFKPSoGKKFCjl7udb6c43
	 my2LMuMzHYqN+Y7djx5yLGCDp2VLWYDygHjayc8fCDJbHJDtWswhbencdAFmbP9bnI
	 YCRbV0NLObWww==
Date: Wed, 21 May 2025 11:22:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
Message-ID: <zdltaexty6pzbqesoluuyluygyt6w7nq7r2wccmtfktppwuw3e@qb36fsu3jq4k>
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4tafh3x6o2rwiqf"
Content-Disposition: inline
In-Reply-To: <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>


--s4tafh3x6o2rwiqf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
MIME-Version: 1.0

On Tue, May 20, 2025 at 04:00:46PM -0500, David Lechner wrote:
> Add support for external clock to the AXI PWM generator driver.
>=20
> In most cases, there is a separate external clock that drives the PWM
> output separate from the peripheral clock. This allows enabling both
> clocks.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/pwm/pwm-axi-pwmgen.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index 4337c8f5acf055fc87dc134f2a70b99b0cb5ede6..67992a7561ec0440b1c1fa327=
f844a0602872771 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -280,9 +280,26 @@ static int axi_pwmgen_probe(struct platform_device *=
pdev)
>  	ddata =3D pwmchip_get_drvdata(chip);
>  	ddata->regmap =3D regmap;
> =20
> -	clk =3D devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(clk))
> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +	/* When clock-names is present, there is a separate ext clock. */
> +	if (device_property_present(dev, "clock-names")) {
> +		struct clk *axi_clk;
> +
> +		axi_clk =3D devm_clk_get_enabled(dev, "axi");
> +		if (IS_ERR(axi_clk))
> +			return dev_err_probe(dev, PTR_ERR(axi_clk),
> +					     "failed to get axi clock\n");
> +
> +		clk =3D devm_clk_get_enabled(dev, "ext");
> +		if (IS_ERR(clk))
> +			return dev_err_probe(dev, PTR_ERR(clk),
> +					     "failed to get ext clock\n");
> +	} else {
> +		/* Otherwise, a single clock does everything. */
> +		clk =3D devm_clk_get_enabled(dev, NULL);
> +		if (IS_ERR(clk))
> +			return dev_err_probe(dev, PTR_ERR(clk),
> +					     "failed to get clock\n");
> +	}

Can you achieve the same effect with the (IMHO slightly nicer but
hand-crafted) following patch:

 	ddata =3D pwmchip_get_drvdata(chip);
 	ddata->regmap =3D regmap;
=20
-	clk =3D devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(clk))
-		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+	axi_clk =3D devm_clk_get_enabled(dev, "axi");
+	if (IS_ERR(axi_clk))
+		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get axi clock\n");

+	clk =3D devm_clk_get_enabled_optional(dev, "ext");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext clock\n");
+	}

 	ret =3D devm_clk_rate_exclusive_get(dev, clk);
 	if (ret)

with the only side effect that for machines with a single clk we get
axi_clk =3D=3D clk and it's enabled twice.

Another upside is that

	clock-names =3D "axi";
	clocks =3D <...>;

still works.

Best regards
Uwe

--s4tafh3x6o2rwiqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgtmzwACgkQj4D7WH0S
/k71vQf7BiRb/3LpNcadtaG3ykMxBtOZvUSoxQsHTzQTd2LFGi4FU+4EuiUyOWH0
QZMnKVThUsN2tr02KffV3dzYZW4g0zXG/9JbEdkS+/WI/rfhnckceixDQNi7EDgq
1ag6SK9V8lmWdHzp3Qss2+DXxj9MMXzanTGtSnaXR7QzicYSV96DfmI1yDqNEc+e
FB4Ku97WNJ/JS+0bQnrIgbVhuUq0WnxVuBqfykAXOFmriSGdqUCvMH4ohzH1sS6w
op7hQqWtp5ywCOY2X/bdveakx4K+Zhf6RykYW2AsUh7G+DPO2yj/GPkNjLn9zzib
fKut+Lk+A7LyCEsu9uZdRG2cCL/B9w==
=0kBf
-----END PGP SIGNATURE-----

--s4tafh3x6o2rwiqf--

