Return-Path: <linux-pwm+bounces-7271-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF91AB4AAEA
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFC71BC353C
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15131770E;
	Tue,  9 Sep 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMJGue0l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14B2882C5;
	Tue,  9 Sep 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415168; cv=none; b=DJQyaJ+JCdeYl2uLIHLTXDRKTuU8FTunPozV6G8d77sJl+TnMsFkvh2OtkRa6ysMWA7A3ExLfrcqwHBqjRbMRROjuJ0DaxYujPbg5sGuJ6XLiZ8wHvsnh7vv5UXiLmZhsM9X0VxRZBvprJFMxZgFbJC230gySAlEi318PnRvKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415168; c=relaxed/simple;
	bh=RuzkZqY9TDl0xwHTbArVdSoYhdyCPv5S5kmfGZYTMNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW26f1pJRNQY9b3J8K0Fd3YSP6BgvRlK6b6Zku7/L37ZLPCEsoqfhMR2QlUdcO1DB9eGZ8KTUHu1pa9WDKjKHcOCs1VSS6lzDrbBDJQDuTS2cANLYobSjfai3OyjlTXCQhSR8GrRoIF7Ka53c6Neh1l3Y0fGNfc1p4o7cAdidBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMJGue0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B2BC4CEF4;
	Tue,  9 Sep 2025 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757415168;
	bh=RuzkZqY9TDl0xwHTbArVdSoYhdyCPv5S5kmfGZYTMNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMJGue0lghRR8rLcysCM9hOWVYraYSuvfzRxx82TRj2STvIqqKIGrupZcQDbdAHBJ
	 f0tlYGW9+I8IZz/Aeq0r0sEM3CC49FVHlwdo/yjnjAB4doBDQqcb9hD0AR9WxEXIgp
	 odcl+ElIn8G3HXwzbXfF0B4P33mQKNpBwmGc5k1vIDxYOP3KoZH1ZFALysHvdHGiOl
	 6hRsCUyjl6WHpHoTJLlZB11/wmhHqH2QpkOJAIJv4+XVq/EPCB00ATyeX8rT4cNQ4O
	 pzroQK5WuZcywWR9TXbC5D4nhn6Aaos3BRHpfsRnTajnb7St6PMgJwgh8ratA4aA58
	 oe/6g40OtmiIw==
Date: Tue, 9 Sep 2025 12:52:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] pwm: Fix incorrect variable used in error message
Message-ID: <52u2odvlsut2efemijiewh5gzfkvq6dj347fojrvytrjpxq76z@5isb6opneofo>
References: <20250902130348.2630053-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4hwofridi3bqaue"
Content-Disposition: inline
In-Reply-To: <20250902130348.2630053-1-colin.i.king@gmail.com>


--t4hwofridi3bqaue
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH][next] pwm: Fix incorrect variable used in error message
MIME-Version: 1.0

On Tue, Sep 02, 2025 at 02:03:48PM +0100, Colin Ian King wrote:
> The dev_err message is reporting the incorrect return value ret_tohw,
> it should be reporting the value in ret_fromhw. Fix this by using
> ret_fromhw instead of ret_tohw.
>=20
> Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for wavefor=
ms")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index ec4112e6209a..ea2ccf42e814 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -276,7 +276,7 @@ int pwm_round_waveform_might_sleep(struct pwm_device =
*pwm, struct pwm_waveform *
> =20
>  	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ret_fromhw > 0)
>  		dev_err(&chip->dev, "Unexpected return value from __pwm_round_waveform=
_fromhw: requested %llu/%llu [+%llu], return value %d\n",
> -			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns=
, ret_tohw);
> +			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns=
, ret_fromhw);
> =20
>  	if (IS_ENABLED(CONFIG_PWM_DEBUG) &&
>  	    (ret_tohw =3D=3D 0) !=3D pwm_check_rounding(&wf_req, wf))

Indeed, thanks for the fix. I added it to my pwm/fixes branch at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git. I
didn't made my mind up yet if the patches contained in there are
relevant enough to send it to Linus before 6.17.

Best regards
Uwe

--t4hwofridi3bqaue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjABvoACgkQj4D7WH0S
/k6Diwf7BfuMcnZqdITnmfwsZKNhVwHOt65eKj51sa7TnUxPF/aTl/H4dL2LBEZr
elekmMbX+XmzCwfGNF9MsGFA/4HTzySLLv2Gmmdb1DZEZsVvcn54B+qQIXzF/lsC
U25y6UQcDSypUPfxnSPzqQ/wOALtH3BTDr8Q/SVmz7Rwb8d8DSssb08dvZXuSHuM
NDXCohKypnhJ12RDfcsoX6ormIt4QTrKihhOyVB01VshJ6WVcxtCkllFM00t8TrZ
2B5KO3asVkzaBe4uOK0TRfgiiu/w0nVcEtSg9zmtvUjOO21GvaN65H0QOfiTolNg
qG4XQMY83UT8aYJ+lV5LOA40Ep3oZw==
=sm8Q
-----END PGP SIGNATURE-----

--t4hwofridi3bqaue--

