Return-Path: <linux-pwm+bounces-4383-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22A69F502F
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 17:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE8C7A57C7
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2024 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AD71F7078;
	Tue, 17 Dec 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4tBmVlf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05B1EC4C3;
	Tue, 17 Dec 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450384; cv=none; b=RRBo3BEB7aq89JajcgjXQexkHvtea6gbseLjCGODjYXdU4wKmE88wRarQ7vzIlik4xtreoX3JqdFw1Jr8qFkvhmYWFo1wOPdCQL9bNrk86B127qSvXz8eYOL6XnY2GIsHNmj4yzRvHk00LZruEE5ilYL/bWtyoW4eszLv6fE8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450384; c=relaxed/simple;
	bh=ru/q+OLGAIOy3QN6Qk2nhuzxbhuGYxQydpgLzzKFXdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luCIj7Og5fYNrjy3Ea7RG3fdc5XR8R14zVdoaqJ95EU4S4J00NNNbv9G4Uz/UsnFsy3LKY1EjQ9S1osrKmCtwhcDqMYRsmHwoY8V3P/UgbdliDGkz2DbHLMw6yU8F232ZH9xUEo5K3VGY2uVdxkDbIL7Fz/aDoDBBiVOFVJP8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4tBmVlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F786C4CED3;
	Tue, 17 Dec 2024 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734450383;
	bh=ru/q+OLGAIOy3QN6Qk2nhuzxbhuGYxQydpgLzzKFXdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4tBmVlf2a9CV2oWg8wZRHGKdVamvAT4WqSZfWlCDb+hK6/pA+pcZMe3hRlC0q6GG
	 D4DdkHQRibVHNIXDxlP4HkGR+Tmm7zZKibNYyT3Le0eSR+0zGJLJ6frkbzH6SlUIec
	 kmohquthw4MuVytZTMmvw3jaC/sJTKbRwROGG9SX5lCBSyXBsfoXkS6/u/oWYcFvo3
	 vXW2O5DRUG/3HdweNMCM1OYITNF5jjTVPGVnRApRz7jrmtv7JfsX6mcN4lOsWoryUN
	 yqmx5Gb9cqBNZR3Oa01fB7fx4+xQzuoiRT4e9Gahdol43ZCHcYSIBgcWcEl4Qk6VgI
	 j9NZZ7Ta+ZIpQ==
Date: Tue, 17 Dec 2024 16:46:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: alexandre.torgue@foss.st.com, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, olivier.moysan@foss.st.com
Subject: Re: [PATCH] pwm: stm32: fix complementary output in
 round_waveform_tohw
Message-ID: <dwwbefhhvjczcakd4nrrunzoq7mhzwrxxpm7gdtabgm6flk4cp@5w4usax4n67h>
References: <20241217150021.2030213-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qbozxwrmepqihx7u"
Content-Disposition: inline
In-Reply-To: <20241217150021.2030213-1-fabrice.gasnier@foss.st.com>


--qbozxwrmepqihx7u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: stm32: fix complementary output in
 round_waveform_tohw
MIME-Version: 1.0

On Tue, Dec 17, 2024 at 04:00:21PM +0100, Fabrice Gasnier wrote:
> When the timer supports complementary output, the enable bit is
> overridden. It should be OR'ed. This makes all PWM channels for
> such timer not to work.
>=20
> Fixes: deaba9cff809 ("pwm: stm32: Implementation of the waveform callback=
s")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index b889e64522c3..17e591f61efb 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -84,7 +84,7 @@ static int stm32_pwm_round_waveform_tohw(struct pwm_chi=
p *chip,
> =20
>  	wfhw->ccer =3D TIM_CCER_CCxE(ch + 1);
>  	if (priv->have_complementary_output)
> -		wfhw->ccer =3D TIM_CCER_CCxNE(ch + 1);
> +		wfhw->ccer |=3D TIM_CCER_CCxNE(ch + 1);

Oh, indeed. Thanks for the fix.

Applied to=20
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes
and I will send it to Linus later this week.

Best regards
Uwe

--qbozxwrmepqihx7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdhnMoACgkQj4D7WH0S
/k42SAgAukU0izAyfSfEHr+srRGWulhaFMrUOYDLRgBWAa5ELJaS/8gHKrhtj2om
rFl31JAs/8uiXYgP2w4Wlui1qJma5JH1qWpDjAsYxepnNRJMWENSjjiU/I8lKiiJ
Mk9cKUV4uZlrG/wWNso9OnNNQgeQgjysqkEvcbWdSTza65lZMKLMjy4ar2aLVCIQ
wP94l6Fe3WFDvoedqb2jMlGOIbbOYxV3zxeec91jo3AJMIAGXVwFngeU1sKNqSgR
ReR741ODSY7Alqjm6RpstItWz4nR0J+cdYwnAffA/J7UBQGlKZ+sfK/U8xrfS0YZ
v0QpIr5tXXha04SFh12DaiQ2aztudg==
=DF95
-----END PGP SIGNATURE-----

--qbozxwrmepqihx7u--

