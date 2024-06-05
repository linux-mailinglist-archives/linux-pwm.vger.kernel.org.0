Return-Path: <linux-pwm+bounces-2358-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2538FD3EA
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 19:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F141C24C85
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01BB139D0A;
	Wed,  5 Jun 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjtE8Dqt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80703D26D;
	Wed,  5 Jun 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608211; cv=none; b=A8M0X/DtMLl+cA37yuVKJBdUwBxb4Ul1qU/glLaEK/ofudGD5GOcVd6n4x0GhagmULEOchB/53i+aMge00PUNm3MTErCS9RQjeixx4BrDYe80OaRxsJFTWUokQRAXwrvkZf42JbgTfx3J5ur9cLGje6PSgDEpXGhw5KrXakIVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608211; c=relaxed/simple;
	bh=6PluMPHUYizb6FEj3i2/J4xCW61yi3OAY1rWSGbUHUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHw1OGA6Eesr4D1RQ34D9gdlZHRomd/7sCEDhDPevT/la8Ybx2cQSmolF0+YJJ9ix1t9+YloGNJhoqF154E0Vm4dh8U5aPBTIbR2aW/1TGBl0uuY3FuQp2JMjPlCfFiNekquXcm+GFN/RdV1lR9RUw1tT42gk6pm2f8eiHbMsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjtE8Dqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214E8C2BD11;
	Wed,  5 Jun 2024 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717608210;
	bh=6PluMPHUYizb6FEj3i2/J4xCW61yi3OAY1rWSGbUHUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjtE8Dqt6EhfepgMzoZpCnMaqKNGRE5UR669cyt73WgHzieVieN68LD+2tiNudLe2
	 xNYqnnzQdVmVsDBdkuYRwc0y42KOEP4LByekXZ79wnAUxILzCKNQET0ktBFrQYpZSA
	 zdbEWGFDrB3TkrnFwOj/hANpjkvML1qIyywJ9WDea5vGh1lsRFpw1cbSBc5Mti0RJg
	 2r4yRlyE5QemctKocA8zIsk9nH4GbU+e5Riea2T4sf1+Js0e/4vWtF/vCEbP1xb5K7
	 tH9IeqnFBZZRmW0Sneyv3byPYn3tYuy0aDeCslo2Huxh2EtdBzhT/84RhGvKDM5Z5t
	 3eidG+airIJPw==
Date: Wed, 5 Jun 2024 18:23:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	Nicola Di Lieto <nicola.dilieto@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Add pwm-gpio
Message-ID: <20240605-earthworm-suspend-f7f58579f211@spud>
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
 <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>
 <CACRpkdbPGEx9QSazVfP7rbkM7x2MnJbrACdTi3zyniQhZSyTbw@mail.gmail.com>
 <20240604-creole-easiest-2146ac2ea996@spud>
 <CACRpkdYDcR_ysF4rX6Zx6ZjQpgzYxxNKR+U=PJOVCndy2hrGaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2lGtmrwmBltFSkfr"
Content-Disposition: inline
In-Reply-To: <CACRpkdYDcR_ysF4rX6Zx6ZjQpgzYxxNKR+U=PJOVCndy2hrGaw@mail.gmail.com>


--2lGtmrwmBltFSkfr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 10:54:26PM +0200, Linus Walleij wrote:
> On Tue, Jun 4, 2024 at 4:14=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>=20
> > > The #pwm-cells are currently not properly specified in the bindings: =
for example
> > > pwm-tiecap.yaml says "See pwm.yaml in this directory for a description
> > > of the cells format."
> > > and that file says nothing about the cells and what they are for, sho=
uld
> > > I send a separate patch for that?
> >
> > Does this suffice?
> > https://lore.kernel.org/linux-pwm/20240517-patient-stingily-30611f73e79=
2@spud/
>=20
> Indeed. You can add:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org> for the above patch!

Seemingly Uwe already queued it, so should end up in 6.11:
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git/commit/?=
h=3Dpwm/for-next&id=3D603e1cf3b21a2451b99a5d06dca9e511dff0a294

--2lGtmrwmBltFSkfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCfDAAKCRB4tDGHoIJi
0tGyAP9oMQDcjWAEZPKB/fFbAVyFa/lMi5krukWaCcJua5c79QD+J+Q1V1UeMyyz
mHkSoULuw/XA6XVExsqSYS7K/XdVKwg=
=HkM1
-----END PGP SIGNATURE-----

--2lGtmrwmBltFSkfr--

