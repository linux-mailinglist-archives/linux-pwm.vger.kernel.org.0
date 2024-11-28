Return-Path: <linux-pwm+bounces-4152-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6E69DB52A
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Nov 2024 10:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EABB214CE
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Nov 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD015748F;
	Thu, 28 Nov 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3+6ooN/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332F5146D45;
	Thu, 28 Nov 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787969; cv=none; b=KtFJOE0VV61M3h1s1vySTEkv2TX/Ok8qZbbHfC1oF0XmjkfHmQHdxogmxDsQ0g9xAZxOrFIugoOJ9PnhJAeQZ8NLhatvsvwkTs4ZTpC7CbG14Faaj4lSiWD5Aj1DHnBfra+U/ahV/sAVYa/A+o0aV+u8cmHMb9uSQp25BZnHgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787969; c=relaxed/simple;
	bh=mIOuMIbEcaPfpC2aoAeGW/bwKGeXMijUHn52HORUdEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sU/KAu0eHMMwBsdacn8D9sx1mjkewXcLzte+CSwacf+0NZnu/vlZfULSORZFnCUqHggHH1npp4r7SUC71rcFsPvfE9MuQWmQSNcpkBUgKL3UIQBQ22f8aGLu08B+LETcXslQqY+GMl+GyUJGbmeIxFiZ9ejDavmuPIBU2Cldvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3+6ooN/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54335C4CECE;
	Thu, 28 Nov 2024 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732787968;
	bh=mIOuMIbEcaPfpC2aoAeGW/bwKGeXMijUHn52HORUdEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3+6ooN/lEa12EDB8FFl3CO8hTOsv92PtUeItEFpHFmx6bImRdF7pErQs7mJCkV5Y
	 9qkAvP8VwnOfNq7jBpj6MO7djDV6ESq8Y92AEZAmQL7puIEqi9aXL2cbzCrxvPTW8/
	 j8b6hMLkHq8IC9qyJU4hlAgSnOi+Zx2wjoLm+ymt41WLODPQUCsx6q9rDmPylq3/qz
	 2sMA9dvCm9hflrU8qNo4lrBfLsnpzf+xEIwNiiPK7QGrOtGgLlCvzq3JTrPx5V4num
	 bF9mgJV9ytpcsFjZRPUixrUD8TPnt9O8sLC8NwInn+RPGUkStWRS+M0zMxxf+5qKgP
	 KjT4vfnATFXMw==
Date: Thu, 28 Nov 2024 10:59:25 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: improve state handling in ehrpwm driver
Message-ID: <eobcrbxmtyxv4x5dkgxf2sssgjefqbhit3tsnzizdel2aqzynq@opsqlav5zh32>
References: <pujikyjijvcn3mmlayqmdkh5zyjqdrfmmz3jafxyhdhuo5ekam@ntttaqiw7iow>
 <20241127222649.6394-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a357774gghswhkum"
Content-Disposition: inline
In-Reply-To: <20241127222649.6394-1-rafael.v.volkmer@gmail.com>


--a357774gghswhkum
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: improve state handling in ehrpwm driver
MIME-Version: 1.0

Hello,

Subject should use "pwm: tiehrpwm:" as prefix, then drop "in ehrpwm
driver".

On Wed, Nov 27, 2024 at 07:26:49PM -0300, Rafael V. Volkmer wrote:
> Introduce ehrpwm_is_enabled() to verify the module's enable/disable state
> by checking the AQCSFRC and AQCTLA registers, instead of relying solely
> on pwm->state.enabled. This ensures a more accurate representation of
> the ePWM state in the kernel.
>=20
> Previously, when performing fops operations directly in kernel space
> after retrieving the platform device (pdev)=E2=80=94bypassing the sysfs i=
nterface=E2=80=94
> pwm->state.enabled could incorrectly signal transitions between active
> and inactive states, leading to inconsistent behavior.

I don't see a problem in this driver but I wonder what you do trigger
the problem you're describing. Are you saying some other driver calls
ehrpwm_pwm_apply() directly bypassing the pwm core? If so: Don't.

Otherwise I'd claim the only place where state.enabled can get out of
sync is during .probe(). The driver might need something like:

	if (hw_is_enabled) {
		clk_enable(...)
		pm_runtime_get(...)
	}

there and an implementation of .get_state(). BTW, .free() looks wrong; a
driver isn't supposed to make up for a consumer failing to disable the
hardware before it releases the pwm handle (but that's orthogonal to
your problem I think).

Am I missing something?

> [...]
>  static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pw=
m)
>  {
>  	struct ehrpwm_pwm_chip *pc =3D to_ehrpwm_pwm_chip(chip);
> @@ -404,7 +423,9 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  			    const struct pwm_state *state)
>  {
>  	int err;
> -	bool enabled =3D pwm->state.enabled;
> +	bool enabled;
> +
> +	enabled =3D (ehrpwm_is_enabled(chip) | pwm->state.enabled);

|| is the right operator for bools. No parenthesis are needed.

ehrpwm_is_enabled() should never return something different than
pwm->state.enabled. This is the thing you need to address. Don't paper
over this.

Best regards
Uwe

--a357774gghswhkum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdIPvsACgkQj4D7WH0S
/k4Dwwf+KAtUullZJlqR+XtK+W/YsDeznAbuSY5rf+JWGGkXd3TnSXO5+u4NRxfD
rKUdDsKSkdr5q6JL9MHd7q07V+GV62n7ddW+x3Ntmh+AqEdIw7e7O9WQ7aL2+Ix8
LYgPzFX18JhOjig6SXaWVpjc7T8MSaXbn2HeU6o8iEPu8uuQFLf9NakgSJjsKZKd
aAWdYJUbDhm39C5tPbZYbvRC3dPWmN6Ewy9WSRuqmmjeJb7VZS++srlLUHhhthrP
RIZa6oIBaUHw6QHDC2xnFG8xB8xgSaDPfaZL3KACnZ6Ay+QnP3RfoUDyMezrz9MA
Ht2R+1T65xGGGOvqByVuwVtM/58dmQ==
=i4n+
-----END PGP SIGNATURE-----

--a357774gghswhkum--

