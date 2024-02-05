Return-Path: <linux-pwm+bounces-1217-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A57EB84A0C7
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 18:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434F51F22A7D
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D14121B;
	Mon,  5 Feb 2024 17:31:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158140BEB
	for <linux-pwm@vger.kernel.org>; Mon,  5 Feb 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154285; cv=none; b=LVIjE6BRcZgrPteiYhS5TNk60RycZ+B8xQOfLgLolG0fpHKI7NfarcpKtJF+v8Dq0z3engUNNbv1fDIe3nu+3BDGXSwoGbokBqKb88AjF1ipBJGGzR69Qq0K4G3J6/Bi+fNJXLYJD5ZuxNP8w1Rf932SGmJr/oFqC+pxmBRzYrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154285; c=relaxed/simple;
	bh=mPbC2RmTD845KRWabTLtlYfUK0JmuOKmYRU43wBm3to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VREyEe3SEqT9eAbbf11qQP2fhjwrYc4DiX1mTmHa603y67+w/8hBL+iRUddTNjO/F8dwzpFwPwobTS/X72InncTw6SNVIgHLj7B/wHLFM+CA33mzR6dZaf/vFdAGa0zsHPvJIknTK2tfd0W868Zr7NZ2qgtleXs+jaR5/874hDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rX2oS-000893-Mx; Mon, 05 Feb 2024 18:31:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rX2oR-004foJ-Ia; Mon, 05 Feb 2024 18:31:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rX2oR-00Fjbq-1a;
	Mon, 05 Feb 2024 18:31:19 +0100
Date: Mon, 5 Feb 2024 18:31:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] pwm: bcm2835: Drop write-only member of driver private
 data
Message-ID: <ytkcz3tkbtkxttk2vtl3izjfmfu6agm5kkehn5lf5cabdn3ipk@2pdkogg27oqw>
References: <20240129081029.2355612-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3vrfjjhudyxnrza"
Content-Disposition: inline
In-Reply-To: <20240129081029.2355612-2-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--d3vrfjjhudyxnrza
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jan 29, 2024 at 09:10:30AM +0100, Uwe Kleine-K=F6nig wrote:
> Since commit fcc760729359 ("pwm: bcm2835: Allow PWM driver to be used in
> atomic context") struct bcm2835_pwm::dev is only assigned a value, but
> it's never used. So the dev member can just be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d3vrfjjhudyxnrza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXBG2UACgkQj4D7WH0S
/k4FMwf/ZWE2c8rz5j5HYm00sa30SqTvPQKvDsBc6UYfBGpydAdI14kuUiFrqZQo
1mp+FwYibFX2N+Qt2CERl39Kyh/dzCVnk9F0SpxhsU9R0x5okTQrC1X1qCCm1d48
5TchXOPEqfYMhfptJbPMWTea5HcHU8ShN+aqF3M87nIRxDrUAxEtl/I70SsK7XOz
S0MJE4b6nUsUKZMtApI8Tmj0HIdcYMj4GBs88fw5gfp4aXynXw0wdAl6TPggDZQ5
B7fb3axkiHDHSWdFd09ESRe3Qx+O1kofFsIyF4SLxbDcDqXhojNKo6VNcaSNen6i
JPSbww722TO97/RxHMRqXpN62n5d+Q==
=JeMf
-----END PGP SIGNATURE-----

--d3vrfjjhudyxnrza--

