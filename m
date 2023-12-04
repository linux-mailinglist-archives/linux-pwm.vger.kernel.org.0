Return-Path: <linux-pwm+bounces-278-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20428031BF
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 12:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3901C208C2
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Dec 2023 11:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959AFEADE;
	Mon,  4 Dec 2023 11:51:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81CEA0
	for <linux-pwm@vger.kernel.org>; Mon,  4 Dec 2023 03:51:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA7U4-00006n-T9; Mon, 04 Dec 2023 12:51:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA7U3-00DVRR-5i; Mon, 04 Dec 2023 12:51:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rA7U2-00E1OU-Sj; Mon, 04 Dec 2023 12:51:30 +0100
Date: Mon, 4 Dec 2023 12:51:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Hari.PrasathGE@microchip.com
Cc: christophe.jaillet@wanadoo.fr, thierry.reding@gmail.com,
	Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: atmel: add missing clk_disable_unprepare()
Message-ID: <20231204115130.d46fuficobdfs4yn@pengutronix.de>
References: <20230902063232.22620-1-Hari.PrasathGE@microchip.com>
 <f15da804-206b-be53-b59e-06a3edfa0e96@wanadoo.fr>
 <f08d820b-cef3-bc9d-69ce-fc6d3f65a550@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="suyx3ysyth33jpxh"
Content-Disposition: inline
In-Reply-To: <f08d820b-cef3-bc9d-69ce-fc6d3f65a550@microchip.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--suyx3ysyth33jpxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hari,

On Wed, Sep 06, 2023 at 06:15:36AM +0000, Hari.PrasathGE@microchip.com wrot=
e:
> Thank you, I admit that I have messes up this part. Its been quite a=20
> while sending patches upstream and I seem to have forgotten the basics.=
=20
> I will take time to send the v3 paying more attention to these small=20
> details.

You never followed up with the promised v3. Is this still on your radar?
Would be great to get this addressed as it fixes a clk imbalance, right?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--suyx3ysyth33jpxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVtvUEACgkQj4D7WH0S
/k4vRggAi5Qzd8FssadJ8Y3jXMkQYtbvpv1lmMyDCpcOdYTFPL109e3XxjLZE5Q3
yksr6XCQlnUEleNkjUwo7q30JtiPkTeU2fRkTlhRuu8h/oiUKs1q1ehiMUXC2AWJ
5nDcCRn8ZDc9e2qljrSsGnSjulFDZFDIZB8pZCF6EMVhetIExnQDHvJVtheJkYJ1
YPsBpG6wIXeqDL8kOkt/dexQYkDq3VCC1/siIh12azFf3iAqEOE+FeSEOQIviji4
aGwIakzlXJYFdVQzGchsObOnqGxzj0NsdCFP0wAqWsaUc+C4Jss3aJqg9qZJ4bAd
gUsHOsk2YcZrvT5LHGGzmriOeuwYNw==
=SssV
-----END PGP SIGNATURE-----

--suyx3ysyth33jpxh--

