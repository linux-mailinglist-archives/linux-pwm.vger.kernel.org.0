Return-Path: <linux-pwm+bounces-7467-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A6BF5C06
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Oct 2025 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0C746754B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Oct 2025 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268D32D44D;
	Tue, 21 Oct 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6OE5897"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186032D443;
	Tue, 21 Oct 2025 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041983; cv=none; b=ZdlJgLt5dPteFXmB8U1CpbYZDW1BPKqqbMjc6C+fU3gsBK3LGG/xEVb7hMGwXr1VrHvGQ/YkMgix+z85+A6IUHKGXXxpAfbi8EF/3XZC3iRDRLDmdC5W7sWQ5+jG/tstPtKuz29vw70CtGrKDSHMUcTKsFnA4atbyh3Vasdqr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041983; c=relaxed/simple;
	bh=f0g5THhK54dybF5dmkHuBFG1blG84WxDpg/JuwhhxA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBF3JZwr9PwfnirTJe9+WD/OKUQpOM2/aalGU3kdycN4FpZl0M+xARzl9599lapvnBfibXQW7gHXKT06QWQ6WFIwgETqUkHei7oPA6+3avacQDbF/9yiQL24aOx0tBB+ZJEQLBFrTXRZos5KDqI0/1FA5QhHAJl3V4t8nKPid54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6OE5897; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275DFC4CEF1;
	Tue, 21 Oct 2025 10:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761041982;
	bh=f0g5THhK54dybF5dmkHuBFG1blG84WxDpg/JuwhhxA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6OE5897LDLOTzsdByMLlf3cZIKKK+9G2+OQqUV8uwL/SfvbyNnrnzC7iphEvNAyW
	 HRvgyY/sIT57az/O2/Ma5mV8514MycfoR0UY6N8v0/JNL0hJyem/odm5qkuzNcfdjL
	 WQuuWeWgbg4cHQZoXwSOjjZEn132BSkJrmAwC4YVvDLwu4/8213WdCi07poFX2Yphm
	 aZqy3qv7mcLHOwobhWcnQ3gWXQTYheQCWo1TPu/D3KKZR8pNnB7m25Xu9+IgO6Ok7A
	 4E7sU/DQpbkBko27LGssTL+sN6s0cdGwHDx3mRUlJirURLwrFa67gmGJtlONF1mdW/
	 GVjC4VuCfNirg==
Date: Tue, 21 Oct 2025 12:19:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: kernel@collabora.com, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] pwm: rz-mtu3: Share parent device node to MTU3 PWM
Message-ID: <7uuuqhmkmmucmeeo5fybzld62rybyq6fjxwqqnxqr6eufis2ze@xfc2owdzfcs5>
References: <20251009162445.701589-1-martyn.welch@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hn2y6sgc6bhpdjch"
Content-Disposition: inline
In-Reply-To: <20251009162445.701589-1-martyn.welch@collabora.com>


--hn2y6sgc6bhpdjch
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: rz-mtu3: Share parent device node to MTU3 PWM
MIME-Version: 1.0

Hello,

[adding maintainers of drivers/of and Krzysztof to Cc:]

On Thu, Oct 09, 2025 at 05:24:44PM +0100, Martyn Welch wrote:
> The PWM currently functions, however if we try to utilise the pwn in a
> device tree, for example as a pwm-backlight:
>=20
>         lcd_bl: backlight {
>                 compatible =3D "pwm-backlight";
>                 pwms =3D <&mtu3 3 833333>;
> 		...
>=20
> This fails:
>=20
> [   15.603948] platform backlight: deferred probe pending: pwm-backlight:=
 unable to request PWM
>=20
> The PWM driver forms part of the Renesas Multi-Function Timer Pulse Unit
> 3. The PWM does not have a DT node of it's own. Share the DT node of the
> parent MFD device, so that the PWM channels can be referenced via phandle=
s.
>=20
> Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>  drivers/pwm/pwm-rz-mtu3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
> index ab39bd37edafc..5825875fa0128 100644
> --- a/drivers/pwm/pwm-rz-mtu3.c
> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -523,6 +523,12 @@ static int rz_mtu3_pwm_probe(struct platform_device =
*pdev)
>  	if (ret < 0)
>  		return ret;
> =20
> +	/*
> +	 * There is only one DT node, get it from the parent MFD device, so
> +	 * that the PWM channels can be referenced via phandles
> +	 */
> +	dev->of_node =3D dev->parent->of_node;
> +

I (very quickly) talked to Krzysztof about this. He said that
of_node_get() should probably be used here. I wonder if
device_add_of_node() is the right function to use (which uses
of_node_get(), also handles fwnode and implements some safeguards).

>  	chip->ops =3D &rz_mtu3_pwm_ops;
>  	ret =3D devm_pwmchip_add(&pdev->dev, chip);
>  	if (ret)

Best regards
Uwe

--hn2y6sgc6bhpdjch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj3XjgACgkQj4D7WH0S
/k5fRQgApfWLCG1uFRgeJaGb2nN+t9ay4j5ItEu/+8762mGY1jnzg9VeM3/DRBuk
NUF5Pjyd4s/n4AO7IhMVvBFWfcX38zoxvheUA13nwhIne6Rz4KdkDGwfb8iVL7C+
/HyaBt1xTF38HkZ77zq3ODmVoYaQh9MZhiUJPRAf32nh7mfwh61p2+A2dGYXGDtH
ZDe+tCH2iME7A8Yx8McpmDT5omp11QcPj+vf4rGE6nl1obmVyZv0H9PL1WCwC9On
bTT2HQZJsA3cJJJfl8qm8wYUkBm8VUuJCCode0phQNZgSLI1937fiSUptk29LAkC
OEODR5YY2encI4GgCuRfMc6Rj0jknQ==
=l7bX
-----END PGP SIGNATURE-----

--hn2y6sgc6bhpdjch--

