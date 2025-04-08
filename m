Return-Path: <linux-pwm+bounces-5376-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42301A7FC38
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 12:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4545F169E96
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 10:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E679265CD2;
	Tue,  8 Apr 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSL72a1q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FF264A9E;
	Tue,  8 Apr 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108428; cv=none; b=IMrI/oQBEZlHkmyGWxe5CD3UQMUqvC8DNKolo4BnLAFbzCKobTk9J92rYByHYiSa286higUaxRX4UslLihNu5IVjMaBKV0dpEDzsUdXaRd6y2NknEjaSaE+bkg0lDSXCUKJlUx6z/WAz7iTW7w/956eA/szEuiMKlEGYvo6M1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108428; c=relaxed/simple;
	bh=dqZUQH9A3gBbckpMl01iPyZ2J6aWR3eyIu6QiPrKiqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwv4fS8xE/ntC7mfck6Y/8Ny9338g+PI4PBmjYIQEv4HpnX48nW5gNRe2BS85juWbweqjpFSGlN7w1tBkNffQOyi4VGsha6kQrhBYbhGOhZbwwoozxbkT+wwEyAZZGH4RtzWyqD/O7HRDrukWeYaXphYTBUmyVCwi4jDB5R9q6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSL72a1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E79EC4CEE5;
	Tue,  8 Apr 2025 10:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744108427;
	bh=dqZUQH9A3gBbckpMl01iPyZ2J6aWR3eyIu6QiPrKiqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSL72a1qC+paDiQfoaTlIPE9PEo4VTZNUdxmhuYw1G9WYOCE4T/JHSR5T63eR1MOZ
	 eW665vj7Jf6coIpPFDV6Roz9cjeB1RprrKmNoZM/Wu5BghDl1nypzEqfJA11Z2zQhY
	 PTRa7GejT5TZ/UBr8SXw0r1u7mD5Eps3pyKbFmQlmrJ9buAEKreQE0zJMx4H9yN09e
	 zxrpTPqbuAMqLKmNjw9aSD0d+pExvrHbheVxf6J1oHAB5W2C4Sls9wlai9RVcw+wN/
	 OhAMOLe/E121JGjzltRghh178ZsXrMHvwe0TniGoOi2blmqdxExcjcu+UvT02dSp94
	 5xA9qSYfoG4Vg==
Date: Tue, 8 Apr 2025 12:33:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] pwm: pca9685: use new GPIO line value setter callbacks
Message-ID: <s6hks5xgximkrvciv2rmuzgtjjzj3oocjge4jjnp6h3svqq7g7@mggzysqt3pzi>
References: <20250408-gpiochip-set-rv-pwm-v1-1-61e5c3358a74@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uzob57sthtjneq6y"
Content-Disposition: inline
In-Reply-To: <20250408-gpiochip-set-rv-pwm-v1-1-61e5c3358a74@linaro.org>


--uzob57sthtjneq6y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: pca9685: use new GPIO line value setter callbacks
MIME-Version: 1.0

Hello Bartosz,

On Tue, Apr 08, 2025 at 09:31:46AM +0200, Bartosz Golaszewski wrote:
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
as v6.16-rc1 material.

Thanks
Uwe

--uzob57sthtjneq6y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmf0+4YACgkQj4D7WH0S
/k5B+Af/fQ+GlBzudlOCt36Ouke8l2yhSQ5WzvXjcuXlUIct3FgPWAXScg1aVPyk
r0u7ZhPAJDKikxGjTLjnYEGNmmXUEaoc7Wp6OhA+Uz13P8LcpkL17Y36gvIT+sY7
gFXPagb7EltotndpDarQnQn19b+GbovcmRV5fkiJ2mS60+6xpfd8RxbWQTk29r6K
/MuLk2BBPxxd6G4zd076cIZ2Tyx+ckaR/SJA9rEeWtJvoc6czrbwEeKG17/LwmBk
bD0vqJvuWgF7JbPYW4YbxR8JpU+GWKKqvkVbEih4emZO7QhPdcu41WggS5Kmogyi
PxBaZgDhHM9tiWxYVjqTL/69ik6RJw==
=IiT0
-----END PGP SIGNATURE-----

--uzob57sthtjneq6y--

