Return-Path: <linux-pwm+bounces-7948-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E83A9D3B575
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 19:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FE0C301C3C9
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297B2BEFEB;
	Mon, 19 Jan 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skofMk94"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA1318142
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846870; cv=none; b=llgiMDEzFFjisPIT9yWfxV/agnUdyIGD5lUpdNpoiDu4eUZZNAXkbBOQb4EUvBA2y6TpQeuH5M5OaaRHlYhrg30s+vbaA1E3YH1ABhyFCrbvCoKSxRe1rUIBSjLZeiUn/RHB1BTMUfDEkeSwvN9q+wFt3VNbRdDqua4wCT8fd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846870; c=relaxed/simple;
	bh=pbpNAN4jgQ2PV/5/4JwvHsoHtPG/jsvmmninaygHwok=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzaOW0/E8g6/hvg8SETQSZIO0bJtNtPLc4kQcc9yh6rn2kutt2PMn/xZAYfxflM0FI8Y+ttoCc1Qv8YYq/hDahUOjkfIPePTqK8HhcDwpxPMVHbGxda6AeHNOwnwPky9ENNWHPT0dlveZJ9dDgiVR+ViKblXlgiR+azlfLsSSz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skofMk94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5DDC19422
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846870;
	bh=pbpNAN4jgQ2PV/5/4JwvHsoHtPG/jsvmmninaygHwok=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=skofMk94Af4L1jJhJfGSBnnVWkuVrulSWmc1H8WnnEXYXomQBMignW3SZMcMLTsjP
	 mIJ5di+lTFx/O8keWYZEKuRa3guh8Uz1PnPQLOhldt4AEKy2L379Fgx+sUWWwN8fIt
	 8ZVgQcOCCCSCAzofyKt0w9QTk/M/q8KRxO8M/HOVDbIcOQ2ZVZ2blKwm+VOFETxZvU
	 AqALCOEw0c1erP4xGA0C4awlGgYgNE20EdmBEhm5Tw/p/VvDZYQ5dys5RbmAPlZPpl
	 pTihgQghSWb2mFncH4I2ll8nSWZtIO2X+02cwosxJOtPGspQDaI8LIqQkaMPSMWN/U
	 0DCuaNtt1GWlw==
Date: Mon, 19 Jan 2026 19:21:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Ensure ioctl return a negative errno on error
Message-ID: <cktfp4sbbav7znwqbnxbwoymdouusjne2ary4esswlhww2uwsc@cda66bosiu4j>
References: <20260119151325.571857-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uoqskny5eoaae4cs"
Content-Disposition: inline
In-Reply-To: <20260119151325.571857-2-u.kleine-koenig@baylibre.com>


--uoqskny5eoaae4cs
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Ensure ioctl return a negative errno on error
MIME-Version: 1.0

On Mon, Jan 19, 2026 at 04:13:26PM +0100, Uwe Kleine-K=F6nig wrote:
> copy_to_user() returns the number of bytes not copied, thus if there is
> a problem a positive number. However the ioctl callback is supposed to
> return a negative error code on error.
>=20
> This error is a unfortunate as strictly speaking it became API with the
> introduction of pwm character devices. However I never saw the issue in
> real live -- I found this by code inspection -- and it only affects an
> error case where readonly memory is passed to the ioctls or the address
> mapping changes while the ioctl is active. Also there are already error
> cases returning negative values, so the calling code must be prepared to
> see such values already.
>=20
> Fixes: 9c06f26ba5f5 ("pwm: Add support for pwmchip devices for faster and=
 easier userspace access")
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

I put this into

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fix=
es

to let it get some test coverage in next. I intend to send this to Linus
before 6.19 unless an objection pops up that convinces me that this is a
bad idea.

Best regards
Uwe

--uoqskny5eoaae4cs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmludhEACgkQj4D7WH0S
/k745Qf8DqCmKL1qgW+pEL8yQ1K0ZsHO5VXj8BQ5LUOYl0TJuMjbR7Xlk9PK7AoR
xRZXXylNnTSSwUrDeHwcAaNwLZcHY1TCoqex5ip8CjXzzIlxJlsVtNR8G3q+4PTC
LhuQtj5RuA33btrEfqMPK6oydZGeMbXxZpjVUys0XT8h8K3+9Ry1fZsB1WiVjewp
OZYxOtA76Yrv6mh/rO+aVlDnd4x8Sp/+kkKUdP7hly+t6NbIGwF3ZOsLFHMtdVbn
xQCy/WnkjTwpkNi/lbAXIGKfZy0+N1uHH3y/6iA9VDy+S6Z79hXtPmYFNWirfkBS
Kf0T4Fbbd6Q5HAbo3vg9DzeBchI7kA==
=lbkb
-----END PGP SIGNATURE-----

--uoqskny5eoaae4cs--

