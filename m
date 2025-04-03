Return-Path: <linux-pwm+bounces-5323-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8365DA7A171
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5871883A68
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6824BBE8;
	Thu,  3 Apr 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVlx2qjj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F824A07E
	for <linux-pwm@vger.kernel.org>; Thu,  3 Apr 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677723; cv=none; b=kHPSjlSvFvhXTS+vwQRVSBt4yzw/TyClUnW3Dsxqd39GmVld1+GJT80oTcMp2MZMnUh4O0FJVSVtAbHd2j2RMaKXJxmtFodayHiCYAsZ0d4uVPcDtd9dwQMgAUQvgO2xCqDIOcf6XBQiPpXtu+RrrEM5tobVRMMNGO+yG8nnRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677723; c=relaxed/simple;
	bh=J961k0sMsjx0DtTlxe6SYPRL0vJtzjSjQ1nYBHnlDeI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP0Ysbxlrfk2myPDA/dKzrO6wEvlc6snlxlha575fsIpvgMXxLUhzq8c/9FNwXSuTHaynl5zhiJ4QBYwuFdfBL6sBF8bSi+Wc4LW2ENRQxZExeoxLqrA63zaO7nqSqqEdrmMRbq14rYh7g20VmRepyGdCjzsO8OLV7XvrEjEIrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVlx2qjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D895C4CEE3
	for <linux-pwm@vger.kernel.org>; Thu,  3 Apr 2025 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743677722;
	bh=J961k0sMsjx0DtTlxe6SYPRL0vJtzjSjQ1nYBHnlDeI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=cVlx2qjj/otkh2QTfpNqMKxKFLsTXnreJiZlVlxahp4Kjv1DCvY0wY6tgJtfTp/sC
	 ZY8D/AJbN4TBPKTnGWUIon3UGmxL+W4BnqO2pEu4mzwKqmbKn7Y/knpuo4XsPH6H2g
	 24F1aZYlpw+ii2tKnWEtADoLmIzTbp6SRzjUEzKGdinOJPp1HLxqNLiHwwkd19hl+N
	 pP6+GetAQkVmB1OEB1nVGmLNBvLi9VuANHFUjN83I6vpiC/i2tjoVyGH66dRFjvK/P
	 HKIQ7ir+I0TM4GyfwROAvt0IgQwRs6B0mK6/p9xQL6onWaogmj8tpNIfo72INSAjR5
	 hXlRdlx110l2w==
Date: Thu, 3 Apr 2025 12:55:20 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: pxa: Improve using dev_err_probe()
Message-ID: <dgwhfusojj7opafpglt5wmzf7x6uibcxjj3ibtmkvcwyfhuayw@klxz2lhpcysc>
References: <20250313072855.3360076-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bfeetsmii4af4mf"
Content-Disposition: inline
In-Reply-To: <20250313072855.3360076-2-u.kleine-koenig@baylibre.com>


--4bfeetsmii4af4mf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: pxa: Improve using dev_err_probe()
MIME-Version: 1.0

Hello,

On Thu, Mar 13, 2025 at 08:28:55AM +0100, Uwe Kleine-K=F6nig wrote:
> Add a message to the error path of devm_clk_get() and simplify the error
> path of devm_pwmchip_add() while improving the error message en passant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied as v6.16 material to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

Best regards
Uwe

--4bfeetsmii4af4mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfuaRQACgkQj4D7WH0S
/k56ngf9EY+TBqv9Nl11QjfRYiLBn+nU3bER46OJCpiNjmH7EB6EOSxlKynkOOgS
qxvePG4HdTHUZwuz+xPbZiFxzHOYyKrqkkSOEc69Umf7u3x/UDyF2af1mrNvQap0
zTvFfKpmHNg0krUWBKpeLiR2yefUzgTqTRJDU20UAC7nsd/Q57hLRvIPNmYXKMyj
m3YaAdySs9yNbo5bwUX0TQ/lkvsOSE6XBIuYP5rkRrf6p1l7y64XgRrydHRAj0pV
dzBstN73ddV52NOz3YTosFk2dmOTpq/hMd9ce4ERYsBcHQrHeH2fc4sa5+U2vIR+
LGvMyUZQYEO9j+sPwAAHgSG4V1CEYw==
=fnOO
-----END PGP SIGNATURE-----

--4bfeetsmii4af4mf--

