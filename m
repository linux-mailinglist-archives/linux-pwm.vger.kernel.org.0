Return-Path: <linux-pwm+bounces-160-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C227F5513
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 00:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E9D1C209CC
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 23:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0FE20B38;
	Wed, 22 Nov 2023 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0211F
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 15:56:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5x4n-0007cb-Pd; Thu, 23 Nov 2023 00:56:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5x4n-00Auw4-5R; Thu, 23 Nov 2023 00:56:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5x4m-0066kb-SP; Thu, 23 Nov 2023 00:56:12 +0100
Date: Thu, 23 Nov 2023 00:56:12 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev,
	Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
	Guenter Roeck <groeck@chromium.org>,
	Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 051/108] pwm: cros-ec: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231122235612.pfpy64xwhsxnz5xn@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-52-u.kleine-koenig@pengutronix.de>
 <ZV3BXAMCBkArwIm6@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="scgqo5g6yvb4t763"
Content-Disposition: inline
In-Reply-To: <ZV3BXAMCBkArwIm6@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--scgqo5g6yvb4t763
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Nov 22, 2023 at 04:52:44PM +0800, Tzung-Bi Shih wrote:
> On Tue, Nov 21, 2023 at 02:49:53PM +0100, Uwe Kleine-K=F6nig wrote:
> > @@ -41,7 +40,7 @@ struct cros_ec_pwm {
> > =20
> >  static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm=
_chip *chip)
> >  {
> > -	return container_of(chip, struct cros_ec_pwm_device, chip);
> > +	return pwmchip_priv(chip);
>=20
> Or just replace every `pwm_to_cros_ec_pwm` to `pwmchip_priv`.

An advantage of the pwm_to_cros_ec_pwm() wrapper is that it yields the
right type. I'd keep it for this series to keep amount of the changes
small (and also because I like to keep the wrapper).

Feel free to propose a patch replacing pwm_to_cros_ec_pwm() by
pwmchip_priv() when this code landed in the mainline.

I'll look into the other things you pointed out. Thanks for your review.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--scgqo5g6yvb4t763
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVelRsACgkQj4D7WH0S
/k7ghwgAs9QEpTKqKJDltQTPTg9m/W+7ehgr2L5GU+IbDaZWjwgq59ELt3P7Vl0U
5Jf8mTj5B5siSeIpmILS1o87nxExzN1suryAbTe8ZNd7fhxJDYwIyIm1XIv7LDt4
vIPhzDpSBLe/5gne8VUuHN2X0Sy6wZ3WQznOoKFzaIhcqqHZoPxXhC0vz4m4JAtK
ssvY8gMnJ2tjlqayPnKqJBGe2y1fC99cCwW5LGGx4jfAF6HOHSQ3YBJlNqvzjbE5
VUm9PL9ljgAxlH6nrzblH1EmT+nO03b6MlLWuqCeNZFfdfD3piMld55LbGahenXr
hmU1CpWIBOHn7mTtbuovCyueV0P+vg==
=uPOi
-----END PGP SIGNATURE-----

--scgqo5g6yvb4t763--

