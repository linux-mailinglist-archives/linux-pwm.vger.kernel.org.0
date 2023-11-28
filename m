Return-Path: <linux-pwm+bounces-222-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32837FC7C3
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 22:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC96FB240D2
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Nov 2023 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0517E44386;
	Tue, 28 Nov 2023 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84044A1
	for <linux-pwm@vger.kernel.org>; Tue, 28 Nov 2023 13:11:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r85MT-0002Ms-2A; Tue, 28 Nov 2023 22:11:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r85MS-00CGL9-Lx; Tue, 28 Nov 2023 22:11:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r85MS-00AOnN-Cs; Tue, 28 Nov 2023 22:11:16 +0100
Date: Tue, 28 Nov 2023 22:11:15 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [GIT PULL] pwm: Changes for next
Message-ID: <20231128211115.el3tzubwpxe47776@pengutronix.de>
References: <20231121112029.gyv3gqirlycysyr4@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f5xh6aun4fj3eajs"
Content-Disposition: inline
In-Reply-To: <20231121112029.gyv3gqirlycysyr4@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--f5xh6aun4fj3eajs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Tue, Nov 21, 2023 at 12:20:29PM +0100, Uwe Kleine-K=F6nig wrote:
> to get a defined and useful base for my lifetime and character support
> code changes here comes a pull request with the commits that I'd like to
> have in next and build upon.
>=20
> Note that the first commit is a fix that IMHO should go into
> v6.7-rc$next.
>=20
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>=20
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>=20
> are available in the Git repository at:
>=20
>   https://git.pengutronix.de/git/ukl/linux tags/pwm/for-thierry-6.8-rc1
>=20
> for you to fetch changes up to 869de350ff3834145273a6d39faedea878c6715a:
>=20
>   pwm: cros-ec: Drop unused member from driver private data (2023-11-21 1=
1:13:31 +0100)

Last time you missed/ignored my pull request, you suggested that I
should mark the contained patches in patchwork as delegated to me. I did
that this time around, but it didn't seem to have helped as you still
picked the patches from the list yourself.

:-|
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--f5xh6aun4fj3eajs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVmV3IACgkQj4D7WH0S
/k758AgAjSaZ58SGRxODU4D4H6wSfFrz8iZnpBPu/vUQJUAUPBuSI1ebJLHZ+o0w
oyJ7bLLDfmB30ipbZ7kCvlcVKtrmwfcTpX+LZtWL12YflRrX8YYcPvU+9YdPCJUT
JcmKz9yypBdve7WRQtgVokW1EH2y7EGjbZh9RHljcFbh2CdgNQ6MybGtHaWSfTX8
YYeVLrAkvc9Ood2uLdDRqSH+A99mZw+uDLtcDwlsVhO227FlVbCoBOMLQ/OnvSV2
yP1k8HIbW4nejIb12J5Ofn8HUssjqninHjIOGbUbUIK4O/qsrTDSj1qmjK79K24j
MeyGqw762LWCDXIWFcICbmABP5G+Aw==
=ncnU
-----END PGP SIGNATURE-----

--f5xh6aun4fj3eajs--

