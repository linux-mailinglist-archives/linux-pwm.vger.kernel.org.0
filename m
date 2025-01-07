Return-Path: <linux-pwm+bounces-4545-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF48A03736
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 06:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2A51644F1
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 05:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2374F194C9E;
	Tue,  7 Jan 2025 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laoKNB7O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E51802AB;
	Tue,  7 Jan 2025 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736226459; cv=none; b=nFb+MjSSEXhMUSTL/kDg2iQ5g+k67kLINw6PjyIMXZb5rTxs5PpRo3qC555JsQHLswo3WnCcI5aCwfIxigmTKKWI+M/+KwOHjkRHatQ3PE4ip0J6QNwR4X+GSq8DGb/2R1ICefVXOT0ruGRKAA/GPra9mp5gEVAeHnA7egP4c+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736226459; c=relaxed/simple;
	bh=UTP2yln0R5brDwcvJQ9DLlME0HUB0TlitU6O3YCX8V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfadDZVEm9J+NTlDh6ayYuQI9VDVdpqz+fASdNGMo66laf066Ls8C7nDywJobgQhz53DAYKU8cVQBKhjCjoF5OJvLcGjbIG4nV3MSezH9cX9X5pSR/Mexd6IUKyfA3GutpC6tBFsjjp0rdR1VWIMvXpZYkPrWU6hrPqJ+TYnPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laoKNB7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB19C4CED6;
	Tue,  7 Jan 2025 05:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736226458;
	bh=UTP2yln0R5brDwcvJQ9DLlME0HUB0TlitU6O3YCX8V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=laoKNB7OsgiZSqP93POaabeYROjQwDY0rWw3I9Zqupyc8u/U+E9YOqjft3TWmqYAR
	 LIslPBFDk/eeRRNY2bQuMNl+96RCNfuAA1KbB4QlbyFErGgMEZYq7xvpU18pZPrp0M
	 scXttnTsWVknhTsyAUdu2jbpOQ+OMr9KljFPeXozRBfnsx26AiAhyIK+HDpoC1bXZg
	 +gYwInkCSK8lhnBiTL3CQramV+KH38dO0ZvDntkutzcqTL6ALNTozzezk3+r/XjMAX
	 V+V0NYVSHcBTV/OI062/SwjEHV840kCM58mBYMrTLhvP+wxQ6ha3i/S/GUgQdjRCqr
	 zUwvLkD2cl82g==
Date: Tue, 7 Jan 2025 06:07:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Maud Spierings <maud_spierings@hotmail.com>
Cc: william.qiu@starfivetech.com, hal.feng@starfivetech.com, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, p.zabel@pengutronix.de
Subject: Re: [PATCH v17] pwm: opencores: Add PWM driver support
Message-ID: <7kfpvipnkirfacy3ro3qb3cmbw5fv5dlyjh3qowc4juvmcb2jj@43zpytio2273>
References: <20250106103540.10079-1-william.qiu@starfivetech.com>
 <VE1P189MB1024E9669B8CFCB943D633E7E3102@VE1P189MB1024.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vz6tfkkpvjabun6q"
Content-Disposition: inline
In-Reply-To: <VE1P189MB1024E9669B8CFCB943D633E7E3102@VE1P189MB1024.EURP189.PROD.OUTLOOK.COM>


--vz6tfkkpvjabun6q
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v17] pwm: opencores: Add PWM driver support
MIME-Version: 1.0

Hello Maud,

On Mon, Jan 06, 2025 at 07:59:23PM +0100, Maud Spierings wrote:
> Hello William,
>=20
> I've once again put the patch to the test, and it seems the oops is
> resolved.
>=20
> I did notice something odd though, when controlling the backlight=A0 bl_p=
ower
> 0 means the backlight is on and controllable, 1 seems like off, but inste=
ad
> sets the screen to maximum brightness and then stops listening to any val=
ue
> echoed into brightness.

Note that for bl_power 0 is on and 4 is off. Still the behaviour you
report sounds wrong. Quickly looking in the pwm_bl driver, I don't spot
something obvious.

>=20
> The brightness is also reversed from what would be logical, so 255 is off
> and 0 is maximum.
>=20
> Now the little text at the top specifies that the hardware only does
> inverted polarity, which I guess explains this, but I don't understand it.

The backlight's operation should still be fine, its usage be independent
of the PWM's details.

> I also encountered this when I got an error to start with so I had to add
> PWM_POLARITY_INVERTED to my pwm-backlight definition.

That makes me suspect the problem is on your end. If you add
PWM_POLARITY_INVERTED the result is that the pwm_bl driver still
configures duty_cycle=3D0 for backlight off, but you then get a constant
high output.

So with the hardware capabilities (i.e. not being able to emit a
constant low output) I think you need to not use PWM_POLARITY_INVERTED
and accept that completely off doesn't work (unless you have an
additional GPIO or regulator to disable the backlight).

> But I don't understand why it isn't supported. Wouldn't supporting non
> inverted polarity be a very simple calculation? 40% negative duty cycle is
> of course equal to 60% positive duty cycle, 20% N =3D=3D 80% P etc. I don=
't see
> why the hardware would specifically have to support this.

If you only care about the mean voltage level (as is the case for a
backlight), that's right. But only then. And if the hardware cannot emit
a constant low signal, this doesn't help you.

Best regards
Uwe

--vz6tfkkpvjabun6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmd8tpQACgkQj4D7WH0S
/k51Agf+KZvCR5NhKAnnkB1hrUdGtM6zYAD4AH0s9iPKa1j319Vz8SWU9IX+wi0U
8w1QT5/2PZQyNsvUwP84R5aAXyPHC1hCHPQZc1plXrwcaGwvb68TXdjL7kwBNRwl
ps3lIJYNXv/ixKYoyZtomifVXh1ut9COAIZTW5jBMEUC0Vk+MNvbJtR+HvmW10D8
9Np3pnIlxZb31cpRrtCe9/7aBvsHH+jyTZtfjx78ZbP7sYUfr4K5GkMCIqsggSep
B01lIMfPMaLtDK6hO33EkYsmVSQqpojdzDTyfuqNehRjFNA3/6dPYws0r0n6aFzy
K/JpogSYo2kOq7g4+aJXR9BllCDyPw==
=Ig//
-----END PGP SIGNATURE-----

--vz6tfkkpvjabun6q--

