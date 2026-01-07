Return-Path: <linux-pwm+bounces-7862-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B24CFCFB7
	for <lists+linux-pwm@lfdr.de>; Wed, 07 Jan 2026 10:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0EA730022FF
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jan 2026 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01A3074BA;
	Wed,  7 Jan 2026 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="td8h4KAT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB83043DE;
	Wed,  7 Jan 2026 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779482; cv=none; b=r3tsFm54tylJvdCARpRZmgHJgIVJR/ZcE6g4oHAepVxhruOMItalLEAoRlGhojF8omHW9koHWpL6a2CuUZ9TpqJJyJk8PQQk/GoNmU3Y+yrOgXedrpZXh6IbJy5Yk/opFIV9dB2Y8OnOpWbXlzu0oHb0l09RoOaQxqR/ADpUkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779482; c=relaxed/simple;
	bh=JbDXWjc9Cc3PvN2a+pMcI+CRnS6UrCPygf5Pp4mqr9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAeCkYtjTYZ94sza+Fk3hX69EAJnuilkWiwHzwsB7uASOre8VclrOzf2EQOXyRI1qDfCbs3q0bD7UBVDqJ9rhNzyzkogdMojQywIahOqcG48Q9L6tvFsUeqbEGwpncFFyHdME+IBLSPohXCPXo3nE08669SVcy4fYG0dSZ1naAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=td8h4KAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCFDC4CEF7;
	Wed,  7 Jan 2026 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767779481;
	bh=JbDXWjc9Cc3PvN2a+pMcI+CRnS6UrCPygf5Pp4mqr9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=td8h4KAT+8bw/ZuTUaanaHyyAxMj0IfjPe+wLEWV04zT9E0NIR70IJkWw7JGFucAB
	 9COcSYXq4vinEDm8Cd8WDsH++rs1M+cANNlZsvqkmQf0FgHP/ZesHXSmR13LN8Xd8O
	 da7/gVZGHImE2zGpuntiyWIKSqlRCeWZxafuPYq3w9Laful8vThPKZK1UceJUVEw26
	 JHDIpUtGuXNMTehGhK/qMAyvWfNeGNdTk+mABuJxRZZk/78MXuQiz8MMpi+ThqlcgV
	 ZjaCrPX7JAPH0jHVleTSOGarOMkC8NWfDy4Bb3PvcWBPqCsgcUe9rp+dot8akbsM27
	 xm7BIUsDZyzXQ==
Date: Wed, 7 Jan 2026 10:51:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Gokul Praveen <g-praveen@ti.com>
Cc: j-keerthy@ti.com, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, u-kumar1@ti.com, n-francis@ti.com, 
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
Message-ID: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
References: <20260107055339.10999-1-g-praveen@ti.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jrf2dw4qccz4rtmp"
Content-Disposition: inline
In-Reply-To: <20260107055339.10999-1-g-praveen@ti.com>


--jrf2dw4qccz4rtmp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before
 setting configuration
MIME-Version: 1.0

Hello,

adding Rafael to Cc: who sent a patch series for this driver that I
didn't come around to review yet. Given that neither he nor me noticed
the problem addressed in this patch I wonder if it applies to all
hardware variants.

On Wed, Jan 07, 2026 at 11:23:39AM +0530, Gokul Praveen wrote:
> The period and duty cycle configurations does not get reflected
> after setting them using sysfs nodes. This is because at the
> end of ehrpwm_pwm_config function, the put_sync function is
> called which resets the hardware.
>=20
> Fix it by preventing the pwm controller from going into
> low-power mode.
>=20
> Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> ---
> v2 <=3D=3D> v1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Removed space between Fixes and Signed-off tag
>=20
>  drivers/pwm/pwm-tiehrpwm.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 7a86cb090f76..408aed70be8c 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -237,7 +237,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	if (period_cycles < 1)
>  		period_cycles =3D 1;
> =20
> -	pm_runtime_get_sync(pwmchip_parent(chip));
> =20
>  	/* Update clock prescaler values */
>  	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
> @@ -290,12 +289,11 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	if (!(duty_cycles > period_cycles))
>  		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
> =20
> -	pm_runtime_put_sync(pwmchip_parent(chip));
> -
>  	return 0;
>  }
> =20
> -static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +				const struct pwm_state *state)

With this function also caring for *state the name isn't appropriate any
more.

>  {
>  	struct ehrpwm_pwm_chip *pc =3D to_ehrpwm_pwm_chip(chip);
>  	u16 aqcsfrc_val, aqcsfrc_mask;
> @@ -304,6 +302,13 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, =
struct pwm_device *pwm)
>  	/* Leave clock enabled on enabling PWM */
>  	pm_runtime_get_sync(pwmchip_parent(chip));
> =20
> +	ret =3D ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, =
state->polarity);
> +
> +	if (ret) {
> +		pm_runtime_put_sync(pwmchip_parent(chip));
> +		return ret;
> +	}
> +
>  	/* Disabling Action Qualifier on PWM output */
>  	if (pwm->hwpwm) {
>  		aqcsfrc_val =3D AQCSFRC_CSFB_FRCDIS;
> @@ -391,12 +396,11 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  		return 0;
>  	}
> =20
> -	err =3D ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, =
state->polarity);
> -	if (err)
> -		return err;
> -
>  	if (!enabled)
> -		err =3D ehrpwm_pwm_enable(chip, pwm);
> +		err =3D ehrpwm_pwm_enable(chip, pwm, state);
> +	else
> +		err =3D ehrpwm_pwm_config(chip, pwm, state->duty_cycle,
> +					state->period, state->polarity);
> =20
>  	return err;
>  }

Why are the changes from the two hunks above needed? Reading the change
log I only understand the first hunk and would expect it to be enough.

Best regards
Uwe

--jrf2dw4qccz4rtmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmleLIoACgkQj4D7WH0S
/k5MqAf+L3bCPbs74eWkt649O67EuS+84QQKD9fn9u2sp+OIPTB0ft7NwFHdbPDx
jIENVXx6UwhaBLW8qIlTvxm+PlFpNX+WlmC0VDeKlQPKqyfoVByKTNDH8ChtPI81
GN6JI0F2OXHbdgacB186cxMimjGgTcr8KO9C9htgGzuDhq2s+nThphu59LMi2ZIw
ByZk+nhRUSB8ukw/76EV1rdHgWG1cWasidUxJ3IaCIWCCVDce3pssXJgCY6kq9nj
IVGX+s7Q01xKCAJcbstqXFDuIF4Hb/8QQovTjYMa6bDXqGlW0YXoUerEZhahKoQA
no1eAAl5aj5dYxejHhMDTOU/DHkm/w==
=3v78
-----END PGP SIGNATURE-----

--jrf2dw4qccz4rtmp--

