Return-Path: <linux-pwm+bounces-7901-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D5AD1E51C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jan 2026 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF3D63001BE5
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Jan 2026 11:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4160D38FEE8;
	Wed, 14 Jan 2026 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM5VHh7Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2781E5B7A;
	Wed, 14 Jan 2026 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388975; cv=none; b=FXRxgBMzyF5nlCdTvDhTK42srmh1jAEXenJqspKSwfyolbq0wx3cq7fVZuk6J3KByVmukOpwJ+MYGTeKvF4LgmZxAcNSOCwaToeVpLQHoY30GhZFwvNsIiddd6W9cGc727Rfi1O1sD2XEuaMgbx0vdHRU04ZRJvpB972L6s/3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388975; c=relaxed/simple;
	bh=XhGBaD8FY/Lx51w6XesX96JkFnVl6xY/Ir3YL+37H5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3B2CK7nIY22iV/0c36NUfPj4ictuNTwoHakU4tR/S4eewcJf+f2bKcA9nkIIFvHAvB6w2HO3JQfkWn2l9pLWs/CMcbCMctJlD/M2FDDuJLI+PbVJ0R71SpIA13dw2Gsn0ZBDSdUJD5Ro8xjR6WGMQfYxDZpnVbxKGgrOaqYOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM5VHh7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886FFC4CEF7;
	Wed, 14 Jan 2026 11:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768388975;
	bh=XhGBaD8FY/Lx51w6XesX96JkFnVl6xY/Ir3YL+37H5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM5VHh7QQ+7WqR4uLOem5QwKsanjfislnm1fyE0yteyhrw0LXGLPkFnHYFRM2Juxq
	 uTylynoPiFkHlVJ1gws7CIdnoaqlYi748zC89V+4dGeMY/w9G1+tT9z4hTGvT7fCzK
	 fBHgbXLsX5O4G9QS/2z4iNt4Qgx5wv2JCe66JsEL4T3exu33qhE5eQ18HhGjrRd7Os
	 1r7GJFlPRWmqe4vytvow/8mtQ747tJPfd/pIapPhAi5TGs1BmBK5yaOjZtJyuoj2HU
	 YEgT3nUG3WPXboR8ZMFvHOrBrV97RwwSn9KqiGMnvjgr1F79XUosWqF9jndfCy5b05
	 xiq3MtWbhhm6A==
Date: Wed, 14 Jan 2026 12:09:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
	Lee Jones <lee@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: max7360: populate missing .sizeof_wfhw in
 max7360_pwm_ops
Message-ID: <k2igxghpj53l25dupkgh67tasxp4jynj2owy7le4mlchrbrskd@zufor7a6kzqx>
References: <20260113163907.368919-1-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ayxlv3uhydn3sfiv"
Content-Disposition: inline
In-Reply-To: <20260113163907.368919-1-richard.genoud@bootlin.com>


--ayxlv3uhydn3sfiv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: max7360: populate missing .sizeof_wfhw in
 max7360_pwm_ops
MIME-Version: 1.0

Hello Richard,

On Tue, Jan 13, 2026 at 05:39:07PM +0100, Richard Genoud wrote:
> The sizeof_wfhw field wasn't populated in max7360_pwm_ops so it was set
> to 0 by default.
> While this is ok for now because:
> sizeof(struct max7360_pwm_waveform) < PWM_WFHWSIZE
> in the future, if struct max7360_pwm_waveform grows, it could lead to
> stack corruption.
>=20
> Fixes: d93a75d94b79 ("pwm: max7360: Add MAX7360 PWM support")
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/pwm/pwm-max7360.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
> index 16261958ce7f..732969303dd7 100644
> --- a/drivers/pwm/pwm-max7360.c
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -153,6 +153,7 @@ static int max7360_pwm_read_waveform(struct pwm_chip =
*chip,
>  }
> =20
>  static const struct pwm_ops max7360_pwm_ops =3D {
> +	.sizeof_wfhw =3D sizeof(struct max7360_pwm_waveform),
>  	.request =3D max7360_pwm_request,
>  	.round_waveform_tohw =3D max7360_pwm_round_waveform_tohw,
>  	.round_waveform_fromhw =3D max7360_pwm_round_waveform_fromhw,

good catch. For the reason stated in the commit log I'd not consider
that urgent (so I won't bother Linus with it before 6.19).

I applied it as is to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

=2E But I'm still taking review tags.

Best regards
Uwe

--ayxlv3uhydn3sfiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlneWkACgkQj4D7WH0S
/k7/rQf+MdCtI7v8onJHKYcMzyAW6banwqnaSjbRNVgF0LKek0231CdQR2d4z7R2
nG8930Fu/iLDMuqxcXZhPFkqrgvI2i4DHbpWWGpyqxuY1d/ZentCyq90rpgfXgPN
KAFo7+pBo9NpxyDyuvrD4CASzAJ5GdOTDQlM6CJKnSuNxvxyhjsIhSmQ9J/ov58w
WKLtZSXIE59M4rjYyjeH2EF/KIYmTF4RkqE0pb23tBlYtKgzejMer5NCe4WmGKOJ
zlIcPgdAwFTwPKwCUEGWV2Dv/mZ+yIbFqWaRmF3crRX28LJSW+F2n+zCuBFk1Jln
MqGLmuV0YSTRvihAHT8+rklEHFGudQ==
=ZtjM
-----END PGP SIGNATURE-----

--ayxlv3uhydn3sfiv--

