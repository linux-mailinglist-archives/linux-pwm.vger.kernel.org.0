Return-Path: <linux-pwm+bounces-2557-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894AF90FFB8
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 10:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB1D1C21F27
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Jun 2024 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685993A1AC;
	Thu, 20 Jun 2024 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLxHfoOx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998B628;
	Thu, 20 Jun 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873953; cv=none; b=myD+ITOaZLXVVT12KQ13pwW6FD046x56WvcCV6n9YMv2JE7cTz8hexeCX8p9E4VOOjOGVRFFBY1ZP4j1xArn8xAUPUaugOM6EJEqtvpjxODxzJ5EsnT6ljF2qz/0sXu0FijsC/25rxfUAGiK0YzvJDar7JGVxOwMzNvOFBmEXh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873953; c=relaxed/simple;
	bh=cxO0O9LpvQgPUIclFb5zIAe3EVexH+Kz4teCj8aZZ3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eo5Vl1sjAfR2nrvqD780+D+hzM+w5z1UGxANQ7ey3pTBz22YWCdnX6NjZaxSC0wj7dNHD4kw+O+se61OFw8gAS1EEaQGByOmnlcimijGCl1651CbJr2vZarF2CeFMo+JJZGPARiS57Adp5KKu0UZ0lYNfIga9uKUf6rrhjb89ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLxHfoOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8D2C2BD10;
	Thu, 20 Jun 2024 08:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718873952;
	bh=cxO0O9LpvQgPUIclFb5zIAe3EVexH+Kz4teCj8aZZ3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLxHfoOx65muZqCx7fXYQA+BVobfWUYljU/T3kndPOGXaItcWwNz4sYjMRVbL3rfo
	 2Wl9Y3l0tXzCpA1JqnJH8IbC1gIGadbM9RlKUjZnN+iERxeohoKaqA2b+0I/P+GKUQ
	 E7r0CKv9OjU85F7M3QTLjy4MXkx02x5FYj0KhbNSGQDO2pL9Nkc5CKRgEY0pQkloFg
	 eAwbHg/kEjhUpo1fZ9PJ4waOyWUO4UwYVqHTHFfuOcTYHL7ggnBLIjxx3KJSq7YXBV
	 DccgAGUgDnKd7IEv63oQfrqeXQWUx1siv0oeFbw+i9tCmvdWuuSfyccn1MLT+Vnmaj
	 isDWOie3aU/qg==
Date: Thu, 20 Jun 2024 17:59:07 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [PATCH v2 3/5] counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x)
 instead of TIM_DIER_CCxIE(x)
Message-ID: <ZnPvW6Zx69wVjNRS@ishi>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240620084451.GC3029315@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qUxpVBYe6s7jx2cy"
Content-Disposition: inline
In-Reply-To: <20240620084451.GC3029315@google.com>


--qUxpVBYe6s7jx2cy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 09:44:51AM +0100, Lee Jones wrote:
> On Wed, 19 Jun 2024, Uwe Kleine-K=C3=B6nig wrote:
>=20
> > These two defines have the same purpose and this change doesn't
> > introduce any differences in drivers/counter/stm32-timer-cnt.o.
> >=20
> > The only difference between the two is that
> >=20
> > 	TIM_DIER_CC_IE(1) =3D=3D TIM_DIER_CC2IE
> >=20
> > while
> >=20
> > 	TIM_DIER_CCxIE(1) =3D=3D TIM_DIER_CC1IE
> >=20
> > . That makes it necessary to have an explicit "+ 1" in the user code,
> > but IMHO this is a good thing as this is the code locatation that
> > "knows" that for software channel 1 you have to use TIM_DIER_CC2IE
> > (because software guys start counting at 0, while the relevant hardware
> > designer started at 1).
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/counter/stm32-timer-cnt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Did you drop William's Ack on purpose?
>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

No problem, here it is again for the sake of the LKML scraper tools:

Acked-by: William Breathitt Gray <wbg@kernel.org>

Lee, do you prefer taking this patchset through your tree?

William Breathitt Gray

--qUxpVBYe6s7jx2cy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZnPvWwAKCRC1SFbKvhIj
K1GgAP9odcqC0bo8rEeP0eJTrSUFEqcSuJZBP7eDgnXlVa0onwD+PKCxPPIJMLff
Zg4Fw4SPOHzpnOcfqWbkCDNjqMhH6AY=
=XwMH
-----END PGP SIGNATURE-----

--qUxpVBYe6s7jx2cy--

