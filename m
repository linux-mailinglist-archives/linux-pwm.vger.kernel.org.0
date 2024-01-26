Return-Path: <linux-pwm+bounces-1099-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F5183DF97
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3751F23F30
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B791EA7C;
	Fri, 26 Jan 2024 17:14:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020741DDFA
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jan 2024 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289276; cv=none; b=kUgYl6IDqV7e2+8YXm/uDQYg+j+qiTgnHqfqdZFfsEKvxSGOkA9xQuPI0iqmk+I/+bDWIcijYGrkGVw3p2LK1Cy1I/Nd5fmBMc6w9VWNajXCq6NfvlfWKvzUB1W7IuPWu1kNnjp5kYRLYdBZweYUhsY45oHmyv/RA1zB7vMpiOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289276; c=relaxed/simple;
	bh=0Zvl5i5KVs11tiDF30+JMzGsJ4tV6/Aiu7+xH5gMViQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhzPy4bPGMucM1UME0lHPeh6agUG/AeQgvgt5k2upXgLpGf4Lm7as0USv16uECiNDUZceercAEx7pp2fqFm7vo0YIyI2pD56YhknzMYzs627CsoZeUA9pVbQH0hZfsXqu/3HC0Ieof06dN6PJVoHydTAKS56XsxQNA1BX2AqsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTPmf-0003vn-Nk; Fri, 26 Jan 2024 18:14:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTPmf-002YGA-7l; Fri, 26 Jan 2024 18:14:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rTPmf-008oT4-0V;
	Fri, 26 Jan 2024 18:14:29 +0100
Date: Fri, 26 Jan 2024 18:14:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alex Elder <elder@ieee.org>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linux-staging@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v5 038/111] staging: greybus: pwm: Make use of
 pwmchip_parent() macro
Message-ID: <l42gon3id2p7ehdvjc2zcj4ahgd22m725yirgcuqetnd2pfhad@6mewdz4i5xgh>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <57b2e034d878c39d472d9dfc86b2c39272e4eabf.1706182805.git.u.kleine-koenig@pengutronix.de>
 <c796d34c-0076-488b-9643-8ecfdaa2a32b@ieee.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qiqb4v3sx4xw4gdb"
Content-Disposition: inline
In-Reply-To: <c796d34c-0076-488b-9643-8ecfdaa2a32b@ieee.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--qiqb4v3sx4xw4gdb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 08:46:15AM -0600, Alex Elder wrote:
> On 1/25/24 6:09 AM, Uwe Kleine-K=F6nig wrote:
> > struct pwm_chip::dev is about to change. To not have to touch this
> > driver in the same commit as struct pwm_chip::dev, use the macro
> > provided for exactly this purpose.
> >=20
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I think I'd rather see the footprint of your change be much
> smaller than it is.  Please see below.

You have noticed already yourself while reviewing a later patch touching
this driver. But to be explicit here: Later it's not trivial any more to
get the pwm_chip from a gb_pwm_chip. So I changed some functions to take
a pwm_chip. This should be mentioned in the commit log though. I will
improve that in the next iteration, and maybe split the introduction of
pwmchip_parent() and the parameter changes in two changes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qiqb4v3sx4xw4gdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWz6HQACgkQj4D7WH0S
/k4vxAgAr3AbG7WHZligA2jnIr7gC0knu3X7hvuS58RJ39M626cMpiZPxvdEn5on
tOVqvo1fz72b68cpUPvAh+CQ5tIg+qlu9GeRLXnsNvgUhWChvb6GFOiXBz8fU0Sy
PhS1Lfs+NdR14MiXSa7uM+3CCPWBt+JTvXojt8tHTnLGu4Bl+/xRY5HHyXOmkHzV
vuNj1Azx8bg5t3v+yRMLwhc8ZxvXYTRlvVxYlHipG10UysqU6PJm+KbxiVEsZk6J
jfs9KknSSWrG7UrA9Vi3XvFQPlQnYwn+9Kpo7Y3sMtElUFq+3TsxY5XBAcrAx7+6
fBUslROYRaSbva5wiEUiKVvYvRDc1A==
=JArl
-----END PGP SIGNATURE-----

--qiqb4v3sx4xw4gdb--

