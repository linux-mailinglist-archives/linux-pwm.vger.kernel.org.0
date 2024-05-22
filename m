Return-Path: <linux-pwm+bounces-2222-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E558C8CC497
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 18:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3975FB21D50
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B720DF4;
	Wed, 22 May 2024 16:00:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA491CF9B
	for <linux-pwm@vger.kernel.org>; Wed, 22 May 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393637; cv=none; b=AMu7/PPvDn3KfRQ1/m0+e5NhhCrk0BPLEpxDrWYdnuPFikdsF3HiQzaP4gqoQKFL3BLQipp6wcqGwOwL7MdClITjrpJr22U9WqvNyJ+iQ3LoduujS5rtvQtKOxco+3/ncoot8Oc29AsAW3XkZ6nCapJihXhtQ6TMGcTL3lS2k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393637; c=relaxed/simple;
	bh=KP/AvMgVHoXQOdcv6PLxIgIToL9BAMof4V1g9J1LlrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkktCozv3oZr+h8ETOfCXLCnWm6iwdNGrNVYvtP1Wwz5HU8aWr2F7C8w1xaPv+lqYaEIDZEbWw7ic8w+QPUko1Cm1k8eX2fv3EnPBtuoiMrZQaN7kdIGH+xu2wSKtfwVHvZZ1hngxySATO6LE+jqgb7pKlv0PcItPeovaQpK49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9oOH-0005lz-5H; Wed, 22 May 2024 18:00:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9oOG-002XsK-6i; Wed, 22 May 2024 18:00:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s9oOG-00A7vx-0P;
	Wed, 22 May 2024 18:00:32 +0200
Date: Wed, 22 May 2024 18:00:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com
Subject: Re: [PATCH 0/2 v3] pwm: add support for duty_offset
Message-ID: <6dzlh6id4icmdlbrl2hciuypnqsg2fsoncmr6nevvufv7vhyvt@tvwxsf4i64sn>
References: <20240521194916.1897909-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="epcbly2pxpokikgd"
Content-Disposition: inline
In-Reply-To: <20240521194916.1897909-1-tgamblin@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--epcbly2pxpokikgd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

On Tue, May 21, 2024 at 03:49:14PM -0400, Trevor Gamblin wrote:
> This series extends the PWM subsystem to support the duty_offset feature
> found on some PWM devices. It includes a patch to enable this feature
> for the axi-pwmgen driver, which can also serve as an example of how to
> implement it for other devices.
>=20
> The series was tested on actual hardware using a Zedboard. An
> oscilloscope was used to validate that the generated PWM signals matched
> the requested ones.=20
>=20
> Note that in addition to the other patches in this series, the changes
> to the axi-pwmgen driver rely on [1], which hasn't been picked up yet.
>=20
> [1] https://lore.kernel.org/linux-pwm/20240424125850.4189116-1-tgamblin@b=
aylibre.com/

You can do yourself a favour and use git format-patch's --base option to
(additionally) tell this in a way that the autobuild bots understand.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--epcbly2pxpokikgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZOFp4ACgkQj4D7WH0S
/k61bQf/R9TP8rl0qwTFEveQBooESFTvvArt4HuJcMClTC8bzGZmkmnX9oR1ujyC
B3kYWZiLW0djMuMSqKmb2ehFMAIpX8xo7VA7GVVynoaVJoQpeahJUJ4QQGhXP86v
zqY9bfnfW24Y0CmJX7PLCHGO5xK3WZJ5H3siRqB/p3Tl0iyUMf78Lvv6jKwVcBVd
H3qhs+I4G6JyBECS6dCtZlDQBWv/0HKG+wwKiKrR8PMxTzWKFlcS7ZZchPecTy3P
/o3W4Ef5BnXJEbjl4HYtvrl5MdXyK1lGLRNQF9G2LiIskSzLvQNUa/A3wt0iWmlZ
RiScQuIZ4O/oynYNSEzIVz2FOEAMeQ==
=ccCq
-----END PGP SIGNATURE-----

--epcbly2pxpokikgd--

