Return-Path: <linux-pwm+bounces-8566-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNY5KBew3GldVQkAu9opvQ
	(envelope-from <linux-pwm+bounces-8566-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:57:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB56A3E96CE
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51AE5301C593
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Apr 2026 08:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F13AE1A8;
	Mon, 13 Apr 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Kc/F4O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5E3AE188;
	Mon, 13 Apr 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070506; cv=none; b=cBzbJoZvdyBfUGGg4BbvvH6tYZ0M2Stk5DS5RbpVWMp+Q0x/hQzgMGpfqxHQhSkhdrmKDls+C2warBLwvYXe3V/hSXwbnAT8UdG4+Z0PlM3WjZcvuj8MndrtFdC71u7ePVj0mWJyE7QZYgw10zvnKVdxahMDuuF4xAYLlYnjTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070506; c=relaxed/simple;
	bh=MnXbCdsjlvyvs9JqkHFM6tGL70LIXsHZjV87wjkRqjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ao0OlDLSa65kL2xz1DauMRCQo1CG5LEc70J8s40RoBwGOXdWmMOna4Guf+gabBP77KjLJdZEQjG2/YfcE7hR/3MTvycnsxN+LtNGj2PHtTmZ1/Ml5AH2cPW6WaUzeCXzCHt6+uu2E4ldmQBsFH1MY4WaJsC5WGAjBxBK93dbZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Kc/F4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F110CC116C6;
	Mon, 13 Apr 2026 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776070506;
	bh=MnXbCdsjlvyvs9JqkHFM6tGL70LIXsHZjV87wjkRqjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4Kc/F4OU4saMe+vQG/0hl2CUrlQBpNgvdNexwjYPYUEFpb7UCUoRsJlzx7I2B6Sm
	 CAj74iiv24pXXhLNxjHyMlBgHt/R+CdRZXDB5lfSoYPRM8TH/VFpmXABv2KN/3aDpi
	 mCbv0PFfO7m+brK0Ob0ahZqw6fGJTderxW2iWZoWBuneAJOcmEcEutVp2miHOEIxYP
	 ustGCSsvElvLIQYizHxDmV4HZdPqD8Uu+fYNvWvgbPY+FhVm3RVV9TYho+dMIJ2nYf
	 dMheiuh9rE3NbzDSmQ3mMA9DRqLDodQkez56OHoVpGit9wTV8mYLd+TJ+Wpac8T0EM
	 +WfxdomAMw5/w==
Date: Mon, 13 Apr 2026 10:55:03 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: clk-pwm: add GPIO and pinctrl support for
 constant output levels
Message-ID: <adys5EQcZXP7BBmg@monoceros>
References: <20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com>
 <20260406-clk-pwm-gpio-v1-2-40d2f3a20aff@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f4ox6y2gzf7pofli"
Content-Disposition: inline
In-Reply-To: <20260406-clk-pwm-gpio-v1-2-40d2f3a20aff@radxa.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8566-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB56A3E96CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--f4ox6y2gzf7pofli
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] pwm: clk-pwm: add GPIO and pinctrl support for
 constant output levels
MIME-Version: 1.0

Hello,

