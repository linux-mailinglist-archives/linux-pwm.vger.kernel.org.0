Return-Path: <linux-pwm+bounces-2580-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF72C911CA8
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 09:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8081F22324
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2024 07:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874A16B396;
	Fri, 21 Jun 2024 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avcQT1bA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F816B390
	for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2024 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954291; cv=none; b=f/4TY8109V7Ac4RVCd7QNfHMMoL7oDXW+0HweH3GSTrIQX76FO/BUPC/1RPHZSK3rml+/oG7t3ZX/avpXZCW1LRivLOkn1xTQ7jNUrQ3vyIfBUapGcduqrPddL74q4Jc1RT/Xc7hJUxDF0VS48Ro/bmyIIzQktSBoOl51JLQ1Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954291; c=relaxed/simple;
	bh=TwdRhfZYZjB0WdAFUJlw4yH0tiLdcgngfMR0zmuG/DY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gzkPD+wcvEZ73tCTPaYv+XR5DPXq5Xp5V0vYhzSms9OJ3BCUMnmJZ4g0RQNcXTj6WLUNNbEa5AD11SPlWJ6122Xc8Mvk9YAe9utKqyBmGxtsl47Cx/H+A+Y3zsIfTpYFXM513s781ytrKsDSJF6n0y32gpwvD51eHuhjRW+LS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avcQT1bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D50C2BBFC;
	Fri, 21 Jun 2024 07:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718954290;
	bh=TwdRhfZYZjB0WdAFUJlw4yH0tiLdcgngfMR0zmuG/DY=;
	h=Date:From:To:Cc:Subject:From;
	b=avcQT1bAhpT58Umrh4FjJA552YbRL6ddzHl5m6ZJH86XXzZzjKd3D+biPvbKku+MD
	 JZQ0ZGm7nl5xbLLUkFjZ9nMOAHbXx4gSvaKOF30ImmCVrz1imJ2E0HMsMaBUDQGKeF
	 oopqEJIDVsP03jNyO0efiHavmRaCCwmHeYn60TQ2x7tD5s7DHSzMOnAqmqSASSGyxJ
	 ZV3qOxAmJOb1WuVkx3kH5A63D1egSFy6ivtNtD4YJyo9k0s8nLShtBTlKD+kQ6otmP
	 igOpVZG9zpP8tiXfoE/9/Gp+OkcPE1uPVBLTv0tLEMTFa8TuoCvMXWkFR1snDoDUCY
	 eydER+buRg7sw==
Date: Fri, 21 Jun 2024 09:18:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Trevor Gamblin <tgamblin@baylibre.com>
Subject: [GIT PULL] pwm: Three fixes for the pwm-stm32 driver
Message-ID: <2d2qmxla4hcug3mx4puvhrnezwjw6xp6xdnwodggcdglghmx4w@wqd7rv5qys73>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fgkxgnr4wy444m5c"
Content-Disposition: inline


--fgkxgnr4wy444m5c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.10-rc5-fixes

for you to fetch changes up to 4120bc75cf95bb1b10df83e85a0478f292ea97cc:

  pwm: stm32: Fix error message to not describe the previous error path (20=
24-06-21 08:57:12 +0200)

The first two patches were in next since Wednesday as

	215d1aa8b5a7 ("pwm: stm32: Refuse too small period requests")
	ea80bdb90a5d ("pwm: stm32: Fix calculation of prescaler")

I rewrote them for this PR to add a review tag and improve the commit
log. I also dropped Cc: stable for the latter, because the offending
commit is only included in v6.10-rc1; there are no code changes.

While preparing this PR I noticed the bogus error message fixed in the
third patch. I consider this obviously right enough to include it here
without cooking in next.

Please pull this for 6.10-rc5.

Thanks
Uwe

----------------------------------------------------------------
pwm: Three fixes for the pwm-stm32 driver

The first patch prevents an integer wrap-around for small periods. In
the second patch the calculation for the input clock prescaler is
corrected which resulted in another wrap-around and so bogus period
configurations. The last commit improves an error message that was
wrongly copied from another error path.

----------------------------------------------------------------

Uwe Kleine-K=F6nig (3):
      pwm: stm32: Refuse too small period requests
      pwm: stm32: Fix calculation of prescaler
      pwm: stm32: Fix error message to not describe the previous error path

 drivers/pwm/pwm-stm32.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--fgkxgnr4wy444m5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ1KS0ACgkQj4D7WH0S
/k4+7gf8CH5gqo9ioWc5je2+c9HnPTMGlcJaJ5yxKthq9VVi2K9Zb59o8p7S2OsJ
LP8OFNuI33BH0LepRFVbG/dzDahWtvLrEdi7dqCvbIU+IR985RSnwHf7ck8WsruR
jsmx3SVtGcRGaCCuIezZpQlfHR7SI7tmyrFhXahoneoMpJ2msWqUCkvmV1kmEphj
//XTiTKXrK27YoQ17CPR5Lz4MA9aVbjlSDJUm+ZeOiz4IiK6BSQizCEnSKonifym
7eiQji9d/RfQV4RQXUlbVZh8eKb4dzUmhDU06ylkGzHp1mUjHG/TjaTeAKwxhHBy
sxAdx5nO9o6LP8juwhhyz/OmSZsFQw==
=vIff
-----END PGP SIGNATURE-----

--fgkxgnr4wy444m5c--

