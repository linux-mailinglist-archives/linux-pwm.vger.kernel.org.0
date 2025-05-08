Return-Path: <linux-pwm+bounces-5847-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4778AAF514
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725443A4410
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70721018F;
	Thu,  8 May 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjVNolHG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D2205E3E
	for <linux-pwm@vger.kernel.org>; Thu,  8 May 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746691133; cv=none; b=rVbYdulOXbrzhj1LFAcxRutXMetGBeH0kkGO5UivqnHi1kJKz0QMYEnefOQvN5GxkRZeuejwF7x9QqCnG2/xh6EoPs99oVbV+Tu0RijpWF0eXyri7GFC7BekyVHuZ57UIRewwBqdJ4W/e4kkbeqLutUeuf8LKNOcJrYmxyn44H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746691133; c=relaxed/simple;
	bh=MHYw09iTl1Ttyjs8n/wS4IqiUAUqTd5DKOvhw0uLSy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8A9HaDjHM+UXaNueOhmoRbKMAM+YQnu59h4ukjvg55Pw9eMCwpBfed2ILT6QFE5LEayJ5CkgB3LzEgHNeg3XZW7C6LtVKEsmiPscCm+Rz3YU8zNoZD0zUGSEXXGFEBp5tmy0KvJZ/QXn335NHxMYERXQItEeayGM5jOQDP8Kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjVNolHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3205AC4CEEB;
	Thu,  8 May 2025 07:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746691132;
	bh=MHYw09iTl1Ttyjs8n/wS4IqiUAUqTd5DKOvhw0uLSy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjVNolHG8bomFaGoUiaoX3gEQxUdakURDmmiVTD/bNP4iagjFedD792Q2VN5SPzNp
	 2Z5GAhgYf5vR5ENGvai58Itnkbq7Wq7QvllxXhRlPjHNVMBFRV/mMb6KKjj0GMyAWS
	 74d/eyP26kr+DaiiggZtP1oUZ17V9AfeILXx6OOyy9jNYE/Qj2ZppaMNNJztQ0EmZC
	 OhkRle0EX6vmBDhbz+fWmYhZD8AGpqYaR65CEZRT9QrJxosFAY/tpjFQsFpHVFKQ27
	 ZbvIvLTmZ6zJKQaGkoWv2fHuIWqVLXRvFtjFe73MmtELPF4pK43ccF7ElnAWuq67+Q
	 gntgXIHSpxoZQ==
Date: Thu, 8 May 2025 09:58:50 +0200
From: =?utf-8?Q?=22Uwe_Kleine-K=C3=B6nig=22?= <ukleinek@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: tidyup PWM menu for Renesas
Message-ID: <odkmm5vr5sav2e2bithwpwjlscw3annav5ccbtbnllyyfjialj@yfhbuac54xcb>
References: <874ixv3nqz.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gvvran7xo7e5luei"
Content-Disposition: inline
In-Reply-To: <874ixv3nqz.wl-kuninori.morimoto.gx@renesas.com>


--gvvran7xo7e5luei
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tidyup PWM menu for Renesas
MIME-Version: 1.0

Hello,

On Thu, May 08, 2025 at 01:16:52AM +0000, Kuninori Morimoto wrote:
> Current PWM Kconfig is merging Renesas and Rockchip. Let's tidyup it
>=20
> =3D>	[ ]   Renesas R-Car PWM support
> =3D>	[ ]   Renesas TPU PWM support
> 	[ ]   Rockchip PWM support
> =3D>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/pwm/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..6cfd1172a727 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -532,14 +532,6 @@ config PWM_RENESAS_TPU
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-renesas-tpu.
> =20
> -config PWM_ROCKCHIP
> -	tristate "Rockchip PWM support"
> -	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on HAS_IOMEM
> -	help
> -	  Generic PWM framework driver for the PWM controller found on
> -	  Rockchip SoCs.
> -
>  config PWM_RZ_MTU3
>  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
>  	depends on RZ_MTU3

Hmm, that file is supposed to be ordered by the Kconfig symbol name.
While there are a few offenders in the file, ROCKCHIP is correctly
sorted between RENESAS_TPU and RZ_MTU3. But I agree that this is a bit
strange.

Maybe rename PWM_RZ_MTU3 and PWM_RZG2L_GPT to start with PWM_RENESAS and
then have the sort order of symbol names match the sort order of
prompts?

If you respin with that change, please base your change on next because
there are conflicting changes. To make it explicit: I won't apply the
patch as is.

Best regards
Uwe

--gvvran7xo7e5luei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgcZDcACgkQj4D7WH0S
/k4qzwf/TpGGurT/5LI6WWEfir4ThzTYRp6VH/spYzMQ08QjG4szBP1h8Adcgi3X
E/vOtft+drvN087pRDeh1NENJlcssfdQEOrEAQ2IyZL4mz5RTZpqiWE7tEkol7WM
kP87gR4XmoHwYnO9+6tB0APWM2QNY8Abr2jGgDtZQWTOy7e8o4djbOEFhjUqgpZd
RuF5KFRiINAhQhgbzQ6ROJ90vQaccaoHmf+ov6vORKzFuH8Lew/VVaT6vI2YbL8I
5+aHMIk42Ci0W0KUOuo+ERzw9rj9+O6IrYUgTIdkXlG4shQcCxH3J0G1+Ca0z5+T
i0d3DNXfZqcDfYNQibpQTVRpGNAo+w==
=QQZW
-----END PGP SIGNATURE-----

--gvvran7xo7e5luei--

