Return-Path: <linux-pwm+bounces-7297-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90AB5461F
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 10:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC4644E19DC
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1F272E5E;
	Fri, 12 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arYteBou"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62C26CE02;
	Fri, 12 Sep 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667434; cv=none; b=hP31MERxCG51i+atVnT3c/mWyiv89DyxXAOm5sYozwPn6SdBk6JmyLKAB5vbFILwM0PSLV9Ayjyk83/icpzpzCywnXyz1jM87Sk9NjLh6FbKZMilfrJgJVTx5XKqzRC1PH0s4UJF1OX4ozhEf0EaMTd23wPFy65etdjPrJYy2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667434; c=relaxed/simple;
	bh=R8pmvXYNXPv61cZrkXJEOoL+DzfW39pQ/TW92VuM7fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHfuFb3PZl8AP9xuI4yXCd71lkX8US8O1if2cgSAWOYM61VX5jCtJyHOtbkLwEEtlGsHz10Ylch89B4QrZpC1lCVpfxdaj8A7C/hZSaxj5erA+nF4Jh3xMCG28na5pXDwfOCL8msPVN2YbgvZQbPCWQ3o5X984P7+RiXhRHt9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arYteBou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C2BC4CEF1;
	Fri, 12 Sep 2025 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757667434;
	bh=R8pmvXYNXPv61cZrkXJEOoL+DzfW39pQ/TW92VuM7fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arYteBouvfqqM6gDSA4wvJgLUhXAvtn96LDHoRs7LHgcQxrHIrYp/G+P9iNdCx8nE
	 TjVhBiiS02odIDB7zH1HJiK3YtSes7kCsS0hgF6JbFbBKOvafblIMyrMw3rS1RUqDo
	 cmu8MaOMAjSbocLMxg85MlpO8tgz9TRQLdkx61P4G2x0N/r1+jsKrvFUoqmjfqLf8+
	 y5xUX6vd5FEXQyQ0MuDvzKXj8i6EIrAL8hQIPreGxwdztxdxN7PphvoY5v14PVG5E2
	 AbWxiTf0/jNt5pr5oqFzmXsvgoUTY93nczQClI1ukCEGlm6nk05ou2gzyFiSQykNen
	 3TTqM2Piv78yQ==
Date: Fri, 12 Sep 2025 10:57:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v14 04/10] pwm: max7360: Add MAX7360 PWM support
Message-ID: <7jytyub4v7tn6vbwh4drusaagnskl2dsfg2xr6eqp4leqpfq3y@a7g3de5echs4>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
 <20250824-mdb-max7360-support-v14-4-435cfda2b1ea@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zmberailqlfhseth"
Content-Disposition: inline
In-Reply-To: <20250824-mdb-max7360-support-v14-4-435cfda2b1ea@bootlin.com>


--zmberailqlfhseth
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 04/10] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

On Sun, Aug 24, 2025 at 01:57:23PM +0200, Mathieu Dubois-Briand wrote:
> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)
> +{
> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
> +	u64 duty_steps;
> +
> +	/*
> +	 * Ignore user provided values for period_length_ns and duty_offset_ns:
> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of =
0.
> +	 * Values from 0 to 254 as duty_steps will provide duty cycles of 0/256
> +	 * to 254/256, while value 255 will provide a duty cycle of 100%.
> +	 */
> +	if (wf->duty_length_ns >=3D MAX7360_PWM_PERIOD_NS) {
> +		duty_steps =3D MAX7360_PWM_MAX;
> +	} else {
> +		duty_steps =3D (u32)wf->duty_length_ns * MAX7360_PWM_STEPS / MAX7360_P=
WM_PERIOD_NS;
> +		if (duty_steps =3D=3D MAX7360_PWM_MAX)
> +			duty_steps =3D MAX7360_PWM_MAX - 1;
> +	}
> +
> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX, duty_steps);

duty_steps is never bigger than MAX7360_PWM_MAX, isn't it? Then this can
be simplified to just

	wfhw->duty_steps =3D duty_steps;

Otherwise looks fine to me.

To get this series forward, it's OK for me to apply the series as is via
Lee's MFD tree and cope for this minor optimisation later. So:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--zmberailqlfhseth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjD4GUACgkQj4D7WH0S
/k77QAgAjjqIqisX0gZEMvfEUJ6b5oMEE4/wjU5NBKRDyva0lOmPR4y0eg8XCSd6
WXBNjxsQ+zdzk8ATPVz2GaWl6It3jsTIIjXEeBZM5dcrsh7U3OD+KoFdkDfeZhgH
Fgs8dVGvrPW4+7hruZqoGiOBScRMgV3OezDHZ0bfIAQRzg9cAZcMJVsa+JMFy60V
0HZ1oE4lm65SKpKO5OVEsQ7/tUPAXFiqvCGr8KJNTGGM8vmg+ds62Y53JcojWjZs
Vvdk2rtpKRDklrjoJjDcfIfgZVZcZrM7QReEGl7rOnYEG3vFLQRJVJjDVziqcpt0
BgFP8Hj3a6dMWoMjgm4kQrJ14qT5kg==
=ruZV
-----END PGP SIGNATURE-----

--zmberailqlfhseth--

