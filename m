Return-Path: <linux-pwm+bounces-542-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C999080F54C
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059FC1C209D4
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0210E7E775;
	Tue, 12 Dec 2023 18:14:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1E3A1
	for <linux-pwm@vger.kernel.org>; Tue, 12 Dec 2023 10:14:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7HK-00040L-KK; Tue, 12 Dec 2023 19:14:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7HI-00FOxL-SC; Tue, 12 Dec 2023 19:14:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7HI-001p8f-I9; Tue, 12 Dec 2023 19:14:44 +0100
Date: Tue, 12 Dec 2023 19:14:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/6] pwm: bcm2835: Allow PWM driver to be used in
 atomic context
Message-ID: <20231212181444.mw5kxff5ijz676qh@pengutronix.de>
References: <cover.1702369869.git.sean@mess.org>
 <e9e32c9789da3c90b5a2aa7d5a093120b76421fb.1702369869.git.sean@mess.org>
 <20231212160838.k4z4csy455a7qnje@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="llbhn5mnvxkhmahv"
Content-Disposition: inline
In-Reply-To: <20231212160838.k4z4csy455a7qnje@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--llbhn5mnvxkhmahv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Tue, Dec 12, 2023 at 05:08:38PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Dec 12, 2023 at 08:34:04AM +0000, Sean Young wrote:
> > @@ -169,6 +179,7 @@ static int bcm2835_pwm_suspend(struct device *dev)
> >  {
> >  	struct bcm2835_pwm *pc =3D dev_get_drvdata(dev);
> > =20
> > +	clk_rate_exclusive_put(pc->clk);
> >  	clk_disable_unprepare(pc->clk);
>=20
> I thought this was the remove function, but that's suspend. Adding
> clk_rate_exclusive_put() there is wrong.

https://lore.kernel.org/linux-clk/744a6371f94fe96f527eea6e52a600914e6fb6b5.=
1702403904.git.u.kleine-koenig@pengutronix.de/
might be useful to fix this.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--llbhn5mnvxkhmahv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmV4oxMACgkQj4D7WH0S
/k4mdAgAn2zEXY7AwmY1SR/n2nlH95E9ZMWuZsWEE5YGkmiMVuu3Vxndi5GvL9Dh
dd1KzI3rvGRWEOh7sNhr8gdfyRFVBwFE8N0IMRWH5SOOL6uMiDV5qB8gcQF4cHJf
sVZp1wxCIrv8QVmdNVhafSAIz7ojkYJpls9Hp18MfZWAJ40kwuUQSRqx3zu565rr
fAujilnhb2J/JgM+SBmkERoG5p7RPdJ7Txck7nT2/poL7wwwhxBK5uBAHsIzLbiq
iiM1wU/uYHSSEln0EYdz74u47W65H8hiKG6e/CdhThnLh6p29h+R9UtQpNSktAe6
nfXqhhqc2AWJJk1y3kL2nDV/gkykzg==
=ZifV
-----END PGP SIGNATURE-----

--llbhn5mnvxkhmahv--

