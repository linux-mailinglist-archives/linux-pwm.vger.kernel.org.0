Return-Path: <linux-pwm+bounces-7624-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C20DC5C4B1
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 10:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A0B3AAFA9
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5027306B2C;
	Fri, 14 Nov 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxFMG/25"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49FF3043C6;
	Fri, 14 Nov 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112647; cv=none; b=Ig9bEr/VNxTU7Kfmp6Bh39VzGG80m0yVQfG9l7NbWc3NHwvbNLdTp2ORxexbDVFul0ZVsxRfSTyKN9NAEBufHmqF7rvdzI13hufT2DZjpQ3flc/qYJO63XiCSuuoGdfyq4RtW7O4yZMtQw12iphUxfFJ+/VHde1ImQqUF0cjRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112647; c=relaxed/simple;
	bh=mu6sYtHQseknXhdtdvf9zUMdMyQYHZUubUq2cO8pKl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARSQosOB+ET+rr9xkobtPLX4FQievTgv7uvwq+eWqW9gDbLN7oEJHlJb7FJHkCyj9Xj/gqRu/R7ESHkSz0U4DSEmQuLCmO/5OZ5nyxXLcMJ+z7vJhOuOoOOwVfepCj4Nf6rMxp3WE2pLRM3y40QLyAIlh+A2jLzi+wP2XlitSqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxFMG/25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FCAC116D0;
	Fri, 14 Nov 2025 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763112647;
	bh=mu6sYtHQseknXhdtdvf9zUMdMyQYHZUubUq2cO8pKl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxFMG/256/eEXj4FR3stK6beusUTOyckjSYfr/vf3LkyTM5ru1xBVQkOjLZLUIXVy
	 /lzJdb1C1kRSlvLiAxLq8os34JMVQeAoBDK4/8Yzy03qUMwg8EF6WvEbx2gZcaeJct
	 ckgkrN5UL8qISOiLngfSiwoOk3AG4xNCmAbsqZGzbBZnD28aAB4Z5H1vHcpm0B3eY1
	 2T9LCgBC71FcEbkkJHJ2eLNn/PEVym1JbusIudxd5Tkg2QJaDC+FnUCbnbi4Pwck2F
	 /ujFGleqFiob/G4ZhtmZxZb4YN5mk0ehcx07wO/kwd1m4LEb7KJnWB+sEXot5gvBrG
	 6veMxP0wHrfiw==
Date: Fri, 14 Nov 2025 10:30:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: ziniu.wang_1@nxp.com
Cc: laurent.pinchart@ideasonboard.com, nuno.sa@analog.com, lee@kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Subject: Re: [PATCH] pwm: adp5585: correct mismatched pwm chip info
Message-ID: <jqsmjigr65kqhlk3buybrcurllqxlad6zkkuwo3tea5uqopqzl@ldwbjsndltpk>
References: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tn5s2tuukomvlmxr"
Content-Disposition: inline
In-Reply-To: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>


--tn5s2tuukomvlmxr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: adp5585: correct mismatched pwm chip info
MIME-Version: 1.0

Hello,

On Fri, Nov 14, 2025 at 02:53:08PM +0800, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>=20
> The register addresses of ADP5585 and ADP5589 are reversed.

My German feeling for the English language suggests:
s/reversed/swapped/.

> Fixes: 75024f97e82e ("pwm: adp5585: add support for adp5589")
>=20
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/pwm/pwm-adp5585.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> index dc2860979e24..806f8d79b0d7 100644
> --- a/drivers/pwm/pwm-adp5585.c
> +++ b/drivers/pwm/pwm-adp5585.c
> @@ -190,13 +190,13 @@ static int adp5585_pwm_probe(struct platform_device=
 *pdev)
>  	return 0;
>  }
> =20
> -static const struct adp5585_pwm_chip adp5589_pwm_chip_info =3D {
> +static const struct adp5585_pwm_chip adp5585_pwm_chip_info =3D {
>  	.pwm_cfg =3D ADP5585_PWM_CFG,
>  	.pwm_offt_low =3D ADP5585_PWM_OFFT_LOW,
>  	.pwm_ont_low =3D ADP5585_PWM_ONT_LOW,
>  };
> =20
> -static const struct adp5585_pwm_chip adp5585_pwm_chip_info =3D {
> +static const struct adp5585_pwm_chip adp5589_pwm_chip_info =3D {
>  	.pwm_cfg =3D ADP5589_PWM_CFG,
>  	.pwm_offt_low =3D ADP5589_PWM_OFFT_LOW,
>  	.pwm_ont_low =3D ADP5589_PWM_ONT_LOW,

I wonder how that didn't pop up during development of 75024f97e82e. I
would expect that the driver doesn't work correctly in a very obvious
way without this change?! I tend to want to send this to Linus before
6.18, but the question makes me wonder if I'm correct with that
urgency. Any insights?

Best regards
Uwe

--tn5s2tuukomvlmxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkW9sIACgkQj4D7WH0S
/k4N2QgAmWykMZute2sALvKEhz9aGkCx3oPfLIup2KcLeeeRIV8HIPwN/fEZf5Cb
MQtFmPp/xje0kLZUytUQGoJm7U4l2kEj/Pcga7+/ZsXRN8UXD3hIV4pgndAheylb
Aev14rLEEg0p68FTIfagmuc8qPyHRGfQ1tys4+r8H/OE7c+VX47sxFnDIuf7ZtLS
EaBTFpd52YCLe6IHHp/FdRJ9c3C0OTuwVypAI13vR40OWNsIGQzx/P4Erhbw+X/u
9dXwc5U5eVrEQ/qVqMl1FipIWJ16edG4vbbEECzbQc5GaJPX13bE5EN3UBtD5Yw3
CYGa6UjO1fWyUS2YlL4IlAWmjhiJfA==
=51X1
-----END PGP SIGNATURE-----

--tn5s2tuukomvlmxr--

