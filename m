Return-Path: <linux-pwm+bounces-6805-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5650CAFFA1A
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47C74A8103
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 06:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9F238D49;
	Thu, 10 Jul 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1W/3He3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70487231A21;
	Thu, 10 Jul 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752130198; cv=none; b=hL95bPm90AKd705wJlIz7CkFbxyf/SuCW3ny9dIX/RCmS3uhs4odZO42+Mw3knN23s+YLQPEsVHUzj0mXGglR8I/19PlnPq++aV70asP5gLNZ3JbE6OfUn6vArsp6osp+nNLtnHf7U2M0QDp/b5cK1bgiQYYospbK3oQLqGBvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752130198; c=relaxed/simple;
	bh=SVNRURW7mpHDd03yiBO4hzyqJyZHZgozC/0qPz7n+lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgmkLga7GpY1655YzOQBzFY2QLbbaWrE9ncWYyM+gIp8LPsMAd3kjkjj/z90Xbjes6dG0+xbjIuKAqrk/DeSgVgkhjpGOuKZK2Wkd+0gju6SdQ52o8/NYrSZa04KGAiDf9x9wX7qwOs7lN6ExFbSGVbCLBX6FY3Bx92ABOnZRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1W/3He3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A0C4CEE3;
	Thu, 10 Jul 2025 06:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752130198;
	bh=SVNRURW7mpHDd03yiBO4hzyqJyZHZgozC/0qPz7n+lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1W/3He31SVNhKvl70+xMMi1Fdmys3eUZB88yA6pKfZL01RP+sYseLaJMVwqJdyO9
	 uiJ0c8fR3W8tcOY2VexSK0EUI0KRswqKn2gbnoCVvz9v/FZCoN4rZQ4U11HgFzc0r1
	 80Tul8XKx4MOy9Nvsfl96LRsEJejEAax4X9v6SJRRIkdkwAkF3nffHFY05yEt75knP
	 uLVsN6VuHtRuyVzvLeBNsSGWzmYU8v0DXu2iGw/6eZrwkiKvwKAZTEGeSndky8SuO/
	 FubUi9CwWr/xPAO5l09Ub5b18E9kvXCtfCwQgBI1yKwelBZaPu6/7ekWS3pLVWzjl3
	 F1LtCLbaz+4OQ==
Date: Thu, 10 Jul 2025 08:49:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Subject: Re: [PATCH] pwm: imx-tpm: reset counter if CMOD is 0
Message-ID: <vqqcxkefrzp25jjirwqbpmu4ytevt57mwd6fylmywlydjxvfiu@fs4xludzaurl>
References: <20250701220147.1007786-1-laurentiumihalcea111@gmail.com>
 <vwozlwajisjw5qomwtmnfdklmucevyxncsxl2cdmixn2yixxrk@x6j3r2lrl5qz>
 <a1b6039e-7020-4d17-8186-d40ac17ba730@gmail.com>
 <xo56zato6pgqqttdriskfgh4kdt2g6q5eg5jxte56uddkdfr63@sa7coeifbsmy>
 <907a40d6-7d55-4bdf-b16b-01c71b5f4104@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nmq3mzfo6amvxnbe"
Content-Disposition: inline
In-Reply-To: <907a40d6-7d55-4bdf-b16b-01c71b5f4104@gmail.com>


--nmq3mzfo6amvxnbe
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: imx-tpm: reset counter if CMOD is 0
MIME-Version: 1.0

Hello Laurentiu,

On Wed, Jul 09, 2025 at 11:29:16AM +0300, Laurentiu Mihalcea wrote:
> On 7/9/2025 9:05 AM, Uwe Kleine-K=F6nig wrote:
> > JFTR: I marked your patch as "changes requested" now in patchwork and my
> > inbox and expect an updated patch, but without holding my breath :-)
>=20
> Sorry for the long delay! Got this on my TODO list. Busy week :(

No need to hurry for me, I'm not busy waiting and we won't be able to
stop Linus releasting 6.16 anyhow :-)

I prefer well considered patches over patches in quick succession anyhow.

So it's ok to take your time
Uwe

--nmq3mzfo6amvxnbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhvYpAACgkQj4D7WH0S
/k7Bzgf/UmJuQUOMJzEA55s8ZtGd4ndkFp63PO8tRbJYvIX9IBIoaoLRUOWbuAO+
XR6KNfcB4DKlMqMQxR+ULXdTpH8Ph2VbgNSi4JzaMUL3j5BI8aoF0/rvZgDG3Agq
0ZiDQ8aZ8+Y5KWEHdbD73HrJUV7QwzWZ7Ji+5TNlLy5sQwgznzCZCHgkj23bUEC4
yXtpK+XnN4DhQnXLdEkA6/76LWfH7XNsIjphu9RYweLSJQs1NBOwD2hvP0HjhImV
II81sKub/Z3mIbg8kElfsEgi2h7Zk2YwjFUEno7rnjLcmLQPyTXla36I0pfasTFp
uVNinr3DXmMXDPoZuO3WOiKiaJ2T/w==
=TuF/
-----END PGP SIGNATURE-----

--nmq3mzfo6amvxnbe--

