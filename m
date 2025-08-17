Return-Path: <linux-pwm+bounces-7081-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C3B292BA
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Aug 2025 12:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326557AF216
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Aug 2025 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF732877CA;
	Sun, 17 Aug 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD6Wb82x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B43285040;
	Sun, 17 Aug 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755427924; cv=none; b=lIeYB6UbAOkAz1lj7uT3CRqjxl1JCjmxgpCLGsTq8evFR7DCiAwYmFPRdoOoHeEjs1VSTEruULYW+ke8esE0ZoBDsIEBOLwGUBSuBDneS50OO4POrilqn+yigtGWCsL4HgVZZyQSCxu+Yk3Z4lK4opOXvj3IQo0ymwRBjsSzY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755427924; c=relaxed/simple;
	bh=pMMIe+P1uAVD+fiUbERzGoVnBS5zowAqRDZnffQAvdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZmcb0/B3RMp9oWFlmf5usPeJfz4FuXtfQxP+LpAZLbwWZr8v8dzAMO4E57KI9CurISI6JphMseXw+p1WLmW0T3Pglvd4vxuBZca0yQQOSeC4UHppVtbR6AUB/zvB1rg2qiCBYBNKZUBS6x+RyJSUCIKN/tsRjzqeKK/xq4fLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD6Wb82x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4724C4CEEB;
	Sun, 17 Aug 2025 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755427924;
	bh=pMMIe+P1uAVD+fiUbERzGoVnBS5zowAqRDZnffQAvdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GD6Wb82xVeCkEiPAPQyVx5fuXm1vBkHKZkGAtnYCNaCbJaPHYYfCVtvPJ6PBcvOfJ
	 +LFzSKd3W7hs0DUnipS4rLxcDVHTmQ/yJEf1r5eU6dV1gVO91ZvTnOxF5vE3cFynh/
	 53efBH2w9dxj2LBhggmIhGEoV27gGpqNJio/+Gqhy/MKe6FlVa8o1ch6jnri7owtB8
	 0t8yaas+8A4woSEhYsmRpCinls/KnKNmrOW49KlDoV4CnFsIwEbvXX1QuF7BBoQMoB
	 wk2AtYZBpjUPZthfQxerz6kzuWsG5fRYB/md6ny0aXZwuw102swa4xLa8Pjvkqw2Bc
	 AstkNU+NMsiNA==
Date: Sun, 17 Aug 2025 12:52:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: berlin: Fix wrong register in suspend/resume
Message-ID: <rscqtwztqwtihcq7rwvyjvnkbo5bmve257i66e3it52cnft7pb@6gwbgx5o7lpt>
References: <20250815031016.31000-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gkb3f744hn3qtrx2"
Content-Disposition: inline
In-Reply-To: <20250815031016.31000-1-jszhang@kernel.org>


--gkb3f744hn3qtrx2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: berlin: Fix wrong register in suspend/resume
MIME-Version: 1.0

Hello,

On Fri, Aug 15, 2025 at 11:10:16AM +0800, Jisheng Zhang wrote:
> The 'enable' register should be BERLIN_PWM_EN rather than
> BERLIN_PWM_ENABLE.
>=20
> Fixes: bbf0722c1c66 ("pwm: berlin: Add suspend/resume support")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/pwm/pwm-berlin.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> index 831aed228caf..858d36991374 100644
> --- a/drivers/pwm/pwm-berlin.c
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -234,7 +234,7 @@ static int berlin_pwm_suspend(struct device *dev)
>  	for (i =3D 0; i < chip->npwm; i++) {
>  		struct berlin_pwm_channel *channel =3D &bpc->channel[i];
> =20
> -		channel->enable =3D berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
> +		channel->enable =3D berlin_pwm_readl(bpc, i, BERLIN_PWM_EN);

BERLIN_PWM_ENABLE is 1 and BERLIN_PWM_EN is 0. What is the effect? Is
the low bit just ignored and the right thing happens? Or does this
result in a bus exception and the machine catches fire?

If it's more the latter than the former, I wonder how that didn't pop up
earlier.

Best regards
Uwe

--gkb3f744hn3qtrx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmihtE4ACgkQj4D7WH0S
/k4WqggAjURbeqkril2WNTHV0K/mCg4xeuwNXphkZvmDi8Tv0iVHNtY52W4MhG6H
UrbJ1Z7m+LIJz+t6y0EKRDFPwdmD/7mzK5+4L9uEFIvwqBYHSFzdgi0oMrrUrh95
NDR1PPFWu34ZD/4DCYLgucDkOPnDctb+naTBOrdWM9NJoPk+Q2WNlfTSMSM2kzU8
lgeEF8RkmYwwreBC/sBQXQisO09oDhzjVXo1LulBItFUo+JA7hMyTQDAwO4TXjBj
3QVioNVgOIPhmcahZQIKMuWIJUQAFdTkkREiDCX+0gYI7eMJB5IX5n0MAwzr8rTf
Giu5LyQ+D3MpRto0DoWHJCo5Q51DCg==
=LQsI
-----END PGP SIGNATURE-----

--gkb3f744hn3qtrx2--

