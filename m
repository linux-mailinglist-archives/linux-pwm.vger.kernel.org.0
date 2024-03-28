Return-Path: <linux-pwm+bounces-1827-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4DE88FEBA
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Mar 2024 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199271C23FD2
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Mar 2024 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604CB657C5;
	Thu, 28 Mar 2024 12:11:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DF5474B
	for <linux-pwm@vger.kernel.org>; Thu, 28 Mar 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627860; cv=none; b=YOjc3cnDQiloOmw2VYyTlSDIk+Mz2Ynm5JaFaN1qJbgoyfU4Sozt+yOkynhwR8m2Y2DdE7sSeMl71xCID5chf6Jj/65qWfY7JzJPfOaB9kOD4u9i8mxg2lou0hKEiw/sofXbXcT7jrqyw0WoCoDGbYFq+oGDCpDVCdW9YRJuMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627860; c=relaxed/simple;
	bh=XLR5seFyaOZ89hdv/Ug8D4XWdLSyEghesi9PWjNcV6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXTh6v0y0zqbNNYMLiPSLh/bQ2W3pBxrIvshaeDhkVbAycv7fTqOx0LYP4YEg7ynr88bAmGJRHnCYCQBNKUK9LAHqF/LK0NRXFi7DSLG7W81leXFLZRChKOOoFPzSiDvuaOMpMtTrugOKgi4IQ29k40jeIwQ4GNYHOTLLUOyQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rpoam-0003cy-1q; Thu, 28 Mar 2024 13:10:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rpoal-008zxt-FO; Thu, 28 Mar 2024 13:10:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rpoal-00CxMb-1I;
	Thu, 28 Mar 2024 13:10:47 +0100
Date: Thu, 28 Mar 2024 13:10:47 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: add missing kernel-doc for pwm_chip:cdev
Message-ID: <3xqcgvyz2dunxxnmstt63d3v235r3cfh6ddsajrnogpw4zvy7b@w7tzawgexthc>
References: <20240328045515.15874-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vl5k7ifaxjvijgw2"
Content-Disposition: inline
In-Reply-To: <20240328045515.15874-1-rdunlap@infradead.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--vl5k7ifaxjvijgw2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Randy,

On Wed, Mar 27, 2024 at 09:55:13PM -0700, Randy Dunlap wrote:
> Add a kernel-doc description of @cdev to prevent a build warning:
>=20
> include/linux/pwm.h:308: warning: Function parameter or struct member 'cd=
ev' not described in 'pwm_chip'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for the fix, I applied it to my for-next branch at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vl5k7ifaxjvijgw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYFXkYACgkQj4D7WH0S
/k6cKQf/RspDnaB8B793IIf5VGeniUSJQJ6Y+ZbSnl7Nd5F8rpMpZ+V2dNkJ02eA
sO64DEi9sdjm/xhiJh1qyZgJi4cmuHwl5SmZCOlQi4gVTtGXMydMUW8gL4MtsUiR
ZS3KXz57oDWs6ZPRz2cAUwfut/b1Qs/9R9qOnb2JM/KFrYFxlQgtwxaXga1wweFB
TJL7hElzajXZygks1pq7LNocMhvtdRz4hUBGjBekqLyLFXTLkY6TP2m0vep5UHJC
U9irHFFFh5y0a2yhoQDEwqG2AYsLa3uFPEMC/GjKM85sUngv6O1C1QrCA4D2FRnT
Adj9LPGcE8BWs4zr8UHUBElzBILs8g==
=0Tli
-----END PGP SIGNATURE-----

--vl5k7ifaxjvijgw2--

