Return-Path: <linux-pwm+bounces-4150-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D64429DA43A
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Nov 2024 09:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848D6165664
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Nov 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11908189F20;
	Wed, 27 Nov 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubrbky6g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC427154BEA;
	Wed, 27 Nov 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697781; cv=none; b=fkpZxvu4Fwiq8pNlj0zS1E/iQYLjKx0Oktx6OD+EpXzrUJfkqnnCJFuqvv9iRFjB6NY2sddNwdxMgSmKczLLTov4zhAWsA4RKH64s25OYP/GXaYa36A7/OOCgWGdShGN6Eo0IhwGtrE8R5CqUH65jL7yNLOKmWLXGi3OpMRohQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697781; c=relaxed/simple;
	bh=emvo7WHupGcVSUysy3yVUx2hYcnGAx5mb2uwEYdRjYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axvh/DcbQ9JmZFzgvqZOUkDbh9E7HFwE5C7jVWDHbCuVBJr918H5I+hsHbSt0hxKHbxQkt+y04BbIaWqs8RMLil8eFvd/b3VnfwZ+ohw/W+n6o1Nse02lZk2kaBzPM/T9PqSTsehAumeMcHGqKRQmMKGA/OuAKPlVKrXISLVu+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubrbky6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1A9C4CECC;
	Wed, 27 Nov 2024 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732697780;
	bh=emvo7WHupGcVSUysy3yVUx2hYcnGAx5mb2uwEYdRjYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ubrbky6glta/kawO3cY5nmNLWBdme+QgX9cdUE0RGim6c609OmrTtITJ2jlly9dpO
	 r9Ay9BynD0LHh+590bj/fSTZMYRIt43aIQqTKXU9CtS2G0XoORU4coznARRcryBmc+
	 FCCrvepAwRulYd0FCh8mS6zq/2grAQH/nX8/+D+ulqFSK1W3Pv3Ww3gNnYQRX4VCaX
	 8w5Gw6v4CmTt0QQvAxeWhX1LdJtKhLSYqWnEErdnlbBr+bSmw0yL8KHVqVYdtrPVkr
	 /iszTzHIVAxKoj3PGBrUoCAPg7GFyBpPmPliauCl8P6yXXsiLJTfQY2VzFxF3UDXci
	 zOkCV95KqW1gQ==
Date: Wed, 27 Nov 2024 09:56:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: correct pwm->state.enabled handling to allow
 fops control
Message-ID: <pujikyjijvcn3mmlayqmdkh5zyjqdrfmmz3jafxyhdhuo5ekam@ntttaqiw7iow>
References: <20241126212414.15165-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2uhmb6pgn3e7vfqx"
Content-Disposition: inline
In-Reply-To: <20241126212414.15165-1-rafael.v.volkmer@gmail.com>


--2uhmb6pgn3e7vfqx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] pwm: correct pwm->state.enabled handling to allow
 fops control
MIME-Version: 1.0

Hello,

On Tue, Nov 26, 2024 at 06:24:14PM -0300, Rafael V. Volkmer wrote:
> Ensure pwm->state.enabled is consistently updated during enable and
> disable operations in ehrpwm_pwm_apply() to resolve this issue.
>=20
> Previously, when attempting to interact with the ti PWM driver through
> fops, the pwm->state.enabled field was not updated correctly after
> applying enable or disable. This led to a state mismatch where the
> driver's state detection logic prevented disabling the PWM through
> fops once it had been activated.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 0125e73b98df..9f939d535440 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -420,6 +420,7 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	if (!state->enabled) {
>  		if (enabled)
>  			ehrpwm_pwm_disable(chip, pwm);
> +			pwm->state.enabled =3D false;

This is a layer violation (pwm->state is under control of core.c only)
and uses irritating indention.

Please rethink!

Best regards
Uwe

--2uhmb6pgn3e7vfqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdG3q8ACgkQj4D7WH0S
/k4dJAf/Rxe0Zo6dFRQbjp8INlPjFE6pXsoaYftak9EQ/bjyu5IKOlOXfRr1+Ye3
xVSF63MH+FTqI+/EE4D48nGB5T22LsxO05blBVKt+Ru+7Lq8IJEDMjy3oCQ7a23q
9NB10VehpyJIJtoMswL3YWoSBhACmkHDuJ4yaIRPRUjFRSnWiKdgZuM4Qpp2xIGe
uRMcWBWDkxy8n/eMKuxFtXcq44Exa9OlT7EIqcQfJ8cuFkylD16PfvKKCDiq5qfK
S5Awk1JCSzQr8EEIYcBcXVVMKtov5Yxn0hv2kf4LCIYVDFvDkr0jmXZKEyAPkSE/
DesoyybXHE8A8isX41rM/QJ4zsfPvQ==
=zjqn
-----END PGP SIGNATURE-----

--2uhmb6pgn3e7vfqx--

