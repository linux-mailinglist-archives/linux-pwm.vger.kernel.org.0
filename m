Return-Path: <linux-pwm+bounces-164-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB5D7F5B07
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 10:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA254B20E54
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B66F2032F;
	Thu, 23 Nov 2023 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E919AF
	for <linux-pwm@vger.kernel.org>; Thu, 23 Nov 2023 01:24:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r65wm-0007QU-GZ; Thu, 23 Nov 2023 10:24:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r65wl-00B0Zs-Gj; Thu, 23 Nov 2023 10:24:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r65wl-006W6D-7X; Thu, 23 Nov 2023 10:24:31 +0100
Date: Thu, 23 Nov 2023 10:24:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
	Guenter Roeck <groeck@chromium.org>,
	Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 001/108] pwm: cros-ec: Change prototype of helper to
 prepare further changes
Message-ID: <20231123092431.4xcvbccjrbid7ius@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-2-u.kleine-koenig@pengutronix.de>
 <ZV3BQMalgY7WZCVR@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5dlypce4bcguj5sc"
Content-Disposition: inline
In-Reply-To: <ZV3BQMalgY7WZCVR@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--5dlypce4bcguj5sc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 04:52:16PM +0800, Tzung-Bi Shih wrote:
> On Tue, Nov 21, 2023 at 02:49:03PM +0100, Uwe Kleine-K=F6nig wrote:
> > @@ -233,7 +232,7 @@ static int cros_ec_num_pwms(struct cros_ec_pwm_devi=
ce *ec_pwm)
> > =20
> >  	/* The index field is only 8 bits */
> >  	for (i =3D 0; i <=3D U8_MAX; i++) {
> > -		ret =3D cros_ec_pwm_get_duty(ec_pwm, i);
> > +		ret =3D cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, i);
>=20
> Or just pass false for `use_pwm_type` because the path:
> cros_ec_pwm_probe()
> -> !ec_pwm->use_pwm_type
> -> cros_ec_num_pwms()
>=20
> `ec_pwm->use_pwm_type` is always false here.

Good catch, that allows to simplify the patch that introduces
devm_pwmchip_alloc() to this driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5dlypce4bcguj5sc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVfGk4ACgkQj4D7WH0S
/k7slQf/aq557wJBu2oswpIdTasvF7wNME5CaX651BjLcVsyEZU7SsClYAmw+HHl
n8SD+ZdUlCGeiEIhhO7AlNeeCNKboOLO9aX1wIuWdV8ZcL/Af/tLWjfqcooWW80Z
/fyv6VdkHcPsxZ8Mgeu6E3kk8xzewxPzfDdvKVSd6jRpXKTY/ir44IAC7M0J1W/j
+FJAwjKA5BPt2xk+Ler6Jh8logjpgo6sR2yQPpX3tzxolIOIL3mJ9rkhsVRkBBu8
0yhQc2hihLPfFpIF+3eZnGlkafJpmmI8Vpn963EqSsRZ6bEk+/6CkmJqo/gvGY1r
3QYFxBrpcEnRHM615rqFiUKZaWE3tA==
=cSxi
-----END PGP SIGNATURE-----

--5dlypce4bcguj5sc--

