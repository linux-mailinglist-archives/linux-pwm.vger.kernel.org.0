Return-Path: <linux-pwm+bounces-5270-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2E3A6E1B5
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Mar 2025 18:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FCE189848B
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Mar 2025 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F49B264A9B;
	Mon, 24 Mar 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWhtQ8/y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714426463D;
	Mon, 24 Mar 2025 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838147; cv=none; b=AIuPB3a6YFm/0yzNfSxTBP2vgor4+jR1j5I3Gp5bLtWrM2pWsRxpREWdPsEt6zLHeFmnuW2iIUL6vjHAfbgk6ou15EKcviHDFnvJhI5AyTrTAt2vQg8yvd5GYU9kDrAevC/AQ6Tu71ryZ9yGz1T/nuI0SwPw34M2KViwN2pTq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838147; c=relaxed/simple;
	bh=JzLwpUYcuzVCpdSFrJ47M0hj0NSi9n7p7JRZWewryVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXeD/EbpHqNZbCSmEC1z4rA9u1kCG/VZWmlmzJoBwxhnN1ZuSNdygdcbV1PCsWE5AqUo7w+SYQUGGeMiBKrMBuWDJKRoNYDCHyKJB4xnlf77WWo/j2KshlG0jX1AoIqil5eob+wwStDoGA88ldh8Pj7WGNHN+0cB0HjmkzLtfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWhtQ8/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F85C4CEDD;
	Mon, 24 Mar 2025 17:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742838146;
	bh=JzLwpUYcuzVCpdSFrJ47M0hj0NSi9n7p7JRZWewryVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWhtQ8/yCUsdR0t6RLb6QpyiO9AcH38H6foBfoBAnhX9qxkUg8AmSC8B5K0LoYPLy
	 40/vYLWgSBp74df3IawiLqMWqFPvoDFFpFJBR3/711Quc7Ur+uVTEIA5GWG/FnoVgA
	 oWQex/dLnFORQuKEo+y2dd5KbDf2dF4yYOabppFexMJKAUgI2CT7XxzHSmSDXwW7sY
	 PMJ+LyN8Bj5zMUYp6KzmJisMn6+hFOiPnWS2fBzGqrrQ1qN3J/MsuLukT094TqCAT+
	 KpsvFXLUbAFDdQ626ilhm0uWQyoFQRTkqJWaXwNZFPyhd6mGmIbyS8IwHLIw1P2jp+
	 y4l5meIQdK9xw==
Date: Mon, 24 Mar 2025 18:42:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [GIT PULL] pwm: Changes for 6.15-rc1
Message-ID: <dkvbidqel4v3wndhjp7cnzyh6h3le54tthblcwflq4ayilm2dw@vcclgjfkrm6e>
References: <gwhcc5df76untpl5ko4mqbt7vtxo3z4zdbqn4ehkenktt6untv@eng6ov2jmlwb>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="52r62j6bu437hsws"
Content-Disposition: inline
In-Reply-To: <gwhcc5df76untpl5ko4mqbt7vtxo3z4zdbqn4ehkenktt6untv@eng6ov2jmlwb>


--52r62j6bu437hsws
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] pwm: Changes for 6.15-rc1
MIME-Version: 1.0

Hello,

On Mon, Mar 24, 2025 at 06:08:52PM +0100, Uwe Kleine-K=F6nig wrote:
> warn: No match for commit 6df320abbb40654085d7258de33d78481e93ac8d found =
at uklko
> warn: Are you sure you pushed 'pwm/for-6.15-rc1' there?

I only noticed this warning after sending. Probably I was too quick
calling git-request-pull after pushing that tag. I confirm that I want
you to pull the tag pointing to 6df320abbb40654085d7258de33d78481e93ac8d
and that pwm/for-6.15-rc1 is the right name:

$ git ls-remote uklko refs/tags/pwm/for-6.15-rc1\*
0a313207e23c1353c84de62dd60226ce920fe466	refs/tags/pwm/for-6.15-rc1
6df320abbb40654085d7258de33d78481e93ac8d	refs/tags/pwm/for-6.15-rc1^{}

So I think everything is fine now and you can ignore the warning.=20

Best regards and sorry for the noise,
Uwe

--52r62j6bu437hsws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfhmX0ACgkQj4D7WH0S
/k7nkQf/R2iUjmJa/sihMlha50hNUug9eC7k4uIr+TDuolE59K/wzICpG18AxfQd
vts1AKwUbgq6Uq/reh78aGPAKvazZ9Wxp+rOQVVhyJuO0pxln9KWQqf1ao0wfYDj
B91FeGKigbiADp40o1UM9WyVyb5pmPVfYclfUwZNYG+kzNz515ny66qz2XwPZsWb
AsiPAHMwG0y44VgKJlstJa3g8Su/ccNAJ3XAacj4slCSJqmed580pXs2Q/OX4yQT
ytI2UeKM3e8yKycADF+pE/cpGaiNs88OKaxrQ3ONVb4Pf5m2dan4fbJ8DNR3ppGN
7nzyvxhn1dhnj3ZdfUJ9bZWnPp8L5w==
=fvg/
-----END PGP SIGNATURE-----

--52r62j6bu437hsws--