On Mon, Apr 06, 2026 at 11:50:02PM +0800, Xilin Wu wrote:
> @@ -45,14 +54,36 @@ static int pwm_clk_apply(struct pwm_chip *chip, struc=
t pwm_device *pwm,
>  	u32 rate;
>  	u64 period =3D state->period;
>  	u64 duty_cycle =3D state->duty_cycle;
> +	bool constant_level =3D false;
> +	int gpio_value =3D 0;
> =20
>  	if (!state->enabled) {
> -		if (pwm->state.enabled) {
> +		constant_level =3D true;
> +		gpio_value =3D 0;
> +	} else if (state->duty_cycle =3D=3D 0) {
> +		constant_level =3D true;
> +		gpio_value =3D (state->polarity =3D=3D PWM_POLARITY_INVERSED) ? 1 : 0;
> +	} else if (state->duty_cycle >=3D state->period) {
> +		constant_level =3D true;
> +		gpio_value =3D (state->polarity =3D=3D PWM_POLARITY_INVERSED) ? 0 : 1;
> +	}
> +
> +	if (constant_level) {
> +		if (pcchip->gpiod) {
> +			pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);
> +			gpiod_direction_output(pcchip->gpiod, gpio_value);

Please swap these two calls to reduce glitches.

> +		}
> +		if (pcchip->clk_enabled) {
>  			clk_disable(pcchip->clk);
>  			pcchip->clk_enabled =3D false;
>  		}
>  		return 0;
> -	} else if (!pwm->state.enabled) {
> +	}
> +
> +	if (pcchip->gpiod)
> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_default);
> +
> +	if (!pcchip->clk_enabled) {
>  		ret =3D clk_enable(pcchip->clk);
>  		if (ret)
>  			return ret;
> @@ -97,6 +128,35 @@ static int pwm_clk_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
>  				     "Failed to get clock\n");
> =20
> +	pcchip->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(pcchip->pinctrl)) {
> +		ret =3D PTR_ERR(pcchip->pinctrl);
> +		pcchip->pinctrl =3D NULL;
> +		if (ret =3D=3D -EPROBE_DEFER)
> +			return ret;

I think you want to return all failures of devm_pinctrl_get() to the
caller.

> +	} else {
> +		pcchip->pins_default =3D pinctrl_lookup_state(pcchip->pinctrl,
> +							    PINCTRL_STATE_DEFAULT);
> +		pcchip->pins_gpio =3D pinctrl_lookup_state(pcchip->pinctrl,
> +							 "gpio");
> +		if (IS_ERR(pcchip->pins_default) || IS_ERR(pcchip->pins_gpio))
> +			pcchip->pinctrl =3D NULL;
> +	}
> +
> +	/*
> +	 * Switch to GPIO pinctrl state before requesting the GPIO.
> +	 * The driver core has already applied the "default" state, which
> +	 * muxes the pin to the clock function and claims it.  We must
> +	 * release that claim first so that gpiolib can request the pin.
> +	 */
> +	if (pcchip->pinctrl)
> +		pinctrl_select_state(pcchip->pinctrl, pcchip->pins_gpio);

Why is this needed? Ideally the probe function doesn't interrupt an
already setup output.

> +	pcchip->gpiod =3D devm_gpiod_get_optional(&pdev->dev, NULL, GPIOD_ASIS);
> +	if (IS_ERR(pcchip->gpiod))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->gpiod),
> +				     "Failed to get gpio\n");
> +
>  	chip->ops =3D &pwm_clk_ops;
> =20
>  	ret =3D pwmchip_add(chip);

Best regards
Uwe

--f4ox6y2gzf7pofli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmncr2UACgkQj4D7WH0S
/k6FEggAkJfA5MMjYLXW8hLVGywXB033oMDgsSDYYcWAzKVcPCSxDEwuQ+XYA2hR
NpBkvZltVwEKLXproo55NCk6m20cR402euznjHcI7FyERYpgKrILBa9h9lbOPTFW
mkup4ikkNq09TyZwSh4A8+YO7XbMfskK+m1Nyn3CFcOkq3PCJ5BkA2IvpK7xkvTC
axvn1tWK/FHPoFpgi7YuvGLXmpm/d+SDmSF603GkzkxAPm9oEciNp7DR2AmnSW2F
CvfBnasi+qgTGYCBmAdsgYR/gB+rGPxuI3/B51PMJ92W7BvrxkIvOxrPnkzoj1eF
dY2lpiPkiwXW7sO8urVykWuhel2aSw==
=IMQs
-----END PGP SIGNATURE-----

--f4ox6y2gzf7pofli--

