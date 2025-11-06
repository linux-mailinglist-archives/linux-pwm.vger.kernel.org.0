Return-Path: <linux-pwm+bounces-7597-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D7C39D64
	for <lists+linux-pwm@lfdr.de>; Thu, 06 Nov 2025 10:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597B21894314
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Nov 2025 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E52D24B3;
	Thu,  6 Nov 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+xqXbxm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E3286D55;
	Thu,  6 Nov 2025 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421770; cv=none; b=AQTVtTkZvsSN+9ZF1kQNIRoY8++JOYIEY6IuiTgJjNWh6QGEScyP/I2V274Y8DvVjrkEehaM8QRWh/FyhwbGqKoB3sW4BMqV2I1vkr4dQtp1+E3op53SC26bAqgMv5BxHhfRr1plYVubB7iq+USiAvPlXDvsuSSAqXfuz4Hfv5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421770; c=relaxed/simple;
	bh=Toqy0lKEohSNoSfFWjUFFL6GdfH+5truG1nkMtppQZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV09vWh7VNBu0aoQQwhFoAlxDdaB1xMf8P3e48JPXx3pwJnAehJXql6lOrAPY1WojN6MZjpnY0cJhJ36P22MH/wdudx6XyqhdIxKnnN92gtoSVLiDJYmgNaK5qJVv7tWwrtr/2pzTRwUWiDpIvZUQf+E6ld4N9pqnH5pmY24AJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+xqXbxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B1DC4CEF7;
	Thu,  6 Nov 2025 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762421769;
	bh=Toqy0lKEohSNoSfFWjUFFL6GdfH+5truG1nkMtppQZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+xqXbxmhje9PKO4r4kC5DzuJSUy7ZKdpoZP5dm9YbLP3no4UkysZfcytuEjnrrfb
	 5QZaB9M0CVIgIDsncBVTmxGj/nqYDTqDXvSPycArX3faqc9H/qyHCJYZRMk/N2Wz+O
	 ZXULGdO9KRde+AXEllK0hgKM9YlyQlTHg1LfEi4EdmZzDeBPhKogzMO2u7fqsC+CIk
	 iAFTeXvY+GzfABCLSzQTi9klc47ocuefQAsxyKynA/gQc2tofmQ069ZJ71ejC28hnq
	 lKRX2tVQAkmFdX4uGEDQeySxoiZaMcM4mo+xn5aMND1G9zDz4N/tOVNdefvaiSQ2qu
	 2Z/Q71GfuFKKQ==
Date: Thu, 6 Nov 2025 10:36:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] pwm: rzg2l-gpt: Reinitialize cache value
Message-ID: <ct7zlhhexzjsogtthsmhejm37idby3pphljzzdarylkcupmblg@gripvo3dxzqq>
References: <20250915163637.3572-1-biju.das.jz@bp.renesas.com>
 <20250915163637.3572-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="or25wqcocuvjykyk"
Content-Disposition: inline
In-Reply-To: <20250915163637.3572-2-biju.das.jz@bp.renesas.com>


--or25wqcocuvjykyk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] pwm: rzg2l-gpt: Reinitialize cache value
MIME-Version: 1.0

On Mon, Sep 15, 2025 at 05:36:30PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Reinitialize the cache value to 0 during disable().
>=20
> Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3:
>  * New patch.
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index 360c8bf3b190..b2452e50d618 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -190,8 +190,10 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip =
*rzg2l_gpt,
>  	/* Stop count, Output low on GTIOCx pin when counting stops */
>  	rzg2l_gpt->channel_enable_count[ch]--;
> =20
> -	if (!rzg2l_gpt->channel_enable_count[ch])
> +	if (!rzg2l_gpt->channel_enable_count[ch]) {
>  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> +		rzg2l_gpt->period_ticks[ch] =3D 0;
> +	}

A code comment and/or a more verbose commit log would be very welcome.

>  	/* Disable pin output */
>  	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0=
);

Best regards
Uwe

--or25wqcocuvjykyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkMbAQACgkQj4D7WH0S
/k5+rggAlRnnHOXN5Cyw8ayTcICgtQSHgkNtrg/M4WN0498MLEqAHdcv1roeEPsd
m1x47NRM+vGIf2oMvY0IZsLsbAg8EG6oKLa7C3THrvw9BsKFve//pta+YG4I1C3K
KEMD9mphHFew0BQiB226JLY5viehPw4vQsoQjKV0Z7aRA1gwm9c6kv8xRK5LYmnE
j6xdciMlATGTNXfTV4ad+jW+8rpHlgXU7Yjq4OH0ED6oFfan5t80pSJ/7kmPvyOb
qLzBd+LPfnfGXlXbfnDRUMThzzPq2KuQqMHwx3SDt3w+KQiWUnfbNB23HXtS5N1P
EBsJ6qucUih8ZNIiKfb1lPSrPuWrqg==
=7Iko
-----END PGP SIGNATURE-----

--or25wqcocuvjykyk--

