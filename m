Return-Path: <linux-pwm+bounces-295-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961D8053EA
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 13:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EEE1C2093A
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2206B5B1E4;
	Tue,  5 Dec 2023 12:14:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3524C116
	for <linux-pwm@vger.kernel.org>; Tue,  5 Dec 2023 04:14:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAUJR-0003WA-KB; Tue, 05 Dec 2023 13:14:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAUJR-00DjtL-4p; Tue, 05 Dec 2023 13:14:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAUJQ-00EgkB-Rk; Tue, 05 Dec 2023 13:14:04 +0100
Date: Tue, 5 Dec 2023 13:14:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-pwm@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 058/108] pwm: imx27: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20231205121404.djhpn5t3gylebfyc@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-59-u.kleine-koenig@pengutronix.de>
 <95b1df79f6830eb7d886bcd7099354ad38218e31.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ir6eiuawqinzwl7g"
Content-Disposition: inline
In-Reply-To: <95b1df79f6830eb7d886bcd7099354ad38218e31.camel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ir6eiuawqinzwl7g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Philipp,

On Tue, Dec 05, 2023 at 12:49:19PM +0100, Philipp Zabel wrote:
> On Di, 2023-11-21 at 14:50 +0100, Uwe Kleine-K=F6nig wrote:
> > @@ -306,13 +308,15 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
> > =20
> >  static int pwm_imx27_probe(struct platform_device *pdev)
> >  {
> > +	struct pwm_chip *chip;
> >  	struct pwm_imx27_chip *imx;
> >  	int ret;
> >  	u32 pwmcr;
> > =20
> > -	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
> > -	if (imx =3D=3D NULL)
> > -		return -ENOMEM;
> > +	chip =3D devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +	imx =3D pwmchip_priv(chip);
>=20
> Please use to_pwm_imx27_chip() here. Otherwise,
>=20
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks. This is already fixed in my tree for this and a few other
drivers. Currently the patch looks as follows:

	https://git.pengutronix.de/cgit/ukl/linux/commit/?h=3Dpwm-lifetime-trackin=
g&id=3D4fa8c8a8661fa6d91de0368693d4a92907fb5359

The only other changes since this v3 is the usage of
pwmchip_get_drvdata() instead of pwmchip_priv(). Can I keep your
Reviewed-by for this new variant?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ir6eiuawqinzwl7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVvFAsACgkQj4D7WH0S
/k47cwgAh+s3yHFZlpD0rep5VKmSz3ehIxC2MiF1uVWTlbUrImd+8bhCqrpswF4U
LhJ52JL4BEqZNhejUV+zoEd9CvV4UZ3iCXtf6pHh8EeLUJClcJv79foLFXyqJs9n
tArXk/hl8o1EStCqgV1IOleL+Em0n3t58ty5jvW7UnPk0Rw3eH583mKFmSV77MSE
GB4WKnf2V+xD2ratAW+zXldj8t7PmcxvxDru6oJgDqCgTPb+k8NBy/gBcv9Rfvud
RCwCC1l5FzuFXYlN/bmt6ugHNUJ0UPHaEHgdq348mZ5mDUrkENV9GAdRQ8N8kiAB
wpg10ALZxYbkg0W17ptAv7NdyP0+EA==
=dC6e
-----END PGP SIGNATURE-----

--ir6eiuawqinzwl7g--

