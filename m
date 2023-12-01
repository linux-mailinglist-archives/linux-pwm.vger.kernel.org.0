Return-Path: <linux-pwm+bounces-276-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8488010F2
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Dec 2023 18:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0A21C20953
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Dec 2023 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C619B22080;
	Fri,  1 Dec 2023 17:16:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A91F3
	for <linux-pwm@vger.kernel.org>; Fri,  1 Dec 2023 09:16:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r978G-0003U2-Ac; Fri, 01 Dec 2023 18:16:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r978F-00Ctvx-OC; Fri, 01 Dec 2023 18:16:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r978F-00CMsP-F1; Fri, 01 Dec 2023 18:16:51 +0100
Date: Fri, 1 Dec 2023 18:16:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Stop referencing pwm->chip
Message-ID: <20231201171650.5xlsw4vkiquw532q@pengutronix.de>
References: <20231201102253.2352419-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gzvarywrq7p3bmcx"
Content-Disposition: inline
In-Reply-To: <20231201102253.2352419-1-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--gzvarywrq7p3bmcx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 11:22:53AM +0100, Thierry Reding wrote:
> Drivers have access to the chip via a function argument already, so
> there is no need to reference it via the PWM device.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gzvarywrq7p3bmcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVqFQEACgkQj4D7WH0S
/k7Drgf/cNmBN9PTobfyQTzR396ieMGNfFeR7ftQV9gJxc9pAJsal3oKhLs+lV7b
WYfyHVzG3mqkL3B2aR3scwW0Aei+8BUGAJwN31vXYRyKSBzOdL3TF+VE1AP7aKSS
HhC2wukFnNXbumPYFn4fOvqWUWYXkBLTHUEs2geL02guMyumHED28gPtUFtf6Xoo
abUCoXmDIa71HTISrBZZo9pimcI1kO8jNdOzCJyQl5S+iMEr+eLZ073QDOrz7OuY
T4TzbctdFhyMSe4h5Zb7mhcIZjU1tOLfeUJYKkBjpTx7hF3EVQH2TSS9Gh3BV6CT
T6d5u5zjlCZfC5skUiK8ICyp1BMdKw==
=YOBo
-----END PGP SIGNATURE-----

--gzvarywrq7p3bmcx--

