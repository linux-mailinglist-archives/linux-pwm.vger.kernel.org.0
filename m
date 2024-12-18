Return-Path: <linux-pwm+bounces-4394-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CCD9F6252
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 11:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422251891DAD
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Dec 2024 10:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C019884B;
	Wed, 18 Dec 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBoT5JfE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8BE175D2D;
	Wed, 18 Dec 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516306; cv=none; b=LSTIbi93lELDIrXARKFRScenNoJXy0KQ5dZgy/SsVdT3O3X4u691BVnsEt3Cj6cCrlnGnTiXAyz5V07iM8dGAD09Cro1VirGgI2tEJRFHHoUsA3tpiiIkXC9MxTJCyF4TpEkxVEStUBgb2ug11B5ce3+sL/xMq/E63uu7Yr6zM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516306; c=relaxed/simple;
	bh=AvgDaXHtwbjGpgaswDIE8L8Q79jWldOS8jXiymOqhVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwT81RMOb75siRTxeUGBcRIKhqIZ7ZVuN1MwXs/av8jYkyY967fRuXEVWojfWrHaGqEJDMlJf2a4dou/XbRoaLVsQILsM7/P0T1yh8uDhgMfvaejmxph3p/gbS3Hm/6rHWpgLMuoOSIhJ06ohFNMMugvZCzN6HYRCApjzXlVX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBoT5JfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61230C4CECE;
	Wed, 18 Dec 2024 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734516305;
	bh=AvgDaXHtwbjGpgaswDIE8L8Q79jWldOS8jXiymOqhVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GBoT5JfEG3pfz6gRlPYib7Y3mQXMytM4776pg7n11Ax/1FB1gGF4PuUGD0pu+/3M1
	 fTdCR0peOq3XVYYzqgR8vTrocVlKfazgleENOepmy9l6Y+0M/G/HgcSs0NEXyhFhKi
	 qCamv4C0sLyGxCYRNzV/XM2xd47k9vsx0M66oZduxJLuHnahexO0GL3uauj8eWoKsW
	 ApyVzOM0NrEciAyArjzoJrM4Rd0mPQYYo46g3DWVWeAq/YEjyTsOGEfEDm6p66i/Da
	 SpZEfRYPaO3SWX+ZRaCiTp3oy8IUamFvJX160Qyzu/CwVRUAlyaOtIeGzrbo40jRNW
	 bk70WqLac5pQA==
Date: Wed, 18 Dec 2024 11:05:03 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, alexandre.torgue@foss.st.com, wbg@kernel.org, jic23@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	olivier.moysan@foss.st.com
Subject: Re: [PATCH 5/9] pwm: stm32: add support for stm32mp25
Message-ID: <lptm6gh2lzjqxm26lbmdw4yr2fowo6ytxwzqwl65khrx5xpcox@u25yzz6ssdy5>
References: <20241218090153.742869-1-fabrice.gasnier@foss.st.com>
 <20241218090153.742869-6-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4ocvksavacg3j36"
Content-Disposition: inline
In-Reply-To: <20241218090153.742869-6-fabrice.gasnier@foss.st.com>


--o4ocvksavacg3j36
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/9] pwm: stm32: add support for stm32mp25
MIME-Version: 1.0

On Wed, Dec 18, 2024 at 10:01:49AM +0100, Fabrice Gasnier wrote:
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 17e591f61efb..99383e09920e 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -19,6 +19,7 @@
>  #define CCMR_CHANNEL_SHIFT 8
>  #define CCMR_CHANNEL_MASK  0xFF
>  #define MAX_BREAKINPUT 2
> +#define MAX_PWM_OUTPUT 4

I would prefer a less generic name. Something like STM32_PWM_MAX_OUTPUT.
=20
>  struct stm32_breakinput {
>  	u32 index;
> [...]
> @@ -790,11 +800,31 @@ static void stm32_pwm_detect_complementary(struct s=
tm32_pwm *priv)
>  	priv->have_complementary_output =3D (ccer !=3D 0);
>  }
> =20
> -static unsigned int stm32_pwm_detect_channels(struct regmap *regmap,
> +static unsigned int stm32_pwm_detect_channels(struct stm32_timers *ddata,
>  					      unsigned int *num_enabled)
>  {
> +	struct regmap *regmap =3D ddata->regmap;
>  	u32 ccer, ccer_backup;
> =20
> +	if (ddata->ipidr) {
> +		unsigned int npwm =3D 0;

No need to initialize npwm.

> +		u32 val;
> +
> +		/* Simply deduce from HWCFGR the number of outputs (MP25). */
> +		regmap_read(regmap, TIM_HWCFGR1, &val);
> +
> +		/*
> +		 * Timers may have more capture/compare channels than the
> +		 * actual number of PWM channel outputs (e.g. TIM_CH[1..4]).
> +		 */
> +		npwm =3D FIELD_GET(TIM_HWCFGR1_NB_OF_CC, val);
> +
> +		regmap_read(regmap, TIM_CCER, &ccer);
> +		*num_enabled =3D hweight32(ccer & TIM_CCER_CCXE);

So the part that determines *num_enabled is the same for both variants.
Maybe it's possible to share the code for that?

> +		return npwm < MAX_PWM_OUTPUT ? npwm : MAX_PWM_OUTPUT;
> +	}
> +
>  	/*
>  	 * If channels enable bits don't exist writing 1 will have no
>  	 * effect so we can detect and count them.

Best regards
Uwe

--o4ocvksavacg3j36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdinkwACgkQj4D7WH0S
/k7nywf+JjLEk4Gaee/ADgMvYOiBEUH8OA9/D7Ae1isx7Ve33iUPYu57fZCQFdJ9
7ah0kiX1U5gsFd96TlfydpA3EjhrHr/t8DKL5ZL9WWiKPi68Bb1HM/MZrnh641TZ
xV6o0+OlYihaqYZpJkt93x0TXdg4+KR6PWk5aSVf47bWNC3jg3n1gLADY8GIKl/Y
Sk/j12ktASXSCxNOscdwhwdyNIHCbmH/rU3FA8lEA1H9/5UZ5ljUoZRxBeqDqptz
Qh4YiPPr1fs24A0/z4uh/W3CMkLkW8RXCCffGQprrejK0O1cb6JNhnAiMNZBLbcC
Wc1T1qulU2XYmW7Of1S4WCcelNWE+A==
=WbTY
-----END PGP SIGNATURE-----

--o4ocvksavacg3j36--

